Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DDCC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 09:30:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE0F2073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 09:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE0F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EC20786EBA;
	Tue, 30 Jun 2020 09:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0rnEm40URmP4; Tue, 30 Jun 2020 09:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 78C0586EA1;
	Tue, 30 Jun 2020 09:30:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6756BC0865;
	Tue, 30 Jun 2020 09:30:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9C01C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 97E7387D5C
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d0mHe5st+4zr for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 09:30:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3BB7F87C42
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 09:30:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 2EEDB26B; Tue, 30 Jun 2020 11:30:41 +0200 (CEST)
Date: Tue, 30 Jun 2020 11:30:39 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Ott <sebott@amazon.de>
Subject: Re: [PATCH 3/3] iommu/amd: Actually enforce geometry aperture
Message-ID: <20200630093039.GC28824@8bytes.org>
References: <20200605145655.13639-1-sebott@amazon.de>
 <20200605145655.13639-4-sebott@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200605145655.13639-4-sebott@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Benjamin Serebrin <serebrin@amazon.com>, Filippo Sironi <sironi@amazon.de>,
 iommu@lists.linux-foundation.org
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

Hi Sebastian,

On Fri, Jun 05, 2020 at 04:56:55PM +0200, Sebastian Ott wrote:
> Add a check to enforce that I/O virtual addresses picked by iommu API
> users stay within the domains geometry aperture.
> 
> Signed-off-by: Sebastian Ott <sebott@amazon.de>
> ---
>  drivers/iommu/amd_iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index d2e79e27778e..6485e2081706 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -2618,6 +2618,11 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
>  	if (pgtable.mode == PAGE_MODE_NONE)
>  		return -EINVAL;
>  
> +	if (dom->geometry.force_aperture &&
> +	    (iova < dom->geometry.aperture_start ||
> +	     iova + page_size - 1 > dom->geometry.aperture_end))
> +		return -EINVAL;
> +
>  	if (iommu_prot & IOMMU_READ)
>  		prot |= IOMMU_PROT_IR;
>  	if (iommu_prot & IOMMU_WRITE)

This patch need also make iommu_setup_dma_ops() aware of the aperture
limits.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
