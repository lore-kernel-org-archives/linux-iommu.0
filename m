Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A07EEBF
	for <iommu@lists.linux.dev>; Mon,  4 Mar 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540125; cv=none; b=CKyWleIXBu2160T4e4jL1aV1gq8F3F/3t7uLY6wSunaeTXzVDujzizJPQ2Q/0hLuXq6FYzDPsENyM/nD3aOoRRVdBWIZD8+7bsSDPThE9APehG6Qfcri6MxaYxTlIApvDYIPRgLcZ19QQLPh+QFHtzC25xfGvyQvclSTH2oh1A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540125; c=relaxed/simple;
	bh=VJWSqHQPMivBeqfzMOvO9PGJPKuYFI58V0eb5OjVzjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MNx9N1ELyJQuey27JM8zfbmUh6mfn6T2w0MRtFRC3wISzQozC0C7Eyw1vxLIrtAsfqPwfOFaNotXSWIXpWIZA1YjJA7MOUpuT+pwMCBxo3UQl32FzJGT55T6f+C9xUfOUa0N+G3h3KNyGyOUSLTrB2/H1uaGxk250tqFNHFEEu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1709540111-086e2316ee06760001-Djp6mn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id JjMqnPvHCH8Gl0M9 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 04 Mar 2024 16:15:11 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Mar
 2024 16:15:10 +0800
Received: from xin.lan (10.32.64.1) by ZXBJMBX03.zhaoxin.com (10.29.252.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 4 Mar
 2024 16:15:08 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.7
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <TonyWWang-oc@zhaoxin.com>,
	<YeeLi@zhaoxin.com>, <LeoLiu@zhaoxin.com>, leoliu-oc <leoliu-oc@zhaoxin.com>
Subject: [PATCH] iommu/dma: Fix not fully traversing iova reservations issue
Date: Mon, 4 Mar 2024 16:15:07 +0800
X-ASG-Orig-Subj: [PATCH] iommu/dma: Fix not fully traversing iova reservations issue
Message-ID: <20240304081507.63221-1-LeoLiu-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1709540111
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1537
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.121644
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

From: leoliu-oc <leoliu-oc@zhaoxin.com>

For multiple devices in the same iommu group, sorted later device (based
on Bus:Dev.Func) have the RMRR.

Sorted earlier device (without RMRR) initialized the iova domain causing
the sorted later device goto done_unlock.

Then, the sorted later device (with RMRR) cannot execute the
iova_reserve_iommu_regions to reserve the RMRR in the group's iova domain,
and other devices (in the same group) alloc iova in RMRR are permitted.

DMA iova addresses conflict with RMRR in this case.

Goto iova_reserve_iommu_regions could avoid the problem (make sure all
devices of the same group execute reserve iova)

Signed-off-by: leoliu-oc <leoliu-oc@zhaoxin.com>
---
 drivers/iommu/dma-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 50ccc4f1ef81..2b6c6bf4bccf 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -709,7 +709,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		}
 
 		ret = 0;
-		goto done_unlock;
+		goto iova_reserve;
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
@@ -724,6 +724,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
 		domain->type = IOMMU_DOMAIN_DMA;
 
+iova_reserve:
 	ret = iova_reserve_iommu_regions(dev, domain);
 
 done_unlock:
-- 
2.34.1

