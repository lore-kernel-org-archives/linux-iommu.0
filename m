Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A92F3C3D
	for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792225172; cv=none; b=oj97aiYzLUdmcrNRvd8ZztX3IMkvI73wcFnxGtxGIMup07XmVQ4CDk+rHiRxWhiWVCqRXl2Tu6uoSIWFj50DjIfVwh/NgwhgQ/NbxnT8ZM+abpM0et9bF+YnnCtVBnhnVrtIy+YKeU/M8UqykHClmHrPeWiv0KG0oJjPMdgWHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792225172; c=relaxed/simple;
	bh=nB1z2FAlgkv6hwNiZtfd9WPOohxtypbsqIfn2C57yTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5DqcD9UkGmycuGBb7I+cH5pX2oI9B/5IRYI+FlC1eKZgEpEA+kYWqJTKQcbLzsOA/8e0W3YK1rn8n5gvxFHx4GDYh+9+B+K6keVJ1+yr5kp1wJeDbT9Ae1M+ihmTI8JdNJrwbjCqov6hbiIQIXr9s8gfAct2ki7fFbhbQlutGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ljXevt2J; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ljXevt2J"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792225163; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hm49MjoKdmBJeY4b0QFV0UuGDTjMKJ5IHpViY1jODFQ=;
	b=ljXevt2JpsS6LzdN5elwHNcFrNJoHc8Ow7A7KkgnmGrkvcKPARHaqK3LUlshZqu63ZPrDHeGTgvWCIFGGu3e3Fxp4fdvNaGnxuBWFn8H8hkFtY7MfbBQafvYQb7E92Pbq1mwytI2nKvM433RdjFtmF149kW7TEocC+vQTOzJj08=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0XCwojoQ_1792225161;
Received: from 30.28.50.44(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XCwojoQ_1792225161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Oct 2026 16:19:22 +0800
Message-ID: <27f2e050-10c0-4a77-8d59-00a95a162912@linux.alibaba.com>
Date: Sat, 17 Oct 2026 16:19:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/11] iommu/arm-smmu-v3: Adopt the crashed kernel's
 stream table for kdump
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
References: <cover.1791226953.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/6/26 3:30 AM, Nicolin Chen wrote:
> When transitioning to a kdump kernel, the primary kernel might have crashed
> while endpoint devices were actively bus-mastering DMA. Currently, the SMMU
> driver aggressively resets the hardware during probe by clearing CR0_SMMUEN
> and setting the Global Bypass Attribute (GBPA) to ABORT.
> 
> In a kdump scenario, this aggressive reset is highly destructive:
> a) If GBPA is set to ABORT, in-flight DMA will be aborted, generating fatal
>     PCIe AER or SErrors that may panic the kdump kernel
> b) If GBPA is set to BYPASS, in-flight DMA targeting some IOVAs will bypass
>     the SMMU and corrupt the physical memory at those 1:1 mapped IOVAs.
> 
> To safely absorb in-flight DMA, the kdump kernel must leave SMMUEN=1 intact
> and avoid modifying STRTAB_BASE. This allows HW to continue translating in-
> flight DMA using the crashed kernel's page tables until the endpoint device
> drivers probe and quiesce their respective hardware.
> 
> However, the ARM SMMUv3 architecture specification states that updating the
> SMMU_STRTAB_BASE register while SMMUEN == 1 is UNPREDICTABLE or ignored.
> 
> This leaves a kdump kernel no choice but to adopt the stream table from the
> crashed kernel.
> 
> In this series:
>   - Introduce an ARM_SMMU_OPT_KDUMP_ADOPT
>   - Skip SMMUEN and STRTAB_BASE resets in arm_smmu_device_reset()
>   - Skip EVENTQ/PRIQ setup including interrupts and their handlers
>   - Memremap the crashed kernel's stream tables into the kdump kernel [*]
>   - Reserve the crashed kernel's in-use ASIDs and VMIDs, preventing any TLB
>     aliasing with the kdump kernel's own domains
>   - Defer any default domain attachment to retain STEs until device drivers
>     explicitly request it.
> Most of the new code is in arm-smmu-v3-kexec.c. A hidden ARM_SMMU_V3_KEXEC
> config symbol (def_bool CRASH_DUMP) controls its build.
> 
> The common helpers parse and walk the crashed kernel's stream/CD tables and
> reserve its in-use IDs. The kdump code is guarded by CONFIG_CRASH_DUMP. The
> helpers can also support the proposed SMMUv3 Live Update work:
> https://lore.kernel.org/all/20260929071950.2710070-1-praan@google.com/
> 
> [*] For verification reasons, this series only fixes coherent SMMUs.
> 
> For non-ARM_SMMU_OPT_KDUMP_ADOPT cases, keep a status quo since the commit
> 3f54c447df34f ("iommu/arm-smmu-v3: Don't disable SMMU in kdump kernel"):
> full reset followed by driver-initiated reattach, potentially rejecting any
> in-flight DMA.
> 
> Note that this series is no longer treated as a bug fix, since it has grown
> fairly big and most of the kdump code now resides in a separate C file. For
> folks interested in back-porting the change: a v6.12+ kernel (since commit
> 85196f54743d ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_strtab_cfg"))
> would be still compatible with this series.
> 
> This is on Github:
> https://github.com/nicolinc/iommufd/commits/smmuv3_kdump-v11
> 
> Changelog
> v11
>   * Rebase on arm/smmu/updates branch
>   * Add Tested-by from Breno and Cristian
>   * Add Reviewed/Acked-by from Jason and Kiryl
>   * Update commit messages and Assisted-by tags
>   * New prep patch: swap EVTQ/GERROR MSI indexes
>   * Skip EVTQ's CFG0 write and vector allocation
>   * Merge arm-smmu-v3-kdump code into arm-smmu-v3-kexec
>   * Fold patches accordingly as static functions require callers
Hi Nicolin,

We tested this series (v11, backported onto our 6.6-based kernel) on two
arm64 server platforms that differ in how PCIe errors are reported: one
with firmware-first reporting (GHES/CPER), the other with OS-first AER
plus DPC. The test triggers a kdump crash (echo c > /proc/sysrq-trigger)
on an otherwise idle machine and compares the capture kernel's dmesg
between the unpatched baseline and the kernel carrying this series.

On the firmware-first platform (10 SMMUv3 instances):

   Unpatched, every SMMU logs:

     arm-smmu-v3.0.auto: SMMU currently enabled! Resetting...

   and the destructive reset immediately aborts in-flight DMA. The capture
   kernel then drowns in a storm of GHES/CPER records together with PCIe
   AER "Poisoned TLP" (Data Link Layer) errors from the devices that were
   bus-mastering at crash time. Devices behind the reset SMMUs fail to
   recover in the capture kernel, and in some runs the capture kernel
   hangs in the error storm instead of saving the vmcore.

   With the series applied, all 10 SMMUs log:

     arm-smmu-v3.0.auto: kdump: retaining SMMUEN for in-flight DMA

   and the capture kernel boots with zero AER/GHES error records. A
   complete vmcore is saved and the machine reboots normally.

On the OS-first AER/DPC platform (8 SMMUv3 instances):

   Unpatched: 8x "SMMU currently enabled! Resetting..." followed within
   seconds by PCIe AER Completion Abort errors reported by the root
   complex, along with DPC containment events and EDR notifications. The
   NICs behind the contained link never recover in the capture kernel.

   With the series applied: 8x "kdump: retaining SMMUEN for in-flight DMA",
   no PCIe error events at all, a complete vmcore and a clean reboot.

The baseline symptom is load-independent: it reproduces on idle machines,
since even an idle server has periodic DMA in flight (NIC rings, NVMe
admin queues, etc.).

Overall, on both platforms this series turns a capture-kernel boot that
used to be buried under fatal PCIe error storms into a quiet one that
reliably produces a usable vmcore.

Please feel free to add:

Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks,
Shuai Xue
