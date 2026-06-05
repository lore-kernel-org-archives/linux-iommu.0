Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id EA6AC7262E
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620071; cv=none; b=H20InPfTitXjoIWa1Uh3eXIRz9MAAzco+Y+dFKRjYIojcz/kwJ+bhqZxjg5RztjP/6L1kPzamhDt2CmBHlIY/yB+Q3NdzJCLUJnOmDDpF7Exl0oKqU/bIweKOGQjlVxid7DJI0yUA4iIVCWH4BTT5digXuQLFyJFaBqpxPU9HBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620071; c=relaxed/simple;
	bh=YqxJaUeKsr3Q7DXdpyCeh7iuHWcgzb5Zzv8kxCng33k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oln5TtYoJvbDPx5bM1MUlN26Rj2nUjHgE4JhFPlAxGRFhBnPtyEIHHdPp7l2t/wvhnMFLpMIj+T3Fmz0sN/53ESusPFNHsZjl/w4FuS8rfBFz9G7CN3KaHwAlAucTqmkiMlY/8pTyDCdPiSXLCunr3/ASZzTPm4vAGgsRoExBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=VUGO7kDv; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="VUGO7kDv"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] iommu/intel: Use logical OR operator for privilege mode check
Date: Fri, 5 Jun 2026 08:40:53 +0800
Message-ID: <20260605004053.1867-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc10.internal.baidu.com (172.31.3.20) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780620062;
	bh=RuANLm17uRgcZ9HYHQfy2FLkCmrRcAta6xUPY12kNFQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=VUGO7kDvyoewVlnhvEDVy2dBqQ8OQ1lid9VVrti9mSe583HeTmtPPeJ2qFwbPYCmm
	 833XlVnhqDFVx6Cf12ccQKfcte27A0gd2W4FH1//WK/GW19bDhe3jmzM4I2witcZBj
	 nqjxoeluGLZR7tLwefTOBhwLFTv5ZFihZyU1TJ6yphff2qLKUxG5otQMTXWUVCoIdq
	 OI26K64Pn8siD+McPpHMjXFJhnuLNlz++weKRPgtCRI02O2lqATKvbqvK1xSIfgrz6
	 IpGzBmy/agGgmm8hhuN6DQrDveGZqbjruyhLTUvOBmqFIrre7OEONQJLI+Adxq4GSR
	 u5t5cxJaD/nIg==

From: Li RongQing <lirongqing@baidu.com>

Replace bitwise OR (|) with logical OR (||) in the privilege mode
validation check. While both operators produce the same result for
boolean values (0 or 1), using logical OR is semantically correct and
makes the intent clearer.

No functional change, but improves code readability.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/iommu/intel/prq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index adf2bab..b89184a 100644
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
2.9.4

