Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE61C433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF9160EE0
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 15:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5BF9160EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3871340176;
	Tue, 16 Nov 2021 15:42:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jhhjB6YvxgwL; Tue, 16 Nov 2021 15:42:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 00CD24010B;
	Tue, 16 Nov 2021 15:42:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2715C001E;
	Tue, 16 Nov 2021 15:42:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81388C0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DA71403C5
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bY2LjmhMs0eV for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 15:42:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 867A540224
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 15:42:55 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id a9so12231144wrr.8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 07:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=73W+eAVWIQvhx1y8meb9GkMNaweSrLQquuQCwdCLdlM=;
 b=tTBwR2mJVmrbw05vqMoeWpcPdynH5H7MFpf8U/8M6xAuOKKys74i66yvqrb7RY9j0c
 IF7HThF8ogn4WMAQ2xF+1XUR3nF9pRF3mx0z2644qRJ7JqOfW6pNG37Q9MmrhI64L7/1
 5nOS7Oai+JmTOPLteY90Q5vXTUc4E5uPgv8E4k2vUNWeZsmPs0teGgIiDewfWs5w4at1
 9n/BphIsJYboNZAdn4C2ib8Iq2I9IsT8rcjRiAnWuP9K2N878bsWMD0CHAaOBnNdWTa+
 gIcE9MJLWh1bZas0FX7UDx98TnKHEubMHnpcccJbOTSC1wZCrqjXVnETxhBquCaynfdY
 zQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=73W+eAVWIQvhx1y8meb9GkMNaweSrLQquuQCwdCLdlM=;
 b=swbka26+U8eWNAaoP62vpk6urPlKtRRvypdWh/dJ9blSMfyfgf7jW4z3g7mtc4Hpg5
 LpxwZkH/gAeldiXAs5SWo9C326IDqwQOcKRRz8tXH5cCFICPJcX5MohvLzydgAh1dLFf
 rdZ2eaS+oTLac0j4PUj9HszRW0YBxXvzC4UuEnoj8LQ1T20uAopNG6L/uliHTd6nw5hx
 aAatrKAd30wZjmvmBQKbnn9FlT0ypz/V+T23d+i+yXz4jht8G8FmB6kMKOivXTo0jviF
 wsmd2gb5CoYyVVuSo0nwAE4qzurbFDRAL2x414pcE14xoUdWx/a/RShPspGgZZtTXQKS
 Gg7w==
X-Gm-Message-State: AOAM532FEYbAFP4IhlKUSCJhBW+IjWKW94awSk75HT0vv/KL1O2Ag0IX
 KfH++uo4Ifv+0GEfg0zVjIldTg==
X-Google-Smtp-Source: ABdhPJyKqFpr5MW3WSKHEzdeBo0mZSQini6a3jugtcFq28ioUcWTEOtVBpkQKMt1YvUY/9Jb3SJZlw==
X-Received: by 2002:a05:6000:1201:: with SMTP id
 e1mr10350062wrx.298.1637077373724; 
 Tue, 16 Nov 2021 07:42:53 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id p14sm2742034wms.29.2021.11.16.07.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 07:42:53 -0800 (PST)
Date: Tue, 16 Nov 2021 15:42:32 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 2/2] perf/smmuv3: Add devicetree support
Message-ID: <YZPRaKqfWMJcqaC0@myrica>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <20211116113536.69758-3-jean-philippe@linaro.org>
 <0f410098-2a58-9024-9fe4-77fb54b2a076@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0f410098-2a58-9024-9fe4-77fb54b2a076@huawei.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, will@kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, uchida.jun@socionext.com,
 leo.yan@linaro.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Tue, Nov 16, 2021 at 12:06:36PM +0000, John Garry wrote:
> On 16/11/2021 11:35, Jean-Philippe Brucker wrote:
> > Add device-tree support to the SMMUv3 PMCG.  One small cosmetic change
> > while factoring the option mask printout: don't display it when zero, it
> > only contains one erratum at the moment.
> > 
> > Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/perf/arm_smmuv3_pmu.c | 25 +++++++++++++++++++++++--
> >   1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> > index 226348822ab3..958325ac103a 100644
> > --- a/drivers/perf/arm_smmuv3_pmu.c
> > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > @@ -47,6 +47,7 @@
> >   #include <linux/kernel.h>
> >   #include <linux/list.h>
> >   #include <linux/msi.h>
> > +#include <linux/of.h>
> >   #include <linux/perf_event.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/smp.h>
> > @@ -750,8 +751,15 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
> >   		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
> >   		break;
> >   	}
> > +}
> > +
> > +static void smmu_pmu_get_of_options(struct smmu_pmu *smmu_pmu)
> > +{
> > +	struct device_node *node = smmu_pmu->dev->of_node;
> > -	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
> > +	if (of_device_is_compatible(node, "hisilicon,smmu-v3-pmcg-hip08"))
> 
> I don't think that this is necessary. We don't support DT for hip08, nor
> have any plans to. Incidentally, was this binding missing in your series?

Ok I'll drop this (and the compatible value from patch 1)

Thanks,
Jean

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
