Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47E2C433DB
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 22:35:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E2F20679
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 22:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E2F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D8E6860BE;
	Tue, 26 Jan 2021 22:35:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9z8orctI1ybc; Tue, 26 Jan 2021 22:35:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 94214866AF;
	Tue, 26 Jan 2021 22:35:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 789CCC0FA7;
	Tue, 26 Jan 2021 22:35:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3C4DC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 22:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BAA0E86FCA
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 22:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wXqWgCv-bu0U for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 22:35:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5BE5D86FC5
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 22:35:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FBC22065E;
 Tue, 26 Jan 2021 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611700547;
 bh=Q1GyRhpkZiVQToN/jT2ZPcVt3BW6HFaKBIAmsCu2bCU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SnxfXEhAt5e/63DrE8s+rWzNBER52n3jEXPQlNMC/nc6Ti+X+VSP/YbFKL+KxtwNb
 kEryFl/EK49PYII5Z7np11Tl8nITq2dxISWzqHKW/Y58aC4cMHZ6heu3zPUcLzwrqv
 Itz9HtP20hbwkvF5GkW295UitLIWTnWo6iTIZc6iphBD5ZnylWnn5m+3QIUHfqLgbo
 BC+1sIgIzhqa/rmSbB8IWTdOMjvjtSxVkNhaixwuNEbg5FsIeXoEikEwfHgIBMB9C1
 qS5uCgh4d0PJscnJS6d+lfkAmOg7ZzUZ0x5GeqzvM7nzUadOmqZ+wpnJvkYm3EoVeY
 t+Phu04NZhDFw==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com, bjorn.andersson@linaro.org,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>, joro@8bytes.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix mask extraction for bootloader
 programmed SMRs
Date: Tue, 26 Jan 2021 22:35:41 +0000
Message-Id: <161167109569.3787430.13165422969483638185.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1611611545-19055-1-git-send-email-isaacm@codeaurora.org>
References: <1611611545-19055-1-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, kernel-team@android.com,
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

On Mon, 25 Jan 2021 13:52:25 -0800, Isaac J. Manjarres wrote:
> When extracting the mask for a SMR that was programmed by the
> bootloader, the SMR's valid bit is also extracted and is treated
> as part of the mask, which is not correct. Consider the scenario
> where an SMMU master whose context is determined by a bootloader
> programmed SMR is removed (omitting parts of device/driver core):
> 
> ->iommu_release_device()
>  -> arm_smmu_release_device()
>   -> arm_smmu_master_free_smes()
>    -> arm_smmu_free_sme() /* Assume that the SME is now free */
>    -> arm_smmu_write_sme()
>     -> arm_smmu_write_smr() /* Construct SMR value using mask and SID */
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Fix mask extraction for bootloader programmed SMRs
      https://git.kernel.org/will/c/dead723e6f04

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
