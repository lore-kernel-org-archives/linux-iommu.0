Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E263B3DD866
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262118; cv=none; b=OFveykd6VFP+4PPJvd7B70TCUEQQz7jeSanSFI0yPQS5AKI2ZDKbsTVphWBVBruwA6ra3xEz/3IAoHQn6qIJT5un7+srrlR/2TAyg3/+nqln/wJfZECcLLFzyrs6K6GeLUHU1reELV58B+dkcQHgs2hT8fbLtQApnUextvimZmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262118; c=relaxed/simple;
	bh=hHYQn9PR2m95l7aDARakl3/C/8daRifvWIdm0TW1Kuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dBPTdNrMtWMWPIWO3rCOZKkj6JkeD8jHmum2Gix1mpFD3gfuVep3BvJeEYXIqG5pTHG3inztlv67DnIobbcrKLu1rrm+H5Um5dahLlyiMDT2jNPHZABZJi8fgFyW2+wA1bxi6hO80UO/KVbqY+Fzrc8Ww/6wsq8Tndp+CiiI8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xe1KDJx0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OghL3VRe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xe1KDJx0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OghL3VRe"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7Y6l250323
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=j6Bwt9iYUQQSgcsBbVeYnZY6fTgfzlVwvWx
	n3LzObN0=; b=Xe1KDJx0lFBAjkmtJ7gBkS1/b3Bi3OnTOov37nhLUUjj7D8aKMN
	rZ6ywynDG64aQvR2b7BZZgVdrshIp4Lac3WH1efUu9GXSpCQ0j/OD7k/+XaKuQK8
	v64aTxN1VjbkBrT8/wLxdoRcL+CWS8Iga6MGZj+/1r6cTKJmXlEMQt6Dn/cpxZkL
	GwQ87gkXzCIqHyEKUjp10kGqkQmFNzw6q8aqFTRiGtDekD6uWvweRIX6NKmBgQTh
	k4zsL83bWrLYfTSt9gIUf0kGO5wNKCs+KaG/dVoZuUBhopjqzZFkA0qoAtjuZyWa
	EJRJdAFx4Nx7XNCbQ/tTd64RmRBg3Z62luw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bqnw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:41:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52de40127adso3349121cf.3
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262114; x=1787866914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j6Bwt9iYUQQSgcsBbVeYnZY6fTgfzlVwvWxn3LzObN0=;
        b=OghL3VRetew++vilqZtu4ZuRwgX6kiynpVGFjG44e6GlpcD3mv5Vy8FptOvIVfg4Ys
         OTiF4D9hyxXeijYSMVse03croKnvulYY7WU8LbdZ7ipXtbgVXwi8H+gI50sQzg4bTBoL
         ZcoYyI8o8VmfD+IghoZwrKErpWgButDyRZG/0OG3lTQpRECE89JVLjp6Bs8uztkTYILW
         DCMMGLU+/p9+jOsZ/GvZ3rStLp95C4A8ONz0EZLL1QyWVjKxh8Jpq/XMX/pzcME7Xk6s
         874xyR6Tc4MOcTlWMkSHPFBA4n2J3TOqL1gZ5BVHnOsl7Fbg+Q7JWLZ+RGXRTEJ0UYzf
         iV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262114; x=1787866914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6Bwt9iYUQQSgcsBbVeYnZY6fTgfzlVwvWxn3LzObN0=;
        b=tJXJdJQzF71dsSSfmM9LRMMlyDyO+D6/tyt4Ox/t01pLkg/cG0YwhXpbqggn53Tw7k
         JOpyyPu1ON7R9uEIKo6IJY52kwiv7h2w3NGhrpKMN2o5/RfSvgHIm+h/dFNRrJcikmkg
         7BNvvFP6IorYYsJiecmYK+tqw86GbhaLPoFZC6Liemh9cBfbk0tdCcWrPIdgYrBVJiUJ
         Bvj18bn8W3R8dgEopetR7/Ttsppi1TTGYfoyrwImH2QhQMjqz3jD4YPqI1ZojZC1RE6y
         TnwsZ1avEsAl/vkn0VAz6azjGGAneq2TFIej7ON4+DxXKmAYAfHZAalPFKCFJmBl6mr7
         e3bg==
X-Forwarded-Encrypted: i=1; AHgh+RqMiZZD7rMh/w94Ohlgw9ZQuyrA5CaQSjlrae/oXuEeZuOUTscenAxGZWkq/U9p/YLJGrOSbw==@lists.linux.dev
X-Gm-Message-State: AOJu0YweuERK34h1ZuXUy7bPMd4KeH2gQX2T3u3FPGPAn79l5U/NvTp6
	F9hxiqCAlMsnweRlmw6JpOzsnTkPhkI1v6OiClnN9wAk7rDmH+5QZF+C/tXIj0mFv95ePTGmEZW
	V1llmsvuZVw/y4Wjs4RumXegld9JdiDHhoxK4T1+n6XevE+5BZ30h4FDW4Q==
X-Gm-Gg: AR+sD11Nr0DqxEBBCjBF2DW/rrj9dqbq5Sev7Sy5oMRvs1NoRXrhZqM53K/NEZ2+PTt
	zhfeM1O0SMfzOI/UOCBlHqlRLmGzB+W/19+1QFNv/nV+AxTYoZRnL7Asr35y3X7yvoXJx8omcqi
	/SXJUQIlwsBymX+ihWIJrIB9fk7UZ8pSORops0vsCHJiiiTzzPoqv5BAJwo/s1Ti57SjNlAJPFy
	SmIrbjn/f3wPRqYFr8dM6jrdLVhqkRROCVFUInI17IiIOeFOXXi/MGVIS8PVSvAvk8fyjSfhkZR
	iJxAZB+iWtYza2Za/Xq9MyqI5qqqbI0HvEIvKcFpy8n90sTfDzX8LOjMxff6K+4YAzuDtPcRvof
	awFy/QwcN
X-Received: by 2002:ac8:59c8:0:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-52df5694c1emr15478421cf.9.1787262113786;
        Thu, 20 Aug 2026 14:41:53 -0700 (PDT)
X-Received: by 2002:ac8:59c8:0:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-52df5694c1emr15477741cf.9.1787262113094;
        Thu, 20 Aug 2026 14:41:53 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e61sm15340014f8f.13.2026.08.20.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:41:51 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 00/21] iommu/riscv: Enable MSI remapping, IOMMU_DMA and VFIO
Date: Thu, 20 Aug 2026 23:41:29 +0200
Message-ID: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX0d4/AjqCy9jU
 FqjGDzOYaHh3vi1Zi7/WTdzV22+OV9G7j0WqoI8i08welOFZ4a/NPG7sktOY+mKVIjnHTKOjXH+
 KWVknogHROWraTdCPUWZ1wqlgEnLWp4=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a8774a2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CRasP5_FkgFBEu7lvvUA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: e6oACtk07aDE0sbwE8G3qsJwptvH6rrb
X-Proofpoint-GUID: e6oACtk07aDE0sbwE8G3qsJwptvH6rrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX5V7ILjnIaBQV
 ze+13E302EQnsKSQ8Rqx/bSelIkSLpSl8d/NzzO5RFOKmAjy6aMEHJemJKKuTiCHTutR33qsvRW
 TA7czdrZSNvyfClCLZbIFVM2QsTMHLYXFUzhLNBk5WtyZgzHRuC1IZ0RPPX1lFXMzy77zq+xRFY
 T1D8P6UQOx4aTHmStfdR/UO6YaTRwfE4gclXkX12I5v/tEMz6Svp1o/5gXgDsL43xavhYlbM+ew
 535jCCSYnQFAhxiJS2+nAfJ8fMxhCaJy99jMR2Bd+6hjeGiFPv3dfnUh2jWSZ8wVh6KlolKnhii
 5nkUTY7d6C4hEiz3/pYzxqNYnCSE8S/kl9PI6P1ni7+WcEFLV/dizG3u9jfWvEbjDdSyk8Nd/Bc
 lZhJxKN86gVJ+G2xB7UViSJ4xHaljVvZpwcWPjm4v8uhwmsp0BPLIX9FifPLwvKvDM2OyH2Uelp
 1U2K1rmP8J0KKbLDklQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

This series adds MSI remapping for IMSIC so a device's MSI target gets
translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
and paging domains by default.

v1[1] used get_resv_regions() with IOMMU_RESV_DIRECT_RELAXABLE to identity
map IMSIC pages, but that was rejected as only a workaround, and the
proposal for v2 was to follow ARM's approach. This series does that at a
high level by introducing an IOMMU IRQ domain, mapping MSI targets into
the device's DMA address space, and rewriting composed messages with
msi_msg_set_addr(). A new iommu_dma_map_msi() supports both DMA-IOMMU and
iommufd domains and returns each mapping to the interrupt-remapping
driver rather than caching it on an MSI descriptor.

ARM can map a fixed doorbell PA per ITS and cache its IOVA on the
descriptor because affinity changes only hardware routing, not the
composed address. An IMSIC target PA changes with affinity, and MSI
composition may run in atomic context, so mapping the selected target on
demand is not an option. This series pre-maps the supervisor IMSIC page
for every possible CPU into a domain-local PA-to-IOVA table when remapped
IRQs are first allocated, allowing composition to select the target with
an O(1) lookup. If iommufd replaces a paging domain while IRQs remain
allocated, the incoming domain's table is rebuilt before it is attached.

The series also carries the remaining plumbing needed for RISC-V PCIe
device assignment through VFIO/KVM: the RISC-V IOMMU reports DMA
cache-coherency capability for coherent devices, VFIO type1 and KVM_VFIO
are enabled for RISC-V, defconfig enables IOMMUFD/VFIO as modules with
cdev support, and the generic VFIO/iommufd selftests can be built for
RISC-V. The RISC-V IOMMU specification does not provide MSI data
validation, so the interrupt-remapping domain cannot provide isolated
MSI. VFIO device assignment therefore requires the applicable
allow_unsafe_interrupts=1 module parameter. Direct MSI routing to guest
interrupt files (irqbypass) is not yet supported by this series and will
be posted separately on top.

LLM-based coding assistants were used during development for code
exploration ("super grep" as one of my colleagues calls it), patch review,
test execution, and drafting and editing commit messages and this cover
letter. I reviewed and finalized all resulting code and text. Per-patch
Assisted-by tags are omitted in light of the ongoing discussion about
simplifying coding-assistant attribution[2].

Thanks,
drew

[1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

v4:
- Rebased onto linux-iommu/next
- Addressed Thomas's v3 review comments[3]
- Added documentation for mapping MSIs while replacing an IOMMU domain
- Reworked domain replacement to rebuild MSI IOVAs through each domain's
  backend rather than copying iommufd tables
- Rejected passthrough MSI mapping results when preparing an incoming
  paging domain, preventing a first iommufd attach with live MSIs from
  caching an unusable address-zero table [PatchWise]
- Deferred interrupt-remapping domain publication until probe_finalize(),
  after the IOMMU core assigns the device group [PatchWise]
- Refreshed stale OF and ACPI platform MSI domains before setting up
  interrupt remapping [PatchWise]
- Used vcalloc() for the sparse IMSIC PA-to-IOVA table [Sashiko]
- Reported IOMMU_CAP_CACHE_COHERENCY only for DMA-coherent devices [Sashiko]
- Clarified that only direct identity <-> paging domain transitions are
  rejected while IRQs are allocated [Sashiko]
- Used the old-domain argument to avoid unnecessary RCU lookups in attach
  callbacks [Sashiko]
- Fixed the VFIO selftest architecture check to use riscv64 [Sashiko]
- Reworked commit messages throughout

[3] https://lore.kernel.org/all/20260807181713.228535-1-andrew.jones@oss.qualcomm.com/


Andrew Jones (18):
  iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
  iommufd: Add iommufd_sw_map_msi()
  iommu/dma: Add iommu_dma_sw_map_msi()
  iommu/dma: Add iommu_dma_map_msi()
  iommu: Document MSI mapping during domain replacement
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  irqchip/riscv-imsic: Compose MSI updates through the hierarchy
  iommu/riscv: Add IRQ domain for interrupt remapping
  iommu/riscv: Refresh platform MSI domain before IR setup
  iommu/riscv: Prepare info->domain for concurrent RCU read access
  iommu/riscv: Reserve an MSI IOVA window for iommufd
  iommu/riscv: Pre-map IMSIC MSI targets
  iommu/riscv: Preserve MSI IOVA state across domain replacement
  iommu/riscv: Gate direct identity boundary switches with live MSIs
  iommu/riscv: Remap IMSIC targets during MSI composition
  iommu/riscv: Report cache coherency capability
  riscv: defconfig: Enable IOMMUFD and VFIO
  selftests/vfio: Allow building on RISC-V

Tomasz Jeznach (3):
  iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
  vfio: enable IOMMU_TYPE1 for RISC-V
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch

 arch/riscv/configs/defconfig               |   4 +
 arch/riscv/kvm/Kconfig                     |   1 +
 drivers/iommu/Kconfig                      |   2 +-
 drivers/iommu/dma-iommu.c                  |  33 +-
 drivers/iommu/dma-iommu.h                  |  12 +-
 drivers/iommu/iommu-priv.h                 |  11 +-
 drivers/iommu/iommu.c                      | 109 +++++-
 drivers/iommu/iommufd/device.c             |   3 +-
 drivers/iommu/iommufd/driver.c             |  87 +++--
 drivers/iommu/iommufd/hw_pagetable.c       |   1 +
 drivers/iommu/iommufd/iommufd_private.h    |  41 ++-
 drivers/iommu/riscv/Kconfig                |   1 +
 drivers/iommu/riscv/Makefile               |   2 +-
 drivers/iommu/riscv/iommu-ir.c             | 397 +++++++++++++++++++++
 drivers/iommu/riscv/iommu.c                | 111 ++++--
 drivers/iommu/riscv/iommu.h                |  48 +++
 drivers/irqchip/irq-msi-lib.c              |   8 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |  27 +-
 drivers/vfio/Kconfig                       |   2 +-
 include/linux/iommu.h                      |  31 ++
 include/linux/irqchip/riscv-imsic.h        |   7 +
 include/linux/irqdomain_defs.h             |   1 +
 tools/testing/selftests/vfio/Makefile      |   2 +-
 23 files changed, 819 insertions(+), 122 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.43.0
