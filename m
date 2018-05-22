From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: kernel BUG at drivers/iommu/intel-iommu.c:732! , kernel 4.14.39
Date: Tue, 22 May 2018 08:22:40 -0600
Message-ID: <20180522082240.7317024b@w520.home>
References: <CAONWS2ynv6oEnFRLmCCvLLC=XBk9qtFkugkRw6GDvBpfgbMbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAONWS2ynv6oEnFRLmCCvLLC=XBk9qtFkugkRw6GDvBpfgbMbPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: plexo rama <plexorama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 22 May 2018 13:30:20 +0200
plexo rama <plexorama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi all,
> 
> 
> I receive the following kernel dump when trying to load QLogic qede in-tree
> driver for a dual-port
> 
> *QLogic* Corp. FastLinQ QL41000 Series 10/25/40/50GbE Controller (rev 02).
> One of the ports (45:00.0) is bound to the vfio-pci driver for
> pci-passthrough to a KVM/QEMU guest. Id like to use the PF of the second
> port on the host. I've unbound the pci device (45:00.1) from vfio-pci, but when
> I modprobe qede, I receive this:

AIUI, this device does not provide a PCIe ACS capability, therefore the
kernel assumes the functions of the device are not isolated and places
them in the same IOMMU group.  The vendor has also not indicated that
the PCIe functions are DMA isolated nor provided quirks to indicate any
sort of isolation.  vfio-pci requires DMA isolation between users,
whether they be separate userspace instances or between kernel and
users.  Via the process above, assuming 45:00.0 is in use by a user
instance when it occurs, you've compromised the isolation.  Generally
the response to this is a BUG in the vfio code, but in the case of this
driver it attempts to map DMA in the probe routine and therefore
encounters a different BUG where one device within the group has a
mapping through the IOMMU API and the other is attempting to map
through the DMA API, where the domains within intel-iommu are
incompatible.

In short, the device you're using doesn't support the DMA isolation
necessary for the use case you're trying to impose on it and the kernel
protects itself by preventing it, harshly.  Perhaps ask QLogic if
there's actually ACS equivalent isolation provided between PCIe
functions of the device and we can implement quirks for it.  Otherwise
you'll need a separate card to use for the host.  Thanks,

Alex
