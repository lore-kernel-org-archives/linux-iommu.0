Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB3B1FD8
	for <iommu@lists.linux.dev>; Sat,  2 Jul 2022 21:37:29 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id z19so6942197edb.11
        for <iommu@lists.linux.dev>; Sat, 02 Jul 2022 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxNfqvGh9Dkg/Ylz1u5K33HiEHJDlDTxa5n3A3ldybk=;
        b=Me94KsgF2l25/VtjClrzXOurY47uvCOFfBo96GNvQ0dqyBJGRWw0HvuryG16InIHsg
         42ueHTmWL+quG64V1G7HkyB5jmP+xIMed8FLl7P0xqZQgaOn4opESi/YnArBL8Yv3B+I
         oO/Tf4+yWiRBPYAvjIDHFuTtSPEORWhHF67IltYBGUiqSUfXEdnUmvk22x1prSXi6pnj
         Etc0PbRfKOZgZ9Iex/as0SOwJuP7HTIPwaYmwgHWudeNdflB8n+BMO3V+6xqHrU3gGLP
         3UgWOFoCQ1iMyu2FWwqsYThO7W6BWAbl0FkEwOWAMqyOHVpcZi0VNPQINV7VLbc42jf9
         Q50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxNfqvGh9Dkg/Ylz1u5K33HiEHJDlDTxa5n3A3ldybk=;
        b=HZZiBnIU+O59ZjWCt4BIwhQpwUoEmOHdJH9Oj+Mlx/mvQzOU8H1dfYfL5XWiLLLF6O
         iMW8YPNa8qL+aHbsAjtzhrJj16BQnZm+Hsakmvu98r62ozA3pUQxtjMaTIFiDMd0P/PM
         8EBfN0tzADnENmuA1jwSGXSjzmp2kZyjk16A6v3zlRJujyZIhsz+pJiH7Tak9Fr9oa7u
         JBY/EfsVCpZcvFSVTqjAxbLOELwDzyy3neXNB/b0Xo806ShGfRCf0ocwmZtXbqArwPb/
         mqXDeseRPqNcmVNuQkFiFnDF5aE8llIHf/7sPgn0jws9bWyF5o3ZruoSLSQNIcyDIyJs
         b/zw==
X-Gm-Message-State: AJIora+EvRcBNZbYjdCWUpxr+VmfIVWFepj2z/VvUN20sJaEwUr0x0D2
	+H7Pcq8eKdK7XPf4d0Bgjg4/Ng==
X-Google-Smtp-Source: AGRyM1tDG6oe9EA4EzWZYsEDwSxNJe8GVmy2A/vhPa0sP6AZ1JAP27WJ8w7/4ZBkoKA+0ySR6z8AtA==
X-Received: by 2002:a05:6402:1774:b0:435:7fea:8c02 with SMTP id da20-20020a056402177400b004357fea8c02mr27855122edb.213.1656797847559;
        Sat, 02 Jul 2022 14:37:27 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id s8-20020a508dc8000000b00435c10b5daesm17297032edh.34.2022.07.02.14.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 14:37:27 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux-foundation.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iommu/exynos: Check if SysMMU v7 has VM registers
Date: Sun,  3 Jul 2022 00:37:22 +0300
Message-ID: <20220702213724.3949-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220702213724.3949-1-semen.protsenko@linaro.org>
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20220702213722.8yNWFZBU8MuASlMwIQnRX1exU0o5JzC9g5GEbUP1NGU@z>

SysMMU v7 can have Virtual Machine registers, which implement multiple
translation domains. The driver should know if it's true or not, as VM
registers shouldn't be accessed if not present. Read corresponding
capabilities register to obtain that info, and store it in driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 42 ++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 28f8c8d93aa3..df6ddbebbe2b 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CAPA0_CAPA1_EXIST		BIT(11)
+#define CAPA1_VCR_ENABLED		BIT(14)
+
 /* common registers */
 #define REG_MMU_CTRL		0x000
 #define REG_MMU_CFG		0x004
@@ -171,6 +174,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
+/* v7.x registers */
+#define REG_V7_CAPA0		0x870
+#define REG_V7_CAPA1		0x874
+
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
 static struct device *dma_dev;
@@ -274,6 +281,9 @@ struct sysmmu_drvdata {
 	unsigned int version;		/* our version */
 
 	struct iommu_device iommu;	/* IOMMU core handle */
+
+	/* v7 fields */
+	bool has_vcr;			/* virtual machine control register */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -364,11 +374,7 @@ static void __sysmmu_disable_clocks(struct sysmmu_drvdata *data)
 
 static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 {
-	u32 ver;
-
-	__sysmmu_enable_clocks(data);
-
-	ver = readl(data->sfrbase + REG_MMU_VERSION);
+	const u32 ver = readl(data->sfrbase + REG_MMU_VERSION);
 
 	/* controllers on some SoCs don't report proper version */
 	if (ver == 0x80000001u)
@@ -378,6 +384,29 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 
 	dev_dbg(data->sysmmu, "hardware version: %d.%d\n",
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
+}
+
+static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
+{
+	const u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
+
+	return capa0 & CAPA0_CAPA1_EXIST;
+}
+
+static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
+{
+	const u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
+
+	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
+}
+
+static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
+{
+	__sysmmu_enable_clocks(data);
+
+	__sysmmu_get_version(data);
+	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
+		__sysmmu_get_vcr(data);
 
 	__sysmmu_disable_clocks(data);
 }
@@ -623,6 +652,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	data->sysmmu = dev;
 	spin_lock_init(&data->lock);
 
+	sysmmu_get_hw_info(data);
+
 	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
 				     dev_name(data->sysmmu));
 	if (ret)
@@ -634,7 +665,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	__sysmmu_get_version(data);
 	if (PG_ENT_SHIFT < 0) {
 		if (MMU_MAJ_VER(data->version) < 5) {
 			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
-- 
2.30.2

