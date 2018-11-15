From: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v4 6/8] vfio/mdev: Add iommu place holders in mdev_device
Date: Fri, 16 Nov 2018 03:01:01 +0530
Message-ID: <7bfc2f2b-10e6-b53c-51f3-c6494b686aa3@nvidia.com>
References: <20181105073408.21815-1-baolu.lu@linux.intel.com>
 <20181105073408.21815-7-baolu.lu@linux.intel.com>
 <20181106165356.44b59ec3@w520.home>
 <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edadb198-e4ab-ac23-4520-28bfcac252c3@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, Alex Williamson <alex.williamson@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org



On 11/7/2018 7:18 AM, Lu Baolu wrote:
> Hi Alex,
>=20
> On 11/7/18 7:53 AM, Alex Williamson wrote:
>> On Mon,=C2=A0 5 Nov 2018 15:34:06 +0800
>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>>> A parent device might create different types of mediated
>>> devices. For example, a mediated device could be created
>>> by the parent device with full isolation and protection
>>> provided by the IOMMU. One usage case could be found on
>>> Intel platforms where a mediated device is an assignable
>>> subset of a PCI, the DMA requests on behalf of it are all
>>> tagged with a PASID. Since IOMMU supports PASID-granular
>>> translations (scalable mode in vt-d 3.0), this mediated
>>> device could be individually protected and isolated by an
>>> IOMMU.
>>>
>>> This patch adds two new members in struct mdev_device:
>>> * iommu_device
>>> =C2=A0=C2=A0 - This, if set, indicates that the mediated device could
>>> =C2=A0=C2=A0=C2=A0=C2=A0 be fully isolated and protected by IOMMU via a=
ttaching
>>> =C2=A0=C2=A0=C2=A0=C2=A0 an iommu domain to this device. If empty, it i=
ndicates
>>> =C2=A0=C2=A0=C2=A0=C2=A0 using vendor defined isolation.
>>>
>>> * iommu_domain
>>> =C2=A0=C2=A0 - This is a place holder for an iommu domain. A domain
>>> =C2=A0=C2=A0=C2=A0=C2=A0 could be store here for later use once it has =
been
>>> =C2=A0=C2=A0=C2=A0=C2=A0 attached to the iommu_device of this mdev.
>>>
>>> Below helpers are added to set and get above iommu device
>>> and iommu domain pointers.
>>>
>>> * mdev_set/get_iommu_device(dev, iommu_device)
>>> =C2=A0=C2=A0 - Set or get the iommu device which represents this mdev
>>> =C2=A0=C2=A0=C2=A0=C2=A0 in IOMMU's device scope. Drivers don't need to=
 set the
>>> =C2=A0=C2=A0=C2=A0=C2=A0 iommu device if it uses vendor defined isolati=
on.
>>>
>>> * mdev_set/get_iommu_domain(domain)
>>> =C2=A0=C2=A0 - A iommu domain which has been attached to the iommu
>>> =C2=A0=C2=A0=C2=A0=C2=A0 device in order to protect and isolate the med=
iated
>>> =C2=A0=C2=A0=C2=A0=C2=A0 device will be kept in the mdev data structure=
 and
>>> =C2=A0=C2=A0=C2=A0=C2=A0 could be retrieved later.
>>>
>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> Cc: Liu Yi L <yi.l.liu@intel.com>
>>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>> =C2=A0 drivers/vfio/mdev/mdev_core.c=C2=A0=C2=A0=C2=A0 | 36 +++++++++++=
+++++++++++++++++++++
>>> =C2=A0 drivers/vfio/mdev/mdev_private.h |=C2=A0 2 ++
>>> =C2=A0 include/linux/mdev.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 23 ++++++++++++++++++++
>>> =C2=A0 3 files changed, 61 insertions(+)
>>>
>>> diff --git a/drivers/vfio/mdev/mdev_core.c
>>> b/drivers/vfio/mdev/mdev_core.c
>>> index 0212f0ee8aea..5119809225c5 100644
>>> --- a/drivers/vfio/mdev/mdev_core.c
>>> +++ b/drivers/vfio/mdev/mdev_core.c
>>> @@ -390,6 +390,42 @@ int mdev_device_remove(struct device *dev, bool
>>> force_remove)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0 }
>>> =C2=A0 +int mdev_set_iommu_device(struct device *dev, struct device
>>> *iommu_device)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct mdev_device *mdev =3D to_mdev_device(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mdev->iommu_device =3D iommu_device;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +EXPORT_SYMBOL(mdev_set_iommu_device);
>>> +
>>> +struct device *mdev_get_iommu_device(struct device *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct mdev_device *mdev =3D to_mdev_device(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return mdev->iommu_device;
>>> +}
>>> +EXPORT_SYMBOL(mdev_get_iommu_device);
>>> +
>>> +int mdev_set_iommu_domain(struct device *dev, void *domain)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct mdev_device *mdev =3D to_mdev_device(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 mdev->iommu_domain =3D domain;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +EXPORT_SYMBOL(mdev_set_iommu_domain);
>>> +
>>> +void *mdev_get_iommu_domain(struct device *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct mdev_device *mdev =3D to_mdev_device(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return mdev->iommu_domain;
>>> +}
>>> +EXPORT_SYMBOL(mdev_get_iommu_domain);
>>> +
>>> =C2=A0 static int __init mdev_init(void)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mdev_bus_register();
>>> diff --git a/drivers/vfio/mdev/mdev_private.h
>>> b/drivers/vfio/mdev/mdev_private.h
>>> index b5819b7d7ef7..c01518068e84 100644
>>> --- a/drivers/vfio/mdev/mdev_private.h
>>> +++ b/drivers/vfio/mdev/mdev_private.h
>>> @@ -34,6 +34,8 @@ struct mdev_device {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head next;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct kobject *type_kobj;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool active;
>>> +=C2=A0=C2=A0=C2=A0 struct device *iommu_device;
>>> +=C2=A0=C2=A0=C2=A0 void *iommu_domain;
>>> =C2=A0 };
>>> =C2=A0 =C2=A0 #define to_mdev_device(dev)=C2=A0=C2=A0=C2=A0 container_o=
f(dev, struct
>>> mdev_device, dev)
>>> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
>>> index b6e048e1045f..c46777d3e568 100644
>>> --- a/include/linux/mdev.h
>>> +++ b/include/linux/mdev.h
>>> @@ -14,6 +14,29 @@
>>> =C2=A0 #define MDEV_H
>>> =C2=A0 =C2=A0 struct mdev_device;
>>> +struct iommu_domain;
>>> +
>>> +/*
>>> + * Called by the parent device driver to set the PCI device which
>>> represents
>>
>> s/PCI //
>>
>> There is no requirement or expectation that the device is PCI.
>>
>=20
> Fair enough.
>=20
>>> + * this mdev in iommu protection scope. By default, the iommu device
>>> is NULL,
>>> + * that indicates using vendor defined isolation.
>>> + *
>>> + * @dev: the mediated device that iommu will isolate.
>>> + * @iommu_device: a pci device which represents the iommu for @dev.
>>> + *
>>> + * Return 0 for success, otherwise negative error value.
>>> + */
>>> +int mdev_set_iommu_device(struct device *dev, struct device
>>> *iommu_device);
>>> +
>>> +struct device *mdev_get_iommu_device(struct device *dev);
>>> +
>>> +/*
>>> + * Called by vfio iommu modules to save the iommu domain after a
>>> domain being
>>> + * attached to the mediated device.
>>> + */
>>> +int mdev_set_iommu_domain(struct device *dev, void *domain);
>>> +
>>> +void *mdev_get_iommu_domain(struct device *dev);
>>
>> I can't say I really understand the purpose of this, the cover letter
>> indicates this is a placeholder, should we add it separately when we
>> have a requirement for it?
>=20
> Oh, I am sorry that I used a wrong word. It's not a placeholder for
> something designed for future, but adding two members that will be used
> in the following patches. Since they will be used in anther modules
> (like vfio_iommu), we need function interfaces to get and set them.
>=20
> mdev->iommu_device:
> =C2=A0-=C2=A0 This, if set, indicates that the mediated device could
> =C2=A0=C2=A0=C2=A0 be fully isolated and protected by IOMMU via attaching
> =C2=A0=C2=A0=C2=A0 an iommu domain to this device. If empty, it indicates
> =C2=A0=C2=A0=C2=A0 using vendor defined isolation.
>=20
> mdev->iommu_domain:
> =C2=A0 - This is used to save the pointer of an iommu domain. Once
> =C2=A0=C2=A0=C2=A0 a domain has been attached to the iommu_device, it sho=
uld
> =C2=A0=C2=A0=C2=A0 be stored here.
>=20

I don't see mdev->iommu_domain is used anywhere in this series of patch.
If this is not being used, then no need to save it. With that symbols
mdev_set/get_iommu_domain(domain) are not required.

Please keep symbols mdev_set/get_iommu_device(dev, iommu_device) non-GPL
same as other exported symbols from mdev_core module.

Thanks,
Kirti
