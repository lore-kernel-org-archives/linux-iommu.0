Return-Path: <SRS0=L2Qy=CE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25DFC433E1
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 13:54:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB0622B4E
	for <iommu@archiver.kernel.org>; Wed, 26 Aug 2020 13:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy5vfyAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB0622B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5DFDB87B36;
	Wed, 26 Aug 2020 13:54:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "To"
	occurs 3 times
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obH4Hr5Ld8Uf; Wed, 26 Aug 2020 13:54:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C32A187A43;
	Wed, 26 Aug 2020 13:54:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADFB7C07FF;
	Wed, 26 Aug 2020 13:54:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C264BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 13:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B3E832045C
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 13:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Header field occurs more than once: "To"
 occurs 3 times
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYZpsl1yRrUq for <iommu@lists.linux-foundation.org>;
 Wed, 26 Aug 2020 13:54:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 122F720427
 for <iommu@lists.linux-foundation.org>; Wed, 26 Aug 2020 13:54:05 +0000 (UTC)
Received: from localhost (unknown [70.37.104.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7215208E4;
 Wed, 26 Aug 2020 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598450044;
 bh=gDOILFHQ8erfZ+RKeyL/QbShSWOKn3N680xVgmW8MQs=;
 h=Date:From:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
 b=Qy5vfyAY1vq9SfSmsWuWYKZuRD5kzrN7XOV3/P6ZMmr1dj2lY9CxDRRLyWZwWmven
 dh2dhoDxY2eA31OcW+HQbomtQjvLWn01YyY0JEcpU36i+c/9xQiQ2qtRGhK4vncm8z
 99w1OfuvS6p8RssolthXYD6xbNZqkwkcU2uDPcUI=
Date: Wed, 26 Aug 2020 13:54:04 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND v3] iommu/tegra-smmu: Add missing locks around
 mapping operations
In-Reply-To: <20200814162252.31965-1-digetx@gmail.com>
References: <20200814162252.31965-1-digetx@gmail.com>
Message-Id: <20200826135404.A7215208E4@mail.kernel.org>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 stable@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.8.2, v5.7.16, v5.4.59, v4.19.140, v4.14.193, v4.9.232, v4.4.232.

v5.8.2: Build OK!
v5.7.16: Build OK!
v5.4.59: Failed to apply! Possible dependencies:
    781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")

v4.19.140: Failed to apply! Possible dependencies:
    06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
    44f6876a00e8 ("iommu/arm-smmu: Support non-strict mode")
    46053c736854 ("dma-mapping: clear dev->dma_ops in arch_teardown_dma_ops")
    781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
    886643b76632 ("arm64: use the generic swiotlb_dma_ops")
    92aec09cc879 ("iommu/dma: Move __iommu_dma_map")
    96a299d24cfb ("iommu/arm-smmu: Add pm_runtime/sleep ops")
    c4dae366925f ("swiotlb: refactor swiotlb_map_page")
    d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
    dff8d6c1ed58 ("swiotlb: remove the overflow buffer")
    fafadcd16595 ("swiotlb: don't dip into swiotlb pool for coherent allocations")

v4.14.193: Failed to apply! Possible dependencies:
    06d60728ff5c ("iommu/dma: move the arm64 wrappers to common code")
    10dac04c79b1 ("mips: fix an off-by-one in dma_capable")
    32b124492bdf ("iommu/io-pgtable-arm: Convert to IOMMU API TLB sync")
    32ce3862af3c ("powerpc/lib: Implement PMEM API")
    44f6876a00e8 ("iommu/arm-smmu: Support non-strict mode")
    781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
    92aec09cc879 ("iommu/dma: Move __iommu_dma_map")
    96a299d24cfb ("iommu/arm-smmu: Add pm_runtime/sleep ops")
    d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")
    ea8c64ace866 ("dma-mapping: move swiotlb arch helpers to a new header")

v4.9.232: Failed to apply! Possible dependencies:
    125458ab3aef ("iommu/arm-smmu: Fix 16-bit ASID configuration")
    280b683ceace ("iommu/arm-smmu: Simplify ASID/VMID handling")
    32b124492bdf ("iommu/io-pgtable-arm: Convert to IOMMU API TLB sync")
    3677a649a751 ("iommu/arm-smmu: Fix for ThunderX erratum #27704")
    44f6876a00e8 ("iommu/arm-smmu: Support non-strict mode")
    452107c79035 ("iommu/arm-smmu: Tidy up context bank indexing")
    523d7423e21b ("iommu/arm-smmu: Remove io-pgtable spinlock")
    58188afeb727 ("iommu/arm-smmu-v3: Remove io-pgtable spinlock")
    61bc671179f1 ("iommu/arm-smmu: Install bypass S2CRs for IOMMU_DOMAIN_IDENTITY domains")
    781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
    bdf95923086f ("iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU is bypassed")
    d4a44f0750bb ("iommu/arm-smmu: Invoke pm_runtime across the driver")

v4.4.232: Failed to apply! Possible dependencies:
    267b62a96951 ("clk: tegra: pll: Update PLLM handling")
    287980e49ffc ("remove lots of IS_ERR_VALUE abuses")
    407254da291c ("clk: tegra: pll: Add logic for out-of-table rates for T210")
    56fd27b31f1a ("clk: tegra: pll: Change misc_reg count from 3 to 6")
    58188afeb727 ("iommu/arm-smmu-v3: Remove io-pgtable spinlock")
    6583a6309e83 ("clk: tegra: pll: Add tegra_pll_wait_for_lock to clk header")
    6929715cf6b9 ("clk: tegra: pll: Add support for PLLMB for Tegra210")
    6b301a059eb2 ("clk: tegra: Add support for Tegra210 clocks")
    781ca2de89ba ("iommu: Add gfp parameter to iommu_ops::map")
    7db864c9deb2 ("clk: tegra: pll: Simplify clk_enable_path")
    8cfb0cdf07e2 ("ACPI / debugger: Add IO interface to access debugger functionalities")
    8f78515425da ("iommu/arm-smmu: Implement of_xlate() for SMMUv3")
    9adb95949a34 ("iommu/arm-smmu: Support DMA-API domains")
    bc7f2ce0a7b5 ("iommu/arm-smmu: Don't fail device attach if already attached to a domain")
    bdf95923086f ("iommu/arm-smmu: Return IOVA in iova_to_phys when SMMU is bypassed")
    d907f4b4a178 ("clk: tegra: pll: Add logic for handling SDM data")
    f8d31489629c ("ACPICA: Debugger: Convert some mechanisms to OSPM specific")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
