From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 02/40] iommu/sva: Bind process address spaces to devices
Date: Thu, 6 Sep 2018 12:09:42 +0100
Message-ID: <fbe7615d-2236-8080-c54f-f53da8118f93@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-3-jean-philippe.brucker@arm.com>
	<471873d4-a1a6-1a3a-cf17-1e686b4ade96@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <471873d4-a1a6-1a3a-cf17-1e686b4ade96-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/09/2018 12:29, Auger Eric wrote:
>> +/**
>> + * iommu_sva_bind_device() - Bind a process address space to a device
>> + * @dev: the device
>> + * @mm: the mm to bind, caller must hold a reference to it
>> + * @pasid: valid address where the PASID will be stored
>> + * @flags: bond properties
>> + * @drvdata: private data passed to the mm exit handler
>> + *
>> + * Create a bond between device and task, allowing the device to access the mm
>> + * using the returned PASID. If unbind() isn't called first, a subsequent bind()
>> + * for the same device and mm fails with -EEXIST.
>> + *
>> + * iommu_sva_device_init() must be called first, to initialize the required SVA
>> + * features. @flags is a subset of these features.
> @flags must be a subset of these features?

Ok

> don't you want to check flags is a subset of
> dev->iommu_param->sva_param->features?

Yes, that will be in next version

>> +/**
>> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
>> + * @dev: the device
>> + * @pasid: the pasid returned by bind()
>> + *
>> + * Remove bond between device and address space identified by @pasid. Users
>> + * should not call unbind() if the corresponding mm exited (as the PASID might
>> + * have been reallocated for another process).
>> + *
>> + * The device must not be issuing any more transaction for this PASID. All
>> + * outstanding page requests for this PASID must have been flushed to the IOMMU.
>> + *
>> + * Returns 0 on success, or an error value
>> + */
>> +int iommu_sva_unbind_device(struct device *dev, int pasid)
> returned value needed?

I'd rather keep this one, since it already pointed out some of my bugs
during regression testing.

Thanks,
Jean
