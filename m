From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch v2 7/9] iommu/amd: copy old tables and do not update dev
	tables before driver init
Date: Sun, 13 Dec 2015 09:19:29 +0800
Message-ID: <20151213011929.GA2490@x1.redhat.com>
References: <1446811851-20623-1-git-send-email-bhe@redhat.com>
	<1446811851-20623-8-git-send-email-bhe@redhat.com>
	<20151127113517.GF24300@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151127113517.GF24300-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 11/27/15 at 12:35pm, Joerg Roedel wrote:
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -1992,14 +1992,15 @@ static void do_attach(struct iommu_dev_data *dev_data,
> >  	/* Update data structures */
> >  	dev_data->domain = domain;
> >  	list_add(&dev_data->list, &domain->dev_list);
> > -	set_dte_entry(dev_data->devid, domain, ats);
> > +	if (!translation_pre_enabled()) {
> > +		set_dte_entry(dev_data->devid, domain, ats);
> > +		/* Flush the DTE entry */
> > +		device_flush_dte(dev_data);
> > +	}
> 
> Hmm, this patch adds a lot of special cases into the AMD IOMMU code to
> make sure the domain is attached at driver init time.
> 
> Can we change the code to generally defer domain attachment to driver
> init time? There is a set_dma_mask call-back in the dma-ops that can be
> used for that.
> 
> This would limit the special cases to device table initialization and
> iommu enable time.

I checked code and still didn't get how to use set_dma_mask to help
defer the domain info updating to driver init time. Previously what I
tried to do is:
Firstly copy old dev table entries to newly allocated dev table;
Secondly always use the old dev table before driver init. Means before
driver init any behavious which is trying to update domain informaton to
that device would be skipped;
Thirdly, as soon as it's going to driver init, allow the updating.

>From definition and usage for other arch/component set_dma_mask is only
used to set the DMA addressing limitations which is I got from reading.
Could you please give more tips on this? Maybe I didn't dig into it deep
enough to get it.

Thanks
Baoquan
