Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7FB241EE
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 12:48:47 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-65617075b6fso4125856d6.1
        for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694695726; x=1695300526; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hDY3jBRB8QH3yOR0YRex0tFByVoHyqIzvOIxxftR4g=;
        b=h8LrRAT5RhJ7VLQVpi8KmoOZC0UapfVQyRqLmgnJVApkLvaEK1UrdjBhcXwmKCJqKv
         aDGSAblas28C/KmHH6a8DWcX9GZyzcwnehU202jtDCFXHV7FQhVyUh+PK/OkzS6zOsvg
         T6XGD9CT8ClLtufryX40PZWRiau7UA395fkVj+MPbVvC4WMKUWccTY7OY5BHfzB+pOF/
         tQAb3cSkdUr44nT+tUQSItfPRAxB4eKUkNqRvw/ze3gZ9X+RlRD/iZ8ZpouQQbPDnaNA
         KFWXLc/c6TW2b/Z1BDd2hM2eSTfvj/TcV1RToZN/4qRPXtUVXYl8Ud6tst5fUOi9twMv
         0wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694695726; x=1695300526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hDY3jBRB8QH3yOR0YRex0tFByVoHyqIzvOIxxftR4g=;
        b=BGvFYSPrYgS2sgxMhzaB3JndLuoIRJ/V4KhEjDtLz1Ele5NoKRscqDV2Qk/ORLs5mR
         99zgQchbmaHoVlV3NCQTkzKFd7HvA4sOnx7xSpGsukSVU5CwS2K96IBhG3HSgK/ZpBUU
         R9JF13pDUfBpX19d3JOxpuRUEi7W8wnrvYBnBwU1AiL1cINGKpQLrZryOG1xSkV4q4UH
         9RT8QoIccP1YJ+hsmSYJEY+dq3PcpZpPfa1Bc/XduI1lVTxfIMp3MZMy4CwUFp5dWE7d
         cHR7gZdmRoBuSo1bxpgJBwWiwMvSRyDhLoubq5Il38+6rh4DEHgP2Yciiusl4v6qV+B2
         CP+g==
X-Gm-Message-State: AOJu0Yx/tddUtfIu4LoQIqypsrE7NO8vpNuGlWB9WktGQoFkX2o/n5+e
	eH8rTdpezUfMhcRqK5p4u31nLg==
X-Google-Smtp-Source: AGHT+IFb+31j8aguJo3o5v/yxAzNfgc3FgIXMcgrFLafSVt2YfOorz1Vk8Xqwy3zW3uCpoZ3Q9/vlA==
X-Received: by 2002:a05:6214:acc:b0:62d:ddeb:3770 with SMTP id g12-20020a0562140acc00b0062dddeb3770mr1706096qvi.0.1694695726278;
        Thu, 14 Sep 2023 05:48:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id c9-20020a0ce149000000b00655d6d3147bsm447704qvl.14.2023.09.14.05.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:48:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qglm0-003jPR-7n;
	Thu, 14 Sep 2023 09:48:44 -0300
Date: Thu, 14 Sep 2023 09:48:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Message-ID: <ZQMBLFB20ke4hv9t@ziepe.ca>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
 <ZQHJoK0Er/nekjL6@ziepe.ca>
 <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>

On Wed, Sep 13, 2023 at 07:46:45PM +0100, Robin Murphy wrote:
> On 2023-09-13 15:39, Jason Gunthorpe wrote:
> > On Tue, Sep 12, 2023 at 05:18:44PM +0100, Robin Murphy wrote:
> > > The current checks for the __IOMMU_DOMAIN_PAGING capability seem a
> > > bit stifled, since it is quite likely now that a non-paging domain
> > > won't have a pgsize_bitmap and/or mapping ops, and thus get caught
> > > by the earlier condition anyway. Swap them around to test the more
> > > fundamental condition first, then we can reasonably also upgrade
> > > the other to a WARN_ON, since if a driver does ever expose a paging
> > > domain without the means to actually page, it's clearly very broken.
> > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/iommu/iommu.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index c83f2e4c56f5..391bcae4d02d 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
> > >   	phys_addr_t orig_paddr = paddr;
> > >   	int ret = 0;
> > > -	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> > > -		return -ENODEV;
> > > -
> > >   	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
> > >   		return -EINVAL;
> > 
> > Why isn't this a WARN_ON? The caller is clearly lost its mind if it
> > is calling map on a non paging domain..
> 
> Sure it's a dumb thing to do, however I don't think we can reasonably say
> without question that an external caller being dumb represents an unexpected
> and serious loss of internal consistency.

WARN_ON is not just for "serious loss of internal consistency" it
should be use in all places where invariant are violated. We can't
guess why the caller is using this wrong (most likely it is UAF or
memory corruption), but if this fires something definately has gone
wrong with the kernel.

eg if syzkaller somehow hits this we want the WARN_ON so it reports
it.

> > > +	if (WARN_ON(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> > > +		return -ENODEV;
> > > +
> > 
> > And these could be moved to after attach so they are not in any fast
> > path, and eventually to after alloc..
> 
> Perhaps, although TBH I can't imagine it making any appreciable difference -
> they're both values we need to load and use soon anyway, so on a sensible
> CPU, the additional overhead should only really be a couple of not-taken
> branch-if-zero instructions, which is nothing at all compared to how much
> goes on in the main loop and the driver op call itself.

IMHO it is a cleaner pattern to check the objects the driver creates
when it creates them, not when we go to try to use them..

Jason
