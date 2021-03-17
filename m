Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2D9C433E0
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 14:24:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A7E64F67
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 14:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A7E64F67
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A1CF83EB9;
	Wed, 17 Mar 2021 14:24:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hVOxMng6--vk; Wed, 17 Mar 2021 14:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 848DD83C32;
	Wed, 17 Mar 2021 14:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5902BC000B;
	Wed, 17 Mar 2021 14:24:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 196D0C0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 14:24:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F38F14ED67
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 14:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MkcqkSA6Smof for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 14:24:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D7F54EBFB
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 14:24:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B857A3A4; Wed, 17 Mar 2021 15:24:47 +0100 (CET)
Date: Wed, 17 Mar 2021 15:24:46 +0100
From: Joerg Roedel <joro@8bytes.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/3] iommu/amd: Don't call early_amd_iommu_init() when
 AMD IOMMU is disabled
Message-ID: <YFIRLh3PPiW1hCQZ@8bytes.org>
References: <20210317091037.31374-1-joro@8bytes.org>
 <20210317091037.31374-3-joro@8bytes.org>
 <449d4a2d192d23eb504e43b13c35c326f2d0309a.camel@infradead.org>
 <YFIE8xnr/HWqxm4p@8bytes.org>
 <3014DA56-84D8-474B-94FE-6FDBB6241F9F@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3014DA56-84D8-474B-94FE-6FDBB6241F9F@infradead.org>
Cc: Joerg Roedel <jroedel@suse.de>, Xiaojian Du <xiaojian.du@amd.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, Huang Rui <ray.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
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

On Wed, Mar 17, 2021 at 01:37:16PM +0000, David Woodhouse wrote:
> If we can get to the point where we don't even need to check
> amd_iommu_irq_remap in the ...select() function because the IRQ domain
> is never even registered in the case where the flag ends up false, all
> the better :)

This should already be achieved with this patch :)

But the check is still needed if something goes wrong during IOMMU
initialization. In this case the IOMMUs are teared down and the memory
is freed. But the IRQ domains stay registered for now, mostly because
the upper-level APIs to register them lack a deregister function.

I havn't looked into the details yet whether it is suffient to call
irq_domain_remove() on a domain created with
arch_create_remap_msi_irq_domain() for example. This needs more research
on my side :)

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
