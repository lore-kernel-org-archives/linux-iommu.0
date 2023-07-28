Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00F5C2C0
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 07:34:06 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-583f837054eso19307637b3.3
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 00:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529645; x=1691134445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjZ+2lMyWd1yujiMboXAmmUAYWYVQiLkKfCWB6zgCK8=;
        b=M/+MbDlRjoHe9u27LVrHKP713/r5vN5xZ0YoP27SxK2t49kh3uHE33SIfRSRNlZcxT
         gGtG+j+VDG5LLFQzC9fhxlePVfA9roocsEhvHP+WRKgQP77ejCXGut3zSiybj35Idw0E
         bG+P4eWBRCSzrN9wXiTxm1tnOdRUliG+7dWiK82QhAQ2tAAs/e1drDnxX40nXgztI6C/
         CcGSPtx2RGCLNtnZHSjKA507Nwo9o/6UgKMKTxbTn6eP/H8SV6WKGxLW6CoWNXoxvdf1
         Nhs9xmR2CpIv+2UR6kxyQU65eTlhlpziZZNTTw7+BGHox+1A8JBb6z8qtwflC9wIcd+p
         dYQw==
X-Gm-Message-State: ABy/qLZYE/WqF8muJvWHWQu8ARVoXQlVVQjeDP3RC77/X4OzB1PVu5HC
	RSot+PeOC3nVs5KU4qCvnxcLIiX0KUxDAw==
X-Google-Smtp-Source: APBJJlGojzRdHpdEBXIKYFGP/o056xUnPZPAbZ1itzXO3KrIl23m4HaHglVpi27T2DSZy9tej73ycQ==
X-Received: by 2002:a0d:c501:0:b0:56d:43cb:da98 with SMTP id h1-20020a0dc501000000b0056d43cbda98mr1090361ywd.29.1690529645585;
        Fri, 28 Jul 2023 00:34:05 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id o73-20020a0dcc4c000000b00576e5af0249sm912780ywd.20.2023.07.28.00.34.04
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:34:05 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d0728058651so1638241276.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 00:34:04 -0700 (PDT)
X-Received: by 2002:a25:514:0:b0:d06:f0ab:e17b with SMTP id
 20-20020a250514000000b00d06f0abe17bmr984545ybf.55.1690529644412; Fri, 28 Jul
 2023 00:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230728014659.411751-1-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230728014659.411751-1-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Jul 2023 09:33:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXzWE7NrtPi0hW_APo+Dg-skDMeyAEjVxmUXy9M0jKn_Q@mail.gmail.com>
Message-ID: <CAMuHMdXzWE7NrtPi0hW_APo+Dg-skDMeyAEjVxmUXy9M0jKn_Q@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/ipmmu-vmsa: Allow PCIe devices
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 4:40=E2=80=AFAM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> IPMMU hardware on R-Car Gen3 and RZ/G2 is simple. Each bus-master
> device like eMMC host and PCIe controllers has a micro-TLB of
> The IPMMU, and after enabled it, all transactions of the device are
> under the IPMMU.
>
>  eMMC host ---(micro-TLB of eMMC)--- IPMMU cache --- IPMMU main
>  PCIe --------(micro-TLB of PCIe)--- IPMMU cache --- IPMMU main
>
> Now this IPMMU driver allows eMMC host, and it is safe to use
> the IPMMU. So, we can assume that it is safe to use the IPMMU
> from PCIe devices too, because all PCIe devices transactions will
> go to the micro-TLB of PCIe. So, add a new condition whether
> the device is a PCIe device or not in the ipmmu_device_is_allowed()
> which will be called if the PCIe host controller has iommu-map
> property.
>
> This can improve CPU load because the PCIe controllers only have
> a capability for lower 32-bit memory area so that this can avoid
> using swiotlb.
>
> Note that IPMMU on R-Car Gen4 is different than R-Car Gen3 and
> RZ/G2's one, especially OS-ID. But, for now, the IPMMU driver
> takes care of OS-ID 0 only. In other words, all PCIe devices will
> go to the micro-TLB of PCIe.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> Changes from v3:
> https://lore.kernel.org/all/20230529063928.1030014-1-yoshihiro.shimoda.uh=
@renesas.com/
>  - Rebase the latest iommu/next branch.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
