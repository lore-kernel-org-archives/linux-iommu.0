From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: DMAR faults from unrelated device when vfio is used
Date: Mon, 04 Feb 2013 08:49:28 -0700
Message-ID: <1359992968.11144.414.camel@bling.home>
References: <1359972630.2498.21.camel@riven-lux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1359972630.2498.21.camel-gkzspu4BhkBxV/yNj0eb6g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Gstir <david-S6VGOU4v5edDinCvNWH78Q@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, daniel.vetter-/w4YWyX8dFk@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, richard-S6VGOU4v5edDinCvNWH78Q@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-02-04 at 11:10 +0100, David Gstir wrote:
> Hi!
> 
> I get the following error messages over and over again when using vfio
> in qemu-kvm:
> 
> [ 1692.021403] dmar: DMAR:[DMA Read] Request device [00:02.0] fault addr 1a45aa9000 
> [ 1692.021403] DMAR:[fault reason 12] non-zero reserved fields in PTE
> [ 1692.021416] dmar: DRHD: handling fault status reg 2
> 
> This pci device is the graphics card, which I did not assign to qemu!
> I did assign the following devices:
> 00:1a.0, 00:1b.0, 00:1c.0, 00:1c.6, 00:1d.0, 03:00.0.

Piecing together your logs:

iommu_group 5
00:1a.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #2 [8086:1c2d] (rev 04)
iommu_group 6
00:1b.0 Audio device [0403]: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller [8086:1c20] (rev 04)
iommu_group 7
00:1c.0 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 1 [8086:1c10] (rev b4)
00:1c.6 PCI bridge [0604]: Intel Corporation 6 Series/C200 Series Chipset Family PCI Express Root Port 7 [8086:1c1c] (rev b4)
03:00.0 USB controller [0c03]: NEC Corporation uPD720200 USB 3.0 Host Controller [1033:0194] (rev ff)
iommu_group 8
00:1d.0 USB controller [0c03]: Intel Corporation 6 Series/C200 Series Chipset Family USB Enhanced Host Controller #1 [8086:1c26] (rev 04)

Can you clarify what you mean by assign?  Are you actually assigning the
root ports to the qemu guest (1c.0 & 1c.6)?  vfio will require they be
owned by vfio-pci to make use of 3:00.0, but assigning them to the guest
is not recommended.  Can you provided your qemu command line?  We need
to re-visit how to handle pcieport devices with vfio-pci, perhaps
white-listing it as a vfio "compatible" driver, but this still should
not interfere with devices external to the group.

The DMAR fault address looks pretty bogus unless you happen to have
100GB+ of ram in the system.

> The error occurs at random and is not reproducible every time. It
> happens about every third reboot. 
> I'm running qemu-kvm 1.3.0 (kvm-1.3.0-187.3), kernel 3.8.0-rc5 and
> windows 7 as guest OS. The hardware uses an Intel IOMMU. See
> attachments for output of lspci, and details on iommu groups
> 
> I'm not sure if this problem originates from qemu, kvm, vfio or the
> GPU driver.
> Do you have any hints how to debug this further?

vfio makes use of the IOMMU API for programming DMA translations, so an
reserved fields would have to be programmed by intel-iommu itself.  We
could of course be passing some kind of bogus data that intel-iommu
isn't catching.  If you're assigning the root ports to the guest, I'd
start with that, don't do it.  Attach them to vfio, but don't give them
to the guest.  Maybe that'll give us a hint.  I also notice that your
USB 3 controller is dead:

03:00.0 USB controller: NEC Corporation uPD720200 USB 3.0 Host Controller (rev ff) (prog-if ff)
	!!! Unknown header type 7f

We only see unknown header type 7f when the read from the device returns
-1.  This might have something to do with the root port above it (1c.6)
being in state D3.  Windows likes to put unused devices in D3, which
leads me to suspect you are giving it to the guest.  Let's see what
happens without that.  Thanks,

Alex
