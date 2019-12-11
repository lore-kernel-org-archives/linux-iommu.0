Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8DC43603
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD642077B
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NRKfFcdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD642077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CD2A86DF2;
	Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M14Aj-DOP-_C; Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0664586DE1;
	Wed, 11 Dec 2019 20:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4B48C18DC;
	Wed, 11 Dec 2019 20:28:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E73F2C0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 20:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D44708660D
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 20:15:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RUPHD5fUCCEx for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 20:15:33 +0000 (UTC)
X-Greylist: delayed 00:20:40 by SQLgrey-1.7.6
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com
 [209.85.219.202])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 273D3864DA
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 20:15:33 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id y197so12905155ybe.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=BhTHWYgCSRQtEgCb1BylwBRcg/1kvg/B2oRKXg+gQaY=;
 b=NRKfFcdG6A4G5+sdQcP18SbNkmh1K5xiATWt/eiHVv9xZBDxllX9SQzVn3rHMvyDMI
 h9ijXt1EyeVoQLowMSJ9qHQonptwYiDR999p8WI/NbxSmfeEW560BMDGtqnLrnI0sPwj
 dWO7Lb+b7vDByHnu80y56OMFS74unO9AiAeKUqJ0vSMzRPrDoX+2vxJIOkcF4czGQIVk
 cs//fejmn//AmRtVHtYQQZZD42rXDK7Sqh0V/aOx1dkYN6ZoOTEovpRoD5TTApC9HbHt
 AGb60H2zF8iTMLIMtdGA3symGnVQ2NmGN3sJvM3wzsuq/ygQd1XoNRh29TwLP/ySIf+N
 HvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=BhTHWYgCSRQtEgCb1BylwBRcg/1kvg/B2oRKXg+gQaY=;
 b=DAxla3KouYJfDxBvDVqwGRP6E6zdJLCc1PnPFzeKCkZxvByvO/CWYIj66ztyf5Lmbj
 to0mpOg5hElf9Dd7wqGy+3o1O38DVdCjoyFVhIDHUg2GcsKew9acfINZVlKGYXi3oiin
 mU4dy+UgWNORNOigXGq4mKRS2vSgC6yKVpvAdfa4etahm6rixPqCaVyfgP0GckxAoOCU
 pjk8mEBcz4ya6PhPS3/+a3ovjmKvhze/9cZ5YAy0G+WgDvKoowN8qR/9up2wL2lc2ghs
 2o2plO4CFD8RzYPU3SFiGmxS8o1jpBLxO+/jOynAniZZVV+zmCAODyUGkFCkeuB3yRZX
 jw4Q==
X-Gm-Message-State: APjAAAV6K6qQ0pl/9nZ5GwcSVKXjqqjfsuNtxd+q6nIiZVtvnCK1tqSR
 4O4+Jj2zHUvWwaP34iWFlXCDn61d
X-Google-Smtp-Source: APXvYqx33A6l+F0JL5LmhA7761ThPciJW7aU6oekLpGrNCPEgTSjL2GCjb/RsgaRNTGpE4W3vmLLvwV3
X-Received: by 2002:a81:2441:: with SMTP id k62mr1238554ywk.214.1576093605695; 
 Wed, 11 Dec 2019 11:46:45 -0800 (PST)
Date: Wed, 11 Dec 2019 14:46:05 -0500
In-Reply-To: <20191211194606.87940-1-brho@google.com>
Message-Id: <20191211194606.87940-3-brho@google.com>
Mime-Version: 1.0
References: <20191211194606.87940-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 2/3] iommu/vt-d: treat unmapped RMRR entries as sane
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, 
 "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>,
 Joerg Roedel <joro@8bytes.org>, 
 Yian Chen <yian.chen@intel.com>, Sohil Mehta <sohil.mehta@intel.com>
X-Mailman-Approved-At: Wed, 11 Dec 2019 20:28:58 +0000
Cc: iommu@lists.linux-foundation.org, x86@kernel.org,
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
From: Barret Rhoden via iommu <iommu@lists.linux-foundation.org>
Reply-To: Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The RMRR sanity check is to confirm that the memory pointed to by the
RMRR entry is not used by the kernel.  e820 RESERVED memory will not be
used.  However, there are ranges of physical memory that are not covered
by the e820 table at all.  The kernel will not use this memory, either.

This commit expands the sanity check to treat memory that is not in any
e820 entry as safe.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 arch/x86/include/asm/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..7e9f0c2f975f 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -20,6 +20,8 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 
 	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
 		return 0;
+	if (!e820__mapped_any(start, end, 0))
+		return 0;
 
 	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
 	       start, end - 1);
-- 
2.24.0.525.g8f36a354ae-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
