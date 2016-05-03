From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
	remapping is supported
Date: Tue, 3 May 2016 15:34:11 +0800
Message-ID: <e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<1461761010-5452-6-git-send-email-xyjxie@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
	<f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D15F842653-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org" <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>, "nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org" <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, "mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org" <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, "ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org" <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org" <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, "paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org" <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2016/5/3 14:22, Tian, Kevin wrote:

>> From: Yongji Xie [mailto:xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org]
>> Sent: Tuesday, May 03, 2016 2:08 PM
>>
>> On 2016/5/3 13:34, Tian, Kevin wrote:
>>
>>>> From: Yongji Xie
>>>> Sent: Wednesday, April 27, 2016 8:43 PM
>>>>
>>>> This patch enables mmapping MSI-X tables if hardware supports
>>>> interrupt remapping which can ensure that a given pci device
>>>> can only shoot the MSIs assigned for it.
>>>>
>>>> With MSI-X table mmapped, we also need to expose the
>>>> read/write interface which will be used to access MSI-X table.
>>>>
>>>> Signed-off-by: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>>> A curious question here. Does "allow to mmap MSI-X" essentially
>>> mean that KVM guest can directly read/write physical MSI-X
>>> structure then?
>>>
>>> Thanks
>>> Kevin
>>>
>> Here we just allow to mmap MSI-X table in kernel. It doesn't
>> mean all KVM guest can directly read/write physical MSI-X
>> structure. This should be decided by QEMU. For PPC64
>> platform, we would allow to passthrough the MSI-X table
>> because we know guest kernel would not write physical
>> MSI-X structure when enabling MSI.
>>
> A bit confused here. If guest kernel doesn't need to write
> physical MSI-X structure, what's the point of passing through
> the table then?

We want to allow the MSI-X table because there may be
some critical registers in the same page as the MSI-X table.
We have to handle the mmio access to these register in QEMU
rather than in guest if mmapping MSI-X table is disallowed.

> I think the key whether MSI-X table can be passed through
> is related to where hypervisor control is deployed. At least
> for x86:
>
> - When irq remapping is not enabled, host/hypervisor needs
> to control physical interrupt message including vector/dest/etc.
> directly in MSI-X structure, so we cannot allow a guest to
> access it;
>
> - when irq remapping is enabled, host/hypervisor can control
> interrupt routing in irq remapping table. However MSI-X
> also needs to be configured as remappable format. In this
> manner we also cannot allow direct access from guest.
>
> The only sane case to pass through MSI-X structure, is a
> mechanism similar to irq remapping but w/o need to change
> original MSI-X format so direct access from guest side is
> safe. Is it the case in PPC64?
>
> Thanks
> Kevin

Acutually, we are not aimed at accessing MSI-X table from
guest. So I think it's safe to passthrough MSI-X table if we
can make sure guest kernel would not touch MSI-X table in
normal code path such as para-virtualized guest kernel on PPC64.

Thanks,
Yongji
