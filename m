From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 28/37] iommu/arm-smmu-v3: Maintain a SID->device structure
Date: Wed, 14 Mar 2018 13:09:10 +0000
Message-ID: <4d83c676-604c-6003-5284-81e3535689a8@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-29-jean-philippe.brucker@arm.com>
	<20180308183431.00005f86@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180308183431.00005f86-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rjw@rjwyso
List-Id: iommu@lists.linux-foundation.org

On 08/03/18 17:34, Jonathan Cameron wrote:
>>  static int arm_smmu_add_device(struct device *dev)
>> @@ -2198,6 +2298,7 @@ static int arm_smmu_add_device(struct device *dev)
>>  
>>  	group = iommu_group_get_for_dev(dev);
>>  	if (!IS_ERR(group)) {
>> +		arm_smmu_insert_master(smmu, master);
> There are some error cases it would be good to take notice off when
> inserting the master.  Admittedly the same is true of iommu_device_link
> so I guess you are keeping with the existing code style.
> 
> Would also be nice if the later bit of rework to drop these out
> of the if statement was done before this patch in the series.

Not sure that's worth a separate patch, maybe we can do it here.

Thanks,
Jean

> 
>>  		iommu_group_put(group);
>>  		iommu_device_link(&smmu->iommu, dev);
>>  	}
>> @@ -2218,6 +2319,7 @@ static void arm_smmu_remove_device(struct device *dev)
>>  	smmu = master->smmu;
>>  	if (master && master->ste.assigned)
>>  		arm_smmu_detach_dev(dev);
>> +	arm_smmu_remove_master(smmu, master);
>>  	iommu_group_remove_device(dev);
>>  	iommu_device_unlink(&smmu->iommu, dev);
>>  	kfree(master);
>> @@ -2527,6 +2629,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>>  	int ret;
>>  
>>  	atomic_set(&smmu->sync_nr, 0);
>> +	mutex_init(&smmu->streams_mutex);
>> +	smmu->streams = RB_ROOT;
>> +
>>  	ret = arm_smmu_init_queues(smmu);
>>  	if (ret)
>>  		return ret;
> 
> 
