Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D251B9833
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 22:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725401016; cv=none; b=Br3wB/ofqGAHsIJ8s6EMsNXGzosTW4b8zQLS4RLuUxczUH1IGxD86Va1eaxeSgAiRluXt/zmixeqnhSSncnE1nqaOp5IJSZganMXZcuUWiqdRnL096tZF5lQPf/59w/TXmzhMFwjHcUgLhXmV/MSTWw703Qi+8RF8rnyi28IjkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725401016; c=relaxed/simple;
	bh=4I4n9MObgJlPz38I/7BDLtM7k6dqK74zRw3BWesIOqA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au++cdFJkjxM5zAw/h6Rm2INEuwiV/W0glcoRRLQJvUSMBxXRCsfE/1vgMN4+v6wCmi5JW+fNHWVPmJh3ohtDUwUAb0+tut7W3xSu2wx32gsLX+GAOuVcPbmJd0a27jzPGgO138PEkhONZCGDn2lSqDri/WW5HOf/CbaNWyJqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ohMWLyCV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ohMWLyCV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483Bxhaw020611;
	Tue, 3 Sep 2024 22:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6R7q7PjXWsk1rKykAn2AXbPTTLJuDd6qRIy/D9BrNc=; b=ohMWLyCVIEV0E3z3
	4KQX4cBMty0YFJLEBMIR1gykNiAC3EMHkr3njvQF9y3MQRAvMpmI/LpMZ251zJGv
	lTB4gsHNNyXxxHBYnFdFCMxm99tpvY9lE+pIFd8b+t+9OH5DjYDMeS2zahGKx56j
	9QA7a6GcFhklcoBl9OouJ9d4iqQHfzIe/rRThUJdsgiEPnHEC2KSYtmbPJFpFnH1
	6PEtyvk4f03IvgOrsCu3ngECMt0q5okLCfxxqai3iE6FB2eTXT1doRgOhvTOy0KR
	c+V2qk8CBHNNJHUAPyhpy4BavIcgKS4tCO1F9aFP9bRPJwZsQcwFOaqFYcGTd8Bb
	szY3pA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41btrxrucr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Sep 2024 22:03:16 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 483M3EC8028012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Sep 2024 22:03:14 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 3 Sep 2024 15:03:11 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <quic_nkela@quicinc.com>
CC: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <sudeep.holla@arm.com>, <andi.shyti@kernel.org>,
        <tglx@linutronix.de>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jassisinghbrar@gmail.com>, <lee@kernel.org>,
        <linus.walleij@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <broonie@kernel.org>,
        <cristian.marussi@arm.com>, <rui.zhang@intel.com>,
        <lukasz.luba@arm.com>, <wim@linux-watchdog.org>, <linux@roeck-us.net>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <arm-scmi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <iommu@lists.linux.dev>, <linux-gpio@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_psodagud@quicinc.com>
Subject: [PATCH v2 19/21] dt-bindings: firmware: arm,scmi: allow multiple virtual instances
Date: Tue, 3 Sep 2024 15:02:38 -0700
Message-ID: <20240903220240.2594102-20-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903220240.2594102-1-quic_nkela@quicinc.com>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PbS57Sdk2zhWnJ4YKRdK7iSWQHh7U6ak
X-Proofpoint-ORIG-GUID: PbS57Sdk2zhWnJ4YKRdK7iSWQHh7U6ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_10,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2409030177

This change extends scmi node name so as to allow multiple virtual
SCMI instances.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 54d7d11bfed4..5d79b15a1610 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -27,7 +27,7 @@ anyOf:
 
 properties:
   $nodename:
-    const: scmi
+    pattern: '^scmi(-[0-9]+)?$'
 
   compatible:
     oneOf:
-- 
2.34.1

