From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Thu, 15 Jan 2015 11:57:04 +0900
Message-ID: <54B72C80.5010400@nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-9-git-send-email-will.deacon@arm.com>
	<54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150114104610.GC4050-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 01/14/2015 07:46 PM, Will Deacon wrote:
> Hi Alex,
>
> On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
>> On 12/02/2014 01:57 AM, Will Deacon wrote:
>>> This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
>>> actually called outside of a few drivers) into arch_setup_dma_ops, so
>>> that we can use IOMMUs for DMA transfers in a more generic fashion.
>>>
>>> Since this significantly complicates the arch_setup_dma_ops function,
>>> it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
>>> is not set, the iommu parameter is ignored and the normal ops are used
>>> instead.
>>
>> A series for IOMMU support with Tegra/Nouveau ceased to work after this
>> patch.
>
> Which series? This code shouldn't even be executed unless you start using
> of_xlate and the generic bindings.
>
>> The Tegra IOMMU is not registered by the time the DT is parsed,
>> and thus all devices end up without the proper DMA ops set up because
>> the phandle to the IOMMU cannot be resolved.
>
> You might want to look at the patches posted for the exynos, renesas and ARM
> SMMUs for some hints in how to use the new API.
>
>> Subsequently calling arm_iommu_create_mapping() and
>> arm_iommu_attach_device() from the driver (as I used to do until 3.18)
>> does not help since the call to set_dma_ops() has been moved out of
>> arm_iommu_attach_device(). Therefore there seems to be no way for a device
>> to gets its correct DMA ops unless the IOMMU is ready by the time the DT
>> is parsed.
>>
>> Also potentially affected by this are the Rockchip DRM and OMAP3 ISP
>> drivers, which follow the same pattern.
>
> I don't understand why any code currently in mainline should be affected.
> Please can you elaborate on the failure case?

Here is the sequence of events:

1) DT is populated and of_dma_configure() is called for every device. 
Here is the stack trace:

of_dma_configure
of_platform_device_create_pdata
of_platform_bus_create
of_platform_bus_create
of_platform_populate
customize_machine
do_one_initcall

of_dma_configure() is supposed to set the iommu_ops for every device 
(and this is currently the only place in the kernel where this can 
happen), but since the IOMMU is not ready yet it falls back to the 
default arm_dma_ops.

2) Driver calls arm_iommu_create_mapping() and arm_iommu_attach_device() 
(which were already called during step 1 btw). Both calls succeed, but 
since arm_iommu_attach_device() does not change the ops anymore we are 
still left with arm_dma_ops.

3) Things don't go well. :)

There are several problems with the way things are currently setup IMHO:

1) CONFIG_ARM_DMA_USE_IOMMU forcibly makes the DMA API go through the 
IOMMU. This effectively forbids the simultaneous use of the IOMMU API 
and DMA API because of address-space collisions issue. Being a kernel 
config option, there is no way to turn this behavior off which will 
likely become a problem for multi-configs where some platforms might 
want this and some other not.

2) IIUC arm_iommu_*() are now not supposed to be called directly by 
drivers anymore. At least that's what their current behavior makes me 
think, as well as the fact that they are not defined if 
CONFIG_ARM_DMA_USE_IOMMU is not set. Yet they are still public and 
drivers that use them have not been updated consequently.

3) This is a longer-standing issue, but IIUC the fact that the IOMMU VM 
used by the DMA API is not available effectively prevents anyone from 
using the DMA API behind a IOMMU and the IOMMU API simultaneously (which 
you now have to assume is always the case because of 1)).

These are huge issues - under the current conditions the only safe path 
for me is to eschew the DMA API completely and port my work to the IOMMU 
API, and I suspect this will affect other people as well.

>
>> This raises the following questions:
>>
>> 1) Why are arm_iommu_create_mapping() and arm_iommu_attach_device()
>> still public since they cannot set the DMA ops and thus seem to be
>> useless outside of arch_setup_dma_ops()?
>
> It has callers outside of the file. I'd like to make it static, but that
> means doing some non-trivial porting of all the callers, which I'm also
> unable to test.

Yeah, but all the callers of these functions are broken anyway as of 
3.18-rc4...

>
>> 2) Say you want to use the IOMMU API in your driver, and have an iommu
>> property in your device's DT node. If by chance your IOMMU is registered
>> early, you will already have a mapping automatically created even before
>> your probe function is called. Can this be avoided? Is it even safe?
>
> Currently, I think you have to either teardown the ops manually or return
> an error from of_xlate. Thierry was also looking at this sort of thing,
> so it might be worth talking to him.

Tearing down the ops manually does not sound like something drivers 
should do - how can they even be aware of the private dma_ops anyway?

Thanks,
Alex.
