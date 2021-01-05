Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D219C433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 22:07:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF929230FA
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 22:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF929230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9909186BB2;
	Tue,  5 Jan 2021 22:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmhK5-Npx+T5; Tue,  5 Jan 2021 22:07:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4492A86B9F;
	Tue,  5 Jan 2021 22:07:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32BE6C088B;
	Tue,  5 Jan 2021 22:07:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA29C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B4FC86F1B
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WV6bhUIKjUe4 for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 22:07:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EEE65871D5
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 22:07:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A528B22EBF;
 Tue,  5 Jan 2021 22:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609884435;
 bh=tsheRUiuvVXoAiX6SgiMXhmYuf9QGk7UvV4pmxzSUbA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W40u7p8GiX2ojjXhVZV3jacLPbHw+9iWZAuRtnNsZcnUkILt74wXGO7nxoTHirp+V
 7nNcX7rV0NyW5xc9sgbL6ddKhhgysMhvf/BkeHGenLnQ+3MeUzLBw6Gzzzi6oY779Q
 EEG4B2fmSmCQHoPcBmgl2zvEOtv2JR0t8QSJIOKUNHexJzl1qgNx+MYv0Bj5PTZBxz
 uRG3QuKRoOUg3A+7G9i+bp+N/5E3XsFWkNiHEtKuUIZubIBayOw0Cc1Y83gE8AhQaO
 WNdv16PvziQUv+TxcRCvG/pA+ZtjH7/Gjmdw6iXPDcDT69RXbmt7S74Vxs9cnrjGVX
 ZhZYFui+RfhbQ==
From: Will Deacon <will@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/iova: fix 'domain' typos
Date: Tue,  5 Jan 2021 22:07:03 +0000
Message-Id: <160987253811.25749.17357875257993494998.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201222164232.88795-1-sgarzare@redhat.com>
References: <20201222164232.88795-1-sgarzare@redhat.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>
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

On Tue, 22 Dec 2020 17:42:32 +0100, Stefano Garzarella wrote:
> Replace misspelled 'doamin' with 'domain' in several comments.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/iova: fix 'domain' typos
      https://git.kernel.org/arm64/c/6775ae901ffd

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
