From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V7 00/11] IOMMU probe deferral support
Date: Mon, 30 Jan 2017 14:50:35 +0530
Message-ID: <005801d27ada$2127ee90$6377cbb0$@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
	<20170128211029.GI20550@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170128211029.GI20550-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
To: 'Bjorn Helgaas' <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Bjorn,

>On Mon, Jan 23, 2017 at 09:48:02PM +0530, Sricharan R wrote:
>> This series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
>> ...
>
>>  arch/arm64/mm/dma-mapping.c       | 132 ++++----------------------------------
>>  drivers/acpi/arm64/iort.c         |  40 +++++++++++-
>>  drivers/acpi/glue.c               |   5 --
>>  drivers/acpi/scan.c               |   7 +-
>>  drivers/base/dd.c                 |   9 +++
>>  drivers/base/dma-mapping.c        |  41 ++++++++++++
>>  drivers/iommu/arm-smmu-v3.c       |  46 +------------
>>  drivers/iommu/arm-smmu.c          |  58 +++--------------
>>  drivers/iommu/of_iommu.c          | 114 +++++++++++++++++++++++---------
>>  drivers/of/address.c              |  20 +++++-
>>  drivers/of/device.c               |  36 ++++++-----
>>  drivers/of/platform.c             |  10 +--
>>  drivers/pci/probe.c               |  28 --------
>>  include/acpi/acpi_bus.h           |   2 +-
>>  include/asm-generic/vmlinux.lds.h |   1 -
>>  include/linux/acpi.h              |   7 +-
>>  include/linux/acpi_iort.h         |   3 -
>>  include/linux/dma-mapping.h       |   3 +
>>  include/linux/of_device.h         |  10 ++-
>>  19 files changed, 252 insertions(+), 320 deletions(-)
>
>I'm assuming this will go via some other tree, maybe the IOMMU tree?
>I acked the PCI parts, so let me know if you need anything more from me.

Thanks for the review/acks.
Ya, via the IOMMU tree looks correct.

Regards,
 Sricharan
