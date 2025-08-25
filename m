Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49C304BB5
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146686; cv=none; b=u/wGoDtBLKuoizifVrTXpBhybM8BJWK+yxfzW3NkbazBqM8xqVqXvjPPcH58gdwlcEhUbCDLS+6l7KpbXYZP8HZt9QkK4B57P4e6PmvsKtVecd2uCsnRngkZdPEhG3/IXPdIwcCtdRuK3Toa/FCDBWRfPPicBfXpm5E3+b6RbtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146686; c=relaxed/simple;
	bh=NqoYACXOw8wDP1WvzCpUxeuUy2wpqRUkEhJcPRJdMis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BCiB24HTWy9Fl6tRxtvMlPCt0z/rhzXH8Mb41+BmP9xR60FfnvMc0uzXAisuGRi2ML3EVqhvzFNfrlnoX3dNQh9WDjiLwtyiYKDzc6oOK8cM8wB+txS9zNgcGw24UP6fsV2c6QcvxIc1NZYF/8AoGGNo1puFCYFTKhapdel/1iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VJGXmwCq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VJGXmwCq"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e872c3a0d5so471163185a.2
        for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1756146684; x=1756751484; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWiX+6VTPBW9oMyyTDAuGR0ExNJ3ZNdezl4Ijz6qJzY=;
        b=VJGXmwCqnBhY1AwRPDK09YHTKT6pyNMmrBhY+tjYwRB0sSNWftviacqFMrZuU2512q
         sHTt/R+wzXPxzO6y9jhJBs3ng/vFLhrq3fNa3ZCmQ0O1itCLR481s//IH6qhj2LYS4Re
         4u2gnAaM9sPtxWpXtLXg8rAGIseUVyTGgMphdtdxWrYXS+XDYi4V+A9YCR41BgAPGw0h
         bt/Dx35gKvEZJI1BllIbjO9yDzlE44Zmvbaw/VRTAeb/lUPjFGPTxnCINHYdvdwulSC7
         1CLL3Yd2cd+ZVISHzbVeCQszzjgtoP/JD2POQC6sHOglpxnmd++RuoBmcDlXRP9PTm8Q
         0+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756146684; x=1756751484;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWiX+6VTPBW9oMyyTDAuGR0ExNJ3ZNdezl4Ijz6qJzY=;
        b=hPzBrLyxT3cnrI0hqkAw8YQ+JQRjr5j4sQumuXgz9ItEUZB1gGHGOPryzzht+ymHRM
         LAkf6K6Uq0Y0qVe8nhoMNKid15s5Db/UlxySctZCt32xjLlEfx+SqY/uld8AQcsBresH
         ywLY/4k9ZEmwu9k99Mi1+5YR5CFxV1YWUxkPc+0BMaLugilc5KfxraRijj14Zgp52hLN
         +Uuxx41//bm0ZWo/iv9JtA5lntlsmqxGbsHjf7kpMdJqmA2S4EK1OTJpFtu89rDLjncz
         ZFbqd6SKerUJbKTF/c4wvhMwYkfAolexu1fcCNQedLcuYg8TAzEvqdIy/MhFm1TqYbCb
         mC4A==
X-Forwarded-Encrypted: i=1; AJvYcCW2fQEqzsifnMtyYfrbBLqCE0ZooWIYHbONTZ3rnaiw3IoHC+UvdQyiuR0sMo0oGEUNBq4/uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHNbeQwrH7G6GtNBzNDBxSPlfMbO9K+lkzsn35ekatIJVJdwez
	Bgm4VURfi8bQ0IZSropLlf7C0E1S5NcofuClT2xYI4QSgyp8A2zYtUROPFul0A8ZvYM=
X-Gm-Gg: ASbGncsCOFpIwIzkx/JAyFHXXiqCk35eI5kFybzQhvOzsMwTQ2tz7FCts385ociAATN
	bdkYmAJh0ZiVPrahEZLJxUU/GwcL/XsTfLixYyokrfSD90yQgiOCZVwuHIZI7NXZrqbcG+7rua9
	etnxS+NGaWLzGXaG1PoYYfK31tQtt/GsFzFchgSYcEQbXQMwH17XLHh69UkYfRaxbnlpFt1UDF4
	rB3twvh3qcwZoP6DsBuRZ3/M7mN5/r4p2Yyg2w1buhPgW8U8RHWBh7JENd6NL8XBpoJguMNzpqy
	MRUOjINcswEKjoBAOpz7qHjyyMxE4ijFJLpus29nFAYbf/4gg7DCPfUqMBof2w+koyRiARCvdJv
	CXaLGYyCm/1aOTky6KBhUJcwpYQys77mNiFM01+RFwNu6wUHIwI4adYqlLb4CUjGSmubo
X-Google-Smtp-Source: AGHT+IGrrqtb5FLiQ6yBv5bSbXionDmSOOeGsus0fmtyrIvrknH2Q5meU+RUaqrB7rQ0ZREIDsRXNA==
X-Received: by 2002:a05:620a:1726:b0:7e9:f820:2b95 with SMTP id af79cd13be357-7ea110baa0emr1337281385a.86.1756146683666;
        Mon, 25 Aug 2025 11:31:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c631b8sm57949871cf.3.2025.08.25.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:31:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uqbyU-00000008lWr-2NRj;
	Mon, 25 Aug 2025 15:31:22 -0300
Date: Mon, 25 Aug 2025 15:31:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	p.zabel@pengutronix.de, mchehab@kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v7 4/6] media: verisilicon: AV1: Restore IOMMU context
 before decoding a frame
Message-ID: <20250825183122.GB1899851@ziepe.ca>
References: <20250825153450.150071-1-benjamin.gaignard@collabora.com>
 <20250825153450.150071-5-benjamin.gaignard@collabora.com>
 <20250825170531.GA1899851@ziepe.ca>
 <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c327e8353bb5b986ef6fb1e7311437659aea4a.camel@collabora.com>

On Mon, Aug 25, 2025 at 01:50:16PM -0400, Nicolas Dufresne wrote:

> Jason, the point is that the iommu and the VPU are not separate devices, which
> comes with side effects. On RKVDec side, the iommu configuration get resets
> whenever a decoding error leads to a VPU "self reset". I can't remember who from
> the iommu subsystem suggested that, but the empty domain method was agreed to be

IDK, that seems really goofy too me an defiantly needs to be
extensively documented this is restoring the default with some lore
link of the original suggestion.

> the least invasive way to workaround that issue. I believe Detlev tried multiple
> time to add APIs for that before the discussion lead to this path.

You mean this:

https://lore.kernel.org/linux-iommu/20250318152049.14781-1-detlev.casanova@collabora.com/

Which came back with the same remark I would give:

 Please have some kind of proper reset notifier mechanism - in fact
 with runtime PM could you not already invoke a suspend/resume cycle
 via the device links?

Or another reasonable option:

  Or at worst just export a public interface for the other driver to
  invoke rk_iommu_resume() directly.

Sigh.

> Benjamin, please improve the naming, comment and description, I agree with Jason
> its not completely clear. I'm also surprised that you do that every frame, seems
> excessive.

Indeed if it is just error recovery.

> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ff8c5622f9f7c644e995d013af320b59e4d61b93

This is already merged? And now you want two copies of this? I think
this is a very poor direction..

Jason
