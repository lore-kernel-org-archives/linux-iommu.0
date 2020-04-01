Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48A1C2D0F0
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 15:49:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2506214DB
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 15:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1X71f5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2506214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 81E2686DD6;
	Wed,  1 Apr 2020 15:49:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VAthNKR9KSk3; Wed,  1 Apr 2020 15:49:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B22F686DAD;
	Wed,  1 Apr 2020 15:49:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF51C1D7F;
	Wed,  1 Apr 2020 15:49:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84171C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 15:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7B38186C6A
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 15:49:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Nk4pZi_9QyK for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 15:49:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3D52985F19
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 15:49:43 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id m11so599228wrx.10
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C/6o2vAlNYHnEoJMtN8wwi/oRzeStDRZUTB/Nd2Hv7M=;
 b=V1X71f5rZiDGmnBfh3sBWCp7T9Jp+5xgMJtds1xfZSu8D+O/hvzseXEbwd0hbE/ic5
 x2TkT+43IaifgxbqN3WD5qF0jkxiEJn/vxu7PJRb8DLrWPo6nyc2sc0xJTT/Dgr5U/Ks
 I+dljP0laNt/dwhmWSN9NgnGnsQ5TIJIRWzDiczColatMsLZ4AxN0FV2nGqCjw0hr5vA
 Zoy0T/CjYuH6DlYK8xB91i5btiy69jf9MTCkULGVja5Tvk+K0iLwEzJSa0OqQVJ5Ulf2
 xfg3KFSYDoo0qFQSaOx3myBfeqcG6DhAd2eTiiX5P4BHoNaXawbCHD7VO9oOVywNrhMn
 kYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C/6o2vAlNYHnEoJMtN8wwi/oRzeStDRZUTB/Nd2Hv7M=;
 b=dDnQAt3a3Hwu9E39sfw96Tht4BJR6Z+GW2mLO2XxZt5EmDMhUQ5nOiFkfw3SKa1ngb
 5L4f5nY4yZh5xBNkhYOxyAppVVxBvloYjENJaHGfDKDY32d7YfFPnaaFcyXJlr4a7M1H
 d6rsxl590iIAH+8sXOwH16jTGTgH0nWhmbFpiM92ZKtISXq5uVZN5uyRr5zFpnIQ+O/X
 32raNPFNBxtURMjoQdC+xUEcn9B3xF5TyzheQF9WAHiTWxDptAnWtUfAyDKV/qrvkK/O
 a41PlfS1m4eWpj7pvGKoe6QS8bLyodaSn2IjZNexU6fVyNql0WMMgzP80NZfS3dlJnB6
 kkHg==
X-Gm-Message-State: ANhLgQ0Hf6heoUYkjuxrOdg1roH3rjdT8pfrli/1DPwfTlDljm1GVb7Y
 PCdC2Vben5qTF3umS8RTjYZI6A==
X-Google-Smtp-Source: ADFU+vsj+IPnTlTnW8cEeiZkmxOp3zrZSNdsM6O5dJ55cTv7aer2xndG3sAVVLsjPUulI2AMAH/7/g==
X-Received: by 2002:adf:84a3:: with SMTP id 32mr25563249wrg.378.1585756181494; 
 Wed, 01 Apr 2020 08:49:41 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id s131sm3258684wmf.35.2020.04.01.08.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 08:49:40 -0700 (PDT)
Date: Wed, 1 Apr 2020 17:49:32 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH v2] iommu/virtio: Use page size bitmap supported by
 endpoint
Message-ID: <20200401154932.GA1124215@myrica>
References: <20200401113804.21616-1-bbhushan2@marvell.com>
 <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b75beb74-89ce-fd6a-6207-3c0d7f479215@arm.com>
Cc: mst@redhat.com, jasowang@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Bharat Bhushan <bbhushan2@marvell.com>, eric.auger.pro@gmail.com
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

On Wed, Apr 01, 2020 at 02:00:13PM +0100, Robin Murphy wrote:
> On 2020-04-01 12:38 pm, Bharat Bhushan wrote:
> > Different endpoint can support different page size, probe
> > endpoint if it supports specific page size otherwise use
> > global page sizes.
> > 
> > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > ---
> >   drivers/iommu/virtio-iommu.c      | 33 +++++++++++++++++++++++++++----
> >   include/uapi/linux/virtio_iommu.h |  7 +++++++
> >   2 files changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > index cce329d71fba..c794cb5b7b3e 100644
> > --- a/drivers/iommu/virtio-iommu.c
> > +++ b/drivers/iommu/virtio-iommu.c
> > @@ -78,6 +78,7 @@ struct viommu_endpoint {
> >   	struct viommu_dev		*viommu;
> >   	struct viommu_domain		*vdomain;
> >   	struct list_head		resv_regions;
> > +	u64				pgsize_bitmap;
> >   };
> >   struct viommu_request {
> > @@ -415,6 +416,20 @@ static int viommu_replay_mappings(struct viommu_domain *vdomain)
> >   	return ret;
> >   }
> > +static int viommu_set_pgsize_bitmap(struct viommu_endpoint *vdev,
> > +				    struct virtio_iommu_probe_pgsize_mask *mask,
> > +				    size_t len)
> > +
> > +{
> > +	u64 pgsize_bitmap = le64_to_cpu(mask->pgsize_bitmap);
> > +
> > +	if (len < sizeof(*mask))
> > +		return -EINVAL;
> > +
> > +	vdev->pgsize_bitmap = pgsize_bitmap;
> > +	return 0;
> > +}
> > +
> >   static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
> >   			       struct virtio_iommu_probe_resv_mem *mem,
> >   			       size_t len)
> > @@ -494,11 +509,13 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
> >   	while (type != VIRTIO_IOMMU_PROBE_T_NONE &&
> >   	       cur < viommu->probe_size) {
> >   		len = le16_to_cpu(prop->length) + sizeof(*prop);
> > -

Whitespace change

> >   		switch (type) {
> >   		case VIRTIO_IOMMU_PROBE_T_RESV_MEM:
> >   			ret = viommu_add_resv_mem(vdev, (void *)prop, len);
> >   			break;
> > +		case VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK:
> > +			ret = viommu_set_pgsize_bitmap(vdev, (void *)prop, len);
> > +			break;
> >   		default:
> >   			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> >   		}
> > @@ -607,16 +624,23 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
> >   	return &vdomain->domain;
> >   }
> > -static int viommu_domain_finalise(struct viommu_dev *viommu,
> > +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
> >   				  struct iommu_domain *domain)
> >   {
> >   	int ret;
> >   	struct viommu_domain *vdomain = to_viommu_domain(domain);
> > +	struct viommu_dev *viommu = vdev->viommu;
> >   	vdomain->viommu		= viommu;
> >   	vdomain->map_flags	= viommu->map_flags;
> > -	domain->pgsize_bitmap	= viommu->pgsize_bitmap;
> > +	/* Devices in same domain must support same size pages */
> 
> AFAICS what the code appears to do is enforce that the first endpoint
> attached to any domain has the same pgsize_bitmap as the most recently
> probed viommu_dev instance, then ignore any subsequent endpoints attached to
> the same domain. Thus I'm not sure that comment is accurate.
> 

Yes viommu_domain_finalise() is only called once. What I had in mind is
something like:

---- 8< ----
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 750f69c49b95..8303b7b513ff 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -639,6 +639,29 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	return 0;
 }
 
+/*
+ * Check whether the endpoint's capabilities are compatible with other endpoints
+ * in the domain. Report any inconsistency.
+ */
+static bool viommu_endpoint_is_compatible(struct viommu_endpoint *vdev,
+					  struct viommu_domain *vdomain)
+{
+	struct device *dev = vdev->dev;
+
+	if (vdomain->viommu != vdev->viommu) {
+		dev_err(dev, "cannot attach to foreign vIOMMU\n");
+		return false;
+	}
+
+	if (vdomain->domain.pgsize_bitmap != vdev->pgsize_bitmap) {
+		dev_err(dev, "incompatible domain bitmap 0x%lx != 0x%lx\n",
+			vdomain->domain.pgsize_bitmap, vdev->pgsize_bitmap);
+		return false;
+	}
+
+	return true;
+}
+
 static void viommu_domain_free(struct iommu_domain *domain)
 {
 	struct viommu_domain *vdomain = to_viommu_domain(domain);
@@ -670,9 +693,8 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		 * owns it.
 		 */
 		ret = viommu_domain_finalise(vdev, domain);
-	} else if (vdomain->viommu != vdev->viommu) {
-		dev_err(dev, "cannot attach to foreign vIOMMU\n");
-		ret = -EXDEV;
+	} else if (!viommu_endpoint_is_compatible(vdev, vdomain)) {
+		ret = -EINVAL;
 	}
 	mutex_unlock(&vdomain->mutex);
---- >8 ----

> 
> > +	if ((domain->pgsize_bitmap != viommu->pgsize_bitmap) &&
> > +	    (domain->pgsize_bitmap != vdev->pgsize_bitmap))
> > +		return -EINVAL;
> > +
> > +	domain->pgsize_bitmap = vdev->pgsize_bitmap;
> > +
> >   	domain->geometry	= viommu->geometry;
> >   	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
> > @@ -657,7 +681,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >   		 * Properly initialize the domain now that we know which viommu
> >   		 * owns it.
> >   		 */
> > -		ret = viommu_domain_finalise(vdev->viommu, domain);
> > +		ret = viommu_domain_finalise(vdev, domain);
> >   	} else if (vdomain->viommu != vdev->viommu) {
> >   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
> >   		ret = -EXDEV;
> > @@ -875,6 +899,7 @@ static int viommu_add_device(struct device *dev)
> >   	vdev->dev = dev;
> >   	vdev->viommu = viommu;
> > +	vdev->pgsize_bitmap = viommu->pgsize_bitmap;
> >   	INIT_LIST_HEAD(&vdev->resv_regions);
> >   	fwspec->iommu_priv = vdev;
> > diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
> > index 237e36a280cb..dc9d3f40bcd8 100644
> > --- a/include/uapi/linux/virtio_iommu.h
> > +++ b/include/uapi/linux/virtio_iommu.h
> > @@ -111,6 +111,7 @@ struct virtio_iommu_req_unmap {
> >   #define VIRTIO_IOMMU_PROBE_T_NONE		0
> >   #define VIRTIO_IOMMU_PROBE_T_RESV_MEM		1
> > +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK	2
> >   #define VIRTIO_IOMMU_PROBE_T_MASK		0xfff
> > @@ -119,6 +120,12 @@ struct virtio_iommu_probe_property {
> >   	__le16					length;
> >   };
> > +struct virtio_iommu_probe_pgsize_mask {
> > +	struct virtio_iommu_probe_property	head;
> > +	__u8					reserved[4];
> > +	__u64					pgsize_bitmap;

Should be __le64

Thanks,
Jean

> > +};
> > +
> >   #define VIRTIO_IOMMU_RESV_MEM_T_RESERVED	0
> >   #define VIRTIO_IOMMU_RESV_MEM_T_MSI		1
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
