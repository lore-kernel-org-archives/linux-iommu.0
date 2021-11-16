Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76E8C433FE
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 17:21:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D41A61ABA
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 17:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D41A61ABA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4565B60674;
	Tue, 16 Nov 2021 17:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a_NS51Fje79C; Tue, 16 Nov 2021 17:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2D2A76066D;
	Tue, 16 Nov 2021 17:21:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 044EBC001E;
	Tue, 16 Nov 2021 17:21:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BEB54C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 17:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E547403C5
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 17:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UDUjPM0hFSW3 for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 17:20:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D04940224
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 17:20:57 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id w1so91288241edd.10
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 09:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Y7/ymhGPjLSJyJ+YNwQEo5utnlZQVkYRG4UA4vbBNwE=;
 b=Z6E7Zuy9PVFwXGePFb9KxhGg+daLtMwLGjckBQ7b2vySbEEd1DJ0lUYC6pLSnm7zSy
 kXaweByb8FcJBWyKrE0jB3m51ljQqHMdGCk7ZkQqVUt+khzHBmkhOhYe1GeFo2W6Nsso
 vazqnh/kK2bGZ911xdksNeaXzz4+eRLENNElhVi8yJ2J5xEZwstLoQikqgkyc4PHcOjs
 XhCdev6ycGAfTq4vNwHJOk+sXDN1s+oVbuSatxxkOwnnFrHnGr8o0dVBJWdYc+XtttBs
 NI6LHtNi5BKXpHXhsMPWOn1q/Bomz5sn42rCzH5vIJIZ7JDKmxvWD/Nouai7ne9MAmAZ
 Va+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y7/ymhGPjLSJyJ+YNwQEo5utnlZQVkYRG4UA4vbBNwE=;
 b=BkFIyKG0K4B5UJZwgkZHU3ExLBwg26mFdO7Vy4Ftfc06LI8FZQ/lf4CeOgW0wHytch
 2Yyj2GHsk7IQP/bSf08HKq0hURYW5YQytYCu8TaX/5dk8ZJKE1nRxUuQEaODX1GhQzyp
 iwz1GC2CT6dvHYokUMXrFKMY/pMzcio+ff008urxVhM7dnK41LglBg3MNVK1aKvZEG8o
 mPSl1VSYqhB32RUgNJCI4hCl39oZQYs+PfWZSWicLmNM4wIms1idBYwGxJLUEesNzn5p
 sPjY1BUcLyUH7q4Z6L5A7JfFAuLkzMi/bdaY2KIPvFeK8N98lRFqhc95uZfay64Q56Hs
 veJA==
X-Gm-Message-State: AOAM532+u8BFiMnAB26o5VmdykqHOwaUwxjyGXgrlEr213rL++stFEhv
 CV7CT3P9uWdpMJ0B+te5mUanxQ==
X-Google-Smtp-Source: ABdhPJysrk4hn2MXFU1z+7fNFOPzdwH3NRQbppL+rDRVzDdxxgEucQ2rht9F4+xHJqZt9Jy1xcVSqg==
X-Received: by 2002:a17:907:629b:: with SMTP id
 nd27mr12055773ejc.24.1637083255412; 
 Tue, 16 Nov 2021 09:20:55 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j3sm8344871ejo.2.2021.11.16.09.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 09:20:54 -0800 (PST)
Date: Tue, 16 Nov 2021 17:20:33 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] perf/smmuv3: Support devicetree
Message-ID: <YZPoYSIU/hBYgt3m@myrica>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <3b5cb536-5a11-5096-4369-cec3d369ec52@arm.com>
 <YZPRTUis+G279XIO@myrica>
 <54be6173-59d3-7ce8-e04b-b5197fdc0e10@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54be6173-59d3-7ce8-e04b-b5197fdc0e10@arm.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, uchida.jun@socionext.com,
 leo.yan@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 16, 2021 at 05:00:14PM +0000, Robin Murphy wrote:
> On 2021-11-16 15:42, Jean-Philippe Brucker wrote:
> > On Tue, Nov 16, 2021 at 12:02:47PM +0000, Robin Murphy wrote:
> > > On 2021-11-16 11:35, Jean-Philippe Brucker wrote:
> > > > Add devicetree binding for the SMMUv3 PMU, called Performance Monitoring
> > > > Counter Group (PMCG) in the spec. Each SMMUv3 implementation can have
> > > > multiple independent PMCGs, for example one for the Translation Control
> > > > Unit (TCU) and one per Translation Buffer Unit (TBU).
> > > > 
> > > > I previously sent the binding as reply to Jay Chen's thread implementing
> > > > device tree support [1]. This posting addresses the comments from that
> > > > thread.
> > > 
> > > Ha, I'd also resurrected this and was planning to post it at some point this
> > > week[0] - you should have said :)
> > 
> > Ah sorry about that, I just resent because there was some demand for it at
> > Linaro
> 
> Heh, no worries - it's not like you were even CC'ed on the thread where I
> only mentioned I *might* do it.
> 
> Can I get away with being cheeky and just saying that my review comments are
> the diff between my branch and yours, I wonder...

Sure, that works for me, I'll send a v2 this week or so

Thanks,
Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
