Return-Path: <SRS0=6QSB=IH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F418C433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 17:34:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E9664F02
	for <iommu@archiver.kernel.org>; Tue,  9 Mar 2021 17:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E9664F02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FE4A6F5F8;
	Tue,  9 Mar 2021 17:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ry_56xGBebVI; Tue,  9 Mar 2021 17:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D3526F4BC;
	Tue,  9 Mar 2021 17:34:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A065C000B;
	Tue,  9 Mar 2021 17:34:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5936EC0001
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 17:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A63C83077
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 17:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fGQ7pPVU4Eb4 for <iommu@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 17:34:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2F99282FAE
 for <iommu@lists.linux-foundation.org>; Tue,  9 Mar 2021 17:34:15 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 m20-20020a7bcb940000b029010cab7e5a9fso7243638wmi.3
 for <iommu@lists.linux-foundation.org>; Tue, 09 Mar 2021 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=u2Jgq2SnEUtYvh+N+tLW1yt3xw0hfp1QxcwgyedJ7ds=;
 b=qJyWMJ60xOqK0ZUsA2dlaXWSGFKGH3Yvm6uAgMQJAXNEPWydlYRk8aq9iAaoFgqdm4
 KfHU/rYSqzlLw6DjYgzy+0ubuR3EQHX0GgxFtDVTL8pmxBv2t62G2xik5b026iT+pt+S
 E36q/xu+DnxEGX31iTZRh5KQT4wWhdovQaUJEG9KQtEtF0JbMy5LIqdi14SepZWK4+7b
 j/ZPgEOWBqH6kCWswHqw+3kWCGIdkXwpJPN3wYXXstSKWTjL9Ev6jN4USnUz/FMlvuE4
 +yH3FHbcxiopniS/RMPTfquoFNP+16GDnuM55pO1njHe2VqIUOrdXiRw13CaLmROpLav
 BVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u2Jgq2SnEUtYvh+N+tLW1yt3xw0hfp1QxcwgyedJ7ds=;
 b=QZGkD2EN9KVFSod2a5d2gNVE1ihhS7dPC5NDAoDhjFn4HYwl36Rz9mny+a1Mq1v7ST
 W8Y3ctLLK0XAcr9YZsNqTlspTcgF7lnusm+WFzLJvphN0aecDHe9NbRb107Pi3BfhVp/
 b7cCCqgQZ73zXqmIMz9NjSEG7ZAVzRRZYcifRGBByblBtReeHn0tAZfkU5Srw18Fcwlm
 83b2pHbPBMZhQc/ch4tXFsqdOEtEsdEMcBv5W0KUPRdXz2CnUOUcPpmPCB1q2pI05lzH
 ms+7yZ6TiHx0g4J/KqXkXAP/VtFRdnC2QyBQA0sFxNSjhq/dN8vh8zHTYnCB4DkIemdl
 lQcA==
X-Gm-Message-State: AOAM533DAsVadx8c7rtNIAT9coOWWXGpOvXUoehYKTarLLLOCpOKSXoZ
 ry8H7gApUse3heym1D3im1XSzg==
X-Google-Smtp-Source: ABdhPJx6ZdYnpNQLX/O7M2VYIdw9Lzlp44StIKqfq7yUlf4Hzk6VAEa3cWvsT55R4PRXOBUooXO2sQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr5325693wmc.59.1615311254016; 
 Tue, 09 Mar 2021 09:34:14 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w6sm25973243wrl.49.2021.03.09.09.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Mar 2021 09:34:13 -0800 (PST)
Date: Tue, 9 Mar 2021 18:33:51 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
Message-ID: <YEexf0/V/YF394bf@myrica>
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
 <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com>
Cc: Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@linux.ie>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Will Deacon <will@kernel.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

Hi Felix,

On Tue, Mar 09, 2021 at 11:30:19AM -0500, Felix Kuehling wrote:
> > I think the proper fix would be to not rely on custom hooks into a particular
> > IOMMU driver, but to instead ensure that the amdgpu driver can do everything
> > it needs through the regular linux/iommu.h interfaces. I realize this
> > is more work,
> > but I wonder if you've tried that, and why it didn't work out.
> 
> As far as I know this hasn't been tried. I see that intel-iommu has its
> own SVM thing, which seems to be similar to what our IOMMUv2 does. I
> guess we'd have to abstract that into a common API.

The common API was added in 26b25a2b98e4 and implemented by the Intel
driver in 064a57d7ddfc. To support it an IOMMU driver implements new IOMMU
ops:
	.dev_has_feat()
	.dev_feat_enabled()
	.dev_enable_feat()
	.dev_disable_feat()
	.sva_bind()
	.sva_unbind()
	.sva_get_pasid()

And a device driver calls iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA)
followed by iommu_sva_bind_device().

If I remember correctly the biggest obstacle for KFD is the PASID
allocation, done by the GPU driver instead of the IOMMU driver, but there
may be others.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
