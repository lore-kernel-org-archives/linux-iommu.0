Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14408397E89
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775825781; cv=none; b=jytHo4XHPLt9mpUHpyWfYuwGR4SwmuwRZI4lB4+L+gxpbFQXj/NfFq0cIzigYDY7QYheP4PKLt8rgta5+SYruaDcwbEDc8VrdV5nerKM3rfUYQYUnfvn5WjjTElfwcxiTB99C8FqZTaHaG2Un0pGhc7OasBTBG0SP/ica3tX2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775825781; c=relaxed/simple;
	bh=jQ0D9YP29owC0fujodI0kwK6Vi7Aoh6n+jNjA5ohHZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Qb5BIaPgYVsV8LxZDjZd3TfD9PD2h1QmSeDNzS43cZ4ULKXw8R8NHMb5oleNGpxwxr6pr6h+fK8RD7P7eTZOK9pLOSeKlx69Stk6T7sNddzZ+6A70oAtNacoqczHPGUInrvtH1tZhfWLMFrkkRGl8jlCxfc3sgiMAixwsNG9u7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAsHH75q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAsHH75q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775825777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rQok3OB45+l4fCfg+tNaYuiwZC4TiksQDUZba1BoN2I=;
	b=JAsHH75qCCoeijMHRg0DNtXOqFSlEBXENGXQ1Nf44BpMfrJdW2izIBPhilLQL0YO0azVOh
	dlm4jQMHVOrgHbq/ZWn6YtQ9MEIsnSG9emiHKOghwAOdY+T/uu2JRgBgAPjf1I4BJZVAq1
	vYOWzDMI3lpOYTn9JCjSJlyPxuagONc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-P0xdzv9YMdqDyi2Pbcy56A-1; Fri,
 10 Apr 2026 08:56:11 -0400
X-MC-Unique: P0xdzv9YMdqDyi2Pbcy56A-1
X-Mimecast-MFC-AGG-ID: P0xdzv9YMdqDyi2Pbcy56A_1775825768
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46F98180044D;
	Fri, 10 Apr 2026 12:56:08 +0000 (UTC)
Received: from ezulian-p1gen7.rmtde.csb (unknown [10.44.48.169])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A350B1955F2E;
	Fri, 10 Apr 2026 12:56:05 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Eder Zulian <ezulian@redhat.com>
Subject: [PATCH] iommu/amd: Remove latent out-of-bounds access in IOMMU debugfs
Date: Fri, 10 Apr 2026 14:55:50 +0200
Message-ID: <20260410125550.187398-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: xP45jUnsd3IYQTK5RZ67od_dfuqAvGIB7eiGb6bJSBA_1775825768
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

In iommu_mmio_write() and iommu_capability_write(), the variables
dbg_mmio_offset and dbg_cap_offset are declared as int. However, they
are populated using kstrtou32_from_user(). If a user provides a
sufficiently large value, it can become a negative integer.

Prior to this patch, the AMD IOMMU debugfs implementation was already
protected by different mechanisms.

1. #define OFS_IN_SZ 8 ensures the user string <= 8 bytes, so
   e.g. 0xffffffff isn't a valid input.

  if (cnt > OFS_IN_SZ)
     return -EINVAL;

2. Implicit type promotion in iommu_mmio_write(), dbg_mmio_offset is int
   and iommu->mmio_phys_end is u64

  if (dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
      return -EINVAL;

3. The show handlers would currently catch the negative number and
   refuse to perform the read.

Replace kstrtou32_from_user() with kstrtos32_from_user() to parse the
input, and check for negative values to explicitly prevent out-of-bounds
memory accesses directly in iommu_mmio_write() and
iommu_capability_write().

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 drivers/iommu/amd/debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 4e66473d7cea..4c53b6361314 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -31,11 +31,12 @@ static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &dbg_mmio_offset);
+	ret = kstrtos32_from_user(ubuf, cnt, 0, &dbg_mmio_offset);
 	if (ret)
 		return ret;
 
-	if (dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
+	if (dbg_mmio_offset < 0 || dbg_mmio_offset >
+			iommu->mmio_phys_end - sizeof(u64))
 		return -EINVAL;
 
 	iommu->dbg_mmio_offset = dbg_mmio_offset;
@@ -71,12 +72,12 @@ static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &dbg_cap_offset);
+	ret = kstrtos32_from_user(ubuf, cnt, 0, &dbg_cap_offset);
 	if (ret)
 		return ret;
 
 	/* Capability register at offset 0x14 is the last IOMMU capability register. */
-	if (dbg_cap_offset > 0x14)
+	if (dbg_cap_offset < 0 || dbg_cap_offset > 0x14)
 		return -EINVAL;
 
 	iommu->dbg_cap_offset = dbg_cap_offset;
-- 
2.53.0

