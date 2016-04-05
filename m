From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: AMD-Vi regression with PCIe/PCI bridges in 4.4
Date: Tue, 5 Apr 2016 12:15:30 +0200
Message-ID: <20160405101530.GA4203@suse.de>
References: <5700BF69.2080102@ladisch.de>
 <57038D1F.7040205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57038D1F.7040205-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 05, 2016 at 12:02:07PM +0200, Clemens Ladisch wrote:
> Joerg Roedel wrote:
> > I have seen that before, can you please boot with 'amd_iommu_dump' on
> > the kernel command line and send me dmesg after boot?
> 
> Full dmesg: <https://bugzilla.kernel.org/attachment.cgi?id=211771>:
> ...
> [    0.179504] pci 0000:04:00.0: [10b5:8112] type 01 class 0x060400
> [    0.179681] pci 0000:04:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
> [    0.179966] pci 0000:00:15.0: PCI bridge to [bus 04-05]
> [    0.180128] pci 0000:00:15.0:   bridge window [io  0xc000-0xcfff]
> [    0.180216] pci 0000:05:04.0: [13f6:8788] type 00 class 0x040100
> [    0.180245] pci 0000:05:04.0: reg 0x10: [io  0xc000-0xc0ff]
> [    0.180390] pci 0000:05:04.0: supports D1 D2
> [    0.180478] pci 0000:04:00.0: PCI bridge to [bus 05]
> [    0.180641] pci 0000:04:00.0:   bridge window [io  0xc000-0xcfff]
> ...
> [    0.459076] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: fe info 1300
> [    0.459238] AMD-Vi:        mmio-addr: 00000000feb80000
> [    0.459430] AMD-Vi:   DEV_SELECT_RANGE_START	 devid: 00:01.0 flags: 00
> [    0.459592] AMD-Vi:   DEV_RANGE_END		 devid: ff:1f.6
> [    0.460268] AMD-Vi:   DEV_ALIAS_RANGE		 devid: 03:00.0 flags: 00 devid_to: 00:14.4
> [    0.460555] AMD-Vi:   DEV_RANGE_END		 devid: 03:1f.7
> [    0.460717] AMD-Vi:   DEV_SPECIAL(HPET[0])		devid: 00:14.0
> [    0.460876] AMD-Vi:   DEV_SPECIAL(IOAPIC[5])		devid: 00:14.0
> [    0.542806] iommu: Adding device 0000:00:02.0 to group 0
> ...
> [    0.547889] iommu: Adding device 0000:00:15.0 to group 9
> ...
> [    0.549907] iommu: Adding device 0000:04:00.0 to group 9
> [    0.550071] iommu: Adding device 0000:05:04.0 to group 9
> [    0.550229] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
> [    0.550387] AMD-Vi:  Extended features:  PreF PPR GT IA
> [    0.550804] AMD-Vi: Lazy IO/TLB flushing enabled
> ...
> [  124.474883] AMD-Vi: Event logged [IO_PAGE_FAULT device=05:00.0 domain=0x0000 address=0x0000000000100000 flags=0x0050]

Hmm, with this IVRS table it should've never worked. For it to work
there needs to be an alias defined from device 05:04.0 to device
05:00.0. Otherwise the iommu driver doesn't know about the real
requestor-id it could expect from the sound card.

Did you do a BIOS update in-between? Or maybe some change to the sound
driver makes it misbehave and use a wrong pci request-id?


	Joerg
