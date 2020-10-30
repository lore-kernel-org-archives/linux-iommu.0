Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE87C4742C
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 20:57:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0113D20791
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 20:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VimyRA9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0113D20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4BF20228D5;
	Fri, 30 Oct 2020 20:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olXeQ+h4f-CG; Fri, 30 Oct 2020 20:57:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 66D8D2048E;
	Fri, 30 Oct 2020 20:57:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A873C088B;
	Fri, 30 Oct 2020 20:57:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F79C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 20:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 55DED86847
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 20:57:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8dJLimneJVr3 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 20:57:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5AB5F86815
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 20:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604091421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G4Sd/bJr19YSAd9GdvU3fP5HNJ+0V8eKs7dPTIY2nYM=;
 b=VimyRA9VkpxqOY60/DABUybnq+F0tdV6HklJTGYSNl880oakJHpcwLpG32nGdjoJ/t6Wa6
 u0LyvMyHaO5CVFvddga+xvY9rAayS4fMr/iaVWBCld1BoGqkGl6pi5n99eRr4sdEj3XdaR
 0OFFrmbFXNni/7YSld7/O1NerOWmrL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-dQ9rhtvwMhy-8YCCyffXSA-1; Fri, 30 Oct 2020 16:56:58 -0400
X-MC-Unique: dQ9rhtvwMhy-8YCCyffXSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73C91087D68;
 Fri, 30 Oct 2020 20:56:56 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8918476642;
 Fri, 30 Oct 2020 20:56:55 +0000 (UTC)
Date: Fri, 30 Oct 2020 14:56:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v6 4/5] iommu/vt-d: Add iommu_ops support for subdevice bus
Message-ID: <20201030145655.07c692d8@w520.home>
In-Reply-To: <20201030045809.957927-5-baolu.lu@linux.intel.com>
References: <20201030045809.957927-1-baolu.lu@linux.intel.com>
 <20201030045809.957927-5-baolu.lu@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

On Fri, 30 Oct 2020 12:58:08 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> +static const struct iommu_ops siov_iommu_ops = {
> +	.capable		= intel_iommu_capable,
> +	.domain_alloc		= siov_iommu_domain_alloc,
> +	.domain_free		= intel_iommu_domain_free,
> +	.attach_dev		= siov_iommu_attach_device,
> +	.detach_dev		= siov_iommu_detach_device,
> +	.map			= intel_iommu_map,
> +	.unmap			= intel_iommu_unmap,
> +	.iova_to_phys		= intel_iommu_iova_to_phys,
> +	.probe_device		= siov_iommu_probe_device,
> +	.release_device		= siov_iommu_release_device,
> +	.get_resv_regions	= siov_iommu_get_resv_regions,
> +	.put_resv_regions	= generic_iommu_put_resv_regions,
> +	.device_group		= generic_device_group,
> +	.pgsize_bitmap		= (~0xFFFUL),
> +};
> +
> +void intel_siov_init(void)
> +{
> +	if (!scalable_mode_support() || !iommu_pasid_support())
> +		return;
> +
> +	bus_set_iommu(&mdev_bus_type, &siov_iommu_ops);
> +	pr_info("Intel(R) Scalable I/O Virtualization supported\n");
> +}

How can you presume to take over iommu_ops for an entire virtual bus?
This also forces mdev and all the dependencies of mdev to be built into
the kernel.  I don't find that acceptable.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
