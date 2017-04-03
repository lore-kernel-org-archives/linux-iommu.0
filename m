From: Sunil Kovvuri <sunil.kovvuri@gmail.com>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Mon, 3 Apr 2017 14:04:35 +0530
Message-ID: <CA+sq2CeWpGarhT9p+iVo8nJXR=xpkj6XNMwv4LvbP0M6JxA_SA@mail.gmail.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com> <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170227195441.5170-5-jean-philippe.brucker@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Harv Abdulhamid <harba@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@qti.qualcomm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Nate Watterson <nwatters@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>, LAKML <linux-arm-kernel@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

> +static size_t arm_smmu_atc_invalidate_domain(struct arm_smmu_domain *smmu_domain,
> +                                            unsigned long iova, size_t size)
> +{
> +       unsigned long flags;
> +       struct arm_smmu_cmdq_ent cmd = {0};
> +       struct arm_smmu_group *smmu_group;
> +       struct arm_smmu_master_data *master;
> +       struct arm_smmu_device *smmu = smmu_domain->smmu;
> +       struct arm_smmu_cmdq_ent sync_cmd = {
> +               .opcode = CMDQ_OP_CMD_SYNC,
> +       };
> +
> +       spin_lock_irqsave(&smmu_domain->groups_lock, flags);
> +
> +       list_for_each_entry(smmu_group, &smmu_domain->groups, domain_head) {
> +               if (!smmu_group->ats_enabled)
> +                       continue;

If ATS is not supported, this seems to increase no of cycles spent in
pgtbl_lock.
Can we return from this API by checking 'ARM_SMMU_FEAT_ATS' in smmu->features ?

Thanks,
Sunil.
