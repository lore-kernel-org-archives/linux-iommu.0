Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179C4C95;
	Fri, 16 Sep 2022 11:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E6AC43143;
	Fri, 16 Sep 2022 11:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663329458;
	bh=4mAe95msSQk1H+17nLH8cwEk5y1qk5VEu4IIy8UaDa8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R6QPhiyg9IXbFuqFLDXgN+P1tpHp6w/wnaxSvuTy3k596sfMSPVyO5SIxdulHhQ6m
	 lYtKfB/Cf5WDFmVsfOKhM8CcR9qNsz16L+9BxCvu4bOAGPgYhj+B3vQolsh58MhygI
	 r1VBOyeDPwG9jbmPviGl0bPpu6ZKZvbpLI945/Um+8ZSU83ivWww5wmG4Se1x/SeqA
	 TSZ6wtKQUBjN7ueYBxMqJdy2a/Hm2+EgY0J8X+CeTNqXlDc5Jt2cd8b6E3OqJB4fWa
	 PPfWr5iLPngTKOgQ6mSPhN5Vj1ImY2vt3dPsD+p9brHvX6VGvexUUO/VECLn7ARPJm
	 B3RIaFPKYhfEg==
Received: by mail-vs1-f47.google.com with SMTP id q26so16958316vsr.7;
        Fri, 16 Sep 2022 04:57:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf3poWTm6+atQ4FaxiPpcCYaGEiaBWJkIKImjaM9j/naNzZjibEo
	xXrkYR+uRPGa1Gag6Dx3EMG8CAGxR0M0kKHKfQ==
X-Google-Smtp-Source: AMsMyM5KW5eWL7Cqt5T0A2gzwu5JCELe579DpI/4acsgJ1Dh4ttemvDob7uKBCVevdtJkNDewsUUe9f+tsuuCBHwFRM=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr1767890vsi.85.1663329457398; Fri, 16
 Sep 2022 04:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220916094152.87137-1-j@jannau.net> <20220916094152.87137-4-j@jannau.net>
In-Reply-To: <20220916094152.87137-4-j@jannau.net>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Sep 2022 06:57:26 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKWaYV7uJeJbaJSuHM+ud6f_eZ0_Kq_WwGg3uLDodUV3Q@mail.gmail.com>
Message-ID: <CAL_JsqKWaYV7uJeJbaJSuHM+ud6f_eZ0_Kq_WwGg3uLDodUV3Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] iommu/io-pgtable: Add DART subpage protection support
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
> DART allows to only expose a subpage to the device. While this is an
> optional feature on the M1 DARTs the new ones present on the Pro/Max
> models require this field in every PTE.
>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - apply change to io-pgtable-dart.c
>
>  drivers/iommu/io-pgtable-dart.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
