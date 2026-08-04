Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394F449EAB
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887669; cv=none; b=o3SHlQJbLLE9R3OSacI5z+cvQ9fmOGZe1IoBHpzkKC5x5R2H4hm0yCDihWstnOcY4J5rPqHLRk0fT8GkneOZNMRCKhgXHfCziDrr0Xz13GDB/6LSi9BOjgAzHgd53L3jdD5vog6diaJZpTO6U+ZWtAZNglLbPGzRDfAV/cPfgA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887669; c=relaxed/simple;
	bh=NzOh9HpnXu8dPA60cF2rU7FEPlZpigtx/FS96NI3DkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlMMgUMXgYuxAtRtVw9aeNpO2HEq7e4z9LBBu7Vpu5YDNtKvz8i8XYXr1Vy7/iWVNaiZUglNie0381xKG7l82gBuFqb0KNly61VNfwYimOB4rNCn2OPv5SD3XBhmfuOAjB7cVGRJskMu88CAEIl7LekhRFTJmbBxDUk5WlaWaDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eu8MjeK2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eu8MjeK2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887668; x=1817423668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzOh9HpnXu8dPA60cF2rU7FEPlZpigtx/FS96NI3DkY=;
  b=eu8MjeK2VQ2V7MGU9XSKvfCi+asFOTC+b5TzOyqevWn0LsPQPoCyS0x6
   M6b1pDrfHtQ0hfErvVhhESUzHuV3YUIw1i3GRcxebnXB65EYBFLWR/X0M
   +oaUGa22iUv5zXYRZtZ82A47olyTDbC0Z7rxbiMdWp9MsjCm130zXAnMk
   uOGCnfD5VWo3Kiku6p4xwi6VBYRv6aiwpMIMOi5RKhKJsPKP3fn2A1rnt
   gttvxsbPjbJCqvlD3arxVxXbOvsMI2Kx3j5b1K2EQk1Xn302FLYnYmFQo
   0x787rFxDNP3BzsrTw5HKJnlYf4U9baoNmVH1ihFuyfqDYDRF0sfQYfLE
   Q==;
X-CSE-ConnectionGUID: OwhRFAHdQXOKGjRJ1Mn1sA==
X-CSE-MsgGUID: 2Ktex7WoR/KXUu52S6EkTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263196"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263196"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:28 -0700
X-CSE-ConnectionGUID: AQ2MSFamQBOpDf3klcXw7A==
X-CSE-MsgGUID: PvbqMMPHSl+v5+5AoXXaaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324308"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:25 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/19] iommu/vt-d: Use logical OR operator for privilege mode check
Date: Wed,  5 Aug 2026 07:42:56 +0800
Message-ID: <20260804234314.3087110-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li RongQing <lirongqing@baidu.com>

Replace bitwise OR (|) with logical OR (||) in the privilege mode
validation check. While both operators produce the same result for
boolean values (0 or 1), using logical OR is semantically correct and
makes the intent clearer.

No functional change, but improves code readability.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/prq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 586055e51bb2..dddd3b51b657 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -223,7 +223,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			goto prq_advance;
 		}
 
-		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
+		if (unlikely(req->pm_req && (req->rd_req || req->wr_req))) {
 			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
 			       iommu->name);
 			goto bad_req;
-- 
2.43.0

