From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/dma: Respect __GFP_DMA and __GFP_DMA32 in
	incoming GFP flags
Date: Wed, 26 Jul 2017 18:26:39 +0900
Message-ID: <CAAFQd5DP4b-Cmm+=e01SXanbMwNXfGkeTFvKMY4OV0n1y7rOTA@mail.gmail.com>
References: <20170704135556.21704-1-tfiga@chromium.org>
	<20170726091545.GC15833@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170726091545.GC15833-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Wed, Jul 26, 2017 at 6:15 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jul 04, 2017 at 10:55:55PM +0900, Tomasz Figa wrote:
>> Current implementation of __iommu_dma_alloc_pages() keeps adding
>> __GFP_HIGHMEM to GFP flags regardless of whether other zone flags are
>> already included in the incoming flags. If __GFP_DMA or __GFP_DMA32 is
>> set at the same time as __GFP_HIGHMEM, the allocation fails due to
>> invalid zone flag combination.
>>
>> Fix this by checking for __GFP_DMA and __GFP_DMA32 in incoming GFP flags
>> and adding __GFP_HIGHMEM only if they are not present.
>>
>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Isn't it better to mask out __GFP_DMA and __GFP_DMA32 in the allocation
> flags and only take them into account for iova allocation?
>
> When the IOMMU re-maps the DMA to this memory it doesn't matter where it
> is in system memory.

It's a platform specific knowledge and I'd say the generic helper is
not where it should be decided. Please see my reply to Robin for v1
[1].

[1] https://patchwork.kernel.org/patch/9810921/

Best regards.
Tomasz
