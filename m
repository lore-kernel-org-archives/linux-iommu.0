Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F15199FC9
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289815; cv=none; b=tYJVhssfu2q/NZdRv77VEXq6K7PgRPJDNzh9tAB/eRXLo5o+MJgVz8y9fGT5AcN4ZrGZSZYUdiiydTH+/5etZb0oyChk3fG9ZvbNzTfjyx9/sB4xJsGPsT2Rrv4uSksB2xHD6qOK5d/pgL2Ap9HmRAvQ9OKHns8vO3YeFA4zyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289815; c=relaxed/simple;
	bh=DV7wpbry1jkw+VWJERzJa6U1rgHn8ivUK6AEfkD8XWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQAQiXR+eFhnXoPpC5ltqJEChdh9H7TciT3lvTzxps1XOwpzrAIk1tc760LilQCdEe/V1l/a8hKG5PRxa5AO1MLwGJLq7TqCzfdNWmhxjZG9yUn52nxdBDKt0+CKVZ+V4sFze5B73rHXBFcCgBTFc2CpBiSAxUzIVLcHdh3s5kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgeLdPzP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgeLdPzP"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30227ccf803so179613381fa.2
        for <iommu@lists.linux.dev>; Tue, 07 Jan 2025 14:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736289812; x=1736894612; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pa3RqmxudYJyFQPRnw18vNuYTg6IZacGgInKXmkuvPY=;
        b=bgeLdPzPsCjR2x/IrHdBZacEvpWSsyN+fODyqfdA73MAbplpaXJj9xYG3fsMvweS88
         YR0F1L50cuIIVOd4E8EyOiqu24Dsm5TUuOPJIfpcBMV4/U/votMVqk2qdhqEq/AiaI/l
         dxvtXk9Bovwkm4UE5RxH7ZJsCu7D1JaTIEpcDz72v7BLN94meUI7nClucU3t096BTdgl
         nLFibjzV6THktgyXyUGHmXB4CiZoCPIIKNZr0VG3f/mnialp/jYp3oEu6faG2xGsbSAg
         kPUtWx8MFqyhtKyH5D7pCupMwvyXwEnfMEu6ccxeZwxcaPhvkv6TQDULAg3odKQFTEN4
         l4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736289812; x=1736894612;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pa3RqmxudYJyFQPRnw18vNuYTg6IZacGgInKXmkuvPY=;
        b=hqGMyHYQ0EqlL+t/9woFZv5HuvjatAFSInjhzQmVnH7pegoSR6IRn98n0TaYzqvvKl
         gpHEhlOh2escXlcW+9+JggHID6R1qeLeA/1P/XoAaNZ8AI4Xc8WtNAx1U1jjPaUvgn5y
         4cTDPGmsxyd7XkV8+qZ1SULyJH4jsHNFhrfFGbgcA9bARszIYI0ZWBsqsxwc0ye4XX77
         0n1q6cAV+I9Vm2QRQXL2AkJqwrXl/pv42Qkqvpogok6kqfNWFYZAM43tOf2inh41liUF
         U+xMsnnZ9Eb1Nm1h7C3meXVcyZZ5OYR6aCPu8868/pAaGhnjOz8krSh2CVITN495JneZ
         l01A==
X-Forwarded-Encrypted: i=1; AJvYcCWpbpmul4w37RoG/lbAfVB8Ie3T78KZ9THW2sXkFBQ4MhhRXY8L2rr5EFL8R9s+PIi79zlQ8w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywh9y7y9XvrNwQEPQaVa4nox3BI0faE4WHeCrXhV7ic75GS4Cyg
	4xJk6M7TfJLd9G2cboZDuf7vCV7zO8AVH9ZH80rOglfDakJD9q39Tkueag+LZJc=
X-Gm-Gg: ASbGnctdPmaRaBQ8KBEGArIa8DFiSz6+hKLYHBCgJRh1H110ULAPvOTXEfNhxKWyt9l
	CeOXaYQhhdq6f9Cn3PtiV+1PV1fvYn9bh5w8cG9YaU17s0/QvT5qXt3TkCYjhaibsVozKTRpy2D
	PDLDcrWFjDjUcvH00SRxhd4Nn6NAE5KocHslKtClYzn2P86ar/KoJBlvLzcrS7erFV0IYhoDhud
	15bneNz05xmGIIO6g/ORnd1dTaNp+ua/9yx4Qv/nk1YxB5g1W0g4HyqrJJXr6/balhwzYOo+x0t
	gYrmpDpfdiQlole7aGz1M6BToewm+mkf80wz
X-Google-Smtp-Source: AGHT+IHy5V27gDH+by9fnJ68iOhPGvEIJqeaut59nvgCwr8FXp2+T/5yYWYjCX3jT2mFaBHiG+I4UA==
X-Received: by 2002:a2e:bea8:0:b0:302:1b18:2c09 with SMTP id 38308e7fff4ca-305f45ba080mr1149561fa.27.1736289812296;
        Tue, 07 Jan 2025 14:43:32 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad9b9c4sm61091001fa.31.2025.01.07.14.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 14:43:31 -0800 (PST)
Date: Wed, 8 Jan 2025 00:43:29 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	Robin Murphy <robin.murphy@arm.com>, Rob Clark <robdclark@chromium.org>, 
	Joerg Roedel <joro@8bytes.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/arm-smmu-qcom: Only enable stall on smmu-v2
Message-ID: <fipxf3vf3nrbiqgwtu7z4vqcyt52dludehdvqc2cnfbal6poyv@uj4hxrlhnqeg>
References: <20250102183232.115279-1-robdclark@gmail.com>
 <20250107125738.GA6991@willie-the-truck>
 <CAF6AEGtZSOMi-=AOmjoXSVkwfyvKOymSuRRMZ7jOcM2wyhu5qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGtZSOMi-=AOmjoXSVkwfyvKOymSuRRMZ7jOcM2wyhu5qg@mail.gmail.com>

On Tue, Jan 07, 2025 at 07:26:44AM -0800, Rob Clark wrote:
> On Tue, Jan 7, 2025 at 4:57 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, Jan 02, 2025 at 10:32:31AM -0800, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > >
> > > On mmu-500, stall-on-fault seems to stall all context banks, causing the
> > > GMU to misbehave.  So limit this feature to smmu-v2 for now.
> > >
> > > This fixes an issue with an older mesa bug taking outo the system
> > > because of GMU going off into the weeds.
> > >
> > > What we _think_ is happening is that, if the GPU generates 1000's of
> > > faults at ~once (which is something that GPUs can be good at), it can
> > > result in a sufficient number of stalled translations preventing other
> > > transactions from entering the same TBU.
> >
> > MMU-500 is an implementation of the SMMUv2 architecture, so this feels
> > upside-down to me. That is, it should always be valid to probe with
> > the less specific "SMMUv2" compatible string (modulo hardware errata)
> > and be limited to the architectural behaviour.
> 
> I should have been more specific and referred to qcom,smmu-v2
> 
> > So what is about MMU-500 that means stalling doesn't work when compared
> > to any other SMMUv2 implementation?
> 
> Well, I have a limited # of data points, in the sense that there
> aren't too many a6xx devices prior to the switch to qcom,smmu-500..
> but I have access to crash metrics for a lot of sc7180 devices
> (qcom,smmu-v2), and I've been unable to find any signs of this sort of
> stall related issue.
> 
> So maybe I can't 100% say this is qcom,smmu-500 vs qcom,smmu-v2, vs
> some other change in later gens that used qcom,smmu-500 or some other
> factor, I'm not sure what other conclusion to draw.

Might it be that v2 was an actual hw, but mmu-500 is somehow
virtualized? And as such by these stalls we might be observing some kind
of FW bug in hyp?

> 
> BR,
> -R

-- 
With best wishes
Dmitry
