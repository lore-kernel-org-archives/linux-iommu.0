Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3D1F9F4C
	for <iommu@lists.linux.dev>; Wed,  8 Jan 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340972; cv=none; b=EhLV43lgL7GA8XKk2jF5+sssUTTWrtfhu+f4CemtRuBOB4aEcOTNJfXAho3YsAhw8KPn8NRntI0T1TK2M+zmeV5cjPxY8uE7pAmmteMwEvOhPFkd3z/X4VqKnktOyXHIV7hXbzljWN+UtU0kq/FN+10KASvbrsO+S4q7NQ/RQ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340972; c=relaxed/simple;
	bh=oKT7Yz8DLH/KDqfm87YOoAHzlTdU3CIV02cT2d0S8zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aWlh6aC0ZGo2QpGSk45FduojpzbpQ4G+hLobZR2aL0i/fcaiMwoPFRhL1fZhfJDy4h1QCWk/+I3wFL6Q+xqme7+ZdYbkLaE29toNfnj+iJp6+kDvMMs1n9Pljzha2UyQ6MeOnPuCZNxqrGFCKQqXJXEtSD0Tk7kg2Dc6hTqt7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85b9f2de38eso3013054241.2
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736340969; x=1736945769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zr5OAgOEPPZiSNcmjwmBPGqoc39w41Bm0SLcztepzJA=;
        b=ILFRnAMQOjxrVH7yq7N/Tw5BO6PHgGDca9xTunUfbEiKV9TuDL+uch/P9zfgquqrIU
         AZ31Qh0FrJeHp+sYMyrG5Wwdrb/VlkwgpVWH5AYGd2Xk6rbHz3MqH55m10x8SufCFTUG
         4fMB2/4Pbh0r8og6oEkFSjVU7CKUICiXJunrnkXV9uGf2Hdq0g9hX0Brsjn1/8eqj4lI
         FGP9ii5fMFHfdpnCAE5oJHgXMofRWZD9Htn6siET0kocovCDc1ZxvXJuCVh9T7bKjQCt
         oaXV3Bxh1YPl7msVBmy9aaume028Q//c61S48iBuEqRSMea58r/2BteW+KI9OIvCylSx
         mjEw==
X-Forwarded-Encrypted: i=1; AJvYcCUfEN0KiFvQ3/Ft1rUsLkrV8w2NUlrn7Ol6aFt/iRgl8YXzYIFuEEHni/nzdEZPDO1axRvqeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxRw/3d3qhO93SyA+U1PKToPtHvE4NCA5NYwMEcUQpN/hktcrZ
	UZf136w604/9VahfpAmtZEJFap4ctEuzx7L38AAEcevuZ95vegCUzFF6RzOB
X-Gm-Gg: ASbGncsIgZE8H0P+F+7mIjK9AyXhqa1SEZwAKcr86LcKR6jAD/SAU0HRZpjkHhN0SgK
	x8/3wlDjYADcMAAB8r0lZNps93Tf1dfAyZ0JDUuMM48X5PZ/6xz3Dk+5ys86gpS14OlwwgwQ/Gh
	37wK3FanBMRToU5MymYY4P7f4eDiJYi/gIRKz2RkTulLawQT8yrQTwaqNRUaM5WSjqBQDK5mn3/
	6HXq7Oz+CR5jAGQnZd7+oyaXaNEn5fFkTcmGfP9T6fArWXHsBHKE28GeAleIr83UhJYEgqV70IW
	EzfYgEvVRS3prtl7uqU=
X-Google-Smtp-Source: AGHT+IFDXTOXGGJgyy1jVeYkY1XxZgHn+/fp5DXevT9GeF7QLzREdqjwaBFdcbJrSUUrZzPaSFaoKg==
X-Received: by 2002:a05:6102:3ca0:b0:4b2:5c4b:5186 with SMTP id ada2fe7eead31-4b3d0fe692emr1660846137.23.1736340969426;
        Wed, 08 Jan 2025 04:56:09 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ac6df78sm8578143241.17.2025.01.08.04.56.09
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 04:56:09 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4b1279ca1d2so4396150137.3
        for <iommu@lists.linux.dev>; Wed, 08 Jan 2025 04:56:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVGTfAuAkrAPi8Z2HYq8c2afScY7WHk6sbOy4I0HJhQmVB40botDc20ym+y2PRCADl2vOgjRg==@lists.linux.dev
X-Received: by 2002:a05:6102:5123:b0:4b2:ad82:1318 with SMTP id
 ada2fe7eead31-4b3d0fde32amr1732752137.26.1736340968977; Wed, 08 Jan 2025
 04:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250107131456.247610-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250107131456.247610-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Jan 2025 13:55:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWjRu8AnCei67oBX-eR6RqD6m11SbH6mRmpjD2sfTtFzA@mail.gmail.com>
X-Gm-Features: AbW1kvZ52DN__RR4vjE2dLHCl44CSoj_lJNsAln_Gci5kCuBVU2sP3BZtvvNBVQ
Message-ID: <CAMuHMdWjRu8AnCei67oBX-eR6RqD6m11SbH6mRmpjD2sfTtFzA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Correct indentation and style in DTS example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-leds@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 2:15=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
>
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>  .../devicetree/bindings/mmc/renesas,sdhi.yaml |  78 +++----
>  .../bindings/rtc/renesas,rzn1-rtc.yaml        |  22 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
