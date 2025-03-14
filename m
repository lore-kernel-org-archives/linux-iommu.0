Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3898153808
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932563; cv=none; b=OytY3Ab7uo9SMwxgqytgvOE45tEggFNMqdEF7AWXdbHenWiXGIbT7SMu6jMDYFB+LSYUwyPBzFQQ2VP+5mIoUHu7oehzwilu4n9tCtWEwd0dlRGuak9exPpZMNRvLCGU9yTPsuTdsrwtpD8fuDVYUAQrw17u+IyJAHyCb91mC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932563; c=relaxed/simple;
	bh=BXoa02LSLqszw1KFDNTyhiysJ9vnQES6ubpi95G3uTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BskdEX9NsRYY7/fxrHXB3slJcc81jFoy1Emym1P30NqWqFe1C+orIfNUyR7wQzXkTqkXJPCoum6BNgkXCgsmN69vVaeyNASt7QdRQ7rFWkf2herUiZA/WYLWXON42cVmm34HlwqBCBMcoi656oHitFqdezjLAtmg5+dCz9aKwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NT7ioOSE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NT7ioOSE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DKEOS3003907
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	e+7zJBm63Lgp886dxKyB6dmrzG0t1u6zSCJPTB4/5Dw=; b=NT7ioOSENl9x1pN7
	GhD++rPfqHwgsbxWFRK6na/hnKSFrZoR7zIMzrdiZZaoSp1TPomAWQUUdUuKuFjp
	XRs7Awzg+4uSaGrvGSDGEw9L/Q5da4NanONrk5mY2GzYpkRn7scwKl8AtIJz54oW
	gMn6i3mOfi7LINJKrX13PlGwilXpi55xL/FU4j5+m7sIXePcvDsM2PT6J+ZgPuGB
	gVIXZE7U+Z3fTl5+nPMXZDqXUnfgoyQz15rHAKHV41Mvf6HVaN4mCga+bHlb/b7l
	rKKxU8Kt5xUHwxuhat9cCXYMkJONx3efdX6WPyMdzqacw4zh0IhcNHRtnrSJUpE0
	220jfg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45b96ye4k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 06:09:20 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e913e1cf4aso48017166d6.2
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 23:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741932559; x=1742537359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+7zJBm63Lgp886dxKyB6dmrzG0t1u6zSCJPTB4/5Dw=;
        b=W80QkR4g5MNxOLFGxzsz9uFNBWl4pNYbFxkEDk8VmE1HK45DKRQtUqLFZ+dTLv0+xY
         KMbH8rmmW4auKL2Jg8nlBGsF0izO38wMhlhEwgpt3UwGQW6DE4GGiSTdEw0AVu/V/9XV
         mX3NpgnIMlyPy7/1vZftrdVAzRc1t8u/xY7rdnqmVwS+pkIDIONCM7EmdDKja78GgM0w
         2oivzoL7cpjvBRQuG3e5ggHCMgXk5Xai3yxJZZzQwXLqZsA2qtV3c60PAlevPVhr5KZS
         8yyyLFfJVh4UXPaQaJx7u3VJOHnmmg4CNSnJjle+9NIzjyPoYO9skJbE3eXCLhH2/yH2
         d3kA==
X-Forwarded-Encrypted: i=1; AJvYcCUeqwKxYketyjIP21m1DerNTPivOWEZW+e8rgU+vjKJTuCNpLWQMF9rFIzMY+n7LNwk3Rgepw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKwnC4e0ocWJeDS6SOmfxwuFGn3g9mCPjevrsWoRIphaNB00pA
	BHm9lbuM2gGftM/AMg7W0iQ5F0Dr0UKe5irU/hs+z9XLDNHVCw9zNmtIECXIbaXIiEWnk/rknUH
	SO6gF9Ce/ccWwI0sJB1/27+XdlSlPaPaXVxSsWwSRgoMeMhY6mTZjGQ==
X-Gm-Gg: ASbGnctYeRPsn4IRUbdLD8NUL4pJcqTseMxSqXCfEZQpSMKoivJ9AdOfcp/ikKaE+C0
	qyBuNIEt0MiJh0tES6b/hf/9jpRyMr8E5mj5XMWs2pzoZ7kI3K426nd4N5EEDCp5isTl/YuuM75
	c+roDtqLYRgjux9lz6TH9nZbVho7rEN3VOIpbDWxsPLLABdxA52/W2/tnCI0sjf2R7Ef8SxGTHV
	5zsslXX36DVbSS96/Gm4KRiU82sgzvtqS40OacIVCxZjAytNW0irL0d89Kt3l7zctC5fnDYLslP
	RxeueQKhaP3T/tABUgD6hK3f35Ba0cN/rEDsIfT40SHdM5YLzJzsFIPCFu2Y9hgnPht1JEc2a/x
	Ej+xtM407agTb+XToq9zOGL2Zx94P
X-Received: by 2002:a05:6214:29c7:b0:6d8:99cf:d2e3 with SMTP id 6a1803df08f44-6eaeaa50d3bmr16274636d6.22.1741932559671;
        Thu, 13 Mar 2025 23:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBY0ZI+zd7SGof84c58nMntLqEKYAgej+c8q8loIMsah08MFhtIYr9H5cZxY3U/P0nrdLK9Q==
X-Received: by 2002:a05:6214:29c7:b0:6d8:99cf:d2e3 with SMTP id 6a1803df08f44-6eaeaa50d3bmr16274296d6.22.1741932559242;
        Thu, 13 Mar 2025 23:09:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864fc9sm416071e87.140.2025.03.13.23.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 23:09:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 14 Mar 2025 08:09:05 +0200
Subject: [PATCH v2 01/10] dt-bindings: display/msm: dp-controller: describe
 SAR2130P
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sar2130p-display-v2-1-31fa4502a850@oss.qualcomm.com>
References: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
In-Reply-To: <20250314-sar2130p-display-v2-0-31fa4502a850@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Bjorn Andersson <andersson@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=950;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=t96ussCqWyIQAdmFD81iVPY1jwLXVD8SP3JFMa/Qjfw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBn08gGCBp0k6HqW50FaN34vQJ5Qz5yfxDlRMZfR
 Hy6mQkyFMaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ9PIBgAKCRCLPIo+Aiko
 1ZuHB/9lbdoj5IXC26SOHHWE9rWM1DIEMbSoqxW7R/DA8cOCdd5rlC09Hhibvr+hOS1dKri5lbx
 PqMES4aCbDW38we3ofVviw8goSeq+j3Mw4e49cTDXnwYoJ4paRIATkH54k9jHFTVOzygZcXOV5Y
 8lGeTwgzz3fulM6aVtWAqS3pC1bMN6YTdZXJkd6LdmbW4CF3wO7dAXoBqBLQh0s24ktldAagAX/
 UV0ZWCH1KRIere7TRAUwqkaBA3ytZ7HNj+wiWV3X86TQttRABsBtlPZOxWk6TS9V2vzToHnKIMt
 vu2C0OEpMNedMhMjX6mUv33Ar8bGbJ+Ttp9PI74ToAN9F+XZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: K4muJ2bec740HAyWWAuzRmmZGHSQ-ZOT
X-Authority-Analysis: v=2.4 cv=I+llRMgg c=1 sm=1 tr=0 ts=67d3c810 cx=c_pps a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=qy0Ph95xh7xgto4wCWoA:9 a=QEXdDO2ut3YA:10 a=eRSyEd_ZPWdY3HzJaUvg:22
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: K4muJ2bec740HAyWWAuzRmmZGHSQ-ZOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=967
 lowpriorityscore=0 adultscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140047

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Describe DisplayPort controller present on Qualcomm SAR2130P platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index e00b88332f2fed2fc33f6d72c5cc3d827cd7594e..246bbb509bea18bed32e3a442d0926a24498c960 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -31,6 +31,7 @@ properties:
           - qcom,sm8650-dp
       - items:
           - enum:
+              - qcom,sar2130p-dp
               - qcom,sm6350-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp

-- 
2.39.5

