From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy
	DMA/IO
Date: Tue, 21 Oct 2014 20:16:46 -0600
Message-ID: <CAErSpo69VmK5zD-ztNVHCA=KrK8zucqubY17z0K3rcpe6ReNUA@mail.gmail.com>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com>
	<1398854973.12733.23.camel@i7.infradead.org>
	<20140702133258.GN26537@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140702133258.GN26537-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Vaden,
	Tom L (HP Server OS Architecture)" <tom.vaden-VXdhtT5mjnY@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zhen-Hua <zhen-hual-VXdhtT5mjnY@public.gmane.org>, doug.hatch-VXdhtT5mjnY@public.gmane.org, "ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org" <ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, zhenhua-VXdhtT5mjnY@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

[-cc Bill, +cc Zhen-Hua, Eric, Tom, Jerry]

Hi Joerg,

I was looking at Zhen-Hua's recent patches, trying to figure out if I
need to do anything with them.  Resetting devices in the old kernel
seems like a non-starter.  Resetting devices in the new kernel, ...,
well, maybe.  It seems ugly, and it seems like the sort of problem
that IOMMUs are designed to solve.  Anyway, I found this old
discussion that I didn't quite understand:

On Wed, Jul 2, 2014 at 7:32 AM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Apr 30, 2014 at 11:49:33AM +0100, David Woodhouse wrote:

>> After the last round of this patchset, we discussed a potential
>> improvement where you point every virtual bus address at the *same*
>> physical scratch page.
>
> That is a solution to prevent the in-flight DMA failures. But what
> happens when there is some in-flight DMA to a disk to write some inodes
> or a new superblock. Then this scratch address-space may cause
> filesystem corruption at worst.

This in-flight DMA is from a device programmed by the old kernel, and
it would be reading data from the old kernel's buffers.  I think
you're suggesting that we might want that DMA read to complete so the
device can update filesystem metadata?

I don't really understand that argument.  Don't we usually want to
stop any data from escaping the machine after a crash, on the theory
that the old kernel is crashing because something is catastrophically
wrong and we may have already corrupted things in memory?  If so,
allowing this old DMA to complete is just as likely to make things
worse as to make them better.

Without kdump, we likely would reboot through the BIOS and the device
would get reset and the DMA would never happen at all.  So if we made
the dump kernel program the IOMMU to prevent the DMA, that seems like
a similar situation.

> So with this in mind I would prefer initially taking over the
> page-tables from the old kernel before the device drivers re-initialize
> the devices.

This makes the dump kernel more dependent on data from the old kernel,
which we obviously want to avoid when possible.

I didn't find the previous discussion where pointing every virtual bus
address at the same physical scratch page was proposed.  Why was that
better than programming the IOMMU to reject every DMA?

Bjorn
