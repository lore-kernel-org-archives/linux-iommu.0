Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64CC31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 17:39:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59873217D6
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnFmAH1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59873217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 216E812D8;
	Fri, 14 Jun 2019 17:39:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DB7EA1167
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 17:39:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
	[209.85.166.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 81A4AE5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 17:39:52 +0000 (UTC)
Received: by mail-io1-f67.google.com with SMTP id k8so7631149iot.1
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 10:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=pyNZh3/ZiJGCHGyK6bSxYhhEMHeQph+kYYlr649t5fI=;
	b=fnFmAH1S+PAJamnF3NqeGjNJKLKabKSrwIeQ4EWJOLeaxDi+l9iEip4OJmJBE4s4L5
	t9EWMjkoX75msS90FvzStnVp/1AD3CIo70/WhRleVWjKXaqS3APRMAJECm+XcYadU/ix
	NoYetrWGQsDpipp5CJSmFksF4KKmbPS+G5fi+ZUtKbo2GXH7BN59YlDslJywgc2SS+gy
	7nSTV2khtyZxk64W+L6RLIHRhrh19JY6SbxYGhrM4ZCTDfu5g2mtLUyNnQtuaUcGndFD
	fG4rYx3xyR8Rc02ZTzSUJSrO3nLpuK/4ZfzmIZPbx6Ud+dlFALl7B/IX0ZD07hvzgrFQ
	PnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=pyNZh3/ZiJGCHGyK6bSxYhhEMHeQph+kYYlr649t5fI=;
	b=aQALVc35opn7hEcDLMnCRK9BnClrkvmR8Vx/noffXMy3OzD2eLJMRaNT78ksKoeBDz
	TzMIN91KNHiRF5Xf7YBa2H8enufyVvMbSbdlCPf1+cYMJmjBz3EY1PyGNlBfJC1bUIBZ
	XaW+BsvVI8hRM2258prtWIzI4PHIObFwgL8zkhz0QRY7VAyeB/F/WzNigBs7cKk2aKM+
	ol63r6PLp6C/QKJr5FakWvi+1qcT6u8P3dv+lQr6z8AXD3AjuJozGWpzvcpyJtBsx6N3
	xeM7T94AMGgyxNqfWvBVoeroEJjrMM8D6S+XKacCqAkPs+/FjD+TdiaG0ayL31qyoJhI
	sCWQ==
X-Gm-Message-State: APjAAAUotyk8b6880ncsLEKeNdUArqv0T3VO1dkJrHO8joZk4m0e6Wof
	ZhYBkkHHKSUmqL7yqRab23KxfrdQarTzTnVV8PY=
X-Google-Smtp-Source: APXvYqwNZ0eXs3p92pVUhwtqOL0humBUMj2IEaTDc3AAW0U+hb04I4VnHxh86HS27ouhORHP6iTBY8v4nEVPMWiA21c=
X-Received: by 2002:a02:9567:: with SMTP id y94mr69763782jah.28.1560533991898; 
	Fri, 14 Jun 2019 10:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190613162703.986-1-tiny.windzz@gmail.com>
	<20190614071245.GA2950@infradead.org>
In-Reply-To: <20190614071245.GA2950@infradead.org>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Sat, 15 Jun 2019 01:39:40 +0800
Message-ID: <CAEExFWupzjErW1E0z3tcR2xyGgpWXwgLZOTqvru4=hk98EfGhQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] iommu/exynos: convert to SPDX license tags
To: tglx@linutronix.de
Cc: linux-samsung-soc@vger.kernel.org,
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
	agross@kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
	David Brown <david.brown@linaro.org>, kgene@kernel.org,
	Thierry Reding <thierry.reding@gmail.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	robin.murphy@arm.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Need me to make them a patch?

MBR,
Yangtao
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
