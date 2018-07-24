From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC PATCH 01/10] iommu/vt-d: Get iommu device for a mediated
	device
Date: Tue, 24 Jul 2018 10:06:44 +0800
Message-ID: <5B5689B4.2080706@linux.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-2-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA141D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A2975661238FB949B60364EF0F2C257439CA141D-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Yi,

Thank you for reviewing my patch.

On 07/23/2018 12:44 PM, Liu, Yi L wrote:
> Hi Baolu,
>
> Per my understanding, the subject is not accurate. I think this patch is
> to get parent device structure for a mediate device instead of iommu
> device. This may be misleading for reviewers.

Please check below.

>
> Thanks,
> Yi Liu
>
>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
>> Sent: Sunday, July 22, 2018 2:09 PM
>>
>> This patch adds the support to get the iommu device for a mediated device. The
>> assumption is that each mediated device is a minimal assignable set of a physical PCI
>> device. Hence, we should use the iommu device of the parent PCI device to manage
>> the translation.
>>
>> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Sanjay Kumar <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>>  drivers/iommu/intel-iommu.c |  6 ++++++  drivers/iommu/intel-pasid.h | 16
>> ++++++++++++++++
>>  2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c index
>> 7d198ea..fc3ac1c 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -767,6 +767,12 @@ static struct intel_iommu *device_to_iommu(struct device
>> *dev, u8 *bus, u8 *devf
>>  	if (iommu_dummy(dev))
>>  		return NULL;
>>
>> +	if (dev_is_mdev(dev)) {
>> +		dev = dev_mdev_parent(dev);
>> +		if (WARN_ON(!dev_is_pci(dev)))
>> +			return NULL;
>> +	}
>> +

This gets the parent of a mediated device. And an iommu device will be
found which services the parent device. A mediated device should in the
same iommu scope as its parent.

Best regards,
Lu Baolu

>>  	if (dev_is_pci(dev)) {
>>  		struct pci_dev *pf_pdev;
>>
>> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h index
>> 518df72..46cde66 100644
>> --- a/drivers/iommu/intel-pasid.h
>> +++ b/drivers/iommu/intel-pasid.h
>> @@ -35,6 +35,22 @@ struct pasid_table {
>>  	struct list_head	dev;		/* device list */
>>  };
>>
>> +static inline bool dev_is_mdev(struct device *dev) {
>> +	if (!dev)
>> +		return false;
>> +
>> +	return !strcmp(dev->bus->name, "mdev"); }
>> +
>> +static inline struct device *dev_mdev_parent(struct device *dev) {
>> +	if (WARN_ON(!dev_is_mdev(dev)))
>> +		return NULL;
>> +
>> +	return dev->parent;
>> +}
>> +
>>  extern u32 intel_pasid_max_id;
>>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);  void
>> intel_pasid_free_id(int pasid);
>> --
>> 2.7.4
>
