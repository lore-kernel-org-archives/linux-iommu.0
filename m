Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7914C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C54E61351
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 12:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C54E61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71FD983BB6;
	Tue,  8 Jun 2021 12:01:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WQ1pwQkOQm7e; Tue,  8 Jun 2021 12:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 750BD834E8;
	Tue,  8 Jun 2021 12:01:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36577C000B;
	Tue,  8 Jun 2021 12:01:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FAD9C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 414DD402A0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xpgsHarwTBp2 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 12:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9370F40291
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 12:01:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5058C6124C;
 Tue,  8 Jun 2021 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623153681;
 bh=S9TLRCiwFFilnww/1DED8OP0Gyo0PR92bBpXLJy8tH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eT6No3MgMtNx+qx/FA8JNUfYz7tKEOTR/Ey8cbopGTWGxL65RQj2w/LCGP2L1Gx60
 8tGEXSSBDCXRYBAo7A3QKLHm1nEEm1QzN5ILvPB1tueHcH3aQE9E3139TpcnmNeohx
 tnLB5DHwu5oeZzugweOBl0H0RrSvXUOtH2x0p0wCSzlCJ9MaGHDkUTbhxt7pfe8Uo8
 UrkPmbMAOl+Zkna6jpay7tusSk/woedHPh5mVGh3lPtTpejPfzdeDUgPIUEF4F+O1c
 CWhP1oAh4hXnvhACYrSGeLlwiY1G1bvL5V1056NgaguTA4B6mZMtwu2TfsQYzy2llr
 Evl5MONEuVd6A==
Date: Tue, 8 Jun 2021 13:01:16 +0100
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv3 0/2] iommu/arm-smmu-qcom: Add SC7280 support
Message-ID: <20210608120115.GA10174@willie-the-truck>
References: <cover.1618898456.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1618898456.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Akhil P Oommen <akhilpo@codeaurora.org>,
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

On Tue, Apr 20, 2021 at 11:34:55AM +0530, Sai Prakash Ranjan wrote:
> Patch 1 adds the sc7280 smmu compatible.
> Patch 2 moves the adreno smmu check before apss smmu to enable
> adreno smmu specific implementation.
> 
> Note that dt-binding for sc7280 is already merged.

This conflicts with what I've already got queued at [1]. Please can you
send an updated version, as I wasn't sure about the initialisation order
you need here wrt to the ACPI parts.

Thanks,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
