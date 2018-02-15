From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
Date: Thu, 15 Feb 2018 12:40:57 +0000
Message-ID: <ca4d4992-0c8b-dae6-e443-7c7f7164be60@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-3-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
	<b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191003AD6@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D191003AD6-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mykyta.iziumtsev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <mykyta.iziumtsev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 13/02/18 23:34, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Tuesday, February 13, 2018 8:57 PM
>>
>> On 13/02/18 07:54, Tian, Kevin wrote:
>>>> From: Jean-Philippe Brucker
>>>> Sent: Tuesday, February 13, 2018 2:33 AM
>>>>
>>>> Add bind() and unbind() operations to the IOMMU API. Device drivers
>> can
>>>> use them to share process page tables with their devices. bind_group()
>>>> is provided for VFIO's convenience, as it needs to provide a coherent
>>>> interface on containers. Other device drivers will most likely want to
>>>> use bind_device(), which binds a single device in the group.
>>>
>>> I saw your bind_group implementation tries to bind the address space
>>> for all devices within a group, which IMO has some problem. Based on
>> PCIe
>>> spec, packet routing on the bus doesn't take PASID into consideration.
>>> since devices within same group cannot be isolated based on requestor-
>> ID
>>> i.e. traffic not guaranteed going to IOMMU, enabling SVA on multiple
>> devices
>>> could cause undesired p2p.
>> But so does enabling "classic" DMA... If two devices are not protected by
>> ACS for example, they are put in the same IOMMU group, and one device
>> might be able to snoop the other's DMA. VFIO allows userspace to create a
>> container for them and use MAP/UNMAP, but makes it explicit to the user
>> that for DMA, these devices are not isolated and must be considered as a
>> single device (you can't pass them to different VMs or put them in
>> different containers). So I tried to keep the same idea as MAP/UNMAP for
>> SVA, performing BIND/UNBIND operations on the VFIO container instead of
>> the device.
> 
> there is a small difference. for classic DMA we can reserve PCI BARs 
> when allocating IOVA, thus multiple devices in the same group can 
> still work correctly applied with same translation, if isolation is not
> cared in between. However for SVA it's CPU virtual addresses 
> managed by kernel mm thus difficult to introduce similar address 
> reservation. Then it's possible for a VA falling into other device's 
> BAR in the same group and cause undesired p2p traffic. In such 
> regard, SVA is actually functionally-broken.

I think the problem exists even if there is a single device in the group.
If for example, malloc() returns a VA that corresponds to a PCI host
bridge in IOVA space, performing DMA on that buffer won't reach the IOMMU
and will cause undesirable side-effects.

My series doesn't address the problem, but I believe we should carve
reserved regions out of the process address space during bind(), for
example by creating a PROT_NONE vma preventing userspace from obtaining
that VA.

If you solve this problem, you also solve it for multiple devices in a
group, because the IOMMU core provides the resv API on groups... That's
until you hotplug a device into a live group (currently WARN in VFIO),
with different resv regions.

>> I kept the analogy simple though, because I don't think there will be many
>> SVA-capable systems that require IOMMU groups. They will likely
> 
> I agree that multiple SVA-capable devices in same IOMMU group is not
> a typical configuration, especially it's usually observed on new devices.
> Then based on above limitation, I think we could just explicitly avoid
> enabling SVA in such case. :-)

I'd certainly like that :)

Thanks,
Jean
