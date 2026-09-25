Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417F49B21F
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352722; cv=none; b=pWZSwxYr9pVlJm4LeS0NVpD8gRynPviSKLH8ExUscpZHLSYi6tYz52S3/rzi+K2zWLQh89AO1YJxErSSXDccvP0e4ioIuBzPkR3Tc0aQFId5SLvrDQZ4fGFNmusD5rmC1iH/SjhASKzNhj2Helmsm0rwercuqWZzBhZpXbGbr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352722; c=relaxed/simple;
	bh=wz4bT1GonheGCmKoZsL/+QlgDflUo0GVx6Z0t97lEHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rg5WzIGkIOtoi4gZHeqr0mzwdouNFn6yNYkl18F4VLWsW7dPcsjP9YjEmG0JkkYRsmssjg2v5Z85qXlaMn+8UROOW2dvq3pZyIupKP551Wp12ZTTgUqe1MQQIxy5SBbi5SOKHa7CMEzjHhQ0mMFbBdQ+6PHIo2Oj8feW+3BG6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ru8MMHwP; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru8MMHwP"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7bcb94d3so8328025e9.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352718; x=1790957518; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sP0+/Epjm1Zv/XcAoYjyuNOC0ozQ/xub9MNxjeAUspA=;
        b=Ru8MMHwPRde3EwKcM/3HpVAEHNR7hggatzUbEE7uEzYusRAgu4Cg3v3WT7fJwwtEW7
         lJrLElp7d0U0Pu9fzRx6j52HaTweBI9aZyG8KFP1xV8PQcrzMH2kHtabHA1uIxAkielw
         6bAgyPjC/ZgRcxZg5eZRO1RovpoZotQg96VvwpuH8nFzkeEHygn61owEWUHnVR3IgoyZ
         IXLHkSp8sIXve8KNofoM+UWGPv72N6EEOJpeelZK99CdgiC61SODeJgJtFNC6lo49lpj
         dvW+/mhuqiDs8ErDljxqJMjkfejEM4Y2lQNLSmWZij2mKuh4sziBQqHmr2gJfZ/p/ZFf
         fZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352718; x=1790957518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sP0+/Epjm1Zv/XcAoYjyuNOC0ozQ/xub9MNxjeAUspA=;
        b=MSyid3q4dqWIcdTufAZN+ryZv/YRu1qilPHeyHjukkw74mfOLXo1zAuJPawBMdnKwt
         ZzMWY37nAJve0lEJ9EiAxSJ/KLwdw5nQW0XZgxh5CINatNncVEwcFTc/ThMZSxisWXzV
         6rM4My3qnnRVb7Cvg9Q/Fo+mUoltEtnLCk2pbs3kKGOlmIzyXEIlzWAIYmsjL2Wr7Y1t
         fL2kbVmGsMte2gVHcKkFai8EcZrUSuLfPBl4EeWTpkI12tJ3662ZgNRDjKsCpV36q1cJ
         a7NdySecGVvTKM0MwmIx1YQVQBFbZ3Hby0kopzN65dOyByMD9NMrxo/2gGukEgwPmN1d
         ua6g==
X-Forwarded-Encrypted: i=1; AKwUvBytHkC7QO9dK2XduE4JRWGsa5esDXgFvgJvlDp2kQJmgDh1Y9E5E4A0jqpqICon+6b5PxlK+Q==@lists.linux.dev
X-Gm-Message-State: AFuF++nVV0RzvEiQd64o9PjO71NsvlXfxFGG2L1s3Wv1DN5/3u9dxpHu
	KUuObr/Dr9X9E0halWxZI+WSPCAoZgWvwNSDq04vo/e8RudWaO59xLSL
X-Gm-Gg: AYBFou1vEI7xnvSgLPdBQZm3LNZeE4m/7xS53LGGYgvbqxBzdHapCjBqg/5orgVGH+q
	YwqwHdnSLAiYgQEQzhAFKS69U0UAC/z4YA/DsIGEC50M0Ndbd/W0WciA209ZRJ4QDYZMMVOKh+h
	HMKwn2Z31/h4kyoBQaAWqFvIQkoTjlz4dX7tu6icMKmjSu5N+B7VeRq+kbvMlal1/SR8SVUOh4H
	1DROtVfTkeAieqhPxGEOgFRigSDUEC8Eq7P33BMf5KfNL+I/BbXUm+IfUmSQ8l36V9J3ShTqzKZ
	b32sy0k2E9L66O3NUzCuPjOS4ZAzpyja44WVJJYQWRtZtjVgdRFPo08uCD7mJK1DI8i0Dek+c1j
	UPiq5or4kGzcgcsb4J4AgXxHLRj2KCCAqavuDyuzTAnyvNYVfb40y70OiA7+pL/8oHP1ji5mnfn
	024e2FU2xJE6jVzVmPkWWrJZOR78fdnpYw5vpTgIUEZP5wrurZxCC7/PH8WAFXDR7l4SPfHhtgg
	u7YWI4GFzf7UzAT7nmrUSmLv/SmSUXarrTY/q2khpAI
X-Received: by 2002:a05:600c:3b9c:b0:49c:fed6:cd3f with SMTP id 5b1f17b1804b1-49fe66dfdf8mr136621715e9.23.1790352717800;
        Fri, 25 Sep 2026 09:11:57 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm81238665e9.1.2026.09.25.09.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 09:11:57 -0700 (PDT)
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
Subject: [PATCH 0/4] iommufd: Keep IOMMU_HWPT_GET_DIRTY_BITMAP within the user bitmap
Date: Fri, 25 Sep 2026 18:11:36 +0200
Message-ID: <20260925161142.189813-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IOMMU_HWPT_GET_DIRTY_BITMAP can set bits past the end of the bitmap the
caller passed in. Two cases, both fixed here.

iova_bitmap_set() does not clip the range it records to the bitmap. When
a query ends inside a dirty huge IOPTE, the generic page table code
records the whole entry and the bits past the end of the user bitmap are
set, up to the end of the last pinned page. The helper is shared with
VFIO DMA logging, so the clip covers both users. Patch 1 fixes it and
patch 2 tests it.

iommufd_check_iova_range() subtracts one from the length before checking
it, so iova = 0 with length = 0 is accepted and reaches
iova_bitmap_alloc() with length - 1 == SIZE_MAX, a range the clip in
patch 1 cannot bound. Patch 3 rejects a zero length and patch 4 tests
it.

Tested on x86-64 under virtme-ng with CONFIG_IOMMUFD_TEST=y and
hugepages=128. Without the fixes the new tests fail: the overrun test
finds 56 bytes set past an 8-byte bitmap, and the zero-length query
returns success. With the series the iommufd_dirty_tracking fixture
passes, the overrun test skipping on the variants without huge IOPTEs.

Andrea Parri (4):
  iommufd/iova_bitmap: Clip recorded ranges to the bitmap
  iommufd/selftest: Test dirty bitmap recording past the query
  iommufd: Reject a zero-length dirty bitmap request
  iommufd/selftest: Test a zero-length dirty bitmap request

 drivers/iommu/iommufd/io_pagetable.c    |  3 ++
 drivers/iommu/iommufd/iova_bitmap.c     | 27 ++++++++++
 tools/testing/selftests/iommu/iommufd.c | 68 +++++++++++++++++++++++++
 3 files changed, 98 insertions(+)


base-commit: 54dadb030c7e2350957855d3995de05ae02c2e66
-- 
2.53.0

