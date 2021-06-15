Return-Path: <SRS0=7V87=LJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BFCC48BE5
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D7036145C
	for <iommu@archiver.kernel.org>; Tue, 15 Jun 2021 11:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D7036145C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07F89836F0;
	Tue, 15 Jun 2021 11:51:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f3kZLEvpYKgf; Tue, 15 Jun 2021 11:51:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D998A833D3;
	Tue, 15 Jun 2021 11:51:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB94AC000E;
	Tue, 15 Jun 2021 11:51:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5350C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id A4062404B9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:51:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id Fbv0HMaPI2uI for <iommu@lists.linux-foundation.org>;
 Tue, 15 Jun 2021 11:51:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 10F1F404A5
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 11:51:31 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623757899; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/ci1rzPoEU+l3HzDBbWn4cIwPVaqw55throQucUw+SI=;
 b=c5Lsqt/3f5+BDsUaUln+6CQXjRqPYrsjCUnn/DzEiJQf5WBRsUjFuvf7jR43LHeHWDJmmMRj
 FaYCOI5A7XOes0D0Qd2CugUTFdCiUzyQEjPI/Y96GuvHVEPP0mKZtLG4fZ8PAxQKOJvYJjkG
 LuX4goPtES1Uu0nn2ThmaIEp/bE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60c8942babfd22a3dc0f9c9f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 11:51:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 52A6CC43143; Tue, 15 Jun 2021 11:51:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4ECE2C433F1;
 Tue, 15 Jun 2021 11:51:05 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 15 Jun 2021 17:21:05 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Krishna Reddy <vdumpa@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
In-Reply-To: <BY5PR12MB376433B3FD0A59EF57C4522DB3319@BY5PR12MB3764.namprd12.prod.outlook.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
 <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
 <266f190e-99ae-9175-cf13-7a77730af389@arm.com>
 <dfdabcdec99a4c6e3bf2b3c5eebe067f@codeaurora.org>
 <61c69d23-324a-85d7-2458-dfff8df9280b@arm.com>
 <BY5PR12MB37646698F37C00381EFF7C77B3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <07001b4ed6c0a491eacce6e4dc13ab5e@codeaurora.org>
 <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
 <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
 <BY5PR12MB376433B3FD0A59EF57C4522DB3319@BY5PR12MB3764.namprd12.prod.outlook.com>
Message-ID: <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thierry Reding <treding@nvidia.com>,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Hi Krishna,

On 2021-06-14 23:18, Krishna Reddy wrote:
>> Right but we won't know until we profile the specific usecases or try 
>> them in
>> generic workload to see if they affect the performance. Sure, over 
>> invalidation is
>> a concern where multiple buffers can be mapped to same context and the 
>> cache
>> is not usable at the time for lookup and such but we don't do it for 
>> small buffers
>> and only for large buffers which means thousands of TLB entry mappings 
>> in
>> which case TLBIASID is preferred (note: I mentioned the HW team
>> recommendation to use it for anything greater than 128 TLB entries) in 
>> my
>> earlier reply. And also note that we do this only for partial walk 
>> flush, we are not
>> arbitrarily changing all the TLBIs to ASID based.
> 
> Most of the heavy bw use cases does involve processing larger buffers.
> When the physical memory is allocated dis-contiguously at page_size
> (let's use 4KB here)
> granularity, each aligned 2MB chunks IOVA unmap would involve
> performing a TLBIASID
> as 2MB is not a leaf. Essentially, It happens all the time during
> large buffer unmaps and
> potentially impact active traffic on other large buffers. Depending on 
> how much
> latency HW engines can absorb, the overflow/underflow issues for ISO
> engines can be
> sporadic and vendor specific.
> Performing TLBIASID as default for all SoCs is not a safe operation.
> 

Ok so from what I gather from this is that its not easy to test for the
negative impact and you don't have data on such yet and the behaviour is
very vendor specific. To add on qcom impl, we have several performance
improvements for TLB cache invalidations in HW like wait-for-safe(for 
realtime
clients such as camera and display) and few others to allow for cache
lookups/updates when TLBI is in progress for the same context bank, so 
atleast
we are good here.

> 
>> I am no camera expert but from what the camera team mentioned is that 
>> there
>> is a thread which frees memory(large unused memory buffers) 
>> periodically which
>> ends up taking around 100+ms and causing some camera test failures 
>> with
>> frame drops. Parallel efforts are already being made to optimize this 
>> usage of
>> thread but as I mentioned previously, this is *not a camera specific*, 
>> lets say
>> someone else invokes such large unmaps, it's going to face the same 
>> issue.
> 
> From the above, It doesn't look like the root cause of frame drops is
> fully understood.
> Why is 100+ms delay causing camera frame drop?  Is the same thread
> submitting the buffers
> to camera after unmap is complete? If not, how is the unmap latency
> causing issue here?
> 

Ok since you are interested in camera usecase, I have requested for more 
details
from the camera team and will give it once they comeback. However I 
don't think
its good to have unmap latency at all and that is being addressed by 
this patch.

> 
>> > If unmap is queued and performed on a back ground thread, would it
>> > resolve the frame drops?
>> 
>> Not sure I understand what you mean by queuing on background thread 
>> but with
>> that or not, we still do the same number of TLBIs and hop through
>> iommu->io-pgtable->arm-smmu to perform the the unmap, so how will that
>> help?
> 
> I mean adding the unmap requests into a queue and processing them from
> a different thread.
> It is not to reduce the TLBIs. But, not to block subsequent buffer
> allocation, IOVA map requests, if they
> are being requested from same thread that is performing unmap. If
> unmap is already performed from
> a different thread, then the issue still need to be root caused to
> understand it fully. Check for any
> serialization issues.
> 

This patch is to optimize unmap latency because of large number of mmio 
writes(TLBIVAs)
wasting CPU cycles and not to fix camera issue which can probably be 
solved by
parallelization. It seems to me like you are ok with the unmap latency 
in general
which we are not and want to avoid that latency.

Hi @Robin, from these discussions it seems they are not ok with the 
change
for all SoC vendor implementations and do not have any data on such 
impact.
As I mentioned above, on QCOM platforms we do have several optimizations 
in HW
for TLBIs and would like to make use of it and reduce the unmap latency.
What do you think, should this be made implementation specific?

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
