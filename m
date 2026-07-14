Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3043016F7
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009425; cv=none; b=Bq9/ZaFooFVaNt2CFTeAAijzNhaa4atdtK1IGzzcv2yG7i4uF6Im+fuDUWMCxe28RGhGgomwXuYJylK+5rB44IH8jT0uyzLBluIOVyqGW+jf7Y4LUgp7JeKnkx19FF9YiDYFXPgtoNfu/esi6TcPTf091ILYKqZWXwG2HQxyjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009425; c=relaxed/simple;
	bh=h1rcSZIJCx1s78fckibab2t0DEvvfwOPISuMFxICZCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Upc+Rt6MKigpO+uZHNF2kf6GpJug+LWoljoTzTWta4mizAq2J8DJVskgoGQzs2fBder9o+akTLiT1zc0AG+zkzupLO5VgRhz4hMUDAZ25eKZxFZIh6lT4jQfp6Px250Ml94yr1sV3CH3Du0TYck561Q9H1XFhgvWW3PWOGzpqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iqI/ShWL; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iqI/ShWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fO
	rVLDpGjRjUa+f8VzrtP6B9hFELin8qYtwTJlLmQHk=; b=iqI/ShWLN0QGPUqjSJ
	HV4sJ1rtMWL3tWOLVElIvwBK6ZSAS4vfu0sssBfLo/bYGEpI3L73sIP+ni1SSqUT
	CmAr7QEESbFj+puJ3v3C2uYKuvXUwn8posOU/mE9sIfmLZjymxF95WZIUJm21bsD
	UnPKkFa6CVRl/0wW+XDTRAaMM=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnwyab0lVqrG_HHA--.5129S5;
	Tue, 14 Jul 2026 14:09:48 +0800 (CST)
From: weimin xiong <xiongwm2026@163.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	weimin xiong <xiongwm2026@163.com>
Subject: [PATCH v1 3/4] iommu/vsi: Fix fwnode lookup lifetime handling
Date: Tue, 14 Jul 2026 14:09:29 +0800
Message-ID: <20260714060930.220277-4-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714060930.220277-1-xiongwm2026@163.com>
References: <20260714060930.220277-1-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnwyab0lVqrG_HHA--.5129S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyrGF1DJw1fCw47uF45Jrb_yoW8Ww45pF
	WUGayYkrWUXF10gF47C3W5CFyYvws2va4I9rW5tw4v9w1rtrW8ta4UJryjqryrCFZ5J3W7
	Kw13ta97CFy5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeg4fUUUUU=
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgzPX2pV0qyd0gAA3c

bus_find_device_by_fwnode() returns a device with its reference count
incremented. vsi_iommu_get_from_dev() drops that reference before
reading the driver data, which leaves the returned pointer derived from
a device after its reference has been released.

Read the driver data before put_device(). Also make
vsi_iommu_probe_device() fail with -ENODEV when the IOMMU cannot be
found instead of dereferencing a NULL pointer.

Signed-off-by: weimin xiong <xiongwm2026@163.com>
---
 drivers/iommu/vsi-iommu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 42c424496..d19db561e 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -220,10 +220,15 @@ static struct vsi_iommu *vsi_iommu_get_from_dev(struct device *dev)
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct device *iommu_dev = bus_find_device_by_fwnode(&platform_bus_type,
 							     fwspec->iommu_fwnode);
+	struct vsi_iommu *iommu;
+
+	if (!iommu_dev)
+		return NULL;
 
+	iommu = dev_get_drvdata(iommu_dev);
 	put_device(iommu_dev);
 
-	return iommu_dev ? dev_get_drvdata(iommu_dev) : NULL;
+	return iommu;
 }
 
 static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
@@ -619,6 +624,9 @@ static struct iommu_device *vsi_iommu_probe_device(struct device *dev)
 	struct vsi_iommu *iommu = vsi_iommu_get_from_dev(dev);
 	struct device_link *link;
 
+	if (!iommu)
+		return ERR_PTR(-ENODEV);
+
 	link = device_link_add(dev, iommu->dev,
 			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
 	if (!link)
-- 
2.43.0

