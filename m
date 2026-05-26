Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B163FFACB
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806535; cv=none; b=SCynEqJycqBXjCZO7BQeUyq2+RrNrKFR3gtRxxlPJVhfCkwos2OUefq9k770mEVwDcmy9FLYYNyOi5clB3/o1tUrqBB4YyxfHJAh89Pqzf9COEO7uw6wfAMQLTlU6+a9cwBT1qLcCqwj+AWvrIbG62JKJSfvKTP6Afp3P+W4c4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806535; c=relaxed/simple;
	bh=uLBVRdHt1DzWyNxdmo3c1un5xSXTEc6wp4DIMqPlal4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uaqVD6qGwnUhDklTllt87V16K389di2klTi6tnY1B9OC6DAduSw+PSHgv3tpHKpNKXsxbRS7x9aZG6M+GnRgMfeqyfqBCQYh4yGr9Wp5iEhDo2M0UNgRSrjC2B8xy02fIWJZ/YPppUvt7zJo9/VxZ8F872rL/pCZSq97wQUdR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KOvtZH5x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=djMOWpGc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOvtZH5x";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="djMOWpGc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QD40ND3693558
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OJiQqr3Kx8IGfpljF3ubZK
	SLxL/TpGa8jIJrCHd9nnQ=; b=KOvtZH5xB6yp+4JZnbkSbPMS8qvSqY2FJ4t3Qo
	YU+jMF9039wl6J/Boy4V3bDCJFVrs7ErloNk90U2FJ/BB0N0g54JxmkC/0q0zhmE
	XleaxDlE3KdY+4GVOBG6P330O1V9T690DPp7NHCFkgJgbhFxjQKaZYVjp6tvEGnH
	lzUu9AOsgFnRdvPqzNavlHX0HCe0KvGniq03NABx0F3ZhZjiVqzMbWdgARmHKgS4
	eUDEu7Uktyv37nOuESVIFp6IKA0WfogS4v9FxvF6dducyyiB+n9e+HTbb17bCvyG
	Q39GeG6RYX8cb6Xjk/4AldH/o9sKEco52elqZetBJykL0FEQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edc2yggxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 26 May 2026 14:42:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-83836443305so5239218b3a.1
        for <iommu@lists.linux.dev>; Tue, 26 May 2026 07:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779806532; x=1780411332; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OJiQqr3Kx8IGfpljF3ubZKSLxL/TpGa8jIJrCHd9nnQ=;
        b=djMOWpGcWvfdojimzBGSZEvtuMPeIw4DSJrttAQ6AJqFAXgcWS1kmPKLtLZdQOYV9V
         KZWddi0JACxMCTM6nRKQuCegMDGeCZkmhKCuiBBVkWYjvu6dEPyZmJQqi6sZgC5M/WXf
         5cCillOhMKvzynh+2DHNltITuDj/gb7BL8lyVu3v0tknBnsET4Dghw7BaZjbmdG4l3NS
         pgS9CusDPxfwdD8vt3SS/J2WeWEcGBkLEU0vYlYlcJLCxEM5YbsOWrKSJSIUrxnDlLjJ
         YCWDkhmvz3lHRq++cnwE+FSwj64gK8icLLkLpddHspNL4lGDZnxqQohm9ReL9rBrUkTU
         YijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779806532; x=1780411332;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJiQqr3Kx8IGfpljF3ubZKSLxL/TpGa8jIJrCHd9nnQ=;
        b=knrwlBDo0yhhRHcwuxIU2JihCWp7SmfDDIbfMXNCBxkrscY04Q+VFgZWgl09gAW7vf
         NU0KqeVKYV1XeM91IQXOXVSB+vRnK9wBXnDowvs3MvWJuHZUtZBiG0dleq7WRCX/9WXM
         nGyxnBzJJrvJ+LorMVRbbhf4FL33XWGy5vTXGxALFj5g0lRb5hdkrASOlf4cCfPbLD63
         dWOq0DHk8jO6oAKq9s+2W6Akffrgvgbh3fKfCilqQra6D783fpBhau1J387h3ocZydrH
         se60yboSOosX67oTC7N6h3ukI8sFh36XiEc8Amom7Myfbr7rDmaYk6UuxQbIc+FOjKob
         9KeA==
X-Forwarded-Encrypted: i=1; AFNElJ8jWS2u2iR5sLoC5irI87kuBWYh/11XNPl4b3KX3CbopSrdaRmfN7/nYmr7JINVUeeV1yV4zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCpFCQ5FOgX3i/wSpnzSHeWxv+B2LrFxQhHg+eqR9a1S/dtGJD
	llya9HZzYW7rHURojwq+2WFEGFxn73rar4Jzvkgd9vKNa2/QJ/AlKJw54x8nz0Fa2EHmGkqVOCt
	BOSRf02xfs6M36wiJvO3HhlY0iUQULjpCxNRh9LQOIgZft0raWE+5mRliGA==
X-Gm-Gg: Acq92OHVaLbfeCrJUKS0U7TZFAlBUg5mfWkvaS8hqCC1YMCkaUjAnbeBmyi+RBXRAnH
	NJxROVMra7XefK+VzXFNZUWmCe/P6/vkVLHSs7CsX4P9IfOFpIpF76mDT79fKwTXKzyTBs9P8gQ
	FFxGhsP8D3fsBLLkzu+3sHye4PRgdO/eK3pG0Vmis9t1yVHjhWiTloMkyxJvyVdjHawPp+CSPnF
	PPCVBiiqUj3g3FdsJo2VyfHr4KJa2n+9FGZttO8mGSNNEAMVqM8Z/hfUsxBENLjxWdDHve5Pz2H
	t8FFZKoEepIQY0UnrhpF1G+nNgrpUEUPBbgI4aruzBXhbNykHK4VTCM9QoreR2JTfhif0quO/0l
	p7cwSDcIpIZIYk1PwKFR+e0JDFsefr3MpxmAE7e2zkLFgAVxxAwK7
X-Received: by 2002:a05:6a00:2da4:b0:837:e9cc:d465 with SMTP id d2e1a72fcca58-8415f19e22fmr17299166b3a.20.1779806531943;
        Tue, 26 May 2026 07:42:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da4:b0:837:e9cc:d465 with SMTP id d2e1a72fcca58-8415f19e22fmr17299129b3a.20.1779806531391;
        Tue, 26 May 2026 07:42:11 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164acc288sm15362019b3a.10.2026.05.26.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:42:11 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: [PATCH v2 0/6] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Date: Tue, 26 May 2026 20:12:01 +0530
Message-Id: <20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADqxFWoC/x3MQQqAIBBA0avErBPK0KirRIQ4U82iKdQiiO6et
 HyL/x+IFJgi9MUDgS6OvEuGLgvwq5OFFGM26ErbytRWxW07J5ZEwe8i5NPkEDnlTGFnbGsaQx2
 2kAdHoJnvfz6M7/sBQV7ISmwAAAA=
X-Change-ID: 20260516-smmu_interconnect_addition-d9567535e9d7
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779806526; l=3074;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=uLBVRdHt1DzWyNxdmo3c1un5xSXTEc6wp4DIMqPlal4=;
 b=/Ne81frZrkFm12O3bT5MXS9r78AlTz/iZ3rH89KQuoikLX44xrKyZYzPj9hBcNKbp/325tjH8
 0XBzvdHMDjgBCjsAjZPjbGiePAPo5dN+smBTmF6hDnj3cr3fkfQFBAa
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-ORIG-GUID: 3QZeZ-t_MNNaaEaKhp7Vm8AKYAfcl0rV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNiBTYWx0ZWRfXzRqr6xpUeNsA
 AG6ooLQ3NYM5RzC8UovYhIr/OZ4wq+lSGIAPcQdmnk53qlCeH57i21TMxeQov7Z7lBf38Yy6FUt
 sZM/EGtr7w8ZEHK4SvFPZhbZX/GFcc4mcGO9DW2s4OmuCUPoSYCYESrGyXJqHuMwzgtUvPOS147
 7Wi4yIiZpy1m1F+dJlKlnewRxd322+U14RsP7ZCD7BRc3QAQ+7RVEARq/ES9DawCUwssGUAfsnL
 onzra6LVxx6Lu5Gws9ojkcJY1jgxpPWi/SkZBzx71TpDtiUtALg5eYuI1n5OT5+WtZL8nIWV6Xm
 o07N/xyuH5OTJEYTziDdo5FOmCCRo7FiP9fZT+0fW5qIV90n8HZrwMDkPY9d1lg6dMa55yjJfbB
 VZsztDcuAV+6RS2YyFYseJ0nTR1OTVo8UlUwO6M/5f9sN+W7NqtEBAbk/NhxPeTrEreMjs7HZCp
 Qt2NvkfDEKowyMHNL6A==
X-Authority-Analysis: v=2.4 cv=CYg4Irrl c=1 sm=1 tr=0 ts=6a15b144 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TPSRUwCClOzv9anTvj0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 3QZeZ-t_MNNaaEaKhp7Vm8AKYAfcl0rV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260126

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

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 27 ++++++++++
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  2 +
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 57 +++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  2 +
 7 files changed, 92 insertions(+), 2 deletions(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260516-smmu_interconnect_addition-d9567535e9d7

Best regards,
-- 
Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

