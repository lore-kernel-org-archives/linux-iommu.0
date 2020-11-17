Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A9C2D0E4
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:57:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519D822202
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 22:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D73w5s+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519D822202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E0C7085507;
	Tue, 17 Nov 2020 22:57:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHYstpAWfyIa; Tue, 17 Nov 2020 22:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 719168539A;
	Tue, 17 Nov 2020 22:57:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B7D9C0891;
	Tue, 17 Nov 2020 22:57:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CFAD4C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:57:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C6279870FC
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:57:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F4RntA61AYEo for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 22:57:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 510D1856B8
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 22:57:22 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BC03522202;
 Tue, 17 Nov 2020 22:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605653841;
 bh=KgP6kIuW2/56O4LdccOpIcXq+RuiisQme+VZtaE2LFk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D73w5s+6pbC0lfIN6P0E9PzWBfZfNHkLIspBx7xGiSb9StntWhr6b+6rRYzmOTmmC
 SlPll7ltr48r+vg3hewCLk0famlOjGYTs1XdwidEEC0KWezG0bnkr/X10ifPYFzy2n
 +sa/U5hVGNMnYarhrP3GfLUORm9edCExp+AOfs30=
Date: Tue, 17 Nov 2020 22:57:17 +0000
From: Will Deacon <will@kernel.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
Message-ID: <20201117225717.GF524@willie-the-truck>
References: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
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

On Wed, Oct 28, 2020 at 11:18:24PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
> and the completion wait write-back regions. However, when allocating
> the pages, they could be part of large mapping (e.g. 2M) page.
> This causes #PF due to the SNP RMP hardware enforces the check based
> on the page level for these data structures.

Please could you include an example backtrace here?

> So, fix by calling set_memory_4k() on the allocated pages.

I think I'm missing something here. set_memory_4k() will break the kernel
linear mapping up into page granular mappings, but the IOMMU isn't using
that mapping, right? It's just using the physical address returned by
iommu_virt_to_phys(), so why does it matter?

Just be nice to capture some of this rationale in the log, especially as
I'm not familiar with this device.

> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")

I couldn't figure out how that commit could cause this problem. Please can
you explain that to me?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
