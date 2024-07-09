Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C2B180047
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549259; cv=none; b=gEq2I+nZXlQFMgd1FL0HsKidvdJnte5ZOaTjFcvDD7TiN6qAE1jnB7EjgkLUt7k6Eh/mPnhl+HOATvZHkcG8koesAgk5jC66+EBR/UNZ9XY+WX+CeevfeuQBxtm5R3TrH2LsiLqMuMlaeZi1OB7OncaDdvj3vXzVLb04ulRZmKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549259; c=relaxed/simple;
	bh=jwZGJyfU07UoYWIzsMHX/3TK3hvf2IuoCeBvu8j4bfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZYl6fMdIKO5r4fnfkt1H0OssZeLWznjZdbkD9tXQpD9JNTcMJNnf9uAZIW86Mymrcr0f7drBf+ijscWaqcJt3/VvsIbR4gHIHkOIxWEqDAHZM0u6paExIIhTL5KzBgYMnoxnEUK0E8zF1u38W/D5+ppKdf971Rme8tdKvSZvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z2tsoDYZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z2tsoDYZ"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b5db7936b3so29826846d6.1
        for <iommu@lists.linux.dev>; Tue, 09 Jul 2024 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720549257; x=1721154057; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9E6V6cY/cj8ZiaAnveer+zyrlVrfa8IU5zVqzB39Oxk=;
        b=Z2tsoDYZt5+28cz11iJzIjlnXhC+a7sNyqpVhCKf4DA+GoRZPBmB76FLkdWCLd/cHz
         zFahJNOnxklVg7yAEtA623qIJMVGL4YSOtDQ1bXrNXCS3Q4OCIi5zaLXZLgjoY05H5eU
         4hm3ZZhOn3khy8LpfKKWl5U3Eh/GPGuoAqiezdGLdb21+Z8oCI/Z6HCpQXAPMilvIcb8
         GgA1FDTemqwW8f69FO/deaVE3aW/lcu2XgCyBBokyUZG9oD+dTj9MezLRl6JQdCBoG9n
         8i3jz7gjLmRp5aENhGI0M61T8Ev62duIws4yZ4bcPITXQj57CqOpSKY3WSJES1+EQaEJ
         zVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720549257; x=1721154057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9E6V6cY/cj8ZiaAnveer+zyrlVrfa8IU5zVqzB39Oxk=;
        b=s+X6VH5NbFv7rO/wN4GitEk83RH5fnqYp7VETTvUwnlLvf8btgvb5GBwBWHvm6wvVS
         SS1enSXbhFDu0bYYXYtAebOCrJaOT7VbWSkp6wr6iUpO99uRwliVpbSQnDQBE1diBVLF
         39RYQA46dJbOTlBT+TsUYIrNk+mut+uPKwNLq8uiSL7b9XPgNI+v9wtZbKjxfhkabtu0
         xtcoBdBNdgoRNu/McVAqdllTl9q+yL2FYh4a7GVVRNd/VAoLwAwloVRoNHQBNZe4ZaxV
         QCFz91cQI9BtCot2RxffqdChpIMZ4dS9olRLUUj36SRQHQrczbTDsQhvPRmVRHyvN+Yc
         HUQA==
X-Forwarded-Encrypted: i=1; AJvYcCXi+8plYWewxHNUSQFeRtSuzgC/SalxkoZrFJth4GLgvusugaNc6Mm9nkosJBebTeYCNDr/q13WAlHPJLUcuB2HZm/OqkY=
X-Gm-Message-State: AOJu0Yy5FAqKEJ0xp0F/oOSmQdCoA4FiFjBvqXGDcX8tQYpuQKTU7rLl
	LOEZIG5wCKPPnzSDp66KqM45Xehxhh7GzVwRAcuLLnhotWyH8YozmrFX83JqIL4=
X-Google-Smtp-Source: AGHT+IHQcPysG+/lYer4BWdKZGOo1vfS8mkZYftL/MoxoyxLIYr0KVtgkTjjYF2ckPALt1hH5llLkw==
X-Received: by 2002:a05:6214:240f:b0:6b5:e58a:6388 with SMTP id 6a1803df08f44-6b61c1c50f0mr42298536d6.46.1720549256724;
        Tue, 09 Jul 2024 11:20:56 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba73984sm10845926d6.75.2024.07.09.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:20:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRFSQ-002pM4-Eq;
	Tue, 09 Jul 2024 15:20:54 -0300
Date: Tue, 9 Jul 2024 15:20:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rob Clark <robdclark@gmail.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <20240709182054.GJ14050@ziepe.ca>
References: <20240626204033.255813-1-robdclark@gmail.com>
 <20240626204033.255813-2-robdclark@gmail.com>
 <20240703150205.GA6012@willie-the-truck>
 <CAF6AEGsgN8O2eJGqcJm1UaPzV2rWSXskAc+A8uk0mVbsj8Wm8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGsgN8O2eJGqcJm1UaPzV2rWSXskAc+A8uk0mVbsj8Wm8A@mail.gmail.com>

On Wed, Jul 03, 2024 at 09:18:43AM -0700, Rob Clark wrote:
> On Wed, Jul 3, 2024 at 8:02 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Rob,
> >
> > On Wed, Jun 26, 2024 at 01:40:26PM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> > > would be traversed for a given iova access.
> > >
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > >  drivers/iommu/io-pgtable-arm.c | 34 +++++++++++++++++++++++++---------
> > >  include/linux/io-pgtable.h     | 16 ++++++++++++++++
> > >  2 files changed, 41 insertions(+), 9 deletions(-)
> >
> > Non-technical question, but with patch 2/2 being drm-specific, how do
> > you plan to get this merged this once it's finalised? I can take this
> > part via the IOMMU tree?
> 
> I guess if need be, I could merge the drm part only after the iommu
> part lands.  We've lived with an earlier iteration of these series as
> downstream patches in the CrOS kernel for this long, it isn't the end
> of the world if it takes a bit longer

We should try not to split series up, there are too many cases where
the other parts don't make it and we end up with some cruft.

This is only two patches, get iommu or DRM to ack their parts and send
it through one tree.

Jason
