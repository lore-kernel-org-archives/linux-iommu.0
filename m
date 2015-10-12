From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Mon, 12 Oct 2015 10:23:19 -0600
Message-ID: <1444666999.4059.362.camel@redhat.com>
References: <20151009182228.14752.99700.stgit@gimli.home>
	 <20151009184110.14752.53531.stgit@gimli.home>
	 <20151012085607.2c64f98f@urahara>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151012085607.2c64f98f@urahara>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: avi@scylladb.com, avi@cloudius-systems.com, gleb@scylladb.com, corbet@lwn.net, bruce.richardson@intel.com, mst@redhat.com, linux-kernel@vger.kernel.org, alexander.duyck@gmail.com, gleb@cloudius-systems.com, vladz@cloudius-systems.com, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-10-12 at 08:56 -0700, Stephen Hemminger wrote:
> On Fri, 09 Oct 2015 12:41:10 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
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
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Will this work for distro's where chaning kernel command line options
> is really not that practical. We need to boot with one command line
> and then decide to use IOMMU (or not) later on during the service
> startup of the dataplane application. Recent experience is that IOMMU's
> are broken on many platforms so the only way to make a DPDK application
> it to write a test program that can be used to check if VFIO+IOMMU
> works first.

There's no kernel command line dependency, if you find that VFIO+IOMMU
doesn't work, unload the vfio modules and reload with the no-iommu
option and try again.  VFIO itself cannot simply fall back to no-iommu,
that definitely needs to be a user opt-in.  The userspace app though
should easily be able to tell when the type1 model is not available and
fall back to no-iommu.

> Also, although you think the long option will set the bar high
> enough it probably will not satisfy anyone. It is annoying enough, that
> I would just carry a patch to remove it the silly requirement.
> And the the people who believe
> all user mode DMA is evil won't be satisfied either.

I find that many users blindly follow howtos and only sometimes do they
question the options if they sound scary enough.  So yeah, I would
intend to make the option upstream sound scary enough for people to
think twice about using it and maybe even read the description.  That
still doesn't prevent pasting it into modprobe.d and forgetting about
it.

I don't see non-IOMMU protected usermode DMA as evil, it's just
unsupportable and I want to be able to immediately know that it's a
possibility if I'm looking at a kernel bug.

> But I really like having the same consistent API for handling device
> access with IOMMU and when IOMMU will/won't work.

We still need to hear from IOMMU folks, AIUI there are plans to
implement dma_iops via iommu_ops, which would make squatting on
iommu_ops much more difficult for a hack like this.  Thanks,

Alex
