Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70CAC433E2
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 09:39:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973D72077D
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 09:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973D72077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6364F87F72;
	Thu,  4 Jun 2020 09:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBOtEyC6Jasu; Thu,  4 Jun 2020 09:39:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CBABD8794A;
	Thu,  4 Jun 2020 09:39:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AACA9C0881;
	Thu,  4 Jun 2020 09:39:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5013C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:39:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BB302887FC
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SxBP6J4lgJyD for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 09:39:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 782CC887F9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:39:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 7562426F; Thu,  4 Jun 2020 11:39:38 +0200 (CEST)
Date: Thu, 4 Jun 2020 11:39:36 +0200
From: Joerg Roedel <joro@8bytes.org>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jerry Snitselaar <jsnitsel@redhat.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu: Check for deferred attach in
 iommu_group_do_dma_attach()
Message-ID: <20200604093936.GK14598@8bytes.org>
References: <20200604091944.26402-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200604091944.26402-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

On Thu, Jun 04, 2020 at 11:19:44AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The iommu_group_do_dma_attach() must not attach devices which have
> deferred_attach set. Otherwise devices could cause IOMMU faults when
> re-initialized in a kdump kernel.
> 
> Fixes: deac0b3bed26 ("iommu: Split off default domain allocation from group assignment")
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b5ea203f6c68..5a6d509f72b6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1680,8 +1680,12 @@ static void probe_alloc_default_domain(struct bus_type *bus,
>  static int iommu_group_do_dma_attach(struct device *dev, void *data)
>  {
>  	struct iommu_domain *domain = data;
> +	int ret = 0;
>  
> -	return __iommu_attach_device(domain, dev);
> +	if (!iommu_is_attach_deferred(group->domain, dev))
> +		ret = __iommu_attach_device(group->domain, dev);

And of course with the same bug as my original diff. Fixed that up
before applying it. (group->domain -> domain).


	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
