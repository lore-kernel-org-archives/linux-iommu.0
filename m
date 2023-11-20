Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8719BB9
	for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KUkUl2PO"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6d3260385b5so2230867a34.0
        for <iommu@lists.linux.dev>; Mon, 20 Nov 2023 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700495138; x=1701099938; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM9uvcoV5ag+HkmTgVNIfQvYLbzKwuT2srRTitPCGCI=;
        b=KUkUl2POWtvquxqEZD+R6HMSzZERSq5ouxvalsHrRZrBpNZL2SbT0PkwzEct3wyV5w
         3/7tCYsqyqq7Ckt1IjLrcgEpzE6WcNdl8Kwmj8mIESQiZEyh1CytTtzp+TBltzedmplQ
         lnlYEjOgEnzkb8yncJ2TnXZHuIXX+/eeZnDD5kPO35MA/26iX6r08GRVBhqiML66xVc5
         8fEy3vSyQNAn4SNSTbk8efdM9esMUzclhQiUpLRj4+XzByc1346+JvkmLOiuwkHLV2fT
         SyWVzrywuTzRCiDg8kyhxy0WO9Il8cNrkxRVk1LBEeBb6GeVkNUWd5n7wmZHnV9Q+sCS
         jVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700495138; x=1701099938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM9uvcoV5ag+HkmTgVNIfQvYLbzKwuT2srRTitPCGCI=;
        b=oFNwxJlO2kxJrKB/HsMWZwzd2DBcIVtGAgzyqf4cPPgKdWLzDtNpkQ83zTyGnQxG6Z
         x/a60VbC5YEUQjRf34Ioi7aTRBcfYemBmEAs0tx2qFG0vLNA+0sgg/akI/LtIKUml4iQ
         G0C+TbQEGk15+wtjyLo5mzHyfL6cmV87X4MP5PeU7cQ6RCLa//l+c7GFtXi2TXwQbPpI
         OTAf32iDdhM2+/++kjbIhjS3I6JVJB6D8y21KVScbFqq6NQhupTj2uaVoMwywzBM6elj
         tZotMM22AcOD1T+k/DM2XjtHOq8VSMGAAkpqvOWxQvVXpV4Tr0kH0iMrY7+CPC5fzbTs
         uh5Q==
X-Gm-Message-State: AOJu0Yx+TgJPCQkl8WWAPG84TZXvlcCDLRnT4YZptYcRwghzcPv6K5bF
	vxxKwOBVgXrE6fI+7HkS6OqgbA==
X-Google-Smtp-Source: AGHT+IHazKAMmMUu7WG6XKk34HRvrp2GXdikeXTyF9zWwYYOH3ewfnPuO4HJIzH8J7s1XmGRpIszKw==
X-Received: by 2002:a05:6830:2007:b0:6d6:c0ec:6de8 with SMTP id e7-20020a056830200700b006d6c0ec6de8mr3231220otp.14.1700495138014;
        Mon, 20 Nov 2023 07:45:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id cu24-20020a056830681800b006c4d822bea7sm1216744otb.31.2023.11.20.07.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 07:45:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r56Su-000j0f-EH;
	Mon, 20 Nov 2023 11:45:36 -0400
Date: Mon, 20 Nov 2023 11:45:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231120154536.GE10140@ziepe.ca>
References: <20231110164809.270f82bc@collabora.com>
 <20231110161229.GA462657@nvidia.com>
 <20231110201652.629b7228@collabora.com>
 <20231110194215.GR4488@nvidia.com>
 <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com>
 <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com>
 <20231120144604.GD10140@ziepe.ca>
 <20231120161418.5eca178e@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120161418.5eca178e@collabora.com>

On Mon, Nov 20, 2023 at 04:14:18PM +0100, Boris Brezillon wrote:
> On Mon, 20 Nov 2023 10:46:04 -0400
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Mon, Nov 20, 2023 at 03:38:38PM +0100, Boris Brezillon wrote:
> > 
> > > > At LPC there was quite a lot if interest in improving the io page
> > > > table stuff to work better. Based on that I'm even more against adding
> > > > an external allocator at this time. :\  
> > > 
> > > I'm sure this has been discussed with the IOMMU maintainers, but I'd
> > > really like to hear it from them if you don't mind. Especially since,
> > > as I mentioned, the custom allocator idea comes from Robin, not me...  
> > 
> > It is a community effort - this is my opinion. We now understand this
> > io page table area needs a lot of work to meet all the new needs. I'm
> > against hacking it up like this and making that work harder.
> 
> Consider it a hack if you like, but the thing is pretty self-contained,
> and I doubt it will get to a point where things become unmaintainable
> before you get the generic caching system working. Not to mention
> Gaurav's use case, which can't really be solved with your caching
> solution.

Gaurav doesn't need a custom allocator, he needs a way to manage
sharing page table memory with the hypervisor. A different set of ops
that don't replace the entire allocator would be fine for them.

The issue with taking away the alloc_page is that it complicates the
ability for the common code to use the struct page fields and more. We
already know we are going to need those to do some of the things that
are being asked for, eg RCU freeing and refcounting.

> > I would not expect a resolution in a few weeks.
> 
> OOC, what's the time frame?

The larger need has been discussed is considerable work, I would be
surprised if something could be merged in less than 6 months,
especially with the upcoming holiday season

> I've maintained a subsystem for a few years, so I know what it means
> to contribute upstream and ask or being asked to extend the core to do
> something the right way. I'm generally patient and try to follow
> maintainers' recommendations, but there's some point where waiting is
> no more an option, and you have to be more pragmatic, because there's
> always a better way of doing things, and perfection is often the enemy
> of good...

Here I am not talking about perfection, I am concerned about messing
up work that I now see as important for other iommu drivers related
things by making a hack for a DRM driver (which as I've said has,
unravelling these hacks has been traumatic for many of us
historically)

So while I would not like you copying the code to DRM, but I think it
would be less troublesome to everyone in the longer term.

Jason
