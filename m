Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9DDC56202
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 11:39:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34F022254
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 11:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34F022254
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7026E2DEC9;
	Fri, 20 Nov 2020 11:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dpfPUCxWu6tS; Fri, 20 Nov 2020 11:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 71B14203E1;
	Fri, 20 Nov 2020 11:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43A1EC1825;
	Fri, 20 Nov 2020 11:39:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9D7C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 11:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 215A7870A9
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 11:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DXiA1YKKV-xJ for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 11:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 776EF86ABD
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [2.26.170.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D418B22253;
 Fri, 20 Nov 2020 11:39:35 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, ardb@kernel.org,
 hch@lst.de
Subject: Re: [PATCH v7 0/7] arm64: Default to 32-bit wide ZONE_DMA
Date: Fri, 20 Nov 2020 11:39:34 +0000
Message-Id: <160587230018.19468.15360551479275381470.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201119175400.9995-1-nsaenzjulienne@suse.de>
References: <20201119175400.9995-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>, jeremy.linton@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
 linux-riscv@lists.infradead.org, robin.murphy@arm.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 19 Nov 2020 18:53:52 +0100, Nicolas Saenz Julienne wrote:
> Using two distinct DMA zones turned out to be problematic. Here's an
> attempt go back to a saner default.
> 
> I tested this on both a RPi4 and QEMU.

Applied to arm64 (for-next/zone-dma-default-32-bit), thanks!

[1/7] arm64: mm: Move reserve_crashkernel() into mem_init()
      https://git.kernel.org/arm64/c/0a30c53573b0
[2/7] arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
      https://git.kernel.org/arm64/c/9804f8c69b04
[3/7] of/address: Introduce of_dma_get_max_cpu_address()
      https://git.kernel.org/arm64/c/964db79d6c18
[4/7] of: unittest: Add test for of_dma_get_max_cpu_address()
      https://git.kernel.org/arm64/c/07d13a1d6120
[5/7] arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
      https://git.kernel.org/arm64/c/8424ecdde7df
[6/7] arm64: mm: Set ZONE_DMA size based on early IORT scan
      https://git.kernel.org/arm64/c/2b8652936f0c
[7/7] mm: Remove examples from enum zone_type comment
      https://git.kernel.org/arm64/c/04435217f968

-- 
Catalin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
