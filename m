Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97FD320A
	for <iommu@lists.linux.dev>; Thu, 20 Apr 2023 08:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1681978048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oiFbyJM/OVQzht3NVRAuOeDRCZOh3MADqrY1DUOhLSk=;
	b=AfBJLrEdaUDSvMQ7UmAiiSys4ErzU1TP5NBssf5OrkgMG5Ir1Bd/iti20ER+wKdho+R+bD
	h8jx8HwTRlJEvdbOrgrYhmJ6MFSafjt7NgHFW4p5PX0Y326jM4NOeY7UvcfVTnXhQ+H03U
	4SNlOBxY/RpKmYazoAgpxltl0ZIXPh8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-oMS7FFhqMkiBaKPbv7BaSg-1; Thu, 20 Apr 2023 04:07:25 -0400
X-MC-Unique: oMS7FFhqMkiBaKPbv7BaSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9BB329AB405;
	Thu, 20 Apr 2023 08:07:24 +0000 (UTC)
Received: from cantor.redhat.com (unknown [10.2.16.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA9DD1121315;
	Thu, 20 Apr 2023 08:07:23 +0000 (UTC)
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: amd: Use page mode macros in fetch_pte
Date: Thu, 20 Apr 2023 01:07:18 -0700
Message-Id: <20230420080718.523132-1-jsnitsel@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3

Use the page mode macros instead of magic numbers in fetch_pte.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/io_pgtable.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index ace0e9b8b913..61a99d715b23 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -310,8 +310,8 @@ static u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 			return NULL;
 
 		/* Large PTE */
-		if (PM_PTE_LEVEL(*pte) == 7 ||
-		    PM_PTE_LEVEL(*pte) == 0)
+		if (PM_PTE_LEVEL(*pte) == PAGE_MODE_7_LEVEL ||
+		    PM_PTE_LEVEL(*pte) == PAGE_MODE_NONE)
 			break;
 
 		/* No level skipping support yet */
-- 
2.38.1

