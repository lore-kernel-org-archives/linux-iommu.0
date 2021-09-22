Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91511C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:24:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291C76115A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 21:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 291C76115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAD9F40614;
	Wed, 22 Sep 2021 21:24:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9b4wbSLRPtj2; Wed, 22 Sep 2021 21:24:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F23B40121;
	Wed, 22 Sep 2021 21:24:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70B39C000F;
	Wed, 22 Sep 2021 21:24:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60619C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4259D818C4
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:24:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id levZEgnVgaCi for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 21:24:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A18B281836
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 21:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632345851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bSXV/WbyIuvflNI0O5gv8cTQJk2LfpQktDl+auRuYw=;
 b=RaOfdIkvkcmxJccv6Rnz8ML0XfRXrH4mx5SvhD9o7j7Bcg6NIliufn6f51kROwXuUzcMR0
 ognTE7CaIzsU44T/9cP/0y8LFzFS+JyXxyrv7btxuOwbs/fc0ng0OYuCPuJLI/HsWCih0e
 gf/QZt23/9SxRvwPGcE8q1Ng9I6hHjw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-ozPjUcqgPmG8rKfqx18E8A-1; Wed, 22 Sep 2021 17:24:10 -0400
X-MC-Unique: ozPjUcqgPmG8rKfqx18E8A-1
Received: by mail-oo1-f71.google.com with SMTP id
 k6-20020a4ae286000000b00290b373626dso2515772oot.6
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 14:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=5bSXV/WbyIuvflNI0O5gv8cTQJk2LfpQktDl+auRuYw=;
 b=ol5FUGANUh0rLJodO7Ef6joZh6dvdZCeAanBc7THJEbZ9PNW2OeK1c0JhSJ/hhhKDJ
 YhMeq8Y4yMsJWlVO8GDZzI4Aiqs3GgA12wx3BaOXTxQPeldRkeEjHeMWAzNe7/qcWYca
 1XsrFiFaRVydGAv3MmZV0ElK3yfPhwm9bIKXXa6aiSfPQAjV4sZTuQQaKDCx3EmxMptL
 oHSraz7TeDyf8Wd/yEZ5XjwQ5IsjipIqX+Kk87nKdRhH0SFWOw0LkjDn0s67IcT1bOZ8
 nYNmcWz//pgDZctsS6G4DW94EDUFsqhzrtC9sC1tOpklURXUb/fVwROHwqDIata9iOj5
 2mlg==
X-Gm-Message-State: AOAM532Qpy/dHuwrSBK4aHydKvGm0ZMHsuwjJDh0GWr01ZYlebNZXS3u
 LKE11cObH9fmgbIXQr7Bfh5a1aD9mCkI0lWFdrCU8oQRyIc+Ka0wrOp1mv54BslsTzfKY4erfW2
 RPdwBYUPl6Lu0IttBbqUb9DNq4KOgug==
X-Received: by 2002:a05:6808:2026:: with SMTP id
 q38mr1062591oiw.15.1632345849607; 
 Wed, 22 Sep 2021 14:24:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdoCWR7q3blhAcNoLIpqhCzivqr2u9tYk00GR6mvZvaI93uSxrNhlQY0cnvU77gFLtK4G4DA==
X-Received: by 2002:a05:6808:2026:: with SMTP id
 q38mr1062549oiw.15.1632345849392; 
 Wed, 22 Sep 2021 14:24:09 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
 by smtp.gmail.com with ESMTPSA id s24sm788936otp.36.2021.09.22.14.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Sep 2021 14:24:09 -0700 (PDT)
Date: Wed, 22 Sep 2021 15:24:07 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Message-ID: <20210922152407.1bfa6ff7.alex.williamson@redhat.com>
In-Reply-To: <20210919063848.1476776-11-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-11-yi.l.liu@intel.com>
Organization: Red Hat
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

On Sun, 19 Sep 2021 14:38:38 +0800
Liu Yi L <yi.l.liu@intel.com> wrote:

> +struct iommu_device_info {
> +	__u32	argsz;
> +	__u32	flags;
> +#define IOMMU_DEVICE_INFO_ENFORCE_SNOOP	(1 << 0) /* IOMMU enforced snoop */

Is this too PCI specific, or perhaps too much of the mechanism rather
than the result?  ie. should we just indicate if the IOMMU guarantees
coherent DMA?  Thanks,

Alex

> +#define IOMMU_DEVICE_INFO_PGSIZES	(1 << 1) /* supported page sizes */
> +#define IOMMU_DEVICE_INFO_ADDR_WIDTH	(1 << 2) /* addr_wdith field valid */
> +	__u64	dev_cookie;
> +	__u64   pgsize_bitmap;
> +	__u32	addr_width;
> +};
> +
> +#define IOMMU_DEVICE_GET_INFO	_IO(IOMMU_TYPE, IOMMU_BASE + 1)
>  
>  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
