From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v8 06/13] iommu/amd: copy old trans table from old kernel
Date: Fri, 28 Jul 2017 14:52:02 +0800
Message-ID: <20170728065202.GJ24304@x1>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-7-git-send-email-bhe@redhat.com>
	<20170727153825.GM3610@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170727153825.GM3610-l3A5Bk7waGM@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 07/27/17 at 05:38pm, Joerg Roedel wrote:
> On Fri, Jul 21, 2017 at 04:59:04PM +0800, Baoquan He wrote:
> > @@ -2128,9 +2131,43 @@ static void early_enable_iommu(struct amd_iommu *iommu)
> >  static void early_enable_iommus(void)
> >  {
> >  	struct amd_iommu *iommu;
> > +	bool is_pre_enabled = false;
> >  
> > -	for_each_iommu(iommu)
> > -		early_enable_iommu(iommu);
> > +	for_each_iommu(iommu) {
> > +		if (translation_pre_enabled(iommu)) {
> > +			is_pre_enabled = true;
> > +			break;
> > +		}
> > +	}
> 
> is_pre_enabled should only be true when _all_ iommus are pre-enabled. If
> only one is found disabled just disable the others and continue without
> copying the device table.

OK, will change as you suggested.

> 
