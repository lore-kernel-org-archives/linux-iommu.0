Return-Path: <SRS0=iLkC=PQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F9C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 21:39:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9863F60FF2
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 21:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9863F60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 605C9823F9;
	Thu, 28 Oct 2021 21:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EaO2xZ0Qaxgv; Thu, 28 Oct 2021 21:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5E09A81D65;
	Thu, 28 Oct 2021 21:39:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BDA0C0019;
	Thu, 28 Oct 2021 21:39:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23795C000E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 21:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03EC84048E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 21:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MmZPjigR1AqD for <iommu@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 21:39:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D106840101
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 21:39:42 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id x8so6009286oix.2
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 14:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TQ4SKNB7MnmkITYiKq9OaxL/6LE4iRf7G2BlLXaMFT0=;
 b=Fr+GCKSw/hA0qJrlwjJllsgDK7Kdb4ohv/0/yZE15ktE1kHJriCx75bZdk4qaX1xGl
 4Jf8nkUXW7l75GpSofdFNE1nDsJj4j4DcbiDk2ptziK+xdC99TdUHYt/Q5WyiIESoVmx
 0ftECP2/EaxPq5D4btzYg5iU532fmF4w8hKCUawCYYdJ2WyOSUqThHTpcDnIUloMZx1l
 Q2av/8T3wShvyr/EsmQkBtGJHCfN8mrn+pcGIpQOGVyNlYiq1l91ooZsvBC4BEMyzxJx
 pj2mO2Otptd3x2/pNjpp2YTFXUzhsZVNJt3533ZIeptfoawK2A4md4da4kSbHXwICEg0
 MQ4w==
X-Gm-Message-State: AOAM53378TwDL1ejYfgZszRBzQ4j0dGcxyFgFA4PHiOlmBgsub3owwH3
 84SDjCHGZkxL7AbG7qaw8A==
X-Google-Smtp-Source: ABdhPJzOT/3TCzv6UnPH4JVEx/wL3HRrNdHhCuWskSHZ+nZPafpkq4i3RmB5gl7enVIsnbiO+cEEdA==
X-Received: by 2002:aca:ac0f:: with SMTP id v15mr2038214oie.46.1635457181936; 
 Thu, 28 Oct 2021 14:39:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id d28sm1377732ote.7.2021.10.28.14.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 14:39:41 -0700 (PDT)
Received: (nullmailer pid 634348 invoked by uid 1000);
 Thu, 28 Oct 2021 21:39:40 -0000
Date: Thu, 28 Oct 2021 16:39:40 -0500
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Message-ID: <YXsYnG+H8gQu4Prc@robh.at.kernel.org>
References: <20211020231701.278846-1-david@ixit.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020231701.278846-1-david@ixit.cz>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 ~okias/devicetree@lists.sr.ht, linux-arm-kernel@lists.infradead.org
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

On Thu, 21 Oct 2021 01:17:00 +0200, David Heidelberg wrote:
> Add missing compatible for the SDX55 SoC.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
