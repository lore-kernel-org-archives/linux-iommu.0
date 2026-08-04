Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B403F076E
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811709; cv=none; b=RGgLr9hIuj+SQHAsi9z1SU2a0gjqa17ZdAN3Bvtay63CTBcGzt4cBpXZOfqn08fpYkeosYdq0Y62GnNThMU5RWh61ZTtEGzFGTEYkZeAGEXl66bryi9rF7OhgwEfQWzfelZZBW3UW13Ial822jJdCvUSxJUaqiSpPvPZWVK/hZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811709; c=relaxed/simple;
	bh=NzOh9HpnXu8dPA60cF2rU7FEPlZpigtx/FS96NI3DkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVUN1VaJLYwMTj8UWoPPSYizWfSF56fHqwnXMtdd5tpHc9PFNUNS/Afnny8daedpZ5jMCqOzvWLD0fY25Uw1dasaV49SEMKEJIbqWMww1VwHS0v/X8QineLXWBdszI9BDp1l9dj6QtfM4XDC0U1XnU1MbcIAX9FQu16bw3hDIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V2ze/zWw; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V2ze/zWw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811708; x=1817347708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NzOh9HpnXu8dPA60cF2rU7FEPlZpigtx/FS96NI3DkY=;
  b=V2ze/zWwp2AQBHmqD1D0rwSHJQd7VqS9L2EmIG13fkA+BKX3CHQVoe8p
   XDVhGu2WhbUd6IT9knNlHOCmqy3311noyBifRVTLWGrRmxG+6f6ubkGFe
   bVVT4+q3YT2sx++bL4YxPouPYaiF7eTAw1PzstgQmSbib8jLEFZ131b9t
   WwjXVwZjbdvSQmwqQVv9dCuXb/qGox/kR8+Z7O6Z0UC1IuM535xFUOrl5
   yj4V7QHt5erO719+8xbrzgBHMQoNRCxMqZ4ccQYeNAzQBde7Qv2SsUdBj
   zsk5cpWqPnUdcWCiCviMp6cqcrgDRXiEc//HEETgh3rQLKtoUYmgb69N7
   w==;
X-CSE-ConnectionGUID: fdLuydDVRo6wnH0xQf56aw==
X-CSE-MsgGUID: ISdZWf8oRMyiX8kVF0lsBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231232"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231232"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:28 -0700
X-CSE-ConnectionGUID: fM1NofRNSw+IEGDkrWTtZg==
X-CSE-MsgGUID: +NekXnV+RPWePW2IjoPMoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587410"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:26 -0700
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
Subject: [PATCH 02/20] iommu/vt-d: Use logical OR operator for privilege mode check
Date: Tue,  4 Aug 2026 10:36:56 +0800
Message-ID: <20260804023714.3080506-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
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

