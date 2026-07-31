Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAD34E75E
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785475900; cv=none; b=AKk+13fml0E/A5JYeweFrnO/uy+UCH/oNOWwl8o4lGbvIOpnzNmKhKs2Cz4hYv0PXfVLH3tp3lHhbArDv/FyyMKAlwTeJR7/ctfiylkERibOtoxaZMmenVtiPqXs+Hulu3OkhuHdGo4q+f3HX/XsU04KmE/Y+Zo59rQb2NaO05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785475900; c=relaxed/simple;
	bh=87gyxKw5vueVf2Epya5aaSKe+eAGML2SWSMjgAKpXdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rd/PFp63adxM+YimSAbpP0W7a9G+7pcBq/u4900thQLo1lLNJcXIMI4NA9bPs07DrTYl9LW710tdbebnJg4FyWa5zpaxPSqnaw1uZYVm5VDica7ZyZ75t1xLrPkx++rPFG+GJ4A1lpFnq8yHCKzGMsUZ7QurrmPSGFxsR4qLTWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDtnA4HC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fz1WalWB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDtnA4HC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fz1WalWB"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5S98l3061534
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+ge0zGVB2WMr0FkBsLt/Bn
	F/YfcascqnH7BAZ+KIoMU=; b=QDtnA4HCCjMlHLFZh7gRoTQdkUUJf6P6VoZ6Ck
	1RkmMZRvKR56/hprrAXhtga/smz/hoL+pF70ukVctX3Q9euEVNq5pjUrvtJ39nB+
	F2O+uM+QmlwK0zuNyvRLnjnAeJ4lEV0xYixWBF5f6MxPKzEF3PdDvFpwG+xhwwgt
	cQpvNvcPfCBCTDfswBox4OdqGcMCJ+jpzLH/EuTWCnj93WhFwbIwu/YvPdGpqc9S
	AIpAUmwOciN0LZEdXKFl/FEsT2sNBR6IbK4hym7PRON/fjC86cuVBf848opZM0Vt
	SUQAqNGxcV0/LbWY+Rsmb+wQoAGvOThfX+Iy7+cDJo5X6wgA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frnk980c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 31 Jul 2026 05:31:38 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c85798977dcso933590a12.0
        for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 22:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785475896; x=1786080696; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+ge0zGVB2WMr0FkBsLt/BnF/YfcascqnH7BAZ+KIoMU=;
        b=fz1WalWB+z0mRQr5SYx2i+EYSuFVCgoSiJoQT3VG5hnHpRTpcz09yOkgOnw7/Q7FZB
         ShIw3HTL798+K+XISFvu0g9IUZarWYQeSXDnsOlDhpg+jWszgHxieClHGN4yFEbEBmUz
         DZ320vdj2W5pqYzz7W0Kmt4m2B1z2YYB45WFZEth25V9mDwLHY0hFXdM0GAFbi7V3nVh
         kzRGcgEUgmk/wO57W46n82u4zE0icfArnyvR8W0axJHSMInTXQXNPCDw+rTALT4GFzrx
         rKplfjazKltkWLC+RRC/s7dQ7WP5LFgfIP3i0YQaKIMdhFZBCq+Vc6MhdZZk5WNmta2+
         HlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785475896; x=1786080696;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+ge0zGVB2WMr0FkBsLt/BnF/YfcascqnH7BAZ+KIoMU=;
        b=rS27wCBKzdK6CoDyYss7PRIgeNcSES8+pQeg2qvPJqL6AVLjFd0UjqWfORJ+9P5rmq
         2XQzJTKutrhNKPLf3zedI8Bt0qn+jwbj2ybpX6e5ueS8rcr//61Kmw7UZvzWe7ChymMX
         YIGs78/+2IYrvpICRUTTLNhzDFMWtrrNxVgmtJCyNGw6H9/+ofdw8/BAJ8Yn8l9hBOo7
         mx5uLtTrswbwGujg4ZUqraKkJ7qOTmw+K4PJfzq76xSoz0qeLxUtZY77ftqEybQMy80B
         W1yVpJchvX9G1uSZ5U+4Vv+EOTrLU41QfvwX/FvmsEdm+xyCF13rf4US7Gw0LUshk9lk
         6Mmw==
X-Forwarded-Encrypted: i=1; AHgh+RqpUZU+BZ+nqazYHeMur0mLSKDQVKysU9Hqgt5upx9fUtsG4ppG4Hr2YgLBkehxuojt+ubhHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4QLhfprFNSX58NppPuEaYD2MdcN7p9V5IZLNCOviqVYCD3eJ9
	CJy2u4Bry3p8RgOkwybiGtwOUYd1GlMnAviIfLgV+A8M8+QT6fKohZ3WcLKgakelBr8O1Da/+Zr
	bVSZkGlU+GcpM+pxOnEbnHM4posYrfPC2kqPDulNP7TLRzDhHNt2I/Jdu+Q==
X-Gm-Gg: AR+sD13o4KHgLb+SnaRpxk0UO8DjxY+oiSgGGZtJRVKs33hieILwrDzBZAgelfIqQol
	5wobrpmCb26+slXgvNQBrxtOFTtQmCqJsRpq68uP3TebEathnRngO8UVlp4BdORk1uB/VRhJ5sj
	E+ZeAkHGf+zvGBjobRQVNRoU0tjfgCak2QuaGXIeiBwE4MvN8+GbJikp4ql9R1gVzsyexKgifqK
	j6W+znJTaFWhdxLtkkUcS/ZlQ+jW5UZ0WNc/SQ8SeE/lO+xLdO2J7oLAjJve4BjTyMg4N/OnTjc
	r+erH+buO2AxMd9485lMtZes+z0tLv9p5OtkvG3xtp8nJazWOkXvhCSfMDwan2VkQOIDeWFWRYA
	3Gy9v9FDQrCmFyOdWmD5/4J0gdBHI3chS8CK56uxG3rDt3Y/TNls5kL0SAaZ62FamkiKYJDanKu
	TM6Oju2scKRdlmbuDwVOFkl+3MFtXmPT4S2Fo=
X-Received: by 2002:a05:6a21:918c:b0:3c3:cf9b:fb8b with SMTP id adf61e73a8af0-3c91b3ab625mr542271637.68.1785475895818;
        Thu, 30 Jul 2026 22:31:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:918c:b0:3c3:cf9b:fb8b with SMTP id adf61e73a8af0-3c91b3ab625mr542243637.68.1785475895416;
        Thu, 30 Jul 2026 22:31:35 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm1983434eec.4.2026.07.30.22.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 22:31:34 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 11:01:26 +0530
Subject: [PATCH v2] dt-bindings: arm-smmu: qcom: add compatible for IPQ9650
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ipq9650_smmu_binding-v2-1-143a51c8ffce@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAC0zbGoC/4WNQQqDMBREryJZN5JEDbWr3qOIxCTqLzXRfJUW8
 e6N9gDdDDyYmbcRtAEskluykWBXQPAugrgkRPfKdZaCiUwEE5IVXFAYp1IWrMZhWOoGnAHX0Uw
 azQqTlVfJSJyOwbbwPm8f1Y9xaZ5Wz8fX0egBZx8+p3flR++PYuWUU5Yb2xqleM703SOm06Je2
 g9DGoNU+75/AVYSpJzRAAAA
X-Change-ID: 20260512-ipq9650_smmu_binding-36dc05d39860
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzNSBTYWx0ZWRfX6/rKaGMBqJfq
 ucloRaCvDdvBnUoJSTj1T5e/cNjglNoHOc0wayC3hGTRultW8BSHGMxM/R8SwZ9OBn6nTVcBKWA
 Z4sEIeeY3jwcNVNkxpg2W8KuC+zQOUFJusdXyBt4QUKKHfWZvIWjjWzyKKup9/al/ygPbbTsbZm
 z1QTZMssrTUsxE86/ejStgGc/dwqMIrd8hK6v4RBgnaN5XEUrTATib/vTC+7ujhGUZ4SVDYudxa
 1GTWLwlOGNKZ9B7yFDF6CUaMfPY8Xp25LgBAmccomPlU+MU3KuyLBM+u7qu2SVf5UDoQiA6n0XU
 NI7109nGr5uoCfGW2gZrNykoK8SISa/uuYHfijiUHq1eWU7ZX7exrVRRaPtmdY7qYwXGDWonihj
 Nx5Kuj94qPsOzSOLrwMSlQeGdA9F+Eve3LvjOSybeUJnbfyRvBLG+LPyXQn5XSM0KOu3NWs6oMV
 pK5R1/EfaX48wLyl/zA==
X-Proofpoint-GUID: pYF-1suONyo3oMppmsSyGBfChTM-lgkt
X-Authority-Analysis: v=2.4 cv=c7ybhx9l c=1 sm=1 tr=0 ts=6a6c333a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=tA7aZXjiAAAA:8 a=JfrnYn6hAAAA:8 a=pIFn9JwG4DboacuzgAoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=kIIFJ0VLUOy1gFZzwZHL:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzNSBTYWx0ZWRfX/fbPJR/qikRJ
 W0kbd5hrqEknxQ+Vz4dgRWxFiZ59je03VqhBpriBoJ7fcI6p8qIwOlmuakPlvm/6Jk4Vl6sNoHC
 2NHCnB1MMoIlHkpbXuka7b4/wTfjAYI=
X-Proofpoint-ORIG-GUID: pYF-1suONyo3oMppmsSyGBfChTM-lgkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310035

Add the compatible string for the APPS SMMU present on the Qualcomm
IPQ9650 SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- Add the proper constraints - no clocks needed for IPQ9650
- Link to v1: https://patch.msgid.link/20260512-ipq9650_smmu_binding-v1-1-04defdaa140c@oss.qualcomm.com

To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux.dev
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f2188942f877..ffa33b7f4a96 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -38,6 +38,7 @@ properties:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
+              - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,maili-smmu-500
               - qcom,milos-smmu-500
@@ -625,6 +626,7 @@ allOf:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
                 - qcom,hawi-smmu-500
+                - qcom,ipq9650-smmu-500
                 - qcom,kaanapali-smmu-500
                 - qcom,maili-smmu-500
                 - qcom,milos-smmu-500

---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260512-ipq9650_smmu_binding-36dc05d39860

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

