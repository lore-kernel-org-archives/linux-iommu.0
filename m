Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000BF3D666F
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009426; cv=none; b=Fjli6IBxkN9YBlYMOzvF8A9OgmHRKhPloA2aPyZOB4k4KPzPHFuSmuj7sIpKScd8eub7frf0fpkV0M66xxeObcVPWh6CAmS2pOK5VvZQujsqy4szwecZ1H8pXHTimY9ehxmaFevtvsz2ukutLlL0bq72z7+IR4762kqGnkzDvxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009426; c=relaxed/simple;
	bh=4xPqYvlq9Nfls+v7bxOV7lBCChf+ugfxubUKqn9mCi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cm38HOfKuygPiRuSAFXlwy0I5SP1y1bgTwpzp9wVgUMLO2FUZECOaIWefaNFFkkQCgFL6Cf2tGDMXIZed33pV7Iqs5Ze5SrZOZKy49e+PiWAhgn1NhdNZ0b2KXqn6A9Ka2adPioSrsUrdsgRSxfnmhgqXJ0afp3cQzvvfi2jiMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OwtK6mD4; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OwtK6mD4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bn
	7zqv7BhhO4u2hyqtDUkagNf7vxIqH4Kedjj5Ao8gg=; b=OwtK6mD4hKcXDiM1hO
	qPwRv5qhI/mzDULJimzH9Y9IxR/J8+QkKfrm5IWPi6H8Yy+INj2zjIAD1hDcdNPT
	0CUv6LutuOvjYBSSUq0bsOiXWHGMpH61vh4m5CUSXe7TpFdXwXQsKVr+/fP0zDbW
	M8LHhjuo2Nw4aSpm+Gt/o4u8w=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAnwyab0lVqrG_HHA--.5129S2;
	Tue, 14 Jul 2026 14:09:47 +0800 (CST)
From: weimin xiong <xiongwm2026@163.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	weimin xiong <xiongwm2026@163.com>
Subject: [PATCH v1 0/4] iommu: Fix device lookup lifetime and probe cleanup
Date: Tue, 14 Jul 2026 14:09:26 +0800
Message-ID: <20260714060930.220277-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAnwyab0lVqrG_HHA--.5129S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kGryxKF15JFW8Kr4DJwb_yoWDGFX_ur
	yrZ3srXw1rZFWxZa42qF47ZrZYkr4IvF97GrWjg3s3Jr17XrWkGa1qvFn5Ja1xWw1jyFn7
	tw4Ykr1xG342gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUuHq3UUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzgvOXmpV0qudxAAA3K

Fix a few IOMMU driver lifetime and error-path issues found while
auditing fwnode-based device lookup and probe cleanup paths.

The first three patches avoid deriving driver private data after
dropping the device reference returned by bus_find_device_by_fwnode().
They also make the ARM SMMU v2 and VSI probe paths fail cleanly when the
IOMMU lookup fails.

The last patch unwinds msm_iommu_probe() state if sysfs setup or
iommu_device_register() fails.

weimin xiong (4):
  iommu/arm-smmu: Fix fwnode lookup lifetime handling
  iommu/arm-smmu-v3: Fix fwnode lookup lifetime handling
  iommu/vsi: Fix fwnode lookup lifetime handling
  iommu/msm: Clean up probe state on registration failure

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  8 +++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.c       | 12 +++++++++++-
 drivers/iommu/msm_iommu.c                   | 10 ++++++++--
 drivers/iommu/vsi-iommu.c                   | 10 +++++++++-
 4 files changed, 35 insertions(+), 5 deletions(-)

-- 
2.43.0

