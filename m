From: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Mon, 12 Oct 2015 19:27:50 +0300
Message-ID: <20151012191150-mutt-send-email-mst@redhat.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
	<20151009184110.14752.53531.stgit@gimli.home>
	<20151012085607.2c64f98f@urahara>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151012085607.2c64f98f@urahara>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
Cc: avi-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, avi-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, gleb-VrcmuVmyx1hWk0Htik3J/w@public.gmane.org, corbet-T1hC0tSOHrs@public.gmane.org, bruce.richardson-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, gleb-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, vladz-RmZWMc9puTNJc61us3aD9laTQe2KTcn/@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 12, 2015 at 08:56:07AM -0700, Stephen Hemminger wrote:
> On Fri, 09 Oct 2015 12:41:10 -0600
> Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
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
> > access to the necessary dev files.  Mixing no-iommu and secure VFIO is
> > also unsupported, as are any VFIO IOMMU backends other than the
> > vfio-noiommu backend.  Furthermore, unsafe group files are relocated
> > to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
> > kernel is tainted due to the dummy IOMMU put in place.  Unloading of
> > the module in this mode is also unsupported and will BUG due to the
> > lack of support for unregistering an IOMMU for a bus type.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> Will this work for distro's where chaning kernel command line options
> is really not that practical. We need to boot with one command line
> and then decide to use IOMMU (or not) later on during the service
> startup of the dataplane application.

On open? That's too late in my opinion. But maybe the flag can be
tweaked so that it will probe for iommu, if there - do the
right thing, but if that fails, enable the dummy one.
And maybe defer tainting until device open.

Won't address the "old IOMMUs add performance overhead"
usecase but I'm not very impressed by that in any case.

> Recent experience is that IOMMU's
> are broken on many platforms so the only way to make a DPDK application
> it to write a test program that can be used to check if VFIO+IOMMU
> works first.

In userspace? Well that's just piling up work-arounds.  And assuming
hardware is broken, who knows what's going on security-wise.  These
broken systems need to be identified and black-listed in kernel.

> Also, although you think the long option will set the bar high
> enough it probably will not satisfy anyone. It is annoying enough, that
> I would just carry a patch to remove it the silly requirement.

That sounds reasonable. Anyone who can carry a kernel patch
does not need the warning.

> And the the people who believe
> all user mode DMA is evil won't be satisfied either.
> But I really like having the same consistent API for handling device
> access with IOMMU and when IOMMU will/won't work.

I agree that's good. Makes it easier to migrate applications to
the safe configuration down the road. Thanks Alex!

-- 
mST
