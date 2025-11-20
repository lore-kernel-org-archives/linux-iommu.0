Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620812737E7
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667212; cv=none; b=Sjcwt0g1EXBL7dFELmQOPbRgWBonr9GFyidiQakFYh3OOSVdU5FXuY8SigGOn5uIoxgaWQT/Lp/CVk8O6nOi6kHVURkTANh1T7O3c2BHfbUHYhzvSx+3tFwhe0eJT27IFFNk3Rvs8+TR9XvijACNqUIBA7mDg1IzYnpSK5U4CGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667212; c=relaxed/simple;
	bh=hzYdS2RbjjdpNPkRll9+qBCneRKVB6myqbcq8DhMp4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGP/kD5E5CZoM6KyHjg+eokdvHMdKnYQnXY6TXZBK0HBewWjO65p2r0EORfcBL+UFtKUYOay0hSj4uSdCdUY+eF+8/r/cViwKRfaLXs4/Wkl0fF0Som4mzstubmaE4OI09RpqRq2tHfxxZ8vytnsdrs1E2W+e7W4zTw8c8KMw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O5qQ0zAW; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O5qQ0zAW"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2dcdde698so172509185a.3
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763667208; x=1764272008; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJbOTvKtBkMETxUQbFFc6nVU6t/7S/ESP6xTtKSK0tM=;
        b=O5qQ0zAWx/DXdijJGBW1QevV98D+BeM7onXJp5lWe9d6Ba1HEQwTaAnlVQDwCVAifA
         pT2EkoliGlPdTuTpFBBIVPZXjm4RIK2KgJ1FWtMZUpJvWayqr5TqE6dw4RkthkOCKCeV
         xPlRaNz5A8IJzn4gqOS4lkg43WlcN4KwIsVbOaAjb/HBfBKpE+4s1e1vvlV5pnd+7Mdo
         LRPO8VndxPfM2GNbpEN/WJS+FMLFlGsOlmRjKDiCiZXZrajCePK0jIgeuB9QS+gOKVov
         Zam4/Ispq34tv016iyCsCOokUtxGvXzumwHsiVXkF3zTxwaD6NhRngAeBhslsNFScluP
         WFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667208; x=1764272008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJbOTvKtBkMETxUQbFFc6nVU6t/7S/ESP6xTtKSK0tM=;
        b=wxNpbeoe4nVlp0cdiCRQs43RR6soHES0U9ppNbLdVyoSbTrpERZsMnWMiJWR102BpB
         pZUFta5uNWuhGDCwesyCP8sJEpMO2R1Wd+JBozHa57k4JN5rTFVWnjPslH3pI+RMw72P
         XKyks6jS/8tQsFi0O5LTf3WlY6DFi4hdZh48B9ksyE2QL/HL5AmMIg4/zDknsx1OHlHc
         jCn3a18Q4nroRZfEjKmhiCRHiLtfljsUn3ujWdWjmB3G9dv1o4jsIdKz7W8ArpHfEBxb
         bY545oqwuq0U9VenJPY4d54qwZ83MG6XJ6kcS89imlWVaywQcyc3b309ZCWyUjGUL3WR
         TKNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVyhMBVBx5jp6gPlhCMtLNLvO1o146sFbEdS1hhGEmRPvkxVKBdCh02MCv+jv/APAWHtT3mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxz7JfzowstK0vDanKMHx3PDPM/KrwsOPd6ePOAe9inVFwxFebP
	UPP/dwqPbTWb5goomHank3wjxB8dM6dyLa6zHfLpIJPt2J4quP4aCFiDxfNjij/stYw=
X-Gm-Gg: ASbGncssp+GhEU+emKvAvXT7fraJm+I9nNuzu4zuszeNhkmC7QsNahhw5mLuc8Soeal
	QCLPT1KWCcKVCxYWsthPTyO3+MtywDV1ZaBddKlsYCXHxPCK2vF88zr7PkoLg0Gp8AYxzHYC5ez
	DHE5XssyxAJJGxRCRMovmEm3g+t4TkM6qH84aHZy+A2zZxvm6By/dAKMg43CBh8aD5gHgbppJIO
	QXmAmK3GrAMRF6QTE7r/x1NJqTcpL8yyhR5Nf5R73CFNV5HnitAwV4reKGAVDeYQj2p5c2J/xPo
	XnSCUn4QtCbZweHgIdtM7yQ6fnSgt+fDvIeIV+49lVurSwEHBKKjUvDypoTCCWPXpOLkBWlCZxD
	CSDcH5b54q2eSmlUANLc1b7Kc21H3kL2xpru7DYukvpD/OKQ4GDFDl88ph0vSS1wjKTi1ZycoQC
	yBoXEqIlrMLEG7QiwbfJ11k8qqYxrKLCdJdA+isU7kHqenf4oVM7QORp85
X-Google-Smtp-Source: AGHT+IGpaR+w3wp4votZhuUNdazIQPQ2JUOa4gTel/dGSMeoCPvMZg4kNVugdag6pW8h3TthvdJcbg==
X-Received: by 2002:a05:620a:7103:b0:8a2:45ba:1b5e with SMTP id af79cd13be357-8b33860b8eamr108942585a.28.1763667208042;
        Thu, 20 Nov 2025 11:33:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3294321dcsm208458485a.13.2025.11.20.11.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:33:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMAPG-000000015S2-37Ge;
	Thu, 20 Nov 2025 15:33:26 -0400
Date: Thu, 20 Nov 2025 15:33:26 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	KUnit Development <kunit-dev@googlegroups.com>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] genpt: Make GENERIC_PT invisible
Message-ID: <20251120193326.GB233636@ziepe.ca>
References: <48381c47930d98380871458ca471ea5a7a89aafc.1762956447.git.geert+renesas@glider.be>
 <20251120164933.GV17968@ziepe.ca>
 <20251120170744.GA236839@ziepe.ca>
 <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVsyu_vnYiV7EcChd3a6czUCh4Gis3hL8uDVmbDcGo06w@mail.gmail.com>

On Thu, Nov 20, 2025 at 07:31:10PM +0100, Geert Uytterhoeven wrote:
> Hi Jason,
> 
> CC kunit
> 
> On Thu, 20 Nov 2025 at 18:07, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Thu, Nov 20, 2025 at 12:49:33PM -0400, Jason Gunthorpe wrote:
> > > On Wed, Nov 12, 2025 at 03:08:05PM +0100, Geert Uytterhoeven wrote:
> > > > There is no point in asking the user about the Generic Radix Page
> > > > Table API:
> > > >   - All IOMMU drivers that use this API already select GENERIC_PT when
> > > >     needed,
> > > >   - Most users probably do not know what to answer anyway.
> > > >
> > > > Fixes: 7c5b184db7145fd4 ("genpt: Generic Page Table base API")
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > >  drivers/iommu/generic_pt/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > Actually, it doesn't work :\
> >
> > $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --arch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig
> > [13:01:26] Configuring KUnit Kernel ...
> > [13:01:26] Building KUnit Kernel ...
> > Populating config with:
> > $ make ARCH=x86_64 O=build_kunit_x86_64 olddefconfig
> > Building with:
> > $ make all compile_commands.json scripts_gdb ARCH=x86_64 O=build_kunit_x86_64 --jobs=20
> > ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> > This is probably due to unsatisfied dependencies.
> > Missing: CONFIG_IOMMUFD_TEST=y, CONFIG_DEBUG_GENERIC_PT=y, CONFIG_IOMMU_PT_VTDSS=y, CONFIG_IOMMU_PT=y, CONFIG_IOMMU_PT_AMDV1=y, CONFIG_IOMMU_PT_X86_64=y, CONFIG_GENERIC_PT=y, CONFIG_IOMMU_PT_KUNIT_TEST=y
> >
> > Can you add this hunk and send a v2?
> >
> > --- a/drivers/iommu/generic_pt/.kunitconfig
> > +++ b/drivers/iommu/generic_pt/.kunitconfig
> > @@ -1,4 +1,5 @@
> >  CONFIG_KUNIT=y
> > +CONFIG_COMPILE_TEST=y
> >  CONFIG_GENERIC_PT=y
> >  CONFIG_DEBUG_GENERIC_PT=y
> >  CONFIG_IOMMU_PT=y
> 
> Do you really want to enable CONFIG_COMPILE_TEST in a .kunitconfig?

IDK, why not?

> Hm, that .kunitconfig already enables IOMMUFD_TEST, which is
> documented to be dangerous (why?)

It builds in a kernel module with a uapi that is kind of unsafe.

Though, hmm, maybe that is some weird a leftover I don't recall that
this kunit needed IOMMUFD_TEST stanza at all..

>  and already enabled by allyesconfig (except on GENERIC_ATOMIC64
> architectures).  

I guess allyesconfig would do that.

> IOMMUFD_TEST cannot select GENERIC_PT, as that would lead to a
> recursive dependency (and I am not a huge fan of test code
> auto-enabling extra attack surfaces^W^W functionality).

Yes

> Or perhaps:
> 
> -       bool "Generic Radix Page Table"
> +       bool "Generic Radix Page Table" if COMPILE_TEST || KUNIT
> 
> ?

It would work, that does seem like a better choice if someone wants to
make the kunit run in a normal disto kernel.

Thanks,
Jason
