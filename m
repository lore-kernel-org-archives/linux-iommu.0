Return-Path: <SRS0=Ewjr=LG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1230AC48BE6
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 02:46:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884016128A
	for <iommu@archiver.kernel.org>; Sat, 12 Jun 2021 02:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884016128A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40F99406A5;
	Sat, 12 Jun 2021 02:46:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LVa0gxkGx4cH; Sat, 12 Jun 2021 02:46:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE4A94069D;
	Sat, 12 Jun 2021 02:46:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2AC2C000D;
	Sat, 12 Jun 2021 02:46:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F18CEC000B
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 02:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id E335C400C4
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 02:46:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id qbVDt2YBybp7 for <iommu@lists.linux-foundation.org>;
 Sat, 12 Jun 2021 02:46:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 3261540004
 for <iommu@lists.linux-foundation.org>; Sat, 12 Jun 2021 02:46:36 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623465996; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=j7qyuZEIWve0Yp35tsM69fI9OIKOGtzrOcSGMsRKDag=;
 b=XxE228JXrE72elOTthcCXPRQ+MajZi6wPhXDz/xx4GR//IcLShA3mu6+/h0Tez5e1OyiabvA
 79PWqwjbU0FC4x8YOrxyx8gtFY0wvyRpWkO973P56ShJkd6zmD587JB0aeARjvD8tiEUprV/
 qIhZJE/wmmCma6OnwLSOdQjj2J8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60c42007ed59bf69ccf2d0c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 02:46:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 862C5C43217; Sat, 12 Jun 2021 02:46:31 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id C9627C433F1;
 Sat, 12 Jun 2021 02:46:30 +0000 (UTC)
MIME-Version: 1.0
Date: Sat, 12 Jun 2021 08:16:30 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Krishna Reddy <vdumpa@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
In-Reply-To: <BY5PR12MB376480219C42E5FCE0FE0FFBB3349@BY5PR12MB3764.namprd12.prod.outlook.com>
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
Message-ID: <f749ba0957b516ab5f0ea57033d308c7@codeaurora.org>
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

On 2021-06-11 22:19, Krishna Reddy wrote:
> Hi Sai,
>> >> > No, the unmap latency is not just in some test case written, the
>> >> > issue is very real and we have workloads where camera is reporting
>> >> > frame drops because of this unmap latency in the order of 100s of
>> milliseconds.
> 
>> Not exactly, this issue is not specific to camera. If you look at the 
>> numbers in the
>> commit text, even for the test device its the same observation. It 
>> depends on
>> the buffer size we are unmapping which affects the number of TLBIs 
>> issue. I am
>> not aware of any such HW side bw issues for camera specifically on 
>> QCOM
>> devices.
> 
> It is clear that reducing number of TLBIs  reduces the umap API
> latency. But, It is
> at the expense of throwing away valid tlb entries.
> Quantifying the impact of arbitrary invalidation of valid tlb entries
> at context level is not straight forward and
> use case dependent. The side-effects might be rare or won't be known
> until they are noticed.

Right but we won't know until we profile the specific usecases or try 
them
in generic workload to see if they affect the performance. Sure, over
invalidation is a concern where multiple buffers can be mapped to same 
context
and the cache is not usable at the time for lookup and such but we don't 
do it
for small buffers and only for large buffers which means thousands of 
TLB entry
mappings in which case TLBIASID is preferred (note: I mentioned the HW 
team
recommendation to use it for anything greater than 128 TLB entries) in 
my earlier
reply. And also note that we do this only for partial walk flush, we are 
not
arbitrarily changing all the TLBIs to ASID based.

> Can you provide more details on How the unmap latency is causing
> camera to drop frames?
> Is unmap performed in the perf path?

I am no camera expert but from what the camera team mentioned is that
there is a thread which frees memory(large unused memory buffers)
periodically which ends up taking around 100+ms and causing some camera 
test
failures with frame drops. Parallel efforts are already being made to 
optimize
this usage of thread but as I mentioned previously, this is *not a 
camera
specific*, lets say someone else invokes such large unmaps, it's going 
to face
the same issue.

> If unmap is queued and performed on a back ground thread, would it
> resolve the frame drops?

Not sure I understand what you mean by queuing on background thread but 
with
that or not, we still do the same number of TLBIs and hop through
iommu->io-pgtable->arm-smmu to perform the the unmap, so how will that 
help?

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
