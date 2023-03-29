Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F311102
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 07:16:03 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id cf7so18174943ybb.5
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 00:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680074162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRC1wc1HRmoSKP28Csbp1c2SyHFhwUwNxc/3v65hV78=;
        b=1YQNxfkZ/FWCPym2ibsI+VC43MisnWVfMX3n86vUT/Y5MHLGvhn8VGenUyVjJmiAy5
         keVzh+nHXr7lFX+kj/TKt+jIqZsqg9kkLgVgsB63UcNYegXlAHReNixJvUlbIzbiNoMy
         35amXgk/hHEQBx0IbKSGz5CMNGXDGaa2fzpigdxrYbeEhbNvz9h8+znYxn5Z+o2spWf/
         7LBMFFPprbqi/SM95DVdZi+ss9uBi44ZWvJoMoqsMmNBl6okB9uxDDE+RngF5vwYU7MF
         VK+YRzJu8mO33OmLoA/89xbULO0WF4QGbKMnznZVikm3H8dk4vYmO89aCgVoX+z1FXkz
         BVgg==
X-Gm-Message-State: AAQBX9cAeGsGnHu6svIixvZ+s9dWpblm54OrI8E+oY4b7Twikm8o9unq
	V17RJxoizskzw6v+Jzp4M/WcnsydLc9dTQ==
X-Google-Smtp-Source: AKy350bf5DDg7WS72eshlwYaTiwGBdXMcsnKkzgHSW2vI6Bgvsfczdflw3e6PKrZCTh7Ue+MwXjleA==
X-Received: by 2002:a25:408e:0:b0:b44:892c:7010 with SMTP id n136-20020a25408e000000b00b44892c7010mr1460176yba.0.1680074162527;
        Wed, 29 Mar 2023 00:16:02 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id h6-20020a81b646000000b00545a08184fdsm2806372ywk.141.2023.03.29.00.16.01
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 00:16:01 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5445009c26bso277024907b3.8
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 00:16:01 -0700 (PDT)
X-Received: by 2002:a81:b28a:0:b0:544:5fc7:f01f with SMTP id
 q132-20020a81b28a000000b005445fc7f01fmr8681031ywh.4.1680074161155; Wed, 29
 Mar 2023 00:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230316140912.1038404-1-desnesn@redhat.com>
In-Reply-To: <20230316140912.1038404-1-desnesn@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Mar 2023 09:15:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX=M+zQ+Y_DoYkHyfT0FCKWtKcAwhpze7jxQo_HXmH1aw@mail.gmail.com>
Message-ID: <CAMuHMdX=M+zQ+Y_DoYkHyfT0FCKWtKcAwhpze7jxQo_HXmH1aw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] scsi: smartpqi: fix DMA overlapping mappings asymmetry
To: Desnes Nunes <desnesn@redhat.com>
Cc: iommu@lists.linux.dev, linux-scsi@vger.kernel.org, 
	storagedev@microchip.com, linux-kernel@vger.kernel.org, hch@lst.de, 
	martin.petersen@oracle.com, don.brace@microchip.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, jejb@linux.ibm.com, jsnitsel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Desnes,

On Thu, Mar 16, 2023 at 3:13=E2=80=AFPM Desnes Nunes <desnesn@redhat.com> w=
rote:
> In summary, this series fixes an overlapping mappings asymmetry on the
> smartpqi driver due to a missing pqi_pci_unmap() call, while also adding
> the cacheline on debug messages of dma-debug debugging functions.
>
> Other minor non-functional updates are also provided.

Thanks for your series!

Unfortunately this v2 does not fix the build issues reported by the
bots, thus breaking linux-next on plain 32-bit.

I have sent a fix
https://lore.kernel.org/r/20230329071405.1568021-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
