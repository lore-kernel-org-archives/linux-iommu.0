Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF73B14C5
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716228; cv=none; b=sMz3l/fouUlv8o40fbASyq2Q1o8puA3xJXc3Y9f08AtmiW2EiMvrIOh0CdmyUfnrnMRq7JVIJ6lma+HUZMzrz3nZxzxnTUEppOhFXzhbreNFrfBQNrVpO1XgtY+jSpVv4r2836EGeMcLVN+yq75OMKNZzt/DwGTKof2JtY2pxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716228; c=relaxed/simple;
	bh=BtkPFNWwQb2PwuusYf/8KN3qcU9Gir40fUa8c/oqJ5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VtUXQg0wqLdoSmUApiHbDw6Rp0ttc/z9pfHBVTrqgWKMDWCQmBGaVBcZu68+99RWZ0lKAsNN+iU5/TwVcUS4Ied3DCaTNV35hhIqnaugPVqaveQ11q7gtw9rm4RST/rPHczapJOVuqfgHLJYH5NtzIhtO7ccs1/n8WTWPnFNuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=giUQhWBy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FZgNB2fn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="giUQhWBy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FZgNB2fn"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T6sKMD2143078
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 06:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xOux2gDggREnIc5Op1Tbz5
	VNmuHn30UOA4c59Lv6Txk=; b=giUQhWByJkMkmkHPncSBlK/cyD2BmCue3wQBYq
	yZhoLgsoHppyLJC0d8I3gc778X98oq2/voWWPMorovgyoPInub1k5PLB7jubcYni
	iVzM9sjOqm0FjTVFio1Z3PEK8T8nJBL4XXMSnwwUCYUaqiOgu70Yv0XpkIVqAKih
	O7OjsgVdo4cJc2XGG2e2CY2nnqB8bKrt88BTutjFAVOVklkyFUB3Zv17aJHDG8aX
	1lp8hcNylwDa9s9BKceta+7wsxaTELPwnwd9yiRwumdJAs1WybZNWYxVg7So6CMO
	76NEgYMQZvfvdVnqPvDwVPCvbtZdNnvuDBjFVvH7ILBxyicA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8n67k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 06:57:03 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139fe708181so1499102c88.0
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782716223; x=1783321023; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOux2gDggREnIc5Op1Tbz5VNmuHn30UOA4c59Lv6Txk=;
        b=FZgNB2fnzgehP6b8fJ0sKIrtfZYW+0ORqKNtxChB37akY6nkMoB77HkNTYVF+fm5w0
         kCT39cCIx6dPAR54QZr5mdrIgMI1QBMuccj55jpHuT3Mq5QWwvCjwlsoSU9xdRWvBY/W
         bqsvh7sdAIhOl1i1hDGTqhTZPBUdVSAv5uHSCYSfTzRY6stUSMMP3Y0Iq48aNofoaBuN
         t8JP15h9PG7JQeRba3OZy1Yt1mezRCnzAr+Oh/lo0ANyKWAQd4c5xYaUc2gnY5VUX7Io
         twpdgcW6z5WCfnZo19aosBvfzOx4a9iXbKdCZHs3o3G/5OrnGAiUXj0V5vqkJl3QTyI2
         fKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716223; x=1783321023;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOux2gDggREnIc5Op1Tbz5VNmuHn30UOA4c59Lv6Txk=;
        b=emloNdxBjpBmwdAOtZHnb1QEiXranx+2DH4pOWJ1e9Wd5eoYFPQplcTIrHLDAFrASb
         wo5IHHzHLx/LXP/u8XiC28ASRTs65SlbOjw2zAtT1hEzxnppB8RspH+Wmw9ZZdObxh/j
         E/PVrS9Hw1HNSd+PI/hN8BGuo4AAUbHnOmlDUlhK4Rer0CZGu4jHv4mU2ImtP2QTn+Pq
         zTTbUhxmdmgi70pggGGUfzgn0OHXX5nPXSsoV66S91ONWLe1GjkMV2jdC04fcmEedekz
         84k57iGJ70lSTM6zgTQ1x/2xBLuek8M2JemFu1wNqb8rWaPclV84aafq51ZAiPXwutOY
         ePYA==
X-Forwarded-Encrypted: i=1; AHgh+RpddiUf6d1ffz2GB030C1+SrUV834L/2VPhCyPmv8bKti+0DQS2DySLdt7XZyEOm/fHKBNr9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyG+6UETKTY2NShahMlznHvwJWifxou6+rSCopMe6D6rHLBR25B
	YDje73DorkbBXSDSNvESsC6cVDzQiE6rELBNj9fzn3Er84TZDZ17+g5/u7JbnoGomAVr2IlX/Gh
	zqeo1qCDur1gwbC2b46mgp1QZmrCsnfOju06mPx7wcOOURY/dsoxhMx2vtw==
X-Gm-Gg: AfdE7cnJ8X3BYkAKQxENIya4bp3iOq1sX+w5RTWenixK/QKBUuEDAn4N1NskY0HUwx7
	xmiaqtMvx8Z5tFowbD1S3sEK49HCY3dRQ00zWFtlPIODGmXUHEZbKS3rPHze0OLHuWQZEHnf4Y2
	T8w51ZxhPGixnJ+/LrLExX6SIcazCYo4kXHpd+I3CcjQaLDviYsZXZyA5j3q2ArhWLXdtGhcVAZ
	tXIVJm9qpyeBvzxntAulaUzeg9Jga36Z7lLj+VlyijYn+MqUOpg4rTVsMBxOVkm+fsDKXnPs07U
	chERWOxS/5iHsiMZqqj38skcVZaw3j8l4eO5nZvqrfZ8qgzLaT3LM5JUkJoSEm+/MiCoIQHtNf+
	4/EIjThTEvH9sQ+YKhUsYCe9tLSn/0e6CIFzTFouDX3CoTy/HEh+/tAMng/HdSw==
X-Received: by 2002:a05:7301:6003:b0:307:91f9:c1d9 with SMTP id 5a478bee46e88-30c84f77b05mr15366621eec.29.1782716222315;
        Sun, 28 Jun 2026 23:57:02 -0700 (PDT)
X-Received: by 2002:a05:7301:6003:b0:307:91f9:c1d9 with SMTP id 5a478bee46e88-30c84f77b05mr15366587eec.29.1782716221797;
        Sun, 28 Jun 2026 23:57:01 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c6c2sm44995600eec.10.2026.06.28.23.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 23:57:01 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:56:53 -0700
Subject: [PATCH v2] dt-bindings: arm-smmu: qcom: Add compatible for Maili
 SoC
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-maili-smmu-v2-1-87448a7678ec@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADQXQmoC/02NwQ6CMBBEf4X0bAldhRRP/ofhUNpFNqEUu0I0h
 H+34MXLJC+ZebMKxkjI4pqtIuJCTGFMAKdM2N6MD5TkEgsooCoq0NIbGkiy97Os0RUdWKVr40Q
 aTBE7eh+ye5O4NYyyjWa0/a5I82qv9cSvED/H5aL28s9ewuXfviipJFpdtgo6Z/T5Fpjz52wGG
 7zPU4hm27YvrJsaD8IAAAA=
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-3d134
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782716221; l=1234;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=BtkPFNWwQb2PwuusYf/8KN3qcU9Gir40fUa8c/oqJ5I=;
 b=QnqI2Z0FwP7IqQVq1stRSgL3Kmyg9mkoHLOBdkzpbuoDBBSGghBhnyoHaLBqYkrOJfrh+vpgx
 a/mQgHR0MfwCp7N0ENAXOw6pmh8hAexhgtVK9oM3H0P1619SRkyGQzp
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA1NyBTYWx0ZWRfX+74qC+TuGgOB
 ygiE9NaOBu3+y7STfStprwbTjLxbosYWfSYhbP/rpHQuiJbH6Uj/vT3kST61Je7XQsmma7UuY6d
 vlAczbFjuWuNoXMaFYfVYgvdvk8fYko=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a421740 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0vWZlYpcnXXQiWOWdZUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: XLAi3MJgD5hQHnrc7yEgSMvvDgQ-sf_-
X-Proofpoint-ORIG-GUID: XLAi3MJgD5hQHnrc7yEgSMvvDgQ-sf_-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA1NyBTYWx0ZWRfXyxml1cGYYO3p
 8cyerbzlYSEhpCKiFsLhDXyGXs8jGoQFFtbnmQvQia+gqSp8oeYw24mp9OOm+hRh4i0nWKrCmx9
 mt7rlbbmWVydPdleXzc85v8YJMcUlt7Pxf3Q4gM7QBJQ/FsRiamGL3kAplcLfmCCMnUtb8zFn6h
 5p5Se6Uq0c6xpJCxgyvLrnUzlCsVE88p3Xd2RNsTM0LplUQ5CNsovR7G7837xG1nHGK1B+KFSIZ
 jdEi6RYoA7J6+mq0yoS6u/gNUHHEgTYV5LXvChbVJlBT+yDWkv1syRPGoCDuSmpVhbtsuzlT542
 W90RFFG40ePW57awMlzIuQBaQgL+0DXj/VBAz0sf7wSy97wo/9bPXJFR6hi6AM11W/m7CuJ/GK5
 7bY4BdmU4govrJnkEThMxmtfJoJbPSU8L+ztVbSR7E+jjZwQaqi1ZnpD698r48+5KdBW2iGwI0+
 xUO+oIoWpRD7ru8QLEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290057

Qualcomm Maili SoC includes apps smmu that implements arm,mmu-500,
which is used to translate device-visible virtual addresses to
physical addresses. Add compatible for it.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- patch rebase
- Link to v1: https://lore.kernel.org/r/20260524-maili-smmu-v1-1-ec85b12fda83@oss.qualcomm.com
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a701dec2fa0a..c48e9de1a2bd 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,glymur-smmu-500
               - qcom,hawi-smmu-500
               - qcom,kaanapali-smmu-500
+              - qcom,maili-smmu-500
               - qcom,milos-smmu-500
               - qcom,nord-smmu-500
               - qcom,qcm2290-smmu-500

---
base-commit: 3d5670d672ae08b8c534b7beed6f57c8b44e7b43
change-id: 20260628-maili-smmu-9ed0f2c189ad

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>

