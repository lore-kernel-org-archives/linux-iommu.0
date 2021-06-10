Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADCDC47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 17:30:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD08613FF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 17:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD08613FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D62C060A3F;
	Thu, 10 Jun 2021 17:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l7MYhMWpm3Yy; Thu, 10 Jun 2021 17:30:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3F4160664;
	Thu, 10 Jun 2021 17:30:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9503EC000D;
	Thu, 10 Jun 2021 17:30:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42B24C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 17:30:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3129A40118
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 17:30:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qU4ADrB5ylRT for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 17:30:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 63968400F3
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 17:30:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66855600EF;
 Thu, 10 Jun 2021 17:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623346205;
 bh=tpFhPjG7Nz3ReCCibgwvR7yqQCAmWIcVdLql5PiyI1o=;
 h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
 b=pMUdQh0kuxs8yhs+HZlpxAe4L84jne5MuYxI+9l/Z7RCT/y7qAMG073V+JHpiI6mf
 pOSF2BkSB5aU1QcrO40W0OjKbQzct1YRK1EyiY2dr3QdlqeKV9dh59+AKxCLSWT60o
 yqGmbNhjtqtfJSpzT6fvP1oLK8xu/ch4Vl3YnMbghNR0cEs1J34H6Mws964zapULTU
 DlljZys0Rd3om9zUQsp53C1DHOcBKAbSGbtNdfllh1oEf4GbKKvC4FVosHc1b4fHdf
 JFA706zXRqUhf3PE08fJEmyEwmPnVNVPtCiANYRoCnBVpvNqZLTIbH1znRkufnw/Pu
 Q3tj1ZYJcqGQQ==
Date: Thu, 10 Jun 2021 18:29:59 +0100
From: Will Deacon <will@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
Message-ID: <20210610172958.GA14188@willie-the-truck>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
 <20210608120128.GB10174@willie-the-truck>
 <YL+A+MPjjaa3nSwq@orome.fritz.box>
 <20210608164851.GB10994@willie-the-truck>
 <YMHZCaRiQNQCSsVr@orome.fritz.box>
 <8c18edeb-2e3e-9072-6bb4-11637d0ca3e5@canonical.com>
 <YMIqNynz29Z9fYi3@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMIqNynz29Z9fYi3@orome.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <soc.lore.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, soc@kernel.org,
 arm@kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
 iommu@lists.linux-foundation.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Thu, Jun 10, 2021 at 05:05:27PM +0200, Thierry Reding wrote:
> On Thu, Jun 10, 2021 at 04:23:56PM +0200, Krzysztof Kozlowski wrote:
> > On 10/06/2021 11:19, Thierry Reding wrote:
> > > On Tue, Jun 08, 2021 at 05:48:51PM +0100, Will Deacon wrote:
> > >> I can queue as much or as little of 2-6 as you like, but I would like to
> > >> avoid pulling in the memory controller queue into the arm smmu tree. But
> > >> yes, whichever of those I take, I can put them on a separate branch so
> > >> that you're not blocked for the later patches.
> > >>
> > >> You have a better handle on the dependencies, so please tell me what works
> > >> for you. I just want to make sure that at least patch 3 lands in my tree,
> > >> so we don't get late conflicts with other driver changes.
> > > 
> > > Yes, if you could pick up patch 3 and send out a link with the stable
> > > branch, I think Krzysztof or I could pull in that branch and pick up the
> > > remaining patches. It'd be good if you could also ack the remaining SMMU
> > > patches so that ARM SoC knows that they've been sanctioned.
> > > 
> > > Krzysztof: would you be okay with picking up patches 2 and 4-6 on top of
> > > your memory branch for v5.14?
> > 
> > You mean the iommu patches? Yes, I can take them and later explain to
> > Arnd/Olof why they come through me.
> 
> Okay, great.
> 
> Will, can you provide that stable branch? Or would you prefer if I
> prepared it and sent you a pull request? We're kind of running out of
> time, since for ARM SoC the cut-off point for new material is usually
> -rc6 and that's coming up pretty fast.

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-thierry/arm-smmu

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
