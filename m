Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF8BC433E2
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:22:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4394F207F9
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7qT433B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4394F207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 000EC8A5BF;
	Thu, 16 Jul 2020 10:22:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CCzOXV7ME2yH; Thu, 16 Jul 2020 10:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 84A4C8A5BE;
	Thu, 16 Jul 2020 10:22:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B089C07FF;
	Thu, 16 Jul 2020 10:22:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD29BC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B4B8E8AFEF
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zVA96MdVEcJe for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 10:22:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 44DB68AFEC
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:22:38 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 89A51204EA;
 Thu, 16 Jul 2020 10:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594894958;
 bh=vzEaE1HWTa7LYtbebB7ritpzkpel2YtikBtG3CEZDzU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=O7qT433Bf508kbmPUyZtGJ1ha3eKm5yrmKHurnYxiVO1tk+RfIFdFzfIP9a4dEULJ
 cxskKb6f2hESv3IlEBT1RUtZQsbEm8i3bC2eetulC0gX+ABbte+A6hbUMZv5oMxo3Z
 dEeF7i7CvTyJM+Yn2p8YoEk1EHckrb6iEUSt+mB4=
Date: Thu, 16 Jul 2020 11:22:33 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200716102233.GC7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <20200716101940.GA7036@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200716101940.GA7036@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: trivial@kernel.org, maz@kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com,
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

On Thu, Jul 16, 2020 at 11:19:41AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
> > As mentioned in [0], the CPU may consume many cycles processing
> > arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> > get space on the queue takes approx 25% of the cycles for this function.
> > 
> > This series removes that cmpxchg().
> 
> How about something much simpler like the diff below?

Ah, scratch that, I don't drop the lock if we fail the cas with it held.
Let me hack it some more (I have no hardware so I can only build-test this).

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
