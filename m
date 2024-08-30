Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627611B2ECF
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029096; cv=none; b=csvKFWy7+Ba7Lqv2oTQ/ExD4ND9bKlrSWg62sIEnZDjOcqqtXtLRuowDFmb29szoj9dgZv14zYgsX/ArFgNhKt9+2VyJG6jdTLSd0GEV0vIihnV8E2F31RoeNbg4nxpDrED2B8lS+uqtdku3fALjEzwx9iCPJD+DU6FD0Tt6pqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029096; c=relaxed/simple;
	bh=6f2WgrwM+oBYMEbFA/A5ogXzYsctqgEAAF3bpBkOzoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0+8JWN6f2jlfnE/CKfxCUwLg7427Ll8/09EnwO9VnUlAE6l3Ob0qAT8TdzG3KJ8UqctI97oIjWXiaWO8EQL+TyIs9+OEaXeBy0bsLdt9JAvi1DIfu5IvgAcPljdJBUbcMmJiK5wAzTD7NXoNY0n1PT+FAtmNO4YeJpVe+mSa6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8hU75Rq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8hU75Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B751C4CECC
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029096;
	bh=6f2WgrwM+oBYMEbFA/A5ogXzYsctqgEAAF3bpBkOzoI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X8hU75RqiVjleNV2CmnO+SkF/2Gn01NxdY0DInl/ArQXvSPxnVAj8dDUcEFMn66zY
	 +3mmWMmWZuwLV241PoaoXTaVJN6okrGd3xlKS4iiQht/2gZ+1eTIyGBx9wKZXvlFGj
	 3piz2KI5T5BE8Udz0v/zWytv1bJWYexgTAtDXUMV7dcCSEhWaBr6Ymnh52s7xOCWi/
	 Rzjurj2cPgwlqVqTjF29w/qxo2ErO2qxkd24o/C9u7tWMTtApIvh7CqiRO5LgTiebA
	 8qN3SyuOnxabblpMgVOvpH7hOYdVFa/2TWorxZVq+PRS7XYrxC5gzClsWNBrdcaet1
	 WKbMGJrZBR2WA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f3f0bdbcd9so22445141fa.1
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 07:44:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfdqz0vdnnOtxoG7GNpKl3gT0pdqfhQjS8OdZ7Mwl9hNCOGqDH0RJ1xI8SWiefHuX8nCww+Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO61gIDQxiimtJlZXIgCFEIwWvUalRm++WjdqE1IbMJRXdYCpd
	5M7eqcsbMEQ8ZSpi3Nlal+6aWeK6gZU+6JSt1VPsg9hojxeuuSJY7gf6i0FTtqGFO+eTCLlTuLZ
	6JUN3xXvyHDnkrOk2DwJJbDl02A==
X-Google-Smtp-Source: AGHT+IHNK+9MXGVAZLBYt9qXZDqL92+9Mw4J9z0N2JZfmchRYYjKoFr1fQ6DbSfpa5bXY7t46hBzKKVI680zgd+zxWw=
X-Received: by 2002:a05:6512:2345:b0:52f:c833:861a with SMTP id
 2adb3069b0e04-53546bb06dfmr1793360e87.51.1725029094340; Fri, 30 Aug 2024
 07:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240828203721.2751904-22-quic_nkela@quicinc.com> <20240829185240.GA914553-robh@kernel.org>
 <de0c40c2-3627-4c63-9112-4eb13cf75c0a@quicinc.com>
In-Reply-To: <de0c40c2-3627-4c63-9112-4eb13cf75c0a@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 30 Aug 2024 09:44:41 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKS1pB9GMjEwji_XO_DmrKs4J6GkcxpRkUqcAAHwCseQg@mail.gmail.com>
Message-ID: <CAL_JsqKS1pB9GMjEwji_XO_DmrKs4J6GkcxpRkUqcAAHwCseQg@mail.gmail.com>
Subject: Re: [PATCH 21/22] ARM: dt: GIC: add extended SPI specifier
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	herbert@gondor.apana.org.au, davem@davemloft.net, sudeep.holla@arm.com, 
	andi.shyti@kernel.org, tglx@linutronix.de, will@kernel.org, joro@8bytes.org, 
	jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org, 
	amitk@kernel.org, thara.gopinath@gmail.com, broonie@kernel.org, 
	wim@linux-watchdog.org, linux@roeck-us.net, robin.murphy@arm.com, 
	cristian.marussi@arm.com, rui.zhang@intel.com, lukasz.luba@arm.com, 
	vkoul@kernel.org, quic_gurus@quicinc.com, agross@kernel.org, 
	bartosz.golaszewski@linaro.org, quic_rjendra@quicinc.com, robimarko@gmail.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-gpio@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, kernel@quicinc.com, quic_psodagud@quicinc.com, 
	quic_tsoni@quicinc.com, quic_shazhuss@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:02=E2=80=AFPM Nikunj Kela <quic_nkela@quicinc.com=
> wrote:
>
>
> On 8/29/2024 11:52 AM, Rob Herring wrote:
> > On Wed, Aug 28, 2024 at 01:37:20PM -0700, Nikunj Kela wrote:
> >> Add interrupt specifier for extended SPI interrupts.
> > What's an "extended SPI"? Is this a GIC spec thing? If so, what version=
?
>
> Extended SPI is an extended range of SPI interrupts supported by GIC.
>
> Excerpt below from
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
>
> "The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
> interrupts, 2 for interrupts in the Extended SPI range, 3 for the
> Extended PPI range. Other values are reserved for future use."
>
> "The 2nd cell contains the interrupt number for the interrupt type. SPI
> interrupts are in the range [0-987]. PPI interrupts are in the range
> [0-15]. Extented SPI interrupts are in the range [0-1023]. Extended PPI
> interrupts are in the range [0-127]."

Looks like you should add EPPI define too while you're here.

Rob
