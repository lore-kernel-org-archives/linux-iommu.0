Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BECC433E3
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1609A2078D
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuQRr8H0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1609A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 064042156C;
	Mon, 24 Aug 2020 18:42:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ERJJUbaPnSX; Mon, 24 Aug 2020 18:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9103C2156B;
	Mon, 24 Aug 2020 18:42:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF46C016F;
	Mon, 24 Aug 2020 18:42:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E438BC0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D21E48804A
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6To55fv2N0w1 for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:42:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6CFE987CB2
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:42:22 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id x25so5309113pff.4
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kSk9Ml31XbJOG2f57h64F+Z+u/H7LjegKljJVlxq3/o=;
 b=PuQRr8H0J0Wm/JwS7TDm/n1aaDYpCp+u0Xhtd6ySCS+jIDk3G8tZ+NTj4I9yJl9Xi0
 ESlNd1bOyyh7orw4FugAlt6b+4E1XyjwB3dT9M21/hTZnBuqymaPtGRryP6vooFDmeCg
 WBeYpuFK/VhIFBz/ID3oiWyAmocmTWpc71sVReALesHl5XDdOuMmx5BRB2l0jgjEdjjL
 7NTUSfmUhr5gmrltKw5aeVI4wrDhmcyD8K51sVTFDE2s9RgvK0yi5wbt0jyc43vGwnz6
 llUJuwX98+NWd8VFREqSV3FObuRD5JQgg65Tdc9SiDaD++ha9SxdK+F2yxcFANSDRVgN
 6ErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kSk9Ml31XbJOG2f57h64F+Z+u/H7LjegKljJVlxq3/o=;
 b=KHtazmuV5fe4bdhwRwhR3eja8esdWU6M1/Vd6tO7zpdtjaVayTnJdtmS41HEsTkj0r
 OST2KLNHsGf+vmgvwqs6j89oq9sOdtW/VaJh4BpV4Eaq/IlMAMTDA0zmZCXm2mtde9T4
 J5x2zJcDwVRuX7Hd2jQ0vYn8r3oFM1xdSBgNXMZWgcBogI2B4o9l5YrjibPoyPqxD8hU
 k2I4zUPiSHOs4PhkQTPVr9t2t4PkApSC4WR4kstPfxlxXXLPyiw+7JJZg2uhjEgmawTO
 VpKGR3YkQUil+M/18vQIDxAxKc0E36COYpbWqpBM647NEWDsnr1lnwTtMnm5zVD4pTsc
 wDlQ==
X-Gm-Message-State: AOAM531qkNjTXfgdHXuxLkP0SgNsUDeq4lYERHb2V7ZZUcFPpiL5r5ee
 LAJasfP4a+Jm/p2kfoTHhDU=
X-Google-Smtp-Source: ABdhPJypoRetU1pm/hYk35duEuEDV/9I1qEX2ndUelby0c1VRDwOv61H6tDsCuRdB0ISZKdafjLiDQ==
X-Received: by 2002:a17:902:7792:: with SMTP id
 o18mr4697906pll.150.1598294542026; 
 Mon, 24 Aug 2020 11:42:22 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
 by smtp.gmail.com with ESMTPSA id p12sm11985571pff.110.2020.08.24.11.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:42:20 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH 08/20] iommu/arm-smmu: constify some helpers
Date: Mon, 24 Aug 2020 11:37:42 -0700
Message-Id: <20200824183825.1778810-9-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824183825.1778810-1-robdclark@gmail.com>
References: <20200824183825.1778810-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Akhil P Oommen <akhilpo@codeaurora.org>, Eric Anholt <eric@anholt.net>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Sibi Sankar <sibis@codeaurora.org>,
 Brian Masney <masneyb@onstation.org>, Joerg Roedel <jroedel@suse.de>,
 Stephen Boyd <swboyd@chromium.org>, John Stultz <john.stultz@linaro.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 freedreno@lists.freedesktop.org, open list <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Rob Clark <robdclark@chromium.org>

Sprinkle a few `const`s where helpers don't need write access.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 59ff3fc5c6c8..27c83333fc50 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -377,7 +377,7 @@ struct arm_smmu_master_cfg {
 	s16				smendx[];
 };
 
-static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
+static inline u32 arm_smmu_lpae_tcr(const struct io_pgtable_cfg *cfg)
 {
 	u32 tcr = FIELD_PREP(ARM_SMMU_TCR_TG0, cfg->arm_lpae_s1_cfg.tcr.tg) |
 		FIELD_PREP(ARM_SMMU_TCR_SH0, cfg->arm_lpae_s1_cfg.tcr.sh) |
@@ -398,13 +398,13 @@ static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
 	return tcr;
 }
 
-static inline u32 arm_smmu_lpae_tcr2(struct io_pgtable_cfg *cfg)
+static inline u32 arm_smmu_lpae_tcr2(const struct io_pgtable_cfg *cfg)
 {
 	return FIELD_PREP(ARM_SMMU_TCR2_PASIZE, cfg->arm_lpae_s1_cfg.tcr.ips) |
 	       FIELD_PREP(ARM_SMMU_TCR2_SEP, ARM_SMMU_TCR2_SEP_UPSTREAM);
 }
 
-static inline u32 arm_smmu_lpae_vtcr(struct io_pgtable_cfg *cfg)
+static inline u32 arm_smmu_lpae_vtcr(const struct io_pgtable_cfg *cfg)
 {
 	return ARM_SMMU_VTCR_RES1 |
 	       FIELD_PREP(ARM_SMMU_VTCR_PS, cfg->arm_lpae_s2_cfg.vtcr.ps) |
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
