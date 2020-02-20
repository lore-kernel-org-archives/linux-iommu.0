Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DBC11D20
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 20:48:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2FA20801
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 20:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiBCIqXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2FA20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A04142038B;
	Thu, 20 Feb 2020 20:48:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ohspuEY1fTcf; Thu, 20 Feb 2020 20:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDB4520337;
	Thu, 20 Feb 2020 20:48:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B86DAC1D81;
	Thu, 20 Feb 2020 20:48:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B088C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 71A8D863DD
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:48:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W4OH_cp6H9Ri for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 20:48:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C7CF8863DB
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 20:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582231726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehW/C4q3o/MFSLK01WJohdnOjzA4tnd/QR6FiiqgjL0=;
 b=PiBCIqXgmSIzCl7kHDzaajWmCrBDxQVnTa884V2pmBUcEHrWXk6qdyYGf5l+KPzVuObE7E
 ygJ0vMIMFhd/k+eyw+I3tCHUsKOQng25f+stm7OEhfFWc8XOHpSfXYmAHoX0PXV8mZzwLc
 Gk2dXIlpHvlcoH4ngXJUH18btLQoiMk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-LKZiP0rsMwSijF5YrK33SA-1; Thu, 20 Feb 2020 15:48:44 -0500
X-MC-Unique: LKZiP0rsMwSijF5YrK33SA-1
Received: by mail-qt1-f197.google.com with SMTP id x8so2188qtq.14
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 12:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ehW/C4q3o/MFSLK01WJohdnOjzA4tnd/QR6FiiqgjL0=;
 b=tCVnRWL+bJJyXc7nq5uI1tCSvJhu8yj8Zl2KgKdk0wXMQCeIvkNlgARs+Aa8iHrySf
 xWdN0NS899FPnQi0ko2Qz0nwEICuLlahiWMgo1SEifGcjH6qAPI5FCoyfE/Arxqu7u0L
 HEBLsY7l6Fcp30S9oUFzlcaV2rbMhnwiaMSDGT+f49hiCugLQxC4LRugg3YlHnIJ1D3G
 3m/AUWfNwetE4j7OacXV16sDZqN3g73xEwkHZbzE+1QFVFCvlGQHcKbJqFyy49d/5PiW
 rzje7r1VIV66Tu0sXluUGK17QawwZjcP1OQIoRyZThDvRklVbhf7WBDl9p4zAQBUJbIX
 ECRw==
X-Gm-Message-State: APjAAAW3R1voQpGS5zGaC4Ph6trgTgf1MVBfaHzimNjQk7T7uRt3VCVi
 9QOrlmXx2Dd5esJQCFaL3z5VdXnaqn+S8yzVp2qNSkrpvpTXcBn0v6KSNlMVA9zpb8cFy9lCT9x
 6hoHphLhprytl9dyTz0uhQh8Q+E07ug==
X-Received: by 2002:a05:620a:1279:: with SMTP id
 b25mr27577889qkl.385.1582231723887; 
 Thu, 20 Feb 2020 12:48:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8/6ncIbfogJ3gGTu5AoGgDYIF/agRj+iWjgwKDztDiB0lAfpoI0718ywEcHd9ifb45n14Hw==
X-Received: by 2002:a05:620a:1279:: with SMTP id
 b25mr27577859qkl.385.1582231723602; 
 Thu, 20 Feb 2020 12:48:43 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
 by smtp.gmail.com with ESMTPSA id p8sm358226qtn.71.2020.02.20.12.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 12:48:42 -0800 (PST)
Date: Thu, 20 Feb 2020 15:48:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200220154718-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-s390@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
 "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 iommu@lists.linux-foundation.org, David Gibson <david@gibson.dropbear.id.au>,
 Michael Mueller <mimu@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
> Currently if one intends to run a memory protection enabled VM with
> virtio devices and linux as the guest OS, one needs to specify the
> VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> linux use the DMA API, which in turn handles the memory
> encryption/protection stuff if the guest decides to turn itself into
> a protected one. This however makes no sense due to multiple reasons:
> * The device is not changed by the fact that the guest RAM is
> protected. The so called IOMMU bypass quirk is not affected.
> * This usage is not congruent with  standardised semantics of
> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> for using DMA API in virtio (orthogonal with respect to what is
> expressed by VIRTIO_F_IOMMU_PLATFORM). 
> 
> This series aims to decouple 'have to use DMA API because my (guest) RAM
> is protected' and 'have to use DMA API because the device told me
> VIRTIO_F_IOMMU_PLATFORM'.
> 
> Please find more detailed explanations about the conceptual aspects in
> the individual patches. There is however also a very practical problem
> that is addressed by this series. 
> 
> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> effect The vhost code assumes it the addresses on the virtio descriptor
> ring are not guest physical addresses but iova's, and insists on doing a
> translation of these regardless of what transport is used (e.g. whether
> we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> "vhost: new device IOTLB API".) On s390 this results in severe
> performance degradation (c.a. factor 10). BTW with ccw I/O there is
> (architecturally) no IOMMU, so the whole address translation makes no
> sense in the context of virtio-ccw.

That's just a QEMU thing. It uses the same flag for VIRTIO_F_ACCESS_PLATFORM
and vhost IOTLB. QEMU can separate them, no need to change linux.


> Halil Pasic (2):
>   mm: move force_dma_unencrypted() to mem_encrypt.h
>   virtio: let virtio use DMA API when guest RAM is protected
> 
>  drivers/virtio/virtio_ring.c |  3 +++
>  include/linux/dma-direct.h   |  9 ---------
>  include/linux/mem_encrypt.h  | 10 ++++++++++
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> 
> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> -- 
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
