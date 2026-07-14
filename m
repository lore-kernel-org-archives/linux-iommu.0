Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AA83A381D
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999519; cv=none; b=iU3zD5XgAt5164UvIYZCNVoIZIQIsSS8IsJyel+nC0HSjcTesR7giCJ0VkNipC+ypWHKFfU1WuAQtD7wytTQgJkNspdK/vADprf/yvre171kUXDL5c7kTXNFBNFxqLgNtRRMsMLibChpYh7Dk1Bn+OfTXQpNO6gbVNreG/Zjq9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999519; c=relaxed/simple;
	bh=/dFc0pugWrsgZkM6LI1nyzCJEM8Nz6rchJWaq2iqfG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/NCtovEKYHvxAfUyawgekUNZyWTtmJVExf/O2ElV+/KEUKIu5RN2cdrcs5lLZTrIfc3ldgFJfbnwDbSewTk1SYg5AnHPydKfYnFpu2lio2h0Ry/apKOjjR49TDKZmwIWA7NkIMAUPHT6ORMIPB2q5hKEln9uOaR1LcvdiL3qxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=csX+o3gZ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="csX+o3gZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/I
	yw589EVgHH/fhkFRnPD5WO5FsPMkVamqMpmsEwbvY=; b=csX+o3gZL8Mnw90TsQ
	nlTbvilqth1BXbcV6Du2D8FV5BEefUfizfLMp8zQaFw+51nQfuGj4fYfl2Fa6ots
	C+k4r8FCWZXjRW/xLRSZYjw60H0M7r2nheRaspjf57No+xXDfEjZpHjohuwZVuHF
	m++XdUc4VMDE1C4jimJCdWF2Y=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3Or7mq1VqjYDmJg--.50453S2;
	Tue, 14 Jul 2026 11:24:23 +0800 (CST)
From: weimin xiong <xiongwm2026@163.com>
To: iommu@lists.linux.dev
Cc: baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH] iommu/vt-d: fix typo in comment
Date: Tue, 14 Jul 2026 11:24:22 +0800
Message-ID: <20260714032422.201378-1-xiongwm2026@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Or7mq1VqjYDmJg--.50453S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWxXrW5WrWxKr4DJryrZwb_yoWfGFg_Gr
	10grykWry5ZFyFvrWj9FZxua4Yyw42grZ2yFZYgay3Zw1xZrs8KFZ3ZryUXFs8W3yjkFZI
	krWYkryxZFWrAjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5jAp7UUUUU==
X-CM-SenderInfo: x0lr0wdzpsijqw6rljoofrz/xtbCzQcUo2pVq+fmIQAA3J

From: xiongweimin <xiongweimin@kylinos.cn>

Correct "assocaition" to "association".

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
---
 drivers/iommu/intel/irq_remapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 25c26f706..cc2eca08a 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -953,7 +953,7 @@ static void ir_remove_ioapic_hpet_scope(struct intel_iommu *iommu)
 }
 
 /*
- * Finds the assocaition between IOAPIC's and its Interrupt-remapping
+ * Finds the association between IOAPIC's and its Interrupt-remapping
  * hardware unit.
  */
 static int __init parse_ioapics_under_ir(void)
-- 
2.43.0


No virus found
		Checked by Hillstone Network AntiVirus

