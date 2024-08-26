Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F816F827
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672468; cv=none; b=n7O89lEp20t1ZKrc2gja58VYr+CJtEzbP8VtGab2UaoD29PrHk4gaetjQAMEFfx5kXzV8u1z3j0nUuFT+F2pjX1UF0po0Zq60MM4O2NQZy6r/QKxu1M1K7sDyO4xsHFSSyEI1fTbk5cn2epsaqsXNVbvPjmBKZM5wrcjIZ40/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672468; c=relaxed/simple;
	bh=jHDwvs4XW4LjqzJwHaxI9oERjlUVSUY0D7V/9XakqNw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/VC1ctPBnTKuMdVGaB0fZOnHDysOYSSVhThAobqQyG8eg+G11UEZuHqg8fVFAMlDLRZSjoIYpFETzlBpHiR9nQjuRZjoqEN6SsuCk48D5IDP6cPx1RsDThZQMZAn7FaOhdyaq9ZOQMY8vifNeB6ohWyM504STf361EVtjovgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=WEMnRkBK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a1INHpcJ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="WEMnRkBK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a1INHpcJ"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F1414139081F;
	Mon, 26 Aug 2024 07:41:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 Aug 2024 07:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1724672465; x=1724758865; bh=qyECNre3MKh/GNrYjMn6VpOuWvEEq8tX
	k/MbTJU7AEM=; b=WEMnRkBK8zbeYD1pPYQPz9sVccQfIofESAbjmZwPiQwfJbg8
	l/TGNBA3XzYREfQzOpUco6yWJxhqnf8W369SfOlgLu3mzMLBhnntiWqZd9X4Kj8e
	4rinQ09VljVy9JIZ5qIXWHSTkBIgIwRn5kE90HHxluns7KJmEfZCawsWQL2SVXU+
	VCRTsdZHdOpt061sFgxM8IGMUd3/5E1u44PmHYFwnLX4uQiYwUKt4xnwZngsH4mz
	Yt7IUgLFAm+4ECZCQKrYrxuT319p+/Ues0c1L/pSzKReL7IHVkfbm+xArbzBU5vr
	sY4Gs104D5FEzjO57SRsFeqYqtAncAhs8/8L5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724672465; x=
	1724758865; bh=qyECNre3MKh/GNrYjMn6VpOuWvEEq8tXk/MbTJU7AEM=; b=a
	1INHpcJw3T0IFR7Ukox2q8+T+68qa0EFcYMlZ0Bk2qthFS+q+FguZ33W4uTIgccV
	+A+0ugDV84Vnb8Cq3HcrdcTc61Rnpf+fqGsVGtSPBdiO1wSAACTbrcap7hr+w3rm
	kAPyn2Kc6SspbzbzzTUV6avH1ZbC5xlBjCzz//Nn4In7eihZfSK5QC2BrGOv283R
	7ydg3OwBBtQVZ9gpqjHp9M2DmlULCSBDfQ12lbOKFmOk0u7TFdTJP1q2i6msLGPg
	t/qJip2ewGTq97rcU/hThTHQpiDj3UOaQCDj/jNnZfWoKaTxCLjFfZ7WYt/WHQmV
	0jKSiRU4eFDgPdsYz9cEQ==
X-ME-Sender: <xms:0WnMZtsMCzTZaW_6K7Yywctrm4l5urq29vONgHZLj8rMV6NpGFXCWQ>
    <xme:0WnMZmdXGyLm6zJ1PrqXOOD9TCvYsXx54zxj0T0B0YwrYurW6jqiQEfaD48smqiD8
    Tq9Sf_-t3rB-2JffpY>
X-ME-Received: <xmr:0WnMZgwZf_LECsFbyR8NceYp0Juxf-GmK8Pc-gzZQcjRlAltyJUHyxLYNGqpiTOiQULqrUdATDfEk6W9QBB0WQ>
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
X-ME-Proxy: <xmx:0WnMZkPekTS6JBiaQ8TxWLPeZroUYggSLWTHNAbHhyLZVEw07a0Zgg>
    <xmx:0WnMZt-Y06uPO2t-qvV6M1U0zZRlqXZ4D7l1UIR3Wd8OLkSZN5FYTQ>
    <xmx:0WnMZkUN6xRPpX56Tb3xG6m8X5j0hRmflgiLdLOxwQSOS3KdrHdNSg>
    <xmx:0WnMZuc1OppJSArBA4jcJmglvMkrJmp5rVqYK2mV8orXuokuTWKz_w>
    <xmx:0WnMZgV-i1C7aOwYPDalAHcYYO0Xnldonq--GMAf5V9cWfBg1Cj0kzBM>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:41:03 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 26 Aug 2024 13:40:32 +0200
Subject: [PATCH RFC PREVIEW 6/6] iommu/vt-d: do not require a PASID in page
 requests
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-iopf-for-all-v1-6-59174e6a7528@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=kfiGm5p448US0J5HAOq/YOUe9BCb4+xS2lFdixASPsE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekF4ZWo3Y0wxaHJqL3ZTO
 GJUYWtrTWFXY3lEMHdRV3RzUXdmQXkrNCtpaWRiTlpoWm1acWtTCjNkaXdyVXhlbWNsS1VXNW5N
 em9aalZrWUdMa1laTVVVV1lJMGpGZVZQcnJ6YkpGNzJnR1lRYXhNSUZNWXVEZ0YKWUNLMUJ6Z1k
 1alM1TnovTGZNS3lPK1RKcGVncFArY1UydjJNWnYvS2FqdzNxQ0NwejB6L25XeVp5ZDZwTnlyKw
 p1VnpMNitHWjduelBKMit5dmNycmw3bW1QMDhGbFZTOTIyNFNOdlhOWStGaXVlUmxWN2lPcXEwd
 1hYV3FTU2J3CnMzbjFSc3YwT2VyZDhwbTdNd1FsaFNWbktpWHZ1N2d0ZHZWOGh0dlQ3STRzL3Iy
 bWZmNVJscm9INVdVbXJ5eVgKVjB3UmpWclJQY255NGkxUHZiZEhDanEyclpDZWQ0ejNnZDNEL3J
 TTkx6YnVuK1FhYWMvNlIxQjBUNDU4ZjVOUgpvbk5JWjZiUG8zMldIK09xN3JDY3Z4LzlYNCsxSl
 NpRHVlVno5VGNXMFgzRzZ5UFBsb2Vzdkp6UzcrclR0NDlICk5jZmhpc2ZTL3o2S0RrTHI1ODdpU
 GUxaFlOYm54TEJtV3ZvN1oyMHB3WktRMTlVQWhkU2lIdz09Cj1OQUY3Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

From: Klaus Jensen <k.jensen@samsung.com>

PRQ events can now be handled without a PASID being present. Remove the
restriction.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 drivers/iommu/intel/prq.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
index 2814373e95d8..cc36198ebf91 100644
--- a/drivers/iommu/intel/prq.c
+++ b/drivers/iommu/intel/prq.c
@@ -101,18 +101,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		req = &iommu->prq[head / sizeof(*req)];
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
 
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
-			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
-
 		if (unlikely(!is_canonical_address(address))) {
 			pr_err("IOMMU: %s: Address is not canonical\n",
 			       iommu->name);
-			goto bad_req;
+bad_req:
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
 		}
 
 		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {

-- 
2.45.2

