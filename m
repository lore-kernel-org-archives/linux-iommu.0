Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F53C43465
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 09:17:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C6621D42
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 09:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C6621D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F9E2877CD;
	Fri, 18 Sep 2020 09:17:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SqY842vi7pep; Fri, 18 Sep 2020 09:17:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CC0FE877CF;
	Fri, 18 Sep 2020 09:17:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B783CC0859;
	Fri, 18 Sep 2020 09:17:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2463C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E1489877CF
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 321fgBNTWbZ5 for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 09:17:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9D398877CD
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:17:48 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B48F8396; Fri, 18 Sep 2020 11:17:46 +0200 (CEST)
Date: Fri, 18 Sep 2020 11:17:45 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Restore IRTE.RemapEn bit for
 amd_iommu_activate_guest_mode
Message-ID: <20200918091745.GN31590@8bytes.org>
References: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mlevitsk@redhat.com
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

On Wed, Sep 16, 2020 at 11:17:20AM +0000, Suravee Suthikulpanit wrote:
> Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating
> 128-bit IRTE") removed an assumption that modify_irte_ga always set
> the valid bit, which requires the callers to set the appropriate value
> for the struct irte_ga.valid bit before calling the function.
> 
> Similar to the commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn
> bit after programming IRTE"), which is for the function
> amd_iommu_deactivate_guest_mode().
> 
> The same change is also needed for the amd_iommu_activate_guest_mode().
> Otherwise, this could trigger IO_PAGE_FAULT for the VFIO based VMs with
> AVIC enabled.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied for v5.9, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
