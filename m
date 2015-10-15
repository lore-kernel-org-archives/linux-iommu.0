From: Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC PATCH v2] vfio: Include No-IOMMU mode
Date: Thu, 15 Oct 2015 15:40:25 -0700
Message-ID: <20151015154025.6c9a17cf@xeon-e3>
References: <20151014212933.22236.22913.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151014212933.22236.22913.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: avi@scylladb.com, avi@cloudius-systems.com, gleb@scylladb.com, corbet@lwn.net, bruce.richardson@intel.com, mst@redhat.com, linux-kernel@vger.kernel.org, alexander.duyck@gmail.com, gleb@cloudius-systems.com, vladz@cloudius-systems.com, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 14 Oct 2015 15:51:18 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> There is really no way to safely give a user full access to a DMA
> capable device without an IOMMU to protect the host system.  There is
> also no way to provide DMA translation, for use cases such as device
> assignment to virtual machines.  However, there are still those users
> that want userspace drivers even under those conditions.  The UIO
> driver exists for this use case, but does not provide the degree of
> device access and programming that VFIO has.  In an effort to avoid
> code duplication, this introduces a No-IOMMU mode for VFIO.
> 
> This mode requires building VFIO with CONFIG_VFIO_NOIOMMU and enabling
> the "enable_unsafe_noiommu_mode" option on the vfio driver.  This
> should make it very clear that this mode is not safe.  Additionally,
> CAP_SYS_RAWIO privileges are necessary to work with groups and
> containers using this mode.  Groups making use of this support are
> named /dev/vfio/noiommu-$GROUP and can only make use of the special
> VFIO_NOIOMMU_IOMMU for the container.  Use of this mode, specifically
> binding a device without a native IOMMU group to a VFIO bus driver
> will taint the kernel and should therefore not be considered
> supported.  This patch includes no-iommu support for the vfio-pci bus
> driver only.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

The concept looks good.

I am trying it now to see how well this works for the use case of DPDK
in a VM.
