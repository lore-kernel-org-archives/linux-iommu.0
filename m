Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E8C433E3
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:03:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC352065C
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AC6I72s0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC352065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D688A87E45;
	Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 49G0gtEhGD-F; Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5FCF787B5E;
	Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B7CAC0050;
	Wed, 29 Jul 2020 20:03:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91976C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7DF7F87E07
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q9mFrWH02tFe for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 20:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D5E787B5E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 20:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596053030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeyS6hEHiK3c3NVQsKxvW8k7HJvPYBCqvPsl0jPPbrg=;
 b=AC6I72s0MNejLJkpvizw7rA92PgnBOw1iTpLhE5UaCygkWu5NFrXmWtlwXIi+MlaIT8WUb
 HuizyLnxzX+grPvKZa8vphvmz9+jf4+9sgCfdhhcyD0zZVxKwTu2EBN6gc3F7w3/e8//3z
 zylfxjCnUFrHv5NBPwS5Ua8pI51PmS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-lV5JfxIrNgqWJ0JBZrb2PA-1; Wed, 29 Jul 2020 16:03:46 -0400
X-MC-Unique: lV5JfxIrNgqWJ0JBZrb2PA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C6D98017FB;
 Wed, 29 Jul 2020 20:03:44 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A82F5C6C0;
 Wed, 29 Jul 2020 20:03:43 +0000 (UTC)
Date: Wed, 29 Jul 2020 14:03:43 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 1/4] iommu: Check IOMMU_DEV_FEAT_AUX feature in aux
 api's
Message-ID: <20200729140343.2b7047b2@x1.home>
In-Reply-To: <20200714055703.5510-2-baolu.lu@linux.intel.com>
References: <20200714055703.5510-1-baolu.lu@linux.intel.com>
 <20200714055703.5510-2-baolu.lu@linux.intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Tue, 14 Jul 2020 13:57:00 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The iommu aux-domain api's work only when IOMMU_DEV_FEAT_AUX is enabled
> for the device. Add this check to avoid misuse.

Shouldn't this really be the IOMMU driver's responsibility to test?  If
nothing else, iommu_dev_feature_enabled() needs to get the iommu_ops
from dev->bus->iommu_ops, which is presumably the same iommu_ops we're
then calling from domain->ops to attach/detach the device, so it'd be
more efficient for the IOMMU driver to error on devices that don't
support aux.  Thanks,

Alex

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1ed1e14a1f0c..e1fdd3531d65 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2725,11 +2725,13 @@ EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>   */
>  int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev)
>  {
> -	int ret = -ENODEV;
> +	int ret;
>  
> -	if (domain->ops->aux_attach_dev)
> -		ret = domain->ops->aux_attach_dev(domain, dev);
> +	if (!iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) ||
> +	    !domain->ops->aux_attach_dev)
> +		return -ENODEV;
>  
> +	ret = domain->ops->aux_attach_dev(domain, dev);
>  	if (!ret)
>  		trace_attach_device_to_domain(dev);
>  
> @@ -2748,12 +2750,12 @@ EXPORT_SYMBOL_GPL(iommu_aux_detach_device);
>  
>  int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  {
> -	int ret = -ENODEV;
> +	if (!iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX) ||
> +	    !domain->ops->aux_get_pasid)
> +		return -ENODEV;
>  
> -	if (domain->ops->aux_get_pasid)
> -		ret = domain->ops->aux_get_pasid(domain, dev);
> +	return domain->ops->aux_get_pasid(domain, dev);
>  
> -	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
