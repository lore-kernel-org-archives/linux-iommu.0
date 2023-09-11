Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D63CC13C;
	Mon, 11 Sep 2023 19:02:27 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99cce6f7de2so609695466b.3;
        Mon, 11 Sep 2023 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694458945; x=1695063745; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3y2BGukH6url/m3nyh3PLmZ/imBVQiEyAeDipRiBwe0=;
        b=WZaoUIp1p2zZJMjiXH3HmSPSUGNkO4zTlppGqwwfneohDoIP7PV32HC898b+bEpt3+
         heJVM3MwiqJXocCV0ftXvAaWgkJ/jlr0KRzW+j+aQHqTzmakgnBhFZpIFy7W5ZRVe7yh
         fu0e/83H48m20wygnOwZzLsdmvww4j9ITZSPFdZ00f3A9OHe8JZNX860iZiO5d7JDOGM
         UC9uSHdwtmUqeiAP/ClkvrFoxSLVGx96fBFGEv19lOoKN4n/pAfdoyJyrO8yaBSF4Do3
         0AH31arXUehjb2u6g40Ry4MKmaK2dQa/lE8LTUceItGh0gbkyv16tiglm9QMamDSWeLr
         1p1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694458945; x=1695063745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y2BGukH6url/m3nyh3PLmZ/imBVQiEyAeDipRiBwe0=;
        b=lr2h74XNFswcGv2kDY0PCYkMOzAl1eGK8mRe73K9SyNQeq3rtR2U0DS4dSfX4IJWjY
         HSaVCFPBiGB/eNDBDTmmR5QqoHPenGbLgCR9SfsktMndh8uNWu6ccObECq12FIXMr3F8
         ehYqVFV943PxGmLnV+0TbUMlRcmAc9iZr4tGGL7ES1CNT2yN31Wda/1Uh2lOgYNE5Pxw
         aYVGoaU1UMrNSfmJ2nfbsjgBIfDAEhUm0NKkyHMrMiXWEpBAFHDlklkEtDvar1ut7OIW
         78biprDRCjyS40Zrcq9eHNjkshoZdds/dHnyt5LcjN3ebXw/hfVBe80nJXR4XdjCAl+F
         7zdg==
X-Gm-Message-State: AOJu0Yz3+sgO0Nbdmz58I2DSJzX6+oQzHmF8vnROm0vdlHtoQ0uxgHse
	RRCOMRQ9b+D4i0EhVr2YbFQ=
X-Google-Smtp-Source: AGHT+IFpgox4BFKnt0rNPbRceB2bQ3Z76YQCI6/Tvh13dhWuZo0yy8xGtqPL7TTMQCkN8A9GyXFFKg==
X-Received: by 2002:a17:906:2189:b0:99b:de31:6666 with SMTP id 9-20020a170906218900b0099bde316666mr8837593eju.22.1694458945409;
        Mon, 11 Sep 2023 12:02:25 -0700 (PDT)
Received: from localhost.localdomain (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id re1-20020a170906d8c100b00993a37aebc5sm5697324ejb.50.2023.09.11.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:02:25 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com
Cc: wens@csie.org,
	samuel@sholland.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] iommu/sun50i: Allow page sizes between 4K and 1M
Date: Mon, 11 Sep 2023 21:02:18 +0200
Message-ID: <20230911190218.1758812-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While peripheral supports only 4K page sizes, we can easily emulate
support for bigger page sizes, up to 1M. This is done by making multiple
entries in map function or clearing multiple entries in unmap.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 49 +++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 74c5cb93e900..93077575d60f 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -95,6 +95,10 @@
 
 #define SPAGE_SIZE			4096
 
+#define SUN50I_IOMMU_PGSIZES		(SZ_4K | SZ_8K | SZ_16K | SZ_32K | \
+					 SZ_64K | SZ_128K | SZ_256K | \
+					 SZ_512K | SZ_1M)
+
 struct sun50i_iommu {
 	struct iommu_device iommu;
 
@@ -593,10 +597,12 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
-	u32 pte_index;
+	u32 pte_index, pages, i;
 	u32 *page_table, *pte_addr;
 	int ret = 0;
 
+	pages = size / SPAGE_SIZE;
+
 	page_table = sun50i_dte_get_page_table(sun50i_domain, iova, gfp);
 	if (IS_ERR(page_table)) {
 		ret = PTR_ERR(page_table);
@@ -604,18 +610,22 @@ static int sun50i_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	}
 
 	pte_index = sun50i_iova_get_pte_index(iova);
-	pte_addr = &page_table[pte_index];
-	if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
-		phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
-		dev_err(iommu->dev,
-			"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
-			&iova, &page_phys, &paddr, prot);
-		ret = -EBUSY;
-		goto out;
+	for (i = 0; i < pages; i++) {
+		pte_addr = &page_table[pte_index + i];
+		if (unlikely(sun50i_pte_is_page_valid(*pte_addr))) {
+			phys_addr_t page_phys = sun50i_pte_get_page_address(*pte_addr);
+
+			dev_err(iommu->dev,
+				"iova %pad already mapped to %pa cannot remap to %pa prot: %#x\n",
+				&iova, &page_phys, &paddr, prot);
+			ret = -EBUSY;
+			goto out;
+		}
+		*pte_addr = sun50i_mk_pte(paddr, prot);
+		paddr += SPAGE_SIZE;
 	}
 
-	*pte_addr = sun50i_mk_pte(paddr, prot);
-	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	sun50i_table_flush(sun50i_domain, &page_table[pte_index], pages);
 
 out:
 	return ret;
@@ -626,8 +636,10 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	phys_addr_t pt_phys;
+	u32 dte, pages, i;
 	u32 *pte_addr;
-	u32 dte;
+
+	pages = size / SPAGE_SIZE;
 
 	dte = sun50i_domain->dt[sun50i_iova_get_dte_index(iova)];
 	if (!sun50i_dte_is_pt_valid(dte))
@@ -636,13 +648,14 @@ static size_t sun50i_iommu_unmap(struct iommu_domain *domain, unsigned long iova
 	pt_phys = sun50i_dte_get_pt_address(dte);
 	pte_addr = (u32 *)phys_to_virt(pt_phys) + sun50i_iova_get_pte_index(iova);
 
-	if (!sun50i_pte_is_page_valid(*pte_addr))
-		return 0;
+	for (i = 0; i < pages; i++)
+		if (!sun50i_pte_is_page_valid(pte_addr[i]))
+			return 0;
 
-	memset(pte_addr, 0, sizeof(*pte_addr));
-	sun50i_table_flush(sun50i_domain, pte_addr, 1);
+	memset(pte_addr, 0, sizeof(*pte_addr) * pages);
+	sun50i_table_flush(sun50i_domain, pte_addr, pages);
 
-	return SZ_4K;
+	return size;
 }
 
 static phys_addr_t sun50i_iommu_iova_to_phys(struct iommu_domain *domain,
@@ -827,7 +840,7 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 }
 
 static const struct iommu_ops sun50i_iommu_ops = {
-	.pgsize_bitmap	= SZ_4K,
+	.pgsize_bitmap	= SUN50I_IOMMU_PGSIZES,
 	.device_group	= sun50i_iommu_device_group,
 	.domain_alloc	= sun50i_iommu_domain_alloc,
 	.of_xlate	= sun50i_iommu_of_xlate,
-- 
2.42.0

