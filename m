Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE87349CD4
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589630; cv=none; b=MV9lZucWyK0wHJFrJ7OErsBFeAlriVOsFF9x7fZ8lLCSm5S+FDPmNnDRJtFHphB9irgpoB6JZHuxOwrMVmXZ3xmacMK/0sR/f5lvqLEA8hSkdjMYzXBox36rdDspW0cyFfnQekaWpfdQpLaEc+xvzIvR/q4YY3SEbSKLqEbNUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589630; c=relaxed/simple;
	bh=hkKtx+usdPUmf0nx42KiBOuHEN8nSPyFyyIr59g+ADc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv/W8pEmMiX/TQBlmN5j29aXzh5Bp3oYDABIsrYYDb00rghAO+s+wIGPmNVfmTM/KXFJJrY6pM9kOYCVFP1r6M/2qrwcwxwKz/gg3jAfuognAWwuk0dW+h0soE5jZ8XPierwmmKoKzqFpQnVAWUgN2aBI8nFKqespLU4h2P+7YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Kvx4b06L; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kvx4b06L"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90eb7a63a30so7354985a.2
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 05:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778589618; x=1779194418; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4lELg4tysIZjC4IAy9jg6iqJ6L2+JsLGKduxlfu78HE=;
        b=Kvx4b06L3zkgRhm3pzHezFXObKPO70avM4aDA6GssmDsui22fYigUOlzcIGW6gkkbW
         T45bl6zXp5TCAF8gthFgvnDS1gBfKOJd0bgWQlyoKUdO/yBnxfzdVKkQvzJzteakf7vN
         w5N7Jcmdj60LTi/+IDYkAgJ5F6DbZ0tjslxPvEoqhOHE2IAtPE5gSX3IwdsL7EfXpI9N
         pmmAv9kPdR0nGoC7qloGpfyJUNzMueQ7U9GfZxPwObvy21kZLjp8I7kgjjVKDoo/LMiQ
         qyjkQYbmmuIyQd1Lpsjs7LmLP39LxWb24c6EIBFvPRVw6qrdZdQKkz7CPLALZ0iKwsNT
         lnJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589618; x=1779194418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lELg4tysIZjC4IAy9jg6iqJ6L2+JsLGKduxlfu78HE=;
        b=mtXSd1VLmd+iZ74QJ7OKL55huUnLW2rnVF7dpXujx98PN8K2ARCnswMqGU/xXcbscn
         SijV+xEtYmXLO/zkL3vDvLxOHuGDeZq+SqpygBPOr51NO0LOjl5bCXkPjA2D+jZCKP5c
         W1g0woIjfSHN6NLnd4d9dJcOfgH1w0mnd39QklLMWlA+OWeaM280haNw2j4x8tb0YQze
         H4/Z+qeEIp4gNuJQiAg5xDr/Qg9CumTNB2wwW26ldyshrivKFwScW1X6CZNNArW0X66s
         ID2OK25ie7Mxlgt1OlE6LSodOKicZCSok2U9jclfWX4VyVFW1mckv8ZJ/Dsl4pyXX5Wx
         m2nw==
X-Forwarded-Encrypted: i=1; AFNElJ+4719NGXxNXa+wgZNGrR8pIt+NA9XbxXxfEqG3eFEumMHSLLbmvqDC8idIwRPUuNUOvdjf3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy4rzQCKVvG+cQkpWjIXolQnpX3S4J28W7vOOAPYsCiB/kgLJDW
	kbmsRW22lafFiuFO4MOcYeVV27x1K+14vCx1Kdl5Ow/oITxbIHiOYeMwvCNtjucrx6s=
X-Gm-Gg: Acq92OEvVVflF2YlZ9iRVIWRRMo2OZCPsRmKXY0FjOLjKp1p8OWSCrXeGQhj5U/9p5z
	dtAW3gOQWiLgQxUGXhwr0SafbdfGGLO34PWgoqh9P10kGH+sYQJdJ+dfsExxH/b503m8F8tdh3h
	hjhd7b2L4wC8Q1sbcPKmhENeZ/6ocL8XOz3bLv5WbexH2FB/j6TGzTl4bmTKSmidYmDBNBCq+d8
	QgUiQnDvJGlbEDMBfW2Ztc7w0IfGpBm8uai/R9sXW+b49TAPyJxT7VvryjHVZTdHCKQGPbvPQb9
	XkXw5bXqgR27dWZviGt1Pr7Lf1iHZHRTQFGcJVzyCiPBJYFuRQAfhlJJoAHf9CYPNM68bHDf8AW
	7GG5t8M0JRDZX8FIjUk7SdX6PBbIJ6QoboeVmufZDJpP2nE5m0BTymPphP44tNhzaKlnsvJ2RpM
	vJDgoNCH68B+An813m7bOewpN8RxLlGlJ5cE6ACxsdruNkPy5VNhgbu2TnV9QD8aq8ze2H3/FEn
	burZQ==
X-Received: by 2002:a05:620a:2887:b0:8eb:2aae:ef9c with SMTP id af79cd13be357-904d4f4b25amr4301047185a.27.1778589617549;
        Tue, 12 May 2026 05:40:17 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87bd588sm1464542685a.29.2026.05.12.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:40:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMmPH-00000005Aky-3Kl2;
	Tue, 12 May 2026 09:40:15 -0300
Date: Tue, 12 May 2026 09:40:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Joonwon Kang <joonwonkang@google.com>
Cc: robin.murphy@arm.com, Alexander.Grest@microsoft.com, amhetre@nvidia.com,
	baolu.lu@linux.intel.com, easwar.hariharan@linux.microsoft.com,
	iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com,
	joro@8bytes.org, jpb@kernel.org, kees@kernel.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
	smostafa@google.com, will@kernel.org
Subject: Re: [PATCH RFC] iommu: Enable per-device SSID space for SVA
Message-ID: <20260512124015.GU9285@ziepe.ca>
References: <20260511132128.GM9285@ziepe.ca>
 <20260512095714.2518097-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512095714.2518097-1-joonwonkang@google.com>

On Tue, May 12, 2026 at 09:57:14AM +0000, Joonwon Kang wrote:
> > There is a bit more going on though, I think that is what Joonwon is
> > mentioning by asking about ST64B and ST64BV. I *think* the answer is:
> > 
> > - ST64B uses a posted write
> > - ST64BV can be restricted so EL0 cannot execute it, it uses a
> >   non-posted write (AI tells me via EnASR)
> > - ST64BV0 can be used by EL0, always uses a non-posted write, and always
> >   uses ACCDATA_EL1
> > 
> > Which is similar to Intel.
> 
> Ah, I missed that ST64BV is currently being trapped to EL1 while ST64B is
> not [1]. However, I am not sure if the trap is to disallow EL0 to use it.
> Can it be instead to pass the response value of the non-posted write to
> EL0 while using the EL0-given PASID as-is? If so, I believe EL0 still can
> specify arbitrary PASID as it wants via ST64BV.

I think if an OS implements things this way it is would security
broken as far as ENQCMD compatible HW goes.

> Since I guess ST64B* instructions are to serve generic purposes not only
> for communication with accelerators with SIOV but also with any memory
> location or device without SIOV, I am not sure if it is always okay to
> make those instructions work the way Jason mentioned.

The end point has to use the posted vs non-posted write distinction
for security.

> > The device only processes the PASID from a non-posted write,
> 
> Regarding ST64B, are the ARM devices behind ARM SMMU v3 supposed to work
> this way too? If not, EL0 can specify arbitrary PASID via ST64B with the
> kernel today [1].

If you want ENQCMD compatible semantics then yes you have to do all of
these things, it is part of the security design.

Jason
