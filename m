From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Check if domain is NULL before dereference it
Date: Thu, 24 Aug 2017 20:22:51 +0800
Message-ID: <20170824122251.GG19768@x1>
References: <1503575807-15746-1-git-send-email-bhe@redhat.com>
	<20170824121137.dgsy57bq3qsjvjqj@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170824121137.dgsy57bq3qsjvjqj@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/24/17 at 03:11pm, Dan Carpenter wrote:
> On Thu, Aug 24, 2017 at 07:56:47PM +0800, Baoquan He wrote:
> > In get_domain(), 'domain' could still be NULL before it's passed to
> > dma_ops_domain() to dereference. For safety, check if 'domain' is
> > NULL before passing to dma_ops_domain().
> > 
> > Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> > Signed-off-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> >  drivers/iommu/amd_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index 16f1e6af00b0..2e2d5e6a13b3 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -2262,7 +2262,7 @@ static struct protection_domain *get_domain(struct device *dev)
> >  		domain = to_pdomain(io_domain);
> >  		attach_device(dev, domain);
> >  	}
> > -	if (!dma_ops_domain(domain))
> > +	if (domain && !dma_ops_domain(domain))
> >  		return ERR_PTR(-EBUSY);
> >  
> >  	return domain;
> 
> This still doesn't look right.  None of the callers can handle a NULL
> domain.

Here the NULL domain is on purpose. In kdump kernel if iommu is
pre-enabled, just stop attach the device to domain until the device
driver init. So here in driver init when call get_domain(), if found
get_dev_data(dev)->defer_attach is true, we just do the attachment of
device to domain.

Not sure if I got what you mean about 'callers'.
