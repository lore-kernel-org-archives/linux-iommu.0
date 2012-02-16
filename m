From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: Using OMAP3 ISP live display and snapshot sample applications
Date: Thu, 16 Feb 2012 07:46:58 +0100
Message-ID: <13567544.qv9HnVLVXR@avalon>
References: <CAOy7-nNSu2v9VS9Bh5O5StvEAvoxA4DqN7KdSGfZZSje1_Fgnw@mail.gmail.com>
	<CAOy7-nNgduFBqYMpLEaTPQ9VQwZ0Z29SzcAoGC6uRWGAPM3_JA@mail.gmail.com>
	<20120214104436.GU22598@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120214104436.GU22598-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, James <angweiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Tuesday 14 February 2012 11:44:37 Joerg Roedel wrote:
> On Mon, Feb 13, 2012 at 09:28:30AM +0800, James wrote:
> > >> @@ -28,6 +28,7 @@ obj-$(CONFIG_XEN)           += xen/
> > >> 
> > >>  # regulators early, since some subsystems rely on them to initialize
> > >>  obj-$(CONFIG_REGULATOR)              += regulator/
> > >> +obj-$(CONFIG_IOMMU_SUPPORT)  += iommu/
> > >> 
> > >>  # tty/ comes before char/ so that the VT console is the boot-time
> > >>  # default.
> > >> @@ -125,7 +126,6 @@ obj-y                             += clk/
> > >> 
> > >>  obj-$(CONFIG_HWSPINLOCK)     += hwspinlock/
> > >>  obj-$(CONFIG_NFC)            += nfc/
> > >> -obj-$(CONFIG_IOMMU_SUPPORT)  += iommu/
> > >> 
> > >>  # Virtualization drivers
> > >>  obj-$(CONFIG_VIRT_DRIVERS)   += virt/
> 
> I don't see how this patch solves a problem like below.
> 
> > [    3.663269] Unable to handle kernel NULL pointer dereference at virtual
> > address 00000058

[snip]

> > [<c03eeac4>] (klist_next+0x10/0xb4) from [<c024deb8>]
> > (next_device+0x8/0x14)
> > [<c024deb8>] (next_device+0x8/0x14) from [<c024df28>]
> > (driver_find_device+0x64/0x7c)
> > [<c024df28>] (driver_find_device+0x64/0x7c) from [<c02e9578>]
> > (isp_probe+0x228/0xa34)

[snip]

> This looks more like data corruption or something. But this is definitly
> not caused by some random order in the Makefile.
> Please debug this issue down to the real cause. Bisecting may help here.

There's actually a line missing from the backtrace for some reason.

isp_probe() calls iommu_attach_device(), which ends up calling 
omap_iommu_attach(). That function then calls driver_find_device(), passing it 
omap_iommu_driver.driver as its first argument. However, as the OMAP3 ISP 
driver is linked in the kernel before the OMAP3 IOMMU driver, 
omap_iommu_init() has not be called yet by this time. omap_iommu_driver.driver 
is thus uninitialized, and klist iteration oopses as the linked list head is 
NULL.

-- 
Regards,

Laurent Pinchart
