Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F415572A
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672461; cv=none; b=BxOw5VdFVs8dLUJaJLfGBIxC+vrBJbR/SZGFoc6ccymiPintqu0aMgML6KNwhMtUGISVnyS2yyBDoCwkltuNGm7E44H/5/9H6ZgAE4uH5DjBLlFbEhDFFB0XwJICZAfUy/AdmIUa9/YQ4P+TlyUEi29tmeB1/VneU6LQlYbLwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672461; c=relaxed/simple;
	bh=hs/ZudjzfEqcAh7HluGv+nmR1yWWfTmWeR7gImxnI8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCIgXCXo+Kyy/YrIScPumRcuPnSyFlsql0X3Q2tAwaJ1prCmpoxMom/D9g+7aLMHBbirjJ6gF+mifDrBq6VOn+ZXkkaaOvCebmm2200PY/Bj3tIZHLTFsVSBGyiKfbe5oguw7zfphpetrzSsRNp4RDKz13GH2ilEDbCo5a5aIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=YldQ0X8v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OIiLmPgl; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="YldQ0X8v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OIiLmPgl"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4A3B11390A12;
	Mon, 26 Aug 2024 07:40:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 26 Aug 2024 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1724672459; x=1724758859; bh=tWVv16qdxasnFH/zAKrmYDtll4cJrF5f
	qwTGoDxNSrM=; b=YldQ0X8v7UitvauDHEVFkh/KmYhRsw2Y8rCvVmxUPoSNP2/z
	FHqfTXrpYQRM6KNX502rSSjqTyVsdqipxtWFcwn5pwD9WPeI863HqQLTCStcb3gk
	u6mLHbfBJ35U8B/sFgWKlmLZm3ODcMHfcumyEQmmB41szTLY2vEVYV1vUWJ9vppP
	SqNQ0HFRRimjcZLx4+Q5D400NeJTpRMEFXGDE28zvkdnF9euLWv88Z3SRR1128hD
	fUfomopFLeP4uZEazYxp7jv4M0sV3OJo2/0hB7tbPZzdZGE/9qXT9kKYv6dKKYYC
	3n4PR10uv4VsnNW29BOfTwF0aRo2ou+33PUbtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724672459; x=
	1724758859; bh=tWVv16qdxasnFH/zAKrmYDtll4cJrF5fqwTGoDxNSrM=; b=O
	IiLmPglbBdAQpKtaq1dUyahYItaSq9IEf3p05VX798AKRCAaWt281Y7P4H43/xqt
	xz6YXFYEnBlkzFjB1YGpTphaOHyR4kRiExEyrL+QQzn5zPzc1W+ktjbKGGE9kOMn
	2vqI2kdyOYTENtfq5n9Z7h7sIgPU3NyLhb+I/RS6fE9fTTPinXAk+JEcIN4jXxDu
	i+Akjbudn5jZ1ZxPG4aHcQrPhWlhFf6ipZHkwF2QT5HAQWRSP1Zh9GF40tKZBS7G
	0Wr8hHQo8W8r2oerM7PmufsFeP+S1GO1JhmslMTj2D++lFJlLVvp87Aax2nIoayI
	sVi0yYDWDHKIdRW2138WA==
X-ME-Sender: <xms:y2nMZkXSqYsh9ro0x9D9nVYrpB9a7ezLAofYbYYVEKVFBNRp2go5HQ>
    <xme:y2nMZomhyv_39PU8vlBjLzlR3vQ240NuGEvFra5pF5n4HCGgszXVETRMsqD573NAu
    O_0VaItFanjeOm2094>
X-ME-Received: <xmr:y2nMZoY1FKZWSxdKGlz80BVQCg7zw8mCuTpmgGSiV_z7RZfH3wNOK4UfV0MjoOdN7gMneWKzHBFc9qhbtsgCKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
    drughkqeenucggtffrrghtthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudev
    gefgffeiteevfffhhefggefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhdrghhrrghnrgguoh
    hssehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhu
    nhhgrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehi
    ohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhosghinhdrmh
    hurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhinhifohhordhimhesshgrmhhsuhhngh
    drtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhg
X-ME-Proxy: <xmx:y2nMZjWaHK-dfx__pZT0aqO4ptrGjt2crkzsGu_-EaQytc2-WLjGIw>
    <xmx:y2nMZukK2ZwvNYu3Xkiq_gJZrg8pUp8xPGf2zDFWrgajUEsOCL0DVg>
    <xmx:y2nMZoeX6WXOuCytg7orM2TK5sP1w-5_ah8o0UNzvbvlpjz5CH_GBA>
    <xmx:y2nMZgFgqnc3EggwxUzBm3G7WH6lX9icXVGkWKjSy2VzoXJVhfhpCg>
    <xmx:y2nMZp9iIj6MgiZ1xZbOTXUNnrMVQnyLk500O0rrUQJ3_ajjuJ11bufD>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:40:57 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 26 Aug 2024 13:40:29 +0200
Subject: [PATCH RFC PREVIEW 3/6] iommufd: Enable PRI when doing the
 iommufd_hwpt_alloc
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-iopf-for-all-v1-3-59174e6a7528@samsung.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
In-Reply-To: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=PpQLWdKZhPTArwQOEpcdZXSK5WSfDc067pv1+3sevyg=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgprQTBEQUFvQlRlR3ZNVzFQRGVrQnl5WmlBR
 2JNYWIrajVvUnVhaVplSWd0T25udEg1UjZlQTcxaXVSNFlXdUZKCjZPS3crdFpsR1lrQk13UUFB
 UW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3BCUUptekdtL0FBb0oKRUUzaHJ6RnR
 UdzNwc1d3SUFMZkJycTFoSnZyazJhWWxwdWtJTy9KQ3MydTBLZzR3RGhibFdGK1dTYU5RZ0J1cw
 ovQlNCeE9CUVdicmdqd0VtR1V5blR2M0granNJb29Qc2kvbk5xd2lYUjlKejViTWQ0aXd5c0NuU
 kdGU1BvcTlCCmd2NGI0SnBMZkdvcnVRNFNRVmFhRzBmWWppU0srMVZuK3NDZTNBMlAvbmIvYjJK
 QW14YnlpZUxRTzY3QmE4TmMKZU9NZUp1Qms3bFVjNG1lcmlJQ1hTRXRtMWsrNEJXWmprdDVFTWl
 oazJNdWpSQjJ6cTZIL3dPSVRGTEpzYlhZNgpNRVF5YlhRT2ZBMlFQSFRUSnd6clJXU1Z6T0ZhOU
 FUa3hyYVcvd3ZRYmc2K28yMlZWWTFFWWFwNEw1Q1FPVUNwCkFmdDZVMDdaamM1UThHMnAzeStUQ
 2kxRmJ2NnRSOEtURHlJdlNWTT0KPUJmSk8KLS0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

From: Joel Granados <j.granados@samsung.com>

Add IOMMU_HWPT_FAULT_ID_VALID as part of the valid flags when doing an
iommufd_hwpt_alloc allowing the use of an iommu fault allocation
(iommu_fault_alloc) with the IOMMU_HWPT_ALLOC ioctl.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/iommu.c          | 3 ++-
 drivers/iommu/iommufd/hw_pagetable.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4ca284d53a6b..ada3507d2831 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3716,7 +3716,8 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	}
 
 	if (flags &
-	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
+	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING
+	       | IOMMU_HWPT_FAULT_ID_VALID)))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (nested_parent && !nested_supported(iommu))
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index aefde4443671..88074e459995 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -107,7 +107,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			  const struct iommu_user_data *user_data)
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
-				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
+				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
+				IOMMU_HWPT_FAULT_ID_VALID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;

-- 
2.45.2

