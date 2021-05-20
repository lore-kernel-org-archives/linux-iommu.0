Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B5DC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 22:03:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB886138C
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 22:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB886138C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70DF260D8C;
	Thu, 20 May 2021 22:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e2vqFf1gIsBd; Thu, 20 May 2021 22:03:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 55EBC60D89;
	Thu, 20 May 2021 22:03:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 328F3C000D;
	Thu, 20 May 2021 22:03:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A7EEC0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 22:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7706D414F1
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 22:03:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6qjN5XKxd7K for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 22:03:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94C9D414EE
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 22:03:09 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id
 v19-20020a0568301413b0290304f00e3d88so16244327otp.4
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 15:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fTSRjsOcuZx8pYPM4Y1kMmkhvEZ09jKFF24Yv3fC00A=;
 b=AxHMU/xVm3uadc1Jh5NGi4J6y+ze7NQPpRyHtJTp8o3DoJPfZGIX0Su43R4Kb73v1A
 KRFML6YE1KTKoTGnOl+psMX9IXyK0FbZ7gyGCYvcOztaZxDfBlpb3w9RpZHGpi83OIKi
 VTaAj2E2EoVfOkt66cLObFQYwkE0CuhkBBsLyAPrqa+Maij1vsdCRmpvnLC8E7UJwQa5
 EOZUXlbaE77+ARcixcnCFBy3TTCpGSJyam1ibiLAO6kh1bEWljeczLsyv346NXRmv0HZ
 nB+Qv2XnBuTHmunOG3u/f/zf3+xq2XkQv/6+dN+LLU7LGS00bxG+locpeAAELOw9CrBL
 DM2Q==
X-Gm-Message-State: AOAM531DBUJjrJdZbeuYhHVGyH/QSAxuMxIqREEQOofmSO12x+3Pyl/b
 yMXmF4LhcPY1qYIMg46+lg==
X-Google-Smtp-Source: ABdhPJwtAU3l1c6DBNoU2f0LgsDgxOJkyUKiPWVnTMvPY2Qx9BfZ0T12uREJKY4gARMRp8ykv2eAJw==
X-Received: by 2002:a9d:e88:: with SMTP id 8mr5249701otj.239.1621548188615;
 Thu, 20 May 2021 15:03:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n13sm799982oov.30.2021.05.20.15.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 15:03:07 -0700 (PDT)
Received: (nullmailer pid 2071988 invoked by uid 1000);
 Thu, 20 May 2021 22:03:06 -0000
Date: Thu, 20 May 2021 17:03:06 -0500
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: reserved-memory: Document memory
 region specifier
Message-ID: <20210520220306.GA1976116@robh.at.kernel.org>
References: <20210423163234.3651547-1-thierry.reding@gmail.com>
 <20210423163234.3651547-2-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210423163234.3651547-2-thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org, Nicolin Chen <nicolinc@nvidia.com>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, Apr 23, 2021 at 06:32:30PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Reserved memory region phandle references can be accompanied by a
> specifier that provides additional information about how that specific
> reference should be treated.
> 
> One use-case is to mark a memory region as needing an identity mapping
> in the system's IOMMU for the device that references the region. This is
> needed for example when the bootloader has set up hardware (such as a
> display controller) to actively access a memory region (e.g. a boot
> splash screen framebuffer) during boot. The operating system can use the
> identity mapping flag from the specifier to make sure an IOMMU identity
> mapping is set up for the framebuffer before IOMMU translations are
> enabled for the display controller.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../reserved-memory/reserved-memory.txt       | 21 +++++++++++++++++++
>  include/dt-bindings/reserved-memory.h         |  8 +++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/reserved-memory.h

Sorry for being slow on this. I have 2 concerns.

First, this creates an ABI issue. A DT with cells in 'memory-region' 
will not be understood by an existing OS. I'm less concerned about this 
if we address that with a stable fix. (Though I'm pretty sure we've 
naively added #?-cells in the past ignoring this issue.)

Second, it could be the bootloader setting up the reserved region. If a 
node already has 'memory-region', then adding more regions is more 
complicated compared to adding new properties. And defining what each 
memory-region entry is or how many in schemas is impossible.

Both could be addressed with a new property. Perhaps something like 
'iommu-memory-region = <&phandle>;'. I think the 'iommu' prefix is 
appropriate given this is entirely because of the IOMMU being in the 
mix. I might feel differently if we had other uses for cells, but I 
don't really see it in this case. 

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
