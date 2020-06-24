Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC0C433E0
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1543220885
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 09:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGhN7dyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1543220885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0330F87514;
	Wed, 24 Jun 2020 09:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxB2JBTMGyBK; Wed, 24 Jun 2020 09:06:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8EC498742C;
	Wed, 24 Jun 2020 09:06:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76D18C0888;
	Wed, 24 Jun 2020 09:06:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B251CC016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 09:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 99F6F881ED
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 09:06:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ietqjhjcYNDF for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 09:06:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EE3E5880E9
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 09:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592989615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BWweQzpvz5qRvsYocQLFZ/CEELAJfUtNzgc7NW2oHMc=;
 b=CGhN7dyV+qMddUF4oBDwNhIkVao2HbnxaoePCr1VSfgO7bHrW/RfIy1dolC+IMQoYJpN/F
 xTj/RKsjY1TxQiMhxaj8IoJZ1zmGBJ4RwuOdkshKlKvtM5M3Qc5cxCTEUTPWUbMeHiJcDk
 ptgr8/KgF45U0nr2HI0tuFwQDy/wLFA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-9V2x0bw_P76jM7nTFiEftA-1; Wed, 24 Jun 2020 05:06:54 -0400
X-MC-Unique: 9V2x0bw_P76jM7nTFiEftA-1
Received: by mail-wr1-f72.google.com with SMTP id a18so2264233wrm.14
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 02:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BWweQzpvz5qRvsYocQLFZ/CEELAJfUtNzgc7NW2oHMc=;
 b=ukJZ4di/SIZjTQfCwCpQRpRzXqzugcKCzdFhvLGRMuns96ot+hj7khcSK2StsIhI+m
 PjOvI+p/Of0LTkITOsmFpLiv4vv+YmCqvZ7jlSG2SOwvjrnIElZGtztrtLzzGvZYoOZf
 GdR6p/ia290L4ctybpX+Dz1QNpgyQ70O9n6jl1YQKWyCLaSvAhr9q9er45qNc7Xtmbvm
 7/0dujrbR8nce09PiMy1DlVDbmUXbeiXYRdZq8FDKRAOB4tFiPQrwOZo1RnvG/TC6tF+
 dPY1HLspMcwoz+zg9EiHOI6Sc6zpiCDx/Qhag3d10yocHZTZc0fMT23GoCqyF0ngxV+9
 s6pA==
X-Gm-Message-State: AOAM531gAQjcQzvoFBH7edCLyEoLv26Wu86BOAdV+i4JmkY6q3zIOh2a
 glCAGfUR0uOoeYOhfUD4gycxoIYcQv8WtpQc2NiAu9pOKJtMKFt1NKZS69GDtryNG48aAC9yFyz
 fDecW4Qkpgb4sSEd4JNX4jXI++73pzw==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr276010wmk.170.1592989612963; 
 Wed, 24 Jun 2020 02:06:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCjnIRq0GLGlJ0yYJ0oEVhHQJi+H1TnyLeWn06GTYZrPy1eSbfHNnWW2xTl+/KbPsMMBv1Rw==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr275986wmk.170.1592989612754; 
 Wed, 24 Jun 2020 02:06:52 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id n189sm7181712wmb.43.2020.06.24.02.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 02:06:51 -0700 (PDT)
Date: Wed, 24 Jun 2020 05:06:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200624050355-mutt-send-email-mst@kernel.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
MIME-Version: 1.0
In-Reply-To: <20200624091732.23944-1-peng.fan@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jgross@suse.com, sstabellini@kernel.org, konrad.wilk@oracle.com,
 jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 linux-imx@nxp.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Jun 24, 2020 at 05:17:32PM +0800, Peng Fan wrote:
> Export xen_swiotlb for all platforms using xen swiotlb
> 
> Use xen_swiotlb to determine when vring should use dma APIs to map the
> ring: when xen_swiotlb is enabled the dma API is required. When it is
> disabled, it is not required.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Isn't there some way to use VIRTIO_F_IOMMU_PLATFORM for this?
Xen was there first, but everyone else is using that now.


> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2de775801af..768afd79f67a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
>  	 * the DMA API if we're a Xen guest, which at least allows
>  	 * all of the sensible Xen configurations to work correctly.
>  	 */
> -	if (xen_domain())
> +	if (xen_vring_use_dma())
>  		return true;
>  
>  	return false;


The comment above this should probably be fixed.

-- 
MST

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
