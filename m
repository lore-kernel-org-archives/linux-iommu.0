Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B8736A376
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 02:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783994601; cv=none; b=OVtrg3XXhwncO2N9QJma6nP8czgDzSd1aRm5rHeaNFWdgBiNs3l3EBp5O0WCruBa5xNUqLH6q037gDJ/Ay0Pf6LNg1DVB21PCqifLnKtGSS+Ebt4uGipoJhy/5l1Jfj8R5VMfICBwqTkMy8uNBvfFlFDhvKuT3lXroWOmK4HBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783994601; c=relaxed/simple;
	bh=6rhUxPl7w0KqouTpMbolr3BZMXdmvBnvYbg+4s5h6Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gu6tBNE4FLONAxdqubKAo83Uo4GfonbuhmFvMsZot+a9Kp04I7wIE1HnwsVJJ521ODO5DwJ3kSRvMXgntZRnYbgIM8q6ulDZZJH3/1IcucDS5tuQ/XJ9OHs2ah/iK7HgYHlISoZipOy0YX+LFpk1zklJ/bVOEFu8DGKcIT8mjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fzBiOsoJ; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fzBiOsoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yn
	+D+qu2dW1uG2w9o50v9I6wtp33ntfSJIG6DTWdptw=; b=fzBiOsoJocNAEEmXqb
	31RFZTWKkOnaFWgTFZxS2iwPsQ/IA4Pc8aNzQzBb0X+v2Tx//vNBUezRAG9jC600
	Wd5s1A2g27D1Zhvq7MVApmD2y5zaDdrBePH7XY05zasV4zRQ+TzGaLuLT/ZayuCb
	UDBr/ZYZ8gLeWt5UQwcYPZ42Q=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnFy7KmFVqnrbaJg--.22055S2;
	Tue, 14 Jul 2026 10:02:51 +0800 (CST)
From: weimin xiong <15927021679@163.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/amd: Use device max PRI outstanding requests
Date: Tue, 14 Jul 2026 10:02:50 +0800
Message-ID: <20260714020250.175808-1-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnFy7KmFVqnrbaJg--.22055S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw4kJF1kJw17KrW7WF4rKrg_yoW8Jw47pr
	45GF40kr1kXFy8tay7ua4ruFy5ZayfAa4FyrWDKw4Uuw1DCa48KryrKr1xt3Z3Ar4ktFya
	vF10gFy7uF4Yq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3DGrUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wtI0GpVmMucUAAA3A

From: xiongweimin <xiongweimin@kylinos.cn>

pci_enable_pri() already clamps the requested outstanding count to the
device PCI_PRI_MAX_REQ value. Passing a hardcoded 32 under-utilizes
capable devices and can oversubscribe weaker ones.

Pass ~0U so the allocated request count matches what the device
advertises.

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/amd/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 563f9c267..e1ec5ee76 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -602,10 +602,10 @@ static inline int pdev_enable_cap_pri(struct pci_dev *pdev)
 
 	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) {
 		/*
-		 * First reset the PRI state of the device.
-		 * FIXME: Hardcode number of outstanding requests for now
+		 * Reset PRI then enable with the device-advertised maximum.
+		 * pci_enable_pri() clamps @reqs to PCI_PRI_MAX_REQ.
 		 */
-		if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, 32)) {
+		if (!pci_reset_pri(pdev) && !pci_enable_pri(pdev, ~0U)) {
 			dev_data->pri_enabled = 1;
 			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
 
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

