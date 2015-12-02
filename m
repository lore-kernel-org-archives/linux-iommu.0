From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio: Include No-IOMMU mode
Date: Wed, 02 Dec 2015 08:28:43 -0700
Message-ID: <1449070123.15753.35.camel@redhat.com>
References: <20151028211309.14155.23867.stgit@gimli.home>
 <1447693613.3946.258.camel@redhat.com> <564A0E70.4030409@scylladb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <dev-bounces@dpdk.org>
In-Reply-To: <564A0E70.4030409@scylladb.com>
List-Unsubscribe: <http://dpdk.org/ml/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://dpdk.org/ml/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <http://dpdk.org/ml/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org
Sender: "dev" <dev-bounces@dpdk.org>
To: Avi Kivity <avi@scylladb.com>
Cc: gleb@scylladb.com, mst@redhat.com, "<dev@dpdk.org>" <dev@dpdk.org>, corbet@lwn.net, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hjk@hansjkoch.de, gregkh@linuxfoundation.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2015-11-16 at 19:12 +0200, Avi Kivity wrote:
> On 11/16/2015 07:06 PM, Alex Williamson wrote:
> > On Wed, 2015-10-28 at 15:21 -0600, Alex Williamson wrote:
> >> There is really no way to safely give a user full access to a DMA
> >> capable device without an IOMMU to protect the host system.  There is
> >> also no way to provide DMA translation, for use cases such as device
> >> assignment to virtual machines.  However, there are still those users
> >> that want userspace drivers even under those conditions.  The UIO
> >> driver exists for this use case, but does not provide the degree of
> >> device access and programming that VFIO has.  In an effort to avoid
> >> code duplication, this introduces a No-IOMMU mode for VFIO.
> >>
> >> This mode requires building VFIO with CONFIG_VFIO_NOIOMMU and enabling
> >> the "enable_unsafe_noiommu_mode" option on the vfio driver.  This
> >> should make it very clear that this mode is not safe.  Additionally,
> >> CAP_SYS_RAWIO privileges are necessary to work with groups and
> >> containers using this mode.  Groups making use of this support are
> >> named /dev/vfio/noiommu-$GROUP and can only make use of the special
> >> VFIO_NOIOMMU_IOMMU for the container.  Use of this mode, specifically
> >> binding a device without a native IOMMU group to a VFIO bus driver
> >> will taint the kernel and should therefore not be considered
> >> supported.  This patch includes no-iommu support for the vfio-pci bus
> >> driver only.
> >>
> >> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> >> ---
> >>
> >> This is pretty well the same as RFCv2, I've changed the pr_warn to a
> >> dev_warn and added another, printing the pid and comm of the task when
> >> it actually opens the device.  If Stephen can port the driver code
> >> over and prove that this actually works sometime next week, and there
> >> aren't any objections to this code, I'll include it in a pull request
> >> for the next merge window.  MST, I dropped your ack due to the
> >> changes, but I'll be happy to add it back if you like.  Thanks,
> >>
> >> Alex
> >>
> >>   drivers/vfio/Kconfig        |   15 +++
> >>   drivers/vfio/pci/vfio_pci.c |    8 +-
> >>   drivers/vfio/vfio.c         |  186 ++++++++++++++++++++++++++++++++++++++++++-
> >>   include/linux/vfio.h        |    3 +
> >>   include/uapi/linux/vfio.h   |    7 ++
> >>   5 files changed, 209 insertions(+), 10 deletions(-)
> > FYI, this is now in v4.4-rc1 (the slightly modified v2 version).  I want
> > to give fair warning though that while we seem to agree on this idea, it
> > hasn't been proven with a userspace driver port.  I've opted to include
> > it in this merge window rather than delaying it until v4.5, but I really
> > need to see a user for this before the end of the v4.4 cycle or I think
> > we'll need to revert and revisit for v4.5 anyway.  I don't really have
> > any interest in adding and maintaining code that has no users.  Please
> > keep me informed of progress with a dpdk port.  Thanks,
> >
> >
> 
> Thanks Alex.  Copying the dpdk mailing list, where the users live.
> 
> dpdk-ers: vfio-noiommu is a replacement for uio_pci_generic and 
> uio_igb.  It supports MSI-X and so can be used on SR/IOV VF devices.  
> The intent is that you can use dpdk without an external module, using 
> vfio, whether you are on bare metal with an iommu, bare metal without an 
> iommu, or virtualized.  However, dpdk needs modification to support this.


Still no users for this that I'm aware of.  I'm going to revert this in
rc5 unless something changes.  Thanks,

Alex
