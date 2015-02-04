From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] iommu/amd: Use wait_event in put_pasid_state_wait
Date: Wed, 4 Feb 2015 17:34:50 +0100
Message-ID: <20150204163450.GD5029@twins.programming.kicks-ass.net>
References: <1423062622-28257-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-aio@kvack.org>
Content-Disposition: inline
In-Reply-To: <1423062622-28257-1-git-send-email-joro@8bytes.org>
Sender: owner-linux-aio@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Benjamin LaHaise <bcrl@kvack.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-aio@kvack.org, linux-kernel@vger.kernel.org, Oded Gabbay <oded.gabbay@amd.com>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 04, 2015 at 04:10:22PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Now that I learned about possible spurious wakeups this
> place needs fixing too. Replace the self-coded sleep variant
> with the generic wait_event() helper.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd_iommu_v2.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
> index b6398d7..5cc1409 100644
> --- a/drivers/iommu/amd_iommu_v2.c
> +++ b/drivers/iommu/amd_iommu_v2.c
> @@ -266,14 +266,7 @@ static void put_pasid_state(struct pasid_state *pasid_state)
>  
>  static void put_pasid_state_wait(struct pasid_state *pasid_state)
>  {
> -	DEFINE_WAIT(wait);
> -
> -	prepare_to_wait(&pasid_state->wq, &wait, TASK_UNINTERRUPTIBLE);
> -
> -	if (!atomic_dec_and_test(&pasid_state->count))
> -		schedule();
> -
> -	finish_wait(&pasid_state->wq, &wait);
> +	wait_event(pasid_state->wq, !atomic_read(&pasid_state->count));
>  	free_pasid_state(pasid_state);
>  }

You just lost your atomic_dec.

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
