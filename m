Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.36.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567198;
	b=hRKDqKaGFo93V1rL+9akc8Jp52MNKJLChVQXa5vGQcI8phqJFSYhelKTXBOkQrUMNAQ/
	 LkA7wvlVTDCGv4Dl7fNtC3fmy93ev39DpQat9kmjYx/t7aypDBGtVIFvwtFQKTtTVmgn9
	 m3YIBnHPUqTCwb3uMkiD2JHaDhtYtuQJ6W/DsuexRFRj/ABfVkbZ4pXM4WkcKa7xWSsje
	 QUaGFYh4K5mrT1piGKfYxz0a0TzYNL7QCQy5v78wvCYXd7x8cEoD4aaRGPQYN53qC4k9t
	 ShPW2MM2vn7UK2WhfW4tSkW3LLbLx9Uyl0djtFPb2boRF61r6bRZKljFDzgApPigGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567198;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=FIByHlTPNo6yonGSdO2RYDduoUN+XoU6L/TvYdP6w/E=;
	b=vVg+h7B1KmWBgc9zWyIiHWuZuB/bdIDbqGi8qACoLRkGq9EQTQ+p9OByYorcOHZSIWWM
	 E89jcUDWQzbhD6hQcal1xWErZvNtCjh6EvEa/N4iOxIALNkyVlz6GEK1Dn9hQs2PR1WSC
	 wA/IweOUhbPW1ehbQZJDZ4MuebiXr1Qo5EiRKhARvZaEFqlw2jQNrpmoi6W07T6K958kF
	 FYTPzaVP+KJJvCAe/0kaBhNc0Xt9yL+SPu43Vvqsr0nkSLe3bL9edY1Klyd0//jJuPqF7
	 aTOxCEXm/9oirzi3pDGQbM6Ocp7xl+jRCs112Uv7ccC6vz2gsnSsUkaykWo2SNny6ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=DWL6Xj+e;
	arc=none smtp.remote-ip=139.138.36.225
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB1606A33F
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 00:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41CB1606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=DWL6Xj+e
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795567205; x=1827103205;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=9zVoKV2VBSnVaNWOGCXlH1YLrznYJ/CwSJb8o0cmF1o=;
  b=DWL6Xj+efw4XMqmUfWMGFqDsN7ElZj+WSW7wlNOnewvIc5GwbKqCiOdM
   BjrbM/nh/5kkZKv3+my9JlSDxeLw14vIV0Lxvoa1saO9EB50HMeBBM1D6
   5RGRMHrxxpm6pvNSEaxf2rpLEzn1u6p3ZV5SKDKPLWkSurkAcpWmyYzVS
   rtjhbiNPrq3R9m22KeDXChofgMxRFdzHcMAum6lNGyGvTFqLD0/QuMYiJ
   1FrMU9cbQGi0mIFx8hbwL93VkhT/ZkpZYDBKzwVjqkdFQm/epQoCPLSLG
   Zd1QRLvpRrwFrU2hUkGbFBozVyP0QTWrifJdiy1gOOYa1luc5r36nJ5Hr
   w==;
X-CSE-ConnectionGUID: YYSawAlfQ8KyiG8TmYOWwQ==
X-CSE-MsgGUID: ZenlP6McTSO8qj3emXzjdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="249157234"
X-IronPort-AV: E=Sophos;i="6.27,231,1786978800"; 
   d="scan'208";a="249157234"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 09:39:58 +0900
Received: from az2uksmgm3.o.css.fujitsu.com (unknown [10.151.22.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 58A941002832
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 00:39:50 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (unknown [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm3.o.css.fujitsu.com (Postfix) with ESMTPS id 0F644C00897
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 00:39:50 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTP id EB5B51400271;
	Wed, 25 Nov 2026 00:39:46 +0000 (UTC)
From: Kohei Enju <enju.kohei@fujitsu.com>
Date: Wed, 25 Nov 2026 09:39:31 +0900
Subject: [PATCH] dma: swiotlb: Use system_percpu_wq for dynamic pool
 freeing
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-swiotlb-replace-system_wq-v1-1-83807c6afb75@fujitsu.com>
X-B4-Tracking: v=1; b=H4sIAEMuBmsC/yXM0QqCQBCF4VeRuW4gBZPtVSJi3E42YWo7Wyriu
 7flufsuzr+QISiMjtlCAR817buEfJeRv0vXgPWaTMW+OORpbKP2sa05YGjFg222iOdlfLE4V4p
 UVekglP5DwE2nf/t03mzv+gEff0Fa1y9Z/TeefQAAAA==
X-Change-ID: 20261111-swiotlb-replace-system_wq-a995aa7759ea
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, 
 Petr Tesarik <ptesarik@suse.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Kohei Enju <enju.kohei@fujitsu.com>
X-Mailer: b4 0.16.0

system_wq is deprecated, and queueing dynamic SWIOTLB pool teardown work
on it causes the following warning:

  workqueue: work func swiotlb_dyn_free_work enqueued on deprecated workqueue. Use system_{percpu|dfl}_wq instead.

Use system_percpu_wq instead, which preserves the per-CPU workqueue
behavior of system_wq.

Fixes: e13d4d9a4915 ("dma: swiotlb: free dynamic pools from process context")
Signed-off-by: Kohei Enju <enju.kohei@fujitsu.com>
---
 kernel/dma/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 786954bc5e6a..4060d9ad5b24 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -926,7 +926,7 @@ static void swiotlb_dyn_free_work(struct work_struct *work)
 static void swiotlb_schedule_dyn_free(struct io_tlb_pool *pool)
 {
 	INIT_RCU_WORK(&pool->dyn_free, swiotlb_dyn_free_work);
-	queue_rcu_work(system_wq, &pool->dyn_free);
+	queue_rcu_work(system_percpu_wq, &pool->dyn_free);
 }
 
 /**

---
base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
change-id: 20261111-swiotlb-replace-system_wq-a995aa7759ea

Best regards,
--  
Kohei Enju <enju.kohei@fujitsu.com>

