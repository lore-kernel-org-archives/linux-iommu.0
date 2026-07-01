Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909034CFA7
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916537; cv=pass; b=VT52rsT+W/rsMxhO/8OmJds3K5lw/ccSeZ6G+kzgOHOftK3/RNIKJZv6GyTC0V1NRw43RJnTr9eq61GLtxL02GN5xfmJ/riqw15zn7Y+Q+ul3BoB+cUSG1R6F+vb1sqd/eqZvHfiW5wH1z+Tq9zMBt3zrE+fX1GlJIIfiqH4xn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916537; c=relaxed/simple;
	bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Je0vjiTtaimQsxr75RgLzH7ygPj532PwhM4Ut1BLFBmkemYcwLeMIYH+GxB7Glj9g/zygtop/ihnYIMQK0CmK6xczcnKHp4A1XB77uvvrwLgHnjuQ2thoCE5NBjTRl0iBKCgI6kvkneEWARB2kI0xmKKvJhCpz4PPb3zSJDx7Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD/U+d0G; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD/U+d0G"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664d22d7337so655529d50.1
        for <iommu@lists.linux.dev>; Wed, 01 Jul 2026 07:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782916535; cv=none;
        d=google.com; s=arc-20260327;
        b=W8vhbMjF3sRz912WbdbmaL+syDphak+0TGdEGRvjAk9YrjxM/gJ9fgjlh7Bmm9TO/k
         cl6u2GZBZIoPOdlU1sJmSLRt7oT2m8INgw6byrQzSQEO1ZFgCwypMuVAtKDDhf6ngAV2
         yctXKkjK2gOu9iLvrv2NqZjHVGNfJrfAvgIxy59p+23IPWu8H+083LTyRQ2xp7oDkJFf
         RiSYG21pOloyvkQg3uzIsbAVgjuw1ITOnwoPVkpfq0Dk5R3bb6NpAXWcoGrG6i+BnQZZ
         iv6sAWMkrNXbLQMFNhvcvnu0v9rK4mLyhQzxoHfUT9HqzwLbsmZsYmxoZVPra2v/yvGU
         KJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
        fh=mf+2uh/XTltd/P+9+O2thgAB7U4yEHtagFvg0uu3Uyo=;
        b=DNY/N6vJZKxf5/LmPsCIA1EIv3qXmK40cSFUr4C8oYhzAOBQ9QuDfiQa+l09WGeUMG
         z2QyccIo46Hx1h1tJEXkOMbhXDmffOT0NyzboQHpFPwjp815qg2PUZr0nWeRRkMkyAH7
         NwuwEMRGoY04yA8n9ako33EptdAYz1bgXvfxkNxtyy5OAt58kZvsb5i0Ff90OM+8WOiH
         XHpGZ2nPWO8GdJZXJoEEHxaGgoghxJ705r4ccjs0EaGYFj8cqscWHW1t+RWL4Xqy3wx7
         D00ki6R/zb/CD66fmBzU3Oedh4yfwzg+GSkKMIvZ7dvcYXumqLVIJO8WjzOzkkqf7IYA
         U3uA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782916535; x=1783521335; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
        b=KD/U+d0G5HhKpv8bojdkXbPOaPbGR6bJpq4h7KvReQb3mBVyX23j6JTh+xkr8/Eck2
         ATDJLZUYqAve/rjOfLG19UOR1ZVLqacj0YyNvx98P4aO6sw3i1wSZ8k/djrnTqXtLb7I
         EUInlkMPw7p2jgwjlx8bwglAlNumRjiwM8XV8eSbhvNfRHjOlV75y+yZj/F+p9nCpbcK
         v6qlDK8GjNn+OjNSvK7MQuhzAE4QS3l2OJpyQ5W+Jzli3ewcxgy5z7EQ5LNyTiBO0G7C
         Sr0q/4Y8lhD0i/+mCLFHaCJUR7/AZyuSKDAc8Vuk+ePFaNt7B4F94bPcmWfDUCb1E/PA
         DrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782916535; x=1783521335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ITer+kkk4mMSsWxMyfWrD36+FmvMAHde/cCZgcgLMa8=;
        b=eSGxwH/fIRM8e1uL37VU4h4AWnQRQYbN7VABWvlz72mP7E0SOWc3yXV6llb43scyfw
         A2lqsIZtoBmULSHTpZL8UZPhULnugY7vTr0yDlDiZqpsAO+hdTSR0NUn0J06VjJMAzVz
         1ROcaIrZaBtJmhdepv05dxyfDRDpHqQx0MfYJRxAq8GAj5McORjdEsMbe8vWT2iPCOHC
         eJppCqQvPl9uWxLu9RAr9xs2XqOYvGd8IatHpcPkx+ZU8DWOObkd8iPeZZlQNq/DWm7H
         UoN7d/ynSx14QI/vLNQQknbXqxlpk7M6lMqtBmNsW+uCTGdmGUgMnHT2ZdbRd9+BpIX0
         hVxA==
X-Forwarded-Encrypted: i=1; AHgh+RpXRLX8MCfsBTttqmnfRVTekvezFpMP1/r0bgJz4ZScMbZVzB8TcyfrIIAHMrJS1bjDg0/V0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZQsEIHButZJKN5agg6H3QLDzHdp568oxfNF3Q9GhMqki6Mjmu
	D1oRw246olQPPL0ddvJ/v8cxmPSm0xxXsfTDVPf70nDn7wUoCHBPKXPhD0WSXR2xPZQMzqhD907
	q0QaLKDXalP07Ah0YxIZFK5KRftU7aOA=
X-Gm-Gg: AfdE7ck3x7A9nBH8CYS52RuuQz4Vz4Mp5I+wyvM75T1gun+h3V0Ffi54C2rEXtszKUP
	kHrmTYJgCqDkxmoJLLSwJzbTIn8VZ8fsxzGh+BY6oDXe2CGX1J0yyjwIZKjvjqiJHzFC9RTtRJF
	0Z5HBC/ZcHA56iDE3VGAHRgBbFMY3+Omwxu+GCKjcVbDEKxsaDUSK7AXfdsIYuo0XToUAq4/Mp/
	dG5N31jUevnZgRHIrgE9oHr+PrJ/Sjryd9CAlPuIRUuzrebdDdx5hVkaNfPr5hMveUxqKlmnkzr
	VE3/stfDqnQhkXT7QunLxaVoimzsMiECZfNQIEhyjIAL0Xb91zx5Ecc9Ug1VmQ==
X-Received: by 2002:a05:690e:400a:b0:664:d5ff:2845 with SMTP id
 956f58d0204a3-66507a15364mr5289486d50.19.1782916535159; Wed, 01 Jul 2026
 07:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
 <20260630-apple-mtp-keyboard-final-v1-2-506d936a1707@gmail.com> <20260630-tattling-pacify-3b990261b8b5@spud>
In-Reply-To: <20260630-tattling-pacify-3b990261b8b5@spud>
From: Michael Reeves <michael.reeves077@gmail.com>
Date: Thu, 2 Jul 2026 00:35:23 +1000
X-Gm-Features: AVVi8Cfa1dzp-N-jQ1tztDZshofJ1mjnAsJpK28Uy4QoNy9Qd76BAukQRwwA8nI
Message-ID: <CANpmGNtq96uJzbPRLyDG9Qq3hPVGA3yspk0-ezAdD9PUzj0gMA@mail.gmail.com>
Subject: Re: [PATCH 02/10] dt-bindings: mailbox: apple: Add DockChannel mailbox
To: Conor Dooley <conor@kernel.org>
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

On Wed, Jul 1, 2026 at 3:07=E2=80=AFAM Conor Dooley <conor@kernel.org> wrot=
e:
[...]
> > +++ b/Documentation/devicetree/bindings/mailbox/apple,dockchannel.yaml
>
> Please name this file matching the t8112 compatible (since that's your
> fallback).
> Otherwise, this looks good.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> pw-bot: changes-requested
Thank you, will change the name in v2.
