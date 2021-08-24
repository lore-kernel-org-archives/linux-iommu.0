Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE4C4338F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 16:42:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698046135F
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 16:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 698046135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 245B1404B5;
	Tue, 24 Aug 2021 16:42:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hoRnR1MN5mU; Tue, 24 Aug 2021 16:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CFDE340185;
	Tue, 24 Aug 2021 16:42:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8CAEC001A;
	Tue, 24 Aug 2021 16:42:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83129C000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 16:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7123540833
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 16:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ma8cI2t70Jch for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 16:42:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB4F040802
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 16:42:28 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 c19-20020a9d6153000000b0051829acbfc7so47689516otk.9
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 09:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xS+QtzQiuoAe6e5m4kKcB1AtgOWvkfG4yNkCC1KF3aw=;
 b=NTRj6H6Yp7P04N+HvqfpD3MHVdB7hWtGyo4ywYlLx6anprmef3c+p+X18HF1FFavWX
 3qFH0p/xekS32FM4zAPLdiPKl9ZcZrYxZ1GJJlul+WHTNb6SN/JJ4KB+eLGKPOjuMYbO
 6k/yRSVDLr5wZn8Xhv/h3zIGaqBixYw09njuX0pUX+9KieWp2Q2rOQ/P5oq9T9IeMWBO
 /490f9sbJReJAu3k3MP4qu+GV79wFuGUHG9nt9S2s5tWPJi+nZqopPGCyE7nmfA7FoMx
 pIL5Qk7t1g4H29b6p5WRGGuFWukyo/k4aVRfMXBUj3UGK51J1PLqKRVy+mS2NAeFNxzT
 3XEw==
X-Gm-Message-State: AOAM532av5rYEomShmyTqrIVBI/6pFTF3bbJ4cI9eCOkfo/MFNJgf83n
 a5DfcYUQDZylDFO74nEzew==
X-Google-Smtp-Source: ABdhPJzHioaZD2owbUBwVjdP9XBsuI/CgwMh0zF/+mLlYSdJS+bvBe2j/4nYeICM4bxxPP4xM2bsuA==
X-Received: by 2002:a9d:4e98:: with SMTP id v24mr20477465otk.228.1629823347901; 
 Tue, 24 Aug 2021 09:42:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id o15sm3592677oos.1.2021.08.24.09.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 09:42:27 -0700 (PDT)
Received: (nullmailer pid 599220 invoked by uid 1000);
 Tue, 24 Aug 2021 16:42:25 -0000
Date: Tue, 24 Aug 2021 11:42:25 -0500
From: Rob Herring <robh@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM6350 SoC
Message-ID: <YSUhcfEIY/wOiOIt@robh.at.kernel.org>
References: <20210820202906.229292-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210820202906.229292-1-konrad.dybcio@somainline.org>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, jamipkettunen@somainline.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
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

On Fri, 20 Aug 2021 22:29:04 +0200, Konrad Dybcio wrote:
> Add the SoC specific compatible for SM6350 implementing
> arm,mmu-500.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
