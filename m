From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Date: Wed, 26 Apr 2017 11:08:17 +0100
Message-ID: <c53478ed-20a9-414f-06ef-385c9252556f@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-30-jean-philippe.brucker@arm.com>
	<f5745241-83b0-0945-7616-4b59d7ebcd48@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f5745241-83b0-0945-7616-4b59d7ebcd48-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 26/04/17 07:53, Tomasz Nowicki wrote:
>> +        mutex_lock(&device->tasks_lock);
>> +        list_for_each_entry(vfio_task, &device->tasks, list) {
>> +            if (vfio_task->pasid != svm.pasid)
>> +                continue;
>> +
>> +            ret = iommu_unbind_task(device->dev, svm.pasid, flags);
>> +            if (ret)
>> +                dev_warn(device->dev, "failed to unbind PASID %u\n",
>> +                     vfio_task->pasid);
>> +
>> +            list_del(&vfio_task->list);
>> +            kfree(vfio_task);
> 
> Please use list_for_each_entry_safe.

There is:

+            break;

right after kfree, so we'd never follow vfio_task->list.next after freeing
vfio_task. The code searches for the _only_ task matching the PASID,
removes it and leaves the loop.

Thanks,
Jean-Philippe
