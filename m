Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7137EC2BA12
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 18:01:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C8C206F6
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 18:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e7kr5e83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C8C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 11B7B88447;
	Thu,  2 Apr 2020 18:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oomq4YdL0FdN; Thu,  2 Apr 2020 18:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 73AB58842A;
	Thu,  2 Apr 2020 18:01:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A478C1AE2;
	Thu,  2 Apr 2020 18:01:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87D6BC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 18:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7741088443
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 18:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cIRFI1zNTXXE for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 18:01:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0FD5B8842A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585850475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuJXTu9rJu0+h7TGYhV5Gmdmq14OC6YvWqcRaZtvH2U=;
 b=e7kr5e83CdO653WwBcMBdjHE3wUn0tzJN5hw/VSEAyyjlL9r4tP0gXFAopCFN6kN9Q2p8a
 JIMBUPtfKY3g0ZW0ElznGWLospi+Etzt3aPEgPmiN+EF9c63KYgd2+BgY9+aa9o2EYhySZ
 rtolV08S1UeAXajfCT+UvtErxGWwQS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-36_XwoHxOCqhaXgOqqEFPQ-1; Thu, 02 Apr 2020 14:01:14 -0400
X-MC-Unique: 36_XwoHxOCqhaXgOqqEFPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20E749A682;
 Thu,  2 Apr 2020 18:01:02 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FB115E000;
 Thu,  2 Apr 2020 18:01:01 +0000 (UTC)
Date: Thu, 2 Apr 2020 12:01:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
Message-ID: <20200402120100.19e43c72@w520.home>
In-Reply-To: <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Sun, 22 Mar 2020 05:32:00 -0700
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
> 
> This patch reports PASID alloc/free availability to userspace (e.g. QEMU)
> thus userspace could do a pre-check before utilizing this feature.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  8 ++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e40afc0..ddd1ffe 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2234,6 +2234,30 @@ static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> +					 struct vfio_info_cap *caps)
> +{
> +	struct vfio_info_cap_header *header;
> +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> +
> +	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> +	if (IS_ERR(header))
> +		return PTR_ERR(header);
> +
> +	nesting_cap = container_of(header,
> +				struct vfio_iommu_type1_info_cap_nesting,
> +				header);
> +
> +	nesting_cap->nesting_capabilities = 0;
> +	if (iommu->nesting) {
> +		/* nesting iommu type supports PASID requests (alloc/free) */
> +		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> +	}
> +
> +	return 0;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2283,6 +2307,10 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		if (ret)
>  			return ret;
>  
> +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> +		if (ret)
> +			return ret;
> +
>  		if (caps.size) {
>  			info.flags |= VFIO_IOMMU_INFO_CAPS;
>  
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 298ac80..8837219 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -748,6 +748,14 @@ struct vfio_iommu_type1_info_cap_iova_range {
>  	struct	vfio_iova_range iova_ranges[];
>  };
>  
> +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  2
> +
> +struct vfio_iommu_type1_info_cap_nesting {
> +	struct	vfio_info_cap_header header;
> +#define VFIO_IOMMU_PASID_REQS	(1 << 0)
> +	__u32	nesting_capabilities;
> +};
> +
>  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
>  
>  /**

I think this answers my PROBE question on patch 1/.  Should the
quota/usage be exposed to the user here?  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
