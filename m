Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE0357CF1
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 01:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609276; cv=none; b=omY7fTka8PXa6JgZymDipB/Ud5kg+k787XfznoaAF9n3EC3JHKiBU+MlzUs2TKUGie3oedxi1FD4t7WcKsT0OAUND4PvWya/15JAmHEC2Bk9gfLgJAogLzH8ktkLuFo6KJ46wQR90M+1bCRMEPeH/qZ5czaThDHfRa/gbmuWIfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609276; c=relaxed/simple;
	bh=pCZRKaN7b0DZpONbjkmfo6/OIA6Jc9dc5IrybdG4dlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caURGz41W6T4lrU5nIhwC19xj0EQQPHXuU4TQGQYnBTv7JXGkt0IbPoA7ndFoogzcY90Xy79zsIcpQEW4iHCbjXGMBpytF7XCckZAbTMFbZ1zhYrmNhcJmb/z+GJo1TO29sMrxYz3Kq4lT9Jm7UY/eL5qGmNxziN3xRAcA6SraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPp1ZSsh; arc=none smtp.client-ip=74.125.227.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPp1ZSsh"
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-38fd9408220so64303a91.1
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 18:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789609274; x=1790214074; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=phs6j4c6GSVsgWqjzCyy6AX6x537GMsS5N7HEcIYNoA=;
        b=bPp1ZSshGAHkKgtw8cvGCGx1HtfBndV9Sb+IcPVbQwBcfK2mehGvd2k7bO5xto+dCR
         0MsAkumcxONUJSpFaR/8AumfLFeuPVPKMB4OpvTQ2teJd4gG22aXSzInYnltiJVRdzcT
         FGQwXlomuAtQWdGuKn4t7Dgil5hoyTnqe2bGnJn29UaCKuGZON5xJvhX1fItBbd5Qrkg
         kPayWSoSvDyjsVmC4NRcJHEQu29+7Pm2/Z3bSy6pLJqeI25Plqyc1Y+PuBRcgRdiEQE0
         FOfXMxH4c+PTDt2KlQdhXN7alEdTHR8MRmx0Js5EUmYQO9YPuS+oVNADj3NvOrx8AV7/
         pL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789609274; x=1790214074;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=phs6j4c6GSVsgWqjzCyy6AX6x537GMsS5N7HEcIYNoA=;
        b=HEjuKrmLjvAW6U+SwsipaWjufvuv09bIsV9nIHwK2O+HLoPEzwuPMVMli59ggljHO8
         qgjiGRb+eewgfCpl0CjpJFMTU81hlE1oFdBwtH9R2mDNGQhnlzj0k6+f+Ig8611G5w3z
         w17PcJl6ViH4/LDJ4zr+YrMoVY4dRGNoZ2ntMndzBqAplIAHV2G45OuoSJwIkhuWBiY7
         QnSpisOebr1fge2mF76mIN44mtElQU43DfAiwX+U/BO0KqhbTjXP2J6nxUoLoCOFmDIO
         3gkW1HPY8/raqi9GUDaJmwyr/zPRMPyUZM+cgrmfRoJiX/IsmHJ04l+jKutcYRI8m3si
         mwiQ==
X-Forwarded-Encrypted: i=1; AKwUvByha8tNQh5JKFlfvf3WuLg5aHYIpvwCGsn3Ht4z9Q6UVxhjB1l9i99W26B0tPkkAqYuc7qgfA==@lists.linux.dev
X-Gm-Message-State: AFuF++nMNfOCRt529ZNGru7d7nXpDhTrc3rmsO2QQ6fhHJ0nFkRlsS8P
	nbyV037r48riU55kgLMqx4xE6cT89BmJN2iy8KFurGY6Yddi9IMUdMZv
X-Gm-Gg: AYBFou3zdkH6K3NynBjSuX3PbuoN6jY041kIRzTDpYMMqzrtmk7ctasNujqt3QKLbV6
	LFX55aOIlJzHsC8b9Ie/8u1Hg///tGyVliMVaH0TiXgGzu4Uf3NgJBNYm7BYHB9KuvMxKibgVIi
	fSdqWbrzwJVcdBWtfqf6/R9HQgeDgkfIrVoW6+PuSWQJ8iJFxcCfkP4++QBWQ1Z0p/erd+wYQGb
	jmz1UFipOUO5GJljS7mUSyw0QmgvCPuRJvFtGtE/E78ziHkH/1uI7JT5XrWxbH4GAOPAyJ3rFev
	xdqaNcWHlsFJFM9MhQyfM5O94xqTpZeWRxz2YPqKEr7RwZy5FVoFp6YXDtnZHcX78l2m2HXP4v/
	iR6CYtVUS1LMS+DowBtC0+DoC+ek3Ah36qdkNZFL7jN1NpXO2ZlBU4zA+5iqY5EsoA95o49F9Lp
	Z46rfut4sMnt3ePokDprx/rJ5s34Pr8CCNAxIH7Dkx4c2pXTk2Dr7iDlTMpeSN6RQuUFTC1WEoi
	GzbtvZqratjfghe/AdDGZFenCUHjj23vpstKLFNASXPFVgeFI2Mgg==
X-Received: by 2002:a17:90b:3b41:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-39e1e48a416mr10022482a91.15.1789609273770;
        Wed, 16 Sep 2026 18:41:13 -0700 (PDT)
Received: from ?IPV6:2409:8900:87c0:1605:195c:9057:4549:3b0b? ([2409:8900:87c0:1605:195c:9057:4549:3b0b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e3618ab38sm1949715a91.10.2026.09.16.18.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 18:41:13 -0700 (PDT)
Message-ID: <8530f6cf-3c61-4bd1-871d-b589ef0412bd@gmail.com>
Date: Thu, 17 Sep 2026 09:40:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 00/10] iommu/riscv: Add hardware dirty tracking for
 second-stage domains
To: fangyu.yu@linux.alibaba.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com, gong.shuai@sanechips.com.cn
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
> Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
> in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
> autonomously sets D on the first write to a page mapped by an iohgatp
> domain.  This series wires that capability up to the iommufd dirty-tracking
> interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
> reports IOMMU_CAP_DIRTY_TRACKING.
> 
> Design notes
> ------------
> 
> * The feature is scoped to second-stage (iohgatp) domains only; these are
>    the domains created for KVM / VFIO device pass-through when userspace
>    allocates an HWPT with IOMMU_HWPT_ALLOC_NEST_PARENT or
>    IOMMU_HWPT_ALLOC_DIRTY_TRACKING.  First-stage (iosatp) domains are not
>    touched by this series.
> 
> * The page-table side plugs into the existing generic_pt dirty hook
>    framework (amdv1 / vtdss style).  RISC-V adds the three required PTE
>    ops – is_write_dirty / make_write_clean / make_write_dirty.
> 
> Testing
> -------
> 
> * Test on QEMU RISC-V, a nvme and an e1000e device was passed through
>    to an L2 guest via vfio-pci + iommufd.
> 
> * generic_pt KUnit: the existing test_dirty case now runs and passes for
>    the RISC-V 64-bit format.
> 
> Follow-up work
> --------------
> * Build a dedicated end-to-end test case that drives the full flow
>    (HWPT_ALLOC with DIRTY_TRACKING -> attach -> IOAS_MAP -> generate real
>    DMA -> SET_DIRTY_TRACKING -> GET_DIRTY_BITMAP -> verify bitmap against
>    expected IOVA footprint) so that the behaviour can be regression-tested
>    beyond the KUnit PTE-level coverage.
> 
> * If possible, rebase and retest on top of the updated "iommu irqbypass"
>    patchset.
> 
> ---
> Changes in v4 (Jason's suggestions):
>      - Rebased the series on top of [1] and [2].
>      - Drop the RISC-V-specific pt_num_items_lg2() top-level special case.
>      - Validate page-table address widths by translation stage: accept only
>        Sv39/Sv48/Sv57 widths for first-stage tables and only Sv39x4/Sv48x4/
>        Sv57x4 widths for second-stage tables.
>      - Replace the aliased first-stage/second-stage MODE union with
>        independent FSC/IOSATP and IOHGATP MODE fields.
>      - Add pt_dirty_supported() to restrict RISC-V generic_pt dirty tracking
>        to second-stage tables.
>      - Link to v3:
>        https://lore.kernel.org/linux-riscv/20260821132749.82070-1-fangyu.yu@linux.alibaba.com/
> Changes in v3 (Andrew Jones's suggestions):
>      - Rebased the series on top of Andrew Jones' generic_pt RISC-V supported
>        feature mask fix, which adds PT_FEAT_RISCV_SVPBMT to the supported feature
>        set.
>      - Added PT_FEAT_RISCV_S2 to the RISC-V generic_pt supported feature mask and
>        KUnit feature matrix.
>      - Kept PT_FEAT_SIGN_EXTEND only for first-stage RISC-V KUnit configs; second
>        stage configs now use PT_FEAT_RISCV_S2 without sign-extension semantics.
>      - Split RISC-V IOMMU capability checks into first-stage FSC and second-stage
>        IOHGATP helpers.
>      - Updated second-stage paging domain setup to use GPA widths 41/50/59 and to
>        avoid PT_FEAT_SIGN_EXTEND.
>      - Link to v2:
>        https://lore.kernel.org/linux-riscv/20260507113706.11400-1-fangyu.yu@linux.alibaba.com/
> Changes in v2 (Jason's suggestions):
>      - Introduced a single PT_FEAT_RISCV_S2: second-stage selection is driven
>        purely by this feature bit.
>      - Switched from dynamic DC.tc.GADE toggling to static pre-enable.
>      - domain_alloc_paging_flags: follow the switch/case design from other
>        drivers.
>      - Drop IOMMU_CAP_DEFERRED_FLUSH in riscv_iommu_capable.
>      - Remove the .hw_info-related patch.
>      - Link to v1:
>        https://lore.kernel.org/linux-riscv/20260428131359.34872-1-fangyu.yu@linux.alibaba.com/
> 
> [1] https://lore.kernel.org/linux-iommu/1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
> [2] https://lore.kernel.org/linux-iommu/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/
> 
> Fangyu Yu (6):
>    iommupt: Add RISC-V Second-stage (iohgatp) page table support
>    iommupt: Add RISC-V dirty tracking PTE ops
>    iommu/riscv: Add domain_alloc_paging_flags for second-stage domain
>    iommu/riscv: Pre-enable GADE for second-stage domainsgon
>    iommu/riscv: Add dirty tracking support for second-stage domains
>    iommu/riscv: Add IOTINVAL.GVMA after updating DDT/PDT entries

Hi Fangyu,

This patch (10/10) is missing from this series.
It was also missing in RFC v3.

Thanks,
Shuai

> 
> Tomasz Jeznach (2):
>    iommu/riscv: report iommu capabilities
>    RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
> 
> Zong Li (2):
>    iommu/riscv: use data structure instead of individual values
>    iommu/riscv: support GSCID and GVMA invalidation command
> 
>   arch/riscv/kvm/Kconfig                       |   2 +
>   drivers/iommu/generic_pt/fmt/iommu_riscv64.c |   2 +-
>   drivers/iommu/generic_pt/fmt/riscv.h         | 158 +++++++++++--
>   drivers/iommu/riscv/iommu-bits.h             |   7 +
>   drivers/iommu/riscv/iommu.c                  | 224 +++++++++++++++----
>   include/linux/generic_pt/common.h            |   4 +
>   include/linux/generic_pt/iommu.h             |  11 +
>   7 files changed, 336 insertions(+), 72 deletions(-)
> 

