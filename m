Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61DCC433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 15:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F9B460BD2;
	Mon, 25 Apr 2022 15:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RnT19Cr9oDGw; Mon, 25 Apr 2022 15:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7194660E16;
	Mon, 25 Apr 2022 15:53:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E476C0039;
	Mon, 25 Apr 2022 15:53:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B31DAC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 15:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A814D81768
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 15:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3q8rYx_RaZh for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 15:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 82B9B81762
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 15:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650902032; x=1682438032;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OgI7VQnUPjqMWNGxE5sNT1Rye9YtELUHcykl0maLGbY=;
 b=Bh30bf/fA29fkTaIvRzGNYDS93Qo9O+z3OiwjJ6OP53sNdRd6tvtHEwS
 Y+nJ/GT4DhE6dFBEgjq+Tgvv4chDC8jkfZSvvrHeV+jJi9wTuIL4bRx8a
 +V8A7hWt2BoiXbV871HeIJMBqKPM4eLcjOMeaGu1LE0V0LqLfjopwT8D+
 I1sHDChx9JKYakzrk3Au1QtzddQLFWotwj4jvzar00IWgeOuf6G1LUxqA
 fLzXlTsnm/bWLsXN6pJTkvYuYiel+Kgbua45cn5rTLOYc8E1EwFAmTsuS
 vljzLDZBk2h97DBX/Cmx6876IyBkMyd1QLPrC6PJ+/DHXHFzhBMihciPM w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245851293"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; d="scan'208";a="245851293"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 08:53:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; d="scan'208";a="595294518"
Received: from bjkrist-mobl.amr.corp.intel.com (HELO [10.212.88.70])
 ([10.212.88.70])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2022 08:53:50 -0700
Message-ID: <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
Date: Mon, 25 Apr 2022 08:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <YllADL6uMoLllzQo@fyu1.sc.intel.com> <YmA4pbgevqln/jSO@myrica>
 <tencent_76E043C4D1B6A21A5253579A61034107EB06@qq.com>
 <tencent_7477100F8A445C6CAFA8F13601A55134480A@qq.com>
 <YmJ/WA6KAQU/xJjA@myrica>
 <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica> <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YmavoKkVu+hd+x0M@myrica>
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

On 4/25/22 07:26, Jean-Philippe Brucker wrote:
>>
>> How does the IOMMU hardware know that all activity to a given PASID is
>> finished?  That activity should, today, be independent of an mm or a
>> fd's lifetime.
> In the case of uacce, it's tied to the fd lifetime: opening an accelerator
> queue calls iommu_sva_bind_device(), which sets up the PASID context in
> the IOMMU. Closing the queue calls iommu_sva_unbind_device() which
> destroys the PASID context (after the device driver stopped all DMA for
> this PASID).

Could this PASID context destruction move from being "fd-based" to
happening under mm_pasid_drop()?  Logically, it seems like that should
work because mm_pasid_drop() happens after exit_mmap() where the VMAs
(which hold references to 'struct file' via vma->vm_file) are torn down.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
