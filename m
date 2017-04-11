From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/omap: Set dev->archdata.iommu = NULL in
	omap_iommu_remove_device
Date: Tue, 11 Apr 2017 16:25:02 -0500
Message-ID: <224ed0a1-65f2-5a49-1959-bb88c51efb24@ti.com>
References: <1491576092-23339-1-git-send-email-joro@8bytes.org>
	<1491576092-23339-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491576092-23339-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/07/2017 09:41 AM, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Don't leave a stale pointer in case the device continues to
> exist for some more time.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Acked-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>

> ---
>  drivers/iommu/omap-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index e9c9b08..08bd731 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1259,6 +1259,8 @@ static void omap_iommu_remove_device(struct device *dev)
>  	if (!dev->of_node || !arch_data)
>  		return;
>  
> +	dev->archdata.iommu = NULL;
> +
>  	kfree(arch_data->name);
>  	kfree(arch_data);
>  }
> 
