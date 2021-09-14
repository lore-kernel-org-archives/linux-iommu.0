Return-Path: <SRS0=mcPB=OE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C61C4321E
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 117E961130
	for <iommu@archiver.kernel.org>; Tue, 14 Sep 2021 01:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 117E961130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0D78403B0;
	Tue, 14 Sep 2021 01:47:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y0pMOuC-IfpJ; Tue, 14 Sep 2021 01:47:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A23E6403B7;
	Tue, 14 Sep 2021 01:47:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1F48C0027;
	Tue, 14 Sep 2021 01:47:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7B48C000D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB69380C53
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 24cx0oPSYMMB for <iommu@lists.linux-foundation.org>;
 Tue, 14 Sep 2021 01:47:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1380580C40
 for <iommu@lists.linux-foundation.org>; Tue, 14 Sep 2021 01:47:39 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id f21so4873236plb.4
 for <iommu@lists.linux-foundation.org>; Mon, 13 Sep 2021 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KEHBwA3froCQB75sci1LoZ3044EVfAvduVBAgISzhzk=;
 b=gQzHtdm0kIgxR9hlbp7Pjgzn6MbQiszWuTlHp1mtplAW/fkprOBU+rypu/wfNDbK7R
 gG3vr58E51xUDsidiN1Q2L36oZ4e6d+Kwfy/DWRenC3EWKJrF8ztDCU+1BrvYo1LHAQ6
 OY1jrcZRlJad9c7azQpLZEBlDZa5ZjtKiXnis+BPxuMl7GIPm56nwQiFaXxfBzFlFUNW
 qRMNJmAMWT3KCoG0RcXZ25MDEvhc4N4eghuMAsCaWEQIa0DWpFhWv4p8ab0i8bxZdaJr
 T7lxMfz4xiWi6cyuty4w1xvgBhK2oFkgXPT4oPXNV1vHZtuGYkKXyr7M+jlqLm3mPZ7T
 OY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KEHBwA3froCQB75sci1LoZ3044EVfAvduVBAgISzhzk=;
 b=0DM4f4rz+Vhl4yK1pAVj2nsjrIaVrH4cMvCQJMF77leHjo6VWN8as5RuzK/eI2zdcH
 j4jNITdvthyAoES02yO+WK6DNl6fr+NT2+d+kvK1VjDRE9hscwu7OEdqKUPIZbU9oXSN
 Cvpymz/w3pgTlMmeCB9nqQep4ryjrdqIVRmCFVb20C9J2DqONYYdaEEJmZ3EP6zFy/lT
 aLCRSO/kU19NXqPN+ogxpTqFmbyAcwnnmCc1/RzTXZ4p4ffbZnEZCQW+HQwnw8b+8TDh
 JqmfYXFmfqp/1EQWKxfOu8Z+9p3vHj+4halXu9s+zQkdc7AVCevPtHKfG0ynMKZG+7hI
 0zog==
X-Gm-Message-State: AOAM532pdAxe9tHzh3KggiU+8mPLbEk6oQve4ueGVUqJ1QiG825Ae6Mj
 uStHd+Gfi4P3VsAdk9fq0uw=
X-Google-Smtp-Source: ABdhPJzskNw45GqqeSUXGgj/1ef7/AQJvkz3kHRa8IqJIcIMjhbaL0IaTXZxhlQF+pqgvenczr1Ibw==
X-Received: by 2002:a17:902:968a:b0:133:e2c5:4908 with SMTP id
 n10-20020a170902968a00b00133e2c54908mr12842074plp.2.1631584058457; 
 Mon, 13 Sep 2021 18:47:38 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id z11sm8270101pfr.157.2021.09.13.18.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 18:47:38 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: thierry.reding@gmail.com,
	joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v6 6/6] iommu/tegra-smmu: Add pagetable mappings to debugfs
Date: Mon, 13 Sep 2021 18:38:58 -0700
Message-Id: <20210914013858.31192-7-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210914013858.31192-1-nicoleotsuka@gmail.com>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
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

Attaching an example:

SWGROUP: hc
as->id: 0
as->attr: R|W|N
as->pd_dma: 0x0000000080c03000
{
        [index: 1023] 0xf0080c3e (count: 2)
        {
                PTE RANGE      | ATTR | PHYS               | IOVA               | SIZE
                [#1022, #1023] | 0x5  | 0x000000010bbf1000 | 0x00000000ffffe000 | 0x2000
        }
}
Total PDE count: 1
Total PTE count: 2

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 145 +++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 68c34a4a0ecc..aac977e181f6 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -46,6 +46,7 @@ struct tegra_smmu {
 	struct list_head list;
 
 	struct dentry *debugfs;
+	struct dentry *debugfs_mappings;
 
 	struct iommu_device iommu;	/* IOMMU Core code handle */
 };
@@ -153,6 +154,9 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 
 #define SMMU_PDE_ATTR		(SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
 				 SMMU_PDE_NONSECURE)
+#define SMMU_PTE_ATTR		(SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
+				 SMMU_PTE_NONSECURE)
+#define SMMU_PTE_ATTR_SHIFT	29
 
 static unsigned int iova_pd_index(unsigned long iova)
 {
@@ -164,6 +168,12 @@ static unsigned int iova_pt_index(unsigned long iova)
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
@@ -496,6 +506,8 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
 	mutex_unlock(&smmu->lock);
 }
 
+static const struct file_operations tegra_smmu_debugfs_mappings_fops;
+
 static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 				 struct tegra_smmu_as *as,
 				 unsigned int swgroup)
@@ -517,6 +529,12 @@ static void tegra_smmu_attach_as(struct tegra_smmu *smmu,
 			dev_warn(smmu->dev,
 				 "overwriting group->as for swgroup: %s\n", swgrp->name);
 		group->as = as;
+
+		if (smmu->debugfs_mappings)
+			debugfs_create_file(group->swgrp->name, 0444,
+					    smmu->debugfs_mappings, group,
+					    &tegra_smmu_debugfs_mappings_fops);
+
 		break;
 	}
 
@@ -541,6 +559,12 @@ static void tegra_smmu_detach_as(struct tegra_smmu *smmu,
 		if (group->swgrp != swgrp)
 			continue;
 		group->as = NULL;
+
+		if (smmu->debugfs_mappings) {
+			d = debugfs_lookup(group->swgrp->name, smmu->debugfs_mappings);
+			debugfs_remove(d);
+		}
+
 		break;
 	}
 
@@ -1124,6 +1148,125 @@ static int tegra_smmu_clients_show(struct seq_file *s, void *data)
 
 DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 
+static int tegra_smmu_debugfs_mappings_show(struct seq_file *s, void *data)
+{
+	struct tegra_smmu_group *group = s->private;
+	const struct tegra_smmu_swgroup *swgrp;
+	struct tegra_smmu_as *as;
+	struct tegra_smmu *smmu;
+	unsigned int pd_index;
+	unsigned int pt_index;
+	unsigned long flags;
+	u64 pte_count = 0;
+	u32 pde_count = 0;
+	u32 *pd, val;
+
+	if (!group || !group->as || !group->swgrp)
+		return 0;
+
+	swgrp = group->swgrp;
+	smmu = group->smmu;
+	as = group->as;
+
+	mutex_lock(&smmu->lock);
+
+	val = smmu_readl(smmu, swgrp->reg) & SMMU_ASID_ENABLE;
+	if (!val)
+		goto unlock;
+
+	pd = page_address(as->pd);
+	if (!pd)
+		goto unlock;
+
+	seq_printf(s, "\nSWGROUP: %s\n", swgrp->name);
+	seq_printf(s, "as->id: %d\nas->attr: %c|%c|%s\nas->pd_dma: %pad\n", as->id,
+		   as->attr & SMMU_PD_READABLE ? 'R' : '-',
+		   as->attr & SMMU_PD_WRITABLE ? 'W' : '-',
+		   as->attr & SMMU_PD_NONSECURE ? "NS" : "S",
+		   &as->pd_dma);
+	seq_puts(s, "{\n");
+
+	spin_lock_irqsave(&as->lock, flags);
+
+	for (pd_index = 0; pd_index < SMMU_NUM_PDE; pd_index++) {
+		struct page *pt_page;
+		unsigned int i;
+		u32 *addr;
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
+		seq_printf(s, "\t[index: %u] 0x%x (count: %d)\n",
+			   pd_index, pd[pd_index], as->count[pd_index]);
+		pt_page = as->pts[pd_index];
+		addr = page_address(pt_page);
+
+		seq_puts(s, "\t{\n");
+		seq_printf(s, "\t\t%-14s | %-4s | %-10s%s | %-10s%s | %-11s\n",
+			   "PTE RANGE", "ATTR",
+			   "PHYS", sizeof(phys_addr_t) > 4 ? "        " : "",
+			   "IOVA", sizeof(dma_addr_t)  > 4 ? "        " : "",
+			   "SIZE");
+		for (pt_index = 0; pt_index < SMMU_NUM_PTE; pt_index += i) {
+			size_t size = SMMU_SIZE_PT;
+			dma_addr_t iova;
+			phys_addr_t pa;
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
+				dma_addr_t next_iova;
+				phys_addr_t next_pa;
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
+			seq_printf(s, "\t\t[#%-4u, #%-4u] | 0x%-2x | %pa | %pad | 0x%-9zx\n",
+				   pt_index, pt_index + i - 1,
+				   addr[pt_index] >> SMMU_PTE_ATTR_SHIFT,
+				   &pa, &iova, size * i);
+		}
+		seq_puts(s, "\t}\n");
+	}
+
+	spin_unlock_irqrestore(&as->lock, flags);
+
+	seq_puts(s, "}\n");
+	seq_printf(s, "Total PDE count: %u\n", pde_count);
+	seq_printf(s, "Total PTE count: %llu\n", pte_count);
+
+unlock:
+	mutex_unlock(&smmu->lock);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_debugfs_mappings);
+
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
@@ -1134,6 +1277,8 @@ static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 			    &tegra_smmu_swgroups_fops);
 	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_clients_fops);
+
+	smmu->debugfs_mappings = debugfs_create_dir("mappings", smmu->debugfs);
 }
 
 static void tegra_smmu_debugfs_exit(struct tegra_smmu *smmu)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
