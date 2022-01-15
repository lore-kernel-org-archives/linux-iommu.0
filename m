Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F04C433FE
	for <iommu@archiver.kernel.org>; Sat, 15 Jan 2022 07:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99CED82B24;
	Sat, 15 Jan 2022 07:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eu1rc12u5SMl; Sat, 15 Jan 2022 07:50:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70D3182B1E;
	Sat, 15 Jan 2022 07:50:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43F28C0077;
	Sat, 15 Jan 2022 07:50:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2B04C002F
 for <iommu@lists.linux-foundation.org>; Sat, 15 Jan 2022 07:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89FC660AA9
 for <iommu@lists.linux-foundation.org>; Sat, 15 Jan 2022 07:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHzfAMrzvID6 for <iommu@lists.linux-foundation.org>;
 Sat, 15 Jan 2022 07:50:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F17F360879
 for <iommu@lists.linux-foundation.org>; Sat, 15 Jan 2022 07:50:32 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id q186so15582752oih.8
 for <iommu@lists.linux-foundation.org>; Fri, 14 Jan 2022 23:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to:cc;
 bh=h3PgS0CNglNFEriFcIB5fPEGJsKvjMbV56HeR6dLGrE=;
 b=EmUyNC5+fyl6EfcWg7V5NP/+/kTDIH/EdOvuowOUADAQekSeyTVMo2Pw+R7MGnNyr3
 5F8QHuI+3uuwmjE0hhIplcSf2WL7/QNRQcOV1244KFMSs7KyWUA1l2Wf6ku/ze8CULMO
 JrK0FD1KD6O13Y02WDkLJ8qPwwJwBY8Rk79Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to:cc;
 bh=h3PgS0CNglNFEriFcIB5fPEGJsKvjMbV56HeR6dLGrE=;
 b=64W1f02+T6h5zwSgwCn5XrWPtlQZT/OU1DR8qxTP5+Qs9BP5BsYUp0VvdmzTK/LQch
 AfcRCfu+qPXduq+S+uhVpw0saBc3Bv+kI2SJPtPZJb/zN0aJbp0EZef4NowoWs3afVlC
 jFABWPrfQLWwHpM3bxWaL8SkPP+CDU/LL4QQo4N/r30zkLEZrLUbiqkY1+YA/18v+c/G
 n6x3+dXl0t/bsgehhQubOEOHiQ9BB6TIsj4uNtJGRBS7+I1u1j/vLMcFXuq/n9QmBXEz
 iYdS9ax61ewyhL8W+8VcLG7gyUzA51B+UDG0crYST7Qqrbv1uf9J/GRKXd2zZ6Pis/qm
 VcQg==
X-Gm-Message-State: AOAM533ald6qQfLKkGQGdpUlyMaO5bqBx1mYPsfHNEUsLe+D7FruUahP
 fCYfVKeYX82UoIsmcfJPnuuEQ+ppM/UIz5BBbi2EMA==
X-Google-Smtp-Source: ABdhPJx02kIfoT6/5m/ATyYIlU8INhZ26iHsr9xTblSQKWo5tlo36oAirP0TSNUr8dUl4s8qhL52VFzPwIS7Yj/lE4c=
X-Received: by 2002:aca:a953:: with SMTP id s80mr15972957oie.164.1642233032027; 
 Fri, 14 Jan 2022 23:50:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jan 2022 01:50:31 -0600
MIME-Version: 1.0
In-Reply-To: <fc7207eb9958c487fec5679da73d8f3595cc7bb1.camel@mediatek.com>
References: <20220106214556.2461363-1-swboyd@chromium.org>
 <20220106214556.2461363-26-swboyd@chromium.org>
 <1a3b368eb891ca55c33265397cffab0b9f128737.camel@mediatek.com>
 <CAE-0n53Y3WRy4_QvUm9k9wjjWV7adMDQcK_+1ji4+W25SSeGwg@mail.gmail.com>
 <ff81bc1fe1f1c2060fcf03ba14f1bef584c47599.camel@mediatek.com>
 <CAE-0n53FAHDmCznJ35Xh2aTwXBVwukAM3ioKx8SU9VowSaQSqA@mail.gmail.com>
 <69a10908622512c60790f97942731a8ab989b727.camel@mediatek.com>
 <CAE-0n53ao52UX3sJ67UQ3dgj0-DZ0xTeo-NrmW5YVAuXfAnxZw@mail.gmail.com>
 <fc7207eb9958c487fec5679da73d8f3595cc7bb1.camel@mediatek.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Sat, 15 Jan 2022 01:50:31 -0600
Message-ID: <CAE-0n52kPPXuZH8srbQXC6iPpaM_+2Qewn6-HQ0RNKMxi5Jdsg@mail.gmail.com>
Subject: Re: [PATCH v5 25/32] iommu/mtk: Migrate to aggregate driver
To: Yong Wu <yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, Saravana Kannan <saravanak@google.com>,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>,
 freedreno@lists.freedesktop.org
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

Quoting Yong Wu (2022-01-14 23:39:52)
> On Fri, 2022-01-14 at 15:30 -0600, Stephen Boyd wrote:
> >
> > This sounds more correct to me. I'm not an expert on runtime PM
> > though
> > as I always have to read the code to remember how it works. if the
> > device isn't ready for runtime PM until the component bind function
> > is
> > called then runtime PM shouldn't be enabled on the component device.
>
> Anyway, We should update the SMI driver for this case. I prepare a
> patch into this patchset or I send it independently? which way is
> better?

I can roll it into this patch. It needs to be combined otherwise it
breaks the bisectability of the series.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
