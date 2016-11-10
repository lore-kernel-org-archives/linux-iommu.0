From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/dma-iommu: properly respect configured address
	space size
Date: Thu, 10 Nov 2016 16:17:30 +0000
Message-ID: <9d239c5c-a4ed-f177-319f-7c467a6059ba@arm.com>
References: <CGME20161107130625eucas1p2dd23c07010b4f3eddb6c6540ed802246@eucas1p2.samsung.com>
	<1478523973-8828-1-git-send-email-m.szyprowski@samsung.com>
	<68e7a18b-739e-b73e-eacf-3cb6c1bd279a@arm.com>
	<20161110155938.GI2078@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161110155938.GI2078-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/11/16 15:59, Joerg Roedel wrote:
> On Tue, Nov 08, 2016 at 11:37:23AM +0000, Robin Murphy wrote:
>> TBH I've been pondering ripping the size stuff out of dma-iommu, as it
>> all stems from me originally failing to understand what dma_32bit_pfn is
>> actually for.
> 
> The point of dma_32bit_pfn is to allocate dma-address below 4G by
> default. This is a performance optimization so that even devices capable
> of 64bit DMA are using SAC by default instead of DAC.
> 
> Since it is the goal to share a dma-iommu implemenation between
> architectures, I would rather prefer not to rip this stuff out.

Oh, I didn't mean rip it out entirely, just get rid of the bogus
assumption that it's the "size" of the domain, especially when given a
>32-bit DMA mask, since that defeats the very optimisation I do now
understand (although it might still be OK for platform devices where
SAC/DAC doesn't apply, to avoid the rb_last() overhead every time).

>From the patch I've started, "rip it out" turns out to actually be
mostly "rewrite the comments" anyway - I'll post something soon.

Robin.
