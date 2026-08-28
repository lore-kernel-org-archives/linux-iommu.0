Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDAF451071
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921677; cv=none; b=YT/RLLe7hF2rQpMNn4mLyagPRD6ZMDKYeKohfPLygEbOe+ajyc/gbbQ9BtiHxfi/HDicU7xp3FNMquF+TjzLhMpRottslqjkRY0dxatYD+zB3WHY0mTLHvkyO1IO+moBsWaKDXq3rUpuNeMqhfrF3jSAWPghjEuhX+Wp6ipwcjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921677; c=relaxed/simple;
	bh=gVQ7u5jDgJkCL3SN8F3pewl83SUruus2jM9vNu3Da/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I6KdAA6YBjpkOieRgelunyMPfh3AH+D8klW6ES+KV9w/fbFbrCGIxo3wMNV/wZAdSYRq0ZE/3FFlzCnmsU///riobsZwLw7vphASpTaAfv1R0LyfdSJkaflmCcEojIkchkZycTDRWiEDlc9oCW/URRn6G4LaPZvnGKaMVpXGy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=te0jBVtR; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="te0jBVtR"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso7802345e9.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921675; x=1788526475; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqE2RL7ob83hHe4LCs/SgOtsDWUwdfHdO0PxSusQVD0=;
        b=te0jBVtRrK0VjBJeNGc6unYrhVnUhHTDl4QEQR0xq33+FjjmKI5EzXcgKZXB19gBvs
         tFzGAHvuS4Bgv2P21ZnCPwzi6Z9rpYqRPPd3xfl7iRCC1H6WZOetPBYpxu86s7l1kg7r
         TJJxZ8SjJwI9lKGaMP0/HCXRdQJktpetkQ+w5rcK7gv7Bw0mEVZdn1b0Eq3QzMN9BfCu
         6+BALB/SIBRVxq543LMG7hh1d6TPD1ARe9uFSWSK4HUtHGR4UASwsjLe6GX4y1V6h9fQ
         alsPBY2rnlgXqEuV/oEG59dCIkqshyEMRFXBueHslHLRUIZVAycJJ36wG704L/79z7fx
         Ch1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921675; x=1788526475;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqE2RL7ob83hHe4LCs/SgOtsDWUwdfHdO0PxSusQVD0=;
        b=BEwZ0l0XLnpecdhzC2z2HvA0ajTsxhtfThiT/CNBbJf/DM69F89xi2OuX5p+JsJ5yZ
         aWINhYn+TgzhdloUnOdabkPP3ZOfulKJtl+w+NgrUsTrYDZzKuQxM1z96+ODhqIwWYVu
         nv2eMcd3cc34lhQaKmxFF6+OrCvA83w2Xjie+7BYBzkm8uVP0A1O16oIcBCh68zFl3DR
         3QTAow8PJYfDrgMgmpEQ6EQT9DpBcZ3b3tGwIUqwn7siMv1U5piP26vqBT2WKP71f2vG
         cQKd1a/8n6xXTwgb5Sq0T8xfqayUk0ZUyQu4nPvsrMXfQdvFhshT8ZOLgowUnqBv+9LZ
         WpEA==
X-Forwarded-Encrypted: i=1; AHgh+RoJoxTuasctaSX2GQDmYccRnl/Xnp9uplbnzoWmoZOmRBCc79ZHEFgqkajEUn2Z/kr87xPG7A==@lists.linux.dev
X-Gm-Message-State: AFuF++nnyj/XNnGxqYwwOivnlSALcvPMOI8irzCMYfkMynuejKN4qB2m
	sxB6/Ijirx+vWbw1YR2qgCYd57n2CT20p9rvUyJtqu1m4XqB78wuHKDUg2ERVvZP05pYR52icFN
	lytodzJ7JtKdQjg==
X-Received: from wmlf1.prod.google.com ([2002:a7b:c8c1:0:b0:493:bd51:5095])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6b:b0:49b:c8e:8e6 with SMTP id 5b1f17b1804b1-49b91bd99b7mr113293015e9.0.1787921674606;
 Fri, 28 Aug 2026 05:54:34 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:42 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-8-smostafa@google.com>
Subject: [PATCH 7/7] iommu/arm-smmu-v3-test: Fix UBSAN error
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
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
2.55.0.897.gb25b4bd76c-goog

