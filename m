Return-Path: <SRS0=85So=MN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0161BC636C9
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 11:54:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC212610D2
	for <iommu@archiver.kernel.org>; Wed, 21 Jul 2021 11:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC212610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 733B7401B6;
	Wed, 21 Jul 2021 11:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4liQJdW3NDKU; Wed, 21 Jul 2021 11:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 527C840144;
	Wed, 21 Jul 2021 11:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1C19C001A;
	Wed, 21 Jul 2021 11:54:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F374FC000E
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E117040157
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFQKFyA1qx4u for <iommu@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 11:54:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A241B40144
 for <iommu@lists.linux-foundation.org>; Wed, 21 Jul 2021 11:54:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 793C561029;
 Wed, 21 Jul 2021 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626868458;
 bh=/2R8FyLulO5rrqukg2m/b0q3W8lFktNyD1tz1yDdULM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NvnrAsLkF0Yx7FXryc0oSbfvjzA+R6bv6PEZ4+PA/Mk/wZCPz9BpZHas8eeEvNVxZ
 DNZGUWUGAYK86Ef/lQA26aJ9wc73nJvy3/kCl9TVxFnk98AFvQSv8kPrE4HON7+pvR
 WEGCxlS4UISR0xAcEsSBs2jXXi1/BRdakyDREFBE=
Date: Wed, 21 Jul 2021 13:54:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH] firmware: QCOM_SCM: Allow qcom_scm driver to be loadable
 as a permenent module
Message-ID: <YPgK50dmV7Z69WsL@kroah.com>
References: <20210707045320.529186-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210707045320.529186-1-john.stultz@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>, Saravana Kannan <saravanak@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, lkml <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, linux-gpio@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
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

On Wed, Jul 07, 2021 at 04:53:20AM +0000, John Stultz wrote:
> Allow the qcom_scm driver to be loadable as a permenent module.

This feels like a regression, it should be allowed to be a module.

> This still uses the "depends on QCOM_SCM || !QCOM_SCM" bit to
> ensure that drivers that call into the qcom_scm driver are
> also built as modules. While not ideal in some cases its the
> only safe way I can find to avoid build errors without having
> those drivers select QCOM_SCM and have to force it on (as
> QCOM_SCM=n can be valid for those drivers).
> 
> Reviving this now that Saravana's fw_devlink defaults to on,
> which should avoid loading troubles seen before.

fw_devlink was supposed to resolve these issues and _allow_ code to be
built as modules and not forced to be built into the kernel.

Let's not go backwards please.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
