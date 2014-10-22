From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH v2 0/4] vfio: platform: return device tree info for
	a platform device node
Date: Wed, 22 Oct 2014 15:56:59 -0600
Message-ID: <1414015019.4202.281.camel@ul30vt.home>
References: <1413474876-28544-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1413474876-28544-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-10-16 at 17:54 +0200, Antonios Motakis wrote:
> This RFC's intention is to show what an interface to access device node
> properties for the VFIO platform driver can look like.
> 
> If a device tree node corresponding to a platform device bound by VFIO PLATFORM
> or VFIO AMBA is available, this patch series will allow the user to query the
> properties associated with this device node. This can be useful for userspace
> drivers to automatically query parameters related to the device.
> 
> An API to return data from a device's device tree has been proposed before on
> these lists. The API proposed here is slightly different.
> 
> Properties to parse from the device tree are not indexed by a numerical id.
> The host system doesn't guarantee any specific ordering for the available
> properties, or that those will remain the same; while this does not happen in
> practice, there is nothing from the host changing the device nodes during
> operation. For this reason in this RFC properties are accessed by property name.
> 
> The type of the property accessed must also be known by the user. Properties
> types implemented in this RFC:
> - VFIO_DEVTREE_TYPE_STRINGS (strings sepparated by the null character)
> - VFIO_DEVTREE_TYPE_U32
> - VFIO_DEVTREE_TYPE_U16
> - VFIO_DEVTREE_TYPE_U8
> 
> These can all be access by the ioctl VFIO_DEVICE_GET_DEVTREE_INFO. A new ioctl
> was preferred instead of shoehorning the functionality in VFIO_DEVICE_GET_INFO.
> The structure exchanged with userspace looks like this:
> 
> /**
>  * VFIO_DEVICE_GET_DEVTREE_INFO - _IOR(VFIO_TYPE, VFIO_BASE + 16,
>  *						struct vfio_devtree_info)
>  *
>  * Retrieve information from the device's device tree, if available.
>  * Caller will initialize data[] with a single string with the requested
>  * devicetree property name, and type depending on whether a array of strings
>  * or an array of u32 values is expected. On success, data[] will be extended
>  * with the requested information, either as an array of u32, or with a list
>  * of strings sepparated by the NULL terminating character.
>  * Return: 0 on success, -errno on failure.
>  */
> struct vfio_devtree_info {
> 	__u32	argsz;
> 	__u32	type;
> #define VFIO_DEVTREE_PROP_LIST		0
> #define VFIO_DEVTREE_TYPE_STRINGS	1
> #define VFIO_DEVTREE_TYPE_U8		2
> #define VFIO_DEVTREE_TYPE_U16		3
> #define VFIO_DEVTREE_TYPE_U32		4
> 	__u32	length;
> 	__u8	data[];
> };
> #define VFIO_DEVICE_GET_DEVTREE_INFO	_IO(VFIO_TYPE, VFIO_BASE + 17)

Seems pretty reasonable.  We should add a flags variable to
vfio_devtree_info as well.  General question, in order to get a VFIO
device file descriptor, the user already needs to know the name of the
device.  Presumably they'll get this from sysfs or otherwise just know
it in advance.  Is that redundant information to what we're providing
here?  What other information already exists in sysfs for device tree
devices that we're duplicating here for the sake of creating a VFIO
mechanism?  If it's not already exposed in sysfs, should it be?  Thanks,

Alex

> The length of the property will be reported in length, so the user can reallocate
> the structure if the data does not fit the first time the call is used.
> 
> Specifically for QEMU, reading the "compatible" property of the device tree
> node could be of use to find out what device is being assigned to the guest and
> handle appropriately a wider range of devices in the future, and to generate an
> appropriate device tree for the guest.
> 
> TODOs:
>  - 64 bit values support
>  - We can consider to rebase this on the patch series by Rafael J. Wysocki:
>    "[PATCH v4 00/13] Add ACPI _DSD and unified device properties support"
>    This would make 64 bit support more straightforward as it already includes
>    the APIs we need for 64 bit OF values.
> 
> Changes since v1:
>  - Updated for VFIO platform patch series v8:
>    VFIO AMBA devices now supported in addition to VFIO PLATFORM devices
>  - Refactored and cleaned up the code
> 
> Antonios Motakis (4):
>   vfio: platform: add device tree info API and skeleton
>   vfio: platform: devtree: return available property names
>   vfio: platform: devtree: access property as a list of strings
>   vfio: platform: devtree: return arrays of u32, u16, or u8 data
> 
>  drivers/vfio/platform/Makefile                |   3 +-
>  drivers/vfio/platform/devtree.c               | 199 ++++++++++++++++++++++++++
>  drivers/vfio/platform/vfio_platform_common.c  |  39 +++++
>  drivers/vfio/platform/vfio_platform_private.h |   6 +
>  include/uapi/linux/vfio.h                     |  26 ++++
>  5 files changed, 272 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/vfio/platform/devtree.c
> 
