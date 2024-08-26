Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BF15E5D3
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 11:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672466; cv=none; b=qGN8Hut2F8a/n5cdTMTymlAZSLmPIjawCIuFvVVNwxxVY0qKWxasRwnTDWxpd0D98s+zNBZXP/sMi/j1bKupSoY4YpgSAiqSbFZ9yFS5JM/C6CEfuunOc0FeFR8WC9TNgjVPdqBOSbljXSbcWSmK5e/hL8rpyG43/+m2GSV22Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672466; c=relaxed/simple;
	bh=L/FGzQ8zpniVkgpoOSJL5BYnM3LKCwvVi0ZSaocV/+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gv6Hk6NuxBxM+mevrH1GexFQ+VTL9XlJfQurRZFIjgatnJz1Yae3tYhLhbl2tytyGTE6UcTiMu48X88jGg4d9Zx0TN9MNU4GRJKEPI7CcK8Fh4djzb8/3zITPyUofaIS2KBpbaAmA23MQenucA2pINUV16b6MVoodRHirbvCwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=QITWCLYI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgmDRds7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="QITWCLYI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgmDRds7"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id CA2E11390A12;
	Mon, 26 Aug 2024 07:41:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 07:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1724672463; x=1724758863; bh=kMFHMd9S329W3ID5o0HYSw0A/MBapvs6
	/gFfJCROojI=; b=QITWCLYIkT7WVNC1JJ+jUH+AdkJ0iof5SX5NG/iuNT2Bi5Ii
	3ouCIbj1zj/b3+7qHmO1cubZUFptrjEkKTo+MZX5yszR4uOTaI76zeKLygl7Bjo5
	srffj7gtJwnH5dJ1cfaf64hPsFDObb1Pd7P9K9bGMFsAioTJF+moD0A8DRnVH14V
	ZaCL1xHXpbg1X0Yv8EqNVtLgppJrlm8t7sDksXfZqpS/y7wVauL4pDeizaKxSQNf
	w5/bveRR8rPoGzQN6o+5F89NDkPo8O9gHWw6nXdkstNQE+sXmahozbddAZZDhenZ
	flPXfiM3S06aV6ts/cWav4+GrNFlT4NfFB5RNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724672463; x=
	1724758863; bh=kMFHMd9S329W3ID5o0HYSw0A/MBapvs6/gFfJCROojI=; b=O
	gmDRds7ooQLMaqacY8cfre5aV1XuCdxfFEpB2+FsmOIog+OcUhPIP4W7TMUvebpU
	cA2hNRB1mLVnGIE1BX8G1JY9D60wsItw0mOcZ/liXI8LjOpFxGxtsw0Q+yfLtDyx
	5hgyK323zpss1ilXful9pvdIw0cZO273L07pK7LNCkaR47yTorsZCyPcHD+dqZjo
	OxEfnqn8yYODWlcag+pJ2dDnClYZLs2L3jrHttECZLXOaFnBRhKlkQIqFxIJ56PD
	ViNsgh6KkDWnOGKKgJpGMT6ErTCXFW+jLVgeUydUFuDAr7TmsLqLA2rYSCTg35rc
	bkSk4Y3sZjNFygCJrVOGA==
X-ME-Sender: <xms:z2nMZoT85lHa4c3GKQVMEO_I3QqgYPWZDPvQA11WxnxpAZU-D8d7WQ>
    <xme:z2nMZlw43u_len4tG1LrjkhGxkxs_3c3HkH9tUgaepL5Tz7ZcdzWfVBr3y0TFlzoJ
    zjzSanUB_1xPFZhaHg>
X-ME-Received: <xmr:z2nMZl3_cHy9KwgSiBansldbafRFkKjZhFY59YsOfyscHKd8lRLpHlyfmDXi3xqLQMl4t3E-r8QPcbE4zfE5og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedggeduucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:z2nMZsC0KdbYYJMoYmmgvgL4tqa_bVsN1n3mLhVYOWvMRrxfmTEotg>
    <xmx:z2nMZhg6agX3g2jpz0IAxeg9_c2_a--rzrr-MeHQ798GI19b8kJbPw>
    <xmx:z2nMZorocp1qhCh2JkinMJhZeqRjaodXwTCN4G2_puVkxmJ5Q5N7qg>
    <xmx:z2nMZkiQrsS6XygTQ_vKzyOmiD49fpyxB-XlJQQEKDBxhgUmW-G5oQ>
    <xmx:z2nMZkQwU-xp2BxeaazQwwnWL0841goQTMaWFya6j4qQD5oSPJoP0XRm>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:41:01 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 26 Aug 2024 13:40:31 +0200
Subject: [PATCH RFC PREVIEW 5/6] iommu/vt-d: drop pasid requirement for prq
 initialization
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-iopf-for-all-v1-5-59174e6a7528@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=CwuF9pmuEX48hp2ZuB20pZfeUGBaUDnjBt7rCAANZ+E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2JNYWNCVEg1Qk1UU2tqbGh1Vlk4QVdhOUVKCit1c3RiVFEycHVxMWx3NHV1
 RXkxRVlrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbXpHbkF
 BQW9KRUUzaHJ6RnRUdzNwQTVRSUFLTXhXWTlWc2c3TWgrT3pPakZIRkNjQUZFeEVZS1A3OVowSQ
 oxSmlHS0I3SVF4OVZid0g5amM5aU1hNGIxUUNCZmM3cUtwN3BjQ0JmYWM1RnIwUWF2dUh0ZVBJO
 VdLMGtIYmg1ClRZVTdJWHU4eVdhNlRqT0RFRDNTZlROaVRRYWU0TWN2dTVGY01iQ0xiL3dlaHF6
 V2ZSaXRrWDZNRWVYK2hIOXIKTUhmQzArMGpiZWFYanZyTlBhME0ra21BSEdaN0sycmx2N21GcVF
 xVWsvRWFSZWdPRUVWbit0ZzFnRnRyTHZiaAp5NUpUWXg2ZWE0SmN6RjNVditlVXpWNkJTVWlvbm
 xTWFlwMXFuK1k4K1JKREQxbTNFYW5FVUVHWGpoZW9sMFVjCmcxd09ENTFUbWdZS0ptM2oydi9hT
 WZISzJ0RDlwdEpNUmcvbXhmYUFkM0lqOTA5S01mMjNWS1dlCj05V2JyCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

From: Klaus Jensen <k.jensen@samsung.com>

PASID support within the IOMMU is not required to enable the Page
Request Queue, only the PRS capability.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ada3507d2831..bc1a369c2cf4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1487,10 +1487,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	/* free context mapping */
 	free_context_table(iommu);
 
-	if (pasid_supported(iommu)) {
-		if (ecap_prs(iommu->ecap))
-			intel_finish_prq(iommu);
-	}
+	if (ecap_prs(iommu->ecap))
+		intel_finish_prq(iommu);
 }
 
 /*
@@ -2478,7 +2476,7 @@ static int __init init_dmars(void)
 
 		iommu_flush_write_buffer(iommu);
 
-		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+		if (ecap_prs(iommu->ecap)) {
 			/*
 			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
 			 * could cause possible lock race condition.
@@ -2919,7 +2917,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
 
-	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+	if (ecap_prs(iommu->ecap)) {
 		ret = intel_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;

-- 
2.45.2

