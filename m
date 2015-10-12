From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH 2/2] vfio: Include no-iommu mode
Date: Mon, 12 Oct 2015 08:56:07 -0700
Message-ID: <20151012085607.2c64f98f@urahara>
References: <20151009182228.14752.99700.stgit@gimli.home>
	<20151009184110.14752.53531.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151009184110.14752.53531.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: avi@scylladb.com, avi@cloudius-systems.com, gleb@scylladb.com, corbet@lwn.net, bruce.richardson@intel.com, mst@redhat.com, linux-kernel@vger.kernel.org, alexander.duyck@gmail.com, gleb@cloudius-systems.com, vladz@cloudius-systems.com, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 09 Oct 2015 12:41:10 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> There is really no way to safely give a user full access to a PCI
> without an IOMMU to protect the host from errant DMA.  There is also
> no way to provide DMA translation, for use cases such as devices
> assignment to virtual machines.  However, there are still those users
> that want userspace drivers under those conditions.  The UIO driver
> exists for this use case, but does not provide the degree of device
> access and programming that VFIO has.  In an effort to avoid code
> duplication, this introduces a No-IOMMU mode for VFIO.
> 
> This mode requires enabling CONFIG_VFIO_NOIOMMU and loading the vfio
> module with the option "enable_unsafe_pci_noiommu_mode".  This should
> make it very clear that this mode is not safe.  In this mode, there is
> no support for unprivileged users, CAP_SYS_ADMIN is required for
> access to the necessary dev files.  Mixing no-iommu and secure VFIO is
> also unsupported, as are any VFIO IOMMU backends other than the
> vfio-noiommu backend.  Furthermore, unsafe group files are relocated
> to /dev/vfio-noiommu/.  Upon successful loading in this mode, the
> kernel is tainted due to the dummy IOMMU put in place.  Unloading of
> the module in this mode is also unsupported and will BUG due to the
> lack of support for unregistering an IOMMU for a bus type.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Will this work for distro's where chaning kernel command line options
is really not that practical. We need to boot with one command line
and then decide to use IOMMU (or not) later on during the service
startup of the dataplane application. Recent experience is that IOMMU's
are broken on many platforms so the only way to make a DPDK application
it to write a test program that can be used to check if VFIO+IOMMU
works first.

Also, although you think the long option will set the bar high
enough it probably will not satisfy anyone. It is annoying enough, that
I would just carry a patch to remove it the silly requirement.
And the the people who believe
all user mode DMA is evil won't be satisfied either.

But I really like having the same consistent API for handling device
access with IOMMU and when IOMMU will/won't work.
