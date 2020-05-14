Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA556C433DF
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 18:32:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC522054F
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 18:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC522054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7D9A88C30;
	Thu, 14 May 2020 18:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cCQ69sLbEqf3; Thu, 14 May 2020 18:32:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17D83888FA;
	Thu, 14 May 2020 18:32:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB7B9C0863;
	Thu, 14 May 2020 18:32:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A2BFC016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 18:32:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F1D7720443
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 18:32:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h5Z6W7eCsQ7K for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 18:32:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 9970B22668
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 18:32:37 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9DF6A26F; Thu, 14 May 2020 20:32:34 +0200 (CEST)
Date: Thu, 14 May 2020 20:32:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH] iommu: Remove functions that support private domain
Message-ID: <20200514183233.GO18353@8bytes.org>
References: <20200513224721.20504-1-sai.praneeth.prakhya@intel.com>
 <20200514131315.GJ18353@8bytes.org>
 <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F573A6427@ORSMSX114.amr.corp.intel.com>
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

On Thu, May 14, 2020 at 05:51:39PM +0000, Prakhya, Sai Praneeth wrote:
> Sorry! didn't get that quite well. When you meant "per-group
> default-domain patch-set", do you mean the patch set that I am working
> on which changes iommu group default domain dynamically by writing to
> sysfs file?

Not only the sysfs file, but also changing it at boot already. Note that
changing the default-domain at runtime is only possible for
single-device groups.

I'll queue that patch tomorrow.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
