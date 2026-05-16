Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF222FF22
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934861; cv=none; b=cdaFPC+SOE6XexBH+BKGdfTZL0CD52PWT4hqc9HWS31bWeSzw+NR4cZxt7qgjN2fyoABlWPDNnm/o2JkTFvexBx43MPNs7xzRMf00khw7w6LFmSF3/migiinXUIhLsIJcIUQMrvaAEvbf8OjU3Km//owdgTL3QbWkGs7iwKGDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934861; c=relaxed/simple;
	bh=wqpXfIpeij9xEfvUNcjaE+C+fgLfl5o0ZRfgRNcaWrA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YtUIYZx2XBjvZeM1k0q5OW7fRaenPtP5eYCYi484mAiqQkakjvVWU88PuPk5AuwLEWQo9UnvAFZWLeWIxNKLAtLKloqEnYfNellnHrEUwYiEdBrrLxDzGQzKmf4bnUAmARC53VmT+VNaCvGWm609rMakH1KPfiIlZ3cB2XJ2ZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NwCWa8Oe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D7ABmFN2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NwCWa8Oe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D7ABmFN2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G90Ixp3373038
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=v/qlA8PM2DTSSKhlDDk1SL
	7aX+U5Iuh8+Hnk2GoP4P0=; b=NwCWa8Oe64/+tC+7G1YPgU4Sl+IxypHWpjZ6+U
	v3HMl/VIwq3Gz/+vSD82ELktoiGIT7WHPoFt62DX6rQnW/L9RElH0wySuO3lw2/c
	dPfxI/s7UH4sG0kKoFghl01BuSSVS3LbMNMgBN/IVeT3ffF5z9PS6ECcbxZj6W5z
	5m3nmPfPvUO9pQxUv00zgomy6m5ThIQ5ftSveZ8HSYnLuXzNXQVrw2C8+I+4WeE8
	/rVdErwnm1dpQVrvBg5FzMyBGHhF8tMPdwxCpxkNKQ803tv4vJR66AMj+5YOLzsx
	Bn5fnF0r4ulXRJiOkDVCLu2K4ChY0GytyDs3o2/PmyWqk/wA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6hv7rqx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 16 May 2026 12:34:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8353b042152so910702b3a.3
        for <iommu@lists.linux.dev>; Sat, 16 May 2026 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778934859; x=1779539659; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v/qlA8PM2DTSSKhlDDk1SL7aX+U5Iuh8+Hnk2GoP4P0=;
        b=D7ABmFN2J/DePj1d7t7d4VmZ7SzbIpUKUr/slfIosX9jpJ+9hLsDnUeCGOURxRJtzU
         GFQj75ObZThC4RXR0+UqyBOh1lVitMpTN5MxNQzbSALYhonVU7XDRDA2Qe8W0GEUCUaM
         iPLmua1h6KhF2EyrdW2N9lUD+N9kG3rw6HzQ55WmsPDsqVyUbB9TbRlwD2s69zfvoUSp
         HLniBF/hdN95C0vWCrejk0p2nuyfupRV3+V3Q3HFUcxta18zhd2JzTkNbByp+wr28Wxx
         goc3ZQF2AexfEqt0r/A6lMRqiGkKGzxESSo1VS1VVZxdFgKAHd8hY+yzGikBIOl+5YTN
         FMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778934859; x=1779539659;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/qlA8PM2DTSSKhlDDk1SL7aX+U5Iuh8+Hnk2GoP4P0=;
        b=BVTKNFSZjXOVo7j4ZLCVU5JrofJqTbWoa7ej0bkcd153dx9AnsfpxFGc3zFPJRjVbO
         wEqZPmmZExntCyTVQumCv456xqYKIOPET2+IibafMFwAC3rUjSYvTMg6vxdMWcKpU4Ce
         zOuwE2s4/i5MWswTgZ3DFCzMiBxx0HcRlcR91jVBgA2/mZuDaXG2z+6V4dn5okw4cbSx
         p2Y28aznWlyRjXsUkVLbDIWPiSNvolKgBRvcAUb+wseHzLLSNfuccblt/wXzkLx2PI7U
         wzJEgSzIVv95RK0TuNgtRGBi8U48yLqJTdv4oKsfNZJ/kj4syWscyuLZcxK98aIT7wYA
         JubA==
X-Forwarded-Encrypted: i=1; AFNElJ/a0KDY815osDaLmKhG2zrbV5h7pcfOJRIXJpj/1iCa7I13TYW1pz5CaSh8Ss4joq2CwPG/FA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpHZUopOjCTjYDYaVPPJhodcd6L7/PGXVp7+71cLXILCJyUJUJ
	l3LJMG8qJtkyQ1PSJ6GjR7OLELkwHfLMR1W0S/zChtp2g3Hbppddy2rMylvze1RpLwsgFcvXQ0T
	0LNmsCDXvGl0o4ODmKHqaBFS+3LzoLC5IHlLkvDzua4270Z8Q+CEn4VsghPcPlFXFgw==
X-Gm-Gg: Acq92OHuHdUdXj3DnWCgkC3b+zk+tSRhdYqJElBcO2u8jxDZcGLabS0wHpCviITxvAG
	agNhaGREIpU6et0yu4VWlSCRikrF0K3LHPbWGkKAbfejJAEedB5BCrYXdi7lkwRGlolS3uDCYeh
	TxDC6o3LECInJOvLqq8Z6yCLQrqgwz6e5b5efdEBpbuQ9YqKHKF7kStR9giCew7Ahk96zcdHoTF
	LNMvjrCndWg+iwEA6OmvvGLwJCt6NaPS9AynEw1KjmbU/LvDB1c0G2F+IamwcyTXVL1acduasI7
	EyJ31gabbvui1wVj9LHOVdf8/Cth/QrEcKS4EiTnizUhl11rBtLpKVtDyi/OgnWpQdSsBZ8cWJ2
	XXz9huVNe2r5OzScaHjqAD+uP4PO43XgQmBTGwg8Z9z3BtalQctxQyQ+MTXmCxrk=
X-Received: by 2002:a05:6a00:3028:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-83f33d9dc40mr8418952b3a.32.1778934858923;
        Sat, 16 May 2026 05:34:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:3028:b0:82f:2243:e445 with SMTP id d2e1a72fcca58-83f33d9dc40mr8418925b3a.32.1778934858440;
        Sat, 16 May 2026 05:34:18 -0700 (PDT)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc9asm11405217b3a.53.2026.05.16.05.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 05:34:18 -0700 (PDT)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: [PATCH 0/2] iommu/arm-smmu: Add interconnect bandwidth voting
 support
Date: Sat, 16 May 2026 18:04:02 +0530
Message-Id: <20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADpkCGoC/x3MQQqAIBBA0avErBOsUKmrREQ4U82iKdQiiO6et
 HyL/x+IFJgidMUDgS6OvEtGVRbg10kWUozZUOvaalNZFbftHFkSBb+LkE/jhMgpZwpbY51pDLX
 oIA+OQDPf/7wf3vcDEL/MpGwAAAA=
X-Change-ID: 20260516-smmu_interconnect_addition-d9567535e9d7
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778934854; l=1960;
 i=bibek.patro@oss.qualcomm.com; s=20260408; h=from:subject:message-id;
 bh=wqpXfIpeij9xEfvUNcjaE+C+fgLfl5o0ZRfgRNcaWrA=;
 b=JhI5NIrTKt3Fz1WHFtw59UHAjtXkzMyTDK6UkYq9PmroRFC6ryp6bV7aLu3hq2ngBFuCBlEh4
 1OPRd2WhGNsD5MXrmvURzIV8+iuWhpm0brMLZ+Y/ntndjB1FeER/fa3
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=V4oTa+TgRi7dib76fc92V+rslyRCAKbK8D4b2RVsMbc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDEyMyBTYWx0ZWRfX98H9puX2WPdb
 eMIjgb75tT4EuCl9lGlh7jfxWfCyeSwesP+GIVHfHx8YdPW1XbewP8AgZAdE111/E/AiQ1SqdO9
 +7O+8Sdi0UFn6/TOw79Rk6HRJbre7kvhwhx1yfubHMphKa6SoO5/074z7jV3OBnljM9ux1LRQtO
 qtUmGIYFZYEl3K5EVO5EiKEZEcnfQg7G573tQsE18PHkh4ScL59EH2N6GcVRhsPZviD/ufqS9nT
 PClPFAq+DtZJA1DrHnAtGUU70+k2rbzjtgKg0k87k8tB41ZJCGvD7xm6NI65UyRC/gBdmUquQ49
 tA441XZJ6h883L6eJvEhfgcx+nPVkqIdKy2uSQ/h67OV0l4jwBomBk0nWUcFgaypDWyt6vch3Dp
 u1CFkguKSSQzG+nMHGpFuK8BZHQNb3I0piNGNpOY7wiN9PFsGkfzB77lMfh+Naojyp6RUGl2wON
 txidnuOLhZ0ncrWvkGQ==
X-Authority-Analysis: v=2.4 cv=a8oAM0SF c=1 sm=1 tr=0 ts=6a08644b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=Z_0B4eLmBfDa8jkmzhEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: LrCOnsAD_o8kOHoZG2MB8pjO-hmrQBig
X-Proofpoint-GUID: LrCOnsAD_o8kOHoZG2MB8pjO-hmrQBig
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160123

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

[PATCH 1/2] documents the optional 'interconnects' properties in the
arm,smmu DT binding.

[PATCH 2/2] implements the ICC path acquisition and bandwidth voting in
the arm-smmu driver.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
Bibek Kumar Patro (2):
      dt-bindings: iommu: arm,smmu: Document optional interconnects property
      iommu/arm-smmu: Add interconnect bandwidth voting support

 .../devicetree/bindings/iommu/arm,smmu.yaml        |  9 ++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 53 +++++++++++++++++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  2 +
 3 files changed, 63 insertions(+), 1 deletion(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260516-smmu_interconnect_addition-d9567535e9d7

Best regards,
-- 
Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

