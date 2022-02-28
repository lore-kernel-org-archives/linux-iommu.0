Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2491DC433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 22:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D56638247F;
	Mon, 28 Feb 2022 22:06:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id om2P-nxXykme; Mon, 28 Feb 2022 22:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCF3982457;
	Mon, 28 Feb 2022 22:06:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95EE4C0077;
	Mon, 28 Feb 2022 22:06:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D103EC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCBE160E66
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Iz-fDpxdPqXy for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 22:06:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A01D60E6E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646085998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d94j7lxxX5y02+A6WG5OxYm+EuL2bPwYE+feweTMi6I=;
 b=J0ohMJ9U4ZN2kRr3Weze39lKaA2qodgnMc2U8kKg2jj2hagwo7Z89eTVrnJTmbp9kN8iQp
 h6WAvdENA2NstwlRqY7ftZc5uM+XFeiHJEt+qmcrDz8x3bA8qd0uSU9A6L6rBA9ZutRL1g
 jHofp/lyat83++zOLirrqDWEJrhor9o=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-rZc2ut-QMbKWuz1QFeHNSw-1; Mon, 28 Feb 2022 17:06:36 -0500
X-MC-Unique: rZc2ut-QMbKWuz1QFeHNSw-1
Received: by mail-ot1-f71.google.com with SMTP id
 l23-20020a056830239700b005ad40210ca2so9955578ots.3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 14:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d94j7lxxX5y02+A6WG5OxYm+EuL2bPwYE+feweTMi6I=;
 b=muaqP16h9aiaD6UlITZdaMZygleIeSoirdUDLwKoRks+2qD+l1BmauPtLyj0CLqQHx
 kevx+57f2uVYCRqFGMUAH5krtokHo+J/jffcZhmSzYqTp6OkgScC77To6OvRH8Fs/Vvl
 LH5USuIGQlsNO1Bd59kR0YKx/sQaNrPEVsp6lF7QICouyVAe18ZTiRpg43j4KDJFCALt
 j0bFCWYnqMG5K8uSec72o3amrHItRKOsfprUocYB7o9llLntHMFzi1spjApsQyuaWmvR
 b7e9cEv4qNIi3kF8+YPRKV0p2O6m7aO8/VW9utt7+RQke7k7ZMUiCcVUamhff/7mmyhZ
 mAfg==
X-Gm-Message-State: AOAM532ZZIks4GFoxXxP4fFnH+n4C45Tu2pxfcewCobPQt+o4MAwVMxF
 au1unFEKKmSUlHcRpcVPAduX/2v9K4v+xRisbduw/Xd/ZtOrEhGZzOry0GvAKjXCohTFatRhLdr
 trn3cV5JhVivfkWfgcS/RDlyjbhl6pQ==
X-Received: by 2002:a05:6808:1586:b0:2d5:1211:5785 with SMTP id
 t6-20020a056808158600b002d512115785mr10690609oiw.0.1646085995963; 
 Mon, 28 Feb 2022 14:06:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLGQUBEm26I4XhzS9O0hC1lMHUwWYT/sXCYb5vTAfKM0mj7adVygonLblatFgJDlUF3+gebg==
X-Received: by 2002:a05:6808:1586:b0:2d5:1211:5785 with SMTP id
 t6-20020a056808158600b002d512115785mr10690580oiw.0.1646085995791; 
 Mon, 28 Feb 2022 14:06:35 -0800 (PST)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 m21-20020a056820051500b0031d0841b87esm5371712ooj.34.2022.02.28.14.06.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 14:06:35 -0800 (PST)
Date: Mon, 28 Feb 2022 15:06:33 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 10/11] vfio: Remove iommu group notifier
Message-ID: <20220228150633.3438200c.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-11-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-11-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, 28 Feb 2022 08:50:55 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> The iommu core and driver core have been enhanced to avoid unsafe driver
> binding to a live group after iommu_group_set_dma_owner(PRIVATE_USER)
> has been called. There's no need to register iommu group notifier. This
> removes the iommu group notifer which contains BUG_ON() and WARN().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 147 --------------------------------------------
>  1 file changed, 147 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
