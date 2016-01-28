From: Robin Murphy <robin.murphy-VeJGdqYn5oNWk0Htik3J/w@public.gmane.org>
Subject: Re: Bus error at 0x0 by sysmmu_fimd (Page table base 0x000 0x00
	ad808000)
Date: Thu, 28 Jan 2016 13:08:57 +0000
Message-ID: <56AA12E9.5070601@foss.arm.com>
References: <CAAVm-g0+YP6pFJbY-28TX9FWuP+My2Vb7aciO_iYx7y_5e4UTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAVm-g0+YP6pFJbY-28TX9FWuP+My2Vb7aciO_iYx7y_5e4UTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Vijay Kumar <iamcurious456-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/01/16 04:54, Vijay Kumar wrote:
> Hii all,
>             I am new to this mailing list and i need some help.I am trying
> to add exynos iommu support for my board with exynos5250-soc for fimd.I am
> getting this error at exynos_sysmmu_irq.I am pretty confused with it and
> didn't know what to do.I strucked at this point.So please explain why this
> error occurs.My device is attaced correctly to iommu.

It looks like something (either the client device or the sysmmu itself, 
I'm not familiar with that hardware) has tried to access physical 
address 0, and the MMU is raising the interrupt to report that it got an 
error response back for that access. On Exynos 5 that's where the boot 
ROM stuff lives, so there may well be nothing there at all in the 
non-secure memory map. Either way, it's a long way from RAM (which will 
be somewhere above 0x20000000), so you've almost certainly wound up with 
some bogus mapping in your sysmmu page table. First thing I'd try is 
adding a check in exynos_iommu_map() to scream if someone passes in a 
dodgy-looking physical address, then work backwards from there.

Robin.

>
> Thanks and Regards,
> Vijay Kumar Prathipati.
>
>
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
