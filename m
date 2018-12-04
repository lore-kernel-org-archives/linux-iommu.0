From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v4 0/8] vfio/mdev: IOMMU aware mediated device
Date: Tue, 4 Dec 2018 14:20:02 +0800
Message-ID: <9a1d0b6f-7363-495d-2f4b-5a1693fb3fd9@linux.intel.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
	<5C05F87D.4050206@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5C05F87D.4050206-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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

On 12/4/18 11:46 AM, Xu Zaibo wrote:
> Hi,
> =

> Is this solution trying to support general user space processes who are =

> directly working on devices?

Yes, it is.

> =

> Thanks,
> Zaibo

Best regards,
Lu Baolu

> =

> .
> =

> On 2018/11/5 15:34, Lu Baolu wrote:
>> Hi,
>>
>> The Mediate Device is a framework for fine-grained physical device
>> sharing across the isolated domains. Currently the mdev framework
>> is designed to be independent of the platform IOMMU support. As the
>> result, the DMA isolation relies on the mdev parent device in a
>> vendor specific way.
>>
>> There are several cases where a mediated device could be protected
>> and isolated by the platform IOMMU. For example, Intel vt-d rev3.0
>> [1] introduces a new translation mode called 'scalable mode', which
>> enables PASID-granular translations. The vt-d scalable mode is the
>> key ingredient for Scalable I/O Virtualization [2] [3] which allows
>> sharing a device in minimal possible granularity (ADI - Assignable
>> Device Interface).
>>
>> A mediated device backed by an ADI could be protected and isolated
>> by the IOMMU since 1) the parent device supports tagging an unique
>> PASID to all DMA traffic out of the mediated device; and 2) the DMA
>> translation unit (IOMMU) supports the PASID granular translation.
>> We can apply IOMMU protection and isolation to this kind of devices
>> just as what we are doing with an assignable PCI device.
>>
>> In order to distinguish the IOMMU-capable mediated devices from those
>> which still need to rely on parent devices, this patch set adds two
>> new members in struct mdev_device.
>>
>> * iommu_device
>> =A0=A0 - This, if set, indicates that the mediated device could
>> =A0=A0=A0=A0 be fully isolated and protected by IOMMU via attaching
>> =A0=A0=A0=A0 an iommu domain to this device. If empty, it indicates
>> =A0=A0=A0=A0 using vendor defined isolation.
>>
>> * iommu_domain
>> =A0=A0 - This is a place holder for an iommu domain. A domain
>> =A0=A0=A0=A0 could be store here for later use once it has been
>> =A0=A0=A0=A0 attached to the iommu_device of this mdev.
>>
>> Below helpers are added to set and get above iommu device
>> and iommu domain pointers in mdev core implementation.
>>
>> * mdev_set/get_iommu_device(dev, iommu_device)
>> =A0=A0 - Set or get the iommu device which represents this mdev
>> =A0=A0=A0=A0 in IOMMU's device scope. Drivers don't need to set the
>> =A0=A0=A0=A0 iommu device if it uses vendor defined isolation.
>>
>> * mdev_set/get_iommu_domain(domain)
>> =A0=A0 - A iommu domain which has been attached to the iommu
>> =A0=A0=A0=A0 device in order to protect and isolate the mediated
>> =A0=A0=A0=A0 device will be kept in the mdev data structure and
>> =A0=A0=A0=A0 could be retrieved later.
>>
>> The mdev parent device driver could opt-in that the mdev could be
>> fully isolated and protected by the IOMMU when the mdev is being
>> created by invoking mdev_set_iommu_device() in its @create().
>>
>> In the vfio_iommu_type1_attach_group(), a domain allocated through
>> iommu_domain_alloc() will be attached to the mdev iommu device if
>> an iommu device has been set. Otherwise, the dummy external domain
>> will be used and all the DMA isolation and protection are routed to
>> parent driver as the result.
>>
>> On IOMMU side, a basic requirement is allowing to attach multiple
>> domains to a PCI device if the device advertises the capability
>> and the IOMMU hardware supports finer granularity translations than
>> the normal PCI Source ID based translation.
>>
>> As the result, a PCI device could work in two modes: normal mode
>> and auxiliary mode. In the normal mode, a pci device could be
>> isolated in the Source ID granularity; the pci device itself could
>> be assigned to a user application by attaching a single domain
>> to it. In the auxiliary mode, a pci device could be isolated in
>> finer granularity, hence subsets of the device could be assigned
>> to different user level application by attaching a different domain
>> to each subset.
>>
>> The device driver is able to switch between above two modes with
>> below interfaces:
>>
>> * iommu_get_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_CAPABILITY)
>> =A0=A0 - Represents the ability of supporting multiple domains
>> =A0=A0=A0=A0 per device.
>>
>> * iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLE)
>> =A0=A0 - Enable the multiple domains capability for the device
>> =A0=A0=A0=A0 referenced by @dev.
>>
>> * iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_DISABLE)
>> =A0=A0 - Disable the multiple domains capability for the device
>> =A0=A0=A0=A0 referenced by @dev.
>>
>> * iommu_domain_get_attr(domain, DOMAIN_ATTR_AUXD_ID)
>> =A0=A0 - Return ID used for finer-granularity DMA translation.
>>
>> * iommu_attach_device_aux(domain, dev)
>> =A0=A0 - Attach a domain to the device in the auxiliary mode.
>>
>> * iommu_detach_device_aux(domain, dev)
>> =A0=A0 - Detach the aux domain from device.
>>
>> In order for the ease of discussion, sometimes we call "a domain in
>> auxiliary mode' or simply 'an auxiliary domain' when a domain is
>> attached to a device for finer granularity translations. But we need
>> to keep in mind that this doesn't mean there is a differnt domain
>> type. A same domain could be bound to a device for Source ID based
>> translation, and bound to another device for finer granularity
>> translation at the same time.
>>
>> This patch series extends both IOMMU and vfio components to support
>> mdev device passing through when it could be isolated and protected
>> by the IOMMU units. The first part of this series (PATCH 1/08~5/08)
>> adds the interfaces and implementation of the multiple domains per
>> device. The second part (PATCH 6/08~8/08) adds the iommu device
>> attribute to each mdev, determines isolation type according to the
>> existence of an iommu device when attaching group in vfio type1 iommu
>> module, and attaches the domain to iommu aware mediated devices.
>>
>> This patch series depends on a patch set posted here [4] for discussion
>> which added scalable mode support in Intel IOMMU driver.
>>
>> References:
>> [1] =

>> https://software.intel.com/en-us/download/intel-virtualization-technolog=
y-for-directed-io-architecture-specification =

>>
>> [2] =

>> https://software.intel.com/en-us/download/intel-scalable-io-virtualizati=
on-technical-specification =

>>
>> [3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf
>> [4] https://lkml.org/lkml/2018/11/5/136
>>
>> Best regards,
>> Lu Baolu
>>
>> Change log:
>> =A0=A0 v3->v4:
>> =A0=A0 - Use aux domain specific interfaces for domain attach and detach.
>> =A0=A0 - Rebase all patches to 4.20-rc1.
>>
>> =A0=A0 v2->v3:
>> =A0=A0 - Remove domain type enum and use a pointer on mdev_device instea=
d.
>> =A0=A0 - Add a generic interface for getting/setting per device iommu
>> =A0=A0=A0=A0 attributions. And use it for query aux domain capability, e=
nable
>> =A0=A0=A0=A0 aux domain and disable aux domain purpose.
>> =A0=A0 - Reuse iommu_domain_get_attr() to retrieve the id in a aux domai=
n.
>> =A0=A0 - We discussed the impact of the default domain implementation
>> =A0=A0=A0=A0 on reusing iommu_at(de)tach_device() interfaces. We agreed
>> =A0=A0=A0=A0 that reusing iommu_at(de)tach_device() interfaces is the ri=
ght
>> =A0=A0=A0=A0 direction and we could tweak the code to remove the impact.
>> =A0=A0=A0=A0 https://www.spinics.net/lists/kvm/msg175285.html
>> =A0=A0 - Removed the RFC tag since no objections received.
>> =A0=A0 - This patch has been submitted separately.
>> =A0=A0=A0=A0 https://www.spinics.net/lists/kvm/msg173936.html
>>
>> =A0=A0 v1->v2:
>> =A0=A0 - Rewrite the patches with the concept of auxiliary domains.
>>
>> Lu Baolu (8):
>> =A0=A0 iommu: Add APIs for multiple domains per device
>> =A0=A0 iommu/vt-d: Add multiple domains per device query
>> =A0=A0 iommu/vt-d: Enable/disable multiple domains per device
>> =A0=A0 iommu/vt-d: Attach/detach domains in auxiliary mode
>> =A0=A0 iommu/vt-d: Return ID associated with an auxiliary domain
>> =A0=A0 vfio/mdev: Add iommu place holders in mdev_device
>> =A0=A0 vfio/type1: Add domain at(de)taching group helpers
>> =A0=A0 vfio/type1: Handle different mdev isolation type
>>
>> =A0 drivers/iommu/intel-iommu.c=A0=A0=A0=A0=A0 | 315 +++++++++++++++++++=
+++++++++---
>> =A0 drivers/iommu/iommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 52 +++++
>> =A0 drivers/vfio/mdev/mdev_core.c=A0=A0=A0 |=A0 36 ++++
>> =A0 drivers/vfio/mdev/mdev_private.h |=A0=A0 2 +
>> =A0 drivers/vfio/vfio_iommu_type1.c=A0 | 162 ++++++++++++++--
>> =A0 include/linux/intel-iommu.h=A0=A0=A0=A0=A0 |=A0 11 ++
>> =A0 include/linux/iommu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 52 +++++
>> =A0 include/linux/mdev.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 23 +++
>> =A0 8 files changed, 618 insertions(+), 35 deletions(-)
>>
> =

> =

> =
