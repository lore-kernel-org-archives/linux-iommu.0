Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E5C43464
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 08:36:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2E420872
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 08:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2E420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 80E4C877CD;
	Fri, 18 Sep 2020 08:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VkpZT4Qik7mx; Fri, 18 Sep 2020 08:36:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0207C877C5;
	Fri, 18 Sep 2020 08:36:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D97A5C0888;
	Fri, 18 Sep 2020 08:36:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C92FC0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 08:36:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 309E8877CC
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 08:36:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dwyCCECr318x for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 08:36:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E7AF5877C5
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 08:36:21 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id CE2BF396; Fri, 18 Sep 2020 10:36:19 +0200 (CEST)
Date: Fri, 18 Sep 2020 10:36:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH] iommu/amd: Fix potential @entry null deref
Message-ID: <20200918083618.GF31590@8bytes.org>
References: <20200910171621.12879-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200910171621.12879-1-joao.m.martins@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Thu, Sep 10, 2020 at 06:16:21PM +0100, Joao Martins wrote:
> After commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn bit after
> programming IRTE"), smatch warns:
> 
> 	drivers/iommu/amd/iommu.c:3870 amd_iommu_deactivate_guest_mode()
>         warn: variable dereferenced before check 'entry' (see line 3867)
> 
> Fix this by moving the @valid assignment to after @entry has been checked
> for NULL.
> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Fixes: 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn bit after programming IRTE")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied for v5.9, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
