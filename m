From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
Date: Fri, 2 Mar 2018 16:03:25 +0000
Message-ID: <4d5eccd4-6151-fbce-510e-ac2c02a6794a@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-3-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191002897@SHSMSX101.ccr.corp.intel.com>
	<b9eacb30-817f-9027-bc0a-1f01cf9f13f9@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D191003AD6@SHSMSX101.ccr.corp.intel.com>
	<ca4d4992-0c8b-dae6-e443-7c7f7164be60@arm.com>
	<A2975661238FB949B60364EF0F2C257439B829DA@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B829DA-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mykyta.iziumtsev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <mykyta.iziumtsev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Raj,
	Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/03/18 03:03, Liu, Yi L wrote:
> Hi Jean,
> 
>> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
>> Sent: Thursday, February 15, 2018 8:41 PM
>> Subject: Re: [PATCH 02/37] iommu/sva: Bind process address spaces to devices
>>
>> On 13/02/18 23:34, Tian, Kevin wrote:
>>>> From: Jean-Philippe Brucker
>>>> Sent: Tuesday, February 13, 2018 8:57 PM
>>>>
>>>> On 13/02/18 07:54, Tian, Kevin wrote:
>>>>>> From: Jean-Philippe Brucker
>>>>>> Sent: Tuesday, February 13, 2018 2:33 AM
>>>>>>
>>>>>> Add bind() and unbind() operations to the IOMMU API. Device drivers
>>>> can
>>>>>> use them to share process page tables with their devices.
>>>>>> bind_group() is provided for VFIO's convenience, as it needs to
>>>>>> provide a coherent interface on containers. Other device drivers
>>>>>> will most likely want to use bind_device(), which binds a single device in the
>> group.
>>>>>
>>>>> I saw your bind_group implementation tries to bind the address space
>>>>> for all devices within a group, which IMO has some problem. Based on
>>>> PCIe
>>>>> spec, packet routing on the bus doesn't take PASID into consideration.
>>>>> since devices within same group cannot be isolated based on
>>>>> requestor-
>>>> ID
>>>>> i.e. traffic not guaranteed going to IOMMU, enabling SVA on multiple
>>>> devices
>>>>> could cause undesired p2p.
>>>> But so does enabling "classic" DMA... If two devices are not
>>>> protected by ACS for example, they are put in the same IOMMU group,
>>>> and one device might be able to snoop the other's DMA. VFIO allows
>>>> userspace to create a container for them and use MAP/UNMAP, but makes
>>>> it explicit to the user that for DMA, these devices are not isolated
>>>> and must be considered as a single device (you can't pass them to
>>>> different VMs or put them in different containers). So I tried to
>>>> keep the same idea as MAP/UNMAP for SVA, performing BIND/UNBIND
>>>> operations on the VFIO container instead of the device.
>>>
>>> there is a small difference. for classic DMA we can reserve PCI BARs
>>> when allocating IOVA, thus multiple devices in the same group can
>>> still work correctly applied with same translation, if isolation is
>>> not cared in between. However for SVA it's CPU virtual addresses
>>> managed by kernel mm thus difficult to introduce similar address
>>> reservation. Then it's possible for a VA falling into other device's
>>> BAR in the same group and cause undesired p2p traffic. In such regard,
>>> SVA is actually functionally-broken.
>>
>> I think the problem exists even if there is a single device in the group.
>> If for example, malloc() returns a VA that corresponds to a PCI host bridge in IOVA
>> space, performing DMA on that buffer won't reach the IOMMU and will cause
>> undesirable side-effects.
> 
> If only a single device in a group, should it mean there is ACS support in
> the path from this device to root complex? It means any memory request
> from this device would be upstreamed to root complex, thus it should be
> able to avoid undesired p2p traffics. So I intend to believe, even we do
> bind in group level, we actually expect to make it work only for the case
> where a single device within a group.

Yes if each device has its own group then ACS is properly enabled.

Even without thinking about ACS or p2p, all memory requests don't
necessarily make it to the IOMMU. For example transactions targeting the
PCI host bridge MMIO window (marked as RESV_RESERVED by dma-iommu.c),
may get eaten by the RC and not reach the IOMMU (I'm blindly following
the code here, don't have anything in the spec to back me up). Commit
fade1ec055dc also refers to "faults, corruption and other badness"
though I don't know if that's only for PCI or could also affect future
systems.

And I don't think prefixing transactions with a PASID changes the
situation. I couldn't find anything in the PCIe spec contradicting it
and I guess it's up to the root complex implementation. So I tend to
take a conservative approach and assume that RESV_RESERVED regions will
also apply to PASID-prefixed traffic.

Thanks,
Jean
