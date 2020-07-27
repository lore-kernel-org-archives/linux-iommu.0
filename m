Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC56C433E3
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 14:44:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D407A2083B
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 14:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFtmj2Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D407A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8F0A420436;
	Mon, 27 Jul 2020 14:44:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X2VkQEBk1QNc; Mon, 27 Jul 2020 14:44:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDA612040D;
	Mon, 27 Jul 2020 14:44:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F0AC004F;
	Mon, 27 Jul 2020 14:44:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5251CC004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 14:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 37A148780F
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 14:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 561fVeOnXtJd for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 14:44:37 +0000 (UTC)
X-Greylist: delayed 00:26:09 by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9716F877AD
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 14:44:36 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id h19so17500965ljg.13
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5nrJGkR5gzoJoAzFw0QkQIZLHmzb77Jw0yeZu9JZot4=;
 b=dFtmj2Pf6AsbS3ZvrmOl3FfSHcXv98akIbtsWzzmClw206P7VO9+ayWWQx9sByRB4h
 IvdlzRxURd8G6ieLgdpRGeBUc1taiMQV3jsbSXZC2A1tKVunmUZsw/k3TKGTTsczi9M8
 hr6HisxYH5uZ1vlNHNfdpSAqCLg7wwALQkKrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5nrJGkR5gzoJoAzFw0QkQIZLHmzb77Jw0yeZu9JZot4=;
 b=CzI0hBNQ5hhcYImalVjeDZ3L4YRGT2Zr7AVXbHLig1z7m19zPkHD8Pa2sN0WuT8N3B
 CTt9JgepFXlwTdtsSSEEtiVncrg0t9JhZ3rRq7AG1AQWMSITDYe1wADaVX6l4coWZmtb
 vhd55a7r8Tg4wWMtOGocq/i86QfcgokHTxWjGFc12/zmlrOQYC12h6wYbJdA3vYOGh4a
 aWw3WPDcNgWyRskfOlU1a8D4acZMr5nog5hyA5TYFJOVZEoZGic7/zgjOSqM4Fwj5UDn
 4LmIy06lH5YzEDscBV7dq6hROFgBxXBQTGlhJt3mM9fhoIBMbZGeGlS94KXOh6k4RYAK
 wg2g==
X-Gm-Message-State: AOAM533nerAzdC0Q2stvBH2i4Jy76wkS+hLVEkQJvvhMNrAb0I8lHjmK
 +KXOOQgLW1tWDfzhYHc96MEBKPyiTo2WzA==
X-Google-Smtp-Source: ABdhPJzAhkZJoZvZNQrB9ncrhg/ZXddARnGjxLcvGnTEIh/R5KBems8uYupLcBdKaEl6jE4J1iptaQ==
X-Received: by 2002:a17:906:eb4f:: with SMTP id
 mc15mr19254619ejb.435.1595857750637; 
 Mon, 27 Jul 2020 06:49:10 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com.
 [209.85.221.42])
 by smtp.gmail.com with ESMTPSA id bq8sm7181297ejb.103.2020.07.27.06.49.09
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 06:49:09 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id 88so14965743wrh.3
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:49:09 -0700 (PDT)
X-Received: by 2002:adf:82b2:: with SMTP id 47mr19927685wrc.17.1595857749000; 
 Mon, 27 Jul 2020 06:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200426022650.10355-1-xc-racer2@live.ca>
 <BN6PR04MB0660DB1C884EE9F9C7D94857A3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200707184412.GJ2621465@chromium.org>
 <BN6PR04MB0660C1942C3738F9F9D1AAAFA3620@BN6PR04MB0660.namprd04.prod.outlook.com>
 <CAAFQd5ABvEnt7QQHmwwFyCqRLMabE=Vs_e7FrG3fMmrAWgD_bQ@mail.gmail.com>
 <BN6PR04MB066075594507854A6619A3E3A3770@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB066075594507854A6619A3E3A3770@BN6PR04MB0660.namprd04.prod.outlook.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 27 Jul 2020 15:48:57 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BAb+TcfMf3C_Mczo4+USsP5MzJmFj12eVPER9f-gJ41A@mail.gmail.com>
Message-ID: <CAAFQd5BAb+TcfMf3C_Mczo4+USsP5MzJmFj12eVPER9f-gJ41A@mail.gmail.com>
Subject: Re: [PATCH 10/11] media: exynos4-is: Prevent duplicate call to
 media_pipeline_stop
To: Jonathan Bakker <xc-racer2@live.ca>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kyungmin Park <kyungmin.park@samsung.com>, kgene@kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, Jul 25, 2020 at 1:46 AM Jonathan Bakker <xc-racer2@live.ca> wrote:
>
> Hi Tomasz,
>
> On 2020-07-20 6:10 a.m., Tomasz Figa wrote:
> > On Sat, Jul 11, 2020 at 8:17 PM Jonathan Bakker <xc-racer2@live.ca> wrote:
> >>
> >> Hi Tomasz,
> >>
> >> On 2020-07-07 11:44 a.m., Tomasz Figa wrote:
> >>> Hi Jonathan,
> >>>
> >>> On Sat, Apr 25, 2020 at 07:26:49PM -0700, Jonathan Bakker wrote:
> >>>> media_pipeline_stop can be called from both release and streamoff,
> >>>> so make sure they're both protected under the streaming flag and
> >>>> not just one of them.
> >>>
> >>> First of all, thanks for the patch.
> >>>
> >>> Shouldn't it be that release calls streamoff, so that only streamoff
> >>> is supposed to have the call to media_pipeline_stop()?
> >>>
> >>
> >> I can't say that I understand the whole media subsystem enough to know :)
> >> Since media_pipeline_start is called in streamon, it makes sense that streamoff
> >> should have the media_pipeline_stop call.  However, even after removing the call
> >> in fimc_capture_release I'm still getting a backtrace such as
> >>
> >> [   73.843117] ------------[ cut here ]------------
> >> [   73.843251] WARNING: CPU: 0 PID: 1575 at drivers/media/mc/mc-entity.c:554 media_pipeline_stop+0x20/0x2c [mc]
> >> [   73.843265] Modules linked in: s5p_fimc v4l2_fwnode exynos4_is_common videobuf2_dma_contig pvrsrvkm_s5pv210_sgx540_120 videobuf2_memops v4l2_mem2mem brcmfmac videobuf2_v4l2 videobuf2_common hci_uart sha256_generic libsha256 btbcm bluetooth cfg80211 brcmutil ecdh_generic ecc ce147 libaes s5ka3dfx videodev atmel_mxt_ts mc pwm_vibra rtc_max8998
> >> [   73.843471] CPU: 0 PID: 1575 Comm: v4l2-ctl Not tainted 5.7.0-14534-g2b33418b254e-dirty #669
> >> [   73.843487] Hardware name: Samsung S5PC110/S5PV210-based board
> >> [   73.843562] [<c010c7c4>] (unwind_backtrace) from [<c010a120>] (show_stack+0x10/0x14)
> >> [   73.843613] [<c010a120>] (show_stack) from [<c0117038>] (__warn+0xbc/0xd4)
> >> [   73.843661] [<c0117038>] (__warn) from [<c01170b0>] (warn_slowpath_fmt+0x60/0xb8)
> >> [   73.843734] [<c01170b0>] (warn_slowpath_fmt) from [<bf00c20c>] (media_pipeline_stop+0x20/0x2c [mc])
> >> [   73.843867] [<bf00c20c>] (media_pipeline_stop [mc]) from [<bf145c48>] (fimc_cap_streamoff+0x38/0x48 [s5p_fimc])
> >> [   73.844109] [<bf145c48>] (fimc_cap_streamoff [s5p_fimc]) from [<bf03cbf4>] (__video_do_ioctl+0x220/0x448 [videodev])
> >> [   73.844308] [<bf03cbf4>] (__video_do_ioctl [videodev]) from [<bf03d600>] (video_usercopy+0x114/0x498 [videodev])
> >> [   73.844438] [<bf03d600>] (video_usercopy [videodev]) from [<c0205024>] (ksys_ioctl+0x20c/0xa10)
> >> [   73.844484] [<c0205024>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> >> [   73.844505] Exception stack(0xe5083fa8 to 0xe5083ff0)
> >> [   73.844546] 3fa0:                   0049908d bef8f8c0 00000003 40045613 bef8d5ac 004c1d16
> >> [   73.844590] 3fc0: 0049908d bef8f8c0 bef8f8c0 00000036 bef8d5ac 00000000 b6d6b320 bef8faf8
> >> [   73.844620] 3fe0: 004e3ed4 bef8c718 004990bb b6f00d0a
> >> [   73.844642] ---[ end trace e6a4a8b2f20addd4 ]---
> >>
> >> The command I'm using for testing is
> >>
> >> v4l2-ctl --verbose -d 1 --stream-mmap=3 --stream-skip=2 --stream-to=./test.yuv --stream-count=1
> >>
> >> Since I noticed that the streaming flag was being checked fimc_capture_release
> >> but not in fimc_cap_streamoff, I assumed that it was simply a missed check.  Comparing
> >> with other drivers, they seem to call media_pipeline_stop in their vb2_ops stop_streaming
> >> callback.
> >
> > vb2 does a lot of state handling internally and makes sure that driver
> > ops are not called when unnecessary, preventing double calls for
> > example. I suppose it could be a better place to stop the pipeline
> > indeed. However, ...
> >
> >>
> >> I'm willing to test various options
> >>
> >
> > I think it could make sense to add something like WARN_ON(1) inside
> > media_pipeline_stop() and then check where the first call came from.
>
> Here's the results of that:
>
> [   69.876823] ------------[ cut here ]------------
> [   69.876962] WARNING: CPU: 0 PID: 1566 at drivers/media/mc/mc-entity.c:550 __media_pipeline_stop+0x24/0xfc [mc]
> [   69.876976] Modules linked in: s5p_fimc v4l2_fwnode exynos4_is_common videobuf2_dma_contig videobuf2_memops v4l2_mem2mem brcmfmac videobuf2_v4l2 pvrsrvkm_s5pv210_sgx540_120 videobuf2_common hci_uart sha256_generic btbcm libsha256 bluetooth cfg80211 ce147 brcmutil s5ka3dfx ecdh_generic ecc libaes videodev atmel_mxt_ts mc pwm_vibra rtc_max8998
> [   69.877182] CPU: 0 PID: 1566 Comm: v4l2-ctl Not tainted 5.7.0-14540-gb1220848c797-dirty #681
> [   69.877198] Hardware name: Samsung S5PC110/S5PV210-based board
> [   69.877274] [<c010c7c4>] (unwind_backtrace) from [<c010a120>] (show_stack+0x10/0x14)
> [   69.877326] [<c010a120>] (show_stack) from [<c0117038>] (__warn+0xbc/0xd4)
> [   69.877375] [<c0117038>] (__warn) from [<c01170b0>] (warn_slowpath_fmt+0x60/0xb8)
> [   69.877448] [<c01170b0>] (warn_slowpath_fmt) from [<bf010130>] (__media_pipeline_stop+0x24/0xfc [mc])
> [   69.877540] [<bf010130>] (__media_pipeline_stop [mc]) from [<bf010228>] (media_pipeline_stop+0x20/0x2c [mc])
> [   69.877663] [<bf010228>] (media_pipeline_stop [mc]) from [<bf08fc48>] (fimc_cap_streamoff+0x38/0x48 [s5p_fimc])
> [   69.877904] [<bf08fc48>] (fimc_cap_streamoff [s5p_fimc]) from [<bf040bf4>] (__video_do_ioctl+0x220/0x448 [videodev])
> [   69.878105] [<bf040bf4>] (__video_do_ioctl [videodev]) from [<bf041600>] (video_usercopy+0x114/0x498 [videodev])
> [   69.878234] [<bf041600>] (video_usercopy [videodev]) from [<c0205024>] (ksys_ioctl+0x20c/0xa10)
> [   69.878281] [<c0205024>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> [   69.878301] Exception stack(0xe50c1fa8 to 0xe50c1ff0)
> [   69.878342] 1fa0:                   004ef08d 00539d0c 00000003 40045613 bec1578c 00517d16
> [   69.878386] 1fc0: 004ef08d 00539d0c bec188c0 00000036 bec165ac 00000000 b6def320 bec18af8
> [   69.878415] 1fe0: 00539ed4 bec15730 004ef0bb b6f84d0a
> [   69.878436] ---[ end trace d004ab573a72c329 ]---
> [   69.879704] ------------[ cut here ]------------
> [   69.879794] WARNING: CPU: 0 PID: 1566 at drivers/media/mc/mc-entity.c:550 __media_pipeline_stop+0x24/0xfc [mc]
> [   69.879806] Modules linked in: s5p_fimc v4l2_fwnode exynos4_is_common videobuf2_dma_contig videobuf2_memops v4l2_mem2mem brcmfmac videobuf2_v4l2 pvrsrvkm_s5pv210_sgx540_120 videobuf2_common hci_uart sha256_generic btbcm libsha256 bluetooth cfg80211 ce147 brcmutil s5ka3dfx ecdh_generic ecc libaes videodev atmel_mxt_ts mc pwm_vibra rtc_max8998
> [   69.880002] CPU: 0 PID: 1566 Comm: v4l2-ctl Tainted: G        W         5.7.0-14540-gb1220848c797-dirty #681
> [   69.880016] Hardware name: Samsung S5PC110/S5PV210-based board
> [   69.880071] [<c010c7c4>] (unwind_backtrace) from [<c010a120>] (show_stack+0x10/0x14)
> [   69.880115] [<c010a120>] (show_stack) from [<c0117038>] (__warn+0xbc/0xd4)
> [   69.880161] [<c0117038>] (__warn) from [<c01170b0>] (warn_slowpath_fmt+0x60/0xb8)
> [   69.880231] [<c01170b0>] (warn_slowpath_fmt) from [<bf010130>] (__media_pipeline_stop+0x24/0xfc [mc])
> [   69.880318] [<bf010130>] (__media_pipeline_stop [mc]) from [<bf010228>] (media_pipeline_stop+0x20/0x2c [mc])
> [   69.880419] [<bf010228>] (media_pipeline_stop [mc]) from [<bf08fc48>] (fimc_cap_streamoff+0x38/0x48 [s5p_fimc])
> [   69.880582] [<bf08fc48>] (fimc_cap_streamoff [s5p_fimc]) from [<bf040bf4>] (__video_do_ioctl+0x220/0x448 [videodev])
> [   69.880776] [<bf040bf4>] (__video_do_ioctl [videodev]) from [<bf041600>] (video_usercopy+0x114/0x498 [videodev])
> [   69.880895] [<bf041600>] (video_usercopy [videodev]) from [<c0205024>] (ksys_ioctl+0x20c/0xa10)
> [   69.880939] [<c0205024>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> [   69.880958] Exception stack(0xe50c1fa8 to 0xe50c1ff0)
> [   69.880997] 1fa0:                   004ef08d bec188c0 00000003 40045613 bec165ac 00517d16
> [   69.881040] 1fc0: 004ef08d bec188c0 bec188c0 00000036 bec165ac 00000000 b6def320 bec18af8
> [   69.881070] 1fe0: 00539ed4 bec15718 004ef0bb b6f84d0a
> [   69.881089] ---[ end trace d004ab573a72c32a ]---
> [   69.881102] ------------[ cut here ]------------
> [   69.881163] WARNING: CPU: 0 PID: 1566 at drivers/media/mc/mc-entity.c:556 media_pipeline_stop+0x20/0x2c [mc]
> [   69.881174] Modules linked in: s5p_fimc v4l2_fwnode exynos4_is_common videobuf2_dma_contig videobuf2_memops v4l2_mem2mem brcmfmac videobuf2_v4l2 pvrsrvkm_s5pv210_sgx540_120 videobuf2_common hci_uart sha256_generic btbcm libsha256 bluetooth cfg80211 ce147 brcmutil s5ka3dfx ecdh_generic ecc libaes videodev atmel_mxt_ts mc pwm_vibra rtc_max8998
> [   69.881367] CPU: 0 PID: 1566 Comm: v4l2-ctl Tainted: G        W         5.7.0-14540-gb1220848c797-dirty #681
> [   69.881381] Hardware name: Samsung S5PC110/S5PV210-based board
> [   69.881424] [<c010c7c4>] (unwind_backtrace) from [<c010a120>] (show_stack+0x10/0x14)
> [   69.881465] [<c010a120>] (show_stack) from [<c0117038>] (__warn+0xbc/0xd4)
> [   69.881511] [<c0117038>] (__warn) from [<c01170b0>] (warn_slowpath_fmt+0x60/0xb8)
> [   69.881580] [<c01170b0>] (warn_slowpath_fmt) from [<bf010228>] (media_pipeline_stop+0x20/0x2c [mc])
> [   69.881683] [<bf010228>] (media_pipeline_stop [mc]) from [<bf08fc48>] (fimc_cap_streamoff+0x38/0x48 [s5p_fimc])
> [   69.881834] [<bf08fc48>] (fimc_cap_streamoff [s5p_fimc]) from [<bf040bf4>] (__video_do_ioctl+0x220/0x448 [videodev])
> [   69.882025] [<bf040bf4>] (__video_do_ioctl [videodev]) from [<bf041600>] (video_usercopy+0x114/0x498 [videodev])
> [   69.882246] [<bf041600>] (video_usercopy [videodev]) from [<c0205024>] (ksys_ioctl+0x20c/0xa10)
> [   69.882291] [<c0205024>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
> [   69.882309] Exception stack(0xe50c1fa8 to 0xe50c1ff0)
> [   69.882348] 1fa0:                   004ef08d bec188c0 00000003 40045613 bec165ac 00517d16
> [   69.882391] 1fc0: 004ef08d bec188c0 bec188c0 00000036 bec165ac 00000000 b6def320 bec18af8
> [   69.882420] 1fe0: 00539ed4 bec15718 004ef0bb b6f84d0a
> [   69.882439] ---[ end trace d004ab573a72c32b ]---
>
> With the final trace being the original one that I was having.
>
> So it looks to me as if streamoff is being called twice.  Is this a possibility for all drivers
> or is there a different bug that I should be trying to track down?  In any event, my patch does
> prevent the warning (although my reasoning was wrong as I thought it was being stopped on the
> call to release).

It certainly is possible for the userspace call STREAMOFF twice and
the driver needs to ensure that the second call is essentially a
no-op, as per [1]. FWIW, if the driver defers the stream start/stop
operation entirely to the vb2 .start/stop_streaming callback, then vb2
would handle this automatically.

[1] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/vidioc-streamon.html#description

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
