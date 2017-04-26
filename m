From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Date: Wed, 26 Apr 2017 13:01:48 +0200
Message-ID: <6723b835-5325-f120-9b49-16209feb3611@semihalf.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-30-jean-philippe.brucker@arm.com>
 <f5745241-83b0-0945-7616-4b59d7ebcd48@semihalf.com>
 <c53478ed-20a9-414f-06ef-385c9252556f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c53478ed-20a9-414f-06ef-385c9252556f@arm.com>
Sender: kvm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Nate Watterson <nwatters@qti.qualcomm.com>
List-Id: iommu@lists.linux-foundation.org

On 26.04.2017 12:08, Jean-Philippe Brucker wrote:
> On 26/04/17 07:53, Tomasz Nowicki wrote:
>>> +        mutex_lock(&device->tasks_lock);
>>> +        list_for_each_entry(vfio_task, &device->tasks, list) {
>>> +            if (vfio_task->pasid != svm.pasid)
>>> +                continue;
>>> +
>>> +            ret = iommu_unbind_task(device->dev, svm.pasid, flags);
>>> +            if (ret)
>>> +                dev_warn(device->dev, "failed to unbind PASID %u\n",
>>> +                     vfio_task->pasid);
>>> +
>>> +            list_del(&vfio_task->list);
>>> +            kfree(vfio_task);
>>
>> Please use list_for_each_entry_safe.
>
> There is:
>
> +            break;
>
> right after kfree, so we'd never follow vfio_task->list.next after freeing
> vfio_task. The code searches for the _only_ task matching the PASID,
> removes it and leaves the loop.
>

Ah right. Sorry for the noise.

Tomasz
