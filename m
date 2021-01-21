Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91D9C433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 21:30:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BC623A5B
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 21:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BC623A5B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F037E86374;
	Thu, 21 Jan 2021 21:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bFHDAl3rcWtx; Thu, 21 Jan 2021 21:30:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3A2BE8631C;
	Thu, 21 Jan 2021 21:30:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D471C088B;
	Thu, 21 Jan 2021 21:30:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36166C013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 21:30:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1A86620766
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 21:30:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Zy8mA5xqu2x for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 21:30:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from a1.mail.mailgun.net (a1.mail.mailgun.net [198.61.254.60])
 by silver.osuosl.org (Postfix) with ESMTPS id EF02C204DF
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 21:30:37 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1611264640; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tq0FX0gjjypNx35NWziv3I0HuJg9vmylS8439Swmh1c=;
 b=qeJD67G+tj9Gok/Zilhkh8Eu3VHsSU+xNY9g2rOBTM7Y3HMYCT4N2pxCJYYkLlR3R7RW8ATj
 xf8+TWxTQTJaLe3wcmp9MQbpRjM2kKfjUftcP91A5qGgOvcVou4xeilGkxieuaQGocBVg1eW
 CWoOj8UOZFFHfP2J/Q9Yob+ra54=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6009f266bdcf468287939d1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Jan 2021 21:30:14
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 731BEC433ED; Thu, 21 Jan 2021 21:30:13 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DC07C43461;
 Thu, 21 Jan 2021 21:30:12 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 21 Jan 2021 13:30:12 -0800
From: isaacm@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/5] Optimize iommu_map_sg() performance
In-Reply-To: <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
 <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
Message-ID: <2580095e227403893b78856edbaeb77b@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: pdaly@codeaurora.org, will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, pratikp@codeaurora.org,
 linux-arm-kernel@lists.infradead.org
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

On 2021-01-12 08:00, Robin Murphy wrote:
> On 2021-01-11 14:54, Isaac J. Manjarres wrote:
>> The iommu_map_sg() code currently iterates through the given
>> scatter-gather list, and in the worst case, invokes iommu_map()
>> for each element in the scatter-gather list, which calls into
>> the IOMMU driver through an indirect call. For an IOMMU driver
>> that uses a format supported by the io-pgtable code, the IOMMU
>> driver will then call into the io-pgtable code to map the chunk.
>> 
>> Jumping between the IOMMU core code, the IOMMU driver, and the
>> io-pgtable code and back for each element in a scatter-gather list
>> is not efficient.
>> 
>> Instead, add a map_sg() hook in both the IOMMU driver ops and the
>> io-pgtable ops. iommu_map_sg() can then call into the IOMMU driver's
>> map_sg() hook with the entire scatter-gather list, which can call
>> into the io-pgtable map_sg() hook, which can process the entire
>> scatter-gather list, signficantly reducing the number of indirect
>> calls, and jumps between these layers, boosting performance.
> 
> Out of curiosity, how much of the difference is attributable to actual
> indirect call overhead vs. the additional massive reduction in visits
> to arm_smmu_rpm_{get,put} that you fail to mention?There are ways to
I did an experiment where I compared the two approaches without any 
calls
to arm_smmu_rpm_[get/put]. There's still a large amount of difference
without the overhead incurred by power management calls. Here are the 
results:

no optimizations and no power management calls:
  size        iommu_map_sg
       4K            0.609 us
      64K            8.583 us
       1M          136.083 us
       2M          273.145 us
      12M         1442.119 us
      24M         2876.078 us
      32M         3832.041 us

iommu_map_sg optimizations and no power management calls:
size        iommu_map_sg
       4K            0.645 us
      64K            1.229 us
       1M            9.531 us
       2M           23.198 us
      12M           99.250 us
      24M          185.713 us
      32M          248.781 us

 From here, we can see that the amount of latency incurred by the 
indirect
calls is fairly large.

> optimise indirect calling that would benefit *all* cases, rather than
> just one operation for one particular driver.
Do you mind sharing some more information on how to optimize the 
existing
approach further, such that it benefits other drivers as well?
> 
>> On a system that uses the ARM SMMU driver, and the ARM LPAE format,
>> the current implementation of iommu_map_sg() yields the following
>> latencies for mapping scatter-gather lists of various sizes. These
>> latencies are calculated by repeating the mapping operation 10 times:
>> 
>>      size        iommu_map_sg latency
>>        4K            0.624 us
>>       64K            9.468 us
>>        1M          122.557 us
>>        2M          239.807 us
>>       12M         1435.979 us
>>       24M         2884.968 us
>>       32M         3832.979 us
>> 
>> On the same system, the proposed modifications yield the following
>> results:
>> 
>>      size        iommu_map_sg latency
>>        4K            3.645 us
>>       64K            4.198 us
>>        1M           11.010 us
>>        2M           17.125 us
>>       12M           82.416 us
>>       24M          158.677 us
>>       32M          210.468 us
>> 
>> The procedure for collecting the iommu_map_sg latencies is
>> the same in both experiments. Clearly, reducing the jumps
>> between the different layers in the IOMMU code offers a
>> signficant performance boost in iommu_map_sg() latency.
> 
> Presumably those are deliberately worst-case numbers? After all, a
> 32MB scatterlist *could* incur less overhead than a 64KB one if things
> line up just right (still 16 ->map calls, but each with one fewer
Yes, these are worst case numbers (i.e. a buffer is composed entirely
of 4 KB pages, so higher order mappings don't get used).
> level of pagetable to traverse). TBH I find the significant regression
> of the 4KB case the most interesting - what's going on there?
That was an error on my part. After fixing my error, I observed that the
time spent mapping the 4 KB buffer is comparable with and without 
optimizations,
which is expected.
> 
> My main reservation here is that we get an explosion of duplicate
> copies of almost the same code, and it's code that's just non-trivial
> enough to start being bug-prone. And it's all still only for one
> specific operation - your argument about calling through multiple
> layers for each element applies just as much to iommu_map() itself, so
> why aren't we trying to make more fundamental improvements with wider
> benefits? Indeed I can't imagine the existing iommu_map_sg() loop
> really adds significant overhead compared to a single iommu_map() call
> that results in the equivalent set of ->map calls to the driver.
> 
> At a glance, I reckon that simply extending the internal ->map and
> ->unmap interfaces to encode a number of consecutive identical pages
> would already get us a large chunk of the way there; then we'd be in a
> better place to consider options for the io-pgtable interface.
> 
Do you mean physically contiguous pages? If so, that still wouldn't help 
the
case where a buffer is composed entirely of 4 KB pages, correct?
> Robin.
> 
>> Changes since v1:
>> 
>> -Fixed an off by one error in arm_[lpae/v7s]_map_by_pgsize
>> when checking if the IOVA and physical address ranges being
>> mapped are within the appropriate limits.
>> -Added Sai Prakash Ranjan's "Tested-by" tag.
>> 
>> Thanks,
>> Isaac
>> 
>> Isaac J. Manjarres (5):
>>    iommu/io-pgtable: Introduce map_sg() as a page table op
>>    iommu/io-pgtable-arm: Hook up map_sg()
>>    iommu/io-pgtable-arm-v7s: Hook up map_sg()
>>    iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>>    iommu/arm-smmu: Hook up map_sg()
>> 
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 19 ++++++++
>>   drivers/iommu/io-pgtable-arm-v7s.c    | 90 
>> +++++++++++++++++++++++++++++++++++
>>   drivers/iommu/io-pgtable-arm.c        | 86 
>> +++++++++++++++++++++++++++++++++
>>   drivers/iommu/iommu.c                 | 25 ++++++++--
>>   include/linux/io-pgtable.h            |  6 +++
>>   include/linux/iommu.h                 | 13 +++++
>>   6 files changed, 234 insertions(+), 5 deletions(-)
>> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
