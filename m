From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 7/9] iommu/amd: Update domain into to dte entry during
	device driver init
Date: Sun, 13 Nov 2016 13:17:17 +0800
Message-ID: <20161113051717.GB19995@x1>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
	<1476963440-23039-8-git-send-email-bhe@redhat.com>
	<20161110114816.GE9996@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161110114816.GE9996-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent.Wan-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks for your reviewing and great comments!

On 11/10/16 at 12:48pm, Joerg Roedel wrote:
> On Thu, Oct 20, 2016 at 07:37:18PM +0800, Baoquan He wrote:
> >  	prot = dir2prot(direction);
> > +	if (translation_pre_enabled(iommu) && !dev_data->domain_updated) {
> > +		dev_data->domain_updated = true;
> > +		set_dte_entry(dev_data->devid, domain, dev_data->ats.enabled);
> > +		if (alias != dev_data->devid)
> > +			set_dte_entry(alias, domain, dev_data->ats.enabled);
> > +		device_flush_dte(dev_data);
> > +	}
> 
> Hmm, I really don't like to have these checks in the fast-path. But to
> get rid of it I think we need to re-work the way domains are assigned to
> devices.
> 
> One way to do this would be to add a 'defered-domain-attach' feature to
> the iommu-core code. What do you think about this?

Yes, I have to admit code in this patch is really urly. Could you say a
little more about the "defered-domain-attach"? I would love to do any
improvement as long as it's make things correct and better. I could read
code flow several times from init to the end of driver probe, then may
get what you say because of my limited knowledge. If you can give a little
details about it, I can try to change and post for reviewing.

What I get now is you want to see a function  is added so that we can invoke
when attach domain to device. And the calling can be decided by checking
if it's in kdump. This makes it like intel iommu does, defer the
attaching to probe stage. That's why you don't need to do what I am
doing in this patch when you fix intel iommu failure in kdump kernel. Am
I right?

Thanks
Baoquan
