Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4462EDD69
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567593; cv=none; b=DHTA0VbbBXruk4AwkQn+9XallEeROhMnlJ6gXhR6HTNDFdcxyQZ6P2AhwYuWkRNuk2AppYWjtHcfyCYF3xg26zpXPOGKt8K+FtCMn6NSyulxc0aUgaNZ7wpnBUgpm+ORSkWa+1cPjxM3rhmQFyBsZqJa/z4AWhCWWymNLH2sXHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567593; c=relaxed/simple;
	bh=hZ5BOEdIjQlRicH4k5l+Kunm1iR1aAUDSBi+7KacEP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tMQe/4+Df57Hysc6NxihK5YS/xmfS2X/dARTLnm28IWSAu7ksszCc7Q5NX38y7tRjMgOygblXaKeGTtCB33r58VQYZjS5PdklxFYkUG816PreS9xO19q+xFfPPC9ge1CR+2//ABL/3wg5RXVf8olBEF9Av+IDYpQT7FQB7+KWq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UlYRivl5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UlYRivl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=j/
	TN/sU2SeyLWF88svOm2fJwSQECH2WOcEkvYKP5mE0=; b=UlYRivl5PRPN0RnQgS
	apwtnEeuoS/v4htzI6LuAGUZ8b0J3FahGD4DZhAKSp5Ox68WP6p8ifbYbNzaMEmK
	+wvTs+AzQ1yPFtQUg+VMx0Xl97RHx4a8GJHMFnVWDE/zyvRbZ4dw9i1t2VUBzoTk
	3m3Q8SSwCpn/bwm7fsQse/A6E=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHWJ46h_NpWWQZCg--.13259S2;
	Fri, 01 May 2026 00:45:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/2] iommu/arm-smmu: Use FIELD_MODIFY() for bitfield operations
Date: Fri,  1 May 2026 00:45:43 +0800
Message-Id: <20260430164545.49637-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHWJ46h_NpWWQZCg--.13259S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry3Cw4xKF4kurW3XFW8WFg_yoW3JFXEk3
	48Aa93t3Z7AFyayF1FgF17Jr1kC3y7ur1DArsYqas3t34DXr15WFsaqF95Gw4xGF4Y9a4x
	t3Z0934fAF97ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRidbbDUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxtH6mnzhzsO+wAA3m

Replace open-coded bitfield modifications with the standard FIELD_MODIFY()
macro. This improves code readability and adds type/range checking without
functional changes.

FIELD_MODIFY() internally performs the same mask-clear + set operation but
eliminates repetitive boilerplate.

---
Hi, If the Maintainers think it's not necessary, please ignore it.
---

Hans Zhang (2):
  iommu/arm-smmu-qcom: Use FIELD_MODIFY()
  iommu/arm-smmu-v3: Use FIELD_MODIFY()

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 5 ++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c    | 3 +--
 2 files changed, 3 insertions(+), 5 deletions(-)


base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
-- 
2.34.1

