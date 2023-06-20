Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB0101FA
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 11:42:44 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b52864b701so35823385ad.3
        for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 04:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1687261363; x=1689853363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDZ7ULI7Gz45/BBzCO4ozBFhMbYvKO7tkQm7FJGGKkA=;
        b=NK/+iMQsbH6NMURen5XkeFO52klpCiQq0sEPZNhqt7WMh0f188qi9ENpXaKj3kdEiB
         Uo59OzT5oFnBhXN5/pK4Yj11KEbHTYT+rhujoUEgAV2dtheH0LHyJ3pf5Qo2bx0vr0WU
         NCHqUrM+zOKJ46WXJR/c+F+yKrEll+q/vvYDC/Xns5UCvMJ7T9jzKl46J81emK33h3IM
         5CHnNyfkCpCBPCJAE4UjxQPAVgXTwenSodu/qzGdTNUocBLbq+DypPyFrPAcB9nuAmlu
         EOTElimsIKTSy+PZf4/SuyNtu5y9CWeCv7qavjftqxiOdhjJPNvOQhBqsasn7OvoX4FT
         eS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261363; x=1689853363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDZ7ULI7Gz45/BBzCO4ozBFhMbYvKO7tkQm7FJGGKkA=;
        b=OmSJ5dMZ8xS9Vr3XbEQQMkh/jyfMtdQlGTIIvYllHLgsNKhlsmLTnsdoBLMTwamocb
         Iri54xED+0sSZzNqmWYEWFfWmUyq3Ee52BV2TYswhO+ZBpRCg2feTz3X156CLZs78h6A
         3Z+HcNRb/NyAUknr7bbLjJV7OWhbFGevF5H6uWQDsLEzrnyipQHS68ti/1pEmUB9qkwv
         wRfflYijgHJ3ztvJXSwmRxGWjtYql/KjkOMvVM2yVpJpzV2GlAgsG93Tcbm7t2VnP88f
         HSqVQcK2kJxx0YjaEYyCvueF4kyPHJRa6dB0v8jEM7R+GmWqAY/6XMAZg7W6uOZ6Hkyg
         ZiOA==
X-Gm-Message-State: AC+VfDwxW5b1sJMSlGLUnZIzhJSQRebZoUqX6IingDvN7vNYFr0kClLa
	HadwamshTJn4baM3HqCfV5d7Kg==
X-Google-Smtp-Source: ACHHUZ4GN/Mo/BjDw4LcFCD4cJhLnKMmS4apsopQwOPfIokotr/jA5x+wAMAm7rayaNJsD2IvxM5BA==
X-Received: by 2002:a17:902:e5c6:b0:1b6:8f20:1a2b with SMTP id u6-20020a170902e5c600b001b68f201a2bmr337929plf.26.1687261363561;
        Tue, 20 Jun 2023 04:42:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e80f00b001b024ee5f6esm1474674plg.81.2023.06.20.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:42:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qBZkv-007KQp-2G;
	Tue, 20 Jun 2023 08:42:41 -0300
Date: Tue, 20 Jun 2023 08:42:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Message-ID: <ZJGQsWXkgTuj7xC1@ziepe.ca>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
 <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>

On Tue, Jun 20, 2023 at 02:31:43PM +0800, Baolu Lu wrote:
> >   err_restore:
> >   	if (old_dom) {
> >   		__iommu_group_set_domain_internal(
> >   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> > +		group->default_domain = old_dom;
> >   		iommu_domain_free(dom);
> >   		old_dom = NULL;
> >   	}
> 
> The err_restore branch doesn't work if old_dom is NULL. We have no means
> to restore a group from a successful first-time attaching to NULL
> attaching.

Yes, this is what I fixed in my alternative version

Jason
