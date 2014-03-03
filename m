From: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: IOMMU DMA-mapping API for arm64 ?
Date: Mon, 3 Mar 2014 13:42:22 +0530
Message-ID: <CAD15agZpoT9r7jJgWBgLtinsqgZW=dFLCDE-gmU94T03GeCwQw@mail.gmail.com>
References: <CAD15agaps45rZT5ko9JKP2CfRF_iTV+0JMDwa239ExgKrRzBYQ@mail.gmail.com>
	<20140227185211.GM30003@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140227185211.GM30003-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
Cc: Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 28, 2014 at 12:22 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Thu, Feb 27, 2014 at 05:15:38AM +0000, Ritesh Harjani wrote:
>> Hi Everyone,
>
> Hi Ritesh,

Hi Will,

>
>> I was going through some iommu code in arch/arm and of some other
>> archs code. I have some doubts on this for refactoring and may need
>> some suggestions from you guys.
>>
>> 1. So, looking at other arch code, looks like they have their
>> different way of implementation of iova management and buffer
>> allocation. So to refactor the iommu common code out from arch/arm/ to
>> lib/iommu-helper, do we need to take care across all arch  ?
>
> Whilst the code should compile for all architectures, I don't think you need
> to go round porting them all to use it. That can happen in a piecemeal
> fashion as they get ported over to the generic code. Initially, I see arm and
> arm64 as the users.
Got it.

>
>> 2. Should the approach be like take the common code(between arm/arm64)
>> and move it into lib/iommu-helper.c ?
>
> Well, something along those lines. We should put some thought into what the
> interfaces should look like, rather than blindly copying everything out as
> it stands.
>
>> Could someone give an example of what sort of code(will be better if
>> this is little more specific) we are talking here to be taken out to
>> lib/iommu-helper.c ? Earlier I was thinking of iova management can be
>> taken out but then I saw it might not be suited across all archs.
>>
>> I am ready to do this work, but need some guidance from the experts .
>
> Catalin can clarify here, but I think we'd basically want a generic
> equivalent to arm_iommu_create_mapping and its associated halpers (i.e. the

Do you mean here that dma_iommu_mapping structure can be taken out to
incude/linux/iommu-helper.h ?
Since arm_iommu_create_mapping strongly uses this structure. But if
this is the case than it will be completely arm specific
implementation.

> dma_map_ops). The dma_map_ops will have generic parts (e.g. the interfaces
> to the iommu API) but also architecturally-specific parts (e.g. cache
> flushing for non-coherent devices), so that will need some thought.
>

Architecturally-specific i.e. cache flush operations are not just for
non-coherent devices. Irrespective of coherent/non-coherent dma_ops,
every time we allocate the buffer by __iommu_alloc_buffer, we call for
__dma_clear_buffer (which does cache_flushing operation).

Yes, but for non-coherent devices, during map_page/map_sg,  we do
cache maintenance/invalidate/clean.

> Once that's done, we can later look at hooking this into device-tree in
> order to set the correct ops each device.
>
> Will
