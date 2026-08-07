Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D187353A8A
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126653; cv=none; b=RAQp7DWFYLgt3rhTCPhv1uYMnJovPJ0SzypbjpV4blPUJqlBfFNlglvhpABz+3K77DiR1LPFYx5fs8D1MF57uBLjAY6uf7zkTz+Dn96I9dkh1CKQtOMGygeevY8PLdzBrqaCduovkjxArfGg5B26cCwPi3tcKpQFD8YOqd24f5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126653; c=relaxed/simple;
	bh=37RtK2D28BmUAmkGMaYwcTQM7hs2OULYAFpm56Fl4R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6eQqfXMCPRwuz1wbMK69OaZVTQQBq6i5D/6SRWmpuDaFy+uQwg3+JYL/DgRtH/sWXt1Yx6El2/3yiRM9dS6CBV9jJp5k2103UzxGdodOSQm9vo+CGwRGWeouAtqa2LQ+7O5lyMXF+NT099LrlkLrg2U9jqQSAvgpAkQ5jIvUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dKwdx06S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bRgJx4Mm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dKwdx06S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bRgJx4Mm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GbPET1537971
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pDwQTzkackf
	YyWvS2E1rMtaG5mXeUpuJDpmUY0FaUR4=; b=dKwdx06S6bv4tZCmafXCDcMneGs
	q++is8CYGWL9SS7UCh12/lMJoeeI3y5MAACe5rJYNRZbBNISIBT5sO8W3Rc5b+xF
	Qeh5nQYYiddIsEcuZ8t3+r5tMUKDJSQhubCiOS2zJQ058NPbSM4X3lvp8weSOQVH
	bNID3jUhqFhUo5ws71QKuWwB3UwMquUGJ7Q23I1J9X8qnj5zR6/6Dgc2YyePYPP3
	bq8GT71LT4/xEMv9bQnqYsVCcSt4lrkB4dr7+1vdP/zjPGLI2oid4pHb3Zsloy+u
	/NrfGIp4zRDnXUF9HNfWZohoNnY3V7R/00fxMgDdQFS6ulD9YpeybNGcXTg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwk200f6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso55097551cf.3
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126650; x=1786731450; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pDwQTzkackfYyWvS2E1rMtaG5mXeUpuJDpmUY0FaUR4=;
        b=bRgJx4MmvK0cSpvRdUH18zrmSggiQzN1Me/wXx2o/5zKueiTBf7N6+0DWK0a2LYHX+
         NmlsSrKh4MrjFq0G+uNAT+vbDcfZslAxwrWQIl4fYctIHZC7lZYyvmWe+Q1Yvwc6vDh3
         ISavvTp0eiEdZ8N6F0V+Az+KVA2uhCxMmjSkPPEOKRwqnpiJxL471YN0qIHA2OD5WsT1
         wWeeJdFmzPd2IArsKIAQ52J7oSMViUIn+j++y8/I/KLrJtxYwnm8zKZLj3dBfz4iyFUu
         Fhf0kDoNq9VICI0rOAv6O1lSytzE3TSQztjRZhrYcoEw9Xp4WV1WiLLRAD1hzHcKQToB
         2Cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126650; x=1786731450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pDwQTzkackfYyWvS2E1rMtaG5mXeUpuJDpmUY0FaUR4=;
        b=Qh/y53rfuhAda6Et1QSwdXQEmLbiYEMriIYSIE9yVj3MRM78RY7ledBggSKvUdSVab
         oi2alXzl27rhdxcj5NW63aKJuXBz2V4EMdC1j2lFd4BTfNlMu/9R8F1o8Es23iiiWCas
         PwP1uXpMoT6TNjOU56zGu6V1wdV+9mPmirXw2bzlqV7bqANL8KkbcPkr812Kiq695HpG
         dTPPd1Rpb6C/5E+jYpUrgr+TJVH5OIHEaNxxSo/cFFX2fAOM2OVEPS2l/3zEz+NJ8jWu
         oP1FT5LsxcLBqcLgE+us2wOUDwXqYWN3RD7DLA/yQLfRejnikrZkq4iGH2w2HD14DK6k
         tGvg==
X-Forwarded-Encrypted: i=1; AHgh+Rq9b2ownEB5BXuLuuzz/NJU0yv424yzzESjE5z/4r8P0YEBq2GBjkfe3P2AqwNvZcT2vmeQww==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG75Yg0gzmC3O9ilYpjlZKN5t4+vuHRevh6/lyrTdbGNlQS1uo
	MvHCbFPdtgj10MEhfzraSiaDvBYovC1u81lxV8Wh7aZDAqH9FA35vvnOmmn/xntmRp/eWhSDC5Z
	MNAOBhLQHCN5qBucv8LM6RcMKLj/4dOhSZiWuaI9/RDZbOSZcqmXi8QqwiQ==
X-Gm-Gg: AR+sD11iFYNK09MWvrRPADMyVyOsmjr8b0/KwYIvs3Ol9fde8VElXYYU0FIkQ9svLPX
	y+8hdZgzEEdvqFIkGG3DuvZ/npxVXNCQK3S7qEpQnG6fCEsAfcURtymocEP+QJaz2sMSMS2wiNF
	sJ+3487UxjFGb5lPlWoQMGkhw/Hpljdmr2hxmV0n+lQ35VrvDmHb46wqhjllF5n5ud5WoypBbg7
	uZQ9AizMSbf7+mpRWogjDKDxYVxTCtGi7V3nP1aFVNVxUt2l9NUe6FqMN7+gQDp5rZTtFSGX9L6
	kiteRtmHqlLrJITa2wsvGQrCTnwIMUgtmihXLH6nkfTXJ5jLrmbNlEwuRKFWK7xQnhqUehILOeg
	eW/KYTgg3BMSiKJweU1nntg1l8F3Acf1c/BmyAU8=
X-Received: by 2002:a05:622a:a10:b0:51c:a9a:b0ed with SMTP id d75a77b69052e-52d0b191dccmr138504431cf.26.1786126649719;
        Fri, 07 Aug 2026 11:17:29 -0700 (PDT)
X-Received: by 2002:a05:622a:a10:b0:51c:a9a:b0ed with SMTP id d75a77b69052e-52d0b191dccmr138503641cf.26.1786126649289;
        Fri, 07 Aug 2026 11:17:29 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080cc386esm80002966b.45.2026.08.07.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:28 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 06/19] irqchip/riscv-imsic: Compose MSI updates through the hierarchy
Date: Fri,  7 Aug 2026 20:17:00 +0200
Message-ID: <20260807181713.228535-7-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
References: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX4dfxN/SeeY42
 jJhwR9ZqcODqAjbg7wlsiuLLKEwOWJrKhFiMW3Gc+7WtsXZUCMTOm4IFe85LlDstcr4UqP+KxpE
 NOrDe15QZtQ3zlWnsBppopCrNt2PJvqjPLS/HJt5b3D4NzQ/QBEN4B7alulPtIxN6BvJN8v9dXU
 Qj0HlanGpY2V9XQwUA59FQGLIR3q9lnbOnwfYAGJVCUgLd7cqRU45cayj+h8w0d/FdQ5hXvFvi9
 XlYdc2GYSjBjQX2YSDhW2IOms6j3BGyesA4A7biVh6yU5oETyI0xlA60O+sdazpjFLglz1uioqZ
 tktHAZGl5Cj1q11EdXiEsL+0eb4vlRZDB9+Ebq/P21kWyBfmazeYB6+tJHWcQDX2b2ErVUiIu/z
 /1OkOXvvjDMrqZg6zEK7h2rhkrozQwkiBD9dm33bCmEcq2sz1tAglB13LqwVIHo9uzwGufWrj8Q
 mMtjuTT6q/deK20zQfg==
X-Proofpoint-ORIG-GUID: 5HDWAmW4gsxI74SmBMfckCbsUS4IemVm
X-Proofpoint-GUID: 5HDWAmW4gsxI74SmBMfckCbsUS4IemVm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfXwKTdcylZHsMd
 yeinYKIsWm7+CJOzQPkQwILFsIx4G9lOal0fBig4Dz8cNjTFKAQMvb6emJdvoM2WW/LimaCqAkD
 VW4kJGH12urfXs3NHQDw1aqNuiSmBUQ=
X-Authority-Analysis: v=2.4 cv=Fvw1OWrq c=1 sm=1 tr=0 ts=6a76213a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3qtCRIp3mPeaHrg9mH0A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

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

