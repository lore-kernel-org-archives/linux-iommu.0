Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9062C2343
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226380; cv=none; b=Ovvd19ZJsevVdtjzzXk9NayXKg17XT7Jy9MRi1y9/Hj1gYW+Mg6+yJNHbVszARjvBdcwrTECHDfRHES66ephZK58pbMrr+BIZcq+F+006u3Zwu2LvMWSwTVNuyGlzFClk6h49rPxTvomlUWPnKq86nhJPxwqEbr5E+8F7bW9AJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226380; c=relaxed/simple;
	bh=n6+7p1fdJVuXTAshZJvAA2wH82a0EPrQuroIWx1J500=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEoETzIQeop0PlI8oJAWAbGw1ML6pQByips8Xpvbi8FFXmnpiB/nzeLySvXLyLEfOBdnwXN0FZagDN2ml7MvgW+Is/I7PjaYhWogFpNiVm9davWrvt7VJj1gcvTpi5GJrfuJFGX5uNH3jdi+374W0yU4YQMxAksNTv80y5Fa6hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EK76NGvW; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EK76NGvW"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b29b714f8cso461571cf.1
        for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756226378; x=1756831178; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6+7p1fdJVuXTAshZJvAA2wH82a0EPrQuroIWx1J500=;
        b=EK76NGvWB6O7VauWQC9Ids34Q9GHJA7/RXZRHpPNdzFCVqe37yT8UVJu0ArYf9oqz4
         GxihOYlDAFXvELm1EpvpocE7LgXhCiCd/5mm0YocwzZhSvR+wQllEFW+wr4bz0z497sQ
         PeCDMdjm+EjpGLwU8yz/y7ICe/ylkDT4ZYwEeSGZFhrI+erf6T+0K1VaVlwoHA6JmkCo
         ShwQbLG2QR1rJGCIb86nCiXjR+B4FHojPxr2vcbGrdN7uFz5ooyGrnfoGqgh8iWC+HAW
         bM9TAK9lfjBsNtECZlf9w4mTqNuSSb0OpR6wbTk1jM+b+kJcee3ATDVNN0AVmXPEkjbk
         OD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226378; x=1756831178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6+7p1fdJVuXTAshZJvAA2wH82a0EPrQuroIWx1J500=;
        b=ap+AnKHCDsHBsJxkDggKH0RQqjSS49C4sestyLgrXQRgGt2vwGLfI5Yo8z9HuiGdMw
         vfYgSMuUK0UlU+TK+p5/KMWV/y8XzzFdlt6/BbITedG5HLJ3Io3bxlsa5Wiu9LqeRc16
         NZYcB04xkTMQHoo+wx5CowkO3cP0E9g9+v0F811HGR/TIxepp9wCMvkQFpATjk4uNrkn
         JGB6sgA3o07bA1StgpOZ8P6qll1Y/xDoeJ7rH7RgrgJxA81aV7Cvwq3zl4V7/HNaRjYF
         mJzv/W4Awebhe9KlFdgBpgWBPX5Yekrh5eMhhqHnUM5ilXxKtskkSnUWWik8xuh9Ej3i
         Rtmw==
X-Forwarded-Encrypted: i=1; AJvYcCULDPbVYBiCeIHcEkO/GoKXQy5vbKU0qU+vTgIj9OCQtUZIzu2lKs+9ydNVs05jYAjzq9sX3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5vmhbHQ9fCQjT/40z4uzWZNsUHZx2FPzQsLKm3qkg+swELUj3
	KiBZNlQVifGOFcV6kkswXynjEKu8gAnPhzpMsxsJs6+fTPZFdOgGGDaxJ8WKgxlZqTvLHB5nDlq
	BZwma/da+nPJp+SigHa79EUa7E0E7ioGqqQXXfoHE
X-Gm-Gg: ASbGncvWi1W1UgE1eXzw6KS1Oqhm843wowFifdzCW0LuKc4nnyRIN+9jpfLRVVzheLv
	LB6JZ4rFtHNayHXAJ6NrogBskASxNo47thVyqMJ2a3gyFMGG6Wdfl/sxllsCPO9qXSBSqd+qUhr
	NI0okFWtOgNN0+Ys6fdhp+UwsBcQSYP7k82Zbbtz52ii0ucxHCKoosv5wUbg5mCaNyW27KaFfQV
	ke54gyZ4ZE=
X-Google-Smtp-Source: AGHT+IF9sFSkQJt4rZArtsNZy1iqLIVeCHcZ45BnpLXmrF76YrOG7Z45Enc/2KRYnJiWYQPQ41/HruRPhQB+b8/iQLc=
X-Received: by 2002:ac8:5a49:0:b0:4ae:d2cc:ad51 with SMTP id
 d75a77b69052e-4b2e2b6d63dmr6262141cf.1.1756226377856; Tue, 26 Aug 2025
 09:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250821094717.573232-1-zhao.xichao@vivo.com>
In-Reply-To: <20250821094717.573232-1-zhao.xichao@vivo.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 26 Aug 2025 09:39:26 -0700
X-Gm-Features: Ac12FXwtorRfZ_FzjnLB-SquF7kNHgSDOAoCJgOtfd17FUtw_9L-I2qwTVXlIms
Message-ID: <CAE2F3rBg+m_iVpJN+raoto2YV-0g1WFC-JNtuZV=OjarHgL3RQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Remove dev_err_probe() if error is -ENOMEM
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 2:48=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com> =
wrote:
>
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.

You could mention the following commit which I believe changed the
-ENOMEM behavior.

2f3cfd2f4b7c ("driver core: Make dev_err_probe() silent for -ENOMEM")
