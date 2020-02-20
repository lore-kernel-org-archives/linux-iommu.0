Return-Path: <SRS0=unsG=4I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCACC5ACC4
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 03:37:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D5F24658
	for <iommu@archiver.kernel.org>; Thu, 20 Feb 2020 03:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="F00Tq2Le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D5F24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 368C520513;
	Thu, 20 Feb 2020 03:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5TfwJWSr124M; Thu, 20 Feb 2020 03:37:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9A73C203EE;
	Thu, 20 Feb 2020 03:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F669C1D81;
	Thu, 20 Feb 2020 03:37:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6E13C013E
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 03:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D06E085948
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 03:36:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EacgohVUMYli for <iommu@lists.linux-foundation.org>;
 Thu, 20 Feb 2020 03:36:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E2F0A85803
 for <iommu@lists.linux-foundation.org>; Thu, 20 Feb 2020 03:36:58 +0000 (UTC)
Received: by mail-qk1-f193.google.com with SMTP id b7so2312990qkl.7
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 19:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dkadaknjPr939YsFtbvxvMQUXBujmRjgvIb+Q86NNzM=;
 b=F00Tq2LeK/hphQmCVUmumG7Z7rpvX9/8PQ8WtI22TsMG1bGlBciujm26gP5iCtmcmy
 JolP9CvKAwe7C7rZ2rs1eyssuz61tK7UMtGPro3kMGPypObHPPUkXTCsJY2yRTm7bNX1
 En9nBMEWo75ZVhodDg0Bbp0q5A+Mq3EqwEYFRtP+0IE0+MFjgCgBtQVKCVS1KzJb9Fkd
 g3JWQfbJKfZWkgySNknM6DGF3GYlnQkdU8wzuco6PoySEokD3AwgOOME9B3G7CPr8eu3
 gZ5VpWKEJ2+1xWFnG9ILTynizgI+B1dBkLy8l9v0r5m5uAPHGuVstWHvU/Lm5GLivSD9
 E2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dkadaknjPr939YsFtbvxvMQUXBujmRjgvIb+Q86NNzM=;
 b=YKmjHlPECCqMgqMlsAvRBnWLlda9fmNp23hBP/8kKsYoyfof28OQQuZzdL5xeSZeK9
 ngNNL4bOCMEhSfvOvAjl7k9DKceVEL+BRqnRQqalLqDzRniZl2Pw3YYeh/2RIyea7Q34
 psMBpKhIizhk6rL8Jul0qCYHAormkHBM+diN8+yKZaXo5ceb5KSwIoMYKjVPNWtnGNyP
 tKLxqbCE2vYDY+HFw2ZbX8SNmwQ1GD5DZ87cMyimGWeDsG5GbKrkRApuuXqptzj6RQZ1
 6rGJiocE4Ksq6I1cxi1TwUQg/J5Sdx09YIzql9DPG+DABr/wTtaYgfUNif7a0bd147zn
 Xaeg==
X-Gm-Message-State: APjAAAXq0uDW6n4j2I5BHTTx+835+3ZErLoQiJbKKTV/U9WFnbssCHIR
 X5Of/unFYk6OFjNhL97WB5jCCo5Z7DXBl9llMrDrNQ==
X-Google-Smtp-Source: APXvYqxGQyMUQZS2O6T9QH3W4M7KOXNxHTEB85ieOaAQ6y7VmcHFCF92Gvzkj1LZ+BYxYf6+36/JysxiftpYvvQ+TFo=
X-Received: by 2002:a37:4a51:: with SMTP id x78mr24792506qka.445.1582169817823; 
 Wed, 19 Feb 2020 19:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20200219032128.27907-1-drake@endlessm.com>
 <f1df8a90-c5b8-b6e0-9d7c-e8eb697b0f13@linux.intel.com>
In-Reply-To: <f1df8a90-c5b8-b6e0-9d7c-e8eb697b0f13@linux.intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Thu, 20 Feb 2020 11:36:46 +0800
Message-ID: <CAD8Lp47Bhv_58-Z+a+JFS9rTZW58_rWvE8N+XVtX7mmB-Tj55A@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/vt-d: consider real PCI device when checking if
 mapping is needed
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Upstreaming Team <linux@endlessm.com>,
 Jon Derrick <jonathan.derrick@intel.com>
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

On Wed, Feb 19, 2020 at 11:40 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> With respect, this is problematical. The parent and all subdevices share
> a single translation entry. The DMA mask should be consistent.
>
> Otherwise, for example, subdevice A has 64-bit DMA capability and uses
> an identity domain for DMA translation. While subdevice B has 32-bit DMA
> capability and is forced to switch to DMA domain. Subdevice A will be
> impacted without any notification.

I see what you mean.

Perhaps we should just ensure that setups involving such real DMA
devices and subdevices should always use the DMA domain, avoiding this
type of complication. That's apparently even the default for VMD. This
is probably something that should be forced/ensured when the real DMA
device gets registered, because similarly to the noted case, we can't
risk any identity mappings having been created on the real device if
we later decide to move it into the DMA domain based on the appearance
of subdevices.

Jon, any thoughts?

Daniel
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
