Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1826C433E3
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:03:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 994C2206D8
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqZwFPCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994C2206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 50ED123A18;
	Tue, 28 Jul 2020 12:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vxpg6CF7xWwg; Tue, 28 Jul 2020 12:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DA99422FC6;
	Tue, 28 Jul 2020 12:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6A15C004F;
	Tue, 28 Jul 2020 12:03:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61C43C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 53BDD23799
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:03:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-5lWnVLafzP for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 12:03:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by silver.osuosl.org (Postfix) with ESMTPS id B859322FC6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:03:34 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id 88so18021155wrh.3
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LfN0TsB7N7AdarfvjvRIf9YQ5p9m006ZFBNxrgGFhZU=;
 b=cqZwFPCNbS0yWTs8sJSDh1ugQQEGr6/OXB6iCZ4Vlb8FuHMTBIySewe9fDuS5pCcHY
 1HqNlzGuFqmXkl3K0JKUOhr+1JP4HqRgPEOCG6OH/tp/K6DW534zZkT4Vhl2iH0H+niw
 +0uVbL3aoXeJOErSt/LbZDLbxCzgjyh+s0ziSWyDZQIwTMge2DlJOgemiGtuzcoHyJLE
 H7M4bhDonetUewooFY+BV2dSDYvdFHN3J8GNP0Mh1jS+fpFV8iMzuiQVHBvLUGXGpcv0
 eCr3CY/zzQfsiPKE7WnVnnE9bhBkYd7qB6b11h2r9s4JUswgheDxZHQ7q4+YBKC8qUKw
 1GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LfN0TsB7N7AdarfvjvRIf9YQ5p9m006ZFBNxrgGFhZU=;
 b=aAo+8EMIPsN/IxFw2IvjZYKIc7TTleMTS+dUL7OQoXIYpoi7Y/3cls8uMLNwSnkwbR
 PcNvIhiytIgZLOJoHTHK2b5NPJFRBuhTUAK/oxB7syY/PXWivgt+2NHkDamEQHQRLRxT
 U1jka50RZMxDLwZNSpZEt90ysnC2wz5GGRtgpPuKwwAMi0AGPAXFL/f3WgVATo9I+gmm
 1PhJ6Zlru6wIyohDEXgYxbtp9kECa0o+OcPaUmfah4uCaIonweVgA4R4YMI9CHFomjrO
 mMrxJspgkj/Z++tP6deXRsMze3mFEbwP9ym6QnKP6KAYFJ4yKbNQ2FU3IzcdAQN9ryXG
 QDjQ==
X-Gm-Message-State: AOAM532h+YfQme1qmHI6Oz5xL99APKhaHWvE9VJS1kjoq+kLP1i+PB4b
 GwPBM2JGx+qcXX6JV+oIlkdvGRjF9rwaW3zCVoorVA==
X-Google-Smtp-Source: ABdhPJze2QvWtkJ6ij2jnuJ2FKwUBr0YC5w6Qp5XEMXd0UwKYAWDXjcARk82aUPZKk4sHLIjSCcPkt0Lt76m5mj44FA=
X-Received: by 2002:adf:f44b:: with SMTP id f11mr7274018wrp.114.1595937812831; 
 Tue, 28 Jul 2020 05:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200728104742.422960-1-hch@lst.de>
In-Reply-To: <20200728104742.422960-1-hch@lst.de>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 28 Jul 2020 17:32:56 +0530
Message-ID: <CAMi1Hd3=6ZZykF1yx_CChqx71k6T-wj12TzJiz_uJZbwrEtTXw@mail.gmail.com>
Subject: Re: dma-pool fixes
To: Christoph Hellwig <hch@lst.de>
Cc: jeremy.linton@arm.com, iommu@lists.linux-foundation.org,
 linux-rpi-kernel@lists.infradead.org, David Rientjes <rientjes@google.com>,
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

Hi Christoph,

On Tue, 28 Jul 2020 at 16:17, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Amit,
>
> can you try these two patches?  The first one makes sure we don't apply
> physical address based checks for IOMMU allocations, and the second one
> is a slightly tweaked version of the patch from Nicolas to allow dipping
> into the CMA areas for allocations to expand the atomic pools.

Sorry, verified a couple of times but these two patches are not working
for me. I'm stuck at the bootloader splash screen on my phone.

Regards,
Amit Pundir
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
