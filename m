Return-Path: <SRS0=xWGd=D6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E59BC388F9
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 19:05:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935C120BED
	for <iommu@archiver.kernel.org>; Fri, 23 Oct 2020 19:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935C120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 208002153D;
	Fri, 23 Oct 2020 19:05:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hqbl-WVJPTAG; Fri, 23 Oct 2020 19:05:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 76A9F2153E;
	Fri, 23 Oct 2020 19:05:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59BC8C088B;
	Fri, 23 Oct 2020 19:05:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE2C6C0051
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 19:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D36E8875DC
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 19:05:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PI+mImNGh2Fy for <iommu@lists.linux-foundation.org>;
 Fri, 23 Oct 2020 19:05:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id BDDAE875B5
 for <iommu@lists.linux-foundation.org>; Fri, 23 Oct 2020 19:05:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07FFE101E;
 Fri, 23 Oct 2020 12:05:51 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABDA3F66E;
 Fri, 23 Oct 2020 12:05:50 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] arm64: Default to 32-bit wide ZONE_DMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, robh+dt@kernel.org,
 catalin.marinas@arm.com, hch@lst.de, ardb@kernel.org,
 linux-kernel@vger.kernel.org
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9bccc5ef-9457-044b-7193-d002a395e461@arm.com>
Date: Fri, 23 Oct 2020 14:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021123437.21538-1-nsaenzjulienne@suse.de>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org, robin.murphy@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 linux-riscv@lists.infradead.org, will@kernel.org,
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

Hi,

On 10/21/20 7:34 AM, Nicolas Saenz Julienne wrote:
> Using two distinct DMA zones turned out to be problematic. Here's an
> attempt go back to a saner default.
> 
> I tested this on both a RPi4 and QEMU.

I've tested this in ACPI mode on the rpi4 (4+8G with/without the 3G 
limiter) as well, with Ard's IORT patch. Nothing seems to have regressed.

Thanks,

Tested-by: Jeremy Linton <jeremy.linton@arm.com>




> 
> ---
> 
> Changes since v3:
>   - Drop patch adding define in dma-mapping
>   - Address small review changes
>   - Update Ard's patch
>   - Add new patch removing examples from mmzone.h
> 
> Changes since v2:
>   - Introduce Ard's patch
>   - Improve OF dma-ranges parsing function
>   - Add unit test for OF function
>   - Address small changes
>   - Move crashkernel reservation later in boot process
> 
> Changes since v1:
>   - Parse dma-ranges instead of using machine compatible string
> 
> Ard Biesheuvel (1):
>    arm64: mm: Set ZONE_DMA size based on early IORT scan
> 
> Nicolas Saenz Julienne (6):
>    arm64: mm: Move reserve_crashkernel() into mem_init()
>    arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
>    of/address: Introduce of_dma_get_max_cpu_address()
>    of: unittest: Add test for of_dma_get_max_cpu_address()
>    arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
>    mm: Remove examples from enum zone_type comment
> 
>   arch/arm64/mm/init.c      | 16 ++++++------
>   drivers/acpi/arm64/iort.c | 52 +++++++++++++++++++++++++++++++++++++++
>   drivers/of/address.c      | 42 +++++++++++++++++++++++++++++++
>   drivers/of/unittest.c     | 18 ++++++++++++++
>   include/linux/acpi_iort.h |  4 +++
>   include/linux/mmzone.h    | 20 ---------------
>   include/linux/of.h        |  7 ++++++
>   7 files changed, 130 insertions(+), 29 deletions(-)
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
