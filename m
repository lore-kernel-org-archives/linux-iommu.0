Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224B333727
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610222; cv=none; b=gIHlRa7tbxkJuhVrhlGutlMkOQjthb3DtGFwuZraXn4MV5ADUAfEMH5hTJ47sFmGzMRFt9Hruthvglq0wcZmtfc9XgdA2R2jBgMD3S4QqMMv2ltWpQVwwtx8CMfvsnGrMR85mjhjVirhws0D1fkDIFVXdYDeMom88nVUs3ehz3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610222; c=relaxed/simple;
	bh=FbNOAZU0TKAhX3Wq3/ciyXKedKyMzpckcHTC9mx8Wp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQ0tLTsJg65uX7XRDRYAiFFl8hWhd/RJryl/+aGdDdjTS3q6hr8Kh0o+eBtB2DvIhNCml5dEadkNfQTHPmuMMmN+kmk3mbWEizp+G4la1Ot0MYAWv8iRfPC35HZivJIt7KQKZulcLnHDd8x7h2ZiI9CNoVTFn/PIxf5boRZWFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l0Lls3Vo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l0Lls3Vo"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id E468C2065978;
	Mon,  1 Dec 2025 09:30:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E468C2065978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610219;
	bh=dvomxELmbgUsVVEk5BX3KOjzWISlwhy4c5KxjdUoepY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0Lls3Vobt5W4SfRM6e8SjngoYYyvFQuVmVu4ogoL88V42/44vZXNPP/65MDRlgcI
	 znWFTkAxZusrhnLmyAuky2fsdo8EBxRqr3n6Ze4EnPhEwl4PNxq7drsmiHXYi8uZPv
	 DeAwqKbgngXEfj3p5sLds8JlssDXZ3ry1TSa7Yqo=
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
Subject: [RFC 5/8] vfio: IOMMUFD relax requirement for noiommu mode
Date: Mon,  1 Dec 2025 09:30:09 -0800
Message-Id: <20251201173012.18371-6-jacob.pan@linux.microsoft.com>
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

noiommu device only has auto domain, does not need to attach to other ioas.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/vfio_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 38c8e9350a60..805d30b0b82f 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -317,9 +317,7 @@ static int __vfio_register_dev(struct vfio_device *device,
 
 	if (WARN_ON(IS_ENABLED(CONFIG_IOMMUFD) &&
 		    (!device->ops->bind_iommufd ||
-		     !device->ops->unbind_iommufd ||
-		     !device->ops->attach_ioas ||
-		     !device->ops->detach_ioas)))
+		     !device->ops->unbind_iommufd)))
 		return -EINVAL;
 
 	/*
-- 
2.34.1

