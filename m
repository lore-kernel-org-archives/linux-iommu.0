From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
Date: Tue, 29 May 2018 12:55:49 +0100
Message-ID: <99ff4f89-86ef-a251-894c-8aa8a47d2a69@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-14-jean-philippe.brucker@arm.com>
	<5B0536A3.1000304@huawei.com>
	<cd13f60d-b282-3804-4ca7-2d34476c597f@arm.com>
	<5B06B17C.1090809@huawei.com>
	<205c1729-8026-3efe-c363-d37d7150d622@arm.com>
	<5B077765.30703@huawei.com>
	<fea420ff-e738-e2ed-ab1e-a3f4dde4b6ef@arm.com>
	<5B08DA21.3070507@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5B08DA21.3070507-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Xu Zaibo <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>
Cc: "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

(If possible, please reply in plain text to the list. Reading this in a
text-only reader is confusing, because all quotes have the same level)

On 26/05/18 04:53, Xu Zaibo wrote:
> I guess there may be some misunderstandings :).
> 
> From the current patches, 'iommu_sva_device_shutdown' is called by 'vfio_iommu_sva_shutdown', which
> is mainly used by 'vfio_iommu_type1_detach_group' that is finally called by processes' release of vfio facilitiy
> automatically or called by 'VFIO_GROUP_UNSET_CONTAINER' manually in the processes.
> 
> So, just image that 2 processes is working on the device with IOPF feature, and the 2 do the following to enable SVA:
> 
>     1.open("/dev/vfio/vfio") ;
> 
>    2.open the group of the devcie by calling open("/dev/vfio/x"), but now,
>      I think the second processes will fail to open the group because current VFIO thinks that one group only can be used by one process/vm,
>      at present, I use mediated device to create more groups on the parent device to support multiple processes;
> 
>     3.VFIO_GROUP_SET_CONTAINER;
> 
>     4.VFIO_SET_IOMMU;
> 
>     5.VFIO_IOMMU_BIND;

I have a concern regarding your driver. With mdev you can't allow
processes to program the PASID themselves, since the parent device has a
single PASID table. You lose all isolation since processes could write
any value in the PASID field and access address spaces of other
processes bound to this parent device (even if the BIND call was for
other mdevs).

The wrap driver has to mediate calls to bind(), and either program the
PASID into the device itself, or at least check that, when receiving a
SET_PASID ioctl from a process, the given PASID was actually allocated
to the process.

>     6.Do some works with the hardware working unit filled by PASID on the device;
> 
>    7.VFIO_IOMMU_UNBIND;
> 
>     8.VFIO_GROUP_UNSET_CONTAINER;---here, have to sleep to wait another process to finish works of the step 6;
> 
>     9. close(group); close(containner);
> 
> 
> So, my idea is: If it is possible to just release the params or facilities that only belong to the current process while the process shutdown the device,
> and while the last process releases them all. Then, as in the above step 8, we
> don't need to wait, or maybe wait for a very long time if the other process is doing lots of work on the device.
Given that you need to notify the mediating driver of IOMMU_BIND calls
as explained above, you could do something similar for shutdown: from
the mdev driver, call iommu_sva_shutdown_device() only for the last mdev.

Thanks,
Jean
