Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5343F4C3
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921675; cv=none; b=eIUs2KkHYVtJNH3ZJOC6IXBG2oBoGVR2OWD+MSLAytj1B9/X/aoI6BxDJW1568O+bHs6Bu1HgHEVZPfZDclbake5KI18lwCRek1qHMva+bWTHyFtlhFU4yb+FgGxE9R31TbbvC/Im1cZeJXjZoTkwjnJpvyn0+lSfwbDuo7UeSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921675; c=relaxed/simple;
	bh=Y19wC9aROH0p2C0YhyoiBj7Iw1xMl80M5dB6Vw2JHjE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HBj3wU08XaVsthHRTKQjqRh4j+hWWz6C0wsEwB9BZgyv7GEq7yYMYP0hTrLqa4ATyZWXWGXNXwjYROquvuuHt92mwS5WHFoQT24uN/oOaW9rtasORu2sofpL9tpXHoHUbFEf8JrNjUTg5iCiD2os6fPVSH2Q9o+n0RiRRkMxASU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WnX/xEWs; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WnX/xEWs"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so6267275e9.2
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921672; x=1788526472; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3t59Cwp3hUZ2CzdmTE2YwsjNcWIkkKVh96IkZiq53c=;
        b=WnX/xEWskwiViaQB1/6cEG15aRQSwUxKgEK+MgswbuWMyD3Mn/NVUcbXi95siADWch
         ddxs1bb/gMDrWHF40wKOi6qSpSPAaGklmz5bmCPhjqVwg1PuXh9klj+HDQWBIypncvbQ
         SSEXRrwgTiRwiDLF7318UPVPA5yAjtmdA24/+ZHn+o9mPn/d5h+CB2SPboI/iS1LClTd
         xkux0LZOSpR0LMIJjJAdeDjV03i67Xru0fEvO3P//Y1pV+n0Tk5nuLVBzbKi/WYzA273
         kI8dM6XwaGAUs9C7ykB3iFDbPHgbezzLknADQ6HxavGIwrmx4OtUBQBDnyPQJJa2MBZi
         DjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921672; x=1788526472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3t59Cwp3hUZ2CzdmTE2YwsjNcWIkkKVh96IkZiq53c=;
        b=I/igrGdt9hrBnOKeNrEdKLz/yBXDZ73nrYSN/kUs/pGgLwMUEqJi5BBzCBpt6ks9Aw
         10KXM9kCJcmj79orZw1EhFp0gnuTCbXIurQL75FvwXDecYiPxzdHJ7+cJFwhobVSjGYJ
         Vs/G9mXO9WhSo/EALLaFZDYOEPqniD2rn8IRWvZhfKEMOT7P3aRuTWWJp9+P3HySOsr2
         wGIKgfUckC5/tDWKaMzDg7lfkfsdfMEY7smDua9gyn3UVSqcBmNd0tVY1RAxeqHLskWm
         AaxGnjASkhCVBImcIlgQdzuPs/eKLIYgYVH0JWiy4Qu/0Wl8i69S7ZP7nmSI50iXyY5w
         /W0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rpv5tduWdEtxxHDLlxup7wtu+qwhG/1XI6SCB5IpAyc/lkvNi+/9ocTM8j3fjwZyHQFTvn4qA==@lists.linux.dev
X-Gm-Message-State: AFuF++nbgnBV+ZCz6IhyfGmjB0ZDDsY2PxJmuAnz06zD7Fq668IyD9yR
	i1cBfmjmC1WdN3fTrv22GYWYpRRjqmRdCv8blyv9S2RPjn12gAfdsFiyCcn5NZoUzjpyhzMPZNw
	aq3qkx3S3L+2+TQ==
X-Received: from wmsm23.prod.google.com ([2002:a05:600c:3b17:b0:495:6261:8954])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c02:b0:499:8ff5:8ec4 with SMTP id 5b1f17b1804b1-49b91c2e11dmr109166555e9.3.1787921671689;
 Fri, 28 Aug 2026 05:54:31 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:40 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-6-smostafa@google.com>
Subject: [PATCH 5/7] iommu/arm-smmu-v3-test: Add missing error checks for inv array
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
2.55.0.897.gb25b4bd76c-goog

