Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992F0C2BA83
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 10:49:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590D620848
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 10:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3CZSF6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590D620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0ED9186303;
	Wed, 12 Feb 2020 10:49:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8hxhERJyUA8u; Wed, 12 Feb 2020 10:49:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8C821861B3;
	Wed, 12 Feb 2020 10:49:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67CAEC1D88;
	Wed, 12 Feb 2020 10:49:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5474AC0177
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 10:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3DD3A203CA
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 10:49:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zdUAjDploxNx for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 10:49:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 4D38020373
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 10:49:08 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA3D32082F;
 Wed, 12 Feb 2020 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581504548;
 bh=e7/KyaTyypq+Fd/F2Np5hVC5zzZzRMc32NuzncQ3qr4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k3CZSF6H7D/ew3dYU1hxbYGV9FK3JiiBQCudA+bcHr5Dk5IZycoxRNeIIAczEJqZx
 If5vFyX31y5yq6FxhPyHwSCDqIAJJh6SwTK1/8xMwNCt3TKZ/W20LPfEpWgZrOpiXN
 VIfGeiSbNiAu4H64sjCjLwY8SP/gbnSeWNK9h0qc=
Date: Wed, 12 Feb 2020 10:49:03 +0000
From: Will Deacon <will@kernel.org>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] iommu/arm-smmu: fix the module name to be consistent
 with older kernel
Message-ID: <20200212104902.GA3664@willie-the-truck>
References: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1581467841-25397-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
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

On Tue, Feb 11, 2020 at 06:37:20PM -0600, Li Yang wrote:
> Commit cd221bd24ff5 ("iommu/arm-smmu: Allow building as a module")
> introduced a side effect that changed the module name from arm-smmu to
> arm-smmu-mod.  This breaks the users of kernel parameters for the driver
> (e.g. arm-smmu.disable_bypass).  This patch changes the module name back
> to be consistent.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/Makefile                          | 4 ++--
>  drivers/iommu/{arm-smmu.c => arm-smmu-common.c} | 0
>  2 files changed, 2 insertions(+), 2 deletions(-)
>  rename drivers/iommu/{arm-smmu.c => arm-smmu-common.c} (100%)

Can't we just override MODULE_PARAM_PREFIX instead of renaming the file?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
