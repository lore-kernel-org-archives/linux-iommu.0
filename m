Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB389C433E1
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA26A207FC
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA26A207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9002E86074;
	Mon, 20 Jul 2020 22:59:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mBr2GKFJVf29; Mon, 20 Jul 2020 22:59:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF31580A5F;
	Mon, 20 Jul 2020 22:59:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFAACC0894;
	Mon, 20 Jul 2020 22:59:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1A8FC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 22:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DFABB88173
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 22:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rK6BW7oE1zKO for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 22:59:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8574888127
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 22:59:21 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id d18so19399135ion.0
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ybLjdJnNEzw3PjLa+ida62upYueSqoAHLo8Hga07AFI=;
 b=tG6kA4cIqZPFy2czjwS/oCvpe9cLCCPixECCjhplCQx/24TY0dnaBRfnXt4dLDKYuR
 hSAfWwfdOINxNUdAohsj3JiChvd9HDpvWtnEqJ/HScp+P5hWbCp3TtD9zOEjhOPnXoXO
 WzxsrDBONL2Jshdev4ky8JjCVi/0yem7+ZRPvbTDcMi3OgIpCaPjv9zcM5BJbegS6xd3
 n8CMHOS9wuSBx+J9Do6d9A3Ee5/5dl7KTpDgBaeZsvrf4ClE7VejX2szkJbWVjfL//pM
 GdlWBBzjg9JpZNpJPyDZYkGnNu+KFV/tUhAE/XEnXwMJFeXQfbz90RMr2mFVOQGQEEkj
 7MqQ==
X-Gm-Message-State: AOAM530eqY6FgQAs2S8rdnpxfy0rx4KsHFAYq8iNdA8tD+m3wxH/+F2u
 QM5mgILRqQ/9SYn510aZ+w==
X-Google-Smtp-Source: ABdhPJzLaIZ/SR4wIJfqeFdccTnBBLnUptFgZ037ZPt4d8W2AdS6R04ewjeU1fu4LJgmATuLmvJZEA==
X-Received: by 2002:a05:6602:2f89:: with SMTP id
 u9mr25210319iow.126.1595285960921; 
 Mon, 20 Jul 2020 15:59:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id k14sm9856274ion.17.2020.07.20.15.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 15:59:19 -0700 (PDT)
Received: (nullmailer pid 3106187 invoked by uid 1000);
 Mon, 20 Jul 2020 22:59:16 -0000
Date: Mon, 20 Jul 2020 16:59:16 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 02/21] dt-binding: memory: mediatek: Extend LARB_NR_MAX
 to 32
Message-ID: <20200720225916.GA3106142@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, Tomasz Figa <tfiga@google.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, chao.hao@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Sat, 11 Jul 2020 14:48:27 +0800, Yong Wu wrote:
> Extend the max larb number definition as mt8192 has larb_nr over 16.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
