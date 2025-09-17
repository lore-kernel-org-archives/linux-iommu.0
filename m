Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45732877D8
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 21:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145708; cv=none; b=FPAQvUnJxoEZQN5EdSuhXPf6mjfD3rgXB3HVKj6rLfTOU21bzqGxw4TvUV1AvNW0c2NnaqAwgF/GilEJw5vUUJ48incnp+ack+Ls/TDQCtb9o13aOTUFx2xj4L0qwXU8FITZIZh7mtT3d2vWhajYCfdPrEnLWvY8/HXalJeanAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145708; c=relaxed/simple;
	bh=tvO4JycTDd5hLOR4zxWrgeg1TmYixYOGyaOl4qqzl7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WROvwQDwR/IAHp37YMBzdJT8oDhLueUMppV8JVuOVVYni9JWvznXD2kDvn/hs/sRK9Bh0icJUbLyNqPT9T65mqk8oS89CYu1GNUZ0VG8i+S2zuuihdMZ4p+r0PeNJzlbXq2ZD2YlLWH1nqx8LHJhzPb5gYlozWCjDK26QJt3t4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lTpFT7fq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lTpFT7fq"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-78f30dac856so3470586d6.2
        for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 14:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758145705; x=1758750505; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M5pjsrH0NuPhJAa2Q4JnWo3JaksS0ES3ehHxy8GX7zY=;
        b=lTpFT7fq8PwH3OYSUaPnHdKaz+BSQd65SIrFGi0Wt40JdiDDed5vf/BA/Y5hxG3Yte
         JqJB7X1o5bsQwSX1j7IpUy6RPEAiC4V9rMayqTdmrrcRZFdz2e/TbIsUoO7xSWA0DG60
         3BzRRzRLAJybJxTAR/YSraruXfMaJ5QCxBWRnXBBDUgb11P3XCtWo78rlD54sxJbota/
         e724gnscKYQ13Jtgl57LMnW7j4L/2ICt4Lz4lOYMP1C0eJhUD09e++XmxA18DQTM2x4/
         hE+h3yC3VUX7bZduoFlK0oJDMK+h42a3XQ4oZvDxmpbdo5+6gqYlUSEKdkRfABICSR7w
         IAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758145705; x=1758750505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M5pjsrH0NuPhJAa2Q4JnWo3JaksS0ES3ehHxy8GX7zY=;
        b=njwoyfdUss9wvaGJDD7WHbNzBFmsZrZmLPr6RM0i6dFYPgNtQCkJ7HsJKtUBc9HCQb
         RmRp1royXEia42tvclk8kp1nIjJDTibUAfDlxVmKJlc5pCfU5J/nJVzq/ZnhKsFevKGf
         jEJkJQmrwNFHBFc12EhjIMH1FyEru3wTnU1qpcl9e+WZ/zX/GDYGxEDIkUVgJdog/Glv
         T2RIWCWg0lZz5dCz5iLRDwVkPM4hXjbow2FnY5p0SzOlgLxPmGwmg/e8y6XkwvirtfN6
         O55ddIBG5dBIyIr5Vm93syBBiUoVK0hl+YeIj373mEEhcAsuAj6MULdQGAoLCDdlVg5U
         Wbdg==
X-Gm-Message-State: AOJu0YxpHNIXRPaIgUxD2B/z8McdpNInbAN0cgomranYoKQGScZALJSq
	gLvR3loSX8103ZOXhEzFCKUHZHL79AgSilpBF4IbQsmtuUBK33JP2ygz5COidGe7RpU=
X-Gm-Gg: ASbGncsKbX9ydGksRH3jnu/+KGgIwUSWY7QjeoCATTz4iEbYtcGbHXm0eL+gyPa01DI
	k+VDmfSAc6EolbpyctqEyAFTF5viEmhkzLU44WbS/lFacxL8fj0QGkcrsae9CprD9PONsj6X0ON
	t3IEdL6grvBei8k0IrS71Ajk38aAC81pkKjlAs/ZdWkc8J9OiQ+O2MdWR6oWWBwNuiPsqI2wtW7
	A9LaA3+NJBjLQ4DOKkNbsi2DSRMXY3NqzMgsCht0cUtgDRkMHaeu8NxS2H/yWvStc+AuyUC4552
	zEFrpIEbygOemc0RPtUHnXCfNA/PSxt821v6Pc6MqqPyXc2ArPVQ0XcXq4O3fZNJvoBW2/hzerJ
	AEaRzwNcnb6mTM86UsIzISQg1jUK3bZRcAdw4IWtX3OmFPC3lLcL6em3Vg75x9kICf9lj/6dJcU
	dCeqTpyXMvr1E=
X-Google-Smtp-Source: AGHT+IGqltdD4fDq4evbzVSSO987bVfhcgn3SKxWfDcujX+SUfkoa+t2KVNljJJgOxNmqIWdaHiAsA==
X-Received: by 2002:ad4:4ee4:0:b0:720:e4bd:d3e6 with SMTP id 6a1803df08f44-78ecca1699cmr47085396d6.15.1758145705595;
        Wed, 17 Sep 2025 14:48:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79346931b67sm2589176d6.22.2025.09.17.14.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 14:48:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uz00m-00000008ots-2fnK;
	Wed, 17 Sep 2025 18:48:24 -0300
Date: Wed, 17 Sep 2025 18:48:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, praan@google.com
Subject: Re: [PATCH v2 1/3] iommu/io-pgtable-arm: Move selftests to a
 separate file
Message-ID: <20250917214824.GN1326709@ziepe.ca>
References: <20250917191143.3847487-1-smostafa@google.com>
 <20250917191143.3847487-2-smostafa@google.com>
 <20250917193818.GK1326709@ziepe.ca>
 <aMsX_HafW3rLs5dQ@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMsX_HafW3rLs5dQ@google.com>

On Wed, Sep 17, 2025 at 08:20:12PM +0000, Mostafa Saleh wrote:
> On Wed, Sep 17, 2025 at 04:38:18PM -0300, Jason Gunthorpe wrote:
> > On Wed, Sep 17, 2025 at 07:11:38PM +0000, Mostafa Saleh wrote:
> > > +static void __init arm_lpae_dump_ops(struct io_pgtable_ops *ops)
> > > +{
> > > +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > > +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> > 
> > Can be:
> > 
> >        struct io_pgtable_cfg *cfg =
> >                &io_pgtable_ops_to_pgtable(pgtbl_ops)->cfg;
> 
> There are a bunch of other formatting issues here also, but I wanted to
> move the code as is, so with “--color-moved” you can see the exact
> difference, otherwise, it’s harder to review.
> 
> I can add a patch before to fix those + the printing as you suggested
> next.

Yeah, I brought it up because with the above you don't need
arm_lpae_io_pgtable

> I don’t have a strong opinion about this, but I am more inclined to
> keep the prints considering it’s a low-level test for the page table,
> and such parameters would be useful to understand the failures.

My general view has been that there is alot of debug prints I've added
to kunits to debug them but once they are debugged I tend to drop them
off as they may not be useful to debug the next issue.

> I know this is not relevant to this series, but the KVM driver will
> need to expose arm_lpae_io_pgtable anyway.

Really? That sounds like wrong layering, why does it need to break the
iopgtable abstraction? :(

Jason
