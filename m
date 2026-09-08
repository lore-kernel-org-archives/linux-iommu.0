Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B05455293F
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872925; cv=none; b=cNmoru54Mx62sQbzKTHng9cV1ZaoqQYGKY1U8J/enTkOQ+RaRPPk6WvLAMz208ZhPfPv5iRHDYrEHTU/HIcRS1aoGFr9qFiSZo1nh7kxaB+CZkYqf5J1C6tzQYNWN8iNtRySXyTdv3HO+1BefuQ5NTIS6NkuS1ffeP6Q7Tass34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872925; c=relaxed/simple;
	bh=lZOJZ1eXA52ShReNf9dL+c4a3gllm4PudhUTHQNpfUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XvYjFIdbPC/Khah2BqWx+LC1RGJmFSdlSM8hHNzr6pVwsqgy8BJtV9NLo1urzW6GLDCerlYKztC/WAMIrZaerfVtJS1mhJFulh6vxMQAKyZm7ed7EAgg6yvxR23pgv+84rmp0S725pzAznsjxW6DxpYwNIV6ukw4Ze5YtGzL4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r9ZOx5PG; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r9ZOx5PG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788872913; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lZOJZ1eXA52ShReNf9dL+c4a3gllm4PudhUTHQNpfUI=;
	b=r9ZOx5PGf0NRmLJOUPdvc7WFOcP18Qr8g4ttnw0niASlGqGtRI63Jfhkm1iJfukT3mEOCGkwH2ak6dzhMenPJ5iYdLGkBRvKaliuSWGsSzR+vl6eYZB6ULIb20kTOtfyXgfEP7hq+b+k7sGFryFbjJgwUDszvNKWYygvqZZFa5U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XAbablx_1788872910;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XAbablx_1788872910 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 21:08:32 +0800
From: fangyu.yu@linux.alibaba.com
To: andrew.jones@oss.qualcomm.com
Cc: anup@brainfault.org,
	fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tglx@kernel.org,
	tjeznach@rivosinc.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org
Subject: Re: [PATCH v5 00/17] iommu/riscv: Enable MSI remapping, IOMMU_DMA and VFIO
Date: Tue,  8 Sep 2026 21:08:28 +0800
Message-Id: <20260908130828.14195-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>This series adds MSI remapping for IMSIC so a device's MSI target gets
>translated the same way its DMA does, allowing RISC-V to enable IOMMU_DMA
>and paging domains by default.
>
>v1[1] used get_resv_regions() with IOMMU_RESV_DIRECT_RELAXABLE to identity
>map IMSIC pages, but that was rejected as only a workaround. v2 through
>v4[2] instead introduced a RISC-V IOMMU IRQ domain which pre-mapped every
>possible IMSIC target and maintained a domain-local PA-to-IOVA table. The
>v4 discussion with Jason identified a simpler way to handle the RISC-V
>requirement that the MSI target address changes with interrupt affinity:
>extend the existing iommu_dma_prepare_msi() model to prepare an ordered
>list of MSI targets as one contiguous IOVA range. v5 is a complete redesign
>around that approach.
>
>The IMSIC driver now builds an array containing the supervisor IMSIC page
>for every possible CPU, indexed by logical CPU number. When allocating an
>IRQ, it passes the complete array to iommu_dma_prepare_msi_list(). The new
>API maps the ordered physical address list into one contiguous IOVA range
>through either DMA-IOMMU or iommufd, then caches the base IOVA and mapping
>granule in the MSI descriptor. MSI composition can therefore select the
>target for the current CPU with simple arithmetic, including during an
>affinity change, without allocating memory or consulting IOMMU-owned state
>in atomic context.
>
>DMA-IOMMU extends its existing per-page MSI cache to recognize and reuse
>complete ranges. iommufd grows its software-MSI bitmap on demand, bounds
>allocations to the reserved MSI window, and prepares, installs, rolls back,
>and replays a range as one unit. This keeps the descriptor's contiguous
>IOVA valid across iommufd paging-domain replacement without exposing a
>partially installed range.
>
>Unlike v4, v5 has no RISC-V IOMMU IRQ domain, no domain-local IMSIC mapping
>table, and no IOMMU lookup during MSI composition. The IMSIC IRQ domain
>owns the target list and message composition, while the IOMMU layers only
>provide the mappings. Devices which do not need IOMMU MSI translation keep
>using physical MSI addresses through the same IMSIC path.
>
>The series also carries the remaining plumbing needed for RISC-V PCIe
>device assignment through VFIO/KVM: the RISC-V IOMMU reports DMA
>cache-coherency capability for coherent devices, VFIO type1 and KVM_VFIO
>are enabled for RISC-V, defconfig enables IOMMUFD/VFIO as modules with cdev
>support, and the generic VFIO/iommufd selftests can be built for RISC-V.
>The RISC-V IOMMU specification does not provide MSI data validation, so
>VFIO device assignment requires the applicable allow_unsafe_interrupts=1
>module parameter. Direct MSI routing to guest interrupt files (irqbypass)
>is not yet supported by this series and will be posted separately on top.
>

Hi Andrew:

I tested this on riscv64 QEMU with an emulated NVMe device and e1000e
network adapter. The fio and iperf3 tests both completed successfully,
and the interrupt status was as expected.

For this series
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>

>LLM-based coding assistants were used during development for code
>exploration, patch review, test execution, and drafting and editing
>commit messages and this cover letter. I reviewed and finalized all
>resulting code and text. Per-patch Assisted-by tags are omitted in
>light of ongoing discussions about simplifying coding-assistant
>attribution.
>
>Thanks,
>drew
>
>[1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/
>[2] https://lore.kernel.org/all/20260820214150.545737-1-andrew.jones@oss.qualcomm.com/
>
