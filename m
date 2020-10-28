Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7791BC4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 11:09:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B568246B1
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 11:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B568246B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF6DB87401;
	Wed, 28 Oct 2020 11:09:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fAQnFSTGjD+S; Wed, 28 Oct 2020 11:09:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DAD9C873E9;
	Wed, 28 Oct 2020 11:09:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDD84C088B;
	Wed, 28 Oct 2020 11:09:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33515C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1D590863A6
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NlFLV6ysm9uz for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 11:09:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5A374862E6
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:09:01 +0000 (UTC)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CLm6P095sz6yKv;
 Wed, 28 Oct 2020 19:09:01 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 19:08:54 +0800
Subject: Re: [PATCH v4 6/7] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, <robh+dt@kernel.org>,
 <catalin.marinas@arm.com>, <hch@lst.de>, <ardb@kernel.org>,
 <linux-kernel@vger.kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-7-nsaenzjulienne@suse.de>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3a1480f7-7fd6-247c-73a2-f761f9ce3362@huawei.com>
Date: Wed, 28 Oct 2020 19:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021123437.21538-7-nsaenzjulienne@suse.de>
Content-Language: en-GB
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Cc: devicetree@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 will@kernel.org, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, jeremy.linton@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 Len Brown <lenb@kernel.org>
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

On 2020/10/21 20:34, Nicolas Saenz Julienne wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> incorporating masters that can address less than 32 bits of DMA, in
> particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> peripherals that can only address up to 1 GB (and its PCIe host
> bridge can only access the bottom 3 GB)
> 
> Instructing the DMA layer about these limitations is straight-forward,
> even though we had to fix some issues regarding memory limits set in
> the IORT for named components, and regarding the handling of ACPI _DMA
> methods. However, the DMA layer also needs to be able to allocate
> memory that is guaranteed to meet those DMA constraints, for bounce
> buffering as well as allocating the backing for consistent mappings.
> 
> This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> problems with kdump, and potentially in other places where allocations
> cannot cross zone boundaries. Therefore, we should avoid having two
> separate DMA zones when possible.
> 
> So let's do an early scan of the IORT, and only create the ZONE_DMA
> if we encounter any devices that need it. This puts the burden on
> the firmware to describe such limitations in the IORT, which may be
> redundant (and less precise) if _DMA methods are also being provided.
> However, it should be noted that this situation is highly unusual for
> arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> the _DMA method if implemented, and so we will not lose the ability to
> perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> it.
> 
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [nsaenz: Rebased, removed documentation change and add declaration in acpi_iort.h]
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v3:
>   - Use min_not_zero()
>   - Check ACPI revision
>   - Remove unnecessary #ifdef in zone_sizes_init()
> 
>   arch/arm64/mm/init.c      |  3 ++-
>   drivers/acpi/arm64/iort.c | 52 +++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi_iort.h |  4 +++

Acked-by: Hanjun Guo <guohanjun@huawei.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
