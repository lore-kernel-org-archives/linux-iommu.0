Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3A2C433FE
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 13:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C5CE7823E3;
	Mon,  7 Mar 2022 13:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6QGqwzKg8ELX; Mon,  7 Mar 2022 13:56:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B7D88141A;
	Mon,  7 Mar 2022 13:56:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3378DC001D;
	Mon,  7 Mar 2022 13:56:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04A56C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:56:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6486400F3
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iFbTtKbYfdx3 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 13:56:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 365EA40004
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 13:56:25 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id j26so13048914wrb.1
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=dOWHiNiW1gr75BNGnyFXSXkC6oa3oOMnwuKYpwVf/zg=;
 b=RaPfV/UsQxEg5bWCmVlslKdDwz6ZY0Zvenpban7wYG9mlFG+j7bdGoTMGNN/W8n354
 /ia3shXKCrWRm74NAwLqrHFxy0fL1OCkSXtvRTFcXwvvRFyR42AINNU4CpLK/lpG5SUK
 SYTe1Ho8aMmsr3ndRsJHY58SzIeiWon2/ny7ik4Ru8ob2vWtlOZTr5wMZh03plEpVT6e
 JOYOxTyfD/F/bqLsym9s/t5X9DrH9OtOJPmjmHOUb3s97dslG1sXRfCuXxh206Gx1yz0
 l1i52Glt6NGbb1f4SaA04BPvz9qL5yqmNnSX0eoYmiVISE1D+4D9Yte5H7VXWF0vi5DZ
 gd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=dOWHiNiW1gr75BNGnyFXSXkC6oa3oOMnwuKYpwVf/zg=;
 b=cgF/Vwn2WxVG78ASs+CK8Pvav/xOlZAFlrudd4kxu/jnapj4EH1zQ/0XZpecCq8AE5
 Mh9dcyQOwxhxrUPA7YdrI3RbKNcXiWIPqOG7adbZDfNQKmPeschhhG84VPdb8FxS2brO
 7CKI/tB4+rBf62+3lQrf0d2CUcuFoltBgRA1INAJ3hkYGf0/DQxoJeneK5HBKNjPMlTA
 4U5TCm2Yg3zuL6UwB7Zp4nN1XyBSc4mS6EuwonT+3BaJwy4Fix0gnUVrgOnOGVwbj8/E
 Yr3N0++RWjOFQmNHISOzHWpNgtZ1FDwvN3jYBU64NmigSXGmZlAasNNMju+Da7DlGATQ
 VRug==
X-Gm-Message-State: AOAM5318a7ibUWLjXMJUa7ZToroLASRsaUhokBC33YOva/92f4Bb92Q6
 +0SaknMGii09ZRPweh3UxHY=
X-Google-Smtp-Source: ABdhPJyHF69crih2bQZgeoDk9AFEi+v+pd0yO3k4wwr/m/iYgpOSvZl8QMgfjJCcXC1BszPAFF1bvA==
X-Received: by 2002:a05:6000:168e:b0:1f1:faee:f1c4 with SMTP id
 y14-20020a056000168e00b001f1faeef1c4mr2494524wrd.173.1646661383296; 
 Mon, 07 Mar 2022 05:56:23 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id
 p22-20020a1c5456000000b00389a558670fsm2820409wmi.11.2022.03.07.05.56.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 05:56:22 -0800 (PST)
Date: Mon, 7 Mar 2022 14:56:21 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiYPBdRIi4+HYsmW@Red>
References: <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
 <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
 <YiYMeFf+Lsa9y4ss@Red>
 <CAOtvUMccCai9gFrTv6CZB-U56UtCPtmnZUyW5WmUr=+6YiUHZg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOtvUMccCai9gFrTv6CZB-U56UtCPtmnZUyW5WmUr=+6YiUHZg@mail.gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Le Mon, Mar 07, 2022 at 03:53:02PM +0200, Gilad Ben-Yossef a =E9crit :
> On Mon, Mar 7, 2022 at 3:45 PM Corentin Labbe <clabbe.montjoie@gmail.com>=
 wrote:
> >
> > Le Mon, Mar 07, 2022 at 11:14:16AM +0000, Robin Murphy a =E9crit :
> > > On 2022-03-07 10:48, Corentin Labbe wrote:
> > > > Le Mon, Mar 07, 2022 at 09:59:29AM +0200, Gilad Ben-Yossef a =EF=BF=
=BDcrit :
> > > >> On Sun, Mar 6, 2022 at 11:49 PM Herbert Xu <herbert@gondor.apana.o=
rg.au> wrote:
> > > >>>
> > > >>> On Fri, Mar 04, 2022 at 02:30:06PM +0100, Corentin Labbe wrote:
> > > >>>>
> > > >>>> Hello
> > > >>>>
> > > >>>> I got:
> > > >>>> [   17.563793] ------------[ cut here ]------------
> > > >>>> [   17.568492] DMA-API: ccree e6601000.crypto: device driver fre=
es DMA memory with different direction [device address=3D0x0000000078fe5800=
] [size=3D8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTI=
ONAL]
> > > >>>
> > > >>> The direction argument during unmap must match whatever direction
> > > >>> you used during the original map call.
> > > >>
> > > >>
> > > >> Yes, of course. I changed one but forgot the other.
> > > >>
> > > >> Corentin, could you be kind and check that this solves the original
> > > >> problem and does not produce new warnings?
> > > >>
> > > >> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
> > > >> b/drivers/crypto/ccree/cc_buffer_mgr.c
> > > >> index 11e0278c8631..31cfe014922e 100644
> > > >> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> > > >> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> > > >> @@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *=
dev,
> > > >> void *ctx,
> > > >>                                req_ctx->mlli_params.mlli_dma_addr);
> > > >>          }
> > > >>
> > > >> -       dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONA=
L);
> > > >> -       dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src));
> > > >> -
> > > >>          if (src !=3D dst) {
> > > >> -               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BID=
IRECTIONAL);
> > > >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_D=
EVICE);
> > > >> +               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FRO=
M_DEVICE);
> > > >>                  dev_dbg(dev, "Unmapped req->dst=3D%pK\n", sg_virt=
(dst));
> > > >> +               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(=
src));
> > > >> +       } else {
> > > >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDI=
RECTIONAL);
> > > >> +               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(=
src));
> > > >>          }
> > > >>   }
> > > >>
> > > >> @@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > > >> *drvdata, void *ctx,
> > > >>          u32 dummy =3D 0;
> > > >>          int rc =3D 0;
> > > >>          u32 mapped_nents =3D 0;
> > > >> +       int src_direction =3D (src !=3D dst ? DMA_TO_DEVICE : DMA_=
BIDIRECTIONAL);
> > > >>
> > > >>          req_ctx->dma_buf_type =3D CC_DMA_BUF_DLLI;
> > > >>          mlli_params->curr_pool =3D NULL;
> > > >> @@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > > >> *drvdata, void *ctx,
> > > >>          }
> > > >>
> > > >>          /* Map the src SGL */
> > > >> -       rc =3D cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req=
_ctx->in_nents,
> > > >> +       rc =3D cc_map_sg(dev, src, nbytes, src_direction, &req_ctx=
->in_nents,
> > > >>                         LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapp=
ed_nents);
> > > >>          if (rc)
> > > >>                  goto cipher_exit;
> > > >> @@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata
> > > >> *drvdata, void *ctx,
> > > >>                  }
> > > >>          } else {
> > > >>                  /* Map the dst sg */
> > > >> -               rc =3D cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTION=
AL,
> > > >> +               rc =3D cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
> > > >>                                 &req_ctx->out_nents, LLI_MAX_NUM_O=
F_DATA_ENTRIES,
> > > >>                                 &dummy, &mapped_nents);
> > > >>                  if (rc)
> > > >>
> > > >>
> > > >
> > > > Hello
> > > >
> > > > I still get the warning:
> > > > [  433.406230] ------------[ cut here ]------------
> > > > [  433.406326] DMA-API: ccree e6601000.crypto: cacheline tracking E=
EXIST, overlapping mappings aren't supported
> > > > [  433.406386] WARNING: CPU: 7 PID: 31074 at /home/clabbe/linux-nex=
t/kernel/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> > > > [  433.406434] Modules linked in:
> > > > [  433.406458] CPU: 7 PID: 31074 Comm: kcapi Not tainted 5.17.0-rc6=
-next-20220303-00130-g30042e47ee47-dirty #54
> > > > [  433.406473] Hardware name: Renesas Salvator-X board based on r8a=
77950 (DT)
> > > > [  433.406484] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSB=
S BTYPE=3D--)
> > > > [  433.406498] pc : add_dma_entry+0x1d0/0x288
> > > > [  433.406510] lr : add_dma_entry+0x1d0/0x288
> > > > [  433.406522] sp : ffff800015da3690
> > > > [  433.406531] x29: ffff800015da3690 x28: 0000000000000000 x27: 000=
0000000000000
> > > > [  433.406562] x26: 0000000000000000 x25: ffff80000b4c7bc0 x24: fff=
f80000b4c7000
> > > > [  433.406593] x23: 0000000000000000 x22: 00000000ffffffef x21: fff=
f80000a9b6000
> > > > [  433.406623] x20: ffff0004c0af5c00 x19: ffff80000b420000 x18: fff=
fffffffffffff
> > > > [  433.406653] x17: 6c7265766f202c54 x16: 534958454520676e x15: 000=
000000000022e
> > > > [  433.406683] x14: ffff800015da3380 x13: 00000000ffffffea x12: fff=
f80000b4be010
> > > > [  433.406713] x11: 0000000000000001 x10: 0000000000000001 x9 : fff=
f80000b4a6028
> > > > [  433.406743] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : fff=
f80000b4a5fd0
> > > > [  433.406773] x5 : ffff0006ff795c48 x4 : 0000000000000000 x3 : 000=
0000000000027
> > > > [  433.406802] x2 : 0000000000000023 x1 : 8ca4e4fbf4b87900 x0 : 000=
0000000000000
> > > > [  433.406833] Call trace:
> > > > [  433.406841]  add_dma_entry+0x1d0/0x288
> > > > [  433.406854]  debug_dma_map_sg+0x150/0x398
> > > > [  433.406869]  __dma_map_sg_attrs+0x9c/0x108
> > > > [  433.406889]  dma_map_sg_attrs+0x10/0x28
> > > > [  433.406904]  cc_map_sg+0x80/0x100
> > > > [  433.406924]  cc_map_cipher_request+0x178/0x3c8
> > > > [  433.406939]  cc_cipher_process+0x210/0xb58
> > > > [  433.406953]  cc_cipher_encrypt+0x2c/0x38
> > > > [  433.406967]  crypto_skcipher_encrypt+0x44/0x78
> > > > [  433.406986]  skcipher_recvmsg+0x36c/0x420
> > > > [  433.407003]  ____sys_recvmsg+0x90/0x280
> > > > [  433.407024]  ___sys_recvmsg+0x88/0xd0
> > > > [  433.407038]  __sys_recvmsg+0x6c/0xd0
> > > > [  433.407049]  __arm64_sys_recvmsg+0x24/0x30
> > > > [  433.407061]  invoke_syscall+0x44/0x100
> > > > [  433.407082]  el0_svc_common.constprop.3+0x90/0x120
> > > > [  433.407096]  do_el0_svc+0x24/0x88
> > > > [  433.407110]  el0_svc+0x4c/0x100
> > > > [  433.407131]  el0t_64_sync_handler+0x90/0xb8
> > > > [  433.407145]  el0t_64_sync+0x170/0x174
> > > > [  433.407160] irq event stamp: 5624
> > > > [  433.407168] hardirqs last  enabled at (5623): [<ffff80000812f6a8=
>] __up_console_sem+0x60/0x98
> > > > [  433.407191] hardirqs last disabled at (5624): [<ffff800009c9a060=
>] el1_dbg+0x28/0x90
> > > > [  433.407208] softirqs last  enabled at (5570): [<ffff8000097e62f8=
>] lock_sock_nested+0x80/0xa0
> > > > [  433.407226] softirqs last disabled at (5568): [<ffff8000097e62d8=
>] lock_sock_nested+0x60/0xa0
> > > > [  433.407241] ---[ end trace 0000000000000000 ]---
> > > > [  433.407381] DMA-API: Mapped at:
> > > > [  433.407396]  debug_dma_map_sg+0x16c/0x398
> > > > [  433.407416]  __dma_map_sg_attrs+0x9c/0x108
> > > > [  433.407436]  dma_map_sg_attrs+0x10/0x28
> > > > [  433.407455]  cc_map_sg+0x80/0x100
> > > > [  433.407475]  cc_map_cipher_request+0x178/0x3c8
> > > >
> > > >
> > > > BUT I start to thing this is a bug in DMA-API debug.
> > > >
> > > >
> > > > My sun8i-ss driver hit the same warning:
> > > > [  142.458351] WARNING: CPU: 1 PID: 90 at kernel/dma/debug.c:597 ad=
d_dma_entry+0x2ec/0x4cc
> > > > [  142.458429] DMA-API: sun8i-ss 1c15000.crypto: cacheline tracking=
 EEXIST, overlapping mappings aren't supported
> > > > [  142.458455] Modules linked in: ccm algif_aead xts cmac
> > > > [  142.458563] CPU: 1 PID: 90 Comm: 1c15000.crypto- Not tainted 5.1=
7.0-rc6-next-20220307-00132-g39dad568d20a-dirty #223
> > > > [  142.458581] Hardware name: Allwinner A83t board
> > > > [  142.458596]  unwind_backtrace from show_stack+0x10/0x14
> > > > [  142.458627]  show_stack from 0xf0abdd1c
> > > > [  142.458646] irq event stamp: 31747
> > > > [  142.458660] hardirqs last  enabled at (31753): [<c019316c>] __up=
_console_sem+0x50/0x60
> > > > [  142.458688] hardirqs last disabled at (31758): [<c0193158>] __up=
_console_sem+0x3c/0x60
> > > > [  142.458710] softirqs last  enabled at (31600): [<c06990c8>] sun8=
i_ss_handle_cipher_request+0x300/0x8b8
> > > > [  142.458738] softirqs last disabled at (31580): [<c06990c8>] sun8=
i_ss_handle_cipher_request+0x300/0x8b8
> > > > [  142.458758] ---[ end trace 0000000000000000 ]---
> > > > [  142.458771] DMA-API: Mapped at:
> > > >
> > > > Yes the mapped at is empty just after.
> > > >
> > > > And the sequence of DMA operations in my driver is simple, so I can=
not see how any overlap could occur.
> > >
> > > The "overlap" is in the sense of having more than one mapping within =
the
> > > same cacheline:
> > >
> > > [  142.458120] DMA-API: add_dma_entry start P=3Dba79f200 N=3Dba79f
> > > D=3Dba79f200 L=3D10 DMA_FROM_DEVICE attrs=3D0
> > > [  142.458156] DMA-API: add_dma_entry start P=3D445dc010 N=3D445dc
> > > D=3D445dc010 L=3D10 DMA_TO_DEVICE attrs=3D0
> > > [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=3D16 b=
i=3D0
> > > [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=3D16 b=
i=3D0
> > > [  142.458234] DMA-API: add_dma_entry start P=3Dba79f210 N=3Dba79f
> > > D=3Dba79f210 L=3D10 DMA_FROM_DEVICE attrs=3D0
> > >
> > > This actually illustrates exactly the reason why this is unsupportabl=
e.
> > > ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping
> > > ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range
> > > ba79f200-ba79f23f to be written back over the top of data that the
> > > device has already started to write to memory. Hello data corruption.
> > >
> > > Separate DMA mappings should be from separate memory allocations,
> > > respecting ARCH_DMA_MINALIGN.
> > >
> >
> > I just saw something strange, only one SG is involved, and I dont see a=
ny DMA_TO_DEVICE for ba79f210.
> > I see 2 DMA_FROM_DEVICE (ba79f200 and ba79f210), but only one should be=
 done.
> > Why 2 FROM mappings are added with only one sg ?
> >
> =

> The thing that does the memory allocation of user calls from libkcapi
> tests is the crypto/af_alg.c code ...
> =

> I assume the sglist has two buffers? could it be that somehow they are
> not DMA aligned? that would be weird indeed...
> =


The SGlist has only one SG, so only one buffer, it is why I dont understand=
 the double call to add_dma_entry().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
