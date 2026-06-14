Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD7285C84
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781472793; cv=none; b=O3stGCZWBiSWnN5q74ge6iciAVTz2pP3SBQlracLHHeRIfNbE4+iwu3JGQjEDfJ1BLJOT8kfC49kkrUQ43J12J0DMUl54m9ekpqYx5ufVKhPMTt1ljneUf4cRKmRXS8EU/ZKKhqmr31sEmJlzcBfHMC0NyndHiFEPTuzN7pkK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781472793; c=relaxed/simple;
	bh=XhaeUKD8ec4SllC82vt0xlcd0hBy+SDeLmBke9XzXRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XipCUlcu2z3BUVEsPHQtMJ6QgCcHANQVanlJiGFjcw8o1Nuy7IE/hHb11RWsRQhNiFdFsM7nGmjFV5jtli3SeJsLJQniABtbS9kRELZbi9HUQkrVR2+r/71vszfLRzWMLllh9N39hDkCfOB7goagqcdUqvIDnb+BnK7d63nFMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z+RhBxCF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YrtNXia3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z+RhBxCF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YrtNXia3"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ELEDSW2555681
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Bur06zKcsSYkJsUBV4uhT7
	g5E5SB6XYFrjgclNHkfuY=; b=Z+RhBxCFxckpOJbV1njc6mIp0E4/+fGHcovYc+
	K3FPG6MVBZxPsFHAwB8EJ/NY/Ky1PbWuQPNQXJiqU/+DOZZnV/knvzJrJdiECK2s
	OUg4rE3GQEtwVizx9/w7UrQo7TzfY2R6atbIbTwrnsarPn7Pa5Ovi04FM76NhdIF
	6PbAkPSYB/xYJZXVfCgoyWiEpyzVmn6tYzgjXZPdZlOH0jhFr6q1xdxDMe43hNet
	dUZyflkZ7YjuvkPU4rK5dsqRb18g3RvSo2FRvV7UdMubLiX465/Dn4Eu1WyW8Rmq
	XEMnGonf1qNYv2kkBLgiHhhp737uIvntI/Ipqy6R/UHrobZw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery954hxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 21:33:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso72836045ad.3
        for <iommu@lists.linux.dev>; Sun, 14 Jun 2026 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781472790; x=1782077590; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bur06zKcsSYkJsUBV4uhT7g5E5SB6XYFrjgclNHkfuY=;
        b=YrtNXia3KxDQFWZfPnvh4HtgdW9AYbcwbIO1zTqloVQlMI1I3v4kxoCWnxTKUhHMNH
         b5mOWTVPDvz8fmPqdgdDOSWkCotU3CdCPKRtAvW8Fm8CVwzT1v1oSsR9Ve4Rqdr+4/5O
         cbl4R1YgRLQfyj1KBi1T7iJBySw+L/PsRnrC3oY+k+rDrbYXXncyE2jjN1mT1E8SMb+y
         3tucCW5FghoFE+Rd1YrE6Bb9TusGDp0zdToGzmkZ3lFO70+X9xFqAeScgtwSEeMP9e7F
         EYXN6kXlHhpdx509Sh5rnep8uvMprX1106S+ea/v12tVFMLcANJxn2369khOCiJOSAV6
         nQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781472790; x=1782077590;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bur06zKcsSYkJsUBV4uhT7g5E5SB6XYFrjgclNHkfuY=;
        b=LybxWawJF6XjidFziNyc+m2jbbj7lcMsAyG0Inhnqvi58itP9oQbhkcB0Lx6H+pS3r
         NR+YtGQiJFuFysTwYaZlj19HiZYDdjtFUWajqWlHf85Vnz4MFPxVF9lQHfcBNcmrbu2/
         bOT2o5J9838/SmBxIU+q5TZjY9cRVkPpwLQse1jzjyOd8M6p98+dpnl/8yvGwqxnT0wD
         TAyHFPCit4bnFqR3khC3SK9s6wy2XzgQJ5shzuoiAcPz9yqRx6T06uSrHP+O/9W0JqHC
         G1VFhp0iNO4wMR+hr7b5wEbp6+GULHpHlYIK7e5sppAsdy7OkgxzvgYErkZXOpLSJsHk
         +iQw==
X-Forwarded-Encrypted: i=1; AFNElJ+leKhr7qsJgeahXTArIn/dPuxX2LWZcvfz+ZSEuB2VQyDxdP1VZ1CZoqfOqVsazx396EIeRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT3xmnFo2iaD0SXAs7tQKsxpOo8GlVBIQTiomjO3PcTo7JCp4b
	KykUimH635p1GCBzqv3A2Dq6W3VJn3CTeLJ9Kx4f65owbSG5/2AkedVabAIqfcYmfWDB6aXvswX
	LLwoT7sTMYvMr+AMaRjFRU26vfZq8LTAkcG39Ev2jJDjCf5kV8lP4O5z5hw==
X-Gm-Gg: Acq92OHM33112e+A0xgfeT9vEa/Z4VENvMKwrhiPuPeNoZuWxoSaaFvgubpQbwaQtns
	Z0R66/vRzrUDwE+cOItV/NappTsuYZDpMNDCWvXSJj7VzCrQtiXfk/lc4sFFi3pb5ipDY2+f0wM
	TmWHGyX/4+Th4O1DRHtOzCZSa4hMgqX0XgOSDN+b1JIVzX6OHhEuEFeDsGIYOAnxRzjPJCq2cMZ
	86p8owIx7i1mdY6ThTn1iw3siVLkA0QQFvfQ8rQkoqP2dBpz59u8ZEjgSQ1E6UlSdM+4JTVcQXN
	bZZf3J07vHn4pyjXNZKEVLRhAnBhfw48WtqO2ERmkEKcgUNBtoJWzdMhqP3TPq4WHrs3ccB+eS/
	IEGYfsPAy0KZVHXRqP4LLGy/Czhx+aTJIWwucllRdQGT8qA==
X-Received: by 2002:a17:902:c941:b0:2bf:222e:455 with SMTP id d9443c01a7336-2c4109ecfbamr130763505ad.7.1781472790198;
        Sun, 14 Jun 2026 14:33:10 -0700 (PDT)
X-Received: by 2002:a17:902:c941:b0:2bf:222e:455 with SMTP id d9443c01a7336-2c4109ecfbamr130763165ad.7.1781472789777;
        Sun, 14 Jun 2026 14:33:09 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f7c6c5dsm78385815ad.21.2026.06.14.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:33:08 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/3] drm/msm: Add support for Shikra GPU (A704)
Date: Mon, 15 Jun 2026 03:02:56 +0530
Message-Id: <20260615-shikra-gpu-v2-0-2f2d1347c3fb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgeL2oC/22OMQ6DMAxFr4I81yhJCxWdeo+KIYCBqIVAHBAV4
 u4NsHax9Cz/578CkzPE8IhWcDQbNrYPoC4RlK3uG0JTBQYlVCpSkSG35u00NsOEye2qiop0Leo
 7hMDgqDbLIXvlgVvD3rrv4Z7lvv2rmSUKzCpBIit1IWXytMzxOOlPabsuDgPy7dQ7GqdQ0Z8/o
 NBMuB8Z/4h6WjyefqlCYvsBCVDfttwAAAA=
X-Change-ID: 20260609-shikra-gpu-5432bdeaf0f7
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Aditya Sherawat <asherawa@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781472781; l=1310;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=XhaeUKD8ec4SllC82vt0xlcd0hBy+SDeLmBke9XzXRk=;
 b=ivyhD3XZRXduZdfDnTiKOjDQ59HNYEZ7GA0ltWYmT+EzWj6f47wF+hZ4wLfkRqiJC/Tx6fMpp
 zKINriZeE9UAw4pN32kSFUX/mmaWRexd0I7ddS8cJ00O4Hv2Zb9G2a6
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: I6dy_N_Ha3VfgXeA5Q3sw6NhY8FvAILV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX+BpXguvXmnaD
 xNnecnmm3HmawhUlfNyCxC/esomgVRLnbwrH79ENhPCQGWlZovPxSLcJURlY2eW5CT1QSx+LsMm
 4sHcsxI4M0vndANMqKZeO9O5iV1vamY=
X-Proofpoint-GUID: I6dy_N_Ha3VfgXeA5Q3sw6NhY8FvAILV
X-Authority-Analysis: v=2.4 cv=EbP4hvmC c=1 sm=1 tr=0 ts=6a2f1e17 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vtaXLjJ3spEbOLdMN1IA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDIyOCBTYWx0ZWRfX5p2cIJ1DLMA7
 U/4L6/e9jXbPpVt1U4kdqOqAsiSsIKflsQnpcjdScIw7GCw3vKajkoflwFS/GgUk3MtYHKx5CY+
 OKIRlthqtdpym52DzN585uF6S68YAJ8quQ/qv74hK9zOTHOHfzcqXLSPpVEcygKbJ3kUQEyNMk1
 UEZvRTIKUbFNPOJ9RJfvDx9X7+iOyi0ZkVkP+uqpqMuia9VI7o7kHD650/vwiEt1+72o5MU8hF1
 vAnxs+/sxGERMZ+4O4nT/PzNpDcj2f1uW+7X+R8+VBXYnNa4PyIegee7Y2tDrkzdQ54jwhKl+IZ
 kPjOcUO4SkbWTiu41Nn3ElxEtPZQjqtNfaAg3SXnL5gl77+vaxI+mZQ8KkupoilkZ7aBC7jR/B7
 6xlk2x7oB61UtSFTWH7kuu3abzgOif08m9FAeQP4qM5PY76uEr/WGPxZnyZeZzwGGQaLnh3Jizn
 wF9Zuew6axd/0DSZuGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_05,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140228

Adreno A704 GPU found in Shikra is an IP reuse of A702 GPU with very 
minimal changes. The only KMD facing difference is the chipid and the
zap firmware which is specified via devicetree.

Mesa side support is already merged:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41762

The dependencies for the devicetree patches are still on the mailing
lists. So I will send that separately.

-Akhil.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Add a new patch to document the GPU SMMU bindings
- Capture trailers
- Link to v1: https://lore.kernel.org/r/20260609-shikra-gpu-v1-0-9d0e09cab115@oss.qualcomm.com

---
Aditya Sherawat (2):
      dt-bindings: display/msm/gpu: Add support for A704 GPU
      drm/msm/adreno: Add support for A704 GPU

Bibek Kumar Patro (1):
      dt-bindings: arm-smmu: Document GPU SMMU for Shikra SoC

 Documentation/devicetree/bindings/display/msm/gpu.yaml | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml  | 2 ++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c              | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: 61087e3a8490908a65da4e2d33fb5de6eb888982
change-id: 20260609-shikra-gpu-5432bdeaf0f7

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

