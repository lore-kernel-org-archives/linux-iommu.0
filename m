From: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
	remapping is supported
Date: Fri, 13 May 2016 09:16:18 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4BBEDD@AcuExch.aculab.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<f7d73ac3-470d-a0d2-0a97-05be630480dd@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842653@SHSMSX101.ccr.corp.intel.com>
	<e064a6a7-a8dc-f71f-1725-f31e03581b8d@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F847150@SHSMSX101.ccr.corp.intel.com>
	<063D6719AE5E284EB5DD2968C1650D6D5F4B52B5@AcuExch.aculab.com>
	<4be013bc-e81b-84c5-06d3-e1b3f46b3227@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F8474A4@SHSMSX101.ccr.corp.intel.com>
	<20160505090513.56886c12@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F84EEBA@SHSMSX101.ccr.corp.intel.com>
	<20160511095331.18436241@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F850046@SHSMSX101.ccr.corp.intel.com>
	<20160511202042.77593861@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F8507E8@SHSMSX101.ccr.corp.intel.com>
	<20160512114735.7ec61bd3@t450s.home>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F853FA4@SHSMSX101.ccr.corp.intel.com>
	<20160512233246.347b8b3c@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160512233246.347b8b3c-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
To: 'Alex Williamson' <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org" <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>, "nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org" <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org" <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org" <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, paulus@samba.o
List-Id: iommu@lists.linux-foundation.org

From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: 13 May 2016 06:33
...
> Simply denying direct writes to the vector table or preventing mapping
> of the vector table into the user address space does not provide any
> tangible form of protection.  Many devices make use of window registers
> that allow backdoors to arbitrary device registers.  Some drivers even
> use this as the primary means for configuring MSI-X, which makes them
> incompatible with device assignment without device specific quirks to
> enable virtualization of these paths.

We have one fgpa based PCIe slave where the device driver has to read
the MSI-X table and then write the value to other fpga registers so
that the logic can generate the correct PCIe write cycle when an
interrupt is requested.
The MSI-X table itself is only as a PCIe slave.

We also have host accessible DMA controllers that the device driver
uses to copy data to kernel memory.
These could easily be used to generate arbitrary MSI-X requests.
As I've said earlier it is almost certainly possible to get any
ethernet hardware to perform something similar.

So without hardware that is able to limit the memory and MSI-X
that each PCIe endpoint can access I believe that if a virtualisation
system gives a guest kernel direct access to a PCIe devices it gives
the guest kernel the ability to raise and MSI-X interrupt and read/write
any physical memory.
(I've not looked at the cpu virtualisation support, but do know what
the PCIe devices can do.)

More interestingly, probably the 'worst' thing (from a security point of view)
that changing the MSI-X table lets you do is a write to an arbitrary
physical memory address.

	David
