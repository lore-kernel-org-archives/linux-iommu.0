Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C130285CAA
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126639; cv=none; b=imFxfAhbWpCpt9wmX32833PWSHCzKsB5/pwaIY3XbR0ORa6DyRtXYg+p9qYWyRYLTaTzxXKjlnd5DRXzuAovjWElbwjF11XsTxvZT/0faA6AVIhRtr/0bVYWTGtslKgyDBeMz8Um/DOhtvNDOhiQVZexFOKsb4hyhKUhSDc6Bhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126639; c=relaxed/simple;
	bh=73OmjTSCcVR/hU29SHD8+thM3YVWysYt5KI3hDNNhe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rAjHyFPCy8F3Dncntd0L5c6VYFJxWdpjFxYNaLXQrZjtCV1ZfCbmfHPF2Zkk5tty7fjOVIXxvZN8RiXH4qRmUPwSVcBZ6G+fxdx9rcHLRTR28n9xvVcdFtUpeoH1S/Ex21Qm3Y6xjpc1Dgbn6q2rroGnqWn1JXVNHg1CipgWNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ztn6r2+f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTgNde6C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ztn6r2+f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTgNde6C"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GOLDq769985
	for <iommu@lists.linux.dev>; Fri, 7 Aug 2026 18:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mTHaDqPuYE0hc87S0Qdk1xSBSfV/vLCUnN9
	+GLT39n0=; b=Ztn6r2+fHEdxxJidlueemU/H3tuB3y5qDexALM31F4qZRnFgReE
	wgIBRUhn17QkSRg2nf70wxMYFRH44a9OKnv40IgGPYRLgIu3LsHSjHVTzSaDwc9a
	IeincXYpq5hgP4NZAJpdgY2Sl4I3yI+5qqFVU1H+ktaiJB96GI1LwSnBZvCQ/Eva
	+WixgyVVLfTsUkNCy4tNbgHMbo+yB9+bMuXEnWrgWT+QvE0WPFJ8u2TkU6zjqbR+
	oP+LxE4PEWI6pSNzhDhQAH9Ravw2Zj6HvVl66W6t6E0qfH2/9J765E1GCa1bsJth
	oKtpicsSA1XtVxkEetwMAo3YepwSsYY/wFg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fw9vu2uxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 18:17:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0408254aso26166021cf.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786126636; x=1786731436; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTHaDqPuYE0hc87S0Qdk1xSBSfV/vLCUnN9+GLT39n0=;
        b=NTgNde6C4aQZf02ofYyTW54QpVgPs5yPaHAqiL94FJzK45XP+MVfWiIh7+WkNYjOSH
         gEqczZyo38wS80dSBJ/MgGX84Z5FS7Q/pP5c1kxor78HkJfFac8BkCyqn48uEYBLnXXA
         dVPw9m4A+32D3hpGver1DD+SM3HMxdInDJOgwi9vNdhdy7CXvkmllJFWHDHEt9Z+dpL7
         RB47mdv0izeXfc1a7V+7vLx1e9zDZ1L6NFMawfrlGE/cHCeRhA8iBI52g8ho1QHV7orB
         2gowv5gt/14Pji8qhTsdgSK1nIj8+qiWoI9qvyhUjDEQBdIUgrQOK0NX6ry5zLi4RspK
         QE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126636; x=1786731436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTHaDqPuYE0hc87S0Qdk1xSBSfV/vLCUnN9+GLT39n0=;
        b=rjPsS/oZvwKBWOvlK/9hIH+b5uAyL3dgC+cTetdr54d55+wK9woQEGTviOHzRgnfAE
         sOujYOY78fKJMhXLI/MlaTxrVxEm/d/ZkVU4Pr6Ml1lys7SXU37unS387CKtpdcvO4Ev
         gacvGO7EVYJsvB1Ldc5xxGH6iXD6j3lf4EDaDQACCEkOoG4iN136j1jCCYiQsPe2IbV5
         87k/3+M4YM90sUDiemQbexNXSCh6aPvs7aQ4tcGgvLnErUOWCi+LCXwlM0pgHz5SAMIs
         sTgR2dTysQDy4Yvepg+cOWLhTD4VMCuds7wPXxIwxgZ+co8izvWHENm6Nav1kqG6cwXC
         1TUA==
X-Forwarded-Encrypted: i=1; AHgh+RqN8cpuS8GZGlqKSrgoRiIn1noVQJBe0RUzOcYrzAs6syeh8EDULGniB1fzevnEFkyJ8LvQIw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNEO74KgJO8XegClA4BQQnMyAEcYs+GVCw0Kseozd8EbBxkm1L
	p3+k5FKxR6bJogcJdp95wSFnMqGeUH/1kVfa4aaCwHkZiB//X+XeooA3ooMsuzvbs70UxQf3Aj/
	fz8MCcMiIM7z1UHLWswHXr2SpkqOisNxE3lDEfvNHcuLNtjr/mbbldIFlig==
X-Gm-Gg: AR+sD12n+Kl6kyFz/YlRYLWqbbw5YAtzdVkjdFJHY0r+M9f1ZJ6hdOYZvUdCkhJkt3N
	JCt8pX4DhoElYiU+UcN47vz+vHWSttyHXKa/t9/z4scEMFGN6ISVMSadDeUTWTR5Vpyvhbq1f2d
	fENvco1OZ0LR6dCfEX36Ld3lL6rhgzmvIL2DgXZzJkBbE5RnO7OSpo+kH0HApGUoTJb68QBUowl
	eKK3uiGSlkkDjt5SdK/1uUSA0+KNTxmisx11F5zGorhL/FXQLerhrYFjeyKehglTq6e5CSrdlRH
	bkjYU0sDyqUTUCgm365DS/vAD50m+dfYnnWhoz2bZBpDeil8ygUnCY1UawIuKz2uTvoJluvrJSf
	tLjRDBwqIg0a9Ns0Y5+oRuvmv2UdXh/620Dk/Wkw=
X-Received: by 2002:ac8:5c83:0:b0:517:63df:91a5 with SMTP id d75a77b69052e-52d2380c1b0mr7887291cf.19.1786126636326;
        Fri, 07 Aug 2026 11:17:16 -0700 (PDT)
X-Received: by 2002:ac8:5c83:0:b0:517:63df:91a5 with SMTP id d75a77b69052e-52d2380c1b0mr7886581cf.19.1786126635760;
        Fri, 07 Aug 2026 11:17:15 -0700 (PDT)
Received: from localhost (ip-86-49-241-13.bb.vodafone.cz. [86.49.241.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a743ffsm82614366b.23.2026.08.07.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:17:14 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v3 00/19] iommu/riscv: Enable MSI remapping, IOMMU_DMA and VFIO
Date: Fri,  7 Aug 2026 20:16:54 +0200
Message-ID: <20260807181713.228535-1-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K4ZBs5iZQI_GFjdnvDw0zw_gB1_gK5FE
X-Authority-Analysis: v=2.4 cv=SYbHsPRu c=1 sm=1 tr=0 ts=6a76212d cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VPysOpcHbS0DNrM1Xqmyow==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c92rfblmAAAA:8 a=uKVmUR9HeUr0h8foQc0A:9
 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX8/4KgHezrR/D
 o84x4E2ofZx7EYvNs51qEuU+IreAEaGqtMaWB/V0776Yuc8KDFdYdSwkOe4g7OUmZnjAZDOWsDk
 eNdZGmCD7noYbhcsgRptByIqAncqPtQ=
X-Proofpoint-GUID: K4ZBs5iZQI_GFjdnvDw0zw_gB1_gK5FE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX4j1goW/M0YgP
 zREghJifOoXSB6EFuALeZC3g98MqjG1ZwBt1EUjznRPNVR0K/RGN+1uCk5txo2z3sylydSCNhuY
 UwCYL2PAk6m7/XCvocbbFUqEGzpgIErfofEOfGsTwdvNhDYpG8gkNREfHBn46U1aqYlbBtNjoaB
 vIocVAlRRsoL8V2/sBkX1NcM0l9onoiRHfB3LQOtd+cD6iQp/PVjfPvW7WpdmPI+aBFvR26ktSr
 SYeo2KR3Tl97By3h4PZgC3nGC/dEn1M3S0TrgFR5vI2gj/aGBQmQ5AEDXhTHipZRRhKJFZmjBln
 EjX4tC9R/URJZD1zqsbjoN0aJ6Yt9Ul+0jPPw8C1I5vzGXpUDx0IMNIu1PxomNEPFrotZfnbgxq
 e9EbKvGXLC489+QdDyvMFwIhB/GcaG2Su2fhvwWvpHg5xjvWyPc8f+RPcRoTcAzHqjE299M2iuN
 Vtl2CiqmRbcPSt44oNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070143

This series adds MSI remapping for IMSIC so a device's MSI target gets
translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
and paging domains by default.

v1[1] used get_resv_regions() with IOMMU_RESV_DIRECT_RELAXABLE to identity
map IMSIC pages, but that was rejected as only a workaround, and the
proposal for v2 was to follow ARM's approach. ARM calls
iommu_dma_prepare_msi() once at IRQ-alloc time, caches the IOVA on the
msi_desc, and lets compose replay it via msi_msg_set_addr(). This series
follows that structure by introducing an IRQ domain and a new
iommu_dma_map_msi(). Like iommu_dma_prepare_msi(), it dispatches on the
same domain cookie types. Unlike iommu_dma_prepare_msi(), it returns the
IOVA to the caller instead of caching it on a descriptor. That allows the
caller to collect all IOVAs needed (since IMSIC needs one IOVA per host
IMSIC page). Like ARM, msi_msg_set_addr() is used at compose time to
direct MSIs to the appropriate IOVAs.

The divergence from ARM is required due to where the target address
actually lives. ARM's doorbell PA is fixed per ITS instance (affinity
changes only retarget hardware routing, never the composed address) so
one IOVA cached at alloc time stays valid for the descriptor's lifetime.
IMSIC doesn't have a fixed target, the MSI address itself changes on
irq_set_affinity(), and that runs in atomic context, so mapping a fresh
IOVA isn't an option. This series pre-maps every IMSIC page into a
domain-wide PA-to-IOVA table at first IRQ-alloc time, and compose does an
O(1) lookup to pick the right one.

With the DMA path in place, v3 also carries the remaining plumbing needed
for RISC-V PCIe device assignment through VFIO/KVM: the RISC-V IOMMU
reports DMA cache-coherency capability, VFIO type1 and KVM_VFIO are
enabled for RISC-V, defconfig enables IOMMUFD/VFIO as modules with cdev
support, and the generic VFIO/iommufd selftests can be built for RISC-V.
The interrupt-remapping domain does not yet validate MSI data, so VFIO
still requires allow_unsafe_interrupts=1. Direct MSI routing to guest
interrupt files (irqbypass) is not yet supported by this series.
irqbypass will be posted separately on top.

LLM-based coding assistants were used during development for code
exploration ("super grep" as one of my colleagues calls it), patch review,
test execution, and commit-message iteration, but all resulting code and
commit messages were selected, reviewed, and finalized by me. Per-patch
Assisted-by tags are omitted in light of the ongoing discussion about
simplifying coding-assistant attribution[2].

Thanks,
drew

[1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org/

v3:
- Addressed Sashiko's v2 comments[3]
- Added RISC-V VFIO/KVM enablement patches and VFIO selftest build support
- Capped SW MSI bitmap growth at 16K entries to simplify the growth arithmetic
- Tracked live MSI allocations so domain replacement can rebuild MSI IOVA
  tables when no iommufd table can be copied
- Add a patch to guard against identity <-> paging domain changes with
  in-flight MSIs

[3] https://sashiko.dev/#/patchset/20260724151218.965929-1-andrew.jones@oss.qualcomm.com


Andrew Jones (15):
  iommufd: Convert struct iommufd_sw_msi_maps to a growable bitmap
  iommufd: Add iommufd_sw_map_msi()
  iommu/dma: Add iommu_dma_sw_map_msi()
  iommu/dma: Add iommu_dma_map_msi()
  genirq/msi: Provide DOMAIN_BUS_MSI_REMAP
  irqchip/riscv-imsic: Compose MSI updates through the hierarchy
  iommu/riscv: Add IRQ domain for interrupt remapping
  iommu/riscv: Prepare info->domain for concurrent RCU read access
  iommu/riscv: Publish IOMMU_RESV_SW_MSI region for iommufd MSI
    remapping
  iommu/riscv: Pre-map IMSIC MSI targets
  iommu/riscv: Copy MSI IOVA table when replacing an iommufd domain
  iommu/riscv: Gate identity boundary switches with live MSIs
  iommu/riscv: Implement irq_compose_msi_msg for IMSIC remapping
  riscv: defconfig: Enable IOMMUFD and VFIO
  selftests/vfio: Allow building on RISC-V

Tomasz Jeznach (4):
  iommu/dma: Enable IOMMU_DMA for 64-bit RISC-V
  iommu/riscv: report iommu capabilities
  vfio: enable IOMMU_TYPE1 for RISC-V
  RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch

 arch/riscv/configs/defconfig               |   4 +
 arch/riscv/kvm/Kconfig                     |   1 +
 drivers/iommu/Kconfig                      |   2 +-
 drivers/iommu/dma-iommu.c                  |  32 +-
 drivers/iommu/dma-iommu.h                  |  12 +-
 drivers/iommu/iommu-priv.h                 |  11 +-
 drivers/iommu/iommu.c                      | 104 +++++-
 drivers/iommu/iommufd/device.c             |   3 +-
 drivers/iommu/iommufd/driver.c             |  79 +++--
 drivers/iommu/iommufd/hw_pagetable.c       |   1 +
 drivers/iommu/iommufd/iommufd_private.h    |  41 ++-
 drivers/iommu/riscv/Kconfig                |   1 +
 drivers/iommu/riscv/Makefile               |   2 +-
 drivers/iommu/riscv/iommu-ir.c             | 353 +++++++++++++++++++++
 drivers/iommu/riscv/iommu.c                | 100 ++++--
 drivers/iommu/riscv/iommu.h                |  41 +++
 drivers/irqchip/irq-msi-lib.c              |   8 +-
 drivers/irqchip/irq-riscv-imsic-platform.c |  27 +-
 drivers/vfio/Kconfig                       |   2 +-
 include/linux/iommu.h                      |  31 ++
 include/linux/irqchip/riscv-imsic.h        |   7 +
 include/linux/irqdomain_defs.h             |   1 +
 tools/testing/selftests/vfio/Makefile      |   2 +-
 23 files changed, 749 insertions(+), 116 deletions(-)
 create mode 100644 drivers/iommu/riscv/iommu-ir.c

-- 
2.43.0

