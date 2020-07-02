Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF3C433E1
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 08:39:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0126A2084C
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 08:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4Yc/C8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0126A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B401C8B290;
	Thu,  2 Jul 2020 08:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NPWmcsSxO9UG; Thu,  2 Jul 2020 08:39:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1C4BA8AF10;
	Thu,  2 Jul 2020 08:39:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00898C0890;
	Thu,  2 Jul 2020 08:39:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10F68C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 08:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ED0678A7B6
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 08:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3gxe7M6ZI0iE for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 08:39:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E98718A7B4
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 08:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593679173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StuPzHVgAIa3558kdBGKp0xFyX4a1jvLpYin4jiIWa8=;
 b=C4Yc/C8OplrI20M3k2OmlODBangrr/fqqL1t3JzD5Bu59SkDF6ficLNEWHLX4eBRa+cvId
 Rt0WH1knItN5KXXzlilHnws8bNoFxacEMBghhiQjgXDSvjvXz6XUdXilgGnJgjhdiThk1s
 czzjyiUPF2RdesNpvbrXYxYRBfbP844=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-nbNwT6YTNKGwD17lW4gM8A-1; Thu, 02 Jul 2020 04:39:31 -0400
X-MC-Unique: nbNwT6YTNKGwD17lW4gM8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF8088010EF;
 Thu,  2 Jul 2020 08:39:29 +0000 (UTC)
Received: from [10.36.112.70] (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7AED19D7E;
 Thu,  2 Jul 2020 08:39:27 +0000 (UTC)
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Fix devTLB flush for vSVA
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-6-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <f44409e8-7c68-9b26-cf87-b0887668e879@redhat.com>
Date: Thu, 2 Jul 2020 10:39:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1593617636-79385-6-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

Hi Jacob, Yi,
On 7/1/20 5:33 PM, Jacob Pan wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> For guest SVA usage, in order to optimize for less VMEXIT, guest request
> of IOTLB flush also includes device TLB.
> 
> On the host side, IOMMU driver performs IOTLB and implicit devTLB
> invalidation. When PASID-selective granularity is requested by the guest
> we need to derive the equivalent address range for devTLB instead of
> using the address information in the UAPI data. The reason for that is, unlike
> IOTLB flush, devTLB flush does not support PASID-selective granularity.
> This is to say, we need to set the following in the PASID based devTLB
> invalidation descriptor:
> - entire 64 bit range in address ~(0x1 << 63)
> - S bit = 1 (VT-d CH 6.5.2.6).
> 
> Without this fix, device TLB flush range is not set properly for PASID
> selective granularity. This patch also merged devTLB flush code for both
> implicit and explicit cases.
> 
> Fixes: 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 96340da57075..6a0c62c7395c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5408,7 +5408,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  	sid = PCI_DEVID(bus, devfn);
>  
>  	/* Size is only valid in address selective invalidation */
> -	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> +	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
>  		size = to_vtd_size(inv_info->addr_info.granule_size,
>  				   inv_info->addr_info.nb_granules);
>  
> @@ -5417,6 +5417,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  			 IOMMU_CACHE_INV_TYPE_NR) {
>  		int granu = 0;
>  		u64 pasid = 0;
> +		u64 addr = 0;
>  
>  		granu = to_vtd_granularity(cache_type, inv_info->granularity);
>  		if (granu == -EINVAL) {
> @@ -5456,24 +5457,31 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>  					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
>  					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
>  
> +			if (!info->ats_enabled)
> +				break;
>  			/*
>  			 * Always flush device IOTLB if ATS is enabled. vIOMMU
>  			 * in the guest may assume IOTLB flush is inclusive,
>  			 * which is more efficient.
>  			 */
> -			if (info->ats_enabled)
> -				qi_flush_dev_iotlb_pasid(iommu, sid,
> -						info->pfsid, pasid,
> -						info->ats_qdep,
> -						inv_info->addr_info.addr,
> -						size);
> -			break;
> +			fallthrough;
>  		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			/*
> +			 * There is no PASID selective flush for device TLB, so
> +			 * the equivalent of that is we set the size to be the
> +			 * entire range of 64 bit. User only provides PASID info
> +			 * without address info. So we set addr to 0.
The "PASID selective flush for device TLB" terminology above sounds a
bit confusing to me. I would rather say Intel device TLB has no support
for OMMU_INV_GRANU_PASID granularity but only supports
IOMMU_INV_GRANU_ADDR. Indeed 6.5.2.6 title is "PASID-based-Device-TLB
Invalidate Descriptor"
> +			 */
> +			if (inv_info->granularity == IOMMU_INV_GRANU_PASID) {
> +				size = 64 - VTD_PAGE_SHIFT;
> +				addr = 0;
I have my answer for previous patch review question. In that case the
addr is not formatted with the least significant 0 matching the size_order.

> +			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
> +				addr = inv_info->addr_info.addr;
> +
>  			if (info->ats_enabled)
>  				qi_flush_dev_iotlb_pasid(iommu, sid,
>  						info->pfsid, pasid,
> -						info->ats_qdep,
> -						inv_info->addr_info.addr,
> +						info->ats_qdep, addr,
>  						size);
>  			else
>  				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
> 

Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
