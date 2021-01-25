Return-Path: <SRS0=REuq=G4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8AFC433E0
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 08:44:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701E822D02
	for <iommu@archiver.kernel.org>; Mon, 25 Jan 2021 08:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701E822D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E7AEA872B4;
	Mon, 25 Jan 2021 08:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2E9KBEvJLzhv; Mon, 25 Jan 2021 08:44:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4EAE48703D;
	Mon, 25 Jan 2021 08:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3427BC0FA7;
	Mon, 25 Jan 2021 08:44:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 392D8C013A
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 048252051C
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NGeiO2r3iwF1 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Jan 2021 08:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by silver.osuosl.org (Postfix) with ESMTPS id 1CA7920509
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 08:44:54 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id m2so9820235wmm.1
 for <iommu@lists.linux-foundation.org>; Mon, 25 Jan 2021 00:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iG617n7RY186O/pmG7ncN7Xf1mrGP2hULOGFRnrxrOI=;
 b=QWG1HvHMOwNm4e5d7cvmwEo0aGP49+H40BwYP8FVFwWWhkk687JHGjnKTDsg7hdwRb
 0RZDgLnbXyVjgtNL05DRf6LxskqZI70DTwsFM/jshRF/NYSC/wM9ZS8RwiZImdipgAko
 0q3hhnRovZn4IQJnfW4UcM8epnmKVECZ1vDfRiJAQj816vDMdQvmZq0/N2zvR50cyrM2
 O5mHvv4SKu9S5ij5RlEsZErrCSuiSCpCXR+U1HPpaY7F0Do4pk4O4FxQuiKppXo6g6+D
 ExOg0bUh0KJ2lVjdWsrjTf0nm8UDbMEZMQ0HbyLd2oblJZYSci3/ibTFE3gYb1wmIw49
 3SHg==
X-Gm-Message-State: AOAM531aJJA8k1ToqRQKB/vap4/qg9KnrZ4eo5XDxl1yedIIZdIkM+6j
 b1ZrSVW/AHqzGyEM5eoekaM=
X-Google-Smtp-Source: ABdhPJwbi+N5mhqS3OVl7qZ4K7X04AkWAmdd1Z98I7yaiQ3n0D1F04aYVUoXBZy4+it6iLZGkS40Hg==
X-Received: by 2002:a1c:7dc4:: with SMTP id y187mr1502306wmc.42.1611564292632; 
 Mon, 25 Jan 2021 00:44:52 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id
 h125sm20907834wmh.16.2021.01.25.00.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Jan 2021 00:44:51 -0800 (PST)
Date: Mon, 25 Jan 2021 09:44:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
Message-ID: <20210125084450.wurwhi2hbbuueapy@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-4-yong.wu@mediatek.com>
 <20210122213558.qnboqc4obdmipxs4@kozik-lap>
 <1611557384.3184.22.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1611557384.3184.22.camel@mhfsdcap03>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 yi.kuo@mediatek.com, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
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

On Mon, Jan 25, 2021 at 02:49:44PM +0800, Yong Wu wrote:
> On Fri, 2021-01-22 at 22:35 +0100, Krzysztof Kozlowski wrote:
> > On Thu, Jan 21, 2021 at 02:24:29PM +0800, Yong Wu wrote:
> > > This patch switches MTK_SMI to tristate. Support it could be 'm'.
> > > 
> > > Meanwhile, Fix a build issue while MTK_SMI is built as module.
> > 
> > s/Fix/fix.
> > 
> > What error is being fixed here? How can I reproduce it? Aren't you just
> > adjusting it to being buildable by module?
> 
> Sorry, I didn't copy the fail log here. This is the build log:
> 
> In file included from .../drivers/iommu/mtk_iommu.c:34:0:
> .../drivers/iommu/mtk_iommu.h:84:28: error: array type has incomplete
> element type 'struct mtk_smi_larb_iommu'
>   struct mtk_smi_larb_iommu larb_imu[MTK_LARB_NR_MAX];
> 
> Our iommu driver will use this structure. but it was contained by
> "#ifdef CONFIG_MTK_SMI". thus I change it to "#if
> IS_ENABLED(CONFIG_MTK_SMI)"
> 
> If reproducing it, we should change mtk-iommu to module_init[1]. and
> switch kconfig MTK_IOMMU to tristate, then change the CONFIG_MTK_IOMMU
> to m. we could get the fail log.
> 
> In this case, Should I squash this change into this patch? I though this
> is a preparing patch and the fail is caused by MTK_SMI. thus I squash
> that into this patch. or change it as a independent patch and send when
> I change MTK_IOMMU to tristate?

If I understand correctly, there is no error before this patch. In such
case just don't mention the error to fix, because it is simply part of
making things modular.

Best regards,
Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
