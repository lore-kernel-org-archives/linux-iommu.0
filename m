From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Sun, 11 Oct 2015 15:16:51 -0600
Message-ID: <1444598211.4059.291.camel@redhat.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
	<20151009184110.14752.53531.stgit@gimli.home>
	<561A19DE.8040302@scylladb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <561A19DE.8040302-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Avi Kivity <avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org>
Cc: avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sun, 2015-10-11 at 11:12 +0300, Avi Kivity wrote:
> 
> On 10/09/2015 09:41 PM, Alex Williamson wrote:
> > There is really no way to safely give a user full access to a PCI
> > without an IOMMU to protect the host from errant DMA.  There is also
> > no way to provide DMA translation, for use cases such as devices
> > assignment to virtual machines.  However, there are still those users
> > that want userspace drivers under those conditions.  The UIO driver
> > exists for this use case, but does not provide the degree of device
> > access and programming that VFIO has.  In an effort to avoid code
> > duplication, this introduces a No-IOMMU mode for VFIO.
> >
> > This mode requires enabling CONFIG_VFIO_NOIOMMU and loading the vfio
> > module with the option "enable_unsafe_pci_noiommu_mode".  This should
> > make it very clear that this mode is not safe.  In this mode, there is
> > no support for unprivileged users, CAP_SYS_ADMIN is required for
> > access to the necessary dev files.
> 
> CAP_SYS_RAWIO seems a better match (in particular, it allows access to 
> /dev/mem, which is the same thing).

Sure, that seems reasonable.

> >    Mixing no-iommu and secure VFIO is
> > also unsupported, as are any VFIO IOMMU backends other than the
> > vfio-noiommu backend.  Furthermore, unsafe group files are relocated
> > to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
> > kernel is tainted due to the dummy IOMMU put in place.  Unloading of
> > the module in this mode is also unsupported and will BUG due to the
> > lack of support for unregistering an IOMMU for a bus type.
> 
> I did not see an API for detecting whether memory translation is 
> provided or not.  We can have the caller guess this by looking at the 
> device name, or by requiring the user to specify this, but I think it's 
> cleaner to provide programmatic access to this attribute.

The VFIO user can probe and needs to set the IOMMU model in use before
they can access a device file descriptor.  In this mode, the
VFIO_NOIOMMU_IOMMU is the only model available, which as proposed here
provides no translation, and in fact no mapping ioctls.  Thanks,

Alex
