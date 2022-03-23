Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6712C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 18:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52D9141B69;
	Wed, 23 Mar 2022 18:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3d_hgBpISxv; Wed, 23 Mar 2022 18:10:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1260941B80;
	Wed, 23 Mar 2022 18:10:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D457CC0012;
	Wed, 23 Mar 2022 18:10:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CDA4C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:10:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42EB840195
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:10:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TTPLb_rujLP7 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 18:10:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4892E400C4
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 18:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648059007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VLCjEJMsxD02pVC+ZWBt5x6radALOQJ9jfriiBMEERg=;
 b=WzE1g14/eNmM3Felyp41N0T/MKFBvdUbe1tKFUNFL/EhFFMCzDnv2Ahsi295l99p8dyYMP
 nSNNGQgRkckyzNF+pC8B5aPxrPBsqix4EMMJdVqeKILqG/0BQPe95PvOmV5HcUmiorXtot
 yaJCOvTWfEC0B3vGshzUs0Grz6DMKJw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-20-jxKftl39Ox2C_BKgXefhCQ-1; Wed, 23 Mar 2022 14:10:06 -0400
X-MC-Unique: jxKftl39Ox2C_BKgXefhCQ-1
Received: by mail-oo1-f72.google.com with SMTP id
 t2-20020a4a7442000000b003245b0660afso1379741ooe.10
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 11:10:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=VLCjEJMsxD02pVC+ZWBt5x6radALOQJ9jfriiBMEERg=;
 b=fZlsyinxCsRH75AhSDzFbI54xHXO4SLBqE6K+g/xGZ8eoaxuzaAue82+M2ssKRDGan
 DDyvyJkUIPsanuTnAJ6X7KX0J1oqj4ddOaRvOKViQHuEoPTuf4LHmKUGgBwvMKgjrn1P
 MgHZTxD7vLu9VsWEguTDzZyWUNsd5S+gKbOSj+yA9j9YPVl6+2lty9yli/tJ6QTwNAbB
 OolC3xvv882S+xcbJMmq/ar12jLf91YTgSsteKEPR8VOLsNSZFURxm/VvQXRqT0Nbte+
 2gLzZsTcH7HiedIZZrjSp+UIPzLtjbSzwAy/6TAzMZBGXDdABARuAEWiod8++AuIfoGD
 UMtA==
X-Gm-Message-State: AOAM530TBMP9dO3BFy2qENocAlZlAVK/0m6bv8vnUjyuL7l+Vy+uCg3N
 dWWyFxmI0T7GKng3r/IwQLFX9cM2xoaIazrjKKvtAcu+eFMoOhXPvtRgzaYJ/S+C1TlScjjj3ny
 3znA2SDH/LMWJln9a821iQlaJTQTK2g==
X-Received: by 2002:a05:6870:610c:b0:de:8b7a:2c1b with SMTP id
 s12-20020a056870610c00b000de8b7a2c1bmr43586oae.268.1648059004699; 
 Wed, 23 Mar 2022 11:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrHaHkpxaFJ1Iy7hVsicFX1/wa0wSpP7Cj69xLCpwRuJbeH7W0SJG2cbEcbPVL/3gVNWgelw==
X-Received: by 2002:a05:6870:610c:b0:de:8b7a:2c1b with SMTP id
 s12-20020a056870610c00b000de8b7a2c1bmr43567oae.268.1648059004457; 
 Wed, 23 Mar 2022 11:10:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 r23-20020a056830237700b005b2610517c8sm306881oth.56.2022.03.23.11.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Mar 2022 11:10:04 -0700 (PDT)
Date: Wed, 23 Mar 2022 12:10:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH RFC 10/12] iommufd: Add kAPI toward external drivers
Message-ID: <20220323121001.5b1c8c5d.alex.williamson@redhat.com>
In-Reply-To: <10-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
References: <0-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <10-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Niklas Schnelle <schnelle@linux.ibm.com>,
 Kevin Tian <kevin.tian@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
 iommu@lists.linux-foundation.org, Joao Martins <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Fri, 18 Mar 2022 14:27:35 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> +/**
> + * iommufd_bind_pci_device - Bind a physical device to an iommu fd
> + * @fd: iommufd file descriptor.
> + * @pdev: Pointer to a physical PCI device struct
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and returns
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touch
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *
> + * The caller must undo this with iommufd_unbind_device()
> + */
> +struct iommufd_device *iommufd_bind_pci_device(int fd, struct pci_dev *pdev,
> +					       u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	struct iommufd_ctx *ictx;
> +	struct iommu_group *group;
> +	int rc;
> +
> +	ictx = iommufd_fget(fd);
> +	if (!ictx)
> +		return ERR_PTR(-EINVAL);
> +
> +	group = iommu_group_get(&pdev->dev);
> +	if (!group) {
> +		rc = -ENODEV;
> +		goto out_file_put;
> +	}
> +
> +	/*
> +	 * FIXME: Use a device-centric iommu api and this won't work with
> +	 * multi-device groups
> +	 */
> +	rc = iommu_group_claim_dma_owner(group, ictx->filp);
> +	if (rc)
> +		goto out_group_put;
> +
> +	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_release_owner;
> +	}
> +	idev->ictx = ictx;
> +	idev->dev = &pdev->dev;
> +	/* The calling driver is a user until iommufd_unbind_device() */
> +	refcount_inc(&idev->obj.users);
> +	/* group refcount moves into iommufd_device */
> +	idev->group = group;
> +
> +	/*
> +	 * If the caller fails after this success it must call
> +	 * iommufd_unbind_device() which is safe since we hold this refcount.
> +	 * This also means the device is a leaf in the graph and no other object
> +	 * can take a reference on it.
> +	 */
> +	iommufd_object_finalize(ictx, &idev->obj);
> +	*id = idev->obj.id;
> +	return idev;
> +
> +out_release_owner:
> +	iommu_group_release_dma_owner(group);
> +out_group_put:
> +	iommu_group_put(group);
> +out_file_put:
> +	fput(ictx->filp);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(iommufd_bind_pci_device);

I'm stumped why this needs to be PCI specific.  Anything beyond the RID
comment?  Please enlighten.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
