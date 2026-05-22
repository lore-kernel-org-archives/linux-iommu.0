Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5C3B7B7A
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444769; cv=none; b=DJdggkE9fBJbEhKMehXI7BcAMI5H2t54/9hyPa9lcGqRBYQ2/lt7ZHbPfuHGbij4wgRbhQ9OJq1AEzWqPNEa057Vl/PGyAwbe4l/BO0ebicCfK5hEAyfL0H+eD1mD9ow/vBH6GFkbW1w3Z0k6sZYByC5a5jVV6WTZIuNhMzrB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444769; c=relaxed/simple;
	bh=VXyPjRyCvwokK/qdzZThuxToG/yvYiuIOD5L6w36bck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lIFxN/kui2tsOgURWtElkaDGJYoV1S3LVhF3IPlSX89yrCC47tItaTcU9rAmjEN9nymmpUwX0suOxr4Hyr+VO0Valf+fVxrE/HMuWsBF2ZF/7HntmpDztunjQ4vVrx+iazwK8DW25AR37MnK9iMS5HnelC+s0zBGX1yEmU9Sbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BaHp0and; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jZ9JQBmK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaHp0and";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jZ9JQBmK"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M6UbMO1960034
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cokVwtObejHhNsT8CGzVLLo/zm8OUnIjAi9EaYJJAFE=; b=BaHp0and/uMoE7DS
	h5Sz57ZRPv0MyxT1qtrLFJF2OQQtbuHLeiyLzQU3sA8IHq1UVGvc6rXcdreUU+UT
	PAvSZM4zm+jOFT4WRJHe+UP3IjkTMwSfyyLeGvZux4Nn890yHF3zuwfufuOc6CTm
	gzqsZTvd39NxbrZjHvBV0S9XtKJp4x5F7R5aXn8Cv8aaVgUyZQV/SJq2FFkQBjjC
	yOcWhr4IsiXpTLVoSPEchgFBsaXWBQetjs0QQF1p7AI3z3305IY0jkvWjHVtiBpj
	rYL2rmFU7bo4bOrvjA2pb/tX3ysXfjiqjiYlWnW/fkj7hKWIaRADjGG8peid1swE
	dEf4WA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxes16v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 10:12:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so6441377a91.2
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779444766; x=1780049566; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cokVwtObejHhNsT8CGzVLLo/zm8OUnIjAi9EaYJJAFE=;
        b=jZ9JQBmKiwi8kPUUAnJNn7/Bmg3392Gvt5IfoJcEpJw7/gg0HJM6dkE15ie3DO7TZn
         8dHQHovlzEzhdqPbQngp2NAFDHZ66Ab647pKn2diWGCCNstUJ+I2sKfBsgWklAuArfae
         jdoJGQUyWoO6y55BQWAOmemuaCdyozBrMaaGxQxRwup12U4W8u13BhIu2Z5+dbtqAl8p
         f+N324aotGkUrue73vjSyg7BuwhHckJtp0uDC5eI5bGVi8lLqkHynfFUd07tX9J07VrS
         mwGKp+floIhzx1LcrZGsIuPdcnKvuZKNh7uZ+bp0LEVYBpzODYrGZN6WL/Hz5+gISD+s
         9Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779444766; x=1780049566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cokVwtObejHhNsT8CGzVLLo/zm8OUnIjAi9EaYJJAFE=;
        b=nJ7xwWXAYQ6e0ZzHzDzU2hdsXQQmw4NWBAfyUOBfVEewFpGpKVcnfhKMJhelUGyz5C
         Uy5GUvDGmCelPTgOyt7fevanrZqEj/6Z66hewgxu3bJrGfEy1qz0D3nE1fa5/uSXcsYE
         69sQJLhV5M0x8lqIT1CX6YjUwQ3EbvAcAFgdCSJRViOzUBbt3Jzz1kMv2FzS0v7O9jae
         zbweMvR35RTlkQeER72AvMuTdpUXiwmubl3/pDdr6ZCxBDnjkGMkhNYo/WHhxwfo6Uk2
         DZo7ZuAO2KYLN/pTYaFw/oK2/vSURHWkbdO121DYXhkWPFqUcEAt4Ppft12SeA7HCplm
         9NTg==
X-Forwarded-Encrypted: i=1; AFNElJ+IbPGZ/biClNFWChQUvwMMzO1anogAp9AmdiJKwUuUMenpdIxwV8UiThSx2fpUXeZo3uKsPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLwJ1YcKhcCyv1UbdjxIMfHrKr8VLG26cwVd+QLw3Mqmac8ImP
	9u0Rt8KDX+yEcjC5CPd6LvwMWfjI6AUhMVrZzQhrDcs5nw3mLyE9CR7vy/S9KFwAZzEBtjPWvJl
	WDNNCVIk66tNArCo937A/PqKp55U1605sDboXcd6W1W68P/+mNuwXSMEDMQ==
X-Gm-Gg: Acq92OGit71BHzP8tAKxkVN3l5R6iNthieDjCYXc7PKHo5DQwqmDDtwMpwe1ndL1uIa
	55EPORVpDzesXvob2BTrg4eKQPeANAtEmrvhgXd95GQ7ThYSHuKXmnncum2M6GIC8qyjGkrwXAI
	ZULldbrQcS46o+uYuAlD+GZ16rATgeAGhm9kygL4aC5+izOGlHti0N/NMoEW8/vRxaf9bOjEWhQ
	KdDlcmZdU4tUfqcmc8d/C3uZY1piBKT6dbirTEoE7/o8NDf2QhhgdoHmWzZithxJOJ2LvW4tgTT
	9Jx0WaJ27DR2J9CetZ6/zw2lF3hvVitGzWeA5y8wahjexjS0/5ZIO/K0QRzom7No4orpEJlqu9D
	ke9VMqdjPf/+t3yKisj69yk07esyL9aVSkaXcKGWiLF5/4Q==
X-Received: by 2002:a17:90b:23c5:b0:36a:7c8f:13c4 with SMTP id 98e67ed59e1d1-36a7c8f15c0mr757083a91.20.1779444766099;
        Fri, 22 May 2026 03:12:46 -0700 (PDT)
X-Received: by 2002:a17:90b:23c5:b0:36a:7c8f:13c4 with SMTP id 98e67ed59e1d1-36a7c8f15c0mr757065a91.20.1779444765611;
        Fri, 22 May 2026 03:12:45 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:12:45 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:41:58 +0530
Subject: [PATCH v5 2/5] dt-bindings: display/msm: gpu: Document Adreno
 X2-185
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-2-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=1562;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=VXyPjRyCvwokK/qdzZThuxToG/yvYiuIOD5L6w36bck=;
 b=hHmHtgDv/8JAzGDQHpoxO18rVqZunMZq4oxl0d3cCR+bDPnORL1fE/cpw/Xw180Vyv/75m9Dn
 jdLWruQY/RFAIr2sYPUchNZDz0KAyA6VsVna6zODm5Hqhh57SNm7AZb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfXy+R2t90i52DU
 NgVPBOITb43+MXhyKjXac7eYibkSOZXH11LhoqJVk2/OusoW8qtpuhpJpRWi4a42GF7YpSW/N52
 B180mZrY7WMAn6RgxLWq5AFegqSrODW4aym1Fig5ZHuhZ3L+gBE0HImIAVHshsx/xvMGAKe2KID
 Mr48mbFAVlimeBirNu46q1lPgGao8k/XdHwpsQ4GrewFqQl4CtiAkt49gJEkPBo84UDnEGLq6C7
 eUpQBqGOGXX/iEYEDYL5Zu7G68L/lCO8bGzoDGhU87w3sItY/PlqegmewISRmmGxXPb9xxnTRu9
 R9XMc2l3WywKtKcqSg2arqv5o81+PNg+B72FA4ZfVElwtCGUmVV7s543/S/uPCxj7e8XlI8Yk/9
 r0KAoMe13mdyIPHLmPbt97XKk637OJOrR2HoLiGsD9FvH0IRrwSfiiz+tbzE0FFeVH1nn8Flrbz
 +gvf7eZ2xdyxyAzDsQg==
X-Proofpoint-GUID: MK1BOAdgiu1EgPyh7iUVzBlT_IDC9RP9
X-Proofpoint-ORIG-GUID: MK1BOAdgiu1EgPyh7iUVzBlT_IDC9RP9
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a102c1f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220101

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..77caacd0fb3f 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -411,6 +411,21 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-44070001
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        reg-names:
+          minItems: 2
+          maxItems: 2
+
   - if:
       properties:
         compatible:
@@ -434,6 +449,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

