Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BBBC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 11:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D31E58135A;
	Mon,  7 Mar 2022 11:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mL66GaFUMoPl; Mon,  7 Mar 2022 11:49:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A09681334;
	Mon,  7 Mar 2022 11:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE66C001D;
	Mon,  7 Mar 2022 11:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56206C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 11:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37AD24031B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 11:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UBr-FGGylp5C for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 11:49:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 14BB840286
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 11:49:20 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 q7-20020a7bce87000000b00382255f4ca9so10653752wmj.2
 for <iommu@lists.linux-foundation.org>; Mon, 07 Mar 2022 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ebv4wRovj70KG8uF5gc7UC8c0Xuo000rWiEHlagQEq8=;
 b=pvyDOySoBXFDOYhct7puGFCOpDvUqtmZOn4/I1xtNdXvorYhegmYmOtDsIG+9sT+xl
 YOu92CfjrYAT7tAqgHpsrj+q05amk3O27nl+PbTfFhGdH2UPPmCCYYT3oglY1H9H8Tmi
 c/9UHo0FE53g3MiUW0ZetD7R+de03f9zIiQU7XKCK/qE53iwCtblvOP5cs5qUr042K8X
 uXxbUBUVxSU9GxE4H6nUHOsBT/j5oWTaRMv5eqEZbhDrX8gx+80KBrKYLw7nqRuqVS7B
 MpqoqpLwPA7Bo5QprGWarxRvyt9EljVyyu3nt8zI59adNHxUXlJvU76x1Ms2cKnloYr6
 1MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ebv4wRovj70KG8uF5gc7UC8c0Xuo000rWiEHlagQEq8=;
 b=QXZhAZiqBmX0xRhLTXBSr+EIHHI0L5GIKheSa872L8VAL1ssfJlCUPUuankzkP9qw6
 flbqjTw9Kg4KtyyBm4IA2kZAQB3xHMv2sExPbB8aXxGYwLjphiN4+sYFi82Ys1YoDO5v
 NJRt0faQcMEWr9y7RgQv9zL12EATpHfB/1riYCshdbFBeGVi9uqJlW/L0M0Xe+OVLKIw
 oGty4bIXiL+bQb6HTYkspmk5u1SPb+zAIp9KGXSUBOY3yOb8EJL4x87g+RKf8qDzCPgu
 skd5OBGwDw9xsHLfthuNQ4iU/UxAhhaoi45DNlU3BQnYOZtQk3WY0iHnNhCV79upYqpu
 yDjg==
X-Gm-Message-State: AOAM531axQht4j8AcY/su1ODKFhimApBEm1TjBCsXmOuFkCh/K7JZrkH
 8TTHzvaMp4FZJmm842OztYg=
X-Google-Smtp-Source: ABdhPJx+GnLHEJJ+FDMRm8MHItvvYqChTZvRoIe5yiJ3MiTULGprMAB1sJJExC2f1Nq96cbHv0nUkQ==
X-Received: by 2002:a05:600c:4f85:b0:382:e2bf:5fd2 with SMTP id
 n5-20020a05600c4f8500b00382e2bf5fd2mr8840222wmq.30.1646653758134; 
 Mon, 07 Mar 2022 03:49:18 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
 by smtp.googlemail.com with ESMTPSA id
 ay24-20020a05600c1e1800b00389a420e1ecsm3742530wmb.37.2022.03.07.03.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 03:49:17 -0800 (PST)
Date: Mon, 7 Mar 2022 12:49:14 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [BUG] crypto: ccree: driver does not handle case where cryptlen
 = authsize =0
Message-ID: <YiXxOqfF21q5LAxR@Red>
References: <YhKV55t90HWm6bhv@Red>
 <CAOtvUMdRU4wnRCXsC+U5XBDp+b+u8w7W7JCUKW2+ohuJz3PVhQ@mail.gmail.com>
 <YhOcEQEjIKBrbMIZ@Red>
 <CAOtvUMfN8U4+eG-TEVW4bSE6kOzuOSsJE4dOYGXYuWQKNzv7wQ@mail.gmail.com>
 <CAOtvUMeRb=j=NDrc88x8aB-3=D1mxZ_-aA1d4FfvJmj7Jrbi4w@mail.gmail.com>
 <YiIUXtxd44ut5uzV@Red> <YiUsWosH+MKMF7DQ@gondor.apana.org.au>
 <CAOtvUMcudG3ySU+VeE7hfneDVWGLKFTnws-xjhq4hgFYSj0qOg@mail.gmail.com>
 <YiXjCcXXk0f18FDL@Red>
 <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aca4117c-b7a5-f7eb-eb03-4e1f1a93a730@arm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 Gilad Ben-Yossef <gilad@benyossef.com>, iommu@lists.linux-foundation.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, hch@lst.de
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

Le Mon, Mar 07, 2022 at 11:14:16AM +0000, Robin Murphy a =E9crit :
> On 2022-03-07 10:48, Corentin Labbe wrote:
> > Le Mon, Mar 07, 2022 at 09:59:29AM +0200, Gilad Ben-Yossef a =EF=BF=BDc=
rit :
> >> On Sun, Mar 6, 2022 at 11:49 PM Herbert Xu <herbert@gondor.apana.org.a=
u> wrote:
> >>>
> >>> On Fri, Mar 04, 2022 at 02:30:06PM +0100, Corentin Labbe wrote:
> >>>>
> >>>> Hello
> >>>>
> >>>> I got:
> >>>> [   17.563793] ------------[ cut here ]------------
> >>>> [   17.568492] DMA-API: ccree e6601000.crypto: device driver frees D=
MA memory with different direction [device address=3D0x0000000078fe5800] [s=
ize=3D8 bytes] [mapped with DMA_TO_DEVICE] [unmapped with DMA_BIDIRECTIONAL]
> >>>
> >>> The direction argument during unmap must match whatever direction
> >>> you used during the original map call.
> >>
> >>
> >> Yes, of course. I changed one but forgot the other.
> >>
> >> Corentin, could you be kind and check that this solves the original
> >> problem and does not produce new warnings?
> >>
> >> diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c
> >> b/drivers/crypto/ccree/cc_buffer_mgr.c
> >> index 11e0278c8631..31cfe014922e 100644
> >> --- a/drivers/crypto/ccree/cc_buffer_mgr.c
> >> +++ b/drivers/crypto/ccree/cc_buffer_mgr.c
> >> @@ -356,12 +356,14 @@ void cc_unmap_cipher_request(struct device *dev,
> >> void *ctx,
> >>                                req_ctx->mlli_params.mlli_dma_addr);
> >>          }
> >>
> >> -       dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECTIONAL);
> >> -       dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src));
> >> -
> >>          if (src !=3D dst) {
> >> -               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_BIDIREC=
TIONAL);
> >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_TO_DEVIC=
E);
> >> +               dma_unmap_sg(dev, dst, req_ctx->out_nents, DMA_FROM_DE=
VICE);
> >>                  dev_dbg(dev, "Unmapped req->dst=3D%pK\n", sg_virt(dst=
));
> >> +               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src)=
);
> >> +       } else {
> >> +               dma_unmap_sg(dev, src, req_ctx->in_nents, DMA_BIDIRECT=
IONAL);
> >> +               dev_dbg(dev, "Unmapped req->src=3D%pK\n", sg_virt(src)=
);
> >>          }
> >>   }
> >>
> >> @@ -377,6 +379,7 @@ int cc_map_cipher_request(struct cc_drvdata
> >> *drvdata, void *ctx,
> >>          u32 dummy =3D 0;
> >>          int rc =3D 0;
> >>          u32 mapped_nents =3D 0;
> >> +       int src_direction =3D (src !=3D dst ? DMA_TO_DEVICE : DMA_BIDI=
RECTIONAL);
> >>
> >>          req_ctx->dma_buf_type =3D CC_DMA_BUF_DLLI;
> >>          mlli_params->curr_pool =3D NULL;
> >> @@ -399,7 +402,7 @@ int cc_map_cipher_request(struct cc_drvdata
> >> *drvdata, void *ctx,
> >>          }
> >>
> >>          /* Map the src SGL */
> >> -       rc =3D cc_map_sg(dev, src, nbytes, DMA_BIDIRECTIONAL, &req_ctx=
->in_nents,
> >> +       rc =3D cc_map_sg(dev, src, nbytes, src_direction, &req_ctx->in=
_nents,
> >>                         LLI_MAX_NUM_OF_DATA_ENTRIES, &dummy, &mapped_n=
ents);
> >>          if (rc)
> >>                  goto cipher_exit;
> >> @@ -416,7 +419,7 @@ int cc_map_cipher_request(struct cc_drvdata
> >> *drvdata, void *ctx,
> >>                  }
> >>          } else {
> >>                  /* Map the dst sg */
> >> -               rc =3D cc_map_sg(dev, dst, nbytes, DMA_BIDIRECTIONAL,
> >> +               rc =3D cc_map_sg(dev, dst, nbytes, DMA_FROM_DEVICE,
> >>                                 &req_ctx->out_nents, LLI_MAX_NUM_OF_DA=
TA_ENTRIES,
> >>                                 &dummy, &mapped_nents);
> >>                  if (rc)
> >>
> >>
> > =

> > Hello
> > =

> > I still get the warning:
> > [  433.406230] ------------[ cut here ]------------
> > [  433.406326] DMA-API: ccree e6601000.crypto: cacheline tracking EEXIS=
T, overlapping mappings aren't supported
> > [  433.406386] WARNING: CPU: 7 PID: 31074 at /home/clabbe/linux-next/ke=
rnel/dma/debug.c:571 add_dma_entry+0x1d0/0x288
> > [  433.406434] Modules linked in:
> > [  433.406458] CPU: 7 PID: 31074 Comm: kcapi Not tainted 5.17.0-rc6-nex=
t-20220303-00130-g30042e47ee47-dirty #54
> > [  433.406473] Hardware name: Renesas Salvator-X board based on r8a7795=
0 (DT)
> > [  433.406484] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [  433.406498] pc : add_dma_entry+0x1d0/0x288
> > [  433.406510] lr : add_dma_entry+0x1d0/0x288
> > [  433.406522] sp : ffff800015da3690
> > [  433.406531] x29: ffff800015da3690 x28: 0000000000000000 x27: 0000000=
000000000
> > [  433.406562] x26: 0000000000000000 x25: ffff80000b4c7bc0 x24: ffff800=
00b4c7000
> > [  433.406593] x23: 0000000000000000 x22: 00000000ffffffef x21: ffff800=
00a9b6000
> > [  433.406623] x20: ffff0004c0af5c00 x19: ffff80000b420000 x18: fffffff=
fffffffff
> > [  433.406653] x17: 6c7265766f202c54 x16: 534958454520676e x15: 0000000=
00000022e
> > [  433.406683] x14: ffff800015da3380 x13: 00000000ffffffea x12: ffff800=
00b4be010
> > [  433.406713] x11: 0000000000000001 x10: 0000000000000001 x9 : ffff800=
00b4a6028
> > [  433.406743] x8 : c0000000ffffefff x7 : 0000000000017fe8 x6 : ffff800=
00b4a5fd0
> > [  433.406773] x5 : ffff0006ff795c48 x4 : 0000000000000000 x3 : 0000000=
000000027
> > [  433.406802] x2 : 0000000000000023 x1 : 8ca4e4fbf4b87900 x0 : 0000000=
000000000
> > [  433.406833] Call trace:
> > [  433.406841]  add_dma_entry+0x1d0/0x288
> > [  433.406854]  debug_dma_map_sg+0x150/0x398
> > [  433.406869]  __dma_map_sg_attrs+0x9c/0x108
> > [  433.406889]  dma_map_sg_attrs+0x10/0x28
> > [  433.406904]  cc_map_sg+0x80/0x100
> > [  433.406924]  cc_map_cipher_request+0x178/0x3c8
> > [  433.406939]  cc_cipher_process+0x210/0xb58
> > [  433.406953]  cc_cipher_encrypt+0x2c/0x38
> > [  433.406967]  crypto_skcipher_encrypt+0x44/0x78
> > [  433.406986]  skcipher_recvmsg+0x36c/0x420
> > [  433.407003]  ____sys_recvmsg+0x90/0x280
> > [  433.407024]  ___sys_recvmsg+0x88/0xd0
> > [  433.407038]  __sys_recvmsg+0x6c/0xd0
> > [  433.407049]  __arm64_sys_recvmsg+0x24/0x30
> > [  433.407061]  invoke_syscall+0x44/0x100
> > [  433.407082]  el0_svc_common.constprop.3+0x90/0x120
> > [  433.407096]  do_el0_svc+0x24/0x88
> > [  433.407110]  el0_svc+0x4c/0x100
> > [  433.407131]  el0t_64_sync_handler+0x90/0xb8
> > [  433.407145]  el0t_64_sync+0x170/0x174
> > [  433.407160] irq event stamp: 5624
> > [  433.407168] hardirqs last  enabled at (5623): [<ffff80000812f6a8>] _=
_up_console_sem+0x60/0x98
> > [  433.407191] hardirqs last disabled at (5624): [<ffff800009c9a060>] e=
l1_dbg+0x28/0x90
> > [  433.407208] softirqs last  enabled at (5570): [<ffff8000097e62f8>] l=
ock_sock_nested+0x80/0xa0
> > [  433.407226] softirqs last disabled at (5568): [<ffff8000097e62d8>] l=
ock_sock_nested+0x60/0xa0
> > [  433.407241] ---[ end trace 0000000000000000 ]---
> > [  433.407381] DMA-API: Mapped at:
> > [  433.407396]  debug_dma_map_sg+0x16c/0x398
> > [  433.407416]  __dma_map_sg_attrs+0x9c/0x108
> > [  433.407436]  dma_map_sg_attrs+0x10/0x28
> > [  433.407455]  cc_map_sg+0x80/0x100
> > [  433.407475]  cc_map_cipher_request+0x178/0x3c8
> > =

> > =

> > BUT I start to thing this is a bug in DMA-API debug.
> > =

> > =

> > My sun8i-ss driver hit the same warning:
> > [  142.458351] WARNING: CPU: 1 PID: 90 at kernel/dma/debug.c:597 add_dm=
a_entry+0x2ec/0x4cc
> > [  142.458429] DMA-API: sun8i-ss 1c15000.crypto: cacheline tracking EEX=
IST, overlapping mappings aren't supported
> > [  142.458455] Modules linked in: ccm algif_aead xts cmac
> > [  142.458563] CPU: 1 PID: 90 Comm: 1c15000.crypto- Not tainted 5.17.0-=
rc6-next-20220307-00132-g39dad568d20a-dirty #223
> > [  142.458581] Hardware name: Allwinner A83t board
> > [  142.458596]  unwind_backtrace from show_stack+0x10/0x14
> > [  142.458627]  show_stack from 0xf0abdd1c
> > [  142.458646] irq event stamp: 31747
> > [  142.458660] hardirqs last  enabled at (31753): [<c019316c>] __up_con=
sole_sem+0x50/0x60
> > [  142.458688] hardirqs last disabled at (31758): [<c0193158>] __up_con=
sole_sem+0x3c/0x60
> > [  142.458710] softirqs last  enabled at (31600): [<c06990c8>] sun8i_ss=
_handle_cipher_request+0x300/0x8b8
> > [  142.458738] softirqs last disabled at (31580): [<c06990c8>] sun8i_ss=
_handle_cipher_request+0x300/0x8b8
> > [  142.458758] ---[ end trace 0000000000000000 ]---
> > [  142.458771] DMA-API: Mapped at:
> > =

> > Yes the mapped at is empty just after.
> > =

> > And the sequence of DMA operations in my driver is simple, so I cannot =
see how any overlap could occur.
> =

> The "overlap" is in the sense of having more than one mapping within the =

> same cacheline:
> =

> [  142.458120] DMA-API: add_dma_entry start P=3Dba79f200 N=3Dba79f =

> D=3Dba79f200 L=3D10 DMA_FROM_DEVICE attrs=3D0
> [  142.458156] DMA-API: add_dma_entry start P=3D445dc010 N=3D445dc =

> D=3D445dc010 L=3D10 DMA_TO_DEVICE attrs=3D0
> [  142.458178] sun8i-ss 1c15000.crypto: SRC 0/1/1 445dc000 len=3D16 bi=3D0
> [  142.458215] sun8i-ss 1c15000.crypto: DST 0/1/1 ba79f200 len=3D16 bi=3D0
> [  142.458234] DMA-API: add_dma_entry start P=3Dba79f210 N=3Dba79f =

> D=3Dba79f210 L=3D10 DMA_FROM_DEVICE attrs=3D0
> =

> This actually illustrates exactly the reason why this is unsupportable. =

> ba79f200 is mapped for DMA_FROM_DEVICE, therefore subsequently mapping =

> ba79f210 for DMA_TO_DEVICE may cause the cacheline covering the range =

> ba79f200-ba79f23f to be written back over the top of data that the =

> device has already started to write to memory. Hello data corruption.
> =

> Separate DMA mappings should be from separate memory allocations, =

> respecting ARCH_DMA_MINALIGN.
> =


Hello, thanks for the explanation.
Does my driver can do something about it ?
Like checking SGs respect this ARCH_DMA_MINALIGN constraints and if not fal=
lback to a software implementation (as it will does non-DMA transfer).

Regards
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
