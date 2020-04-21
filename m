Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF026C54FC9
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 16:09:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FC92068F
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rL9EGCnD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FC92068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 63BE2884D8;
	Tue, 21 Apr 2020 16:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PkxH+Sk5WXGM; Tue, 21 Apr 2020 16:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9F27884D6;
	Tue, 21 Apr 2020 16:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1729C1797;
	Tue, 21 Apr 2020 16:09:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFF80C0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 16:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DBC44884D9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 16:09:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fPgLTAcj1TyG for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 16:09:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1E568884D6
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 16:09:46 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id v8so2878678wma.0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c5KYJYYVZWjaCwxDwO74zJzw8wEte600mPboCoS5M8Q=;
 b=rL9EGCnDks23VFlrEYYGotlJpwk1uvfVBC5fgQWivos8Ni23QvOXP18QnUHuVcaGs3
 dQJJ8cDne41fya/re0nyXhz1y9IX7PyZ/VTtpxIc39JIojIs6XHqZJ18whpREk5LYSW5
 xUttGOdjbRaoFESgWRigBB1Puaxc8KDBVVyxcWhCosBZV7XOZVPhjjXyI6uA7GCsP76k
 2qvkHg7R8LMhB8nSFVKv5mZ0M9LUzqkgk+RQ2FUhYEzpvUNIwuaR+GWhXFIEKwaP88zV
 4e+hCjGP/Bve3JWeCUnWnr7SFcAVnkl4TDKYgAlcDuh5MujSVhN3cc8egUoLj78/FPe0
 IxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c5KYJYYVZWjaCwxDwO74zJzw8wEte600mPboCoS5M8Q=;
 b=DtbQHgrilBz2aVVpQfg85ywcZNRlJjBVxiNr7x7s9HIQRm9qZublrXHW/NeCB4uq7A
 wcZ+HMcnetE+IVr7II/PYJq5PGX3cHm/Db9f7tkZNBy1wrtmkkLxGLVkMCr8XRE34WZ1
 9++uAyW9e8+b/cpav0FpLXgCluWCsRVoHCbMrJFMoPCyOVRlcfJ6rMylqw9LYzo7cYpC
 ao/Ep67XEKscry5qrxqef+Wm6XI0rFpRRQiu7Dj5TPmiQrZJRyluAX4oOJNARQlZQ50E
 7IqOTnyHIVVOWR6dxiWiPIXm1tWsxA44GMEHxCSqYKQc2gIOfG2rIf2XE6XJ8N7bilg9
 /1MQ==
X-Gm-Message-State: AGi0Puakeo6NU055TYk40YeWHVmDJ5F9uhRXwb7Qaa/6cVHqzDOfViuO
 noIJzH4e9HbV2Bgid/jeLe715g==
X-Google-Smtp-Source: APiQypIa5Npj9XzlSyuaBswyPsPEsYezdYr8hpfMJKHXSaoJb+F+8lXDQk9AGw64W3s+HTJLDMfYPg==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr5230614wml.132.1587485384639; 
 Tue, 21 Apr 2020 09:09:44 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id q143sm4284618wme.31.2020.04.21.09.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:09:43 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	mark.rutland@arm.com
Subject: [PATCH] perf/smmuv3: Allow sharing MMIO registers with the SMMU driver
Date: Tue, 21 Apr 2020 17:57:46 +0200
Message-Id: <20200421155745.19815-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Some Arm SMMUv3 implementations, for example Arm CoreLink MMU-600, embed
the PMCG registers into the SMMU MMIO regions. It currently causes probe
failure because the PMU and SMMU drivers request overlapping resources.

Avoid the conflict by calling devm_ioremap() directly from the PMU
driver. We loose some sanity-checking of the memory map provided by
firmware, which doesn't seem catastrophic.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---

So this is the simplest solution, and I don't think we're missing much
by skipping the resource reservation. I've also been exploring a more
complex approach [1] which has the SMMU driver perform resource
reservation on behalf of the PMU driver, but I'm not sure it's
necessary.

Please test, I've only tried the RevC FastModel using devicetree so far.

[1] https://jpbrucker.net/git/linux/log/?h=smmu/pmu
---
 drivers/perf/arm_smmuv3_pmu.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index ca183a53a7f10..ad63d1e73333f 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -730,8 +730,8 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
+	struct resource *res_0, *res_1;
 	struct smmu_pmu *smmu_pmu;
-	struct resource *res_0;
 	u32 cfgr, reg_size;
 	u64 ceid_64[2];
 	int irq, err;
@@ -759,18 +759,32 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
 	};
 
+	/*
+	 * If the PMCG registers are embedded into the SMMU regions, the
+	 * resources have to be shared with the SMMU driver. Use ioremap()
+	 * rather than ioremap_resource() to avoid conflicts.
+	 */
 	res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
-	if (IS_ERR(smmu_pmu->reg_base))
-		return PTR_ERR(smmu_pmu->reg_base);
+	if (!res_0)
+		return -ENXIO;
+
+	smmu_pmu->reg_base = devm_ioremap(dev, res_0->start,
+					  resource_size(res_0));
+	if (!smmu_pmu->reg_base)
+		return -ENOMEM;
 
 	cfgr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_CFGR);
 
 	/* Determine if page 1 is present */
 	if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
-		smmu_pmu->reloc_base = devm_platform_ioremap_resource(pdev, 1);
-		if (IS_ERR(smmu_pmu->reloc_base))
-			return PTR_ERR(smmu_pmu->reloc_base);
+		res_1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res_1)
+			return -ENXIO;
+
+		smmu_pmu->reloc_base = devm_ioremap(dev, res_1->start,
+						    resource_size(res_1));
+		if (!smmu_pmu->reloc_base)
+			return -ENOMEM;
 	} else {
 		smmu_pmu->reloc_base = smmu_pmu->reg_base;
 	}
-- 
2.26.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
