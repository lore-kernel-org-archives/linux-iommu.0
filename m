Return-Path: <SRS0=jTem=TI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B806C04A6B
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 18:11:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFB220850
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 18:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm2N3nQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFB220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6CF3CEB9;
	Wed,  8 May 2019 18:10:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 0FFC5E75
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 18:10:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
	[209.85.214.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B739187B
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 18:10:24 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id y3so10309446plp.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 08 May 2019 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=5zLWZfJCoIg5TeUT0Jt2rwSpfAhD7R9q7eCYI7YHf40=;
	b=Tm2N3nQ5R4MhS+8rDGVu/boYYfOVT9eIZUs60lgVugsa12xyjFshqIWhczZyFQwzYF
	Ym9H3mmMhQzLUib+TUxO5mS0LpNapV2Zy81WXsYoFwNV+rdA6rOEnixV+TXKtAggW5lK
	QDSEMsjaxPVnY6u3e/z7047pG6rP96Ay9RL1uwxSRF/22zO+7kd1MqxLXfdrrhPThSRA
	mY7VHAWoPNgVv22UCIzmgaNRexxreIebf/jobba8vTVTF9A1vGdOTUvINtIZ8Ly5Xsib
	JDr4j9KfbpUyW4/2fktvOOqSl8/YIGfpKUC/87WCEwPw7Dh3+HZrmyWQrHn3UotZRAP4
	vOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=5zLWZfJCoIg5TeUT0Jt2rwSpfAhD7R9q7eCYI7YHf40=;
	b=qXKr0FmMDLy8j9HeIwhdL+Mm3apnjORwCmHsA1ylwmQxrO1KueD5JatbcDqHNLDKev
	1W3gtAZWd5QsMQ0chrRhE/mva3efG+BgUYr36lrsx7W5QedNCIVVdzM/gj0sNG5Hort7
	evQDwqq6E6B9LdKuKX/uWUqHT1h12wgsu0Bx4c7nYaZHQMvtquCK1o+LXVeAv6v8DyiC
	fMOjY3I5jLKPZ9s0DlNDfb6vnzkUTf19lFJgIfcarW6odP96T1keVv1KUk4KiOe21/fH
	BT9VRe8mPXIggArd1fhiGFw2Cq/SM+sLcyrQmTpww8/Ox7whqcr/Wxi10Qg+T40MKaLP
	/+AQ==
X-Gm-Message-State: APjAAAWgi/ZzLvNGvtgpkMZN/8Inj+icsvDKS4eB5jJSvWwQpg7lyu+Q
	/9MDEmOmOpRw0orO+WYEKcQ=
X-Google-Smtp-Source: APXvYqx2Wb4CB0KCpVy419mUcctEXRtv9dVAdNA+TWZj7LlWHc7EV1/KC6TAZsJVn2A5r991XqqT8A==
X-Received: by 2002:a17:902:5ac9:: with SMTP id
	g9mr14087995plm.134.1557339023983; 
	Wed, 08 May 2019 11:10:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	j189sm31400665pfc.72.2019.05.08.11.10.22
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 08 May 2019 11:10:23 -0700 (PDT)
Date: Wed, 8 May 2019 11:08:53 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] Optimize dma_*_from_contiguous calls
Message-ID: <20190508180852.GA2298@Asurada-Nvidia.nvidia.com>
References: <20190506223334.1834-1-nicoleotsuka@gmail.com>
	<20190508125254.GA26785@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190508125254.GA26785@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, keescook@chromium.org,
	sfr@canb.auug.org.au, tony@atomide.com, catalin.marinas@arm.com,
	will.deacon@arm.com, linux@armlinux.org.uk,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	jcmvbkbc@gmail.com, wsa+renesas@sang-engineering.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
	treding@nvidia.com, robin.murphy@arm.com, dwmw2@infradead.org,
	linux-arm-kernel@lists.infradead.org
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

On Wed, May 08, 2019 at 02:52:54PM +0200, Christoph Hellwig wrote:
> modulo a trivial comment typo I found this looks fine to me.  I plan
> to apply it with that fixed up around -rc2 time when I open the
> dma mapping tree opens for the the 5.3 merge window, unless someone
> finds an issue until then.

Thanks for the help all the way.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
