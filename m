From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu: fix double spin_lock_irqsave on
	`device_domain_lock'
Date: Thu, 3 Nov 2016 14:51:36 -0600
Message-ID: <20161103205136.GA4930@suse.de>
References: <1476694480-4251-1-git-send-email-iari@itu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476694480-4251-1-git-send-email-iari-YidNj35/HaM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Iago Abal <iari-YidNj35/HaM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Iago Abal <mail-nS/Qcn0WMKPsq35pWSNszA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 17, 2016 at 10:54:40AM +0200, Iago Abal wrote:
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a4407ea..05796a8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1721,12 +1721,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>  		if (!info->dev || !info->domain)
>  			continue;
>  
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +
>  		domain = info->domain;
>  
>  		dmar_remove_one_dev_info(domain, info->dev);
>  
>  		if (!domain_type_is_vm_or_si(domain))
>  			domain_exit(domain);
> +
> +		spin_lock_irqsave(&device_domain_lock, flags);
>  	}
>  	spin_unlock_irqrestore(&device_domain_lock, flags);

No, you can't just release the lock to re-aquire it in
dmar_remove_one_dev_info(). This introduces new races, as the list your
are walking is no longer protected by the lock. The right solution is to
call a variant of dmar_remove_one_dev_info() which does not take the
lock. It turns out this function already exists, so the patch looks like
below. Can you check if this is still correct and resubmit your patch?

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a4407ea..3cadde2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1723,7 +1723,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 
 		domain = info->domain;
 
-		dmar_remove_one_dev_info(domain, info->dev);
+		__dmar_remove_one_dev_info(info);
 
 		if (!domain_type_is_vm_or_si(domain))
 			domain_exit(domain);
