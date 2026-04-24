Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D33FBED2
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063699; cv=none; b=VoFVMVL+CafkoK/hs9Eu40BglkrPo5BmzwYGEFGmfhsFScriPIz2Lx2mr4Vfyrs+h+XV2z6v2NGYnEXyCduZ+l2/zpZBTbD0F093SGy9M6PJOg2YMe/I7fkVS9z+y4DYRcb/16oyjBNXUgPNGnaFASZN27X3BBlNDzwJF2oYFyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063699; c=relaxed/simple;
	bh=0boLH8hWc2dXkhxszeQy6lSGDQIbpwqKKGbmn8fEX2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU82BZQ/ECqTM2NVTJQlPsjnDMAQ2OzJTbU3fpUExjTp/GwVBTwqg9onX1w55wId2CT0CVDmWkwJRBV1QNM+Kw6vRGcUhXwvuI+8Ie8174tQ7kECqwkE97Fv/Dzv810EB2HSiMZgZO015yKdqyz2lMOiNjY+9U3xuoyTh5pvo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiAF+I5R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiAF+I5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B4EC2BCB4
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 20:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063699;
	bh=0boLH8hWc2dXkhxszeQy6lSGDQIbpwqKKGbmn8fEX2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TiAF+I5RqpU6/3gkqIvpr3PX82e4NbyOw55hHZqWrDFdzu3gtTQu7vkDFPWEKv9wl
	 ib57LMFwSFZdPwCZlqsQMt90WiZ1j587RV3+pY1B2RuziYz79udO9ZLq8+r2R4DICC
	 hxjEJr0yH99IqaBEkpDSenp0KLcVF+59ExE1R/uDMCOjZKQS03nr5UeSD6ff4n7Qu6
	 23jkQnMmfuuMPFJ+gwxpIeUNult16TaLKAkD/xCa0X0vO6+HGfViMeLG76I0WLMBOt
	 nJxq8cTJhLJqLk1kq3l6a3nWb822IrB7J1w0q4EfII+3I6uOXzlcCQTq1fEJeOd7c6
	 Bb5oZmJ3VCMoQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dea72099eso8739778e87.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 13:48:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hnrpGHkE1dd6Jdant5yh4yH+EKDwmKFRvqL/K+uP/1soCbgk63mu4YRogqAMWPnJecIbBRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzh+VT8z7VpaIpnbu+q6jW7S7yb39vPK+FRIHX5wMIcKjLIYOnA
	WvjcSm7siK4krUXnVtrSvEsxVFfnhtz7Oh+Uyqzfn6pDPGT26dX/cMsRToOiFOjNzUkQrtLkpRm
	mLVFxwwYY1isZVQ9r9MdLiAR5FgtedpA=
X-Received: by 2002:a05:6512:3981:b0:5a2:c4f1:2635 with SMTP id
 2adb3069b0e04-5a4172e307amr10148193e87.41.1777063698385; Fri, 24 Apr 2026
 13:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421-mainline-send-v1-sending-v1-0-bcb0857724de@alex-min.fr> <20260421-mainline-send-v1-sending-v1-6-bcb0857724de@alex-min.fr>
In-Reply-To: <20260421-mainline-send-v1-sending-v1-6-bcb0857724de@alex-min.fr>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 24 Apr 2026 22:48:07 +0200
X-Gmail-Original-Message-ID: <CAD++jL=O75u0r2ZaZSxNhTYByY38GDXvpsW8HyjW1f9gh2+KjA@mail.gmail.com>
X-Gm-Features: AQROBzB16qsj3GujL8b5ZQZQVOXOMFbhR3ha-RvGHxlKIhb-Pz_tIyFGs3LtbMQ
Message-ID: <CAD++jL=O75u0r2ZaZSxNhTYByY38GDXvpsW8HyjW1f9gh2+KjA@mail.gmail.com>
Subject: Re: [PATCH 6/8] ARM: dts: qcom: apq8064: Fix USB controller clocks
To: contact@alex-min.fr
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 11:45=E2=80=AFAM Alexandre MINETTE via B4 Relay
<devnull+contact.alex-min.fr@kernel.org> wrote:

> From: Alexandre MINETTE <contact@alex-min.fr>
>
> The APQ8064 HS USB controller nodes describe the transceiver clock as
> "core", but the ChipIdea MSM glue expects "core" to be the controller
> fabric clock and "fs" to be the transceiver clock.
>
> This mismatch can leave the fabric clock disabled while the controller is
> accessed. Some boards may tolerate that if the clock is already enabled
> elsewhere, but it is not a correct description of the hardware.
>
> Describe the RPM Daytona fabric clock as "core", the AHB clock as
> "iface", and the transceiver clock as "fs" for all APQ8064 HS USB
> controllers. Without this, USB does not probe reliably on Samsung Galaxy
> S4 because the fabric clock remains disabled.
>
> Signed-off-by: Alexandre MINETTE <contact@alex-min.fr>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
