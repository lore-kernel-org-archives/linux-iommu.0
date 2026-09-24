Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58844470B
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240196; cv=none; b=PiLRo+r5vDwwvOM2jPikjdzy39TbH7vCLJIJLItUgYiZI5OGB/7/zwRyu+BgiV96E01shWcsLXghIEZX1AltK6NXlRFYUhZLb6/6gmEnlB8olftzX4FnNuLEWIjuJH/VC67ZIa0JcY7SVRRKfgI4JDhjLMmZB76OjccAWoGNoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240196; c=relaxed/simple;
	bh=eLIV7GBDyUXW1GE0yyrhPOJcVmO1w3FP+tbKIHaKPxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkVAMvOzCw39f1BXHt+UpoCUk+xGkLkqyaKg8GlO7Rvuw9VeUG1AX6nPoWg3AnfWd5XT2eggSquViOP5Pxvk0cYiIQXbHyAYeTE05YDlddQ6HgXh6RCSmhss/VItlrOaqDyOocynmTMZa687+/zVNCUjto4hTIDOw3i5ckUt48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geRrPa9F; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geRrPa9F"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cf5bd2f12so21126195e9.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240191; x=1790844991; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hETdWP+28Kjop3TWViNya7dV2FwGxiafVK/A/I1RaCA=;
        b=geRrPa9FakTzs2kWT/G6zu45YNIYre/J+r0rHwRRG0H501mBfghiTYgnDQ0VLqAeJz
         6xU3Fg+iipO8AIIkEfQ4+qPu1CrMlqdJahxbrldB8RoYJXVyLPohAS5UQtw2eVSJxFCF
         ltvY6fpLeRVww7JHqWncmGRu8jSzbWTy2Bm8sTPN/H0FlDaM2i+eZowAZUrh+WcCEWJn
         6lgP4dch9Nk+40KIngALzjJ3o6gh9hi7RE+gleuB+mvFlt4ZpwblK4FRVNsjzr6g/4LH
         kZdJ4+w6Szp6D7ZBH7M5EqVXG5o0qKIVGFrPrEAwKrUtV7D00HOS/Ok30T/ISf8XlZsT
         kqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240191; x=1790844991;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hETdWP+28Kjop3TWViNya7dV2FwGxiafVK/A/I1RaCA=;
        b=RaPAr2hWZeVlTNhiGPRrBotfc+5OOBB2+zXbJpBtczHoYVhb6Sj/a9FclL5hAnGcaN
         YwGjme+ccbGzijhOFEXkQDulHz48NPt7wfrUe3EBsh8vyE4LwCDu37o9jBybpcQ2JKWa
         iQo0b9yqJiAzsdLeQ2VhV0Gw9Os4tKhxNbsxAAtSZA4iHKOIqiWNnYuFXVkNmtNqg/GZ
         VuLZd2yaV8YSqDV07VcpMp01kogODjjTWQOmXS/Fu/G6M7kWqhZvtPYeYkUCUAVIIfWN
         dATMILXca9Fw0W1ECHTB2WE1BHh+pWj9EHM3tS8siuKM2uyfQEUiq+6eMl7mMvzGinm5
         lBxw==
X-Forwarded-Encrypted: i=1; AKwUvBxe0G+HgBPk7/x/N8bF8mSwacM7dgloeK/oNC9mRZDezHVpZBSTipsY+zWOm+FLfvX2DshI2A==@lists.linux.dev
X-Gm-Message-State: AFuF++kzzASb61ikxSWBJG+sAoEpEuTWbiKP++q78TAtzK1QqE3MhrZA
	VkaV/1cKG131TyYOe1FpRYZ8IirzOyLnVXq9/CcXaFx5KT8AGeZDYfoJGP/dRI9WC6LaEJ7ef9Z
	y/ffmHcvimQi9Dw==
X-Received: from wmjv7.prod.google.com ([2002:a7b:cb47:0:b0:49f:e95d:f21a])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d99:b0:49e:6c27:d093 with SMTP id 5b1f17b1804b1-49fe7b739f4mr19669965e9.15.1790240190846;
 Thu, 24 Sep 2026 01:56:30 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:56:16 +0000
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260924085616.300650-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924085616.300650-6-smostafa@google.com>
Subject: [PATCH v2 5/5] iommu/arm-smmu-v3-test: Fix UBSAN error
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

struct arm_smmu_invs marks its flexible array member inv[] with the
__counted_by(max_invs).

arm_smmu_v3_invs_test() uses invs1 to invs5 which has num_invs = 3
but omit max_invs.

This causes the following UBSAN error:
[    2.333240] UBSAN: array-index-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:1116:21
[    2.333604]     # arm_smmu_v3_invs_test: lib/ubsan.c:228: array-index-out-of-bounds in drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
[    2.334129] index 1 is out of range for type 'struct arm_smmu_inv[] __counted_by(max_invs)' (aka 'struct arm_smmu_inv[]')
[    2.335375] CPU: 6 UID: 0 PID: 155 Comm: kunit_try_catch Tainted: G                 N  7.2.0-g8dcb331fbb72 #2 PREEMPT
[    2.335759] Tainted: [N]=TEST
[    2.335791] Hardware name: linux,dummy-virt (DT)
[    2.336254] Call trace:
[    2.336932]  show_stack+0x18/0x24 (C)
[    2.338443]  __dump_stack+0x28/0x38
[    2.338494]  dump_stack_lvl+0x54/0x6c
[    2.338518]  dump_stack+0x18/0x24
[    2.338541]  ubsan_epilogue+0x10/0x44
[    2.338565]  __ubsan_handle_out_of_bounds+0xb8/0xbc
[    2.338834]  arm_smmu_invs_merge+0x688/0x8ac
[    2.338862]  arm_smmu_v3_invs_test+0xd4/0x598
[    2.338890]  kunit_try_run_case+0x64/0x160
[    2.338914]  kunit_generic_run_threadfn_adapter+0x28/0x4c
[    2.338955]  kthread+0x10c/0x12c
[    2.338984]  ret_from_fork+0x10/0x20
[    2.339433] ---[ end trace ]---

Explicitly set max_invs = 3 on the test arrays to match the number of
elements.

Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 244cf34e5a0b..e52a7d95c919 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -654,6 +654,7 @@ static void arm_smmu_v3_invs_test_verify(struct kunit *test,
 }
 
 static struct arm_smmu_invs invs1 = {
+	.max_invs = 3,
 	.num_invs = 3,
 	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, },
 		 { .type = INV_TYPE_S2_VMID_S1_CLEAR, .id = 1, },
@@ -661,6 +662,7 @@ static struct arm_smmu_invs invs1 = {
 };
 
 static struct arm_smmu_invs invs2 = {
+	.max_invs = 3,
 	.num_invs = 3,
 	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
 		 { .type = INV_TYPE_ATS, .id = 4, },
@@ -668,6 +670,7 @@ static struct arm_smmu_invs invs2 = {
 };
 
 static struct arm_smmu_invs invs3 = {
+	.max_invs = 3,
 	.num_invs = 3,
 	.inv = { { .type = INV_TYPE_S2_VMID, .id = 1, }, /* duplicated */
 		 { .type = INV_TYPE_ATS, .id = 5, }, /* recover a trash */
@@ -675,6 +678,7 @@ static struct arm_smmu_invs invs3 = {
 };
 
 static struct arm_smmu_invs invs4 = {
+	.max_invs = 3,
 	.num_invs = 3,
 	.inv = { { .type = INV_TYPE_ATS, .id = 10, .ssid = 1 },
 		 { .type = INV_TYPE_ATS, .id = 10, .ssid = 3 },
@@ -682,6 +686,7 @@ static struct arm_smmu_invs invs4 = {
 };
 
 static struct arm_smmu_invs invs5 = {
+	.max_invs = 3,
 	.num_invs = 3,
 	.inv = { { .type = INV_TYPE_ATS, .id = 10, .ssid = 2 },
 		 { .type = INV_TYPE_ATS, .id = 10, .ssid = 3 }, /* duplicate */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

