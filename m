Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBBA390C8C
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424599; cv=none; b=LMnD0K9RPfFXbvTJsPlje38cigoFxAbZof0MMMGFKxj9LETmGzmOtgk0A6M38FCiEL/chY0FpaXF2QRjuOf4Sv/+D5gPXd++qy2ypbyncvUopSzGT3mT1n1XKZsW+Rr2tEYRvJNCQbCBDu99OAJBzUJAXP1vLc1V+OjK1crMPsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424599; c=relaxed/simple;
	bh=cUXMsrDGeIBWOIuQbUfBOaNvH8JEbkg0nFIQzIgttYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JO/ZAAegy4PYfs/6U3bLLWHzbwq2Agoat2fUBYGJmPqsvBFNb4dhKwlPgzM2q63HDAC+pbVanvvmJAtk5/xTCbOstCVqZVoTRZcGBfKcVfG/YRcLcG+Gi6c+K4mcQyVFp/ki9d64ur1wjhKXAPPzyjln7+h4O8Biv/D2jfxkACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ul5Gk5QR; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ul5Gk5QR"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8cceaa6f75bso70543276d6.0
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780424597; x=1781029397; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbha56/7IbU9o6lT6g3eE33GSrujKbwp5wEl1xMrKQA=;
        b=Ul5Gk5QRsiR/gokmJ5PJLqx3inQK6SCWQ1xcSWCRbudZaPERQpaGwQkX0d9LEygYXw
         2EbxrIZxudIiR23ORC/yOqLiN/GZ2xlMot88PCQ8KzcE2Zlbrs1xyu55ctyrcV4ECZL8
         jicHLmmslkpfD1H2blCe+++V2k+Lzkw20/eTL3uwM9z4c5etwrprmf5OJGKgPESB+YbT
         z3WH23QxQ1AZ7OP3CNfzOq/nrQ2sieIg7ZZxmVEPDhu4KwPkfKFZ9yJ4aSTvUFMweOHc
         Qf+BGYnfnjjlkgET4KWhop/cQACkQZj9tXnVbFM/ysrYxjF+/SxDwvJ5WKNAEqsifZFV
         zFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424597; x=1781029397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbha56/7IbU9o6lT6g3eE33GSrujKbwp5wEl1xMrKQA=;
        b=pqAvKQ0REzy9lAGzvEOPGmqQQZYia/fR467PRT2EhrJnSRwaCK0Yg3ORxVmFgvfJEo
         ndpxk4p09THSK95f7xdCb5dX5FubX+lP8KaJzQuoFghD0c6+0zSZfLB7NxkOjHtILnh3
         LoihsLYAuU6tgumTPoqfrByIF3YwL0w2jnrMHLRVIftISz3mkmn10b2QswGQJ/EnTKOT
         guCiIxb4BcGTpPO9YhFkKvyD2AOBIsvIIT6vBpRzZF+ZxJFhge5BnWqUUpwHjr8mQO7b
         X4VfqH6k3KI3kNwNGBCKCkS5Vgk61iWhtwS2vPIZaZY+BkimynHemViOX7Wi+LdiGikP
         5R6w==
X-Forwarded-Encrypted: i=1; AFNElJ9BaMlMSeFJcEWoPf+SFTv6t/v1NaRTnJNdaAw8ftGAq5n6+PjsMgRZhj0wdZAAIlBdpBpKqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzFRNHl5LpGMU3dKRUh7RSUWrOGtwUD4s/eocENXa61iKpr4mF
	EkzO6GROsKXJIm28eXkwe9cykc3U4ztx2Ppt+b4hMVRS07NNr6v8buBrW1nzlPtRRbs=
X-Gm-Gg: Acq92OEnciH4p5tOIRO6M3xApkVWlT0KucXnEsrIoGEQpFZckD8IOjegDf+BD2md1Pt
	M+PrdzULuRfe4QISwB2RjIEj+bTflJ78WR1RLZIDKlFKPFAH40cXmAUg7LvyTuUf6eHltTW5sz4
	cQxZOqzekV4y6UkQhyemWWO7yX9qbMnDEkUvvEd6XB1PltDoyg79CxuSktVb7eHvxkBcUg0BHY8
	7T9RCk1wmoOh0mW15JOKAHEYaxxtADSaWw0I4zHiSLjI6WODIO67lbM97i9aZSAErXqQIaUZsAo
	UllrX/EzaQiVeYe0xmNQPRRJRlShsATKswMREa/9DIijKdI8lt2f5e8CX+geaYdhshnKrF4d11J
	dUL3sDIuhK1CiZbr38g4JygKwuTwPAdjWRI8q5SheEOzn31wY2ohaxJj3dRH4Ermz1TnCW6SDPy
	bio2WCJKby5KF+dz21N9Y/TVsXkx93qlYhVXrMrq6InJjaNGiSrFXk0c8PQTxEWzH8vHHIkdaMr
	HNxgb56QxSJ/X6b
X-Received: by 2002:a05:6214:300b:b0:8cc:f3e7:7c1d with SMTP id 6a1803df08f44-8cecb3420aemr11414386d6.32.1780424596822;
        Tue, 02 Jun 2026 11:23:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2587a5sm134235176d6.46.2026.06.02.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:23:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUTlj-00000004Mz7-1ui4;
	Tue, 02 Jun 2026 15:23:15 -0300
Date: Tue, 2 Jun 2026 15:23:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, nicolinc@nvidia.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
Message-ID: <20260602182315.GH2487554@ziepe.ca>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <ah8FYa0hdkkAFQVp@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8FYa0hdkkAFQVp@google.com>

On Tue, Jun 02, 2026 at 04:31:29PM +0000, Mostafa Saleh wrote:
> On Mon, Jun 01, 2026 at 10:48:42AM +0000, Ashish Mhetre wrote:
> > Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
> > survive an invalidation that races with concurrent traffic targeting
> > the same entry. The hardware-recommended software workaround is to
> > issue every CFGI/TLBI command (each followed by CMD_SYNC) twice. The
> > second issue must execute only after the first issue's CMD_SYNC has
> > completed, giving the sequence:
> 
> This seems quite intrusive, will the TLB entry survive if you push a
> full invalidation instead?

It's 36 lines and completely contained to the insides of the command
sumbissions code??

Stuff like this is why I was guiding you to use the more code exactly
as is for pkvm. Historically there have been many invalidation related
errata, and invalidate twice seems to be a theme in fixing many of
them.

Jason
