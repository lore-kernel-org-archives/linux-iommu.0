From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/4] iommu/amd: Prevent possible null pointer
	dereference and infinite loop
Date: Tue, 15 May 2018 16:49:47 +0200
Message-ID: <20180515144947.6kercnc2tb2op4hp@8bytes.org>
References: <20180507125329.24648-1-anna-maria@linutronix.de>
	<20180507125329.24648-3-anna-maria@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180507125329.24648-3-anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anna-Maria Gleixner <anna-maria-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 07, 2018 at 02:53:27PM +0200, Anna-Maria Gleixner wrote:
> @@ -2793,6 +2790,7 @@ static void cleanup_domain(struct protection_domain *domain)
>  	while (!list_empty(&domain->dev_list)) {
>  		entry = list_first_entry(&domain->dev_list,
>  					 struct iommu_dev_data, list);
> +		BUG_ON(!entry->domain);

I am not happy with that BUG_ON, and it is unnecessary because we would
run into a NULL-ptr deref later if we don't BUG_ON here. So this makes
it easier to debug if it ever happens, but changing the code so that
this can be turned into a WARN_ON would be nicer.

Anyway, applied for now.



	Joerg
