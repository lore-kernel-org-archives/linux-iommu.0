From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Add support for non-coherent page
	table mappings
Date: Mon, 21 Jan 2019 11:35:30 +0530
Message-ID: <CAFp+6iFh26JgBUx1jkm4EHNY1vs93Uz2qngxP27D0f7dcpX2GQ@mail.gmail.com>
References: <20190117092718.1396-1-vivek.gautam@codeaurora.org>
	<20190117092718.1396-3-vivek.gautam@codeaurora.org>
	<20190120000117.GH26876@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190120000117.GH26876@brain-police>
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
Cc: linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "list-Y9sIeH5OGRo@public.gmane.org:IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>,
	Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, " <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,


On Sun, Jan 20, 2019 at 5:31 AM Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On Thu, Jan 17, 2019 at 02:57:18PM +0530, Vivek Gautam wrote:
> > Adding a device tree option for arm smmu to enable non-cacheable
> > memory for page tables.
> > We already enable a smmu feature for coherent walk based on
> > whether the smmu device is dma-coherent or not. Have an option
> > to enable non-cacheable page table memory to force set it for
> > particular smmu devices.
>
> Hmm, I must be missing something here. What is the difference between this
> new property, and simply omitting dma-coherent on the SMMU?

So, this is what I understood from the email thread for Last level
cache support -
Robin pointed to the fact that we may need to add support for setting
non-cacheable
mappings in the TCR.
Currently, we don't do that for SMMUs that omit dma-coherent.
We rely on the interconnect to handle the configuration set in TCR,
and let interconnect
ignore the cacheability if it can't support.

Moreover, Robin suggested that we should take care of SMMUs, for which
removing snoop latency on walks by making mappings as non-cacheable
outweighs the cost of cache maintenance on PTE updates.

So, this change adds another property to do this non-cacheable mappings
explicitly. As I pointed, omitting 'dma-coherent', and corresponding
IO_PGTABLE_QUIRK_NO_DMA' does takes care of few things.

Should we handle the TCR settings too with this quirk?

Regards
Vivek
>
> Will
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu



--
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
