From: Xu Zaibo <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
Date: Thu, 6 Sep 2018 15:26:40 +0800
Message-ID: <5B90D6B0.300@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-14-jean-philippe.brucker@arm.com>
	<5B83B11E.7010807@huawei.com>
	<1d5b6529-4e5a-723c-3f1b-dd5a9adb490c@arm.com>
	<5B89F818.7060300@huawei.com>
	<3a961aff-e830-64bb-b6a9-14e08de1abf5@arm.com>
	<5B8DEA15.7020404@huawei.com>
	<bc27f902-4d12-21b7-b9e9-18bcae170503@arm.com>
	<5B8F4A59.20004@huawei.com>
	<b51107b8-a525-13ce-f4c3-d423b8502c27@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b51107b8-a525-13ce-f4c3-d423b8502c27-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org" <linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org>
Cc: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <liguozhu-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, fanghao11 <fanghao11-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?B?57Gz57Gz?= <kenneth-lee-2012-H32Fclmsjq1BDgjK7y7TUQ@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


On 2018/9/5 19:02, Jean-Philippe Brucker wrote:
> On 05/09/2018 04:15, Xu Zaibo wrote:
>>>>        1. While the series are finished well, VFIO-PCI device can be held
>>>> by only one process
>>>>            through binding IOCTL command without PASID (without PASID
>>>> being exposed user space).
>>> It could, but isn't supported at the moment. In addition to adding
>>> support in the I/O page fault code, we'd also need to update the VFIO
>>> API. Currently a VFIO_TYPE1 domain always supports the MAP/UNMAP ioctl.
>>> The case you describe isn't compatible with MAP/UNMAP, since the process
>>> manages the shared address space with mmap or malloc. We'd probably need
>>> to introduce a new VFIO IOMMU type, in which case the bind could be
>>> performed implicitly when the process does VFIO_SET_IOMMU. Then the
>>> process wouldn't need to send an additional BIND IOCTL.
>> ok. got it.  This is the legacy mode, so all the VFIO APIs are kept
>> unchanged?
> Yes, existing VFIO semantics are preserved
>
>>>>        2. While using VFIO-PCI device to support multiple processes with
>>>> SVA series, a primary
>>>>            process with multiple secondary processes must be deployed just
>>>> like DPDK(https://www.dpdk.org/).
>>>>            And, the PASID still has to be exposed to user land.
>>> Right. A third case, also implemented by this patch (and complete), is
>>> the primary process simply doing a BIND for itself, and using the
>>> returned PASID to share its own address space with the device.
>>>
>> ok. But I am worried that the sulotion of one primary processes with
>> several secondary ones
>>
>> is a little bit limited. Maybe, users don't want to depend on the
>> primary process. :)
> I don't see a better way for vfio-pci, though. But more importantly, I
> don't know of any users :) While the feature is great for testing new
> hardware, and I've been using it for all kinds of stress testing, I
> haven't received feedback from possible users in production settings
> (DPDK etc) and can't speculate about what they'd prefer.
>
At present, It seems no other way existing while being compatible with 
current logic.
Thank you.

Thanks,
Zaibo
