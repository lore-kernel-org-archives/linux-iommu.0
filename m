Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786EDC433F5
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 05:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06D824154E;
	Fri,  6 May 2022 05:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pvgk9z6PSVo; Fri,  6 May 2022 05:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A82B041516;
	Fri,  6 May 2022 05:36:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6166DC0032;
	Fri,  6 May 2022 05:36:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FB0BC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D87060B9A
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYSHAdt2RK3Y for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 05:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EDBF5605EE
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 05:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651815405; x=1683351405;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7WUabhyWEk0L7SRCIeRBJvTnaBGJT01I1lM5YJHnXF8=;
 b=kcNPw+IZLtFXuJzF/NmxShcqyqP+fPJfTfEFd16QWwNdPFrB+fmxARDK
 PH52U1FROdyN7pcXKTtLMpShO/4pncRmcM5OdiJwSo924/K0cNYZfNynn
 rRDi+F47YRWnTObqmG7EazRmKExoyebGw8Gs1QT1X+Fwd0l2sH77SK/+b
 C6rpPSOrf1Cxp6jrAtHzXryk7SGG9ALAAmiaVXdOGQxKcoheghiu+5nk7
 fJ5eBs9AdPwhbSP+boQTWCTCPBN17W3xMfANkpzPaSXKRbFbprFCbuAiN
 TxxFazBPcuZoLWj85Lh4rFk4GLH87OneoByRNzHOj0rrIidFGElXeKUzD Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="354792616"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="354792616"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:36:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="735407780"
Received: from sunyanwa-mobl1.ccr.corp.intel.com (HELO [10.255.31.183])
 ([10.255.31.183])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2022 22:36:39 -0700
Message-ID: <a7778e67-bcc7-03b0-0b58-fc311d542baa@linux.intel.com>
Date: Fri, 6 May 2022 13:36:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com> <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com> <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com> <Ymv3fC4xXqe+oMRK@myrica>
 <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
 <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
 <YnDeoGjv/dZnu+YQ@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnDeoGjv/dZnu+YQ@myrica>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Ravi V Shankar <ravi.v.shankar@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, will@kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>, x86 <x86@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dave Hansen <dave.hansen@intel.com>, iommu <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 zhangfei.gao@linaro.org, Thomas Gleixner <tglx@linutronix.de>,
 robin.murphy@arm.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/5/3 15:49, Jean-Philippe Brucker wrote:
> On Sat, Apr 30, 2022 at 03:33:17PM +0800, Baolu Lu wrote:
>> Jean, another quick question about the iommu_sva_bind_device()
>>
>> /**
>>   * iommu_sva_bind_device() - Bind a process address space to a device
>>   * @dev: the device
>>   * @mm: the mm to bind, caller must hold a reference to it
>>   * @drvdata: opaque data pointer to pass to bind callback
>>
>> This interface requires the caller to take a reference to mm. Which
>> reference should it take, mm->mm_count or mm->mm_users? It's better to
>> make it explicit in this comment.
> 
> Agreed, it's mm_users as required by mmu_notifier_register()

Thanks! I will add this in my refactoring patch.

Best regards,
baolu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
