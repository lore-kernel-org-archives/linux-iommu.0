Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97932C433E3
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 13:14:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6147D20866
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 13:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2OzoqK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6147D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3FAAB86CFC;
	Thu, 13 Aug 2020 13:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QoA2Jt36m-D5; Thu, 13 Aug 2020 13:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B678386CF3;
	Thu, 13 Aug 2020 13:14:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9751C07FF;
	Thu, 13 Aug 2020 13:14:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1265C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ECB8688642
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:14:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HJTanNPZEuXS for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 13:14:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 89A6C8863E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 13:14:17 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DC2C2207DA;
 Thu, 13 Aug 2020 13:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597324457;
 bh=HCr4ngCWjVKb+xxBnt5CGWnhlxXwqewqquSGs6gY/tQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g2OzoqK45R4qfqF8Or+HHI5oAJY2/0O4pieaNJoQbathqNBIzeNkh1vtAjW4OK5/w
 gynmT/frIe0nHJN/Vqsht7fKwsdZZLszjSo+BMWCaVjLbOmDO1myd2i2r/L+IkhBYx
 1HI6Mj4LGSBFsM7RcW5SewzVPhXmfbxDe+qTqOm4=
Date: Thu, 13 Aug 2020 14:14:12 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v12 04/13] iommu: Add a domain attribute to get/set a
 pagetable configuration
Message-ID: <20200813131412.GB10256@willie-the-truck>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200810222657.1841322-5-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810222657.1841322-5-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
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

On Mon, Aug 10, 2020 at 04:26:48PM -0600, Jordan Crouse wrote:
> Add domain attribute DOMAIN_ATTR_PGTABLE_CFG. This will be used by
> arm-smmu to share the current pagetable configuration with the
> leaf driver and to allow the leaf driver to set up a new pagetable
> configuration under certain circumstances.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fee209efb756..995ab8c47ef2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -118,6 +118,7 @@ enum iommu_attr {
>  	DOMAIN_ATTR_FSL_PAMUV1,
>  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> +	DOMAIN_ATTR_PGTABLE_CFG,
>  	DOMAIN_ATTR_MAX,
>  };

Nobody other than the adreno gpu uses this, so can we avoid exposing it
in the IOMMU API, please? Given that you have a reference to the adreno
GPU device in the SMMU implementation code thanks to .alloc_context_bank(),
can you squirrel some function pointers away in the driver data (i.e. with
dev_set_drvdata()) instead?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
