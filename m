From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 2/3] iommu/fsl: Fix the device domain attach condition.
Date: Fri, 4 Jul 2014 12:50:28 +0000
Message-ID: <23ace98ce7e145b0909a1f5f5d1fd2dd@BL2PR03MB468.namprd03.prod.outlook.com>
References: <1403618237-26248-1-git-send-email-Varun.Sethi@freescale.com>
	<1403618237-26248-3-git-send-email-Varun.Sethi@freescale.com>
	<20140704105430.GE13434@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140704105430.GE13434-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Friday, July 04, 2014 4:25 PM
> To: Sethi Varun-B16395
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Subject: Re: [PATCH 2/3] iommu/fsl: Fix the device domain attach
> condition.
> 
> Hmm,
> 
> On Tue, Jun 24, 2014 at 07:27:16PM +0530, Varun Sethi wrote:
> > -	old_domain_info = find_domain(dev);
> > +	old_domain_info = dev->archdata.iommu_domain;
> >  	if (old_domain_info && old_domain_info->domain != dma_domain) {
> >  		spin_unlock_irqrestore(&device_domain_lock, flags);
> >  		detach_device(dev, old_domain_info->domain);
> 
> Wouldn't this set dev->archdata.iommu_domain to NULL anyway, so that ...
> 
Not for the case where device has multiple LIODNs.

> > @@ -399,7 +394,7 @@ static void attach_device(struct fsl_dma_domain
> *dma_domain, int liodn, struct d
> >  	 * the info for the first LIODN as all
> >  	 * LIODNs share the same domain
> >  	 */
> > -	if (!old_domain_info)
> > +	if (!dev->archdata.iommu_domain)
> >  		dev->archdata.iommu_domain = info;
> 
> We already know that it _must_ be NULL here?
> 

That won't be true for devices having multiple LIODNs

> >  	spin_unlock_irqrestore(&device_domain_lock, flags);
> 
> This would shrink down the patch to:
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index 93072ba..d21b554 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -399,8 +399,7 @@ static void attach_device(struct fsl_dma_domain
> *dma_domain, int liodn, struct d
>  	 * the info for the first LIODN as all
>  	 * LIODNs share the same domain
>  	 */
> -	if (!old_domain_info)
> -		dev->archdata.iommu_domain = info;
> +	dev->archdata.iommu_domain = info;

For devices having multiple LIODNs, we don't want to overwrite the info.

-Varun
