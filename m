Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899031A7FF
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792837; cv=none; b=UheTw7I10DZgaU8Ter0JwC1atYjg+aL5b7qocT4pMgoAVjlVJkVma2j+n2ZOti3ijZsHWUS8/5g8iiSUF3jQ6rnHhxWw5Wf9+ChMq/R9Ik22BLMh91q1WvLg0FUQFEbtlJUqTG+3CEkeWwzmKkeVA/6lDg57cq/Co8NMNNzDgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792837; c=relaxed/simple;
	bh=G2l2DvQ06Sbowus5yA4dZFnVkOMl0ih94brxKuiwNUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gnfrUGQfXX6crOeS1jPv97oJKPMTNPW92Q/4Hyvw3EGROPrkjsZjayZb+vhDJj5v6WIQEjTytfkXbwzKi8/tPpCzOw+uOwSi9n2OIwcJ9mFc4RxQfknGReaFjaUdMnFlY0mWn/1ZWBLQFXCNwvKD7y38srgs0p9WPpG86nvALKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BkyHWAyJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h8RhFPws; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BkyHWAyJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h8RhFPws"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACGOPh2407319
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tB9D/fdcmRiky3PhS+srVAJo4/Iv4jc0qDMbbq5Kk+Q=; b=BkyHWAyJEbEj1Kf7
	5qUO9kdpU6Q/9UbvpvsTyHJ39ZOeI2MRNpXnJaQUXsm5g9sVIg75ajCTwI3RChyC
	sYOfyBwNRjbFV+GiZo1TNoEuwP0pxYtPZk71L85dTL4NOoVD3eMf2kVsTkcsuoY/
	n+eZijX6DcMj+LmlINZaeDdMPdkFn3NocFqjGldaKuVSBKh5MgUsUU/UPnGS58Cj
	aSHqLKMdDner/Iu+JnY0wkKz6Q9Abb29pE2Sr5uXN0e6f0nQn+7q/M46YxpxBpBE
	0PXXJE86u8oR9CBACBe82+DgM3FM6YdDDx+MTRkL57pui6mYaevlv3g9v9gjctG0
	yLP97g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd9v0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3418ad76063so3776837a91.0
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792835; x=1763397635; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tB9D/fdcmRiky3PhS+srVAJo4/Iv4jc0qDMbbq5Kk+Q=;
        b=h8RhFPws40Ql7mUESjsFfE4Pj+3lp6rnxdj2cioTHnWT1zxXY937FVIT95e8sxMOVw
         6rqRwiNeiziMARmBQKs2wQK4LHY0Wc/evrFWebDnZZiRoopvULYDU/XakVbBr39+42HT
         wNyrNfW0vdF+Iqit51AXi3kWhQn74HSgvn6pLYnLSsoNKpcyQi8jJdHJSRIPk2niYyuo
         584x1979e1mzkE734ItOoCWlnMHAwDM7NGo55vufS8LvtCG1QlIY0avFBBJWisVj9QVL
         foK72WvWUYZs5RfyQ6NUtpN5noPzmesXzVab4EM0qLf8wVA+Y7pxijlSOlPjGCklewh8
         a5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792835; x=1763397635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tB9D/fdcmRiky3PhS+srVAJo4/Iv4jc0qDMbbq5Kk+Q=;
        b=qyfTX6U+U84HXyJKZMh+efFqDM6ntmEfgIvGD5mWmgsq3XOu+hdOnTuYVTYG+FYj33
         fbAxeq39VgRssVdRzNfU4480cgYLyzncwGo0RsEUvaWYA6lIxxjSMIsHh+/LW2PnlBiy
         D95F5OYhxAPgSIfgbvQpRnnF4C0oN7W4I25Y/dIWQbBMP22yixhbWcNqvIqCEuG8g0Dv
         dHcK0RN+7mTepYDDZmOeIp1Ve2XIv+4Yni8m6fmyid9ytlPKxHShWqI9hLDJxi+bRJYp
         yBVEcAqO30/r5K449gTDi7HhJRMzm6Ajf0IMBrrMsw1l1MIwS64OmdAXsobNdTBs1lP7
         5E9w==
X-Forwarded-Encrypted: i=1; AJvYcCXl2D2QSIMzrBSIPmf6nWyrIypXkK+1omumdhoaYM3A9ccDGOSMx7Z9/sBtZNpa1ofSdLmbHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVDwHNZ7YzMtFl2jUmTiowyHbwsLpEwHl7M6RJLvmr5/vxFjg1
	BcSqoN5PgoYJdi7Xk76h68RqUwthXMZHJuQwwsK+vzoWWEpMUAVHMaopRaMyoSUTxkeIyEoMg5B
	szPcyPLTpoYWwTkWhWJMc9IXZqhPFglbxxFi81/FnfJjKB/0fWPhFqQqjRA==
X-Gm-Gg: ASbGncsFJ1H7EMr0NSvOC63a9OzB8vnSHZRmq9eKuBBT0HeXGtunKXnPOcIpIudgnza
	iHzqh44fth7DSxvC3yP2xlH/LdXxQ9WlTWn1OPDM6GT/SyLH45DSpTNsKDimmP6DZ0NtovC0gge
	swrfg0QFt0mtbS13K5GbZ2ynfrR6m5nAqEeZEIa9sWZsolaypASWi68fRbqwUIne4Ac+uY9yCCX
	/L6bdcU08+SPNaOwwypAA4hGwj7+Z4VcoPQYleoy1jO51wXKPvbzl/bO8VzWVTHiFnUmCku1MZI
	li6Lxh4yDVkTm+LmfMJQ/xO/vbR3IrAoq3Nh9WqJ1Q7K76BMOgwBbWdRTfJh0yysxpSmnn60F0K
	QBzRLz+qfkEV+EjfJoHNjRBs=
X-Received: by 2002:a17:90a:7786:b0:343:87b1:27a with SMTP id 98e67ed59e1d1-34387b10381mr5172083a91.10.1762792835077;
        Mon, 10 Nov 2025 08:40:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWFnJwABxwEcbzLA4NNn8jcaHApPxbRaToXFtfQE+N3nOzqp3Zff9UTtgGElCKztEpfLbq5A==
X-Received: by 2002:a17:90a:7786:b0:343:87b1:27a with SMTP id 98e67ed59e1d1-34387b10381mr5172042a91.10.1762792834452;
        Mon, 10 Nov 2025 08:40:34 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:34 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:24 +0530
Subject: [PATCH v2 18/21] dt-bindings: arm-smmu: Add Kaanapali GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-18-bef18acd5e94@oss.qualcomm.com>
References: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
In-Reply-To: <20251110-kaana-gpu-support-v2-0-bef18acd5e94@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Connor Abbott <cwabbott0@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=916;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=G2l2DvQ06Sbowus5yA4dZFnVkOMl0ih94brxKuiwNUI=;
 b=i58PaWIJhvP983kaIcMBq4mEfOd2Dd/WK27M8EkgEPM8e2wRt8CP0MDcNjfuquTO36mYLtIal
 +hsVHf9IYi5DvmUiLKDu5icK9arFAWOyRczHm6SeqUfsEgpnR1BfIU8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 5Hhog6B7vPBvDGzp2zO4DTiPo112o8dQ
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=69121583 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mFHhPm7ftKKhVARBLukA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 5Hhog6B7vPBvDGzp2zO4DTiPo112o8dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfXx5lnQIrWfwss
 RWw4fsF5urw1WioZNLX2ClcVA2bcMsoex8Jm4pg4jpNEGruW4WrxVYS1XmsGg31Z3elgbR2g3te
 EIhOyx0TD3xYWqZacdS/Kx6g2bS+zeI7pYsKGrLETwbf0VrT0wQhZsC2x5H28oa0vssJyTkLmYJ
 Z4q8+zbEKpe/cEAgAgXtlvWYOo2R4SFAXyVJ0CXbzejP8AeK8xXxup+VDkQCit9VLF8EUNMTU/X
 nRR6ljFvW00XBM8ePk3zwtdD0WTmXGguSuy7S5Xeg0cIL6HVlNOjhqVJo4mLRq9rDLZZFMSXlkB
 cc3MfV+qT3aPNQNEHbZKH1QK9pPSrGXu4a7xGWaF2hLtOCAwowOaqgPCJ623xX9/FlYS/KI+xT4
 wM3HY3J3HW3EbrtXGaqDs9dIGx6/nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Update the devicetree bindings to support the gpu smmu present in
the Kaanapali chipset.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 59bbd20992c9..14a9624e3819 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -91,6 +91,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

-- 
2.51.0

