From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/3] PCI/x86: Interface for testing multivector MSI support
Date: Mon, 12 Jan 2015 08:42:13 -0700
Message-ID: <1421077333.6130.21.camel@redhat.com>
References: <20141121213752.31095.30735.stgit@gimli.home>
	<20150108161521.GB6575@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150108161521.GB6575-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-01-08 at 09:15 -0700, Bjorn Helgaas wrote:
> On Fri, Nov 21, 2014 at 03:08:27PM -0700, Alex Williamson wrote:
> > I'd like to make vfio-pci capable of manipulating the device exposed
> > to the user such that if the host can only support a single MSI
> > vector then we hide the fact that the device itself may actually be
> > able to support more.  When we virtualize PCI config space and
> > interrupt setup there's no PCI protocol for the device failing to
> > allocate the number of vectors that it said were available.  If the
> > userspace driver is a guest operating system, it certainly doesn't
> > expect this to fail.  I don't think we can ever guarantee that a
> > multi-vector request will succeed, but we can certainly guarantee
> > that it will fail if the platform doesn't support it.
> > 
> > An example device is the Atheros AR93xxx running in a Windows 7 VM.
> > Both the device and the guest OS support multiple MSI vectors.  With
> > interrupt remapping, such that the host supports multivector, the
> > device works well in the guest.  With interrupt remapping disabled,
> > the device is far less reliable because of the mismatch in MSI
> > programming vs driver configuration and often fails.  If vfio-pci
> > can test whether multiple vectors are supported, then we can make it
> > work reliably in both cases by adjusting the exposed MSI capability,
> > like in this patch that would follow this series:
> > 
> > https://github.com/awilliam/linux-vfio/commit/9ace67515680
> > 
> > With this series, only x86 w/ interrupt remapping will advertise
> > support for multiple MSI vectors.  In surveying the code, I couldn't
> > find any other archs that allowed it, but I'll take corrections if
> > that's untrue.  Thanks,
> 
> Per Thomas' comments and your possible workaround if we don't have
> pci_msi_supported(), I'm going to ignore these for now.  Let me know if
> you disagree.

Yep, that's fine.  I'll either forget about this for a while or kludge
something in vfio to know that only x86 with interrupt remapping, which
I can test from the IOMMU API, has multivector MSI support.  Thanks,

Alex
