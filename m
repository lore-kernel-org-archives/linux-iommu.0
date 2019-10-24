Return-Path: <SRS0=zRLl=YR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451B6CA9EAF
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 11:31:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CFE20679
	for <iommu@archiver.kernel.org>; Thu, 24 Oct 2019 11:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXmmrZmw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hXmmrZmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CFE20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E35251514;
	Thu, 24 Oct 2019 11:31:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 377241513
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 11:31:06 +0000 (UTC)
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DDFEE8B8
	for <iommu@lists.linux-foundation.org>;
	Thu, 24 Oct 2019 11:31:05 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9EC760DCD; Thu, 24 Oct 2019 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1571916665;
	bh=Df3D1TVJ0A68e7eOZBT3yIaWIqBH4dlXJJA083uNO6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hXmmrZmwgTc/IBZ4bMWBbc7e7OZRqHmwVMdTl+GcGP8rpinZNHiUVJCVs9orq/Olk
	6vXqafVsusvMd/oToUAqqXjWV5rKqxTL56bFMbKI0/adunDBzbwEXR9r35waa4FaIu
	FbRgEfECQgDFzeufRqVymT4DZzMX6rBGDIZkVzco=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.codeaurora.org (Postfix) with ESMTP id 13114607B5;
	Thu, 24 Oct 2019 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1571916665;
	bh=Df3D1TVJ0A68e7eOZBT3yIaWIqBH4dlXJJA083uNO6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hXmmrZmwgTc/IBZ4bMWBbc7e7OZRqHmwVMdTl+GcGP8rpinZNHiUVJCVs9orq/Olk
	6vXqafVsusvMd/oToUAqqXjWV5rKqxTL56bFMbKI0/adunDBzbwEXR9r35waa4FaIu
	FbRgEfECQgDFzeufRqVymT4DZzMX6rBGDIZkVzco=
MIME-Version: 1.0
Date: Thu, 24 Oct 2019 17:01:05 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Will Deacon <will@kernel.org>
Subject: Re: Users of IOMMU_QCOM_SYS_CACHE?
In-Reply-To: <20191024112130.GD1242@willie-the-truck>
References: <20191024105150.GC1242@willie-the-truck>
	<d255a4a6835fb982b5852106f970b0e6@codeaurora.org>
	<20191024112130.GD1242@willie-the-truck>
Message-ID: <257ea3fb1740ba7b968e1ddfbbb94a52@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com, sspatil@android.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 2019-10-24 16:51, Will Deacon wrote:
> On Thu, Oct 24, 2019 at 04:41:04PM +0530, Sai Prakash Ranjan wrote:
>> On 2019-10-24 16:21, Will Deacon wrote:
>> > In commit 90ec7a76cc4b ("iommu/io-pgtable-arm: Add support to use system
>> > cache") we added support for IOMMU_QCOM_SYS_CACHE which was merged into
>> > 5.3.
>> > This allows non-coherent devices to request an outer cacheable memory
>> > type.... except that nobody actually does this in mainline. I remember
>> > there
>> > being a potential DRM user but I don't know what happened to it.
>> >
>> > Given that this isn't actually exposed in the DMA API, I worry that
>> > we're
>> > just carrying part of an out-of-tree hack here and propose that we drop
>> > the flag altogether unless we get an upstream user, preferably by
>> > plumbing
>> > this into the DMA API via a new attribute.
>> >
>> > Thoughts?
>> >
>> 
>> There is definitely a user of this coming soon atleast for SC7180 SoC 
>> once
>> we have support for this SoC upstream.
> 
> Ok, I'm keen to see how you end up using this. How soon is soon?
> 

We have already started upstreaming for SC7180, so this should also come 
pretty soon. Sorry, I cannot tell the exact date but can make sure that 
your message reaches to appropriate team.

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
