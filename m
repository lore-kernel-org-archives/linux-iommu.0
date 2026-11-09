Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215330;
	b=KE8cpKtrW/6dJpiEb7ArBh8vhKqh0g6kBiyj1d2UWiQJds781glGUu1iLLT6+X8uE7nM
	 y7GmeqDfcKBRrLhUZ91vKi7Ep07dvBjo0VaOsgxsmjv4GKh2HJtkLvcMj6zisL7valuoe
	 yGXq6I1Du2pO/LBKsdf0yXOVvO2aD8CfG+AHzr5cZp/1leatJUx2bzLNR7vMtknQJL4ji
	 ZGttgPT71CsxvtL9rJuZ/xkOMPeza6pEdi/70fWc5/8UW8asJMLGm/tl/BdwhpAsHzZf4
	 pLk65J45ognBmztRzjj7bKXoF9N2dJwFqc6ab14dPsnVc9IfjHfqG545Z/4eDmW8IDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215330;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=bAjv5jztQ8jh+iGi9AbS/QPrQZz+pxTt/UWPKu5c9Ow=;
	b=RH+q2/XmCoNr5LPrVW0v2vYecl1M4+dKDVbCyFwcJlE3FdUBvbeHI3zJb70EENywECD5
	 MljoB3GvdNrPyyZI8/ag2VVlZwq1CEEkaPFk/bvf/Drs26KX9fJm/z67nOOf47Lt6FtLT
	 9JiQgugoQdlAd4xFRbk60bM0aNzAVvvAHbvWAD8NTcv7N/HsS2gpADLknjSHqL/SWA9Ni
	 4RN+D+GsgehPq8/ApQQe344QXm7Bk7wg5K1YZSgtskOnt+j0ZNNqFTKe6QMJtd01aXLj/
	 Z5HptE2wXaKvciNsdY9YVVuqQ8hy0uhuUltE0yltVzcoAVEn0G6rMYZXr7WEIGeQl6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=iYKek6U6;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67001606A31C
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 09:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67001606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=iYKek6U6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1794215319;
	bh=jAokk+Zfx8ZmaPMvbaEBUYWJIuTkacUKL7Qyb4uWvvg=;
	h=From:To:Cc:Subject:Date:From;
	b=iYKek6U6XtbshWVb1vaedkcO22OtsM6XrxXfH+4O0gilHQ/tAYdzq+V03yMsWqgt3
	 gHCdSrixbsZhTiMPmxubhrqp6lK6KfZkMlVno8r2kS/4YLJQsDhhtbltK8HjGZu+uI
	 7A8jnu01s9H5dBQBeea3pIzId8B5GKjHgKN1NBv4A9sKEmqEU39WsKTDDQq5y/c2Wl
	 QueqBwOf54LVaY+FGZ34Tm2xurut8bM/YiA110fImNaYkYErHlYbI33S2F/TsLeHfL
	 j8+tthGIqeM6SvjXkO2CHmg/9E0DWh5mO2csXKgnKG3+cgG70ie1zQrHGqHbuf3rCJ
	 olerSOja1V6Lw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 5DC0124FCA;
	Mon,  9 Nov 2026 12:08:39 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  9 Nov 2026 12:08:20 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.52.177])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jNP8N1BSfz2lh4;
	Mon, 09 Nov 2026 12:08:20 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: [PATCH 5.10/5.15] iommu/amd: Fix clone_alias() to use the original device's devid
Date: Mon,  9 Nov 2026 12:07:31 +0300
Message-ID: <20261109090732.1565-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207338 [Nov 09 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/09 08:07:00 #28826469
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Vasant Hegde <vasant.hegde@amd.com>

commit faad224fe0f0857a04ff2eb3c90f0de57f47d0f3 upstream.

Currently clone_alias() assumes first argument (pdev) is always the
original device pointer. This function is called by
pci_for_each_dma_alias() which based on topology decides to send
original or alias device details in first argument.

This meant that the source devid used to look up and copy the DTE
may be incorrect, leading to wrong or stale DTE entries being
propagated to alias device.

Fix this by passing the original pdev as the opaque data argument to
both the direct clone_alias() call and pci_for_each_dma_alias(). Inside
clone_alias(), retrieve the original device from data and compute devid
from it.

Fixes: 3332364e4ebc ("iommu/amd: Support multiple PCI DMA aliases in device table")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
[mdmitrichenko: Replace iommu->pci_seg->alias_table with the global
 amd_iommu_alias_table used by 5.10/5.15.]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-53053.

 drivers/iommu/amd/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 334303b1d27bb..d8af774124a98 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -216,8 +216,9 @@ static struct iommu_dev_data *search_dev_data(u16 devid)
 	return NULL;
 }
 
-static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
+static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 {
+	struct pci_dev *pdev = data;
 	u16 devid = pci_dev_id(pdev);
 
 	if (devid == alias)
@@ -242,9 +243,9 @@ static void clone_aliases(struct pci_dev *pdev)
 	 * part of the PCI DMA aliases if it's bus differs
 	 * from the original device.
 	 */
-	clone_alias(pdev, amd_iommu_alias_table[pci_dev_id(pdev)], NULL);
+	clone_alias(pdev, amd_iommu_alias_table[pci_dev_id(pdev)], pdev);
 
-	pci_for_each_dma_alias(pdev, clone_alias, NULL);
+	pci_for_each_dma_alias(pdev, clone_alias, pdev);
 }
 
 static struct pci_dev *setup_aliases(struct device *dev)
-- 
2.43.0

