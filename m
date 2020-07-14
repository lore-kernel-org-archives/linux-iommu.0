Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B025AC433F1
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 12:39:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7694D22453
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 12:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7694D22453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 19DD189F0A;
	Tue, 14 Jul 2020 12:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UDi6dGhTslLb; Tue, 14 Jul 2020 12:39:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 267AF89EF8;
	Tue, 14 Jul 2020 12:39:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10D56C0888;
	Tue, 14 Jul 2020 12:39:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 653D3C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 12:39:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BD838A27B
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 12:39:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSM50PDn11oV for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 12:39:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4C15F8A279
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 12:39:51 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id 5so12866563oty.11
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 05:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1gkM+uPTnitshLBuV08goagb6Ra5DyU+s9EwRHXtZeQ=;
 b=Za5qYW1pV1a1PbxqLnfNQ+0pt2c6C+7+bcsD0ea440qQcwRdFRbQ9Fu7hZsU4e/3hD
 MDi6pMQNgmWafnyWIjjaihEbgBnegRhHfs4sG5lh/j+DwNVcK8fkjMCJNhIMH90qUg1g
 z66AGe3ES3xMIY8hevllRt1zjIkKmUv5YJawfnxK5gMcQCX8e3cO35+R3pf8uaOcH0vd
 tPGaJ6CEYrgHlURpSN1Gli18xglM+DU8GnmWdizYUGy7DXPkf1BSmPn/n8GfOo8e7J5t
 pOahdMNqDX03uJyj3yxaTezzjeYeO2xUAagXQyxdU7n9vaKONuRDONqUuanExvNU0sQo
 WuSA==
X-Gm-Message-State: AOAM533D0tYcxQhDC8ViXXurVmS/Q5gtDhOiXPKuVhpBcaBg7B641Kc4
 Is9gno4KycVjrlTz014vzEKYQSrrHfkX7HIjAlc=
X-Google-Smtp-Source: ABdhPJwQEGIYICCEl9+rMfVmtnnA3KEy1Oav7DAM0WyYTDfpBWgrg5GEkZrfN+c/weUUf5GnvXRjVxzrNetFysb/vow=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr3637009otb.107.1594730390491; 
 Tue, 14 Jul 2020 05:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV4zzrk_=-2Cmgq8=PKTeU457iveJ58gYekJ-Z8SXqaCQ@mail.gmail.com>
 <CA+V-a8tB0mA17f51GMQQ-Cj_CUXze_JjTahrpoAtmwuOFHQV6g@mail.gmail.com>
 <CAMuHMdXM3qf266exJtJrN0XAogEsJoM-k3FON9CjX+stLpuMFA@mail.gmail.com>
 <TY2PR01MB3692A868DD4E67D770C610E3D8610@TY2PR01MB3692.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB3692A868DD4E67D770C610E3D8610@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Jul 2020 14:39:39 +0200
Message-ID: <CAMuHMdUry12MnLvVgmd7NJ+Gv4mA86qKKfsQobP1o-ohzKm=RQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 netdev <netdev@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, "Lad,
 Prabhakar" <prabhakar.csengg@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 dmaengine <dmaengine@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
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

Hi Shimoda-san,

On Tue, Jul 14, 2020 at 1:42 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> > From: Geert Uytterhoeven, Sent: Tuesday, July 14, 2020 5:42 PM
> > On Tue, Jul 14, 2020 at 10:30 AM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Tue, Jul 14, 2020 at 9:09 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Mon, Jul 13, 2020 at 11:35 PM Lad Prabhakar
> > > Also the recent patch to add
> > > "r8a77961" just adds to soc_rcar_gen3_whitelist.
> >
> > Oops, commit 17fe16181639801b ("iommu/renesas: Add support for r8a77961")
> > did it wrong, too.
>
> Thank you for the point it out. We should add r8a77961 to the soc_rcar_gen3[].
> However, I don't know why I could not realize this issue...
> So, I investigated this a little and then, IIUC, glob_match() which
> soc_device_match() uses seems to return true, if *pat = "r8a7796" and *str = "r8a77961".

Are you sure about this?
I enabled CONFIG_GLOB_SELFTEST, and globtest succeeded.
It does test glob_match("a", "aa"), which is a similar test.

To be 100% sure, I added:

--- a/lib/globtest.c
+++ b/lib/globtest.c
@@ -59,6 +59,7 @@ static char const glob_tests[] __initconst =
        "1" "a\0" "a\0"
        "0" "a\0" "b\0"
        "0" "a\0" "aa\0"
+       "0" "r8a7796\0" "r8a77961\0"
        "0" "a\0" "\0"
        "1" "\0" "\0"
        "0" "\0" "a\0"

and it still succeeded.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
