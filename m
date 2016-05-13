From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 5/5] vfio-pci: Allow to mmap MSI-X table if interrupt
	remapping is supported
Date: Fri, 13 May 2016 02:36:27 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D15F853FC5@SHSMSX101.ccr.corp.intel.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D15F842512@SHSMSX101.ccr.corp.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org" <alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org>, "nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org" <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org" <ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org" <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> From: Tian, Kevin
> Sent: Friday, May 13, 2016 10:33 AM
> 
> > means.  The MSI-X vector table of a device is always considered
> > untrusted which is why we require user opt-ins to subvert that
> > protection.  Thanks,
> >
> 
> I only partially agree with this statement since there is different
> trust level for kernel space driver and user space driver.
> 
> OS may choose to trust kernel space driver then it can enable IRQ
> remapping only for load balance purpose w/o source id verfification.
> In such case MSI-X vector table is trusted and fully under kernel
> control. Allowing to mmap MSI-X table in user space definitely
> breaks that boundary.
> 
> Anyway my point is simple. Let's ignore how Linux kernel implements
> IRQ remapping on x86 (which may change time to time), and just
> focus on architectural possibility. Non-x86 platform may implement
> IRQ remapping completely separate from device side, then checking
> availability of IRQ remapping is enough to decide whether mmap
> MSI-X table is safe. x86 with VT-d can be configured to a mode
> requiring host control of both MSI-X entry and IRQ remapping hardware
> (without source id check). In such case it's insufficient to make
> decision simply based on IRQ remapping availability. We need a way
> to query from IRQ remapping module whether it's actually safe to
> mmap MSI-X.
> 

Or another way is to have VFIO explicitly request intel-iommu to
enforce sid check when IRQ remapping is enabled...

Thanks
Kevin
