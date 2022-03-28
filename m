Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B777C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 09:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE54E60F1E;
	Mon, 28 Mar 2022 09:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPNP2EdOWx20; Mon, 28 Mar 2022 09:01:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 715DA60F16;
	Mon, 28 Mar 2022 09:01:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33E32C002C;
	Mon, 28 Mar 2022 09:01:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB81C0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:01:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4832F833AE
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:01:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cavLOZvmYG3o for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 09:01:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4519681839
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648458091; x=1679994091;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lztSyO13dNPMIp1+3S6NkV1TPqamixdSPYlorlP5NbU=;
 b=BbiZLnUJDOISwv9WPc8PNFtnzoZM4A7dd2Oo+dsQ69tOapG91dH3URoD
 +FwECd/xCirj/PiFM09HD+vyArepmBRRhOxHjB1JrjkgyyRthmXyoJ48W
 fqik+9o1UFZ7Gvy8GfvJSMdN/jegVnuHTAwEB2Hhs8rtToM3sX5ur4x1/
 i6I+6Sa/f2tu4Fekh4YqemZ5LqQZD+nrVhDEHdSirckv3iJsNHEtjt2s8
 o6qIDYxaWnSyOTadiAyW4qxZVer5/20eI1QA+orHcGDctIWBGlUIjFQDu
 kGo//N5Ta/9+6vLdaYqUXbjjn4rJuk+z9lbmbBNRafSYJ5MhvWZVXl//N Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10299"; a="259136942"
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; d="scan'208";a="259136942"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 02:01:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,216,1643702400"; d="scan'208";a="563463131"
Received: from yansenfx-mobl.ccr.corp.intel.com (HELO [10.254.208.65])
 ([10.254.208.65])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2022 02:01:29 -0700
Message-ID: <4190f3d7-5c4f-084f-f3bd-2dcf890cd6dc@linux.intel.com>
Date: Mon, 28 Mar 2022 17:01:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Bug report: VFIO map/unmep mem subject to race and DMA data goes
 to incorrect page (4.18.0)
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>,
 "Daniel F. Smith" <dfsmith@us.ibm.com>
References: <20220325200640.GA29990@porter.almaden.ibm.com>
 <20220325161022.00ab43ff.alex.williamson@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220325161022.00ab43ff.alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org
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

Hi Daniel,

On 2022/3/26 6:10, Alex Williamson wrote:
> Hi Daniel,
> 
> On Fri, 25 Mar 2022 13:06:40 -0700
> "Daniel F. Smith" <dfsmith@us.ibm.com> wrote:
> 
>> This email is to document an insidious (incorrect data, no error or warning)
>> VFIO bug found when using the Intel IOMMU to perform DMA transfers; and the
>> associated workaround.
>>
>> There may be security implications (unsure).
>>
>> /sys/devices/virtual/iommu/dmar0/intel-iommu/version: 1:0
>> /sys/devices/virtual/iommu/dmar0/intel-iommu/cap: d2008c40660462
>> Linux xxxxx.ibm.com 4.18.0-348.20.1.el8_5.x86_64 #1 SMP Tue Mar 8 12:56:54 EST 2022 x86_64 x86_64 x86_64 GNU/Linux
>> Red Hat Enterprise Linux release 8.5 (Ootpa)
>>
>> In our testing of VFIO DMA to an FPGA card in rootless mode, we discovered a
>> glitch where DMA data are transferred to/from the incorrect page.  It
>> appears timing based.  Under some specific conditions the test could trigger
>> the bug every loop.  Sometimes the bug would only emerge after 20+ minutes
>> of testing.
>>
>> Basics of test:
>> 	Get memory with mmap(anonymous): size can change.
>> 	VFIO_IOMMU_MAP_DMA with a block of memory, fixed IOVA.
>> 	Fill memory with pattern.
>> 	Do DMA transfer to FPGA from memory at IOVA.
>> 	Do DMA transfer from FPGA to memory at IOVA+offset.
>> 	Compare memory to ensure match.  Miscompare is bug.
>> 	VFIO_IOMMU_UNMAP_DMA
>> 	unmap()
>> 	Repeat.
>>
>> Using the fixed IOVA address* caused sporadic memory miscompares.  The
>> nature of the miscompares is that the received data was mixed with pages
>> that had been returned by mmap in a *previous* loop.
>>
>> Workaround: Randomizing the IOVA eliminated the memory miscompares.
>>
>> Hypothesis/conjecture: Possible race condition in UNMAP_DMA such that pages
>> can be released/munlocked *after* the MAP_DMA with the same IOVA has
>> occurred.
> 
> Coherency possibly.
> 
> There's a possible coherency issue at the compare depending on the
> IOMMU capabilities which could affect whether DMA is coherent to memory
> or requires an explicit flush.  I'm a little suspicious whether dmar0
> is really the IOMMU controlling this device since you mention a 39bit
> IOVA space, which is more typical of Intel client platforms which can
> also have integrated graphics which often have a dedicated IOMMU at
> dmar0 that isn't necessarily representative of the other IOMMUs in the
> system, especially with regard to snoop-control.  Each dmar lists the
> managed devices under it in sysfs to verify.  Support for snoop-control
> would be identified in the ecap register rather than the cap register.
> VFIO can also report coherency via the VFIO_DMA_CC_IOMMU extension
> reported by VFIO_CHECK_EXTENSION ioctl.
> 
> However, CPU coherency might lead to a miscompare, but not necessarily a
> miscompare matching the previous iteration.  Still, for completeness
> let's make sure this isn't a gap in the test programming making invalid
> assumptions about CPU/DMA coherency.
> 
> The fact that randomizing the IOVA provides a workaround though might
> suggest something relative to the IOMMU page table coherency.  But for
> the new mmap target to have the data from the previous iteration, the
> IOMMU PTE would need to be stale on read, but correct on write in order
> to land back in your new mmap.  That seems peculiar.  Are we sure the
> FPGA device isn't caching the value at the IOVA or using any sort of
> IOTLB caching such as ATS that might not be working correctly?
> 
>> Suggestion: Document issue when using fixed IOVA, or fix if security
>> is a concern.
> 
> I don't know that there's enough information here to make any
> conclusions.  Here are some further questions:
> 
>   * What size mappings are being used, both for the mmap and the VFIO
>     MAP/UNMAP operations.
> 
>   * If the above is venturing into super page support (2MB), does the
>     vfio_iommu_type1 module option disable_hugepages=1 affect the
>     results.
> 
>   * Along the same lines, does the kernel command line option
>     intel_iommu=sp_off produce different results.
> 
>   * Does this behavior also occur on upstream kernels (ie. v5.17)?
> 
>   * Do additional CPU cache flushes in the test program produce different
>     results?
> 
>   * Is this a consumer available FPGA device that others might be able
>     to reproduce this issue?  I've always wanted such a device for
>     testing, but also we can't rule out that the FPGA itself or its
>     programming is the source of the miscompare.
> 
>  From the vfio perspective, UNMAP_DMA should first unmap the pages at
> the IOMMU to prevent device access before unpinning the pages.  We do
> make use of batch unmapping to reduce iotlb flushing, but the result is
> expected to be that the IOMMU PTE entries are invalidated before the
> UNMAP_DMA operation completes.  A stale IOVA would not be expected or
> correct operation.  Thanks,
> 
> Alex
> 

As another suggestion, can you please try a patch posted here?

https://lore.kernel.org/linux-iommu/20220322063555.1422042-1-stevensd@google.com/

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
