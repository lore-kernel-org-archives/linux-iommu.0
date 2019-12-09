Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31AEC43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843092077B
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fa4RXbBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843092077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 75B6121517;
	Mon,  9 Dec 2019 15:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjiRrZD1sixv; Mon,  9 Dec 2019 15:08:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 93FFB2154C;
	Mon,  9 Dec 2019 15:08:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 822F2C1796;
	Mon,  9 Dec 2019 15:08:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF022C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DBB8085250
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aDWXeyLhnLmu for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 15:08:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D039B84E5D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 15:08:02 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id z3so16616194wru.3
 for <iommu@lists.linux-foundation.org>; Mon, 09 Dec 2019 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+0yDUeTD5IG+4BWjUfB/nA7nMy0gk8KKKoJnAfbpkus=;
 b=Fa4RXbBA/dzpqqE7Q2X1QZuaSda6lHr6K3iDmfK3kVD1hPE1flW+yfRP6fTlCIvJEM
 XlmirpMaq5nBLXSu3u+vIYsNQJqTBfBQpXqCNUh+rYc3vB7qpW7vg8wPYsj2IKTRzwpc
 FtcfCQmvngK/+/S3tzwzPc2MASbMSUBymnTKJlsd6QdarWt2+hKre5ydqf1RrCzN6Bfg
 IL332IaEYIPG0GyOiudYoCRLdvoi0IWlEwCjVz2floFlYMPOCvnHvVlsBpgYx5Xmw7mq
 n0LLxMNEAQ73L0w1detei3RljY3E5WC3P/RVM27wm013ooIEcsbhAwxwPQabqKHEPU+8
 D/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+0yDUeTD5IG+4BWjUfB/nA7nMy0gk8KKKoJnAfbpkus=;
 b=B5EImJgYBU0IYDgU2v3Gu/xZDw9rIG38l25E9lY5Q811OKC5SVzhGnPmYhjyxeeHNh
 Q7g5yF4rHesrWA/yAV+4aQdf7LHYEhUHK0S/kDPUdB1IILjMonmWCLxoskcELpb93FHx
 JDTcrsV4giocWX1N7XL/3puHcf87fz8bBvEKEg1kauaLNVq6Ffmdxz5k7xslABFsxuKR
 XKZu7/Np7d6X48qBJtTvlMJuDY134AuiVBXrkgrJC6CSvikCjehVBRgrEJ+w9SEW5O3e
 nPrQnCjbK6VbwcUQ5PBdyS8XLJKj9YnHu841nhAnl2lmvy+zUnQ04SBhW+OMCGzVhj4a
 pU1g==
X-Gm-Message-State: APjAAAU/vA97SrSt5rzFJQ+HfWZ12qSCKq0d9E2SfgBSTRiaTCIiZgUY
 TM0MqbuVb04gfc9rzweEdmk=
X-Google-Smtp-Source: APXvYqzKYBI5tUvQ+voqNbricq/0CHkIRnXizQUPgmkqDJFCfbRD3puqfAuoDUQ9fm7svXx3n/8XSA==
X-Received: by 2002:a5d:4392:: with SMTP id i18mr2794732wrq.199.1575904081099; 
 Mon, 09 Dec 2019 07:08:01 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
 by smtp.gmail.com with ESMTPSA id z189sm80287wmc.2.2019.12.09.07.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2019 07:08:00 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RFC 2/2] iommu: arm-smmu: Add support for early direct mappings
Date: Mon,  9 Dec 2019 16:07:48 +0100
Message-Id: <20191209150748.2471814-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191209150748.2471814-1-thierry.reding@gmail.com>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
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

From: Thierry Reding <treding@nvidia.com>

On platforms, the firmware will setup hardware to read from a given
region of memory. One such example is a display controller that is
scanning out a splash screen from physical memory.

During Linux's boot process, the ARM SMMU will configure all contexts to
fault by default. This means that memory accesses that happen by an SMMU
master before its driver has had a chance to properly set up the IOMMU
will cause a fault. This is especially annoying for something like the
display controller scanning out a splash screen because the faults will
result in the display controller getting bogus data (all-ones on Tegra)
and since it repeatedly scans that framebuffer, it will keep triggering
such faults and spam the boot log with them.

In order to work around such problems, scan the device tree for IOMMU
masters and set up a special identity domain that will map 1:1 all of
the reserved regions associated with them. This happens before the SMMU
is enabled, so that the mappings are already set up before translations
begin.

TODO: remove identity domain when no longer in use

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/arm-smmu.c | 171 ++++++++++++++++++++++++++++++++++++++-
 drivers/iommu/arm-smmu.h |   2 +
 2 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 5c5cf942077e..fe0c0975d4e2 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1887,6 +1887,171 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+static int arm_smmu_identity_map_regions(struct arm_smmu_device *smmu,
+					 struct device_node *np)
+{
+	struct device *dev = smmu->dev;
+	struct of_phandle_iterator it;
+	unsigned long page_size;
+	unsigned int count = 0;
+	int ret;
+
+	page_size = 1UL << __ffs(smmu->identity->pgsize_bitmap);
+
+	/* parse memory regions and add them to the identity mapping */
+	of_for_each_phandle(&it, ret, np, "memory-region", NULL, 0) {
+		int prot = IOMMU_READ | IOMMU_WRITE;
+		dma_addr_t start, limit, iova;
+		struct resource res;
+
+		ret = of_address_to_resource(it.node, 0, &res);
+		if (ret < 0) {
+			dev_err(dev, "failed to parse memory region %pOF: %d\n",
+				it.node, ret);
+			continue;
+		}
+
+		/* check that region is not empty */
+		if (resource_size(&res) == 0) {
+			dev_dbg(dev, "skipping empty memory region %pOF\n",
+				it.node);
+			continue;
+		}
+
+		start = ALIGN(res.start, page_size);
+		limit = ALIGN(res.start + resource_size(&res), page_size);
+
+		for (iova = start; iova < limit; iova += page_size) {
+			phys_addr_t phys;
+
+			/* check that this IOVA isn't already mapped */
+			phys = iommu_iova_to_phys(smmu->identity, iova);
+			if (phys)
+				continue;
+
+			ret = iommu_map(smmu->identity, iova, iova, page_size,
+					prot);
+			if (ret < 0) {
+				dev_err(dev, "failed to map %pad for %pOF: %d\n",
+					&iova, it.node, ret);
+				continue;
+			}
+		}
+
+		dev_dbg(dev, "identity mapped memory region %pR\n", &res);
+		count++;
+	}
+
+	return count;
+}
+
+static int arm_smmu_identity_add_master(struct arm_smmu_device *smmu,
+					struct of_phandle_args *args)
+{
+	struct arm_smmu_domain *identity = to_smmu_domain(smmu->identity);
+	struct arm_smmu_smr *smrs = smmu->smrs;
+	struct device *dev = smmu->dev;
+	unsigned int index;
+	u16 sid, mask;
+	u32 fwid;
+	int ret;
+
+	/* skip masters that aren't ours */
+	if (args->np != dev->of_node)
+		return 0;
+
+	fwid = arm_smmu_of_parse(args->np, args->args, args->args_count);
+	sid = FIELD_GET(SMR_ID, fwid);
+	mask = FIELD_GET(SMR_MASK, fwid);
+
+	ret = arm_smmu_find_sme(smmu, sid, mask);
+	if (ret < 0) {
+		dev_err(dev, "failed to find SME: %d\n", ret);
+		return ret;
+	}
+
+	index = ret;
+
+	if (smrs && smmu->s2crs[index].count == 0) {
+		smrs[index].id = sid;
+		smrs[index].mask = mask;
+		smrs[index].valid = true;
+	}
+
+	smmu->s2crs[index].type = S2CR_TYPE_TRANS;
+	smmu->s2crs[index].privcfg = S2CR_PRIVCFG_DEFAULT;
+	smmu->s2crs[index].cbndx = identity->cfg.cbndx;
+	smmu->s2crs[index].count++;
+
+	return 0;
+}
+
+static int arm_smmu_identity_add_device(struct arm_smmu_device *smmu,
+					struct device_node *np)
+{
+	struct of_phandle_args args;
+	unsigned int index = 0;
+	int ret;
+
+	/* add stream IDs to the identity mapping */
+	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
+					   index, &args)) {
+		ret = arm_smmu_identity_add_master(smmu, &args);
+		if (ret < 0)
+			return ret;
+
+		index++;
+	}
+
+	return 0;
+}
+
+static int arm_smmu_setup_identity(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_domain *identity;
+	struct device *dev = smmu->dev;
+	struct device_node *np;
+	int ret;
+
+	/* create early identity mapping */
+	smmu->identity = arm_smmu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
+	if (!smmu->identity) {
+		dev_err(dev, "failed to create identity domain\n");
+		return -ENOMEM;
+	}
+
+	smmu->identity->pgsize_bitmap = smmu->pgsize_bitmap;
+	smmu->identity->type = IOMMU_DOMAIN_UNMANAGED;
+	smmu->identity->ops = &arm_smmu_ops;
+
+	ret = arm_smmu_init_domain_context(smmu->identity, smmu);
+	if (ret < 0) {
+		dev_err(dev, "failed to initialize identity domain: %d\n", ret);
+		return ret;
+	}
+
+	identity = to_smmu_domain(smmu->identity);
+
+	for_each_node_with_property(np, "iommus") {
+		ret = arm_smmu_identity_map_regions(smmu, np);
+		if (ret < 0)
+			continue;
+
+		/*
+		 * Do not add devices to the early identity mapping if they
+		 * do not define any memory-regions.
+		 */
+		if (ret == 0)
+			continue;
+
+		ret = arm_smmu_identity_add_device(smmu, np);
+		if (ret < 0)
+			continue;
+	}
+
+	return 0;
+}
+
 struct arm_smmu_match_data {
 	enum arm_smmu_arch_version version;
 	enum arm_smmu_implementation model;
@@ -2127,6 +2292,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = arm_smmu_setup_identity(smmu);
+	if (err)
+		return err;
+
 	if (smmu->version == ARM_SMMU_V2) {
 		if (smmu->num_context_banks > smmu->num_context_irqs) {
 			dev_err(dev,
@@ -2169,8 +2338,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, smmu);
-	arm_smmu_device_reset(smmu);
 	arm_smmu_test_smr_masks(smmu);
+	arm_smmu_device_reset(smmu);
 
 	/*
 	 * We want to avoid touching dev->power.lock in fastpaths unless
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 6b6b877135de..001e60a3d18c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -280,6 +280,8 @@ struct arm_smmu_device {
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
+
+	struct iommu_domain		*identity;
 };
 
 enum arm_smmu_context_fmt {
-- 
2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
