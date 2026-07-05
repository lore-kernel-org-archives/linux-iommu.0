Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019936998C
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238488; cv=none; b=UVZO731YPO/KLlkYwF/7Dd+zLW2/1M+P5KFSUxUs2NdTyy8DeSbk1QmIc/OG4iqvXi1hAsoE2DFJvdg0vAV0VG4DRlB8XpM9rpUbZr59J8Kw6Lgb+y7NQUCjAfnFVBoQey2FC5LNCYz0mKj/JY7C0uth3tVB5e/qLt0lTiCOWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238488; c=relaxed/simple;
	bh=tmq2w7iFHaSf5G1N9NwNT8S+dyPrAg6brA02Af+BVoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNqkgR22RhINrt4dE7+XFML/gy4M9TTYge8bStJahWaMv0zquOxitnXb26cKQEP4cydOYuW4+ha3GClnehFAZRkZO7L4RDX+dj6+f1OooNmPMbRqJmis08LfJ6VnyCtGLJYvsz77/wCBWzt+5wPX9KnOC11kTPXnXZlBR1i/GmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VUdwCw0c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3KKDRib; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VUdwCw0c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3KKDRib"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6653WdWb616158
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B2tXzOW+S2Yl0q+Uq06qicu2OVLdBJOKKhZnmt9rVFc=; b=VUdwCw0cILZ8JMr4
	3q2tqSbWj2siraqnE8Gnpv7whpKslc9d6eoRsi+NbHZmhTUdXk+w4NjYYp9dHmcl
	kWeHfhNilPqHWc1uYnY/EqWiA2RCxcx8H9zHxFijKH0xEVPjjdMWp84IcfsHtsQ/
	qRBgwoUpyNkqSl/7A/3mooRXdysh98qMNDe55QMtytTRkG/3uCtLYP0nJZg39dcw
	V4ZTJ6vBLZwUthTvkMP7nH7ryE4RvGTCAqNCLNtj7o+cs6u0GIPaPicWyVyqj35i
	CjZm+Cn+7Q/c0p3+yynKA6Z06hEwlqbdDMyk2VZrMafLUV11hsuLr16B2STe8iql
	ni/eHg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjbpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:01:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3811ae55313so1522888a91.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238484; x=1783843284; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2tXzOW+S2Yl0q+Uq06qicu2OVLdBJOKKhZnmt9rVFc=;
        b=C3KKDRibKHpa/cho+wl3AqslU0DFWVKGtILnAnGszAOSY+6dcYBgxjGiTOc40EqqQt
         LWINnrmdYXO6xLzUjg+0ht/7aVtycw5Y1RT+cIBrZ5qiPvMSPxTFEfeLrOcb6Uq5dH36
         8QZ/FK7ESoL6rZTnP6fMzSZEW93oVxubmQrX3e3DbMJ2Brog4+/YK8XLVaNsb5xbYyxR
         rOwFz6SWMkYMIXSFgrWHIAjbNpyleqdqRbvnfm/Z3OXbT9doq8cE135V7KjEfOAhaoWL
         WlEvYxd8cUeNW+4dRc99xzuJ+sfRlgVcmUhXwvJUSAcUPNdVW8nKPhihXGhzUc2f5RLf
         lZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238484; x=1783843284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B2tXzOW+S2Yl0q+Uq06qicu2OVLdBJOKKhZnmt9rVFc=;
        b=HoaLLSRnIhXgaL5Db6QIYPwsiqnngoLcHcPR83jBDe1hjnGYDSXSpIwnfStqwWZwhG
         slh77n2Sq9GBsIPE+Er97h7VuwAG+Aupa8yExSBzInWAtphN1F68nAUdZZcmjrxHzOXy
         IQUECqVctVE0fhy1VjMOa2PF3fCvQ38Mh6MRh4q2CLAOnZw/kC+Kgq6T/GBb3BSPBPDB
         +WwLVvIZ/fLOwJyXC9MrEPWh7bioTNF5BthhIlASfjzLPwVFOEq/BTOdsMBMIlStLhmg
         GEaMINFiIR1Yk9Rwb1UdKpCvl9FTFs8Xxvghwf91kja2qI1jIHR2aWvEhrpDM94aHPEl
         aeGg==
X-Forwarded-Encrypted: i=1; AHgh+Ro6SgSbBEZ9nTG6FyZiC9InVEyLW4ezR0mBjM3YNB5Y0hBTSUv7ATuulcKx4qJ9DnzDgOy9rg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrxYCLKAiJqkXJqAInt+9LtXaJ4uob1rw1LdqgLsrF8A/cVAeL
	On534WRSbDQOKjgo0bGuVyurpX6T1lTUu8x7XGDJz8UwAvK0aHiyZxVtg2hKxCMtrP5flALfIx4
	bE8Iz0kRe6EFpTr4oHn3a5pQXvsgJowJfcjIlq/rD/gn5rr0KpGTJ2MWmZg==
X-Gm-Gg: AfdE7cmOi+6fZL8KtKpvFrnXGi1pWDLqAgmOnwGMQI/W0OanuEDBxSBK8yHwjDe2bja
	Dz1uw7jxIoy9r5pdkq9If2WQTj2pHN2DWNQwZXP3GvRVo9zXDLnRklaDRONnbC/T5Z+IEvN1Qfe
	OYxAbEnJJH4W6zPlHQp7ADlsW5IjYkJx6KEB8pUwLG2yWvIXQF0eb+42QKGoZhV0aSaNpS8sVRx
	C5QFS2ijS8nDmjamRCao5m/vk/Geu7na6mXvd4Ol1n3Mro3FcsTK7f+MLaT7r7F95SbwUdDP2r2
	Ex+gCoe8W8hO3FPhQ4R3oPqxFchQrCuLBcb6x9Hq5050b3QnHhj4Kk1pxEYscEPHdySsEzdh4DR
	xwkJgk4U0A6hWuyy33eL9PKOz4YpP3Fw/G+w=
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-3829effb428mr5736677a91.24.1783238484393;
        Sun, 05 Jul 2026 01:01:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3808:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-3829effb428mr5736407a91.24.1783238480880;
        Sun, 05 Jul 2026 01:01:20 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:01:20 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:08 +0530
Subject: [PATCH v2 4/8] arm64: dts: qcom: kaanapali: Add QFPROM node
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-4-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=1012;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Rh9iMVK1VvEe82MbzfkSioOLphwmD07vDxc9YOX1LZU=;
 b=QirepiWSprygCdEJpVf63TbnYQtCy6LXKokXYpNSjgpaqD0KgQ7t8Cn3O3YrHCcD8otxXqu1H
 DORiZTSw4phC+My0GtSwo9tg4NvRUijt3W7PfDvv2IpCpJBeYGXq650
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a0f55 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=doS3iEISOceegCkkCwMA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: KLjaHKsMtdawEgcBQneS7WnQojO2giqR
X-Proofpoint-GUID: KLjaHKsMtdawEgcBQneS7WnQojO2giqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX+rMWjxTS7Ld6
 mmBVz7vFHpbUp+ML5SrvnxtrDyKRQ+IG+x6LVWMb8cLC5sdSsXhV9rwbSLMY8fTmldgUa7xVqZK
 C67dA4G0svJOnuKJ+tGDqQuUhhpnXkYZM5lS+ZNPyTIOOf9RsdaraOwDbEyy0Zfo2Fe2+D7wOuK
 v0bwS/yiIeBknKIsv9iaur5DX3TcWxngF6KH/iY1Nnpa/DNyAqEULqWDL87YK2dhbTXXiJ15ZXd
 3ae38hX0Zm58hT/HZ218LFuO2IklnBOp453hN1fGrUjjXkE1Hg1pVZCU+ATgX+YkXy/2JVkfunM
 Pqzb3UHW/zSbN3i4A3JTXcgBcqcwWFHWhPYW2h9QUAKOOMwXbgGvTpELpJtgwJR/RRYvvnFagk6
 XzBcUyZEM2J9WMtGa7seI1JT8ue18ADpmQGVoQ86ZZhd/3WvSQfWJQ9LE5WmuM1suYBkd/SKXX+
 V3aG8yIDQEk4JCjC0SA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXwt5+OQt/YIIe
 kO407QJFMElokX2vf9ElPRGksmly+pnO7gdTTRy3/3W6z+TOudfVNCmQ0TceG2E8z6ZgObj4IYc
 Sfa45+zydHqDq2kCIugSCOHdR75+UEo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Add the QFPROM node and GPU related subnodes on Kaanapali SoC.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 19eceecc2a19..8f71f9dc26e6 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -5874,6 +5874,18 @@ rpmhpd_opp_super_turbo_no_cpr: opp-480 {
 			};
 		};
 
+		efuse@221c8000 {
+			compatible = "qcom,kaanapali-qfprom", "qcom,qfprom";
+			reg = <0x0 0x221c8000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@142 {
+				reg = <0x142 0x2>;
+				bits = <3 9>;
+			};
+		};
+
 		nsp_noc: interconnect@260c0000 {
 			compatible = "qcom,kaanapali-nsp-noc";
 			reg = <0x0 0x260c0000 0x0 0x21280>;

-- 
2.54.0

