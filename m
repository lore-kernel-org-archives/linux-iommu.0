Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D6EC433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Dec 2021 19:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5BFC415B7;
	Wed, 15 Dec 2021 19:16:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EaoC-9167X-Q; Wed, 15 Dec 2021 19:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C86A2415B6;
	Wed, 15 Dec 2021 19:16:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D515C001E;
	Wed, 15 Dec 2021 19:16:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8F0C0012
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 19:16:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34D6B4043B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 19:16:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PifFLUHkUKbV for <iommu@lists.linux-foundation.org>;
 Wed, 15 Dec 2021 19:16:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com
 [209.85.161.50])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A599402C3
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 19:16:26 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id
 r18-20020a4a7252000000b002c5f52d1834so6225181ooe.0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Dec 2021 11:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xgMdRGgCuIolfRdeKGEr50tqMCz4JPztfeQpCRP8ws0=;
 b=VVxQJUznIAnn+XDu0hUc5zJvFyy+6BPWBEBnVWw0K7vVWZ9X41iaZf6hBklMHJqtU9
 yGX0Ahsf1m8x5whOaApXCUDtVMKtLIKhsOsRGC//b7WrPB3QRPS7PNX1a7dIKQlKHtMc
 YTXYMiRTLPpBJmxQsjQ/VJiMWlf5FRIBb+0QYnkx8/TIsHzujDM5bjGE6aZVvjPpw0/Y
 l8m8VlJBVRsjzBzrm0UJi72PbkDRh85Bli9tAqZAtix0fSEpsNWaVmSmdIB1fu1K2QTy
 EB+iZ9g71ARfpIbauWVaXDbda76to9Kh2fXEWe67GHUNvTJaMljteA0W84EEvUy8BYLl
 IgHw==
X-Gm-Message-State: AOAM532RyA9RkrqsbWSCg63sTKFe1CFwFfsadmoD1Wspgc2ox4Fjoq7S
 kdj/TKgU5KoPcz5wlRMk4w==
X-Google-Smtp-Source: ABdhPJxsusBoa6hPOOtDxjKOQmlBNdaIhp1woTGfzH5zoLjDqu1oEoUdLzD4RkrrplFyG70u7FcjNQ==
X-Received: by 2002:a4a:c987:: with SMTP id u7mr8518064ooq.65.1639595785406;
 Wed, 15 Dec 2021 11:16:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id x17sm588157oot.30.2021.12.15.11.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 11:16:24 -0800 (PST)
Received: (nullmailer pid 1673469 invoked by uid 1000);
 Wed, 15 Dec 2021 19:16:23 -0000
Date: Wed, 15 Dec 2021 13:16:23 -0600
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm-smmu: Document
 nvidia,memory-controller property
Message-ID: <Ybo/B1cjP4pumACW@robh.at.kernel.org>
References: <20211209163600.609613-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211209163600.609613-1-thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
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

On Thu, 09 Dec 2021 17:35:57 +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> On NVIDIA SoC's the ARM SMMU needs to interact with the memory
> controller in order to map memory clients to the corresponding stream
> IDs. Document how the nvidia,memory-controller property can be used to
> achieve this.
> 
> Note that this is a backwards-incompatible change that is, however,
> necessary to ensure correctness. Without the new property, most of the
> devices would still work but it is not guaranteed that all will.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - clarify why the new nvidia,memory-controller property is required
> 
>  .../devicetree/bindings/iommu/arm,smmu.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
