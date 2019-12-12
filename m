Return-Path: <SRS0=PSAu=2C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D60C43603
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 08:49:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF827214AF
	for <iommu@archiver.kernel.org>; Thu, 12 Dec 2019 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpgkGTq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF827214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9CDD986F33;
	Thu, 12 Dec 2019 08:49:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t4nq07Ojx_7M; Thu, 12 Dec 2019 08:49:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0C8CB86F2B;
	Thu, 12 Dec 2019 08:49:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9875C18DC;
	Thu, 12 Dec 2019 08:49:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D75B3C0881
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 08:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C595588209
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 08:49:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5jIiunOShw1Q for <iommu@lists.linux-foundation.org>;
 Thu, 12 Dec 2019 08:49:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9C05D88123
 for <iommu@lists.linux-foundation.org>; Thu, 12 Dec 2019 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576140590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XU8C1Psaz8RZuU79QNmRojT39LJM3bRqBVxPl66VVQo=;
 b=FpgkGTq6wFX8Ne4QFxTbhPmQ2h9fB4MOV6UG/ZaxW14gppIO5TDiyNMokOQMCCAmx7DWyY
 fapsd6GjCpGqpqglXpQxycUG+gO3szd1dQt6aVrJqs6TY8+/ltYD6HaCIwwo1QXF9+vM1A
 6UW1FSGjj/N2pCkGFR/IX3l03wdlTsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-8MN0vYdoOCyb_V4Zrt5Ulg-1; Thu, 12 Dec 2019 03:49:44 -0500
X-MC-Unique: 8MN0vYdoOCyb_V4Zrt5Ulg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20EDC800EB5;
 Thu, 12 Dec 2019 08:49:43 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6075067E6D;
 Thu, 12 Dec 2019 08:49:39 +0000 (UTC)
Subject: Re: [PATCH] iommu/vt-d: Set ISA bridge reserved region as relaxable
To: Alex Williamson <alex.williamson@redhat.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, baolu.lu@linux.intel.com
References: <157609608124.14870.10855090013879818212.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e330865d-6f88-4537-72c6-f0ecc8252327@redhat.com>
Date: Thu, 12 Dec 2019 09:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <157609608124.14870.10855090013879818212.stgit@gimli.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: cprt@protonmail.com, eauger@redhat.com
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

Hi Alex,

On 12/11/19 9:28 PM, Alex Williamson wrote:
> Commit d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via
> iommu_get_resv_regions") created a direct-mapped reserved memory region
> in order to replace the static identity mapping of the ISA address
> space, where the latter was then removed in commit df4f3c603aeb
> ("iommu/vt-d: Remove static identity map code").  According to the
> history of this code and the Kconfig option surrounding it, this direct
> mapping exists for the benefit of legacy ISA drivers that are not
> compatible with the DMA API.
> 
> In conjuntion with commit 9b77e5c79840 ("vfio/type1: check dma map
> request is within a valid iova range") this change introduced a
> regression where the vfio IOMMU backend enforces reserved memory regions
> per IOMMU group, preventing userspace from creating IOMMU mappings
> conflicting with prescribed reserved regions.  A necessary prerequisite
> for the vfio change was the introduction of "relaxable" direct mappings
> introduced by commit adfd37382090 ("iommu: Introduce
> IOMMU_RESV_DIRECT_RELAXABLE reserved memory regions").  These relaxable
> direct mappings provide the same identity mapping support in the default
> domain, but also indicate that the reservation is software imposed and
> may be relaxed under some conditions, such as device assignment.
> 
> Convert the ISA bridge direct-mapped reserved region to relaxable to
> reflect that the restriction is self imposed and need not be enforced
> by drivers such as vfio.
> 
> Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
Maybe it is rather a fix of my patch, below, since above patch landed
upstream before the IOMMU_RESV_DIRECT_RELAXABLE availability.

Fixes: 1c5c59fbad20 ("iommu/vt-d: Differentiate relaxable and non
relaxable RMRRs")
> Cc: stable@vger.kernel.org # v5.3+
> Link: https://lore.kernel.org/linux-iommu/20191211082304.2d4fab45@x1.home
> Reported-by: cprt <cprt@protonmail.com>
> Tested-by: cprt <cprt@protonmail.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/intel-iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 0c8d81f56a30..6eb0dd7489a1 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5737,7 +5737,7 @@ static void intel_iommu_get_resv_regions(struct device *device,
>  
>  		if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_ISA) {
>  			reg = iommu_alloc_resv_region(0, 1UL << 24, 0,
> -						      IOMMU_RESV_DIRECT);
> +						   IOMMU_RESV_DIRECT_RELAXABLE);
>  			if (reg)
>  				list_add_tail(&reg->list, head);
>  		}
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
