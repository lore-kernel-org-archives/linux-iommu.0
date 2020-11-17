Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A59C63777
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 23:24:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8BE20A8B
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 23:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bN2fZGAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8BE20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E3E348702E;
	Tue, 17 Nov 2020 23:24:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T2HbJx2Cvuw3; Tue, 17 Nov 2020 23:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 83B3587027;
	Tue, 17 Nov 2020 23:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71819C0800;
	Tue, 17 Nov 2020 23:24:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BD69C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2486587027
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DIQFyXXboCuN for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 23:24:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B31678710E
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 23:24:40 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A976421D91;
 Tue, 17 Nov 2020 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605655480;
 bh=qYz2LNdZNi0aiX1wyp0QjexK42xd/yudcPZ60Vwb+1o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bN2fZGAXDDeG9uCBKlptr8v/nlDi28S7SdjahoRESEKjcT9h9nSguvM/TbqXNTjuh
 hFYdRL/I28utCz99QExXTv/DFtQSJ888jdQnt0tzsVNERU0mtu2YnPa0Wx12teFyXr
 k3xSvkO0maYh/nxhg4ba+S0jfWwS91Wwdwg1pQgQ=
From: Will Deacon <will@kernel.org>
To: "vjitta@codeaurora.org" <vjitta@codeaurora.org>, joro@8bytes.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v5 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
Date: Tue, 17 Nov 2020 23:24:29 +0000
Message-Id: <160565419447.2778079.10643367410535150698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, vinmenon@codeaurora.org, kernel-team@android.com,
 robin.murphy@arm.com, Will Deacon <will@kernel.org>
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

On Wed, 30 Sep 2020 13:14:23 +0530, vjitta@codeaurora.org wrote:
> When ever a new iova alloc request comes iova is always searched
> from the cached node and the nodes which are previous to cached
> node. So, even if there is free iova space available in the nodes
> which are next to the cached node iova allocation can still fail
> because of this approach.
> 
> Consider the following sequence of iova alloc and frees on
> 1GB of iova space
> 
> [...]

Applied to arm64 (for-next/iommu/iova), thanks!

[1/2] iommu/iova: Retry from last rb tree node if iova search fails
      https://git.kernel.org/arm64/c/4e89dce72521
[2/2] iommu/iova: Free global iova rcache on iova alloc failure
      https://git.kernel.org/arm64/c/6fa3525b455a

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
