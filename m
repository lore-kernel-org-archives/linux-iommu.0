Return-Path: <SRS0=tixU=6C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BA6C3A5A9
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 12:10:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A28521D79
	for <iommu@archiver.kernel.org>; Sat, 18 Apr 2020 12:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A28521D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4805E2010E;
	Sat, 18 Apr 2020 12:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8sSraq-YpYIm; Sat, 18 Apr 2020 12:10:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 848E32010A;
	Sat, 18 Apr 2020 12:10:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69A68C089F;
	Sat, 18 Apr 2020 12:10:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE97C0172
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:10:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 065D7876C7
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:10:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Rh15zhILMYl for <iommu@lists.linux-foundation.org>;
 Sat, 18 Apr 2020 12:10:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B4469876C5
 for <iommu@lists.linux-foundation.org>; Sat, 18 Apr 2020 12:10:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 945EE342; Sat, 18 Apr 2020 14:10:23 +0200 (CEST)
Date: Sat, 18 Apr 2020 14:10:22 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Qian Cai <cai@lca.pw>
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200418121022.GA6113@8bytes.org>
References: <20200407021246.10941-1-cai@lca.pw>
 <7664E2E7-04D4-44C3-AB7E-A4334CDEC373@lca.pw>
 <20200408141915.GJ3103@8bytes.org>
 <527B0883-F59D-4C7A-8102-743872801EFC@lca.pw>
 <4FAF3A63-8DC8-4489-B5FE-95B716EF25AE@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FAF3A63-8DC8-4489-B5FE-95B716EF25AE@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Thu, Apr 16, 2020 at 09:42:41PM -0400, Qian Cai wrote:
> So, this is still not enough that would still trigger storage driver offline under
> memory pressure for a bit longer. It looks to me that in fetch_pte() there are
> could still racy?

Yes, your patch still looks racy. You need to atomically read
domain->pt_root to a stack variable and derive the pt_root pointer and
the mode from that variable instead of domain->pt_root directly. If you
read the domain->pt_root twice there could still be an update between
the two reads.
Probably the lock in increase_address_space() can also be avoided if
pt_root is updated using cmpxchg()?

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
