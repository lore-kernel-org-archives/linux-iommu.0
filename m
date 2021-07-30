Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE94C4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:22:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C924D61008
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 09:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C924D61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9328C831E3;
	Fri, 30 Jul 2021 09:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dRKj4cwRgzRC; Fri, 30 Jul 2021 09:22:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 81AF9832D0;
	Fri, 30 Jul 2021 09:22:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A19BC001A;
	Fri, 30 Jul 2021 09:22:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F0D5C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 708AD40672
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:22:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id caOJFPcdp9rG for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 09:22:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C52854063E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 09:22:14 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id n2so12174495eda.10
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=/yZoRBkftFgh9sXLWCqSA0NNYyaCCzLCtVVu+qXCde8=;
 b=Cnze41uObV3UjuyKBRXynffruXTghJme4w6xH2+CKNaIh5jdAjagHEtVi6brOprdI1
 hB7CgQP5ZMZ/wpvfAjvC7o0PiTQFG1Sz49unqZPzACDr4Fm9eaP7el6nWO74/isfRLPO
 yAdvxa/7NSLZglcZKCaV8LvCWyz+oj0SIaWafNT74kSpPOz13+bi933z+GlX+US69IUN
 C9lqUSNLFaNVuhLAnUUpRBw6yt8rNe4iRiWFtRIC8DWrkSQBN30UvEUMV1Gi4XpQHblE
 0bRkNR9LuW89ZCe0CmMVfph8tOr5sdtFopwv3F81Qv+h3F5TBv7M910U5VhGTZ+cIBbM
 +5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/yZoRBkftFgh9sXLWCqSA0NNYyaCCzLCtVVu+qXCde8=;
 b=TUpI9czIuDCr6hrEImVvdtY8cpJst5vG6JWS2m07UE32fQQKywgDmAymwptadUyStX
 dVJAMQG8ucPY4WYzcK+v4qkNVUzJCw+OhqD5FrotdX5tCw+aHu1yCxd5kIQPsuaJp0dU
 okYJXo7gNDyzVlnHBrDPw6tfYQ78CpboNJd4Q92aCldWiA20Q0Pcb8ifZ2XgTA5V5gS+
 JDaqjHmgxDPTNw4AZ9goUWRIYOy4mTDiyBa21L3PYg/Gnqetmdc5RZIWdWzyGTxnVxiE
 MchEBQRzpWukqXCnqoKXDJXb0u2dL99gu4wRILHK18GF15PFP0paBEcdzT7d2w6waBwV
 7cGQ==
X-Gm-Message-State: AOAM530dHjTa5wDZm4Yy4Qr0Iw9dkUXuUMFGUSGUQmYcKqh+1uvJH3KP
 D58j23BxWkTVtfs6TY8cSE8GNA==
X-Google-Smtp-Source: ABdhPJy4oM5AApIX3U2FLlWjmaeuzBFrALH3XEYx9p1j+sbBrABIeZKEW0bwiWMsceNydTvxKBGPwg==
X-Received: by 2002:a05:6402:42ce:: with SMTP id
 i14mr1833230edc.345.1627636932973; 
 Fri, 30 Jul 2021 02:22:12 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id mh10sm357790ejb.32.2021.07.30.02.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 02:22:12 -0700 (PDT)
Date: Fri, 30 Jul 2021 11:21:52 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 12/24] iommu/dma: Unexport IOVA cookie management
Message-ID: <YQPEsKymGXDnXrcL@myrica>
References: <cover.1627468308.git.robin.murphy@arm.com>
 <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, will@kernel.org,
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

On Wed, Jul 28, 2021 at 04:58:33PM +0100, Robin Murphy wrote:
> IOVA cookies are now got and put by core code, so we no longer need to
> export these to modular drivers. The export for getting MSI cookies
> stays, since VFIO can still be a module, but it was already relying on
> someone else putting them, so that aspect is unaffected.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
