Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91795C4320E
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 12:52:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9D9610CE
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 12:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A9D9610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E993C42589;
	Thu,  2 Sep 2021 12:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S6BheUWBDsbv; Thu,  2 Sep 2021 12:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 80D7C42584;
	Thu,  2 Sep 2021 12:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624EDC001A;
	Thu,  2 Sep 2021 12:52:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6CE0C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 12:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFDF340707
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 12:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q87BzNBBBPg6 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 12:51:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A7267406EC
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 12:51:55 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id h9so4100612ejs.4
 for <iommu@lists.linux-foundation.org>; Thu, 02 Sep 2021 05:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=oBtvw9RLZz5FiMU8tP1KGG7ayEexwXszGesiGUpyM7c=;
 b=CZV3QxQDYOZ4sA6RDYakDFAaxGnXwXVMjsjFysxH8aP03rp+JlkXUPc7WgK8FGpX/L
 SXGuMEp+ppKVLvddgbBX0ixeNJqxg4VSqP1TDRDBjvPQ5VKMCmLqqkl9AJZfBi3l5/7x
 FRcUlQdxgFS5T4X7fWcunJi/PnebZvrR12cgPxE/DLA+M3YhxO/lbDEoOyp+g2/LW1Jx
 DX6pC3l7XJYiWPp1IXI/Ac9M+08dGoMbdF+te/nB3LOheviQx5PNuf1FxfHa01E+xToK
 SritC5zqmjTg3cZs8yl/SSYVerMp9pqN7lPtFv7U2XR7zP4a0R1mkgHfAJGHK1UQZ/42
 rIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=oBtvw9RLZz5FiMU8tP1KGG7ayEexwXszGesiGUpyM7c=;
 b=kd4/ica5ufMYWNYlEIijoc2bctY9j8eCAatUHOJ3B0hkV4WFjz8ODpPa7SfFj6nK3b
 ClaZboR299r4YyPLGIZDCalLB1iFrFPL3UF5UgXyjQxUVal64Yx2SS1Fogyu1t1FFXOW
 WkJ/PLyd5BPyfY3PwOqvbJhqCKIYRURbdAmr1+39FH1bjNS54yPSUFcvzKHtk9Iy7JOF
 38rGvw8K3HzhGMYUuicFCR3Q6dMB/HBjkGUv4FdNgnRn9AgM78OXFQLSKWRZqri5Lij9
 AZe8c3xBffbgkskTxkacNYanwGOnbHmnD4couQt/yvO8YjCuS9kfJ1BBUH6Vh5wT36h6
 gnmQ==
X-Gm-Message-State: AOAM530LgguP0wiE9cCt25hoQ4mELQ2QgP0WkyAyGM9uIF1qO+AnwzEE
 wuGDJLh43W2hjWOHxWghojtduwcofgeUFiabVRa3WA==
X-Google-Smtp-Source: ABdhPJygSZC8fluO7Inqdaqw8JmKePWM0x239rNniJ2NKvF8HoUFS95pa4d4JBGyUMUeWRE3aBaYUS/L2g/2y3bv5Us=
X-Received: by 2002:a17:906:3a57:: with SMTP id
 a23mr3646914ejf.469.1630587113883; 
 Thu, 02 Sep 2021 05:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
 <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
 <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
 <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
In-Reply-To: <f3087045-1f0e-aa1a-d3f7-9e88bccca925@arm.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 2 Sep 2021 14:51:43 +0200
Message-ID: <CADYN=9JWU3CMLzMEcD5MSQGnaLyDRSKc5SofBFHUax6YuTRaJA@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI
 devices
To: Robin Murphy <robin.murphy@arm.com>
Cc: xieyingtai@huawei.com, Rob Herring <robh@kernel.org>,
 Wang Xingang <wangxingang5@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 helgaas@kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-pci@vger.kernel.org, Will Deacon <will@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

On Wed, 1 Sept 2021 at 11:58, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-09-01 09:59, Marek Szyprowski wrote:
> > On 21.05.2021 05:03, Wang Xingang wrote:
> >> From: Xingang Wang <wangxingang5@huawei.com>
> >>
> >> When booting with devicetree, the pci_request_acs() is called after the
> >> enumeration and initialization of PCI devices, thus the ACS is not
> >> enabled. And ACS should be enabled when IOMMU is detected for the
> >> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> >> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> >> devices.
> >>
> >> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> >> configuring IOMMU linkage")
> >> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> >
> > This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix
> > pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI
> > operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It

We've seen this on ARM Juno R2 boards too in the Linaro testfarm.

The problem is that the device can't get the "SATA link up" while booting.

see https://lkft.validation.linaro.org/scheduler/job/3416767#L577

When reverting this patch we are able to see the "SATA link up".

Cheers,
Anders
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
