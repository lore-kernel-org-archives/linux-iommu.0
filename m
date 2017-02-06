From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/dma: Remove bogus dma_supported() implementation
Date: Mon, 6 Feb 2017 13:14:31 +0100
Message-ID: <20170206121431.GB25981@8bytes.org>
References: <143b03c101e727cb156b26a907c8d7e390eb9114.1485971565.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <143b03c101e727cb156b26a907c8d7e390eb9114.1485971565.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 01, 2017 at 05:53:04PM +0000, Robin Murphy wrote:
> Back when this was first written, dma_supported() was somewhat of a
> murky mess, with subtly different interpretations being relied upon in
> various places. The "does device X support DMA to address range Y?"
> uses assuming Y to be physical addresses, which motivated the current
> iommu_dma_supported() implementation and are alluded to in the comment
> therein, have since been cleaned up, leaving only the far less ambiguous
> "can device X drive address bits Y" usage internal to DMA API mask
> setting. As such, there is no reason to keep a slightly misleading
> callback which does nothing but duplicate the current default behaviour;
> we already constrain IOVA allocations to the iommu_domain aperture where
> necessary, so let's leave DMA mask business to architecture-specific
> code where it belongs.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Applied, thanks
