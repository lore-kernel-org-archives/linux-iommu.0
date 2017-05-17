From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RESEND] iommu/dma: Don't touch invalid iova_domain members
Date: Wed, 17 May 2017 14:36:31 +0200
Message-ID: <20170517123631.GB11068@8bytes.org>
References: <122f47aa5596dc8ef0a1ee76e4425c7b597479a4.1494859975.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <122f47aa5596dc8ef0a1ee76e4425c7b597479a4.1494859975.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 15, 2017 at 04:01:30PM +0100, Robin Murphy wrote:
> When __iommu_dma_map() and iommu_dma_free_iova() are called from
> iommu_dma_get_msi_page(), various iova_*() helpers are still invoked in
> the process, whcih is unwise since they access a different member of the
> union (the iova_domain) from that which was last written, and there's no
> guarantee that sensible values will result anyway.
> 
> CLean up the code paths that are valid for an MSI cookie to ensure we
> only do iova_domain-specific things when we're actually dealing with one.
> 
> Fixes: a44e6657585b ("iommu/dma: Clean up MSI IOVA allocation")
> Reported-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Tested-by: Shanker Donthineni <shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Tested-by: Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Applied to iommu/fixes. Why didn't you add the Tested-by from Eric in
you resend?


	Joerg
