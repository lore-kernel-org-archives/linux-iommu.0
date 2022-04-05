Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794FAC433F5
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 19:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13FBE4155C;
	Tue,  5 Apr 2022 19:04:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OJA9_JLX3gYb; Tue,  5 Apr 2022 19:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B29A34086A;
	Tue,  5 Apr 2022 19:04:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78577C0073;
	Tue,  5 Apr 2022 19:04:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 837C8C0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 649C060B32
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6Hf0pQ3ChfGr for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:04:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1325860B12
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:04:14 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id 10so303843qtz.11
 for <iommu@lists.linux-foundation.org>; Tue, 05 Apr 2022 12:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p4sIUWeO6+P4zWNNUhdcwFoqQbff1GSzTj3PyXvmiEQ=;
 b=nmqu50EBRX36s361/cDtv8BTMjCMfqpX08sQhZFrt8sYSEBPwE1vgZ4nW0w4EdNOZv
 o+tA8EKhpRSdQR3Dv6ZeNplzb/6/d4P/pYo8hMuSFtnnHbT18NbIqrDKWGWRuzj0sX33
 NwkCKPzO9uzXxgwt6mzZTzUipt/2LtQXBV9/6/aCHm68I4zhTPhv8T6Xk7CqblW0d9at
 77T1IBaxtpT6vZINZsj5yY7V5fK3TqnoQBl+RnTQQqZTftcLpRRB8gnwvPgzdCfnGiPk
 34ATgiHVCSNNKC4vBPleRiNh9Mj27XotB+bI/48+eyL/b5gKJFVKWfht+KhNDWMMBTx/
 hSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p4sIUWeO6+P4zWNNUhdcwFoqQbff1GSzTj3PyXvmiEQ=;
 b=1ev5K/KeOwKHpo9EjSsSAieFTZImsHtwRHlR/pLRTzpeH4ewMNURZT7kqaWadxV7qg
 yf5GXgQYE/rf/fTHNZPD7e03GBiTlAYN2dUpYNJ4W02LzkrYdW8gHcizkIluz30/F6QP
 /77SPzCFc44pEDdAPiqXRGY+lYXapb4xFyGdnkMa370gum/tsNEedsCdR0BsjlXt8JXi
 94U76Z7LjQRuMEJPb6+hoUWf8wtp7ynMgGihUd1Y9WBhdRkrNa0bS65bcwduOALS5fHU
 yy7fv2K/6r04PQirBfMw9mwTuOdt0IbgTXBIJOlyuM0pDbGgRXnKRumi0DwGsqazYFgQ
 WOeg==
X-Gm-Message-State: AOAM533bnL4ZC5CiYxpOqIuvlK+bR9PduDcZaPQhCzyqwgEiV5pQ/Gz/
 FrG0X2bl/24WqdBMmazgAZXWbg==
X-Google-Smtp-Source: ABdhPJw89QndTutZv11VxczePEqDQB0+l7F3uU5v+rVSKfMzarjpMx65Se4MSU9B2AhnbihAOWRqBA==
X-Received: by 2002:a05:620a:2452:b0:699:9df2:665d with SMTP id
 h18-20020a05620a245200b006999df2665dmr3178998qkn.668.1649185453843; 
 Tue, 05 Apr 2022 12:04:13 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05620a22b000b0067b7b158985sm8057701qkh.128.2022.04.05.12.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 12:04:13 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nboTL-00DBjA-Ix; Tue, 05 Apr 2022 16:04:11 -0300
Date: Tue, 5 Apr 2022 16:04:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] vfio: Stop using iommu_present()
Message-ID: <20220405190411.GT64706@ziepe.ca>
References: <537103bbd7246574f37f2c88704d7824a3a889f2.1649160714.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <537103bbd7246574f37f2c88704d7824a3a889f2.1649160714.git.robin.murphy@arm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com,
 iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Tue, Apr 05, 2022 at 01:11:54PM +0100, Robin Murphy wrote:
> IOMMU groups have been mandatory for some time now, so a device without
> one is necessarily a device without any usable IOMMU, therefore the
> iommu_present() check is redundant (or at best unhelpful).
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/vfio/vfio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
