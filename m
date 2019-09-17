Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5924C4CECD
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 17:20:28 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3EE214AF
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 17:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJlZcMxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3EE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6802B16BB;
	Tue, 17 Sep 2019 17:20:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 13FE316B6
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 17:20:28 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 76FCA83A
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 17:20:25 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C131A2053B;
	Tue, 17 Sep 2019 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568740825;
	bh=LwKNamw9E4oxB1xQosrZOWdgQe92VETqR14nO7/u3js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJlZcMxRdss/C5nXphHfwkC11ZGWaIGXj83MelUvHMUq8I5gSd3pOW0iqwlgLnYdo
	Pgfz4aYr9Vr2E/C3Kyr89FbWapiRPt+LjPYLADOrXfUF9UNAeOhYsNWikqPBTHHu5L
	OYwtmN9LUz73DR3FfZJOVIZucfs12gYrcDTf4euM=
Date: Tue, 17 Sep 2019 18:20:20 +0100
From: Will Deacon <will@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH 5/7] iommu/arm-smmu: Support DOMAIN_ATTR_SPLIT_TABLES
Message-ID: <20190917172020.hpv5qqdpihvqkehp@willie-the-truck>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
	<1566327992-362-6-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1566327992-362-6-git-send-email-jcrouse@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Aug 20, 2019 at 01:06:30PM -0600, Jordan Crouse wrote:
> Support the DOMAIN_ATTR_SPLIT_TABLES attribute to let the leaf driver
> know if split pagetables are enabled for the domain.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  drivers/iommu/arm-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 3f41cf7..6a512ff 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1442,6 +1442,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>  		case DOMAIN_ATTR_NESTING:
>  			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
>  			return 0;
> +		case DOMAIN_ATTR_SPLIT_TABLES:
> +			*(int *)data = !!(smmu_domain->split_pagetables);
> +			return 0;

Hmm. Could you move the setting of this attribute into
arm_smmu_domain_set_attr() and reject it if the ias != 48 in there? That way
the user of the domain can request this feature, rather than us enforcing it
based on the compatible string.

I'd also prefer to call it DOMAIN_ATTR_USE_TTBR1 instead, since it's pretty
ARM specific at this point.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
