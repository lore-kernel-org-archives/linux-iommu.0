Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA12C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 22:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AE988246F;
	Mon, 28 Feb 2022 22:06:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WeVuAHhKtpzO; Mon, 28 Feb 2022 22:06:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5504F82444;
	Mon, 28 Feb 2022 22:06:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DC42C0077;
	Mon, 28 Feb 2022 22:06:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE31EC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DB10940273
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sD5hYqadS6ZQ for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 22:06:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02A91405F3
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646085986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSd2olf1jnjo/HsSgbCsJs5j16VEb70bfQ7PmeMY2VY=;
 b=X/fORx8DSqlRSB8Kj0AT7WQ4mIydJNZ8yGnDnfTiiCILfmMY4YTVyQqc/KTWk20cu3Lp05
 gcqNApxHkHOb0nBVBbdJ+TvApXevCtXuBdMuenLi0tThipEY1iZnmcHFajZ9sr/zCf9ctf
 7lkPLi5sMG4Gt3kdeSixnT7ksu0Yj5E=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-0Gjn6IZ_POqBZj7-V_Xchw-1; Mon, 28 Feb 2022 17:06:25 -0500
X-MC-Unique: 0Gjn6IZ_POqBZj7-V_Xchw-1
Received: by mail-oi1-f197.google.com with SMTP id
 t34-20020a05680815a200b002d51d9e681dso6268867oiw.10
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 14:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kSd2olf1jnjo/HsSgbCsJs5j16VEb70bfQ7PmeMY2VY=;
 b=m6MnzrSXpHGWwczFR/0kFOwIZR7riyR290/iN7rHiPZycBrruvvHK6piAxZa8+VG3e
 Isay8cbNbk2liKO1PYfmUIOnyqwlpG/+rNtW2mHjQ3hL/7BWawk984qfqEF3h4slqtuC
 o90GcILTta47ao7I0LOfz9KPv6Ei0NfQxlM5f73+c5u9ujaKZ1u116EnlJhK/IhaON5X
 9QWB310HRaznUtX0Qes8ElKyCWOvWWDvDiS6mm/t8EnXJ4R+CzVepyYtu7VRjs5K9Q6H
 nvxHqRoVWlR+5DwmHcTQjmJz/sFH8NL+l5JHdihf4npwwyck6FEF2ULFaPrVrUQ+ihz9
 2yQg==
X-Gm-Message-State: AOAM5309hD+bhSGlJ1BeT6YBuGDNVj5abklB4ejYpxuf2nKxbGl/Fkg3
 pgQ7LmvG4T9D+F71QLpa93DZDYiKFh/O/LR4essL+0ss3GeGSyMvSAZJCHPow+aWT5Et3EXLyY2
 b3bl3rouIkSoOspHXdciQba1ppcMMsg==
X-Received: by 2002:a05:6808:1148:b0:2d5:2333:bbb1 with SMTP id
 u8-20020a056808114800b002d52333bbb1mr10736870oiu.130.1646085984685; 
 Mon, 28 Feb 2022 14:06:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXyd5cLZVXv21R215ahGVE59QoOxgoKUS9B2IAT3b2Nrgqe4ENaiagVjBUsTuHIIBNYSayzQ==
X-Received: by 2002:a05:6808:1148:b0:2d5:2333:bbb1 with SMTP id
 u8-20020a056808114800b002d52333bbb1mr10736822oiu.130.1646085984239; 
 Mon, 28 Feb 2022 14:06:24 -0800 (PST)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 i47-20020a9d172f000000b005aed7ea7b44sm5393010ota.73.2022.02.28.14.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 14:06:23 -0800 (PST)
Date: Mon, 28 Feb 2022 15:06:21 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 08/11] vfio: Remove use of vfio_group_viable()
Message-ID: <20220228150621.5984595b.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-9-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-9-baolu.lu@linux.intel.com>
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

On Mon, 28 Feb 2022 08:50:53 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> As DMA ownership is claimed for the iommu group when a VFIO group is
> added to a VFIO container, the VFIO group viability is guaranteed as long
> as group->container_users > 0. Remove those unnecessary group viability
> checks which are only hit when group->container_users is not zero.
> 
> The only remaining reference is in GROUP_GET_STATUS, which could be called
> at any time when group fd is valid. Here we just replace the
> vfio_group_viable() by directly calling IOMMU core to get viability status.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
