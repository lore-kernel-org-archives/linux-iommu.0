Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55CCC433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 16:25:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EDAC60EEE;
	Fri, 13 May 2022 16:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KrneO7UU3aff; Fri, 13 May 2022 16:25:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6200560EE9;
	Fri, 13 May 2022 16:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FBACC0039;
	Fri, 13 May 2022 16:25:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F843C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 16:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0083383F0C
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 16:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id haQEYNs5vlTe for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 16:25:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2002483F2B
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 16:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652459153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ub5KAZihY6DYhd8Dh60sSEVIjle32E0Y+oXuLhLfRmI=;
 b=aa/HZx4Qz92Wxe7fRBxcFWOQyV8mOEBbp2C5hmJ6znxPelc20P9pLCOz24wKrZdlojwwSY
 TKd+VP8DcRCzIFWlCzFArVrZwPAG3e9fp+k4Nq5O9UBEjhiwmaayaAIV2KaH/hBKQrz/9y
 3xr7/n4gfdpcsnJNjNDNwrIiXgOSeFk=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-zCgXm6uRPsOFZ0rUqjnCTw-1; Fri, 13 May 2022 12:25:52 -0400
X-MC-Unique: zCgXm6uRPsOFZ0rUqjnCTw-1
Received: by mail-il1-f200.google.com with SMTP id
 x1-20020a056e020f0100b002c98fce9c13so5481584ilj.3
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 09:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=Ub5KAZihY6DYhd8Dh60sSEVIjle32E0Y+oXuLhLfRmI=;
 b=Wms03ZU1oMVzH4ANz3nFqBOVnoSjAnkNDCpmgfNMdpBJuprXoauLSbxLTs9+ASJTPs
 1LcJyWy/NVg9K2E1AT7tq6VhdXmED7x6YGZU9tizX1Nk4ytgSLBrYscTYg9k8qKtX2ky
 ThxuEojyYvcCnWfZFmSvXq+6V+A4HraKtvWbS2WSv17ab+qaO0VmvYz850RJXV9Q/T5v
 ywNf4GmU4bKMcdPK6A65gdVOA8F3Ac7ego6PzCnhNSD/KyeR3YXRj0BpGqEtP2aJZG0b
 5tWPnyFyuPTzxM+nwQGWRsm+Dtu2sLOKL9nbl+/+MhuRW7eAoKrqCxRoDQPXqNh/ssEb
 wghw==
X-Gm-Message-State: AOAM531sR3zxV10QPlqZs20H4A4qTkszO6ctS5lcy5qlrEdwFKfm3OBn
 +kOWI6N4//0W3LytfL3/ZbyowytZbV8BLmJnNPMs4+JmC8v+SlDE+L0hrweork4Jq4vgerf8XdA
 yoQqhygsxjb7WtDH4pf4t+IM3h76X3g==
X-Received: by 2002:a05:6e02:1a86:b0:2cf:5846:29b3 with SMTP id
 k6-20020a056e021a8600b002cf584629b3mr3006528ilv.232.1652459151803; 
 Fri, 13 May 2022 09:25:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9MjoZwEcYaDWk2gqQCT9hWL1nI3AiMXUTtNXeCu+v5XL13uXOxow6nSkLqXj4afENxZZ8NA==
X-Received: by 2002:a05:6e02:1a86:b0:2cf:5846:29b3 with SMTP id
 k6-20020a056e021a8600b002cf584629b3mr3006516ilv.232.1652459151519; 
 Fri, 13 May 2022 09:25:51 -0700 (PDT)
Received: from redhat.com ([98.55.18.59]) by smtp.gmail.com with ESMTPSA id
 j17-20020a023211000000b0032b3a7817b3sm772601jaa.119.2022.05.13.09.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 May 2022 09:25:51 -0700 (PDT)
Date: Fri, 13 May 2022 10:25:48 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220513102548.5cf2a3aa.alex.williamson@redhat.com>
In-Reply-To: <Yn5+GKHlQlX5bszi@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian> <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504102956.0f5b5302.alex.williamson@redhat.com>
 <Yn5+GKHlQlX5bszi@8bytes.org>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Kevin Tian <kevin.tian@intel.com>, Qian Cai <quic_qiancai@quicinc.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

On Fri, 13 May 2022 17:49:44 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Alex,
> 
> On Wed, May 04, 2022 at 10:29:56AM -0600, Alex Williamson wrote:
> > Done, and thanks for the heads-up.  Please try to cc me when the
> > vfio-notifier-fix branch is merged back into your next branch.  Thanks,  
> 
> This has happened now, the vfio-notifier-fix branch got the fix and is
> merged back into my next branch.

Thanks, Joerg!

Jason, I'll push a merge of this with

Subject: [PATCH] vfio: Delete container_q
0-v1-a1e8791d795b+6b-vfio_container_q_jgg@nvidia.com

and

Subject: [PATCH v3 0/8] Remove vfio_group from the struct file facing VFIO API
0-v3-f7729924a7ea+25e33-vfio_kvm_no_group_jgg@nvidia.com

as soon as my sanity build finishes.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
