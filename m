Return-Path: <SRS0=55Rd=OL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C88EC433F5
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 19:56:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD3D61131
	for <iommu@archiver.kernel.org>; Tue, 21 Sep 2021 19:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FD3D61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD6F340189;
	Tue, 21 Sep 2021 19:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H2EEoikwPIa9; Tue, 21 Sep 2021 19:56:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90A8E400CF;
	Tue, 21 Sep 2021 19:56:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D06C0011;
	Tue, 21 Sep 2021 19:56:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A8B1C000D
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 19:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49B14406D4
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 19:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dpLAanUiKcn6 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Sep 2021 19:56:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 02C56406D2
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 19:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632254165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLzwRXGzw6x+C1v9j0yrnbrduVN9978/t8EjVYLLyME=;
 b=FpItfJjY9ixQKF+Fbik9AlBIbs1uFIbATbRTsueLrWUvjjm4bRXA9HJ6jz3QMYZgXVL2vi
 zkNjZXgAYSQxK9b7gUDm6df+HKHbl6xNnFTwBSJoyB8HbsjzzvHcwgho/TZnHYYdRbebCX
 F4eKp2KT80PXuv0H4ydk6L6DmRkgzVg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-sFD3O0LxM8-pB4LsY3HSwQ-1; Tue, 21 Sep 2021 15:56:04 -0400
X-MC-Unique: sFD3O0LxM8-pB4LsY3HSwQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 d18-20020a4a9cd2000000b0029afc2f9586so72902ook.19
 for <iommu@lists.linux-foundation.org>; Tue, 21 Sep 2021 12:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oLzwRXGzw6x+C1v9j0yrnbrduVN9978/t8EjVYLLyME=;
 b=reixwwLdAUyj+38TllDWKWsdVLuP7Jq0/pTeF4dY/WXUrfSxIsZ2o0oo1WW3tDc+Do
 Kmmkx/cm2FXD0dahoFWKniS95PqbquG+E9jXZTAFqU8ILdcEq9b0pbRYh6soYD6zPb9a
 rIZFJDulookkZ/AD9aazuxckdSqBM20Bpb4QgmOgz01DvbhT9nN7LuXllDaqsuSFHFTd
 CKgDcAwDtVpNyH++sG0ZCizFzO/CPoUEbAnkX4rA2jgDdOKlWOLOMaYILC3NY9M/CRdZ
 AHcn1vTFTCfMrCmbxwaSONsVlYt79JQ75EyvS0ZMrbTWYIR6nnVj8lpstPbYVNzGhDZ4
 KF+g==
X-Gm-Message-State: AOAM533no/DyM/PyCp83XqagDbmeBAzfKmtnVHWeMoSguA5lSDEczqL5
 WZmCvrTvrNfIlJuwTzJESwcPrdlMAkBRorrXa9HnAalbI+3cc+8rsduMld1REpKKVWLX3R9eKxd
 vBCOZkhZELM9qj9TUM++9AKUs4dJYAA==
X-Received: by 2002:a05:6808:57:: with SMTP id
 v23mr5129808oic.172.1632254164032; 
 Tue, 21 Sep 2021 12:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoOu2++jQHPmZljv5zNozGgELfd2kP7Ma8jcLIdKYbhKK+ntKv4cH2e/ruocpLeO/GYmaibg==
X-Received: by 2002:a05:6808:57:: with SMTP id
 v23mr5129791oic.172.1632254163793; 
 Tue, 21 Sep 2021 12:56:03 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id a8sm471046otv.14.2021.09.21.12.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Sep 2021 12:56:03 -0700 (PDT)
Date: Tue, 21 Sep 2021 13:56:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Message-ID: <20210921135601.3393f51b.alex.williamson@redhat.com>
In-Reply-To: <20210919063848.1476776-3-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-3-yi.l.liu@intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, kwankhede@nvidia.com, hch@lst.de,
 jean-philippe@linaro.org, dave.jiang@intel.com, ashok.raj@intel.com,
 corbet@lwn.net, jgg@nvidia.com, kevin.tian@intel.com, parav@mellanox.com,
 lkml@metux.net, david@gibson.dropbear.id.au, dwmw2@infradead.org,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, robin.murphy@arm.com
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

On Sun, 19 Sep 2021 14:38:30 +0800
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch introduces a new interface (/dev/vfio/devices/$DEVICE) for
> userspace to directly open a vfio device w/o relying on container/group
> (/dev/vfio/$GROUP). Anything related to group is now hidden behind
> iommufd (more specifically in iommu core by this RFC) in a device-centric
> manner.
> 
> In case a device is exposed in both legacy and new interfaces (see next
> patch for how to decide it), this patch also ensures that when the device
> is already opened via one interface then the other one must be blocked.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio.c  | 228 +++++++++++++++++++++++++++++++++++++++----
>  include/linux/vfio.h |   2 +
>  2 files changed, 213 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 02cc51ce6891..84436d7abedd 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
...
> @@ -2295,6 +2436,52 @@ static struct miscdevice vfio_dev = {
>  	.mode = S_IRUGO | S_IWUGO,
>  };
>  
> +static char *vfio_device_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> +}

dev_name() doesn't provide us with any uniqueness guarantees, so this
could potentially generate naming conflicts.  The similar scheme for
devices within an iommu group appends an instance number if a conflict
occurs, but that solution doesn't work here where the name isn't just a
link to the actual device.  Devices within an iommu group are also
likely associated within a bus_type, so the potential for conflict is
pretty negligible, that's not the case as vfio is adopted for new
device types.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
