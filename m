Return-Path: <SRS0=m4IM=CF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A74C433E1
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 08:03:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB53C22BF3
	for <iommu@archiver.kernel.org>; Thu, 27 Aug 2020 08:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lksoy1ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB53C22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C42DC88318;
	Thu, 27 Aug 2020 08:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyxvA5jbny0A; Thu, 27 Aug 2020 08:03:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5A06188391;
	Thu, 27 Aug 2020 08:03:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38938C07FF;
	Thu, 27 Aug 2020 08:03:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6888AC0051
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3A49E1FE0A
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T+I6hXrsTLn0 for <iommu@lists.linux-foundation.org>;
 Thu, 27 Aug 2020 08:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 342D722708
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 08:01:45 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id o18so6402592eje.7
 for <iommu@lists.linux-foundation.org>; Thu, 27 Aug 2020 01:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KLXKGCMrEd+HEPdG/6Veb0H0KiwUV4QwzjuW5uI1H7Y=;
 b=lksoy1NDScckuAYD4sTllL1Iurtev0e+pvnwfQDJMxCxa7JLt2eW5ZALN6jCFFbZwt
 rnEIqFZ/Kn7iFNQBzR0yn6m4899J5aaMisCuWUNBKBwGamGybczhroFIaIi7M4S6KV5c
 S+kw8klrcatEGIZexnu+yfdz1Z8LWp5yN2mGP2UZC2fgzT1VNci0x8Xk2e6UkXtkY3Xz
 tckKKot1hODrYWrRvUV2p46fu3xJLkQSm2MOsm3V+N4oOz00v50T77zCoYVtf5I2MypU
 G0P7T05k6eFA6lGOrHA5r0uEGiMiQ7ECn6imLPHHN+m6uzMSJMTGSN11V00WRZOer7LJ
 SfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KLXKGCMrEd+HEPdG/6Veb0H0KiwUV4QwzjuW5uI1H7Y=;
 b=SfojfbTLr2Uwe7lKZurTBls2iYOm5V7rJVVLT9EvE+KTBBLe8gCL2RA+4gqSvFfkGe
 nP6xsakK9BjUikOvU2akc+7I1w9r6eGOyZ9JgPMZmTblheKmPPHBYyn4pZyExhC/mQM0
 Wr4tr5F5cfzhkCOOVG8/IrABSjORKAXMdBS+KJo1BOMVg2jGyBA8Sw/R1W77+HBb8Q8N
 uAt4zP2QiQLvzlN+/FZNiZny/OWHWt08R5twYkgBKOfNoxTx58WOuaEDOQFLYG17eRqc
 /on/GKtZZBp6TNahIAySuS/aFaWUNeSC9/Wg7TaLDe1aJuHgZz8zHagsAU1QcHTyZdGQ
 jbwg==
X-Gm-Message-State: AOAM532uJy+WsQdSrYjPf/O1NHOtUobpKH6hvpW64iRKbtv2lj8MleNE
 3irTBJJgybw7FzJd1OPoufyRoQ==
X-Google-Smtp-Source: ABdhPJy3u3bRyTUX8lEQynqXU4hAdCiT/PYeb2x0IdTm6vsd6r4sfZTB0YNbGlWTbOWqcKJT0ea+2Q==
X-Received: by 2002:a17:906:fa15:: with SMTP id
 lo21mr20503865ejb.42.1598515303348; 
 Thu, 27 Aug 2020 01:01:43 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id i25sm954760edt.1.2020.08.27.01.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 01:01:42 -0700 (PDT)
Date: Thu, 27 Aug 2020 10:01:25 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 0/6] Add virtio-iommu built-in topology
Message-ID: <20200827080125.GC3399702@myrica>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
 <20200826092542-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200826092542-mutt-send-email-mst@kernel.org>
Cc: virtio-dev@lists.oasis-open.org, kevin.tian@intel.com,
 linux-pci@vger.kernel.org, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

On Wed, Aug 26, 2020 at 09:26:02AM -0400, Michael S. Tsirkin wrote:
> On Fri, Aug 21, 2020 at 03:15:34PM +0200, Jean-Philippe Brucker wrote:
> > Add a topology description to the virtio-iommu driver and enable x86
> > platforms.
> > 
> > Since [v2] we have made some progress on adding ACPI support for
> > virtio-iommu, which is the preferred boot method on x86. It will be a
> > new vendor-agnostic table describing para-virtual topologies in a
> > minimal format. However some platforms don't use either ACPI or DT for
> > booting (for example microvm), and will need the alternative topology
> > description method proposed here. In addition, since the process to get
> > a new ACPI table will take a long time, this provides a boot method even
> > to ACPI-based platforms, if only temporarily for testing and
> > development.
> 
> OK should I park this in next now? Seems appropriate ...

Yes that sounds like a good idea. It could uncover new bugs since there is
more automated testing happening for x86.

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
