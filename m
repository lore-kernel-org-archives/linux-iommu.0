From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V3 0/8] IOMMU probe deferral support
Date: Mon, 24 Oct 2016 18:00:46 +0530
Message-ID: <004c01d22df2$7586f4c0$6094de40$@codeaurora.org>
References: <CGME20161004170414eucas1p141bebe16e1bf241862833e7ad0270c72@eucas1p1.samsung.com>
	<1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<12cfb59f-f7ca-d4df-eb7f-42348e357979@samsung.com>
	<000601d22451$5eb46fc0$1c1d4f40$@codeaurora.org>
	<b9e4e81f-3b3e-951f-df62-d640275aae71@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b9e4e81f-3b3e-951f-df62-d640275aae71-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
To: 'Marek Szyprowski' <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Marek,

>>>> Initial post from Laurent Pinchart[1]. This is
>>>> series calls the dma ops configuration for the devices
>>>> at a generic place so that it works for all busses.
>>>> The dma_configure_ops for a device is now called during
>>>> the device_attach callback just before the probe of the
>>>> bus/driver is called. Similarly dma_deconfigure is called during
>>>> device/driver_detach path.
>>>>
>>>>
>>>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>>>          |                         |
>>>> pci_bus_add_device     (device_add/driver_register)
>>>>          |                         |
>>>> device_attach           device_initial_probe
>>>>          |                         |
>>>> __device_attach_driver    __device_attach_driver
>>>>          |
>>>> driver_probe_device
>>>>          |
>>>> really_probe
>>>>          |
>>>> dma_configure
>>>>
>>>>    Similarly on the device/driver_unregister path __device_release_driver is
>>>>    called which inturn calls dma_deconfigure.
>>>>
>>>>    If the ACPI bus code follows the same, we can add acpi_dma_configure
>>>>    at the same place as of_dma_configure.
>>>>
>>>>    This series is based on the recently merged Generic DT bindings for
>>>>    PCI IOMMUs and ARM SMMU from Robin Murphy robin.murphy-5wv7dgnIgG8@public.gmane.org [2]
>>>>
>>>>    This time tested this with platform and pci device for probe deferral
>>>>    and reprobe on arm64 based platform. There is an issue on the cleanup
>>>>    path for arm64 though, where there is WARN_ON if the dma_ops is reset while
>>>>    device is attached to an domain in arch_teardown_dma_ops.
>>>>    But with iommu_groups created from the iommu driver, the device is always
>>>>    attached to a domain/default_domain. So so the WARN has to be removed/handled
>>>>    probably.
>>> Thanks for continuing work on this feature! Your can add my:
>>>
>>> Tested-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>
>>    Thanks for testing this. So the for the below fix, the remove_device callback
>>    gets called on the dma_ops cleanup path, so would it be easy to remove the
>>    data for the device there ?
>
>I assumed that IOMMU driver cannot be removed reliably, so all
>structures that it
>creates are permanent. I didn't use device_add()/device_remove()
>callbacks, because
>in current implementation device_add() is called too late (after
>dma-mapping glue
>triggers device_attach_iommu()).
>
>Maybe once your patchset is merged, I will move creation and management
>of the all
>IOMMU related structures to device_add/remove callbacks.
>
    ok understand it.

Regards,
Sricharan
