From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/9] iommu/io-pgtable-arm: Allow appropriate DMA API use
Date: Fri, 31 Jul 2015 12:22:27 +0100
Message-ID: <20150731112226.GB29497@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Wed, Jul 29, 2015 at 07:46:04PM +0100, Robin Murphy wrote:
> Currently, users of the LPAE page table code are (ab)using dma_map_page()
> as a means to flush page table updates for non-coherent IOMMUs. Since
> from the CPU's point of view, creating IOMMU page tables *is* passing
> DMA buffers to a device (the IOMMU's page table walker), there's little
> reason not to use the DMA API correctly.
> 
> Allow IOMMU drivers to opt into DMA API operations for page table
> allocation and updates by providing their appropriate device pointer.
> The expectation is that an LPAE IOMMU should have a full view of system
> memory, so use streaming mappings to avoid unnecessary pressure on
> ZONE_DMA, and treat any DMA translation as a warning sign.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Changes since v1[1]:
> - Make device pointer mandatory and use DMA API unconditionally
> - Remove flush_pgtable callback entirely
> - Style, consistency and typo fixes

I think this is looking good now, thanks. I'll add it to my ARM SMMU queue
for 4.3.

Will
