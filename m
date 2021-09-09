Return-Path: <SRS0=9mGv=N7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24301C433F5
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 06:53:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F2561183
	for <iommu@archiver.kernel.org>; Thu,  9 Sep 2021 06:53:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4F2561183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CD5160AC8;
	Thu,  9 Sep 2021 06:36:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4002u01E_5Jf; Thu,  9 Sep 2021 06:36:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33E5060AC6;
	Thu,  9 Sep 2021 06:36:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B803C0011;
	Thu,  9 Sep 2021 06:36:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01204C000D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 06:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFD09404B8
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 06:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=canonical.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9wFyLjs6B2ky for <iommu@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 06:36:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7B07400CB
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 06:36:39 +0000 (UTC)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D0D973FE05
 for <iommu@lists.linux-foundation.org>; Thu,  9 Sep 2021 06:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1631169393;
 bh=akLaMR2Qq8amUpvssgxVNr2WG7Nl5vSl23ypQFllRfM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=FId84mJTLkMEIkHjzNBAhbZ7b7H4Cd7A/uhlPhOISsn58UDC3jmFnqe251AL7MoOe
 Cy6L/QknptZsvgRF4r7OxWoVEZG9ptHPqLcO2HK77HCIJ9ASFI1hRy/OK94PgdhpvA
 sqEQZv5gmv9nhvMPQMxI96IkhWNadbvCtX7P2ZNXcz7003boH6LpIYt6iwCFZhus/k
 Opvv7qx09ZLTetTCTcCAFZa1LORxaHHqlNTvoE5amFoHWhyfOm2H/+/TfVJk9uymVX
 6dnIoIvWJdw0X4+uBZ2jSwN7J25wkk1DNtFIab0HYvCculMObuOfKG3DOofGBqgHty
 2PdHGsz82H0bg==
Received: by mail-ot1-f69.google.com with SMTP id
 c21-20020a0568301af500b0051af51e2a5bso545779otd.10
 for <iommu@lists.linux-foundation.org>; Wed, 08 Sep 2021 23:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=akLaMR2Qq8amUpvssgxVNr2WG7Nl5vSl23ypQFllRfM=;
 b=xbX5PHpDZz7cDt3KFHYQqBXPlqWWRTaTNVj8ekL/fktpvT7XNsqyGcwFBtTIclOShL
 qrMJgzTJiSwqV7SroDSqLxOdy5VheLWddcUyBOOsJlHLCvSJmFwReZzK2H74AURgpIJB
 98JpU9wNG059rounVJ1gEDRgbm7EqkFq3nhLC03yuebwphWFrWlMWC6AmKS21tT5GfVp
 etfqZ33Q9U/HNnBRohy5wff10zeIuv5uNMsqgXhCLfsnr02CHFuDKlK3zPHxZKlw+Toi
 SrgwwM2S4BD7iRnXepzWN4m+OuibcQN3oyuQc+szRMPLkon3LkmIVr1g6bp9nmZtxvWU
 GGsw==
X-Gm-Message-State: AOAM532TsJ9vKLw2bu2+wZze8VGs0u7bgFbg+VsNyqaZj1hp80Wq/mYo
 BjFH0FrRWT6p+0+jQ75IOSlA8/XXTF3Zgjre/7Y+WpxVp9zj5sjqD/BmbCbpjd2NTvJ2RrmWxBv
 GX2j79i0eNxcnJbKTAI7tAZwz7k85loSlAOm9/62NkZws4MzdWoOavMMDNnZI6tk=
X-Received: by 2002:a05:6830:1355:: with SMTP id
 r21mr1140774otq.11.1631169187448; 
 Wed, 08 Sep 2021 23:33:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydNUWa4iWIrH1MSc4yRb3P5wiZt7TtCAWb93Z2ahXjOMnItwMOcoXnTS7/j/i2x/EH0tmNaHVVy938jYvOcUc=
X-Received: by 2002:a05:6830:1355:: with SMTP id
 r21mr1140764otq.11.1631169187145; 
 Wed, 08 Sep 2021 23:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210708074232.924844-1-kai.heng.feng@canonical.com>
 <YObFJREB9/JlcNZP@8bytes.org> <fde11cec-d1bd-49be-f129-c69a973d1b3b@arm.com>
 <CAAd53p40RcG0oeYr9QAKMjYRtyq7he=d_b_a39n4Rt5JSVScRQ@mail.gmail.com>
 <f3bdedcb-5602-cbca-7df1-019e8b8c4217@arm.com> <YO4odF0EwqxfNLFq@fedora>
 <YO67m/jaBvco+I36@8bytes.org>
In-Reply-To: <YO67m/jaBvco+I36@8bytes.org>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 9 Sep 2021 14:32:55 +0800
Message-ID: <CAAd53p4138BB_5-++0P9k91B1dCuKzuv1yGjiG77ewhd1MRSbQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Enable swiotlb if any device supports iommu v2
 and uses identity mapping
To: Joerg Roedel <joro@8bytes.org>
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, open list <linux-kernel@vger.kernel.org>,
 will@kernel.org
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

On Wed, Jul 14, 2021 at 6:25 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Jul 13, 2021 at 07:57:40PM -0400, Konrad Rzeszutek Wilk wrote:
> > The SWIOTLB does have support to do late initialization (xen-pcifront
> > does that for example - so if you add devices that can't do 64-bit it
> > will allocate something like 4MB).
>
> That sounds like a way to evaluate. I suggest to allocate the SWIOTLB
> memory at boot and when the IOMMUs are initialized we re-evaluate what
> we ended up with and free the SWIOTLB memory if its not needed.
>
> If that turns out to be wrong during runtime (e.g. because a device is
> switched to a passthrough default domain at runtime), we allocate a
> small aperture for this device like the above mentioned 4MB.

I am currently working on this but I found that 4MB is not enough,
16MB is the minimal size to make the device work.
How do I know the right SWIOTLB size for each device?

>
> (A boot option to always keep the aperture around might also be helpful
>  for some setups)

OK, will also implement this in next iteration.

Kai-Heng

>
> Regards,
>
>         Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
