From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Don't free parent pagetable of the PTE we're
	adding
Date: Wed, 26 Jul 2017 11:13:31 +0200
Message-ID: <20170726091331.GB15833@8bytes.org>
References: <20170629024223.14866-1-dillow@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170629024223.14866-1-dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Jun 28, 2017 at 07:42:23PM -0700, David Dillow wrote:
> When adding a large scatterlist entry that covers more than the L3
> superpage size (1GB) but has an alignment such that we must use L2
> superpages (2MB) , we give dma_pte_free_level() a range that causes it
> to free the L3 pagetable we're about to populate. We fix this by telling
> dma_pte_free_pagetable() about the pagetable level we're about to populate
> to prevent freeing it.
> 
> For example, mapping a scatterlist with entry lengths 854MB and 1194MB
> at IOVA 0xffff80000000 would, when processing the 2MB-aligned second
> entry, cause pfn_to_dma_pte() to create a L3 directory to hold L2
> superpages for the mapping at IOVA 0xffffc0000000. We would previously
> call dma_pte_free_pagetable(domain, 0xffffc0000, 0xfffffffff), which
> would free the L3 directory pfn_to_dma_pte() just created for IO PFN
> 0xffffc0000. Telling dma_pte_free_pagetable() to retain the L3
> directories while using L2 superpages avoids the erroneous free.
> 
> Signed-off-by: David Dillow <dillow-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)

Applied, thanks.
