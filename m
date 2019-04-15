From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/7] ACPI/IORT: Check ATS capability in root complex
	nodes
Date: Mon, 15 Apr 2019 19:00:04 +0100
Message-ID: <ca0bf1eb-dc8f-97b5-6577-f72bdb60e5bd@arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
	<20190409165245.26500-2-jean-philippe.brucker@arm.com>
	<20190415132108.GB15023@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190415132108.GB15023-UDVVEH7NWB15pKCnmE3YQBJ8xKzm50AiAL8bYrjMMd8@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/04/2019 14:21, Will Deacon wrote:
> On Tue, Apr 09, 2019 at 05:52:39PM +0100, Jean-Philippe Brucker wrote:
>> Root complex node in IORT has a bit telling whether it supports ATS or
>> not. Store this bit in the IOMMU fwspec when setting up a device, so it
>> can be accessed later by an IOMMU driver.
>>
>> Use the negative version (NO_ATS) at the moment because it's not clear
>> if/how the bit needs to be integrated in other firmware descriptions. The
>> SMMU has a feature bit telling if it supports ATS, which might be
>> sufficient in most systems for deciding whether or not we should enable
>> the ATS capability in endpoints.
> 
> Hmm, the SMMUv3 architecture manual is pretty explicit about this:
> 
>   | It [SMMU_IDR0.ATS] does not guarantee that client devices and intermediate
>   | components also support ATS and this must be determined separately.
> 
> so we may need to extend the PCI bindings to describe this. I think the
> negative logic is likely to get in the way if that's the case.

Right. For devicetree I can resurrect the patch I proposed a while ago
[1]. Rob wasn't keen on adding an "ats-supported" property to PCI host
bridge nodes. Instead the host controller drivers should deduce whether
ATS is supported from the compatible string. But I'll resend that patch
adding the property only to pci-host-ecam-generic.

[1] https://lists.linuxfoundation.org/pipermail/iommu/2017-May/022043.html

>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
>> ---
>>  drivers/acpi/arm64/iort.c | 11 +++++++++++
>>  include/linux/iommu.h     |  4 ++++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index e48894e002ba..7f2c1c9c6b38 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1028,6 +1028,14 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>>  	dev_dbg(dev, "dma_pfn_offset(%#08llx)\n", offset);
>>  }
>>  
>> +static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
>> +{
>> +	struct acpi_iort_root_complex *pci_rc;
>> +
>> +	pci_rc = (struct acpi_iort_root_complex *)node->node_data;
>> +	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
>> +}
> 
> Do we need to worry about the "noats" command-line option here? It feels
> like we should be checking with the PCI subsystem before telling the SMMU
> we're good to go.

I'm checking the noats option in arm_smmu_enable_ats() at the moment,
using the pci_ats_disabled() helper.

Thanks,
Jean
