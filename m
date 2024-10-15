Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC451EB9F1
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008660; cv=none; b=mDq396mcgrJ2/TofjrxuNpZiEeQMJZKdG3LJ1WmNqTETXgtsbfzIibZ2mVRWEhVQHF/vQ2YBW9VOksUMox9/INL3smk9+Ct5q4GmO4OBg4HyaoBFjwlJGjdx1Qmh303iEGGujgWZxIjyozmuFgYUHpUN/gzU+AbJ0h3MaSEvXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008660; c=relaxed/simple;
	bh=GA7Fc81A7ztI7UbjRC/32RuEiP8RKKb4G220B9ue1HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qwt+rLUjvOgWJ+OPj3/2ZQjAel/T+ujfvrrRB/nUhuSz2OyztYlN56PvYdDc7Nwq/TXTngUOOBtK1yOZUrdKouTTjgZcabuLjoIl7YabQS09543YrMjl6ruBj+X/DdBozsdnJcN92IbXUUvOLk6Jz1mQ+l2zQVkYhmrDnPPbHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evVerFGD; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evVerFGD"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca03687fdso553915ad.0
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729008658; x=1729613458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGYhfp2OqW3Qzmg96OVHEI/GKpsDJXQmbA11pdTZQhk=;
        b=evVerFGDDiT3NHCDG1FpelVIDcksxNpidf7pYB/8W2eQzfhYa/6q/eoDZf3xqcqyEi
         jsloNg/44KSov621dgpAe0kghdvdJHVa0xM8ISNIGkBoNjGAj9CC/o0ot8VXUI4yEVRa
         pvvszthkxZeLfku1AGAadfihJ8a9RdH00J5xn7rpEKQGUPDUFw84mZIG9ULe0Bva4Lk5
         OvBNsN9uMHHnfZTrunn+BGAiadIYtoKQE+YNd1aLC1ZjZKJ2MSv2Wd1ZFz+lRdViKXcA
         ERAx1Tbokvk4lY7PTuLJIj02C0XS2+6v2fFOMIQFR8MBnCrHyirme41j2MorjmEW+yDS
         MXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008658; x=1729613458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGYhfp2OqW3Qzmg96OVHEI/GKpsDJXQmbA11pdTZQhk=;
        b=mN2HFthzeT8EOgu4FYiMqdRqbzuCeAUL6ldwZ1AIKBhwRuIn5euGSnoTUPZdcUEMaL
         6yOgGDR6RSAgpx2KKnXU8qMqH5OoVcm7Iau+uzWNms/YmE1GBTPjbvFVi9WIVHPjymR9
         jiNrehkWldIrhqc/HzzMZgw7CiY1nQzfxMJWqHyOY2Vkn0Ee9G2Acydbu2MCXynf3QmS
         aL8OA31NhN/qwy9Xhdte98M9WAf7EllHaQvW4jF2abHHgYB166Bp7vhg0TbhplpVpCNN
         cxh5/fFf+wVslLti7euPQ/LmfLewuYjA0OawmapxKl4dFu8p5Y8K/vn3S3rljLzz6CZ6
         ZXFA==
X-Forwarded-Encrypted: i=1; AJvYcCVBJJoVicEufUrdlhN4jtpWFpoet+l2HBnQ48OhR303mXdWnrDtMy5r2K9CWzfDPWebPgaa2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxISV14UVa+cLwWT9hT5NvjzVZBGL2Yqju4Ci+CSI6wmdqcvmU8
	UDVAYn9pMGGH70cxTDRlmTnMCqKgmIvb/2zilvW5NUB/LS0JFUIWMMqvrKuOXg==
X-Google-Smtp-Source: AGHT+IHSgi8+1o+3iy2Nr5pCUXFLnZB8SwGxpqHUBhSE2VfhssmbiQ27u4lhyDBdI5kO8qO8nZD2aQ==
X-Received: by 2002:a17:903:22c6:b0:207:14ca:f0c1 with SMTP id d9443c01a7336-20cbce670dfmr7329985ad.16.1729008657827;
        Tue, 15 Oct 2024 09:10:57 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392e8ec9esm2017723a91.7.2024.10.15.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:10:57 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:10:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw6UCLprZj6aaajY@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
 <20241015153110.GM1825128@ziepe.ca>
 <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce7cc76f-426f-4d19-b4be-3964647a2f2d@arm.com>

On Tue, Oct 15, 2024 at 04:37:25PM +0100, Robin Murphy wrote:
> On 2024-10-15 4:31 pm, Jason Gunthorpe wrote:
> > On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
> > > On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> > > > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> > > > 
> > > > > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > > > > avoid meddling with the STEs directly for acheiving bypass. Playing
> > > > > with the iommu domain type could be neater. Perhaps, modify the
> > > > > ops->def_domain_type to return an appropriate domain?
> > > > 
> > > > Yeah, that is the expected way, to force the def_domain_type to
> > > > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> > > 
> > > There is no domain, this is bypassing an arbitrary StreamID not associated
> > > with any device.
> > 
> > If the stream ID is going to flow traffic shouldn't it have a DT node
> > for it? Something must be driving the DMA on this SID, and the kernel
> > does need to know what that is in some way, even for basic security
> > things like making sure VFIO doesn't get a hold of it :\
> 
> Exactly, hence this RFC is definitely not the right approach.

Agreed. I assumed the bypass was needed for a registered SID.

> 
> Thanks,
> Robin.

Thanks,
Pranjal
