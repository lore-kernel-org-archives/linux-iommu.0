Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C948094B
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 14:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582825; cv=pass; b=GC8JUuIV+Zl9ItxmkNL1YFTEJXZLNnTqHJWHxukJB5aIovT9JyaSwS5K1j8mkrCQOs8HdOKCSE2vua/mW90r7SSj80M5H75uh+Dj3zanTnhavh5QpB2IMekUfyPITZPDZyxKPtyv3O1cZD2YR0HKtq8aWKIXOYSpxnUXTjFAPVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582825; c=relaxed/simple;
	bh=UBHDs0KMwEJOWexVy/nKJ4CDaJuMR5YSOX1Tb1qxhHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0Tl+qbJtTIXBCc5z0eBetAAKskAS0IxT0crSyxM6KejS77VQiqmlHOTSN4i/o0WJVVGkKG8cwYoG3lkzI4dxHnIAEOBnUcvOQyQxoBi44nFoyiVfng72P7zfJ5EaBNkodh161zsj0H1bELp6VhHN0hufiwwTs9zBWxaDMpzMtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b=AxQQ2guh; arc=pass smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20251104.gappssmtp.com header.i=@tomeuvizoso-net.20251104.gappssmtp.com header.b="AxQQ2guh"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9159da9bba5so52971285a.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 07:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582823; cv=none;
        d=google.com; s=arc-20240605;
        b=hAVU05EqpwrN7Jq+533MyerJm77Me5gYVhzZ0CdAkWK3ok6ApwVYc3l/MGsEm6nmMi
         dY/O9I7/aLkWxFutwWkFvBMoJ/esz4tRy+GrsWpM3cT1IoCjpIlmzztKqOgkPfX81Rg4
         dRnFcA2jfvG+0175IZFByPmfRZQq+s8z/GqUMFkGquzSaSzbo2ONi/5cvT/vkpMv1Gci
         m49J0RArmkeQaN2ySrnpmb1M4+6OtoIQ2gE0OpRXP+tJYEPMyjYOBpZIndhDei++oPKT
         zsFVDPJN9yKCgW9XIM/MKxg14YWEL3Pty8GLPx4AHs2dG6rL8EQtJm9dhK3+a6jWrEFz
         sJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QPi10HvU9BftniKMgGr3MAu9cx9vcqkTMC3QUEUHzeg=;
        fh=LB2bOf+Xrrv52/ood3eHRfLrkIrq3VG3NRpE1rmawHI=;
        b=CueJ3z4pl+HZnDPwPhn7na4T5TRah0ylumEso9ZswIZPkLKIrKAODyWPF3A3+PESTT
         6kgJakSCulMOeZmtZjCb7vk58etKhGBXmjmtwLylhBtYFLWDPX2r4Qx+YAAfTZoh/r6r
         e5j22Yh744K5h+i7lscuHxqC41m9X6U23Da+jJcBcudWu2fbgIqR7ngF940RRaALE0Sq
         pRMDRgqIzUT0ErqQhYupY+hvma+AKP+azBOs5MmR47/vYFJRa5MDYCAO3hAMgLErqMo0
         Z2Zna8iB4CBm1ve0rogmugiAgn+WMJ9S9jmiGfyqp/KHKkrOUVcyd8NyV3Wq/n57ogrh
         ZQHg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20251104.gappssmtp.com; s=20251104; t=1780582823; x=1781187623; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QPi10HvU9BftniKMgGr3MAu9cx9vcqkTMC3QUEUHzeg=;
        b=AxQQ2guh2QuFYGQdYNp3QaXLS1YK+Q1n+Df4FhVIuKGbZ2jZDhrblTN9CK+LC5tN57
         OUy9/5JyNQERLsKi99bvZTAuwK1Ku4h3h6qhnIo/QHI9xtBC/ZpNgElUhSvJVr/tg+PN
         GA0N81MfM76cJSDKpfOiZJbsUQPzk6FGZ+GYmKf4a1t9RccvqVQroofvO2v9DUiMN9gQ
         786haLNlk0+T/l+sfHHqtI7MRUmZsjYGxRiWlPRtu3qux5W4Jq9HAlhzxQ2S+bIAIqtE
         Ivsf3YYGDFiqGVIzOJT59N379p9OLrE+oe9YC1ZbdKW3MI4uusPmiZsI7OdLrnLcJrNP
         umog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582823; x=1781187623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QPi10HvU9BftniKMgGr3MAu9cx9vcqkTMC3QUEUHzeg=;
        b=CcMLp7a8NkGbQved65hDvixXOMmIYh7WR1L9c4LcE4JuvA9iOJfRp0S6yTeBQoP6X0
         00p0F6nnovbp21FKNHBtYTBuY2r3rpTOg3oS8sBXh9voHgY/IFM2dmCMgMPBBoMAFGpl
         ZutvVAATN1r4o9o3MkjfuVNCKZyD57k8j+6OHcO6M/GZbVGSTfMkUTLjybnSfL8CX8Mj
         8JSL1gX86aq6knrbsrDPz2myOiuf3uus/5VV2ciqI998qk7Z84jQxKrxQdnfNhLKrbs5
         MQljZlabkWZMc1IPUygt1DyY2Erj9bV0iJKrJkrLHrhfAFkT6rWpYiqTVY9307+pR7CJ
         ItTw==
X-Forwarded-Encrypted: i=1; AFNElJ8pVod/9qmQYBogEvngM3/sc1whz6eZXjy/PmK0fWQ9LBUV3BmzyqbulFVq5hHMPfg83VM53g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoHuAJsh+J3xKA/8NRkhZMn5jio3k7ft+2Zuw3UdiNcmDZTxnZ
	e9wsOK5zFTiqUWxGsT0y8cLP2Zoi9/6YLn0zlWjYQqBE9FA6HVqnQ+/IhaO9am0qvwsqpKpheMW
	ZfrgJojWT8nBIJL0GR8JEnVuW4yVq8ZnzzU+ZsT2nCQ==
X-Gm-Gg: Acq92OFjhRHYcPZG4VYmkaB6YzYb8ROeEa2E3aq0fRujMqRuuiffqXtYUg50sBm4sFd
	xT/JMd2lKZAo82bCUOibKEEkmpsUCyPBOO+t20GZ1XNDm0MO59/pA2EBXJeDhG4vdJ8ic1ahDSt
	VyIgIciDKU7rGCt+JVgvp3SQn4wqO5Fc7uRaOUCIVSJCLzs609SZFJYMsLnB6yHzwdl9TK9V2I/
	kvxv74yHh2o52E1A4dwpWCfFixtxmaYdhbQ5P92d7ermoiZYWTCPJeES243d+SFe4nW4IfTjD6y
	QMrn7XM277YBkuDC
X-Received: by 2002:a05:620a:268d:b0:912:c0b3:7d9b with SMTP id
 af79cd13be357-9158a76739emr1272633085a.24.1780582822784; Thu, 04 Jun 2026
 07:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com> <20260604135255.62682-7-midgy971@gmail.com>
In-Reply-To: <20260604135255.62682-7-midgy971@gmail.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Thu, 4 Jun 2026 16:20:10 +0200
X-Gm-Features: AVHnY4JQeDtrhyq7YBnn9raVEBX1uxBzeM4kDcgUj1eAV9LhKWI5-NL4FjfQpnY
Message-ID: <CAPsqS2RYjf4dMj=Maz1c2vViW83ZsrEW9eOez526eh=TsKvQww@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Midgy BALON <midgy971@gmail.com>
Cc: ogabbay@kernel.org, heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 3:53=E2=80=AFPM Midgy BALON <midgy971@gmail.com> wro=
te:
>
> On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
> auto clock-gating of the page-table walker, so the walker's AXI master
> loses its clock between transactions; a TLB-miss page walk then never
> completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).
>
> Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
> so the walker keeps its clock. This is required for the RK3568 NPU MMU.

Hi,

I'm not able to review this patch myself, but maybe it can be
submitted separately while we work on the NPU bits?

Regards,

Tomeu

> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>  drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 4da80136933c4..e3d8b6e9ca12b 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>
>         ret =3D rk_iommu_enable_paging(iommu);
>
> +       if (!ret) {
> +               /*
> +                * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page=
-walker
> +                * auto clock-gating; the walker's AXI master then loses =
its clock
> +                * between transactions and a TLB-miss page walk never co=
mpletes,
> +                * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE). =
 Clear
> +                * bit 1 (keep bit 0, the slave-port gate) once paging is=
 enabled.
> +                */
> +               for (i =3D 0; i < iommu->num_mmu; i++)
> +                       rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATIN=
G, 0x2);
> +       }
> +
>  out_disable_stall:
>         rk_iommu_disable_stall(iommu);
>  out_disable_clocks:
> --
> 2.39.5
>
