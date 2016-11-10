From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Summary of LPC guest MSI discussion in Santa Fe
Date: Thu, 10 Nov 2016 10:07:04 -0700
Message-ID: <20161110100704.7dd16e2f@t450s.home>
References: <1478209178-3009-1-git-send-email-eric.auger@redhat.com>
	<20161103220205.37715b49@t450s.home>
	<20161108024559.GA20591@arm.com> <20161108202922.GC15676@cbox>
	<20161108163508.1bcae0c2@t450s.home> <58228F71.6020108@redhat.com>
	<20161109170326.GG17771@arm.com> <582371FB.2040808@redhat.com>
	<20161109192303.GD15676@cbox> <20161109130114.3e17bba9@t450s.home>
	<20161110144007.GC2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161110144007.GC2078-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dwmw-vV1OtcyAfmbQXOPxS62xeg@public.gmane.org, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 10 Nov 2016 15:40:07 +0100
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> On Wed, Nov 09, 2016 at 01:01:14PM -0700, Alex Williamson wrote:
> > Well, it's not like QEMU or libvirt stumbling through sysfs to figure
> > out where holes could be in order to instantiate a VM with matching
> > holes, just in case someone might decide to hot-add a device into the
> > VM, at some point, and hopefully they don't migrate the VM to another
> > host with a different layout first, is all that much less disgusting or
> > foolproof. It's just that in order to dynamically remove a page as a
> > possible DMA target we require a paravirt channel, such as a balloon
> > driver that's able to pluck a specific page.  In some ways it's
> > actually less disgusting, but it puts some prerequisites on
> > enlightening the guest OS.  Thanks,  
> 
> I think it is much simpler if libvirt/qemu just go through all
> potentially assignable devices on a system and pre-exclude any addresses
> from guest RAM beforehand, rather than doing something like this with
> paravirt/ballooning when a device is hot-added. There is no guarantee
> that you can take a page away from a linux-guest.

Right, I'm not advocating a paravirt ballooning approach, just pointing
out that they're both terrible, just in different ways.  Thanks,

Alex
