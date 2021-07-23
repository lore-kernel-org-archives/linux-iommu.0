Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F2C4320E
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 12:21:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48B960F12
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 12:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A48B960F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 633038284B;
	Fri, 23 Jul 2021 12:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mgx5FCGa6uXu; Fri, 23 Jul 2021 12:21:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 72B1382A0B;
	Fri, 23 Jul 2021 12:21:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 490F9C001A;
	Fri, 23 Jul 2021 12:21:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAAA6C000E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 12:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCD0E82A0B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 12:21:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id owVS_WWbZMyk for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:21:36 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 650E38284B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 12:21:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28E5A60ED7;
 Fri, 23 Jul 2021 12:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1627042895;
 bh=9ttASHB3pgtVphs5ThtFEDTZUlMESs+xc3gYhWNXu7s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=w8IhHX/JqYeqrily4pkMsNcEcIDmcxFfFNBZXaGyZTBjf6hUdb/ck+vVeZvSyXSp+
 SmMMlgNE+z41L+q3vq6Sk5Fwc81ryx7vTXKK32xXimXI+vBPYpfZxeJ1mnXRrLK540
 yRVB2mJ+xoqZQgiFMdQEszARPi6wZbMnytYLkBrg=
Date: Fri, 23 Jul 2021 14:21:33 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPq0Td5ZDNVwvQ8r@kroah.com>
References: <20210707045320.529186-1-john.stultz@linaro.org>
 <YPgK50dmV7Z69WsL@kroah.com>
 <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALAqxLUVgUT+1DyDGsFbF0138S0OYzpKADk__PsYbR4B4mbMhw@mail.gmail.com>
Cc: Maulik Shah <mkshah@codeaurora.org>, Saravana Kannan <saravanak@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@codeaurora.org>,
 Todd Kjos <tkjos@google.com>
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

On Wed, Jul 21, 2021 at 10:24:01AM -0700, John Stultz wrote:
> On Wed, Jul 21, 2021 at 4:54 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> > > Allow the qcom_scm driver to be loadable as a permenent module.
> >
> > This feels like a regression, it should be allowed to be a module.
> 
> I'm sorry, I'm not sure I'm following you, Greg.  This patch is trying
> to enable the driver to be able to be loaded as a module.

Ah, sorry, you are right, my mistake.

nevermind...
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
