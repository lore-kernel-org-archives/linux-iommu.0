Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF69047ECC1
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844234; cv=none; b=hTAc93BT5qBrFaB770V5otBMmy/rBOLleST1Yoke3Wuy2OUaU46xZgH62bVxOxWBPW7nRAG2GPgOZs8UNttlVcqD10BbWJP0hrmPR26FZyxh27JE/UDTydcI9SDEpzEpkV8F5ODhH94uoLIamWSN+bLFZR7Fmbu9sY1os1sAVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844234; c=relaxed/simple;
	bh=/DvZZLK7RoXoyIRcMfNXJX52GjyEq7ffyO8JhHtrg7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoxQT6n3ReMsPbzwR01qkqeLia6u6P4V1emPepWxQ/mb8AMNVEr/qeVLtoWxqsjlgsJxNgfBojiIGBHPn5r1PO30elx038CfPvoGojy2Sw1+2kH0bRdJ6HzC3x64xddKLIWCkZXDkBy7Q4ujt8o2jnTPBCI+DL6DBN/FUnUepl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p4UK0mjV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dgIu5Oas; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="p4UK0mjV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dgIu5Oas"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F95dWI1714959
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aRznaYXGx0v+j8rw9+afGoTRNyTfcmX12+yAEiEoD8c=; b=p4UK0mjVQ5ePLlm/
	+4SIzuq+6RxI098CAYQ0webZ+QYCElXSw47OkE+4zwrPbXd7PRqfv1nor1LY/NqK
	g9yRLTD/EEGn/wQsSYmxzGJXjdgkUzpU7YHP+H9mgWSn4zub/ne9PP4vf3UKiaVk
	/dDu4j8CNMSxg0+UqC4W/96EMdUyBu7LlI75V2ic44tIXwK44GPqnVBrgHFTn+ON
	GcveOXVCyerKZVo9GqRf5A1X4yi4mKIb0tQ+ixRA1qH4skGMpgP7B/+G88XxIrdw
	ng3eCjlxJ8LRUCgnLdlItQi7iByjHrjyB0SNi3Up/d+vAprqum0DWTP/rBPI09ek
	xnx5zw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxst4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 11:23:52 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-368edd5fec4so4563376a91.0
        for <iommu@lists.linux.dev>; Fri, 15 May 2026 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778844231; x=1779449031; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRznaYXGx0v+j8rw9+afGoTRNyTfcmX12+yAEiEoD8c=;
        b=dgIu5OasSLuC/31JkQgNDM762/YzZNytkxPgnAPozi9xC5Nl4U5huAsObKY5Cn6TIp
         P6FTX433gc+0gYN2OgXUEkZ9g4V7fQ7X2Dfry8O6WpC5NH1RMfqrmmyoig8NNjHPXf8W
         VJV2BZx0OPdZ908L0Twu7k8oQGJkdDxswE831d6eKILVGwOpA9yvR1GFjS6xbwSTEs/T
         zaoaKJ41/ADoXtglEyFmxcztKsYotuiUNR/wx7K0Gko/HPVYwc39LMXUJYEw1z8irmw+
         BRBQYQM0r2bsPGiiwmp28Nvq33bIVBLANPR+IZr4/lAWmHQqun+0eR/Rau+a04ToRuBU
         3fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778844231; x=1779449031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aRznaYXGx0v+j8rw9+afGoTRNyTfcmX12+yAEiEoD8c=;
        b=pLJ0khYSkMDICYjR7ECtdgxZkUF+pZWU2nfouYYhqebLIV73Q6y5aMh74+JVgrGw0N
         cDXmA2GGww4P96sbvyw9kswXUk17OMhUZDsy2BuXRCCrt1JO0zbS0Sw21PtC8IOJz10h
         nBgSgOKOEKEbMYgeaaALQjkLkBPZL/CLwj4onl4yXeg8L4y3S5VlKwcsdeR07RdifWyu
         Yd6ICbMbUgarNKCv0VScgp+WLOOallplAhkn3O+YmUpEPJG9bJXeG1Fwg/AAkUI/pyDF
         7xcpmSdGXLVyJqGLMXZuCs2RVkbQRfsRs6/r8zim2cJ6p40lJNSXaCL1IVzrMUk1bkNf
         MkCg==
X-Forwarded-Encrypted: i=1; AFNElJ/XZNUTD4nfwEd66FJ2zuYajrg64cPg5OkKIZFnzRScY0JRfq9iD+5R5mhRikMgoCQ0mkmoRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGgtINwrhEbGy8co2un2hTnXego6ttybekob42PceCER5dB9Z2
	9CNh3GdxS2T2KQXreFS5XYm3sYtd5oOieoDU1in9kozIwM7TcRqut1SP1Cn/OwHsj3AQ+jzaaEP
	azWQXPoo0wrSuo1nnar6l+NMMNbd+aQWdqd5+6OhEwwL9Oy8yLLUob3LV8g==
X-Gm-Gg: Acq92OHKX7VWsOgf3Rl9fKunKWCNuLv4Xg0uiurmGGSHvC/sz9lAtZQetpQwP/Kj/cy
	isQxFKNxgocrF6uNEFR0q0a6QJR3jM1kazxqz8Qj4mf5tBi1mH7tCd97Zk9Dlxz8NpO+mFb2ANU
	CLo+D1QEYdPBxpYfOXYjmYnGcZ/ulwtpOX4Qfy/dfNZtp4BGCY342vyVP3n4jrojBqnfojcYm3k
	fWu9G8cyeo07+69H6qt+RilWux3mX0ZpwwmVA9Rfgc77dw2hU+nkTyNykKWES6HHTw1IT+jtsjA
	5VnJPhXGMvUrS2TyKmqA54iF7Ncd9DdZES5PtDsKROlmnGfgQjxx7sg9/C/5JcrkZ9PNwWjEjkZ
	7hDDnqwT6/LwAbCa3c8PAh0XAiJ84cn7XU/m9nwFrF3WEhBTiVBHP/ps=
X-Received: by 2002:a17:90b:58c4:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36951895b63mr3504176a91.2.1778844231444;
        Fri, 15 May 2026 04:23:51 -0700 (PDT)
X-Received: by 2002:a17:90b:58c4:b0:368:b4a5:c4dd with SMTP id 98e67ed59e1d1-36951895b63mr3504129a91.2.1778844230955;
        Fri, 15 May 2026 04:23:50 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36951584654sm2476249a91.7.2026.05.15.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:23:50 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Fri, 15 May 2026 16:51:19 +0530
Subject: [PATCH v6 04/14] dt-bindings: media: qcom,venus-common: Raise
 maxItems for clocks and power-domains
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-glymur-v6-4-f6a99cb43a24@oss.qualcomm.com>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
In-Reply-To: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778844197; l=1499;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=/DvZZLK7RoXoyIRcMfNXJX52GjyEq7ffyO8JhHtrg7o=;
 b=6A0Jw3h5Vd94IDHzZQvQub5VJlKlGcYOvPs6oSe7K/94TXwZygg4g8Mq4ZD3MJ4wrbudfchns
 SFEp312OVgjC+7B71bLPg2CSrzm/xsca32YE+z7XutZ3KdXXazyB1P+
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a070248 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=xA1TQA8hIoUvplme17oA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: tyXDJT_p5EsivIV3DfjpYsVkFUSB6j_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX288nAhnFubmA
 OXCE4U+XqxITOUJmUnSwAljFZUQU9scoQ84gQcAW0stRRpO+et4R+Z7nCYVXILL7ndNUPc8oDSE
 gl++CxAut4kSt4YFsnCXE33MwDTEIHVvWO5+DswD/mf9lT4yQBYPg6fSUytBGy1axOoJ3n0XuOt
 F0pjT2hQumFG34tsBC/VhI1y2wGBAlTiEmI323aEZ42fdkmuHk+mc7rCF27oUcZBLQCD+ITn9oc
 H553zLNY7BHW4rNrUP6K5nQWCuPJskp0wzhMKQ+jg0WBBET61Jv+KvtrtSZCwVE+J69cWvSmVzJ
 Jm/uQMvsp4xmbhAdHyezjtIlyTF8agyLqLQOybr/xPlTIGJOqhImsNzHe8IXh0j5fkiuhyf6mVc
 oygR4SoDgxZIAnk46Im22nJKP15b+i/gN7CYjgZdMZcr6O+GMuqjB1YBge7OU7IVwJsfbxSijUe
 w6+AEMKWsjyte3/1BSw==
X-Proofpoint-GUID: tyXDJT_p5EsivIV3DfjpYsVkFUSB6j_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115

The current maxItems constraints for clocks and power-domains in the
common venus schema were sized for platforms available at the time of
authoring. The glymur platform introduces a dual core architecture
that requires more clocks and power domains, exceeding these limits.

Raise maxItems for clocks, clock-names, power-domains and
power-domain-names to accommodate the glymur platform.

The glymur platform-specific schema have fixed constraints for these
properties, so the common schema only acts as an upper bound.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/media/qcom,venus-common.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
index 59a3fde846d2..10716a93dd35 100644
--- a/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,venus-common.yaml
@@ -20,11 +20,11 @@ properties:
 
   clocks:
     minItems: 3
-    maxItems: 7
+    maxItems: 9
 
   clock-names:
     minItems: 3
-    maxItems: 7
+    maxItems: 9
 
   firmware-name:
     maxItems: 1
@@ -41,11 +41,11 @@ properties:
 
   power-domains:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   power-domain-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
 required:
   - reg

-- 
2.34.1

