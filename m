Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A631CF5D6
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438953; cv=none; b=GnAHoWlEnCzgZiUVifEIoUEKjVLjHVrkid2FD9zSU2d3MnQpIIJKpumGDU04sQHdnx41RTCmfm41HOa8KHPzjNTjpe1SiSfEFo+1hGkOF9dsmE5YgLqc9PrY3kHkf5aANDykvv9r5ITaIq1qflKhdVo+v21M5WbM4eyGTbYMHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438953; c=relaxed/simple;
	bh=Z4565oTu+zyUCk9lj309fGvErxTKoYRkuT203TDC164=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MTdzd3AlvUr1gWcHXzyX53pApBRqf5UW8FPJFTzQP6LhENdwy4gQ8x7cR3PZ/Uct2WX/SWezUxYufmS4WuCCkuBv16AT2wcEx6kBhJjAb6VjJEq/Qgw/vK7A1L2RrkCJ2sJcnh4CgkMLUXWYfBvxyOP08efQOjc0oJwtz461x4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FOWTYfyg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FOWTYfyg"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483LZaXi026158;
	Wed, 4 Sep 2024 08:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UTiolnQxG8DHArbSYO6Te0tOPa/AHMJ8zy6otnKZu2g=; b=FOWTYfygTIhbNVMJ
	SKWjdQULle7FpLSo8fA3Tb85trsaVTuZvZ6KEJYA0SmAJFlLKSk4d2ctKsNF4CRh
	S4HkklKGsoqBUcVCHdERGTTBzBAD4aOcOuAWeUMWGHYG7K71eG1iIors/g0Q7ftK
	BMTQRec0DeRZjnXH6GwrWtmJD9aMb+Xw7D9C3sYw0ksBKsSF5rQMe72WQ/99IJcu
	fmHHz71PvmE8EMXmiGIgHHzKUbhbebQMcHpXr+1+K3010/OnYAN0bdkYNhGIRnYN
	UlYNdMcEPPMrC2Mf4ZHrH7OoK9vC5ylhTGUmA+mwig+gTqDiuwjQKkAWtQhO/BXG
	ul96Rw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt672609-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 08:35:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4848ZZdh003346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 08:35:35 GMT
Received: from jingyw-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Sep 2024 01:35:26 -0700
From: Jingyi Wang <quic_jingyw@quicinc.com>
Date: Wed, 4 Sep 2024 16:33:51 +0800
Subject: [PATCH 10/19] dt-bindings: firmware: qcom,scm: document SCM on
 QCS8300 SoCs
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240904-qcs8300_initial_dtsi-v1-10-d0ea9afdc007@quicinc.com>
References: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
In-Reply-To: <20240904-qcs8300_initial_dtsi-v1-0-d0ea9afdc007@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, "Andy Gross" <agross@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh
	<quic_gurus@quicinc.com>,
        Jassi Brar <jassisinghbrar@gmail.com>, Lee Jones
	<lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux.dev>, Jingyi Wang <quic_jingyw@quicinc.com>,
        Zhenhua Huang
	<quic_zhenhuah@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725438840; l=882;
 i=quic_jingyw@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=jpDFNyfFP8C6LOMh09zJnTGBEsvD21QyNOiTIjme1kg=;
 b=p0plL8+XQUENTs2xmOWdKxmZXBynqdL6Jlx4gKI8HNJu/FLSphukJtiJEe5snQIgVehqJpHIm
 z4A5JFSlyq6BUwQlo+PHoMlQ+XNkwRKVQQCzil7yB6PD3EVqQGuxG5V
X-Developer-Key: i=quic_jingyw@quicinc.com; a=ed25519;
 pk=3tHAHZsIl3cClXtU9HGR1okpPOs9Xyy1M0jzHw6A/qs=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fZ509vIFDRr6xbURNltYQRHB6ABmjVCO
X-Proofpoint-GUID: fZ509vIFDRr6xbURNltYQRHB6ABmjVCO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_05,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040065

From: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Document scm compatible for QCS8300 SoCs. It is an interface to
communicate to the secure firmware.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 2cc83771d8e7..f3ab819f812f 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -42,6 +42,7 @@ properties:
           - qcom,scm-msm8996
           - qcom,scm-msm8998
           - qcom,scm-qcm2290
+          - qcom,scm-qcs8300
           - qcom,scm-qdu1000
           - qcom,scm-sa8775p
           - qcom,scm-sc7180

-- 
2.25.1

