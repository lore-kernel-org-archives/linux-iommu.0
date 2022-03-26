Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFFFC433F5
	for <iommu@archiver.kernel.org>; Sat, 26 Mar 2022 22:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40C37818EC;
	Sat, 26 Mar 2022 22:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BNE71JiAmtN6; Sat, 26 Mar 2022 22:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2EAFF818CA;
	Sat, 26 Mar 2022 22:48:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE49BC001D;
	Sat, 26 Mar 2022 22:48:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 870F3C0012
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70ADF818EC
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KmmbvjVWtxkV for <iommu@lists.linux-foundation.org>;
 Sat, 26 Mar 2022 22:47:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 63529818CA
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 22:47:58 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id c15so14595640ljr.9
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lSLy1cPxoDC//3e7623ZX4es74MP3w4cCLgF29j5fUU=;
 b=HTqOpqutn/t7/GJQrakk/gAhabnVwnukxwMtMja/1SljWHCaJh+ZhMav3V4OqLq1/m
 JldSGIs54yIcMbIeQmTLdzLUuMQeARuWCJqZUzEEphC4IEXZ9NChSkH88YY0FSWwPQJu
 U24K7ZOq8FQZ2yFFgeY8MWj+ZVkdrqhAUb3Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lSLy1cPxoDC//3e7623ZX4es74MP3w4cCLgF29j5fUU=;
 b=28pOrJkF5EIC5apFT1luqP5kn/GlhsLO6tkYjFgWBzS6e2e5uHV7JKz1r6X/J47j+o
 rRglNlXEoP0ZzRVx28c3Wn5lueNdH6sn3Qqoai1qzOT8unzkW5ZstF+U/X0p4r2T0AHg
 HBT1YCjsyGaE+YyKkm8tQfoWoqaIZOOw3nUchhRjm6OQ1/oSE8baDmUE94t7WYUpRtL6
 RoIu56ZsCRcyk+eERbdbBm8RXmg7YLXNm7eQ8Utnrzq6yJFQShMGm86EFEVMhQ6ukeZL
 zfyLql5eFgTgQ2BfZLE/nn+92mHzas3WAoemY7sdsXV59nQOXBCGd0QIAUqQ6YReNMlv
 g87g==
X-Gm-Message-State: AOAM532BL9u/xjaIokeYXEfNobDtKyeay4ehuOcoFJHNeQOmckOGLsRt
 rlvGGFdeLnkDEpKbtebMLk0Wwg76hKFFajx6vhldLQ==
X-Google-Smtp-Source: ABdhPJwNzdd/39pxsZgdRKdyXUE3HrSLwdPjqj0UD+N/mXWKL9XvUnOW1+eNohsD4CD7Zib7bdg1sw==
X-Received: by 2002:a2e:6808:0:b0:249:1738:5cd0 with SMTP id
 c8-20020a2e6808000000b0024917385cd0mr13411551lja.174.1648334875636; 
 Sat, 26 Mar 2022 15:47:55 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181]) by smtp.gmail.com with ESMTPSA id
 i15-20020ac25d2f000000b004484a530b07sm1191943lfb.143.2022.03.26.15.47.55
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Mar 2022 15:47:55 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id g24so14593154lja.7
 for <iommu@lists.linux-foundation.org>; Sat, 26 Mar 2022 15:47:55 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr13805287lfu.542.1648334517200; Sat, 26
 Mar 2022 15:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
 <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <cce202fb-5185-aa3e-9e9b-11626192cb49@arm.com>
 <20220326003853.44c3285c.pasic@linux.ibm.com>
 <8735j47l7y.fsf@toke.dk>
 <CAHk-=wjorwZTQuQB8QBgNpdBZNz7uyprgaTT+1Q6_1FaT3sAmQ@mail.gmail.com>
 <d9fbd3ab9b514b0d8121d4d7d21662a6@AcuMS.aculab.com>
In-Reply-To: <d9fbd3ab9b514b0d8121d4d7d21662a6@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Mar 2022 15:41:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgqHqb_yaNUGwMfLJJw28VvauSB6sSMCi3Bu7Q0-N0GEQ@mail.gmail.com>
Message-ID: <CAHk-=wgqHqb_yaNUGwMfLJJw28VvauSB6sSMCi3Bu7Q0-N0GEQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: David Laight <David.Laight@aculab.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Mar 26, 2022 at 3:38 PM David Laight <David.Laight@aculab.com> wrote:
>
> Is the idea of 'buffer ownership' even a good one?

I do think it might be best to not think in those terms, but literally
just in data movement terms.

Because the "buffer ownership" mental model is clearly confused, when
data transfer might be ongoing, but the CPU might need to just look at
"what's going on right now" without actually taking any ownership of
the buffer.

                Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
