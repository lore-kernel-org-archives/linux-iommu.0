Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7977AC43217
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 16:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 15A1C83F84;
	Tue, 31 May 2022 16:15:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hoHgOCEqBHPv; Tue, 31 May 2022 16:15:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E44E483F28;
	Tue, 31 May 2022 16:15:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF6D7C0039;
	Tue, 31 May 2022 16:15:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6246C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:15:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C36A460E8A
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:15:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3h04BAmniNb for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:15:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0CFF560C21
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 16:15:22 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id r129so3017302wmr.3
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yTwbDkRh5hDmKjnX326/H9mLZmvE5gWxqRme+WbiGTU=;
 b=Rru3PwBplI26UVmu4AXwOX9WpBcGD4aIv0VSI8ypmKBntq8oSPd9BEv9TniUq1iLvp
 YBRmDAhwsRw8pp75B5ILEfiMaxPMxFGFKGYBrb6SdwRv/QNuPZoYyxcce5ElLzRkxNYS
 PAvH8P2D8UU78DqlF9etOWjlmopXtvn1GEUjdUucWxPaWHKbHyys0MMKV6e0HLLoqF2r
 LFt+T/F5phreLYp1vMgOVXGeX8tXiA0JYKNoFZyqLbu6auPuzF943C8foHaaN0qnMqjx
 gJjP8I6Pne2uobs/BDW2AAVT39AxR7/ICC7vlZxIolKQUDFOn6MJVnfuJfovNUwZhil3
 PnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yTwbDkRh5hDmKjnX326/H9mLZmvE5gWxqRme+WbiGTU=;
 b=v0IZ/doCUMslVcY6jDMlVGmBVztjtzwfTBP6GRCuCeMLUW8ol/OUO6+ALAb2XaVeOY
 5no9LxEoGfUExBv+4OmKNGV4eAL4uOyngbYg98Nkocx+Zt3kRhYx6rePM3alev52APfy
 QUpzOxTwJH9SGYmBP2AOmsl5rMdPWwxB74oeRWbwcyS4P+3Hd7Dx4dSoxCuDS5aU0zqw
 9jLfao8f890cGdAZ5sI178Y2Z/iwIizsDgZRIWzI6qoknFh0OroDdgQ9PEbxIdO9qgjz
 LD5nF4qeu0UixpnIpqvqp6OLVCZ6HzByvqyJ3oENCL/ebSV7eWCzj26mb8+l4FzJ/FeP
 6zxw==
X-Gm-Message-State: AOAM533yZ0UjCtdhx/pqmCSU1S/pRBZARtA60NGDEc0B6M4L2qU5EK3M
 Cq63Fw3baJBnsO2+59n+Vnpl/xoYekJRNxn2bYw=
X-Google-Smtp-Source: ABdhPJw8TmZisoYJQb2SVHP2J/XSkZSzLw0bfkiAV9h8OY9eEHr/k33ODPPnsIXrdwWQH0cYw+WJ2+TymTyZCKqRUgQ=
X-Received: by 2002:a7b:c5d0:0:b0:389:fe85:3d79 with SMTP id
 n16-20020a7bc5d0000000b00389fe853d79mr24898741wmk.77.1654013721128; Tue, 31
 May 2022 09:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220527212901.29268-1-konrad.dybcio@somainline.org>
 <20220527212901.29268-2-konrad.dybcio@somainline.org>
 <20220531154631.GA25502@willie-the-truck>
In-Reply-To: <20220531154631.GA25502@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 31 May 2022 09:15:22 -0700
Message-ID: <CAF6AEGsWsHfQZnszG=NgP0BufxO-DP4LwvsAYkrz2wRhcJuOXw@mail.gmail.com>
Subject: Re: [PATCH 1/6] iommu/qcom: Use the asid read from device-tree if
 specified
To: Will Deacon <will@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 jamipkettunen@somainline.org, Rob Herring <robh+dt@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andy Gross <agross@kernel.org>, Martin Botka <martin.botka@somainline.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
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

On Tue, May 31, 2022 at 8:46 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, May 27, 2022 at 11:28:56PM +0200, Konrad Dybcio wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >
> > As specified in this driver, the context banks are 0x1000 apart.
> > Problem is that sometimes the context number (our asid) does not
> > match this logic and we end up using the wrong one: this starts
> > being a problem in the case that we need to send TZ commands
> > to do anything on a specific context.
>
> I don't understand this. The ASID is a software construct, so it shouldn't
> matter what we use. If it does matter, then please can you explain why? The
> fact that the context banks are 0x1000 apart seems unrelated.

I think the connection is that mapping from ctx bank to ASID is 1:1

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
