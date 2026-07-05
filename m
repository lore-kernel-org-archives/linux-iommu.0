Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2035F193
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239320; cv=none; b=Kdtj0JT6NCmo14ECCTBizkAd4kSCQtkZwAwz0JRgyCd9NXax4uulr4oWC0yoilxOMqfl6WZptW8kdsfNBRD+IB0fxZYdcn349rSVX4efnMs8f+qAw5emodSbQRYQBFJT3wtBrB42QjA0k1qXZQ1M60dHFRfRGWMQYtFuf+ondh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239320; c=relaxed/simple;
	bh=UMZdQAjPrlgpjP/uUPVTHH4TbLaE85kc8y/6rSTbteQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLDtZuih1PCF0BkEw8jA0D/7V7gKEoejDg4H8vNM6zzuQ0YhZwwNBf1Xcb/hxVnKxyV6AdL8roL3ZveA8+pqd6d6L8EmwikPcAnSHGjppGCD42ByLrU2tzQbr6Apj1dJFQ+p0Aa55xS6A7skh8tZ6Gz11Q7y0tTZg9byEl28fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLqsR38d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UWEgFkp5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLqsR38d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UWEgFkp5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6655tlDl896558
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:15:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IpSk/sxlXac8sHwGv3xl9A9ZxePRN+0nqtegrBdDwFI=; b=GLqsR38d3s0O+C3G
	ha/Vk5wbBipwboDBHv0FtJMt7TquCLSezQRxS1rHaQVrLikPi+USFxAIofO8X2Tu
	G33bNA9Fh1OPc+7BmajK7Bq5kQTOIbqwvVkPtnXUBAbj3nZdEzquYpZ15MFSuFqi
	10egRU1BM8d/r9dhlPKw0QPcOiLj98U0vd4w9IMcWg0/7YVCt/0UWC5oSHbu/H/A
	+I0atb2HmOOJQfgM89EunmAdHsdDG2qKX6wybRS63Y0oEQavoHuPJC/3Qx1duOV2
	3Tn9Itr4lXKoPb6rB5cBI81q5a7ZgxcjXcaTXQGwTuzqm33d8vcJ1dmGLYPNp/sZ
	RW3vvw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgtnhf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:15:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc77a6943eso26494465ad.0
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783239318; x=1783844118; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpSk/sxlXac8sHwGv3xl9A9ZxePRN+0nqtegrBdDwFI=;
        b=UWEgFkp5NqKPi2YujpXX1RmNihcgtVIji177rmRg5EuFK25A+FHAUV0lXZIJFwKaKs
         ZYy5J62TlwR1Ku6cy/yRLwHnqzfjJ5Ug8Z3fRboY5Vjpqz2tevVRMSjf/S3EmeVm9czt
         o3keqgBhDxBrIocup/mr6AJVGay3nS3s4H+IyrsNloVFjDupItT6KLbIpADuhhFNME2T
         +dv7+kt3gc9jdO96+vbzqZb9LMbUEx1G6dsLL2nZzuNEGhCx3gG/TJ90a5IJ8MoXdRCN
         hTj1n983EVYYFmP5pynMCOovF8gTENdGPbh11r+QzxVsif2QrstOiJM1xnoz8LZKhF9L
         lTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239318; x=1783844118;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpSk/sxlXac8sHwGv3xl9A9ZxePRN+0nqtegrBdDwFI=;
        b=CZzfutLCER5hvC5D5QrGAOzfGwSik9zBJjbgwhMwkbSWFkyxlsIbYp8paI1rNHDtxq
         6hROtN/+ZEk2e9c3OHvPWzBDvWgGbMqafmBWhlVm6iFJnHcdWV1UONRklZWAXsga+8Vj
         GT1yJTToXZ4aXrdeYfYKtE518uGNqAuAgLiXLrVzGusAlND9UGghPZC69BVnHSw/N/Mv
         lJ25f0VVT/zO4KwgCh2U1U2xz3cmPxM0sK9qvx/+87B7EFBZndU/ZVmf8JmyzUF8xjSz
         L6dShxTT2NVSG7FnRuJFEVUYm+ZO16KniJwQJ7WYtTuV9URGXCeMyQ2gJPAaI3nwRacm
         Dv+g==
X-Forwarded-Encrypted: i=1; AHgh+RoTmrzkXNxZNpYiXaG/vu+ZPgwK/ab2ijVIqZ9gYbX0WSy0+oRjL5GcbaXGra4WyZYiQgVjMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfFBP9uIS5NWXOXARP8GphDUUliJlWOLovuF71Q/+VDng2glE1
	D44WKDTHvKJN5JYHdmD/wdy/GOzDVUahDqpzXS3cS9hZnsmBp1ZhYlLiedEXRHqoxPvdjjJ+xgJ
	6fEMLS8vRF4yE8pWrskS8mOIkPcW84rfyR3ilUCq0TtWNi1SGGuwqQWL78Q==
X-Gm-Gg: AfdE7cl2Vm4Qsfxl4Yz+ysWzouJK8IKA8cKhUg73i6a9wWlcevgc0x7g4XtA8UzRHcG
	pidejySj9uAZd//Ob/z5V1kxfUvwTdpQzdXlmeDeFyG+TQ2RObISC+xJwG4nLyUSQ0c5P5EFXnB
	kmpsNx+OFJFT101xJkRnpCERJxXvPOtiDRgF1Tub/1A19nGLMhzH3FE+OmiNBp7JaQjWczONR1u
	NUtBo9KatY/mTggn1pgm8kSEuPx1ZLrqOcRrR1TFSOW1Oy/z6TClZQ49OYDIsHGQaeV6pxGR496
	R6G2OqaInjmEFrbAr6fBmdm1zY9U340HGfut0oGaiCn63SzxVL1bk9mPhQw3hpoVo06jcsQvt1s
	N5p2HZDhGnh2dPtUkNLYMR99Q5uyOWDgJVpw=
X-Received: by 2002:a17:902:ea0c:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2cb97e432afmr54557885ad.3.1783239318443;
        Sun, 05 Jul 2026 01:15:18 -0700 (PDT)
X-Received: by 2002:a17:902:ea0c:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2cb97e432afmr54557425ad.3.1783239317878;
        Sun, 05 Jul 2026 01:15:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:15:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:20 +0530
Subject: [PATCH 5/8] dt-bindings: display/msm: Document Adreno 722 GPU and
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-5-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=1907;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=SYs6J75vDEjoACg/8a3Xl+R9WIudj3QmUdBCIW4Akd4=;
 b=pgyLEEFK+ZpQAfr6m8Tw3cgMFBAIXB4mjqFjEtA7wyC8js//XGYK0pV9c7S79qGFwGMWPQOEd
 aGXOOqZhfZ2AqPhfgXlTvu/igiit7d6XcfyE5WWNIIiLyd8Zzh1MKgx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4a1297 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=byR7QgRKzgUKQ7cIeKEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: DpJoSlNblWkz0CyC18hP41LstH6JNtfb
X-Proofpoint-GUID: DpJoSlNblWkz0CyC18hP41LstH6JNtfb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX8utznpwGhDEz
 a4NwaEPynn07VTdl2gxC7VRCLZcX5DV77hXWl0WfqK6D0vEpSTJ4Y343BStB1WF1j5iCpHx7uVp
 GhkY6esN2Q/caHO37KFdEsr9JRFQudg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX+uksGem0T/iJ
 ePb09pV6/+ra5rKwpB9Pw9xFiBZWH1HQfcjbH9rI2CSr+BHOoQzyl7Y6T1N4p4mbhvcLbBw0IXZ
 LKe9cZvac8ZH0ZY23eQQJ9EQHczdEx3XjUOp0LwHitVCzZZk4SxaD3HBXfLUH80wIzcroRGoygg
 y23ehuSj1lEMbPHFUNFiqaUpjg7stDIkV+k5W76YAOe68yMpZARJZsOYwAW9bAsUZoq5tdYEmpr
 IzTdipIxj1Mrrj4KqxIDkCQeCrRt8jfl293Pj9oEz5G2NIxu4/QGYrFW1jv6tRWSywekYM+9ecp
 nMh0mIzxfmmBXTafqIjKgUVfUKxj4CgMJTVCe8CDc6wVmhOf0e2a1YVmEgSHyjurEDw2cJFNqxO
 y91858LKkfdaCwscz/8icXaVp3ikvFGg0aGnqFTUAtBwdljultZQfMTbcvybi/domMrOJlHX+Sd
 shhSN7jXum18cXGiLzw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Adreno 722 found in Eliza chipset belongs to the A7x Gen1 family. It is
derived from A730 and shares the same IP-level configurations: HWCG
registers, protected registers, GBIF CX registers and gmu_cgc_mode.
Major differences include lower cache/core counts, 1MB GMEM, no
Concurrent Binning & LPAC support. Some of the peripheral blocks like
RSCC are from A740 that resulted in updates to RSC layout.

Update the dt-binding docs to document this GPU and GMU.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 8578c2f8122e..9e459f12ce3f 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -262,6 +262,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-722.0
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
               - qcom,adreno-gmu-750.1
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index dbbd8b814189..d096632694c9 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -443,6 +443,7 @@ allOf:
               - qcom,adreno-680.1
               - qcom,adreno-690.0
               - qcom,adreno-730.1
+              - qcom,adreno-43020100
               - qcom,adreno-43030c00
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01

-- 
2.54.0

