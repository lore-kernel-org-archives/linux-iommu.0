From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Date: Fri, 22 Mar 2019 10:05:07 +0000
Message-ID: <0359F732-374F-4EDB-B49C-14B2F1BB637D@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
 <94706334-3DE4-4964-8FDD-125C58D493A0@arista.com>
 <418d1432-2036-3f6f-48de-77005807e350@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <418d1432-2036-3f6f-48de-77005807e350@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 20 Mar 2019, at 01:26, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/19/19 9:35 PM, James Sewart wrote:
>> Hey Lu,
>>> On 15 Mar 2019, at 03:13, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>=20
>>> Hi James,
>>>=20
>>> On 3/14/19 7:56 PM, James Sewart wrote:
>>>> Patches 1 and 2 are the same as v1.
>>>> v1-v2:
>>>>   Refactored ISA direct mappings to be returned by =
iommu_get_resv_regions.
>>>>   Integrated patch by Lu to defer turning on DMAR until iommu.c has =
mapped
>>>> reserved regions.
>>>>   Integrated patches by Lu to remove more unused code in cleanup.
>>>> Lu: I didn't integrate your patch to set the default domain type as =
it
>>>> isn't directly related to the aim of this patchset. Instead patch 4
>>>=20
>>> Without those patches, user experience will be affected and some =
devices
>>> will not work on Intel platforms anymore.
>>>=20
>>> For a long time, Intel IOMMU driver has its own logic to determine
>>> whether a device requires an identity domain. For example, when user
>>> specifies "iommu=3Dpt" in kernel parameter, all device will be =
attached
>>> with the identity domain. Further more, some quirky devices require
>>> an identity domain to be used before enabling DMA remapping, =
otherwise,
>>> it will not work. This was done by adding quirk bits in Intel IOMMU
>>> driver.
>>>=20
>>> So from my point of view, one way is porting all those quirks and =
kernel
>>> parameters into IOMMU generic layer, or opening a door for vendor =
IOMMU
>>> driver to determine the default domain type by their own. I prefer =
the
>>> latter option since it will not impact any behaviors on other
>>> architectures.
>> I see your point. I=E2=80=99m not confident that using the proposed =
door to set a
>> groups default domain has the desired behaviour. As discussed before =
the
>> default domain type will be set based on the desired type for only =
the
>> first device attached to a group. I think to change the default =
domain
>> type you would need a slightly different door that wasn=E2=80=99t =
conditioned on
>> device.
>=20
> I think this as another problem. Just a summarize for the ease of
> discussion. We saw two problems:
>=20
> 1. When allocating a new group for a device, how should we determine =
the
> type of the default domain? This is what my proposal patches trying to
> address.

This will work as expected only if all devices within a group get the =
same=20
result from is_identity_map. Otherwise wee see issue 2.

>=20
> 2. If we need to put a device into an existing group which uses a
> different type of domain from what the device desires to use, we might
> break the functionality of the device. For this problem I'd second =
your
> proposal below if I get your point correctly.
>=20
>> For situations where individual devices require an identity domain =
because
>> of quirks then maybe calling is_identity_map per device in
>> iommu_group_get_for_dev is a better solution than the one I proposed.
>=20
> Do you mean if we see a quirky device requires a different domain type
> other than the default domain type of the group, we will assign a new
> group to it? That looks good to me as far as I can see. I suppose this
> should be done in vt-d's ops callback.

I have thought about this a bit and I think the cleanest approach is to=20=

put devices that require an identity domain into their own group, this =
can=20
be done in the device_group callback, avoiding any situation where we =
have=20
to deal with creating a new group based on domain type in=20
iommu_group_get_for_dev. This way we shouldn=E2=80=99t ever be in a =
situation with=20
multiple different domain types per group. This way your patches will =
work=20
as expected. See below for a possible implementation.

>=20
> Best regards,
> Lu Baolu

Cheers,
James.

Devices that require an identity map because of quirks or other reasons
should be put in their own IOMMU group so as to not end up with multiple
different domains per group.

Signed-off-by: James Sewart <jamessewart@arista.com>

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 3cb8b36abf50..0f5a121d31a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5421,6 +5421,22 @@ struct intel_iommu =
*intel_svm_device_to_iommu(struct device *dev)
 }
 #endif /* CONFIG_INTEL_IOMMU_SVM */

+static struct iommu_group *intel_identity_group;
+
+struct iommu_group *intel_iommu_pci_device_group(struct device *dev)
+{
+       if (iommu_no_mapping(dev)) {
+               if (!intel_identity_group) {
+                       intel_identity_group =3D iommu_group_alloc();
+                       if (IS_ERR(intel_identity_group))
+                               return NULL;
+               }
+               return intel_identity_group;
+       }
+
+       return pci_device_group(dev);
+}
+
 const struct iommu_ops intel_iommu_ops =3D {
        .capable                =3D intel_iommu_capable,
        .domain_alloc           =3D intel_iommu_domain_alloc,
@@ -5435,7 +5451,7 @@ const struct iommu_ops intel_iommu_ops =3D {
        .get_resv_regions       =3D intel_iommu_get_resv_regions,
        .put_resv_regions       =3D intel_iommu_put_resv_regions,
        .apply_resv_region      =3D intel_iommu_apply_resv_region,
-       .device_group           =3D pci_device_group,
+       .device_group           =3D intel_iommu_pci_device_group,
        .pgsize_bitmap          =3D INTEL_IOMMU_PGSIZES,
 };

--=20
2.17.1
