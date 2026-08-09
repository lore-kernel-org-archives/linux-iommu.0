Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88583D955B
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306573; cv=none; b=D+rk1IsYoL8LCJ0iugmhxj0cbMwQlgmR8Q+/FtJlOEc/DnSMGq9gcd4Nvz7O0xpfzuKrEOnnjN6XXi8Rsrbmfls5HENFa8CLhSywh6vEpGU/twuQ9pj3fU1Eabj4pLMVTuJovTnKolgzddHTsMnw+Xme4WbjuVaqwAWaGmmnDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306573; c=relaxed/simple;
	bh=08DI3m/g8w//LYUe10gsP5FMXIEvOf1ZW68iQjd9XpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1BiHNZih1AKTwbE3Vy6skTiYbHgBn6C9Qyogg7l+uKpaFWivwLda7B1OfLp2f+eAUmQgyu3WS4z5PFTz+i4AxhooaiqLSK12PzUofY2eyFpO5GU2HNRzvxRyNfpkmIWqRHWwx3d1TfdgHaKeBrTd7EILog7LX5ySAKJLMJoAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VCYWknPt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hg+X07AL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VCYWknPt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hg+X07AL"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679Jb1mW3925136
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+hV7mbrZwx44RLk9dFycUl+f8Z+IiQ1Td63pdUanc1o=; b=VCYWknPtT+DHTuIY
	tVzaDErKqAENEmh53NdE/F6yPa9Iqqm5VFirSBYIGvRK8vIs3F3NfUyyVYvvFxe2
	RM7MAUGCrDr3M2lUOYnddzIcxBttrW+m3XswltoqI1vIBsmxFRbnm9EpvcLOpC3R
	ZBHVxkGzX07GuWc8pg+tfcGuKiqEXqJe7ccprmM8/TSo9cmFZifhv4bhzpYbqmX3
	WUuX+rLkbW4C8bAgq1XdnESY/tkOe07HZOAawNNkFKApgTbZLAQao4EfQxZocwM5
	lDtfbXLSCeoo4UfJFPjvoM4YbF3j2SE/7OuzHdGdUSidGvZxbJdci/Jqwn+gZKxs
	P55U0w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bjfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:16:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d33c89a29so9348221cf.1
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306570; x=1786911370; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+hV7mbrZwx44RLk9dFycUl+f8Z+IiQ1Td63pdUanc1o=;
        b=hg+X07ALdZDYVq2mOTEgevg5dkpMy+yLLLyv3ibPVQWyenntVn5f13ps0/VaLBDoo0
         ZIJJAjovdjQOwaeCqxambdHnSIIzhhAaBSwAxn2UhcydQNCG8DJZa6Q7vr/VYsWJwulk
         hlZJZSFnAbkYYS3hTGazHbyyN3zPWBoLaWuGjxI3AqU5kK+Eyc4AnPAhXO1haFaL9lHB
         TZiDgoc9LAFkMONaqKL7/KOY3Jk18q+D6W+owaLE7w4Ews1POmvNRhFcT5EpH0XBKEHN
         EDQ1JtFzG80JHPdgyGCwN+iGi2EEMxwfNOXN7WSJW8nQ/9E/TxvwV+fwEgKlpDBH2RAU
         nA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306570; x=1786911370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hV7mbrZwx44RLk9dFycUl+f8Z+IiQ1Td63pdUanc1o=;
        b=aK0mAGTmrraFjpc6QkuiB8FobrFWSwwvjoqOPTYbIFDo+VQisacpNN1mwyNRzQxE4W
         akNVVdIgn/qbY5Sw0r/CzISuXgjR0fiPMqe0WnU2MV1+hboaAly6jM1NG/XeROP4ac0o
         lOCs5aUBJV8LIX7Zxa7y8oUT3QH02rBQzpBYHzXrCCx65KXj4M4Z033XkkjhVuXzfeBJ
         4XPjkPRmUnVMQvaKcFsSfn3oXXrMv2ljdnYurI7QgF3Gp/5XaAUXVQy7W1SygHjjjDu9
         QZCYTGpPzDbBtzYQ4w9qEYXTj613wm5t59zPqR5/4WTQkxUJy3CM9TrZnZCYWi6fwYIW
         C59w==
X-Forwarded-Encrypted: i=1; AHgh+RqwP5tIvX6LEUtDWqeiV2hHmgVWIpUFR4KZLugIY+8VpAeqmW5fOdmaWlEwhmq3BJrScy6sWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq6kOKuIpPl+d+g2O5eLm7MSVCcyMMAfUp/XdBom1/FMuXvl9R
	3bKP4zc+TwZcYu/YEENmXB3EySjI43jcKhuVPbeLvGbs/ya6d/I7jEVq1WidKMqatMD/XP/Yr7j
	jit8vy+YqrvJ1Fml56pLB8nxQhRT81AY+SdeMz0Yx8vAVOEESp70R1zHx9Q==
X-Gm-Gg: AR+sD12MBxi1JzLVptCmK7f3rM+fcu4FSIIXzcGqWIhmpX2eWefvNJyMSlWcxE/wHHX
	ymQp2p/fJPrkfaj40UDHjat20JyohgY4y7I96F1Y1k7aVofhYJ68412YRmQr1T1sdocHOCjxsKy
	5d5TuhxgH5qoujzY3249HjGhdpBlk8llPapxSfxBNmShk4VFRKpiBc5QebSBZVABbBoAgcdh7mT
	5WjhzZK515xnio110kpQV1FKUGk2/XreG78GoIr8qwhRzx+5IMowFyJUoUk4KMmiCQZCyqthjBQ
	ehaW2KiaLSUw+qxXVb28z8JyuR6Oe+diInyvypiOhbYV8Cws7C2oBCVDAQWry2ZlpxPwT8szPlf
	HbiQZR+JGbvQVoxjtzSstSN66wIjBfQa6eSmaqqPlu3x0X5e86TFr2CLHbYoZYHgiyRVCw3q7B/
	KxAskqSzykSWO28w==
X-Received: by 2002:ad4:596d:0:b0:8ca:268b:13b2 with SMTP id 6a1803df08f44-908813c80aamr450316906d6.32.1786306570133;
        Sun, 09 Aug 2026 13:16:10 -0700 (PDT)
X-Received: by 2002:ad4:596d:0:b0:8ca:268b:13b2 with SMTP id 6a1803df08f44-908813c80aamr450316366d6.32.1786306569637;
        Sun, 09 Aug 2026 13:16:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:16:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:48 +0300
Subject: [PATCH 09/12] iommu: qcom_iommu: allow faulting transactions to
 terminate
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-9-87f5cd492560@oss.qualcomm.com>
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
In-Reply-To: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=08DI3m/g8w//LYUe10gsP5FMXIEvOf1ZW68iQjd9XpE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/vhrwXuGhQLdAzY/l2GN/Bhk6G4tkUR0rGB
 /KpHmvM3nqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7wAKCRCLPIo+Aiko
 1fwRB/9hb9z5gxrrc2rcIX+BFjYiB6RwxCiQoXWl76sM26ATHSTCxaQbuXacXM28jJeLWK9Jd6R
 XDfVZ7yWijF4iAIGOC9vZfvp7ilfem4OWuFalZguh2DSShcqwIaeuf4y45ckh7mbxq/KnGt8LvT
 8vz5KhQ7Er6Cl+yFvH4Dp3nQd+WtIjBM6frxM0UNsvnlobUVUjT8hdzTHCPXuB2Jh175Lho6LjB
 LkMTR3AgAo8SNvuEfN8hjQrt9UEb1sCxl6SBoa3zXaaiE2f4oZiQhiEad3O7XGdZEg7SphvYjfM
 uOvwfPPgZBGXz97OhCyhT1AJs0T70xm6aM2/RcJEouk3hfwB
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX0KuenWMmu0lE
 X7Ro+CIkc9RgKSBjTFyWM/M8794qa8ppj6KZ4sIHcDgXvAaPhsft4sCstsIHiiiufSYY0ESVisJ
 wlU6nvxuLjYSa7HDi30oY6A+UtUU8t4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX4FVRyrzwBB3x
 tXTwUgUyTquSjjCssntwwAnsyadNk/outP4jVYbzMdlrjQfQPiB8Ur9jVQeTkByLDpivhcb7hGO
 3wPxkb86fO3JBxOuEL7NPM5uAsjWoaq2dBYhD2FrQqOb3B59zgyg0HCWim0KJBuAcflxQWqqsAT
 okukAB3ASFNcywRXJ4P7NbbXxjMU4XQiF90B0BGtMb74xkey//Vb+Yu2RVsAm8LlfciQZJSzHtC
 4MSYlZTLOxFJUdOSGzZDiqH1PklGDyFM78FezbKxgy7MgynWHRc7Bu+zJaTPxDqMzEp7iVr5iik
 9lW9lBMwvVsqR9DQC8W9M+bnw57cQ7T5lYdHNQF3jWo92TjVX1lRxyj/Q+S2oN1wasuwcLkVqN+
 RqW7C5XwOprXLBOmgYjiSa70jr/A/avjhqrglHbM8CaJLXpgyQFasF1c8i8hx9BAVC0KzFDd9pj
 pgohiwhjllWvOWP9WoQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a78e00a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=9MEWnGasQQH83fMYMBYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 2-I3jh_TMA4DNjLm553XU1NilRczYJIR
X-Proofpoint-GUID: 2-I3jh_TMA4DNjLm553XU1NilRczYJIR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

Context banks are programmed with SCTLR.CFCFG, which selects the stall
model: rather than terminating, a faulting transaction is held pending a
write to CB_RESUME. Held transactions stop the micro-MMU draining, and
anything that waits for the front-end to quiesce - the halt handshake, and
TLBSYNC - waits on exactly that.

Not every instance wants the stall model, and some cannot tolerate it.
Add a per-instance no_stall flag that clears CFCFG so faults terminate
instead. CFRE and CFIE are untouched, so faults are still reported
through the existing interrupt handler; only the stall goes away, and
with it the handler's RESUME write becomes a formality.

No instance sets the flag yet.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index f27f8722ee64..2b2cf665c39d 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -76,6 +76,8 @@ struct qcom_iommu_cfg {
 	bool				 ctx_restore;
 	/* the micro-MMU must be halted while its registers are programmed */
 	bool				 halt;
+	/* faulting transactions must terminate rather than stall */
+	bool				 no_stall;
 	const struct qcom_iommu_sid	*sids;	/* one SMR slot per entry */
 	unsigned int			 num_sids;
 };
@@ -500,6 +502,9 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
 		if (qcom_iommu->cfg && qcom_iommu->cfg->no_afe)
 			reg &= ~ARM_SMMU_SCTLR_AFE;
 
+		if (qcom_iommu->cfg && qcom_iommu->cfg->no_stall)
+			reg &= ~ARM_SMMU_SCTLR_CFCFG;
+
 		ctx->sctlr = reg;
 
 		qcom_iommu_program_ctx(qcom_iommu, ctx);

-- 
2.47.3

