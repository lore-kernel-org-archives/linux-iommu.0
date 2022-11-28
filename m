Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EA8A49F
	for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 22:14:52 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id b2so8724367iof.12
        for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 14:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRCP5i+kS7Z6U29Z84RcTfhHLs05Gmm0hutojax5sCQ=;
        b=j8VmxmloAfeZxEA3bXqzHAqH4WWzlyvDlESJv713QjFWvS1Hn8f7Ue3yiGK6JHS/Ue
         Zh4TzPaicWn/3R0FGXzTUisHAPSpFYj2QVIQjjccPUTBGCOh31fWgWZmgg1nf5dgXnb5
         ePvpR9jbLcUt2+vJDPVM5E3gfYIj6NrTmNdYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRCP5i+kS7Z6U29Z84RcTfhHLs05Gmm0hutojax5sCQ=;
        b=27IeRUTQ4+yMeJgT79AFSr8P2etssa1PM8Yav19Ro0E0YWvReiqP89vyEaYIWn+wHg
         ss6oQhxW3BDmudBJgiC9GdlETuHCAN/KaLYPUIpUJPy1TRO5/ySBh1qsA/bxr4jIuzvt
         WKQU9qOdtzxYat0XCeKEtk4ztPEl7/c1POwzR9zdTAs3OByHNYCjRyBcRb+3Awb6BP1E
         nB6DvhfeWCfIQeJ9IgXTomusy/4r81yWrey24O7dpfrlOea1FY620l3p9HI25ILwt+Tm
         F7ydMNFhOFaYxbwghT4K+6oTCC6lj85TnjUIeVJRFYmNABcyh0p3AokftzB60l0InTkj
         Ua+g==
X-Gm-Message-State: ANoB5pnqjCSIkqTo4745HqGP6Y98Fn5u0SWg0fGjIFIBwazzTdSqRg4d
	B4MHwn4TqDn8sMGRwSGgAriyeUQzWIcqAaLJ
X-Google-Smtp-Source: AA0mqf7gLvvyW4Tgh9kNe7mF4G1Koc/+TmZjdhGLrhdPohF4n/gR5Xdi0hV+NRo94w030pQmP9PfjQ==
X-Received: by 2002:a02:84e2:0:b0:389:dd60:745d with SMTP id f89-20020a0284e2000000b00389dd60745dmr4358762jai.96.1669673691221;
        Mon, 28 Nov 2022 14:14:51 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id f30-20020a056602089e00b006df10f981a2sm4907006ioz.6.2022.11.28.14.14.49
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 14:14:49 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id z3so8740363iof.3
        for <iommu@lists.linux.dev>; Mon, 28 Nov 2022 14:14:49 -0800 (PST)
X-Received: by 2002:a05:6638:11d3:b0:389:ebdc:8f4 with SMTP id
 g19-20020a05663811d300b00389ebdc08f4mr530772jas.27.1669673688675; Mon, 28 Nov
 2022 14:14:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221125-mtk-iommu-v1-0-bb5ecac97a28@chromium.org> <9e81fb3cc4f315f330c610dfb16bad50b7241f4c.camel@mediatek.com>
In-Reply-To: <9e81fb3cc4f315f330c610dfb16bad50b7241f4c.camel@mediatek.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Nov 2022 23:14:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCv_ZBLFTp42AZz9Td_JCR0MKLooW2gtFo3woT-dOQtm8w@mail.gmail.com>
Message-ID: <CANiDSCv_ZBLFTp42AZz9Td_JCR0MKLooW2gtFo3woT-dOQtm8w@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Fix crash on isr after kexec()
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "will@kernel.org" <will@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yong


On Mon, 28 Nov 2022 at 07:44, Yong Wu (=E5=90=B4=E5=8B=87) <Yong.Wu@mediate=
k.com> wrote:
>
> On Fri, 2022-11-25 at 17:28 +0100, Ricardo Ribalda wrote:
> > If the system is rebooted via isr(), the IRQ handler might be
> > triggerd
> > before the domain is initialized. Resulting on an invalid memory
> > access
> > error.
> >
> > Fix:
> > [    0.500930] Unable to handle kernel read from unreadable memory at
> > virtual address 0000000000000070
> > [    0.501166] Call trace:
> > [    0.501174]  report_iommu_fault+0x28/0xfc
> > [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > To: Yong Wu <yong.wu@mediatek.com>
> > To: Joerg Roedel <joro@8bytes.org>
> > To: Will Deacon <will@kernel.org>
> > To: Robin Murphy <robin.murphy@arm.com>
> > To: Matthias Brugger <matthias.bgg@gmail.com>
> > Cc: iommu@lists.linux.dev
> > Cc: linux-mediatek@lists.infradead.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/iommu/mtk_iommu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 2ab2ecfe01f8..17f6be5a5097 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -454,7 +454,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void
> > *dev_id)
> >               fault_larb =3D data->plat_data-
> > >larbid_remap[fault_larb][sub_comm];
> >       }
> >
> > -     if (report_iommu_fault(&dom->domain, bank->parent_dev,
> > fault_iova,
> > +     if (dom && report_iommu_fault(&dom->domain, bank->parent_dev,
> > fault_iova,
>
>
> Which SoC does this issue happen? Does this issue is happened in the
> upstream kernel or the downstream kernel?

I am using chromeos-5.10 and chromeos-5.15 (which are pretty much upstream)=
.

I have seen this issue at least with MT8195 and MT8183


>
> Normally each port enable the iommu defaultly. Let's print the error
> log even though "dom" is null to check which port fail here. then
> analyse the port's behavior.
>
> if (!dom || report_iommu_fault(xx))
>      dev_err_ratelimited(xx)

sending a v2 with the change.

Thanks!


>
> >                              write ? IOMMU_FAULT_WRITE :
> > IOMMU_FAULT_READ)) {
> >               dev_err_ratelimited(
> >                       bank->parent_dev,
> >
> > ---
> > base-commit: 4312098baf37ee17a8350725e6e0d0e8590252d4
> > change-id: 20221125-mtk-iommu-13023f971298
> >
> > Best regards,



--=20
Ricardo Ribalda
