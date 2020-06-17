Return-Path: <SRS0=yzgR=76=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564CAC433E2
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 22:40:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127E52080D
	for <iommu@archiver.kernel.org>; Wed, 17 Jun 2020 22:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127E52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C3AB587D15;
	Wed, 17 Jun 2020 22:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q9BE+rze+4MZ; Wed, 17 Jun 2020 22:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 088BA87B49;
	Wed, 17 Jun 2020 22:40:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5018C0863;
	Wed, 17 Jun 2020 22:40:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48363C016E
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 22:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3639387215
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 22:40:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zpwPO0S9vBto for <iommu@lists.linux-foundation.org>;
 Wed, 17 Jun 2020 22:40:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E2BFD87210
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 22:40:27 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id a13so3965010ilh.3
 for <iommu@lists.linux-foundation.org>; Wed, 17 Jun 2020 15:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Zfs6fQ9dNu1WR3lr294IASeX3pxyyPciqezJugqbLdg=;
 b=PAOLKTPzEk92FLpg4N+YwzTIIhcIjypWDg+9v27wcqT4Zy5xIMt9zrFs0cbQ2aM7bx
 KJYlbWkia33dQoGgyWpSgjFqI9r6Mm1fPV7rXULf41odAxg/iKI/tl8ztie5vpke6lIl
 MlTaxLaD4Os2b0pPO4/0TXjkx6HovtiLojQkZzlsYe4iW5lb7GfZ+5t98EYauQkZpnV7
 pPR9A9z8GuAFVMRK18+Gz3BKV49K0oEvL3nVV5XPMm6tmSfZo4Zy9DVw8LK3NR9G3Bak
 QPv84ISjM1jO87Y248APeopgo8n1UiSh5lJ8hbCTqx7yMvF4XsFAqjP5hOTdDD/5p+S1
 r8tA==
X-Gm-Message-State: AOAM530dQWxGizs7Nd6JkDkVYORqClf1r0P2Rne4Bh+U9dTMVgpfE/QB
 DFLLxbsShThIHFnBzPe0oA==
X-Google-Smtp-Source: ABdhPJzRwz/0uaYi76fA5Zd1pUASZHPvWS/+PxMD1pnVAfG3nH0ehNSUR64R0ytuzMsQ9XxUG4dQDg==
X-Received: by 2002:a05:6e02:ef2:: with SMTP id
 j18mr1221721ilk.69.1592433627244; 
 Wed, 17 Jun 2020 15:40:27 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id c85sm537559ilg.41.2020.06.17.15.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 15:40:26 -0700 (PDT)
Received: (nullmailer pid 2970050 invoked by uid 1000);
 Wed, 17 Jun 2020 22:40:25 -0000
Date: Wed, 17 Jun 2020 16:40:25 -0600
From: Rob Herring <robh@kernel.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v8 3/7] dt-bindings: arm-smmu: Add compatible string for
 Adreno GPU SMMU
Message-ID: <20200617224025.GA2969998@bogus>
References: <20200611222128.28826-1-jcrouse@codeaurora.org>
 <20200611222128.28826-4-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611222128.28826-4-jcrouse@codeaurora.org>
Cc: freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, 11 Jun 2020 16:21:24 -0600, Jordan Crouse wrote:
> Every Qcom Adreno GPU has an embedded SMMU for its own use. These
> devices depend on unique features such as split pagetables,
> different stall/halt requirements and other settings. Identify them
> with a compatible string so that they can be identified in the
> arm-smmu implementation specific code.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
