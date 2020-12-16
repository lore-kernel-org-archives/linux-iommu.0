Return-Path: <SRS0=vTls=FU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78B7C4361B
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:02:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8E22389E
	for <iommu@archiver.kernel.org>; Wed, 16 Dec 2020 22:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8E22389E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DF7852279B;
	Wed, 16 Dec 2020 22:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DTqsxSIn5H11; Wed, 16 Dec 2020 22:02:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 05B9821FA9;
	Wed, 16 Dec 2020 22:02:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4155C088E;
	Wed, 16 Dec 2020 22:02:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0677EC013B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E152186910
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NIWvmQm7Xq4W for <iommu@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 22:02:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com
 [209.85.167.47])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 117A586935
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 22:02:21 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id u18so52276024lfd.9
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 14:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XVPDkcq2n/WLZ6yomPRY0PIIm6Y28Hu8R8ZEQci4gcc=;
 b=FfOSNMn6BfsaQpN+0851BpFCp8KONi6y8EqO2T7gy3zX6onh6L81KKExHaRYCOq9UI
 nNvh88KW0qmGG5Y/w1FOaldtFU5Wp7UMey299zWFQF8hzJSUII4VktvUdKK5z5uxjMbT
 jpKjMw3bRpbn1s2vi3Xn+obmSw4luEBTEfyR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XVPDkcq2n/WLZ6yomPRY0PIIm6Y28Hu8R8ZEQci4gcc=;
 b=Dr7jRKX8ua8ArYl/wen3IdPOQ7aqO1A+4vFgEm1j9eZTO6VXmWtPMg2h5SK9uKvID3
 QQlCzqZzQyTWH4dX2cY9wnbMuhED+Xg8531zWavbzDmLTFmTuhsgy9FdcVQ7omvyYv/w
 mgkfs0d9MKPpCmXx/H9mtIoU4E1uzWVsOWJVeLfmbqeaORwpCDlerRa8Mbt1IQEYZ/Oj
 M71kmdmoPPP8xDcuhJvWmUk8EvAmRRzNTG7kFefIKmtS4ob6gevXrW8sbLa+wFyZnMjf
 DSsMDm7/BgQ7H0vlq/JTpBsBmrvTpHKn2v8YgBpThe+B8hFFe7mNkyN/hvNvKX9E32Pw
 s4wA==
X-Gm-Message-State: AOAM533/gAwtDOIxNGe2bvqm+/VCuDphZixKZOSUMEzQHNK/HQMVnyup
 3QczFEyl5TvjJ8pCBV8uosPIQC/cjrNBg+b7
X-Google-Smtp-Source: ABdhPJx97sdl4kcW7bRehUfH/XiXkD2IcDwRB9tVOXOFJOdY5FeBe2/eSTnYQq7o3w22v59AjXMb0g==
X-Received: by 2002:a05:651c:1a5:: with SMTP id
 c5mr13715474ljn.172.1608156138231; 
 Wed, 16 Dec 2020 14:02:18 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com.
 [209.85.167.45])
 by smtp.gmail.com with ESMTPSA id g17sm363375lfh.167.2020.12.16.14.02.17
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Dec 2020 14:02:17 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id o19so26651637lfo.1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Dec 2020 14:02:17 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr16006581ljj.220.1608156136686; 
 Wed, 16 Dec 2020 14:02:16 -0800 (PST)
MIME-Version: 1.0
References: <20201214234518.GA14575@willie-the-truck>
 <20201216185352.GA16598@willie-the-truck>
In-Reply-To: <20201216185352.GA16598@willie-the-truck>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 16 Dec 2020 14:02:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
Message-ID: <CAHk-=wijH15u2KfpON3VCECQODAVNJ6DtgQajDaKo+PB_c-L3g@mail.gmail.com>
Subject: Re: [GIT PULL] IOMMU updates for 5.11
To: Will Deacon <will@kernel.org>
Cc: Android Kernel Team <kernel-team@android.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Dec 16, 2020 at 10:54 AM Will Deacon <will@kernel.org> wrote:
>
> I'm hoping to wind down a bit next week (ho ho ho), so I just wanted to
> check whether this had got caught in your spam filters, whether you wanted
> me to change something or whether you're just snowed under in pull requests.

No, it didn't get lost, and I just merged it. It's just that everybody
has been very good about sending their pull request early, so I've had
my hands busy, and I've gone roughly by subsystem (and today got
around to block drivers and iommus etc).

               Linus
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
