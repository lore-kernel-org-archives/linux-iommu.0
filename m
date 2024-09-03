Received: from m15.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5B6F30D
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375047; cv=none; b=aDfqeQEl5nArNXVQfrIfpO9SX81KxRqDryeWZycTN98ovA91hUCmSh00tY8jffiYs6zA5RZRDrDPYNOwvtrljwnb5ct/tjIWCJRKQkKTh36GPczEbcJ5BQnTZBuGmOqddQNgVE+DyvNKI9OAORvCws5015iwaAGKthHFGZ45SKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375047; c=relaxed/simple;
	bh=k5utM3wgHf32qhGpen5q4SK8rJu+bGuDYsx7xhGgVa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iT/k3j9WmtjZgz8gEiGae/SwPrFC9nwTbtFlMHmFyLkdHltQbNW+cN2+01x5Jhb3zuUjTHJemiUouyH3zuDAZ8HsAXCUxt4zz7OUE+ff4aWgqTI1TIeM+DayznUfl4tbNJafiG2K28rr/eTdO4FHGMyIv4z1yMZl+3E+cIv2Ruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YGMFrdY2; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YGMFrdY2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PgJJ8
	SX8BUGlB9T2TFFYMz+dTL9blm1JY4VAnKEEgSk=; b=YGMFrdY2hD/RwPtYoX1sb
	CiJ85ureLALodvKkINXul3lnJIO5FT+wJEWZsGijMP8pbRk/v8hbIkb4laQ7Ptdl
	2ZL6E3tw/6arTnorTJfhRvR64YDa7RaV61Z7WTW4hqfku2IdgtIRG6dfpVBfwSZQ
	IENmUnrj1i1OrZc63OqEzM=
Received: from localhost.localdomain (unknown [36.33.36.240])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDX_18bItdm5cJoFQ--.14451S2;
	Tue, 03 Sep 2024 22:50:04 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] iommu/vt-d: Fix 'Null pointer dereferences' issue
Date: Tue,  3 Sep 2024 22:46:01 +0800
Message-Id: <20240903144601.8149-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_18bItdm5cJoFQ--.14451S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr1kGF17Gryruw45CFWrAFb_yoWfWrXEkr
	y8ZFs7ury5Zr48Z3WayFnruryqqw12vFZ3Z3y0grySqFn8Zrn5Cana9FWfJr45G3yUJFya
	yF4UWF4fuFyxCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUU2Nt5UUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYBZPamV4I-QKmQABsL

Passing null pointer "pdev" to "pci_enable_pasid", which dereferences it.
Check the "pdev" is null or not before passing to "pci_enable_pasid".

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 drivers/iommu/intel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..a1e54f334330 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3935,7 +3935,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	 * So always enable PASID support on devices which have it, even if
 	 * we can't yet know if we're ever going to use it.
 	 */
-	if (info->pasid_supported &&
+	if (info->pasid_supported && pdev &&
 	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-- 
2.39.2

