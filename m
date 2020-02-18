Return-Path: <SRS0=Yw80=4G=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447C1C3403D
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 14:27:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C06208C4
	for <iommu@archiver.kernel.org>; Tue, 18 Feb 2020 14:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C06208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D5143843DB;
	Tue, 18 Feb 2020 14:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dWC8sOmwvV3q; Tue, 18 Feb 2020 14:27:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DA9981153;
	Tue, 18 Feb 2020 14:27:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11C0BC1D84;
	Tue, 18 Feb 2020 14:27:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91017C013E
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 14:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7FE5D8564D
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 14:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C3U7yaMgFp_t for <iommu@lists.linux-foundation.org>;
 Tue, 18 Feb 2020 14:27:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8ED8D85521
 for <iommu@lists.linux-foundation.org>; Tue, 18 Feb 2020 14:27:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1B931FB;
 Tue, 18 Feb 2020 06:27:23 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5089C3F6CF;
 Tue, 18 Feb 2020 06:27:22 -0800 (PST)
Subject: Re: [PATCH v2] iommu/qcom: fix NULL pointer dereference during probe
 deferral
To: Stephan Gerhold <stephan@gerhold.net>
References: <20200104002024.37335-1-masneyb@onstation.org>
 <fc055443-8716-4a0e-b4d5-311517d71ea0@arm.com>
 <20200218120435.GA152723@gerhold.net>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4ed8542a-40fe-ae34-4203-efbcf285d784@arm.com>
Date: Tue, 18 Feb 2020 14:27:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200218120435.GA152723@gerhold.net>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bjorn.andersson@linaro.org,
 agross@kernel.org, j.neuschaefer@gmx.net,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Brian Masney <masneyb@onstation.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 18/02/2020 12:04 pm, Stephan Gerhold wrote:
[...]
> Are you going to send a patch for the diff below?
> AFAICT this problem still exists in 5.6-rc2.
> 
> Your patch also seems to fix a warning during probe deferral on arm64
> that has been around for quite a while. (At least for me...)
> 
> (See https://lore.kernel.org/linux-iommu/CA+G9fYtScOpkLvx=__gP903uJ2v87RwZgkAuL6RpF9_DTDs9Zw@mail.gmail.com/)

Ha, I did see that and vaguely remembered a discussion about that 
warning logic being broken, but I'd totally forgotten I was involved to 
that extent :)

Luckily I've managed to track the diff down in my Git stash, so I'll 
write it up properly - thanks for the reminder!

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
