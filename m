Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65314DDB3D
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606325; cv=none; b=Q/CTpnCo8uTxjMcubFqMl/bq7YZ8ovZxGf8ot6ofDZ48/Es8WWxxDbvLwxh8P1oUOltADKNZp7i8HaDz9gHvnMYNyC4v9zGNAh2u31mOETh44qmuLjP5bbxgQJE8L+BpCATVEBHTkC5FuJOHaWppJ3TrjeybxEXrXHuWmb7pPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606325; c=relaxed/simple;
	bh=HMHDIkk9eqjhFkHSH2xSM+qF3/e16Lj391jOJsFu1M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yex0ut5tsiXBme0fOZykYuZoCfn3QKnTXgSdrENjkpaDV3UtirT3280SoLZ46XMxpvGT8+NTkf2Fj9rWrLaZUmpEkcp9QBubksJGBNqLyfMrN7HdxN/3Dk24U7nMyq9Wgh0Uf7YF0uWIUmznM4VNRU1KoANfhn1q3SxXUWPZ6LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PeL9p4w2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IscHyhCm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PeL9p4w2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IscHyhCm"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAOGd782743
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SgBxAUOx84U
	cn9DyKFIg2KlUymyjg92B5RIf9l+yQcg=; b=PeL9p4w26BhoNlRqOvQ3LSV7n/M
	IktOMye2ZvfZB0pICaZ3TBWrcQlguntFEJzgoIjtjths47tJk1xoUZly2IPaQszy
	pNIDDoUjuy9W6cB/mpFxHlby71PtXHVdx0VWz6WtEILSV8JQfkeE87kr7Ib7ZPIG
	TOC7sMO2YdQEslR/txVR634Jw5qrZWxsKyoGjrLuyh/QQjmvwNSaJ/WsFebp67mG
	IImMljNxomfy+bPYM3oRVTQ8paB3pwle9mjd3f8s58TbjX1938Z7pGGKc7eXz9Rg
	gV+3ERanv7za6SCrYk/1jUrCxiIAqpgci3qNcOuCurOWNf5dPF9aV7CCWrw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4aynh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:35 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-147be78cd56so7289170c88.1
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606315; x=1791211115; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SgBxAUOx84Ucn9DyKFIg2KlUymyjg92B5RIf9l+yQcg=;
        b=IscHyhCmChouG+99OU9UvQB1CwJpGCa6FZaTCucMLamXiHUlk2pOOIarZReXAfI8VB
         bYQjHnQcRZ3AlBu8EhAPlLjNfX6+G6z3/DF+IdfaafPd05lzp9LtMVNGmjz0XnomVgXy
         XPwLwNyIsgHz1MvZ4qhkFx85tz6xYF6KhY2t3ZTwH8zynyFTdnI0a/a0Whd98s01xbe1
         EHqCniN2uUsbyfKHsPtc7XXClmF9vd4p2wEXZd6MV/7WGXbwRxK6nBMqDdLS8FuBq74p
         JNYoZ9unJTf98iC1eV3mMhGX473ZHj8lRyE+ZpBX4AM9kKUe9E4WTgA5SyE1HVBhEdLu
         jHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606315; x=1791211115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SgBxAUOx84Ucn9DyKFIg2KlUymyjg92B5RIf9l+yQcg=;
        b=JRbAZ7En5daH6uWlAx/R2mUMHSWg4Gzg+NukwyWtuLEk+RGSpbczT+bmTpF+cZXkqV
         6xpopyDKVnjOnERutpyzg8VLvB85npefTK49sHT+6hMnzwWQyzOr0/f92/vSS/Tz+O5J
         lfpgeRqS8dwmNtuANgV+z+qUOdFOslmisXxZs/uQwq8O8ZrMGcZVF7cIGPn1FyVxn+Ab
         MFWwwcSzYB1hv9y5jdnHu5jAUu8JKq+UDqfOXFXA0Pc2GbMZgjLjEqpF/uhWQL69dt+X
         2GxL5ATTh504bAjavRP2LnbJPOJaJh3DGKoJexsbI54sqK7XCSdPvLn00W6K9un3IjgO
         AB6w==
X-Gm-Message-State: AFuF++k93VoUfjoXlfPy++KBgqaIEp8huzbv22kEFMa8q9BVLmxwpKID
	WWHnZGdYRkelOnNZ24/lkXGLIGd3vQe0oSU/jmyBY4FZGauGI6TmEQtuwKC+D7rwkv8P2j3QYn3
	RDJccP2598mHmFfXp0qBvT4b/OWHdFm2CrmvN1ct8AnT9Cuh2fJzk5Y7xYbZZabFL8A==
X-Gm-Gg: AYBFou1pOINTN+0EHhsk+MtZzZ9I9SgWexiQRsK3rhxwmvOu3HJwzIPxqC6sR7Fp4/v
	3IhWd/E+5OLoAcjDuwkK1NeNCiQXBJ6ryItaF+368QkzyMBxrPEH+xPMjqZRp0I4diPrtKzuHIY
	/p0eVbCVJ8YO/QOo2PeeqtLpTXjn13aYNRjmkcYwyBOFMnrCV5CT5WisNKVh8pi/cBy8n6+XqzG
	LN9Ge2hGjadAJjo+fSZ/y4XeyV0RHa+7CewlTXjvcImct53c5om5HX7pPuiTTLFu75XDUWdug1u
	z10KRlNRK3jzo8vP9givzSj9mLTxTHY6MAjPEr6QX0nPK59CnJHxJNdequ6n54KDYat8D15bgJr
	rOIa/j2jMzsKH2/q+gkusWfzSZGcJYE1/2WvVUw==
X-Received: by 2002:a05:701b:205c:20b0:143:2719:a501 with SMTP id a92af1059eb24-146d077bfa1mr9851628c88.40.1790606314552;
        Mon, 28 Sep 2026 07:38:34 -0700 (PDT)
X-Received: by 2002:a05:6102:4b1a:b0:7a7:5355:7fb6 with SMTP id ada2fe7eead31-7af1e4f8b12mr3623511137.24.1790605896839;
        Mon, 28 Sep 2026 07:31:36 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aae5dc097csm4205378a12.12.2026.09.28.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:36 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 02/14] iommu/riscv: Prepare domain bonds for outer locking
Date: Mon, 28 Sep 2026 16:31:01 +0200
Message-ID: <20260928143113.49838-3-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cZmUaMYezT02eZRULhu5U-zvBdQ-nu90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfXylp2D02m6gGY
 161j7R4lUeRcHpZtFLG+K8Ag+GfsHlSsOZzg69iWgG3tQUSaOo56f8vdDlVBF+vtxYSmDV/Mu9R
 g/CPcA2jAhSJskaArjyL86uQb+m3YcCihNRnzSjYY1ixBuEpUEM1buCnW6F3Lg3AESjZCQ209HM
 g3Ma/ml3EUXEDH1ERVwSn4PAXmCp8eLKEmjqsxPoTqZLfzVftZNlesIE6Bm8kdi5d8E/nX8yPY+
 bR9N6VMkwp+sw2ht+GDIZAZjEi8au3XinKESaG/6aIzk5BGQa3wSLp2mwREZeyzqiZ2CxmNaEsk
 cUtKdDyjo2vI/0nbfIF9LFaxFwnP6FRs4YBY0+AtIyualRpwf19TW5idvhsIE1dSg/HdbFFd5Lt
 QieIBj3LAZoPh5n9jnSEuBzlOkeWHmfvBKH7sQDi+LojVj+ZjofeIRF6g4Ti46LNYzYQDXb3hsm
 vWhzlS13rlXvP0KqLzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX+YPYuMU/cCdn
 eUqBkBkyN569wtRjlvf1cljCIzZ5vk2HOje3sMw8IK12+edM4LF1Ai4DMazT4hEK5c3IpSozwO/
 OVfACdlF+Mjmy1vuMYSrTurbWEU06Wk=
X-Proofpoint-ORIG-GUID: cZmUaMYezT02eZRULhu5U-zvBdQ-nu90
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba7beb cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=69OsnF3JIPtLgHPxktkA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

IRQ bypass will serialize attachment under a raw spinlock. Bond updates
retain their own lock, so make it raw for safe PREEMPT_RT nesting.

MSI forwarding will acquire the MSI table lock under the hardirq-safe
IRQ descriptor lock. Nesting the bond lock below the MSI table lock
therefore requires IRQ protection even for domains without an MSI
table, where attachment takes only the bond lock. Use irqsave/irqrestore
in both bond helpers to avoid a HARDIRQ-safe to HARDIRQ-unsafe lock
dependency.

Also split allocation from list insertion so a future outer lock can be
taken after the sleeping allocation.

No functional change intended.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 3bbb4d0d0a85..09ec8c3e4a72 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -858,7 +858,7 @@ struct riscv_iommu_domain {
 		struct pt_iommu_riscv_64 riscvpt;
 	};
 	struct list_head bonds;
-	spinlock_t lock;		/* protect bonds list updates. */
+	raw_spinlock_t lock;		/* protect bonds list updates. */
 	struct mutex mutex;		/* serialize domain state updates */
 	int pscid;
 	int gscid;
@@ -896,34 +896,27 @@ struct riscv_iommu_bond {
 	struct device *dev;
 };
 
-static int riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
-				 struct device *dev)
+static void riscv_iommu_bond_link(struct riscv_iommu_domain *domain,
+				  struct riscv_iommu_bond *bond)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
-	struct riscv_iommu_bond *bond;
+	struct riscv_iommu_device *iommu = dev_to_iommu(bond->dev);
 	struct list_head *bonds;
-
-	bond = kzalloc_obj(*bond);
-	if (!bond)
-		return -ENOMEM;
-	bond->dev = dev;
+	unsigned long flags;
 
 	/*
 	 * List of devices attached to the domain is arranged based on
 	 * managed IOMMU device.
 	 */
 
-	spin_lock(&domain->lock);
+	raw_spin_lock_irqsave(&domain->lock, flags);
 	list_for_each(bonds, &domain->bonds)
 		if (dev_to_iommu(list_entry(bonds, struct riscv_iommu_bond, list)->dev) == iommu)
 			break;
 	list_add_rcu(&bond->list, bonds);
-	spin_unlock(&domain->lock);
+	raw_spin_unlock_irqrestore(&domain->lock, flags);
 
 	/* Synchronize with riscv_iommu_iotlb_inval() sequence. See comment below. */
 	smp_mb();
-
-	return 0;
 }
 
 static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
@@ -932,12 +925,13 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
+	unsigned long flags;
 	int count = 0;
 
 	if (!domain)
 		return;
 
-	spin_lock(&domain->lock);
+	raw_spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(bond, &domain->bonds, list) {
 		if (found && count)
 			break;
@@ -948,7 +942,7 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	}
 	if (found)
 		list_del_rcu(&found->list);
-	spin_unlock(&domain->lock);
+	raw_spin_unlock_irqrestore(&domain->lock, flags);
 	kfree_rcu(found, rcu);
 
 	/*
@@ -1391,6 +1385,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
+	struct riscv_iommu_bond *bond;
 	struct pt_iommu_riscv_64_hw_info pt_info;
 	struct riscv_iommu_dc dc = {0};
 	int ret;
@@ -1421,9 +1416,12 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
 	     RISCV_IOMMU_PC_TA_V;
 
-	if (riscv_iommu_bond_link(domain, dev))
+	bond = kzalloc_obj(*bond);
+	if (!bond)
 		return -ENOMEM;
+	bond->dev = dev;
 
+	riscv_iommu_bond_link(domain, bond);
 	riscv_iommu_iodir_update(iommu, dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
@@ -1475,7 +1473,7 @@ riscv_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD_RCU(&domain->bonds);
-	spin_lock_init(&domain->lock);
+	raw_spin_lock_init(&domain->lock);
 	mutex_init(&domain->mutex);
 	iommu = dev_to_iommu(dev);
 	cfg.common.hw_max_oasz_lg2 = 56;
-- 
2.43.0

