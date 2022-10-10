Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5481FD1
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 14:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665413332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJZd3UB6IhHIssxO7zFtx8iIa2A93YDht882wbaSn9M=;
	b=ZmR1hHAfaKiVldROk3TFtxUqjhNR+anEWpjoM8+MhSWuM7921CDO8jC+NdbzKnjYSkaVeZ
	GG16+lejUIJvMOC8oF2g4BdhP72mS3lW0SVoTaskQLHYbINnBUJEr4UxxRwjt6G1xA1Pnr
	riQGDqBKOzgKHW7xdUwu5Hag2WBXEE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-eX_a1Le3MxWdSHUyYQIZHA-1; Mon, 10 Oct 2022 10:48:47 -0400
X-MC-Unique: eX_a1Le3MxWdSHUyYQIZHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0460101245C;
	Mon, 10 Oct 2022 14:48:46 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DB323145F94F;
	Mon, 10 Oct 2022 14:48:45 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] iommu/vt-d: Clean up si_domain in the init_dmars() error path
Date: Mon, 10 Oct 2022 07:48:42 -0700
Message-Id: <20221010144842.308890-1-jsnitsel@redhat.com>
In-Reply-To: <20221010065608.281860-1-jsnitsel@redhat.com>
References: <20221010065608.281860-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7

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
v2: Set si_domain to NULL after the memory it points to has been freed.

 drivers/iommu/intel/iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 31bc50e538a3..ecc0b05b2796 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2400,6 +2400,7 @@ static int __init si_domain_init(int hw)
 
 	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 		domain_exit(si_domain);
+		si_domain = NULL;
 		return -EFAULT;
 	}
 
@@ -3042,6 +3043,10 @@ static int __init init_dmars(void)
 		disable_dmar_iommu(iommu);
 		free_dmar_iommu(iommu);
 	}
+	if (si_domain) {
+		domain_exit(si_domain);
+		si_domain = NULL;
+	}
 
 	return ret;
 }
-- 
2.37.2

