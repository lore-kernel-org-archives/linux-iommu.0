Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8211C55178
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 11:39:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BAD246CA
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 11:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFiD3zgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BAD246CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D997867E0;
	Wed, 28 Oct 2020 11:39:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yqtj5rqFD+MS; Wed, 28 Oct 2020 11:39:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DD01786907;
	Wed, 28 Oct 2020 11:39:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4114C0859;
	Wed, 28 Oct 2020 11:39:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C8DBC0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1FCCC86A00
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QnXGB6Bznftg for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 11:39:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6FC81863E0
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 11:39:45 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id k27so4606192oij.11
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ycf4souIl+vJEDDRrugErU3DI/glUjwSMCLL0gPDd9s=;
 b=pFiD3zgIvJ8kI8n7HPxVqWvOVhDZEALH8E3rtVcH3GMP4yEt1A6ggfNWtHL7R8xplB
 JeNxHFrntI4y0PC4mW1HH4J2x8aEha/uro9Da/FtfOtcPafzRnOYk6uMKYMMoPulgAxQ
 EY9mbYBHkVDUPktpZ2t32RTqdi7SlOkUEAiwjCL1lVaSJYyWdrTXY9BTq3JWwgxrAbX2
 y797BtlzTV7ekAkkzQS8vbOrgaeu7GC0sphYAiKvUjIYsvK0hB1OFSIkVYwmpH3m0lni
 +sse5q8GdKKaoaH8946MuyQI6cSa4LLUjP1IM9CEJfRP64xpi0QoGv4gwBRq1ECLUhM+
 4nsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ycf4souIl+vJEDDRrugErU3DI/glUjwSMCLL0gPDd9s=;
 b=bLvzjy5oauaseA0qfrWCxM1Uv7O9pm4t2h0p0E6h4c64i1ookrX8W3OxJoNpHSp60z
 M07oLfXh6SaCXj52ETkA27pFPgUljHIzn3zYx/8/mDxTvnQefuU4nXoNKZHVZq3CiB4Q
 zZyDKIsSZlDj50FTLaRBWc03K7aN/gSuv1SQGrmMDHI0CeXTAIrgQmILzlHAFKLAdwiG
 zGnbHXHnMODfNSyMI9ERKnmLNm2EYqQ9puTqjtCO/FZn/vAwIuqdP5e/sRJ43iXHQf6M
 fex4OPzxehwhEqnPxHF2g7UjL638fXljxH+cbhmnleyivII9TxZJu0TQERix2wHOrU0L
 eOxQ==
X-Gm-Message-State: AOAM53069VMUA6WSoOvJpof2VSdqPmBmJ2AdEktyHsxm3qfg71Lk2Ky/
 RL4WHlWL/J4vS3hy09LxKFvUdRLWSh/18ZyTvWc=
X-Google-Smtp-Source: ABdhPJx3htBouv1IB6/JdQCAt9OXWMHepRfT2cBX8fUrG4yqPeSF2jh9sL7oJtdOvG7PCNv0LoBVpNyFo7d67faYCAY=
X-Received: by 2002:aca:ea42:: with SMTP id i63mr4653331oih.130.1603885184640; 
 Wed, 28 Oct 2020 04:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190802180758.9691-1-gavinli@thegavinli.com>
 <20190803062333.GC29348@lst.de>
In-Reply-To: <20190803062333.GC29348@lst.de>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Wed, 28 Oct 2020 13:39:17 +0200
Message-ID: <CAFCwf122xMQJgqN9qJ1SXAHkVqg4GoNDC+NvXuj=-owXB=AO0A@mail.gmail.com>
Subject: Re: [PATCH v1] dma-mapping: normal memory for mmap() on coherent
 architectures
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Gavin Li <git@thegavinli.com>,
 gavinli@thegavinli.com,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>
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

On Sat, Aug 3, 2019 at 9:26 AM Christoph Hellwig <hch@lst.de> wrote:
>
> See the discussion at:
>
> https://lists.linuxfoundation.org/pipermail/iommu/2019-August/037716.html
>
> Just curious, what driver do you use that uses dma_mmap_coherent on
> x86?
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

Hi Christoph,
In the habanalabs driver we have moved to use dma_mmap_coherent (to
match dma_alloc_coherent - see commit
https://lkml.org/lkml/2020/8/29/252)
Since then, we are plagued by the kernel log message that gavin has
mentioned, as we are mostly running in our C/I environment with 5.4.
I wondered if you know if there was any fix to that in the more recent kernels ?
If not, can I help to fix that ?

Thanks,
oded
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
