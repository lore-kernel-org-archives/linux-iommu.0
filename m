Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78915DF49
	for <iommu@lists.linux.dev>; Tue,  6 Feb 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242308; cv=none; b=bY+UJEoaam54Ey5sHtFi3QDg3PcdWYVJGL4xUTIn0Vqiu0gRJg7z3+leGS+++Dm/Zku+HeLE9mB8Z1v0YYagMnueTShKnm+70b0V4o/+n7g+B4ohPeVYgiC3KLMdaOV8yWxk5jFPONL9W52OO4CC8MS4Uw8pz2hDz2ncrRcDEiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242308; c=relaxed/simple;
	bh=7951GW6Xp9z97Qmg4nwA2H48FMQiXW6i55JHRPyygFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSxtTaN5JuaNI+XRlBnP0dKJh+E9L3ODo1JQrxGGL+hI2fOyFUuTDND/YODTtIyhEKrk7iYp+zBLvbRIv074sP1B525XXVPgjKpDletC83A4ZsZWOrZa9eDFya/0eV3npE+d+oIppYwpqLi9h+kQ9C3SgJuoo/vbVu0/XWkuBrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bo1Of9+t; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bo1Of9+t"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bb9d54575cso4259047b6e.2
        for <iommu@lists.linux.dev>; Tue, 06 Feb 2024 09:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707242305; x=1707847105; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJL53zKCMRe3rZTEyHPFHRTiYb20tj8XiC5zITZ7zHM=;
        b=bo1Of9+tceTl8QMJvxnBvJTPFVXt0TBVU67ZLpuhW3+x8yAbAtYXBqbLxm1HLrL4xv
         RIv+XNvCqgsKpEg33XqS8gn2+gRHSh8dnGaXvTV4SxZt83h/vLyjIPr/m/gUJADIQpJ6
         Tz68Osd5Awgv+xmMp5yOk0wvlUv3+5S7yzR28CEQXdZh7l6crAlzCy4lykk2uyoZBNlW
         V4IMQHMGTJ5Fj6fjHOD+tvo91aIWZXn44gTENSBywxEFSjtsRXokwq5sHnvGhyvJ15eh
         LRwu30ceOXID3f1ZatqvHqKQ1cmH+9TUJirYXXOXm9vT4770Nbd4uzEwnA7nwDFWdtG0
         NzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707242305; x=1707847105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJL53zKCMRe3rZTEyHPFHRTiYb20tj8XiC5zITZ7zHM=;
        b=TB/rjZvZSeGZO2L2x7B5PNltcDS90CxpxDCITJ19NuYaZxYtf3vY/ik+i9vNw8ARa4
         AD9df9f/YIRzFBSrKsdcb40LJYneVkP0YeJBItXnoikAOoVKhcUhoFhFapmQYbiKdygq
         Ql5w+nSgxHHACVQNG8DhCX4b4/Jo672zpTM5VbhjNMTpSWI2I4HJDWaR2HJWbQxv0BPp
         UziBPT4kAyD0ARyCi/OOz/I3saADh+AaQJny/3o/whutRuRZ6I5fI+GTl47FnuWE6xjf
         i9ArZZ1wpSleMV3hrF4yf4UkVjwlflS3dLU30cQJz5bsZNcsGZgz2Eva2eFMhtYh2cTo
         1f7A==
X-Gm-Message-State: AOJu0YzCJKz7FnUuP0NjkwaYgWt05n7aynGk5DTG/qfc8IiLeg8mJdy/
	XI++tY6irQINBV/WOreFTkv4vHTfe0fkDKIx1Ud4LqLhlNa4xK14GVqNyUpF474=
X-Google-Smtp-Source: AGHT+IHIxjSwRq4awxvzbsyCit5HdkjVc2G/Sq25Nyy8GCii+cQ8pGaqFQNhH4SVRAO+2x/musOiOw==
X-Received: by 2002:a05:6808:13c5:b0:3bf:cf6c:8de2 with SMTP id d5-20020a05680813c500b003bfcf6c8de2mr4009432oiw.40.1707242305518;
        Tue, 06 Feb 2024 09:58:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWPJSrrv1Ey9epUQ5cYk+pOO+yktLog0NOU1G3AjTx3/ww5sQ40gWDR7MvUdtO++23mbNZN/edZU6IRT92bHdh+22sY7RROAgU9MstTA9xiIZzQ0fugGpqXd1CAL70NrUKiJH00A1WrqrOG67Xgg3uPpJ17e0s2QyAqCwIivJMw6FKq4itUIhg=
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id cf11-20020a05680833cb00b003bfba9e47a6sm387812oib.3.2024.02.06.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:58:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXPiC-002uMB-13;
	Tue, 06 Feb 2024 13:58:24 -0400
Date: Tue, 6 Feb 2024 13:58:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v5 10/14] iommu/amd: Introduce logic to enable/disable
 IOPF
Message-ID: <20240206175824.GI31743@ziepe.ca>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-11-vasant.hegde@amd.com>
 <20240201214949.GT50608@ziepe.ca>
 <9d3579c7-66c3-3752-bad8-a8a8ebc5c74c@amd.com>
 <20240206163657.GG31743@ziepe.ca>
 <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873201d4-57d1-e856-87c8-08e2ca71f0a2@amd.com>

On Tue, Feb 06, 2024 at 10:59:03PM +0530, Vasant Hegde wrote:
> On 2/6/2024 10:06 PM, Jason Gunthorpe wrote:
> > On Tue, Feb 06, 2024 at 09:49:36PM +0530, Vasant Hegde wrote:
> > 
> >>> This dte change is in the wrong place. When the domain is first
> >>> attached we know if it requires PRI or not. At that moment the DTE
> >>> should be set properly, it should not be set wrong and then changed
> >>> later.
> >>
> >> We want to enable PPR support only after setting up the handler.
> > 
> > That's backwards. It means error handling can't really be sane..
> 
> Why do you think enabling feature only when we are really going to
> use it backwards?

Because you touch the DTE twice, it means the domain is installed in
an inconsistent state where it is not actually working
properly. Domain updates should not "tear" like that.

You already know what is going to happen at the very start of attach,
you don't need to "enable it after" just do it right the first time
through.

There is a clear protocol and ordering requirement for the PRI
enablement. Lu described it in a comment, make sure you follow it.

You also have to think about what happens during detach and what
happens on all the pairs of attach -> attach.

The error unwinds are tricky, the only way I could make it all be
correct for ARM was to fix the attach handling so that there is no
failure scenario after the DTE is updated. ie the attach functions
either do nothing or fully succeed.

The situation where attach fails and leaves the HW in an unknown state
is really hard to deal with - and without the reliable global blocked
domain the core code can't 100% rescue it either.

> >>> (and again the whole dte setting flow needs cleaning, I think you
> >>> should do that before trying to build more complex stuff on top)
> >>
> >> Yeah. I want to fix few things in that path. But that's outside this series.
> > 
> > I was looking at it and there are many security bugs in here now that
> > iommufd can change the DTE at any time. The current design assumes DMA
> > will be stopped and ignores the spec guidance on how to do a safe DTE
> > update :(
> 
> What security issues are you referring? Can you elaborate?

The DTE is not updated correctly. The HW can read inconsistent
versions of it with unpredictable - and possibly security bad -
results.

Like it doesn't even write the two qwords of the DTE in a predicatble
order! Let alone worrying about the 3 qw update or being correct with
races during an ITE touch :(

This doesn't matter so much if there is no DMA active while the DTE is
being changed, which could sort of reasonably be assumed up till
iommufd allowed it to happen under userspace control.

Now a driver cannot make the assumption that DMA is halted. It must
follow all the protocols to ensure that HW observes only exactly the
DTEs/etc it is trying to build and not something random.

The documentation is pretty clear how this is supposed to work. It is
the same as ARM. Use atomic 64/128 bit stores, rely on 'ignored
behavior' or use the valid bit.

This also means, broadly, you can't allow the DTE to evolve during the
operation of attach/detach as the in-between states may become
userspace visible and may be harmful in some way.

> > I'm really not comfortable with adding more stuff here until the
> > security issue is solved. Especially if the more stuff is drifting
> > further from being correct. If you can keep the updates in set_dte
> > then maybe with some reluctance. But not like this with random touches
> > to the DTE all over the place.
>
> Currently all DTE update is happening inside set_dte only (dirty bit enable is
> an exception that may need to moved inside set_dte). This patch just invokes
> that set_dte and invalidates cache.

So then why all this strangeness?? Just set dev_data->ppr earlier in
attach and order the handler setup properly.

It should be really simple:

 // All protected by the core's group mutex

 if (domain->needs_pri)  {
     dev_data->ppr = true;
     if (!dev_data->num_pri_domains)
       // enable fault queues for the device
     dev_data->num_pri_domains++
 }

 if (old_domain->needs_pri) {
     dev_data->num_pri_domains--;
     if (!dev_data->num_pri_domains) {
         dev_data->ppr = false;
         disable pri at PCI()
     }
 }

 set_dte()

 if (domain->needs_pr)
    enable pri at PCI()

The order here is really important too!

Since PRI can only be supported when a GCR3 is present, this should
all be part of some generic 'install GCR3 table DTE' routine that is
called on all the attach paths.

Jason
