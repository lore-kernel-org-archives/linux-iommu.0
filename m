Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9762595743
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887843; cv=none; b=JI42uxj+BPskVuO0X5rQZL8/MrOeK+kqU9egfxbeEwrPQrTEvT49Xhu+Dt523zsZDSposcd/MJQhiwcZkOrn31lXL4T1vKE05sswdPYO9f+uzr/Loa4BL8+e/QR6ZNfT8Z52VB9hEnyXIAAWoXSzaiqUotSO7F6wzCRnNR5s15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887843; c=relaxed/simple;
	bh=kKNlRY43OnhUVZYCIIpwPGN/1KkdINEKV/1NNUt+I7o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKkHK2eE9O/XB6/QKnuzrmTIzMThZ5t1CzojsH/bfEJCcOi4BVtmHKY1LhS0/RYCpauB+Fgxo/gAHog6b+U+bDXtbQCrbIzp90FaA3Qdczi4QY56WlBZ4aaubsjLyM9R/RoQqO2pVRZrXZQ8Ao04u7XGEyKlE8DLJQx63KxO8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAf9uW2i; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAf9uW2i"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-854f274dd69so2640532b3a.1
        for <iommu@lists.linux.dev>; Tue, 08 Sep 2026 10:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788887840; x=1789492640; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYCuDUEGwNS1Zm5PcRgjWFl3h0js1k+eD8YzXNXMofU=;
        b=CAf9uW2i9a6Vf32xeZoxuEGs45BlNQLtlUyfkCOMfk1NeW9avzIe+IBs93EzvNZ5/c
         feZoGfLzS7yFH1MQE588tJyajIjURIQfGechgCwA1qpdirgXdwW1Aqdp5Q7YUowmBsII
         2DdJr4TKiPBENz77hOc/CiJCOvADbguGqu2WXM5Ls8dWBgmebkUHtkvUqq9EOO3vPY0h
         g77gDkxW7Nq3I1EVfzA8+jwHU7e/G/kWuwoA9aCwstD6GQFMqwJuh7uJd9fbpXo6n7F3
         /kONro1iH7xj9UlSD36n53xvQN59e9qkYg45yFoxqxPOnrGOrxEGEBsAblfh+e2AegUq
         smww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788887840; x=1789492640;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYCuDUEGwNS1Zm5PcRgjWFl3h0js1k+eD8YzXNXMofU=;
        b=IhAF44SESzYMDSBOTv72ApdbZLG6/CUmNnUP3RiomZhEu6M6puYnJzqGfAoMMSaa78
         OkV8Sn47NJ4IWNEw5F11CEkIuA6rNdl5ooCE2d2zqPt0iV/O1gz7GyEuYTws7RBTpNbd
         L1zX7vV4p0dz8m1NZyyODDSuJxs7zZvSXQqVqgIbxAiZEJEDfmftPD9ucan067tt+Orx
         RKQiIn6UmnoPwXz9zdYTqk7lZCBhOBwRvdGNEd2ZrSPBdau6vxiAHizdE/TguXIGOlu7
         auH/1e/MHFrtHdJ7qo8VMSoRaxG7os5bmWduAJ9Dpm3AputqcqaGmSmP2nfJYsgSbEOF
         3DKQ==
X-Gm-Message-State: AFuF++lnoP0HAVYYCl4D5l4AkvcehKO6vpG8D09azzHkU4iTGoVZvrjK
	QgmKCt7ajTPhtIQ/xNpwRLYGnxQbxteSiGvh0/aJJb0Hk6JmLX5SJDlULkITE1FvvUgIuFTeHYK
	C/WdGUK06f0OSV/bU7sDDhAKNh60ZfWoqLV8Nv5CY8ZIFqDNw6EJxNf9JZgy/kcITxF76vImtD9
	OO00tVKYFGLcUXnkObFPnEoYjZL+wZfw==
X-Received: from pfam4.prod.google.com ([2002:aa7:8a04:0:b0:848:8808:ae6b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1151:b0:85d:84a5:b7bb
 with SMTP id d2e1a72fcca58-86168d8c2fdmr41280329b3a.18.1788887839972; Tue, 08
 Sep 2026 10:17:19 -0700 (PDT)
Date: Tue,  8 Sep 2026 17:16:58 +0000
In-Reply-To: <20260908171712.356645-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260908171712.356645-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908171712.356645-3-praan@google.com>
Subject: [PATCH v10 02/15] iommu/arm-smmu-v3: Add Q_POS() macro
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Gleixner <tglx@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Nicolin Chen <nicolinc@nvidia.com>

A queue position, the wrap bit combined with the index, is Q_WRP | Q_IDX.
It is a (max_n_shift + 1)-bit value that wraps at twice the queue capacity.
queue_inc_cons(), queue_sync_cons_ovf(), and queue_inc_prod_n() currently
compute such positions by open-coding the two macros at each call site.

Add a Q_POS() macro and switch the open-coded sites to it.

A subsequent change will apply Q_POS() to a position difference, to count
the entries that a queue pointer moved past.

No functional change intended.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 270e6617a19a..06b7de2e6e4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -181,8 +181,8 @@ static void queue_sync_cons_out(struct arm_smmu_queue *q)
 
 static void queue_inc_cons(struct arm_smmu_ll_queue *q)
 {
-	u32 cons = (Q_WRP(q, q->cons) | Q_IDX(q, q->cons)) + 1;
-	q->cons = Q_OVF(q->cons) | Q_WRP(q, cons) | Q_IDX(q, cons);
+	u32 cons = Q_POS(q, q->cons) + 1;
+	q->cons = Q_OVF(q->cons) | Q_POS(q, cons);
 }
 
 static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
@@ -192,8 +192,7 @@ static void queue_sync_cons_ovf(struct arm_smmu_queue *q)
 	if (likely(Q_OVF(llq->prod) == Q_OVF(llq->cons)))
 		return;
 
-	llq->cons = Q_OVF(llq->prod) | Q_WRP(llq, llq->cons) |
-		      Q_IDX(llq, llq->cons);
+	llq->cons = Q_OVF(llq->prod) | Q_POS(llq, llq->cons);
 	queue_sync_cons_out(q);
 }
 
@@ -218,8 +217,8 @@ static int queue_sync_prod_in(struct arm_smmu_queue *q)
 
 static u32 queue_inc_prod_n(struct arm_smmu_ll_queue *q, int n)
 {
-	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + n;
-	return Q_OVF(q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
+	u32 prod = Q_POS(q, q->prod) + n;
+	return Q_OVF(q->prod) | Q_POS(q, prod);
 }
 
 static void queue_poll_init(struct arm_smmu_device *smmu,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index dd2fee2f560e..84e618a7fa9e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -187,6 +187,8 @@ struct arm_vsmmu;
 
 #define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
 #define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
+/* A position is Q_WRP | Q_IDX, wrapping at twice the queue capacity */
+#define Q_POS(llq, p)			(Q_WRP(llq, p) | Q_IDX(llq, p))
 #define Q_OVERFLOW_FLAG			(1U << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
-- 
2.55.0.979.g7e5102b832-goog

