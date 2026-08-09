Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6683C3D669B
	for <iommu@lists.linux.dev>; Sun,  9 Aug 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306553; cv=none; b=lIEEGiBEEQIzL/RZN4+QjsopFCkFD1gPURpyGafhuSHHzGiBYsShF5dbtNK26P5nVgDUJg5GMxUshusfzPg4zCXYAKus3nMZTm+YoHpMLE9jIaqayQ0ZQIKSfqkK8CdqX66U93/0941r3YQx5uztOHulBrvKqNIA58iFXQuvjlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306553; c=relaxed/simple;
	bh=uCse0G4tqb7yw8phAOieTW4riZX8EVQqZbUSnb6rt0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgS+LdrO31RQ9gGqnB/ESnH2y/baRjab/6oZMowxpLFIdzOPrRofRGMjUbtwQWfSU6hKiTfPzgWFl2F+LzKhyftjo+pi0ocEEz/z8nISc6zKXfMop2ZjNHeHseoJjzF4VhWwufOs8gQ3VWYalql9ZjWDIfjAo18anLOk/HO7NdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MsDTcNBN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HpExgrxK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MsDTcNBN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HpExgrxK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679I9UfQ3747782
	for <iommu@lists.linux.dev>; Sun, 9 Aug 2026 20:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IzizJPNPjNfA/xYYjcXya67+pr2fJ/V/trczrmnBD7I=; b=MsDTcNBN6T7lOxBB
	BCgqY4hefdTCOGraIJtlKPG/VMQ7Jo9Wl114R0ow5VMx95SnAwqMKVKifPXbX3O2
	3opRGPQD+67ITCZTN1agBaiXIdRowd5MafuHcX/fkZHALM6F4byYMyhbaPd7iBQe
	ckqWyhArELAfJVQdUK/V50zHJcv+ctGx4UwpRgbwDvwTD/H8SlgHdezt3/4UO9ZE
	9eZHQTI0kt4Km70aMTyJysccdL10M2LiIkeIZ8J50RHoKcUprogYC5rnUAndZzO0
	Ez6TpHk9Wacbj+3rXM95mVzk7wR5GaI+XtzaXV2OT32lCo9GWING5HbIh/KkDuwv
	ITT24g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf7bjef-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 20:15:51 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e934385db1so13964186d6.0
        for <iommu@lists.linux.dev>; Sun, 09 Aug 2026 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786306551; x=1786911351; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IzizJPNPjNfA/xYYjcXya67+pr2fJ/V/trczrmnBD7I=;
        b=HpExgrxKv0aYHgLB5Rztyb4TnYa6UIUMpk3O8pJF3F23LaxW8R+iTUs9IQA/T0JRKd
         Q62wFYjTofimVMJ283HYTrCjxopXpSpMLkSYm5bVgqE7dRrHi+O+wnCFAGOt9ngNzM+O
         mTyawhFuObfT9wS8UhclUxmZluuYvYkHyyH7J9mz7JM3BOkLgNt68pdrM8YcZW0FpAHf
         L1fgCsSpfvFzd9mvhRxHlsPkj6uAfJDcrBbuKQg/3vDhAwafllO7TzIAW+jockNwzhg0
         VC0QPqNU3ZG3E2/Vu/Peg3mM4z4BgNHGhXs4sPU01jiX8YxEmSwUQgBE+Agwsp+XffGx
         Lu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306551; x=1786911351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IzizJPNPjNfA/xYYjcXya67+pr2fJ/V/trczrmnBD7I=;
        b=WcpOZ4KZTrKOr0sUBLa0JHdHGLyIXfmk9RJN+bTpCg4K3W7mh9NkTvU04fqMG2g/ZO
         a+9dCsR3oJBAJeOUF3Lo+ZCurxAekyC+bl/vOoT162kDnOXvbDtmpxda5f0TGtyAIX4k
         Hdx+F3kjrJb6kgAVnE4adbsNE0w9aPxdC5wtSoN+0/941z4EhObw67QvoOvNt1Qd7VRT
         dObvsbiwOtYHrHAcsCs+f+y4wte6idyI5wgCCMngafPE3Kcbb/PKibmQ+GP993DT4xiw
         MqF7ZnoENIyekYEzrLNpl9UZXpkgU2dFID8++7gfDVCEqT2QGpS4HhYsHa4c17w3mi6W
         F4wQ==
X-Forwarded-Encrypted: i=1; AHgh+RqbcZ6H7oFv3M5ReF68PMRMVvbL3hqET5EG4jJdvs4hmULdBjwRGREh548V+uklBNfNez8VAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzodupvvZT26/Dzz1aPayIPkxLyDUNehraNWo89IjXPHNIiI8a9
	ruVyEkx/ed1J1+yQewHrapS0UOKX+yOR0qmGT5G2TZ/flSRJL4dgCGU/DQGrMctzBEi6OO57UDK
	psFWC5qxsn9jBvd3TjKGV6Tk3S75gJvnRC4iC4raemlpXObxC/t66ZZuNrA==
X-Gm-Gg: AR+sD12Bg2HuF26IR9luWtCGMt3bwiv8X7Ny2eiChQBb8M+WtnK1Z1UnlvZTbIvah/y
	lK91KQJ6ULmhnR4fAMijCUMq7RCUFJCUw0XjgTO/2osqETe1f184M8gmx3FwhqRO8BBnGN1UYJc
	2gnbXt1lA9gJePKH62d9Qz5bgaupkeyqhHj+URv711oRPHNE5EJI9n9dxLlY35NtxgXKbV95sPm
	Jnmmc4mOarCjK5k8o4F36HlEf+FSM+K2z1L7kGUeinNNjnf2CCUlc7hKADt0jrhLH1abznOPsmv
	I6eIg6/9I3tydPZ9uoCa8XZSaOFMI2zRIua/aTd2Hfw3NKGcg3nzFb+nesSXp9BvddozQdHrGaA
	yuUkBV+oU4Ppkm4TE4rzFD358WxhS91+/w6SjWYdpyh+KTfD47TzvUNDlhoJQZpN2V198UIrbrO
	kF2iM/rm0BpZS3zQ==
X-Received: by 2002:a05:622a:4111:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52ce60d5ea6mr468766041cf.26.1786306550767;
        Sun, 09 Aug 2026 13:15:50 -0700 (PDT)
X-Received: by 2002:a05:622a:4111:b0:51c:92a0:b2cb with SMTP id d75a77b69052e-52ce60d5ea6mr468765701cf.26.1786306550409;
        Sun, 09 Aug 2026 13:15:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3055f3cfasm1589259e87.70.2026.08.09.13.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:15:49 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 23:15:41 +0300
Subject: [PATCH 02/12] iommu: arm-smmu: add global register definitions
 used by the QSMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-msm8974-iommu-upstream-v1-2-87f5cd492560@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2421;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uCse0G4tqb7yw8phAOieTW4riZX8EVQqZbUSnb6rt0Q=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeN/uOm5F41+fJk5lrC5TdNjqzxoqf3PLotfHc
 NBoDIXGCTeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCanjf7gAKCRCLPIo+Aiko
 1U4mB/9BkjLJ40OyMG0IH/Bav2udI9uSTLa2z5CQ/s6byYnQqqpJfmkKGapWsPPmTZOYi4xrwGE
 DH7SOwF7QybdC2czzYlfv9q4aganYXnX0yG7rheDfvDHXP2eIoiyBg1VD7u9g8vrfLZoHRUmOEr
 SzeGge2XA+1dWruNDf2P4NIJ6TRvGw51wd/ye6Pn7hkCfufp6Yz0ZFLDIwZcR4ERlH2n2x+UJJ2
 c/rBjygOzs29eHDg/ObTIX61fGFqAGCtuszCLfW8uy7JOtxjiraSvNL5Q2U+OtwmX9sqO7jSP8T
 wpNDypbpwympWONEQZOkL84Duewl2GrWQFXKPVK8VB1ZArWJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfX3nV7IxZr/Yv9
 48ezEGK5ThM0PesRLWQV2QlDdhEqk3XkFDiRpScrbL3kr7PDvuhPucLch3FSUsr9KybBkCPeW9I
 ycjytn2lV62sw5Pa0IRaAuOfFXU4zBs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MyBTYWx0ZWRfXxjgskumxYptR
 m890sDmCLo9e43+JQ29h6q5bxe4EN0uOjltn4In6Je3nm0JdPQjEsx5/JpGtxVMrhaXeWTWmRxX
 wN4gl1riXXOMluerT68GGBb8TmlgFwSRJE3dtH3pZOf6MWGWedsxtvQFq9KgcH9oMXPzMSQBpSB
 UqTjL//GwsYl4wvrpbgxox3zZI9BIkTvmhVLHBr2Y3OHsRdmLNFl+2blOIzFyCSw/KOVVyQNRlf
 VpbHcn9GIbw6mr7qkFoqoswJdGKVkcUeqrSZMFVG4hCDzZa38uQ9neF6kIYlfdsarUk62GCxetr
 eT2zfYw9XVLqi0jh5x7R0CI5BS9sXreiXjL8Ngivtjmh/52fVNkGWQqVOlIicx3CiT4Q/qHRU5C
 DkyBlViD5e3Ud5uuKcDOtu2ODyLe9fV0f1LDgFar1290Iew2OnW6+zH1+MeP6z8htZsLpbC6AyV
 D6hXHfOgEfhSBSkVwpw==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a78dff7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=M2U4UlAmMl8uHlp6m3MA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: S5i2gyIthUeiUatJh7h7iHmfdkP-nKh7
X-Proofpoint-GUID: S5i2gyIthUeiUatJh7h7iHmfdkP-nKh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_06,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090183

The MSM8974 QSMMU support about to be added to qcom_iommu has to
program the SMMU global register space itself, and several of the
architectural registers and fields it needs are missing from
arm-smmu.h: the secure configuration and fault registers sCR2, sGFAR
and sGFSRRESTORE, the sCR0 SMCFCFG and STALLD fields and the S2CR
NSCFG and MEMATTR fields.

Add them, sorted by their register offset and bit positions.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
index 26d2e33cd328..49424d8aca6b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
@@ -26,11 +26,13 @@
 /* Configuration registers */
 #define ARM_SMMU_GR0_sCR0		0x0
 #define ARM_SMMU_sCR0_VMID16EN		BIT(31)
+#define ARM_SMMU_sCR0_SMCFCFG		BIT(21)
 #define ARM_SMMU_sCR0_BSU		GENMASK(15, 14)
 #define ARM_SMMU_sCR0_FB		BIT(13)
 #define ARM_SMMU_sCR0_PTM		BIT(12)
 #define ARM_SMMU_sCR0_VMIDPNE		BIT(11)
 #define ARM_SMMU_sCR0_USFCFG		BIT(10)
+#define ARM_SMMU_sCR0_STALLD		BIT(8)
 #define ARM_SMMU_sCR0_GCFGFIE		BIT(5)
 #define ARM_SMMU_sCR0_GCFGFRE		BIT(4)
 #define ARM_SMMU_sCR0_EXIDENABLE	BIT(3)
@@ -38,6 +40,8 @@
 #define ARM_SMMU_sCR0_GFRE		BIT(1)
 #define ARM_SMMU_sCR0_CLIENTPD		BIT(0)
 
+#define ARM_SMMU_GR0_sCR2		0x8
+
 /* Auxiliary Configuration register */
 #define ARM_SMMU_GR0_sACR		0x10
 
@@ -80,9 +84,13 @@
 #define ARM_SMMU_ID7_MAJOR		GENMASK(7, 4)
 #define ARM_SMMU_ID7_MINOR		GENMASK(3, 0)
 
+#define ARM_SMMU_GR0_sGFAR		0x40
+
 #define ARM_SMMU_GR0_sGFSR		0x48
 #define ARM_SMMU_sGFSR_USF		BIT(1)
 
+#define ARM_SMMU_GR0_sGFSRRESTORE	0x4c
+
 #define ARM_SMMU_GR0_sGFSYNR0		0x50
 #define ARM_SMMU_GR0_sGFSYNR1		0x54
 #define ARM_SMMU_GR0_sGFSYNR2		0x58
@@ -110,12 +118,14 @@ enum arm_smmu_s2cr_privcfg {
 	S2CR_PRIVCFG_UNPRIV,
 	S2CR_PRIVCFG_PRIV,
 };
+#define ARM_SMMU_S2CR_NSCFG		GENMASK(19, 18)
 #define ARM_SMMU_S2CR_TYPE		GENMASK(17, 16)
 enum arm_smmu_s2cr_type {
 	S2CR_TYPE_TRANS,
 	S2CR_TYPE_BYPASS,
 	S2CR_TYPE_FAULT,
 };
+#define ARM_SMMU_S2CR_MEMATTR		GENMASK(15, 12)
 #define ARM_SMMU_S2CR_EXIDVALID		BIT(10)
 #define ARM_SMMU_S2CR_CBNDX		GENMASK(7, 0)
 

-- 
2.47.3

