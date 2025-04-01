Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312D3234
	for <iommu@lists.linux.dev>; Tue,  1 Apr 2025 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743541326; cv=none; b=YNAwFdENNaeW3+XV33I6iR2I/BpgWoZguWbrLTfuVyamAWbUbwD5f2Vm6DvwBBRxAVPlYW/OtnNGYiHr1lhbPuq4tbALdVk+NSzVivyHWrxOFqDur3O1AvZjGvmpM1OLanqoScMauLKGD98mCoEGCTWv0iuSC3N9BRBHQek3Lxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743541326; c=relaxed/simple;
	bh=QpMJiwUoBFdoSP7DPzpzrR/BgmlNDb/On0b7vW+Ks+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhaoVGlMDS+b/XHjQjGG0zKes7Pe3HcQeqEY8hFuqihlHwbiKaZh3t58AeR4/efLMilHTZprgW9RM/EjMtw/Edd9OpTPqxGVCY6rykENDtzq0qsjwVWEDoYwM/bASeNJQfG0RwvrZ3FTw2kUERsGeGq2UUi/MrtP8HK4Pu6yLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+vuBJ41; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+vuBJ41"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so1285111f8f.1
        for <iommu@lists.linux.dev>; Tue, 01 Apr 2025 14:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743541323; x=1744146123; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjmWrNFJq5FsQ91RyEXZTPg7iV8Tf7Wr4X3A+p/WTNI=;
        b=l+vuBJ41nksQLBVatIMlCSbfoopudXtqsyKflKVQCZeOxGhL7Lh6KNy0bI9iQjQLD6
         xUu5ofZLFKmN/ed2Xe0WkSbKt/5ymttDr33lFF7PVZ3Ig+QIPBRBdi+GKEEIeygHXtpQ
         tTgrsmk/RrBo6jrc3SaAIwqrzz/H6n5QxSWoHb0pOQRDcAxUaG5W+qCjjW2JrCD8peut
         ANO1Le7D3LZ3DTQpA/2neIx9zCWOH3LteRNaqNqMdIuYiUGoFPcpuYLBL4Hobah0tnXA
         ytAuXc2koV70hdfPK+l4SrSRtd/aVpNuY0jMyc1hrhWO1vkPQ6S2wSPEvjN+Do535REU
         mTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743541323; x=1744146123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjmWrNFJq5FsQ91RyEXZTPg7iV8Tf7Wr4X3A+p/WTNI=;
        b=Hy8mKXPL/0SvDXbo9DQlvqD5IE9nXgJhMu6PkK97SNdcyIWdRXruBh2HbixrCNjBC4
         pb9UfloR0Dpn9eh+M0VSUZ2sFqVTNHz0cg3wbWWYMppIl+Pdl+Ait2KCvqs23FeSTo2h
         hqqevdu3R38TBU7Meu9ez49VWcajRixrkWX5nB5EAkkR9SPPT3HQoz3Dv2gJ8svzGQiO
         X4UzHfLvQlzbcaJj5MvjX6xC7txOjg6ZfLY/2fflUTqKqXtIkNwHj4FTxsmkPsmshdx1
         E1RnMr0QpAoMo2Zb1puxL9YtqJHgReHIAV7p+BXBc3Cbo/eIPS1FkF2bT5fbQg3aocgg
         wV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWYhnJ/M6+MZTeO1/SiiPGhWSkyfRJpzU8jGS7xb2aC2dpmKzAtXSNpv4DHX9O26T6Ju643Rg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6UzWHJQEbTnd/XWrBPjxjkICR8uXNe2n3ir0lhZTrdyTo2TW0
	fySyCaVL/o5jmIzV6CVZVlh50VTjRgDKOXimmjseYLtmmHXPkoeg
X-Gm-Gg: ASbGncubso8QKU4A1YU+DxdOA+Cyx/H98mmghOHWF8Ch9gS21RHv8Hn3VyC5KQSK/3D
	uDexa8p0Mxsd7WYC1mrhCq4ZYLUc7rasXN11eSq/Ha3EDZJToIN1U4L1g6j/1VkEkxJZuUXY5lU
	H3mOQvBxV+6Sp1w7R1VW4z2SPAkQ9hRGuthevjQCQ12EDcQBY3oAK1yZgmmb+DweO1oLVcEv/eS
	G87Gn1qLmEXA1zG4LYUUy7c+UajFYb49Kql1IZmMGowIM2rIN7eJWrm9OnXY7BaHEXCbMbV/jAM
	9Nk8q6muoBcVCuEsy0+xXcJz1ogHxRy0kRdfMmo16xQLjgtmYgog1rkCMg4PU8u4mnDvD6gyvoz
	A2AJd2PU=
X-Google-Smtp-Source: AGHT+IH9YPMWiON4QM+xaQnB5yqCP10tZKboZ8LNviXyPWzJfgh/M6Q58FlmTI0dL5JuYBp5qZxPFg==
X-Received: by 2002:a05:6000:4023:b0:39c:119f:27c4 with SMTP id ffacd0b85a97d-39c29767c83mr14733f8f.30.1743541323342;
        Tue, 01 Apr 2025 14:02:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c1845e66esm9181665f8f.18.2025.04.01.14.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 14:02:02 -0700 (PDT)
Date: Tue, 1 Apr 2025 22:02:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Xu Lu <luxu.kernel@bytedance.com>, Jessica Clarke <jrtc27@jrtc27.com>,
 tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, alex@ghiti.fr, lihangjing@bytedance.com,
 xieyongji@bytedance.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [External] Re: [PATCH] iommu: riscv: Split 8-byte accesses on
 32 bit I/O bus platform
Message-ID: <20250401220201.1fa3ec76@pumpkin>
In-Reply-To: <20250401154412.GI186258@ziepe.ca>
References: <20250325144252.27403-1-luxu.kernel@bytedance.com>
	<9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
	<CAPYmKFtAWNz7nCDDD7rjGeV2fRBgy5Kt6KR60pEyXAM=bb7r4g@mail.gmail.com>
	<20250401154412.GI186258@ziepe.ca>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 12:44:12 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Wed, Mar 26, 2025 at 11:26:07AM +0800, Xu Lu wrote:
> > Hi Jessica,
> >   
> > > Is such a platform conformant to the specification?  
> > 
> > We have talked about this before [1]. I think the IOMMU spec does not
> > mandate the implementation of 8-byte access functionality. The related
> > sentences are listed below:
> > 
> > "The 8-byte IOMMU registers are defined in such a way that software
> > can perform two individual 4-byte accesses, or hardware can perform
> > two independent 4-byte transactions resulting from an 8-byte access,
> > to the high and low halves of the register, in that order, as long as
> > the register semantics, with regard to side-effects, are respected
> > between the two software accesses, or two hardware transactions,
> > respectively."  
> 
> I think the commit message should explain an anyalsis that the code is
> safe against the mentioned side effects due to ordering.
> 
> And a comment should explain this:
> 
> +#define riscv_iommu_writeq(iommu, addr, val) \
> +       ((addr == RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> +        lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> +        hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
> 
> As the naive reading of the above spec paragraph doesn't seem like
> there are exceptions or why one register has to be the opposite order.
> 
> Also missing () around addr

It is also double-evaluating (addr).

I hope there is a lock, interleaved accesses from multiple cpu
may not work.

	David

> 
> Jason
> 

