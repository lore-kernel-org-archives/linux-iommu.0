Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F93D6CB1
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176470; cv=none; b=F3F2cKzt97KdgcRes1w1H2H3/32ovGwFXwZF2OFJtiBVRa0wfKRQOFmAAbNfnJw0A93UT6Ve6JyEa6gxHfgyWeXvFc5qh6f+cKngcrorAUriCNOj4SgeT5niQoVrtcol5O/A3zXhZ75MnaZrvtpgj1kDWyIY8yBnbK6gOl9s9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176470; c=relaxed/simple;
	bh=KZnHZBSLSMpB3NoM0qPWgRe3yVcNSNMcooAkdHqMozc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HvO6U1uLPIJjWaJ5ycasU1kwcN8tovC0K9w6fhpFwjedh4HvfWV6+C4Jg9vzdiOqCJlrQQSwRlIqfMdge6bbjR89gObYKh9/nRAfqO1FrWbQUWyiMXzns6I1dMHrKQmbYX+bGbuSX23G2VYrxz6t8DMTaZoMKK1TIgIiHiMu73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e4UKvTan; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RMmjDhh0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e4UKvTan";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMmjDhh0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J59n4M1251662
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/J/OIJT7DRrHkarchUlhqWqh7n138q1ZhKA
	zjC2X97Q=; b=e4UKvTanqgcy25VgTXVn0puqZEdnZmvvQ52JHzKFqz5F+e9mT5y
	PUaLRzqRcSTMQmjYOLJpykOw0CJMN3FWLYxQe59iMq5f57cHfYHyZUgxaIehKqv5
	MhhjSwNLLgwrvf8HDQ0ND6VQhEj+zuNHtnw+2OZtyZCRcPyS01c6z0DDWAhpiTx8
	URw+dp3qE7MwZ7OQnCIR5BR5V0NRpnDX1a2+i28OlusjFN9/fRqz9mrqSC5ax1LZ
	g+86JPzSXxC2FzOi/eqauV/FNLK9D1RAoD5SAk5+MbSO4embb8BiDQ+9qgykSOWb
	Gv8uqOmuqDqblxsqGyvShnWbgthuzBdto6Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82c0m1e2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:41:08 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d9a6a853bso93635751cf.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 00:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779176467; x=1779781267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/J/OIJT7DRrHkarchUlhqWqh7n138q1ZhKAzjC2X97Q=;
        b=RMmjDhh071yi+WqEkfI4IOlnkU/PLB4uNC5HQZVc0zaOXctCLFfN1x5JuTLEwbllmu
         UH40C4TZqdIPs3eR5yIRj00d7oyRIunRNLyNOmpx2kqHqYqlG14Z+l/gv5/4tFDZQ9CT
         LR4coRmJRxTaQcz+eWurMsaqgl6MhYL1yt9wxECFXc563nfuoyMjrEW+z8Oyqa59eBjq
         YZxNOhsRfdOXV1fRIUUJCo6nLuY4TP1+zIg7ThRXxuNAWhzfGzbpibH8o6dyP6FPWLTR
         DJ5SAK1KzTYrg38WBBsIieJqSxvu7CjtzC8fgNohtqgU7Nq1zBynazbxH1HDEgO6m9Gg
         IBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176467; x=1779781267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J/OIJT7DRrHkarchUlhqWqh7n138q1ZhKAzjC2X97Q=;
        b=k525Uw9N/efaff69e1JdeXVxutB+841azawFLZJ9mBN+7NC36K3B6ADiqCXgCwcnUy
         /nt26rYgoANiTsgHa5QUdDUZvaWMUZEo31t+7Yw4a2Y5EsLumZyyItKvsUHlWAtHeXlG
         HeIu16HoyqU4FAyD2dCRGnq7iC1uMoCeQLsGXvycvPH7KCk5Ij/h/lBjIRUsgQFBEhb/
         0pWjky0k8g8A4bwV1NC3VMOTv0A0A66LHI78mvRF5wJH9qrK/wZr7zNvKiN0EoiuBSk9
         cXFUEpfVR42C29syR4nyQvb3GEMXNbV7nE7eq5j3FD/YBdvX0VnyxRn8SlwCPsx3LngP
         dLJw==
X-Forwarded-Encrypted: i=1; AFNElJ8P95SzZ/6bQll47UrPtQ1IWCVMWmwIMI5V8F73XoPJWGULJO62e5tjo4csTWkNR6dL19a34w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE6MHaCWdhIowzJRonIcOE2X8+YBwY/gRixqF3BHb+T+P10zq7
	VGv87AGX3qHbeLje5tbKeEm8O+/oWFy4Pn5TTm4wSxLbQ4NLKfxDMr/QynzARoqbKk+xtrCNOK/
	kBjXXapyWkCjD5WtvYWwSi7ZpEkTI3F4ztmSBZsm3p6Ve5wAkRzTx1B3ULg==
X-Gm-Gg: Acq92OFFlym8G+6be8WuDGwX0RzDqfya56XN8xg1ZClfoY4AeaL/Dxxzi9kjCbQ8a+l
	XXcWcx3V7HVNhRWlSbR2cBL7YCaqe22XyovLwPVKdmcKsWRtszWg9p/wveGKpGJrWG3UGCP5shk
	rSbl0JAiFzYA/bKZDO+IEr/n+WOVnXZAMQORk506YVYBmr20zCZbQ0j0zlEmciO7eJufQ9t8Wba
	LNzv3W20QlArRReS2kRamfjvORxIKgtmwocyWOW7SFwI6+rpPEtAXxbgK8A4nah5Ou74NTU7u3m
	5irNgUFaBQRSef4KUylccorvJASktQ4DRl7SB/bU2C3Ep5hnFL/UK3mTuUClfbR8AqUh2M98las
	017L0HnsJRJvqe7qwzja0hxappsDypat/d5Vk
X-Received: by 2002:a05:622a:430d:b0:510:41b3:f1f9 with SMTP id d75a77b69052e-5165a1eb755mr196313841cf.38.1779176467152;
        Tue, 19 May 2026 00:41:07 -0700 (PDT)
X-Received: by 2002:a05:622a:430d:b0:510:41b3:f1f9 with SMTP id d75a77b69052e-5165a1eb755mr196313741cf.38.1779176466693;
        Tue, 19 May 2026 00:41:06 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe1a41sm47266843f8f.31.2026.05.19.00.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:41:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v2] dt-bindings: arm-smmu: Constrain clocks for newer Qualcomm variants
Date: Tue, 19 May 2026 09:41:00 +0200
Message-ID: <20260519074059.61405-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3108; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=KZnHZBSLSMpB3NoM0qPWgRe3yVcNSNMcooAkdHqMozc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDBQLmYb4h9fo1eUreNP62Frw+N5foIgep81TM
 ww/LLf+CfOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCagwUCwAKCRDBN2bmhouD
 15MnD/99fRBVxOlQj+DbCgE5EWma0FpIsoLv2jCf2Wt6MLsSbcfMVVGCxpjclQ8XHq65xE+2V4+
 nxfBf1u7I7Eu+c7Xgny1Q8BQ5UgRVVsjnN2ay5Wz/UadlmJq80pZfsRFhvKUcAFs+al7eDV9u3g
 T47SBuOLeL0x15kymqK9FyjvFgBRdXW9af4LwTGs397Rzp2XdjzIu8Tdym2A9dsJS6D83OUFz1M
 +SftOtopi+8INf/jxmKuTfm7wXG2KW2JtiREdhtTViPxcBvypkp4FdA5ozVUefLFvOdVbYD4Iyo
 8Hx9KhhMxeES3kk44rcWAZtUfHIAnkBkpp1ckqe7ghVAutuesu4WbB4/qO8t+KNXR/bQG1EOVRt
 bzCk7hcUwSARgxy8Pma7gl3638Y3+gV0Ze36ypjrUAhBJFgLN8VWw2meQmnj4CKUY4wKjf+VwY9
 pXcNiSGd9hQBotrd/GwQnMador+1BmopQuY3J2YpsinsSiWEe83o2HYHVZl7bZ3UOhZmsJAgOO0
 HzoRL1ZvubwzOaxxs80ZrPPUre7gS3Zu/ATdVqApZWbmfLKiomQFx2m4YaDddXCwl2OJUP74JT1
 qdjMK2muxcci2I+AfXHxY1viB0WkZ+beyXjcPCgZl10ciEBwOyc/jqRQBxwKzRBB6ZL4e1siicE 4vZLHF/YSXXUtvQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA3MyBTYWx0ZWRfX17VBkXIgZaA9
 7atLcTdR+M4l4mPzrTMT67NyhCPB4ndO5GMR/mxGyF8SB2lFdwDi+Tf0EgS2RJe39IKgc4x0qOj
 fnXKFu4GL0v81hIU7MZrlv/tNCYtHXlhETqEZOdgqFwvIOWqyyfF6GgU1VhGNMt3/G20vw3Hgh8
 Jw2JOybrOljT4R5ZRdd4+jpJDPZIiFeWcXy4Z5HgeA4SV1XAtWjqJdrSoLinJMgHGdgHJocCaca
 seyS0rXekqtMQ4yYdgifzKDLSTY0mLhWp4Oajrhnm1lnmLqTaO+6Doa+H4ExBYaaVM1xoBKBAHn
 05ylaKnO8IlOViMtxHknGuC2dUsdlryUyEo9ThAg4AY2LdbStEo+XabeGTSWrlSWKqaHQrCXBCo
 NbuvZrOJg+xZBI5XhECSJ6vT0aJ900lw96GnqOVahEqBf3Odw/rv0jvfRwtXF1jNWgS/B+ZyYaI
 8iRPQ7rHRZwrNOQCyEg==
X-Authority-Analysis: v=2.4 cv=A5Jc+aWG c=1 sm=1 tr=0 ts=6a0c1414 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rJxAMVKw8lswYMJXinYA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: Trl9HNGvoslL7eGOWkxJT95BUikYCdjs
X-Proofpoint-ORIG-GUID: Trl9HNGvoslL7eGOWkxJT95BUikYCdjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190073

Many of SMMU on Qualcomm SoCs come in two flavors using the same front
compatible but a bit different fallback:

1. For application processor, usually without any controllable
   clocks,

2. For the Adreno GPU, with some controllable clock(s) and using
   additionally qcom,adreno-smmu fallback compatible.

Add missing constraints for Glymur SMMU on Adreno GPU and several other
Qualcomm SMMUs for application processors, to restrict the clocks
property to a specific length.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Tags
2. Fix grammar in commit msg
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 38 ++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..ed0d10157bd6 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -566,7 +566,9 @@ allOf:
       properties:
         compatible:
           items:
-            - const: qcom,sm8750-smmu-500
+            - enum:
+                - qcom,glymur-smmu-500
+                - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
             - const: arm,mmu-500
@@ -595,6 +597,7 @@ allOf:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sdx75-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
     then:
@@ -602,6 +605,39 @@ allOf:
         clock-names: false
         clocks: false
 
+  # Disallow clocks for all other platforms where specific compatible is used
+  # with different fallbacks and only one combination has no clocks
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,eliza-smmu-500
+                - qcom,glymur-smmu-500
+                - qcom,kaanapali-smmu-500
+                - qcom,milos-smmu-500
+                - qcom,qcs615-smmu-500
+                - qcom,qcs8300-smmu-500
+                - qcom,sa8775p-smmu-500
+                - qcom,sm6115-smmu-500
+                - qcom,sm6125-smmu-500
+                - qcom,sm6350-smmu-500
+                - qcom,sm6375-smmu-500
+                - qcom,sm8150-smmu-500
+                - qcom,sm8250-smmu-500
+                - qcom,sm8350-smmu-500
+                - qcom,sm8450-smmu-500
+                - qcom,sm8550-smmu-500
+                - qcom,sm8650-smmu-500
+                - qcom,sm8750-smmu-500
+                - qcom,x1e80100-smmu-500
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        clock-names: false
+        clocks: false
+
   - if:
       properties:
         compatible:
-- 
2.51.0

