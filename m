Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184864DAF94
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352732; cv=none; b=omAwsOygj8MUyg4WpXuukDyvonz6psZmBLEyuKE4DB+gDkMftKWj5oMqLk10xSTfOihNs+msAVal8VEsikrWIAIsxpk76ltyTKDT9VUzb1ubEg3c+tbWQz1ov03byOMu19d84yL9eC/xmkt+PLeDOpSUB+wZAEL/6gYUDMGIsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352732; c=relaxed/simple;
	bh=3zBndnPbmFeoFqTjACZnEMiREdKYWlO2VdcYcm001/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F10L5s7tkbHt1GZ0BMemuhGhJCgSZM/khMl+aKH3cNKt8HJ1nkuw04Aq/lzmbx7J82oByVX+EuDLCoHyvm9MyLTNPWVruffsfmmbgdaf+4XMg0sWzStBr2oh6uJr8r69St1egHms0WEae3/C82nMywGTeBJWHzdr3+vI8ey1gSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1bc8GjV; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1bc8GjV"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3931so8942075e9.3
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352728; x=1790957528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qJjIAQ7/2x2XhBZs9VmF+j8AOgJ6YIg+9lR4a75uO7A=;
        b=R1bc8GjVBZpMdi4Zg8J+vW0NVG9F/aEeJe6V7HBzHLdXKLfVpzGFHsunOdvzBTJyay
         as35TjuFFWDEgbNnW+2PO1rC84SgAm26EGtk4LFEKN/L6+rHazR9vPpbPR3xR4BxzO33
         2zqy3mXvTQMz4+I69uTyjW4FzYKsLFJM5mIHWwSwmbG5FdSPptrnCHGdW7eBm9I9pgNH
         e0axBRLQekBH01+KnaKEYzu96sUtZrdSvvPJIA56yTwRsNfs0QMIuucx5l3H9Q3rXtJP
         aILiaqYjZoAAXI67EOshFceZjiCcz1hi8c9u7kPhYxZgg5dRShdhseyNff590TWJJldK
         kDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352728; x=1790957528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qJjIAQ7/2x2XhBZs9VmF+j8AOgJ6YIg+9lR4a75uO7A=;
        b=BY9LV3OCXVvGly8gS+EC39GXeOXlxIYVGkK9pdWkQ+OZtW9h8a2kfhZ0vN7PVGY2yP
         uJ3CEScUV/Fvwypi+3G8LTxjT4dsCvX2FkN5A1VRt3b58tusTvNivINp1Bw/fW6vlemG
         Ktv6H3csjIqHH0ECdfgTPu/02roE6A9hYvTl7ohFQG2tsJcORHG+PTsYjUjViyK9Ugxk
         6IOyNYJM6nnZmd2AsAPg0yYkTacH0e0W6yyUXoCPjZQc0Vt4hyGlZemTqwsBuq566BIO
         Zgpq+PiHj7K7RqHBreuYpBNpn1JB54XpFFMZPzprRmWZo6STeGgoT9/RZYNOc7wsX8cB
         ObRw==
X-Forwarded-Encrypted: i=1; AKwUvBxpuVQA9j4PteMpzudX3HXrF0ZCMFQqYndyu1huuo9Ark/24IGsRZqXEntnEzH6uEntQz6JCA==@lists.linux.dev
X-Gm-Message-State: AFuF++kUSN8xMUYECKq4kObrm+sHtcnVKglzcmsMVxsWq7i7NSxxAcwN
	7NVhl28sHCX14UnlY3jRwPb41IcC/oTiUIgQLzWnkoTRT+V/oFT3sUzK
X-Gm-Gg: AYBFou0xjdv+PVo7F7WyOFIYrsXQNTqYPXW/ealYEB1zzf50EKOdSC9FZlcRmg4N4pe
	hQvP7n6lyYars2lJx1Oef7RY71x258PfCm+WVScEuNvtCFFzq0c8UKElk2eY1Z3dAf66reh84oK
	DoISFhAB6xNF1ku9d7MyOrdvypE8/kn1vo7UINSSrcYxZ/HbzGXkriMnPXCSw+0kwVxtt9M1bCl
	O9klw44vmbZ3en2WJ6Xt7YghIbaP7xIJWZoQCgdWrDb7p0sdERTiHPQGXI9sbJT7L1Wj2tq+tFK
	Xdtw9FwbqsFy7P4CMWHZV8Hx2bReOQqL7azLqMqjeLYRXshC1Pf/orAtX/V5kDBS7jYLEGS0yS3
	plFfVbQQ0kRty2yYQAa6UHtSwyhNHJu4eGxfTVWBl38s4W4o8vFNPcRbMOx5XJUsPJnZ0vEGcrE
	s8wIr9CdK6rgF7+ur+gCbm5oZmdYDDUhbdpBmUk2hQYFSXGnISRRVJosWfUJukOqFbjrDVbiZor
	YiQPE35GcQ1lSftHQ8MEH/45nU4eaSP3zzU8GrwXL4Y
X-Received: by 2002:a05:600d:d:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-49fe7726ee3mr94636635e9.32.1790352727934;
        Fri, 25 Sep 2026 09:12:07 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm81238665e9.1.2026.09.25.09.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:12:07 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Joao Martins <joao.m.martins@oracle.com>,
	Alex Williamson <alex@shazbot.org>,
	Yishai Hadas <yishaih@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 4/4] iommufd/selftest: Test a zero-length dirty bitmap request
Date: Fri, 25 Sep 2026 18:11:40 +0200
Message-ID: <20260925161142.189813-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925161142.189813-1-parri.andrea@gmail.com>
References: <20260925161142.189813-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a GET_DIRTY_BITMAP case that passes iova = 0 with a zero length and
expects -EINVAL. iova = 0 is the value that lets the zero length wrap
into an accepted range; without the previous patch the request is
accepted and returns success.

The case runs on every variant of the dirty-tracking fixture. Tested on
x86-64 under virtme-ng with CONFIG_IOMMUFD_TEST=y.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/testing/selftests/iommu/iommufd.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 47d861b3bdd7b..2b3c9e9c69ca7 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2472,6 +2472,25 @@ TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_overrun)
 	test_ioctl_destroy(hwpt_id);
 }
 
+TEST_F(iommufd_dirty_tracking, get_dirty_bitmap_zero_length)
+{
+	uint32_t ioas_id = self->ioas_id;
+	uint32_t hwpt_id;
+
+	test_cmd_hwpt_alloc_iommupt(self->idev_id, ioas_id,
+				    IOMMU_HWPT_ALLOC_DIRTY_TRACKING,
+				    MOCK_IOMMUPT_DEFAULT, &hwpt_id);
+	test_cmd_set_dirty_tracking(hwpt_id, true);
+
+	/* Only iova 0 wraps the zero length into an accepted range. */
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_get_dirty_bitmap(self->fd, hwpt_id, 0, 0,
+						self->page_size, self->bitmap,
+						0));
+
+	test_ioctl_destroy(hwpt_id);
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
-- 
2.53.0

