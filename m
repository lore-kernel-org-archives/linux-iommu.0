Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D11601C
	for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 20:07:44 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id va17so28131304ejb.0
        for <iommu@lists.linux.dev>; Tue, 26 Jul 2022 13:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=upg6JemQobvxpbvcYkGZTE7woCjfAjYx23pabDH6S70=;
        b=KY2REAUeTrxKpGxnAFQJ6G5IfIIF7/usG+WAYcQ8mBBct/cgEIHf6gFa/H+I97ylFy
         hO1ugpx1K4FDC5+1Wl7nAV9YHIQyhQbkcjR2tCZxnHCqEpsNB5uaRlmAx+c3TMVg8gKD
         WnFmR3DAUnG1WBLjo5jWhavTgSHvkMUmDsVBNnoeG9uK2ncFB5aB70Qh2lk4LzP597mz
         iTzEPubySBp2IOKJeqrNSb3Ka09PUGVChg3I2f1ahx/QZJjVOoNRruThA0rztxT4Avaz
         NB89vxSGFOX4UK0OXQ1w8q8f0uCXY0qLSOB+pn5P6EZZfi34THjmmuttz+9Gz2oJtEm+
         GQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=upg6JemQobvxpbvcYkGZTE7woCjfAjYx23pabDH6S70=;
        b=ILl7upydW+mzp05cm3nE6dAjyOALhE2390hL46fGBHXfb9tSwfqNWGocQJQSuIdW/u
         8EQUoiLKsWxEeNjYX0VIx7BjEzQPpkxTsGwhUnM7lT5ozBXRaWlvLAu6tLCENjthjdYM
         OSn2PwbrvNUC1RbzUiLe7+dKxaUoVRbjQn9sR42EGCjDDkGmA2sYQ0qcBrFzNTf3pZ0r
         PFsG/AoQFmjkW3MhIexB5VBoTasXtmtyk4BDc9O5Kt9riBupDY5qVT6LeisHRAZalUxN
         zUHkwyS6kSStNYHdHbaeBrvs/LJYZEBTxlesRRyeiIr2O2bpypU3JRbwNesvh8syi3yv
         pcyw==
X-Gm-Message-State: AJIora/niq+JCaNQU/viWlwUlLeUYQ9MnkzcTJjHie1qHtqyVwDuFMNb
	qjK2j01X7DitwgNicju2ePU6iw==
X-Google-Smtp-Source: AGRyM1tv8wHXbb3eS/p+8L9YeTdBUJHXMCzexwSOl616wnPkWcjsERUOZMKK3rw0gqgrbcuNtcqbRg==
X-Received: by 2002:a17:907:9620:b0:72b:5822:93d0 with SMTP id gb32-20020a170907962000b0072b582293d0mr15931780ejc.235.1658866063225;
        Tue, 26 Jul 2022 13:07:43 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0564021ad100b0043c87da1ab6sm862947edb.48.2022.07.26.13.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:07:42 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/exynos: Implement fault handling on SysMMU v7
Date: Tue, 26 Jul 2022 23:07:39 +0300
Message-Id: <20220726200739.30017-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220726200739.30017-1-semen.protsenko@linaro.org>
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SysMMU v7 has a bit different registers for getting the fault info:
  - there is one single register (MMU_FAULT_VA) to get the fault address
  - fault access type (R/W) can be read from MMU_FAULT_TRANS_INFO
    register now
  - interrupt status register has different bits w.r.t. previous SysMMU
    versions
  - VM and non-VM layouts have different register addresses

Add correct fault handling implementation for SysMMU v7, according to
all mentioned differences. Only VID #0 (default) is handled, as VM
domains support is not implemented yet.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 48 +++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 766d409e084a..ac47c796741b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -217,6 +217,13 @@ static const char * const sysmmu_v5_fault_names[] = {
 	"SECURITY PROTECTION"
 };
 
+static const char * const sysmmu_v7_fault_names[] = {
+	"PTW",
+	"PAGE",
+	"ACCESS PROTECTION",
+	"RESERVED"
+};
+
 /*
  * This structure is attached to dev->iommu->priv of the master device
  * on device add, contains a list of SYSMMU controllers defined by device tree,
@@ -260,6 +267,8 @@ struct sysmmu_variant {
 	u32 flush_end;		/* end address of range invalidation */
 	u32 int_status;		/* interrupt status information */
 	u32 int_clear;		/* clear the interrupt */
+	u32 fault_va;		/* IOVA address that caused fault */
+	u32 fault_info;		/* fault transaction info */
 
 	int (*get_fault_info)(struct sysmmu_drvdata *data, unsigned int itype,
 			      struct sysmmu_fault *fault);
@@ -337,6 +346,19 @@ static int exynos_sysmmu_v5_get_fault_info(struct sysmmu_drvdata *data,
 	return 0;
 }
 
+static int exynos_sysmmu_v7_get_fault_info(struct sysmmu_drvdata *data,
+					   unsigned int itype,
+					   struct sysmmu_fault *fault)
+{
+	u32 info = readl(SYSMMU_REG(data, fault_info));
+
+	fault->addr = readl(SYSMMU_REG(data, fault_va));
+	fault->name = sysmmu_v7_fault_names[itype % 4];
+	fault->type = (info & BIT(20)) ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ;
+
+	return 0;
+}
+
 /* SysMMU v1..v3 */
 static const struct sysmmu_variant sysmmu_v1_variant = {
 	.flush_all	= 0x0c,
@@ -348,7 +370,7 @@ static const struct sysmmu_variant sysmmu_v1_variant = {
 	.get_fault_info	= exynos_sysmmu_v1_get_fault_info,
 };
 
-/* SysMMU v5 and v7 (non-VM capable) */
+/* SysMMU v5 */
 static const struct sysmmu_variant sysmmu_v5_variant = {
 	.pt_base	= 0x0c,
 	.flush_all	= 0x10,
@@ -362,7 +384,23 @@ static const struct sysmmu_variant sysmmu_v5_variant = {
 	.get_fault_info	= exynos_sysmmu_v5_get_fault_info,
 };
 
-/* SysMMU v7: VM capable register set */
+/* SysMMU v7: non-VM capable register layout */
+static const struct sysmmu_variant sysmmu_v7_variant = {
+	.pt_base	= 0x0c,
+	.flush_all	= 0x10,
+	.flush_entry	= 0x14,
+	.flush_range	= 0x18,
+	.flush_start	= 0x20,
+	.flush_end	= 0x24,
+	.int_status	= 0x60,
+	.int_clear	= 0x64,
+	.fault_va	= 0x70,
+	.fault_info	= 0x78,
+
+	.get_fault_info	= exynos_sysmmu_v7_get_fault_info,
+};
+
+/* SysMMU v7: VM capable register layout */
 static const struct sysmmu_variant sysmmu_v7_vm_variant = {
 	.pt_base	= 0x800c,
 	.flush_all	= 0x8010,
@@ -372,8 +410,10 @@ static const struct sysmmu_variant sysmmu_v7_vm_variant = {
 	.flush_end	= 0x8024,
 	.int_status	= 0x60,
 	.int_clear	= 0x64,
+	.fault_va	= 0x1000,
+	.fault_info	= 0x1004,
 
-	.get_fault_info	= exynos_sysmmu_v5_get_fault_info,
+	.get_fault_info	= exynos_sysmmu_v7_get_fault_info,
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -496,7 +536,7 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 		if (data->has_vcr)
 			data->variant = &sysmmu_v7_vm_variant;
 		else
-			data->variant = &sysmmu_v5_variant;
+			data->variant = &sysmmu_v7_variant;
 	}
 
 	__sysmmu_disable_clocks(data);
-- 
2.30.2

