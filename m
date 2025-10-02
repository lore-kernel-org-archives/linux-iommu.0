Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795314A8B
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759445918; cv=none; b=B8WvwHIh5UKB0m+LnejntNs6ujieaP+gWW7imqbiOUNHNfH87PZGG+AtCpE3+zcYx+JWmSfZdQjoYUDrZ01mEoovLykaFNAT3H50yL9Q1qVtt8e6Rrua3wZHXTBZkgRyvP04E70RBrUpfRaQgyapvLfQTRlFFvnJ0FaHz7M2934=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759445918; c=relaxed/simple;
	bh=Y7ngC7HojWm7IUs9PGbu+/f7WUp+fPvyjflZvuNQEyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht7qk0Dl5195cC5IBsWUwI+L45caE3CnB5yQjwOUtSQl+ymi1FdHHYKkahfBdSDcJdpHUspKKoY8uH3JQPpDsmDUrKNLYkaPwLX7MZd2zU3PPPFJoGAZLNI4ExtyjTHIs7iyAcoQQ/EGRDYjjYyZk/PbJH/pfqtYtPxP0Bznbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WTf1ynJC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WTf1ynJC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-87a0801ba1aso59601985a.2
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759445916; x=1760050716; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BD70i09QaMORHOgNG1NIf1k6EzR92nb/hgxntasDR3A=;
        b=WTf1ynJC+F2Xxi/tQIdXuyRry1nTC7ZDeH8KKcS+0pjZLjI2cJ3Z2/YpyXKnIJi52S
         YpXD8ZHDAA1LRB4CWsVvPqQc4pO/VuzQ5rI7LLf9eqmSMnzv/+bkhd1rLjk9EW0ULWOW
         qY30i2rnHBzh17WbDxGIfteDC3+2UT4TjdHFd9BDq7T/FCa0PFr88Y0jjPQQ1X74gX01
         7/Te6PL4djIb3hwsGZUIBdo5LaFnDYn48/XS3MNSlmpsgtIentDwIQXQ/QiU2zoYto0O
         P42XAqTlA0SI6KjUT/d8B95fsuY2Ca9gDEH3VLBrtvKLRDrP4s3Gza+QC9vPlgsMV02c
         /KYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759445916; x=1760050716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD70i09QaMORHOgNG1NIf1k6EzR92nb/hgxntasDR3A=;
        b=jeWFFKUWwlDN+XYWxLWSu246O5uKqx047N/hsMZCHXJ4k/oVzZZ1Z8UpFWJhEtwsiJ
         Vk/KA7HneFIunaABoIe6Esn6bV0mqKqIclEj/AC8i84aud1xp3fTu1JLsaUjWnb40EQd
         CnHn97iYPacKP4y7uXFNmrp6y4KBoxfzrxZDL+B89pGsBqXndR5vP+FQdvdUQzEUzXPi
         MsTZ1xb4WYgZ0MMjJOwUXt8Qmi3Yw3btGJV1wcff4udpNKK1sG+RAmS30vIKrnmW+E4Z
         XLXaweeHIwWF4XzfsU9du0SwHNB9Ea9WIcITv8VUODPqa6Mp1jpIOiC2N/SGAm9hfV+c
         bRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqoqxZcuZFc5LuvVIaFu+Gqq+nXibnSng3zCOYMl2Jgx4dIHdWVimj70W8/DEa98M/TzlQBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYOD4TnwUywDjq41nk78ZlvLqhbKyDiWQVgA/0Wvx171vYmZCs
	EbE5VjiX36CgA9Ej80eISO+CMtDbxXfSAiQN6a4SyOXi6lnJyN8Vj99MehRZ2W++YMI=
X-Gm-Gg: ASbGncukv3VvMb9xMH/PKonzxkXJBNj5nPE52qWaPaGPujTUNRmp6FAC83oLIEYb81R
	2klyeVZuf/4dPOjeqCNBO4Dj5SU05fcpi73nWA36GpTPWcRmFttLMMdkGH9yUJXSoI0MRhSR4RB
	Ld88iVn9oMWiD0NI0Zd/JsKWUIxlQSmTwXnOKxQtspCGDGriRoR7RpQfhhnfzEKceD/gXlOpUou
	5DtwbfH8BHFNotKvziW1VDH0sonMTVManb6EhO+TeM9UPWFvBNA77UIs9V8rVbfZ/OqYqoTjavC
	fl4HPxgGAqw9HEp+Z7QSDdLhxHzWgTA3KQD04T5Js2TUs6qQtrpGObO900U8kQIBhsWLog7G83c
	qomN3c9RDNDnnCtWjhNU2QcydigGuGZDpzNkdGDKYglpjMtoayE5SRyLdbDzfCkeXevDUi8IdBh
	ZFNEzstNq24Q3lLAeK
X-Google-Smtp-Source: AGHT+IHCc1FLv00zZuPdiNAyfYYP5u1gSaWvc8oyXsbkG+278vuif9Ukg/t+3FfiMRq3Nh5J7YH1Gg==
X-Received: by 2002:a05:620a:1917:b0:84c:65bd:2835 with SMTP id af79cd13be357-87a378d2e6bmr165704185a.42.1759445915598;
        Thu, 02 Oct 2025 15:58:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777112966asm293725985a.4.2025.10.02.15.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 15:58:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4SFu-0000000E1CO-07w7;
	Thu, 02 Oct 2025 19:58:34 -0300
Date: Thu, 2 Oct 2025 19:58:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251002225834.GJ3195829@ziepe.ca>
References: <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca>
 <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca>
 <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>

On Thu, Oct 02, 2025 at 05:30:53PM -0400, Pasha Tatashin wrote:
> > Maybe finish is too broad grained? What if each session had a finish?
> > All the objects in the session are cleaned up, invoke the session
> > finish and the memfd's in the session unfreeze?
> 
> All sessions have their own finish:
> https://lore.kernel.org/all/20250929010321.3462457-15-pasha.tatashin@soleen.com
> LIVEUPDATE_SESSION_SET_EVENT
> 
> Each session can go into a "finished" state independently. However, I
> am still thinking about whether a dependency graph is needed. I feel
> that if we require FDs to be added to a session in a specific order
> (i.e., dependencies must be added first), and every subsequent FD
> checks that all prerequisites are already in the session via the
> existing can_preserve() callback, we should be okay, as long as we
> finish() them in reverse order.

I don't think it is quite that simple, like "finishing" an
iommu_domain cannot reconnect it back to the memfd. The only way to
finish it in the current sketch is to delete it.

So if you have a notion that finish is disallowed and when it is
actually finished maybe the order doesn't matter?

eg it doesn't matter what order we unfreeze memfds in.

This sort of assumes that something outside luo is still ensuring that
no disallowed operations are happening to the objects. eg nobody is
trying to ftruncate a memfd.

But I don't quite know what other objects besides memfd are going to
have this special frozen state??

> There are two issues:
> 1. What do we do with LIVEUPDATE_SESSION_UNPRESERVE_FD ?
> We can simply remove this IOCTL all together. Stuff can be unpreserved
> by simply closing session FD.

This is for serialize error handling? It does make sense if some sub
component of a session fails to serialize you'd just give up and close
the whole session.

> 2. Remembering this order on the way back, and since we are using the
> token as an iterator, that is not going to work, unless the graph is
> also preserved. However, now that we have sessions and the token
> values are independent for each session, I am thinking we can go back
> to the model where the kernel issues tokens when FDs are preserved, as
> each session will always start from token=0. This way FD preservation
> order and token order will always match.

You could just encode a preservation order numer in a seperate field?

Jason
