Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A504441639
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905960; cv=none; b=Q4Dyoi88T4l2gdkTefJBZVZVv49uHwmnGaQ5o1XA5GNFCLwH1W1fTsfseDNcA+Ao95KLRgZnNFe0aOAryaNVwJUzFizDKRuaWeuBZXKef6PYjRgLvHY1fVBUbimWdcLSQKalYLODybD27QXt3OGj/alC4huBIATnsV8B0CE239I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905960; c=relaxed/simple;
	bh=37RtK2D28BmUAmkGMaYwcTQM7hs2OULYAFpm56Fl4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIjF7k91sOFlLZh1qF2TNfIA4x6vO3a/4RjUp2wjklDvQfIpM8hTT8QFc+swdyVyo3XTqxjCFsr46mNYBkmEMpqJXYoNfF7bE2qR/IvoCVja67XjSsI8PkQCZOW3s9vTNYELEErhVmftLkeNmCvKMdL59Ok5gONGjkdnv1A315Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fuE/TVdz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBMXvWxR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fuE/TVdz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBMXvWxR"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbG1C3178246
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pDwQTzkackf
	YyWvS2E1rMtaG5mXeUpuJDpmUY0FaUR4=; b=fuE/TVdzS4YIsVQCtTo9S34dhoc
	hsHIrW1AGwfbOytZnTqzLuMvT/WZl71500gSakWVU3lre5JOovNL9uQoCWc3vQZ0
	pLcv+aLZ9mmHUN1K8yj1iPP1RjSk9Oo9YkmZIy5cAof7EZ1yGiJaAvv7KCi3inDq
	uO5/ziq6eg1/MWVSiag9J9e4Z1aVKoQ042ofGv6wG1L45aF/0v9uRExVIWIKNLYZ
	J9nc1kk3ompOc/iULZhqtmGNOK98GODoKTmLZWloxwnLTRL9N25j+CgLBgNYWNQC
	GaN/y7Um+IByOombta8+pAAnHBNZ1YLo+iuuP2SnAEOiW+jkDjktF1nd55w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yah4ks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 15:12:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1b4d961dso7287171cf.1
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905954; x=1785510754; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDwQTzkackfYyWvS2E1rMtaG5mXeUpuJDpmUY0FaUR4=;
        b=LBMXvWxRbgRWZ5fdkvk7AWxXvTgyq3567pYzb3sX7Z34z2MVrOW0lwtYibwoNloOAP
         L1zA+R/CRKcPA9YJsK3OAXute7hUmkSpe1DJF60bSLllzEhr5Df8ayXVNX+qHBw1WOM3
         ZHeNcV/WpV7JmaYEI1dlhbVK98U+DED0KYAtfOHJMZCMRfrV1NFSKqNHcUsjumQL/MzQ
         +HfGefZAoVR+ojM1Qy648XSPIe9st80XQg5lX362NSWq/SpWgdwa6a1JssBrRGEv7zEU
         A9DLd85jsN+llquewpj0TlgkVxuOMNPc6y84kK6bNGL7f4UdIB8tbiaZkwSIYjS7ng06
         mh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905954; x=1785510754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pDwQTzkackfYyWvS2E1rMtaG5mXeUpuJDpmUY0FaUR4=;
        b=hMMyzjziOBRcABFD1GDQeN58OaU5WguiSzezC0nCbV8YFzc3YDvFEwFs0X4UEv65lV
         s2XyYRLWxvhGqW8W+Gmr4JNM9eD5YWpgSGuXmR5CERvTHoSK9F/vF9caD0V6r2gy1mOi
         p+pBaFbYxCrx5KWFU++D4/XVxMYpZ6KlJHhavxouVXkpkWdKzxTX0Omk5sf0DYhkL5MZ
         +jra1shkBpBwWjNb9DF861Z0eakLJxEsoZlz0Ta0JGvHKUAZNjakLiexKdsHgc8nN7DQ
         LQ/Ae2E3bEmE7+aO8R7vD8K2clBmn0VwUtuOakiJTae+FH4qzJ8UWm0Dgwj301oXKTCK
         Pklw==
X-Forwarded-Encrypted: i=1; AHgh+RqH3ekruo8WBE9tbbQLP0Q3rOqKBGqgnoNXjL5z0Tj5ITsIE8B6WTRbIyCObV1OM+7jmd10MQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyVHtqer43XUVvb00m5jHhNpslhzRu+sBnZ+uXrw39K5klybxgm
	9nIpDNMsweOfgW773anKlIADvXs3h/lsfRD2BRVRKke6dGQtDljfemtS13pdNNdFX/cyuZFtvCh
	T1mCTe3ORaJJm9EBlAtwQLkP57LI/aniRw0sBO9Ya6whkFaSX7OrPE6mhsg==
X-Gm-Gg: AR+sD11wdt/EaC88xDwJx9BUu4k5y6CkOPqXFXkBMZkiySB4/puC0hl+HQ7r2wwdHmT
	O3FfA9OnYcAoyUlKXVOY3fBCh0zBYfcHNDHuyrEIHKU/rWSuz6tEXsAqgMN201New5nfevqj6uf
	L+8364SsFOqZ2MWfuI6jb/MgeDmm/WPVdQg8Ijilu1J/azIQWdzeu13obTDYQV5l71PhcGfjBAM
	XuAYTdNJcUxtjVxmGPAYljj1HiPt8s22I/RLKgQHJ8Qyxv6My5S3qhijO9ynX7JhXm9X15ORoWp
	bQeaYRo2/o4PZi+1TwLtUCVXvFgyfC97O+X3dy1FEF4aKGFGc+H2Uc0QnXOJUUhZELmFhYlf7Yp
	o1s2zA8PQjDJSixopQ5q2UFP2hFpl9W++rkAZ
X-Received: by 2002:ac8:6546:0:b0:517:9407:5c38 with SMTP id d75a77b69052e-5295d377f21mr10370151cf.24.1784905954097;
        Fri, 24 Jul 2026 08:12:34 -0700 (PDT)
X-Received: by 2002:ac8:6546:0:b0:517:9407:5c38 with SMTP id d75a77b69052e-5295d377f21mr10369761cf.24.1784905953639;
        Fri, 24 Jul 2026 08:12:33 -0700 (PDT)
Received: from localhost (ip-86-49-247-5.bb.vodafone.cz. [86.49.247.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32af243fsm367656066b.26.2026.07.24.08.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:12:32 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v2 06/14] irqchip/riscv-imsic: Compose MSI updates through the hierarchy
Date: Fri, 24 Jul 2026 17:12:10 +0200
Message-ID: <20260724151218.965929-7-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
References: <20260724151218.965929-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX3Yp6ibD5lfcA
 t/NDw19DTUS8WqeJ0ik2Cgbr4Q7jNQlJpVN98nkDmG1SvK9KW4JXIVTTYrq8JgtJhEoASVuVD0P
 cFxv3Ny5YrcN7t/v5pBjwQceGnFXIOs=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a6380e2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=aYZ+cQcEYoLAp2L633VOig==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3qtCRIp3mPeaHrg9mH0A:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: mdhstP06QiH-F7ZlG49h5dPSG7pZhevv
X-Proofpoint-ORIG-GUID: mdhstP06QiH-F7ZlG49h5dPSG7pZhevv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNyBTYWx0ZWRfX5xTZ5xXoD7+Q
 vurSDar267wiWQw/I4B0Ep5dOIH1Xp2WZRs9Ai6FoG85iCZ3jFsylyGTD9QtfKUr/lg6JJhpANn
 5ONxFIWVbxIbeWmv9DuodPHQmXMAJ/wtG8YX1pL+jYt56ueSm3wjSFjSfSsRmGdaZchhyVaByhC
 Q4hleMpaxRy6XnbIVAn3TlXNKa5bPIhhwVcdbJ844J5G2DvooLuv/ZGhMVjZRM7jW8REYpioBf5
 Ssyp/GAWsgDGydHt5UeeLxy0+yv11ro5hYq22moobPlxwhX6Kh+41oHC7QpwKZmrJqixRPLvCH9
 3Xmfeta71bAN8jM8Xmf98qJy6FzG6hImL2yYdjIz/EhqxBr5DNVYE2eU1TIWEABvCphLkgfZoxr
 JIWcRL8J203WRK66oZ/Pn5it/eFF9yRmHBFYKnaryxGKvqoV6r1iwVCMr0fGk8wEXBfmorRUofz
 g7B2xChtIO61VE4L0Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240137

imsic_irq_set_affinity() wrote the new IMSIC target straight to the
device via imsic_msi_update_msg(), bypassing the irqdomain hierarchy.
That skips any intermediate IOMMU irqdomain sitting between IMSIC and
the device, so a remapped device would keep the pre-remap physical
address after every affinity change.

Compose MSI updates via irq_chip_compose_msi_msg() starting from the
top of the hierarchy instead, so an intermediate remap domain gets to
translate the target before the device is written.

For the temporary vector used by non-atomic affinity updates, compose
the current vector through the hierarchy before d->chip_data is switched
to the new vector, then replace only msg.data with the new local ID.
This preserves the required old-address/new-data temporary target while
also allowing an intermediate remap domain to refresh or clear any MSI
IOVA state cached on the device's MSI descriptor.

Moving the final write to after d->chip_data = new_vec is required
because irq_chip_compose_msi_msg() reads d->chip_data. Keep it before
updating effective affinity and migrating vector state so the device is
retargeted before the old vector is disabled.

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

