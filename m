From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
	remapping is supported
Date: Thu, 5 May 2016 21:28:55 +0800
Message-ID: <90cc2e8c-be18-45de-ffff-fad313d49f81@linux.vnet.ibm.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
	<f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
	<e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
	<063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
	<4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org" <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>, "nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org" <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, "mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org" <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, "ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org" <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org" <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2016/5/5 20:15, Tian, Kevin wrote:

>> From: Yongji Xie [mailto:xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org]
>> Sent: Thursday, May 05, 2016 7:43 PM
>>
>> Hi David and Kevin,
>>
>> On 2016/5/5 17:54, David Laight wrote:
>>
>>> From: Tian, Kevin
>>>> Sent: 05 May 2016 10:37
>>> ...
>>>>> Acutually, we are not aimed at accessing MSI-X table from
>>>>> guest. So I think it's safe to passthrough MSI-X table if we
>>>>> can make sure guest kernel would not touch MSI-X table in
>>>>> normal code path such as para-virtualized guest kernel on PPC64.
>>>>>
>>>> Then how do you prevent malicious guest kernel accessing it?
>>> Or a malicious guest driver for an ethernet card setting up
>>> the receive buffer ring to contain a single word entry that
>>> contains the address associated with an MSI-X interrupt and
>>> then using a loopback mode to cause a specific packet be
>>> received that writes the required word through that address.
>>>
>>> Remember the PCIe cycle for an interrupt is a normal memory write
>>> cycle.
>>>
>>> 	David
>>>
>> If we have enough permission to load a malicious driver or
>> kernel, we can easily break the guest without exposed
>> MSI-X table.
>>
>> I think it should be safe to expose MSI-X table if we can
>> make sure that malicious guest driver/kernel can't use
>> the MSI-X table to break other guest or host. The
>> capability of IRQ remapping could provide this
>> kind of protection.
>>
> With IRQ remapping it doesn't mean you can pass through MSI-X
> structure to guest. I know actual IRQ remapping might be platform
> specific, but at least for Intel VT-d specification, MSI-X entry must
> be configured with a remappable format by host kernel which
> contains an index into IRQ remapping table. The index will find a
> IRQ remapping entry which controls interrupt routing for a specific
> device. If you allow a malicious program random index into MSI-X
> entry of assigned device, the hole is obvious...

Do you mean we can trigger MSIs that correspond to interrupt
IDs of other devices by writing to MSI-X table although IRQ
remapping is enabled?

On PPC64, there is a mapping between MSIs and PE num
which can be used to identify a PCI device on PHB. So the
hardware can ensure a given pci device can only shoot the
MSIs assigned for it.  Isn't there a similar mapping in IRQ
remapping table on Intel.

Thanks,
Yongji

> Above might make sense only for a IRQ remapping implementation
> which doesn't rely on extended MSI-X format (e.g. simply based on
> BDF). If that's the case for PPC, then you should build MSI-X
> passthrough based on this fact instead of general IRQ remapping
> enabled or not.
>
> Thanks
> Kevin
