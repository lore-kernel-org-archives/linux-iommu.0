Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F981174EFF
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457964; cv=none; b=l5ovY5OoAygCbH5iUv/V8Yvr8tZrs720JEBKxQTzrm0Jl3u/hN9WfXBYRx9d3s4G9QZnv+040OAKiMs2sylpVNJq0WwPHBVrsTg6c7JOfudTrACFVnudbUiUr5IvkgwKQrq4OCwMF4uxozimpQWLEQHLH/loMygQQM93by7jj0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457964; c=relaxed/simple;
	bh=oq4dT7aByaL6/ox7nWOSymIVC3Kwz3/cVJ+FXh79NxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnHDJ1gKCO8gyKGare+Mycn/rPW7MxqtZO/qxX+ZLz9Xzjx4Yjn/1IjQqSVfcCwIEypdVZZKqy8DPu3jpImmIeipslap1YKwz7x9ptNmcLuKIbN7DWMr5rt9BU/C3LF2XfnBrc2pcRH6ayanH4OoYlNi/jeZqhfaGVjpWBbVicA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Zu8DAs+z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Zu8DAs+z"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so1188842b3a.3
        for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713457961; x=1714062761; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUNIKtKL4Udgzy+4pBX8wQhgL3bw7FcCBTIPUGHURow=;
        b=Zu8DAs+zpsXhkSFJFs4UYXm6V4QHjoIlKDBgyNJzhZuN7H8WMUnR63FnYkH+FkZ+sR
         i8L20AXwTarlZUvcviviTejKShUngZoSYlzRNveK9S55FZxHsAbinWEZRju0+056F9kJ
         lcGU2+TsXPthxemvnbcUHgy9gSamlJqstbtdI5DV24JTo3Sva4KrY0+PmTeF9VBfDRrM
         XIQ4HZjoO9f53E7piXAJzhysm+k49feNP8J21c+JAdYcNUNMcs/XERiwUGdLQF871FkC
         ZFKbOLMThfOKeNm9hXdWBrknPPYCT1nWCFj9MImWcb4BnLUS2FWdDF0nPk1TYC2mURw8
         yVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713457961; x=1714062761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUNIKtKL4Udgzy+4pBX8wQhgL3bw7FcCBTIPUGHURow=;
        b=mxaPx0BA61HvjretjdyPWq4ujnB+EE79H2G7pjxS3G/mfOYUQ1blWlQZ53IGAm0dUa
         Y+3lfirNzNJOBeq8RE8c+epO/liDXhBDfRiDOiIhNs2gMnwpZJM8V8LOWu0yJbSmnD40
         EremD5pJ0CLgcmiJs5Wj1CL3HqWdy1fsNgAKUzMiKy96JI+PkfjJYlkgME7QdNw8MMMc
         GBEKgLrCUTsPF78GW8NSqENdTcHR6AAq1P2RwCPqU5DYte5YJFEQjVf3Xn2D2e/W3LM1
         f1AVHa8zwOjdfXG4bJzEQ1sR/593ruuHmN30hvMKObemMf/6joPfa0Jzx7LgwedARx7d
         Ao1g==
X-Forwarded-Encrypted: i=1; AJvYcCWjbkuXrDXj3kRotxFevy+DiGwqUPFBw40AYeN2fuWc+S6iJwWadzo45bpoxiKAh/3J7EkXj7juDpErv1fSlxhQMTTS0kw=
X-Gm-Message-State: AOJu0Yxp19LdCQli4jgOEgwLjvA85F0KYh8X/RZQ5s/D+cgx9LeIBohk
	u9O6mOnuC3asAsOOKbuIygTqf+ItEjEao/pw4lI6wDH0Id/n/XY0nnmCAfOootM=
X-Google-Smtp-Source: AGHT+IEIUJSVoSPi3t2MBsZ2dvfz/1LJj9vQVncVG2ghcK0+/7+9knanVzFgLLeeYdzVVtUXy1E2JQ==
X-Received: by 2002:a05:6a00:cc5:b0:6ea:bb66:9448 with SMTP id b5-20020a056a000cc500b006eabb669448mr3612634pfv.22.1713457961249;
        Thu, 18 Apr 2024 09:32:41 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id b19-20020a056a000a9300b006eae3aac040sm1674755pfl.31.2024.04.18.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:32:40 -0700 (PDT)
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
	Tomasz Jeznach <tjeznach@rivosinc.com>
Subject: [PATCH v2 5/7] iommu/riscv: Device directory management.
Date: Thu, 18 Apr 2024 09:32:23 -0700
Message-Id: <232b2824d5dfd9b8dcb3553bfd506444273c3305.1713456598.git.tjeznach@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713456597.git.tjeznach@rivosinc.com>
References: <cover.1713456597.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce device context allocation and device directory tree
management including capabilities discovery sequence, as described
in Chapter 2.1 of the RISC-V IOMMU Architecture Specification.

Device directory mode will be auto detected using DDTP WARL property,
using highest mode supported by the driver and hardware. If none
supported can be configured, driver will fall back to global pass-through.

First level DDTP page can be located in I/O (detected using DDTP WARL)
and system memory.

Only identity protection domain is supported by this implementation.

Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
---
 drivers/iommu/riscv/iommu.c | 369 +++++++++++++++++++++++++++++++++++-
 drivers/iommu/riscv/iommu.h |   5 +
 2 files changed, 365 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d38317cb2493..721cc71cb959 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -16,6 +16,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -31,13 +32,350 @@ MODULE_LICENSE("GPL");
 /* Timeouts in [us] */
 #define RISCV_IOMMU_DDTP_TIMEOUT	50000
 
-static int riscv_iommu_attach_identity_domain(struct iommu_domain *domain,
-					      struct device *dev)
+/* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
+#define phys_to_ppn(va)  (((va) >> 2) & (((1ULL << 44) - 1) << 10))
+#define ppn_to_phys(pn)	 (((pn) << 2) & (((1ULL << 44) - 1) << 12))
+
+#define dev_to_iommu(dev) \
+	container_of((dev)->iommu->iommu_dev, struct riscv_iommu_device, iommu)
+
+/* Device resource-managed allocations */
+struct riscv_iommu_devres {
+	unsigned long addr;
+	unsigned int order;
+};
+
+static void riscv_iommu_devres_pages_release(struct device *dev, void *res)
+{
+	struct riscv_iommu_devres *devres = res;
+
+	free_pages(devres->addr, devres->order);
+}
+
+static int riscv_iommu_devres_pages_match(struct device *dev, void *res, void *p)
+{
+	struct riscv_iommu_devres *devres = res;
+	struct riscv_iommu_devres *target = p;
+
+	return devres->addr == target->addr;
+}
+
+static unsigned long riscv_iommu_get_pages(struct riscv_iommu_device *iommu, unsigned int order)
+{
+	struct riscv_iommu_devres *devres;
+	struct page *pages;
+
+	pages = alloc_pages_node(dev_to_node(iommu->dev),
+				 GFP_KERNEL_ACCOUNT | __GFP_ZERO, order);
+	if (unlikely(!pages)) {
+		dev_err(iommu->dev, "Page allocation failed, order %u\n", order);
+		return 0;
+	}
+
+	devres = devres_alloc(riscv_iommu_devres_pages_release,
+			      sizeof(struct riscv_iommu_devres), GFP_KERNEL);
+
+	if (unlikely(!devres)) {
+		__free_pages(pages, order);
+		return 0;
+	}
+
+	devres->addr = (unsigned long)page_address(pages);
+	devres->order = order;
+
+	devres_add(iommu->dev, devres);
+
+	return devres->addr;
+}
+
+static void riscv_iommu_free_pages(struct riscv_iommu_device *iommu, unsigned long addr)
+{
+	struct riscv_iommu_devres devres = { .addr = addr };
+
+	devres_release(iommu->dev, riscv_iommu_devres_pages_release,
+		       riscv_iommu_devres_pages_match, &devres);
+}
+
+/* Lookup and initialize device context info structure. */
+static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
+						 unsigned int devid, bool fetch)
+{
+	const bool base_format = !(iommu->caps & RISCV_IOMMU_CAP_MSI_FLAT);
+	unsigned int depth;
+	unsigned long ddt, ptr, old, new;
+	u8 ddi_bits[3] = { 0 };
+	u64 *ddtp = NULL;
+
+	/* Make sure the mode is valid */
+	if (iommu->ddt_mode < RISCV_IOMMU_DDTP_MODE_1LVL ||
+	    iommu->ddt_mode > RISCV_IOMMU_DDTP_MODE_3LVL)
+		return NULL;
+
+	/*
+	 * Device id partitioning for base format:
+	 * DDI[0]: bits 0 - 6   (1st level) (7 bits)
+	 * DDI[1]: bits 7 - 15  (2nd level) (9 bits)
+	 * DDI[2]: bits 16 - 23 (3rd level) (8 bits)
+	 *
+	 * For extended format:
+	 * DDI[0]: bits 0 - 5   (1st level) (6 bits)
+	 * DDI[1]: bits 6 - 14  (2nd level) (9 bits)
+	 * DDI[2]: bits 15 - 23 (3rd level) (9 bits)
+	 */
+	if (base_format) {
+		ddi_bits[0] = 7;
+		ddi_bits[1] = 7 + 9;
+		ddi_bits[2] = 7 + 9 + 8;
+	} else {
+		ddi_bits[0] = 6;
+		ddi_bits[1] = 6 + 9;
+		ddi_bits[2] = 6 + 9 + 9;
+	}
+
+	/* Make sure device id is within range */
+	depth = iommu->ddt_mode - RISCV_IOMMU_DDTP_MODE_1LVL;
+	if (devid >= (1 << ddi_bits[depth]))
+		return NULL;
+
+	/* Get to the level of the non-leaf node that holds the device context */
+	for (ddtp = iommu->ddt_root; depth-- > 0;) {
+		const int split = ddi_bits[depth];
+		/*
+		 * Each non-leaf node is 64bits wide and on each level
+		 * nodes are indexed by DDI[depth].
+		 */
+		ddtp += (devid >> split) & 0x1FF;
+
+		/*
+		 * Check if this node has been populated and if not
+		 * allocate a new level and populate it.
+		 */
+		do {
+			ddt = READ_ONCE(*(unsigned long *)ddtp);
+			if (ddt & RISCV_IOMMU_DDTE_VALID) {
+				ddtp = __va(ppn_to_phys(ddt));
+				break;
+			}
+
+			/* Fetch only, do not allocate new device context. */
+			if (fetch)
+				return NULL;
+
+			ptr = riscv_iommu_get_pages(iommu, 0);
+			if (!ptr)
+				return NULL;
+
+			new = phys_to_ppn(__pa(ptr)) | RISCV_IOMMU_DDTE_VALID;
+			old = cmpxchg_relaxed((unsigned long *)ddtp, ddt, new);
+
+			if (old == ddt) {
+				ddtp = (u64 *)ptr;
+				break;
+			}
+
+			/* Race setting DDT detected, re-read and retry. */
+			riscv_iommu_free_pages(iommu, ptr);
+		} while (1);
+	}
+
+	/*
+	 * Grab the node that matches DDI[depth], note that when using base
+	 * format the device context is 4 * 64bits, and the extended format
+	 * is 8 * 64bits, hence the (3 - base_format) below.
+	 */
+	ddtp += (devid & ((64 << base_format) - 1)) << (3 - base_format);
+
+	return (struct riscv_iommu_dc *)ddtp;
+}
+
+/*
+ * Discover supported DDT modes starting from requested value,
+ * configure DDTP register with accepted mode and root DDT address.
+ * Accepted iommu->ddt_mode is updated on success.
+ */
+static int riscv_iommu_set_ddtp_mode(struct riscv_iommu_device *iommu,
+				     unsigned int ddtp_mode)
+{
+	struct device *dev = iommu->dev;
+	u64 ddtp, rq_ddtp;
+	unsigned int mode, rq_mode = ddtp_mode;
+	int rc;
+
+	rc = readq_relaxed_poll_timeout(iommu->reg + RISCV_IOMMU_REG_DDTP,
+					ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
+					10, RISCV_IOMMU_DDTP_TIMEOUT);
+	if (rc < 0)
+		return -EBUSY;
+
+	/* Disallow state transition from xLVL to xLVL. */
+	switch (FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp)) {
+	case RISCV_IOMMU_DDTP_MODE_BARE:
+	case RISCV_IOMMU_DDTP_MODE_OFF:
+		break;
+	default:
+		if (rq_mode != RISCV_IOMMU_DDTP_MODE_BARE &&
+		    rq_mode != RISCV_IOMMU_DDTP_MODE_OFF)
+			return -EINVAL;
+		break;
+	}
+
+	do {
+		rq_ddtp = FIELD_PREP(RISCV_IOMMU_DDTP_MODE, rq_mode);
+		if (rq_mode > RISCV_IOMMU_DDTP_MODE_BARE)
+			rq_ddtp |= phys_to_ppn(iommu->ddt_phys);
+
+		riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP, rq_ddtp);
+
+		rc = readq_relaxed_poll_timeout(iommu->reg + RISCV_IOMMU_REG_DDTP,
+						ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
+						10, RISCV_IOMMU_DDTP_TIMEOUT);
+		if (rc < 0) {
+			dev_warn(dev, "timeout when setting ddtp (ddt mode: %u, read: %llx)\n",
+				 rq_mode, ddtp);
+			return -EBUSY;
+		}
+
+		/* Verify IOMMU hardware accepts new DDTP config. */
+		mode = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
+
+		if (rq_mode == mode)
+			break;
+
+		/* Hardware mandatory DDTP mode has not been accepted. */
+		if (rq_mode < RISCV_IOMMU_DDTP_MODE_1LVL && rq_ddtp != ddtp) {
+			dev_warn(dev, "DDTP update failed hw: %llx vs %llx\n", ddtp, rq_ddtp);
+			return -EINVAL;
+		}
+
+		/*
+		 * Mode field is WARL, an IOMMU may support a subset of
+		 * directory table levels in which case if we tried to set
+		 * an unsupported number of levels we'll readback either
+		 * a valid xLVL or off/bare. If we got off/bare, try again
+		 * with a smaller xLVL.
+		 */
+		if (mode < RISCV_IOMMU_DDTP_MODE_1LVL &&
+		    rq_mode > RISCV_IOMMU_DDTP_MODE_1LVL) {
+			dev_dbg(dev, "DDTP hw mode %u vs %u\n", mode, rq_mode);
+			rq_mode--;
+			continue;
+		}
+
+		/*
+		 * We tried all supported modes and IOMMU hardware failed to
+		 * accept new settings, something went very wrong since off/bare
+		 * and at least one xLVL must be supported.
+		 */
+		dev_warn(dev, "DDTP hw mode %u, failed to set %u\n", mode, ddtp_mode);
+		return -EINVAL;
+	} while (1);
+
+	iommu->ddt_mode = mode;
+	if (mode != ddtp_mode)
+		dev_warn(dev, "DDTP failover to %u mode, requested %u\n",
+			 mode, ddtp_mode);
+
+	return 0;
+}
+
+static int riscv_iommu_ddt_alloc(struct riscv_iommu_device *iommu)
 {
-	/* Global pass-through already enabled, do nothing for now. */
+	u64 ddtp;
+	unsigned int mode;
+
+	riscv_iommu_readq_timeout(iommu, RISCV_IOMMU_REG_DDTP,
+				  ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
+				  10, RISCV_IOMMU_DDTP_TIMEOUT);
+
+	if (ddtp & RISCV_IOMMU_DDTP_BUSY)
+		return -EBUSY;
+
+	/*
+	 * It is optional for the hardware to report a fixed address for device
+	 * directory root page when DDT.MODE is OFF or BARE.
+	 */
+	mode = FIELD_GET(RISCV_IOMMU_DDTP_MODE, ddtp);
+	if (mode != RISCV_IOMMU_DDTP_MODE_BARE && mode != RISCV_IOMMU_DDTP_MODE_OFF) {
+		/* Use WARL to discover hardware fixed DDT PPN */
+		riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
+				   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, mode));
+		riscv_iommu_readl_timeout(iommu, RISCV_IOMMU_REG_DDTP,
+					  ddtp, !(ddtp & RISCV_IOMMU_DDTP_BUSY),
+					  10, RISCV_IOMMU_DDTP_TIMEOUT);
+		if (ddtp & RISCV_IOMMU_DDTP_BUSY)
+			return -EBUSY;
+
+		iommu->ddt_phys = ppn_to_phys(ddtp);
+		if (iommu->ddt_phys)
+			iommu->ddt_root = devm_ioremap(iommu->dev, iommu->ddt_phys, PAGE_SIZE);
+		if (iommu->ddt_root)
+			memset(iommu->ddt_root, 0, PAGE_SIZE);
+	}
+
+	if (!iommu->ddt_root) {
+		iommu->ddt_root = (u64 *)riscv_iommu_get_pages(iommu, 0);
+		iommu->ddt_phys = __pa(iommu->ddt_root);
+	}
+
+	if (!iommu->ddt_root)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int riscv_iommu_attach_domain(struct riscv_iommu_device *iommu,
+				     struct device *dev,
+				     struct iommu_domain *iommu_domain)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_dc *dc;
+	u64 fsc, ta, tc;
+	int i;
+
+	if (!iommu_domain) {
+		ta = 0;
+		tc = 0;
+		fsc = 0;
+	} else if (iommu_domain->type == IOMMU_DOMAIN_IDENTITY) {
+		ta = 0;
+		tc = RISCV_IOMMU_DC_TC_V;
+		fsc = FIELD_PREP(RISCV_IOMMU_DC_FSC_MODE, RISCV_IOMMU_DC_FSC_MODE_BARE);
+	} else {
+		/* This should never happen. */
+		return -ENODEV;
+	}
+
+	/* Update existing or allocate new entries in device directory */
+	for (i = 0; i < fwspec->num_ids; i++) {
+		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i], !iommu_domain);
+		if (!dc && !iommu_domain)
+			continue;
+		if (!dc)
+			return -ENODEV;
+
+		/* Swap device context, update TC valid bit as the last operation */
+		xchg64(&dc->fsc, fsc);
+		xchg64(&dc->ta, ta);
+		xchg64(&dc->tc, tc);
+
+		/* Device context invalidation will be required. Ignoring for now. */
+	}
+
 	return 0;
 }
 
+static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
+					      struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	/* Global pass-through already enabled, do nothing. */
+	if (iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_BARE)
+		return 0;
+
+	return riscv_iommu_attach_domain(iommu, dev, iommu_domain);
+}
+
 static struct iommu_domain riscv_iommu_identity_domain = {
 	.type = IOMMU_DOMAIN_IDENTITY,
 	.ops = &(const struct iommu_domain_ops) {
@@ -82,6 +420,13 @@ static void riscv_iommu_probe_finalize(struct device *dev)
 	iommu_setup_dma_ops(dev, 0, U64_MAX);
 }
 
+static void riscv_iommu_release_device(struct device *dev)
+{
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
+
+	riscv_iommu_attach_domain(iommu, dev, NULL);
+}
+
 static const struct iommu_ops riscv_iommu_ops = {
 	.owner = THIS_MODULE,
 	.of_xlate = riscv_iommu_of_xlate,
@@ -90,6 +435,7 @@ static const struct iommu_ops riscv_iommu_ops = {
 	.device_group = riscv_iommu_device_group,
 	.probe_device = riscv_iommu_probe_device,
 	.probe_finalize = riscv_iommu_probe_finalize,
+	.release_device = riscv_iommu_release_device,
 };
 
 static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
@@ -124,6 +470,7 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 {
 	iommu_device_unregister(&iommu->iommu);
 	iommu_device_sysfs_remove(&iommu->iommu);
+	riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -133,12 +480,14 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	rc = riscv_iommu_init_check(iommu);
 	if (rc)
 		return dev_err_probe(iommu->dev, rc, "unexpected device state\n");
-	/*
-	 * Placeholder for a complete IOMMU device initialization.
-	 * For now, only bare minimum: enable global identity mapping mode and register sysfs.
-	 */
-	riscv_iommu_writeq(iommu, RISCV_IOMMU_REG_DDTP,
-			   FIELD_PREP(RISCV_IOMMU_DDTP_MODE, RISCV_IOMMU_DDTP_MODE_BARE));
+
+	rc = riscv_iommu_ddt_alloc(iommu);
+	if (WARN(rc, "cannot allocate device directory\n"))
+		goto err_init;
+
+	rc = riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_MAX);
+	if (WARN(rc, "cannot enable iommu device\n"))
+		goto err_init;
 
 	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
 				    dev_name(iommu->dev));
@@ -154,5 +503,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 err_iommu:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_sysfs:
+	riscv_iommu_set_ddtp_mode(iommu, RISCV_IOMMU_DDTP_MODE_OFF);
+err_init:
 	return rc;
 }
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 700e33dc2446..f1696926582c 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -34,6 +34,11 @@ struct riscv_iommu_device {
 	/* available interrupt numbers, MSI or WSI */
 	unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
 	unsigned int irqs_count;
+
+	/* device directory */
+	unsigned int ddt_mode;
+	dma_addr_t ddt_phys;
+	u64 *ddt_root;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
-- 
2.34.1

