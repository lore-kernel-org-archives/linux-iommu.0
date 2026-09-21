Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCB2D0C8F
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961485; cv=pass; b=hs+A1YAHYWQJWvFDmnwwim9fQg3cTzEDbSCb7aJ9u1mpGhW7tRDa7FRX0YMxwXARw6eETX0sHnnlBlsnWifIHJVj5axiCuOulFcBmCHLIOQL+s3AWpjWZjA6t3QLa5lGKk7GFfoKP+eL/TRMGyh5MnxCYOL3bNaCo2v47iHq+co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961485; c=relaxed/simple;
	bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bquGRLZNOUBLYcH3Sddk9O1yMcUo+q3tN56Hld4bFP+Bz6jxbyC65R61QF6/xxU3i56kzI56lxYilv/TTnwzr4avVRbzL4E2rDA8/1Fr/gf2rv6SN1yIUh5+ThKBTFshCNQcTzZBqBo0lRLd2I9GFUsaW3SYtiswjxlKUAGWziA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RiLSjEYd; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiLSjEYd"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a9ab2a135dso3246175a12.1
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 20:31:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789961482; cv=none;
        d=google.com; s=arc-20260327;
        b=jplKjqRH7Lkz9VFQWP3UEt71hOREqAzigD0y5rr8/ksj+wXl2mKZehuNR46EN4kyxe
         scGHNPtqNoUR9znOgmWmP7L/fvOebGfcT8BMrYknUfI3dQskCFpYeAx3E7ihSzgOjAfX
         sNMBzQwCA5rmW4oWJlPo9FXMBVhhJagxZmisQIjqJYYKka0oe5h9fElerSdv1ERJUnSr
         Bju+Kp3YEtC2ftzbGDU9TX0JVaXZpRvwh1+mv0fMOeeeXTJiokuJTGHTqswyk9auOs8E
         NpOXFpIlSmOUuDNyEJfJ25eHjgDLmaRAUliY78cnh1IwffLL6uSlWGL9RgMB1kdQz5+p
         TBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
        fh=fVmycuha3ZIzct1TMnTkculvqPug4hj5DUqICqCLZmw=;
        b=Nh8xOhHu2QkgksY4lknf8vCGpRRuf+DgB7U/KGGd+JgHZllvvpNmvlOxMafHSArYng
         HH84vBOtQdKffiG8OU759GDxUjI3qVBEaucjDq9G8GLzp/X0HWa4uRVNKNBVh6p4DBO0
         1rbDgq/qMxK+YN5Jb3BV8BKO+57CVkOW/z5DgiQEGcqws4akgbnBFMC4oF3XTtHJwSwX
         GgNkbQm9aFJPgd7JnyvmxAL5N2EKOLGFdrtZNQur6rggoqKTaf5cfJV4MlZeWqx9KMkN
         LpwDzysVHBCtzCRWNAgNiriK2nb1PXJl71hCDIVvhJ59DGNgX8l1lmxQ/7e+M/y14eve
         qnqw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789961482; x=1790566282; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
        b=RiLSjEYdPu5omADaMBZS/9YLX5kZkj9gO5rjW/VD+96biz1hgSuAiGZuKq4CNvPGtT
         /0X4Y6MA3KpsUr+n5Odv2Ooj8CAZEkwiee6uqE8wlP7DUxYw0yEeXK7FyBI85aR6jHGy
         /ZwtcieBfUVSJ7FiTJOmJMdRgn7mcpIdsai1nu2ubiJ+gmEmff8OVe0+D07vvoUnVO3A
         bKiC46cQ0VZV2DPng8/5eG9FBeCT83yYHffvhmEiPEVUYHhaRxBTBETnHI7GsaupbCb1
         0SnWWtH/WCrlNFt3yF2uSwcqjUH2ZAFKCKaxrsIshoDQnTl6hm0lGENufq7xTW5T5X93
         YTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961482; x=1790566282;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1JgJndpiQjTJjF4DQFibfiYrBkEpUhcO1uo3E1MTk/w=;
        b=TPNv/5giMrgzR6QIbr5ikgcdgf41su3Aco/+omMzkxYQqTE7NrSFxlbGkJKaWGe5WI
         HmlFpD7CfCcMisUSYDwGRFU9ovplKuD2aGqFdcU2SF0SH68wX5R0kdNwlPOgTRHg6zhQ
         IoqahuZviMNCU/SGZ8t9nyXG1w4fmjW1LjL6P9emcwfxI5eDYRXEA4nBxBMuPikhv+kj
         /l5Vt/RGMdn0qARp3Ytw7NeCPJcwkcowOty68tmB1G7be6QjWRA2QbZfLCG2Wf5K+KkE
         waqdrJ9KRPNvDHid5bl10dmTCi4fuJ1zLU9FZn47poEHTBg+lJqJjLdCV3WA5UkEkDo+
         lV2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxy2EshdxTTYc93fBfkztOYoxCCwSugobk3ij++ub8fHssmP0fuGfX5BVoiQF4QqGfjxyAi0w==@lists.linux.dev
X-Gm-Message-State: AFuF++l4Fyx6QklgZcRXnYrFuZ14mpiwZSy8rJyauxCsfHPoeYZLExRu
	p2sJZSYGl8X0dzM6BIjkAkcxDlaJ6XVUaZBcMsBO6SOOCqWoZvkdgMZrrfiev7nSn9u4Fn6E/uc
	/M9Y08naxqvUUX3a8O07RN9DegM5FjWmfwBOxP4GC4Q==
X-Gm-Gg: AYBFou0l6kGxzLffjrPgqwocoWAwzf9UoWOJNefbGfgtXZsP970nB1mKyrxqnK4RjA4
	OXTfNK45Z4u/PYy8UJD8DI6+F+jMPi383jcurmjlMMj2rLcRZBCKiSt9M6UfZyWO9t5g90OEvq0
	EBeNmWGK+sce+eTb4pzjMxgrzYh19gIwpqbTlvw5q4koGiOX94GSaLe0XOmobrFsA6In5RFfGY6
	oMLNYjGSc+8jEUjUbXHtWwp/G/ykIXoOIl/8isPkHAU6ge5qK31i7QAxukiN3ESZKejye9XT9d0
	YXhyq2NMR8g70sobG5IUx7t4oistf+H1Z4VEesbXOu5Keo8B3eXtt1lEQZ3xc3j4YkSrwBja+YC
	3vYNRKa9mLHdakg==
X-Received: by 2002:a05:6402:4394:b0:6a9:ab7f:c8f with SMTP id
 4fb4d7f45d1cf-6aa54611e57mr5885453a12.17.1789961481999; Sun, 20 Sep 2026
 20:31:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <aq1sooGCYUiWbhMH@p14s> <aq453yukMHiNb1jp@bywater>
In-Reply-To: <aq453yukMHiNb1jp@bywater>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Sun, 20 Sep 2026 21:31:11 -0600
X-Gm-Features: AcwNN1W3qE53RFtHuPGOztjJSdwljZIvy9Wk3z8AN3NJ17iDKQARaTMy5b-3hH0
Message-ID: <CANLsYkySF+eF-FURnnT6UJv7P5Sg2HdfMSBZnZy_BLyCMvuofw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] remoteproc: add support for any virtio device
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, virtualization@lists.linux.dev, 
	imx@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 19 Sept 2026 at 01:33, Francesco Valla <francesco@valla.it> wrote:
>
> Hi Mathieu,
>
> On Fri, Sep 18, 2026 at 10:53:54AM -0600, Mathieu Poirier wrote:
> > Hi Francesco,
> >
> > I have started reviewing this set but given the size and implications, it will
> > take me a few days to get through.
>
> I'm going through the review done by sashiko - would you prefer me
> sending a v2 with the trivial errors already ironed out before doing
> a complete review?
>

We can wait if the errors are trivial.

> >
> > Thanks,
> > Mathieu
> >
>
> Thank you!
>
> Regards,
> Francesco
>
