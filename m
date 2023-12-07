Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E5A405DD
	for <iommu@lists.linux.dev>; Thu,  7 Dec 2023 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lBPefoEg"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b9db318839so591624b6e.3
        for <iommu@lists.linux.dev>; Thu, 07 Dec 2023 05:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701956192; x=1702560992; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwDkkPUreM+kT7f1DugxhqlPlB5ZMWRT1cx42MxAk4I=;
        b=lBPefoEgjH0CFrUX5uguh03dhK0cI6ACFIu20hG/SofokrG4KJtpj5uAOtPcjxaQmV
         sWySzUxKxGmn8ZIt/11P7BBRzheuvSahlZEtVrsfRkzg2TRHS/dBCFBEbfobzRJ+O4RO
         vj+I6Jt2b93MK7cyJFIqTxQVwkvdx2M+RPaGNhs1jFKE3hUx1fxeYxEaXug/KrenQ/dm
         h30BLIbUDckJvgJ9ad2pJeKpjyFFBYLm4LHmNMHV4030Bqaay2w03ftMw7NbpvRqsSDP
         aRz4ZRRyJvYD9tqhdFouCmQDqBb6ijWs4JvpJixbfO2ym9eyXv4QjwLppGpvIA+Kinhe
         z74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956192; x=1702560992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwDkkPUreM+kT7f1DugxhqlPlB5ZMWRT1cx42MxAk4I=;
        b=atNoTa0jTIoFb1G8nmktxhN1Dnbjanpb0B00sBz4aGG7yGdjpH8i0EcufeCQL+Oywf
         bq48mtcWP9UeqK7ojqVuFfVi8wa2dSLTpIj9YjDzl/jMLXgW35rxCjABw/dUcxfYWREc
         9SbcaCo+3Wn6mhHjulZbv9jKt/bLqEKZp+5jzWI9ghiaDPaZtyKQeHcSmUZSvq4Houso
         SJ8O/QaYxsSa00zruJ8Wec2ui7wFec4nm2mqmNOcjH7XDYTdmxQqsX9M9nK5yzgxmWbf
         HuaHqUwJ/8ypxRNIEq1EI9B96AxqOKeq0M35rDmY9kKYId60XN+QW2SXt6lJ9P4sPEB4
         YZWw==
X-Gm-Message-State: AOJu0YyDDFQe3jroMYz3G7xMaiMLyuvVpcOIbjz1tD7/Pvu/dz494BBH
	/JBOPcs+y3NB6pAzDItkNdxppQ==
X-Google-Smtp-Source: AGHT+IH6fAbj16DTLfT8u3PbyCwETOojac9pGddUrlBYHcgsySGBqjGqZwT8hQo4ADzlc4325nrSLg==
X-Received: by 2002:a05:6808:df2:b0:3b8:b063:6675 with SMTP id g50-20020a0568080df200b003b8b0636675mr2155128oic.108.1701956191899;
        Thu, 07 Dec 2023 05:36:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id d2-20020ac851c2000000b0041aff9339a2sm481604qtn.22.2023.12.07.05.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:36:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rBEYI-00Bzlz-II;
	Thu, 07 Dec 2023 09:36:30 -0400
Date: Thu, 7 Dec 2023 09:36:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Set owner token to sva and nested domains
Message-ID: <20231207133630.GS1489931@ziepe.ca>
References: <20231207021938.306738-1-baolu.lu@linux.intel.com>
 <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>

On Thu, Dec 07, 2023 at 09:56:10AM +0000, Robin Murphy wrote:
> On 2023-12-07 2:19 am, Lu Baolu wrote:
> > Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> > an owner token to an iommu_domain. This token is checked during domain
> > attachment to RID or PASID through the generic iommu interfaces.
> > 
> > The sva and nested domains are attached to device or PASID through the
> > generic iommu interfaces. Therefore, they require the owner token to be
> > set during allocation. Otherwise, they fail to attach.
> 
> Oops, I missed that iommu_sva_domain_alloc() is a thing - when did we get
> such a confusing proliferation of domain allocation paths? Sigh...

We have alot of different kinds of domains now, APIs that are giant
multiplexers are not good.

What I've been wanting to do for a while is to have the drivers call a
helper to allocate their domain struct and the helper would initialize
the common iommu_domain instead of doing this after the op
returns. This is more typical kernel pattern and avoids some of the
confusion about when struct members are valid or not (notice some of
driver code needs iommu_domain stuff set earlier and we confusingly
initialize things twice :()

> I think we should set the owner generically there, since presumably it's
> being missed for SMMUv3/AMD/etc. SVA domains as well. Nested domains are
> supposed to be OK since both ->domain_alloc_user callsites are covered, or
> is there some other sneaky path I've also missed?

Indeed, I also think the first hunk is not needed, the second hunk was
missed.

Jason
