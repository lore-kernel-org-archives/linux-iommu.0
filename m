From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 04/13] pci: New pci_dma_quirk()
Date: Thu, 17 May 2012 09:22:00 -0600
Message-ID: <1337268120.2880.4.camel@ul30vt>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225555.30496.80525.stgit@bling.home>
	<CAJtEV7YMrsttPfAdL0_uht-ZRwCHhYwHTvypCc6TfEzTEGaijQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7YMrsttPfAdL0_uht-ZRwCHhYwHTvypCc6TfEzTEGaijQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anonymous <anonymous-MUDIJn/1Q3AaHdxRYFc1FNBPR1lH4CV8@public.gmane.org>
Cc: B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-05-17 at 15:19 +0800, Anonymous wrote:
> Alex,
> 
> On Sat, May 12, 2012 at 6:55 AM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > Integrating IOMMU groups more closely into the driver core allows
> > us to more easily work around DMA quirks.  The Ricoh multifunction
> > controller is a favorite example of devices that are currently
> > incompatible with IOMMU isolation as all the functions use the
> > requestor ID of function 0 for DMA.  Passing this device into
> > pci_dma_quirk returns the PCI device to use for DMA.  The IOMMU
> > driver can then construct an IOMMU group including both devices.
> >
> 
> Please give some thought to the Marvell SATA controller quirk as well.
> 
> Instead of multiple visible functions using the same requester ID of
> function 0, the Marvell device only makes function 0 visible, but uses
> the requestor ID of function 1 as well during DMA.
> 
> See https://bugzilla.redhat.com/show_bug.cgi?id=757166

Wow.  That one isn't quite as easy to deal with since there's no
existing device in the kernel to point to.  This comment might be on the
right track:

https://bugzilla.kernel.org/show_bug.cgi?id=42679#c11

Perhaps David Woodhouse can comment on support for phantom functions.
If we had infrastructure for that it might be easy for the quirk to
update the pci_dev struct, inserting a new phantom function.  Otherwise
we'd need to create a new device in the kernel for it.  Thanks,

Alex
