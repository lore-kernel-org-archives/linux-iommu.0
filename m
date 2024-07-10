Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86A824B3
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720594689; cv=none; b=OE8XXIfCFSuW4QLwqBKvUL/mAroxpPcdiYKqRBNrrYpk87eVEssQqYpHEEH3nLm+EehSF9vuQ3GH/7vbB4rtCx8HiExCdL6EBYHyxny68AGtrwjh2Z6hEH85XTkTQJazKiYhqRU1Y964RtzOINCDdxDerb0dGT2zwstxSDibuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720594689; c=relaxed/simple;
	bh=fYPEXmI/LBSoVmcAiF9CNVOmJ6j5dnKxaStvmGwt1Ew=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n9HK+zB92ujlbVsaREYFeCDnThBDFWsMalButiya3nLQc9mNoJ21TyRUUSU/gp9rp33uuJz6z0Nb55HIziulit46auHM8PkHIHwPs1XnMZL3+YleKThsbLKEm4aNjKNNhjKidBUU20PzW0L3y8vnV2Q69stLH2ZPZE/oqb9D/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9668e30f81e2-301e2;
	Wed, 10 Jul 2024 14:58:01 +0800 (CST)
X-RM-TRANSID:2ee9668e30f81e2-301e2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2668e30f8765-e00fc;
	Wed, 10 Jul 2024 14:58:01 +0800 (CST)
X-RM-TRANSID:2ee2668e30f8765-e00fc
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: shuah@kernel.org
Cc: chenxiang66@hisilicon.com,
	zhujun2@cmss.chinamobile.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/dma:remove unused variable
Date: Tue,  9 Jul 2024 23:57:59 -0700
Message-Id: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The variable are never referenced in the code, just remove it
that this problem was discovered by reading code

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index 3fcea00961c0..c91b485ca99a 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -33,7 +33,6 @@ int main(int argc, char **argv)
 	int granule = 1;
 
 	int cmd = DMA_MAP_BENCHMARK;
-	char *p;
 
 	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
 		switch (opt) {
-- 
2.17.1



