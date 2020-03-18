Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238EEC4332B
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 22:19:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA0982076C
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 22:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnQF0+4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0982076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AFEA9866C4;
	Wed, 18 Mar 2020 22:19:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TXFYXit4R_ZY; Wed, 18 Mar 2020 22:19:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4001A85F7E;
	Wed, 18 Mar 2020 22:19:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27CD0C18DA;
	Wed, 18 Mar 2020 22:19:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43B85C087F
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 22:19:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3FA4F866C4
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 22:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jvv4tvT0Dy11 for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 22:19:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C602785F7E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 22:19:31 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C65D20714;
 Wed, 18 Mar 2020 22:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584569971;
 bh=IkV7guYcGBxx2wF92laAcTYpfXKU9uSDklWHHX0Iz94=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OnQF0+4Fq6ZNErBMLjeBnH8eIAgbVa+7NytYYV5+s3FzNuXdZVGumjsJMV46J1i3m
 Fczeub7M4DVnFJf7bOPFYhY7AN1KHPqpGhewr+DNzAM7W1xUc1DtEif0df2irzmkoN
 64SEigRAb7LTCH/TL7CWVjn9aV3zIdYKrOwhvplw=
Date: Wed, 18 Mar 2020 22:19:27 +0000
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Add SMMUv3.2 range invalidation
 support
Message-ID: <20200318221926.GA10097@willie-the-truck>
References: <20200224223129.1068-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224223129.1068-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
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

Hi Rob,

On Mon, Feb 24, 2020 at 04:31:29PM -0600, Rob Herring wrote:
> Arm SMMUv3.2 adds support for TLB range invalidate operations.
> Support for range invalidate is determined by the RIL bit in the IDR3
> register.
> 
> The range invalidate is in units of the leaf page size and operates on
> 1-32 chunks of a power of 2 multiple pages. First, we determine from the
> size what power of 2 multiple we can use. Then we calculate how many
> chunks (1-31) of the power of 2 size for the range on the iteration. On
> each iteration, we move up in size by at least 5 bits.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v3:
> - Use inv_range local instead of modifying granule
> - Simplify the TG calculation
> - Use shift instead of divide by power of 2.
> ---
>  drivers/iommu/arm-smmu-v3.c | 69 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 67 insertions(+), 2 deletions(-)

I've queued this one, but I had to resolve some conflicts with the command
queue batching changes, so please can you take a quick look at my
resolution?

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/commit/?h=for-joerg/arm-smmu/updates

Cheers,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
