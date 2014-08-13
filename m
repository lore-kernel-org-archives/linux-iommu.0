From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC 0/4] VFIO: PLATFORM: Return device tree info for a platform
	device node
Date: Wed, 13 Aug 2014 13:02:15 +0200
Message-ID: <1407927740-14993-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This RFC's intention is to show what an interface to access device node
properties for VFIO_PLATFORM can look like.

If a device tree node corresponding to a platform device bound by VFIO_PLATFORM
is available, this patch series will allow the user to query the properties
associated with this device node. This can be useful for userspace drivers
to automatically query parameters related to the device.

An API to return data from a device's device tree has been proposed before on
these lists. The API proposed here is slightly different.

Properties to parse from the device tree are not indexed by a numerical id.
The host system doesn't guarantee any specific ordering for the available
properties, or that those will remain the same; while this does not happen in
practice, there is nothing from the host changing the device nodes during
operation. So properties are accessed by property name.

The type of the property accessed must also be known by the user. Properties
types implemented in this RFC:
- VFIO_DEVTREE_ARR_TYPE_STRING (strings sepparated by the null character)
- VFIO_DEVTREE_ARR_TYPE_U32
- VFIO_DEVTREE_ARR_TYPE_U16
- VFIO_DEVTREE_ARR_TYPE_U8

These can all be access by the ioctl VFIO_DEVICE_GET_DEVTREE_INFO. A new ioctl
was preferred instead of shoehorning the functionality in VFIO_DEVICE_GET_INFO.
The structure exchanged looks like this:

/**
 * VFIO_DEVICE_GET_DEVTREE_INFO - _IOR(VFIO_TYPE, VFIO_BASE + 16,
 *						struct vfio_devtree_info)
 *
 * Retrieve information from the device's device tree, if available.
 * Caller will initialize data[] with a single string with the requested
 * devicetree property name, and type depending on whether a array of strings
 * or an array of u32 values is expected. On success, data[] will be extended
 * with the requested information, either as an array of u32, or with a list
 * of strings sepparated by the NULL terminating character.
 * Return: 0 on success, -errno on failure.
 */
struct vfio_devtree_info {
	__u32	argsz;
	__u32	type;
#define VFIO_DEVTREE_PROP_NAMES		0
#define VFIO_DEVTREE_ARR_TYPE_STRING	1
#define VFIO_DEVTREE_ARR_TYPE_U8	2
#define VFIO_DEVTREE_ARR_TYPE_U16	3
#define VFIO_DEVTREE_ARR_TYPE_U32	4
	__u32	length;
	__u8	data[];
};
#define VFIO_DEVICE_GET_DEVTREE_INFO	_IO(VFIO_TYPE, VFIO_BASE + 17)

The length of the property will be reported in length, so the user can reallocate
the structure if the data does not fit the first time the call is used.

Specifically for QEMU, reading the "compatible" property of the device tree
node coul be of use to find out what device is being assigned to the guest and
handle appropriately a wider range of devices in the future, and to generate an
appropriate device tree for the guest.

Antonios Motakis (4):
  VFIO: PLATFORM: Add device tree info API and skeleton
  VFIO: PLATFORM: DEVTREE: Return available property names
  VFIO: PLATFORM: DEVTREE: Access property as a list of strings
  VFIO: PLATFORM: DEVTREE: Return arrays of u32, u16, or u8

 drivers/vfio/platform/Makefile                |   2 +-
 drivers/vfio/platform/devtree.c               | 252 ++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform.c         |  11 ++
 drivers/vfio/platform/vfio_platform_private.h |   7 +
 include/uapi/linux/vfio.h                     |  32 +++-
 5 files changed, 300 insertions(+), 4 deletions(-)
 create mode 100644 drivers/vfio/platform/devtree.c

-- 
1.8.3.2
