From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iommu/amd: Check if domain is NULL before dereference it
Date: Thu, 24 Aug 2017 15:53:12 +0300
Message-ID: <20170824125311.ymx27viis6rnhozy@mwanda>
References: <1503575807-15746-1-git-send-email-bhe@redhat.com>
 <20170824121137.dgsy57bq3qsjvjqj@mwanda>
 <20170824122251.GG19768@x1>
 <20170824123226.57twp5sdh246l5kz@mwanda>
 <20170824124733.GH19768@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170824124733.GH19768@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, joro@8bytes.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 24, 2017 at 08:47:33PM +0800, Baoquan He wrote:
> On 08/24/17 at 03:32pm, Dan Carpenter wrote:
> > Take a look at this code for example.  But all the places which call
> > get_domain() are the same:
> > 
> > drivers/iommu/amd_iommu.c
> >   2648          page = virt_to_page(virt_addr);
> >   2649          size = PAGE_ALIGN(size);
> >   2650  
> >   2651          domain = get_domain(dev);
> >                          ^^^^^^^^^^^^^^
> > imagined get_domain() returns NULL.
> > 
> >   2652          if (IS_ERR(domain))
> >   2653                  goto free_mem;
> >   2654  
> >   2655          dma_dom = to_dma_ops_domain(domain);
> >                           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > This will Oops.
> 
> I see, it's a problem. Thanks for telling!
> 
> How about below change? But I am not very sure which errno should be
> picked, seems the latter one, EBUSY is better since it has passed the
> check_device() checking.

Looks good to me.  You know better than I do which errno is best, so
I'll leave that to you.

regards,
dan carpenter
