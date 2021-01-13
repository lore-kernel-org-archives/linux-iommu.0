Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBABBC433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 03:22:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48E2923132
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 03:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48E2923132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE60685B5D;
	Wed, 13 Jan 2021 03:22:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o+JWd2i+oEhF; Wed, 13 Jan 2021 03:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B9CE184B82;
	Wed, 13 Jan 2021 03:22:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 802E8C088B;
	Wed, 13 Jan 2021 03:22:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59507C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 03:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5493886CAC
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 03:22:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bjc-MLu9QUU1 for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 03:22:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D900886C6D
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 03:22:25 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id i6so647227otr.2
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 19:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iFD+4R4DB+Y+hIT2uTSS82J75l4RpMhVU01lAZvb2CI=;
 b=XiLtmvceccIcu1tXrCnzRfn5IwV7P7POUADqYzmSHIMEj1sqBUj+msvxo5hpSA1cWX
 faQjtZdcO+IFBPKfu9DN1k3WR9rFc/IUUolw4enLY25TfsSMfzOwobnnXgLlOLJ6Dbq2
 yIx2DwKVxZiYqgPCy8A75483gtDY1VTiISDmnIDLn6KjpbSgzN9DbXEjOlhtTdfaxEF7
 hqgIeysbb3uQTM3MfVH+zvINrWqvybR1+DrcYMzTzEnJN30cR2dl6d8iKaLqJBj4yE1j
 G5xKFVy1nMduYdV87ugZ6OFuhmAv58zwqXaIl/KN3tKJE2sEHDGebb0PHCDw46BBQNZF
 Ym7Q==
X-Gm-Message-State: AOAM530IHA6UJD12lp229Nu4QEGlGwXfyHq4qIZBG/YExWg+sDkgn+0M
 R2wTpz05xYKzy+4gHyA/gQ==
X-Google-Smtp-Source: ABdhPJwVVOTMrJbThfuk487IYRWLYVeUWVU+77/cosixS6TZmaY/4vlEVD2pjzV0pdWCiXhOuUsCAg==
X-Received: by 2002:a9d:1c6:: with SMTP id e64mr16380ote.50.1610508145162;
 Tue, 12 Jan 2021 19:22:25 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m7sm157940ool.29.2021.01.12.19.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 19:22:24 -0800 (PST)
Received: (nullmailer pid 1467559 invoked by uid 1000);
 Wed, 13 Jan 2021 03:22:23 -0000
Date: Tue, 12 Jan 2021 21:22:23 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: arm-smmu: Add binding for Qcom SDX55 SMMU
Message-ID: <20210113032223.GA1467511@robh.at.kernel.org>
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
 <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210107143118.2386-2-manivannan.sadhasivam@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>, robh+dt@kernel.org,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, 07 Jan 2021 20:01:18 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for Qualcomm SDX55 SMMU.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
