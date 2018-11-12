From: <Mario.Limonciello@dell.com>
Subject: RE: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection
 support to userspace
Date: Mon, 12 Nov 2018 16:22:25 +0000
Message-ID: <d4d2488e85174cff9ab8c641336d5919@ausx13mpc120.AMER.DELL.COM>
References: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
 <20181112160628.86620-5-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112160628.86620-5-mika.westerberg@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: mika.westerberg@linux.intel.com, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com, ashok.raj@intel.com, bhelgaas@google.com, rjw@rjwysocki.net, jacob.jun.pan@intel.com, andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com, lukas@wunner.de, ckellner@redhat.com, anthony.wong@canonical.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Monday, November 12, 2018 10:06 AM
> To: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel; David Woodhouse; Lu Baolu; Ashok Raj; Bjorn Helgaas; Ra=
fael J.
> Wysocki; Jacob jun Pan; Andreas Noever; Michael Jamet; Yehezkel Bernat; L=
ukas
> Wunner; Christian Kellner; Limonciello, Mario; Anthony Wong; Mika Westerb=
erg;
> linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH 4/4] thunderbolt: Export IOMMU based DMA protection suppo=
rt
> to userspace
>=20
>=20
>=20
>=20
> Recent systems shipping with Windows 10 version 1803 or later may
> support a feature called Kernel DMA protection [1]. In practice this
> means that Thunderbolt connected devices are placed behind an IOMMU
> during the whole time it is connected (including during boot) making
> Thunderbolt security levels redundant. Some of these systems still have
> Thunderbolt security level set to "user" in order to support OS
> downgrade (the older version of the OS might not support IOMMU based DMA
> protection so connecting a device still relies on user approval then).
>=20
> Export this information to userspace by introducing a new sysfs
> attribute (iommu_dma_protection). Based on it userspace tools can make
> more accurate decision whether or not authorize the connected device.
>=20
> In addition update Thunderbolt documentation regarding IOMMU based DMA
> protection.
>=20
> [1] https://docs.microsoft.com/en-us/windows/security/information-
> protection/kernel-dma-protection-for-thunderbolt
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  .../ABI/testing/sysfs-bus-thunderbolt         |  9 ++++++++
>  Documentation/admin-guide/thunderbolt.rst     | 23 +++++++++++++++++++
>  drivers/thunderbolt/domain.c                  | 17 ++++++++++++++
>  3 files changed, 49 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> index 151584a1f950..b21fba14689b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
> +++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
> @@ -21,6 +21,15 @@ Description:	Holds a comma separated list of device
> unique_ids that
>  		If a device is authorized automatically during boot its
>  		boot attribute is set to 1.
>=20
> +What: /sys/bus/thunderbolt/devices/.../domainX/iommu_dma_protection
> +Date:		Mar 2019
> +KernelVersion:	4.21
> +Contact:	thunderbolt-software@lists.01.org
> +Description:	This attribute tells whether the system uses IOMMU
> +		for DMA protection. Value of 1 means IOMMU is used 0 means
> +		it is not (DMA protection is solely based on Thunderbolt
> +		security levels).
> +
>  What: /sys/bus/thunderbolt/devices/.../domainX/security
>  Date:		Sep 2017
>  KernelVersion:	4.13
> diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/ad=
min-
> guide/thunderbolt.rst
> index 35fccba6a9a6..ccac2596a49f 100644
> --- a/Documentation/admin-guide/thunderbolt.rst
> +++ b/Documentation/admin-guide/thunderbolt.rst
> @@ -133,6 +133,29 @@ If the user still wants to connect the device they c=
an
> either approve
>  the device without a key or write a new key and write 1 to the
>  ``authorized`` file to get the new key stored on the device NVM.
>=20
> +DMA protection utilizing IOMMU
> +------------------------------
> +Recent systems shipping with Windows 10 version 1803 or later may suppor=
t a
> +feature called `Kernel DMA Protection for Thunderbolt 3`_.  This means t=
hat

Keep in mind there will be systems that ship with Linux that enable this fe=
ature too ;)

It might be better to make it time frame and platform  firmware oriented as=
 it's
entirely possible for an OEM to have a field firmware upgrade that may enab=
le this
functionality from the platform and allow an end user to upgrade to a suffi=
ciently
protected kernel or Windows OS to take advantage of it.

> +Thunderbolt security is handled by an IOMMU so connected devices cannot
> +access memory regions outside of what is allocated for them by drivers.
> +When Linux is running on such system it automatically enables IOMMU if n=
ot
> +enabled by the user already. These systems can be identified by reading
> +``1`` from ``/sys/bus/thunderbolt/devices/domainX/iommu_dma_protection``
> +attribute.
> +
> +The driver does not do anything special in this case but because DMA
> +protection is handled by the IOMMU, security levels (if set) are
> +redundant. For this reason some systems ship with security level set to
> +``none``. Other systems have security level set to ``user`` in order to
> +support downgrade to older Windows, so users who want to automatically
> +authorize devices when IOMMU DMA protection is enabled can use the
> +following ``udev`` rule::
> +
> +  ACTION=3D=3D"add", SUBSYSTEM=3D=3D"thunderbolt",
> ATTRS{iommu_dma_protection}=3D=3D"1", ATTR{authorized}=3D=3D"0",
> ATTR{authorized}=3D"1"
> +
> +.. _Kernel DMA Protection for Thunderbolt 3: https://docs.microsoft.com/=
en-
> us/windows/security/information-protection/kernel-dma-protection-for-
> thunderbolt
> +
>  Upgrading NVM on Thunderbolt device or host
>  -------------------------------------------
>  Since most of the functionality is handled in firmware running on a
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 93e562f18d40..7416bdbd8576 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,7 +7,9 @@
>   */
>=20
>  #include <linux/device.h>
> +#include <linux/dmar.h>
>  #include <linux/idr.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -236,6 +238,20 @@ static ssize_t boot_acl_store(struct device *dev, st=
ruct
> device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(boot_acl);
>=20
> +static ssize_t iommu_dma_protection_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	/*
> +	 * Kernel DMA protection is a feature where Thunderbolt security is
> +	 * handled natively using IOMMU. It is enabled when IOMMU is
> +	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> +	 */
> +	return sprintf(buf, "%d\n",
> +		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +}
> +static DEVICE_ATTR_RO(iommu_dma_protection);
> +
>  static ssize_t security_show(struct device *dev, struct device_attribute=
 *attr,
>  			     char *buf)
>  {
> @@ -251,6 +267,7 @@ static DEVICE_ATTR_RO(security);
>=20
>  static struct attribute *domain_attrs[] =3D {
>  	&dev_attr_boot_acl.attr,
> +	&dev_attr_iommu_dma_protection.attr,
>  	&dev_attr_security.attr,
>  	NULL,
>  };
> --
> 2.19.1
