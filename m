Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5E26B953
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962614; cv=none; b=RX16jm9Y1pIAuppnn6HWE4HkqiVkqQxj6xENhEXYP8xZQ+p0XyAxByW/sf4YLxh73CpGCOoPoXPbQ4nMFoHEKwhtvadpugehWHWP6nVmrBJO1uuR8XidvZKA10uj35Szk5M8iz/GhxaB+LsSKNS7qryGKA30NrSAM1ZGFFvSWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962614; c=relaxed/simple;
	bh=Y9uutO6VV3TG77pyFKkBldePkthNdxaT024tE84FCsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F5YhKY9Oyf7kA8UNBq0CSwiSzqvk3vjZH3rj0HvextpUpp395x70w0KMkiUSL+FIszJeK4WhFxtJd8fRtr1OKeeZWXnGhJnNUBMT88JD8M/9hjUOZfU3d3iqq+V8nrIbvq/PdzNTH2xRAK27nH2y+ESvGx1XVSqf2xiOvC1slNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iYKPR/ex; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iYKPR/ex"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53I1YL7U023867
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 07:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2dtqbcPgqz2zJYzOOCZPN2LLL9rO3nXwWq5S6LuNoqs=; b=iYKPR/exe+ut/Mpr
	eS4JIZIi01DhpzQ3ga6kufc2EGvbOECQ+fEA3ZPnQ8TvRYIuvTIWHp+fDAaJXUb0
	WtwIMw1IEfbrPqym6qZMxtAlH5Z69H7+6g1Z4+6zDHAVBvJRu6GKjAeJg4+whvdw
	xjz39rBVFghOnlrMLH0mgt8szvKijbFOQ5EJp6ME785yIMwNT2tHU+ZlXpKvmt/I
	tavY78yIOPYjRVx2aDvxq+PChZOPOHDK7foWqrsz0X+Mxyx7H3qVbMNtOlL4SvPa
	hyYFGm2do1734sEWFJyWGCbvbcT2g7Yn5L4AyACq2AuTTFduoOo1cHoFj+it7Ngi
	AHap1Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yhbq1493-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 07:50:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e916df0d5dso28490106d6.2
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 00:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962610; x=1745567410;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dtqbcPgqz2zJYzOOCZPN2LLL9rO3nXwWq5S6LuNoqs=;
        b=Su6Ej8IkTOCzPjgbjgSBxnDpY0VgLVWlYVXQc8W0DXfWQwkU9MgSfe6vqyh+dhpE6n
         KGiT8eiTQ1xIHGocwVkvWCsyF/p+78OmyO0orCM4mI9sHUL/yzSRb8TdV9aWzf7F+de/
         NzOEQW3UqNGpd8buFswXANbJs7gKQ5fyIve9SrAdHoVcl4DmGd6OjcwpNP1/crt7nDK0
         3Qs1pufb3mx6NZkBxgIEuZLsN9qM4TJ4MpPWsrENHT+KPXM/rnDHGGMoFq37QNL73zRm
         74DoXtmIpCxl8dSBB/kbBNmbVtqX5dlZCdy9jB4CJ57xBNHWbnk8ZF71SVxASBv2eFv6
         hwpg==
X-Forwarded-Encrypted: i=1; AJvYcCXL02sFyb51cgK7xp7dNoC158NITK7k2/stJPOVGU7J3Z7BZaUi+yx0/3l8DrMq/7wKcD6p7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwWtgb+AKQmcI2RsFd0Fv+vxiztJvLGGb7302VQJl01j5nt5jIj
	sGNx8uCp59YSqxZZRKnQsjNjs2CnrGvNH8k39ikwgVUbhJv8cP4FS46abGxYr3c2D1jLzdIx4uL
	e4iCkjbCbK8SQY4882BWtnOHVi9EGp4cmm+SiV2gn697Co/JAYyI9xw==
X-Gm-Gg: ASbGncskqtlTM5liv5wfFLF3k5Ny72fGnH8bjbWyhAz4uS/R09X0qu4G32SKcmTWXyG
	vjU6aBOL28fp82N2iRfAXagbPYEaJYYj+zuNp3JFCQK+0qZRPsrA064HuS0tmnv2Ml8xdw7zGKu
	/49pj3g0Uz16tGpaWCvhEcwKJVrJ+pqKxhSPkDgAxATcoa5YCmnTrVlWjlrAJX4aXGeIGgWbl9k
	yI7nOdfsaZDCkvSNdvtSlOoLqS+tmW3sU6coajSTuuMANJwAd6VT5NrE2xkrL2/EQMRw81Tw9er
	xx+NAqqWXwZp9snKTbjguS4mtWKAso+boaAUUEr6DJlf5CuyeD12hhZHu6HxcEuAMWLvSFhYdw8
	5C+26i3nc8GWOiFqJ1V4zEbdg
X-Received: by 2002:a05:6214:d0c:b0:6e8:fee2:aae7 with SMTP id 6a1803df08f44-6f2c46846dfmr28951956d6.39.1744962610264;
        Fri, 18 Apr 2025 00:50:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOd3cRqGE1P8KpWy78lHx9JINBULPKSL5YprCIzeAWjS2E3hNvF1FIPQQX9/FweoUbxXDxkg==
X-Received: by 2002:a05:6214:d0c:b0:6e8:fee2:aae7 with SMTP id 6a1803df08f44-6f2c46846dfmr28951586d6.39.1744962609895;
        Fri, 18 Apr 2025 00:50:09 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-31090863bd0sm1649061fa.113.2025.04.18.00.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:50:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 10:49:59 +0300
Subject: [PATCH v5 04/10] dt-bindings: display/msm: qcom,sc7280-dpu:
 describe SAR2130P
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-sar2130p-display-v5-4-442c905cb3a4@oss.qualcomm.com>
References: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
In-Reply-To: <20250418-sar2130p-display-v5-0-442c905cb3a4@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=934;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=IJ0quqH+dI7r+sJavUIADWzzAqD1L2X/CIVzw9kCDtE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoAgQpQLS4T7hY3QMRLBYKCNlxp6QGzMPUhM1mE
 2syy+Wzk+CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAIEKQAKCRCLPIo+Aiko
 1VrxCACRtXhz+Ws7y/U5mibKKWs1K47mVF3B6oHwu+dbQIpu9R3+cXU8iKVJt9HMUTGg4siyX1D
 eaGaX+pRmZfZCSTCiiZOAXCYxiBEfPXmNgwVdbuDhbfIx0iBbB+4Qcsk24KJc5G/V0Oo2H9Cbt7
 IjHJXi3lpg5HVGAGap1QasV6tALnitBsO9fdF3ko45GlgCzt2Cr6iLyqiHYOqMD0EOP+kRsL2eU
 9G5ILpyOE34prwSBrY5jXHkCWobnAYOtRcHrDUGoji3osXOGRxmh2EQv+nGN/Anrc5XFbGk3keN
 ZLZw5pdrhmvM69zzdCa2x81QxcPDgCtWuEwLUBFy9bg8N4Hc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: yGiv8c2hu2YchEDHj0SvLjfgNwF--Xfy
X-Proofpoint-GUID: yGiv8c2hu2YchEDHj0SvLjfgNwF--Xfy
X-Authority-Analysis: v=2.4 cv=I+plRMgg c=1 sm=1 tr=0 ts=68020433 cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=KKAkSRfTAAAA:8 a=P0d4iQPpJQof_2lRNe4A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=963 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180056

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Describe DPU controller present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index 6902795b4e2c249c2b543c1c5350f739a30553f2..df9ec15ad6c3ca1f77bebaab19ffa3adb985733d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -17,6 +17,7 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 properties:
   compatible:
     enum:
+      - qcom,sar2130p-dpu
       - qcom,sc7280-dpu
       - qcom,sc8280xp-dpu
       - qcom,sm8350-dpu

-- 
2.39.5

