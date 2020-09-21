Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB056C4346E
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 18:17:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2EB20888
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 18:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7sKYbWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2EB20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2AC4A85D39;
	Mon, 21 Sep 2020 18:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PvZC2aX4tMNl; Mon, 21 Sep 2020 18:17:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8ED0385187;
	Mon, 21 Sep 2020 18:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85AABC0859;
	Mon, 21 Sep 2020 18:17:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FEB0C0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 07E2B2266C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:17:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OqMzO2KDXsxx for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 18:17:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id CABBF2041C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2BEEC22262;
 Mon, 21 Sep 2020 18:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600712266;
 bh=xrXEs22xfJfXUjgWn392Dbll4+fngO59McW7lRJEcD4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G7sKYbWM/60ymj4cH6crdDwoMxcSwtFeSvTq5VvFcLT3qf3cHQ/GUWDV0oJyx82zN
 0c+3n4jOqxeR4e6hrMwY9qUsDEpzD9VJHO0NoNTGMs8k2W2gO+/T5mBh8LcScEXnii
 RexoBkAPgfj/OJDTYyz4DXZlRLjMorhWam+4rq/8=
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	robin.murphy@arm.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix endianness annotations
Date: Mon, 21 Sep 2020 19:17:38 +0100
Message-Id: <160071047219.1757999.7743246332571671817.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200918141856.629722-1-jean-philippe@linaro.org>
References: <20200918141856.629722-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
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

On Fri, 18 Sep 2020 16:18:57 +0200, Jean-Philippe Brucker wrote:
> When building with C=1, sparse reports some issues regarding endianness
> annotations:
> 
> arm-smmu-v3.c:221:26: warning: cast to restricted __le64
> arm-smmu-v3.c:221:24: warning: incorrect type in assignment (different base types)
> arm-smmu-v3.c:221:24:    expected restricted __le64 [usertype]
> arm-smmu-v3.c:221:24:    got unsigned long long [usertype]
> arm-smmu-v3.c:229:20: warning: incorrect type in argument 1 (different base types)
> arm-smmu-v3.c:229:20:    expected restricted __le64 [usertype] *[assigned] dst
> arm-smmu-v3.c:229:20:    got unsigned long long [usertype] *ent
> arm-smmu-v3.c:229:25: warning: incorrect type in argument 2 (different base types)
> arm-smmu-v3.c:229:25:    expected unsigned long long [usertype] *[assigned] src
> arm-smmu-v3.c:229:25:    got restricted __le64 [usertype] *
> arm-smmu-v3.c:396:20: warning: incorrect type in argument 1 (different base types)
> arm-smmu-v3.c:396:20:    expected restricted __le64 [usertype] *[assigned] dst
> arm-smmu-v3.c:396:20:    got unsigned long long *
> arm-smmu-v3.c:396:25: warning: incorrect type in argument 2 (different base types)
> arm-smmu-v3.c:396:25:    expected unsigned long long [usertype] *[assigned] src
> arm-smmu-v3.c:396:25:    got restricted __le64 [usertype] *
> arm-smmu-v3.c:1349:32: warning: invalid assignment: |=
> arm-smmu-v3.c:1349:32:    left side has type restricted __le64
> arm-smmu-v3.c:1349:32:    right side has type unsigned long
> arm-smmu-v3.c:1396:53: warning: incorrect type in argument 3 (different base types)
> arm-smmu-v3.c:1396:53:    expected restricted __le64 [usertype] *dst
> arm-smmu-v3.c:1396:53:    got unsigned long long [usertype] *strtab
> arm-smmu-v3.c:1424:39: warning: incorrect type in argument 1 (different base types)
> arm-smmu-v3.c:1424:39:    expected unsigned long long [usertype] *[assigned] strtab
> arm-smmu-v3.c:1424:39:    got restricted __le64 [usertype] *l2ptr
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Fix endianness annotations
      https://git.kernel.org/will/c/376cdf66f624

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
