Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4B19E98C
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750290382; cv=none; b=qZqVZZhaFQtPChPm41ahzgxOjn4N8REJitIzYUBFDEESVKy1HcSHDN4NQqrk3XUz7LkYk98NtAOwgHrsiLFREYjE9Bq+OvMLy3VKqtCk2+2RH9wJADLItqq3jySL+6LMVWMe9SEV80VWVGljSm5vALLGZM73hwQ2VzQ0rUDirAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750290382; c=relaxed/simple;
	bh=bvc6XffpMxOUMZVtjrRFnzDIx7NxU+qhS6gWPeeAZ28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FC7u6kupCB2nfwNA3E/sHR+ebNlZ12b0v4cK3KcnlVjxdC1kvN1lKr5gMGhcAIX/UUAFwqegq4SbpjOMbco/5WL9aJ7okzBbyRmZj/8uYwMROcnNWuOBacoVaoKv+RxfqpSKLO3Ua39at6oOmlA3DRlFOKO/iTLXoYXgDeVYCQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N3mTs4ke; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N3mTs4ke"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C9A62119363;
	Wed, 18 Jun 2025 16:46:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C9A62119363
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750290379;
	bh=8aTJkSQUPtAIsLs5ubRvfMisaVJatdETONyhtHLwckA=;
	h=From:To:Cc:Subject:Date:From;
	b=N3mTs4kerAWdXfKzME+h4vT3uhY9Tv0n9Dx2e31TbnMZxAvhU9DSnQylUHv4r/Gm0
	 mlgFhncEfsjL4trFaF7FpwzYx3b3tGdGWcKvqd07/UhghH3uVliETLdqV8J3Ag8Jdm
	 rTlYEzOCMVaE/av3Sp/F2rK9yJiyww3bQThS87/w=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex.williamson@redhat.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Zhang Yu <zhangyu1@microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v3 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu mode
Date: Wed, 18 Jun 2025 16:46:17 -0700
Message-Id: <20250618234618.1910456-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For devices with no-iommu enabled in IOMMUFD VFIO compat mode, the group open
path skips vfio_df_open(), leaving open_count at 0. This causes a warning in
vfio_assert_device_open(device) when vfio_df_close() is called during group
close.

The correct behavior is to skip only the IOMMUFD bind in the device open path
for no-iommu devices. Commit 6086efe73498 omitted vfio_df_open(), which was
too broad. This patch restores the previous behavior, ensuring
the vfio_df_open is called in the group open path.

Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v3: Apply a concise fix from Alex
v2: Use a fix from Jason
---
 drivers/vfio/group.c   | 7 +++----
 drivers/vfio/iommufd.c | 4 ++++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c321d442f0da..c376a6279de0 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -192,11 +192,10 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		 * implies they expected translation to exist
 		 */
 		if (!capable(CAP_SYS_RAWIO) ||
-		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
+		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
 			ret = -EPERM;
-		else
-			ret = 0;
-		goto out_put_kvm;
+			goto out_put_kvm;
+		}
 	}
 
 	ret = vfio_df_open(df);
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index c8c3a2d53f86..a38d262c6028 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -25,6 +25,10 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
+	/* Returns 0 to permit device opening under noiommu mode */
+	if (vfio_device_is_noiommu(vdev))
+		return 0;
+
 	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
 }
 
-- 
2.34.1

