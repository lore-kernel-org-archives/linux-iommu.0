Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0B6026A
	for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058057; cv=none; b=N0Unnix24qVzEyuM0mRSjZLWlhtAyQGcczIXLNw0oXAPetqurbz3kRPF1xM70xod1l1/A9Rij3zBQz+MnMzJtT64TVTBm/+d9109bf8jGU7bip0JT7ek1CcxLYuZWPZVJqZR8dQuqs2V9opf2nLnA89oyOb8E8bvzZYpxfCh3uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058057; c=relaxed/simple;
	bh=g/PhggfIv0EWCrJhXnxNBPYjMM0MmpbQ2pNY+JxsEzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJrY6EfdupGmTFLr3chE33/Vg1pUxfiVVRbOq1+hqYES5ZmG9I+Rmyht/7gumsiM0EBuULmVRoy8ZskJUvhGKuxdxLiQl75USxB452ASrJfY0y13z5mSZYZrNRDhaUmFOnmUxcaeySuGMJ9m+ZaXSjJQ9LkiuUDjxpyYO293NQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pSt7I2E8; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pSt7I2E8"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7958133cca2so143938185a.0
        for <iommu@lists.linux.dev>; Mon, 10 Jun 2024 15:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718058055; x=1718662855; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IK36WmyP6FxP12hNW+mAYXAuqO1K5/Xu82XpbAGcEYI=;
        b=pSt7I2E8fgGHs4Wr+V/23g42lQgRMHHmBCB6LmlZOza/ow6Pre5+bQtCeIrzvG4sZp
         98SPLqqie3KUhkg5TfOKJAJRFgtvAKWy9JkFCCcTh/abJQOI1QQQgX/8q4qWcMO7cgp+
         lRW4Htdgcr8iyvybt+T/IxAFf9W3keBSdxhu3TbnbV1tZwL+WGwEtsMGHJj5i63berKY
         jzOGvmGBWUrRiFO5gWIdxyDm5x5BQdz7FqpYIVTToRVWy+bzRRAV3L5PyyX5w2wwPR1J
         Sfohh7e2grCoUap0ic5OQ2tN2GE8kHV0HVXuDWQkOxP81GPtHb5wQQjIYimnTrhNTCTk
         b8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058055; x=1718662855;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IK36WmyP6FxP12hNW+mAYXAuqO1K5/Xu82XpbAGcEYI=;
        b=Ig0AjNqVKyyT72YVRKW0h5DNA+Wm5g3elwYTNiXC7whChaaJT6kVH5vByfOfVJ5MZL
         3H+sUUvyHaAmCuj+cvyJtpt9wytHOqxxmq3bO6DC2QkQ/T/WAPKmaS8Us3KY1esW2hD3
         ZrsZeQ4T0SvVq92TSV+AR4FXSwPci/C3g4+ShH1wd9gQlv0tk5vaEMorZRebtqJDvAWa
         39SZLuGexbgPoM7UYXcqmsWLuLnEQ1rJJaMoI9YB8+dE8697EH2WCfEqskOlgXbdkTB6
         4PQ05m6jqop/mep4mtOKprZL4SDFrZFCMZbX9i1zQjJb1N3ougvDM5/ZH7SGnM9jHJ5d
         SFRA==
X-Forwarded-Encrypted: i=1; AJvYcCX+QDhNCqHPrD40QzBq99xqzxe0C4kSu8Mg5uUWZaO5TwPSNdp3gMvptSRrV1JcjSG+TuCaOQ7lkWWmF/R9X2gH7u2FExo=
X-Gm-Message-State: AOJu0YwN+1lJNByRkfIGB6Zel2xJecprpkw/1tn7dlXhWTbiuxnB8NWx
	03NFrIuKmR7u/zrhSy8WEfvTkFr2SL9G2/AhcWK++Y29F6e8Q8hmnrXdYjdGwWQ=
X-Google-Smtp-Source: AGHT+IHVjlKMfA9VJCEHaoVM/zmJJzh0SiPbzZERcL72L1VgK0N7xsovbpdRc0foi5BzwXCYoYpsjA==
X-Received: by 2002:a05:620a:4094:b0:796:5fd7:5219 with SMTP id af79cd13be357-797c2d9fffcmr157451985a.20.1718058054627;
        Mon, 10 Jun 2024 15:20:54 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954f6f337dsm302830785a.42.2024.06.10.15.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:20:52 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sGnNj-00Ftbc-6y;
	Mon, 10 Jun 2024 19:20:51 -0300
Date: Mon, 10 Jun 2024 19:20:51 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com,
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
Message-ID: <20240610222051.GO791043@ziepe.ca>
References: <cover.1716578450.git.tjeznach@rivosinc.com>
 <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>
 <20240610174934.GM791043@ziepe.ca>
 <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>

On Mon, Jun 10, 2024 at 11:48:23AM -0700, Tomasz Jeznach wrote:
> > Right, this is why I asked about negative caching.
> >
> > The VMMs are a prime example of negative caching, in something like
> > the SMMU implementation the VMM will cache the V=0 STE until they see
> > an invalidation.
> >
> > Driving the VMM shadowing/caching entirely off of the standard
> > invalidation mechanism is so much better than any other option.
> >
> > IMHO you should have the RISCV spec revised to allow negative caching
> > in any invalidated data structure to permit the typical VMM design
> > driven off of shadowing triggered by invalidation commands.
> >
> > Once the spec permits negative caching then the software would have to
> > invalidate after going V=0 -> V=1.
> >
> > Jason
> 
> Allowing negative cacheing by the spec (e.g. for VMM use cases) and
> documenting required invalidation sequences would definitely help
> here. 

Yes, you probably should really do that.

> I'm hesitating adding IODIR.INVAL that is not required by the
> spec [1],

If you expect to rapidly revise the spec then you should add it right
now so that all SW implementations that exist are
conforming. Otherwise you'll have compatability problems when you come
to implement nesting.

Obviously the VMM can't rely on a negative caching technique unless
the spec says it can.

> but this is something that can be controlled by a
> capabilities/feature bit once added to the specification or based on
> VID:DID of the emulated Risc-V IOMMU.

I'm not sure it really can. Once you start shipping SW people will run
it in a VM and the VMM will have to forever work without negative
caching.

My strong advice is to not expect the VMM trap random pages in guest
memory, that is a huge mess to implement and will delay your VMM side.

> Another option to consider for VMM is to utilize the WARL property of
> DDTP, and provide fixed location of the single level DDTP, pointing to
> MMIO region, where DDTE updates will result in vmm exit / fault
> handler. This will likely not be as efficient as IODIR.INVAL issued
> for any DDTE updates.

I don't know what all those things mean, but if you mean to have the
VMM supply faulting MMIO space that the VM is forced to put the DDTE
table into, then that would be better. It is still quite abnormal from
the VMM side..

My strong advice is to fix this. It is trivial to add the negative
caching language to the spec and will cause insignificant extra work
in this driver.

The gains on at least the ease of VMM implementation and architectural
similarity to other arches are well worth the effort. Otherwise I fear
it will be a struggle to get nesting support completed :(

Jason
