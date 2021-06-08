Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED15C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B0961246
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B0961246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 973A2402D4;
	Tue,  8 Jun 2021 12:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Id4EOfj4gDDo; Tue,  8 Jun 2021 12:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F10C40291;
	Tue,  8 Jun 2021 12:01:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BE6CC000E;
	Tue,  8 Jun 2021 12:01:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16808C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBD23402A0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oHSwXfOxOz7L for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:01:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B76C40291
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:01:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8803F6124B;
 Tue,  8 Jun 2021 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623153695;
 bh=10kEx6AcAb1DYOk5Z6m1G6xVwL5MwyY7cY33NxXwLrk=;
 h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:From;
 b=SsQvAaGqZQb0LBQkPOgCYXgFcwAzPujSZ9KfEoKR2ol/qWGjWOO0/5QWAIV1Nby01
 ldU+xg2RfpyZ+zgoSh9GhsheHlKWppU6Id+1y2pL5i9xvqYExqOs87KOsxgxLr/7UW
 sbwdIBNinAwa1J3B+8/VlKzTDmQSTVMFEF5OqNE4kOJqiaDu5Yz3ZcK8r8C0HARXZG
 N/h6RlBfSY/yHUTuWvTzrp2NpBDYGmJHPYHwEl+xJlR81jnwMkii+oY9IXCq7uiKtC
 1BAqX28wPSxTAR+OKpRNiQwf/C4g0reY51q2Gu5B5gxseGadAbg5uYFvFL5UKfPO2q
 uXMooaZOHunxg==
Date: Tue, 8 Jun 2021 13:01:29 +0100
From: Will Deacon <will@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [GIT PULL] memory: Tegra memory controller for v5.14
Message-ID: <20210608120128.GB10174@willie-the-truck>
References: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607084910.21024-1-krzysztof.kozlowski@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <soc.lore.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, soc@kernel.org,
 arm@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>,
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

Hi Krzysztof, Thierry,

On Mon, Jun 07, 2021 at 10:49:10AM +0200, Krzysztof Kozlowski wrote:
> Hi Thierry and Will,
> 
> This is the pull for you to base further SMMU aptches (prevent early SMMU
> faults).

This is a tonne of code for me to pull into the SMMU tree given that I only
want one patch!

Thierry, if I just stick:

https://lore.kernel.org/r/20210603164632.1000458-4-thierry.reding@gmail.com

on its own branch, can you stitch together whatever you need?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
