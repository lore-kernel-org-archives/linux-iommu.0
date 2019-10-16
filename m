Return-Path: <SRS0=NqTC=YJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C276FA372A
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 11:50:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E62BF20854
	for <iommu@archiver.kernel.org>; Wed, 16 Oct 2019 11:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsFUbu3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62BF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 13A21D38;
	Wed, 16 Oct 2019 11:50:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4C325D2E
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 11:50:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C0C9B887
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 11:50:32 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id m18so2437614wmc.1
	for <iommu@lists.linux-foundation.org>;
	Wed, 16 Oct 2019 04:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=KxMKHYwy35NNoeyYDHpxCJLWi0KbH8LhZBAxPloA92g=;
	b=OsFUbu3suqoYDFuGTEzUavtATxC8zNR4L+kz9eKi26eAFXbGqTtNxSvf4Q4FRrf+yO
	PDJcYMY0+Xk693/MAziYz0CmpU8ZyD+c7MoIPmibbY1DZIXkxk8aCVLBzPCqBxy64yEl
	dAK+lCRIi1AIiiNN4WdbvlZ23wHUp1c9CFJDoI/cgb+hDh7j459FKLvKbn+fwbrE7yg4
	7q1ovTiu7R7P0h+XbK0Mt+F7PAihKlQk+tAxzmN2JDwUwHV/0U/ARYCfacmemST85nPn
	JRaYj+loR68HiBwhsqnS5MeoG/bJ9VvZrcY3ItfgaMjvDgE65VXow+WcKKf+0WsDPLQm
	gXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=KxMKHYwy35NNoeyYDHpxCJLWi0KbH8LhZBAxPloA92g=;
	b=R0u8ektAGp968fH7Jz/9DElgT7v/u6qXcHvOfs/etId/FQl32TG1yNaSKiF+rWKdLM
	zWlT+vemqGm/WR5uGYPK49tFD30BmYjLFyUnqrv6ptVmQFS92fOySojL/4YsFoSl3ln/
	guM4A85dmSSkkbYMdUN1EhqKzbhPTOUB0X3sokqpRRD1OgkOJPMxkzsM7TILQ7QTioMz
	1CEoDASlavpULNsaSWBZA15NdgtJ/8Q/drT2AgfGMLs2cRyswVxjJX0uOos1imJeHG95
	E21ZCp0C417ccLs1Wvqewfgc7joZJAjt/FSq3lTlBAPrcZllCuZfgQqH9FoI3AghJOy4
	h0ow==
X-Gm-Message-State: APjAAAXipFB5PRD65WcplsWMFwBqyFwsi1VWlvJi7Ga12AX03jSNtI4N
	uENXhmZ/0H2HvlNA7s+4lEI=
X-Google-Smtp-Source: APXvYqyYpKxhBiddMFkqlwoqXwAOqQLv7ut1wSH5oGmFDVdWwDuqiL1WO7pERb65z/XmMOT5r0EU2A==
X-Received: by 2002:a1c:1dcb:: with SMTP id d194mr3305915wmd.75.1571226631215; 
	Wed, 16 Oct 2019 04:50:31 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
	by smtp.gmail.com with ESMTPSA id
	r7sm23662073wrt.28.2019.10.16.04.50.29
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 16 Oct 2019 04:50:30 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/tegra-smmu: Fix client enablement order
Date: Wed, 16 Oct 2019 13:50:25 +0200
Message-Id: <20191016115026.1768745-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016115026.1768745-1-thierry.reding@gmail.com>
References: <20191016115026.1768745-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
	iommu@lists.linux-foundation.org, Jon Hunter <jonathanh@nvidia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Navneet Kumar <navneetk@nvidia.com>

Enable clients' translation only after setting up the swgroups.

Signed-off-by: Navneet Kumar <navneetk@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-smmu.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 03e667480ec6..9425d01a95ac 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -351,6 +351,20 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 	unsigned int i;
 	u32 value;
 
+	group = tegra_smmu_find_swgroup(smmu, swgroup);
+	if (group) {
+		value = smmu_readl(smmu, group->reg);
+		value &= ~SMMU_ASID_MASK;
+		value |= SMMU_ASID_VALUE(asid);
+		value |= SMMU_ASID_ENABLE;
+		smmu_writel(smmu, value, group->reg);
+	} else {
+		pr_warn("%s group from swgroup %u not found\n", __func__,
+				swgroup);
+		/* No point moving ahead if group was not found */
+		return;
+	}
+
 	for (i = 0; i < smmu->soc->num_clients; i++) {
 		const struct tegra_mc_client *client = &smmu->soc->clients[i];
 
@@ -361,15 +375,6 @@ static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
 		value |= BIT(client->smmu.bit);
 		smmu_writel(smmu, value, client->smmu.reg);
 	}
-
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
-	if (group) {
-		value = smmu_readl(smmu, group->reg);
-		value &= ~SMMU_ASID_MASK;
-		value |= SMMU_ASID_VALUE(asid);
-		value |= SMMU_ASID_ENABLE;
-		smmu_writel(smmu, value, group->reg);
-	}
 }
 
 static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
