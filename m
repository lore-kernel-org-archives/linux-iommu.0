Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D141737A
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431758; cv=pass; b=Vyk2DQuOFYQ8BFD27MwXGPzByLuiNQAtdoJh4g5+cARVOyZsigZzWtvyvotT2Vi+KNQQ5lBmDVFHKiFw+R+GbicnY0/24L3KddiESKF+LJ+Ixh5VmhF3qvNjD//RFYZaY+9GPW0Q/SRHLtCM+kZyj5hOj0CoC8ydCFdwlAn48M8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431758; c=relaxed/simple;
	bh=E1zAPP9belnBMx2I7CyLtNbspD4kzIfqj0U5PW0gNQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gglAtPG9mL+X+0CXeP92NUlUZFg6JvXWfdNLt2vWoDd4kxeszANslTQKLi5rdTXAA9ztG6vDl8BgaKF+ee70sF8203MruSW3mfeRP1SH1EQYa3mMZYC6BqWZdNlAubEZiP91bRI8kfsHN4wzZt7q60/jhagIVVtKV40w4r2L9tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sK+wk/Rt; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK+wk/Rt"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6649ffb1d01so6807568d50.1
        for <iommu@lists.linux.dev>; Tue, 07 Jul 2026 06:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431756; cv=none;
        d=google.com; s=arc-20260327;
        b=SX35PZ9JkJEMsFhO7iM6fVSZ7Mejr9jWv+OTIJgD3jtGJbKgHLykX5Hv/t1JS7/heC
         oXq/vdiq3oH32SsRMozmdaFOcbpORE6rYUptRpqfUvv1RH2DDp4Ny365tVQgySwoLQDp
         LkrDuuk+5BjV+tXtxcHKFAu38tBFJpLJQApnnMbrNqia6iULtrd+sIHcX4o4TZTNhKsl
         hRCPFHYNRYHq3YqV0Sx/tVdVWEE4zshca0n0F2USgLm5AF6Ueh57wO3lOas1mQF+v74g
         4X8CEEZkAAk+l29/5426Y/VXtaEtGmOCJsx5QQAzzxjjuDl/9BGo/0IWhUL8sSdpjifq
         XpXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1TwL3+aqF7dc4/lpQ2JLA2uoetuIwHkPHzHxzge8914=;
        fh=9qOeJeQps/vtnoKxNJdQ8H/8eX1YUqR+ZI7uW7fcS+E=;
        b=XA5tu5JJv4OO8EaVLL4qdvJPyd5GqOBuQzCLJrvkhvveLjFP47JgaiDy6exKF37lWN
         wnKd8+YLa8E9L2CneVLcMjKbiuBqii0dfQyy5eUB4kxxD1Bf8Zrg22wbnL1avF7sODGP
         F0Gb8hgqOu+tVnEmBj/YadIbrEGtDj24pZVYEOcbN0QoBb92mU8A2blSMw5qqG6N6Lsd
         uuxXu81clLI1hQu+qNeWVokrnb50ObRBHUUvWS46wXA3dlvUSIdeX5fkpaNr/zA5hnOK
         sNp3+it8iXVucjK0+1EdpqyAegFkPIEhJLLPHwlI4acQAFwAX9Zku+GTM+GaeiO5WeXZ
         D9ow==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783431756; x=1784036556; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TwL3+aqF7dc4/lpQ2JLA2uoetuIwHkPHzHxzge8914=;
        b=sK+wk/RtjNiew4pAMd3CCsIMI+SupolyavmcMvY9so4B9j75Ed9iaCf6p6F1x2zolt
         8zrejjT6Ikvv/kO84bgUUewprApbk/M6oVctqD7xMOmD/TG97FQnK5zwwUw82nfKm+1o
         Vv9ZQQgl7vzkR/T3UyuHL//4IYqIcm9CXUUV3t4urtb1Xbty52l8EW9WZFOrSOSkfCrR
         Q/s1okBVqoW71f6veYga3w9ao3qkhslECd2ocZipqSIJdhJDilh/Us+yxA2TwF9R4DnY
         1unX+bLkQZve059MlY3yXbfZ45lv3ZQszDZj9daxJ+tt9EoCR+bHdOdBnNTtp8W7VVPU
         vkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431756; x=1784036556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1TwL3+aqF7dc4/lpQ2JLA2uoetuIwHkPHzHxzge8914=;
        b=hCktv9RE/j2xOgVWybWlf6viC+sjgJCvRrbP9W5NyFifZ+2tXG39JYIFuu7HWCpH6y
         Knbfq8Llezrseh+9gvYjhLf75h1sUomCjYvU18vct7LL+Zp9KWKK3KhmQn5A3nIET0YS
         p4Iy33kl4YIzFMDfmhztVmoZWQM4urpvzs1FbDp4EMUbjKRR74TOMNv3khxpmb4j+Uo+
         B96rfzp4a0K6GBW6wOHPdmpQXHrHhr7ObRNPcentD+3CtDZXGtvHLM0J0Dw6m/2Y6x+v
         FMvh/PC5sN829HRDzMGaifDQi22YKZrxyIW+EyLb0NLSGs1EiYZwC90pC3EAccoXFXXy
         s6Ww==
X-Forwarded-Encrypted: i=1; AHgh+RqRht6g6fCrwmsulGh+DvZMoZCjf1CkKVJQkYD81UHPqhesUCWV/BQZqkVOqzKAHePwMDeqHg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMlIjrJJBN+uNcgB/7zR7TFWcw+7+KlvUS4JMzbKcoTxms1gXC
	rXkdp/Zq/OcdPcia2LBodDe2I7FoKbwIGYKMBSfq8fYVrOHav+jzHw8OoNE1ZvqyWMhjpADrxAP
	PMcjgVzDBmpMlAE1KSw64uDezZTWpZ4k=
X-Gm-Gg: AfdE7cnaf/PjzusZHLUhKo+zZEjrM4v1QJJisOPyuh30FdlLOGRCSJ0TRemoI3HiLca
	IFkgBFOJSz8LP6NjMMzx5BDfi4q/oRE26fMziQyOUd+QSbICPzwbT4VGFCqmJc4tZ1SIDnX9kbS
	FpLS2YdcuuaMgdArUEzHPIikikFq6Bjpti09xcvU7WJmLiinied8GyLk8zsZuw65kJwmgJupGPY
	+lqU6mUrAx7iQkVt5CkatSeocMpke/PKd4ZTV8R5F662xVEVNX7wHKJgcRiZle7vKXxTofs21KG
	wgU8QQebn1lsBQ6meOpYTYz+U/CK3j63yqwwwdux2osXwrRCJqiLPTDS2Qbvzb/s89VfMnpF
X-Received: by 2002:a05:690e:488c:20b0:664:d231:2f73 with SMTP id
 956f58d0204a3-6677fbd4331mr2922458d50.50.1783431755730; Tue, 07 Jul 2026
 06:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-5-506d936a1707@gmail.com> <e23e4581-7eee-4f4e-aa82-6b6bb6177678@cyberchaos.dev>
In-Reply-To: <e23e4581-7eee-4f4e-aa82-6b6bb6177678@cyberchaos.dev>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Tue, 7 Jul 2026 23:42:24 +1000
X-Gm-Features: AVVi8Cepx_g_efgo_16NLDYw5eSOtcfEnI_otyB3OoPCUn9_yzRFa4EgaystrR0
Message-ID: <CANpmGNtnZo20nPyM4qB7Jcty=bRFsxsDWnAOk9Md6Y+Rd9n7ZA@mail.gmail.com>
Subject: Re: [PATCH 05/10] mailbox: apple: Add DockChannel FIFO controller
To: Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, iommu@lists.linux.dev, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 6:14=E2=80=AFAM Yureka Lilian <yureka@cyberchaos.dev=
> wrote:
[...]
> > +             while (block) {
> > +                     writeb_relaxed(*p++, dc->data_base + DATA_TX8);
>
> This must be writel_relaxed, as writeb_relaxed in this mmio region will
> cause an SError. This is why we have separate addresses putting 8-bits
> and 32-bits into the FIFO I guess.
Ah, thanks for the pickup. Sorry for the silly typo from me, must have miss=
ed
it because all the HID writes are 4-byte aligned. Will correct in v2
which I should
be able to send out by the weekend unless I get busy.

Thanks again,
Michael
