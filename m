Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1910FC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 05:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE0C5408D4;
	Wed, 16 Feb 2022 05:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c_-zCwXgUVgF; Wed, 16 Feb 2022 05:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 813E6408C1;
	Wed, 16 Feb 2022 05:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5490FC001A;
	Wed, 16 Feb 2022 05:59:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02292C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6C36408D4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:59:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0u5kzynP1ZeL for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 05:59:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 27DB0408C1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:59:20 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id r9so1190505qta.1
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 21:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CDBQKjrOHx1jFqanGpjTZz0mkLi+B8rGvMm6ZK2mah0=;
 b=ANYaNLWFCQkj69oiskZkSh6DjZmPGeiq9PrEgU2cP3v3dn1nkwLwYm7cx+4vS6oOKw
 RwNzEIyq3NLxuuxq6/pXX241+VkGVJtb86AlOXZXiNaOF+o9MwFTZ3Ial6STIS1UiAA5
 dhBgfFPAMgGgTKfxv7tknbGcdLXT5auCslnVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CDBQKjrOHx1jFqanGpjTZz0mkLi+B8rGvMm6ZK2mah0=;
 b=5bUKmtXINlrTk+Ik8MW1qfW9eUv9hKwl9HUtgf6yrsta6Us9lonyCzKWQ6EZqnIj0L
 WWmy1ixP8OzFHXx0aqOZuBBcPdn64jEyKDqRX/+XBzRDi8zW1BhUqwl41f/FlraEnue9
 fR44E0Ii8TU5pDyHr0J/XmNS7BK7UIdTlxHB181zN9dKYP8Ql7egx43kb93dzZZ3gcOK
 nIwnG9Dd+nNCrZRWFsKoyrjpbI9eNP0JOv0iX8NegDEV8NTHWJzWoqk6TKilsl7TwLjB
 yX6ESK4qVYKaDv8whyyfGTvFCPHOxu/AHeq2Cl981NMzgpv0SuvEwEcTnVQaoYQ1kLFl
 LXqw==
X-Gm-Message-State: AOAM531ISj7iTcnxYIxUY/XC+L3V8swuzD8u4kXF5shiTV8QUZr3ki4H
 Pq+gHnhk6V+fKcKjfQ+/XwNlu4e1MqiW02KP
X-Google-Smtp-Source: ABdhPJykz/9kNkGz3sTp5JSAIKRqX76X0B4HGjWPFdoaxH/nSyZHOeIuSPp4aFaIfJyyYKC0NKOQYA==
X-Received: by 2002:ac8:5c8a:0:b0:2dc:e1a6:72f2 with SMTP id
 r10-20020ac85c8a000000b002dce1a672f2mr1032451qta.50.1644991158821; 
 Tue, 15 Feb 2022 21:59:18 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com.
 [209.85.219.176])
 by smtp.gmail.com with ESMTPSA id j15sm21641981qta.83.2022.02.15.21.59.16
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 21:59:17 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id y129so2851693ybe.7
 for <iommu@lists.linux-foundation.org>; Tue, 15 Feb 2022 21:59:16 -0800 (PST)
X-Received: by 2002:a0d:c383:0:b0:2d0:f04e:7ada with SMTP id
 f125-20020a0dc383000000b002d0f04e7adamr1070020ywd.229.1644991156422; Tue, 15
 Feb 2022 21:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-9-yong.wu@mediatek.com>
 <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
 <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
In-Reply-To: <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 16 Feb 2022 14:59:05 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
Message-ID: <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/35] iommu/mediatek: Use kmalloc for protect buffer
To: Yong Wu <Yong.Wu@mediatek.com>
Cc: yf.wang@mediatek.com, yen-chang.chen@mediatek.com,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 xueqi.zhang@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org,
 chengci.xu@mediatek.com, libo.kang@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Wed, Feb 16, 2022 at 2:55 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Thu, 2022-01-27 at 12:08 +0100, AngeloGioacchino Del Regno wrote:
> > Il 25/01/22 09:56, Yong Wu ha scritto:
> > > No need zero for the protect buffer that is only accessed by the
> > > IOMMU HW
> > > translation fault happened.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> >
> > I would rather keep this a devm_kzalloc instead... the cost is very
> > minimal and
> > this will be handy when new hardware will be introduced, as it may
> > require a bigger
> > buffer: in that case, "older" platforms will use only part of it and
> > we may get
> > garbage data at the end.
>
> Currently this is to avoid zero 512 bytes for all the platforms.
>
> Sorry, I don't understand why it is unnecessary when the new hardware
> requires a bigger buffer. If the buffer becomes bigger, then clearing
> it to 0 need more cost. then this patch is more helpful?
>
> The content in this buffer is garbage, we won't care about or analyse
> it.

I think we should zero it for security reasons regardless of any other
aspects. With this patch it's leaking kernel data to the hardware.

At the same time, we're talking here about something executed just 1
time when the driver probes. I don't think the cost would really
matter.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
