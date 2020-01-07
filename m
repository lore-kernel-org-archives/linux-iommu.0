Return-Path: <SRS0=zmEc=24=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C72C33C8C
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 14:00:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5562072A
	for <iommu@archiver.kernel.org>; Tue,  7 Jan 2020 14:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="OwKjuKYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5562072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DF815857CB;
	Tue,  7 Jan 2020 14:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GKvu9U6vDUvt; Tue,  7 Jan 2020 14:00:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5FDA1838B8;
	Tue,  7 Jan 2020 14:00:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 309A6C1796;
	Tue,  7 Jan 2020 14:00:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11C0AC0881
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 14:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id F0DD12037B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 14:00:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fAVYk2I2M1Uc for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jan 2020 14:00:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from onstation.org (onstation.org [52.200.56.107])
 by silver.osuosl.org (Postfix) with ESMTPS id B191D20366
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jan 2020 14:00:15 +0000 (UTC)
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net
 [98.239.145.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id 640D53EE6F;
 Tue,  7 Jan 2020 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
 s=default; t=1578405614;
 bh=F6/bC3WaEdJIW6MX3Lz//wft6IJlpoSxsTV7q3G+ET0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OwKjuKYc5PBpQN6DascPHMtS70Wop9JG59kZqpgakYCOjrEbYgMMrxTUlcKPbz0Fm
 hTn4Idz97xS9Yb5Q/3v/HskYI0L4VttgS6RrDIxSVXNCeoCiWHDYMr+EYD1xR/+x0d
 k4qZI6kJ6yZguJHqmedjvPx9S76EAU6roaqNetnc=
Date: Tue, 7 Jan 2020 09:00:14 -0500
From: Brian Masney <masneyb@onstation.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/qcom: fix NULL pointer dereference during probe
 deferral
Message-ID: <20200107140013.GA9084@onstation.org>
References: <20200101033949.755-1-masneyb@onstation.org>
 <20200107132530.GC30750@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200107132530.GC30750@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
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

On Tue, Jan 07, 2020 at 02:25:30PM +0100, Joerg Roedel wrote:
> On Tue, Dec 31, 2019 at 10:39:49PM -0500, Brian Masney wrote:
> >  drivers/iommu/qcom_iommu.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Shortened commit-message a bit and applied for v5.5, thanks.

You might want to hold off on applying this since it looks like Robin
Murphy has a better fix.

https://lore.kernel.org/lkml/fc055443-8716-4a0e-b4d5-311517d71ea0@arm.com/

Brian

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
