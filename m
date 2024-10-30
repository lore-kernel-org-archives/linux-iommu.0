Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE431DF754
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294905; cv=none; b=UeZ211xk/KaDVAnZ0RLmnyjsVLkVkgM4aTeEB0FQD+7q9MnPesvVTQX7By0yDGKH7sDOoScPY7LRO1kK9Kfzs4jzP63DdDkadh0FQqSEUzuMFNlM0tKLTBTkpvBwPtu7IGPne5SfG7w4IRf07hDHaczlghxm44h6RBzvo/sDLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294905; c=relaxed/simple;
	bh=Co0lass6VxucvBFkw1aOnXJDq+FBmwMkMSrHRfwjdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK3eL/zOgvY+SUviKJyfMWTR2GylaoN1JTuwzBOgpEVKS2qwPcfNLeGj1nQpjfbfrIu0FNI8vkRnrt4AY1B6HT5IwP8RoyPiw04q8cohUCLviwnCCqIzHTHvEA92S+0qKLCWOmSWy0KsskFDWlsX9G2Be/xBtHA2zXsCoZ2MLaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gbm1tWy0; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gbm1tWy0"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43169902057so61715105e9.0
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294901; x=1730899701; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5bRYMDo31wli1+F5XqLgDNYu5RKLrQYurcKRy2ybtgM=;
        b=Gbm1tWy0MBF36e3n8aWhhNwUR+pmMxpUoSJPQJXm5ijlTcEKZ+GLltSl9ENzHap6QU
         KVOrFtcZzyHKw3K6vdnAvTJ5iE+1y0XHyOfOli3YxdlIkFXXiu8m9i3NvE616Xn9wRJ8
         pTZvU6pln7EXg4kg35NtCLvT/qCbXWXxzhj5S1mjeXp+tQlholJLQYNgiEt2+cW5jQxj
         z6l/RFZQjMUq0q11UB5cwTrotX6JH15xKcLIWAmBePB8Mp1s7r7n1Cguocr1A4jtuS4y
         y5J+Zn6r/oU9B7+fkCc5ExXaN0G2ND9e156qxfnNansNZY7TBuUPwWfF5wqP47lQS11V
         7DgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294901; x=1730899701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bRYMDo31wli1+F5XqLgDNYu5RKLrQYurcKRy2ybtgM=;
        b=YF+acNzJHl5SrbkvGhOBgw89C553bI7Il/95FqjI0R0AUM5Or6hWaI5Vgbsiq5vH8B
         uxmWpS+14xaxDXzFgnTKbASJknAcIiAmfpjss5ucpvNS8r2chw86fxBdfi+kDcepPhvv
         91HBkpo7nelThv964QZsuHrfHcUocSPAk7Tw0uloQemQ9Qu3TwOZXHU2x0iixVYDZW5w
         Nr0p5FJCB1O6jrHGzbQX5e+KlzeGRBWSi+ojNhPsIzjB/R2WW4on66TnrOdR9b2SsmDq
         Va8tOiwctNvXb59CPeHD5DoAOgBU08PFjE44PneUxov2E2NAk043pGk6Mi6EuVN6PgK7
         33lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqnbS1q3Ke30Mbh7C3rrZdysLjdrTHDOFz/Ee/yxeK8Zfc7WB/EG/188puk1q1iT9NY2Pw7g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5GMNaXHtvduBELRz+PPs7jZQQMjb8HSZJa6WcNW9LuqOfQXq8
	5B8iNJrKaVtLfbsbt3JsVOsxvwiSWRHEql16EEk6oHN4ISx+3lck
X-Google-Smtp-Source: AGHT+IF/oVv8150+7ro6yu0YdcKzcFPQ8lbfxvxtxQ1j2qTb6UYENnsCgQU3QxkyOYC63S92RRMIAg==
X-Received: by 2002:adf:ec8f:0:b0:374:b35e:ea6c with SMTP id ffacd0b85a97d-381b70ed1c3mr2289041f8f.40.1730294901291;
        Wed, 30 Oct 2024 06:28:21 -0700 (PDT)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b9294dsm15353345f8f.105.2024.10.30.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 06:28:20 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:28:13 +0200
From: Sicelo <absicsz@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>,
	Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	mchehab@kernel.org, andersson@kernel.org,
	mathieu.poirier@linaro.org, Beleswar Padhi <b-padhi@ti.com>,
	Andreas Kemnade <andreas@kemnade.info>, iommu@lists.linux.dev,
	arm-soc <linux-arm-kernel@lists.infradead.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix omap-iommu bitrot
Message-ID: <ZyI0baBMPHVZ29-k@tp440p.steeds.sam>
References: <cover.1730136799.git.robin.murphy@arm.com>
 <ZyIClriScBy4s6LX@8bytes.org>
 <515D7932-3939-4C3E-BA3E-CC3152E64749@goldelico.com>
 <ZyIos2Gm1nf5rejI@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyIos2Gm1nf5rejI@8bytes.org>

Hi

On Wed, Oct 30, 2024 at 01:38:11PM +0100, Joerg Roedel wrote:
> On Wed, Oct 30, 2024 at 12:20:31PM +0100, H. Nikolaus Schaller wrote:
> > Why that? There was a discussion and everyone agreed to remove omap2,
> > but not omap3 and later.
> 
> I raised this question to make sure the things we maintain are still
> relevant. Developer and maintainers time is limited and we should not
> spend it on stuff that nobody uses.
> 
> > There are some devices besides the PandaBoard. I am aware of these where
> > this is relevant: Epson BT200, Samsung Galaxy Tab 2, Pyra Handheld
> > (in production) and we are currently thinking about producing a tiny series
> > of the DM3730 based GTA04A5 with spare parts.
> > 
> > And of course we want to participate from the latest and greatest upstream changes.
> 
> Okay, if there are still real users for latest mainline kernels on this
> hardware, then the effort is justified.
> 
> Regards,
> 
> 	Joerg

There is also the Nokia N900 phone (OMAP3) still seeing mainline
activity, as well as the Motorola Droid 4 (OMAP4), to name a few. I will
also be testing on the N900 around the weekend.

Thanks to everyone for the amazing work.

Sincerely
Sicelo
