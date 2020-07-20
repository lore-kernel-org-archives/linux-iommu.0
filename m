Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A100FC433ED
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646A022CB3
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTsf2Eu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646A022CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2199685C3B;
	Mon, 20 Jul 2020 15:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OB5JJivXdRWQ; Mon, 20 Jul 2020 15:39:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E8CBD854E3;
	Mon, 20 Jul 2020 15:39:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB43FC089F;
	Mon, 20 Jul 2020 15:39:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9F0C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:39:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AD0DA85BF2
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:39:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQdCeKIm_GKp for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 15:39:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC6C785B80
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 15:39:18 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id d18so13106023edv.6
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=O1m2EB0FT01ShtO2OJYn83yl6fCn52T14VBuz91LAgY=;
 b=gTsf2Eu9v/AafVNzi8ISPXGS0FQo13KbdhYVlAJnIirPGLFMl1wNXN7duONqOpEnuO
 gC8PikvMwSRdHZ3vjv6yjp2OXj5qXh+QQeht092lrBxZnf3Zue4XKi4/9OXtgTak601Q
 EHbsYozyYp6MgFlFZ2NplcgmGvsJSrTfqeioTi87P40imTRwdBB5+EZ9+HFQgCTZP+TK
 8z9JL0GLMRIuFioi/oYqFiuLmqSsGKLIXUUvtGIRTVvM0bINkFuNBLSrtw5JPk2YH0DK
 X0lJwvz9AqruBCURNDeSl+f3hY0ODUbghng3qJXPq5XHKxWqTLmBn1J16hd1QiI/l9vM
 Zk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O1m2EB0FT01ShtO2OJYn83yl6fCn52T14VBuz91LAgY=;
 b=Fa6ELdCrXFXovsLzSMVO2TjGULuja3hoz/88FeOlaFZlMF5prS7tt6KaMiCuZsL1GL
 2zPwwyodmyhl0r/lda+tYFWd7xDdAbn4bHwlXoWkQWSpuAbYBueJIKOMC5dooZq3XrVs
 NBX5p13417nWxFd0QSvh75/FS9zLyPSTnn6VtCKXh+rmv+mdhgMxTAJp5+Bnalou/uoY
 Gs4Fcj6GAjI2wHbU+dNHDV0Q/DlvMHq0iAJqWSnyNVIHSWiQeAjgkNfZwqUNbKLmUt21
 o/I7f8Kd8Ssmfsu2f+vlL/UJdjglHpQYngQi3gKQpV5qzfABWQyyKNMKO78uVOoQe5sa
 yTyA==
X-Gm-Message-State: AOAM5300vpA8Cwisgf/EN0KNSWXjyGvu9v8WDbgPWju8dZtQBDyl3N/J
 kszyiYi2qk6dojseUDuqItkw4w==
X-Google-Smtp-Source: ABdhPJzlqzOX/v1sKgRJpL3kwuSO3RJqWfM8YDYvHQ2Ix65qY4Cg2pVEcPglA2Qw4qvDhW3c/p8OzA==
X-Received: by 2002:a50:e047:: with SMTP id g7mr21320084edl.290.1595259557047; 
 Mon, 20 Jul 2020 08:39:17 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j21sm15654882edq.20.2020.07.20.08.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 08:39:16 -0700 (PDT)
Date: Mon, 20 Jul 2020 17:39:03 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v8 00/12] iommu: Shared Virtual Addressing for SMMUv3 (PT
 sharing part)
Message-ID: <20200720153903.GA328334@myrica>
References: <20200618155125.1548969-1-jean-philippe@linaro.org>
 <20200720111116.GE11516@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720111116.GE11516@willie-the-truck>
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, zhengxiang9@huawei.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, Jul 20, 2020 at 12:11:17PM +0100, Will Deacon wrote:
> On Thu, Jun 18, 2020 at 05:51:13PM +0200, Jean-Philippe Brucker wrote:
> > Since v7 [1], I split the series into three parts to ease review. This
> > first one adds page table sharing to the SMMUv3 driver. The second one
> > adds support for I/O page faults through PRI and Stall, and the last one
> > adds additional and optional features (DVM, VHE and HTTU). SVA needs the
> > three parts to work. No significant change apart from that, I just
> > addressed the previous comments.
> > 
> > I'd rather everything went through the IOMMU tree but I'm assuming patch
> > 1 will also go through the x86 tree as part of [2]. It is definitely
> > required by patch 3 which is required by patch 11. I don't know how this
> > kind of conflict is usually resolved, but if it's a problem I could
> > further shrink the series to only patches 4-10 this cycle.
> 
> Modulo my review comments, I think most of this looks alright from the SMMU
> side. However, I would really like it if the SVA driver parts could be moved
> into a separate file (e.g. arm-smmu-v3-sva.c), with a separate config option
> (dependent on the current one, so you can easily build a driver without SVA
> support). Does that sound remotely feasible?

Yes it makes sense. It requires moving some definitions from arm-smmu-v3.c
to a .h but should be straightforward, I'll give it a try.

Thanks,
Jean

> If so, I think it would really
> help in terms of maintainability, since the SVA model is really all about
> the mm, whereas the driver model is all about the device. This makes it
> really hard to read when you have to keep working out whether the current
> 'handle' is an mm_struct or an arm_smmu_device.
> 
> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
