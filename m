From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only
Date: Fri, 7 Apr 2017 12:20:39 +0200
Message-ID: <20170407102039.GW7266@8bytes.org>
References: <20170322112242.GK29659@8bytes.org>
	<1490595427-11979-1-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490595427-11979-1-git-send-email-arindam.nath-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: arindam.nath-5C7GfCeVMHo@public.gmane.org
Cc: John.Bridgman-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alexander.Deucher-5C7GfCeVMHo@public.gmane.org, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 27, 2017 at 11:47:07AM +0530, arindam.nath-5C7GfCeVMHo@public.gmane.org wrote:
> From: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> 
> The idea behind flush queues is to defer the IOTLB flushing
> for domains for which the mappings are no longer valid. We
> add such domains in queue_add(), and when the queue size
> reaches FLUSH_QUEUE_SIZE, we perform __queue_flush().
> 
> Since we have already taken lock before __queue_flush()
> is called, we need to make sure the IOTLB flushing is
> performed as quickly as possible.
> 
> In the current implementation, we perform IOTLB flushing
> for all domains irrespective of which ones were actually
> added in the flush queue initially. This can be quite
> expensive especially for domains for which unmapping is
> not required at this point of time.
> 
> This patch makes use of domain information in
> 'struct flush_queue_entry' to make sure we only flush
> IOTLBs for domains who need it, skipping others.
> 
> Signed-off-by: Arindam Nath <arindam.nath-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 98940d1..6a9a048 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2227,15 +2227,16 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
>  
>  static void __queue_flush(struct flush_queue *queue)
>  {
> -	struct protection_domain *domain;
> -	unsigned long flags;
>  	int idx;
>  
> -	/* First flush TLB of all known domains */
> -	spin_lock_irqsave(&amd_iommu_pd_lock, flags);
> -	list_for_each_entry(domain, &amd_iommu_pd_list, list)
> -		domain_flush_tlb(domain);
> -	spin_unlock_irqrestore(&amd_iommu_pd_lock, flags);
> +	/* First flush TLB of all domains which were added to flush queue */
> +	for (idx = 0; idx < queue->next; ++idx) {
> +		struct flush_queue_entry *entry;
> +
> +		entry = queue->entries + idx;
> +
> +		domain_flush_tlb(&entry->dma_dom->domain);
> +	}

With this we will flush a domain every time we find one of its
iova-addresses in the flush queue, so potentially we flush a domain
multiple times per __queue_flush() call.

Its better to either add a flush-flag to the domains and evaluate that
in __queue_flush or keep a list of domains to flush to make the flushing
really more efficient.


	Joerg
