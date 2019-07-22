Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47418C76190
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 16:24:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C342190F
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 16:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnzCgtP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C342190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BDBCEDA7;
	Mon, 22 Jul 2019 16:24:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5E3FCACC
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 16:24:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB288775
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 16:24:00 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id k8so41124759eds.7
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 09:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=3hF/yndw/9iMn5LkMnQIXmMVSvMqJPR1brEffSYKm5A=;
	b=KnzCgtP91QMek3camJEsYfFRzzhuY4Ww/kLXQ31e1jHO+Ezf8mtZJ1b/1iPepH5PzA
	WLLtRKyA5QthErKxn2tF0Gp0gca80dViEGu/6oN7tEaFWByHj6r+IEwyftgUsNkIOpHl
	JAUlt9nmfr6P5a/kge2fwtxnHsSv2e1+E6SfgC3Tnn0ICjHm/4bMEpCZEzQiQrPCpaCW
	GHHNZ0VKd7LuZ/87R8EIRqfsE6HY8J5t9Ll0BvPzxanzyUbqzeB2GTKZSim73zw4T0pA
	JVrnux0f6lCz8yxLBPH+cwJVhcAanqTqw8Lr6c/6k3uMPn1grsr3ZDG534fKF4wPVAX8
	JMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=3hF/yndw/9iMn5LkMnQIXmMVSvMqJPR1brEffSYKm5A=;
	b=Z8uTvLy/Y/Nl9nc2/xfZUzcUJ6ahIE53IEvOKkN5jDlQor+KcHg/mKCYlu946uOd6j
	vwXiaNwQI4gzNm/gVOJs6nu1vsdoIvRm53cbeP/nJQ866qaR+TTbJnU68cEC5BrsjLoX
	CSWKEJyiY2kotsB/2SnDt9CZtZ3iRZBz6yW3mKoEdNBdt3frJk/uuE1uolsrllwv34Ff
	yd9tDSR8o/JWNaByRp+LgQs/w9pA6Fdv83tEhINZRe56X8YovpucrYhOMPwGzTSl0+R7
	KC4U1NkUtByIDeauzwG+3xCxo03pFCX9uV3gjkYyFYIE/vzIKuUppKxoKPnjBAA5dxE4
	QZ4Q==
X-Gm-Message-State: APjAAAUfNGCYxIQms/qz4Xx+KphIQ8XpK8ejALFZ1ng0HG3ofeV7ogN7
	qOay91QIo3U/kD86AW/UaB53/mRJyr0jvTofA8w=
X-Google-Smtp-Source: APXvYqxvnE7n6rBYLjaXH+rbNyXf18kfTJLS/GQKcpYfbikX6ihBKV75fxCtNZ4ZQvBC7LjyrvO+CjV4KyuaPK440ZM=
X-Received: by 2002:a17:906:3612:: with SMTP id
	q18mr55088125ejb.278.1563812639299; 
	Mon, 22 Jul 2019 09:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190702202631.32148-2-robdclark@gmail.com>
	<20190710182844.25032-1-robdclark@gmail.com>
	<20190722142833.GB12009@8bytes.org>
	<CAF6AEGvJc2RK3GkpcXiVKsuTX81D3oahnu=qWJ9LFst1eT3tMg@mail.gmail.com>
	<20190722154803.GG12009@8bytes.org>
In-Reply-To: <20190722154803.GG12009@8bytes.org>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 22 Jul 2019 09:23:48 -0700
Message-ID: <CAF6AEGvWf3ZOrbyyWjORuOVEPOcPr+JSEO78aYjhL-GVhDZnTg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: add support for drivers that manage iommu
	explicitly
To: Joerg Roedel <joro@8bytes.org>
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Robin Murphy <robin.murphy@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Will Deacon <will@kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Mon, Jul 22, 2019 at 8:48 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Mon, Jul 22, 2019 at 08:41:34AM -0700, Rob Clark wrote:
> > It is set by the driver:
> >
> > https://patchwork.freedesktop.org/patch/315291/
> >
> > (This doesn't really belong in devicetree, since it isn't a
> > description of the hardware, so the driver is really the only place to
> > set this.. which is fine because it is about a detail of how the
> > driver works.)
>
> It is more a detail about how the firmware works. IIUC the problem is
> that the firmware initializes the context mappings for the GPU and the
> OS doesn't know anything about that and just overwrites them, causing
> the firmware GPU driver to fail badly.
>
> So I think it is the task of the firmware to tell the OS not to touch
> the devices mappings until the OS device driver takes over. On x86 there
> is something similar with the RMRR/unity-map tables from the firmware.
>

Bjorn had a patchset[1] to inherit the config from firmware/bootloader
when arm-smmu is probed which handles that part of the problem.  My
patch is intended to be used on top of his patchset.  This seems to me
like the best solution, if we don't have control over the firmware.

BR,
-R

[1] https://www.spinics.net/lists/arm-kernel/msg732246.html
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
