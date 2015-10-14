From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 14 Oct 2015 17:34:49 +0100
Message-ID: <561E8429.9060604@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
	<20151014133538.GG4239@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151014133538.GG4239-M2fw3Uu6cmfZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 14/10/15 14:35, Catalin Marinas wrote:
> On Thu, Oct 01, 2015 at 08:13:59PM +0100, Robin Murphy wrote:
>> Taking some inspiration from the arch/arm code, implement the
>> arch-specific side of the DMA mapping ops using the new IOMMU-DMA layer.
>>
>> Since there is still work to do elsewhere to make DMA configuration happen
>> in a more appropriate order and properly support platform devices in the
>> IOMMU core, the device setup code unfortunately starts out carrying some
>> workarounds to ensure it works correctly in the current state of things.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>
> Sorry, I reviewed this patch before but forgot to ack it, so here it is:
>
> Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>

Thanks! Although it turns out I'm at least partly to blame there - you 
did give a reviewed-by on v5, but I didn't add it here since I'd made 
significant changes - I should have checked and called that out, my bad.

> (and I'm fined for the arm64 patches here to go in via the iommu tree)
>
> I assume part of this patch will disappear at some point when the device
> probing order is sorted.

I'll be working on that for 4.5, indeed. Getting the initialisation 
order sorted out also stands in the way of converting 32-bit to the 
common ops, so it's very high up my priority list.

Robin.
