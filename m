Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FA633031C
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792861; cv=none; b=m9Ucmejy0JqzVrdfujY6epJBuQPLS5Z6qD7FEnf57yeGZ4v0aW/mRem1pmQEpLZ5O3yolwaZ8y3rdFDjWIu/P3uqtARNTRipMXSw7t4QVcdtoqxz1e2NpfG/jHj7bpyBnQEtRN8tTa+HkFkRVNAHZvj0cf2uLdrONqPln+PfoYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792861; c=relaxed/simple;
	bh=NgXP4H+ytjNcrx+o8ALLRhAZOLvOHraz88+cU8xEoFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rhDAsKAGWNIXeF/Ts0fUoePVXKMzg8H5Ky5Oc7LL6Ue5TVdmsn0rXxyXA/gVTmy5oP2PX+uQG7NY/mB5RUJnEkpj/cFS+OYUn28UKIUVHBzdWSK2WNndOJIY20fvirJoOs+crO5rLprtix7iELkk2c60M3urR4UD1Ad0fB4Ez54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FgXgnG+V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Id+WfTkw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FgXgnG+V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Id+WfTkw"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACgeXP2407943
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EKz5Fgcl8FFI+imxbIKOoJpuYhVpSnaRPpvrLUXLF5M=; b=FgXgnG+VzrNfD9Uu
	xxzWXTo+ysFP0KjKvm6Xc6apvKNGStrOzzMefelUuFcVtLxfr9PvT2dWIMPgxqaQ
	U4WcLBlhpmt68iEvng1m3nv7vfD4oz5HDLg9+cpyQATHFvM0ajH2IO8+pwYiBU8x
	shlQcv95904PwuvG5m441HI0euahNHLueZfwxhCgqrQF419Z4gS44D+GqEJ/kTNQ
	5ytx/8zFy3+4p+u/DseLySE5IHJuWqivxKA5QZFSEAD1WzDwBCshHpkd635YbuV1
	XW0a8phzd6Qtmims2BEq0F08BhNRXIY4f1kznhbGaHXewKtIcl32Rcm7sD6cASrW
	+qu/4Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd9v2d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 16:40:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34385d7c4a7so1499292a91.0
        for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762792859; x=1763397659; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKz5Fgcl8FFI+imxbIKOoJpuYhVpSnaRPpvrLUXLF5M=;
        b=Id+WfTkwTxwJqenQewOE1lLV7xomJpHWZQtzuoRum605OpydU/xnvl0YGYoDIanTmE
         u/Yj3ELMx5InYLCeeyEyQvt200iXM4REiKWlsRfRPN2RFt50thVykB76u/1dw9WOkh7V
         2akPogB+ZG5Ij3/vM7VV8W74M5pUf+jAsBensfZwiFBaDm4iKiqCNZQZIDUpLeEq/gSN
         +R8yxx0vQEqp/0Su6pDiDiQV4TSpuEKEVx67VUa4eAd0KXK+L8Wi5DrcHdZJFaXcn9ia
         8CgSMkN7DYaWm8NoX0/Q4IB1lb1VVj8gCROhVj/nUuJr7sS+9azHMC69MXR1+RenEbYF
         xDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762792859; x=1763397659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EKz5Fgcl8FFI+imxbIKOoJpuYhVpSnaRPpvrLUXLF5M=;
        b=gnjID7CfJ8eMMarpm3MX+GBkTi84JQdNvdhaGnpb4wrLHZfDh80lpVtrik+g+PlV8v
         o7ABny20URa60AuoC7GxSWs7ZUxcAWi7zJEuAysbjbdQk0m7mQdIS+lu0CBJyEQGr8sC
         GOzcUcFbnOG92cvjqcVs/BW5uQW50jlxObop0gHsEVTsWdVUFk6Ra9ARRvdbE8POvbQA
         /mb5a/S2VkUtyF9O+SB+Wqy9i0XaxmYdRrDhhL0DnrrQQ6qFCWsSpDbxC4/CFtFJFcuN
         HKcAwbGyeFKe3BI/YT+xj9wPlIJFOZLyZxsUYQtIwBeCYK/xB335+yNBt3hUYTlQ1gdx
         inkg==
X-Forwarded-Encrypted: i=1; AJvYcCWFpraRzV41yguHi8+RiGIQB6Y9cXf0DggUkZlaUYt2gCWEWOKiw3xefw8GuiDfdAUieQQy5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywfk3onZSZ8qjMnt1/OsOro6LJkR58p05CYrKLDWF+/DFFL/WB4
	WPlsp5X/FXewDooLrcAIqOrrwzsHGJ+I1PjqUTULgAOGEqB5DvH3wIcd0baPXYnk/lJKY3t4KH4
	KDcKyupgQ97uyaFCL7N75SJpFFRA9q2Tibv9bUUQiMsFg0u+e10NGxrOP/g==
X-Gm-Gg: ASbGnctstxjv2NHUP4Dtl5Zt2hA1UWhN+1heKq2ET0LhDd10HwSMMcy25pA5uxRmJVO
	g+TFCUM8XTApQ5agwHNqAE+pPU3PO11UweRGk5cwXTTTRI28kNYybcTRORWAXQ0pBwNeJJmVSzm
	DMvn7y+lF8ge2BtoXY/nddDkpxoRAS8tJbVfqyTrdk1nXzTi+tjX/rXC5tSBjC9ve07lioToaUD
	12ti0iaCtHtz5vs17hncPQyvM/LoD8z/8eG+f7Df4vPerHXCBHyIRNtU7zFKKL5HNkN5GvZnmL0
	cStP9/4WqRCzNsmqtDkm6+QIblHL8s0upE0cTCCzYzJ+9lnULy7Lfk7DDnruBbbzKGzlkZxe+Tn
	uPKRuUJPjQBt8DZDKu+vnF9w=
X-Received: by 2002:a17:90b:584f:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-343bf0dd563mr21192a91.5.1762792858803;
        Mon, 10 Nov 2025 08:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsAhzrL6dTTOmOA8ktM0ipxOyHiZ+nRx48w6MNOFL+Ma4SpEDRNwXEivWpIkv/T67KRQIZmQ==
X-Received: by 2002:a17:90b:584f:b0:32e:23c9:6f41 with SMTP id 98e67ed59e1d1-343bf0dd563mr21137a91.5.1762792858269;
        Mon, 10 Nov 2025 08:40:58 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3434c337b20sm11468922a91.13.2025.11.10.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:40:57 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 22:07:27 +0530
Subject: [PATCH v2 21/21] dt-bindings: arm-smmu: Add Glymur GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-kaana-gpu-support-v2-21-bef18acd5e94@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762792679; l=866;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=NgXP4H+ytjNcrx+o8ALLRhAZOLvOHraz88+cU8xEoFc=;
 b=P3JYEELDaQNqYHCNPT773ZPurLRY8irSH7D1ka8EbWy70v55a6s41XQrylNdFsIAiMGUQAHcM
 5oLMZZUY5xHBkdCRkIlYhXjOp0JiK+QgZQn+OMA4B0khnaxj4bei+c3
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: sAFcyXUkDfPseCu8xHpG_3tEHfSVnxTQ
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6912159b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-Mh53b5kj-Vf1dIxLVYA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: sAFcyXUkDfPseCu8xHpG_3tEHfSVnxTQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0MCBTYWx0ZWRfX16LKweifXX3z
 A+RZL56HatwZBAlOXjPTcDyZxJ5KSUZ5qeNDs04SUBP55+CaGk0N8KFrOXGEfGxiSQ6OaJSL+c1
 XSU8jAobaWlFgfbjvek0ejxPIQ0YhpYcpA7NvHU1YYSQ4FvzISrDI1K+CsEcEd2Gqt6ZjSWPvV/
 BQgNpNV27ZXw/ZbNrP7IwDklv9C8BE4TPCg2BpYHwtrVUU4EjavWRYqU9ip5TC3G9pyHTG0Jice
 Ic/Gct1WDCUfbR6hF3rwN09RYr39RyB5so7hvUKZDNQWr07glXTbBfTqgBpbTMArjSm6N1PTuj+
 R6JCYT7NT3UeLom3JGU4z9RBn+CqYzyW0lliQfBRYyYlRaAFN1S6l6/nL8IvSYDzsUsDbxKHvJ+
 xplOiaekzRfOrGLhNUSymyoPIW+MnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100140

Update the devicetree bindings to support the gpu smmu present in
the Glymur chipset.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 14a9624e3819..cdbd23b5c08c 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -91,6 +91,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500

-- 
2.51.0

