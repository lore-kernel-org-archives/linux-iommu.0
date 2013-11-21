From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 1/1] IOMMU: Save pci device id instead of pci_dev* pointer
 for DMAR devices
Date: Thu, 21 Nov 2013 14:21:38 +0800
Message-ID: <528DA672.9020707@huawei.com>
References: <1383639898-48776-1-git-send-email-wangyijing@huawei.com>	 <1383639898-48776-2-git-send-email-wangyijing@huawei.com>	 <20131107180713.GA2955@google.com> <527C5D36.7050206@huawei.com>	 <CAErSpo73N2Th-4D5G8-60tMuGwqthfu-VNHVf3LF9+s2mQp53w@mail.gmail.com> <1384963192.15487.76.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1384963192.15487.76.camel@shinybook.infradead.org>
Sender: linux-pci-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Hanjun Guo <guohanjun@huawei.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
List-Id: iommu@lists.linux-foundation.org

On 2013/11/20 23:59, David Woodhouse wrote:
> On Fri, 2013-11-08 at 08:46 -0700, Bjorn Helgaas wrote:
>>
>> I don't know the IOMMU drivers well either, but it seems like they
>> rely on notifications of device addition and removal (see
>> iommu_bus_notifier()).  It doesn't seem right for them to also use t=
he
>> generic PCI interfaces like pci_get_domain_bus_and_slot() because th=
e
>> IOMMU driver should already know what devices exist and their
>> lifetimes.  It seems like confusion to mix the two.  But I don't hav=
e
>> a concrete suggestion.
>=20

Hi David,
   Thanks for your review and comment!

> The generic IOMMU code has a notifier, and calls through to an
> ->add_device() method in the specific IOMMU driver's iommu_ops.
>=20
> The Intel IOMMU driver predates that, and its scheme for mapping devi=
ces
> to the correct DMAR unit is different. It happens entirely within the
> get_domain_for_dev() function, which happens when we're first asked t=
o
> set up a mapping for a given device (when we don't already have the
> answer stashed in dev->archdata).
>=20
> I think we should add an ->add_device() method to the Intel IOMMU
> driver, and make it do much of what's in get_domain_for_dev() right n=
ow
> =E2=80=94 finding the "proxy" device (the upstream PCIe bridge or wha=
tever), and
> then looking through the ACPI DMAR table to find which DMAR unit that=
's
> attached to. Then we stash that information (dmar, devfn) in
> dev->archdata, and get_domain_for_dev() still has *some* work to do,
> actually allocating a logical domain on the IOMMU in question, but no=
t
> as much. And refcount the damn domain instead of playing the horrid
> tricks we currently do to hang it off the upstream proxy device *too*=
=2E

Intel IOMMU driver has an ->add_device() method already,   .add_device	=
=3D intel_iommu_add_device,
this method was used to update iommu group info. Since Intel IOMMU driv=
er has
its own notifier, so maybe it's a nice candidate to do something.
Currently, dmar driver parse DMAR table and find the pci device id unde=
r a specific
DRHD. But only save the device pci_dev * pointer in devices array. So i=
f this pci device
was removed, this info became stale info. In the last version patch, I =
use pci device id intead
of pci_dev * pointer array completely. This maybe introduce some unsafe=
 issues. Because
pci device maybe destroyed during process device dma mapping etc.

So, I have rework the patch and try to save pci device id as well as pc=
i_dev *pointer, like:

struct dmar_device {
   u16 segment;
   u8 bus;
   u8 devfn;  ----------->these tree will be used only when pci device =
add or remove, we will use them to update pci_dev * pointer in intel io=
mmu driver notifier.
   struct list_head list;   -->add to DRHD device list.
   struct pci_dev *pdev;   --->use to hold the pci device
}

What do you think about ?

In this new patch, we won't change the Intel iommu driver much, just en=
hance Intel driver iommu
notifier to make DRHD device list always effect, not stale info.

I will send out this new patch soon.

>=20
> My main concern here is that the DMAR table contains the PCI bus numb=
ers
> at boot time. Doing the lookup later will only work if we don't renum=
ber
> busses. Or if we have a way to look things up based on the *original*
> bus number.

If we won't remove the pci device, the occupied buses won't be change, =
I think.
And because in the new patch, we still use pci_dev *pointer to find mat=
ch DRHD, so
this is not a regression.
Since DMAR also use pci device id to identify the support device,
I have not found anything instead of device id.

In AMD IOMMU driver, it seems to use pci device id to identify drhd too=
, although
I just take a quickly glanced at it, maybe not correctly.

>=20
> The Intel IOMMU also has a bus notifier of its own which it only uses=
 to
> know when a driver is *detached*, so it can tear down the logical dom=
ain
> for the corresponding device. Would be nice to have the generic IOMMU
> notifier call a callback for us then too, perhaps.

Update the device info in Intel IOMMU driver is a good point.


Thanks!
Yijing.

>=20
>=20


--=20
Thanks!
Yijing
