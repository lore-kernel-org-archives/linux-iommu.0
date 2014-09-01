From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 10/29] drivers: add DRIVER_HAS_OWN_IOMMU_MANAGER flag
Date: Mon, 01 Sep 2014 09:53:29 +0200
Message-ID: <540425F9.7080307@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
	<1407235677-26324-11-git-send-email-m.szyprowski@samsung.com>
	<54040298.9020002@samsung.com> <20140901070748.GA24226@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140901070748.GA24226-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 2014-09-01 09:07, Thierry Reding wrote:
> On Mon, Sep 01, 2014 at 07:22:32AM +0200, Marek Szyprowski wrote:
>> Hi Greg,
>>
>> On 2014-08-05 12:47, Marek Szyprowski wrote:
>>> This patch adds a new flags for device drivers. This flag instructs
>>> kernel that the device driver does it own management of IOMMU assisted
>>> IO address space translations, so no default dma-mapping structures
>>> should be initialized.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>> ---
>>>    include/linux/device.h | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/linux/device.h b/include/linux/device.h
>>> index 5f4ff02..2e62371 100644
>>> --- a/include/linux/device.h
>>> +++ b/include/linux/device.h
>>> @@ -253,6 +253,8 @@ struct device_driver {
>>>    
>>>    /* disables bind/unbind via sysfs */
>>>    #define DRIVER_SUPPRESS_BIND_ATTRS	(1 << 0)
>>> +/* driver uses own methods to manage IO address space */
>>> +#define DRIVER_HAS_OWN_IOMMU_MANAGER	(1 << 1)
>>>    
>>>    extern int __must_check driver_register(struct device_driver *drv);
>>>    extern void driver_unregister(struct device_driver *drv);
>> Could you comment if the approach of using flags in the struct driver
>> could be accepted? I've converted suppress_bind_attrs entry to flags to
>> avoid extending the structure, please see patch "[PATCH 05/29] drivers:
>> convert suppress_bind_attrs parameter into flags".
> Is this really necessary? What I did as part of an RFC series for Tegra
> IOMMU support is keep this knowledge within the IOMMU driver rather than
> export it to the driver core.i

The problem with embedding the list of drivers that you would need to update
it everytime when you modify or extend iommu support in the other drivers.
I've tried also other approach, like adding respective notifiers to 
individual
drivers to initialize custom iommu support (or disable default iommu 
mapping)
before iommu driver gets initialized, but such solution is in my opinion too
complex and hard to understand if one is not familiar will all this stuff.

All in all it turned out that the simplest and most generic way is to simply
add the flag to the driver core. Flags might be also used in the future
to model other kinds of dependencies between device drivers and/or driver
core.

> The idea being that the IOMMU driver wouldn't create an ARM DMA/IOMMU
> mapping by default but rather allow individual drivers to be marked as
> "kernel-internal" and use the DMA/IOMMU glue in that case. Drivers such
> as DRM would use the IOMMU API directly.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
