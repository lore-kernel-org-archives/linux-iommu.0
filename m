Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55D9C433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 23:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 554E060C14;
	Tue, 26 Apr 2022 23:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2yEM-v6cRhXl; Tue, 26 Apr 2022 23:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C06E66113A;
	Tue, 26 Apr 2022 23:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B4ECC0039;
	Tue, 26 Apr 2022 23:29:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6E17C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 23:29:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32FBB802CF
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 23:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4ZQ2wl_tV4w3 for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 23:29:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3519480BC8
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651015747; x=1682551747;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=J8JmQdIC2PvJ9tfgakqcAYqNpk0tOSg7F3URbm6mlRk=;
 b=G84w+tHWTCavhPHu909H0l75Qu38MhVTVl2j7I8PJ0fp8EOJZP112+4H
 Cip2LRqbMN5FxUJ/XsQEHCegKVEpQvd7PK1Omb4K1DyO+d3N3ZyGDGw10
 rHrbSEVUPyet6pHEQ3n3vPsRo1e1rGugOMZK2Z7HfldzZg4ysTOM0SCjD
 OnevaLanknB/oSI70sUgrYRuG998AxlE9wJJ4xLCb4blTMvPDNZQ+VtFC
 Q8HkCvaDD7FU9smgdcGv1ZJBzm2NiVUVr8EmQkMR4pWYx56IB8PJhu7h0
 tIqFvng72PoSTtpGlZQ0FXcr2qReYiyd/OdB74GhAyJUzxcZJ/JuTwa2j w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264601391"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="264601391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 16:29:06 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="580226562"
Received: from dsocek-mobl2.amr.corp.intel.com (HELO [10.212.69.119])
 ([10.212.69.119])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 16:29:04 -0700
Message-ID: <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
Date: Tue, 26 Apr 2022 16:31:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica> <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica> <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmgiQZZyFxsJ+9um@myrica>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
 Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/26/22 09:48, Jean-Philippe Brucker wrote:
> On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
>> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
>>> The problem is that we'd have to request the device driver to stop DMA
>>> before we can destroy the context and free the PASID. We did consider
>>> doing this in the release() MMU notifier, but there were concerns about
>>> blocking mmput() for too long (for example
>>> https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
>>> though I think there was a more recent discussion). We also need to drain
>>> the PRI and fault queues to get rid of all references to that PASID.
>> Is the concern truly about blocking mmput() itself?  Or, is it about
>> releasing the resources associated with the mm?
> The latter I think, this one was about releasing pages as fast as possible
> if the process is picked by the OOM killer. 

We're tying the PASID to the life of the mm itself, not the mm's address
space.  That means the PASID should be tied to
mmgrab()/mmdrop()/mm->mm_count.

The address space is what the OOM killer is after.  That gets refcounted
with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
page freeing done in __mmput()->exit_mmap().

Also, all the VMAs should be gone after exit_mmap().  So, even if
vma->vm_file was holding a reference to a device driver, that reference
should be gone by the time __mmdrop() is actually freeing the PASID.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
