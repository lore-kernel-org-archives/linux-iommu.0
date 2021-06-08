Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F8C4743D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 11:42:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 872EF61377
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 11:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872EF61377
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50B5283AA2;
	Tue,  8 Jun 2021 11:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZlTSAycPH3xV; Tue,  8 Jun 2021 11:42:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60CB583B4A;
	Tue,  8 Jun 2021 11:42:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21AC1C000B;
	Tue,  8 Jun 2021 11:42:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACD55C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EF4A83B14
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KN1WwrYClybA for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:42:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AEC7D83AA2
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:49 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31B7061354;
 Tue,  8 Jun 2021 11:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623152569;
 bh=k9u4oLtqZFZqMQL5RbX/43JiWGWq0vXU6dFMnuHjNoo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h39WeBtDyBSnnyS/KwdvKIPeiku1C6zXw7LmVal2HB5v0KgjR7LYJPAto245v4w83
 W9mGsRstf8WFhBnWoV6kJ1quWeQX23mNBjCvqMG1Iofg5z8LVtIWPGTm688mbFQP+N
 uRoFyYS5dNBUzRhvhL380PCYnHLnwMMLFENGABvXecoxBPGP2UtukuNStVcek0oFvO
 DV9L5fgy93xFwlVCMAg/9KK/Y9XhNC1ydbAqA72XU3Tr+TCuX6LaDZbXF0pT/dCnJy
 JdTgS6+0RyWe4iTM+Ny6NzHac3JQo3qP54Ur3WTWo8O0MKuytlKVim4DWt4aB7cfKf
 oh4CYOEKQogMg==
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	joro@8bytes.org
Subject: Re: [PATCH v15 0/3] iommu/arm-smmu-v3: Add stall support
Date: Tue,  8 Jun 2021 12:42:34 +0100
Message-Id: <162314710744.3707892.6632600736379822229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210526161927.24268-1-jean-philippe@linaro.org>
References: <20210526161927.24268-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, guohanjun@huawei.com, rjw@rjwysocki.net,
 robin.murphy@arm.com, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, sudeep.holla@arm.com,
 zhangfei.gao@linaro.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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

On Wed, 26 May 2021 18:19:25 +0200, Jean-Philippe Brucker wrote:
> Add stall support for SMMUv3, enabling I/O page faults and SVA for
> compatible devices. No change since last version [1], but I'd still like
> this to be considered for upstream, because there exists hardware and
> applications.
> 
> Stall is implemented by the Kunpeng 920 processor for its compression
> and crypto accelerators, with which I tested the SVA infrastructure.
> Using the userspace accelerator API [2], a program can obtain a queue
> from one of these devices and submit compression or encryption work
> within the program's address space. UADK [3] provides a library to do
> this, and there is an openssl plugin [4] to use it.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] dt-bindings: document stall property for IOMMU masters
      https://git.kernel.org/will/c/ed1d08b9d0c9
[2/3] ACPI/IORT: Enable stall support for platform devices
      https://git.kernel.org/will/c/6522b1e0c78f
[3/3] iommu/arm-smmu-v3: Add stall support for platform devices
      https://git.kernel.org/will/c/395ad89d11fd

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
