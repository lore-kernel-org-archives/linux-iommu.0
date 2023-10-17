Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AC1CFB8
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7ac4c3666so66655207b3.3
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532514; x=1698137314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wdO2B9/QvvZjPAQkmDCzsWoJIs0Ay3wdYhcrR1VVXg=;
        b=QPu/IapJcuqJBQ49QUg8C+8g4Ub/z6OyT/hpgCJQw/Xvws2fNzW1lCx6kSmfH5mCRT
         iV7ySQ5NaVsPwehJSpQPKGqZi9TQ345EpEMOMKxDRK/L9Wpbs13RxWji/rG+OkzG15qx
         i2oLtoUEq5OfitnImyEJg8MwSTxA3O8iu3nNFGjCTGZBi7flwxsx5y2RT6Akhkxbnizf
         JwqbZ3POlh9WBwY87xsioYRS6aoD9Cct+w1A405arv/X0h2pFrmHxrO/u04iQLrlXVVu
         Wcg1OSgkH2FCto5RAvO47jDHKY/uLk+c5QWtM8B/XaiFLOTOk2HHo3QK7pttq/J4xKTv
         QgIQ==
X-Gm-Message-State: AOJu0YyiP5gs2AevwVSB8f6iVXSTtcoAiJ4JvSdcY5boRPv68ZE+Nf5J
	YDSKjNR+zjYr6M688invDYRb5dbGu5YLIA==
X-Google-Smtp-Source: AGHT+IFV4bLVE4aailWyJuzT0IwWJLAaTcaF/lzKvDlB7VQPMxAbvIBzJNCWg9PZfxbniPZPBfi1AQ==
X-Received: by 2002:a0d:f482:0:b0:5a8:960d:e538 with SMTP id d124-20020a0df482000000b005a8960de538mr1765125ywf.47.1697532513702;
        Tue, 17 Oct 2023 01:48:33 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id e63-20020a816942000000b0059c8387f673sm451974ywc.51.2023.10.17.01.48.33
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 01:48:33 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7ac4c3666so66655147b3.3
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:48:33 -0700 (PDT)
X-Received: by 2002:a05:690c:dc8:b0:5a8:5079:422 with SMTP id
 db8-20020a05690c0dc800b005a850790422mr2326403ywb.26.1697532513384; Tue, 17
 Oct 2023 01:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-13-hch@lst.de>
In-Reply-To: <20231016054755.915155-13-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 10:48:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUgM1FMKSJcq4QD9Gc=B8XF7_jWxhm634bTYQ9a6voVhA@mail.gmail.com>
Message-ID: <CAMuHMdUgM1FMKSJcq4QD9Gc=B8XF7_jWxhm634bTYQ9a6voVhA@mail.gmail.com>
Subject: Re: [PATCH 12/12] m68k: remove unused includes from dma.c
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> dma.c doesn't need most of the headers it includes.  Also there is
> no point in undefining the DEBUG symbol given that it isn't used
> anywhere in this small file.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
