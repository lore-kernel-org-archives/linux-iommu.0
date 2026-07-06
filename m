Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F0D2989B0
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 21:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783374045; cv=none; b=B7yr8IC7c+1Cit5jjnHGwgGbqz2W5Ptp6f8zFo/uLCsv01tZ4Qj5YlbZH7rb5pWxzhWlK4kfydEldks9AkVE7UDw/A2/xtg/68TkqK1C4Mmll8+9m5IPWMDhSODxN6THzD8SRc4AtWngYieXM08TPq4tfsoi4H7L1j8qnqMLLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783374045; c=relaxed/simple;
	bh=bs+iDFNnM8Jvg3DP8d38QXtbWpKTJaOmfgrbI8NBa80=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=meg+HiFHMZ9SPFcJQkA9VTKjQdyBEM9VsJREB8oNCi91GR0dEiJGLwPmQg55k+PHyveGGm2LWdSl1au+C/mtZEUUY3DggtV66pCZ9vmQeQWIYSYbt4SJkU9oNfFTEoPnkxXHrf5osFMVhmejhYSWSG22wF7LFLXZCdn5j4q1drI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJ/ojeK+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UV+tNEdZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJ/ojeK+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UV+tNEdZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KDwKW1495430
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 21:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Sl1a701shpBJWVBwhh6ZP9
	Kq23RhfGUWyGD/s/IZgbw=; b=HJ/ojeK+rNwO5/4jDzx12MhnRCZul1oJFph8di
	W8Yl3e0LfnHow40KFW26JFj3+W3qYKDV0ThdvEkqL9uRdIcNbMlTnSrTI418lKoT
	HcS+0WsOkarsXHksd1jH1K+4H58sfNwi9+PMddDszR+cbSV5IgeQyDJ+ntG6W7Iz
	zeZrGa5oMyDGOs2y7JVLfXrwhK2cozLNPX66JchWQXlZv4Majx43CqdEbnpXmcCK
	cbRQzCkqDVWxSd4aW+JHVFDzexafSnUjkxgEIqVfvwlrRRVwzJxNQB9o/DOW744U
	0UHJJCZw8g3nXyosAH+SDzix1hWlNzdUwB8TOcyBa8nOt9Jg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88t8bb5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 21:40:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cac01e89e3so452345ad.0
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783374042; x=1783978842; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sl1a701shpBJWVBwhh6ZP9Kq23RhfGUWyGD/s/IZgbw=;
        b=UV+tNEdZZfCnCz0MXOJ9sCTe1ruNGhnQVLyXwMqPYbuKK6hMWtyhD9flL0to8LcSNn
         5Vnh4zThdsDnAXWLgA/RUL48hd3R9k+zFgA2+k9pwcWKD0SwlZ7iGkgF4bxG2KV8p/YO
         hV4WlhInV4BLcUDmcQkfWAZTwFjlo6Fb74kbOQ9dCLgUf1N+l6C3xS7+XEoOsUu+Exwi
         N5GImufu/wv4X7ynlMbwAlBvk99Hk8p/rgC7/tXtsVQLgqkmBaLNgwfyBdQzwLrzqAbX
         8kLqbX5Lkobd9Gh6NkapP/vv/segNBJzylqNOeGsFBODUjahcYR6xRa8ctoF/SzhhRFz
         US6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783374042; x=1783978842;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sl1a701shpBJWVBwhh6ZP9Kq23RhfGUWyGD/s/IZgbw=;
        b=MfNidINCSN+V6Qr0H4UNW3PO+C0VDD7BtKPDPWROvKXvbZC/IoyyPYZoGFfPDBWI7I
         fxQsxMVTtoiOEGlu7HXENSLxRN6MANVh4q2EVp7dI3fVszgLhpUuijCgFdnJ5bsyQBQb
         jgOOWpaW7rjyjrefjVOjJCH0zWnbwiK0AqXq5tVLouPMBSoECmENU/lCGSCIaXv5/qUY
         bjKviXRP0aH4tlWy8WSUAtquh6hfp5Su68Rar1AtOHZe25PI5dN5cbFSbm+Yw9nbk5En
         mOc1bWESlOnwT3R/VtJ3k0yPnVrRtIrKNW6686HiercgI3pqYFkBNkfaxInr7w/Ox8pZ
         PBgw==
X-Forwarded-Encrypted: i=1; AHgh+RoaCtzDL7MOAeDY9riTsNiyonNetxaO7dNIYwB/5HObAlG8JFXRG4ngYjgTpNINTJw7q+WnxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmaTz6MlL0COamAAiFq3sbLWr+phTnX0rg9XD++9xmAbZwdRUa
	JZJZlzcpGz3pRrqk4TKsmSX4BQF+7KhXC0hw1/HuPPhHAc1jmFQ8Flv0jlbrrH5xvlmEbXUu+sy
	l1HBGL4uGMDh0R5wT2A9WG7jtIGp75LkT5LFcmNmPitE958McUNPAjm0/iA==
X-Gm-Gg: AfdE7cnMf3l2oLegfvKK+v97TXKbwtaM5fg6W9zbrPt2d92p5KHhL5eqcjjcY0+Hb6n
	zTK5IEhO+2edDPZTf/J5VyTwgiwvdRpVlJM7EMBmOI/O81rEXr93iRye85nAW4dU3B1EWLbv/rG
	kRv48ibI5Hbe/QuMAV6tFQd/FUc9MGry+nJjtEuJQQ8M37PK4w0ThFhsqXafNHQNYBXRvwJMy5n
	SDGfRdtvhtqoul+274fJWK/wpChijVt+0pWmJoA/9+cp2KfDtUqyS0Zy5PqK1DCp88gSnWPkSMs
	uu1W7tFrzvRFc1cwgc9imozrZpBlrq/bd6JabLafVAY3Kx6M7QuPNipgZNmShvOEhLg3afIFj6/
	uI3kKCgt7lWqA4WCRufBPHospDGdlTSiIkMs=
X-Received: by 2002:a17:902:fda5:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2cccaf33717mr555755ad.30.1783374042030;
        Mon, 06 Jul 2026 14:40:42 -0700 (PDT)
X-Received: by 2002:a17:902:fda5:b0:2c9:994c:9a5 with SMTP id d9443c01a7336-2cccaf33717mr555215ad.30.1783374041497;
        Mon, 06 Jul 2026 14:40:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:40:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v3 0/7] arm64: dts: qcom: Devicetree support for Kaanapali
 GPU
Date: Tue, 07 Jul 2026 03:10:18 +0530
Message-Id: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMIgTGoC/23OQQ6CMBAF0KuQrh0zbSmoK+9hXNQyQqOAtoVoC
 He31IUJcdPkd/LfzMQ8OUueHbKJORqtt30Xg9xkzDS6qwlsFTMTKArMuYCb1p2G+jFAFWBf7HS
 JXOZGCBYrD0dX+0rc6fzNjp5DVMP3k120JzB929pwyDp6BUhyiZIthcb60Lt3OmfkqZHmar155
 IDAJXGDpRGo8Nh7v30O+r7g2/gkbxQ/o0S1MkQ0Cm2UrEgVkud/jHmeP/+t434kAQAA
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Qingqing Zhou <quic_qqzhou@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=2226;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=bs+iDFNnM8Jvg3DP8d38QXtbWpKTJaOmfgrbI8NBa80=;
 b=aOWgjsH3Quqy/Ba4njoZ6uizggyqsh282W4b6iHuOyw2JsdoW3L0lnBNH6TZEF9o3L50kD17o
 ubko8wpOpbwD/Y9jUT9CfcTBibDg0S/mj6CTh3/lk6huCzK9uduPgpM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX84On3YZL8Roa
 eiXIwzDQYFV1ad3RkdUhGIiLxg5eHGlle85Q3NsRrJnHwQDRQiwNmjQ/vjyb08eLeqBCb3IuuO3
 /yqReQY+0AFwF6aB49GamNI7uXVOT6g=
X-Proofpoint-GUID: wWxsh2l2T-ui0Fa4y1Vt7nmAJcLUk7YG
X-Authority-Analysis: v=2.4 cv=C6zZDwP+ c=1 sm=1 tr=0 ts=6a4c20da cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RSuC8zd2ZDaJPqFJxW4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: wWxsh2l2T-ui0Fa4y1Vt7nmAJcLUk7YG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX5fzdD2Qy7PtR
 1pUka2QlUpNadV2MfMD6D5wvWg0azQYW6Dn+sk9DnAWXoXq/lvjZib67oFzbPujRD5WgwsRllfE
 isHCE7UkOLeOMqqnDDDNbCUX1P9j/H2a2Lvsedv396iIpi9gSyZmvlAODWcJIJ/wlGTqcrjipOx
 /nbVDv1FQxoYvLAohFIXe3wDwsd1DpSRHukdEwMJutyc5GDOWuIDruSc6dKPpBDgipKjVSsk5Xp
 jdtFfKDN6qshpK4w90cZyh+2w97KM+det5Ac8F76Il+J/vOoBs3fHLNiYroUu1J5g/xG7sNxeN7
 vtyynA01zO+l3q69rw60pDkZ+2KFsaMOAEkja8/kDRMvuEIQguXpFiF5sB+79qU4FQWS8qKdYXC
 Q9/KCzN/FRMNkV/Su2QTUuukjSUTQ+1quwJpo1Pe3k3IBT1eM6ioHc7wxJqdFpizOj2Ll9MULEa
 UoUsg1iDnohXhTvozwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218

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
Changes in v3:
- Reorder properties of adreno_smmu dt node (Konrad)
- Drop updates to the HFI interface as it breaks legacy GPUs (Sashiko)
- Capture trailers
- Link to v2: https://lore.kernel.org/r/20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com

Changes in v2:
- Fix formatting in DT patches (Dmitry/Konrad)
- Update cooling patch to lower the polling delay (Dmitry)
- Keep both passive and hot thermal trip points (Dmitry)
- Update GPU OPP table to match latest downstream version (Konrad)
- Add a new patch to allow HFI related structs to accomodate >16 GX levels
- Drop the smmu binding doc patch as it is already addressed in linux-next
- Link to v1: https://lore.kernel.org/r/20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com

---
Akhil P Oommen (4):
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
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 458 +++++++++++++++++++++
 4 files changed, 476 insertions(+)
---
base-commit: b96de4afaea292f70aec05d40def1d993c04d71c
change-id: 20260412-kaana-gpu-dt-968a70134c22

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

