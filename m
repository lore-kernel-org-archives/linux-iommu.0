Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98310318B9B
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 08:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777882200; cv=none; b=QbwkAkFAAuELj0UZcM1vk9bOBFqYFmRg3VCDxISPTYndNXCa4DMCGclKJ8K/4kvhwUmvUFct+WmRtRVGG770clUjpT4d6Q2Zw/J4r/tEOb64/+pLgJs28JIkltEhzNSXtSD9N4pTUgBvNc/ywE17K4Bi4QveomM4q69WuLLVSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777882200; c=relaxed/simple;
	bh=6qhZq5b8SHzeShtJuS8Tcu7cHC/MNTPAlUlPHtvyRtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cfll02qlbBpRNowOI4Bi4GaH+y5iIrYtWyWuOEw1pYRpD4zo4bQiLxwYjMdBlmIp4Vzdt36ZGdGrEJlUw8NhbAo4A0bk6hUITUz+4SpBt6inhLTO4EaN6fCtcnGQBi9ikSiSA5BEDIQZK8pNj8XNdzY6Y1E7YpN9X3YYbGAAGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nDIHqyMv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cbL4Hgpq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nDIHqyMv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cbL4Hgpq"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6446DAuZ2200845
	for <iommu@lists.linux.dev>; Mon, 4 May 2026 08:09:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=U0ALeNEYrXGxdjvOn7+l1nFE6x+LDkz4A9/
	fqiCXiKc=; b=nDIHqyMvsKhz6nN4+XM9WgrC25a38Rb9BsFbcY0BLOmDFsR66da
	DGVdeVY5j6tAxE+SMX4AFcRR3i7nUg5li3ogxVBHYyaoNkSXoOq+bScp9X/uFb3U
	wV8d2KiWVj6RugqfKrBccuVmur9IaW0M5EeEFr9lp3MuRiomTOk2I8oWZ4k5r+3P
	t5ufCZ9XTu7d8Ev36d6uP1GEciZwoadODp9EprbkiKSlq8NySSZEMe31puWJzUJI
	iKKLmg/iiDB/YIIjDNpnd6xoZx8qzcHhHv8Dz5I+339YKYLNUzhNHtZ9uLiDNHzX
	KzQZSnObum34GmBlbjR5420vBVn2rZPqTTw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwxk1apnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 04 May 2026 08:09:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5902657eec.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 01:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777882195; x=1778486995; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0ALeNEYrXGxdjvOn7+l1nFE6x+LDkz4A9/fqiCXiKc=;
        b=cbL4HgpqfOvuAMNuQcneaJNapZ/tGzEHcYyB+cK/3SaDJqm5dJ1RIuoCZXVOX08lKy
         6oofau2b3vSjvZFjrvVceP+4vByjte/nBjQd0s+lk8jiOo6hfkTXPXu2axyDI4nf94nd
         HuyrsMtxi9uKcfriMM7MuWF67UEyO74uTkVsnrdmnvq9mbfxdduR09Vrm/FbGfFEhxzD
         SyLz860JlFWfG19tWdQuZE23rFz3tyMqsh+SbKq+RYBXt0YNAMpbldcNMFl0ygXnngfK
         YZM+rlscxkrwL5/nPuljKMvaMW/ilLwEvtN+mplf7G8VQbpluHqWUAQWK9116CeEWpWP
         PvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777882195; x=1778486995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0ALeNEYrXGxdjvOn7+l1nFE6x+LDkz4A9/fqiCXiKc=;
        b=ofH7DGyXsHZ53EWqqSITBoOCiXhFADTH24aHzzLgM/YkM0rsRtNaFvY68JmVksmOF0
         1tqA3yCZdAcP3x/lpmdUQ8rH474/oJL3UkgJQsh7KfdWd0G1umtoFGOGcnhytyELcFBY
         79ELBvl5sEzHWnDuEQJlvEGBtp0t1hHeweCdw+4pNM3MibEth4FEzZP2Vpf37a3v5DFX
         537mYqXJJ8c3hqKD1fnQHGVz+f+6/RFCGvihk7G954ltpV25XTzo8g8q3TndfzUn1Txx
         Gi6+6XwzrO6CqLIBfwDfbuTw2dDfdiKqstZe93s92+QwjGxN4t1B8EYTI8FuF8hTxsKy
         y+OA==
X-Forwarded-Encrypted: i=1; AFNElJ+e/idcTgK7OshwIb5YSL1RmrSxQuuEIjrn0Fo67GakB16GKf5wFnfkwn8+QW23XY8NXPNtKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDjhEooHud3U6uyRmJSI8SySKtdid6xbuJB8x3LPEd0nC3guha
	wzI6Afs6+OLOxWe4zICxg49rg/ymfcTG1iJ72COS1lW0QLAZlSnjoR+w1PfXIBRG2g6X08YEg/U
	5U1msM6plcWBby0RWm1uj6QpLKe78VF8mqXV+r68m/ajwgXwgspDx34UBEw==
X-Gm-Gg: AeBDieuhVQxp7446MNSexuIKwuFcpBSUFcNXHTNUwby02U9ocwehUyPf/J0SayI6hXu
	bfArF21jVx7IgSQuZx/jTZqW+zhiqA/EJG+VfSug+wnXvVeKVl1j3LAVIYG/ZDxzXWfpuYvGvlT
	FwGtTmU9iyCvGrXLKRiZtAmYGAfIohv0MZZYLbKcK9rD+Q8GXj/8YAkg+R2mnhZa38XcaoJq7VS
	xGjALOyHZGkl5841/gKU3TR2ZqAxNSpBmrH0qYv/fdq47BZVJuEUtIFaJqkQU6ReekHlkOJFIOc
	grohYJ3i4BZZcqtPWsefbe+/LG9MXnrkcBqBYBsa01bxEfueJhi0ovCUinUwNFDHWEU1AkQeAYq
	C/e9dnBTWp9rkJg/R1DpbblUvSfG+jILnuzivEDeoQKAAzCMs6shsbilBy+gSEXVGizqNAlL+iH
	3fbWFkK9ZV8cLt5VT2
X-Received: by 2002:a05:7300:570c:b0:2de:aafb:fef3 with SMTP id 5a478bee46e88-2efb7bdc7f2mr3480656eec.1.1777882194518;
        Mon, 04 May 2026 01:09:54 -0700 (PDT)
X-Received: by 2002:a05:7300:570c:b0:2de:aafb:fef3 with SMTP id 5a478bee46e88-2efb7bdc7f2mr3480634eec.1.1777882193905;
        Mon, 04 May 2026 01:09:53 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38e71bccsm14247134eec.11.2026.05.04.01.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:09:53 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH v3] dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC
Date: Mon,  4 May 2026 16:09:43 +0800
Message-ID: <20260504080943.825496-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA4NyBTYWx0ZWRfX1M4TvS9QU1aV
 n9JswF0SqR4WYBGulc7sFCc96RbVgGLxc+qSiNZdKaaYR7zRg5VNfTAhZuxK99sNGfnDzkBVpHV
 38W6MozRnWbodX9ysOAAryoiE9p8u8H3i4PNKhf2TCZs34PhEL23JhCfQmpZWVtP+a7Q9B16yXt
 DM3gzhB77Y+EsNS1BpXsOdA/fH5mxleKsZ3YWnrYQMFB+cFcYkk0vuui74+GhO1pWOwN0amU1qk
 heQafFn1hHZoPsprmVf3PhinlK8x/HyHb3UwBU6l6Gdu7yhQEFULa34G3NAVxzjtS5XHX8Dkgz0
 yYymbIlOF03Ck+sx5z4zTwz0HEefxOOp2pOWcgEj1AVKPYVolG4MSSZR5qRU3h6AIeX7/gir6/o
 /hL6y42XWL4jcdJGkhhX5gjB4UaYvM5p6PadzP2c0dJTLrcygRn8/4gc+IAzk+h65oJvPvo+g3P
 NkCHDbH7kl/1RBxreJA==
X-Proofpoint-GUID: _RWHUZyndW-parE9bhuBEI2VAQ7kkV1_
X-Authority-Analysis: v=2.4 cv=bb5bluPB c=1 sm=1 tr=0 ts=69f85453 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gyBjFjMxxG6oYBEMJicA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: _RWHUZyndW-parE9bhuBEI2VAQ7kkV1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040087

Document Applications Processor Subsystem (APSS) SMMU on Qualcomm
Nord SoC.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
Changes in v3:
 - Improve commit log to expand APSS and drop "compatible with" part
 - Link to v2: https://lore.kernel.org/all/20260427011728.231026-1-shengchao.guo@oss.qualcomm.com/

Changes in v2:
 - Improve commit log to make the compatibility explicit
 - Link to v1: https://lore.kernel.org/all/20260420022452.1239665-1-shengchao.guo@oss.qualcomm.com/

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..bf29e453058f 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -39,6 +39,7 @@ properties:
               - qcom,glymur-smmu-500
               - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
+              - qcom,nord-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500
               - qcom,qcs8300-smmu-500
-- 
2.43.0

