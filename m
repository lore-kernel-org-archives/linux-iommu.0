Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F5443C34
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240193; cv=none; b=q0nLw5VsfJ/p/6KP4QhkCLrZOHYpK8PMRiceBIXZ3Tg5mYESVq/Snn6WUc+Sn/bg3IA0wg9waiz9PCz3KhswIHwfxRHZRvtt0YLvmHWX+tZYEAys1gB60HzPvWVme7II0QKTIRg6jWKMiNsrBhI98KA8g1yFfUnNrJR1EJFn/qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240193; c=relaxed/simple;
	bh=7iMQOQ5HcgSI/XCHP/GEjkexPkCe2PLzf76QDMbSjrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EGIQOKXZETECMCtuk4SowFLqyWJfxFFBhRj0s2rkl3y7G7mLLRpANqnA9J5FY1LFU6Hoq2kxIjLTWVozKG4YDHecA5IRdqcXCCFkefMd4LpiwdiBoSOGnEB2B7ePJ6LzJhB1pJmI6MKtnBeak8kCbCVSNmWnBROsVFXpZkxrhPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXohL7GJ; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXohL7GJ"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c29959eb71fso181155966b.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790240190; x=1790844990; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeCtBbQ7yt7z6sBbxQb9QyYhXFA8zToXd2a7O4Dja9Q=;
        b=UXohL7GJUfyNNZc/RYjfmdjZX7tspSdIE2RC2Fg4QudZnijnA9lFOfox9Z3ucc8ROJ
         Ed6qZ0pwUnOsdB4XNbrUOO/AiKn2Xo/KRwfmPd7pHV5y/lL/ym15i+7QJAkwD2dB33C8
         5DemUTpkEo5SiWbKNmjZBPPxziJsIXwtsZWmpyK4uP77eIU1kQNT90cHmolnTMXCU/XY
         26bB7HRX+DGArnrDJAtjnh09AxydAfWsSPsyYJHJ6a4SqLk9P8SEYlbM80c4yx+g/OsN
         Lrqpywb+7qcNIsL7xJzZcQRsY9Pw3i1NIJOEoXmenhgdVRoqql3/IpT6lV6ngc0+Uo69
         QOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240190; x=1790844990;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WeCtBbQ7yt7z6sBbxQb9QyYhXFA8zToXd2a7O4Dja9Q=;
        b=EWVrLLhtZzYS+cm8/tcIfTZyNzUAcYf30UdZ4atrZKfv9tnbvKrwIGj5IRr7W+Tp8f
         uUO6uHQ0TkuHXJ+EuxZVk63iJ1r6cYYUmkp79IcIgOCJxQBVW5ZQiV1wzFUVITh56v2A
         6wgezh4rZtA3jLlWmhJI97sJW572G14FACrHCtX6jb45/1PtzrAAG7PLnRuE7ZrABVwT
         r/hI0WyAJvDp2g41uAfbfaUJGso/t/26g9uv5q0Y1vjijoDuuDPAfr1eruUcgKxrJjkX
         tdlrBYrOlbBelVxJJxJsL774F4Gx+E0Exu3xPA26/7iP4/uJZtaZoRnwOKow7J+SqsVW
         I8yA==
X-Forwarded-Encrypted: i=1; AKwUvBxczzzHVjCozGS6qiO+c8G9I0nNBTddmahM4dtn+7KjQ7Eis2mWupi32VeOqhd8qjd9/3rCGQ==@lists.linux.dev
X-Gm-Message-State: AFuF++nBFWVIxIgOM1Hk3fF4H4zXSq3cysga80P8nRSPHCALce80ju0V
	ndlN02Qj6h2f/71b+7JCJchbH+lzpuCAE30zczVaSQVlTzWRz+5LgtxVTXZstqAU8g8HADa0MvZ
	CFh+fnAyp0kdkCw==
X-Received: from ejcet6.prod.google.com ([2002:a17:907:2946:b0:c25:2d7f:4eee])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7a8b:b0:c29:3b7e:3a94 with SMTP id a640c23a62f3a-c2ac53d2785mr104883766b.38.1790240189335;
 Thu, 24 Sep 2026 01:56:29 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:56:15 +0000
In-Reply-To: <20260924085616.300650-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260924085616.300650-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924085616.300650-5-smostafa@google.com>
Subject: [PATCH v2 4/5] iommu/arm-smmu-v3-test: Fix OOB in arm_smmu_v3_invs_test_verify()
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

arm_smmu_v3_invs_test_verify() validates the array bounds using
KUNIT_EXPECT_EQ(), which triggers a failure and continues execution.
If invs->num_invs was smaller than expected, the next loop over
num_invs would blindly read past the end of the invs->inv[] array.
Switch to KUNIT_ASSERT_EQ() to fail and stop the test on bound errors.

Fixes: 15a2a5645ad7 ("iommu/arm-smmu-v3: Introduce a per-domain arm_smmu_invs array")
Reported-by: Sashiko <>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
2.56.0.rc1.315.gc6ed9934b7-goog

