Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51F486E45
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262130; cv=none; b=LKteqSergy5pbVTSED6pUWH+hdVW2U0Kt3VBWvMZV+Rm7+gLtkqKbd5hCOUW9gvC+gOrCULtKXo1IZvkUQgVXB9k6U9Lhx1vSxCydrjLgcoqO9kBMpuTJ8kFNlBBKq7drqqdoc8dIoug749sL7EqepvCQ2FsBdioBgrOShg0zBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262130; c=relaxed/simple;
	bh=OtjqiRpJWnwWbHw9R4LYvyNr5zP4pITXmox0FONClVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuRWCpEsNd+NB/hX02UUQ1ttYZUz9/cHf9bWwQBYeuuiymE64sEi9RKM+H9bkw7CouQoa3dC8BvyKHxPgw/nrK0CYoAk1YKMmvj3SPabgbe2xOYq8Ib41exg5fAIkLr+kej4cA15Z4U/DgI9lu8tXxdTm7LniIDnmcTRGu1gowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hai/VHYy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FNaY+i9T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hai/VHYy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FNaY+i9T"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7pLR3492133
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vyODiBWKuzm
	uq5TZsRKKzD7ne2IN4bfUAIf/kyMhK2I=; b=Hai/VHYydaPn/Lrgc4Dc8uZKjFJ
	FHchH7uar4NIJHbRxH6Bc7GuM9fDY397iR8kytDPbcydYhD9DzMs/cAtGkldZ6DM
	eSqkHyQ3UiJnfhUanyhAJtPG5v9MdjhtVMAyo1hehFVHPz/cg84midQv5T05a9RO
	yHWCEN9Uls7/dxuOQz6sKTtwTLyEynwBeghq+opWeK4v9ufVheXOqUgGFT7tbAwc
	chMGabjtqgsfQtwS2SOFoXl5T4u98xdPLCKRs7u1rJz5oC/M18qJxgl1wyNhLJlx
	zeNDJixtkBgiUaJEH3dapAprUuf8q4m2m0k623mloJoA8rEfWwN0yVcKwZg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5ytcb06w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:07 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-526da7e3c9dso3077231cf.1
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262127; x=1787866927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vyODiBWKuzmuq5TZsRKKzD7ne2IN4bfUAIf/kyMhK2I=;
        b=FNaY+i9TKablZ7pDE5RuKstYJN73NLHvY+95lEY+zsuPgkvuRGrUHAH/C3q/Fpured
         L9kJk2SsWVlH/cyNTWEJmtZqOSDt1l6mIWgbsyH55XybhKcxezyCAKQW6w3q6Pbfaoeb
         C5NclLlgIMQu7kIS3AKBE2kFDvbHZQMbMrYsuRGpUt6vrRV7rqLnod8hSsGmwAodm+2n
         f/rSTOFYp4oAdfeee7+knqNzFB+2Ozw/984oD/nEd621akLR63+GFSxtBNSn4YJNyMOl
         2la1msxHDeYrIqTwyWDmyCsYjl0htZhmuo525kRdYiZ5/y6/IsG+SF7QL/VmaCX3cuIe
         teXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262127; x=1787866927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vyODiBWKuzmuq5TZsRKKzD7ne2IN4bfUAIf/kyMhK2I=;
        b=mlJkp8jwWgJbL5QCftT5p6D60bBzHHhQrT3UDzdNBmI7Hw1M/erfps5ZiAmF1NO1xH
         YAqFx1pVjD9eWTG3oE6PapI8Q9KIeKSGKcqOAFuwSmK2wfKtQG+7hlk+7cjxgZtLdnc9
         CkFmFnDanz5YeZa3FjgVKFM2LN5zpJd+7TIChcp2oJlF7e0vCNO739AufVX4+MF+ECt2
         80R3cK7tIh2+xaUqEg7hDjwR0gXCt3h8svMPUwsq7f7CEoLHFmh75UZiux9soL90BXac
         jjFIYnU3UgjE4ON1lb45+SGR7VAjcVCq9QIDytu6PtX7agbvbhS0OZlh4FX0uhe174uG
         bvXg==
X-Forwarded-Encrypted: i=1; AHgh+RoBEs/a0pQ8fLRmG5+xTlJgM0np3tXEo2qN85aMeIxiHWaXoHhGyjuQqLYWt1bXqAhTx3/g1g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZQ5L/GFJkRQx5bb/UDWf+DSsYBVB860nUU6+BBqtvJB0OeeoD
	jZvy6HzGNJRF9FxSQCCZ8dxa0q2VuHaN1ImuW5clX9a1Dum0aVPt9DIgdwgQEfnKMsQIyeXcXF8
	c1jPucRQw4wwiumJ+X3TsFfQV/gNWUe4o+yxfQmzbdAwdlONmvqimdDyPUA==
X-Gm-Gg: AR+sD13BFqybVy9x9lIEDLuknlEwW70vSH1wvB6t/YqimodZqU0CICExLpGd2Y6qhub
	/pJB+vU5yRIwE0mrIegoGACW/S/Vfe8g0Ch7AEYXUJ388Zh0u51Tv2IMAWVwKFWuNnDjv+HQBe6
	GrogBhZ+eAsWUvs56fOZAncXcVg1qSaxSC40x7aHx1emJOPj8+T70j3lnwi4KXts5PvODfdmmVk
	iE8hwIr+IzGAPaL/hO2C22kABaFy8auHJaG7Sm4IInLojrQZMOQwFWIR/IYh2tQtRKiE7cmAbbQ
	zhRVBhYh97o2MGdFiYcNuHoHCFSuSZL4M8XBtntMjxUoxPnI6dFI4ihmwjcwkds8FUUmAd2ka4x
	GanISGrDb
X-Received: by 2002:ac8:6543:0:b0:51c:1117:c7c with SMTP id d75a77b69052e-52df59aa4b2mr15893151cf.25.1787262126899;
        Thu, 20 Aug 2026 14:42:06 -0700 (PDT)
X-Received: by 2002:ac8:6543:0:b0:51c:1117:c7c with SMTP id d75a77b69052e-52df59aa4b2mr15892411cf.25.1787262126339;
        Thu, 20 Aug 2026 14:42:06 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b90e3170sm8164685e9.5.2026.08.20.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:05 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 07/21] irqchip/riscv-imsic: Compose MSI updates through the hierarchy
Date: Thu, 20 Aug 2026 23:41:36 +0200
Message-ID: <20260820214150.545737-8-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OqZ/DS/t c=1 sm=1 tr=0 ts=6a8774af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=6bvwFovRZacPTmdMXs8A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX362NTTBX8JLY
 QZTNwdQn8w7u0SH0esESByeO6Navz6H9QtR/o1A8L54jko1b5r6hmjCeFKqlgZiQqlMUm9h58Sc
 MjsG0vPDoD9Aae8kROu3o2ZtV+BHV256Ce2OGvpwjrEH/IIphbwwdKCxItuxqpRbhiQp78rgfN+
 26jKzDMsymaVS9P3ohsIbXvKgr9MdPf1u6830ULTVJ3eMT3QK0si0oywqxTiKy52NfZpx9/BAE6
 MhHQ/vZNiTxguPZxlYslrCSObQ0Ma2xLpdJEyYTHpTYlvU6V/7IfPbesF0bUT3cLkfLf6SkDCSP
 7NbIi36zdjYTFDj0qBn1VU5hIycPLDUInFdryXByey2LrtGOQsoC5K+BUFOCHdJySWwtrgLNkq7
 kO4mPvhMz0ZRa3n0Vg4gBnMfFYTLDjp5FgwOom9tgUxqxVJimWWBJ3QCieXg/U/S9rfXcOQGSER
 E/nFONkumw2HUWmKLRw==
X-Proofpoint-ORIG-GUID: gdXnkTs4vig7yWHyeY0UYK2LD1lMKcPF
X-Proofpoint-GUID: gdXnkTs4vig7yWHyeY0UYK2LD1lMKcPF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX8hJUstGsNXd5
 W7mOKRY+1ykfa59aC704UxM80OdG9wcNyELTebtz7ErGsnNWS5FgdXzESrDLQCzMt1jjS4PouJP
 TN6jHk3LT1QMw0o3fOwN1PPJUaGuT0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

imsic_irq_set_affinity() currently writes a newly composed MSI message
directly to the device. This bypasses intermediate irqdomains, so an
IOMMU remapping domain cannot translate the target after an affinity
change.

Compose affinity updates from the top of the hierarchy instead. This
allows each intermediate domain to update the message and any descriptor
state before the device is programmed.

Non-atomic moves temporarily use the old address with the new interrupt
ID before switching to the new vector. Preserve that transition by
composing the temporary message before publishing the new vector, then
compose the final message after publishing it, but before the old vector
is retired.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/irqchip/irq-riscv-imsic-platform.c | 27 ++++++++--------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 643c8e459611..5634641dc223 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -90,19 +90,12 @@ static void imsic_irq_compose_msg(struct irq_data *d, struct msi_msg *msg)
 }
 
 #ifdef CONFIG_SMP
-static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
-{
-	struct msi_msg msg = { };
-
-	imsic_irq_compose_vector_msg(vec, &msg);
-	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, &msg);
-}
-
 static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 				  bool force)
 {
+	struct irq_data *top = irq_get_irq_data(d->irq);
 	struct imsic_vector *old_vec, *new_vec;
-	struct imsic_vector tmp_vec;
+	struct msi_msg msg = { };
 
 	/*
 	 * Requirements for the downstream irqdomains (or devices):
@@ -153,20 +146,20 @@ static int imsic_irq_set_affinity(struct irq_data *d, const struct cpumask *mask
 	 */
 	if (!irq_can_move_in_process_context(d) &&
 	    new_vec->local_id != old_vec->local_id) {
-		/* Setup temporary vector */
-		tmp_vec.cpu = old_vec->cpu;
-		tmp_vec.local_id = new_vec->local_id;
-
 		/* Point device to the temporary vector */
-		imsic_msi_update_msg(irq_get_irq_data(d->irq), &tmp_vec);
+		BUG_ON(irq_chip_compose_msi_msg(top, &msg));
+		msg.data = new_vec->local_id;
+		irq_data_get_irq_chip(top)->irq_write_msi_msg(top, &msg);
 	}
 
-	/* Point device to the new vector */
-	imsic_msi_update_msg(irq_get_irq_data(d->irq), new_vec);
-
 	/* Update irq descriptors with the new vector */
 	d->chip_data = new_vec;
 
+	/* Point device to the new vector */
+	memset(&msg, 0, sizeof(msg));
+	BUG_ON(irq_chip_compose_msi_msg(top, &msg));
+	irq_data_get_irq_chip(top)->irq_write_msi_msg(top, &msg);
+
 	/* Update effective affinity */
 	irq_data_update_effective_affinity(d, cpumask_of(new_vec->cpu));
 
-- 
2.43.0

