Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6115C6
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 03:31:55 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso7468576pjc.1
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 20:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680233515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3buwZbi8UwI0JR//L3crQYz+6oBSYG/M98AK9MATFQ=;
        b=fuXLi9xSbUbEqkJl8uhdtJ/06Tw8zfHYGi67/DwMDHhe9fm0v2lm456H2gONn3NQUf
         noUEGMu+esSuCuuBBZ2RPOSk8SaM3R23iA8p9ufRQatKbY1MNQPD0c9hVGonNQZepGSE
         Ghmh9pxzTdl/m+bVPbVyCidDReb56ZQaxuZAYkNkYG2gT5QYGCsp3LbMVjgnoXEGh3+A
         321W0QSzv/7KMFCJr7AFZdmJ0Teu3cSXPD9WGjAY44zJGh/ANQr3KI6hryKaB0e8z1kJ
         j0oyDP1TlfXnvSMjFr69dOF1pQ8ncx377nWzpC1BW940nw2SNwGWsu0gl+Bj3mNlGDCK
         aRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680233515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3buwZbi8UwI0JR//L3crQYz+6oBSYG/M98AK9MATFQ=;
        b=Fhk3Br9PE/Xs2MDbpvXm+Oaulcbh/SgXacT7wmA0HrEyUhjPYvUfvTeXZIUvSEaAlC
         42A/YsSiKNvyekbAvfO0PnWu+1WWhC8HHRWpgNpYjIOLqIWdhyC0xvSOjZKdCXuQO+iz
         Ou5WT/3gtEkn7gjfbwTK4gZ4xaIvK2w0IS92mihOiMrQKMdGKSi/06UvIG14qXoP4AF7
         ptlDiR3Nda5G4yHjZnB1+mjMqQ3IgW+9LmZ34vy0630xkpyK+DOqoimDNCGNdgSll2gi
         yRdn0yKbOk+SmvlQmHxa1EP0cKylWQciMMb9SBHrXZzbr1ApU8wt+tF7skcfvv+KifTK
         nrQg==
X-Gm-Message-State: AAQBX9dLU18ky/ZxN/BmieC8zAF8c04GJwViRLl/vwMseadS+NeNBTbb
	Ur6PdzEdpo4C6arfOHTwmqk=
X-Google-Smtp-Source: AKy350YtID6gCA0syz1/NyDJ5v5uxsRZsPlZpvjDe6NNnTvhOlKsawpswgbD23v1bJCkAC6ufr4oXw==
X-Received: by 2002:a17:90a:db97:b0:236:6a28:f784 with SMTP id h23-20020a17090adb9700b002366a28f784mr28430263pjv.3.1680233514896;
        Thu, 30 Mar 2023 20:31:54 -0700 (PDT)
Received: from ubt.spreadtrum.com ([138.113.14.245])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902eac400b001a239325f1csm449128pld.100.2023.03.30.20.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 20:31:54 -0700 (PDT)
From: Chunyan Zhang <zhang.lyra@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V3 1/2] iommu: sprd: release dma buffer to avoid memory leak
Date: Fri, 31 Mar 2023 11:31:23 +0800
Message-Id: <20230331033124.864691-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331033124.864691-1-zhang.lyra@gmail.com>
References: <20230331033124.864691-1-zhang.lyra@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

When attaching to a domain, the driver would alloc a DMA buffer which
is used to store address mapping table, and it need to be released
when the IOMMU domain is freed.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/iommu/sprd-iommu.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..7df1f730c778 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -151,13 +151,6 @@ static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
 	return &dom->domain;
 }
 
-static void sprd_iommu_domain_free(struct iommu_domain *domain)
-{
-	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
-
-	kfree(dom);
-}
-
 static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
 {
 	struct sprd_iommu_device *sdev = dom->sdev;
@@ -230,6 +223,28 @@ static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
 	sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
 }
 
+static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
+{
+	size_t pgt_size;
+
+	/* Nothing need to do if the domain hasn't been attached */
+	if (!dom->sdev)
+		return;
+
+	pgt_size = sprd_iommu_pgt_size(&dom->domain);
+	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
+	dom->sdev = NULL;
+	sprd_iommu_hw_en(dom->sdev, false);
+}
+
+static void sprd_iommu_domain_free(struct iommu_domain *domain)
+{
+	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
+
+	sprd_iommu_cleanup(dom);
+	kfree(dom);
+}
+
 static int sprd_iommu_attach_device(struct iommu_domain *domain,
 				    struct device *dev)
 {
-- 
2.25.1

