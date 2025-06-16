Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F257729550C
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042610; cv=none; b=TIdsIyMZG1AWuPiJVoJFoOkOZl82hZc08tfaAGO+7emYClNFSJHnROJ2wzdRQJbqvoIFY37hk16pB7CH2xCZHr4uQ/N0LNtPTwyUUxgougdwIxIe4FoHKGH6L29yylXw6kIvYQQW+kdjcHvg57vSluoTayEjjK4PBbyV9igDisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042610; c=relaxed/simple;
	bh=YwzNePUm0n+jOxg02zddqKeqTIH74sBY9GdRID8Kbj4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sqc+ZXvZxZfhiJ+e0/0suhpW1VgDRgCp6rkGsGTHUiVUiZsm9gHymBPlEeQxxlXfWE0qZ8EyV+EPIRAOXF7AwN0lBaZ7CvIWzwWIimitxgkGzA2Asj5lo0i6SN1vKlLNjwcp39x7TnR+frbJjZCWNVqgsbIZ7/6J5z+LfsDN70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HVMV5kZX; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HVMV5kZX"
X-UUID: 89173f544a5d11f0b33aeb1e7f16c2b6-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cTdzAVm88Dp3FSAFwEcWTcJ5R+ddpr4qcCBwvjSx2mw=;
	b=HVMV5kZXDoDrEauh71HmkqMKKnSMk/iqrTJmmYFAOEdge7FwFKKmBDhg8GdGBSJGuc2/D+vzOdzAhcyLcaSVnLq64CPontVQhMP/5PFBQS372MWucnEGNv5AqiSRA7eeXr2QwBvW7lhnVXYkn6Ht6spgB7noutdJRNKdfe1juYs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:64bc5cb9-b5c1-4e7b-9aae-4aa4af8b51fd,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:0f94b703-0d95-4f6b-a95f-3c560ebcf3ab,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 89173f544a5d11f0b33aeb1e7f16c2b6-20250616
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1598441658; Mon, 16 Jun 2025 10:56:44 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:42 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:41 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>, Ning li
	<ning.li@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [RFC PATCH 5/8] iommu/arm-smmu-v3: Add IRQ handle for smmu impl
Date: Mon, 16 Jun 2025 10:56:11 +0800
Message-ID: <20250616025628.25454-6-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add IRQ handle for smmu impl

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d36124a6bb54..154417b380fa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1954,7 +1954,8 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 			arm_smmu_decode_event(smmu, evt, &event);
 			if (arm_smmu_handle_event(smmu, evt, &event))
 				arm_smmu_dump_event(smmu, evt, &event, &rs);
-
+			if (smmu->impl && smmu->impl->smmu_evt_handler)
+				smmu->impl->smmu_evt_handler(irq, smmu, evt, &rs);
 			put_device(event.dev);
 			cond_resched();
 		}
@@ -2091,7 +2092,13 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 
 static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 {
+	struct arm_smmu_device *smmu = dev;
+
 	arm_smmu_gerror_handler(irq, dev);
+
+	if (smmu->impl && smmu->impl->combined_irq_handle)
+		smmu->impl->combined_irq_handle(irq, smmu);
+
 	return IRQ_WAKE_THREAD;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 99eeb6143c49..f45c4bf84bc1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -792,6 +792,7 @@ struct arm_smmu_device {
 
 	struct rb_root			streams;
 	struct mutex			streams_mutex;
+	const struct arm_smmu_v3_impl	*impl;
 };
 
 struct arm_smmu_stream {
@@ -998,6 +999,13 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+/* Implementation details */
+struct arm_smmu_v3_impl {
+	int (*combined_irq_handle)(int irq, struct arm_smmu_device *smmu_dev);
+	int (*smmu_evt_handler)(int irq, struct arm_smmu_device *smmu_dev,
+				u64 *evt, struct ratelimit_state *rs);
+};
+
 struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu);
 #if IS_ENABLED(CONFIG_ARM_SMMU_V3_MEDIATEK)
 struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu);
-- 
2.46.0

