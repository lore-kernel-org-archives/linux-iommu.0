Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FE1C2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ADD20771
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hlOzkl87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ADD20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3E14886B9A;
	Wed,  8 Apr 2020 21:21:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QTwU62hpy2-T; Wed,  8 Apr 2020 21:21:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 694DA85359;
	Wed,  8 Apr 2020 21:21:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BCBDC1AE8;
	Wed,  8 Apr 2020 21:21:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2417C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9CB39853D9
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfkfybECktwS for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 21:21:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0160285359
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:02 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id nu11so365025pjb.1
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=AEQOYfD6KlwbjpX4Ij2ibJALe8Dqd/dC0Q9YV1bU9hM=;
 b=hlOzkl87l7nIU+B8Bum98roZyLl+ZMfJaTcRH7l/jQD6zH0udwiDBMGFstrB8ng5dY
 ESKBaujmUSYHqDlGCZi9sGtznbnc7plwdSbkEbKbunNkDwRbGGCqKl7WVAxMvpUuA4co
 vSNBNfPhXyuW7QZtSn5Hwuaphia3Y8qH1NGmpZi8hrcCraK36cefKtgFRchBtrdFW5jM
 DdLBpPsToRtf1raWBc/uoZxRrnB9RstWkcw5FHPtCtSQY7QWoSaalfTo096teDYbu1Kd
 LO5DBnriEvfsf/nnj5+xkPuFlCkzLPntys7HEo6jpLzoLxrugLLtshtfai3YL527HtMj
 bxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=AEQOYfD6KlwbjpX4Ij2ibJALe8Dqd/dC0Q9YV1bU9hM=;
 b=KBXandXiM1rLLN0GEM9Z7A4CcPg1Rvp3O34pL4hu801nSr76qHG1/tBF6xxl1aaTBa
 AmWZpwyPQHjIHu/IrNH00tZpXV4dbPNjx6Mnw2WxJpwiDKbGVdDrCzlt+VwVlJGqbIWK
 sqIgWzlwYtb/prlh2qXDUWZweGNUjnoV441aThPCf4ZgVS9IE7DGuEuKR0MH+b4K/XUY
 tkLnThEYfU+ZGcWqgvwIFncgn4kwONZfUnfRFNpwiihnAKorh5Yrq2wmoC56+tt97BgK
 lm2FuwWVXdQ3tELusX5oRGZhFsc2hYzU2BGCyVmh+BSBRmXK9yDwvMlhpGMO1w01fkno
 ELVA==
X-Gm-Message-State: AGi0Pub2MjbcNddkqZUzmBKep4pdUwbNUCLKLaPkTH3gdbo2oYJFh9L0
 57fYmyC98qOTu5rbtcC+m2Uqkg==
X-Google-Smtp-Source: APiQypJDTfKjj7sgndXs5WeoWJl3rB/YtX+gIS/e9waoz46kcPWNFgoMgqM01OpNU49jLWl4Zbw8QA==
X-Received: by 2002:a17:90a:aa0e:: with SMTP id
 k14mr7567767pjq.74.1586380862157; 
 Wed, 08 Apr 2020 14:21:02 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 63sm17497048pfx.132.2020.04.08.14.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 14:21:01 -0700 (PDT)
Date: Wed, 8 Apr 2020 14:21:00 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc v2 0/6] unencrypted atomic DMA pools with dynamic expansion
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Grimm, Jon" <jon.grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

set_memory_decrypted() may block so it is not possible to do non-blocking
allocations through the DMA API for devices that required unencrypted
memory.

The solution is to expand the atomic DMA pools for the various possible
gfp requirements as a means to prevent an unnecessary depletion of lowmem.
These atomic pools are separated from the remap code and can be selected
for configurations that need them outside the scope of
CONFIG_DMA_DIRECT_REMAP, such as CONFIG_AMD_MEM_ENCRYPT.

These atomic DMA pools are kept unencrypted so they can immediately be
used for non-blocking allocations.  Since the need for this type of memory
depends on the kernel config and devices being used, these pools are also
dynamically expandable.

There are a number of changes to v1 of the patchset based on Christoph's
feedback and the separation of the atomic pools out into the new
kernel/dma/pool.c.

NOTE!  I'd like eyes from Christoph specifically on patch 4 in the series
where we handle the coherent pools differently depending on
CONFIG_DMA_COHERENT_POOL and/or CONFIG_DMA_DIRECT_REMAP and from Thomas
on the requirement for set_memory_decrypted() for all DMA coherent pools.

Why still an RFC?  We are starting to aggressively test this series but
since there were a number of changes that were requested for the first
RFC, it would be better to have feedback and factor that into the series
earlier rather than later so testing can be focused on a series that
could be merged upstream.

This patchset is based on latest Linus HEAD:

commit ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
Author: Hillf Danton <hdanton@sina.com>
Date:   Wed Apr 8 11:59:24 2020 -0400

    mm/gup: Let __get_user_pages_locked() return -EINTR for fatal signal
---
 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/Kconfig          |   6 +-
 kernel/dma/Makefile         |   1 +
 kernel/dma/direct.c         |  28 ++++-
 kernel/dma/pool.c           | 224 ++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c          | 114 ------------------
 9 files changed, 261 insertions(+), 126 deletions(-)
 create mode 100644 kernel/dma/pool.c

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
