Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26020DC5
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374944; cv=none; b=QaU8qBL5Kax5we20YESxY2+rGk8ZLrka60wwKMFAEfMRuCb1ATiWWcwxyjgMoE7uB0xn4qeu27jOtY8TLpps2CA1KRIDTB61qvWKpTe7cplg6tVju1WfqBlSVvjfpiOr9gcfry60ZT/q75DklQzmb75NJuV6QXPApoYuLhZWnPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374944; c=relaxed/simple;
	bh=HQCoIv3Xpbx6DOVWD61lR4O3qkiOmoi7Eje3+sHhmEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Q9RhrKqwErvxuqSvqrbdRe59mF8/8aE05VpmahX9KH9vDigMnIjfFnHzsMxV54wp4yvZ1/NDx5XRWQa9mTnkaVRO6vcAVSDUaoZHFDJbF1/iY5N5jqFmezTXGtStPlH6k8otflBCyRKDrvf0EzAaApepajtQK7L+zOl+jbMCY0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CYSE4yU3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CYSE4yU3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f7028196f2so19199225ad.2
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374943; x=1718979743; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Daef6kUbuf4+6WFIjDcTl7WQW1O4tQM7jDjBoLtjZ4=;
        b=CYSE4yU3EySiZarLm4wzjLMlXEsy0VR8Cc7Eg0nz5h0pHGstwjjeJ1Z3/VjqB248Kn
         GFFkMd4xvyn5DWL8A8/dhsKUxQYBtjV/mndPcvMo5rgowDgN6WpPJxbet7HiskuSmxNB
         tZpfb6kt0kn3zbLns4Y62AkfY7H1hVEL147CjWpjm45ACKdlWGWqxeh3Jp7JxSjQpVZR
         yKzaJoHBKsDVtAVRV5pSNJLWNgcDzfFsNYsRshu4Pq3ZB83dMF5SD8Dt/tEk/b/yKBS0
         3nE2cC9yAA9do+IndWtgfTtYrcsKLF+psckCZ6XSmvdElAVD/BGEq7w8tfd37SNl3fcs
         IBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374943; x=1718979743;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Daef6kUbuf4+6WFIjDcTl7WQW1O4tQM7jDjBoLtjZ4=;
        b=MJKC/FN4rUzMzFrjUmGX6ObwlO5dGSe2Bph+I8/QOyAaNbHu9+eBuLIL3koSEgfRo3
         Hkyqo9ULDWSk19eGrZX1GgDGIC26DChVjraS/gwGaIUTMmXP+ywzC8PUPsdpnURL4Och
         TrU1aZ0+cA1qocdtyKOdDMIynTa97U5sQenja5kpAIub0bNfAHeuHng14OxBx5Eu0Xgx
         5p30gcsK+YwKwa+IUYl0tKdM+NzV13kEXZSJ9CjcXdt3GLKIZ3yuB37sc2WQeFTaU2Yu
         OM6R7pWys4aMewKOV6B0j9qVDpzTJUqkH3LuCXhOQOejFQZRnjZIVtwF1rk5GgV91BCt
         0Tsw==
X-Forwarded-Encrypted: i=1; AJvYcCV/9Q62vDUd3aGY1e1n/yrXIlCWwUqmwTMixpKmekOzoputiHwAmXFHybaGecMXVi3Z5KH23fLvhAhLtouFP/1e7lUnb2s=
X-Gm-Message-State: AOJu0Yzi/5cj1P4A6bKeoejNAQqwL0MF4jz9t13+Ltg69Bs/L0K6dnRV
	HjKUYQ+MKucUnFuYef8SdZJmchc9BM5gXP8xKAzw9/3v1XUHkqlqa3aqFojkJf8=
X-Google-Smtp-Source: AGHT+IFqgOZYvBJ4kxh5nI8iWhYcYwWgqXcjlHpYLYmYilMYTECy6aBNWzRZ7wIFJH/yInxDq6z0lg==
X-Received: by 2002:a17:903:32ca:b0:1f7:c33:aa92 with SMTP id d9443c01a7336-1f8625c06f1mr32662045ad.9.1718374942583;
        Fri, 14 Jun 2024 07:22:22 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:22 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH v2 05/10] iommu/riscv: support GSCID and GVMA invalidation command
Date: Fri, 14 Jun 2024 22:21:51 +0800
Message-Id: <20240614142156.29420-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

This patch adds a ID Allocator for GSCID and a wrap for setting up
GSCID in IOTLB invalidation command.

Set up iohgatp to enable second stage table and flush stage-2 table if
the GSCID is set.

The GSCID of domain should be freed when release domain. GSCID will be
allocated for parent domain in nested IOMMU process.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/iommu/riscv/iommu-bits.h |  7 ++++++
 drivers/iommu/riscv/iommu.c      | 39 ++++++++++++++++++++++++++++----
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
index 60523449f016..214735a335fd 100644
--- a/drivers/iommu/riscv/iommu-bits.h
+++ b/drivers/iommu/riscv/iommu-bits.h
@@ -731,6 +731,13 @@ static inline void riscv_iommu_cmd_inval_vma(struct riscv_iommu_command *cmd)
 	cmd->dword1 = 0;
 }
 
+static inline void riscv_iommu_cmd_inval_gvma(struct riscv_iommu_command *cmd)
+{
+	cmd->dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_IOTINVAL_OPCODE) |
+		      FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA);
+	cmd->dword1 = 0;
+}
+
 static inline void riscv_iommu_cmd_inval_set_addr(struct riscv_iommu_command *cmd,
 						  u64 addr)
 {
diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index df7aeb2571ae..45309bd096e5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -45,6 +45,10 @@
 static DEFINE_IDA(riscv_iommu_pscids);
 #define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
 
+/* IOMMU GSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_gscids);
+#define RISCV_IOMMU_MAX_GSCID		(BIT(16) - 1)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -845,6 +849,7 @@ struct riscv_iommu_domain {
 	struct list_head bonds;
 	spinlock_t lock;		/* protect bonds list updates. */
 	int pscid;
+	int gscid;
 	int amo_enabled:1;
 	int numa_node;
 	unsigned int pgd_mode;
@@ -993,20 +998,33 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 	rcu_read_lock();
 
 	prev = NULL;
+
 	list_for_each_entry_rcu(bond, &domain->bonds, list) {
 		iommu = dev_to_iommu(bond->dev);
 
 		/*
 		 * IOTLB invalidation request can be safely omitted if already sent
-		 * to the IOMMU for the same PSCID, and with domain->bonds list
+		 * to the IOMMU for the same PSCID/GSCID, and with domain->bonds list
 		 * arranged based on the device's IOMMU, it's sufficient to check
 		 * last device the invalidation was sent to.
 		 */
 		if (iommu == prev)
 			continue;
 
-		riscv_iommu_cmd_inval_vma(&cmd);
-		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		/*
+		 * S2 domain needs to flush entries in stage-2 page table, its
+		 * bond list has host devices and pass-through devices, the GVMA
+		 * command is no effect on host devices, because there are no
+		 * mapping of host devices in stage-2 page table.
+		 */
+		if (domain->gscid) {
+			riscv_iommu_cmd_inval_gvma(&cmd);
+			riscv_iommu_cmd_inval_set_gscid(&cmd, domain->gscid);
+		} else {
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		}
+
 		if (len && len < RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
 			for (iova = start; iova < end; iova += PAGE_SIZE) {
 				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
@@ -1015,6 +1033,7 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 		} else {
 			riscv_iommu_cmd_send(iommu, &cmd);
 		}
+
 		prev = iommu;
 	}
 
@@ -1083,6 +1102,7 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 
 		WRITE_ONCE(dc->fsc, new_dc->fsc);
 		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);
+		WRITE_ONCE(dc->iohgatp, new_dc->iohgatp);
 		/* Update device context, write TC.V as the last step. */
 		dma_wmb();
 		WRITE_ONCE(dc->tc, tc);
@@ -1354,6 +1374,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	if ((int)domain->pscid > 0)
 		ida_free(&riscv_iommu_pscids, domain->pscid);
 
+	if ((int)domain->gscid > 0)
+		ida_free(&riscv_iommu_gscids, domain->gscid);
+
 	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
 	kfree(domain);
 }
@@ -1384,8 +1407,14 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
 		return -ENODEV;
 
-	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
-		 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	if (domain->gscid)
+		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, domain->pgd_mode) |
+			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
+			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, virt_to_pfn(domain->pgd_root));
+	else
+		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 			   RISCV_IOMMU_PC_TA_V;
 
-- 
2.17.1

