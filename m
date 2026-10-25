Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792934843;
	b=dupf9y8qL3PSzs3nyQ1jkAQJDYsjJyw2FMdCOZnTjw+8UH37fIvdPMUggtJ3EiSSuZRG
	 QzeSdmphTlEacJrgvRqU8aip11H8NNTg6iAPwuMUD/y/Y80h+klDCby2Xfr98lCm8cXm3
	 B+ndXG+U7h84kQJSjKqLaBU4X2ZVShUE23afjGC6w9w3RZOE7YI1LdZoVQgKtnh0jWSrD
	 AkyG91dIwNPZqZ4LzUmzyEREEuF8Z4tfDAoXSDSAy6YEPErKvsOSFXPcw3Hg0z8Z4w6PD
	 ldo60we/nzLzn1kVdkbYkzQzl2jZ/Pj7UdkvIbV/92IaGQD3pIw3btdgG9O4OXg4Ngg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792934843;
	h=DMARC-Filter:Received:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition;
	bh=s4G6y9mFTbTckKTLQXLl6WZ3FRA9OVGpxiqTBq5svBw=;
	b=wnsnOjlYFYU6lKEeCeVb9kq/tfmC6NUVmHeeahyfG1TLML2ngDJnMxU89daSojt7+0sJ
	 OFpWtHl0cWtFVIbR7qDJMY2LUi1vjWayKFPsCmb12cqupZJPcdKlhAENYaUxhYfrq/WsA
	 pPhQJKvEvmw5Pvw8ITq3WmZT8ENLZfYVqqOMU6U0KVRO6axSuohYCtJgc9AycKubfhyUs
	 Qm6A9n2o4o/4Lv81oUf+I4OOevY97hmfepKxXhvCyLNfOIFueEsy5mD6aRslRH6mt0E+y
	 I2w8LBiKd2eBo7pqKDGOm6RgKkpAxsh8m9sSWDhAGX69EPpmBZmbFBpA5fkItn67z1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B73B606A31A
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 13:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B73B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xKyCb-000000005KX-1kCw;
	Sun, 25 Oct 2026 13:27:11 +0000
Date: Sun, 25 Oct 2026 13:27:08 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vsi: keep the runtime PM callbacks without PM_SLEEP
Message-ID: <e8114502dc91f5fb709509291fdd85e27545dfb6.1792716048.git.daniel@makrotopia.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The runtime PM operations are handed to the driver core through
pm_sleep_ptr(), which is NULL unless CONFIG_PM_SLEEP is set.

Without system sleep support the IOMMU has no runtime PM callbacks at
all: its clocks are never enabled by the driver, the page table is not
restored when the power domain comes back, and iommu->enable stays set
while genpd powers the domain off.
The TLB flush issued from vsi_iommu_map() then writes to the unpowered
IOMMU, and the first buffer allocation of the RK3588 AV1 decoder ends
in an asynchronous SError.

Use pm_ptr(), which keeps the operations whenever CONFIG_PM is set.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/iommu/vsi-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5dac20b143a55..1b447c0693936 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -780,7 +780,7 @@ static struct platform_driver rockchip_vsi_iommu_driver = {
 	.driver = {
 		   .name = "vsi_iommu",
 		   .of_match_table = vsi_iommu_dt_ids,
-		   .pm = pm_sleep_ptr(&vsi_iommu_pm_ops),
+		   .pm = pm_ptr(&vsi_iommu_pm_ops),
 		   .suppress_bind_attrs = true,
 	},
 };

base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
-- 
2.56.0
