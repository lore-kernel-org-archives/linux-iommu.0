Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DD6346E47
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047169; cv=none; b=WF3e+tb8Wwb+XA+I/jZXhIgN13q4LnvG7qE/jSpyhSYlVNE6+Ox7nKLkREd1/rFsJqLl4IJEygsf6EmU9tcJntQ8Vg3WR33kDtVVQyEwQLtqtVV7Tk1kJSCzBh6OXjvsQI7HncjqmySaFFe3tpvJOjRz/TF/dX8iAC11rl16yVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047169; c=relaxed/simple;
	bh=36YsqbbtlmsgKMbq65+9cN1z51B5RiuBUwgiUn1Xsuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uRgY2FhFVdQzuKXs6lVuNyLDsKn2eotL6Nu9dgm2S56CW4d2O86W+lTf9sijo/IEhBv54VD/a2Ie7ykfSrJpywVUvqmwlL0/6UfbR9sLkJLile+ddD/CeR8HfQPQ5sQQXWcuSnbGn7DinsB8QismxHFQ/SScrkEOY3eHdnrTtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4j4zKP1m8Tz5B14n;
	Thu, 15 Oct 2026 14:52:41 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 69F6qa31013812;
	Thu, 15 Oct 2026 14:52:36 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 15 Oct 2026 14:52:38 +0800
X-Zmail-TransId: 3e816ad0782e024-55471
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH 0/12] iommu/riscv: Add nested translation (vIOMMU) support
Date: Thu, 15 Oct 2026 14:52:20 +0800
Message-ID: <20261015065232.604503-1-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 69F6qa31013812
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 15 Oct 2026 14:52:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AD07839.000/4j4zKP1m8Tz5B14n

Add nested translation support to the RISC-V IOMMU driver, so a KVM guest
with its own vIOMMU can own the first stage of a device context while the
host keeps the second stage, and add the interrupt support. This is an RFC
and comments on the design are welcome.

Background

A RISC-V IOMMU device context carries a first stage in DC.fsc and
DC.iosatp and a second stage in DC.iohgatp. A guest with its own vIOMMU
owns the first stage, because the second stage is what isolates the guest
from the host, and the host cannot provide first stage semantics for the
guest address space.

iommufd already has the framework for this split. User space allocates a
second stage hwpt with IOMMU_HWPT_ALLOC_NEST_PARENT, allocates a vIOMMU
on it with IOMMU_VIOMMU_ALLOC, allocates nested page tables from that
vIOMMU with driver specific data, attaches devices to the nested hwpt and
forwards guest invalidations with IOMMU_HWPT_INVALIDATE against the
vIOMMU. Add the missing RISC-V uAPI definitions and the driver
implementation of those ops.

uAPI

Add IOMMU_HWPT_DATA_RISCV_S1 with struct iommu_hwpt_riscv, which carries
the guest first stage fields tc and iosatp for allocating a nested hwpt,
and add IOMMU_VIOMMU_TYPE_RISCV, which allocates a RISC-V vIOMMU on a
nesting parent hwpt. Add IOMMU_VIOMMU_INVALIDATE_DATA_RISCV with struct
iommu_viommu_riscv_invalidate, which carries one IOTINVAL command in the
encoding of the IOMMU command queue, and add IOMMU_HW_INFO_TYPE_RISCV
with struct iommu_hw_info_riscv, which reports the IOMMU Capabilities
register so a VMM can discover what the physical IOMMU implements.

Driver

Keep the nesting parent domain, which is the second stage domain, and the
GSCID it was allocated in the vIOMMU object, and advertise the vIOMMU type
only on hardware which implements both stages.

A nested domain keeps only the guest device context, sanitized when it is
allocated, because user space controls it entirely. Everything user space
provides is checked against the fields this IOMMU and this host support
before it can reach the hardware.

riscv_iommu_attach_dev_nested() composes the device context the hardware
is programmed with from the guest first stage and the host second stage,
and bonds the device to the second stage parent instead of the nested
domain, so a device using nested translation shares the bond list, the
MSI table and the invalidation state with the devices attached to the
parent directly. The update keeps an active guest MSI table in place, so
no MSI is lost across the switch.

Accept IOTINVAL.VMA only and reject reserved bits in cache invalidation.
The isolation operands belong to the host, so they are replaced with the
GSCID assigned to the vIOMMU and a PSCID of 0, and a guest cannot
invalidate the caches of another VM. PASID and the process directory
table, ATS and PRI, and T2GPA install and invalidation are not
implemented.

Interrupts

The prerequisite IRQ bypass requires HWACCEL mode and every interrupt file
to be published, and it forwards an MSI only when it can name the target
vCPU by matching the device MSI address against the guest IMSIC addresses
of the vCPUs. A guest with a vIOMMU programs its device with an address
from its own IOVA space, which the IOMMU resolves through the guest first
stage page tables before it looks the translated address up in the MSI
table, so no vCPU can be named at that point. Host delivery is not an
option either. The device would keep the MSI address the host composed for
it, and since every access from a device in a nested domain is translated
by the guest first stage page tables, that address cannot be resolved to
the intended interrupt file.

Forward MSIs for the whole VM when the address names no vIMSIC, and let
the MSI table decide, since it holds the IMSIC topology of the whole VM
and the hardware then finds the target vCPU itself once the address is
translated. Program such a producer with the MSI message composed by the
guest. Install the table with the interrupt files the host has published
at that time and skip the others, since rejecting the request would leave
the VM without forwarding, and a vIOMMU guest cannot fall back to host
delivery. An MSI that resolves to an unpublished file faults only that
MSI and is reported in the fault queue. Replace the AIA mode check with
the per address hardware backing checks, so the default AUTO mode works,
which publishes an IMSIC VS-file whenever one is available and falls back
to the SW-file only when the host has none left. Such a producer can reach
any published vCPU of the VM, so unforward it whenever a VS-file is
released and retarget it whenever a vCPU migrates.

Patch organization

Patch 1 takes the device context valid bit from DC.tc.V instead of
overloading a translation attribute bit, so a full device context can be
programmed, with no functional change for the existing domains.
Patches 2 and 3 add the uAPI types.
Patches 4 to 9 add the vIOMMU object, the nested domain, cache
invalidation, hw_info and nested device attachment.
Patches 10 to 12 make IRQ bypass usable for a guest with a vIOMMU.

Dependencies

The series applies on top of linux-iommu/next at 634706fe6e36, with the
MSI remapping, IOMMU_DMA and VFIO series v6 [1], the hardware dirty
tracking for second stage domains RFC v4 [2], which also supplies the
second stage domain allocation and the RISC-V iohgatp page table, the IRQ
bypass support RFC v3 [3] and the KVM IRQ bypass client on the branch that
posting refers to [4], the generic iommu page table for SMMUv3 v2 [5], on
which the second stage page table is built, and the generic_pt fix from
Andrew Jones which adds Svpbmt to the RISC-V supported feature mask.

A branch with the whole dependency stack and this series is available from
[6].

Testing

The host is a RISC-V machine whose physical IOMMU is provided by an outer
QEMU riscv-iommu model, which implements both translation stages. An NVMe
controller under it is bound to vfio-pci and passed through to the guest.
The guest is started by a QEMU built with the accel series [7][8], which
exposes a first stage IOMMU to the guest and leaves the second stage to
the host IOMMU. For simplicity the guest runs the same kernel as the host,
and inside the guest it mainly uses the normal IOMMU driver and the NVMe
driver.

The layering of the setup is

Host HW, a RISC-V virt machine from latest QEMU(v11.1.2), with a
riscv-iommu model that implements two stage translation and with the NVMe
controller

    Host OS, the kernel with this series
      riscv-iommu driver, second stage and MSI table vfio-pci and KVM

        Guest HW, QEMU with the accel series [7][8]
          riscv-iommu accel, first stage only

            Guest OS, the same kernel as the host
              riscv-iommu driver, NVMe driver

A DMA address from the NVMe controller is translated by the guest first
stage and then by the host second stage on the physical IOMMU. An MSI
address is translated by the guest first stage into a guest IMSIC address,
which the flat MSI table then resolves straight to the interrupt file of
the target vCPU, instead of walking the second stage.

    DMA    device --> guest first stage --> host second stage --> RAM
    MSI    device --> guest first stage --> MSI table --> VS-file

The host was started with

$HOST_QEMU \
  -M virt,aia=aplic-imsic,aia-guests=7,iommu-sys=on \
  -cpu rva23s64,sv48=on -nographic \
  -smp 16 -m 16G \
  -kernel $HOST_KERNEL \
  -append "root=/dev/vda rw earlycon=sbi console=ttyS0 iommufd.allow_unsafe_interrupts=1" \
  -drive file=$HOST_ROOTFS,if=none,id=d0,format=qcow2 -device virtio-blk-device,drive=d0 \
  -device pcie-root-port,id=port0,chassis=0,slot=0,addr=3.0 \
  -drive file=fake-nvme-disk.img,if=none,id=nvme0,format=qcow2 \
  -device nvme,drive=nvme0,serial=deadbeef,bus=port0,addr=0.0

and the guest with

$GUEST_QEMU \
  -machine virt,accel=kvm,aia=aplic-imsic,aia-guests=5 \
  -cpu host -nographic \
  -smp 4 -m 4G \
  -object iommufd,id=iommufd0 \
  -device riscv-iommu-pci,addr=1.0,s-stage=on,g-stage=off,accel=on \
  -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0 \
  -kernel $GUEST_KERNEL \
  -append "root=/dev/vda rw earlycon=sbi console=ttyS0 iommu.passthrough=0 iommu.strict=1" \
  -drive file=$GUEST_ROOTFS,if=none,id=d0,format=qcow2 -device virtio-blk-device,drive=d0

Correctness was checked by running fio with verification enabled against
the passed through disk.

Known limitations and future work

PASID and the process directory table are not supported, PDTV is rejected
and PSCID is fixed at 0. The ATS, PRI and T2GPA fields are validated on
the nested domain, but ATS.INVAL and the PRI queue are not forwarded. A
vIOMMU is bound to a single physical IOMMU instance. The new uAPI types
have no selftest coverage yet.

Coding assistants based on LLMs were used during development for code
exploration, patch review, test execution and for drafting and editing
commit messages. We have reviewed and finalized all resulting code and
text.

[1] https://lore.kernel.org/all/20260925151659.419512-1-andrew.jones@oss.qualcomm.com/
[2] https://lore.kernel.org/all/20260915032828.11250-1-fangyu.yu@linux.alibaba.com/
[3] https://lore.kernel.org/linux-riscv/20260928143113.49838-1-andrew.jones@oss.qualcomm.com/
[4] https://github.com/jones-drew/linux/commits/riscv/iommu-irqbypass-rfc-v3-kvm/
[5] https://lore.kernel.org/linux-iommu/0-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
[6] https://github.com/leaprise/linux/tree/riscv/iommu-nested-rfc1
[7] https://lore.kernel.org/qemu-devel/202610140811.69E8BqaU098670@mse-fl2.zte.com.cn/
[8] https://github.com/leaprise/qemu/tree/riscv/iommu-nested-rfc1


Gong Shuai (5):
  iommu/riscv: Use DC.tc.V as the device context valid bit
  iommu/riscv: Add vIOMMU cache invalidation
  RISC-V: KVM: Accept auto-mode interrupt files for IMSIC IRQ bypass
  iommu/riscv: Accept unpublished interrupt files in IRQ forwarding
  RISC-V: KVM: Forward MSIs for guests with a vIOMMU

Wu Fei (7):
  iommufd: Add RISC-V IOMMU hwpt and vIOMMU types
  iommufd: Add RISC-V IOMMU cache invalidation data type
  iommu/riscv: Add vIOMMU object support
  iommu/riscv: Add nested domain allocation
  iommufd: Add RISC-V IOMMU hardware info type
  iommu/riscv: Add riscv_iommu_hw_info
  iommu/riscv: Add riscv_iommu_attach_dev_nested

 arch/riscv/kvm/aia_imsic.c          |  74 +++--
 drivers/iommu/riscv/iommu-bits.h    |  19 ++
 drivers/iommu/riscv/iommu-ir.c      |  25 +-
 drivers/iommu/riscv/iommu.c         | 428 +++++++++++++++++++++++++++-
 include/linux/irqchip/riscv-imsic.h |  14 +-
 include/linux/kvm_irqfd.h           |   2 +
 include/uapi/linux/iommufd.h        |  52 ++++
 7 files changed, 569 insertions(+), 45 deletions(-)

-- 
2.53.0

