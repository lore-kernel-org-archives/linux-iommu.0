Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30753C10A4
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371357; cv=none; b=fLUEgEEdXs4ctCGWE76XAuF+eiXdycw6kiFBJ1s3KPWcBvDsDQbvVccvAmGBg/5+muDAgDPkynFS2dfPH1qO94miDp6+Pzj40B/SwPwUrTvnAN3KaFnFvEOE4Atwqn9W1anVFuK7c2tdTlo1wRIBNvmR/5UP+YvYh0YZ23bd/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371357; c=relaxed/simple;
	bh=4cWe+wDIIr2tLAOrRNj/+BJL3C/MFMywAN03TjAoAAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyeogzpmxkFnOF4SfIaFhJr6h8P226crqiR3DkgT66aCOJaJ+E+YFfQukZrYiLrctta4Pib6sidVjC0ynoTUFhzeUbsd3vxi/RGov2UdpBDeHUBaKXPjZRVONMrq8VQOhtk44RKD7f+qsx4vphrr2nKbgsRtT64CzSIN1jeAizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jf31r8Uy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jf31r8Uy"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so15854496d6.1
        for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786371354; x=1786976154; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=idlTE0WqykxV7+rArRYymwOTK1srgqcOSOKZC0b2F24=;
        b=jf31r8UytuMtTHqriYKXmeOBnu7m0e7KqH43NHuM6fblJOcUP5uqSvSYLFAV0WU5lC
         /kfmovaI/TpYtdfnR8nUoDadrPa7jOdKAeqZTT5XM/DH+OrrKpwe4OKNjyjvqXtODibf
         LA0v4umaOuaRgzP2BuyFGHBh3HeujG3RzbUtbjn9q3DpQ416wKJC7RAIAVQOWOReY2fR
         XQbFaYQzS3RDMgDtCHO+XkLGmcQm112cXrieb+dpfxs+JiM+VzEIFOgx3glTxCQkhU1f
         PTGVZUaYyn57uGsv4yHRYDYacrVl7Uz5PB1e/ZTVsUYagK/1wPFmFFmiAxYR82dytWtG
         57Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371354; x=1786976154;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=idlTE0WqykxV7+rArRYymwOTK1srgqcOSOKZC0b2F24=;
        b=qVRXnVgv6s/DcjoB2Y+VYadrNYWVdsTl2c0WlxIxAWIo5uK+IybV6VydIigQ8F8nBj
         m84IYJFgsigArpH+Ug7GSRGRxu7SkbwUeIqWWmS9blNr+OGV0pBQjpaGCGG48rH1lX5R
         z1n0Lil5A1uxekOoQq9YjWsOG0hsYP4Zndba/KoOIFEs3yAPZqeUQjmWz3Z7l5gGXQlD
         ddc5UOm68ZPEDWuuRFPuUE3wrxTAK60KPrNE6611kov9IZebVgmNXUQFgqpI6KfB/dvU
         NP1ats5G5k9CE/BWR2nTqxpoK3lVcRWWErOtMbzdkMVRR3BveaEhu6OQef5loupksutQ
         IWRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmDUA/ItzzMpY7N+RdY7rsZHTbd4nZL5/kc1BnmsMskYxJJnkI0cjxRihbYx1/9fNVAhEG9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGUBJTCgcMVuF9jSQaAeDrMljteEPQpqGFetx83k7ExByUAjJG
	fckTdExjz8DENYFGGXYKNPWmAHJzd/lioeFxNSZVyORCD8NHCPRKB+BaQMN1bKTN6oA=
X-Gm-Gg: AR+sD13BbZMakT+LxlhL6GU2XeVbvhK9SWlEntQ4aanmVtciLIN7xegTjvJj2VjhnL9
	5yQ9PhNOJ3Tf5XgTGiX1z1b77TCcudrnTMkfmQLu3XzyXE7OQOB6CH+hmZ5Zzq7PiUUYzDN79/J
	t7fWlUQ4G92yBUJ/K1B4n55rQ7fPxw9rJD62g9LV/+sirQKe+v5s5NQM7o8ENLCiZGpCm8cQQyI
	SA27DIT0p1qRy7W9e/wHA4P2cvpAIsRzisrOLIYZ/9Jpnk5Xwv1Ph/kx7FfyyEa3ZS16+0Xd8/9
	hlVbhrmAS3kV52sO+i3OH5FhV0aCWpbw1WxfvYXUFsx7XkSY31cFMzpNzaDPBMCEstykz/4rDlx
	vx96IK3JXVS+foZNAnbF+Rn509U5MrpUeaUuU8Vy4tbH7mKahRr/1PKCItc5XQGK7ca6kRSVIM9
	GPLA8Bf7A7+M2c2uT6eQSY9Fli3SPvd40U+WWybA==
X-Received: by 2002:a05:6214:21a8:b0:8f1:1081:a950 with SMTP id 6a1803df08f44-90a346a77b5mr228055386d6.22.1786371354367;
        Mon, 10 Aug 2026 07:15:54 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908a92ff8c6sm72821986d6.28.2026.08.10.07.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:15:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtQnB-000000023Ze-0BaD;
	Mon, 10 Aug 2026 11:15:53 -0300
Date: Mon, 10 Aug 2026 11:15:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pranjal Shrivastava <praan@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Mostafa Saleh <smostafa@google.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@android.com, tudor.ambarus@linaro.org,
	andre.draszik@linaro.org, willmcvicker@google.com,
	jyescas@google.com
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
Message-ID: <20260810141553.GP200537@ziepe.ca>
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
 <amOpSPmc36+YXgCQ@nvidia.com>
 <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>

On Fri, Aug 07, 2026 at 03:37:37PM +0100, Peter Griffin wrote:

> > > @@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
> > >       if (cfg & BIT(1)) {
> > >               used_bits[1] |=
> > >                       cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
> > > -                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
> > > +                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
> > > +                                 STRTAB_STE_1_INSTCFG);
> > >               used_bits[2] |=
> > >                       cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
> > >                                   STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
> >
> > This adds for "stage-1" and "stage-2", while missing "bypass"?
> 
> I need to follow up again on this point, but I don't believe currently
> we require the override for Laguna when it's in bypass.

Oh? Why not?

Is the issue the IOPTEs are set to no-exec or something like that?

Jason
