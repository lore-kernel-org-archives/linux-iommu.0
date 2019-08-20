Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25EC3A59D
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 15:26:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFBB422CE3
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 15:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBB422CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9915CAD;
	Tue, 20 Aug 2019 15:26:00 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2F2BD5AA
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 15:25:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B9DC412E
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 15:25:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB32360;
	Tue, 20 Aug 2019 08:25:58 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807463F246;
	Tue, 20 Aug 2019 08:25:57 -0700 (PDT)
Subject: Re: [PATCH 3/4] iommu/io-pgtable-arm: Rationalise TCR handling
To: Will Deacon <will@kernel.org>
References: <cover.1566238530.git.robin.murphy@arm.com>
	<78df4f8e2510e88f3ded59eb385f79b4442ed4f2.1566238530.git.robin.murphy@arm.com>
	<20190820103115.o7neehdethf7sbqi@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <48ca6945-de73-116a-3230-84862ca9e60b@arm.com>
Date: Tue, 20 Aug 2019 16:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190820103115.o7neehdethf7sbqi@willie-the-truck>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 20/08/2019 11:31, Will Deacon wrote:
> On Mon, Aug 19, 2019 at 07:19:30PM +0100, Robin Murphy wrote:
>> Although it's conceptually nice for the io_pgtable_cfg to provide a
>> standard VMSA TCR value, the reality is that no VMSA-compliant IOMMU
>> looks exactly like an Arm CPU, and they all have various other TCR
>> controls which io-pgtable can't be expected to understand. Thus since
>> there is an expectation that drivers will have to add to the given TCR
>> value anyway, let's strip it down to just the essentials that are
>> directly relevant to io-pgatble's inner workings - namely the address
>> sizes, walk attributes, and where appropriate, format selection.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/arm-smmu-v3.c        | 7 +------
>>   drivers/iommu/arm-smmu.c           | 1 +
>>   drivers/iommu/arm-smmu.h           | 2 ++
>>   drivers/iommu/io-pgtable-arm-v7s.c | 6 ++----
>>   drivers/iommu/io-pgtable-arm.c     | 4 ----
>>   drivers/iommu/qcom_iommu.c         | 2 +-
>>   6 files changed, 7 insertions(+), 15 deletions(-)
> 
> Hmm, so I'm a bit nervous about this one since I think we really should
> be providing a TCR with EPD1 set if we're only giving you TTBR0. Relying
> on the driver to do this worries me. See my comments on the next patch.

The whole idea is that we already know we can't provide a *complete* TCR 
value (not least because anything above bit 31 is the wild west), thus 
there's really no point in io-pgtable trying to provide anything other 
than the parts it definitely controls. It makes sense to provide this 
partial TCR value "as if" for TTBR0, since that's the most common case, 
but ultimately io-pgatble doesn't know (or need to) which TTBR the 
caller intends to actually use for this table. Even if the caller *is* 
allocating it for TTBR0, io-pgtable doesn't know that they haven't got 
something live in TTBR1 already, so it still wouldn't be in a position 
to make the EPD1 call either way.

Ultimately, it's the IOMMU drivers who decide what they put in which 
TTBR, so it's the IOMMU drivers which have to take responsibility for 
EPD*. Sure you can worry about it, but you can equally worry about them 
them misprogramming the ASID or anything else...

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
