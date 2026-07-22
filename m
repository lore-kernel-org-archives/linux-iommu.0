Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95074367293
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784693812; cv=none; b=YpHBQCKQSTdfnvTSFk5KM/qSNaP7om0bzLaXx/JEjd5MMlp3bxtHIHJNnv1UXItSi/ZXKqhyDCfJct+infT2qfY5VaHWjsjX8LbEsdTmJEcXpkWBxQ+UKtkUQOVgZ4aOFfB3cUbFWMXAGGuMP5xg9J0AiPJEryh306sa49y/qz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784693812; c=relaxed/simple;
	bh=COjXA8CR44dXJ+KXqC60mO8/CY2qkCCBkKILyKl5rYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4rpAroo0X8azNRNxZwXm1fjYnXWpHuWh6IK/sVgZc5GYhFxzY4JrQAMEoYOMtBfFO0Fq7vAWW2ki/uikb7AAOGF4aHVPCbSFasJlBMGNEhohpl6G7ygqqCS+pg8YqtfWPC36UKUUEpBogdmf0677e3U6IFwKNhG69sScUm0Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAB35T8TRGBqWy67AA--.34064S2;
	Wed, 22 Jul 2026 12:16:19 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Rob Clark <robin.clark@oss.qualcomm.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] iommu/msm: limit the per-master Machine ID list
Date: Wed, 22 Jul 2026 12:16:19 +0800
Message-ID: <20260722041619.17735-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB35T8TRGBqWy67AA--.34064S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZr4DGFW3GrW8ZFyDtw45GFg_yoWfJFX_CF
	1rXas7Ar4qkFW8CF12ywsrur9IkasFvFn7GFZagwsxGasrXr1xCFy0vrZ8X39rGr48tF9r
	urnrua4fAry7CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	d-PUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The OF translation path appends each unique stream ID from an IOMMU
specifier to the fixed mids array in the per-master object. It currently
has no capacity check before storing at mids[num_mids] and incrementing
num_mids.

Return -ENOSPC when the array is full rather than writing the next ID
beyond it.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iommu/msm_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..0cc7a87037ce 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -622,6 +622,9 @@ static int insert_iommu_master(struct device *dev,
 			return 0;
 		}
 
+	if (master->num_mids >= MAX_NUM_MIDS)
+		return -ENOSPC;
+
 	master->mids[master->num_mids++] = spec->args[0];
 	return 0;
 }
-- 
2.43.0

