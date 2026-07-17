Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8B442B313
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299584; cv=none; b=qAWzVn3s4TETeugI7KdByO991pbyvX2+UoPvYB6BMSBwBxxb/finpzJ5eD3OC3qr8jZbrtlYecILy0N2AHq/dxM/4B3XKjRFgXlGov6Oa3OeIWaSi85ofrWyZcQv7kkdyssTme7HPsFxsqGKa2TNPbC+fCxbARqijM7J06IYTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299584; c=relaxed/simple;
	bh=MMP0o0/wLxlkOACAQ1AZ23luEK1+TS0ogSqOvAnVWdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R1YUBmwTcCg5it6PNlpr0oMXLFEjqEXr+Pc6Jy1KZ5pxdpHbRK58ngJaA5HXoA/yWOvVBcbeSdKmGWMkmMG0I7inFlvIdOZ+gUfSd+Mz+iUjssu2oj09AFMiG9rVowhZ3yy+84n/kXg+5hbuwxiTOKEOuSD8gHcAp697/0nvwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MsCNE9vS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RoC/7t3q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MsCNE9vS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RoC/7t3q"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE7e5W3123185
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WqxH1zDa0UM90FIlcAZOeYgVcW9oIh+YtN03t/bfm5A=; b=MsCNE9vSa5V3v0T9
	TOh0LvhG/ngqx7nbQ/VvRAqiPY3pwCGdJTulrwpFROazkDyqkzyxUDiED9tyqZ+y
	n+8QI/OcSnJq2dK6Pca9KcHGnPdsOAAjw9o6Z/Txt+Gpv2OG2X+UOB+luWz2Cegs
	LW5PvQLMtKAL6qvqzCpYsNPm239q9d2FrHBZe9clnkvRn++bnOpZjnOwAAdrUcHU
	vDDP2m6dkTbHxcQK8qyfLynvyZ/5dpOZFrRfuWKEFfT9sq5DVC7VICg6T27nm0eF
	wMftm7oQAIebMugVWdRBjRfzanC3WqUgE9PiQ2x5o+DArmArvSmLAIX2lru0XhGu
	5iuw9Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff3u6m7m3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 14:46:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so98151241cf.2
        for <iommu@lists.linux.dev>; Fri, 17 Jul 2026 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784299581; x=1784904381; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WqxH1zDa0UM90FIlcAZOeYgVcW9oIh+YtN03t/bfm5A=;
        b=RoC/7t3qIQb2GqPXU7fUpl7fnte2bZaPENLwSYOQfTd+dRf6vXs5Y6NJd6p6aNY+TR
         S+wWhjQ6z6YcW8UhSQsaKUcftIwEmOldbIPYQxllc02+sLjkfwT+FyO5N7yONSo2Was7
         yNsw0FGp7RzV0IEm7IMbpcWANDb+5a4roeAvHTZepq0ViImaOAk3mC1i5ceDvL6cKrPi
         3tpBoX3yHT2DLtkVTCEugdRkwPVnp5F6SmLo5i64WaHQmJZdWLY9SXtfLyJTZ7hOxIO5
         iGJM27zvVNx0l6bWrn1nODH1S7BWN7orSk3T7E8jb/fweD0Q9SM9llF+po9fbb0c5znd
         k/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784299581; x=1784904381;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqxH1zDa0UM90FIlcAZOeYgVcW9oIh+YtN03t/bfm5A=;
        b=apm/URb4cPH46leHTltSu9owynTshazxiClu8zlX5KG+4sXal+naStproyRPj4qImW
         oUHUdjgldr4ki8Ns4Pk9p50uUX2BXX9NFVVRgy5vsBtnlaqFJnGdzyajmAzdIwfN7eEw
         lIx1K5mZD8BXthw6X7QMwq0UpQUkuasmRfgzF0VXE0TpYgiITtwuwcq/GxOQdNkDqk7R
         4vmHYWZMUCte9uIcgP463+fSxkOpv+a+K2v0s0AF6insI2Vm/IB0/iBQXYAIW4tkP14b
         LBlHGvWJX8TctWpubHmpo7GaehwuyOpyVPBZE53rG3MOkoXPYuSg3tnxcQec/aes1FNa
         rPUA==
X-Forwarded-Encrypted: i=1; AHgh+RoTk/DJSdt7yv49ee9Bs2um4U07cuc76J2MFvJsWqn6qN9c9sn4BA9KhfJ8JekI2HmpoynerA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPAzQnQjt4XoKaJdb6Nhx7u/nRsKqpG4yTg4Q/xQ1XYN9KkJY2
	ukk68+QdBmzbwaVydz+FL0HWaMbZ5pKjHkUyju7TnBDca6LLRfpByUMOEDcXQ7dtuiExucZRIY4
	LtwhePHEaol0Zd4kcYQq1pgkY+tIqAorA2vanGRZG1+Y6K5FNzjWOTQsAng==
X-Gm-Gg: AfdE7ck+yMjWyCoKsaus3JjpC2oTLjD834hhendvXtLt1X4QjccIEn5j4hT8tKsqKf5
	Mg1Hn6YrXQ6+Xzup0pRgB2EaBxeVI4wKegzwe1JcUuDFHAptMQbDk/E4qkqW80OgsHOynEEzOjf
	Vj5+dhWvDGRYd8v/H7p5mf6z12IhsVjK8hQqCZTk+W+0hbkuY+vzbIEi553/CnBHcuA2/3p4sgA
	WR+skkJzupaFLC0IGYNrpep+Z+4HO1nVbwCHku9hal+76qtsy4lv0YJCCOrZEC/VW9vsLc1J3BT
	AvtlBmfH4HFumb4KbgFPH4zRPzDVkRv5FhXp76cibHX7lTYSSWsYpw+xRJEwODhsX+3y5VDAVad
	S/MIMEEppYpIETI0UwjwOuoVWQzA=
X-Received: by 2002:ac8:5d88:0:b0:51b:eb55:2916 with SMTP id d75a77b69052e-5213dba36cemr24144051cf.34.1784299581287;
        Fri, 17 Jul 2026 07:46:21 -0700 (PDT)
X-Received: by 2002:ac8:5d88:0:b0:51b:eb55:2916 with SMTP id d75a77b69052e-5213dba36cemr24143621cf.34.1784299580715;
        Fri, 17 Jul 2026 07:46:20 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52149a3ce4fsm13414801cf.0.2026.07.17.07.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 07:46:20 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Alex Williamson <alex@shazbot.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2 1/6] iommu/qcom: Fix inverted fault report check in qcom_iommu_fault()
Date: Fri, 17 Jul 2026 20:16:03 +0530
Message-ID: <20260717144608.3216274-2-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
References: <20260717144608.3216274-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfX0vAxOnnO4YJ+
 nWFZm5ax6NDXN5CNZur6n9erXrNJJmV5tWJLWQDPuJ0Zj7bmYuYxvy1kjHRlDZ1+czAaFCJL0xB
 8RgoTynQgtO9fOAkKPG0GB+OhgKrmAqf+XlPCT7+xOMZSxPrr2lRIYuXG3lfQibhE0Fee7Y/Qy4
 bW5mjXusqnESWF7Rc2GTni0nRw4zdcKVFjUynmPRxXMcbl0nS3MMSGomf/J4/b7kdC9MZnNYpxc
 RbTVyvVq3wDCCuKA1SYvULQNWe/Wgrd16JZhTnWQOd9JC6KWuVjy0Eumiy26DC6KPBSdWPcqCg8
 Q5KOyV7yRktQR4Hwb47Q1PY/FRpuW4CKOBu1an9v5ZZYwtDsFWHnaz6dMMjFo07kds72rntGvNr
 fnok2xbUeEgpE7zqmZhr1WkbiNykIVn+HY7o/KkfprD+hF3zo085ui/V1rlIgATDtIPe4i/NlD6
 Yp6djEAR6I0rZ1pK1mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE1MCBTYWx0ZWRfXzCZjKNpAUUzm
 06fFa1LOCKIoBPsnGMDHh1Zeh1X2ZEoiJC2jxQP4FUcbVQgHqFv/Qof2Y75OakdUfTXE5qz1v/K
 DoOAJG1ZIxCJZKlxpcBuCNxsYhwZ2oA=
X-Authority-Analysis: v=2.4 cv=DYMnbPtW c=1 sm=1 tr=0 ts=6a5a403e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xmDQi4VeJV1Yj6r8B4kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: DqYIRkIK75-ZmZ6HvFc_H6sERRT6iPaV
X-Proofpoint-ORIG-GUID: DqYIRkIK75-ZmZ6HvFc_H6sERRT6iPaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170150

report_iommu_fault() returns 0 when a fault handler successfully handles
the fault, and -ENOSYS when no handler is installed. The condition
'!report_iommu_fault()' evaluates to true (printing "Unhandled context
fault") precisely when the fault *was* handled, and stays silent when no
handler is present — the opposite of what is intended.

Remove the '!' so the driver logs unhandled faults correctly.

Fixes: 049541e178d5 ("iommu: qcom: wire up fault handler")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 32efef69e72d..09f2ee6be988 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -200,7 +200,7 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
 	fsynr = iommu_readl(ctx, ARM_SMMU_CB_FSYNR0);
 	iova = iommu_readq(ctx, ARM_SMMU_CB_FAR);
 
-	if (!report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
+	if (report_iommu_fault(ctx->domain, ctx->dev, iova, 0)) {
 		dev_err_ratelimited(ctx->dev,
 				    "Unhandled context fault: fsr=0x%x, "
 				    "iova=0x%016llx, fsynr=0x%x, cb=%d\n",
-- 
2.53.0

