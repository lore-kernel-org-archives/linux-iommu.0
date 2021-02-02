Return-Path: <SRS0=s4mY=HE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAC2C433E9
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 13:53:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231E96505C
	for <iommu@archiver.kernel.org>; Tue,  2 Feb 2021 13:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231E96505C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D47912046B;
	Tue,  2 Feb 2021 13:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dtWEhqOtKDuY; Tue,  2 Feb 2021 13:53:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 88FD220341;
	Tue,  2 Feb 2021 13:53:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73A50C0174;
	Tue,  2 Feb 2021 13:53:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B13B6C013A
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ACBDC8666D
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:53:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jfCWYa2BAz8Z for <iommu@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 13:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 69D1E863E0
 for <iommu@lists.linux-foundation.org>; Tue,  2 Feb 2021 13:53:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADCFF65055;
 Tue,  2 Feb 2021 13:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612274027;
 bh=iPWZ1a3GkBhhRcShqTp5ZRZgLWTVYizimDRPKo1F5vE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=djcoWc+AVlGkEO7ARJv0skxY6a4S2x4ZqbYna+fHmImYOY2bu81rQvD3Dhdj3Byeg
 fV0NaSQghBkXstj9/GJn/PRNCY7eSA5GZdPmYi1Iojkns3YeRac/Z5STEoT3OE6Eke
 kqtznJv2R4F0bZxZPvOr7GlAENose8caFcjSrPabrz7psZXwy75XuIwXNPF0tQIBcE
 roGP5p9X7yL4PcxzCkNfsOFd2tO9dsS94x+LR6M4edHLkXYaTlO/uA14vHeWvRePDR
 e6X+sswn61SmmqYlqMdMJib9FFscH7QjX8pJ3ibnhWVyDrfN1dizctTBhW2zlhGCAW
 zasSdszXjylag==
Date: Tue, 2 Feb 2021 13:53:41 +0000
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.12
Message-ID: <20210202135339.GC17070@willie-the-truck>
References: <20210201154633.GC15263@willie-the-truck>
 <20210202133456.GT32671@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202133456.GT32671@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

On Tue, Feb 02, 2021 at 02:34:56PM +0100, Joerg Roedel wrote:
> On Mon, Feb 01, 2021 at 03:46:33PM +0000, Will Deacon wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> Pulled, thanks Will.

Cheers, Joerg. Doug spotted a thinko in one of the patches, so you'll want
to apply this guy on top:

https://lore.kernel.org/r/20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
