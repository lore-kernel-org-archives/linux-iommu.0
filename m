Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86F8F58
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 17:36:21 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id t9so23605897qtx.8
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 10:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679506581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWbfKdnzylqruLkb669PxI2Ds25u6VYLIbbrabovtsY=;
        b=PQJwj1HPzHv1dtC0s3LoMHBNrziJ3IVIJiiSj7ubk1Ssg4NpoJ16lj3aVjbzQKzGGX
         XMvtY+X/emL9T9l07jeS5LSy+n1C6AQ4TI/c3g3fFpB4zyjl5w7QslGs7TvOO9N7YRDW
         kKq1cJ4HDgAdkQ9UrrlfAU/u79UYRgjiOpTkBKtGNW29CXuv/cJFdTBRR+GURcZ5mQ+a
         4Rrof8zPjg6cdzZmbRiIe35cfkSaVKcuRDD7ogzBdeh5H3KGTejCaXvDZuTnkjr6ahbY
         368qtfEBHTUEs8FXhi5Ex9el+l8BdPR+fjWt+m+0uncVwnmkqa93zXp55EXw7foH0W/C
         kvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679506581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWbfKdnzylqruLkb669PxI2Ds25u6VYLIbbrabovtsY=;
        b=HvKkHtqWmPkRzHOhKmHEgW+XU+l1V4QCbKfo+gPmb21otyPcS6NOEjQR8P5xoRvbiH
         /KPIw+2ErGNuceekZN3WTTlVt2PpjboyQc7dLMj6nU3kPy3Egha1Xw41bpVBxcMTbRsy
         +BBvNyQkVpunQPQAIBFVLb4AWQwAW4ROl0CMHuEm/ePD0ATZtfyG+Ah4Rhye8jqKFlxN
         mqhey9rsF+VML/i5vFy36eTjn8UoSO1V9qievNQ6tynveSdaglPIchr+hJlbh17Qo56S
         UbY+xC4mCvAOLGKIOYsncOdtmU9zP/SeAPRaTd7i9bzUZ23K3bD+AicymjOGFdFXrSAv
         C54A==
X-Gm-Message-State: AO0yUKVFo79vkKegH3m/wYug2RepBQfLMTzbHH4Kk9hiibnfOxh8QMfP
	n50rdfwO2v/YGuEO7n0jmdSQLQ==
X-Google-Smtp-Source: AK7set+1jTuQ5BkMw9ArPzCi/uxOuElPpNpMdi9teoMqfXrR/0DmTYHtW2bV7gjcoP3ib42QHmjm2w==
X-Received: by 2002:a05:622a:1806:b0:3e3:791e:72d0 with SMTP id t6-20020a05622a180600b003e3791e72d0mr8033898qtc.19.1679506580800;
        Wed, 22 Mar 2023 10:36:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g1-20020a37b601000000b00743592b4745sm11604976qkf.109.2023.03.22.10.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:36:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pf2Nn-000yQO-Iz;
	Wed, 22 Mar 2023 14:36:19 -0300
Date: Wed, 22 Mar 2023 14:36:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
Message-ID: <ZBs8k8nki/iqUiwE@ziepe.ca>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
 <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
 <ZBr5e6tn1i7EE/16@ziepe.ca>
 <a5b946f0-5be8-a656-a8d5-1cd75399f0c4@arm.com>
 <ZBsb01emBJJMZIt0@ziepe.ca>
 <bee3e168-3fc3-89e8-6b10-a830f052cf55@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee3e168-3fc3-89e8-6b10-a830f052cf55@arm.com>

On Wed, Mar 22, 2023 at 04:04:25PM +0000, Steven Price wrote:
> On 22/03/2023 15:16, Jason Gunthorpe wrote:
> > On Wed, Mar 22, 2023 at 03:08:41PM +0000, Steven Price wrote:
> >> @@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
> >>  	if (iommu->domain == domain)
> >>  		return 0;
> >>  
> >> -	if (iommu->domain)
> >> -		rk_iommu_detach_device(iommu->domain, dev);
> >> +	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
> >> +	if (ret)
> >> +		return ret;
> > 
> >>  
> >>  	iommu->domain = domain;
> >>  
> >> @@ -1049,8 +1070,6 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
> >>  		return 0;
> >>  
> >>  	ret = rk_iommu_enable(iommu);
> >> -	if (ret)
> >> -		rk_iommu_detach_device(iommu->domain, dev);
> > 
> > I think this still needs error handling, it should put it back to the
> > identity domain and return an error code if it fails to attach to the
> > requested domain.
> 
> What confused me here is that there's already a call to
> rk_iommu_identity_attach() just above. But I can obviously add a...

I don't know this driver at all, but to me it looks like this is
perhaps undoing a partially failed rk_iommu_enable() since it doesn't
seem to enetirely fix itself. Ie it zeros the INT_MASK and DTE_ADDR

Maybe it would be better to put that error cleanup direclty into
enable and just move the iommu->domain assignment to after enable
success.

>        if (ret)
>                rk_iommu_identity_attach(&rk_identity_domain, dev);
> 
> ... in here. But I don't know how to handle an error from
> rk_iommu_identity_attach() at this point. Does it need handling - is a
> WARN_ON sufficient?

WARN_ON should be fine, that is kind of hacky, it would be better to
organize things so there is an identity attach function that cannot
fail, ie pre-assumes all the validation is done alread.y

> 
> > It should also initlaize iommu->domain to the identity domain when the
> > iommu struct is allocated. The iommu->domain should never be
> > NULL. identity domain means the IOMMU is turned off which was
> > previously called "detached".
> 
> I presume you mean in rk_iommu_probe()?

It would be best if it was setup at allocation time so in
rk_iommu_of_xlate() before dev_iommu_priv_set()

Jason
