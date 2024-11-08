Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3836126
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053283; cv=none; b=CHW83UFAPDpEKm8DyxNxXXjI3hEIXSYAi1ZqcRBb6wLeElZhwrT845CDJHYi1jyACpTMkBNmwBsg6EztDbxo9Mm6DrstRV/eAzNzssGdn4h4F20a0Cg+twJq7u/F5kUKFHWGcUvMGJialrKxLpBwGEYw+0OmKpYQzCdG68lkS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053283; c=relaxed/simple;
	bh=BxCAif6wBpfReu8TvZw3mVT33TIGWApsV+3A+vA2nTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SlJ0TG0DkZCpg/Q73k6quNjLbpj622RXajeXlgRw/g4YJIn7fqYAzl8bAntEPisZR7d6LrUyxosqFtBpTSHBhaUepM7Vm/DPvphmTimjw3HZrA6aA8cvdv9+SAxSkSRbSXpdwlmg7333kwFZVd4MF1KjM82YP+Fj1faI5RU7YJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l/Aw7CdB; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/Aw7CdB"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso27161231fa.1
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 00:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731053279; x=1731658079; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxCAif6wBpfReu8TvZw3mVT33TIGWApsV+3A+vA2nTg=;
        b=l/Aw7CdBdg1ZwZOKdzKoGSIsKR0WvFxfo/BQxPySW74PBULfqhx8e3gtj53l+lPn1i
         JimKwvUCf82A0j9V/9APfSxoKvWzSjq88vds9p3rTkYSUByzLEAAwE3cvj33vVfrGErV
         T/HwyfBaLeBnqgA82dD9Pf0NuDeAl+/TokQP6sTKgJ+UOlA8LhHgH4ZbN/dayTR69kzB
         T+D6u6rtYJNPrEF2Mzhz/rmjTZJPUHB4dP6f/TnRWa3AO9gjvz6QfF0rwSdm7aE2JxRG
         /1W4lsHojepie6L1N5ZqVGAFrUuiHV4QtQbB7qFX7nFkI7vbxK/6+CvenF0dxdyyBSUC
         4qlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053279; x=1731658079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxCAif6wBpfReu8TvZw3mVT33TIGWApsV+3A+vA2nTg=;
        b=QbCxnk6VKfRPJTWGembXmtSwgoRIq0Z0AP98iqG7FSHOHpjFrLrg1VOPigvCCtZ6mj
         UeutTcm/0Mlh4Qpz1YhHqwG+ULgIvvdrLt1cKCnu6hkRa7Qyt+/2UZsVirMyJzriPcjR
         HUVbiRYddLl4o7O/iNIEkcphzIwSaRPbuYVOPZGAqcjhtM4519LJkQYe83Ytuc2DTQd0
         c4ICJV/XF0kKSr21RqnOtEzapuwS/hZGmrgYsWygmdABW3KBB88w2pVFg1hW75HKi2LY
         XVUy3Z3ha7VD9DPHQHNZvzaNyFN6Ws1HJT133UAGL+rgZEXrBK33s+32RZR+8/LHtgd9
         w+RA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7TzBIdwfUf00/nVPaGLX1t+FwLaC8AVJ5qnBQr2h060QrH3gK4VBdxWVuVjuMGymEKyBCw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMUd7ScUPIGym9MESGFlPUBESuYmDkP3bNLHnYp+sVtjB0TFsX
	v/ZyovwtIrAEcaIdDI6tcsjFwGeDvWJYT9kMylDSMQDyh4+emhMgjQ5WVLWQlPD9mvLe7ZPWL5j
	ZwJt/kgsr5C29IBly4NqKKMUz9l8ulhBzAeAulg==
X-Google-Smtp-Source: AGHT+IECFYZgmqXq90uc6fU+GhsZFrNHgfgkpCoMfSI20MKSS84Aidx6qe2DptwPr7H2EP4ELmSvQSeK05aPSJkA+5k=
X-Received: by 2002:a2e:a10e:0:b0:2fb:510c:7237 with SMTP id
 38308e7fff4ca-2ff202c3c9bmr11587911fa.41.1731053278604; Fri, 08 Nov 2024
 00:07:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241031-msm8917-v2-0-8a075faa89b1@mainlining.org> <20241031-msm8917-v2-2-8a075faa89b1@mainlining.org>
In-Reply-To: <20241031-msm8917-v2-2-8a075faa89b1@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Nov 2024 09:07:47 +0100
Message-ID: <CACRpkdZJmetNUHhBOfoZuygEXW7VO0Go2bmngxciVeOoyzVaxA@mail.gmail.com>
Subject: Re: [PATCH v2 02/15] pinctrl: qcom-pmic-gpio: add support for PM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 2:19=E2=80=AFAM Barnab=C3=A1s Cz=C3=A9m=C3=A1n
<barnabas.czeman@mainlining.org> wrote:

> PM8937 has 8 GPIO-s with holes on GPIO3, GPIO4 and GPIO6.
>
> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlining=
.org>

Patch applied for v6.13.

Yours,
Linus Walleij
