From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V6 06/11] drivers: platform: Configure dma operations at
	probe time
Date: Mon, 23 Jan 2017 19:44:32 +0530
Message-ID: <007a01d27583$09279400$1b76bc00$@codeaurora.org>
References: <1484939748-31591-1-git-send-email-sricharan@codeaurora.org>
	<1484939748-31591-7-git-send-email-sricharan@codeaurora.org>
	<20170123120729.GB12593@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170123120729.GB12593@red-moon>
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
To: 'Lorenzo Pieralisi' <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Lorenzo,

>-----Original Message-----
>From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
>Sent: Monday, January 23, 2017 5:37 PM
>To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>Cc: robin.murphy-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
>kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
>Subject: Re: [PATCH V6 06/11] drivers: platform: Configure dma operations at probe time
>
>[+bjorn]
>
>On Sat, Jan 21, 2017 at 12:45:43AM +0530, Sricharan R wrote:
>> Configuring DMA ops at probe time will allow deferring device probe when
>> the IOMMU isn't available yet. The dma_configure for the device is
>> now called from the generic device_attach callback just before the
>> bus/driver probe is called. This way, configuring the DMA ops for the
>> device would be called at the same place for all bus_types, hence the
>> deferred probing mechanism should work for all buses as well.
>>
>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>        |                         |
>> pci_bus_add_device     (device_add/driver_register)
>>        |                         |
>> device_attach           device_initial_probe
>>        |                         |
>> __device_attach_driver    __device_attach_driver
>>        |
>> driver_probe_device
>>        |
>> really_probe
>>        |
>> dma_configure
>>
>> Similarly on the device/driver_unregister path __device_release_driver is
>> called which inturn calls dma_deconfigure.
>>
>> This patch changes the dma ops configuration time to probe time for
>> both OF and ACPI based devices.
>
>For all device types, inclusive of PCI, so please you have to:
>
>- Update the $SUBJECT
>- Copy linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>- Copy linux-acpi-u79uwXL29TZUIDd8j+nm9g@public.gmane.org org (on the series)

Sure, i will just see till tomorrow for any further comments and
repost with $SUBJECT modified and the lists

Regards,
 Sricharan
