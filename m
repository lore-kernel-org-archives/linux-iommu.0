Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A697C63697
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:43:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E2320715
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t77rKKLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E2320715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 37CC08569B;
	Tue, 17 Nov 2020 22:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ArcDZ6knyg7B; Tue, 17 Nov 2020 22:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CEB148568D;
	Tue, 17 Nov 2020 22:43:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7CFBC0891;
	Tue, 17 Nov 2020 22:43:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 148F6C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EC044226FC
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J6W6q7rNqa53 for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 22:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 02BAB203EE
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:43:11 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6120E20709;
 Tue, 17 Nov 2020 22:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605652991;
 bh=0SFBsqaNbJ3KLyPX1uMM76O7e/5+G6SX1GOQxGY2lSA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t77rKKLuLqLBsLIsln15cG9Bd24C8388FbOO1O3Fn590nTBPfZHjEXmGFpUNj2eXA
 jj652eSTeTo7sXjohtTNp4+olWdnP2G5cpwGJY1/flcNXKiKY3ewaum/GPBreA/UzN
 sGCiWf+SL3u1DxlMjpnwbNoDqh8fbB0TmjS0lwEM=
Date: Tue, 17 Nov 2020 22:43:07 +0000
From: Will Deacon <will@kernel.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
Message-ID: <20201117224306.GE524@willie-the-truck>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
 <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
 <4dce5bdb-1a08-75ad-fd41-a1686521fef1@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4dce5bdb-1a08-75ad-fd41-a1686521fef1@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org
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

Hey Suravee (it's been a while!),

On Fri, Nov 13, 2020 at 12:57:18PM +0700, Suravee Suthikulpanit wrote:
> Please ignore to include the V3. I am working on V4 to resubmit.

Please can you put me on CC for that?

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
