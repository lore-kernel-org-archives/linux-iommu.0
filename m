Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2626C1F17C
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 15:07:06 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso8051882a12.3
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690297624; x=1690902424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZUa3uDyejgNax81C3rf+wIL3cUgqBQKB2P7I+aBclw=;
        b=Uf29Nyg7xnRg63yyxfx80HjEG6Br0n/5nlnoDN7RuMqIxIbyLEElRmiCQpDx8aW12B
         qJdMhW2tLGVP3WwTW/U02C6SUEc8UzgtauOUwxQp2mAX/a9ZdRUbbmww10esmusvJ1v7
         KpckzVh9aqCjKaIKdKBsZw2e8hYJ0KtlXg2QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690297624; x=1690902424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZUa3uDyejgNax81C3rf+wIL3cUgqBQKB2P7I+aBclw=;
        b=j8mpKEIygorMJu8URvuuLrjs/WKPuQPHzxuMUJx51H60B4mpN44ssPuOf/cmWyhp5s
         g2rQ9/wpnBOyoCNrB9fyKbZiYHP81qs5XlU7gm5QgaTq/TkGdc3IlxOhLYJ7f+7sWbBI
         cF4rBDKl8TvD1rM20hVcdQUuLutRQ7iutcRyiWJVlcvw2IgkbCouKxZORGf++L5+J3A1
         UrzVQfRCLUT9yMApqNqBq3R+tbsyBQITvKL99fLK4hxAs+0yZsZCmC2ebogZMljfVy2m
         IM6c+/S0STrwzE3onPRhmeQJexZ8n0/kW0tZMM4abiaTQTLoSjj5yaZgjRys4iOcrEWR
         z1jg==
X-Gm-Message-State: ABy/qLZfh6CO78yn6TjeU7tNHJfvfJeT/KmUOKz2Y5Chtn5sb6EjF8yM
	ntZtRyYEZwubzPJk7El6h5/DZA6slXOWg1Zm8zVdJJTu
X-Google-Smtp-Source: APBJJlHx1hIeTGK8MW9czcdjRZsb1FUSQCh67CQ4aeGp9QSDENIqXFmdCX6buZXXgO3KN9X9trJ5Nw==
X-Received: by 2002:a17:907:77c6:b0:987:498a:87f6 with SMTP id kz6-20020a17090777c600b00987498a87f6mr12270821ejc.34.1690297624446;
        Tue, 25 Jul 2023 08:07:04 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id z3-20020a170906270300b00993017b64a8sm8291478ejc.224.2023.07.25.08.07.04
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 08:07:04 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so13751a12.0
        for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 08:07:04 -0700 (PDT)
X-Received: by 2002:a50:d55c:0:b0:51e:16c5:2004 with SMTP id
 f28-20020a50d55c000000b0051e16c52004mr113153edj.6.1690297603084; Tue, 25 Jul
 2023 08:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org> <20230627-topic-more_bindings-v1-1-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-1-6b4b6cd081e5@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jul 2023 08:06:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WsWyTWk8W23PEgw7vXWpLDCih1kGZHkqYCNHLFOPrkGw@mail.gmail.com>
Message-ID: <CAD=FV=WsWyTWk8W23PEgw7vXWpLDCih1kGZHkqYCNHLFOPrkGw@mail.gmail.com>
Subject: Re: [PATCH 01/11] arm64: dts: qcom: sc7180: Fix DSI0_PHY reg-names
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Benjamin Li <benl@squareup.com>, 
	James Willcox <jwillcox@squareup.com>, Joseph Gates <jgates@squareup.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
	Christian Marangi <ansuelsmth@gmail.com>, Wesley Cheng <quic_wcheng@quicinc.com>, 
	Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vincent Knecht <vincent.knecht@mailoo.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org, iommu@lists.linux.dev, 
	linux-usb@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Leo Yan <leo.yan@linaro.org>, 
	Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 27, 2023 at 9:24=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> Commit 2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI
> nodes") broke reg-names, possibly with search-and-replace. Fix it.
>
> Fixes: 2b616f86d51b ("arm64: dts: qcom: sc7180: rename labels for DSI nod=
es")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index 34eff97f8630..b9640574e73b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -3120,8 +3120,8 @@ mdss_dsi0_phy: phy@ae94400 {
>                                 reg =3D <0 0x0ae94400 0 0x200>,
>                                       <0 0x0ae94600 0 0x280>,
>                                       <0 0x0ae94a00 0 0x1e0>;
> -                               reg-names =3D "dsi0_phy",
> -                                           "dsi0_phy_lane",
> +                               reg-names =3D "dsi_phy",
> +                                           "dsi_phy_lane",

I noticed that this patch got applied [1], but I think it got put into
a branch targeting 6.6 instead of 6.5. Specifically I see it in
"arm64-for-6.6" but not "arm64-fixes-for-6.5". Any chance it could be
landed in a "Fixes" tree and get sent out sooner rather than later?
v6.5 will be pretty broken without it and it would be nice to see it
in Linus's tree sooner rather than later.

[1] https://lore.kernel.org/r/168896565982.1376307.13166434967387866925.b4-=
ty@kernel.org

Thanks!

-Doug
