From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v3 0/8] vfio/mdev: IOMMU aware mediated device
Date: Tue, 16 Oct 2018 09:21:52 +0800
Message-ID: <40fc685e-a0be-5e54-2de7-6cd87c36dd80@linux.intel.com>
References: <20181012051632.26064-1-baolu.lu@linux.intel.com>
	<5BC1AC09.1060507@huawei.com>
	<f3ffd1a3-be4b-f041-e4da-2bbf065aa065@linux.intel.com>
	<5BC454DF.6010109@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5BC454DF.6010109-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Xu Zaibo <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 10/15/2018 04:50 PM, Xu Zaibo wrote:
> Hi,
> =

> On 2018/10/15 10:48, Lu Baolu wrote:
>> Hi,
>>
>> On 10/13/2018 04:25 PM, Xu Zaibo wrote:
>>> Hi,
>>>
>>> On 2018/10/12 13:16, Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> The Mediate Device is a framework for fine-grained physical device
>>>> sharing across the isolated domains. Currently the mdev framework
>>>> is designed to be independent of the platform IOMMU support. As the
>>>> result, the DMA isolation relies on the mdev parent device in a
>>>> vendor specific way.
>>>>
>>>> There are several cases where a mediated device could be protected
>>>> and isolated by the platform IOMMU. For example, Intel vt-d rev3.0
>>>> [1] introduces a new translation mode called 'scalable mode', which
>>>> enables PASID-granular translations. The vt-d scalable mode is the
>>>> key ingredient for Scalable I/O Virtualization [2] [3] which allows
>>>> sharing a device in minimal possible granularity (ADI - Assignable
>>>> Device Interface).
>>>>
>>>> A mediated device backed by an ADI could be protected and isolated
>>>> by the IOMMU since 1) the parent device supports tagging an unique
>>>> PASID to all DMA traffic out of the mediated device; and 2) the DMA
>>>> translation unit (IOMMU) supports the PASID granular translation.
>>>> We can apply IOMMU protection and isolation to this kind of devices
>>>> just as what we are doing with an assignable PCI device.
>>>>
>>>> In order to distinguish the IOMMU-capable mediated devices from those
>>>> which still need to rely on parent devices, this patch set adds two
>>>> new members in struct mdev_device.
>>>>
>>>> * iommu_device
>>>> =A0=A0 - This, if set, indicates that the mediated device could
>>>> =A0=A0=A0=A0 be fully isolated and protected by IOMMU via attaching
>>>> =A0=A0=A0=A0 an iommu domain to this device. If empty, it indicates
>>>> =A0=A0=A0=A0 using vendor defined isolation.
>>>>
>>>> * iommu_domain
>>>> =A0=A0 - This is a place holder for an iommu domain. A domain
>>>> =A0=A0=A0=A0 could be store here for later use once it has been
>>>> =A0=A0=A0=A0 attached to the iommu_device of this mdev.
>>>>
>>>> Below helpers are added to set and get above iommu device
>>>> and iommu domain pointers in mdev core implementation.
>>>>
>>>> * mdev_set/get_iommu_device(dev, iommu_device)
>>>> =A0=A0 - Set or get the iommu device which represents this mdev
>>>> =A0=A0=A0=A0 in IOMMU's device scope. Drivers don't need to set the
>>>> =A0=A0=A0=A0 iommu device if it uses vendor defined isolation.
>>>>
>>>> * mdev_set/get_iommu_domain(domain)
>>>> =A0=A0 - A iommu domain which has been attached to the iommu
>>>> =A0=A0=A0=A0 device in order to protect and isolate the mediated
>>>> =A0=A0=A0=A0 device will be kept in the mdev data structure and
>>>> =A0=A0=A0=A0 could be retrieved later.
>>>>
>>>> The mdev parent device driver could opt-in that the mdev could be
>>>> fully isolated and protected by the IOMMU when the mdev is being
>>>> created by invoking mdev_set_iommu_device() in its @create().
>>> I just cannot understand here, how to get an iommu_device while I =

>>> create mediated
>>> device in my parent device driver?
>>
>> When you are creating an mdev in your parent driver, you should know
>> which PCI device this mdev belonging to.
>>
> =

> So, generally, I can set the parent device as mdev's iommu_device?
> If that, however, Mdev already holds its parent device. So, I just =

> figure what
> differences between Mdev's parent device and iommu_device are.
>>>
>>> And why not reuse the device of MDEV instread of adding a new device =

>>> here?
>>
>> iommu_device in the mdev_device structure represents the PCI device
>> that represents this mdev in iommu's device scope. IOMMU is only aware
>> of pci devices, it's not aware of mdev device.
> =

> Could I understand like that: IOMMU can be aware of the parent device of =

> Mdev?
> And more, I am doubting the necessary of iommu_device in Mdev.
> =


The "mdev parent device" and "mdev iommu device" are different although
they might be the same in practice. "mdev parent device" represents the
device who created the mdev. "mdev iommu device" represents the device
who shares the device context entry in iommu tables.

"mdev iommu device" is always a PCI/PCIe device since IOMMU always use
source id (bus:dev:func) to walk the device context table. But there is
no limitation on who can create an mdev, right?

Best regards,
Lu Baolu
