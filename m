From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC 0/4] VFIO: PLATFORM: Return device tree info for a platform
	device node
Date: Thu, 21 Aug 2014 14:19:32 +0200
Message-ID: <CAG8rG2zteFC=S8zPrzAB_bFZon=oP8w30Z1bRm46SoHsHH=62Q@mail.gmail.com>
References: <1407927740-14993-1-git-send-email-a.motakis@virtualopensystems.com>
	<53F3B32C.6080101@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53F3B32C.6080101-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joel Schopp <joel.schopp-5C7GfCeVMHo@public.gmane.org>
Cc: Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, alvise rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 19, 2014 at 10:27 PM, Joel Schopp <joel.schopp-5C7GfCeVMHo@public.gmane.org> wrote:
>
>
> > This RFC's intention is to show what an interface to access device node
> > properties for VFIO_PLATFORM can look like.
> >
> > If a device tree node corresponding to a platform device bound by VFIO_PLATFORM
> > is available, this patch series will allow the user to query the properties
> > associated with this device node. This can be useful for userspace drivers
> > to automatically query parameters related to the device.
> >
> > An API to return data from a device's device tree has been proposed before on
> > these lists. The API proposed here is slightly different.
> >
> > Properties to parse from the device tree are not indexed by a numerical id.
> > The host system doesn't guarantee any specific ordering for the available
> > properties, or that those will remain the same; while this does not happen in
> > practice, there is nothing from the host changing the device nodes during
> > operation. So properties are accessed by property name.
> >
> > The type of the property accessed must also be known by the user. Properties
> > types implemented in this RFC:
> > - VFIO_DEVTREE_ARR_TYPE_STRING (strings sepparated by the null character)
> > - VFIO_DEVTREE_ARR_TYPE_U32
> > - VFIO_DEVTREE_ARR_TYPE_U16
> > - VFIO_DEVTREE_ARR_TYPE_U8
> >
> > These can all be access by the ioctl VFIO_DEVICE_GET_DEVTREE_INFO. A new ioctl
> > was preferred instead of shoehorning the functionality in VFIO_DEVICE_GET_INFO.
> > The structure exchanged looks like this:
>
> You'll have to forgive my ignorance on the history.  But with the dtc
> tool already supporting a filesystem representation (--in-format=fs),
> with the dtc tool source already built into qemu, and having an example
> implementation of such an interface in /proc/device-tree/ why is an
> ioctl interface preferred over a filesystem interface?
>

Hello Joel,

VFIO already exposes an ioctl interface, so from the side of VFIO I
think it wouldn't make sense to add another interface just for the
device node data of the target device. I don't think the existing
/proc interface would be appropriate to use since (1) you would have
to give to the VFIO user (e.g. QEMU) access to the whole hierarchy (2)
the VFIO user would have to implement logic to figure out which node
it needs to get data from.

One thing to keep in mind is that VFIO is not designed to be used only
by QEMU. Taking as an example a hypothetical user space driver for the
PL330 DMAC, I think it makes sense to be able to directly get from
VFIO the right values for #dma-cells, #dma-channels, #dma-requests,
etc.

Of course QEMU could let the user override any values via any format
QEMU supports, but IMHO out of the box it would make sense to use an
interface such as the proposed one.

-- 
Antonios Motakis
Virtual Open Systems
