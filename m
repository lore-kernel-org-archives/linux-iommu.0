Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D5540B114
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811713; cv=none; b=tM3yccywOnxeWCtCvYrf+qPZRLrGufKcAZ4K7MqijDmtpEKeOiyudYAba7jutf+Fj+xYzKWoVtBnTP/1sT88e8Q3ggSky2cFwQ8dTilqMJ1SmAsvWtpWMc/gV4m5pmlCL0Nztmi9PkC2v7v5c674ZwXU5v3+2QlYnJUokLtOaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811713; c=relaxed/simple;
	bh=wvs5/3Vc8ATiENqbwg9FKEU2eKqwenz/FQk2i2ewikk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXbYOdm0cFXcU3uWw0aI5QSMM4bfJD0LYF0vf/8mnpt0w/J7EC/L2HgTNnX8v901RlFV6cBMlzZOZp3kPNjTYEUIPG6+gp/oJiZpG0/L3jGUObMwSMlk1u7BJ9lSDnbXQLW86KxVL8ztZIt38rY2P/on2ySo8Pth+C3vY6G5cuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMpt692h; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMpt692h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811713; x=1817347713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvs5/3Vc8ATiENqbwg9FKEU2eKqwenz/FQk2i2ewikk=;
  b=WMpt692hgBBR2shLTg+Mnmgfhw8SANkkclLxMbWPVBJNQ8o6zIntnVql
   HkBPUemjUfsMGzJL4Ju9ipc908KTwsyvWoGiVaKrmNiQZkXz5/ZtHOZvk
   MJi8m3clvnt2MpB3UMWe0zgEVWn12t4+n0AnVT7A1AHeaEQhaexdR7Y73
   J/S++QNR1hEstq02TjofroA6F0zHajCGO2qF1bJJu8jKktSAkHAE1QoRX
   3hRynJeCGHYj1BItqyFczRXTIJO6hlWnu1DEViPk9hvIQ6QJ5SOLIHXS9
   Wb2Gja5tIGLBZ12GU8wzf6DgadznGJYYksVXEeqdhrWDT4BBmRfyGeQUR
   A==;
X-CSE-ConnectionGUID: An9eSc49RWCNFgwsEGpKNA==
X-CSE-MsgGUID: n8no3dUZT9aBms+xxAtcyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231248"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231248"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:32 -0700
X-CSE-ConnectionGUID: XW406pNNQ9eSVXqWEJ4TIg==
X-CSE-MsgGUID: YyNt6JpmSuGHDNu/Dnq0CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587457"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:30 -0700
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
Subject: [PATCH 04/20] iommu/vt-d: Use kstrtoint_from_user() in dmar_perf_latency_write()
Date: Tue,  4 Aug 2026 10:36:58 +0800
Message-ID: <20260804023714.3080506-5-baolu.lu@linux.intel.com>
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

