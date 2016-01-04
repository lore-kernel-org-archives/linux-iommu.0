From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu:Check that iommu_device_create has completed
	successfully in alloc_iommu
Date: Mon, 4 Jan 2016 17:16:16 +0100
Message-ID: <20160104161616.GP18805@8bytes.org>
References: <1451365811-19111-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451365811-19111-1-git-send-email-xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 29, 2015 at 12:10:11AM -0500, Nicholas Krause wrote:
> This adds the proper check to alloc_iommu to make sure that the call
> to iommu_device_create has completed successfully and if not return
> to the caller the error code returned after freeing up resources
> allocated previously by alloc_iommu.
> 
> Signed-off-by: Nicholas Krause <xerofoify-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/dmar.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 80e3c17..27333b6 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1069,9 +1069,12 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
>  		iommu->iommu_dev = iommu_device_create(NULL, iommu,
>  						       intel_iommu_groups,
>  						       "%s", iommu->name);
> +	if (IS_ERR(iommu->iommu_dev)) {
> +		err = PTR_ERR(iommu->iommu_dev);
> +		goto err_unmap;
> +	}

This leaves a dangling pointer to the iommu in drhd->iommu.

>  
>  	return 0;
> -

That blank line improves readability of the code, please leave it in.

>  err_unmap:
>  	unmap_iommu(iommu);
>  error_free_seq_id:
