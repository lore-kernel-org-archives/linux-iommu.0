From: sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: Re: [PATCH V8 07/11] iommu: of: Handle IOMMU lookup failure with
	deferred probing or error
Date: Tue, 16 May 2017 19:59:01 +0530
Message-ID: <4484f88d5ce342a3a27a00ef12869acc@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
	<1924197.MWBQ7kvoOo@avalon>
	<5724f819-40db-e830-1ec1-62c887ba39ee@arm.com>
	<1825810.fLbCv8umR7@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1825810.fLbCv8umR7@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 2017-05-16 19:40, Laurent Pinchart wrote:
> Hi Robin,
> 
> On Tuesday 16 May 2017 15:04:55 Robin Murphy wrote:
>> On 16/05/17 08:17, Laurent Pinchart wrote:
>> > On Tuesday 16 May 2017 07:53:57 sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org wrote:
> 
> [snip]
> 
>> >> arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
>> >> ,dma_ops should be cleared in the teardown path. Otherwise
>> >> this causes problem when the probe of device is retried after
>> >> being deferred. The device's iommu structures are cleared
>> >> after EPROBEDEFER error, but on the next try dma_ops will still
>> >> be set to old value, which is not right.
>> >>
>> >> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> >> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> >> ---
>> >>
>> >>   arch/arm/mm/dma-mapping.c | 1 +
>> >>   1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> >> index ab4f745..a40f03e 100644
>> >> --- a/arch/arm/mm/dma-mapping.c
>> >> +++ b/arch/arm/mm/dma-mapping.c
>> >> @@ -2358,6 +2358,7 @@ static void arm_teardown_iommu_dma_ops(struct
>> >> device *dev)
>> >
>> >>   	__arm_iommu_detach_device(dev);
>> >>   	arm_iommu_release_mapping(mapping);
>> >> +	set_dma_ops(dev, NULL);
>> >>   }
>> >>   #else
>> >
>> > The subject mentions arch_teardown_dma_ops(), which I think is correct,
>> > but the patch adds the set_dma_ops() call to arm_teardown_iommu_dma_ops().
>> >
>> > However, the situation is perhaps more complex. Note the check at the
>> > beginning of arch_setup_dma_ops():
>> > 	/*
>> > 	 * Don't override the dma_ops if they have already been set. Ideally
>> > 	 * this should be the only location where dma_ops are set, remove this
>> > 	 * check when all other callers of set_dma_ops will have disappeared.
>> > 	 */
>> > 	if (dev->dma_ops)
>> > 		return;
>> >
>> > If you set the dma_ops to NULL in arm_teardown_iommu_dma_ops() or
>> > arch_teardown_dma_ops(), the next call to arch_setup_dma_ops() will
>> > override them. To be safe you should only set them to NULL if they have
>> > been set by arch_setup_dma_ops(). More than that, arch_teardown_dma_ops()
>> > should probably not call arm_teardown_iommu_dma_ops() at all if the
>> > dma_ops were set by arm_iommu_attach_device() and not
>> > arch_teardown_dma_ops().
>> 
>> Under what circumstances is that an issue? We'll only be tearing down
>> the DMA ops when unbinding the driver,
> 
> Or when deferring probe.
> 
>> and I think it would be erroneous to expect the device to retain much 
>> state
>> after that. Everything else would be set up from scratch again if it 
>> get
>> reprobed later, so why not the DMA ops?
> 
> Because the DMA ops might have been set elsewhere than 
> arch_setup_dma_ops().
> If you look at the patch that added the above warning, its commit 
> message
> states
> 
> commit 26b37b946a5c2658dbc37dd5d6df40aaa9685d70 (iommu-joerg/arm/core)
> Author: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Date:   Fri May 15 02:00:02 2015 +0300
> 
>     arm: dma-mapping: Don't override dma_ops in arch_setup_dma_ops()
> 
>     The arch_setup_dma_ops() function is in charge of setting dma_ops 
> with a
>     call to set_dma_ops(). set_dma_ops() is also called from
> 
>     - highbank and mvebu bus notifiers
>     - dmabounce (to be replaced with swiotlb)
>     - arm_iommu_attach_device
> 
>     (arm_iommu_attach_device is itself called from IOMMU and bus master
>     device drivers)
> 
>     To allow the arch_setup_dma_ops() call to be moved from device add 
> time
>     to device probe time we must ensure that dma_ops already setup by 
> any of
>     the above callers will not be overriden.
> 
>     Aftering replacing dmabounce with swiotlb, converting IOMMU drivers 
> to
>     of_xlate and taking care of highbank and mvebu, the workaround 
> should be
>     removed.
> 
> I'm concerned about potentially breaking these if we unconditionally 
> remove
> the DMA ops and mapping.

arch_teardown_dma_ops does nothing if there is
no mapping (not behind iommu), dma_ops without iommu is ok.
But when the arm_iommu_create_mapping/arm_iommu_attach_device
was called previously in the iommu driver, after we teardown,
that path in the iommu driver which called those functions is not
replayed.

Regards,
