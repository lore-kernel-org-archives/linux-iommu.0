From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [GIT PULL (PATCH 0/4)] VFIO driver for v3.6
Date: Mon, 30 Jul 2012 17:17:59 -0600
Message-ID: <1343690279.8073.215.camel@ul30vt>
References: <20120725142254.12800.61860.stgit@bling.home>
	<20120727053206.GC11870@drongo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120727053206.GC11870@drongo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>
Cc: B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-07-27 at 15:32 +1000, Paul Mackerras wrote:
> On Wed, Jul 25, 2012 at 08:53:06AM -0600, Alex Williamson wrote:
> > Hi Linus,
> > 
> > This series includes the VFIO userspace driver interface for the
> > 3.6 kernel merge window.  This driver is intended to provide a
> > secure interface for device access using IOMMU protection for
> > applications like assignment of physical devices to virtual
> > machines.  Qemu will be the first user of this interface, enabling
> > assignment of PCI devices to Qemu guests.  This interface is
> > intended to eventually replace the x86-specific assignment mechanism
> > currently available in KVM.  This interface has the advantage of
> > being more secure, by working with IOMMU groups to ensure device
> > isolation and providing it's own filtered resource access mechanism,
> > and also more flexible, in not being x86 or KVM specific (extensions
> > to enable POWER are already working).
> > 
> > As a new driver, I'm including both the individual patches in email,
> > as well as a branch to pull from:
> > 
> > git://github.com/awilliam/linux-vfio.git for-linus
> > 
> > This driver is originally the work of Tom Lyon, but has since been
> > handed over to me and gone through a complete overhaul thanks to the
> > input from David Gibson, Ben Herrenschmidt, Chris Wright, Joerg
> > Roedel, and others.  This driver has been available in linux-next for
> > the last month.  Thanks,
> 
> Linus,
> 
> Are you thinking of pulling this driver in for 3.6?  I would be glad
> to see it go in since we want to use it with KVM on PowerPC.  If
> possible we'd like the PowerPC bits for it to go in as well.

I'm pretty anxious to find out as well.  Linus, ping, any thoughts on
including this in 3.6?  Thanks,

Alex
