Return-Path: <SRS0=u5nN=W5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E31C3A59E
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 14:26:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D52421881
	for <iommu@archiver.kernel.org>; Mon,  2 Sep 2019 14:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D52421881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 29066CC6;
	Mon,  2 Sep 2019 14:26:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 15865C77
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 14:26:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7F734709
	for <iommu@lists.linux-foundation.org>;
	Mon,  2 Sep 2019 14:26:42 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id t16so14242291wra.6
	for <iommu@lists.linux-foundation.org>;
	Mon, 02 Sep 2019 07:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to:user-agent;
	bh=ot30V47/iBS0yHDmKdi6h92CwtoqCpzSIGyUdC23LBs=;
	b=gkV4Kdx8MtHyE80MW2ajVykhxooN7TA5ejExya4QwvatfIhKjcdAGIrFKj98V72Xfg
	S1dWzYrOzNI5cP8THhaDuy06Vc6MmNHAQs8Mkdi1+aXUhm9aVqqMomqF0Ve9CXTjfh0f
	8AjUGvO+r3DePT9xMZD3pjKWql4e3yaBKemnnwum7IUlyl4aCOdhMMTAXuqrBBjDj/gR
	XVUn1JGi6Kri2hJdYYjXvT51jSAA/ttMeEnPXtoVed/IAiBmbonrkr/z12UgRQZS+/IR
	txJhqhEyaVAWAGxinHYVaKedh4jUkeSsHR4feLcTxiS8RM90jursmtZKCtNdwaSBHj62
	0xVw==
X-Gm-Message-State: APjAAAX4D6+O2aVgkgjL0yLpnWC9xBnWjmDs8LBM0SLSyJ3JVSITwtEP
	ANWkqveM6nZuvEwaXyH78Q==
X-Google-Smtp-Source: APXvYqwrcoUbjAf10BUlLBhioq2RZCRuSUEHDKWeG20TWt9K0tZHjtvEfqHEbFfZ7g0NKNH+PmgRKg==
X-Received: by 2002:a5d:6811:: with SMTP id w17mr1391676wru.181.1567434400948; 
	Mon, 02 Sep 2019 07:26:40 -0700 (PDT)
Received: from localhost ([212.187.182.166]) by smtp.gmail.com with ESMTPSA id
	h125sm33788405wmf.31.2019.09.02.07.26.40
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 02 Sep 2019 07:26:40 -0700 (PDT)
Date: Mon, 2 Sep 2019 15:26:39 +0100
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
	non-negative cell_count
Message-ID: <20190902142639.GA13947@bogus>
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

On Sat, Aug 24, 2019 at 03:28:46PM +0200, Uwe Kleine-K=F6nig wrote:
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

Looks fine to me. I can apply with an ack from the iommu folks on patch =

1.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
