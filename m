Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22B539C;
	Fri, 16 Sep 2022 12:05:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD4C433B5;
	Fri, 16 Sep 2022 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663329919;
	bh=X/vY/KRBPWKbSbi9cNPBQFHDmijh1dF4skZMnpE87+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X2SyfLK0z7j9IWv8EiVx4sAuTQjLjI4+W3XIBdJUNokuX55TODKe9gACQ9rnA8hW6
	 rlkHhDqUqQAOPVLjNcX7HCb3+hv0q+M6y7KSmZJ+4Vp4oAqHNTb+xPhdL8/X4Gr7B8
	 XVayqXwIj8qOHSS2/ufiRSBaZo2FJ0YnhJzzBbhxxWPjraTGvKtFkDVpx0pydjaItB
	 rOGQ4BgOM+i7qAKEugLKLbNBcSOD0eVrr9CUvhmgE6BarcxDpR/6+zrN5cHIGWLNWH
	 cCkTYoMtSRB9WfeNoVajfu1EKAq3FsdTxzDiSm9p6c4qBSwPWr8P+4lT4FuVpuLvLr
	 zudxhVY8uqLXA==
Received: by mail-ua1-f47.google.com with SMTP id b7so7814199uas.2;
        Fri, 16 Sep 2022 05:05:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf2stzqToPNUwQkeTiJLf5BRvP1V4gkC/Tklt9YaNNDvYZZH62Qq
	vZklyhyWPl5Oj9xdszmZolfsCoyZkINtJ0WhNQ==
X-Google-Smtp-Source: AMsMyM6JqoWENmcjIu/e8yxtT/sLSv8+SY5ABk4vsdDmdDuhMa7hBIrdG0PEFMAjHmumVKlV+9knF9FfzOgvFU7wu8g=
X-Received: by 2002:ab0:2ea9:0:b0:395:b672:508 with SMTP id
 y9-20020ab02ea9000000b00395b6720508mr1696771uay.63.1663329918882; Fri, 16 Sep
 2022 05:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220916094152.87137-1-j@jannau.net> <20220916094152.87137-6-j@jannau.net>
In-Reply-To: <20220916094152.87137-6-j@jannau.net>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Sep 2022 07:05:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL27Oj3+Pahyfn+HmW-bTtwT0UnSuRDRAiyk3nExV4wVw@mail.gmail.com>
Message-ID: <CAL_JsqL27Oj3+Pahyfn+HmW-bTtwT0UnSuRDRAiyk3nExV4wVw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] iommu: dart: Support t6000 variant
To: Janne Grunau <j@jannau.net>
Cc: iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>, 
	asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 16, 2022 at 4:43 AM Janne Grunau <j@jannau.net> wrote:
>
> From: Sven Peter <sven@svenpeter.dev>
>
> The M1 Pro/Max/Ultra SoCs come with a new variant of DART which
> supports a larger physical address space with a different PTE format.
> Pass through the correct paddr address space size and the PTE format
> to the io-pgtable code which will take care of the rest.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - apply change to io-pgtable-dart.c
>
> Changes in v2:
> - use APPLE_DART2 PTE format for dart-t6000
>
>  drivers/iommu/apple-dart.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
