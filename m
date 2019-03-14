From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Remove lazy allocation of domains
Date: Thu, 14 Mar 2019 16:35:01 -0700
Message-ID: <20190314163501.2f414a78@jacob-builder>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
	<F4D76093-3F9F-4184-9F92-191A01126D0F@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <F4D76093-3F9F-4184-9F92-191A01126D0F-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 14 Mar 2019 11:59:36 +0000
James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org> wrote:

>  
> -	domain = get_valid_domain_for_dev(dev);
> +	domain = find_domain(dev);
>  	if (!domain)
>  		return DMA_MAPPING_ERROR;
>  
> @@ -3914,7 +3624,7 @@ static int intel_map_sg(struct device *dev,
> struct scatterlist *sglist, int nele if (iommu_no_mapping(dev))
>  		return intel_nontranslate_map_sg(dev, sglist,
> nelems, dir); 
> -	domain = get_valid_domain_for_dev(dev);
> +	domain = find_domain(dev);
This patchset looks like a very good clean up, I am wondering why we
can't use the generic iommu_get_domain_for_dev() here, since VT-d has a
default DMA domain after your patch.
