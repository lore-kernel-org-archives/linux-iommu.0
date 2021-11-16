Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3CC433F5
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5C560F38
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A5C560F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCD7E4042D;
	Tue, 16 Nov 2021 15:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAsEUgcTCc9l; Tue, 16 Nov 2021 15:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CDA594044A;
	Tue, 16 Nov 2021 15:42:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92CAEC001E;
	Tue, 16 Nov 2021 15:42:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C7CC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70CE1606ED
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:42:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0InAxankkKZT for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 15:42:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C3A5607EA
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:42:28 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id t5so4204735edd.0
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=O6sbtn5xvEBNaOtn9UEFFKe+g7L6F0RYzfYTzDVMF/I=;
 b=eynKHH0QO52xWjqQj6zrLoZm4ne3qN6aPkoTwvfBmLf1pr+gN5PTFe0ZpIhs7trXsb
 VIRQf5PFhG4ylLXFO+F5NADxLSlh8zZUYIftK4zfmYQ+FuLfvfLGkmPd7bBIA3ptmxSs
 vEX/J9mh5TBHuw7EznlL46fXe3JhT1PW1Oz7czW7O8jyDO+km6g04eb1asxwOCh0YQBh
 /V8rgoUFfN3FEqjPtmj+MOM4OcVXl3nX6JMUb1gPH51N+cflV74s2RiDTN06CKqjzUGF
 O2lZmiYL1xWw/1NugBNnlbDenbgP6jVEPaRsWaFCmeOV5PNXi2ntm6GEyx1IxOtYUoKj
 bhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O6sbtn5xvEBNaOtn9UEFFKe+g7L6F0RYzfYTzDVMF/I=;
 b=wjQdhn4Uqt+7muzSboc6lk2GLH72AuGj4PvFroroWil2LNgVfJp9w3N1hPqIaUWn8s
 BT8XCleONJ+OMZ8eS6Xuip/JuX6FT8Jkp4DWWbh+EaqpIaOGy3ZPnpZgI5sRsxEQbZz3
 Vv476qurbUyf9DT5wlkPq1z41CXiWSEnVH7IApJzgq8QVlaAeDRtdBBR0DDIaXjtYIr3
 VDgZ6iiIvemQPSH09qFQrFs2H9LB0ETXUcKaVlSc2lyh1O1RQup+pNrh/FvVppxKSdr4
 ujji/591jKEdcEmjZ/I6yhOHROC8u3qhkESvO46FqVLuPiGtDatgRN3fdOm6pIwQYjo5
 Un5g==
X-Gm-Message-State: AOAM5303KELA2UxOThIpErA29/ChJdBAdXg9BJ6LW2Dvh+ZdKdCQrTdk
 EucG/A7Lg/Fe/ALFToaHRjPOaQ==
X-Google-Smtp-Source: ABdhPJx0eQ+PslF4hYTTpI2Xpbj5O8GvvC/hQB20eDbfaRVoh8niF5Qt3h1b6H5RW7O+XXP7v5RzyQ==
X-Received: by 2002:a17:906:fcb0:: with SMTP id
 qw16mr10483926ejb.495.1637077346511; 
 Tue, 16 Nov 2021 07:42:26 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id bo20sm9763810edb.31.2021.11.16.07.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 07:42:26 -0800 (PST)
Date: Tue, 16 Nov 2021 15:42:05 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/2] perf/smmuv3: Support devicetree
Message-ID: <YZPRTUis+G279XIO@myrica>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <3b5cb536-5a11-5096-4369-cec3d369ec52@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b5cb536-5a11-5096-4369-cec3d369ec52@arm.com>
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

On Tue, Nov 16, 2021 at 12:02:47PM +0000, Robin Murphy wrote:
> On 2021-11-16 11:35, Jean-Philippe Brucker wrote:
> > Add devicetree binding for the SMMUv3 PMU, called Performance Monitoring
> > Counter Group (PMCG) in the spec. Each SMMUv3 implementation can have
> > multiple independent PMCGs, for example one for the Translation Control
> > Unit (TCU) and one per Translation Buffer Unit (TBU).
> > 
> > I previously sent the binding as reply to Jay Chen's thread implementing
> > device tree support [1]. This posting addresses the comments from that
> > thread.
> 
> Ha, I'd also resurrected this and was planning to post it at some point this
> week[0] - you should have said :)

Ah sorry about that, I just resent because there was some demand for it at
Linaro

> > Patch 1 adds two compatible strings. "arm,smmu-v3-pmcg" is common to all
> > PMCGs. "hisilicon,smmu-v3-pmcg-hip08" allows to support the same quirk
> > as IORT for that implementation (see patch 2). We'll probably want to
> > also introduce compatible strings for each implementation that has
> > additional perf events. For example the MMU-600 implementation has
> > different events for TCU and TBU PMCGs [2], but both components have the
> > same device IDs. So the driver could differentiate them if they had two
> > distinct compatible strings such as "arm,mmu-600-pmcg-tbu" and
> > "arm,mmu-600-pmcg-tcu".
> 
> Actually it only needs a general MMU-600 compatible, since once you know
> it's an Arm Ltd. implementation, you can assume the pattern for the IMP_DEF
> ID registers to figure out the rest.

It might be an error in the MMU-600 spec specifically, both TBU and TCU
PMU registers have a 0x83 PIDR0, where I think the TBU should be 0x84 (the
revC model uses that value). It's possible that the implementation
actually has 0x84 instead.

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
