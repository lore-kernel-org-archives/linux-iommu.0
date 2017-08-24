From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Check if domain is NULL before dereference it
Date: Thu, 24 Aug 2017 21:01:10 +0800
Message-ID: <20170824130110.GI19768@x1>
References: <1503575807-15746-1-git-send-email-bhe@redhat.com>
	<20170824121137.dgsy57bq3qsjvjqj@mwanda>
	<20170824122251.GG19768@x1>
	<20170824123226.57twp5sdh246l5kz@mwanda>
	<20170824124733.GH19768@x1>
	<20170824125311.ymx27viis6rnhozy@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170824125311.ymx27viis6rnhozy@mwanda>
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

On 08/24/17 at 03:53pm, Dan Carpenter wrote:
> On Thu, Aug 24, 2017 at 08:47:33PM +0800, Baoquan He wrote:
> > On 08/24/17 at 03:32pm, Dan Carpenter wrote:
> > > Take a look at this code for example.  But all the places which call
> > > get_domain() are the same:
> > > 
> > > drivers/iommu/amd_iommu.c
> > >   2648          page = virt_to_page(virt_addr);
> > >   2649          size = PAGE_ALIGN(size);
> > >   2650  
> > >   2651          domain = get_domain(dev);
> > >                          ^^^^^^^^^^^^^^
> > > imagined get_domain() returns NULL.
> > > 
> > >   2652          if (IS_ERR(domain))
> > >   2653                  goto free_mem;
> > >   2654  
> > >   2655          dma_dom = to_dma_ops_domain(domain);
> > >                           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > This will Oops.
> > 
> > I see, it's a problem. Thanks for telling!
> > 
> > How about below change? But I am not very sure which errno should be
> > picked, seems the latter one, EBUSY is better since it has passed the
> > check_device() checking.
> 
> Looks good to me.  You know better than I do which errno is best, so
> I'll leave that to you.

OK, thanks! Then let me post v2 with it.
