Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BE9148315
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064967; cv=none; b=nnZTp86YnlXr/j8lXFXMOPU3BrVnU8j3xI9D6xbq/BiZDZROeNvz4VfyWq/f83X2oTSjanwqGuU1Hcrv7wRzpNqYi/HlOo3bi5i4y7eM/75uiXr90rD0zFCmIFC6+m3tPcL1H9vw0Ohpo9okqrhlAWgymxa/LEtisfJlT7RGvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064967; c=relaxed/simple;
	bh=28eiBx9PmX31DIEiab35EHBlvPR50wHVwNErjmfAAuc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CXfAfLl3FHsRwyRSsi6UQ/FtLLZQU31i7z3ncZJcROFFxcEh5a1qpHuGfkKmZzQdQPC6nm4eMDM2lirY8ycO7aEA8XIYGPBKLw4Dq3bTP5Y5gXkA3MBMKUevpX6z5lHPyhEy+U/OYC7wxv+bsI+jpfU+vQNAds8I+X65HW933ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1724064285-1eb14e31a7542a0001-Djp6mn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id 0eunwJAKyFGd07QX (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 19 Aug 2024 18:44:46 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 18:44:45 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e]) by
 ZXSHMBX1.zhaoxin.com ([fe80::dcd1:d46d:263:77e%7]) with mapi id
 15.01.2507.039; Mon, 19 Aug 2024 18:44:45 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 18:42:22 +0800
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>,
	<leoliu-oc@zhaoxin.com>, <YeeLi@zhaoxin.com>, LeoLiuoc
	<LeoLiu-oc@zhaoxin.com>
Subject: [PATCH] iommu/dma: Fix not fully traversing iova reservations bug
Date: Mon, 19 Aug 2024 18:42:19 +0800
X-ASG-Orig-Subj: [PATCH] iommu/dma: Fix not fully traversing iova reservations bug
Message-ID: <20240819104219.8057-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Moderation-Data: 8/19/2024 6:44:44 PM
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1724064286
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2804
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.129251
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>

For multiple devices in the same iommu group, sorted later devices (based
on Bus:Dev.Func) have the RMRR.

Sorted earlier device (without RMRR) initialized the iova domain causing
the sorted later device goto done_unlock.

Then, the sorted later device (with RMRR) cannot execute the
iova_reserve_iommu_regions to reserve the RMRR in the group's iova domain,
and other devices (in the same group) alloc iova in RMRR are permitted.

DMA iova addresses conflict with RMRR in this case.

There is a need to make sure all devices of the same group execute reserve
iova.

Substitute iova_reserve_iommu_regions with iova_reserve_pci_regions
(reserved PCI window)and iova_reserve_iommu_regions(reserved resv-region,
like RMRR and msi range). And then, goto iova_reserve_iommu_regions could
avoid the problem when if (iovad->start_pfn) is true.

Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
---
 drivers/iommu/dma-iommu.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7b1dfa0665df..9d40146a63e3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -559,6 +559,19 @@ static int iova_reserve_pci_windows(struct pci_dev *de=
v,
 	return 0;
 }
=20
+static int iova_reserve_pci_regions(struct device *dev,
+		struct iommu_domain *domain)
+{
+	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
+	struct iova_domain *iovad =3D &cookie->iovad;
+	int ret =3D 0;
+
+	if (dev_is_pci(dev))
+		ret =3D iova_reserve_pci_windows(to_pci_dev(dev), iovad);
+
+	return ret;
+}
+
 static int iova_reserve_iommu_regions(struct device *dev,
 		struct iommu_domain *domain)
 {
@@ -568,12 +581,6 @@ static int iova_reserve_iommu_regions(struct device *d=
ev,
 	LIST_HEAD(resv_regions);
 	int ret =3D 0;
=20
-	if (dev_is_pci(dev)) {
-		ret =3D iova_reserve_pci_windows(to_pci_dev(dev), iovad);
-		if (ret)
-			return ret;
-	}
-
 	iommu_get_resv_regions(dev, &resv_regions);
 	list_for_each_entry(region, &resv_regions, list) {
 		unsigned long lo, hi;
@@ -707,7 +714,7 @@ static int iommu_dma_init_domain(struct iommu_domain *d=
omain, struct device *dev
 		}
=20
 		ret =3D 0;
-		goto done_unlock;
+		goto iova_reserve_iommu;
 	}
=20
 	init_iova_domain(iovad, 1UL << order, base_pfn);
@@ -722,6 +729,11 @@ static int iommu_dma_init_domain(struct iommu_domain *=
domain, struct device *dev
 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_in=
it_fq(domain)))
 		domain->type =3D IOMMU_DOMAIN_DMA;
=20
+	ret =3D iova_reserve_pci_regions(dev, domain);
+	if (ret)
+		goto done_unlock;
+
+iova_reserve_iommu:
 	ret =3D iova_reserve_iommu_regions(dev, domain);
=20
 done_unlock:
--=20
2.34.1

