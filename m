Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8372853F7
	for <iommu@lists.linux.dev>; Fri, 13 Feb 2026 18:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007798; cv=none; b=jCj4oip1trJ0btmucrm8X2sXUmK2cW5mHA0RCdQbOxTk8ttAko4pfhUXkhGbBoKDZgCE68BsuI1a185Brx0+dkjkEdpDTlcI324QGoQm+3GnqSkXkmGGCEXu+XNqvNEvgc+HktQRE6X83l1Eq6IbRHiSZOC4+DEiMqiUvCbJM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007798; c=relaxed/simple;
	bh=j8L4MDDAtEv6fjC0YQfVhYePVu2AJcpdjAajbDUQRD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvecEA0zudF5ZSNfxpI1/wBqxiyK7VBQADlaCttbDbNuY1JBdXNV2nHfnU5SpHXMHA8pNqaXdf0/cHB/sPFGKBfXiYv5ekA8gsNB0KdfxyCo6AqAQkljWS3G3BcLs5ydSYzb0AFIlLV1KQIdg0T4nHtndNrB7px+S5qI0zIRC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KstQ9Cbf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KstQ9Cbf"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id E375920B7165;
	Fri, 13 Feb 2026 10:36:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E375920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771007797;
	bh=H/YmSIrkd21MH+EnWDFi6FjTILZTx33A7T/69Gia21s=;
	h=From:To:Cc:Subject:Date:From;
	b=KstQ9CbfirRpK+a2HIeW7rTqCZ8/aHbUP+t0jR7ZpactEdtM5jAfoVbqts7gQuPx9
	 9kNknyr3G6AxmH7qDYqlfH9potePXiHthpS62KrPXHRC/k/O6S99OzD2E2hhdPbivf
	 8hp9r0lR5eBhRBTJLzxD2KGhSADh0t9C9w8IpMKk=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: [PATCH] iommufd: vfio compatibility extension check for noiommu mode
Date: Fri, 13 Feb 2026 10:36:36 -0800
Message-Id: <20260213183636.3340-1-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VFIO_CHECK_EXTENSION should return false for TYPE1_IOMMU variants when
in NO-IOMMU mode and IOMMUFD compat container is set. This change makes
the behavior match VFIO_CONTAINER in noiommu mode. It also prevents
userspace from incorrectly attempting to use TYPE1 IOMMU operations
in a no-iommu context.

Fixes: d624d6652a65 ("iommufd: vfio container FD ioctl compatibility")
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/vfio_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index a258ee2f4579..acb48cdd3b00 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -283,7 +283,7 @@ static int iommufd_vfio_check_extension(struct iommufd_ctx *ictx,
 	case VFIO_TYPE1_IOMMU:
 	case VFIO_TYPE1v2_IOMMU:
 	case VFIO_UNMAP_ALL:
-		return 1;
+		return !ictx->no_iommu_mode;
 
 	case VFIO_NOIOMMU_IOMMU:
 		return IS_ENABLED(CONFIG_VFIO_NOIOMMU);
-- 
2.43.0

