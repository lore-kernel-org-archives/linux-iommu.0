Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58330C433FE
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 16:56:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE01323C43
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 16:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE01323C43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C9B287151;
	Wed,  9 Dec 2020 16:56:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fcoZsjEtdPwM; Wed,  9 Dec 2020 16:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 026F38711C;
	Wed,  9 Dec 2020 16:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD85C0FA7;
	Wed,  9 Dec 2020 16:56:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 106C1C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 16:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EF6BF87131
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 16:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6i6-KvDplU15 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 16:56:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 133EE8711C
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 16:56:40 +0000 (UTC)
Date: Wed, 9 Dec 2020 16:56:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607532999;
 bh=zKu4C9xk4YyOMMGuiHx0Da7TOXulLg9gpE8B5lWLyUc=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=p80H08nYdQRpUFIdDCsI7//toC5n/Ukh0oPtZF0PEQNv5tkY+ocscTvzmWWZ7WpUu
 qp7WiZpND22Yn1uXeuAPEZEaCrTaVd8j3Q+8SvtGpF6klozzdGt+U6QHzzrPsKLwN8
 Ellw0AWLGS6iprl+bZXEKtJ6XqAPbYtr463AI9L4OApQEurADMafqLjc39LimHYo1O
 TZdl9xY3Nq6WrIWxaksim3RoGTAlxsUtxGKKt9noYbppXqk4eCIfT8mP8V6RQC3GT7
 qClsZdg7eIUN3QtK7jhOt4QucWt+c9oRSrg4Rrhu6ts/CubGayVDzVK8WDwzIOVn0a
 3//79aUN4B1kw==
From: Will Deacon <will@kernel.org>
To: Adrian Huang12 <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] iommu/amd: Remove unnecessary assignment
Message-ID: <20201209165635.GA8729@willie-the-truck>
References: <HK2PR0302MB2594BB6B721306895329A28DB3CC0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <HK2PR0302MB2594BB6B721306895329A28DB3CC0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On Wed, Dec 09, 2020 at 03:32:50PM +0000, Adrian Huang12 wrote:
> Gentle ping.

Sorry, I hadn't noticed this patch.

However, I haven't been able to apply this successfully as b4 doesn't seem
to identify it as a patch and I only have this reply in my mailbox. Please
can you send it again, with me on cc?

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
