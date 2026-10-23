Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763343;
	b=x93zMd/DMEukEl99VXIOeHLj9UIwYlVn7t3nIA0ShulvMp+CW0qUe4T2TKu0ofEj2zUJ
	 f47e/UI2jqzQR7BKJA/y2H3Xu4WC1N10TGa7l6NNPEMLK6YlfFg0C/J+vEirJqElELxnV
	 3My86O/FRQGNmQdv44z4W+cNQ5QQFO9x7JXr6/WdNNZNRg50Eby9sKiMWSV2tg0FotR76
	 aqTRdY48YzkMShZnGJ2KAfP7bmed7nyFQFyFOj1/b0sYBIuCz1GScWvweC6OEX950mRJK
	 HV1kbpA9NuGXSiXUbVyX9I7NPxGKEBl21tu+fCpO42DTxNuru5Ltd/k0H+DmufW7x0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WZKXP8VTOXU0OFEfLxvR9auLXjQRH/E3aKS3dlf0WJ8=;
	b=m0oV8ClBC/PRiklZDxBOkdm4vjVyoqOlsZ13RuoFxxA9DDylbIGav2mlSF6fHluBBQEj
	 qDG16RAC7NAV/nLToivefiuWjQgGS04lsoXHhp9tlEPp/ZwEgyUSc7Jo7vqXrmL2KLG0o
	 Yd0s5C/vW5/kH9ElWTuSsLmZXb5MYHJ4U0CzI3BwpBfaDY/KlFycw5Z3ejtqq4F03PZpm
	 k76v0779QMV728Pw/NtpOyqMJh4czuakWz8SjO/W5zx6ppbwuZxiFmeroUzEoqsVunmwh
	 Rg5Rw5OkzExEyks4Sid2TEJqJvvaCv2rgKQg9UzQmKybyOM6BxuPzUzS2gT2vnnKK/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VDn4LM70;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE59606A31A
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 13:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=VDn4LM70
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e503815adso96066885a.1
        for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 06:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792763341; x=1793368141; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZKXP8VTOXU0OFEfLxvR9auLXjQRH/E3aKS3dlf0WJ8=;
        b=VDn4LM70zX8a+2rPv6BohNyTWk7FkA6imWIXv+2qvj8qkLdLwtXGdwhae0j0FUWvT4
         OZp5vqycxlw9sNIdUlCJhx+qR7HVxyLc1uV3+ZuO+SXnTMEcsHs1NCRFNqo/yiwWXfI1
         aOoL5Qs221sPy9bxJUYxzXdDSC86BqHGf2SE5nYpFZ3Xl5PIAKWxiEVxnPtU3Z7nvfGQ
         Mu/FLynXD/3dUxptTVe0gY3Q1sv2AdXWpdGc8ixDzHHNLkSB6g3r3RNlNID6xNQEhCNx
         MekRi2g6yGcMg8CknUn27XzSwUxD9IADiC9bq543hR0GtQPzDaVeh+o+03fEpEsD5ZBt
         CRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763341; x=1793368141;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZKXP8VTOXU0OFEfLxvR9auLXjQRH/E3aKS3dlf0WJ8=;
        b=Pi135nori5fK34IWksUu1B/VQ/mXJ2TSHEDJ2fMcCsQuFqY/BrZPk4ezNhc7PfSN5F
         8Xc7y0nhAb3vJ5HLY6xC9JPHVAAr9XOE5M9Qcczmv62Ozrrbg6fTJp2ViSz3RoeMCbXB
         cI0fyQgmU9wd0lUps1oBN7nhmlq5vNH1Q2l1jgLA8JolvBb+5heNjiJCsPQ0nt5QkwhK
         i5Lpa21lme2ZQlZ4vx6jUUIA83oAJx229itqhBSq9WR8Tr0S9wthUoUh7erBJSV+YOpw
         K5bx82tKXX1cPSXWPNREzh1P7EVyoG7Ehreurl02ETg3iZLlRXmgu7ZwD5sJBRN+AMsu
         sSvg==
X-Forwarded-Encrypted: i=1; AKwUvBz0g8mhAlxB0F2riJzNv2oD7q5eaz0J8ER9sci+yQHr+Tb2sFyLAmLDE/oMhXmFrV9M0jlCzA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLe3Gvmsd+ViLvuxSy92Udho+1VL4pKdyYsb1og+wKRx+2743Yx
	l1mFlL2VXEqEFpen8Kjt9V6DXNl0WoFftAKjzt+xwDMKi0mfxafvZ9SyzUlKWDPFydU=
X-Gm-Gg: AYBFou0pq+n9cQ8/l+6g9m2/qkbETn8FJQZG/ynWb0hzfaA9Wir/xlif2t580JBsu9n
	Sh/FS3ApszbwoyS5nLcMxdX1dcjtMdr/xIcFh1SUYxjGITPehdgO1yANkQqJxGJhtYUMHwzOHjG
	CST1EVH+bWMOi/BqanwQ0R4/jBw7NtBeXmoip577r5QgI+N6Q9Cz99sa0MyO1R5aNsO/0+l4oW1
	F32rDcxYzSuDozbTvM2npnSvYR1cxXGeDrS1PTevkZ+svjcdwxnlFMcvv1sLCnSIzFVIzgG1Prp
	+9bUUt/VXQMb32wd43sCYI7tP3O0ukN+JkuSsnAKNk/ftStyIs92mCW6BHJCqJmn8XclJ1TFc4N
	x+jzFD2pQr8cPHboI/VnM5TD0G5Fk4ua643H89Yqu+Z7Nk2wiwLKBTvpuLd7F5OkpF4w3TleOOR
	4xcoprofZYHNie6Dx7j8cpwO9UZPdLGrY6N1xUUkexFfKStcVpBV6GueYnDv3lEAObZ6JWdJfnB
	3GFZ1BnlFkg5tX0mbdAqQgwzFJ6lvsnk+0J3uoKT5/RMsCuTdQ//qkm471fjtoMb8GGLIEeIQxb
	NkENG8NflLGqNqwpPA2hHUo=
X-Received: by 2002:a05:620a:439e:b0:93f:1cd7:734b with SMTP id af79cd13be357-93f6f796974mr406212285a.34.1792763341610;
        Fri, 23 Oct 2026 06:49:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b1c97esm21136585a.30.2026.10.23.06.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 06:49:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKFdk-0000000GhLJ-2S35;
	Fri, 23 Oct 2026 10:49:00 -0300
Date: Fri, 23 Oct 2026 10:49:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add support for hitless
 replace of S1 domains
Message-ID: <20261023134900.GB3977851@ziepe.ca>
References: <20260925011308.3381953-1-skhawaja@google.com>
 <20260925011308.3381953-4-skhawaja@google.com>
 <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1eb92f-3447-49f0-a210-fd4fa015304b@arm.com>

On Fri, Oct 23, 2026 at 02:43:28PM +0100, Robin Murphy wrote:
> > @@ -3664,8 +3726,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
> >   		struct arm_smmu_cd target_cd;
> >   		arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
> > -		arm_smmu_write_cd_entry(master, IOMMU_NO_PASID, cdptr,
> > -					&target_cd);
> > +		arm_smmu_replace_cd_entry(master, IOMMU_NO_PASID, cdptr,
> > +					  &target_cd);
> 
> No, we cannot blindly do this for arbitrary ->attach_dev calls - the
> majority of S1->S1 transitions are going to be moving back and forth between
> the default domain and user domains, where there is zero expectation, let
> alone guarantee, that the translations would be equivalent and thus not
> liable to lead to TLB conflict aborts or amalgamation hell.

Heh, yeah this probably only works properly with BBML2 or something so
the temporary ASID doesn't explode.

Jason
