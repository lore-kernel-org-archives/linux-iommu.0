Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436953;
	b=yiVJdIM5EkS2JtO7IgLamLMK+vh3lYdkJvS/H/jxZTiAJj4FMbTUnnMrYN6XUCBRDYd0
	 nNVElgDfzoD6y5Egs7Iwsg6oFTbz29fRbeD/3LofzdfU6QNaQwEaVtLec9YB80WN28mCL
	 Dk75LdMkA9vp+3/J9rbn5B4mASGwu4ri2FI6FyTFkFIp6ztQA3AV1uFS7fFkCCRpxQFaW
	 I4h4QcXKnI3Mkl6JOQ4tNbjX8KGTUV++hVedwnGBPUF921A38AXVGBsrfPe85tm5ev+fU
	 kbSxGyjcouFI8p6bjtbYaM6hRNHFkVoyOKxhJKvmNeEhDd086bvBhlBrb7mxk77TmFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436953;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=Nf/e7h6zi5zw9Vu4WfB0GEyN8EmLcf8HjHUMJ9G9oow=;
	b=XoTu32J7Vi/UDmqPtpxI1lOPIbgNJZZjKxPuavYUla4KW1r/RiwFNvnh1H2w+06wv9WZ
	 QAdKA+eXju3uzQV4bSAE5r91Mgn0T1vQq5bwi4Ot76IJoOhxHJTBfd42lKck/F2xflAO9
	 7MCSZkRk/qzNRwtXfwmrkQO1TtcjEL6fYBAT8VDHf1YVKB7aEVVJzCWZZLEAQCei0LaG2
	 X4x2t6g/eLRL7xgmoSj/to7AUI+pM/m/1/6zU3bMQhe9q5tm4UVVBBCdoc5L48iKAvavC
	 u8VXWYGJ0U9ICG6wAyDk6Bc6qdd+k4UalqSvWdDwl9NIi8pDrBRUaZsQ4AQ1/m/T0dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b="REWBOM2/";
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECD606A326
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AECD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=REWBOM2/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794436953; x=1825972953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nf/e7h6zi5zw9Vu4WfB0GEyN8EmLcf8HjHUMJ9G9oow=;
  b=REWBOM2/S7wRYVmCVCWDrMVbS0ZXNm1hzfNkRG3O0IUy76btBalKfOZd
   H3tVWfp51d7m/okS0aLhlH+gRK+KRLplsqqvAaSoFcon2qoyPif5cVfBR
   OcZpxbGeFhAUSvigkuwMyw14iqwpql0Q6L05XodjdZAr8Zj3i5uLYV7xX
   fSgj1nUHiQ0XFNpROJCVvI1bZ3YakSiLhPoAERRju6uThfqxGMeboDdK1
   JCZ9LbPUxVh0QNlQpimP20E57WLLc++1lcc8kEwfM3DOaBfYHdZQLqttX
   R4gMfx87Rnqg0IGKcHKCENfXvMp9imfXcaF+rcmQ2kPVjWW8jurulrkMf
   w==;
X-CSE-ConnectionGUID: G7TPEGiWQRSBLwmwzCQc/A==
X-CSE-MsgGUID: DDSJSqkBS+O+gJ5y7ySdsA==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33756163"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:42:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:31849]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 152a9830-b7c4-42e9-a68c-30a0443400c8; Wed, 11 Nov 2026 22:42:30 +0000 (UTC)
X-Farcaster-Flow-ID: 152a9830-b7c4-42e9-a68c-30a0443400c8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:29 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:42:27 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 00/40] nitro_enclaves: Add support for Nitro Sandboxes
Date: Wed, 11 Nov 2026 22:41:45 +0000
Message-ID: <cover.1794300002.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Nitro Sandboxes [1] are a new EC2 feature that build on top of the
technical foundations of Nitro Enclaves - an EC2 feature that allows
you to spawn a virtio-vsock-only VM sibling constructed out of resources
donated by the VM you execute in.

Nitro Sandboxes build on that concept and the same hypervisor interface,
but add the ability to implement virtio devices in the parent, run vCPUs
oversubscribed, add device hotplug support and allow to spawn a sandbox
without attestation, but shared memory. They also boot a full EC2-like VM
that runs with a UEFI stack and executes the EIF-wrapped kernel as UEFI
executable.

In combination, Nitro Sandboxes provide a way to create a confidential
compute VM for almost all workloads, but without the biggest gaps that
other confidential compute offerings have: The parent has no timing
control and the parent also has no control over the base device model,
such as timers, PCIe, UART, etc. All base devices are implemented in
Nitro.

This series adds parent-side support for Nitro Sandboxes to the
nitro_enclaves driver.

This supports adds a few non-obvious technical foundations:

guest_memfd like CMA allocator - With Nitro Enclaves, memory came from
hugetlbfs and user space maintained visibility into it. That led to a
few problems. With this new enablement, we add a guest_memfd like
allocator that seeds from CMA, allows the parent to seed the EIF before
hand-over and then loses any mechanism to access donated memory. Thanks
to CMA, it also provides much larger contiguous chunks than 2M huge pages.

Virtio notifications - To implement virtio in the parent, we need to
handle notifications in both directions. Parent to sandbox goes through
a BAR write; sandbox to parent through multiplexed IRQs. We provide
eventfd support in both directions, which also enables vhost support.

NUMA - With Nitro Sandboxes, NUMA became a first class citizen and all
APIs now support NUMA targeting.

Memory Donations - Every sandbox requires hypervisor memory. To allow
for a larger scale of sandboxes you can run, we add a way to donate
memory from the parent to the hypervisor. The user visible effect of
that is that there is a slot limit sysfs file which you can increase.
On write, we allocate physically contiguous CMA memory and donate it.

This series depends on "nitro_enclaves: Fix enclave release, command
retries and the CPU pool", which I posted earlier today.

I used Kiro, an AI coding assistant running Claude Opus and GPT models,
to draft the initial code and patch descritptions.

I validated all new functionality on x86_64 and arm64 as well as ensured
that Nitro Enclaves are still fully functional after this patch series.

[1] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/amazon-ec2-nitro-sandboxes.html

Alex

Alexander Graf (40):
  nitro_enclaves: Allow the CPU pool to span NUMA nodes
  nitro_enclaves: Add NE_ADD_ANY_VCPU
  nitro_enclaves: Expose CPU pool state under sysfs
  nitro_enclaves: Document multi-NUMA CPU pools
  dma-contiguous: add dma_get_numa_cma_area() accessor
  nitro_enclaves: Allocate physically contiguous enclave memory
  nitro_enclaves: Add NE_MEMORY_SHARED
  nitro_enclaves: Add NE_ADD_MEMORY_REGION
  nitro_enclaves: Document the memory pool
  nitro_enclaves: Add NE_CREATE_VM2 with a launch flag word
  nitro_enclaves: Add NE_ENCLAVE_PCIE_MODE launch flag
  nitro_enclaves: Name the device's error codes in the UAPI header
  nitro_enclaves: Log a reached device limit at info level
  nitro_enclaves: Add NE_SET_INFO_PAGE
  nitro_enclaves: Document the info page in the memory pool
  nitro_enclaves: Turn the command reply into a per-command union
  nitro_enclaves: Add the slot pool donation commands
  nitro_enclaves: Donate memory for the slot pool
  nitro_enclaves: Add the slot pool growth commands
  nitro_enclaves: Add a helper to grow the slot pool
  nitro_enclaves: Document the slot pool
  nitro_enclaves: Expose slot pool state under sysfs
  nitro_enclaves: Add the device add command
  nitro_enclaves: Add NE_ADD_DEVICE
  nitro_enclaves: Read the interrupt multiplexer geometry at probe
  nitro_enclaves: Donate a bitmap page per multiplexed vector
  nitro_enclaves: Dispatch multiplexed interrupts to per-queue bindings
  nitro_enclaves: Add NE_SET_NOTIFY_EVENTFD
  nitro_enclaves: Report the device's info notification
  nitro_enclaves: Count multiplexed interrupts under debugfs
  nitro_enclaves: Map the doorbell window at probe
  nitro_enclaves: Add NE_SET_VRING_CALL
  nitro_enclaves: Assert the layout of the ioctl argument structs
  nitro_enclaves: Pass on the Nitro Sandbox launch flags
  nitro_enclaves: Add NE_ENCLAVE_DIRECT_MODE
  nitro_enclaves: Add NE_ENCLAVE_PCIE_HOTPLUG_MODE
  nitro_enclaves: Add NE_ENCLAVE_CPU_OVERCOMMIT_MODE
  nitro_enclaves: Add NE_GET_CAPS
  nitro_enclaves: Add NE_UPDATE_DEVICE_CONFIG
  nitro_enclaves: Document the driver side of Nitro Sandboxes

 .../sysfs-devices-virtual-misc-nitro_enclaves |  232 +
 Documentation/virt/ne_overview.rst            |  256 +-
 MAINTAINERS                                   |    1 +
 drivers/virt/nitro_enclaves/Kconfig           |   19 +
 drivers/virt/nitro_enclaves/ne_misc_dev.c     | 4832 +++++++++++++++--
 drivers/virt/nitro_enclaves/ne_misc_dev.h     |  206 +-
 drivers/virt/nitro_enclaves/ne_pci_dev.c      | 1568 +++++-
 drivers/virt/nitro_enclaves/ne_pci_dev.h      |  599 +-
 include/linux/dma-map-ops.h                   |    7 +
 include/uapi/linux/nitro_enclaves.h           | 1182 +++-
 kernel/dma/contiguous.c                       |   36 +
 samples/nitro_enclaves/ne_ioctl_sample.c      |   10 +-
 12 files changed, 8282 insertions(+), 666 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-misc-nitro_enclaves


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: 542b3d78fda912095b75a49becd1b93109befdbc
prerequisite-patch-id: 318368e966c1925652b7976948f435d42b87c72f
prerequisite-patch-id: eb35b5d713e7f50f6d1d02310c9afe10b1628fc6
prerequisite-patch-id: 223bf6e60620ca8fe72f3ff6f3bd3f5839cdd6d5
prerequisite-patch-id: e5305ce0515a02f7f88e72adf02c6a2bee2fd2e0
prerequisite-patch-id: 759b5920f842d70e675770608d9088639c10559e
prerequisite-patch-id: e1837df37663da3d3ce53afa4594828b2d602152
prerequisite-patch-id: f0d4302bd36f94de95951a0db1ae9eb9747076aa
prerequisite-patch-id: 41159b92e250fef705be52f714b6e2761a2cd1f7
prerequisite-patch-id: a0c3a56907acac2297c800209faa2849a8df0e48
prerequisite-patch-id: a80a95bd682b540be5760e8fdf7044379fe32d61
prerequisite-patch-id: 9c01e0fecd6810f3448582715c87cd3dd7a6cdf1
prerequisite-patch-id: b94dfc8bb1039740d88a30535445bb7b3dd1fe74
prerequisite-patch-id: bd76f15728dc0ee2ca3417cd95a6b23a7d63e91f
prerequisite-patch-id: 0c60f1574b590f68885a25760017e9ff87752f66
prerequisite-patch-id: 63dff43da52934a6e6f5e65c3e235a7114b6b4dc
prerequisite-patch-id: af52cf938525874cadd6d879aa76495e563876d2
prerequisite-patch-id: f53ee22764b5f13708cacd3e48a59a82d71a270c
prerequisite-patch-id: 258b8c18168db49aacbda5156e33978b539666ab
-- 
2.47.1

