Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25B3FFF
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 07:20:25 +0000 (UTC)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-45f10f5882fso1177702e0c.1
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 00:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686036024; x=1688628024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aznv3oFTVvxn0OuZbUQcyVpvGCRIQmh+X3GwU5kUzcI=;
        b=pqCnRJRCwqhZlMoMMHMibVJA/xuevTSeutUDFwF61VwL8ko3pMujyGCyCSRM03bNMG
         9APZmZJ7/BQKGYe6TmoJcceN0HImz62Nb0KcRrZrpii6MSpie9veyWq9j5rcqmNQwbFK
         3OKktcRQEDsJM8Mk0z2zsIU+0IA6VP0KawfyhzlaVuqQnE48r2cnCmMcwhhcIQ2iWp9b
         +lCBsJGng/U4AlbJFP9Finf6omnSqSrzyynY+TaMN+TBC6Xmc4zdehjhizMoGZL9claE
         rrnnCmQn8wuvjaxz8/FWh3GHzE1DmE7gmGajaXXkLewaiWiiBmJoyoDo44kChVjVJt8C
         T/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686036024; x=1688628024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aznv3oFTVvxn0OuZbUQcyVpvGCRIQmh+X3GwU5kUzcI=;
        b=QlBNl8IW67GLrQpqccgiik/NtXjTkvJ12fZKgZbfHBFXUfc6bhrCM02fIVNj8UEcli
         q5TtKUKpVkMckO81kMCHGNxS6Y1+KtYXYiJohEyxyuJwosqIV0JQW2dM2+QXxcHWOikS
         UBZ1wydlHuhw6VjprV8o98zBEEgDk8dnFWPnL7wmqVY76xNyZR9JO+N6fJ042RktjEG8
         evZeDixgxB/xqHCFzbv2yMyX1G+AxUg6McTN4y/qsVVWQzB18AhANEauRj06YbGf7LCV
         IgeaB6HZxzjQ0hCxkggMO5N0eckvxKnFGauICA5l66FbL+3zKJCBEyCgFulxsZ2vwtGp
         46eg==
X-Gm-Message-State: AC+VfDwntjDjDPb6RNcYbrOd2X5U7a0Gj/njQyWhURil1o/0cLzKMJxr
	gDKdIQXju9LuuMoGRLzjpxk5Cf0WRA63ua/TwkUmOQ==
X-Google-Smtp-Source: ACHHUZ611b6fh0JRo/6OzBszVFi42muiyHcQzpD7oR3k3oIsTKXQ7ahb8V/9G7hauPfbKNUFBwLbN7riniMmmKT0bHw=
X-Received: by 2002:a1f:dd02:0:b0:45f:ed55:4cca with SMTP id
 u2-20020a1fdd02000000b0045fed554ccamr353486vkg.6.1686036024433; Tue, 06 Jun
 2023 00:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230530144931.188900-1-brgl@bgdev.pl> <20230605153928.GB21796@willie-the-truck>
In-Reply-To: <20230605153928.GB21796@willie-the-truck>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 6 Jun 2023 09:20:13 +0200
Message-ID: <CAMRc=MeNrgcV_mCM-1-OgJvRGygAAEVQpvS1W2+26CHVpeHhNg@mail.gmail.com>
Subject: Re: [RESEND PATCH] dt-bindings: iommu: arm,smmu: enable clocks for
 sa8775p Adreno SMMU
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 5, 2023 at 5:39=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 30, 2023 at 04:49:31PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The GPU SMMU will require the clocks property to be set so put the
> > relevant compatible into the adreno if-then block.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Resending with all IOMMU maintainers in CC.
>
> I've picked up the earlier version (which is the same patch). There was
> a trivial conflict with a similar change allowing clocks for the
> 'qcom,sc8280xp-smmu-500' device, so please check when I push out the
> updated branch.
>

Looks good, thanks!

Bart
