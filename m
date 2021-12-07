Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858D6C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 14:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2907D40935;
	Tue,  7 Dec 2021 14:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b0_kdcGNMQMb; Tue,  7 Dec 2021 14:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E66E1401D6;
	Tue,  7 Dec 2021 14:04:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9893CC002F;
	Tue,  7 Dec 2021 14:04:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 893A0C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 14:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69F15826B0
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 14:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RP_2NibUVs0D for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 14:04:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3DFDE8268F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 14:04:07 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id g19so13575650pfb.8
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uUMLiNh/bSzrS43lAqDC9c682in0XTRAfDruWLqNFmE=;
 b=SYUTMmCU+Y2f8WNZJs4lt3PIdlJ9b+cI4l1BsoFipX8rC9deEq400ZLQP0o8ZiA4vC
 hKNpJJ9OeBi5IqdsdF2L3gNcuSfkmk/vaVaWOhPduRjd8ANsGLjvnskJhbhAQC8IBl2y
 kUOMXpo0+Lp1CsRgzK/5QOqS/Xx9lga/AWXTrQmyTk/RpGKTpHsmZHloi4fP57yD5J40
 DzFj2I1uhLrAjBNereixnEIGie+pO80UHgC+mxrauCrjcssw6SX9y7njLk0YjPNXeUdM
 QvXQz6tExD67LXaPKuvYgDjSSknxpIla0+3mIEB9HD9h7lA+l8EDbFSfMbSG+/8eWeF5
 B5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uUMLiNh/bSzrS43lAqDC9c682in0XTRAfDruWLqNFmE=;
 b=TuHF1rFfa2SOASC1B9/EDLO0ZPdUyvNzU0HCV5yErE1Kl2NfDBRQfMsQwvWsrT4aWv
 l+qTqkFXRgY3ZIEiMeFOVzddFw4edESbxB/44oBR2EDmasl3yVXh3rtZVE5grGlfpDr9
 444rIfr0HxKNelF5K5jEbf5EhHgMvjogfFaxGeBAyWjsRxanJ3oAtJxaOgnv78OSaqbK
 upVWJE/1ZwVOGp4anypi+67vEskMoso991AADg13Sop6oXR5145jWZ2v7a5CYLzux/7S
 BdKpupNOlz1Pk0BYaUt9CKZSNlXt8eywONq/q2XsWADAil0ZqbXzoe096dOftOfQ5vlI
 yWkQ==
X-Gm-Message-State: AOAM5311chpL3yGug4I19uYIYUwfT4rthQtUCUPOc39vB3ubopFndEhz
 WBQhOv3Qdlb3SrLQfqXlv2w7Hg==
X-Google-Smtp-Source: ABdhPJyHIlrdgCmOSeODZKEXgmwArMZ8OyS/M4e8Py4QlUyrwOAc9DhuSEAI/jN+lC7Z7UQ0FTBstQ==
X-Received: by 2002:a63:110:: with SMTP id 16mr23644069pgb.498.1638885846603; 
 Tue, 07 Dec 2021 06:04:06 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2602:feda:dd4:2c9c:bf78:9bf6:6aab:c7a8])
 by smtp.gmail.com with ESMTPSA id
 a18sm15425723pfn.185.2021.12.07.06.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 06:04:06 -0800 (PST)
Date: Tue, 7 Dec 2021 22:04:01 +0800
From: Leo Yan <leo.yan@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Message-ID: <20211207140401.GA273781@leoy-ThinkPad-X240s>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
 <20211117144844.241072-4-jean-philippe@linaro.org>
 <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
 <766ac58a-ffb7-f673-709b-0f0f740f3cfd@arm.com>
 <53f868a8-c7ae-b69d-b061-bb0a7dc98f8a@huawei.com>
 <d60110c4-c179-45d6-512d-3d058caac974@arm.com>
 <20211207132007.GB255238@leoy-ThinkPad-X240s>
 <675bfd78-69ac-608f-1303-e86b90a83f72@arm.com>
 <20211207135904.GH42658@leoy-ThinkPad-X240s>
 <2ece685e-84fb-cec2-522e-70680bcf9370@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2ece685e-84fb-cec2-522e-70680bcf9370@huawei.com>
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 devicetree@vger.kernel.org, will@kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, uchida.jun@socionext.com,
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

On Tue, Dec 07, 2021 at 02:00:35PM +0000, John Garry wrote:
> On 07/12/2021 13:59, Leo Yan wrote:
> > > Whether other implementers might retroactively define "equivalent" IIDR
> > > values for their existing implementations in a way we could potentially
> > > quirk in the driver is an orthogonal question.
> > Agreed, it makes sense that supports the standard IP modules in
> > the mainline kernel at this stage.
> > 
> > Thanks for explanation.
> 
> Leo, if you really want this to work on D06, I could also hack some
> out-of-tree perf tool patches for you. I'm not sure if you're interested in
> that. Let me know.

No, please don't spend time on this.  I just use D06 platform to
verify SMMUv3 relevant patches, but have no requirement for profiling
SMMUv3 on it.  Anyway, thanks a lot!

Leo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
