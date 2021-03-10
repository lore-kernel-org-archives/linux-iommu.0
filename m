Return-Path: <SRS0=kCyf=II=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36A4C433E0
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 03:39:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669F964F82
	for <iommu@archiver.kernel.org>; Wed, 10 Mar 2021 03:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669F964F82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 258FD43176;
	Wed, 10 Mar 2021 03:39:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qWVVm2ohaJmL; Wed, 10 Mar 2021 03:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9C034315B;
	Wed, 10 Mar 2021 03:39:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB7CAC000B;
	Wed, 10 Mar 2021 03:39:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 953BDC0001
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 03:39:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7649F6F584
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 03:39:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dWnV8V4SViL0 for <iommu@lists.linux-foundation.org>;
 Wed, 10 Mar 2021 03:39:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6D8CC60595
 for <iommu@lists.linux-foundation.org>; Wed, 10 Mar 2021 03:39:02 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id o10so10468627pgg.4
 for <iommu@lists.linux-foundation.org>; Tue, 09 Mar 2021 19:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=mcwREzFVw6W5FK314R1LHVbuIgRDIYcjs41i2ItQ/Q4=;
 b=b8vDFZE6MpAJnLDIwNqoW2kZfIKu933z8gQ4no17zJv+D5HsmqcQowPXImbjQ5Wp7h
 27jnZRsVk+eLjHJDqXBqAxpo1qdZycBZh3aXo26O0sCVJjwb4yC9YFIKxTtuRU0Vsp1n
 +yvYksFt9Gn1VKYfCsUbkNQRZq8C468c/ktwN8gugZp/lHuDF7KipqODYRj3cWY3gCNM
 jHfur1UhOu4iEi4oy6ze5xC+ZPZXxHp2wQ3ScFP0L8Gjdy+PBZUzMM3NBWDbosyw6FQu
 KwuC8WWFTE4z/KSbUnhGbEMFP+ILk36IcFhYUTUS6Ndn3JVHb6miQr9GrWkMB45wBc8g
 b/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mcwREzFVw6W5FK314R1LHVbuIgRDIYcjs41i2ItQ/Q4=;
 b=Q8zhqy2DtCloFj9bKJoKFSTA3eVI/Kg+9aen03kQIVspAq4msyx52lHrlkOeIiOnxO
 JDYQ1TQCthhs4t7EMSqeDibKejVZSdQmKaOmkAa0tdIeLo2HdRL8uIQrF6l+zMnpZKYK
 xy8ZZxubKorDkQoe2FFbQixnMr5FQ4nXqlpoy6FgcsmU5jjL0QjpahJzLsZoyvu66O5y
 hY2+7b12hYtQzU14hmhNEFDu8FZwiSUEI7eKMxmosFI20sjzaaQadnEP0GzExSe1XDe0
 R1YY/r7eFrP2D8inJVtWlFYUWXFGBY0ypjDUf8ti+Cjc1tO+mCEVOZGYkoH/qz6A67Na
 s8Dg==
X-Gm-Message-State: AOAM530JdVp7spa3jUINhqt8yYCuemBRKZOEnWn7vd10//gYjJuU3xNT
 q60O/oFQrfB0JWQqni+u22s=
X-Google-Smtp-Source: ABdhPJxiswUDvvjRGsq/a6vprRcJjYlaidnoD4Yxs4LihTn3R85pX9rxuR+yJECU1MJfRJlmZL/0OQ==
X-Received: by 2002:a63:6642:: with SMTP id a63mr959044pgc.333.1615347541716; 
 Tue, 09 Mar 2021 19:39:01 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id n4sm14071952pgg.68.2021.03.09.19.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 19:39:01 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org,
	thierry.reding@gmail.com,
	will@kernel.org
Subject: [PATCH v2] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date: Tue,  9 Mar 2021 19:36:14 -0800
Message-Id: <20210310033614.16772-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

This patch dumps all active mapping entries from pagetable
to a debugfs directory named "mappings".

Ataching an example:

SWGROUP: hc
ASID: 0
reg: 0x250
PTB_ASID: 0xe0080004
as->pd_dma: 0x80004000
{
        [1023] 0xf0080013 (1)
        {
                PTE RANGE       PHYS           IOVA        SIZE        ATTR
                #1023 - #1023   0x122e5e000    0xfffff000  0x1000      0x5
        }
}
Total PDE count: 1
Total PTE count: 1

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---

Changelog
v2:
 * Expanded mutex range to the entire function
 * Added as->lock to protect pagetable walkthrough
 * Replaced devm_kzalloc with devm_kcalloc for group_debug
 * Added "PTE RANGE" and "SIZE" columns to group contiguous mappings
 * Dropped as->count check; added WARN_ON when as->count mismatches pd[pd_index]
v1: https://lkml.org/lkml/2020/9/26/70

 drivers/iommu/tegra-smmu.c | 172 +++++++++++++++++++++++++++++++++++--
 1 file changed, 167 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 97eb62f667d2..155735f6323f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -19,6 +19,11 @@
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
+struct tegra_smmu_group_debug {
+	const struct tegra_smmu_swgroup *group;
+	void *priv;
+};
+
 struct tegra_smmu_group {
 	struct list_head list;
 	struct tegra_smmu *smmu;
@@ -47,6 +52,8 @@ struct tegra_smmu {
 	struct dentry *debugfs;
 
 	struct iommu_device iommu;	/* IOMMU Core code handle */
+
+	struct tegra_smmu_group_debug *group_debug;
 };
 
 struct tegra_smmu_as {
@@ -152,6 +159,9 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 
 #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
 				 SMMU_PDE_NONSECURE)
+#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
+				 SMMU_PTE_NONSECURE)
+#define SMMU_PTE_ATTR_SHIFT	(29)
 
 static unsigned int iova_pd_index(unsigned long iova)
 {
@@ -163,6 +173,12 @@ static unsigned int iova_pt_index(unsigned long iova)
 	return (iova >> SMMU_PTE_SHIFT) & (SMMU_NUM_PTE - 1);
 }
 
+static unsigned long pd_pt_index_iova(unsigned int pd_index, unsigned int pt_index)
+{
+	return ((dma_addr_t)pd_index & (SMMU_NUM_PDE - 1)) << SMMU_PDE_SHIFT |
+	       ((dma_addr_t)pt_index & (SMMU_NUM_PTE - 1)) << SMMU_PTE_SHIFT;
+}
+
 static bool smmu_dma_addr_valid(struct tegra_smmu *smmu, dma_addr_t addr)
 {
 	addr >>= 12;
@@ -334,7 +350,7 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static const struct tegra_smmu_swgroup *
-tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
+tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup, int *index)
 {
 	const struct tegra_smmu_swgroup *group = NULL;
 	unsigned int i;
@@ -342,6 +358,8 @@ tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
 	for (i = 0; i < smmu->soc->num_swgroups; i++) {
 		if (smmu->soc->swgroups[i].swgroup == swgroup) {
 			group = &smmu->soc->swgroups[i];
+			if (index)
+				*index = i;
 			break;
 		}
 	}
@@ -350,19 +368,22 @@ tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
 }
 
 static void tegra_smmu_enable(struct tegra_smmu *smmu, unsigned int swgroup,
-			      unsigned int asid)
+			      struct tegra_smmu_as *as)
 {
 	const struct tegra_smmu_swgroup *group;
+	unsigned int asid = as->id;
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
+	group = tegra_smmu_find_swgroup(smmu, swgroup, &i);
 	if (group) {
 		value = smmu_readl(smmu, group->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value |= SMMU_ASID_ENABLE;
 		smmu_writel(smmu, value, group->reg);
+		if (smmu->group_debug)
+			smmu->group_debug[i].priv = as;
 	} else {
 		pr_warn("%s group from swgroup %u not found\n", __func__,
 				swgroup);
@@ -389,13 +410,15 @@ static void tegra_smmu_disable(struct tegra_smmu *smmu, unsigned int swgroup,
 	unsigned int i;
 	u32 value;
 
-	group = tegra_smmu_find_swgroup(smmu, swgroup);
+	group = tegra_smmu_find_swgroup(smmu, swgroup, &i);
 	if (group) {
 		value = smmu_readl(smmu, group->reg);
 		value &= ~SMMU_ASID_MASK;
 		value |= SMMU_ASID_VALUE(asid);
 		value &= ~SMMU_ASID_ENABLE;
 		smmu_writel(smmu, value, group->reg);
+		if (smmu->group_debug)
+			smmu->group_debug[i].priv = NULL;
 	}
 
 	for (i = 0; i < smmu->soc->num_clients; i++) {
@@ -499,7 +522,7 @@ static int tegra_smmu_attach_dev(struct iommu_domain *domain,
 		if (err)
 			goto disable;
 
-		tegra_smmu_enable(smmu, fwspec->ids[index], as->id);
+		tegra_smmu_enable(smmu, fwspec->ids[index], as);
 	}
 
 	if (index == 0)
@@ -1058,8 +1081,132 @@ static int tegra_smmu_clients_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 
+static int tegra_smmu_mappings_show(struct seq_file *s, void *data)
+{
+	struct tegra_smmu_group_debug *group_debug = s->private;
+	const struct tegra_smmu_swgroup *group;
+	struct tegra_smmu_as *as;
+	struct tegra_smmu *smmu;
+	int pd_index, pt_index;
+	unsigned long flags;
+	u64 pte_count = 0;
+	u32 pde_count = 0;
+	u32 val, ptb_reg;
+	u32 *pd;
+
+	if (!group_debug || !group_debug->priv || !group_debug->group)
+		return 0;
+
+	group = group_debug->group;
+	as = group_debug->priv;
+	smmu = as->smmu;
+
+	mutex_lock(&smmu->lock);
+
+	val = smmu_readl(smmu, group->reg) & SMMU_ASID_ENABLE;
+	if (!val)
+		goto unlock;
+
+	pd = page_address(as->pd);
+	if (!pd)
+		goto unlock;
+
+	seq_printf(s, "\nSWGROUP: %s\nASID: %d\nreg: 0x%x\n", group->name, as->id, group->reg);
+
+	smmu_writel(smmu, as->id & 0x7f, SMMU_PTB_ASID);
+	ptb_reg = smmu_readl(smmu, SMMU_PTB_DATA);
+
+	seq_printf(s, "PTB_ASID: 0x%x\nas->pd_dma: 0x%llx\n", ptb_reg, as->pd_dma);
+	seq_puts(s, "{\n");
+
+	spin_lock_irqsave(&as->lock, flags);
+
+	for (pd_index = 0; pd_index < SMMU_NUM_PDE; pd_index++) {
+		struct page *pt_page;
+		u32 *addr;
+		int i;
+
+		/* An empty PDE should not have a pte use count */
+		WARN_ON_ONCE(!pd[pd_index] ^ !as->count[pd_index]);
+
+		/* Skip this empty PDE */
+		if (!pd[pd_index])
+			continue;
+
+		pde_count++;
+		pte_count += as->count[pd_index];
+		seq_printf(s, "\t[%d] 0x%x (%d)\n", pd_index, pd[pd_index], as->count[pd_index]);
+		pt_page = as->pts[pd_index];
+		addr = page_address(pt_page);
+
+		seq_puts(s, "\t{\n");
+		seq_printf(s, "\t\t%-15s %-14s %-11s %-11s %-6s\n",
+			   "PTE RANGE", "PHYS", "IOVA", "SIZE", "ATTR");
+		for (pt_index = 0; pt_index < SMMU_NUM_PTE; pt_index += i) {
+			size_t size = SMMU_SIZE_PT;
+			phys_addr_t pa;
+			u64 iova;
+
+			i = 1;
+
+			if (!addr[pt_index])
+				continue;
+
+			iova = pd_pt_index_iova(pd_index, pt_index);
+			pa = SMMU_PFN_PHYS(addr[pt_index] & ~SMMU_PTE_ATTR);
+
+			/* Check contiguous mappings and increase size */
+			while (pt_index + i < SMMU_NUM_PTE) {
+				phys_addr_t next_pa;
+				u64 next_iova;
+
+				if (!addr[pt_index + i])
+					break;
+
+				next_iova = pd_pt_index_iova(pd_index, pt_index + i);
+				next_pa = SMMU_PFN_PHYS(addr[pt_index + i] & ~SMMU_PTE_ATTR);
+
+				/* Break at the end of a linear mapping */
+				if ((next_iova - iova != SMMU_SIZE_PT * i) ||
+				    (next_pa - pa != SMMU_SIZE_PT * i))
+					break;
+
+				i++;
+			}
+
+			seq_printf(s, "\t\t#%-4d - #%-6d 0x%-12llx 0x%-9llx 0x%-9lx 0x%-4x\n",
+				   pt_index, pt_index + i - 1, pa, iova, size * i,
+				   addr[pt_index] >> SMMU_PTE_ATTR_SHIFT);
+		}
+		seq_puts(s, "\t}\n");
+	}
+
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	seq_puts(s, "}\n");
+	seq_printf(s, "Total PDE count: %d\n", pde_count);
+	seq_printf(s, "Total PTE count: %lld\n", pte_count);
+
+unlock:
+	mutex_unlock(&smmu->lock);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_mappings);
+
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
+	const struct tegra_smmu_soc *soc = smmu->soc;
+	struct tegra_smmu_group_debug *group_debug;
+	struct device *dev = smmu->dev;
+	struct dentry *d;
+	int i;
+
+	group_debug = devm_kcalloc(dev, soc->num_swgroups, sizeof(*group_debug), GFP_KERNEL);
+	if (!group_debug)
+		return;
+
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
 	if (!smmu->debugfs)
 		return;
@@ -1068,6 +1215,21 @@ static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 			    &tegra_smmu_swgroups_fops);
 	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_clients_fops);
+	d = debugfs_create_dir("mappings", smmu->debugfs);
+
+	for (i = 0; i < soc->num_swgroups; i++) {
+		const struct tegra_smmu_swgroup *group = &soc->swgroups[i];
+
+		if (!group->name)
+			continue;
+
+		group_debug[i].group = group;
+
+		debugfs_create_file(group->name, 0444, d, &group_debug[i],
+				    &tegra_smmu_mappings_fops);
+	}
+
+	smmu->group_debug = group_debug;
 }
 
 static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
