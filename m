Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E373BFE2D
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550312; cv=none; b=EKEsoLDEBXK4McJ6iD8/tlChKBg9REuXaEdCgN34HP2OPRBmsSneMfU0fabPPAKwnEyzOI+mZhX2ctAQ7A5QM6M2kLjDDteRz0rApvfAo3AWsFalSm6w2SYBzbqcVZIui93mLRrU6AnHpKohiz6b5/0XkhjPw9c1X0Yp0rmeykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550312; c=relaxed/simple;
	bh=s3eSFIhSroDbWAI1zZwjjlbEoJePmn4Sz3PrpBM79bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeSlhVIpmleNcjXYmwpJQzW/A4z3Er2vJTyKHFWXqkO7Lb/4qBLeiggn/cjxBnU4fnUzvKf+ku6ZQkAsP+7H3UKOr9kOE1Lxi9uqdH2zjs/ux6gm60XHfi69jYigHtkkPZrQ1bcL/NbrqcVLBjivg9FhbyxkIhRY4+8oE3VlO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvWMH54p; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvWMH54p"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso157365a91.3
        for <iommu@lists.linux.dev>; Wed, 03 Jun 2026 22:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550307; x=1781155107; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umuccskTvPELH8yp9qi1ExFn7OMlDISJoOngAwbhXJA=;
        b=jvWMH54p4kKKktBazYOp9x3MnYePKk8Av708JDbaKdVnY8OU/SdvnxTFdm/5k0p/cY
         BYsGZFhv5/zFkRYYDvdLuRY+DC/SFMFQj+4LkF+1Rb93xj5scUG3a8iET5GUgpBsOXIL
         jrb+lKyKOud5I+ml473b1qGAj5zrE2Ht4DMPe0PWZwSb+m9AdN2+dBfljBFKilNKU9lY
         wenJUihpRxuI8Do7Eko0jkULYTEY68BawJve0VUrHayvxaJJkBRJ7t+W3B8DwwczRG7d
         t2++U1Zr5NEidNQFL6PZEZ6rH6GtYWzt2VJK0kA3Fq4W1Y07rHzdhUkEFJd9d8qAAkP9
         rieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550307; x=1781155107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umuccskTvPELH8yp9qi1ExFn7OMlDISJoOngAwbhXJA=;
        b=B6UIK0+regAy2y2OnN7Ys+ZNu1CLfZPTQ+uXCpCOVfIY1MkwTcZDtaJ/sKq5rqdDvj
         x0fu9Qz7unIu9O35Sdqvjpqzj+amvquYcXWYfwij/FwqcjiyiHJMHbtD9wTy9/s7VcbJ
         iQHRiE923wGS/tlZYD1qDBXCvJtKjfFOQQOzbcWT2FZe+WSkhPlSSOgS49sFwBSMhpsR
         9C+lnvYbQmtNtLYZOTx0eDe1El/IOq7VZO5cu/BiLogt0H1smL9CNf7i7Mi1Mzhlgohv
         boJYBpO/aWlpfH87WHwZVzo2riT1rLSgYr9PGptj0I1b7Vg7JeDEieOiUGl6rQPipz5W
         nOEg==
X-Gm-Message-State: AOJu0YxskSthb+HY2+bUG3GQk9V2Kr7ZhmucYGdI5heb7PMQ82hN4YSR
	LlXgkxme8EhemTrQIrRgaBwksB4InCChaGScHHxu9ya/v6idqxTrsHJW
X-Gm-Gg: Acq92OHTO05H/b7JfoIneVy79BTioTSJ2L5qtKyKgaG1BXy63hyY0CbwtpjGWg0b4Wi
	vpABEsqjjyicnCKK0NY9fOYMyDuw6ZCgLAix3qyh1UbVeFLAJEPiYy9DU3sU0i4Q3mb0vTffoO2
	qKjz+yLJuiaduSo9/OpVgW7jJYK7TxW5X/aWXz4scNPOomFR1cAPc5AwkbUOWETeP/nDke3Aa+u
	G9XXrS4QTXChTDP+NL2q3CVh5P10ecR51YuUxfClu41Td/dtvUF+0oQ1y+yPDxrnoakP3fXzJaM
	psa0a34P4FVJBMNwxRVMEmoaB2sm40R2x2WBVESk674cuqP4+yZ2hDHEsVfRRWjddvqXTuaSJJ1
	fNHqfOSnF+MBuJ7rwzDVVfUg0Q58woGEFEVgk/zphB/zMowAwkWbPtrPdjYwCbGaYSi9dLyLPPG
	QJh2ijLnTtgVLrV739Ni2NvEEYFxuHWUyXmb8C49X9dmfTx93HJ+iX8/Gpjdk=
X-Received: by 2002:a17:90b:2811:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-36e30c23af4mr6513768a91.7.1780550307210;
        Wed, 03 Jun 2026 22:18:27 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm2009262a91.1.2026.06.03.22.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 22:18:26 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jpb@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	Maoyi Xie <maoyixie.tju@gmail.com>
Subject: [PATCH 2/2] iommu/virtio: Avoid using the list iterator past the loop in viommu_add_resv_mem()
Date: Thu,  4 Jun 2026 13:18:16 +0800
Message-Id: <20260604051816.2976221-3-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604051816.2976221-1-maoyixie.tju@gmail.com>
References: <CAHPEe=G-FZvEXjkE+vAXN5MHXCtsOaUoKwg2RQL6m=om+c20hQ@mail.gmail.com>
 <20260604051816.2976221-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_add_resv_mem() walks vdev->resv_regions to find the insertion
point. When every element has a smaller start address, the
list_for_each_entry() iterator ends up one past the last entry, and
&next->list then aliases the list head, so the following list_add_tail()
still appends at the tail. The result is correct, but using the iterator
after the loop is undefined per the list_for_each_entry() contract.

The loop only needs a list_head as the insertion point, so iterate with
list_for_each() and keep the typed list_entry() dereference inside the loop
body. No functional change.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f1..1d58d6b626a5 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -486,7 +486,8 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
-	struct iommu_resv_region *region = NULL, *next;
+	struct iommu_resv_region *region = NULL;
+	struct list_head *pos;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	start = start64 = le64_to_cpu(mem->start);
@@ -520,11 +521,14 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 		return -ENOMEM;
 
 	/* Keep the list sorted */
-	list_for_each_entry(next, &vdev->resv_regions, list) {
+	list_for_each(pos, &vdev->resv_regions) {
+		struct iommu_resv_region *next =
+			list_entry(pos, struct iommu_resv_region, list);
+
 		if (next->start > region->start)
 			break;
 	}
-	list_add_tail(&region->list, &next->list);
+	list_add_tail(&region->list, pos);
 	return 0;
 }
 
-- 
2.34.1

