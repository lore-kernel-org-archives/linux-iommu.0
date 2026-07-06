Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98917434E42
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783357012; cv=none; b=b+Ehx22DPJyQOP+vi6jR0BYfwxZEY7G0aIvUEbK965ZHTaF+3Gq5VEevFZt7rf+QS3NAb6nBoRG1W7UNsqtZvZcF/2gTA7eFPjVuGpQskaGEUaMCI1F/1x1WdHfoIK3IofpwZkyMn7vt15u7IABXxLsElZ1q9AHTWt+4AiGkUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783357012; c=relaxed/simple;
	bh=pNZbynUekfOmHusDUjDc/vF186uS4D6Gv3Un79o2yrE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FKQVWPL3bXpiI6/mkl70u+ZBQHyGnBlMNCN4w3mdjuXuOHStJOh3bcACXhpa4+RZV0VkZ+ciCgpeGQpqlZzAVZpoaB3iJKnT2LhsZw+NpeP75zpBCQl8OlE4Y/5d1XPg8RiIornE4pQKz1pfWX/rQShy0Z3xrz+rZZY5LmOeNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZKErIk74; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C7cySSyx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZKErIk74";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7cySSyx"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFB7h972248
	for <iommu@lists.linux.dev>; Mon, 6 Jul 2026 16:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XkGXfX6x37QUZsM6pLd70y
	JpzoAVIy49ICSIs9qnngE=; b=ZKErIk749gR+S6axVFdqFva+LjBiOK52IOsouG
	mYaDGQjZRfPMHEVQM15EHooOgt3dL6n2WZW//bASMB9g3s23HUPyS7yIzMR75dRG
	ab2tKtEJYDD2EBjU6YrqOhGnN+pKH3hIZpEyxF4YodPO7Yl19RK2+ZVsMA8xiBRv
	D6lwJbA1dHr8r1FcAydskeS3LT6GtvyUiBFIIdx3yKH/lmtmOg8897vqbrvBgPUs
	PQDCtQHqxSkngaInscpyDwJBZS7swlvE7mLoxnPkkercpMXN1fxqOo924aGoteWz
	EKuRcjYewMAT7rzgI9Vtkz9QVzbjbG5u88TbWCTnD43zsu8g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r1wp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 16:56:49 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so5028725a12.1
        for <iommu@lists.linux.dev>; Mon, 06 Jul 2026 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783357008; x=1783961808; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkGXfX6x37QUZsM6pLd70yJpzoAVIy49ICSIs9qnngE=;
        b=C7cySSyx97Pg2YpnH8pfIkEIQT3Rqx6+zd4hvVTqPACL58s1MV9tdriex52LJA7Q0h
         f0DPVGhGnX2VXMKCizjzFkvU67uk304AbJ5p/ghA6TN/FwYenBWrUTkz5AcJ1roxdeH4
         DiQlltprLtjsnjsu4mMre5Afod0vnIjQtHunV7rpe1/GYg+jT66IlLo7gMiiyH88rf2/
         i7kQYR4lZahYyvIGr2JUJ/2L8Db7LrTRZDAYI7FvVqRR4PkAgS3mikZ0uNRiyIC76Vpd
         xdujQPaRGruT5XJuTA0Pfnkp2ikRyCrmXDBgBvz/VuXyoMjYaRYnh9vlFqKOoWMlInG6
         YJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783357008; x=1783961808;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkGXfX6x37QUZsM6pLd70yJpzoAVIy49ICSIs9qnngE=;
        b=AGzigB3T9+wnIQjWp4oqRZuMckecDDWFpomFzYhckZxJ9DJMrRG8kFchBW4SC1kWqF
         VXmq+uKQvol/G3+q/TM4lC5oZueeQt5R5w4RgEX47exV1C9luYxi2I83QagsifuVIwGk
         9QkSfnIx1mbtn7Y1KYsTmCf/xjRNfL4g2YSVE/is7llEQAKSgHTULtXM4yt6HdC5RELl
         MONnoopfpI2ivfLWG0WsjzNMBFy6bXL+JqALceSjoAjrr0cXzyFV2M6oj+Qn8Lu64BIK
         yBM7OZDOnCYwimxtd9YI86M0ktcCQaeWngxFOZleU4TB+qjqocNDN0f9cplGvHI7IVjv
         JUug==
X-Forwarded-Encrypted: i=1; AHgh+RpSPVD4Nf/fyL1+JX40dIPUVbvSJvMZ3Ib0+vg7IOowqKFhRmPFvkQi5dtRm/KLVDwR14k6zQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlpeBdPggRFLSyV4y+KGmvZFlMcc46yR6+t6230hheALT6UrZY
	lmWBUzfnUQJSX0mTJY/PLlRuk13Qbhxmw4HxptcUQBs5beAmGXfP1NC6o3vcqIGQjpsm/sxTrU4
	ASdnK+V7qkWdeO7kVva/KgrKVd3TtT7HwUuKsku9T6ov0gk5YcKYpUjbLew==
X-Gm-Gg: AfdE7ckMjX/Dtx/pAb7lnYjNbIHHUToJVhPFsHdarg/oIfkCgOfuDuGNW1YvQfnieAi
	xwIJ+iy3LYuT7pNgvs9czoV+g+KukJDnzAhAuHziQdRhOzyhAPmzkfEl0apWBpvOSXwLb8olfqq
	+Pa0x5KRbJmLl0ajdiX1aBNsVel/u15U77UDaAa3vLaMUHGgi6lwL+6SJZ9T3bt0Pig+4SfSuId
	VkrCQ3T4ZNrBEwZW8AsqttfnjNHjWkZB5vsum5OrqFT5RO8V/w08HK6WlU/KWhA5FR9HNTVZ4ZJ
	IAxWazZaP0T+ikfHI/b/slSVg6tifM6Lnn0eA4xOH4E0PemmRUB0sfDQtC4/HWGT6keBxo7hCqI
	b+siN2MkeMxOhOkipRb5yncsf5fmx01daRePdaRzO3A==
X-Received: by 2002:a05:6a21:7704:b0:3bf:7f0b:2f70 with SMTP id adf61e73a8af0-3c08eec7ba3mr1828002637.34.1783357008030;
        Mon, 06 Jul 2026 09:56:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:7704:b0:3bf:7f0b:2f70 with SMTP id adf61e73a8af0-3c08eec7ba3mr1827965637.34.1783357007495;
        Mon, 06 Jul 2026 09:56:47 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8eb0efc8sm6960604a12.5.2026.07.06.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:56:47 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: [PATCH v3 0/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Date: Mon, 06 Jul 2026 22:26:33 +0530
Message-Id: <20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEHeS2oC/32NQQrCMBREryJZmxITklpX3kNKCcnXfjCJ5qdFK
 b27sbh2M/AG5s3CCDICsdNuYRlmJEyxgtrvmBttvAFHX5lJIY3QB8MphGnAWCC7FCO4MljvsdQ
 Z9502rVYaOt+yKnhkuOJrk1/6yiNSSfm9fc3y2/608q92llxwaY0/OquEN+qciJrnZO8uhdDUY
 P26rh8JQKYrywAAAA==
X-Change-ID: 20260516-smmu_interconnect_addition-d9567535e9d7
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783357002; l=4134;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=pNZbynUekfOmHusDUjDc/vF186uS4D6Gv3Un79o2yrE=;
 b=zVp3IoV1k1Bdu5+mmVSi/MvhRK4jbvL2R7AbmXGDNW3lBmkJKhNXSYfKXr2YxUIPSNUeOXVL5
 85tOcqpdhETBWbyyTnM2s0bd36rcuYFlF3UntoiBA0kE8UN9ui/b5hn
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX6HfSyRAehAw4
 pvjlprjpubeltqRXSkwLONwfE7ajEB1eIXu0+omIp73wYKrNBWRHM24G/VpLkPPpNzwqSuZl6QY
 ElATBdAj0iYtDZ/K0dOMV2aWITdWMpjtbJO+Uehjd+kyr6qwYAU6/poYybTbHX+1ZcoehfWw5x2
 H3OuVjqJe8omA5iCLkAm01M5IQnC1B9lD/RFeOcrTOs2/qoErTLTsD4/o7pMKy5uUF73yRIQ1Ht
 dirt1y4XsIjWvrLSu4U3luJzGHfFTvryEo6eVVQG2PysV+8XVR86Hkqvm0MfmzOsWFcIdZHTqo9
 Kg1UjtUL022x64rz0MGexjyRpSR5jNDIF70rJ3RAvP7k3RFZV8ekHiYM0XeUX7kyyH4z/CJ2QXI
 EEyz7BawjPcg6BdMcusharhp2TaRv9UDBrVntTyoBHbmZo9NRq5N8wf6WuEK5clBemSRm1QhDTA
 kj3wkzl+04x73XD/v4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE3MCBTYWx0ZWRfX2pReUQ4KDv7Y
 aeAWxY9tHclAgFMvZFpYJ/Bmuj8OPk6b5e6xmOmu23d/I4JQXEXwfkRVVAav2C0atfIT6gP25sg
 TYbXGhr5BgszPJMBJyboVBTEIBsC0Ss=
X-Proofpoint-GUID: SHzJf6RPZ2OP6kp_tEqTkkiYgI0PN__C
X-Proofpoint-ORIG-GUID: SHzJf6RPZ2OP6kp_tEqTkkiYgI0PN__C
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bde51 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cnCtU0XpSSdWNXPVHlEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060170

On some Qualcomm SoCs the SMMU register space is gated behind an
interconnect fabric that requires an active bandwidth vote before
registers can be accessed. In the common case this vote is held
implicitly by other clients (e.g. the GMU device holds a GEM_NOC
vote whenever the GPU is active), so the SMMU works without any
explicit vote from the driver.

However, during certain power transitions — specifically sleep/wakeup
sequences — the interconnect vote can be dropped before the SMMU is
powered down. If the SMMU is then accessed (e.g. during runtime
resume) while the vote is absent, register reads fail intermittently.
The precise ordering makes this difficult to reproduce consistently.

This series adds support for an optional interconnect path in the
arm-smmu driver. When an 'interconnects' property is present in the
SMMU device node, the driver acquires the path and votes for bandwidth
before any register access, releasing the vote on runtime suspend and
on error paths. Platforms that do not describe an interconnect path
are unaffected.

Changes in v3:
- iommu/arm-smmu: Moved ICC voting from generic arm-smmu.c to
  Qualcomm-specific arm-smmu-qcom.c via new runtime_resume and
  runtime_suspend hooks in struct arm_smmu_impl, as suggested by
  Konrad Dybcio.
- iommu/arm-smmu: Moved icc_path from arm_smmu_device to
  qcom_smmu to keep Qualcomm-specific fields out of the generic
  driver.
- iommu/arm-smmu: Restructured arm_smmu_icc_get() error path to
  exit early on success as suggested by Dmitry Baryshkov.
- iommu/arm-smmu: Dropped if (smmu->icc_path) guards from
  icc_enable/disable since icc_set_bw() handles NULL path safely.
- iommu/arm-smmu: Changed WARN_ON() to WARN_ON_ONCE() and
  propagate error code to callers.
- iommu/arm-smmu: Changed ARM_SMMU_ICC_PEAK_BW_HIGH from 1000
  to 1 kBps as a minimal keep-alive vote.
- Link to v2: https://lore.kernel.org/r/20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com

Changes in v2:
- dt-bindings: Cleaned up 'interconnects' property description —
  removed "Optional" prefix and driver implementation details as
  flagged by Krzysztof Kozlowski.
- dt-bindings: Added allOf conditional using 'items' to restrict the
  'interconnects' property to Adreno SMMU nodes only (qcom,adreno-smmu
  with qcom,qcs615-smmu-500, qcom,qcs8300-smmu-500,
  qcom,sa8775p-smmu-500 or qcom,sc7280-smmu-500 compatible), so
  non-Adreno SMMU nodes on the same SoC cannot use this property.
- Added DTS patches for kodiak, lemans, monaco and talos to add
  the GEM_NOC interconnect path for the adreno_smmu node on each
  platform.
Link to v1:
https://lore.kernel.org/all/20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com/

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
Bibek Kumar Patro (6):
      dt-bindings: iommu: arm,smmu: Document interconnects property
      iommu/arm-smmu: Add interconnect bandwidth voting support
      arm64: dts: qcom: kodiak: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: lemans: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: monaco: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: talos: Add GEM_NOC interconnect for adreno SMMU

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 +++++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  2 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 55 +++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  3 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 27 ++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  2 +
 9 files changed, 119 insertions(+), 3 deletions(-)
---
base-commit: 8e9685d3c41c35dd1b37df70d854137abcb2fbac
change-id: 20260516-smmu_interconnect_addition-d9567535e9d7

Best regards,
--  
Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

