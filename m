Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FC47043A
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153588; cv=none; b=qWyHiBf/rDqhahjZkH8mu2CdJM9gF7E70gslOty4hJCAix4YDLqRKOMkFP2aUr5otQwU9Sy1iSvhR/r0ZhLDWYAeEm7tWUGIXG1bYS3J2wvqh++HptOeoOwVmxzlJeB1W4FihUPydNcDqwmJxrLTz0yVIwCA89xx8foKaGqeQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153588; c=relaxed/simple;
	bh=+Cl6oGedBJJ+fMGdxql2VP3tbVmZikvWHze9Qm20rQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npx6BIQ+JetqA+iWQASELAgUbo//AuJV+WpPOTWAhF/a3ddkJTwluARdwhQCsXLrMiNVjHuyMH8a8zEjFqSaNecFK3kHyAciLdC2YPxxDoDhRlu5NnmpDQLc2uyWRQ88N8Dwf3BANCqO3ytX1tp8al3IPHL2V2A4odHkYDqEoC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4H35Clw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4H35Clw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49e65a8f70eso26935e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 01:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790153574; x=1790758374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aefF/PiYK1b4Z/D8ikpDUgUaGPgIxFbZ+BKtTsI/MQI=;
        b=h4H35ClwdVm/RxwJ2BREKYyuurqlfhVAGcdSbt/P8xYAkvpM3Ju78D1nXF5AAd0QiG
         lUCIt77c4+URkPO0mpbs6Tteqv4GQU+vPQbKQHbiWN7h3iSafNAbNe6/mIGrdhaRrO1F
         1OW7WtYLKru4NJrJ41DAJXmDr3FnkBsrwHBZDfIiTUAO9AwIY43FMiDGR4B8gW47//pu
         FA+yc+Siud89PNKv4h6DtXhEQlDwemOGP/yhw8bL7ntL4w7+I0FGNcF+cfaACH/hE2fJ
         len5LlC+WhBvhiTcRS8U/Z1soeYDKy9mTs4PPNppcL+dYcQHF/FpJ3l3Lq7Wj0HegWzI
         YBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790153574; x=1790758374;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aefF/PiYK1b4Z/D8ikpDUgUaGPgIxFbZ+BKtTsI/MQI=;
        b=syryX8jJVUufobXECKptREBD9dhHm4xVinZG8nIX6vp+pDwYZ6omwzXeoUX14PE+j1
         eKnUPzRdBmJcXwPZGj9lUIeJB7eZZUIOtpDtG5HhvcjPHdGfd1IsxXc/q+p0TGaNrHMM
         jqGUZ5Oy+H7I2sOvIerFjR+jqwxI8y3bOE9pdgCvXrI93sTzPJhdJDTN7YC2WGNXnBU8
         t5kTG5469GFccn0E5/lUdmSOA5oMqpiQPccvMS5tesmtByp1fyQxRbVZrXNQRLqQc8w1
         dl6BXMqDRpQjaLpb2lBSnzghzD+f/UN/tP+GfqLdgzQ+ltkPyXhwLy/LY54QIadrE9M+
         jSZg==
X-Forwarded-Encrypted: i=1; AKwUvBw8ZXme0PzqryQN9cAleCb+lixPcdtWMEzXu0CfIYa0sjizMImP8D7u/D8Zb75E6xRt3piTCw==@lists.linux.dev
X-Gm-Message-State: AFuF++kTFskE3oM/MXEins4/B18i+11s/PVv4J/6BCayFqFW0WELxQbT
	TFU2gfeVoklevVq1Y1qUskVSkqneOBT4vmRgeMxvAh63/MO2CKbED6f0Olsn2nVakUQUwd6dBVd
	XTk5JIQ==
X-Gm-Gg: AYBFou1ht/e/lvlUV//9lxj9mUQPFmeWHaFBA7pfSCBpIuGOX2bhSqwmR58eMqvLKof
	lC+2Oc0t9ggG4trICcm/b+3h/71mNN3v8NYhA1XRrwAH6eh7yI46ho2PpydARFpPUhN/uImbwQ1
	vFn4N3pfiyntGv2vaUXAc+tWlh473/FJVjc4zVeHXQfsfDDVrYYGpdU6oVsNGD5OEWlR+mu7S2J
	yzjr2W89X+UknfkyRjTCyckRbFt8lUukMIzBCWZR6ZLczPhbfpDduapV0sh72lTCRi+dyQZcNYK
	SNrjXx1ZC1iAFHUd90lC1+DQYPfOnpx+12ZHRbRHM+rau1klmqmuaYBDF/WocuEYBeq0ok3bgim
	Xbxom/pePUt7wKomF6oDAZIy3j4/rOO/GGx6fVQ9tOYfWy/ZPq7xBmw6pYgSCVoTLi/avYINXyZ
	i0ssNXRwVfEXzIIvMTuWCqIPXzbvnjquWxBILG4uwcbjeO/yeYvk8LGF+Od5FrKdFZuD9KS81oj
	/VTheczdGAKQxGkck6DRvqd2ijLI5K3TP2H8eqR9g==
X-Received: by 2002:a05:600c:35c3:b0:49d:24e2:5454 with SMTP id 5b1f17b1804b1-49fe0c4a230mr735295e9.13.1790153574217;
        Wed, 23 Sep 2026 01:52:54 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm60265885e9.5.2026.09.23.01.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:52:53 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:52:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 00/25] KVM: arm64: SMMUv3 driver for pKVM (trap and
 emulate)
Message-ID: <arOTYREAT_JEyp9U@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <arLD1qj8E+tE2MYw@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arLD1qj8E+tE2MYw@nvidia.com>

On Tue, Sep 22, 2026 at 11:07:18AM -0700, Nicolin Chen wrote:
> On Tue, Sep 22, 2026 at 01:12:33PM +0000, Mostafa Saleh wrote:
> > Notes about Sashiko
> > ===================
> > I ran Sashiko locally and it was helpful in discovering problems in
> > the series. However, it still shows large number of critical and high
> > severity issues, I went through them and I believe they are false
> > positives, mainly because (in the order of frequently reported):
> > - It doesn't understand WARNs are fatal in the hypervisor.
> > - It doesn't understand that a malicious host can DoS the system and
> >   pKVM doesn't guarantee availability
> > - It doesn't understand the SMMUv3 spec and makes stuff up (eg. about
> >   CMD_SYC CS field it makes up an non-existent encoding or wrong
> >   semantics for the gbpa register)
> 
> Just my two cents here:
> 
> From my experience, making commit messages or inline notes slightly
> clearer against the findings that Sashiko reported could simply help
> it understand things better and mute most of the false positives.
> 

I try to do that also, it helps to a certain level, then the code
becomes too verbose and the comments will be trivial :/


> Otherwise, the number of the findings is a bit scaring; reviewers
> would have to go through the long list of findings to check whether
> each of them fits into one of the false-positive categories :-/
> 

My strategy is to reply to Sashiko on the list to save reviewers time.
But my main concern was the large number of false positives might
discourage reviewers thinking there will be a newer version with
fixes.

> > - It seems to look at one patch at a time and not the whole series, and
> >   as the series is written in a way to be bisectable that confuses it.
> 
> Yea, that happens too. Usually I would add a line at the end of the
> commit message "a subsequent change will do X", which could clarify.

There were a lot of those when I ran locally. However the one on
sashiko.dev does better.

Thanks,
Mostafa

> 
> Nicolin
