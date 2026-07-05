Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10635676B
	for <iommu@lists.linux.dev>; Sun,  5 Jul 2026 08:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783238453; cv=none; b=knlQDnt5qtomiCt706I54bZ3Swre8hR/U/HlXJDA7wBZl+TunISM7yIyXVY1seCtRKntYbyf6N2fYdxSWXHhM0RaLKvJYuAVFGxFtOsBNkOMuCocMG4Z0DfV9OPmqprOQ91awYQBmWrtuQtmPx6kz1+XQFABOuIzLyjHb1xAvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783238453; c=relaxed/simple;
	bh=URQVb9Hu2fuzstaA7s+Dd/pLK/dbkCOd1kpmgoOBjng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DRZLZYhhFyOfYdJZKv3hBvam5vP8DjhYXed+4Shl5xiztbGnnyzBIpGF3jLY6JjNNeKvXrQZwAFRDM/Nc7T7uTOlNzDwkdDL3AZX6BaAivvDJIV7hhfCKQTOxWeeZJ+1RZkd5B0ssLbmgJ0Y9TAS3OqReLTPpyf37VdkxP+cMD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g785812M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KxP0qDfI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g785812M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KxP0qDfI"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664LkAFQ4114535
	for <iommu@lists.linux.dev>; Sun, 5 Jul 2026 08:00:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=64k8OwOX7AWdYCpKVex+ex
	yN30K4FzzL3yTqY9H2RBA=; b=g785812MkR0jeIIjz63it8ak8hMvZM23hCqxHL
	gAHw3y0GSU5IGzSsY9Lpyq5hDQM1iUrR3VIVHkI5EMkRn1WCYAOjN9DqbHyXNOnw
	b30ETVxc0qcs+HvO79XUz2kfOSqW5FmG2K2pCfdCRf2+qPoMoN1ocrj4DpNH5HuP
	+ckdGGd+ebrMBZz6AQ0SPXxi7KtfJCe6U/vEfPRVbB8ue4zM5vqJS5uuzPQIpT09
	I6kK4oO5obWjDAceULaMtaTmiUNjvrO9zw0XS+dYxXBCMgxukVlRPdiSWJJAaBhD
	FmpaGiSw2DWjUnQvlM0ljmJvXB5T72eCVAVgFDNayaM2ctEA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvjbme-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 08:00:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c916d17dd43so3017468a12.3
        for <iommu@lists.linux.dev>; Sun, 05 Jul 2026 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783238450; x=1783843250; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=64k8OwOX7AWdYCpKVex+exyN30K4FzzL3yTqY9H2RBA=;
        b=KxP0qDfIW+38Jx2zH2JjfTmGRRKTQeZ7fwHgp+fP2W00YHVSLU1tOcCq02QVbIcUQf
         f+e3/woQl0dZhccAhhcecurWSEpXEnhXY/XzIEZMAxD7mPkBEl70tUHaaKAEwzb7EBWu
         owLXAZBcm5pla6sgIDcHvCvwEoQW1REOMnXYSN6JBokQZBG2P4k/loIeVdXUnOXGyPQx
         YvIFf3lT6aTULwLqa9vcNfaloYfxq4K4xijiuxY7lQdD60C/EPZO+142GIkwwuNeIU1w
         MeHYN1oNFng7HUH04EjiSVL3nErdBC+ivR4CXmYHbIjaOx6ZiMC6HpgIzgAMMOFUHuvO
         96Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783238450; x=1783843250;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=64k8OwOX7AWdYCpKVex+exyN30K4FzzL3yTqY9H2RBA=;
        b=dDxtC/pw/mbW8KlXBU+ICqabtj5DYEPd20t1cPAUav2hldv8pIH7ZZMYuSeqz/s+/l
         PHnVvT15AjiMnwoP7YP+JSO5NT5evrtE8PU4i3vEVrzQXMIMrXj3cW7OJUaLGwuGdc/U
         M1jCZQ06GSosXersiRDuQPtavm5UQfDBLpc1O2iRQVTrEkwNMj7p+yyPPHo0yWK6qohu
         lK898g5anlT4U43gIHaUj27kVl8hnj50dE09SGT8rIA4OPDPX/cxTSqMxP6Kl8d0VsUU
         Cp6nEqlc3r1xIeRvK041/AL7aGetUF3ckVGvdbm4gnucdPQBO5/gN+DrpIOrq2gCxLeL
         Fcrw==
X-Forwarded-Encrypted: i=1; AFNElJ9WTkRfv1ArjH4oq343EjWUMGYTl6CPEkFZGgR3u5nOzSBHDRlfxnusZ8hBdAB4vm+UCiwypw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGp3TXvrKL41lbcoxjehvy+d4YAOK+oF4QOWw/jlOE/HTyhCRO
	8Tuofofe9s4tE0n6qIxG5tEjTHNDzW74vDfouoWr9Rz16pXXbquNGhYCARIJKWyy2SInY787xes
	tXqM598mjugqIiFbejsXCdGNDCKKzvJU3TzN21bDqWy/Q8jn6v2Bq9VYHHQ==
X-Gm-Gg: AfdE7ckCoOrmZQAKJ1AzkBkvpbM0T7fJEVCoHmRSSjyTgj/RsGvAwnZWvl8ODn9+FyL
	6BGC9GH5tbxvFFnexlqDWMjkSojN8pt8640H0EHNTZWpOO0aFinBOtBlz6B+zJ7xkpe4lyx/JAu
	TSLUYOsHTXEsmi+VFbkQR28uQejgj7BowrFz4DODh1qL+4ckFTzbWsYFScJHTvyU3QvO/x2+Z6l
	JdEefPhDf42WY2WxJItl7VUW3O5x+2D0kpEnL6QbANqSIgA2GnuXKyrjOy6vm6vdKTHB2mu/RCA
	RTt8l4wQIEd8z/6YzifoNYewf4qI32GAwFQu7aKvYeL9ha78d/mlEqKf/srWvHhG52635Hy+cwo
	ZKwL2aF/KG1oYscuRTUkQYKUtPTQaksPZmYU=
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c08:fb8e with SMTP id adf61e73a8af0-3c03e5916e2mr5800997637.48.1783238449832;
        Sun, 05 Jul 2026 01:00:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c08:fb8e with SMTP id adf61e73a8af0-3c03e5916e2mr5800919637.48.1783238448966;
        Sun, 05 Jul 2026 01:00:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:00:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/8] arm64: dts: qcom: Devicetree support for Kaanapali
 GPU
Date: Sun, 05 Jul 2026 13:30:04 +0530
Message-Id: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQPSmoC/12OSQ6DMAxFr4K8rlESppZV71GxSIMLUcuUBESFu
 HtD2HVj6dn6z38DS0aThTLawNCirR56D+ISgWpl3xDq2jMIJnKWcoFvKXuJzThj7fCWX2XBeJI
 qIcBHRkMvvQbdozrZ0DR7qzuX8JSWUA1dp10Z9bQ6DOaCJXAEWm3dYL6hzsJDItyz/88LR4Y8I
 a5YoQTL2H2wNp5m+TnksR9Q7fv+A5p/DTXgAAAA
X-Change-ID: 20260412-kaana-gpu-dt-968a70134c22
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
        Qingqing Zhou <quic_qqzhou@quicinc.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=2164;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=URQVb9Hu2fuzstaA7s+Dd/pLK/dbkCOd1kpmgoOBjng=;
 b=A5ueMO6pkv7W0jq9M8lYGlP/UQ+N8qJKQmdwVe3f2yDx/gBZObWVIlTiApffHVD2KMvafWnGI
 Wc6rXJ0SU5iDxoEkZ987rQGNfssS9UD+04+9JBd5Mg3XhOBdesECS7a
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4a0f32 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RSuC8zd2ZDaJPqFJxW4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: BpF-0Sf3rdcKdYwk1FXa4TtVK3P4h8sS
X-Proofpoint-GUID: BpF-0Sf3rdcKdYwk1FXa4TtVK3P4h8sS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXxjoGnb8TCFOq
 wtn0KpH3fBw1Q+DJiaEUOW3AxJFNXBXyDg/y7Cf8u3gqPg54e+SCgoO8ZQ1EaA8UQ+2qpmoiAwW
 BTnnAQy7Ts5lSEsZkrnE3AtEcppWZME4Glmn3USHuwAiF72ZKYOagvwDh2xRDN2ISGaxijP9pm8
 hXarP2T560r4B09wefe9amTxe0mVN9GxHBKamlEECoLW10zxBTVzj/dGu9kzMv8VLbD7wwEnOMB
 A9QDia4mYT2Pv0mOPqX5I8hqKInFlwblc5Hr5JQWaswRWw+b0T0/v/yvVIZ6Ts6A1Poc+KRJKBX
 MejtYOcQ9rVq4KsBCvYdHUy/78DuTlls5ua5KkZybPdBwhxSmwb1Yf5i4twSFMuHl7xzJbfixo+
 9X7Yoa1QoaMVcpP8inrQ6OVMrTdkIRF91rSFPD3FtU9c49DNOMcX5oR2nMOS3o/ZbuuwypvQlny
 B0R0S5H5Wgbm9tWqVbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX6s9TDYYPzPSD
 n7Woj3Mzxhgc1puokUGDK2+UCU9Qwic5jNmTCBVNgVdlAlD3ODKA4ubL5rsbPy90mritvOozbfb
 8f9hxCJph8TrsO4qBvMSGhJC5UuAPIk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081

This series adds the necessary Device Tree bits to enable GPU support
on the Kaanapali-based devices. The Adreno 840 GPU present in Kaanapali
chipsets is based on the new Adreno A8x family of GPUs. It features a
new slice architecture with 3 slices, raytracing support and other
improvements.

This series includes patches that updates DT schema, add GPU SMMU,
GPU/GMU support, GPU cooling, and enables the GPU on Kaanapali MTP and
QRD platforms.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Fix formatting in DT patches (Dmitry/Konrad)
- Update cooling patch to lower the polling delay (Dmitry)
- Keep both passive and hot thermal trip points (Dmitry)
- Update GPU OPP table to match latest downstream version (Konrad)
- Add a new patch to allow HFI related structs to accomodate >16 GX levels
- Drop the smmu binding doc patch as it is already addressed in linux-next
- Link to v1: https://lore.kernel.org/r/20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com

---
Akhil P Oommen (5):
      drm/msm/a6xx: Increase HFI GX perf level limit to 24
      dt-bindings: display/msm: gpu: Document Adreno 840
      arm64: dts: qcom: Add GPU support for Kaanapali
      arm64: dts: qcom: kaanapali-mtp: Enable GPU
      arm64: dts: qcom: kaanapali-qrd: Enable GPU

Gaurav Kohli (1):
      arm64: dts: qcom: kaanapali: Add GPU cooling

Jingyi Wang (1):
      arm64: dts: qcom: kaanapali: Add QFPROM node

Qingqing Zhou (1):
      arm64: dts: qcom: kaanapali: add the GPU SMMU node

 .../devicetree/bindings/display/msm/gpu.yaml       |   2 +
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         |   8 +
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts         |   8 +
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 461 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   7 +-
 6 files changed, 484 insertions(+), 4 deletions(-)
---
base-commit: b96de4afaea292f70aec05d40def1d993c04d71c
change-id: 20260412-kaana-gpu-dt-968a70134c22

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

