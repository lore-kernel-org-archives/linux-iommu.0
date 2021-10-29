Return-Path: <SRS0=EsFc=PR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D641EC433EF
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 13:44:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C5161100
	for <iommu@archiver.kernel.org>; Fri, 29 Oct 2021 13:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68C5161100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D7D940184;
	Fri, 29 Oct 2021 13:44:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m28eoevqcJM0; Fri, 29 Oct 2021 13:44:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 88FFE40154;
	Fri, 29 Oct 2021 13:44:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47770C001E;
	Fri, 29 Oct 2021 13:44:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ACB4C0012
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 13:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CD4440174
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 13:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w65jS3F30MUM for <iommu@lists.linux-foundation.org>;
 Fri, 29 Oct 2021 13:44:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CE2740154
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 13:44:03 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id x8so9086998oix.2
 for <iommu@lists.linux-foundation.org>; Fri, 29 Oct 2021 06:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Q4j8kz+vDYmA/tiJro/01MgX0r2fELTiXn0N7Y88aTA=;
 b=bFhuDAth6M02i98gJ3xy1LCydanDLp4DaqiNprYPkgRPFsls9C/viihgYHu6OyeB5v
 z2+8RGJP7TLauUA+s1gVimfnMB5slyjwXezCCMwEVVPRgVcRIaESK6iWkF0svCdq1GyP
 LWBYDN3bwpwHSouKBgB1w2GfEqOUqtMnIUXkWz9CrsXV3Kgb2HRJ2ytcVMX29e+V5BVm
 nGKgKqeYbFt/HXnwV6nmREeViaNGNBjCq8U5M2d1ZMljQk4ThEhvWQX9upb3yghlE/Yw
 9rhuMYbSoh3C4OLng9yvZQNhRiqy5CaB/GwBSQ+fiXb1Vtghue2G0e1bOY5TS4mBj7qL
 yLWg==
X-Gm-Message-State: AOAM532oml+GFRjbdrMnxB8sI5yAEacfKUa6Pl5oe9GjWde70QnlwixX
 edkcN0q/dRwErhLICz2LLA==
X-Google-Smtp-Source: ABdhPJxXlg3PkICo5KK9L0xBEvGyufxGFE4IcST0wAx/bcQ2X3qjfMkNzhIl5Qv/WmDQdG6kIWuXqw==
X-Received: by 2002:aca:3455:: with SMTP id b82mr13883274oia.102.1635515042228; 
 Fri, 29 Oct 2021 06:44:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id d7sm1871463otl.19.2021.10.29.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Oct 2021 06:44:01 -0700 (PDT)
Received: (nullmailer pid 2250889 invoked by uid 1000);
 Fri, 29 Oct 2021 13:44:00 -0000
Date: Fri, 29 Oct 2021 08:44:00 -0500
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for the SDX55 SoC
Message-ID: <YXv6oMe4pw6DgIha@robh.at.kernel.org>
References: <20211020231701.278846-1-david@ixit.cz>
 <YXsYnG+H8gQu4Prc@robh.at.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YXsYnG+H8gQu4Prc@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, ~okias/devicetree@lists.sr.ht,
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

On Thu, Oct 28, 2021 at 04:39:40PM -0500, Rob Herring wrote:
> On Thu, 21 Oct 2021 01:17:00 +0200, David Heidelberg wrote:
> > Add missing compatible for the SDX55 SoC.
> > 
> > Signed-off-by: David Heidelberg <david@ixit.cz>
> > ---
> >  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> 
> Applied, thanks!

Now dropped. This conflicts with Will's tree, so he should take it. 

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
