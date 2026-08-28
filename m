Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2543CE79
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921676; cv=none; b=YuYFdZ0iZCB9CT76wMdOdyMXH2tkxTAnTfg/gWEKn3DbZQPz9pBXtkfez31tfdAjTH6sctQvQ1zg7IvoHwMr6myzEQpnyOcxJAYpvgiibLPjA8knw6wo9C8ShD8C9gO6r1OPx3V9+okQlTK9GsqvGZ5/QGmtHYATuQkVCs69cEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921676; c=relaxed/simple;
	bh=cDjSIu32aBcSz8TdWp61j1qcW7QdeCw7abPmRtNMq4o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oGB4wmEVsy04YD9QDuokperCghp1Gii0B/YneBT1g7f967wZRL0h4HUySQ2bHjBlKQcN2xc+F+ddy6YE4/cfiKx8PtWDGRKfhfGT/2iUZrDBXHaKW9NlaR/WFH9g1FOBfkw61xrmOcQtns0tH8UNXhCw65xqQO/RpmgQ2rNjb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jf9udwJz; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jf9udwJz"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4814718d124so552574f8f.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921673; x=1788526473; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ecFwLqLiGFgZXlWDMNOiqsl5/zZT7jnAo8maGJSVqdA=;
        b=Jf9udwJzJwb0f4iTUUB4NiOF9cI3tTNKG/JLKgeuRrU81SimOlLjSTL5eqFydoTyoH
         mQbWWePkYQLXzRPxVHjetNdI+GambVm4yefQ8pqYmPOubPIcPTnGiVFdUl4InsW9BblX
         hhuUjNbMV8MsJwN3B6kAPF5/oVMWBkTjv6cfX8Vq0Re15TLc0G5FXlQD9/us8MHkEvxu
         WV85KJxXYVetyGjkWPzrUAEDwUpvpnQLGHy2TrUUuqjAJgqxupWzr6SBTo/z6mGkaD9u
         YVYV98z9ysuZk8qdR1UqBgn9SgNSBQoL81NKb0D48y9IXoZAZSjzrPgzZTAjCTBNv02A
         yrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921673; x=1788526473;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ecFwLqLiGFgZXlWDMNOiqsl5/zZT7jnAo8maGJSVqdA=;
        b=Dp/fRWjkpnqHOL6tMdbBQ3CGdBp79V9Lm+ZOIXZci/gwOLMd0IlOaF9BjrheKOmsYQ
         JebqEai3ouD/5foPqZ/ghm5HAZ7iV+u96NAEoSYT4bc6DyAweW4tPbl6kwWFUFiPMjtk
         7ZG2do3x91etduzl6mhTNbC3clVbgLxfe5LUJg3s+Qq0vZbgj4QhtH95es1vjqlkoLpz
         WNwygiJGAgJXry18VZgql9YVg92NdwR9RMtVgiBWvjXRZ6mR3222Pi4ILl6FX4VW6pW1
         PF60In4ags6m6pXBs+DTrR263Hz+pykREmUp7v4D+V+5pW1zLjuizzWbYpqAIweHOvsH
         rqWg==
X-Forwarded-Encrypted: i=1; AHgh+Rqy9Q4+9rAcLH8h5UJnhiqouPZ+Yg1tXd6fdq4LobFNulZVcJpkSAkcQyugHTPxHjmI/nkUSg==@lists.linux.dev
X-Gm-Message-State: AFuF++kTScB5AejNL4LjpCp/xTlmIrJXG2/o6tjfJq/2UIR5QIFeq30b
	ERypmoirEisgaBgiuTeH7xQfiQdw+mGewvGBSo6pNK79qE2DP2+Ln2Ub5z7N0NVx1uNRzSIchUw
	VCSZDN3XCO+RFbQ==
X-Received: from wmlv9.prod.google.com ([2002:a05:600c:2149:b0:49b:8f4c:fc2e])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6088:b0:49b:2796:be30 with SMTP id 5b1f17b1804b1-49b91c433a4mr103156005e9.11.1787921672987;
 Fri, 28 Aug 2026 05:54:32 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:41 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-7-smostafa@google.com>
Subject: [PATCH 6/7] iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_v3_invs_test_verify() validates the array bounds using
KUNIT_EXPECT_EQ(), which triggers a failure and continues execution.
If invs->num_invs was smaller than expected, the next loop over
num_invs would blindly read past the end of the invs->inv[] array.
Switch to KUNIT_ASSERT_EQ() to fail and stop the test on bound errors.

Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
Reported-by: Sashiko <>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
index 366dcb2b5554..244cf34e5a0b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
@@ -643,7 +643,7 @@ static void arm_smmu_v3_invs_test_verify(struct kunit *test,
 					 const int *ids, const int *users,
 					 const int *ssids)
 {
-	KUNIT_EXPECT_EQ(test, invs->num_invs, num_invs);
+	KUNIT_ASSERT_EQ(test, invs->num_invs, num_invs);
 	KUNIT_EXPECT_EQ(test, invs->num_trashes, num_trashes);
 	while (num_invs--) {
 		KUNIT_EXPECT_EQ(test, invs->inv[num_invs].id, ids[num_invs]);
-- 
2.55.0.897.gb25b4bd76c-goog

