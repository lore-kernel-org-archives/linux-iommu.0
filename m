Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488FF336EEE
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610219; cv=none; b=C8mKialEf6FLIHHbBX5bSVBYo8yLTfNDmRSO3Lx/ImEHP9ksm/uwZrytXlSS1gIuRGxh2TnhiN9oGxAl9mFVvFmhYt6sXqXeUzY7gVbmhB9mBXH5yrcHHwtah5MiJrfUuEoimz/sY2NJGzZfQNe8/nMImdjt3K2IG5lpg3rj1Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610219; c=relaxed/simple;
	bh=bImSNgi4dZkdOMPK57Dv6OP6ggJxli6qP7lZJCYcKMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LkMq+Z+PAwzXkk/XINxJVCJdz87hOuVYiEZNRbeTJ2505dslaOSIxiQ05vZ7HXUHMKXb8eq6Q5Ixer4ztaKKjRf7IGl7Vicz3r/iU7EOneT/l0XdgtTal61eEi9mVTZ8MMzkjgpH0dH/1LYq6Y0TD9ESeHfG6mA3+ib11cuN860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PRBuLpQD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PRBuLpQD"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B8B3201C97E;
	Mon,  1 Dec 2025 09:30:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B8B3201C97E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610216;
	bh=o0BfdJb6BWCVT/mCZ8zsVVH2PslD3N+9Dsx1+f0fKdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRBuLpQD0ljwyecFTBLZRNz3dNOuNyGwNQmCIJXq5x+GaseE3KWgewZopsSHrib7y
	 dACPGaB25Gf5E4kr9I46UQ7tLntpzGhn8bXxvkg/rUc9RWqy4t54alT8MCUt0z46ZZ
	 eeRr/4lwGvZXfU01muMvA42GB8Wnm5CX9OxVhG2s=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 2/8] iommu: Add a helper to check if any iommu device is registered
Date: Mon,  1 Dec 2025 09:30:06 -0800
Message-Id: <20251201173012.18371-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dummy IOMMU driver for No-IOMMU mode should only be active when
no real IOMMU devices are present in the system. Introduce a helper
to check this condition, ensuring that the dummy driver does not
interfere when hardware-backed IOMMU support is available.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommu.c | 10 ++++++++++
 include/linux/iommu.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0df914a04064..958f612bf176 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2895,6 +2895,16 @@ static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *
 	return ret;
 }
 
+bool iommu_is_registered(void)
+{
+	bool registered;
+
+	spin_lock(&iommu_device_lock);
+	registered = !list_empty(&iommu_device_list);
+	spin_unlock(&iommu_device_lock);
+	return registered;
+}
+
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
 {
 	const struct iommu_device *iommu = iommu_from_fwnode(fwnode);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473..4191ae7312dd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -933,6 +933,7 @@ extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_set_default_passthrough(bool cmd_line);
 extern void iommu_set_default_translated(bool cmd_line);
 extern bool iommu_default_passthrough(void);
+extern bool iommu_is_registered(void);
 extern struct iommu_resv_region *
 iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot,
 			enum iommu_resv_type type, gfp_t gfp);
-- 
2.34.1

