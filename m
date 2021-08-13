Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDCDC4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 14:34:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EDB610A5
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 14:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86EDB610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5270D60BCE;
	Fri, 13 Aug 2021 14:34:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibp-iRnhHetz; Fri, 13 Aug 2021 14:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E8F8660B85;
	Fri, 13 Aug 2021 14:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A4E5C001A;
	Fri, 13 Aug 2021 14:34:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C15EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 14:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 178874022C
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 14:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9QqtUEnl40K3 for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 14:33:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2040140FD7
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 14:33:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55089610A4;
 Fri, 13 Aug 2021 14:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628865237;
 bh=ta8Xk+nMxYGH0aHGwqur4BcQECkIcU85CR4uMIR+1pc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V71wdBIdMy4DFh8y6KkFUnIHxYrs6ERK3+SNWp3pZqZCaMUoj//bnkta+lzG8/MPT
 IuTVrku1jE7a92RzUJ3mrMen7NZWUxp5klnZCOdhdQ6GjsIzG/mZxZvoxo359APOOd
 R8avxgbnPIHRG1enDH7M+9tgFZ4OrArHVHQm0mUYBpqj5CTHuHoa/vJeD/E4uA/XQd
 hd9NTYHg1iBNsyYATFHz6LbKczAlUCmgZxBb2Z8jVpUlVFUypHfRjbvIWAj1Gc2t21
 mkEBsvyxc/qcWSMFjiPMFPDg535ifpaIn7GDKHB22kEffYrQ7fAHBADeZKMp9QSGPk
 rE3amI/COsAMw==
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv5] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom
 implementation
Date: Fri, 13 Aug 2021 15:33:48 +0100
Message-Id: <162886044327.2821414.7990736519109651727.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811160426.10312-1-saiprakash.ranjan@codeaurora.org>
References: <20210811160426.10312-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: Thierry Reding <treding@nvidia.com>, Doug Anderson <dianders@chromium.org>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, kernel-team@android.com,
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

On Wed, 11 Aug 2021 21:34:26 +0530, Sai Prakash Ranjan wrote:
> Currently for iommu_unmap() of large scatter-gather list with page size
> elements, the majority of time is spent in flushing of partial walks in
> __arm_lpae_unmap() which is a VA based TLB invalidation invalidating
> page-by-page on iommus like arm-smmu-v2 (TLBIVA).
> 
> For example: to unmap a 32MB scatter-gather list with page size elements
> (8192 entries), there are 16->2MB buffer unmaps based on the pgsize (2MB
> for 4K granule) and each of 2MB will further result in 512 TLBIVAs (2MB/4K)
> resulting in a total of 8192 TLBIVAs (512*16) for 16->2MB causing a huge
> overhead.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Optimize ->tlb_flush_walk() for qcom implementation
      https://git.kernel.org/will/c/ef75702d6d65

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
