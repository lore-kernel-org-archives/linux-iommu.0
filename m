Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5D844AB67
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887673; cv=none; b=q8YgZG7ekuIieVyIdhL84ZmK0rYR8NKNYPTwpTBTGW2DOoNY3SBgDedVBNAaHD/G8bQvwnAZrSs02SYT2ozCaHPfdj1u5jzjRrlv4W4zLtTH7BmNCBbzmzkIshwnvGXZsgCQH8TObBhkWUDLL5uPI2aPj7/vg527eBqqx6zLDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887673; c=relaxed/simple;
	bh=wvs5/3Vc8ATiENqbwg9FKEU2eKqwenz/FQk2i2ewikk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ2fSiim2NPhihJ/9B9nSR+NpS6qDAeNKx7EjO4lmMTQ4xQhQomEPYQgbNy+N+63w8mltsuBPwT0rwCxAPl2NrYJc0ubPRNxHBsVIlxg94AuG/PFxqnQHrtQNQTbdZy6pkTgooMJ/m3zqhC0gVmcTA+qtYdX5+eeO4UeVaT2BkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/wUSe9H; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/wUSe9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887673; x=1817423673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvs5/3Vc8ATiENqbwg9FKEU2eKqwenz/FQk2i2ewikk=;
  b=e/wUSe9HiV+DLPYqnunMgodpkfRnhfawuGHjE/zV0H/F+vDxNVaImBIm
   f5waLkiL8Cp2qGnys2kUF3Xe719dGZmreyQlbIu8Z8wPmrgZ5Y8CNr6gM
   ojtx7cCrYcSs7eh24BAFqYqqxmvFvvyvLJ9boCNpWMvL7M3wAn2tnlAQ5
   LHFZrVptwGxGSIPkRxXrWHefqfORZdnGVAu1z1k1vjFuSDOgEiDdOqPaf
   6iHPYa2ctDh5YcuCdSrYfmr4lv5/AKrwALQTOJ6RzNR8AHZE58mrBbwM+
   rxsbpOInwPTLaMZROEzb1dYzpCAeHFv6/rYQRqCmiVKpyhehrltr7AD3B
   w==;
X-CSE-ConnectionGUID: P0hH54tjRhy0hhq7IVx4cQ==
X-CSE-MsgGUID: 7//qUfIGT7WBcPSTv95/6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263220"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263220"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:32 -0700
X-CSE-ConnectionGUID: rE9v6iQqTuu/ww1Z+8UMKA==
X-CSE-MsgGUID: ZeV1DN5CQsmYMzngrZjmBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324328"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:30 -0700
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
Subject: [PATCH v2 04/19] iommu/vt-d: Use kstrtoint_from_user() in dmar_perf_latency_write()
Date: Wed,  5 Aug 2026 07:42:58 +0800
Message-ID: <20260804234314.3087110-5-baolu.lu@linux.intel.com>
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

From: Dmitry Antipov <dmantipov@yandex.ru>

Simplify 'dmar_perf_latency_write()' by using the convenient
'kstrtoint_from_user()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 21e4e465ca58..d87408ebb830 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -690,19 +690,11 @@ static ssize_t dmar_perf_latency_write(struct file *filp,
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
-	int counting;
-	char buf[64];
+	int ret, counting;
 
-	if (cnt > 63)
-		cnt = 63;
-
-	if (copy_from_user(&buf, ubuf, cnt))
-		return -EFAULT;
-
-	buf[cnt] = 0;
-
-	if (kstrtoint(buf, 0, &counting))
-		return -EINVAL;
+	ret = kstrtoint_from_user(ubuf, cnt, 0, &counting);
+	if (ret)
+		return ret;
 
 	switch (counting) {
 	case 0:
-- 
2.43.0

