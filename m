Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB784DF4D7
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606313; cv=none; b=PKsIvDf3hT0O4nSO/wLWiGvEeMncvJoHKi+29kBs/q43sAmkgjaUYpnViDjg4EmGbm0NYgWJdsnHPV3SEgDN/EiBsirbmcge7X/t4d6lAHpthYmI6vsJvYSJFTzEdsXzs/q22I+Z2PRuNO1i0yuoxDg4PdZozIMXzQzH94f/Mko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606313; c=relaxed/simple;
	bh=H5GiHK6ztFKrLa7xReiffciw7VCa8JM2dUKAkH6u0T4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEpVD7X6iXrXorOQWEbWHR+CxZuC71LeMwBa/zGb9xmQlq03oRIDEnEFtslDo/papV7Qxtx/ncJYuDqB7iGzLGGkd2JSO5epXrF/aVEn8emoB4IgyTPON3bzHe9PLF/EPwIsXRd8i+tGt9UeE7tXS/PURLgVtU2/2dlOqsCDies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WEJVLUt6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M+rzhfBs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WEJVLUt6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+rzhfBs"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAQN7782762
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=z60xJj9fp2vRAD3QTBKkgHGd6KjBHDRVy/O
	SLFJMMjU=; b=WEJVLUt6Qgndx5YiL7HpWyG8kpXQW6l5olRaMN4FmaJtiSAMI7T
	3yv/pOhRBpkLZyiKRu0CfqCIbDxYg1vdaHIBC73J9OOf/tSqGMkuhLADt8b5ShH5
	BBBWHHl4A3D2+X1ObB3j0llCuQrJgtg29SJEBbeGast4A4kD2OXm+BAihAAGIShA
	BgZ0QlwUae0plvs6QYFxdtCn8m2+kcG9SqUn7P3XW5f+co5y7bdt6hJLhfJIzh9X
	c4ISX9iTXWVvLjlGbhpAY9jv8e/3I4XsnmtFwE/KWcOm9EtiAQ4z5l6gsYcoSSMt
	F177KeS7x4cTW3Fi7Mbg/muDcB24nsKEd8A==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyav4aymg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 14:38:20 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a7de733fa9so5204616b6e.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606300; x=1791211100; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z60xJj9fp2vRAD3QTBKkgHGd6KjBHDRVy/OSLFJMMjU=;
        b=M+rzhfBsN7poNA+qkB5rT71jkQgk3YnrCL3dd4N8CSnYpuaXs6Qn/6aHXWiAt8B/2l
         SraSj/6xlUGA9snPx5vgebaLPVvMr1XnAzVt9qQ+8b4ucBAxnT97qO9/F1wZfxL1s6im
         oK1adQBXk7SlnBapIUahK5qVgrRPIqzzQB26HklQLxf+CqWN5inrLXEQcQmqeIUjl0ZL
         y9l8YrkyB3IAoaOlq5pC/xuzpzP0r0+IJ/LbroDtqJ1f50/Di6MRW4HECdeyh6an7AaF
         2j0djtnQBB2A02qqRIFcSsdriwj+IR4nGxqPo7ZyeyfB47PDTf0E14Xf8Nge8juKMsFj
         U+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606300; x=1791211100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z60xJj9fp2vRAD3QTBKkgHGd6KjBHDRVy/OSLFJMMjU=;
        b=GdIjtviQ/NbAu5mtVY/xxLapGF+4PffdNFh55eDgW5PgYSSxwrSNeuUOPVXjRRm+Yu
         YAiWI+OzOHH4hywdlhvxEIJLsR1M6K+YKGuAYkAkJb/Ckv4vu/kg6/bmEJ6DhjrLl1ov
         0dKqjUafjmxfXsBvNwLsY/Bhec0FoIskgX/KzSrV/+Ar6cwpU0CVZWGQ3/dnLbJJkzKo
         6zPld+Ul/rFzT/5mG2i8MGACNjp35x2sRPUkJwHjerNZs2epzkblucVOxJwKzdN6fgsR
         n3Yv43BFYWp40knBt8Ju89llG1YXi6JM3hp278Y13h4BAAOtqXhWroDYnNDcsq0iMGgc
         kMWA==
X-Gm-Message-State: AFuF++muF/9BJv/eTQM73L4Y//zaRUaR+ib8Aqvfbyr/cYYYg5PqQU2h
	ebxxPBFc5iT30PTHFzrd1SDbrCIFR9QFH2sqEokBYbwEr7StEvjIDpOdasLIEKbyq8CRaIEnvGU
	ebClJNTHTbTFTnEcw/CwVxQvYqJwt9wPLh6+JbCyzg5xUkvybu0hSpFclr5gYyiz2vg==
X-Gm-Gg: AYBFou2fxfDj1/vi4IY2x47dPVCI1L+2OVi+UNkk7R0gVHwiquA+LqddmXh7mHG6Vrp
	Zq4Louxro/EazWCOcJ8iPxit5xIKdK2FTzZKxiyj0x5i4A226uiWzI6fZU+FnlK7yHoKqoTOctp
	3Moc/unD733/rNBnM2la9z54Kv36dm75ZhPikFhau1RZJ3rC8GPoGYJFgOZyT/xRJC8ZtDIsK2y
	62R0q5qOy9RBRX4Qwb19NNdlxTzR7ngs/9W7LfgsNBu7JCWO0CfiQrUtXNIwEO5i6jLN0ZQf0yM
	9gmUWriDgwDGHYJHrmhlosuNLZkpOAJmk52py/zVtMVyr4MiqZ1Utg0qgUI2hQmMxb91ZeDWKuO
	uxn03Xj221l8ANFkQbPzjVuqwILwRdmE6P/OH0Q==
X-Received: by 2002:a05:6808:3a1b:b0:4d6:9252:4645 with SMTP id 5614622812f47-4d72ea62a98mr13449662b6e.57.1790606299919;
        Mon, 28 Sep 2026 07:38:19 -0700 (PDT)
X-Received: by 2002:a05:6102:c03:b0:7a7:196a:84e6 with SMTP id ada2fe7eead31-7b390445334mr1519697137.30.1790605875667;
        Mon, 28 Sep 2026 07:31:15 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3bcadbsm292389266b.72.2026.09.28.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:14 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 00/14] iommu/riscv: Add irqbypass support
Date: Mon, 28 Sep 2026 16:30:59 +0200
Message-ID: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YsugHUwrRKGH4eO28gBVw3XaoY5YGKnl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX5n8hse1ECXpG
 G8bMatwi29E0XBhk96Mxkg5IqNwYqvs9FDzwsb2Zf7PqFyBelDDEddIXk5y3VdGMenI5mEPJ9r3
 IsICDYyAbl83VOI8SviAVL58qi8BbDDWWSbmkHV5t520k+DB7cmYU7MpiPsuWy8cfZMHzwVun1l
 2JS/r6wRjl4vGz7P4RbO+PpYC4yn2kAh3EcW1EXAqFMEio3r3b5QmoOOMVOHRB9rEbfWN1Tv8uU
 sZwsUUXu6syRuaFLmf6OeJdyY4FOPsIK14qouEbdonplbP00lw5eNpjPfdgEb6nZr80Szm3VW6c
 m06EPN17F5m5sPr6KmvAMcIkDJsevXNiEwbqeBY29U5mhS30iuL2Wi9/SwMsLVq16w7+LmoAg3o
 CUhL5gtFVaGlsHkiB0ITQjYyMoDBR2Wj91H/nI2Jtjb3s0M4JqPnwJ+CGRrZbBgF45R7Cxxwwvn
 9VLLQrw+vSH7jEYMcwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX1njsZN0KI9PI
 4llE+joEr4bYIxOpJnEDCRfnCd91K2GuZl2aGWdRshXSmy/7+XR2P28CTvd6i2cQyNIhOl0p7mt
 /xscPCtTOpa557J+Ta6hI89kzeB50MA=
X-Proofpoint-ORIG-GUID: YsugHUwrRKGH4eO28gBVw3XaoY5YGKnl
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aba7bdc cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=bDdBU3oEAAAA:8 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8
 a=JbFp9CTg7fNynJPQWhgA:9 a=_Y9Zt4tPzoBS9L09Snn2:22 a=DN7SgORnOiO7RqxRx1GC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280058

This series adds the RISC-V IOMMU side of IRQ bypass, allowing MSIs from
assigned devices to be delivered directly to guest IMSIC interrupt files.
It uses the IOMMU's flat MSI page table to translate guest IMSIC addresses
to their host backing, with support for both hardware guest interrupt
files (VS-files) and memory-resident interrupt files (MRIFs).

It has been a year since v2[1], and much of the design and implementation
has changed. Host MSI remapping, IOMMU_DMA, and VFIO enablement have been
split into a prerequisite series[3]. This posting contains only the
IOMMU/IRQ-side support. The KVM patches will be posted separately: they
are currently a minimal client for testing this interface, with further
work needed for general device assignment.

The design evolved while considering two-stage guests in the discussions
with Jason on v4 of the host MSI-remapping series[2]. With a guest vIOMMU,
the address in the device's MSI message may be any guest IOVA which the
guest's first-stage page tables map to a guest IMSIC GPA. The hypervisor
cannot determine the target vCPU simply by decoding that IOVA. Instead,
the intended hardware path is:

  Guest MSI IOVA -> S1 -> guest IMSIC GPA -> MSI table -> VS-file or MRIF

An MSI-table match completes the translation; addresses outside the MSI
pattern use the ordinary second-stage page tables. With S1 Bare, the
device uses the guest IMSIC GPA directly. Populating the MSI table with
all guest IMSIC targets allows guest changes to S1 mappings or interrupt
affinity without corresponding MSI-table updates. When a vCPU's host
backing changes, the hypervisor updates the entry for that guest IMSIC
GPA, leaving the device message and guest S1 mapping unchanged.

The MSI table belongs to the second-stage IOMMU domain and is shared by
all devices attached to it. RISC-V requires second-stage translation to
be enabled when using the MSI table. This is separate from host MSI
remapping, which uses ordinary page-table mappings prepared by the common
DMA-IOMMU/iommufd code and composed by the IMSIC driver.

A per-IOMMU interrupt-remapping irqdomain, installed as the MSI parent of
eligible devices at probe time, provides the irq_set_vcpu_affinity()
entry point. The IRQ hierarchy remains stable across IOMMU domain changes.
The callback obtains the device from the MSI descriptor and operates on
its currently attached second-stage domain. The irqdomain has no private
per-IRQ mapping state or MSI table of its own.

The affinity protocol supplies an owner, the guest IMSIC address pattern
and mask, and the complete set of guest targets. The first forwarded IRQ
populates the table and installs its configuration in every attached
device context. Further IRQs share that table after checking the owner
and address layout. A separate target-update command changes a guest
IMSIC's backing without changing per-IRQ forwarding state. The last IRQ
to stop forwarding removes the table configuration from the devices.

The main changes since v2 are therefore:

- Separate host MSI remapping from guest IRQ bypass, and use second-stage
  domains for the guest MSI tables
- Replace per-IRQ MSI-entry mapping and reference counting with complete
  guest-topology setup, domain-wide table lifetime, and individual target
  updates. This is intended to accommodate guest-controlled S1 mappings.
- Add IOMMU-side MRIF support alongside hardware guest interrupt files.
- Move the KVM client out of this series

This remains an RFC, particularly for the relationship between the IRQ
hierarchy and the domain-owned MSI table. Jason raised the alternative of
a per-VM irqdomain owning the table[2]; the arrangement proposed here
keeps the IRQ hierarchy stable and ties the mappings to the S2 domain
shared by the devices.

The dependency stack is based on linux-iommu/next at 634706fe6e36, with:

- "iommu/riscv: Enable MSI remapping, IOMMU_DMA and VFIO" v6[3].
- Fangyu's "iommu/riscv: Add hardware dirty tracking for second-stage
  domains" RFC v4[4], which also supplies second-stage domain allocation
  and page-table support.

The branch below contains all of the above, this series, and the minimal
KVM IRQ-bypass client:

  https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v3-kvm/

Testing requires userspace to select a second-stage domain, for example
by allocating an iommufd HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT. The
corresponding kvmtool branch is available here:

  https://github.com/jones-drew/kvmtool/commits/iommufd-nested-rfc-v1/

LLM-based coding assistants were used during development for code
exploration, patch review, test execution, and drafting and editing
commit messages and this cover letter. I reviewed and finalized all
resulting code and text. Per-patch Assisted-by tags are omitted in
light of the ongoing discussion about simplifying coding-assistant
attribution.

Thanks,
drew

[1] https://lore.kernel.org/all/20250920203851.2205115-20-ajones@ventanamicro.com/
[2] https://lore.kernel.org/all/20260820214150.545737-3-andrew.jones@oss.qualcomm.com/
[3] https://lore.kernel.org/all/20260925151659.419512-1-andrew.jones@oss.qualcomm.com/
[4] https://lore.kernel.org/all/20260915032828.11250-1-fangyu.yu@linux.alibaba.com/

Andrew Jones (14):
  iommu/riscv: Allocate MSI tables for second-stage domains
  iommu/riscv: Prepare domain bonds for outer locking
  iommu/riscv: Serialize MSI table publication with domain attachment
  iommu/riscv: Reject live S2 replacement with forwarded IRQs
  iommu/riscv: Derive the IOMMU from the device in IODIR updates
  iommu/riscv: Cache the programmed device context
  iommu/riscv: Prepare MSI table updates for interrupt remapping
  irqchip/riscv-imsic: Define IOMMU IRQ bypass protocol
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  iommu/riscv: Add IRQ domain for interrupt remapping
  iommu/riscv: Prepare info->domain for concurrent RCU access
  iommu/riscv: Prepare interrupt remapping for IRQ bypass
  iommu/riscv: Validate IRQ forwarding requests
  iommu/riscv: Implement IRQ forwarding

 drivers/iommu/riscv/Makefile            |   1 +
 drivers/iommu/riscv/iommu-bits.h        |  27 ++
 drivers/iommu/riscv/iommu-ir.c          | 505 ++++++++++++++++++++++++
 drivers/iommu/riscv/iommu.c             | 352 +++++++++++++++--
 drivers/iommu/riscv/iommu.h             |  56 +++
 drivers/irqchip/irq-msi-lib.c           |   8 +-
 drivers/irqchip/irq-riscv-imsic-state.c |   6 +
 include/linux/irqchip/riscv-imsic.h     |  60 +++
 include/linux/irqdomain_defs.h          |   1 +
 9 files changed, 974 insertions(+), 42 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.43.0
