Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349E175A81
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 01:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777252660; cv=none; b=LYSjHK0A/bvNuWgJISYCz+Vm3zhzH5lVtHrqbRfrBsDOtdJllZZ5e3pUfa7t40xmYXtTnmwtB+2E05jY3hkHUwIHzGWeslkjRrHuvLsnqV5tzdMoQBdu5l7k8CTmzHJA25B0wVYxBAMqI3tcQyUolWG/Jpa9zifcHAjxh8VopFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777252660; c=relaxed/simple;
	bh=zJdUasQw5n6MSUZveDYI4QDlwGVoR/JI7lWHSlofxIw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgTyTZ6fopZW9xA2RGU/gljdhdsOfztWukJUfr+XJMcGZQBVEtX3ZJrUUTAeSBDnxDT23i/zeBJMRmQ8pS7qk5jYohvVNZCjePGCOD+q6Oyf7BaxCVCdHj7IqcM/dDpqIvWKrByTnWhQoHoHDia3csm1N/wIEP7ZSZVnj4DEsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3giS1M6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OwMUgKNG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3giS1M6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OwMUgKNG"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QKRH012148756
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 01:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ElxAM/fPS/X7Sb5MFzLSQ7x2z75vRG6KYCL
	kBKyeC7o=; b=n3giS1M67ekglqMHaOfYmzXvfeBY+xmxeKVrpB1SGGq0M1s+XJw
	wHhohA1tp1gxEupyY/2FRSv0kpcv9PCxLjfol1dWpxXgH5vTPrckMD2enTLtQS4i
	yaayGE/R5Sp5s7ZP+VT/C8iPOkWK5z5jyIZVT4ICiyYoERRmBLRa2I2B4Hhgp3k6
	TuVuhi14x2FLRnKoX4lzoHU2Dl3akUnmg8b052aCc3NDewLyjRE7Ai+hP8nO9QP4
	Rt4DmzJxvl8rq1Tsx/NDiANTucd4VHKZKdl0J1wlHsR+fL1h8n/bMwiE5vkC/PvT
	c4r+F6JHMGzY2rMNQsMcKPzgc/y/Dn3wTTA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnmr3vs3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 27 Apr 2026 01:17:38 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1270dcd11c1so6428102c88.0
        for <iommu@lists.linux.dev>; Sun, 26 Apr 2026 18:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777252657; x=1777857457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElxAM/fPS/X7Sb5MFzLSQ7x2z75vRG6KYCLkBKyeC7o=;
        b=OwMUgKNGwLfADHR3yXwGBvoknMbWDGS31icQi/LbjNG/xtvU9EIP9XlO0KD36qjLl6
         CtgFjRBajflHdoS18jhsrnxHoHqntk6mNA12psREkvJvYJ5V8K0uH4025DEws6N0QKLN
         VUKikaqSEfO8yW1MNhTflCBkUGKNi5y/CYeD5ojRynsnytaHNK5Vlkp6Sea9HnDTWA/8
         ROGSfQUBBj5eMJ0hNVgrEDGUgTFEbu8oNGXgRkzi+Wh1zB5DnVYMjb0rYvHpfrOg2vXS
         onMPjxpTJWUR80AvGUKqq3pa1cI3RFK+L7LivpIR8+fIAjOfXKzbkf5s76cjV/IAqEG+
         symg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777252657; x=1777857457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElxAM/fPS/X7Sb5MFzLSQ7x2z75vRG6KYCLkBKyeC7o=;
        b=kMt19g+xWCS5hgH14art37mywS26XyF1e1CY4LmUySNhQZKnIccpnSSOXH5NWW9aeB
         xVXqTV1tZ5oYomXkVudjcI69MSvurucwPVT4lHquAP4gNmXdGWn8pOmyg7dqTqJTg9XY
         xU+XZaeeF3Xid6QiMo/vUPsVfp9u2h7kVgzFmFlLIIbGe+7ffQJBP9sEMRPxIr+jorTn
         fz/+9gdfixBctT8UNRTI0l/f6Ntz79P5GtvitgBa2+2Nd//pNnKb5aO4NVkLReOpzIX6
         K0Qhkj0oVLAjB/FAFeVh6buFqOV5Fw/bZIRseDvoj52A2eqroCyJNFXukA0e5n0KmcXo
         hogg==
X-Forwarded-Encrypted: i=1; AFNElJ9O7kJ7oJU7GbMvTqcXN57x96FkH8OyBHe/LvwXcimIaGUrxUtt8vVjpYoJ6nxpYwilMOFBHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu8oQIF2GIG7UM0ed0sLPqObreyEs9o9eARNhbFno+NfkqxF0J
	M3nfraIsrYCm6X+xE1yZ2SK2tGnkQMb+yrczk8ydSf1kaNT5fYg3DdNDf/F3bZHrQ98SrS//4XF
	wbWmfGM5XQeaGVVN2/pd0rdOq6bEVmOh7ZMauSu9rg8Y8sCW8XQkXwuBLWw==
X-Gm-Gg: AeBDiesc4yoHyE5Y24QAeA4WUSHpIP6AjDiGhEkAgtSQ7xvhr0c6qqEPFywqK9lwtVs
	RnIuH1x29BKZkIlcUgrnt/24rfEWSMstfDtv3Xj3MgbeXbxEd1m6TuI1JXJ7sitwg2/zEjwMxb7
	4FnKyW17YdJ8mAypoJjRmOefKkI9592+gMAjIfATxY5k8jwSVaIJQv8ilLHcx1iiA+ILvHrcL3g
	KJ5LsJ8P0pDiYQC/aY8dnJb+aw208p+CauGQ95XrcxhGJe2mwko2+7TVbG7kn749wzovmmx0Qe6
	MgdDqes8/Q2Cw1eRY+zw7q35mWUFxcVKRKZ7vR+vVeZubi+YP8Wt2fbXuPPmHctn6+P7n2grMHX
	WKrgVymU8jhiELnO6SfrDlOvpny7IkngujjAu333VyMj3o4q+kduyi0sEjWL5Wvxli5NdeUoNc/
	BcXzPWraTEI8CLiK8M
X-Received: by 2002:a05:7022:23a1:b0:12d:ce34:3f97 with SMTP id a92af1059eb24-12dce34406emr3465933c88.31.1777252657143;
        Sun, 26 Apr 2026 18:17:37 -0700 (PDT)
X-Received: by 2002:a05:7022:23a1:b0:12d:ce34:3f97 with SMTP id a92af1059eb24-12dce34406emr3465917c88.31.1777252656606;
        Sun, 26 Apr 2026 18:17:36 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12dc6f08eaesm17182104c88.12.2026.04.26.18.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 18:17:36 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: arm-smmu: Add compatible for Qualcomm Nord SoC
Date: Mon, 27 Apr 2026 09:17:28 +0800
Message-ID: <20260427011728.231026-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aqCCzyZV c=1 sm=1 tr=0 ts=69eeb932 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c0LU5v8-wekVdGmAq6UA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: IFsjVwourEhGJnQd-s4Y7d-Tvn57blaJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDAxMSBTYWx0ZWRfX2zYRhQ1Vpnx9
 wodpu9jgBw7vrqqugjf2aiFVMzZMXsPX5XatCzT0Y/0k6vy4H7sgqcVEcFCKHn6OaDnaZKqzEJp
 aDrc1K8+thGAkF/dpeIe1bjJ4XydXeRsz6NooO8HowcEcHU+9my9LE03qgViDUiB2wMDNo1zWY9
 f6I1+i09b++i9IHrBoqVnl49DsrXZo0LyYHv/hhF+/qylxZilaPimi1/Kf/mZzT0lVG4lNMcBfa
 4zp0a4vy5wel4tfUC4gSmWHltjwswAKatqIKbaOz49FmQw1PaQgUrsL99LslqiID64bvu5i9fjO
 thY3Z+x0l9kyTntLkWHlVCVvmmERfG72OKSnMwKiK/GJMa8n4259HzN+vKCC3qOFmMFIK8n0ciH
 vC5wdkFk5etdKm2oHA60Iy4Ufbmr3ka2nCBvpyZ2NZQBm7JuKM0SGK0SoN90x+Iuzxa0dpf16b+
 KfhOdjiuw4T+X9WOwYw==
X-Proofpoint-ORIG-GUID: IFsjVwourEhGJnQd-s4Y7d-Tvn57blaJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_07,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270011

Document APPS SMMU on Qualcomm Nord SoC which is compatible with
'qcom,smmu-500'.

Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
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

