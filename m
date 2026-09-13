Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CC53F7884
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325388; cv=none; b=DdtoQFitjYeLNX509fInlR0ysAg+JySGpeaFskFvf23hYPKqT5yTAP6PdUSerekHqKbIBQ2I+TRgxsSW69lk1DDKswcitqBPC+UOxcW4dlCQ1//lgwIeax4MKz4hcRhR08v1j+Q6KGS8Fro2sJE1nQuLRW5+dKs3sw0KCFOCQgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325388; c=relaxed/simple;
	bh=SL4rHg0ckqjS7yflKo0/gzXQtpbTOEX0iMMjHPfQoGs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JquY7svomHefPYBNB1Y80HfHiRtdQd8tQX7Nziwr+32aB/mwz6LmYGzzTJ78Gw6w+7aRh1rEg/3FHjwH35pWBc2Hp4cqdWQjmfxVTII7nbGWQiBfZqSBbwojNKw6nvGH5k2LnGb8gltaQoC3FIfeOHtnreOhF0VNHDEqS2p6SjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JOrbATl/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LLePFEq/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JOrbATl/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LLePFEq/"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DI2XNk3284316
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tBdLbgUXMSrCBPS1AhsoRZ
	HgTYdkKAJPrOORzltLXkU=; b=JOrbATl/TF0mbBHHB4XXCi9wyH/IvU5HIQ6VLX
	GeuBkKnMW1iDT1U/9vnsXlZTJiSgg+6yt6YsDbgoX3G8+Or6tksl8H86MF5gWsVb
	c1dXJ1gsH7lOCugBLWhLE5gZq44xhwtEuM5eSzn+kLKG04HSux7rLs7a03vbcf6R
	55Z1DIutYzSzHvY03jf60hZKxyCSfBXQluUNPp9ifSOwh1RzFeLhcYjyD2tVEwlk
	7mdZ071Fh4JBUYxRkO+FHkd5xPy1B3cH5oGspp/aUDYdrYneWj+xBzjxpm94hSvp
	9DV37bgELtnswISlLPoTfM4aciOb56DNbbmhIDxWSjqEIYpQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9cby4a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 18:49:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-395543dc382so3414728a91.0
        for <iommu@lists.linux.dev>; Sun, 13 Sep 2026 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789325385; x=1789930185; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tBdLbgUXMSrCBPS1AhsoRZHgTYdkKAJPrOORzltLXkU=;
        b=LLePFEq/6IHXifAaig5x+5yA2k/hRvjhDEEOkCNLEOCDOpGfPgZEY+TGZyggJswibU
         YdnW0ku/zH0aFPLs+EihABTXqOhmLx1bVBe8ySwX+wzxvZt4BzNVL305cVuoFiRT3nq2
         Vl9RL83o+cvLOIAaR6abxRIXiKktPPBbVqeWtWE4SGrhr+OXES0jhF4kJTiYfNko4P94
         4ewyCWA5QAKB1QScPTct4CcbLbAq30BDvUj986TkKP5/AcGm8NrgKdnECC2vmgElFMyC
         mWmzzABavKtjfMEXeEfKKGejmSkXhzseFpW5kuwpR/4GTDMAGeamcU/MHE0eR24NXdB0
         jw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789325385; x=1789930185;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tBdLbgUXMSrCBPS1AhsoRZHgTYdkKAJPrOORzltLXkU=;
        b=eOC+AT1WBhyTmWrzq3IuhuY2vBs2Pxk5RCe1u9IAHN/QslXtYq3gfbBuW8Y1uYUY9b
         pLt0h/Alu4LBCF2lGCNgGS2WiKyxqQXYZMIzFbJe7+4b0CmWRJ1H6Ec5A3CsbxX/ewbG
         h2D/A7NfCY1dZ9Xmpug/Hp7iYQbkf0r6ysbYkbAPPe1+hmdtN7Auk6BYG2XlFpDkV+pl
         //xpsFhgCDaC8O7WbVPPlovkRBqdXvyci7f/Ob/RXq8oD9mwwlYhduDn9TI1vsVCaU58
         uY757meZ6Rd60ye5xM+QbsQIoyRnL5yefUQlF93psy7PrcVs8qRrxaf43II5xnKZn4iK
         Ep9w==
X-Forwarded-Encrypted: i=1; AKwUvBxtZL6/9zDyRmX5TWU5jshGkNEzH+BRKSUxdItc4esPCwLp552ncvvxBVENh2Ew/Ffw9HC4zA==@lists.linux.dev
X-Gm-Message-State: AFuF++ktC71IEpD/ebOHzZkkTNJurdLlJKqJFs9s4vvVWrHS7HB0msq1
	4HMVC7QPfyIaD2eNfVyZrtZ7dIBJmXe2p4Bo51divCyGke22n8zVR+pnJCgv4DWfTfunZuI7kLx
	t/m/jDKlpxB2h3ke7FeV3snDyw6sfeznHlh3ewHL4XDAwU5J4Q2KXBmyEpg==
X-Gm-Gg: AYBFou2Wi5qQRf+maTZysS46ItsT7x3gFXByMVs9CBBPUXrmdXbbm+LRzk1vnR4NWXh
	2f8mj3Olih/mqgQmYV/pNG5hsKx4MQPgG1BFmYPuYdUlmMeW7N3wPshPl+T2k3YXb25Ku6gCSQ6
	BNzIT3NW/sceJthKDxdphDQ/GfBpgObCi5/J8gTKbPB4d7/4OQHapqwk5sqOsz/NdZoeVb9MWXZ
	v05m04shOVJptpo0jAwVOtSHRe3JjWNzCKjqRJM9v7YkDJjrVVTA67o5RX8iQUguKOKOBqZ3d04
	QbyjNKXxQjEGjLCDY9nFETjdqe/zmeGdnEErQ3Gd8Lly4Bi6ES1r8g9VtS/uOHURnExcaayznKb
	qCCgvXRZ+Mk2tNAqpFl1jZnt8DX9jZ7sqUpY=
X-Received: by 2002:a17:90a:c01:b0:39d:e1f2:33ff with SMTP id 98e67ed59e1d1-39de1f2630fmr1887002a91.9.1789325385117;
        Sun, 13 Sep 2026 11:49:45 -0700 (PDT)
X-Received: by 2002:a17:90a:c01:b0:39d:e1f2:33ff with SMTP id 98e67ed59e1d1-39de1f2630fmr1886947a91.9.1789325384618;
        Sun, 13 Sep 2026 11:49:44 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f55735sm22473130eec.24.2026.09.13.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 11:49:44 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v4 00/13] media: iris: Migrate iommus to iris sub nodes
Date: Mon, 14 Sep 2026 00:19:17 +0530
Message-Id: <20260914-vpu_iommu_iova_handling-v4-0-9b9074a73c41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3wpmoC/33OzQ6CMAwH8FchOzvCCgPnyfcwhmxswBK+ZLJoC
 O9uITF6EC9N/k37a2fizGiNI6dgJqPx1tm+w5AcAlLUsqsMtRozgQjSKIsY9cOU275t1+pljjO
 6sV1FOU+NSIVkJSsIbg+jKe1jky9XzLV19358boc8W7tvU+yantGIZqBUCoUCXepz71x4m2RT4
 HSIhay0hy8u3n/RA3JaclAc4KjVHhd/OPHvuxg5KE0SS5PwRPAf3LIsL1fFLttjAQAA
X-Change-ID: 20260701-vpu_iommu_iova_handling-556e969a1f1c
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux.dev,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789325376; l=7094;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=SL4rHg0ckqjS7yflKo0/gzXQtpbTOEX0iMMjHPfQoGs=;
 b=icnT2Qww/PAXHwR4L2TMMCi0IjERQDEJ8e9uiC4dCui4lKVV87Zg0gkSsi9L/Wupl4Y3yBvQ7
 pL21LZ2JOlfDmVqbJDkWuqVqQsPbb3U3B0yRwkzcpxCi7Jmg/ScLFK/
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX7mwZxQi4C9bE
 t/ZRUV653wRBcUIT8XYMnlV5GEMqDIcLxYyDrBmEJet/c+Ypf37+96EHkPi0tWR6/Cea9eSFsiA
 OHz7oUYtsH3mHRN0SCiwf4cqvdAWtZ4=
X-Proofpoint-GUID: w0UqY_TYwwCPPol1Hg57gUJqVKIvzq64
X-Authority-Analysis: v=2.4 cv=BdZNQbt2 c=1 sm=1 tr=0 ts=6aa6f04a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=Mirq-BLilzHILghaBF8A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: w0UqY_TYwwCPPol1Hg57gUJqVKIvzq64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDI2NyBTYWx0ZWRfX/7ckP4gdu+TS
 7dyC6XzeN9znLi1QhwnGKZkmGjm5FR53g6fKLjG56ZW0fowQ1k04mFh+DH1R23Kzr72lZuZPDVn
 br9rZs36L2Qq0QuBQTP+Vz6Tz3G1kEbN9f18NE4TEx1i2tk6nw/J1bo/hCUtmi+Ko5UKlphNfm7
 vJNs4NUx0m+V4f9RecFqLxJvtjviM4zmfTrhFjwzAYa3nFfyI1ukN1+2DJ3JGJlHTCYbV6E8Xz+
 LUXpy3/knNHbxDTk6U03ZPgKtP9DBaJbwxpx19MQFM0Q8MGf/+uPFjwMELYGCQvcTSUJ+Jb34qV
 5L33uftQHFhFUoqCIn9jTJUJMCySBRgkhnTaf0C83+8PDrtByZrwH5ZHzC55z61V+43/q7V5sVK
 IVOVYXdIjfZtf4izjtfQF4CLQCI2uMz64ful71MxJUZn7hPwd0gc55n7kE3DbG9yJAhrAg0mVzY
 zncq9VOVwknn+Qu8OCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130267

The VPU issues DMA through several SMMU streams, and the hardware does 
not restricts specific streams with specific addressable range. The 
non-pixel stream is restricted to use 0-600MB of IOVA space, while the 
pixel stream can address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+

A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing keeps a
non-pixel buffer inside the low 600 MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Fix was made in iris/venus driver to reserve the 0-600MB range and 
thereby prevent iova allocation from that range. 
https://lore.kernel.org/all/20260818-reserve_iova_in_driver-v2-0-5005a1154408@oss.qualcomm.com

Given that the address range restriction is for specific VPU stream, it 
should be ideally moved to that stream. To achieve the same, a subset 
of streams is now represented as subnodes, so that each can be 
associated with its respective addressable range.

In the past, this limitation was addressed with an iommu-map approach,
with the iris driver dynamically creating the devices. That approach
was later concluded to be a hack to avoid having subnodes, and was NAKed
by the iommu maintainers. It was discussed in detail here:
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

The maintainers agreed to proceed with the subnode approach to address
the VPU hardware limitation.

Reserving the iova address using "iommu-addresses" requires it to be 
placed in the reserved-memory node. But when "iommu-addresses" is the 
*only* property being described and there is no backing "reg" (i.e. no
actual reserved system memory), it does not really belong to 
reserved-memory node. A device IOVA range is very much specific to the 
way device own address space is mapped, and not a description of memory
shared across the system. Given this, "iommu-addresses" backed by a 
"reg", should be placed inside reserved-memory, otherwise, it should be 
defined within the device node. More info on this discussion can be 
found at
https://lore.kernel.org/all/662f7093-fb0a-4564-9ca0-98e03e68ba9a@kernel.org

"iommu-addresses" property expects a phandle, which does not make sense 
when the same is defined within individual device node itself. 
Introduced a new property, "iommu-ranges", for the IOVA ranges required 
for DMA memory mapping to that device node and when there is no physical 
memory reservation.

"iommu-ranges" is defined with the schema PR
https://github.com/devicetree-org/dt-schema/pull/207

This series migrate vpu3x platforms to subnodes. All new SOC having 
iris3x or onwards(4x 5x..) should follow the subnode approach.
For VPU2x and AR50Lite SOCs, which are being migrated to iris, the 
subnode support would be added once the SOC is migrated away from venus 
to iris. There is no plan to upgrade venus enabled SOC to subnodes.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v4:
- Dropped Daniel tested by tag (Krzysztof)
- Removed depends-on info from the commit description ((Krzysztof)
- Dropped the soc {} in example (Dmitry)
- Addressed review comments which seems valid (Sashiko)
- Binding patches depends-on: https://github.com/devicetree-org/dt-schema/pull/207
- Link to v3: https://lore.kernel.org/r/20260909-vpu_iommu_iova_handling-v3-0-2fe43ae45495@oss.qualcomm.com

Changes in v3:
- Drop iommu-addresses from reserved memory (Rob)
- Defined a new property iommu-ranges (Krzysztof, Dmitry)
- Moved the vpu specific context bank handling to common(Dmitry)
- Dropped fixes tag.
- Link to v2: https://lore.kernel.org/r/20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com

Changes in v2:
- Fixed sashiko issues.
- Moved subnodes into common schema (Dmitry)
- Kept the firmware name as the one defained earlier (Dmitry)
- Added dma-ranges to specify parent-child address translation
- Moved context bank hooks to VPU ops (Dmitry)
- Updated commit description.
- Link to v1: https://lore.kernel.org/r/20260709-vpu_iommu_iova_handling-v1-0-72bb62cb2dfd@oss.qualcomm.com

---
Vikash Garodia (13):
      dt-bindings: media: qcom,venus: Add context bank subnodes to common schema
      dt-bindings: media: qcom,sm8550-iris: Add context bank subnodes
      dt-bindings: media: qcom,sm8750-iris: Add context bank subnodes
      iommu: of_iommu: Add support for "iommu-ranges" on a device node
      media: iris: Add non-pixel and pixel context bank devices
      media: iris: Route buffers to the matching context bank device
      media: iris: Skip DMA mask setup when the core device has no IOMMU
      arm64: dts: qcom: hamoa: Add Iris context bank subnodes
      arm64: dts: qcom: sm8550: Add Iris context bank subnodes
      arm64: dts: qcom: lemans: Add Iris context bank subnodes
      arm64: dts: qcom: monaco: Add Iris context bank subnodes
      arm64: dts: qcom: sm8650: Add Iris context bank subnodes
      arm64: dts: qcom: sm8750: Add Iris context bank subnodes

 .../bindings/media/qcom,sc7180-venus.yaml          |  15 ---
 .../bindings/media/qcom,sm8550-iris.yaml           |  17 ++-
 .../bindings/media/qcom,sm8750-iris.yaml           |  16 ++-
 .../bindings/media/qcom,venus-common.yaml          |  97 +++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  15 ++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  15 ++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  15 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  15 ++-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  16 ++-
 arch/arm64/boot/dts/qcom/sm8750.dtsi               |  15 ++-
 drivers/iommu/of_iommu.c                           | 115 +++++++++++++++++++--
 drivers/media/platform/qcom/iris/iris_buffer.c     |   8 +-
 drivers/media/platform/qcom/iris/iris_core.h       |   4 +
 drivers/media/platform/qcom/iris/iris_hfi_queue.c  |  16 +--
 drivers/media/platform/qcom/iris/iris_probe.c      |  79 +++++++++++++-
 drivers/media/platform/qcom/iris/iris_resources.c  |  41 ++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |   1 +
 drivers/media/platform/qcom/iris/iris_vidc.c       |   4 +-
 18 files changed, 446 insertions(+), 58 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260701-vpu_iommu_iova_handling-556e969a1f1c

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

