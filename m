Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4848BD2B
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 12:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353022; cv=none; b=Ffmagtp9bbgqy0pSmfYl/uOXfA5R57pWi77x3yw3s1C8Yik4LEu1ShzkOgudCBz4PFVFXPVmx7+XVZi3EqAf9FFwJleCuTAFF4sdjtMZGTeI4udjlPh9YxflOwlhMvdY4kbaj8lah33QBTN8YzukTA+/U5+mX3So8mEjYT/O/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353022; c=relaxed/simple;
	bh=BCMBVFAZIP13I5w/jJTN+YgyJlESvJ3LIxx4hCmYPIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J7NhlyVu76DosUnbrzs5faINvfdrC/bEvryFtctSv7tzWqRL/Qzde0zxROhBScgDxxg3TQGAuHZTr8NukmLThdKKdMd5c/kfT42yMBv+dO89VMNorBIPVZPPlcslsUMMQSgFso1tcS5LaMrNAGJUNR0DUZ2ttOgsabp2eTRA7OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KNOkkZ0d; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KNOkkZ0d"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7151120d6so16378545ad.3
        for <iommu@lists.linux.dev>; Wed, 02 Sep 2026 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788353020; x=1788957820; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5NBHjH0zO3irn3ihVyuwxc3GTb7iuVeu/o9LvgANg3c=;
        b=KNOkkZ0dWSGKIa2Yi76Ofbnr4/OE4HVLneg7HSKWhQ7pMXaKf9RMT01ZaZVpQXtDvH
         JNbdaWE4ktimMiOXxE0QaNzajivS8z37Q6js1C/JdhT+uTBUZm6TanDjmT2ClHkOsWIg
         rgpfzrTL7k1we+jnQ7igY5V13cr3lYTvYqoUAnphjAYwo37MV+yRbtpH8yaOi4ST7x8Y
         DMqef9Mk+rude6EzssUEc0qs+ngqpmiw5/2eFW5HtGFa8aoRmCXQ69doE92udR6Q9x2F
         RFpewa2N/zWL9QmVbBZRGEcm0K1FqtAKZcM1tIYZoxiH6YrJIODVl0do3Jqi56JsVINs
         V5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788353020; x=1788957820;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5NBHjH0zO3irn3ihVyuwxc3GTb7iuVeu/o9LvgANg3c=;
        b=mieliVmwOoz0qLw3U7VqDLXEI98yNziwBD9rdipQDvSDQvSnIcIkF4eMbeSfb4L0S5
         6GV31bbILvEBfC9FNhyrYKHDYTlNlx79613itb21TDRdx4aBmuiQ4iRzoUBtmbQV2g2Q
         p2wwJ0XnUgdC/mqWvl/Eg0r3GwlGoIbUugNoYXintgJzCEY2NhtDHnUk7gWav2VHIsSL
         oQLwSCh6kd4Mnvwd41/aHCwK0wCx5MyqhIdmQrIboTACmeYv5ury5f4ZA/k6fcSkNRhK
         XfDTsgdq1b5QaYmrrz+SxODR6pnPb9RjP27JC+5r23LgHgZFHLELmqvESLM0z3QznEDA
         6r/Q==
X-Gm-Message-State: AFuF++mH1A20Fq8LygGBHk9PCadvGGB3HpKDKzV6cB6yu7jccQsPkaw5
	Wr4w/0Urh1KeKYZBXzFkoJVAeQoCUTSqB4cS+65kwOax8wGIvoHKSnANZmfrO2r5HnAoa0r1LQm
	95u5Br+2mUqto72aMavOxC70QUIvwHTC/ThJp8h0R5gNcq46VsUWRPR3qpcboa6pGdA3Q0QYXtf
	XrnQvAXVFxsS8z7K/0NySmlmQU7CPc7g==
X-Received: from plblc11.prod.google.com ([2002:a17:902:fa8b:b0:2d6:6748:614b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef49:b0:2d6:e9f3:9305
 with SMTP id d9443c01a7336-2daec5ff490mr71575965ad.5.1788353019871; Wed, 02
 Sep 2026 05:43:39 -0700 (PDT)
Date: Wed,  2 Sep 2026 12:43:33 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902124333.2461949-1-praan@google.com>
Subject: [PATCH] iommu: Honor iommufd uapi for zero entry_num args
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Peter Shier <pshier@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

The IOMMU_HWPT_INVALIDATE ioctl uAPI explicitly allows an empty
invalidation request array by setting entry_num == 0. The uAPI
documentation in include/uapi/linux/iommufd.h mentions:

  " An empty invalidation request array by setting @entry_num==0
    is allowed, and @entry_len and @data_uptr would be ignored in
    this case."

While the core iommufd_hwpt_invalidate() handler honors this by
skipping its bounds checks, the generic array copy helper
iommu_copy_struct_from_full_user_array() incorrectly rejects it
by returning -EINVAL, breaking the uAPI.

Fix this by returning 0 instead of -EINVAL when entry_num is 0.

Fixes: 4f2e59ccb698 ("iommu: Add iommu_copy_struct_from_full_user_array helper")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 include/linux/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..cf16f9649645 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -569,7 +569,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
 	if (user_array->type != data_type)
 		return -EINVAL;
 	if (!user_array->entry_num)
-		return -EINVAL;
+		return 0;
 	if (likely(user_array->entry_len == kdst_entry_size)) {
 		if (copy_from_user(kdst, user_array->uptr,
 				   user_array->entry_num *
-- 
2.55.0.966.g6673acef38-goog

