From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/7] ACPI/IORT: Check ATS capability in root complex
	nodes
Date: Tue, 16 Apr 2019 17:27:29 +0100
Message-ID: <9fef7037-3d55-8955-fc14-6f823d996b81@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
	<20190409165245.26500-2-jean-philippe.brucker@arm.com>
	<c10c7adb-c7f6-f8c6-05cc-f4f143427a2d@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c10c7adb-c7f6-f8c6-05cc-f4f143427a2d-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 15/04/2019 19:31, Robin Murphy wrote:
> On 09/04/2019 17:52, Jean-Philippe Brucker wrote:
>> Root complex node in IORT has a bit telling whether it supports ATS or
>> not. Store this bit in the IOMMU fwspec when setting up a device, so it
>> can be accessed later by an IOMMU driver.
> 
> Hmm, it doesn't feel quite right to store a copy of the same RC/SMMU 
> integration property for every endpoint...
> 
> It seems like it might be more logical to track this at the SMMU end, 
> i.e. only allow ARM_SMMU_FEAT_ATS to be set if all RCs targeting that 
> SMMU also support ATS. For the moment that seems sufficiently realistic, 
> and unless some wacky topology ever actually shows up in silicon to 
> complain, I'm inclined not to care too much about it being potentially 
> overly restrictive.

Doesn't that require us to implement a reverse lookup of smmu-node ->
RC-node using the iommu maps, in both DT and IORT? Seems like a lot of
work for little gain. Putting the bit in fwspec isn't ideal, but I don't
find aggregating properties of RCs into ARM_SMMU_FEAT_ATS much nicer.

> Furthermore, I'm now wondering whether it would make sense to push this 
> into the PCI layer as well (or instead), i.e. hook into pci_init_ats() 
> or pci_enable_ats() and it the device is untrusted or the topology 
> doesn't support ATS, prevent the capability from ever being enabled at 
> all, rather than trying to mitigate it later at the SMMU end. What do 
> you reckon?

For the RC property it's a bit difficult because everyone does it
differently. All of DMAR, IVRS, IORT and DT-based implementations would
have to call into the PCI core to declare whether a device is allowed to
do ATS or not. Which is essentially what the IOMMU drivers do now by
calling pci_enable_ats() themselves.

Having pci_enable_ats() check the untrusted bit seems like a good
cleanup. I'm not sure yet but given that it has side effects (AMD IOMMU
doesn't check that bit at the moment) it would probably fit better in a
separate series.

>> Use the negative version (NO_ATS) at the moment because it's not clear
>> if/how the bit needs to be integrated in other firmware descriptions. The
>> SMMU has a feature bit telling if it supports ATS, which might be
>> sufficient in most systems for deciding whether or not we should enable
>> the ATS capability in endpoints.
> 
> I can fairly confidently guarantee that it won't. For instance, MMU-600 
> reports IDR0.ATS==1 because MMU-600 implements the SMMUv3 architectural 
> ATS support. Actually making use of that support, though, still requires 
> an RC capable of generating the appropriate DTI-ATS messages, and that a 
> DTI interface is wired up correctly between the two.

Right, we need to explicitly validate that the RC understands ATS. If we
enable ATS but the root complex doesn't support it, in addition to being
unusable it might be possible for the EP to corrupt memory, because to
an RC that ignores the AT field, a Translation Request looks like a
Memory Read Request. The endpoint could end up storing the content of
memory in its ATC instead of a translated address, and later use that
as address of a write.

>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/acpi/arm64/iort.c | 11 +++++++++++
>>   include/linux/iommu.h     |  4 ++++
>>   2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index e48894e002ba..7f2c1c9c6b38 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>   	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>>   }
>>   
>> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>> +{
>> +	struct acpi_iort_root_complex *pci_rc;
>> +
>> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
>> +}
>> +
>>   /**
>>    * iort_iommu_configure - Set-up IOMMU configuration for a device.
>>    *
>> @@ -1063,6 +1071,9 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>>   		info.node = node;
>>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>   					     iort_pci_iommu_init, &info);
>> +
>> +		if (!err && !iort_pci_rc_supports_ats(node))
>> +			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_NO_ATS;
>>   	} else {
>>   		int i = 0;
>>   
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index 3dbeb457fb16..ed6738c358ca 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -509,10 +509,14 @@ struct iommu_fwspec {
>>   	const struct iommu_ops	*ops;
>>   	struct fwnode_handle	*iommu_fwnode;
>>   	void			*iommu_priv;
>> +	u32			flags;
>>   	unsigned int		num_ids;
>>   	u32			ids[1];
>>   };
>>   
>> +/* Firmware disabled ATS in the root complex */
> 
> More likely firmware is just describing how the hardware was built ;)

Right, I'll fix this

Thanks,
Jean
