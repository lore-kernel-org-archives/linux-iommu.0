Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EECBC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 14:57:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8A361A02
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 14:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8A361A02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07ADF401C4;
	Thu, 25 Mar 2021 14:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTpufKpfoSsj; Thu, 25 Mar 2021 14:57:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 042AE401B0;
	Thu, 25 Mar 2021 14:57:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1785C000E;
	Thu, 25 Mar 2021 14:57:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0BCEC000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DA3BC40F33
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id no-eq2KvJkxh for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 14:57:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1843640F2F
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 14:57:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98E2261A01;
 Thu, 25 Mar 2021 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616684247;
 bh=+MGOAS/02TPE6GFrT+w8Tf+8MdBv5X5AeEce0i//TeY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RTnuiXXLkEsn4crF73TAZrj0cXe7YMEDsHkZMFAFnZJMb1Jzxyu9+62FuSNT/G9TU
 XZzFp4gdAeWsRtEsWiHLERdVq3Z/5yPkMCq45tIWj0YzZXWIbU/3ZfMindIVANJDyQ
 jd2AkjbpLp4Vty+7gkGtOEZJnG5hVkhypEQzQjB348anIbXIZPHjnjvKoGmIsbLNYY
 XEppwNk+b63CdQYy90SzqZlk1sbmLNuYX0Voe0ar9NUKr9H/hk9a9Oqrmv+24VJozD
 14gxdzWLvPV4WPh/t/5PQMn7vIC/JfPSSevrQgQ8MkWHbruaAil+rCjCgHP0s2bFok
 l9O2J3KWYyZUA==
Date: Thu, 25 Mar 2021 14:57:23 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu: Don't use lazy flush for untrusted device
Message-ID: <20210325145723.GB15172@willie-the-truck>
References: <20210225061454.2864009-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210225061454.2864009-1-baolu.lu@linux.intel.com>
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

On Thu, Feb 25, 2021 at 02:14:54PM +0800, Lu Baolu wrote:
> The lazy IOTLB flushing setup leaves a time window, in which the device
> can still access some system memory, which has already been unmapped by
> the device driver. It's not suitable for untrusted devices. A malicious
> device might use this to attack the system by obtaining data that it
> shouldn't obtain.
> 
> Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/dma-iommu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
