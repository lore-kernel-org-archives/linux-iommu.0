From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH v2 3/8] dma-debug: Refactor dma_debug_entry allocation
Date: Thu, 6 Dec 2018 15:23:26 +0100
Message-ID: <20181206142326.GA24642@lst.de>
References: <cover.1544037783.git.robin.murphy@arm.com>
	<d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d868e775492e417f446d6d162f5f792bd41ee7bc.1544037783.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: cai-0UDz38MK/Mo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

> +static int dma_debug_add_entries(u32 num_entries, gfp_t gfp)
> +{
> +	struct dma_debug_entry *entry, *next_entry;
> +	LIST_HEAD(tmp);
> +	int i;
> +
> +	for (i = 0; i < num_entries; ++i) {
> +		entry = kzalloc(sizeof(*entry), gfp);
> +		if (!entry)
> +			goto out_err;
> +
> +		list_add_tail(&entry->list, &tmp);
> +	}
> +
> +	list_splice(&tmp, &free_entries);
> +	num_free_entries += num_entries;
> +	nr_total_entries += num_entries;

The adding to a local list and splicing seems a bit pointless if we
do it all under lock anyway.  Either we change the locking in
dma_debug_resize_entries and your upcoming automatic allocation that
we only do it over the splice and counter adjustment, which would
have the advantage of allowing freeing of entries in parallel to these
allocations, or we could just drop the local tmp list.
