Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4449C433E0
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:20:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84203204EA
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 10:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xkehWQ0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84203204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2A2FB22BCC;
	Thu, 16 Jul 2020 10:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WEcFAerpXNYA; Thu, 16 Jul 2020 10:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 188A520501;
	Thu, 16 Jul 2020 10:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05572C07FF;
	Thu, 16 Jul 2020 10:20:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82BC5C0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 624D822BCC
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1HBrkY6BybVj for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 10:20:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 9C8A420501
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 10:20:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E8713204EA;
 Thu, 16 Jul 2020 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594894842;
 bh=L6O+9oJn1klewKnv0PBbNlZZnruWJcrOzt9QTNHkA/U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xkehWQ0P7hppEt6KHlYUlNGEAJM8OiWVyU/FFxdOlbHSDDRGF+SH3gG1B2UeSdM5T
 DeZueDeBk9N0QcPGSM1Gli43+RB8GbBsIzFd8GKMiWXeKYbhxuukGgUQzYqY1EjCJo
 nHXYGPB7Ds3TZpJVZ6Vp/uNo++ewbKViKu8zEbwg=
Date: Thu, 16 Jul 2020 11:20:38 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
Message-ID: <20200716102037.GB7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
 <1592846920-45338-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
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

On Tue, Jun 23, 2020 at 01:28:40AM +0800, John Garry wrote:
> It has been shown that the cmpxchg() for finding space in the cmdq can
> be a bottleneck:
> - for more CPUs contending the cmdq, the cmpxchg() will fail more often
> - since the software-maintained cons pointer is updated on the same 64b
>   memory region, the chance of cmpxchg() failure increases again
> 
> The cmpxchg() is removed as part of 2 related changes:
> 
> - Update prod and cmdq owner in a single atomic add operation. For this, we
>   count the prod and owner in separate regions in prod memory.
> 
>   As with simple binary counting, once the prod+wrap fields overflow, they
>   will zero. They should never overflow into "owner" region, and we zero
>   the non-owner, prod region for each owner. This maintains the prod
>   pointer.
> 
>   As for the "owner", we now count this value, instead of setting a flag.
>   Similar to before, once the owner has finished gathering, it will clear
>   a mask. As such, a CPU declares itself as the "owner" when it reads zero
>   for this region. This zeroing will also clear possible overflow in
>   wrap+prod region, above.
> 
>   The owner is now responsible for all cmdq locking to avoid possible
>   deadlock. The owner will lock the cmdq for all non-owers it has gathered
>   when they have space in the queue and have written their entries.
> 
> - Check for space in the cmdq after the prod pointer has been assigned.
> 
>   We don't bother checking for space in the cmdq before assigning the prod
>   pointer, as this would be racy.
> 
>   So since the prod pointer is updated unconditionally, it would be common
>   for no space to be available in the cmdq when prod is assigned - that
>   is, according the software-maintained prod and cons pointer. So now
>   it must be ensured that the entries are not yet written and not until
>   there is space.
> 
>   How the prod pointer is maintained also leads to a strange condition
>   where the prod pointer can wrap past the cons pointer. We can detect this
>   condition, and report no space here. However, a prod pointer progressed
>   twice past the cons pointer cannot be detected. But it can be ensured that
>   this that this scenario does not occur, as we limit the amount of
>   commands any CPU can issue at any given time, such that we cannot
>   progress prod pointer further.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 101 ++++++++++++++++++++++--------------
>  1 file changed, 61 insertions(+), 40 deletions(-)

I must admit, you made me smile putting trivial@kernel.org on cc for this ;)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
