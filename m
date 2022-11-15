Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00A1AD30
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 13:25:09 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id s20so9417410qkg.5
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 05:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3FFkarC3g2Wo3KNSd9cKHA/vHYavLbu7x70aWEvueqs=;
        b=pK70hIzR/AwJqhg4FXL7rkWJsxc9oWPlH7P1+X30OCFC3CAdUlD//J/rUoMZqhMfjY
         o8f4fjDov3MENq1XFWufBPGQCNB3MTcsBagRqspghOot35mI7OTem43H3R6zQz/P8L6X
         xIOHi7OxLXf2DREZcruTzSWpQDrarXu1U7+wEsidISOdu2+/shnyk8pV3MP6rfzb5y7K
         wgy/gdJr785E/C/7lQinoVSCeh57bTLiQw393YE9yig4kYPuLWfnzVU7WFl4kZXxXh2W
         EW8iwmnQoKBJFCMGqgtjxUGf7t07r5g179ivE/uFCu+eyXDwKanY6VrU49RRk4ywmCPy
         ElrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FFkarC3g2Wo3KNSd9cKHA/vHYavLbu7x70aWEvueqs=;
        b=bhouS1fZDhCNX4ec+YgRaAu6jaeBsgfsfiileH9lShGHnFN+nMHTWPqKYn0E3O42FP
         Icx0cI6YDsn5TM7ASJG78oAB8fU/yk2tzRRaSD4+0N4u5gzIcv5kDpWgY/MOp8yYHcL9
         M3gdQcWheIKHjOk/CDaxm0GJM7zxaEmhkM72K3YcQvkWCKtGQQEDKcCjIIaskVvRycqm
         VKgvsiGtQytG5SRiF+6vCS91D/8lHkj49U5zqk5yJ2/IaWPUAJPzQ+uUIDXQifft3AWR
         KB9nd27m6vxinfzIUR/lpcFBLmdu8fdRG1Xoj8DkJ4xD1V809plixqK4ScikLYFo55Wt
         yUKg==
X-Gm-Message-State: ANoB5plS+JrJhfTmNurw/nrNvoq4I3f9RnPxIQRvMg+BcghxmULXbPzI
	WbW7wWYOiGwgzY5YbvObFX9AYWx9xdawjw==
X-Google-Smtp-Source: AA0mqf5wSrjegLfvPc7TIH17rmpYrwDWDGcyL5ks9rMLoJdLFUzMp6UFxqRApOeS5cdl9fsTYQSAMw==
X-Received: by 2002:a37:bb06:0:b0:6fa:43e1:2d48 with SMTP id l6-20020a37bb06000000b006fa43e12d48mr14918170qkf.12.1668518708595;
        Tue, 15 Nov 2022 05:25:08 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id x200-20020a3763d1000000b006fa8299b4d5sm8049159qkb.100.2022.11.15.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:25:07 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ouvw3-003sAn-7a;
	Tue, 15 Nov 2022 09:25:07 -0400
Date: Tue, 15 Nov 2022 09:25:07 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dan Carpenter <error27@gmail.com>
Cc: iommu@lists.linux.dev
Subject: Re: [bug report] iommufd: Add a selftest
Message-ID: <Y3OTMwnYKWs7z8lj@ziepe.ca>
References: <Y3OK6DeM6X4q5JWO@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3OK6DeM6X4q5JWO@kili>

On Tue, Nov 15, 2022 at 03:49:44PM +0300, Dan Carpenter wrote:
> Hello Jason Gunthorpe,
> 
> The patch 147393321d65: "iommufd: Add a selftest" from Nov 19, 2021,
> leads to the following Smatch static checker warning:
> 
> 	drivers/iommu/iommufd/selftest.c:160 mock_domain_map_pages()
> 	warn: use 'gfp' here instead of GFP_XXX?
> 
> drivers/iommu/iommufd/selftest.c
>    133  static int mock_domain_map_pages(struct iommu_domain *domain,
>    134                                   unsigned long iova, phys_addr_t paddr,
>    135                                   size_t pgsize, size_t pgcount, int prot,
>    136                                   gfp_t gfp, size_t *mapped)
>    137  {
>    138          struct mock_iommu_domain *mock =
>    139                  container_of(domain, struct mock_iommu_domain, domain);
>    140          unsigned long flags = MOCK_PFN_START_IOVA;
>    141          unsigned long start_iova = iova;
>    142  
>    143          /*
>    144           * xarray does not reliably work with fault injection because it does a
>    145           * retry allocation, so put our own failure point.
>    146           */
>    147          if (iommufd_should_fail())
>    148                  return -ENOENT;
>    149  
>    150          WARN_ON(iova % MOCK_IO_PAGE_SIZE);
>    151          WARN_ON(pgsize % MOCK_IO_PAGE_SIZE);
>    152          for (; pgcount; pgcount--) {
>    153                  size_t cur;
>    154  
>    155                  for (cur = 0; cur != pgsize; cur += MOCK_IO_PAGE_SIZE) {
>    156                          void *old;
>    157  
>    158                          if (pgcount == 1 && cur + MOCK_IO_PAGE_SIZE == pgsize)
>    159                                  flags = MOCK_PFN_LAST_IOVA;
>    160                          old = xa_store(&mock->pfns, iova / MOCK_IO_PAGE_SIZE,
>    161                                         xa_mk_value((paddr / MOCK_IO_PAGE_SIZE) |
>    162                                                     flags),
>    163                                         GFP_KERNEL);
>                                                ^^^^^^^^^^
> "gfp" isn't used anywhere so maybe it was intended here?

It is always GFP_KERNEL, but yes it can use that. I fixed it

Jason
