Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DCCC4360C
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:46:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A71207E0
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 12:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A71207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 099BDBA0;
	Thu, 26 Sep 2019 12:46:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 412CEB2F
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:46:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
	[209.85.167.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8345B108
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 12:46:06 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id t84so1925091oih.10
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 05:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=xbUM+zwEckrsI9HdGsT66xud/A2/3/zcfZM8ljcjHEU=;
	b=nea39d5vIR6XWQMNV9FqDowCDBifo8bHL9w2g+ak5y1m8XYgth0RhjPxdqqy0vhYpD
	9rPnVjdG5Z2zG206YOj1B39Thbc6Mj4PiHAwDJU5DEs9OeyrUk1YiZVHlTVMcCQrOWy5
	36qfVY9kdL2MvPQfe2o2zDRBqjXirSOoWS7AcXtEPUiqWVTGsT4OuivcI8kz0fekrL75
	/Ejf5b3HnVg0TvrFf9VYJoR4bb7L07EYbOS66OuRJdF0iM7CpbJben/nStQ4Qg3XCXC1
	whLJ39Pel1vZKQiKYtqWuIE3Mh2EhFD7J9hH0vD6GDQ8jbaux15Wi4irB6jlkkrrEzBj
	zRPA==
X-Gm-Message-State: APjAAAXuYP/3HVxKCHuwWY1iwZ0YxXUTi1Y1ofM2Q4xxYK4asIeEmiZY
	IqOS9DOUqnggAcaf7buucvCXc6WAMGi3zRYB8DQ=
X-Google-Smtp-Source: APXvYqwHTnDQZ58LKu/l0rzoOT57MVy7pjRDqoXCr++7HLhzRiD6176jKB+p/Uigj4usCCBKIrtVZjRRqNLSnhijyKU=
X-Received: by 2002:aca:dad4:: with SMTP id r203mr2548202oig.102.1569501965706;
	Thu, 26 Sep 2019 05:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <1569310854-37057-1-git-send-email-biju.das@bp.renesas.com>
In-Reply-To: <1569310854-37057-1-git-send-email-biju.das@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Sep 2019 14:45:54 +0200
Message-ID: <CAMuHMdWtH=1FAx=QNNxRV4YCmnRUNqwTUjr7-dRcQwCxtt5yDA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iommu: ipmmu-vmsa: Add r8a774b1 support
To: Biju Das <biju.das@bp.renesas.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms@verge.net.au>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Fabrizio Castro <fabrizio.castro@bp.renesas.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Sep 24, 2019 at 9:41 AM Biju Das <biju.das@bp.renesas.com> wrote:
> Document RZ/G2N (R8A774B1) SoC bindings.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
