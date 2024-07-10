Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95981B86FC
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593060; cv=none; b=XQAcHrBYEBg9SAVJC7BIPtzH3azm8MSDmODpC7LI/3T0f+sYyTGg/5mHv6Yk7wssDf5W2FuYgaeY1IyTvcJE6XvUgbkPSSokhVr9JqyjyNF+R/ydFVowYDCOkZUNbVHM89iicTWPWJSnIAPRtM/xLbnQTu9xsSSPAwKoh4WAEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593060; c=relaxed/simple;
	bh=sM6KFWH6gfzQ94i0OID2kqBYu4u4wpOqFm2ESjUAg1I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n6k+OFFePvFTnQlSkod5FVWCS53s9M94Q2+MbLhdYpLC/BSHCPbc/H41+wKb+IWKexcVc4WAj0ITLhqvKqkLVWI9A3GM99vEPlDpfpG+Rka35NKfpoki2EF8MTmtW6LrGbdwID9wn+DzYhgaL3T4hGNtkS2MLdNMrn+CDQGlNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4668e2a99ef2-fa7e1;
	Wed, 10 Jul 2024 14:30:50 +0800 (CST)
X-RM-TRANSID:2ee4668e2a99ef2-fa7e1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee4668e2a99679-de188;
	Wed, 10 Jul 2024 14:30:49 +0800 (CST)
X-RM-TRANSID:2ee4668e2a99679-de188
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com,
	chenxiang66@hisilicon.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/dma:Fix a resource leak
Date: Tue,  9 Jul 2024 23:30:45 -0700
Message-Id: <20240710063045.5308-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The opened file should be closed in main(), otherwise resource
leak will occur that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 5c997f17fcbd..3fcea00961c0 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -114,6 +114,7 @@ int main(int argc, char **argv)
 	map.granule = granule;
 
 	if (ioctl(fd, cmd, &map)) {
+		close(fd);
 		perror("ioctl");
 		exit(1);
 	}
@@ -125,5 +126,7 @@ int main(int argc, char **argv)
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_unmap_100ns/10.0, map.unmap_stddev/10.0);
 
+	close(fd);
+
 	return 0;
 }
-- 
2.17.1



