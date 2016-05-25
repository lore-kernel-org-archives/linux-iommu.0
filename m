From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/5] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Date: Wed, 25 May 2016 13:46:23 +0800
Message-ID: <201605250546.u4P5htW1048499@mx0a-001b2d01.pphosted.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<1461761010-5452-2-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20160524205519.GA16463@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160524205519.GA16463@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2016/5/25 4:55, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:26PM +0800, Yongji Xie wrote:
>> We introduce a new pci_bus_flags, PCI_BUS_FLAGS_MSI_REMAP
>> which indicates all devices on the bus are protected by the
>> hardware which supports IRQ remapping(intel naming).
> This changelog is ambiguous.  It's possible that there is hardware
> that *supports* IRQ remapping, but does not actually *do* IRQ
> remapping.  For example, an IRQ remapping capability may be present
> but not enabled.
>
> I think your intent is to set this flag only when MSI remapping is
> actually *enabled* for all devices on the bus.

Yes. This is exactly my intent. Thank you for the correction!

> I'd also like to know exactly what protection is implied by
> PCI_BUS_FLAGS_MSI_REMAP and IOMMU_CAP_INTR_REMAP.  I guess it means a
> device can only generate MSIs to a certain set of CPUs?  I assume the
> remapping hardware only checks the target address, not the data being
> written?

When IRQ remapping is enabled, the hardware will check both target
address and data, then compute the interrupt_index from them.
Interrupt_index will be used to find a specific Interrupt Remapping Table
Entry containing some fields which could be used to identify a device or
a group of devices(these devices should be in the same isolation domain).
Then hardware can use this to verify the interrupt request. If the interrupt
request is not from the specific devices, it will be blocked.

So this flag indicate that the hardware can ensure that a given PCI device
can only shoot the MSIs assigned for it. When there is something wrong
with MSI in device or device driver, this can prevent all damage from it.

Regards,
Yongji
