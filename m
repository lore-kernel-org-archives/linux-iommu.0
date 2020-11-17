Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED18FC63697
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:24:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6210320B80
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCdcyR/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6210320B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A80882266C;
	Tue, 17 Nov 2020 22:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2MM2F+jQF4pE; Tue, 17 Nov 2020 22:24:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4BE2A226E9;
	Tue, 17 Nov 2020 22:24:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30FAEC0891;
	Tue, 17 Nov 2020 22:24:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4740C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:24:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 59B1D8495A
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:24:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1P_YOQfBrOcs for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 22:24:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E43B084728
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:24:37 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A46E620B80;
 Tue, 17 Nov 2020 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605651877;
 bh=suTzvgzomH8/b8tydiTPTmWm+Melr0oekXi+74bvqd0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WCdcyR/SR4KIUFc87Q15lZQPG0eLCZTDm5gugZz5CIjeBSP2fFDAQDJaaE/Nn3uKV
 XTdtj5/KBydRFrrvervCjb2+uT+nfg6eOfyLYSaRYi+FKBne3QHRHis4FUhdyfrpSh
 Em6GlvID7zmt1rRNV7JRr+sysGX7MPQAC5gVFGy4=
Date: Tue, 17 Nov 2020 22:24:32 +0000
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org
Subject: Re: [GIT PULL] iommu/arm-smmu: First batch of updates for 5.11
Message-ID: <20201117222432.GC524@willie-the-truck>
References: <20201110135657.GA17034@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110135657.GA17034@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 john.stultz@linaro.org, robin.murphy@arm.com,
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

On Tue, Nov 10, 2020 at 01:56:57PM +0000, Will Deacon wrote:
> Please can you pull these Arm SMMU updates for 5.11 so that they can get
> into -next? I think Bjorn is keen to get a bunch of DT updates moving, so
> the sooner we can get this lot out there, the better. Summary in the tag.
> 
> There are a few other patches kicking around on the list, so I may send
> a second pull on top in a couple of weeks or so.

This is now queued on a stable branch for -next targetting 5.11:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/iommu/arm-smmu

Bjorn, is this what you needed?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
