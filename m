From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
Date: Fri, 22 Mar 2019 09:57:01 +0000
Message-ID: <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 15 Mar 2019, at 02:19, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/14/19 7:58 PM, James Sewart wrote:
>> To support mapping ISA region via iommu_group_create_direct_mappings,
>> make sure its exposed by iommu_get_resv_regions. This allows
>> deduplication of reserved region mappings
>> Signed-off-by: James Sewart <jamessewart@arista.com>
>> ---
>>  drivers/iommu/intel-iommu.c | 42 =
+++++++++++++++++++++++++++++--------
>>  1 file changed, 33 insertions(+), 9 deletions(-)
>> diff --git a/drivers/iommu/intel-iommu.c =
b/drivers/iommu/intel-iommu.c
>> index 8e0a4e2ff77f..2e00e8708f06 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -337,6 +337,8 @@ static LIST_HEAD(dmar_rmrr_units);
>>  #define for_each_rmrr_units(rmrr) \
>>  	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
>>  +static struct iommu_resv_region *isa_resv_region;
>> +
>>  /* bitmap for indexing intel_iommus */
>>  static int g_num_of_iommus;
>>  @@ -2780,26 +2782,34 @@ static inline int =
iommu_prepare_rmrr_dev(struct dmar_rmrr_unit *rmrr,
>>  					  rmrr->end_address);
>>  }
>>  +static inline struct iommu_resv_region =
*iommu_get_isa_resv_region(void)
>> +{
>> +	if (!isa_resv_region)
>> +		isa_resv_region =3D iommu_alloc_resv_region(0,
>> +				16*1024*1024,
>> +				0, IOMMU_RESV_DIRECT);
>> +
>> +	return isa_resv_region;
>> +}
>> +
>>  #ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
>> -static inline void iommu_prepare_isa(void)
>> +static inline void iommu_prepare_isa(struct pci_dev *pdev)
>>  {
>> -	struct pci_dev *pdev;
>>  	int ret;
>> +	struct iommu_resv_region *reg =3D iommu_get_isa_resv_region();
>>  -	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
>> -	if (!pdev)
>> +	if (!reg)
>>  		return;
>>    	pr_info("Prepare 0-16MiB unity mapping for LPC\n");
>> -	ret =3D iommu_prepare_identity_map(&pdev->dev, 0, 16*1024*1024 - =
1);
>> +	ret =3D iommu_prepare_identity_map(&pdev->dev, reg->start,
>> +			reg->start + reg->length - 1);
>>    	if (ret)
>>  		pr_err("Failed to create 0-16MiB identity map - floppy =
might not work\n");
>> -
>> -	pci_dev_put(pdev);
>>  }
>>  #else
>> -static inline void iommu_prepare_isa(void)
>> +static inline void iommu_prepare_isa(struct pci_dev *pdev)
>>  {
>>  	return;
>>  }
>> @@ -3289,6 +3299,7 @@ static int __init init_dmars(void)
>>  	struct dmar_rmrr_unit *rmrr;
>>  	bool copied_tables =3D false;
>>  	struct device *dev;
>> +	struct pci_dev *pdev;
>>  	struct intel_iommu *iommu;
>>  	int i, ret;
>>  @@ -3469,7 +3480,11 @@ static int __init init_dmars(void)
>>  		}
>>  	}
>>  -	iommu_prepare_isa();
>> +	pdev =3D pci_get_class(PCI_CLASS_BRIDGE_ISA << 8, NULL);
>> +	if (pdev) {
>> +		iommu_prepare_isa(pdev);
>> +		pci_dev_put(pdev);
>> +	}
>>    domains_done:
>>  @@ -5266,6 +5281,7 @@ static void =
intel_iommu_get_resv_regions(struct device *device,
>>  	struct iommu_resv_region *reg;
>>  	struct dmar_rmrr_unit *rmrr;
>>  	struct device *i_dev;
>> +	struct pci_dev *pdev;
>>  	int i;
>>    	rcu_read_lock();
>> @@ -5280,6 +5296,14 @@ static void =
intel_iommu_get_resv_regions(struct device *device,
>>  	}
>>  	rcu_read_unlock();
>>  +	if (dev_is_pci(device)) {
>> +		pdev =3D to_pci_dev(device);
>> +		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
>> +			reg =3D iommu_get_isa_resv_region();
>> +			list_add_tail(&reg->list, head);
>> +		}
>> +	}
>> +
>=20
> Just wondering why not just
>=20
> +#ifdef CONFIG_INTEL_IOMMU_FLOPPY_WA
> +	if (dev_is_pci(device)) {
> +		pdev =3D to_pci_dev(device);
> +		if ((pdev->class >> 8) =3D=3D PCI_CLASS_BRIDGE_ISA) {
> +			reg =3D iommu_alloc_resv_region(0,
> +				16*1024*1024,
> +				0, IOMMU_RESV_DIRECT);
> +			if (reg)
> +				list_add_tail(&reg->list, head);
> +		}
> +	}
> +#endif
>=20
> and, remove all other related code?

At this point in the patchset if we remove iommu_prepare_isa then the =
ISA=20
region won=E2=80=99t be mapped to the device. Only once the dma domain =
is allocable=20
will the reserved regions be mapped by =
iommu_group_create_direct_mappings.

Theres an issue that if we choose to alloc a new resv_region with type=20=

IOMMU_RESV_DIRECT, we will need to refactor intel_iommu_put_resv_regions=20=

to free this entry type which means refactoring the rmrr regions in=20
get_resv_regions. Should this work be in this patchset?

>=20
> Best regards,
> Lu Baolu

Cheers,
James.
