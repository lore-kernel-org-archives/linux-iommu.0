From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
	device
Date: Wed, 25 Jul 2018 09:18:21 +0800
Message-ID: <5B57CFDD.1070505@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
	<20180724125056.4ae477c9@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180724125056.4ae477c9-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On 07/25/2018 02:50 AM, Alex Williamson wrote:
> On Sun, 22 Jul 2018 14:09:24 +0800
> Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>
>> This patch adds the support to get the iommu device for a mediated
>> device. The assumption is that each mediated device is a minimal
>> assignable set of a physical PCI device. Hence, we should use the
>> iommu device of the parent PCI device to manage the translation.
> Hmm, is this absolutely a valid assumption?  I'm afraid there's an
> assumption throughout this series that the only way an mdev device
> could be interacting with the IOMMU is via S-IOV, but we could choose
> today to make an mdev wrapper for any device, which might provide basic
> RID granularity to the IOMMU.  So if I make an mdev wrapper for a PF
> such that I can implement migration for that device, is it valid for
> the IOMMU driver to flag me as an mdev device and base mappings on my
> parent device? 

You are right. We should not make it SIOV centric. Let me look into the
patches and identify/fix the unreasonable assumptions.

>  Perhaps in this patch we can assume that the parent of
> such an mdev device would be the PF backing it and that results in the
> correct drhd,

Okay.

>  but in the next patch we start imposing the assumption
> that because the device is an mdev, the only valid association is via
> pasid, which I'd say is incorrect.

You are right. I will find and fix it.

>  
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 ++++++
>>  drivers/iommu/intel-pasid.h | 16 ++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 7d198ea..fc3ac1c 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
>>  	if (iommu_dummy(dev))
>>  		return NULL;
>>  
>> +	if (dev_is_mdev(dev)) {
>> +		dev = dev_mdev_parent(dev);
>> +		if (WARN_ON(!dev_is_pci(dev)))
>> +			return NULL;
>> +	}
>> +
>>  	if (dev_is_pci(dev)) {
>>  		struct pci_dev *pf_pdev;
>>  
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
>> index 518df72..46cde66 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -35,6 +35,22 @@ struct pasid_table {
>>  	struct list_head	dev;		/* device list */
>>  };
>>  
>> +static inline bool dev_is_mdev(struct device *dev)
>> +{
>> +	if (!dev)
>> +		return false;
>> +
>> +	return !strcmp(dev->bus->name, "mdev");
>> +}
> I assume we're not using mdev_bus_type because mdev is a loadable
> module and that symbol doesn't exist in this statically loaded driver,

Yes.

> but strcmp is a pretty ugly alternative.  Could we use symbol_get() so
> that we can use mdev_bus_type?  Thanks,

Sure.

Best regards,
Lu Baolu
