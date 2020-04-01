Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A05C43331
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 08:51:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F5D20784
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 08:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCI48Kob"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F5D20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 50BEA8993D;
	Wed,  1 Apr 2020 08:51:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uobGSSj8wxW; Wed,  1 Apr 2020 08:51:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 722F489932;
	Wed,  1 Apr 2020 08:51:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 633C8C1AE2;
	Wed,  1 Apr 2020 08:51:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF39C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 08:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 67DA5884F3
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 08:51:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QM2K1ib5VohN for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 08:51:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 60D3286866
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 08:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585731077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k51ON82VcZwelzrYwCOEF4ihu17AnECiYNHTB0XAM+E=;
 b=cCI48KobJU/CAFjy+74ZLnNWqbKbh80e1rEbjELTz+uvIxvFxzNVwTnXJ5R/aPA6Z+gkoC
 lLHZmJq/27h/A7dlQd+n5IfX/SRl1MQqFTbA8ggjrYueBuci9zCD6uhRuk8tN/DjFnhN2h
 hFAhqhIAypP4iXWWFyYT4cOwDSZ2uRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-dy1z8-k7M5OxSU80lgCm-A-1; Wed, 01 Apr 2020 04:51:13 -0400
X-MC-Unique: dy1z8-k7M5OxSU80lgCm-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B6E18A6ECE;
 Wed,  1 Apr 2020 08:51:11 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFC0699DF3;
 Wed,  1 Apr 2020 08:51:02 +0000 (UTC)
Subject: Re: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
To: "Liu, Yi L" <yi.l.liu@intel.com>, alex.williamson@redhat.com
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cb68e9ab-77b0-7e97-a661-4836962041d9@redhat.com>
Date: Wed, 1 Apr 2020 10:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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

Hi Yi,
On 3/22/20 1:32 PM, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> VFIO exposes IOMMU nesting translation (a.k.a dual stage translation)
> capability to userspace. Thus applications like QEMU could support
> vIOMMU with hardware's nesting translation capability for pass-through
> devices. Before setting up nesting translation for pass-through devices,
> QEMU and other applications need to learn the supported 1st-lvl/stage-1
> translation structure format like page table format.
> 
> Take vSVA (virtual Shared Virtual Addressing) as an example, to support
> vSVA for pass-through devices, QEMU setup nesting translation for pass-
> through devices. The guest page table are configured to host as 1st-lvl/
> stage-1 page table. Therefore, guest format should be compatible with
> host side.
> 
> This patch reports the supported 1st-lvl/stage-1 page table format on the
> current platform to userspace. QEMU and other alike applications should
> use this format info when trying to setup IOMMU nesting translation on
> host IOMMU.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 56 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  1 +
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 9aa2a67..82a9e0b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2234,11 +2234,66 @@ static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_iommu_get_stage1_format(struct vfio_iommu *iommu,
> +					 u32 *stage1_format)
vfio_pasid_format() to be homogeneous with vfio_pgsize_bitmap() which
does the same kind of enumeration of the vfio_iommu domains
> +{
> +	struct vfio_domain *domain;
> +	u32 format = 0, tmp_format = 0;
> +	int ret;
ret = -EINVAL;
> +
> +	mutex_lock(&iommu->lock);
> +	if (list_empty(&iommu->domain_list)) {
goto out_unlock;
> +		mutex_unlock(&iommu->lock);
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(domain, &iommu->domain_list, next) {
> +		if (iommu_domain_get_attr(domain->domain,
> +			DOMAIN_ATTR_PASID_FORMAT, &format)) {
I can find DOMAIN_ATTR_PASID_FORMAT in Jacob's v9 but not in v10
> +			ret = -EINVAL;
could be removed
> +			format = 0;
> +			goto out_unlock;
> +		}
> +		/*
> +		 * format is always non-zero (the first format is
> +		 * IOMMU_PASID_FORMAT_INTEL_VTD which is 1). For
> +		 * the reason of potential different backed IOMMU
> +		 * formats, here we expect to have identical formats
> +		 * in the domain list, no mixed formats support.
> +		 * return -EINVAL to fail the attempt of setup
> +		 * VFIO_TYPE1_NESTING_IOMMU if non-identical formats
> +		 * are detected.
> +		 */
> +		if (tmp_format && tmp_format != format) {
> +			ret = -EINVAL;
could be removed
> +			format = 0;
> +			goto out_unlock;
> +		}
> +
> +		tmp_format = format;
> +	}
> +	ret = 0;
> +
> +out_unlock:
> +	if (format)
if (!ret) ? then you can remove the format = 0 in case of error.
> +		*stage1_format = format;
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
>  					 struct vfio_info_cap *caps)
>  {
>  	struct vfio_info_cap_header *header;
>  	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> +	u32 formats = 0;
> +	int ret;
> +
> +	ret = vfio_iommu_get_stage1_format(iommu, &formats);
> +	if (ret) {
> +		pr_warn("Failed to get stage-1 format\n");
trace triggered by userspace to be removed?
> +		return ret;
> +	}
>  
>  	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
>  				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> @@ -2254,6 +2309,7 @@ static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
>  		/* nesting iommu type supports PASID requests (alloc/free) */
>  		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
What is the meaning for ARM?
>  	}
> +	nesting_cap->stage1_formats = formats;
as spotted by Kevin, since a single format is supported, rename
>  
>  	return 0;
>  }
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index ed9881d..ebeaf3e 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -763,6 +763,7 @@ struct vfio_iommu_type1_info_cap_nesting {
>  	struct	vfio_info_cap_header header;
>  #define VFIO_IOMMU_PASID_REQS	(1 << 0)
>  	__u32	nesting_capabilities;
> +	__u32	stage1_formats;
>  };
>  
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> 
Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
