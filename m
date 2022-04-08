Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1208C433FE
	for <iommu@archiver.kernel.org>; Fri,  8 Apr 2022 16:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A55F606F5;
	Fri,  8 Apr 2022 16:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 459fvANvxuXa; Fri,  8 Apr 2022 16:07:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2DCD660E06;
	Fri,  8 Apr 2022 16:07:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11CE2C0084;
	Fri,  8 Apr 2022 16:07:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5902C002C
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 16:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92AC44055D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 16:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XPxqrX1Apg6V for <iommu@lists.linux-foundation.org>;
 Fri,  8 Apr 2022 16:07:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EC53C400A6
 for <iommu@lists.linux-foundation.org>; Fri,  8 Apr 2022 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649434075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UZJpwOwiX6p1TLjytT0LkEmh312IajsdmsbzULaJOWo=;
 b=LZdtz12k5N3E9fUlWjAfCnjUa4py3cAf/GdWklCo5hT5v2ERW/yCZvZu6RRQ0dE3Aeoywx
 vMTyz0SoBD6RJZhxrYJLqf6gFj6gDGrdYerlN4IquC9coF+hwkM1Cprh39Pq5h2gD4bgye
 xfGqYU33gdcd8pUGiifAshrV6PAtCrw=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-wWOyd5x1O8yjd2Cy3wXsLw-1; Fri, 08 Apr 2022 12:07:54 -0400
X-MC-Unique: wWOyd5x1O8yjd2Cy3wXsLw-1
Received: by mail-io1-f70.google.com with SMTP id
 i19-20020a5d9353000000b006495ab76af6so6076275ioo.0
 for <iommu@lists.linux-foundation.org>; Fri, 08 Apr 2022 09:07:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=UZJpwOwiX6p1TLjytT0LkEmh312IajsdmsbzULaJOWo=;
 b=fki3Njak9ZWiuz0zGVYmLkoulH/QpQaXOuBOv2rvHxRAARp/LmxEjSKV2BRB3+pjwZ
 p0lFnwlXzaxR2HT5zQL+6Y77CsWyZf+yyXLS/f6wNpCMAlLSlra9z7+DZwbqIFarh/mM
 XytoDtI0TvdVnBZaN8tDAbfc0bSK6yMdj9IJzTDzB6pexWuZS1+g6IfDBbAWT6AHZ7Da
 RXT+96AyOoIRZWkcvnQ3GHE6OAKVCLorozn4/AdUU5OINWLd5MO/rwXEsTcq9Vl6eDbJ
 gEeDQPD46mZmCAll2qXaF8Uf9990/ZcIHhb5dtsw98IsdW2Z5MiUEL867Q+7ZPVccQcB
 CwQA==
X-Gm-Message-State: AOAM532UeVDsPxcwhEX+TDpRT/oouXLGHnfeBlo0C3NGt1tksZjWd7NW
 jUB+D8t8X/C4EGYan19mrDhFjaLVTLa7p2ILp2aY+bqUbqunWKFG9uadnZPWqivXDW4qIPHJ4iB
 ut4mKFDHYfTccfW8YXui5mZaK66VA1w==
X-Received: by 2002:a92:c545:0:b0:2ca:1066:3d6 with SMTP id
 a5-20020a92c545000000b002ca106603d6mr9493060ilj.229.1649434073911; 
 Fri, 08 Apr 2022 09:07:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/TufIImKux5pz6Rl4XI7KZTQV93OrbFNaYKMbngwhu1qKZ7ch3Hl40CSX8DSWlDm9zc9qJw==
X-Received: by 2002:a92:c545:0:b0:2ca:1066:3d6 with SMTP id
 a5-20020a92c545000000b002ca106603d6mr9493027ilj.229.1649434073692; 
 Fri, 08 Apr 2022 09:07:53 -0700 (PDT)
Received: from redhat.com ([98.55.18.59]) by smtp.gmail.com with ESMTPSA id
 s5-20020a056602168500b0064c82210ce4sm15878688iow.13.2022.04.08.09.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Apr 2022 09:07:53 -0700 (PDT)
Date: Fri, 8 Apr 2022 10:07:50 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220408100750.77fd9ffc.alex.williamson@redhat.com>
In-Reply-To: <20220408155922.GA317094@bhelgaas>
References: <YlBWrE7kxX9vraOD@8bytes.org>
	<20220408155922.GA317094@bhelgaas>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
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

On Fri, 8 Apr 2022 10:59:22 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Fri, Apr 08, 2022 at 05:37:16PM +0200, Joerg Roedel wrote:
> > On Fri, Apr 08, 2022 at 11:17:47AM -0300, Jason Gunthorpe wrote:  
> > > You might consider using a linear tree instead of the topic branches,
> > > topics are tricky and I'm not sure it helps a small subsystem so much.
> > > Conflicts between topics are a PITA for everyone, and it makes
> > > handling conflicts with rc much harder than it needs to be.  
> > 
> > I like the concept of a branch per driver, because with that I can just
> > exclude that branch from my next-merge when there are issues with it.
> > Conflicts between branches happen too, but they are quite manageable
> > when the branches have the same base.  
> 
> FWIW, I use the same topic branch approach for PCI.  I like the
> ability to squash in fixes or drop things without having to clutter
> the history with trivial commits and reverts.  I haven't found
> conflicts to be a problem.

Same.  I think I've generally modeled my branch handling after Bjorn
and Joerg, I don't always use topic branches, but will for larger
contributions and I don't generally find conflicts to be a problem.
I'm always open to adopting best practices though.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
