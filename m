Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14F1390998
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517556; cv=none; b=X4CZ4poxs7P7rh3366rlAcs0BPkHeenIw8gwEMxgZ+/eafHyABiQoN6Y47XhaWu3lcgDxsErFsojiafsBjV5MtDggVqsvGbvppDUaqm4zH3NOSSmhklLrPoFgdqKkEBwM68fJZC+z0eG7ivScKuyPLbVDAtBHRYBGN1w3lgEKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517556; c=relaxed/simple;
	bh=AYhBaRoMZOhD6WvPcjiYZhPWcUHtt2P9Heu/65undLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ov4zNGL3iQojuZqLACvWuAfwkdvcuI/Q15YIvff7eFbWBZK1DK8DyAbGk5qNbBJedphQss1SVUjHPN1kxMGVR6pca6kjQZybuVHWEND4MJbPNsqbvdtb6PeiXohbyeKSRjH/fQp0noro8ZIS1ak//NRwVs61fu06Dqd4W6BJDpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnrjxgY8hqMAobCg--.2175S2;
	Fri, 09 Oct 2026 11:45:37 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/exynos: fix NULL pointer dereference on device_link_add() failure
Date: Fri,  9 Oct 2026 11:45:39 +0800
Message-Id: <20261009034539.3073100-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrjxgY8hqMAobCg--.2175S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw15ZFW3Cr17Kw1UAF47Arb_yoW8tw1xpF
	W7CFy5ArWUXF1kWF17Xr4UuF1Sv3Z2ka4fur1fG3yDKr15try8Kay8X34Fv3Z5ArWkG3ya
	y3yaqaykCFsxJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr0_Gr
	1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
	evJa73UjIFyTuYvjxUqY0mUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQPA2rIJBHwaQAAsB

exynos_iommu_probe_device() stores the result of device_link_add() in
data->link without checking it for failure, although device_link_add()
returns NULL when the supplier is not PM initialized, on a dependency
cycle or on allocation failure. exynos_iommu_release_device() then calls
device_link_del() on that entry unconditionally, and device_link_del()
dereferences link->flags, so a NULL data->link causes a NULL pointer
dereference when the device is released.

Check the returned device link for NULL, unwind the links that were
already created and fail the probe instead.

Fixes: 7a974b29fe5d ("iommu/exynos: Rework runtime PM links management")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/iommu/exynos-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b396..ce0492691ef4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1403,7 +1403,7 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
 static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
-	struct sysmmu_drvdata *data;
+	struct sysmmu_drvdata *data, *tmp;
 
 	if (!has_sysmmu(dev))
 		return ERR_PTR(-ENODEV);
@@ -1417,6 +1417,11 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 		data->link = device_link_add(dev, data->sysmmu,
 					     DL_FLAG_STATELESS |
 					     DL_FLAG_PM_RUNTIME);
+		if (!data->link) {
+			dev_err(dev, "Unable to link %s\n",
+				dev_name(data->sysmmu));
+			goto err_unlink;
+		}
 	}
 
 	/* There is always at least one entry, see exynos_iommu_of_xlate() */
@@ -1424,6 +1429,13 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 				struct sysmmu_drvdata, owner_node);
 
 	return &data->iommu;
+
+err_unlink:
+	list_for_each_entry_continue_reverse(tmp, &owner->controllers,
+					     owner_node)
+		device_link_del(tmp->link);
+
+	return ERR_PTR(-ENODEV);
 }
 
 static void exynos_iommu_release_device(struct device *dev)
-- 
2.25.1

