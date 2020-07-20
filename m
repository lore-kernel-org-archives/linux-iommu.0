Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_WP_DIRINDEX,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5483AC433E1
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:23:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7F82080D
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X9UnxWVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7F82080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AA3888723E;
	Mon, 20 Jul 2020 12:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vjo4R9Gd6k-a; Mon, 20 Jul 2020 12:23:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9561387221;
	Mon, 20 Jul 2020 12:23:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AE59C0894;
	Mon, 20 Jul 2020 12:23:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32D5CC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1A7FC2048A
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ypr89yxGDGfw for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 12:22:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 0E9F320474
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595247776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFM1Qo8fTP4agFAqoUXIx/sYoR1DNoACJDTPmZRrdKQ=;
 b=X9UnxWVHL5izrQ1RjvfYVnafId/SXmYNzyprQPtI5R6ZxsSay9d2uOQmgdZf90HbRBzyEj
 +6Owrq30ujNmJnHT3pZnrEsyU5jiltmNCxocMYqahQJ/O/RwFg/867nROTP9sDi41Mcbl6
 cJozVcMOBsJaeYmzcpVzhR65koJCfwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514--fmzgAVpM3WTrqd1e3leqw-1; Mon, 20 Jul 2020 08:22:30 -0400
X-MC-Unique: -fmzgAVpM3WTrqd1e3leqw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28EFC800597;
 Mon, 20 Jul 2020 12:22:28 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B80272B6E2;
 Mon, 20 Jul 2020 12:22:18 +0000 (UTC)
Subject: Re: [PATCH v5 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
To: Liu Yi L <yi.l.liu@intel.com>, alex.williamson@redhat.com,
 baolu.lu@linux.intel.com, joro@8bytes.org
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-13-git-send-email-yi.l.liu@intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5921bffc-9daa-99be-9a12-6d94ce1950d2@redhat.com>
Date: Mon, 20 Jul 2020 14:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594552870-55687-13-git-send-email-yi.l.liu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, jun.j.tian@intel.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 yi.y.sun@intel.com, hao.wu@intel.com
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

Yi,

On 7/12/20 1:21 PM, Liu Yi L wrote:
> Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> is used to achieve flexible device sharing across domains (e.g. VMs).
> Also there are hardware assisted mediated pass-through solutions from
> platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
there is IOMMU enforced DMA isolation
> In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
> concept, which means mdevs are protected by an iommu domain which is
> auxiliary to the domain that the kernel driver primarily uses for DMA
> API. Details can be found in the KVM presentation as below:
> 
> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> 
> This patch extends NESTING_IOMMU ops to IOMMU-backed mdev devices. The
> main requirement is to use the auxiliary domain associated with mdev.

So as a result vSVM becomes functional for scalable mode mediated
devices, right?
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> CC: Jun Tian <jun.j.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v1 -> v2:
> *) check the iommu_device to ensure the handling mdev is IOMMU-backed
> ---
>  drivers/vfio/vfio_iommu_type1.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 960cc59..f1f1ae2 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2373,20 +2373,41 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static struct device *vfio_get_iommu_device(struct vfio_group *group,
> +					    struct device *dev)
> +{
> +	if (group->mdev_group)
> +		return vfio_mdev_get_iommu_device(dev);
> +	else
> +		return dev;
> +}
> +
>  static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	return iommu_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> +	return iommu_sva_bind_gpasid(dc->domain, iommu_device,
> +				     (void __user *)arg);
>  }
>  
>  static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
>  
> -	iommu_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
> +
> +	iommu_sva_unbind_gpasid(dc->domain, iommu_device,
> +				(void __user *)arg);
>  	return 0;
>  }
>  
> @@ -2395,8 +2416,13 @@ static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	struct iommu_gpasid_bind_data *unbind_data =
>  				(struct iommu_gpasid_bind_data *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	__iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> +	__iommu_sva_unbind_gpasid(dc->domain, iommu_device, unbind_data);
>  	return 0;
>  }
>  
> @@ -3077,8 +3103,13 @@ static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	iommu_cache_invalidate(dc->domain, dev, (void __user *)arg);
> +	iommu_cache_invalidate(dc->domain, iommu_device, (void __user *)arg);
>  	return 0;
>  }
>  
> 
Besides,

Looks grood to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
