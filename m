Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37223A4
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 06:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665384978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bKC7lpyYXtfPvmNIVM9PoWLAGcD4nCScccaRlGhKYH8=;
	b=OQ+dq6WCQmfD4ocRSZ2TCz6Q+8FelGatU0S771pNKqtGhM6z/4j+txpzQkLGzWBx8/tUJg
	EfKM6GGYpm6XZzJBRiPQK8HEZiougmKXANXnWyqTB2FBZJ0+EMkY2c0L6o6ElXA5aLkuoy
	2/6L2iAIttlyMOcYECYEa4Pn7KHlPv8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-F7nXsxT3NUCgXvt2vCoUuQ-1; Mon, 10 Oct 2022 02:56:12 -0400
X-MC-Unique: F7nXsxT3NUCgXvt2vCoUuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 811A5380673D;
	Mon, 10 Oct 2022 06:56:12 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87A75AC944;
	Mon, 10 Oct 2022 06:56:11 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/vt-d: Clean up si_domain in the init_dmars() error path
Date: Sun,  9 Oct 2022 23:56:08 -0700
Message-Id: <20221010065608.281860-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

A splat from kmem_cache_destroy() was seen with a kernel prior to
commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
when there was a failure in init_dmars(), because the iommu_domain
cache still had objects. While the mempool code is now gone, there
still is a leak of the si_domain memory if init_dmars() fails. So
clean up si_domain in the init_dmars() error path.

Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/intel/iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 31bc50e538a3..8f1f80a4d0c5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3042,6 +3042,8 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
+	if (si_domain)
+		domain_exit(si_domain);
 
 	return ret;
 }
-- 
2.37.2

