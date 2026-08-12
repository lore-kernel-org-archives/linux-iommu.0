Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB30B3C9ED9
	for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568262; cv=none; b=SvyRXjgN9+n551lhGMfxfg4/3XmJiJInuDLjAvUZNKwLAbb/1bKAFxfAsUBOggmHnnGV8gljmJph7XdHD03207Z2Sb4HhFPAsu7RnCGSW3dBMUHRZHMXwFrxE4HWDYoB7k+qa9Js6oJ9UFQoWKkKGjTOQL8pTm/HA4DTY6GOLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568262; c=relaxed/simple;
	bh=+T8rIYQMA0RYua306DzF39UQaD76cYSTxyj942vKdRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpeQeZ2NXHGqhQwCrfQmEVsL/YelFa+KO1epIl/2WlvhG67L3+PuUyOi5ZEjskos+L8H6wPZcQ03W48VeJa72dnfwuQn2TAttJ05FvQ9Dwgg7FbVCj+EJwWcGoYu6gy7gELMUhU7Bvm9GnjgoODJIqs8+f9IG5XnPt6QYxGxwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=M5EaZYAm; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M5EaZYAm"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-936623c6dd3so21566885a.0
        for <iommu@lists.linux.dev>; Wed, 12 Aug 2026 13:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786568260; x=1787173060; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/JxJ+OXxlnRn0rZzk42XaW0KL3+pcXSN0DjXbqxyWs=;
        b=M5EaZYAm8adyMI8Fzh9z1CIMNx7of2ctFBBJnGoN3zlxAOXjMGOpn9/Zj+Zqx8wFyc
         ijObNOaEEZ0XoiVZHoSxsu7ayV2sQy03rj2juD7azx6y2JstwJ4K0+iGjathloXQKH6p
         D8cNroXD2xKI7wqtCqof+1CBGoSa63aFWylJrtHwZUCKqpynBWbcxQT/LdI9sQrgiI4w
         grcLoNxAnJiwuIjOt5GfakmONv/ESkvLLCF+Id2ICGmqBc/9e1oXO0+0cEKMydUvGcgW
         5fmi1AMqDwWCwST6yiXYCzrQsl+CMEQX4FbEeDK4DH/JUUXqhaQw/+em4XN0cce2hRgP
         s3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786568260; x=1787173060;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/JxJ+OXxlnRn0rZzk42XaW0KL3+pcXSN0DjXbqxyWs=;
        b=XK7PhRLtpJPENyGGPE/NYi7DnUs51WAN6eIPjOxNoZfXbkUSoRIam9g6a7v0cPmq+7
         26ecPuNV3Nc8lVr2oTtyBDTZLSHr3PJAmtS1p2HMkQRFdbOybyGmJWtGivpYEp6elrg/
         8BVEmLGKQ0AnbKNjzsD918O12tbDGypBlXPkkqlH4ddxyob4p3Evv3ey9w1mOqyB6p6y
         47rezWmHZGQNU1YkSjDYMfcXL+pZX4dVT8rpAw5+BHbLqe+GFhWvn3JBtsxGLSAljixh
         j+aneEftOzS4awTFzP3vcaU55E9TWC5+6+eowguAJ8apG3xP9P2FrpzyHUoUZt5tF4bH
         wgxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7mRR/607GHOObcQlD8C3vX9TiMTXguZMObgKtSArqekTQJJ3ZjuiuMnpkBFReu/eirHXReQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNfff3Gl4pF0gBf2M2up+TTzsTgbTHQmZ8VGYvXjuZUFTow30N
	jOURZXMEaU8JFqGOCXhvfBWhRkDg/eBCfc/2alL4WckL0L4eTZ+hMyuPkuIYgXivnXw=
X-Gm-Gg: AR+sD13dRFMV3ohpmXYGtVkQSlp925fSbasjnD5eZQvQi9AQjA2270igtWxT6+9mgxr
	3tDK+pIzMvRmIxiwuSqEL5y+Wz7Ul+vu/2nIsZbFpKLrCvXxpHlRQ7fyMtKfo9zvrdX2xNYu7C/
	f+MgDI7UwTCzhzMNGvjq9QpC2gAf5O7yjUuPW5f+dNJA9tHNH4vDxnLIL87ijFR6P2qi66GQtEE
	EH0UiMgX5pG2AoFzoiwY4iFgQQ03GacPXVnPFCjmUMWMFsgQI7R3EdPNnLYN084GAicandMkFyp
	Zf+oaKe+JXai4/PPyst38Xxe7Nf7XmGFchqU09HMlkq+/o5hzeh8eGBgC2uFf+yjWUGtBnmmRv2
	u7MyPwMpB5n0/LbYem5CevFpsrrKKJ66GcFAu1sYT/o0hVPVyHgNZHAxNCSFBAvViTdzoUGro9d
	Ld65qjGcJrHGLIiaZwd7uYA/NPhgWed+LyTNIJEA==
X-Received: by 2002:a05:620a:278f:b0:936:a8cd:a28a with SMTP id af79cd13be357-936c07f15f7mr50947085a.22.1786568258588;
        Wed, 12 Aug 2026 13:57:38 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936c199108csm778485a.19.2026.08.12.13.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:57:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wuG13-00000003Y59-0iGE;
	Wed, 12 Aug 2026 17:57:37 -0300
Date: Wed, 12 Aug 2026 17:57:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Longia, Amandeep Kaur" <AmandeepKaur.Longia@amd.com>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <20260812205737.GG662699@ziepe.ca>
References: <2f400c7f-eada-45e3-9079-7b5727ecb5c3@amd.com>
 <bacdf160-8ab2-4bd6-aa9d-ab63b16527fa@amd.com>
 <08f2e48e-6e98-4fde-af71-cb8cde666bdf@amd.com>
 <20260805010706.GC28508@ziepe.ca>
 <39ce2a2f-3bb8-43e7-9446-a67551cce104@amd.com>
 <BN9PR12MB5146934D584CF0A2A9DD8CFCF7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805175308.GD28508@ziepe.ca>
 <BN9PR12MB51467229315BC8D731239E80F7D32@BN9PR12MB5146.namprd12.prod.outlook.com>
 <20260805191116.GE28508@ziepe.ca>
 <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR12MB51463D56248A4DE952E6DCA2F7DC2@BN9PR12MB5146.namprd12.prod.outlook.com>

On Wed, Aug 12, 2026 at 08:29:24PM +0000, Deucher, Alexander wrote:
> AMD General
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Wednesday, August 5, 2026 3:11 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> > iommu@lists.linux.dev; joro@8bytes.org; linux-pci@vger.kernel.org;
> > will@kernel.org; robin.murphy@arm.com; Suthikulpanit, Suravee
> > <Suravee.Suthikulpanit@amd.com>; bhelgaas@google.com; Longia,
> > Amandeep Kaur <AmandeepKaur.Longia@amd.com>
> > Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs
> > only
> >
> > On Wed, Aug 05, 2026 at 06:12:05PM +0000, Deucher, Alexander wrote:
> >
> > > > On Wed, Aug 05, 2026 at 05:22:22PM +0000, Deucher, Alexander wrote:
> > > >
> > > > > IIRC, they supported SME, but it wasn't usable due to other
> > > > > limitations (e.g., the requirement for identity mappings due to
> > > > > the display hw bug and the latency impact of encryption for
> > > > > displays in system memory).  Do you could effectively pick either SME or
> > displays.
> > > >
> > > > IMHO the GPU driver should fail if it cannot work because it can't
> > > > reach the IOVA space requried for SME ...
> > > >
> > > > I don't think this should be a iommu problem to deal with
> > >
> > > That means no display for the user which is a not a good user
> > > experience. Most users of systems with integrated graphics would
> > > probably prefer displays over SME.
> >
> > You said IOVA translation doesn't work at all on these devices due to a bug, so
> > what is the iommu even supposed to do? It can't select identity because the
> > device doesn't work that way and it can't select paging because it doesn't work
> > that way either.
> >
> > Or are you saying paging sort of works enough to do something half-busted?
> 
> IOVAs worked fine for everything on the GPU (gfx, video enc/dec,
> etc.) except for displays.  You could avoid the problem by limiting
> displays to carve out, but many of these platforms shipped with so
> little carve out that that it wasn't feasible to use carve out for
> displays beyond the UEFI splash screen.  That's what we did on Linux
> initially until lots of OEMs started shipping platforms with minimal
> carve out and no way to change it.

Sure, but the end result is the GPU and SME are inherently
incompatible, we can't really fix it.

What's wrong with blowing up at boot with a clear message that Linux
must have SME disabled on this HW printed to the UEFI console?

Jason
