Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9E7C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 14:28:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0DA611CA
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 14:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0DA611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF8B882E92;
	Tue, 22 Jun 2021 14:28:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNRhAJmyAbiW; Tue, 22 Jun 2021 14:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9151882E80;
	Tue, 22 Jun 2021 14:28:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72F7EC001A;
	Tue, 22 Jun 2021 14:28:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE486C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 14:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id CE4BB4050A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 14:28:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id debLHmQP9AR5 for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 14:28:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id A255A40505
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 14:28:17 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1624372101; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=GwlPniao3J7tcSGfx042pEI6HKO5H285thPuoFh/a74=;
 b=U+k4YkvOmH57nQ9ptDvfzenEAaGaKo8tIYTV1DG7DXwxu9ywex5G9LA0lYYh8yI9yw5f64fU
 7zvsUZIsCiHqfo7bC4DZSc+qS2ZGx/hE66GhJZsAxR4ogiLFcoPgjdpglKJb9kK1t68KhPk2
 cYYm5Gke2a8L2ixg9BIcp7feNks=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60d1f36912003202418d15d6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 14:27:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 43451C4338A; Tue, 22 Jun 2021 14:27:52 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 84E5FC433D3;
 Tue, 22 Jun 2021 14:27:51 +0000 (UTC)
MIME-Version: 1.0
Date: Tue, 22 Jun 2021 19:57:51 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv2 1/3] iommu/io-pgtable: Add a quirk to use
 tlb_flush_all() for partial walk flush
In-Reply-To: <2b093b93-7fab-be35-59d8-4463c199719a@arm.com>
References: <cover.1623981933.git.saiprakash.ranjan@codeaurora.org>
 <b099af10926b34249f4a30262db37f50491bebe7.1623981933.git.saiprakash.ranjan@codeaurora.org>
 <904f283c-f8b1-ba84-d010-eacc87bb53c5@arm.com>
 <a110e58e36af207be2bed04d1331832a@codeaurora.org>
 <2b093b93-7fab-be35-59d8-4463c199719a@arm.com>
Message-ID: <c0329da89bee9b51b88d907875608877@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>,
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

Hi Robin,

On 2021-06-22 17:41, Robin Murphy wrote:
> On 2021-06-22 08:11, Sai Prakash Ranjan wrote:
>> Hi Robin,
>> 
>> On 2021-06-21 21:15, Robin Murphy wrote:
>>> On 2021-06-18 03:51, Sai Prakash Ranjan wrote:
>>>> Add a quirk IO_PGTABLE_QUIRK_TLB_INV_ALL to invalidate entire 
>>>> context
>>>> with tlb_flush_all() callback in partial walk flush to improve unmap
>>>> performance on select few platforms where the cost of 
>>>> over-invalidation
>>>> is less than the unmap latency.
>>> 
>>> I still think this doesn't belong anywhere near io-pgtable at all.
>>> It's a driver-internal decision how exactly it implements a non-leaf
>>> invalidation, and that may be more complex than a predetermined
>>> boolean decision. For example, I've just realised for SMMUv3 we can't
>>> invalidate multiple levels of table at once with a range command,
>>> since if we assume the whole thing is mapped at worst-case page
>>> granularity we may fail to invalidate any parts which are mapped as
>>> intermediate-level blocks. If invalidating a 1GB region (with 4KB
>>> granule) means having to fall back to 256K non-range commands, we may
>>> not want to invalidate by VA then, even though doing so for a 2MB
>>> region is still optimal.
>>> 
>>> It's also quite feasible that drivers might want to do this for leaf
>>> invalidations too - if you don't like issuing 512 commands to
>>> invalidate 2MB, do you like issuing 511 commands to invalidate 
>>> 2044KB?
>>> - and at that point the logic really has to be in the driver anyway.
>>> 
>> 
>> Ok I will move this to tlb_flush_walk() functions in the drivers. In 
>> the previous
>> v1 thread, you suggested to make the choice in iommu_get_dma_strict() 
>> test,
>> I assume you meant the test in iommu_dma_init_domain() with a flag or 
>> was it
>> the leaf driver(ex:arm-smmu.c) test of iommu_get_dma_strict() in 
>> init_domain?
> 
> Yes, I meant literally inside the same condition where we currently
> set "pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;" in
> arm_smmu_init_domain_context().
> 

Ok got it, thanks.

>> I am still a bit confused on where this flag would be? Should this be 
>> a part
>> of struct iommu_domain?
> 
> Well, if you were to rewrite the config with an alternative set of
> flush_ops at that point it would be implicit. For a flag, probably
> either in arm_smmu_domain or arm_smmu_impl. Maybe a flag would be less
> useful than generalising straight to a "maximum number of by-VA
> invalidations it's worth sending individually" threshold value?

But then we would still need some flag to make this implementation
specific (qcom specific for now) and this threshold would just be
another condition although it would have been useful if this was
generic enough.

> It's clear to me what overall shape and separation of responsibility is
> most logical, but beyond that I don't have a particularly strong
> opinion on the exact implementation; I've just been chucking ideas
> around :)
> 

Your ideas are very informative and useful :)

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
