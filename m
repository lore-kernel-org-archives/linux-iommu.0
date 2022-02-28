Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65124C433EF
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 22:06:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0ACBD405F3;
	Mon, 28 Feb 2022 22:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o5G0KLhW3mIL; Mon, 28 Feb 2022 22:06:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 92E2140273;
	Mon, 28 Feb 2022 22:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C2BDC0077;
	Mon, 28 Feb 2022 22:06:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA27CC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8D75410C7
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63Cwmu7omkDB for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 22:06:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A962410C6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 22:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646085994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LW+d0gtxqXAjakKIGWcmifEtiCoe2QekVg+4keAltg=;
 b=ZQcDhle+kSZWyEdihfyKJCikmiCc1QREqsbFhf3Zh7JYqjNREv58TZ+ymnwvTuyzVHNYkP
 jagKGEnBXbOyiH9uOKxftWyZr6gCclWsa2NeEbh2zoPuOjO2/5N4HbhmhuyjsCKoYmPsXx
 TIB3oJwVZ+u2/ReGsFud8TSawgUN0g8=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-ZHU5_dZ8M4yieby1He1TkQ-1; Mon, 28 Feb 2022 17:06:32 -0500
X-MC-Unique: ZHU5_dZ8M4yieby1He1TkQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 m24-20020a9d4c98000000b005af3b88a817so9946786otf.14
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 14:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1LW+d0gtxqXAjakKIGWcmifEtiCoe2QekVg+4keAltg=;
 b=xYwrj5izy6W2gomntjFh/uI+O5Ihj1JQnVKdPfHc9kGHNdhBK959MKZcqXrXIGbcpr
 osi02Kjx8Prvr08IbVd7eeCFket5JL5OX1qMws1mW2DDXPcMDrqWTQQEX5mGBd6r6qzN
 xqttkiDn/vSJIz/ICt6/HKsvTgNvvO977f3jLoy2RsLJq4i4ddPkC0nKG+A8i9bMdjgK
 k8LiksZ1L9LMWpKKTUmpQ4KPbOmHUadoL7xGf1GLj1y9XlUN9vDhJDwgsM7F/1F/Kl1i
 EJlZs4X373vUtH6MhM1r8H8LbpOugGPL5KaAKBDVzoAbgonz274D7F8uqMNdSspG1eTh
 IS5A==
X-Gm-Message-State: AOAM530dPEtCCQdLp2JElz1boeZtI4mzfuDir/DtbxooIZy0J42EHj8S
 fzyoCL4O6oDKbb/whPpiJcopTGthx60r/ccFeu6tZ8BsAyIAvUhktQa6PPP60TLKYF/w4K5nF+c
 tWusxAIlUrpddDvofK3OWcZ+KZkZV4A==
X-Received: by 2002:a05:6830:314d:b0:5af:fecc:538e with SMTP id
 c13-20020a056830314d00b005affecc538emr5635075ots.348.1646085991363; 
 Mon, 28 Feb 2022 14:06:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFW1+83X6LvIg8c4ECGOmnmvfHMjqxq9s+M0gGRNVNvZ2qLWJBsQ0hgIVPGZj3LChgbRzMPQ==
X-Received: by 2002:a05:6830:314d:b0:5af:fecc:538e with SMTP id
 c13-20020a056830314d00b005affecc538emr5635030ots.348.1646085990790; 
 Mon, 28 Feb 2022 14:06:30 -0800 (PST)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 bd14-20020a056808220e00b002d53f900b9csm7017463oib.30.2022.02.28.14.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Feb 2022 14:06:30 -0800 (PST)
Date: Mon, 28 Feb 2022 15:06:28 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 09/11] vfio: Delete the unbound_list
Message-ID: <20220228150628.2c0077f4.alex.williamson@redhat.com>
In-Reply-To: <20220228005056.599595-10-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-10-baolu.lu@linux.intel.com>
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

On Mon, 28 Feb 2022 08:50:54 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> commit 60720a0fc646 ("vfio: Add device tracking during unbind") added the
> unbound list to plug a problem with KVM where KVM_DEV_VFIO_GROUP_DEL
> relied on vfio_group_get_external_user() succeeding to return the
> vfio_group from a group file descriptor. The unbound list allowed
> vfio_group_get_external_user() to continue to succeed in edge cases.
> 
> However commit 5d6dee80a1e9 ("vfio: New external user group/file match")
> deleted the call to vfio_group_get_external_user() during
> KVM_DEV_VFIO_GROUP_DEL. Instead vfio_external_group_match_file() is used
> to directly match the file descriptor to the group pointer.
> 
> This in turn avoids the call down to vfio_dev_viable() during
> KVM_DEV_VFIO_GROUP_DEL and also avoids the trouble the first commit was
> trying to fix.
> 
> There are no other users of vfio_dev_viable() that care about the time
> after vfio_unregister_group_dev() returns, so simply delete the
> unbound_list entirely.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio.c | 74 ++-------------------------------------------
>  1 file changed, 2 insertions(+), 72 deletions(-)

Acked-by: Alex Williamson <alex.williamson@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
