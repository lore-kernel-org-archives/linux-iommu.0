Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88046EB67
	for <iommu@lists.linux.dev>; Fri, 24 May 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579316; cv=none; b=SNXtvhNEUSwraF6gZvG1c6yd46tikG2NWoE19Vv2L0kdhPgYHsm/ckFLD0uN/7+MuLUfBl2IPoMMR560WYFw+gJE8wZt8bd6dhTfnFCqR2dvN2QRgks5NaTkcAhE97LlLIHtM6EeWcjoqBUBBB/dFltH617HlcQRcP3wCfa2dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579316; c=relaxed/simple;
	bh=eYGA+orwD+Ol9A5EB2UUQDA/4EgJEEn6iHa0vyoTPbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9PM109TCNwf+mGZYmhyFJZN3z2cGB5TCalAbu/270Gpf5jtopyIEKscpzYzZLAbODfPJn/K09ON7e4635Zs2fMP+30P7kI7GEbbEAcVv4jBySunlBsab1uumyxyifiuYjg7dN4YxIUjARYW2TO6R0Szs8JzRBtdQRKGf9GeH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KAGOouJd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KAGOouJd"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so3669207b3a.0
        for <iommu@lists.linux.dev>; Fri, 24 May 2024 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716579313; x=1717184113; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RcH/mtXQa5cqnGqq/VSjXULH6hugwEnzQLEtT1+ekM=;
        b=KAGOouJdbwAuGN8cnbFD1pSWr0iPbY76c24ZokzV/52NZ9NYfLsQqpt56nmYNFLtKS
         dUyMVRaadnlbGpCF9pmSR7dciOxVqmotXnjQEkYk/WnUzXgg57m1nc1oV2scs76Pdf0A
         8hTdGilcr02J40kGhuxec7e7XU81KYL8j4hPUDzpm/LkLdpH9T0rwdG9tXMTRd/MScx5
         l2A5hgJlF6fz0rk0mq2jzP2nnFd05Sj4ZfB98yfy3ll6KHXvw1hoQhj6RtuFMe2NAzXE
         G/YWWykZfDd3v8FpImj6XktfMtEOC3rU74BqeeJj4vauVxlnWLm1eMS4xuiC9JD3AkIP
         UBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579313; x=1717184113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6RcH/mtXQa5cqnGqq/VSjXULH6hugwEnzQLEtT1+ekM=;
        b=bW4omETquKNWM/X02fm+Nf6mjmYWVRMfSXo6sloW8D/MpTU4+vHBFr1WtvAhoUuaqH
         v51CJV366SpJDzYpdSdrOtkTSxzRAk1Rikg5RFEYq2KlRVnw2Z84AM4DV4Dc/FiaNoME
         UoGNy5W+1uRF+8deEiuQW65w0ajE2QXw8jQcWzseBLhLnoQfYpPmWclw44gcdc1QNoc5
         fqZ+Av6W174kk6PTBSv69z/eb60WQJkgrRPZ5kaWJZVFh5de6kzqZZhej2Q1mqVfwkw9
         BOqndeKkDDu2HFCPK+auaO9ufzn996jLYtvzB1aW2tS5Q7M0+U3z/aiCwzU4FQg5Nkc9
         gjXg==
X-Forwarded-Encrypted: i=1; AJvYcCUVCXfD+W4sMVPbYG+k9fuxQ8/Zs2WMxTPEtD9KbgUvxBLjjUWccpr+10zxkWoaR7eux9RuRNOHS6B6cR3dnGHGbsF6o8U=
X-Gm-Message-State: AOJu0Yy8Sq4+8zG/HFuVsbudGYWjHU9H04Tog7NjoX+KP60eWPNlLszM
	jEsOeGnru3gTwcsInnXKR1YzwJP/skwNqP4myE6H1VGm57/vR9gypddnW1TpGWw=
X-Google-Smtp-Source: AGHT+IGYIyonzMcEphp7mpCiAbxRP9AsOeJ4QcYUoUCOAghTbWoZVq4kCMoyQaqlWmi2wSvrfnZAhw==
X-Received: by 2002:a05:6a21:8801:b0:1b1:d371:334d with SMTP id adf61e73a8af0-1b212d4b08fmr4190453637.30.1716579313105;
        Fri, 24 May 2024 12:35:13 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4d878esm1441684b3a.190.2024.05.24.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 12:35:12 -0700 (PDT)
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@rivosinc.com,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v6 7/7] iommu/riscv: Paging domain support
Date: Fri, 24 May 2024 12:34:47 -0700
Message-Id: <b4f1cf3300791345d280aaa79534086cdc267bf4.1716578450.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716578450.git.tjeznach@rivosinc.com>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce first-stage address translation support.

Page table configured by the IOMMU driver will use the highest mode
implemented by the hardware, unless not known at the domain allocation
time falling back to the CPU’s MMU page mode.

This change introduces IOTINVAL.VMA command, required to invalidate
any cached IOATC entries after mapping is updated and/or removed from
the paging domain.  Invalidations for the non-leaf page entries use
IOTINVAL for all addresses assigned to the protection domain for
hardware not supporting more granular non-leaf page table cache
invalidations.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 635 +++++++++++++++++++++++++++++++++++-
 1 file changed, 632 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 8dc14e89f265..9b176c07a70e 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -41,6 +41,10 @@
 #define dev_to_iommu(dev) \
 	iommu_get_iommu_dev(dev, struct riscv_iommu_device, iommu)
 
+/* IOMMU PSCID allocation namespace. */
+static DEFINE_IDA(riscv_iommu_pscids);
+#define RISCV_IOMMU_MAX_PSCID		(BIT(20) - 1)
+
 /* Device resource-managed allocations */
 struct riscv_iommu_devres {
 	void *addr;
@@ -779,6 +783,197 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
 	return 0;
 }
 
+/* This struct contains protection domain specific IOMMU driver data. */
+struct riscv_iommu_domain {
+	struct iommu_domain domain;
+	struct list_head bonds;
+	spinlock_t lock;		/* protect bonds list updates. */
+	int pscid;
+	int amo_enabled:1;
+	int numa_node;
+	unsigned int pgd_mode;
+	unsigned long *pgd_root;
+};
+
+#define iommu_domain_to_riscv(iommu_domain) \
+	container_of(iommu_domain, struct riscv_iommu_domain, domain)
+
+/* Private IOMMU data for managed devices, dev_iommu_priv_* */
+struct riscv_iommu_info {
+	struct riscv_iommu_domain *domain;
+};
+
+/*
+ * Linkage between an iommu_domain and attached devices.
+ *
+ * Protection domain requiring IOATC and DevATC translation cache invalidations,
+ * should be linked to attached devices using a riscv_iommu_bond structure.
+ * Devices should be linked to the domain before first use and unlinked after
+ * the translations from the referenced protection domain can no longer be used.
+ * Blocking and identity domains are not tracked here, as the IOMMU hardware
+ * does not cache negative and/or identity (BARE mode) translations, and DevATC
+ * is disabled for those protection domains.
+ *
+ * The device pointer and IOMMU data remain stable in the bond struct after
+ * _probe_device() where it's attached to the managed IOMMU, up to the
+ * completion of the _release_device() call. The release of the bond structure
+ * is synchronized with the device release.
+ */
+struct riscv_iommu_bond {
+	struct list_head list;
+	struct rcu_head rcu;
+	struct device *dev;
+};
+
+static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
+				 struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_bond *bond;
+	struct list_head *bonds;
+
+	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
+	if (!bond)
+		return -ENOMEM;
+	bond->dev = dev;
+
+	/*
+	 * List of devices attached to the domain is arranged based on
+	 * managed IOMMU device.
+	 */
+
+	spin_lock(&domain->lock);
+	list_for_each(bonds, &domain->bonds)
+		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
+			break;
+	list_add_rcu(&bond->list, bonds);
+	spin_unlock(&domain->lock);
+
+	/* Synchronize with riscv_iommu_iotlb_inval() sequence. See comment below. */
+	smp_mb();
+
+	return 0;
+}
+
+static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
+				    struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_bond *bond, *found = NULL;
+	struct riscv_iommu_command cmd;
+	int count = 0;
+
+	if (!domain)
+		return;
+
+	spin_lock(&domain->lock);
+	list_for_each_entry(bond, &domain->bonds, list) {
+		if (found && count)
+			break;
+		else if (bond->dev == dev)
+			found = bond;
+		else if (dev_to_iommu(bond->dev) == iommu)
+			count++;
+	}
+	if (found)
+		list_del_rcu(&found->list);
+	spin_unlock(&domain->lock);
+	kfree_rcu(found, rcu);
+
+	/*
+	 * If this was the last bond between this domain and the IOMMU
+	 * invalidate all cached entries for domain's PSCID.
+	 */
+	if (!count) {
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		riscv_iommu_cmd_send(iommu, &cmd);
+
+		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+	}
+}
+
+/*
+ * Send IOTLB.INVAL for whole address space for ranges larger than 2MB.
+ * This limit will be replaced with range invalidations, if supported by
+ * the hardware, when RISC-V IOMMU architecture specification update for
+ * range invalidations update will be available.
+ */
+#define RISCV_IOMMU_IOTLB_INVAL_LIMIT	(2 << 20)
+
+static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
+				    unsigned long start, unsigned long end)
+{
+	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu, *prev;
+	struct riscv_iommu_command cmd;
+	unsigned long len = end - start + 1;
+	unsigned long iova;
+
+	/*
+	 * For each IOMMU linked with this protection domain (via bonds->dev),
+	 * an IOTLB invaliation command will be submitted and executed.
+	 *
+	 * Possbile race with domain attach flow is handled by sequencing
+	 * bond creation - riscv_iommu_bond_link(), and device directory
+	 * update - riscv_iommu_iodir_update().
+	 *
+	 * PTE Update / IOTLB Inval           Device attach & directory update
+	 * --------------------------         --------------------------
+	 * update page table entries          add dev to the bond list
+	 * FENCE RW,RW                        FENCE RW,RW
+	 * For all IOMMUs: (can be empty)     Update FSC/PSCID
+	 *   FENCE IOW,IOW                      FENCE IOW,IOW
+	 *   IOTLB.INVAL                        IODIR.INVAL
+	 *   IOFENCE.C
+	 *
+	 * If bond list is not updated with new device, directory context will
+	 * be configured with already valid page table content. If an IOMMU is
+	 * linked to the protection domain it will receive invalidation
+	 * requests for updated page table entries.
+	 */
+	smp_mb();
+
+	rcu_read_lock();
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+
+		/*
+		 * IOTLB invalidation request can be safely omitted if already sent
+		 * to the IOMMU for the same PSCID, and with domain->bonds list
+		 * arranged based on the device's IOMMU, it's sufficient to check
+		 * last device the invalidation was sent to.
+		 */
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_cmd_inval_vma(&cmd);
+		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		if (len && len >= RISCV_IOMMU_IOTLB_INVAL_LIMIT) {
+			for (iova = start; iova < end; iova += PAGE_SIZE) {
+				riscv_iommu_cmd_inval_set_addr(&cmd, iova);
+				riscv_iommu_cmd_send(iommu, &cmd);
+			}
+		} else {
+			riscv_iommu_cmd_send(iommu, &cmd);
+		}
+		prev = iommu;
+	}
+
+	prev = NULL;
+	list_for_each_entry_rcu(bond, &domain->bonds, list) {
+		iommu = dev_to_iommu(bond->dev);
+		if (iommu == prev)
+			continue;
+
+		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+		prev = iommu;
+	}
+	rcu_read_unlock();
+}
+
 #define RISCV_IOMMU_FSC_BARE 0
 
 /*
@@ -798,10 +993,28 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_dc *dc;
+	struct riscv_iommu_command cmd;
+	bool sync_required = false;
 	u64 tc;
 	int i;
 
-	/* Device context invalidation ignored for now. */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
+		tc = READ_ONCE(dc->tc);
+		if (!(tc & RISCV_IOMMU_DC_TC_V))
+			continue;
+
+		WRITE_ONCE(dc->tc, tc & ~RISCV_IOMMU_DC_TC_V);
+
+		/* Invalidate device context cached values */
+		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
+		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
+		riscv_iommu_cmd_send(iommu, &cmd);
+		sync_required = true;
+	}
+
+	if (sync_required)
+		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
 
 	/*
 	 * For device context with DC_TC_PDTV = 0, translation attributes valid bit
@@ -820,12 +1033,406 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
 	}
 }
 
+/*
+ * IOVA page translation tree management.
+ */
+
+#define IOMMU_PAGE_SIZE_4K     BIT_ULL(12)
+#define IOMMU_PAGE_SIZE_2M     BIT_ULL(21)
+#define IOMMU_PAGE_SIZE_1G     BIT_ULL(30)
+#define IOMMU_PAGE_SIZE_512G   BIT_ULL(39)
+
+#define PT_SHIFT (PAGE_SHIFT - ilog2(sizeof(pte_t)))
+
+static void riscv_iommu_iotlb_flush_all(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+}
+
+static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
+				   struct iommu_iotlb_gather *gather)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+
+	riscv_iommu_iotlb_inval(domain, gather->start, gather->end);
+}
+
+static inline size_t get_page_size(size_t size)
+{
+	if (size >= IOMMU_PAGE_SIZE_512G)
+		return IOMMU_PAGE_SIZE_512G;
+	if (size >= IOMMU_PAGE_SIZE_1G)
+		return IOMMU_PAGE_SIZE_1G;
+	if (size >= IOMMU_PAGE_SIZE_2M)
+		return IOMMU_PAGE_SIZE_2M;
+	return IOMMU_PAGE_SIZE_4K;
+}
+
+#define _io_pte_present(pte)	((pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE))
+#define _io_pte_leaf(pte)	((pte) & _PAGE_LEAF)
+#define _io_pte_none(pte)	((pte) == 0)
+#define _io_pte_entry(pn, prot)	((_PAGE_PFN_MASK & ((pn) << _PAGE_PFN_SHIFT)) | (prot))
+
+static void riscv_iommu_pte_free(struct riscv_iommu_domain *domain,
+				 unsigned long pte, struct list_head *freelist)
+{
+	unsigned long *ptr;
+	int i;
+
+	if (!_io_pte_present(pte) || _io_pte_leaf(pte))
+		return;
+
+	ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+
+	/* Recursively free all sub page table pages */
+	for (i = 0; i < PTRS_PER_PTE; i++) {
+		pte = READ_ONCE(ptr[i]);
+		if (!_io_pte_none(pte) && cmpxchg_relaxed(ptr + i, pte, 0) == pte)
+			riscv_iommu_pte_free(domain, pte, freelist);
+	}
+
+	if (freelist)
+		list_add_tail(&virt_to_page(ptr)->lru, freelist);
+	else
+		iommu_free_page(ptr);
+}
+
+static unsigned long *riscv_iommu_pte_alloc(struct riscv_iommu_domain *domain,
+					    unsigned long iova, size_t pgsize,
+					    gfp_t gfp)
+{
+	unsigned long *ptr = domain->pgd_root;
+	unsigned long pte, old;
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+	void *addr;
+
+	do {
+		const int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
+		/*
+		 * Note: returned entry might be a non-leaf if there was
+		 * existing mapping with smaller granularity. Up to the caller
+		 * to replace and invalidate.
+		 */
+		if (((size_t)1 << shift) == pgsize)
+			return ptr;
+pte_retry:
+		pte = READ_ONCE(*ptr);
+		/*
+		 * This is very likely incorrect as we should not be adding
+		 * new mapping with smaller granularity on top
+		 * of existing 2M/1G mapping. Fail.
+		 */
+		if (_io_pte_present(pte) && _io_pte_leaf(pte))
+			return NULL;
+		/*
+		 * Non-leaf entry is missing, allocate and try to add to the
+		 * page table. This might race with other mappings, retry.
+		 */
+		if (_io_pte_none(pte)) {
+			addr = iommu_alloc_page_node(domain->numa_node, gfp);
+			if (!addr)
+				return NULL;
+			old = pte;
+			pte = _io_pte_entry(virt_to_pfn(addr), _PAGE_TABLE);
+			if (cmpxchg_relaxed(ptr, old, pte) != old) {
+				iommu_free_page(addr);
+				goto pte_retry;
+			}
+		}
+		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	} while (level-- > 0);
+
+	return NULL;
+}
+
+static unsigned long *riscv_iommu_pte_fetch(struct riscv_iommu_domain *domain,
+					    unsigned long iova, size_t *pte_pgsize)
+{
+	unsigned long *ptr = domain->pgd_root;
+	unsigned long pte;
+	int level = domain->pgd_mode - RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39 + 2;
+
+	do {
+		const int shift = PAGE_SHIFT + PT_SHIFT * level;
+
+		ptr += ((iova >> shift) & (PTRS_PER_PTE - 1));
+		pte = READ_ONCE(*ptr);
+		if (_io_pte_present(pte) && _io_pte_leaf(pte)) {
+			*pte_pgsize = (size_t)1 << shift;
+			return ptr;
+		}
+		if (_io_pte_none(pte))
+			return NULL;
+		ptr = (unsigned long *)pfn_to_virt(__page_val_to_pfn(pte));
+	} while (level-- > 0);
+
+	return NULL;
+}
+
+static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
+				 unsigned long iova, phys_addr_t phys,
+				 size_t pgsize, size_t pgcount, int prot,
+				 gfp_t gfp, size_t *mapped)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	size_t size = 0;
+	size_t page_size = get_page_size(pgsize);
+	unsigned long *ptr;
+	unsigned long pte, old, pte_prot;
+	int rc = 0;
+	LIST_HEAD(freelist);
+
+	if (!(prot & IOMMU_WRITE))
+		pte_prot = _PAGE_BASE | _PAGE_READ;
+	else if (domain->amo_enabled)
+		pte_prot = _PAGE_BASE | _PAGE_READ | _PAGE_WRITE;
+	else
+		pte_prot = _PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _PAGE_DIRTY;
+
+	while (pgcount) {
+		ptr = riscv_iommu_pte_alloc(domain, iova, page_size, gfp);
+		if (!ptr) {
+			rc = -ENOMEM;
+			break;
+		}
+
+		old = READ_ONCE(*ptr);
+		pte = _io_pte_entry(phys_to_pfn(phys), pte_prot);
+		if (cmpxchg_relaxed(ptr, old, pte) != old)
+			continue;
+
+		riscv_iommu_pte_free(domain, old, &freelist);
+
+		size += page_size;
+		iova += page_size;
+		phys += page_size;
+		--pgcount;
+	}
+
+	*mapped = size;
+
+	if (!list_empty(&freelist)) {
+		/*
+		 * In 1.0 spec version, the smallest scope we can use to
+		 * invalidate all levels of page table (i.e. leaf and non-leaf)
+		 * is an invalidate-all-PSCID IOTINVAL.VMA with AV=0.
+		 * This will be updated with hardware support for
+		 * capability.NL (non-leaf) IOTINVAL command.
+		 */
+		riscv_iommu_iotlb_inval(domain, 0, ULONG_MAX);
+		iommu_put_pages_list(&freelist);
+	}
+
+	return rc;
+}
+
+static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
+				      unsigned long iova, size_t pgsize,
+				      size_t pgcount,
+				      struct iommu_iotlb_gather *gather)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	size_t size = pgcount << __ffs(pgsize);
+	unsigned long *ptr, old;
+	size_t unmapped = 0;
+	size_t pte_size;
+
+	while (unmapped < size) {
+		ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
+		if (!ptr)
+			return unmapped;
+
+		/* partial unmap is not allowed, fail. */
+		if (iova & (pte_size - 1))
+			return unmapped;
+
+		old = READ_ONCE(*ptr);
+		if (cmpxchg_relaxed(ptr, old, 0) != old)
+			continue;
+
+		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
+					    pte_size);
+
+		iova += pte_size;
+		unmapped += pte_size;
+	}
+
+	return unmapped;
+}
+
+static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
+					    dma_addr_t iova)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	unsigned long pte_size;
+	unsigned long *ptr;
+
+	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
+	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
+		return 0;
+
+	return pfn_to_phys(__page_val_to_pfn(*ptr)) | (iova & (pte_size - 1));
+}
+
+static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	const unsigned long pfn = virt_to_pfn(domain->pgd_root);
+
+	WARN_ON(!list_empty(&domain->bonds));
+
+	if ((int)domain->pscid > 0)
+		ida_free(&riscv_iommu_pscids, domain->pscid);
+
+	riscv_iommu_pte_free(domain, _io_pte_entry(pfn, _PAGE_TABLE), NULL);
+	kfree(domain);
+}
+
+static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
+{
+	switch (pgd_mode) {
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV39;
+
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV48;
+
+	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57:
+		return iommu->caps & RISCV_IOMMU_CAP_S_SV57;
+	}
+	return false;
+}
+
+static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
+					    struct device *dev)
+{
+	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	u64 fsc, ta;
+
+	if (!riscv_iommu_pt_supported(iommu, domain->pgd_mode))
+		return -ENODEV;
+
+	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, domain->pgd_mode) |
+	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, virt_to_pfn(domain->pgd_root));
+	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
+	     RISCV_IOMMU_PC_TA_V;
+
+	if (riscv_iommu_bond_link(domain, dev))
+		return -ENOMEM;
+
+	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
+	riscv_iommu_bond_unlink(info->domain, dev);
+	info->domain = domain;
+
+	return 0;
+}
+
+static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
+	.attach_dev = riscv_iommu_attach_paging_domain,
+	.free = riscv_iommu_free_paging_domain,
+	.map_pages = riscv_iommu_map_pages,
+	.unmap_pages = riscv_iommu_unmap_pages,
+	.iova_to_phys = riscv_iommu_iova_to_phys,
+	.iotlb_sync = riscv_iommu_iotlb_sync,
+	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
+};
+
+static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
+{
+	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_device *iommu;
+	unsigned int pgd_mode;
+	int va_bits;
+
+	iommu = dev ? dev_to_iommu(dev) : NULL;
+
+	/*
+	 * In unlikely case when dev or iommu is not known, use system
+	 * SATP mode to configure paging domain radix tree depth.
+	 * Use highest available if actual IOMMU hardware capabilities
+	 * are known here.
+	 */
+	if (!iommu) {
+		pgd_mode = satp_mode >> SATP_MODE_SHIFT;
+		va_bits = VA_BITS;
+	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV57) {
+		pgd_mode = RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57;
+		va_bits = 57;
+	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV48) {
+		pgd_mode = RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV48;
+		va_bits = 48;
+	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV39) {
+		pgd_mode =  RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39;
+		va_bits = 39;
+	} else {
+		dev_err(dev, "cannot find supported page table mode\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD_RCU(&domain->bonds);
+	spin_lock_init(&domain->lock);
+	domain->numa_node = NUMA_NO_NODE;
+
+	if (iommu) {
+		domain->numa_node = dev_to_node(iommu->dev);
+		domain->amo_enabled = !!(iommu->caps & RISCV_IOMMU_CAP_AMO_HWAD);
+	}
+
+	domain->pgd_mode = pgd_mode;
+	domain->pgd_root = iommu_alloc_page_node(domain->numa_node,
+						 GFP_KERNEL_ACCOUNT);
+	if (!domain->pgd_root) {
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
+					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
+	if (domain->pscid < 0) {
+		iommu_free_page(domain->pgd_root);
+		kfree(domain);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * Note: RISC-V Privilege spec mandates that virtual addresses
+	 * need to be sign-extended, so if (VA_BITS - 1) is set, all
+	 * bits >= VA_BITS need to also be set or else we'll get a
+	 * page fault. However the code that creates the mappings
+	 * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
+	 * for now, so we'll end up with invalid virtual addresses
+	 * to map. As a workaround until we get this sorted out
+	 * limit the available virtual addresses to VA_BITS - 1.
+	 */
+	domain->domain.geometry.aperture_start = 0;
+	domain->domain.geometry.aperture_end = DMA_BIT_MASK(va_bits - 1);
+	domain->domain.geometry.force_aperture = true;
+
+	domain->domain.ops = &riscv_iommu_paging_domain_ops;
+
+	return &domain->domain;
+}
+
 static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
+	/* Make device context invalid, translation requests will fault w/ #258 */
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
+	riscv_iommu_bond_unlink(info->domain, dev);
+	info->domain = NULL;
 
 	return 0;
 }
@@ -841,8 +1448,11 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev)
 {
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
 	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
+	riscv_iommu_bond_unlink(info->domain, dev);
+	info->domain = NULL;
 
 	return 0;
 }
@@ -856,7 +1466,7 @@ static struct iommu_domain riscv_iommu_identity_domain = {
 
 static int riscv_iommu_device_domain_type(struct device *dev)
 {
-	return IOMMU_DOMAIN_IDENTITY;
+	return 0;
 }
 
 static struct iommu_group *riscv_iommu_device_group(struct device *dev)
@@ -875,6 +1485,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct riscv_iommu_device *iommu;
+	struct riscv_iommu_info *info;
 	struct riscv_iommu_dc *dc;
 	u64 tc;
 	int i;
@@ -893,6 +1504,9 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 	if (iommu->ddt_mode <= RISCV_IOMMU_DDTP_MODE_BARE)
 		return ERR_PTR(-ENODEV);
 
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
 	/*
 	 * Allocate and pre-configure device context entries in
 	 * the device directory. Do not mark the context valid yet.
@@ -902,24 +1516,39 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 		tc |= RISCV_IOMMU_DC_TC_SADE;
 	for (i = 0; i < fwspec->num_ids; i++) {
 		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
-		if (!dc)
+		if (!dc) {
+			kfree(info);
 			return ERR_PTR(-ENODEV);
+		}
 		if (READ_ONCE(dc->tc) & RISCV_IOMMU_DC_TC_V)
 			dev_warn(dev, "already attached to IOMMU device directory\n");
 		WRITE_ONCE(dc->tc, tc);
 	}
 
+	dev_iommu_priv_set(dev, info);
+
 	return &iommu->iommu;
 }
 
+static void riscv_iommu_release_device(struct device *dev)
+{
+	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+
+	synchronize_rcu();
+	kfree(info);
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
+	.pgsize_bitmap = SZ_4K,
 	.of_xlate = riscv_iommu_of_xlate,
 	.identity_domain = &riscv_iommu_identity_domain,
 	.blocked_domain = &riscv_iommu_blocking_domain,
 	.release_domain = &riscv_iommu_blocking_domain,
+	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
 	.def_domain_type = riscv_iommu_device_domain_type,
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
+	.release_device	= riscv_iommu_release_device,
 };
 
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
-- 
2.34.1

