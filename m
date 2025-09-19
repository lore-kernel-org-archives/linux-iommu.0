Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B62819E967
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288901; cv=none; b=asQ5xbm/i9JbYaFM/cw/oSiaS6DkGmFgpwO1z9Cuw8XpEhc5cq0Tndf4EagJQrMZ5/DXfiprXj70G2eebXqVAx2iMghK4YsWmHBdbCLccIiLoq9jhtzhgz5BZV2trKrNPHjhBLa+vowlGc/eQzVrT6eIVYHnOxE25lGXhuZGGsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288901; c=relaxed/simple;
	bh=v1yecXK0KbtNUMyqkZ4phjSC/lp23KqCyTR3rxB5ioE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E8XpjB3Qj9xmanl1lOeIevjInVRHxy1VDVxFpyCwYj43uJOuzdE4T/kAC5sukrL5mIYtQQuYN/Z1lzKQd04wrPcJ4DAbjEul+d4Tw4mLyKTzAM9jWTUYKhWP6kYtrIYim6aWVuJBHnPgQBCPV8MP9Hs9nxyck6mNqCxScovvcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cflv8X1X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cflv8X1X"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JBCP0Z003286
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 13:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LsohKq/Rcry2lOpzgsvKWq/Zyk6Dbf/1HfO
	9XNIHJ/U=; b=Cflv8X1XBA878cmFDyF8jMcedeFgezI4IJyz0GSsHrNhRxpzuq/
	XHBzVq9AyotS7Jp2Pw2PNjCwUS6C/1kB8O3zUXNelc/pCwK4Ak2rH5KhrFNIqTji
	204TOCgdXJOzJp6Azb9Txd6V0oXhejzRKENVT/A/71Mqzn4aRI7X2Hbz2+ZyIdGf
	D8TTOx27O/gN/sQ1LSLDRBaH7voMd/ILyisBmFsjegY6Bq37zmUUOgxBsaNwSJbh
	ZIR3HIYObO3oPpmT8cIdPh7PeZ2M+0zpIvY//Lc9EpVHyjt3L1jip3CV1OgsEItE
	1cx3f4qsSsRRkaHim8Q3zG5w0Je/S6OwI0w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqh040m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 13:34:58 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7761dc1b36dso4091328b3a.1
        for <iommu@lists.linux.dev>; Fri, 19 Sep 2025 06:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758288897; x=1758893697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LsohKq/Rcry2lOpzgsvKWq/Zyk6Dbf/1HfO9XNIHJ/U=;
        b=EAreX7acrKDCyvC+Rsr7QuI5gB2ODeH9PQ9pWgYyxgeOBhGpBiaZwmI3NSV7KNy5+Q
         IkFI16hbxQrZHE8rDIy32DBfFIloIJebeESAbQZ2bb/Os0xxak5N2E954w7ioulvT2X6
         I6Y1PMgt5B0rPL4B7Uxow5W7eq65ntSPMeRTIytcq1ewEMS9epp9GXPJg9tPzmdOF2Cg
         1gdi/zwxFXRkpZWN42DOOJqquPrj6ayprx39BSyJz03RLzx8pOvttKCpBo6RLFByQGmh
         J6FP1hvCMttGJvAOtvnEUL5b7fXc86Z8U10yWIcYEfNgQU8orylY64QwOwPlxF+6v7AZ
         6p9g==
X-Forwarded-Encrypted: i=1; AJvYcCUlRwKQPNOl2uB7qByJK561XZz/UX9HWiiVjbO5uCQ7Ci8D0xgCvO3jzXMY9lOWo1prsJyZhw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEKDDiCFZFi6wIiPF4QsPOVRcVp682H0SgSaLEi82+brfr+do4
	gpjHs1iOLowsnGTNjvzSLRMrgcX2PK6E7pGmGf75QCb5hTCvp0IgMar88dF2EWVR0OUf+2tOrqq
	IqhDdXd7LEhz+kZ6bCpgEUY3hcnyNc6buSya+ndKUqngoWiiax91vyUC8iA==
X-Gm-Gg: ASbGncs9Xs8rT+r/CamPMsCT+v3Urz5tXQbWd3e3mGfRuQMyUMl+0a4rPNRZmADoyYl
	tZ4pq/bBp8dUXg6YyWKwOwKlXLh6ogVH+ZEligc5OL973Kj/7A41cyX7y5Vqq4fM/m1wgmhcCWu
	RK0uH6EBLA723t3gzC8MLGNiGo+Y2X/c69XvRNt147tbMNSXuwNAy6ABdy/4R9pJjjChD25uxXw
	hbwVwqVtBnzXPaXEyGKYe6kdO4RN77xZf9zV9AEyr+c2WfWU2hskmNfZLqlmH6UaVZ1l0bWxwWk
	5QK/ECX4pVcSEdjKll7M25mF1gyqi7v1m4yrm0WLNi+fg0XAZUMsaZk+iT3k2kSylpkdDvWcZkY
	601Fhgu7lAtl/V4xZu7XhltF3o5tlUW2ZnGBJrnMiAs6k34Mn80OPiBuTPKO7
X-Received: by 2002:a05:6a21:6d9e:b0:283:8139:b613 with SMTP id adf61e73a8af0-2926d9da17emr4653044637.35.1758288897371;
        Fri, 19 Sep 2025 06:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO2w6MVcEvV+deoS3kv/zg7PSgK+W96l5OJ7rnwVpM9/jXjSZoCX9M+C/TvZkhd7xzo1aF5w==
X-Received: by 2002:a05:6a21:6d9e:b0:283:8139:b613 with SMTP id adf61e73a8af0-2926d9da17emr4653017637.35.1758288896951;
        Fri, 19 Sep 2025 06:34:56 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55219e34d5sm1558940a12.7.2025.09.19.06.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 06:34:56 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm-smmu: Document Glymur SMMU
Date: Fri, 19 Sep 2025 19:04:39 +0530
Message-Id: <20250919133439.965595-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XxsHKtlpPVlGn12aj19Wvj93xgCzBOq5
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cd5c02 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8Rycb7W9lGZI8AMxJXgA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: XxsHKtlpPVlGn12aj19Wvj93xgCzBOq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfX4wLEaZGShhGS
 TSpSBSuxb2xRM8IRj0yFTKELjJRWKDJamA88nlPU81M9RJKkOxTCfKFN//nIohB8EEuo3WTHAmZ
 lwhRmc5SP6bGnahzO/713A8k3MAI3GMqc0uoSOcE4awawNsxeCThC38kgH86fpMS8IZR9Z0jhP9
 6kHqiRN1m14V6+Rh5TSHPlmfel72JCpIau4GqZTxip3Lz1RNQbISSkogYpnKVAZI4Ohx9fp1h4d
 PZTWK2CYdmBECQymBfYZxqqy2EWJ7dryDPX6hDhQBGpV0Jf+CHnwE3bW0witOC3X1H2K54pPZsH
 +YJ1l4tGFB8DNwgE8OXPCL0hLRmvTmByFz+GPGyDVZsbXd1lJbMBFU6aQ3xRzpoCBf3CjcR/bOi
 rZsHgERE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

Document the compatible for Qualcomm Glymur APPS smmu

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 89495f094d52..6543fe68a819 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,7 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
-- 
2.34.1

