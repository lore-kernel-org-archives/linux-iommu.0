Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7033443C11
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240192; cv=none; b=Yg6BbOkgZDnAJz9YvdbzhHs2FQnH+t4iLOY30tPgcLEdA2cjTbrOtrCDIX+RKbYIsqOYhNJ2c/t7tGquY6c+FeqB83ZckZuicZzUVeRFP1uVJslMoqWjE5XpTvhpgHNV0rU0qKDAuAK/06XQNOPgx9RDjioDJGJofDxVNtEPdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240192; c=relaxed/simple;
	bh=KeDy4IrcG1e2xwDfz722ZsSdT3LmASiGfQOxY9XlU70=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UoxGWwql31CainEiey+a8G+pOXM9fzSVIQWX+62l5HFu0mnZu/AMg32bc2j3MQTTKALGVD0/CGQfn3fpcylWJhv3sdQPh1fkemDywDoRtjRsr+sl72Pf9g4sRRHtUKYv0zmGOZTimKIr29hijVjBYHxDnzMrZNp465QxRs/moVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mzf7Xbhe; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mzf7Xbhe"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29466736e3so171753066b.2
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240188; x=1790844988; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Vg0s5N/57YDwzYIoROOFrmDFDxGbcQ0sOsS1KaKDkg=;
        b=Mzf7Xbhe8eOQx+JORj1hvpUY4fIM/a1nnLJDPN5Insje0v9lhCyMkMgjE6CUK7uLXu
         sS2CDOzXqjs9GLppNvaB0UyHzHzR2kbu/FX29KWlaIgI84fxETD/NIXilGNGaQ+jVpAV
         VnMUTrF+KPYklBLj2JRPbaUA9BFy9uxIT8i0kk9c9ZyCSO7jsgxoOyqRmaBXusEcl/nR
         NJhb3sWy6XPriZ+AIzOteoKTc8hkPN/kcjcWosPVfx+v00XwlW1XpsnQH2r21GHAuR5T
         tX6QTJidKjbtiGdTSU6Hg0PXO2/EjqCtyWhXZ5WsIbqYu+/G9QJB2Wuz0kowAsXaWJ3O
         0COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240188; x=1790844988;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Vg0s5N/57YDwzYIoROOFrmDFDxGbcQ0sOsS1KaKDkg=;
        b=0SJ9erd8fCEAAyrRzq49WABFb2Dnm54MQgtr7EOh0iDh8iXyTcLajcBALwDWx7N7uK
         8mc4J7PErONgsxcAkt64mawE3xdZoGcNEa9Ehl8GXAqABqe2NbS4qFnhAwAVX9zyiHn7
         yevI9I5ASW+M4avbDQvYZ1kjVXKidd16IfQAsdGPHR/vCkPOdQqWTzFFaTMq86lpNK83
         PZcImoDvrYKVDv/Mq+SiRWyovwowK63eUdMqTyfE1g0XlSeX4AsuuO4Ru7+1OlpH8q4r
         aP/FYFYMVFzw0K5ZdVarEfxmGpphZ+aL7wMfuWCK3vXo/PQ6P3diEE+WnTQP7TQl70xW
         lwKA==
X-Forwarded-Encrypted: i=1; AKwUvBwR4C1xzh9h3hzimj9Z5vFJN/9eo6DiqSkIDIK+xbKwn3M3poqflLpEFKgAhXsaxIkCIKRw8Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kj2OHz2mi7Yp9jNUoTM9fmmJ1TNd7O3a0/udw6S4AXhvOB8hof
	8cDsSJx/6btbO5ZKuJOd5Q0+usG5aXwMKdiNIJ33pydP/ECP9uSK8NwYChMJzmj7n4tZCG1MO8C
	l+9t3D4iO2BEt/A==
X-Received: from ejcgj35.prod.google.com ([2002:a17:907:7423:b0:c16:9d46:17a4])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d409:b0:c26:1648:a069 with SMTP id a640c23a62f3a-c2ac24f9cabmr130143366b.36.1790240188197;
 Thu, 24 Sep 2026 01:56:28 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:56:14 +0000
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260924085616.300650-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924085616.300650-4-smostafa@google.com>
Subject: [PATCH v2 3/5] iommu/arm-smmu-v3-test: Add missing error checks for
 inv array
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_invs_merge() and arm_smmu_invs_alloc() can return NULL or
errors which are checked by the driver but not the test.

Add KUNIT_ASSERT_NOT_ERR_OR_NULL() after calling them to fail the
test instead of accessing NULL or ERR pointers.

Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
Reported-by: Sashiko <>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index eae08d4d77ec..366dcb2b5554 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -704,17 +704,20 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 
 	/* New array */
 	test_a = arm_smmu_invs_alloc(0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_a);
 	KUNIT_EXPECT_EQ(test, test_a->num_invs, 0);
 
 	/* Test1: merge invs1 (new array) */
 	test_b = arm_smmu_invs_merge(test_a, &invs1);
 	kfree(test_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_b);
 	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results1[0]), 0,
 				     results1[0], results1[1], results1[2]);
 
 	/* Test2: merge invs2 (new array) */
 	test_a = arm_smmu_invs_merge(test_b, &invs2);
 	kfree(test_b);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_a);
 	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results2[0]), 0,
 				     results2[0], results2[1], results2[2]);
 
@@ -726,6 +729,7 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	/* Test4: merge invs3 (new array) */
 	test_b = arm_smmu_invs_merge(test_a, &invs3);
 	kfree(test_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_b);
 	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results4[0]), 0,
 				     results4[0], results4[1], results4[2]);
 
@@ -737,6 +741,7 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	/* Test6: purge test_b (new array) */
 	test_a = arm_smmu_invs_purge(test_b);
 	kfree(test_b);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_a);
 	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results6[0]), 0,
 				     results6[0], results6[1], results6[2]);
 
@@ -748,12 +753,14 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	/* Test8: merge invs4 (new array) */
 	test_b = arm_smmu_invs_merge(test_a, &invs4);
 	kfree(test_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_b);
 	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results7[0]), 0,
 				     results7[0], results7[1], results7[2]);
 
 	/* Test9: merge invs5 (new array) */
 	test_a = arm_smmu_invs_merge(test_b, &invs5);
 	kfree(test_b);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_a);
 	arm_smmu_v3_invs_test_verify(test, test_a, ARRAY_SIZE(results8[0]), 0,
 				     results8[0], results8[1], results8[2]);
 
@@ -765,6 +772,7 @@ static void arm_smmu_v3_invs_test(struct kunit *test)
 	/* Test11: purge test_a (new array) */
 	test_b = arm_smmu_invs_purge(test_a);
 	kfree(test_a);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_b);
 	arm_smmu_v3_invs_test_verify(test, test_b, ARRAY_SIZE(results10[0]), 0,
 				     results10[0], results10[1], results10[2]);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

