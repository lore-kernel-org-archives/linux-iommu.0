Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0480282F1C
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096611; cv=none; b=OwR1TY7T7sJRAZihwX/xd6iTLN2xXtLcJpmgaUvV6GC69ueDzVaP82hUq7Ch/I+oz+6J3X6Uz9xLQVnXeKN1ovJgzILG8XDCgSF6LVYSNI0zdfXwYtSE35AJuiEVK4+19poM0l27mRZOlNJb3mBQ5eP+lfhY18zBuJ1TaLDxRBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096611; c=relaxed/simple;
	bh=C/3T9f7YFyndjPxorE6yY5t66bwUWgJKRml4J+HvRhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEMTkuuQYAv212zuJ6szxkmF3M5tOrdJOgp9+M4+dKpl9Z1ZqMhX0qyKOhX62QjQnM7IIbTlGLsJ0Kwj6di1lrA851r4jJ5q1yNzZaCuCIvCIF0B9X0SvFiU6dgbj7gL5hASZiznnTL+/fqcjWlSjG5zhOsG+5WqEFVmCKftz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oeVx5u+J; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oeVx5u+J"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cfc085395fso439783885a.2
        for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776096609; x=1776701409; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=miwNbJxKhSdJiq79jVr6441KfZMZND8Kh74V7hAFm/U=;
        b=oeVx5u+JhlfpJvt2TsURfNTRB7lazqBcizMt45RA3bcRsGME3574YE4EEzPkHkkCSO
         8oh6KrRa2rDlKG82ewMGCR0Ymj0AYdAX0FhmnsSc/daMA3LO/utZUWjPDtuAYnkWadOA
         4S8nKdMNm1SeBVjQnn+V7OQxPgulO8gfbF2gL9eaL4FVA1MOG5W7Ajj74mZIXNjuE+WG
         KFh0nykU6zBzpCuvJ0VZ7lEu+QoLtamM1JVqIa+2+M5u52SLUbeu4Q0gGcAWnssYij4v
         tzt0114zv4+nDLdrWtrRPQttXt6yWuVGbmECXMr7tSJcPRRKdwHvKgpVaAkTBUeEMW+F
         YhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776096609; x=1776701409;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=miwNbJxKhSdJiq79jVr6441KfZMZND8Kh74V7hAFm/U=;
        b=gF6WGbd4KQGHf/uZlH9YpHs/Q4BN1zSQMizpkUx6lrDWuptL3F9Hy/LKEHkOrahAN5
         +YN7TOr5Eu/HpneG0AGcHZDJm8p9Ig6kdQKuqnDHlYGm3RPOoZPkpZwtVflOvWSZbY+T
         +9WwHkIbO4MaRidQMp4WxgMBlv0BDlye1Tbokny1SFKH7nkFm0RiiwhKElJTNTlxZzcy
         gaOOPzwZQxiRpSD9lR1DSXiIfwL00Z8iCdxdxd9dXXzdEqO0MH2I3lP7fUKG31bVEnil
         qJVWTZDyrYrp+flwUiRDLmDKjNgxlrBK/vGsAwpsvHZq40wyl+dX6Od0fJH6OL1yuT4I
         40iA==
X-Forwarded-Encrypted: i=1; AFNElJ/esLx/twsDw2AW46YigedMHfDfsXT+36c1rwnDGv3Wi9LvvNQbcoUpZuDWJ1QXj9fp+/1P5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzovXv6OfydUIcRjwP+0O5xxF1jh4sEMHB4WkpsPT+clAJZwkmL
	NkoqrjX+Fj5p80sDBcOE85ZbwoKV9Y/aAT0jrtx8rzIp0wjNb4X00GuYLIUYRmlDjNU=
X-Gm-Gg: AeBDietn/HFmuWyIkH4BtNOnh+gH/VROx63tckIV1D9uYvWFGYX4fCQqZT+jOtSWcg4
	CUNiU4oN6NhqTQ9t6BaHxeXibtu8lZktoIAhzruFfXV00dQAvQ52KwBMv7/k3d2tlpuI295sGKZ
	hM7T7J87xjwpg3kfZAZ2uGzLUzQNm2zc31mR3fVvUK9NYzw+Fqw0BtrzdMbJACptXTS/KSBPAJX
	UJeV0q9h4FU9rcon3RU1yAmGHc7flgjgd/8jb+fbFnpXltQvK8q3VuFWa0JkGY7kCa0B6tckltc
	5TN5IZbuSikSKTWWt2K4HxiBkZ7szc+uUnCrkdgSJKuNaJgV/mLLW0Ti1eCN25JCo3hSnfjY4tO
	v9rJ5g+BoedXUq4ByaicTfJJRiATqIrfMI67zlvP/TktmjV8x3GuyslAuODRrkcgeG6+k2Oz6qF
	5nB7N9Ii3lRL/qUsIJI1ZCmNambAbqQeVyB2Rx7oXvXMrXpfGcBZWdlr7JRJezVyaUu3QAj/T6e
	QSV22tDV5B9Gs0y
X-Received: by 2002:a0c:f089:0:b0:89c:3f22:c89e with SMTP id 6a1803df08f44-8ac861fd45amr187179046d6.24.1776096608349;
        Mon, 13 Apr 2026 09:10:08 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a10e7esm99025496d6.16.2026.04.13.09.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 09:10:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCJrS-00000005PqT-111F;
	Mon, 13 Apr 2026 13:10:06 -0300
Date: Mon, 13 Apr 2026 13:10:06 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	m.szyprowski@samsung.com, will@kernel.org, maz@kernel.org,
	suzuki.poulose@arm.com, catalin.marinas@arm.com, jiri@resnulli.us
Subject: Re: [RFC PATCH v2 1/5] dma-mapping: Avoid double decrypting with
 DMA_RESTRICTED_POOL
Message-ID: <20260413161006.GM3694781@ziepe.ca>
References: <20260330145043.1586623-1-smostafa@google.com>
 <20260330145043.1586623-2-smostafa@google.com>
 <20260330150654.GA809900@ziepe.ca>
 <acrgYotBExJhEJkK@google.com>
 <yq5aeckjbdrt.fsf@kernel.org>
 <20260413123559.GI3694781@ziepe.ca>
 <yq5azf36anmf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5azf36anmf.fsf@kernel.org>

On Mon, Apr 13, 2026 at 08:55:28PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Apr 13, 2026 at 11:30:38AM +0530, Aneesh Kumar K.V wrote:
> >
> >> I know there is a v3, but I’m commenting here to check whether we really
> >> need to do this now. In my opinion, we can keep this much simpler by
> >> treating all swiotlb allocations as decrypted allocations. 
> >
> > That's not going to work when we get to supporting T=1 devices that
> > may still want SWIOTLB for encrypted memory.
> >
> 
> Earlier discussions indicated that a T=1 device would not require a
> bounce buffer. On ARM, we require such devices to support 64-bit DMA so
> they can operate with an unprotected IPA.

That was somewhat different. To have a sane system a T=1 device should
be able to access unprotected memory and there is no *requirement*
that bounce buffering is used.

That is very different from saying that SWIOTLB in the kernel is
completely broken and unworking on T=1 devices. We should not do that,
it should work correctly and we should have a sensible architecture
here. It is just something that would never/rarely be triggered.

Jason
