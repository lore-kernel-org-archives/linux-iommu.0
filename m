Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742D1C48BDF
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 04:05:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA1061369
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 04:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA1061369
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC39A83D14;
	Fri, 18 Jun 2021 04:05:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Khl1QDDA6x4; Fri, 18 Jun 2021 04:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6F52D83CCB;
	Fri, 18 Jun 2021 04:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46AAAC000D;
	Fri, 18 Jun 2021 04:05:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86CD5C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 04:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 6C717401C8
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 04:05:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id wBm4PobwbIkW for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 04:05:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id DD3D740003
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 04:05:19 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623989121; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=k4HKuaL//VdF5gQIL9VhYemVHmDBvisX1u+MgvW5TN4=;
 b=AEvDMC0jB8vle+dp1leWzpkhxHRxDEN7mzyJRJPz1okgIIW2GuenSr0mrzmjK8ac8+u0y5op
 PhJpHkg8ftZ7v/rszI6k/O2BOGKr+UyPfHFR14EqIsr0Tz18u2LnP96ECGXF19i3r4QP9U13
 +Murf7ULwsJ5AmpSrRzzCRi0WZQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60cc1b70e27c0cc77f356ae2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 18 Jun 2021 04:05:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id A275DC433D3; Fri, 18 Jun 2021 04:05:03 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id D7F05C433D3;
 Fri, 18 Jun 2021 04:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D7F05C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail
 smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: saiprakash.ranjan@codeaurora.org,
	vdumpa@nvidia.com
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
Date: Fri, 18 Jun 2021 09:34:44 +0530
Message-Id: <20210618040444.17270-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
References: <5eb5146ab51a8fe0b558680d479a26cd@codeaurora.org>
MIME-Version: 1.0
Cc: will@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 treding@nvidia.com, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On 2021-06-15 17:21, Sai Prakash Ranjan wrote:
> Hi Krishna,
> 
> On 2021-06-14 23:18, Krishna Reddy wrote:
>>> Right but we won't know until we profile the specific usecases or try them in
>>> generic workload to see if they affect the performance. Sure, over invalidation is
>>> a concern where multiple buffers can be mapped to same context and the cache
>>> is not usable at the time for lookup and such but we don't do it for small buffers
>>> and only for large buffers which means thousands of TLB entry mappings in
>>> which case TLBIASID is preferred (note: I mentioned the HW team
>>> recommendation to use it for anything greater than 128 TLB entries) in my
>>> earlier reply. And also note that we do this only for partial walk flush, we are not
>>> arbitrarily changing all the TLBIs to ASID based.
>>
>> Most of the heavy bw use cases does involve processing larger buffers.
>> When the physical memory is allocated dis-contiguously at page_size
>> (let's use 4KB here)
>> granularity, each aligned 2MB chunks IOVA unmap would involve
>> performing a TLBIASID
>> as 2MB is not a leaf. Essentially, It happens all the time during
>> large buffer unmaps and
>> potentially impact active traffic on other large buffers. Depending on how much
>> latency HW engines can absorb, the overflow/underflow issues for ISO
>> engines can be
>> sporadic and vendor specific.
>> Performing TLBIASID as default for all SoCs is not a safe operation.
>>
> 
> Ok so from what I gather from this is that its not easy to test for the
> negative impact and you don't have data on such yet and the behaviour is
> very vendor specific. To add on qcom impl, we have several performance
> improvements for TLB cache invalidations in HW like wait-for-safe(for realtime
> clients such as camera and display) and few others to allow for cache
> lookups/updates when TLBI is in progress for the same context bank, so atleast
> we are good here.
> 
>>
>>> I am no camera expert but from what the camera team mentioned is that there
>>> is a thread which frees memory(large unused memory buffers) periodically which
>>> ends up taking around 100+ms and causing some camera test failures with
>>> frame drops. Parallel efforts are already being made to optimize this usage of
>>> thread but as I mentioned previously, this is *not a camera specific*, lets say
>>> someone else invokes such large unmaps, it's going to face the same issue.
>>
>> From the above, It doesn't look like the root cause of frame drops is
>> fully understood.
>> Why is 100+ms delay causing camera frame drop?  Is the same thread
>> submitting the buffers
>> to camera after unmap is complete? If not, how is the unmap latency
>> causing issue here?
>>
> 
> Ok since you are interested in camera usecase, I have requested for more details
> from the camera team and will give it once they comeback. However I don't think
> its good to have unmap latency at all and that is being addressed by this patch.
> 

As promised, here are some more details shared by camera team:

Mapping of a framework buffer happens at the time of process request and unmapping
of a framework buffer happens once the buffer is available from hardware and result
will be notified to camera framework.
 * When there is a delay in unmapping of a buffer, result notification to framework
   will be delayed and based on pipeline delay depth, new requests from framework
   will be delayed.
 * Camera stack uses internal buffer managers for internal and framework buffers.
   While mapping and unmapping these managers will be accessed, so uses common lock
   and hence is a blocking call. So unmapping delay will cause the delay for mapping
   of a new request and leads to framedrop.

Map and unmap happens in the camera service process context. There is no separate perf
path to perform unmapping.

In Camera stack along with map/unmap delay, additional delays are due to HW. So HW should
be able to get the requests in time from SW to avoid frame drops.

Thanks,
Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
