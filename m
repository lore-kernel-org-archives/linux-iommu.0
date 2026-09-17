Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5737E5D4
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 02:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610550; cv=none; b=f++nn27s23jDp98+5B84el9zH9QFJIvu75ErRYqgeuoUlvNqHbHXkRfsEqwPWOC5+laxMUbJYkdq0JMDv9gjQtUOQpcmLO/nHpOBJsHBjXMFG1riaROwLmkOpTR4RskVxABb8j0qq9h/VPaUu9Go8Ba8lwAVQZYLdmEMumi4af8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610550; c=relaxed/simple;
	bh=eb0Fawu3NU7oV+2PX2UXZmgSqwPmGmnl5DVZkzFCk+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J23y5Minxb1/zUox1MMjfAUtqMqK9+hvDdmRWgv98kwDx0glfjPX8cvEjpsWS90kAgHqgt5fU5ldXxK+LIgmGZVpiMizGjPitM2U+T9g4/h7sZc4z1tOBjtHSl52VHiTy6d4ml3jZZYjLrC5qJVwMn1/wrsxrgyXlfjMAdsnVMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TriPz3rg; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TriPz3rg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789610544; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=r4BipCby/D23pWA2wWsCcFIn8JR+n+6hfyldx82wyyQ=;
	b=TriPz3rgaJShXPDUxnpKHRkbV9Sz/1zt834n2Rq92h2bafS6PiX/k1R6dU2faaj8BJA6iLdSH3DMj6El1HzZpAhckrSRXKsc0w5sksnuwmdMyblyqG/wzjk8NegdUkhdUq7iHGStbfY34QqX13I9f8a14lmyOXn6c7Yb7g9v+v0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XB6KyDe_1789610540;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XB6KyDe_1789610540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 10:02:22 +0800
From: fangyu.yu@linux.alibaba.com
To: gsh517025@gmail.com
Cc: alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v4 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains
Date: Thu, 17 Sep 2026 10:02:19 +0800
Message-Id: <20260917020219.96918-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <8530f6cf-3c61-4bd1-871d-b589ef0412bd@gmail.com>
References: <8530f6cf-3c61-4bd1-871d-b589ef0412bd@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
>> Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
>> in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
>> autonomously sets D on the first write to a page mapped by an iohgatp
>> domain.  This series wires that capability up to the iommufd dirty-tracking
>> interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
>> reports IOMMU_CAP_DIRTY_TRACKING.
>>
>> Design notes
>> ------------
>>
>> * The feature is scoped to second-stage (iohgatp) domains only; these are
>>    the domains created for KVM / VFIO device pass-through when userspace
>>    allocates an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT or
>>    IOMMU_HWPT_ALLOC_DIRTY_TRACKING.  First-stage (iosatp) domains are not
>>    touched by this series.
>>
>> * The page-table side plugs into the existing generic_pt dirty hook
>>    framework (amdv1 / vtdss style).  RISC-V adds the three required PTE
>>    ops – is_write_dirty / make_write_clean / make_write_dirty.
>>
>> Testing
>> -------
>>
>> * Test on QEMU RISC-V, a nvme and an e1000e device was passed through
>>    to an L2 guest via vfio-pci + iommufd.
>>
>> * generic_pt KUnit: the existing test_dirty case now runs and passes for
>>    the RISC-V 64-bit format.
>>
>> Follow-up work
>> --------------
>> * Build a dedicated end-to-end test case that drives the full flow
>>    (HWPT_ALLOC with DIRTY_TRACKING -> attach -> IOAS_MAP -> generate real
>>    DMA -> SET_DIRTY_TRACKING -> GET_DIRTY_BITMAP -> verify bitmap against
>>    expected IOVA footprint) so that the behaviour can be regression-tested
>>    beyond the KUnit PTE-level coverage.
>>
>> * If possible, rebase and retest on top of the updated "iommu irqbypass"
>>    patchset.
>>
>> ---
>> Changes in v4 (Jason's suggestions):
>>      - Rebased the series on top of [1] and [2].
>>      - Drop the RISC-V-specific pt_num_items_lg2() top-level special case.
>>      - Validate page-table address widths by translation stage: accept only
>>        Sv39/Sv48/Sv57 widths for first-stage tables and only Sv39x4/Sv48x4/
>>        Sv57x4 widths for second-stage tables.
>>      - Replace the aliased first-stage/second-stage MODE union with
>>        independent FSC/IOSATP and IOHGATP MODE fields.
>>      - Add pt_dirty_supported() to restrict RISC-V generic_pt dirty tracking
>>        to second-stage tables.
>>      - Link to v3:
>>        https://lore.kernel.org/linux-riscv/20260821132749.82070-1-fangyu.yu@linux.alibaba.com/
>> Changes in v3 (Andrew Jones's suggestions):
>>      - Rebased the series on top of Andrew Jones' generic_pt RISC-V supported
>>        feature mask fix, which adds PT_FEAT_RISCV_SVPBMT to the supported feature
>>        set.
>>      - Added PT_FEAT_RISCV_S2 to the RISC-V generic_pt supported feature mask and
>>        KUnit feature matrix.
>>      - Kept PT_FEAT_SIGN_EXTEND only for first-stage RISC-V KUnit configs; second
>>        stage configs now use PT_FEAT_RISCV_S2 without sign-extension semantics.
>>      - Split RISC-V IOMMU capability checks into first-stage FSC and second-stage
>>        IOHGATP helpers.
>>      - Updated second-stage paging domain setup to use GPA widths 41/50/59 and to
>>        avoid PT_FEAT_SIGN_EXTEND.
>>      - Link to v2:
>>        https://lore.kernel.org/linux-riscv/20260507113706.11400-1-fangyu.yu@linux.alibaba.com/
>> Changes in v2 (Jason's suggestions):
>>      - Introduced a single PT_FEAT_RISCV_S2: second-stage selection is driven
>>        purely by this feature bit.
>>      - Switched from dynamic DC.tc.GADE toggling to static pre-enable.
>>      - domain_alloc_paging_flags: follow the switch/case design from other
>>        drivers.
>>      - Drop IOMMU_CAP_DEFERRED_FLUSH in riscv_iommu_capable.
>>      - Remove the .hw_info-related patch.
>>      - Link to v1:
>>        https://lore.kernel.org/linux-riscv/20260428131359.34872-1-fangyu.yu@linux.alibaba.com/
>>
>> [1] https://lore.kernel.org/linux-iommu/1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
>> [2] https://lore.kernel.org/linux-iommu/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/
>>
>> Fangyu Yu (6):
>>    iommupt: Add RISC-V Second-stage (iohgatp) page table support
>>    iommupt: Add RISC-V dirty tracking PTE ops
>>    iommu/riscv: Add domain_alloc_paging_flags for second-stage domain
>>    iommu/riscv: Pre-enable GADE for second-stage domainsgon
>>    iommu/riscv: Add dirty tracking support for second-stage domains
>>    iommu/riscv: Add IOTINVAL.GVMA after updating DDT/PDT entries
>
>Hi Fangyu,
>
>This patch (10/10) is missing from this series.
>It was also missing in RFC v3.
>

Hi Shuai,

Thanks for catching that. You’re right — I missed patch 10/10, and it
was indeed omitted from the series. 
I’ll resend it.

Thanks,
Fangyu

>Thanks,
>Shuai
>
>>
>> Tomasz Jeznach (2):
>>    iommu/riscv: report iommu capabilities
>>    RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
>>
>> Zong Li (2):
>>    iommu/riscv: use data structure instead of individual values
>>    iommu/riscv: support GSCID and GVMA invalidation command
>>
>>   arch/riscv/kvm/Kconfig                       |   2 +
>>   drivers/iommu/generic_pt/fmt/iommu_riscv64.c |   2 +-
>>   drivers/iommu/generic_pt/fmt/riscv.h         | 158 +++++++++++--
>>   drivers/iommu/riscv/iommu-bits.h             |   7 +
>>   drivers/iommu/riscv/iommu.c                  | 224 +++++++++++++++----
>>   include/linux/generic_pt/common.h            |   4 +
>>   include/linux/generic_pt/iommu.h             |  11 +
>>   7 files changed, 336 insertions(+), 72 deletions(-)
>>
