From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: KVM PCI passthrough problems after kernel v4.2
Date: Thu, 12 Nov 2015 15:00:23 -0700
Message-ID: <1447365623.3946.99.camel@redhat.com>
References: <CAN74MCz9MCoLFh=NDLeUVQvBnUgaVJO_c8uTv1RT2V9sTMZ9yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN74MCz9MCoLFh=NDLeUVQvBnUgaVJO_c8uTv1RT2V9sTMZ9yA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Juhani Rautiainen <jrauti-X3B1VOXEql0@public.gmane.org>
Cc: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-11-12 at 23:36 +0200, Juhani Rautiainen wrote:
> Hi!
> 
> I've been using KVM PCI passthrough with a dual-port NIC for over a
> year. I just upgraded to v4.3 from v4.1.4 and PCI passthrough stopped
> working. I checked with v4.1.9 and it still works there. Version 4.2
> seems to point after which my system doesn't work. How can I help to
> narrow down the cause of the problem? I checked the intel-iommu.c and
> there seem to have been lots of changes between 4.1.9 and 4.2 in
> drivers/iommu/intel-iommu.c. My motherboard is Asus P8C WS which has
> Intel C216 chipset. CPU is Intel I5-3470. From v4.2 onwards
> passthrough fails with:
> 
> pci-stub 0000:02:00.0: kvm assign device failed ret -22.

This happens when kvm calls iommu_attach_device(), which was changed in
v4.2 to fail with -EINVAL (-22) when the device is part of a
non-singleton iommu group.  Legacy kvm device assignment is not iommu
group aware and has been deprecated for some time.  Have you considered
using vfio for device assignment instead?

For reference, here's the comment that made this change:

commit 426a273834eae65abcfc7132a21a85b3151e0bce
Author: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date:   Thu May 28 18:41:30 2015 +0200

    iommu: Limit iommu_attach/detach_device to devices with their own group
    
    This patch changes the behavior of the iommu_attach_device
    and iommu_detach_device functions. With this change these
    functions only work on devices that have their own group.
    For all other devices the iommu_group_attach/detach
    functions must be used.
    
    Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
