From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC PATCH 04/30] iommu/arm-smmu-v3: Add support for PCI ATS
Date: Wed, 10 May 2017 14:35:20 +0100
Message-ID: <d4ad80e6-4654-710c-4b30-35fd81ab3f06@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-5-jean-philippe.brucker@arm.com>
 <bc1237e2-3690-bc1e-b7bc-86b982c9058f@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <bc1237e2-3690-bc1e-b7bc-86b982c9058f@semihalf.com>
Sender: linux-pci-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Nate Watterson <nwatters@qti.qualcomm.com>
List-Id: iommu@lists.linux-foundation.org

On 10/05/17 13:54, Tomasz Nowicki wrote:
> Hi Jean,
> 
> On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
>> +/*
>> + * Returns -ENOSYS if ATS is not supported either by the device or by
>> the SMMU
>> + */
>> +static int arm_smmu_enable_ats(struct arm_smmu_master_data *master)
>> +{
>> +    int ret;
>> +    size_t stu;
>> +    struct pci_dev *pdev;
>> +    struct arm_smmu_device *smmu = master->smmu;
>> +
>> +    if (!(smmu->features & ARM_SMMU_FEAT_ATS) || !dev_is_pci(master->dev))
>> +        return -ENOSYS;
>> +
>> +    pdev = to_pci_dev(master->dev);
>> +
>> +#ifdef CONFIG_PCI_ATS
>> +    if (!pdev->ats_cap)
>> +        return -ENOSYS;
>> +#else
>> +    return -ENOSYS;
>> +#endif
> 
> Nit: This deserves to be another helper in ats.c like:
> 
> int pci_ats_supported(struct pci_dev *dev) {
>         if (!pdev->ats_cap)
>                 return 0;
> 
>         return 1;
> }

Indeed, although in my next version I'll remove this check altogether.
Instead I now rely on pci_enable_ats to check for ats_cap (as discussed in
patch 3). The downside is that we can't distinguish between absence of ATS
and error in enabling ATS. So we don't print a message in the latter case
anymore, we expect device drivers to check whether ATS is enabled.

Thanks,
Jean
