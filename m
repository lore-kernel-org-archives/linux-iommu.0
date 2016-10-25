From: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V3 0/8] IOMMU probe deferral support
Date: Tue, 25 Oct 2016 11:55:21 +0530
Message-ID: <a9e6492d-381b-1175-5867-74f33be99b89@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475600632-21289-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 10/04/2016 10:33 PM, Sricharan R wrote:
> Initial post from Laurent Pinchart[1]. This is
> series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.
>
>
> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>        |                         |
> pci_bus_add_device     (device_add/driver_register)
>        |                         |
> device_attach           device_initial_probe
>        |                         |
> __device_attach_driver    __device_attach_driver
>        |
> driver_probe_device
>        |
> really_probe
>        |
> dma_configure
>
>  Similarly on the device/driver_unregister path __device_release_driver is
>  called which inturn calls dma_deconfigure.
>
>  If the ACPI bus code follows the same, we can add acpi_dma_configure
>  at the same place as of_dma_configure.
>
>  This series is based on the recently merged Generic DT bindings for
>  PCI IOMMUs and ARM SMMU from Robin Murphy robin.murphy-5wv7dgnIgG8@public.gmane.org [2]
>
>  This time tested this with platform and pci device for probe deferral
>  and reprobe on arm64 based platform. There is an issue on the cleanup
>  path for arm64 though, where there is WARN_ON if the dma_ops is reset while
>  device is attached to an domain in arch_teardown_dma_ops.
>  But with iommu_groups created from the iommu driver, the device is always
>  attached to a domain/default_domain. So so the WARN has to be removed/handled
>  probably.
>

Tested-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

>  Previous post of this series [3].
>
>  [V3]
>      * Removed the patch to split dma_masks/dma_ops configuration separately
>        based on review comments that both masks and ops are required only
>        during the device probe time.
>
>      * Reworked the series based on Generic DT bindings series [2].
>
>      * Added call to iommu's remove_device in the cleanup path for arm and arm64.
>
>      * Removed the notifier trick in arm64 to handle early device registration.
>
>      * Added reset of dma_ops in cleanup path for arm based on comments.
>
>      * Fixed the pci_iommu_configure path and tested with PCI device as well.
>
>      * Fixed a bug to return the correct iommu_ops from patch 7 [4] in last post.
>
>      * Fixed few other cosmetic comments.
>
>  [V2]
>      * Updated the Initial post to call dma_configure/deconfigure from generic code
>
>      * Added iommu add_device callback from of_iommu_configure path
>
>  [V1]
>      * Initial post
>
> [1] http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013016.html
> [2] http://www.spinics.net/lists/devicetree/msg142943.html
> [3] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg13941.html
> [4] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg13940.html
>
>
>
> Laurent Pinchart (4):
>   arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
>   of: dma: Move range size workaround to of_dma_get_range()
>   of: dma: Make of_dma_deconfigure() public
>   iommu: of: Handle IOMMU lookup failure with deferred probing or error
>
> Sricharan R (4):
>   drivers: platform: Configure dma operations at probe time
>   arm: dma-mapping: Reset the device's dma_ops
>   arm/arm64: dma-mapping: Call iommu's remove_device callback during
>     device detach
>   arm64: dma-mapping: Remove the notifier trick to handle early setting
>     of dma_ops
>
>  arch/arm/mm/dma-mapping.c   |  18 ++++++++
>  arch/arm64/mm/dma-mapping.c | 107 +++++---------------------------------------
>  drivers/base/dd.c           |  10 +++++
>  drivers/base/dma-mapping.c  |  11 +++++
>  drivers/iommu/of_iommu.c    |  47 +++++++++++++++++--
>  drivers/of/address.c        |  20 ++++++++-
>  drivers/of/device.c         |  34 +++++++-------
>  drivers/of/platform.c       |   9 ----
>  drivers/pci/probe.c         |   5 +--
>  include/linux/dma-mapping.h |   3 ++
>  include/linux/of_device.h   |   7 ++-
>  11 files changed, 138 insertions(+), 133 deletions(-)
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
