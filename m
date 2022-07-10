Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D13C2F
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 23:06:12 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so1269949wmc.3
        for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2PeNTtURN4eXiGBF6CxKQXSRiBt5jDvHMJleZnMrb8=;
        b=SfvM5oJytjZQ0qgq6y6BcnOrkFe6G++JtjOTDQFIQy2kgaAxgwLpB5KAEhdQ4dKMz8
         HoBc+ochk9ozAdgUZ13Hd59aOuAajgWW+mcNk2uZta1Rod3/cklDhVfxVNBZLtY6j3n9
         DMs9Rfu47zEtjoLQm4yf2J0eUMwvOXkXwrh3RIy3Eavm7GoxQ85kk/KYwqOAe32aIaHr
         Hx4M1hZpVcUo0CZp3kcDklEjgh4BRVuFJR/GVf1kBEiFg4rxNH3WY6BU5dkBDHxSugGZ
         fxOCN3PTL3wdpk3L8tQiP5NSQwhY5JCCh1Lm4StdUnkpP2qNOUb7MtzEWBes5MwEu43z
         89Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2PeNTtURN4eXiGBF6CxKQXSRiBt5jDvHMJleZnMrb8=;
        b=JRZ9W8StCjn2GlQulcdqr+EHb78rloMQVzVM3fOA8qA76ic6OJKb6gacdCQE9nEJd1
         6/jRSEt5ZZ95qMxFPgiNxE+yiIUgB4szt+cdYnyD234VIeAEyEXJC/NCszyJlCb3I192
         NgkLwYPx7WlUHsbclEXhzM6aDzaI9Ys589+Sw/XnbUpF0GODKeas3k30y+ho8K6MQNBD
         oII5dPFgjshaCGY05bjX4KqrWuGCzfsKl+fermcTcuGHEydX7xcXp63Q+y9CluyWef+Q
         ZnSpVkatbBwsSC9umBbA5E6g57yQOXEptTxms7ZtIZ1tl0ohH/ogzfxmtcWYSCSF2kMB
         579w==
X-Gm-Message-State: AJIora8uVFSEqeq2QP6GbyIzWS1PuUjy1qv+xyc7iMIOyJRVOLDYmNjV
	H2y93k+2Yf7JEpr5mLtLGI4OtWSa7rl4+rMd
X-Google-Smtp-Source: AGRyM1sZmV2sI4U7V2nh9Zjsi3UJqRjqwe+PtYS7xEw2DVSpOkpBC8oL9Ojd/vLUIfssJW2LX5R2Pg==
X-Received: by 2002:a05:600c:210d:b0:3a2:e686:e14 with SMTP id u13-20020a05600c210d00b003a2e6860e14mr3277007wml.25.1657494370779;
        Sun, 10 Jul 2022 16:06:10 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id k1-20020adfd841000000b0021d73772c87sm4398867wrl.91.2022.07.10.16.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:10 -0700 (PDT)
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
Subject: [PATCH v2 5/7] iommu/exynos: Check if SysMMU v7 has VM registers
Date: Mon, 11 Jul 2022 02:06:01 +0300
Message-Id: <20220710230603.13526-6-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SysMMU v7 can have Virtual Machine registers, which implement multiple
translation domains. The driver should know if it's true or not, as VM
registers shouldn't be accessed if not present. Read corresponding
capabilities register to obtain that info, and store it in driver data.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v2:
  - Removed the 'const' qualifier for local non-pointer variables

 drivers/iommu/exynos-iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 0cb1ce10db51..48681189ccf8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -135,6 +135,9 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CFG_SYSSEL	(1 << 22) /* System MMU 3.2 only */
 #define CFG_FLPDCACHE	(1 << 20) /* System MMU 3.2+ only */
 
+#define CAPA0_CAPA1_EXIST		BIT(11)
+#define CAPA1_VCR_ENABLED		BIT(14)
+
 /* common registers */
 #define REG_MMU_VERSION		0x034
 
@@ -154,6 +157,10 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define REG_V5_FAULT_AR_VA	0x070
 #define REG_V5_FAULT_AW_VA	0x080
 
+/* v7.x registers */
+#define REG_V7_CAPA0		0x870
+#define REG_V7_CAPA1		0x874
+
 #define has_sysmmu(dev)		(dev_iommu_priv_get(dev) != NULL)
 
 enum {
@@ -298,6 +305,9 @@ struct sysmmu_drvdata {
 
 	struct iommu_device iommu;	/* IOMMU core handle */
 	const unsigned int *regs;	/* register set */
+
+	/* v7 fields */
+	bool has_vcr;			/* virtual machine control register */
 };
 
 static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
@@ -411,11 +421,27 @@ static void __sysmmu_get_version(struct sysmmu_drvdata *data)
 		MMU_MAJ_VER(data->version), MMU_MIN_VER(data->version));
 }
 
+static bool __sysmmu_has_capa1(struct sysmmu_drvdata *data)
+{
+	u32 capa0 = readl(data->sfrbase + REG_V7_CAPA0);
+
+	return capa0 & CAPA0_CAPA1_EXIST;
+}
+
+static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
+{
+	u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
+
+	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
+}
+
 static void sysmmu_get_hw_info(struct sysmmu_drvdata *data)
 {
 	__sysmmu_enable_clocks(data);
 
 	__sysmmu_get_version(data);
+	if (MMU_MAJ_VER(data->version) >= 7 && __sysmmu_has_capa1(data))
+		__sysmmu_get_vcr(data);
 	if (MMU_MAJ_VER(data->version) < 5)
 		data->regs = sysmmu_regs[REG_SET_V1];
 	else
-- 
2.30.2

