From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH v4 00/10] IOMMU probe deferral support
Date: Wed, 30 Nov 2016 16:58:33 +0530
Message-ID: <000201d24afc$e5612a50$b0237ef0$@codeaurora.org>
References: <CGME20161130002326epcas2p462e9291a284c562b3cfeb2ee4339c5af@epcas2p4.samsung.com>
	<1480465344-11862-1-git-send-email-sricharan@codeaurora.org>
	<90b1ad92-f7e6-b512-0676-90b96af10710@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <90b1ad92-f7e6-b512-0676-90b96af10710-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, robin.murphy-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

>
>On 2016-11-30 01:22, Sricharan R wrote:
>> This series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
>>
>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>         |                         |
>> pci_bus_add_device     (device_add/driver_register)
>>         |                         |
>> device_attach           device_initial_probe
>>         |                         |
>> __device_attach_driver    __device_attach_driver
>>         |
>> driver_probe_device
>>         |
>> really_probe
>>         |
>> dma_configure
>>
>> Similarly on the device/driver_unregister path __device_release_driver is
>> called which inturn calls dma_deconfigure.
>>
>> Took the reworked patches [2] from Robin's branch and
>> rebased on top of Lorenzo's ACPI IORT ARM support series [3].
>>
>> Tested with platform and pci devices for probe deferral
>> and reprobe on arm64 based platform. Added the patches [9,10],
>>      drivers: acpi: Configure acpi devices dma operation at probe time
>>      drivers: acpi: Handle IOMMU lookup failure with deferred probing or error
>> for doing the dma ops configuration at probe time for acpi based platform
>> as well. Did not have a acpi based platform to test the changes and with
>> my still catching up knowledge on acpi/enumeration those two patches needs
>> to be reviewed/tested more.
>
>I've checked this patchset on my development boards: Odroid U3
>(ARM/Exynos4412),
>XU3 (ARM/Exynos5422) and TM2 (ARM64/Exynos5433) and my queued patches
>for Exynos
>IOMMU driver [1]. Besides the issue with an excessive dev_info, which
>causes NULL
>pointer dereference (reported in reply to patch #6), it works fine on
>all those
>platforms! Please add (again) my:
>
>Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>
>[1] https://www.spinics.net/lists/linux-samsung-soc/msg56354.html
>
>> Previous post of this series [5].

Thanks for the testing every time.

Regards,
 Sricharan

>>
>>   [V4]
>>       * Took the reworked patches [2] from Robin's branch and
>>         rebased on top of Lorenzo's ACPI IORT ARM support series [3].
>>
>>       * Added the patches for moving the dma ops configuration of
>>         acpi based devices to probe time as well.
>>   [V3]
>>       * Removed the patch to split dma_masks/dma_ops configuration
>>         separately based on review comments that both masks and ops are
>>         required only during the device probe time.
>>
>>       * Reworked the series based on Generic DT bindings series.
>>
>>       * Added call to iommu's remove_device in the cleanup path for arm and
>>         arm64.
>>
>>       * Removed the notifier trick in arm64 to handle early device
>>         registration.
>>
>>       * Added reset of dma_ops in cleanup path for arm based on comments.
>>
>>       * Fixed the pci_iommu_configure path and tested with PCI device as
>>         well.
>>
>>       * Fixed a bug to return the correct iommu_ops from patch 7 [4] in
>>         last post.
>>
>>       * Fixed few other cosmetic comments.
>>
>>   [V2]
>>       * Updated the Initial post to call dma_configure/deconfigure from
>>         generic code
>>
>>       * Added iommu add_device callback from of_iommu_configure path
>>
>>   [V1]
>>       * Initial post from Laurent Pinchart [1]
>>
>> [1] http://lists.linuxfoundation.org/pipermail/iommu/2015-May/013016.html
>> [2] http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/defer
>> [3] https://lkml.org/lkml/2016/11/21/141
>> [4] https://www.mail-archive.com/iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org/msg13940.html
>> [5] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/460832.html
>>
>> Laurent Pinchart (3):
>>    of: dma: Move range size workaround to of_dma_get_range()
>>    of: dma: Make of_dma_deconfigure() public
>>    iommu: of: Handle IOMMU lookup failure with deferred probing or error
>>
>> Robin Murphy (3):
>>    iommu/of: Refactor of_iommu_configure() for error handling
>>    iommu/of: Prepare for deferred IOMMU configuration
>>    iommu/arm-smmu: Clean up early-probing workarounds
>>
>> Sricharan R (4):
>>    drivers: platform: Configure dma operations at probe time
>>    arm64: dma-mapping: Remove the notifier trick to handle early setting
>>      of dma_ops
>>    drivers: acpi: Configure acpi devices dma operation at probe time
>>    drivers: acpi: Handle IOMMU lookup failure with deferred probing or
>>      error
>>
>>   arch/arm64/mm/dma-mapping.c | 132 ++++----------------------------------------
>>   drivers/acpi/arm64/iort.c   |  17 +++++-
>>   drivers/acpi/glue.c         |   6 --
>>   drivers/acpi/scan.c         |   7 ++-
>>   drivers/base/dd.c           |  10 ++++
>>   drivers/base/dma-mapping.c  |  32 +++++++++++
>>   drivers/iommu/arm-smmu-v3.c |  35 +-----------
>>   drivers/iommu/arm-smmu.c    |  58 +++----------------
>>   drivers/iommu/dma-iommu.c   |   1 +
>>   drivers/iommu/of_iommu.c    | 114 +++++++++++++++++++++++++++-----------
>>   drivers/of/address.c        |  20 ++++++-
>>   drivers/of/device.c         |  36 ++++++------
>>   drivers/of/platform.c       |  10 +---
>>   drivers/pci/probe.c         |  17 +++---
>>   include/acpi/acpi_bus.h     |   2 +-
>>   include/linux/acpi.h        |   7 ++-
>>   include/linux/dma-mapping.h |   3 +
>>   include/linux/of_device.h   |  10 +++-
>>   include/linux/pci.h         |   5 ++
>>   19 files changed, 238 insertions(+), 284 deletions(-)
>>
>
>Best regards
>--
>Marek Szyprowski, PhD
>Samsung R&D Institute Poland
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
