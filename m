Return-Path: <SRS0=YfIy=NA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F8DC4320A
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 14:54:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D85060C41
	for <iommu@archiver.kernel.org>; Mon,  9 Aug 2021 14:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D85060C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D48F5401BF;
	Mon,  9 Aug 2021 14:54:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd8veOPxQBip; Mon,  9 Aug 2021 14:54:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C816C40181;
	Mon,  9 Aug 2021 14:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A658FC0010;
	Mon,  9 Aug 2021 14:54:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2131EC000E
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 14:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 10BF26058B
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 14:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HtcLFYnjhIVj for <iommu@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 14:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8DEC6600CC
 for <iommu@lists.linux-foundation.org>; Mon,  9 Aug 2021 14:54:25 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1060361019;
 Mon,  9 Aug 2021 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628520865;
 bh=bmXVwPlv6jk+hRMVAM5D4Cs70KB/HmWxl8NzlqT1h3Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V7uTiTy2Kf1c07ZG3hdoJ0Z0CAd7XAPl8BYfYNci13TAph9dskWb7jRojZJIntqy0
 Z5TLF+8ycGekFWW2v+N94vRD3YKFQkQAWZc9PsE2q4D+uJsXpTQL6LQk1iS+yn2U6p
 8awKSOLddbyn7XQ3tCY5bqnVPkJIdkv7DE97jO1qJP/EY6E8rEyWfLhp+k9B6cgdQ4
 mgvkx/fnD/U32LrnmYk6XDiYt6z5v7N/Qzkp3hBvMw0+m4LZ9uEGD9Ypj553UiVlU+
 xY1Ik/3nNsdT7bs14C5m1wF3tXjF3bCgTpB/4hnVAEg3TXDHF4aMEKzroKESa84wSz
 LoNspFqPTrubw==
Date: Mon, 9 Aug 2021 15:54:20 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
Message-ID: <20210809145420.GB1458@willie-the-truck>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
 <20210802151607.GF28735@willie-the-truck>
 <9c38c53c-c145-097a-4c7e-40f1c06a1f01@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c38c53c-c145-097a-4c7e-40f1c06a1f01@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Ashish Mhetre <amhetre@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 02, 2021 at 04:46:37PM +0100, Robin Murphy wrote:
> On 2021-08-02 16:16, Will Deacon wrote:
> > On Fri, Jun 18, 2021 at 02:00:35AM +0530, Ashish Mhetre wrote:
> > > Multiple iommu domains and iommu groups are getting created for the devices
> > > sharing same SID. It is expected for devices sharing same SID to be in same
> > > iommu group and same iommu domain.
> > > This is leading to context faults when one device is accessing IOVA from
> > > other device which shouldn't be the case for devices sharing same SID.
> > > Fix this by protecting iommu domain and iommu group creation with mutexes.
> > 
> > Robin -- any chance you could take a look at these, please? You had some
> > comments on the first version which convinced me that they are needed,
> > but I couldn't tell whether you wanted to solve this a different way or not.
> 
> Sorry, I was lamenting that this came to light due to the
> of_iommu_configure() flow being yucky, but that wasn't meant to imply that
> there aren't - or couldn't be in future - better reasons for
> iommu_probe_device() to be robust against concurrency anyway. I do think
> these are legitimate fixes to make in their own right, even if the current
> need might get swept back under the rug in future.
> 
> I would say, however, that the commit messages seem to focus too much on the
> wrong details and aren't overly useful, and patch #2 is missing Ashish's
> sign-off.

Ashish -- please can you send a v3 fixing these issues?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
