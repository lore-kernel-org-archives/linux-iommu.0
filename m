From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] iommu/dma: Use correct offset in map_sg
Date: Thu, 7 Jan 2016 13:38:25 +0100
Message-ID: <20160107123824.GI19149@8bytes.org>
References: <4812a34857b081e45c36d7e887840f3675da74dc.1450457730.git.robin.murphy@arm.com>
	<8317d001da4f48831fa23d8d7729a4659ac72b49.1451924092.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8317d001da4f48831fa23d8d7729a4659ac72b49.1451924092.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 04, 2016 at 04:19:42PM +0000, Robin Murphy wrote:
> When mapping a non-page-aligned scatterlist entry, we copy the original
> offset to the output DMA address before aligning it to hand off to
> iommu_map_sg(), then later adding the IOVA page address portion to get
> the final mapped address. However, when the IOVA page size is smaller
> than the CPU page size, it is the offset within the IOVA page we want,
> not that within the CPU page, which can easily be larger than an IOVA
> page and thus result in an incorrect final address.
> 
> Fix the bug by taking only the IOVA-aligned part of the offset as the
> basis of the DMA address, not the whole thing.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Applied, thanks.
