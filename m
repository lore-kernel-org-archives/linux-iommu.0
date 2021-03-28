Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED3FC433DB
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 23:34:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFFE6188B
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 23:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFFE6188B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8EBAF400CD;
	Sun, 28 Mar 2021 23:34:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rU7S4GsDf5kO; Sun, 28 Mar 2021 23:34:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61A3D400D1;
	Sun, 28 Mar 2021 23:34:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4741CC000C;
	Sun, 28 Mar 2021 23:34:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67E8DC000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A6286066E
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgYS7utRQaXQ for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 23:34:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD6C860661
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 23:34:36 +0000 (UTC)
Received: by mail-qt1-x832.google.com with SMTP id i19so8196867qtv.7
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tNDuIurJKv2MqMA4UB9CY1OUJzVsBHPWot7sK8TYg6w=;
 b=DqA6tizyrKnmoIMviQDuYLkBANPFRFcffoyyTYgkbMp05XWdYNrn/Mt8bbIvLyK1oy
 gqv2FPT6fedG+qIi4ykiNv/81Z27lO7CMZidt70A5JcytM4dSBE9OewKlaUR28ZM3eoj
 VNa1X8DM5HEI2B5ur+jJ+2Ntn49gA6rB6bCf2eIwTsTwlIkKA9HpyZj7vuW+Kk+9YXnl
 jRB+zxpnuNRJ9QSWpbiZWR44Oy16TRQLIeaS1nNBu6YIp7u8WicJGJU1WTqFCF1IPlaf
 DzPonDHLrX3wP8LUccPrBQEKR2VFZTK+d01jJjUNCwOYuLdwBUdNjLroRcfqZmnP4aVX
 L54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tNDuIurJKv2MqMA4UB9CY1OUJzVsBHPWot7sK8TYg6w=;
 b=g45kZklOinSQS0Scuzl6zb0tdKMQUgniYtXG93g0PdkTtXupUuDilNVfSWhThpHJBD
 k/DmGtAkoH38jRmiDz42xu6sPurp88ECG4K06FixdG4qGL4aCEvo4usxq27K6H5b69O1
 ir+XBllmdQ5rgNTl8ZIa4Ew3JaE2Zj354H+6PkNXGnTP23jtrirlc60oWXBmLiWOlX8B
 lfbM+/2EFBHlvgT5Wc16gA3uW50x9Eo8CGteHhn4IQLsyeaArQ3EH/rv41sD16Qtoygb
 t2K5LDsWo4Nhc9ZTdZdS9IjgWCQRujAbyt3D0KGxsaqXRNN2ejQSGwCf/l0/SvnWuc8A
 Iqrw==
X-Gm-Message-State: AOAM532ximSxIMVrZ23os4TCtvg9WJjlYy18OqJ6hnLudDJQoYx3bUMO
 vX6Wm/pgdyBi7np8Xvchv20=
X-Google-Smtp-Source: ABdhPJxstrUoBBxCBUfxS1VZCB0g5E9sW8H/zIcXKNt0B0bdws4RkNv2vZ2oYIWngDm84IyXd5m28g==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr19936201qtv.126.1616974475497; 
 Sun, 28 Mar 2021 16:34:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:1370:814d:b259:a10:76ff:fe69:21b6])
 by smtp.gmail.com with ESMTPSA id g2sm10117905qtu.0.2021.03.28.16.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Mar 2021 16:34:35 -0700 (PDT)
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Krishna Reddy <vdumpa@nvidia.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v1 1/2] iommu/tegra-smmu: Defer attachment of display clients
Date: Mon, 29 Mar 2021 02:32:55 +0300
Message-Id: <20210328233256.20494-1-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

All consumer-grade Android and Chromebook devices show a splash screen
on boot and then display is left enabled when kernel is booted. This
behaviour is unacceptable in a case of implicit IOMMU domains to which
devices are attached during kernel boot since devices, like display
controller, may perform DMA at that time. We can work around this problem
by deferring the enable of SMMU translation for a specific devices,
like a display controller, until the first IOMMU mapping is created,
which works good enough in practice because by that time h/w is already
stopped.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 71 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 602aab98c079..af1e4b5adb27 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -60,6 +60,8 @@ struct tegra_smmu_as {
 	dma_addr_t pd_dma;
 	unsigned id;
 	u32 attr;
+	bool display_attached[2];
+	bool attached_devices_need_sync;
 };
 
 static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
@@ -78,6 +80,10 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 	return readl(smmu->regs + offset);
 }
 
+/* all Tegra SoCs use the same group IDs for displays */
+#define SMMU_SWGROUP_DC		1
+#define SMMU_SWGROUP_DCB	2
+
 #define SMMU_CONFIG 0x010
 #define  SMMU_CONFIG_ENABLE (1 << 0)
 
@@ -253,6 +259,20 @@ static inline void smmu_flush(struct tegra_smmu *smmu)
 	smmu_readl(smmu, SMMU_PTB_ASID);
 }
 
+static int smmu_swgroup_to_display_id(unsigned int swgroup)
+{
+	switch (swgroup) {
+	case SMMU_SWGROUP_DC:
+		return 0;
+
+	case SMMU_SWGROUP_DCB:
+		return 1;
+
+	default:
+		return -1;
+	}
+}
+
 static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
 {
 	unsigned long id;
@@ -318,6 +338,9 @@ static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 	as->domain.geometry.aperture_end = 0xffffffff;
 	as->domain.geometry.force_aperture = true;
 
+	/* work around implicit attachment of devices with active DMA */
+	as->attached_devices_need_sync = true;
+
 	return &as->domain;
 }
 
@@ -410,6 +433,31 @@ static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
 	}
 }
 
+static void tegra_smmu_attach_deferred_devices(struct iommu_domain *domain)
+{
+	struct tegra_smmu_as *as = to_smmu_as(domain);
+
+	if (!as->attached_devices_need_sync)
+		return;
+
+	if (as->display_attached[0] || as->display_attached[1]) {
+		struct tegra_smmu *smmu = as->smmu;
+		unsigned int i;
+
+		for (i = 0; i < smmu->soc->num_clients; i++) {
+			const struct tegra_mc_client *client = &smmu->soc->clients[i];
+			const int disp_id = smmu_swgroup_to_display_id(client->swgroup);
+
+			if (disp_id < 0 || !as->display_attached[disp_id])
+				continue;
+
+			tegra_smmu_enable(smmu, client->swgroup, as->id);
+		}
+	}
+
+	as->attached_devices_need_sync = false;
+}
+
 static int tegra_smmu_as_prepare(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as)
 {
@@ -495,10 +543,26 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 		return -ENOENT;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
+		const unsigned int swgroup = fwspec->ids[index];
+		const int disp_id = smmu_swgroup_to_display_id(swgroup);
+
 		err = tegra_smmu_as_prepare(smmu, as);
 		if (err)
 			goto disable;
 
+		if (disp_id >= 0) {
+			as->display_attached[disp_id] = true;
+
+			/*
+			 * In most cases display is performing DMA before
+			 * driver is initialized by showing a splash screen
+			 * and in this case we should defer the h/w attachment
+			 * until the first mapping is created by display driver.
+			 */
+			if (as->attached_devices_need_sync)
+				continue;
+		}
+
 		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
 	}
 
@@ -527,6 +591,12 @@ static void tegra_smmu_detach_dev(struct iommu_domain *domain, struct device *de
 		return;
 
 	for (index = 0; index < fwspec->num_ids; index++) {
+		const unsigned int swgroup = fwspec->ids[index];
+		const int disp_id = smmu_swgroup_to_display_id(swgroup);
+
+		if (disp_id >= 0)
+			as->display_attached[disp_id] = false;
+
 		tegra_smmu_disable(smmu, fwspec->ids[index], as->id);
 		tegra_smmu_as_unprepare(smmu, as);
 	}
@@ -762,6 +832,7 @@ static int tegra_smmu_map(struct iommu_domain *domain, unsigned long iova,
 	int ret;
 
 	spin_lock_irqsave(&as->lock, flags);
+	tegra_smmu_attach_deferred_devices(domain);
 	ret = __tegra_smmu_map(domain, iova, paddr, size, prot, gfp, &flags);
 	spin_unlock_irqrestore(&as->lock, flags);
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
