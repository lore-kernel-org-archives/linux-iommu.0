Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD32C433E6
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:51:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C9223A5C
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C9223A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7AD1F86AC9;
	Fri, 22 Jan 2021 13:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KlGCQewodZCU; Fri, 22 Jan 2021 13:51:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A17F086ACF;
	Fri, 22 Jan 2021 13:51:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D79BC08A1;
	Fri, 22 Jan 2021 13:51:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DAA14C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C92CC86AC1
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDeCe3sL0qCM for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BEF6086AAE
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:51:02 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id m6so3708255pfm.6
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1DGptUPlPUDIn46y7qVQ8wP/NzkZbz3BOz3IJ/t3Ri4=;
 b=K5ZxW5R6zCAWwRlAyqFvab6iy9nUnoYhM+Hfj1cVsyl4Dur1lEoF432t4M1p+3ym+6
 3bmcSqExz+TlsKo27fgffGVoHS5tqJqltp2pW0jsEAX1Csq8V4zEnGeCoT4gMqvBFtYu
 N2foheRcmuoMdvJheolSLC9I2sQ46YUWH9PsubGu044f8UlgsffKfd96TrdpntMaXZsg
 8S+rinNqdJdX8gGnpu4zg0QfL2MF7X3KdnKXEhC06epLv9CRrL2sCkQeU/GZ9ZSZVcWK
 T/LeKssx7reL5o4KUHBkO7c4ozEZaO0U0OZH7TRbyc/uUcH0SiNJIKlkeSXyz9lHq5DE
 W/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1DGptUPlPUDIn46y7qVQ8wP/NzkZbz3BOz3IJ/t3Ri4=;
 b=J6MYgop1uuJcGBfiWfxfiZJqO/Eych5ysmqkNCOBCguavT1f3VCp4dcsASQSIpxxnh
 smFkhvpXZyhj57AnBj9KUaHtIY4ocPubaHCGRd9UiBnN2opLLpb1YuSXoWvYmFSlcOdY
 DFvrtRa6Shjmd+3ztdyHV1ZZrqRI9aTGYnQGwLBxkAX3N9hMPIPHopLvX3JvhZl1t/uh
 K2Nisf0ilCQvldQ3zGDyWv82hstUKk/l13ogzF+Qz8blYab7qEJI8hmf9BdPZwaVOZlF
 n8eOVxFNqzs70XoKlwrkF5ioMqk6c6A06pj6fgQFib9QdW4NMLycAXaL8ivOg7z7XO+d
 GALw==
X-Gm-Message-State: AOAM533rXOb0EBO6a91CQI15JPVKBeyH81z1EA7n6tIQ/fhL3vBkK9nq
 22dpMZAZmfs07JGBx/t3XzOX
X-Google-Smtp-Source: ABdhPJyLPLAM/0qyg6GdxdI1af+ix4NN6PsYGYu3BDKebA3E1Sak2EbnzgI+kYjzh2sCnSCMx8qqPQ==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr4804757pgh.396.1611323462136; 
 Fri, 22 Jan 2021 05:51:02 -0800 (PST)
Received: from work ([103.77.37.137])
 by smtp.gmail.com with ESMTPSA id m18sm5971806pfd.206.2021.01.22.05.50.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Jan 2021 05:51:01 -0800 (PST)
Date: Fri, 22 Jan 2021 19:20:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Message-ID: <20210122135056.GA32437@work>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
 <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
 <20210113032223.GA1467511@robh.at.kernel.org>
 <20210122131448.GE24102@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210122131448.GE24102@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org,
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

On Fri, Jan 22, 2021 at 01:14:49PM +0000, Will Deacon wrote:
> On Tue, Jan 12, 2021 at 09:22:23PM -0600, Rob Herring wrote:
> > On Thu, 07 Jan 2021 20:01:18 +0530, Manivannan Sadhasivam wrote:
> > > Add devicetree binding for Qualcomm SDX55 SMMU.
> > > 
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: iommu@lists.linux-foundation.org
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> 
> Is there another patch adding driver support for matching this new binding?
> 

Nope. But the compatible is used as a fallback with "arm,mmu-500". The
dts patch is merged into qcom tree:

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=dts-for-5.12&id=a2bdfdfba2afb532f2a2c8082bdb7de8379a4b6c

Thanks,
Mani

> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
