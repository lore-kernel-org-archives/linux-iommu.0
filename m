Return-Path: <SRS0=NhDI=NJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC81C4338F
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:17:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4FD860EBC
	for <iommu@archiver.kernel.org>; Wed, 18 Aug 2021 12:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4FD860EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 984AC40495;
	Wed, 18 Aug 2021 12:17:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jUqqKln9ryHU; Wed, 18 Aug 2021 12:17:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4CE30401EA;
	Wed, 18 Aug 2021 12:17:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 284AFC0010;
	Wed, 18 Aug 2021 12:17:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8902C000E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBAFE80DD7
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:17:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FV30FadX2ARL for <iommu@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 12:17:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5975680DD6
 for <iommu@lists.linux-foundation.org>; Wed, 18 Aug 2021 12:17:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B800D60EBC;
 Wed, 18 Aug 2021 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629289053;
 bh=CZPSQOPLHFuQ1gMyYK8CP6eURya3PWKd1E/lhAdfdUc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=imjXuahxGZGSd/+xlu3297dl/h+/JuqnCVridoGkm/iUxNBwTpRv2By2C9Scpc+w8
 ockFFJmNp0ZTbhEWZSIl6zTF9HksMcYuPJT3UJz6A3fshm/2C31JIGi/rdSMkwaGjn
 NaLzTmSTaV/YHludpmGM17IE6tslvMIthjKcINmJx9CQEk8yjGMGPDE7LstQ0zAHIi
 v8zP3HYKbdKM2XP8cPphkYiFiL5UKsswWuNL1iNBLbfGo7M7iSQZWqVa7joch9IqG/
 2GBKKr4HZTa85iaiRChC45KQpU+cy1UtMz3mYlkVKzzXq2XzEkn7IFyII7NghVQG2z
 RfWkInsOvQV9w==
Date: Wed, 18 Aug 2021 13:17:29 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.15
Message-ID: <20210818121728.GB14107@willie-the-truck>
References: <20210813164735.GA8765@willie-the-truck>
 <YRz4OemrkIcDxCC5@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YRz4OemrkIcDxCC5@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kernel-team@android.com, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Aug 18, 2021 at 02:08:25PM +0200, Joerg Roedel wrote:
> On Fri, Aug 13, 2021 at 05:47:35PM +0100, Will Deacon wrote:
> > This applies cleanly against iommu/next, but I suspect it will conflict
> > with Robin's series on the list. Please shout if you need anything from
> > me to help with that (e.g. rebase, checking a merge conflict).
> 
> For now there were at least no conflicts which git couldn't resolve
> automatically, but the compile tests are still running :)

Ok, I won't hold my breath!

> > The following changes since commit ff1176468d368232b684f75e82563369208bc371:
> > 
> >   Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> So this is pulled now, thanks.

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
