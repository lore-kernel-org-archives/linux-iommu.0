Return-Path: <SRS0=Jdo0=25=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39E9C00523
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 09:16:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE1920705
	for <iommu@archiver.kernel.org>; Wed,  8 Jan 2020 09:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie6mnSQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE1920705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1E2C38671A;
	Wed,  8 Jan 2020 09:16:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G9hwtwuDqzxK; Wed,  8 Jan 2020 09:16:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9A933866BD;
	Wed,  8 Jan 2020 09:16:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8796CC1D81;
	Wed,  8 Jan 2020 09:16:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84368C0881
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 09:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 72DF785BA7
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 09:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QtYpE1hAbVg5 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jan 2020 09:16:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D289A85A70
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jan 2020 09:16:52 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C672C20705;
 Wed,  8 Jan 2020 09:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578475012;
 bh=+IAbT80Thjb7cm6WAP8wRkhDBitTa05E7byZ57Le5ag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ie6mnSQIZ0/Cmh6ez45IJInqQwaokWY9MDyBZqRTZNt5uTgXRFmVAd2hNSM9uN3ID
 y/12CJS7TUfkeqVSwEDmyPF/a5pSrE4SVd4XYt+znN6uP71KT5adACbICf8qRxpEXp
 AQXOt9SNrLgS1q631MX+fnpE/s46nKozLm/TcjSk=
Date: Wed, 8 Jan 2020 09:16:42 +0000
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 0/3] iommu/arm-smmu: Qualcomm bootsplash/efifb
Message-ID: <20200108091641.GA15147@willie-the-truck>
References: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191226221709.3844244-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Patrick Daly <pdaly@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 treding@nvidia.com, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Pratik Patel <pratikp@codeaurora.org>
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

On Thu, Dec 26, 2019 at 02:17:06PM -0800, Bjorn Andersson wrote:
> These patches implements the stream mapping inheritance that's necessary in
> order to not hit a security violation as the display hardware looses its stream
> mapping during initialization of arm-smmu in various Qualcomm platforms.
> 
> This was previously posted as an RFC [1], changes since then involves the
> rebase and migration of the read-back code to the Qualcomm specific
> implementation, the mapping is maintained indefinitely - to handle probe
> deferring clients - and rewritten commit messages.

I don't think we should solve this in a Qualcomm-specific manner. Please can
you take a look at the proposal from Thierry [1] and see whether or not it
works for you?

Thanks,

Will

[1] https://lore.kernel.org/lkml/20191209150748.2471814-1-thierry.reding@gmail.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
