Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71083C2BB1D
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:04:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5932076B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="LJKP9ekR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5932076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC5B785C28;
	Wed, 15 Apr 2020 00:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3ff7tc6uiTQ; Wed, 15 Apr 2020 00:04:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F16C7850EA;
	Wed, 15 Apr 2020 00:04:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0760C089E;
	Wed, 15 Apr 2020 00:04:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64895C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:04:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4AD0E87E54
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6VsNk22HUFxC for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 00:04:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5CAC187D9C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:04:52 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id m16so580510pls.4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:user-agent:mime-version;
 bh=9sAv1VN5EHJYZMrc5W3hn8v84B5WLiBXmj1ZlRYwv5k=;
 b=LJKP9ekRVjrczRzWFYpENLjwjVXF3zdmaqJ/JFc1pSY2R3iC/CByObkBIDxDA+K26e
 80PmMHYhalYwRWIxUwy0R/+9A/CybyFDb3fQ8mgmD56W5RXgIGgWnO52OJKFEPRnjdY4
 /MAGh+KOfUIR4fdxE6TD8dSFKUARBFfJz2NITB0tFq3rHU01NLecmmjlPWGFPzLlx5bK
 pAuB5BcQr3XKZE/Rwt0+P7Wimj1ykmlIBN/AjkKd7m3upkM2uQGfKexQaooLHSmC4W0V
 SWx0SW6syfH9MiCSM/REU1Int4BqdM2tlulRJ6/ro822O0LXAEeU9iJX11yi0TtGM46x
 fXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
 :mime-version;
 bh=9sAv1VN5EHJYZMrc5W3hn8v84B5WLiBXmj1ZlRYwv5k=;
 b=HxiVlHwnfE8ehxJbjoxd1eAWnI/U/uzSg3epQAZlaadTjtuLdTkW/cHHu7ICTxgfdc
 5xe/YoE+vUsLNGwD1ySBwyZDFImmmB2n9mJuiHOO8b9jINUMmu4/dVr2UEhXfrFK+3tx
 3Xg+LGOyPgTgPOCul4Oio0qiIvac/Bmqjr7zzYKs5lQcf3KR/My8lDYE2FCuUy2WtAXH
 arHE8V6xVU2SlnKPghnUXM/gw4BDlUKru2reaB1OR1JLIIvbeqmSCG86tvJ5xDT55qws
 RTudcKtiaIt14bJdQJ/oW9bEkcIB3Ze1ESz2L7R9RwmrJgCFnMlyILsUaliaSk9ENIgM
 7gfg==
X-Gm-Message-State: AGi0PuZrNYByhyEzIS7Sbg1rb2vvzAXTMQDpYIwhmYjf05D2RGj49/cn
 cqOF63mdFwKJPpo0gzZYfVT7pg==
X-Google-Smtp-Source: APiQypK98tyTd/KevIl3fxm0IIe9EmtjEsqtvMJvZnnzaKdB0nFTK4nEy9awjtJ71/AIZH54kDbepg==
X-Received: by 2002:a17:902:968a:: with SMTP id
 n10mr2231605plp.96.1586909091613; 
 Tue, 14 Apr 2020 17:04:51 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id g22sm5108300pju.21.2020.04.14.17.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 17:04:51 -0700 (PDT)
Date: Tue, 14 Apr 2020 17:04:50 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 0/7] unencrypted atomic DMA pools with dynamic expansion
Message-ID: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: x86@kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
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

The sizes of the various atomic DMA pools is exported through debugfs at
/sys/kernel/debug/dma_pools.

This patchset is based on latest Linus HEAD:

commit 8632e9b5645bbc2331d21d892b0d6961c1a08429
Merge: 6cc9306b8fc0 f3a99e761efa
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Apr 14 11:58:04 2020 -0700

    Merge tag 'hyperv-fixes-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux
---
 arch/x86/Kconfig            |   1 +
 drivers/iommu/dma-iommu.c   |   5 +-
 include/linux/dma-direct.h  |   2 +
 include/linux/dma-mapping.h |   6 +-
 kernel/dma/Kconfig          |   6 +-
 kernel/dma/Makefile         |   1 +
 kernel/dma/direct.c         |  56 ++++++--
 kernel/dma/pool.c           | 275 ++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c          | 114 ---------------
 9 files changed, 334 insertions(+), 132 deletions(-)
 create mode 100644 kernel/dma/pool.c
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
