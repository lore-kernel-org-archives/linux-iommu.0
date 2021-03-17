Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67494C433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 13:32:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B637C64F44
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 13:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637C64F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4984C42FA6;
	Wed, 17 Mar 2021 13:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0NHYV2vXb8BX; Wed, 17 Mar 2021 13:32:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 49C95414D5;
	Wed, 17 Mar 2021 13:32:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C17BC000A;
	Wed, 17 Mar 2021 13:32:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E733BC0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 13:32:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF6C742FA6
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 13:32:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9l6MqdYasIxD for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 13:32:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D446414D5
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 13:32:42 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 5B8992DA; Wed, 17 Mar 2021 14:32:38 +0100 (CET)
Date: Wed, 17 Mar 2021 14:32:35 +0100
From: Joerg Roedel <joro@8bytes.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/3] iommu/amd: Don't call early_amd_iommu_init() when
 AMD IOMMU is disabled
Message-ID: <YFIE8xnr/HWqxm4p@8bytes.org>
References: <20210317091037.31374-1-joro@8bytes.org>
 <20210317091037.31374-3-joro@8bytes.org>
 <449d4a2d192d23eb504e43b13c35c326f2d0309a.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <449d4a2d192d23eb504e43b13c35c326f2d0309a.camel@infradead.org>
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

On Wed, Mar 17, 2021 at 11:47:11AM +0000, David Woodhouse wrote:
> If you've already moved the Stoney Ridge check out of the way, there's
> no real reason why you can't just set init_state=IOMMU_CMDLINE_DISABLED
> directly from parse_amd_iommu_options(), is there? Then you don't need
> the condition here at all?

True, there is even more room for optimization. The amd_iommu_disabled
variable can go away entirely, including its checks in
early_amd_iommu_init(). I will do a patch-set on-top of this for v5.13
which does more cleanups.

Thanks,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
