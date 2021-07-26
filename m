Return-Path: <SRS0=C8jr=MS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56822C4338F
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:15:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0732360F37
	for <iommu@archiver.kernel.org>; Mon, 26 Jul 2021 08:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0732360F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB78F402A6;
	Mon, 26 Jul 2021 08:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jtTx7YhvHdyj; Mon, 26 Jul 2021 08:15:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C3D02402A3;
	Mon, 26 Jul 2021 08:15:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E555C0010;
	Mon, 26 Jul 2021 08:15:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1222C000E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFA4A8317B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:15:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gPoR4H6bUlQM for <iommu@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 08:15:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5B74830FB
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 08:15:01 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id e19so15077929ejs.9
 for <iommu@lists.linux-foundation.org>; Mon, 26 Jul 2021 01:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=lYPdbRk9NzuoNJUglE6NuLhP3wUwwX0fk3ZFMcXvP/U=;
 b=EAfH77y0T9DVi60ddgTxfiNjVbCkRZDnGy7sUciUJR8aVdP1qOrB2yFz9zft4tSwyK
 h3o1PyOTWU7bnLEIm1BK5Y3c3iso8WYqSImsfo07C6TTdXS9E254YhrUPkSFM0EaMFF3
 F9gXUmffTab0iU9CLaHRX9SpepJQvunKcStC67hdbv1lIybQdZ2TKpcKpRCvw+TMOX4W
 cngneCV5GAgn9g7Ccn6FVxd3mfaEzXzL5OypdyFn/uuHo31xdAA2oP4+m5iwLiaNlZS+
 xZXyemQM1pI0rJelm4HCJ+DaZ6gKAs4OsXMBaXNPcKh6U2FvN6B7JYPgUdLd2sRqMd+z
 k1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lYPdbRk9NzuoNJUglE6NuLhP3wUwwX0fk3ZFMcXvP/U=;
 b=EXno0S7iNi1t1F/kOq/vVs3fdu8yX8saYtdran9Y9vNH746QwoTbw1BVePdC0swrPJ
 EnZLjWM/M557p2YMnS308yj2dkuoJkR9djMVK9ZRaXcCES3C7+rBoPetyeUHlwEUjT1R
 nJCm7c87BPr6ajyteS4d3F5gn18Z350bcd8+nVSHU7Z+o8t5D3tha/arfLx8gZ0VtcNS
 z/giqaWNTYe3u3u3ngz7jXiw/sJp9eRG+kle9m0ykJ++480mGSuJhSag3q1VohLa7S2y
 qtPLTExINtGPS4PcheFNccXrHtbblVHVEISwWDVjVc4tGHv4g/VZuRHbC6JL8+Kdo0le
 2C9A==
X-Gm-Message-State: AOAM531HOEzyGnAGZmj275Rve78Ck/CVgfnQLBkaWfGgBaMh69N7yTf4
 gHTEhnkKQQa4ZJlT/CFjGPh1WQ==
X-Google-Smtp-Source: ABdhPJwcWhMt07hFfYz3oKUeMDexBTevTaRnXbZLHsRRWc1FmkyQoTlAXPWEQn1VXvq4ZHIZjwge1Q==
X-Received: by 2002:a17:906:580c:: with SMTP id
 m12mr13853095ejq.32.1627287299669; 
 Mon, 26 Jul 2021 01:14:59 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id gx11sm14042132ejc.33.2021.07.26.01.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 01:14:59 -0700 (PDT)
Date: Mon, 26 Jul 2021 10:14:36 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <YP5u7Fk2pylHNGeY@myrica>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

Hi Kevin,

On Fri, Jul 09, 2021 at 07:48:44AM +0000, Tian, Kevin wrote:
> /dev/iommu provides an unified interface for managing I/O page tables for 
> devices assigned to userspace. Device passthrough frameworks (VFIO, vDPA, 
> etc.) are expected to use this interface instead of creating their own logic to 
> isolate untrusted device DMAs initiated by userspace. 
> 
> This proposal describes the uAPI of /dev/iommu and also sample sequences 
> with VFIO as example in typical usages. The driver-facing kernel API provided 
> by the iommu layer is still TBD, which can be discussed after consensus is 
> made on this uAPI.

The document looks good to me, I don't have other concerns at the moment

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
