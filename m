Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F633A0EAB
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 07:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905900; cv=none; b=ZsZ+L9F7vXzZ4CVoCnYr2FqrnSaogpkWsqkXn7SnkbdoPhEunWmZIUuJUf3AV2U4vz5yDyf2grme0Ex/as9BMlvBOTmAf0ZLXAukRPv9mSX57FOUu7bR9SdWqW6Oi0OtR5Kw6U3EHpJhL43Lpc4mEAztkHTw57BDOYiWahSStLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905900; c=relaxed/simple;
	bh=no730IizIQLlreFMoZyKs6HKhKmuOP1Dg4tg1IS48/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhihjFb33mqrSxHQJoqpo0Mt9bmhm18+/73jS0AMrRs39oIF6+O17NnM2s8BwoDIKT2jdNaND6Tii/x6jRerx8iia3lRCO8LmNsgw1UiMxLNN3OSxcxPiLNSgRbN2VxpR8cRA51LuA38SJxeEh+bu9gNalBd4fzgxBgfZFz8dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gMTY96jz; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gMTY96jz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773905893; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=e9yDv+7mx/bhuyZMqgBQDkc7NnzyP1+omeB619n0tAE=;
	b=gMTY96jz6RGGDx/y6sFU+XUJyoB4Skg4oRYlb16s95wEWcwiS6GwK//Mwa8BfmS3IK50d0PQ58fn2JfqdAHm0Nf0hEiZs1Ox6ZujhIeb8wnSZ/fooKESnhTUx+zEv6O4IuWiGVE+QbGI2I3anPCRRpjFCrCOUPva10CrylQN2GQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X.HbDBh_1773905874;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X.HbDBh_1773905874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 15:38:12 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com,
	will@kernel.org,
	robin.murphy@arm.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ming.shu@amd.com
Subject: [PATCH 0/2] Fix illegal access in IOMMU debugfs
Date: Thu, 19 Mar 2026 15:37:52 +0800
Message-ID: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In AMD IOMMU debugfs,
1. set the device, address, and other information to be accessed
2. After verifying the legitimacy of the device, address, and other
information in step 1, access and obtain the information

However, before actually accessing the device, invalid device or address
information might be set again after the legitimacy verification in step
2, thus triggering an unauthorized access issue.

Guanghui Feng (2):
  iommu/amd: Fix illegal device-id access in IOMMU debugfs
  iommu/amd: Fix illegal cap/mmio access in IOMMU debugfs

 drivers/iommu/amd/debugfs.c | 63 ++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

-- 
2.43.7

