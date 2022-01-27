Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7489CC433EF
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 00:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDB8341B4E;
	Thu, 27 Jan 2022 00:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlpgoI-rmFKs; Thu, 27 Jan 2022 00:40:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72E0441B38;
	Thu, 27 Jan 2022 00:40:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6ECC0039;
	Thu, 27 Jan 2022 00:40:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87A5AC000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 00:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 61EE984E75
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 00:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key)
 header.d=fireburn-co-uk.20210112.gappssmtp.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U40qG4Fmc8ig for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 00:40:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B2D708346C
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 00:40:01 +0000 (UTC)
Received: by mail-qk1-x729.google.com with SMTP id g145so1239168qke.3
 for <iommu@lists.linux-foundation.org>; Wed, 26 Jan 2022 16:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rwlNx81LiyFXyY2iciGppDMPGoQO0US7JaL+W5wXP58=;
 b=FXix/soSwU5v3gDBYEnHIbcLiXjS+z0b2IBt1TlYAQo0DYeI+gqpxsTbKUZkHtZor8
 kW43pCeC0nP0416RbhbheeDsWkcndx6ktLU0kiQAZlB1C/xdBdlG+WvHZqciDNDlDbXK
 mnqKMdtgjxtcjBEf9c/9P2rRNKh0wcIYu+SlTZjj/TvzydH4I6ji7BNn0dWCLntMxEoH
 AGh5qBdHvW7mQvH5vwouZCB0BTXncXA7u1U5phyfIYC3EZCufC2ZAvtzaYaYrSdxyCxR
 4xHG86igYNCGA3T1zpMWsMa5IddRXhhWMzGkCtRi/qOmkc/Wvdmm4IddVrCU93nRVwGX
 xtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rwlNx81LiyFXyY2iciGppDMPGoQO0US7JaL+W5wXP58=;
 b=uXreYfimAfE2a0RjTYfsNTwmoF7//c9SFphyBiobyAf2AjZhkLE6WGf6Hq1Qxq/QcN
 d3yg79QFzA1pw+3GPKbpeUmDvBVm00+Mqem976djF6nZEIVj9/ZJC6Nj6xD45r8b9FLO
 UPwxegPynH4eStYEP3HYQAIYj9EveYqIfAaf0qgABmDl6hzoqjcjaNuCMheMvHVzKw+v
 rR8UkmGDt3Cdp13ORuP9DJPl1HY0FFwa0ATFgxe3va2HIQt6kUb4RmKI333bmvQnvXaF
 02tHL4czqzy/y/PE5z1TljhnZ3/fI01B+LSjaO82XrBePhCOa87axqyoJGI96E5RdfDl
 aJyg==
X-Gm-Message-State: AOAM5317MHPRazykd93MTkajtV7SyeQ9nsokmo2Vwg+EVR1RGsZun6x2
 UtC3+95fbnuDddcowbHkdlu+SELxJyKAb2yenvEKZg==
X-Google-Smtp-Source: ABdhPJxoJIaDg64lKmnPqG5v33p5Dj2sAajlkAuYc2b76Z34AsFMlB48cJqznS8KGBD+3fj8q2AfDNHyu/oJBJykz6k=
X-Received: by 2002:a05:620a:1511:: with SMTP id
 i17mr1071037qkk.77.1643244000582; 
 Wed, 26 Jan 2022 16:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20211123161038.48009-1-mlevitsk@redhat.com>
 <20220125150832.1570-1-mike@fireburn.co.uk>
 <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
 <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
 <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
 <CAHbf0-F8Uemcu8FVcZvY0CPOf4kFXOcaCzWF1ZCwkpa3tyut3A@mail.gmail.com>
 <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
In-Reply-To: <6cf58a4cd925726ef10481d38f9f4e8090f5023d.camel@redhat.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 27 Jan 2022 00:39:49 +0000
Message-ID: <CAHbf0-EY9_27Tw3v-pfwXDaTuwpsuuFqrJDKZ8C_cW+-PwXwww@mail.gmail.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 tglx@linutronix.de, will@kernel.org, dwmw@amazon.co.uk
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

On Wed, 26 Jan 2022 at 10:12, Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> Great, your system does seem to support GA log
> (but a patch to check if, other that assume blindly that it is supported is
> something that should be done).
>
> So could you bump the LOOP_TIMEOUT like by 10x or so and see if the problem goes away?
>
> (that code should be rewritten to time based wait and not just blindly loop like that,
> I also can prepare a patch for that as well).
>
> Best regards,
>         Maxim Levitsky
>

Hi

I've done quite a few restarts with the LOOP_TIMEOUT increased and
I've not seen the issue since

Cheers

Mike
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
