Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A815338D
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314197; cv=none; b=XvRXasinCZf3x8x5xHkLWyxsr2ydDu+0xX5en8hSx6RLufY0CLk+JcRLuM8Qnp28u9c2LG/k8svu9Q9uqqohcG+oAbi3NlYky96woBOEOY55DgTx2/j0DT0TQSO3a91It7En8WYzSKzKq94bnjIWc9CnZYwpFXPF3W2SlLy8tgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314197; c=relaxed/simple;
	bh=GD5SmuXSwVVv1nKlBg75L0EkhR8HmCkqnPOpazRcbW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HurrofRMXKfj4a1lslVwhE/OTs4JIpsrAcx+xsPBpPtvPufTdoFk/gKCONhau/64Kb7IfxAlSlNoIJ7lYoZdOO+jDMsPCE5yYZoSZW6RpmoYTBYlwarh2NEySKCDcMQlR4mppaJR7uZhyKVXGXHgUue71oIRIFw8YF9ZkTZ4idw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SWugZmEk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SWugZmEk"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-458320b30e7so33010101cf.0
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728314195; x=1728918995; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GD5SmuXSwVVv1nKlBg75L0EkhR8HmCkqnPOpazRcbW0=;
        b=SWugZmEkG9EXZL99U0+/harYqNArNJyV2w8y9Oo3mSksLS5CGAALP8mAhqVeOTRxJc
         0oA5hsji+8hnbhac/Az6wHuUMnoeDWKXqZLjT7o5fDW/lqeVsYyw6yphnlz61O7Rom/y
         lw7oLcBTsWpY7vhj+TtG8W+x3upDx3t/9zsYGwC8WJLWN4329KHNCqntjPEjhwMT0lOU
         pFWNBB790IOICCt2AL5zaX2IDPx3u5HZOSS5up1pb65VHSmyzy9H7+HUK3RkxedP88i/
         F7Vpyax2MwA/t0gQ5OFL42ECXFtAW0s2QZ3NQw1jXox+4bv8720IcZhBRcTwQyOEjlB2
         2hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728314195; x=1728918995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD5SmuXSwVVv1nKlBg75L0EkhR8HmCkqnPOpazRcbW0=;
        b=r34tqN4y/wk5pouO5SyV6BjbJ3gFqbavSpUzLRWUBSxQcNDzfFBMMAvzwTg0D08lvx
         i8Dfl2fIblnWTv+pk0ZPuwYbTlF+P+dGqS+eRRSmebaUrk30QHDww60RtuQMHQ6R+Gon
         2jvMDv70tfg0LUltIW8rB1sNDV9kBJoner0FekIPPj+qjmoQTLKapXRvR1MOX2aDG7Iv
         jEvn6V1Uv1dY0qjhBSuCY599F7302MyShSxgQ+mnfsorjrmzsGzo7xkQqYyCeGR8YKA5
         D5bokuonpCm40w2jXatp1Fea2tKdQxTLjR0MTw3sbI/GMrn1DXX2I/1Cj0S+JSaIBRLn
         RNsA==
X-Forwarded-Encrypted: i=1; AJvYcCUGgZW714GyvOTni5tXF/3v9yaZumtY0gvrTrToW01hByp99LPtLyvzlJWEAzR1LDLqSoSQRw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqRbRrf+jbfrlB+bLlCBmwzynHZHqr+lkHNCWdno05kMcj4Bvl
	xYeJ1T6pRE6nvg18A8tiLIw1Uhb1Lhuuk8oYEq985T50mdEfSke9jJzLAYVBli4=
X-Google-Smtp-Source: AGHT+IEPba2v0q8aqVC+T2ybeBD+S2XlfnHh/v+Vh0EzHqSIu/q83G/LSTFJH4H1JKueo/M8fL1zKQ==
X-Received: by 2002:ac8:7c46:0:b0:458:3b68:ce39 with SMTP id d75a77b69052e-45d9ba79546mr194075641cf.9.1728314194839;
        Mon, 07 Oct 2024 08:16:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74ea488sm27130131cf.26.2024.10.07.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:16:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sxpTN-002alD-Et;
	Mon, 07 Oct 2024 12:16:33 -0300
Date: Mon, 7 Oct 2024 12:16:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"madvenka@linux.microsoft.com" <madvenka@linux.microsoft.com>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"nh-open-source@amazon.com" <nh-open-source@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Saenz Julienne, Nicolas" <nsaenz@amazon.es>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>
Subject: Re: [RFC PATCH 05/13] iommufd: Serialise persisted iommufds and ioas
Message-ID: <20241007151633.GO2456194@ziepe.ca>
References: <20240916113102.710522-1-jgowans@amazon.com>
 <20240916113102.710522-6-jgowans@amazon.com>
 <20241002185520.GL1369530@ziepe.ca>
 <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6328467adc9b7512f6dd88a6f8f843b8efdc154.camel@amazon.com>

On Mon, Oct 07, 2024 at 08:39:53AM +0000, Gowans, James wrote:

> 2. Get userspace to do the work: userspace needs to re-do the ioctls
> after kexec to reconstruct the objects. My main issue with this approach
> is that the kernel needs to do some sort of trust but verify approach to
> ensure that userspace constructs everything the same way after kexec as
> it was before kexec. We don't want to end up in a state where the
> iommufd objects don't match the persisted page tables.

I think the verification is not so bad, it is just extracting the
physical addresses from the IOAS and comparing to what is stored in
the iommu_domain. If they don't match then the domain can't be adopted
to the IOAS.

We actually don't care about anything else, if userspace creates
different objects with different parameters who cares? All that
matters is that the radix tree contains the same expected information.

> What do you think of this 3rd approach? I can try to sketch it out and
> send another RFC if you think it sounds reasonable.

I think it is the same problem, just in a more maintainable
wrapper. You still have to serialize lots and lots of different
objects and their relationships.

> > Ie "recover" a HWPT from a KHO on a manually created a IOAS with the
> > right "memfd" for the backing storage. Then the recovery can just
> > validate that things are correct and adopt the iommu_domain as the
> > hwpt.
>
> This sounds more like option 2 where we expect userspace to re-drive the
> ioctls, but verify that they have corresponding payloads as before kexec
> so that iommufd objects are consistent with persisted page tables.

Yes

> If the kernel is doing verification wouldn't it be better for the kernel
> to do the ioctl work itself and give the resulting objects to
> userspace?

No :)

It is so much easier to validate the IOPTEs in a radix tree.

At the very worst you just create a HWPT and iommu_domain for
validation, do validation and then throw it away. Compare for two
radix trees is about 50 lines in generic pt, I have it already.

Jason
