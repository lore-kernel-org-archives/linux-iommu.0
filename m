Return-Path: <SRS0=dyvA=XI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BD6C4CEC5
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1E6206A4
	for <iommu@archiver.kernel.org>; Fri, 13 Sep 2019 21:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1E6206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AD8FFE91;
	Fri, 13 Sep 2019 21:58:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AF52BE2A
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 21:58:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
	[209.85.167.193])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4EFF681A
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 21:58:11 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id a127so3923982oii.2
	for <iommu@lists.linux-foundation.org>;
	Fri, 13 Sep 2019 14:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=AQ3PXKKEYAPpTNJc/PTOp8Ob+kx8WcDFX3XJj1y+xiY=;
	b=DH3d/a9mC2xZiDzmgqcUDSDC8A++SBk7fmRj5vAg91VgxIKZceZIzeJlciD1YVXhNV
	2WLCvdDGK4gLRdr3sydYki/m7mfC04ot0tL0mFkMynJsXvvGDnlIsJWRfsf2jy+Z0at0
	ZIeOjBU8HcOiZB3heYHWa1704Vc229YAVa/nadBDO3pKRClOPIwFRV0+TUxt3hbfoETv
	5SLjDawTL+aZbTj6F94PktdGNFruwSf+lrj7ZHczOhygSVAgfIEsYlWJR1H8GvD4kQAt
	o8CKeStCRpG2D5wMZAOrzOOniUq+IzKNH7PL9UzIA7sIfLNPtaRB/rCV41a5JwWblXqU
	Ol4A==
X-Gm-Message-State: APjAAAUrCXsqdsNLtEUSe7OniUnbv39sFrFkFYbdM5RWSIvBv703TzMw
	FOM05WUdsJXekuX7AUCIQw==
X-Google-Smtp-Source: APXvYqwcvObB3Yb/Y4El/uikyKAQB52Tnw3hLnBRUoI7ZLHlgxb3ip7OrKPwaxSV60bB8sfAR8RFlA==
X-Received: by 2002:a05:6808:b19:: with SMTP id
	s25mr5498975oij.126.1568411890436; 
	Fri, 13 Sep 2019 14:58:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
	[24.155.109.49]) by smtp.gmail.com with ESMTPSA id
	34sm11938701ots.47.2019.09.13.14.58.09
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 13 Sep 2019 14:58:09 -0700 (PDT)
Date: Fri, 13 Sep 2019 16:58:09 -0500
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
	non-negative cell_count
Message-ID: <20190913215809.GA11833@bogus>
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
	<20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Sat, 24 Aug 2019 15:28:46 +0200, =3D?UTF-8?q?Uwe=3D20Kleine-K=3DC3=3DB6n=
ig?=3D          wrote:
> Referencing device tree nodes from a property allows to pass arguments.
> This is for example used for referencing gpios. This looks as follows:
> =

> 	gpio_ctrl: gpio-controller {
> 		#gpio-cells =3D <2>
> 		...
> 	}
> =

> 	someothernode {
> 		gpios =3D <&gpio_ctrl 5 0 &gpio_ctrl 3 0>;
> 		...
> 	}
> =

> To know the number of arguments this must be either fixed, or the
> referenced node is checked for a $cells_name (here: "#gpio-cells")
> property and with this information the start of the second reference can
> be determined.
> =

> Currently regulators are referenced with no additional arguments. To
> allow some optional arguments without having to change all referenced
> nodes this change introduces a way to specify a default cell_count. So
> when a phandle is parsed we check for the $cells_name property and use
> it as before if present. If it is not present we fall back to
> cells_count if non-negative and only fail if cells_count is smaller than
> zero.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/of/base.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> =


Applied both patches, thanks.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
