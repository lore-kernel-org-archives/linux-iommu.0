From: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] Initial skeleton of VFIO support for Device Tree
	based devices
Date: Mon, 5 Aug 2013 14:50:33 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E1503663FB7@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1375708632-26356-1-git-send-email-a.motakis@virtualopensystems.com>
	<1375708632-26356-3-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1375708632-26356-3-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "agraf-l3A5Bk7waGM@public.gmane.org" <agraf-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> +MODULE_VERSION(DRIVER_VERSION);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR(DRIVER_AUTHOR);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 284ff24..1e4bef2 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -147,6 +147,7 @@ struct vfio_device_info {
>  	__u32	flags;
>  #define VFIO_DEVICE_FLAGS_RESET	(1 << 0)	/* Device supports reset
> */
>  #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
> +#define VFIO_DEVICE_FLAGS_DT	(1 << 2)	/* vfio-dt device */
>  	__u32	num_regions;	/* Max region index + 1 */
>  	__u32	num_irqs;	/* Max IRQ index + 1 */
>  };

In the RFC I sent out the proposed flags were:

   #define VFIO_DEVICE_FLAGS_PLATFORM (1 << ?) /* A platform bus device */
   #define VFIO_DEVICE_FLAGS_DEVTREE  (1 << ?) /* device tree info available */

Since you are only implementing the first part, the platform
device support, just call it:  VFIO_DEVICE_FLAGS_PLATFORM

I think the 'platform' term is more accurate as we are providing
a mechanism to expose devices on the /sys/bus/platform bus to
user space.

Stuart
