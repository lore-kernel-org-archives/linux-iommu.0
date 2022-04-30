Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B81C433F5
	for <iommu@archiver.kernel.org>; Sat, 30 Apr 2022 07:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7BED640D9A;
	Sat, 30 Apr 2022 07:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58MADLmgFD5M; Sat, 30 Apr 2022 07:33:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3862040C38;
	Sat, 30 Apr 2022 07:33:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EB17C0039;
	Sat, 30 Apr 2022 07:33:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2769EC002D
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 07:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1486B60B2A
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 07:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uLfy_K9dJgxl for <iommu@lists.linux-foundation.org>;
 Sat, 30 Apr 2022 07:33:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1342560ACB
 for <iommu@lists.linux-foundation.org>; Sat, 30 Apr 2022 07:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651304006; x=1682840006;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=R2jqEuLVanUhC0qbR2y40hAg+OH/oqq58hrMD8YsY64=;
 b=Iu1qqginb79gEJOvqPGJUwjKTcgo/lUTyYgLwKeSRp/0gfzPa7jAj6Un
 3Pg1nvrmb3tPc5Qlk+2LcGmInd2n8ssjiHeDYDwhwOcGjx8NZ/tfFETvn
 OGnQ/X4LVTibQ2o/BeTd2VsKfjAD/SyRtBqZxjj94MfZGVuRae5fp5ydI
 1SLDoxzqEW+bKBQcrA1VBpAgiIEE5CV1lXAl1xSREanAAAqX6QkdGjALc
 2jz0OwHs3C65SWR8uo0i12AntBCEE/zk+q52GrnVjSxjbSkl+g5dlRo3W
 1TvDCtRT822Dzh1/YK79qjXry84ghi6XWXk5g2esTg8jWkF52s4Xr+p7U w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266683589"
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="266683589"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2022 00:33:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,187,1647327600"; d="scan'208";a="582650317"
Received: from aliu1-mobl.ccr.corp.intel.com (HELO [10.255.30.71])
 ([10.255.30.71])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2022 00:33:19 -0700
Message-ID: <3ea91623-97ea-f318-70db-55f08922d7ce@linux.intel.com>
Date: Sat, 30 Apr 2022 15:33:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Content-Language: en-US
To: Fenghua Yu <fenghua.yu@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com> <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com> <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com> <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com> <Ymv3fC4xXqe+oMRK@myrica>
 <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Ymxke+ihgwNy3BCE@fyu1.sc.intel.com>
Cc: Ravi V Shankar <ravi.v.shankar@intel.com>, Tony Luck <tony.luck@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 will@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
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

On 2022/4/30 06:19, Fenghua Yu wrote:
> Hi, Jean and Baolu,
> 
> On Fri, Apr 29, 2022 at 03:34:36PM +0100, Jean-Philippe Brucker wrote:
>> On Fri, Apr 29, 2022 at 06:51:17AM -0700, Fenghua Yu wrote:
>>> Hi, Baolu,
>>>
>>> On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
>>>> On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
>>>>>> The address space is what the OOM killer is after.  That gets refcounted
>>>>>> with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
>>>>>> page freeing done in __mmput()->exit_mmap().
>>>>>>
>>>>>> Also, all the VMAs should be gone after exit_mmap().  So, even if
>>>>>> vma->vm_file was holding a reference to a device driver, that reference
>>>>>> should be gone by the time __mmdrop() is actually freeing the PASID.
>>>>>
>>>>> I agree with all that. The concern was about tearing down the PASID in the
>>>>> IOMMU and device from the release() MMU notifier, which would happen in
>>>>> exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
>>>>> since the IOMMU drivers need to hold mm->mm_count anyway between bind()
>>>>> and unbind(), I think Fenghua's fix works.
>>>>
>>>> But I didn't find mmgrab()/mmdrop() get called in both arm and intel
>>>> IOMMU drivers.
>>>>
>>>> $ git grep mmgrab drivers/iommu/
>>>> [no output]
>>>>
>>>> Do we need to add these in a separated fix patch, or I missed anything
>>>> here?
>>>
>>> On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
>>> sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().
>>
>> Yes, although for Arm I realized the mmu_notifier grab wasn't sufficient
>> so I sent a separate fix that should go in 5.18 as well
>> https://lore.kernel.org/linux-iommu/20220426130444.300556-1-jean-philippe@linaro.org/
>> The Arm driver still touches the arch mm context after mmu_notifier_put().
>> I don't think X86 has that problem.
> 
> I think so too. On X86, the mm is not used after mmu_notifier_unregister().
> 
> In case of supervisor mode SVM (i.e. svm is bound to init_mm), the code
> is right too because init_mm and its PASID cannot be dropped and
> mmu_notifier_register()/mmu_notifier_unregister() are not called.
> 
> So I think no extra fix patch is needed on X86.

Thanks, Fenghua and Jean. It's clear to me now.

Jean, another quick question about the iommu_sva_bind_device()

/**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
  * @drvdata: opaque data pointer to pass to bind callback

This interface requires the caller to take a reference to mm. Which
reference should it take, mm->mm_count or mm->mm_users? It's better to
make it explicit in this comment.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
