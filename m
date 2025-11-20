Received: from sg-1-110.ptr.blmpb.com (sg-1-110.ptr.blmpb.com [118.26.132.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155532E12B
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653676; cv=none; b=C23KxIBSjgTQcsrriYTnoTyoUpFHEEszRhPQOGTAxFHqcWaTwLFh156rkrnTzuqX/H6vGEHx/EXZaGmN2zGyZXGRhBRQW8mg4IBkXRbLHv7hcLcojyavjUKoqzLPd4Tvi0qTLBxcz9Sr8E/O4vs/mQ6zRavpvctyLnsI+pr1CDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653676; c=relaxed/simple;
	bh=zdTEn0O/J36J8UqLQeFaRty83CHTcnreU5erwZ7OJ84=;
	h=Cc:From:Mime-Version:Content-Type:To:Subject:Date:Message-Id; b=ktf0aotxezDvX/7m+OD+ELDxfk5L/2BWRCnngm1tjLxZZxeK/e/iiApkFOW4NfMFULlYUBUrhsyGBRjSuqfxHvgwNrABYz6QOHviKPsK/RyZG1VUhNMWGzNw8w24xnzzugohlOt1aXVGVJ8ThUdU41RbtaXATHgkH9XuHX35Ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JKhNmBLs; arc=none smtp.client-ip=118.26.132.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JKhNmBLs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763653667; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=w7KQNIS4KvyAgzeaI3AFA+HnGPm5Ojc2cIZQaHEZ5KE=;
 b=JKhNmBLsChKWseQEaiJDuHvxugemKUDo1Pc918cv0jOnfV2kRmI1us/Y78fvbQ4GAUXb/r
 QHCY9Wh2OKAYAKrktuXKGz/lYU4m1C1Y9KdPkimZ/1TwgjupUgSy31WN8oT7P3dLfCdRYQ
 BUYZFZzMxbputFg9crlSWkl5W8tj0u7NdweqdPT/+NkIy27a5+52VO7Yinv9yK4Dvl6wg4
 z6Cy5Gh6EH5k8Oc67wldPgBDTZPiO3VLElZ54Fx1Q/9mbOa7VXGBRho4zdtAoEVCiqHRTO
 Ws/5HAmIc3xuoRlbYTX9p8hThLCZTj3NxXhxp+0iSbsuSMmUvGA0by/Yb9TPUg==
Content-Transfer-Encoding: 7bit
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2691f3821+d3ff84+lists.linux.dev+guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Propagate the error code returned by __modify_irte_ga() in modify_irte_ga()
Date: Thu, 20 Nov 2025 23:47:25 +0800
Message-Id: <20251120154725.435-1-guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>

The return type of __modify_irte_ga() is int, but modify_irte_ga()
treats it as a bool. Casting the int to bool discards the error code.

To fix the issue, change the type of ret to int in modify_irte_ga().

Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1ce..a38304f1a8df 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3354,7 +3354,7 @@ static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 			  struct irte_ga *irte)
 {
-	bool ret;
+	int ret;
 
 	ret = __modify_irte_ga(iommu, devid, index, irte);
 	if (ret)
-- 
2.20.1
