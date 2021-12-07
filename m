Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEE0C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 13:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D66B60C11;
	Tue,  7 Dec 2021 13:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pMztwA06Id-C; Tue,  7 Dec 2021 13:59:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2E8660E0B;
	Tue,  7 Dec 2021 13:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD720C001E;
	Tue,  7 Dec 2021 13:59:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66949C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5501560C11
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sbrNfwlSllgB for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 13:59:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3747660E70
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 13:59:13 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id r130so13589589pfc.1
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=9ESUKLBiwLglZ7fAAALXoWV7PZXHvOzhIGDPe6OkebM=;
 b=pnPRLtMTnOq4Uwn8E7r9ZkhDKaI/K0nHH2eo4O61f9z4Gf8UtFzuGHXAShM3qwxd+K
 hXhKUkmb86V9PD5om1THMHzggWzlW46siyiJlIfghm7PnhfeR3G7K/0orRrl46aMQ2rT
 8ErVQAgnvUs6jjRaygo6pGPS+OTAYxsIToGFVLJyGROtIbLQTWAtKaMEMaD+kygm9kZu
 A76K+tIR1a7imbpvYUCM9oTpee2LevEVELMeoFTtdWh4hlgnc+JizU9CVbBbqcIMmW4R
 sMrERlO+uA0FqeLeKtznjev6GKtSLeOAQ4ZKMCw/Eq+XN5uJI9IB1DRWjW2a6gLfniEo
 AmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=9ESUKLBiwLglZ7fAAALXoWV7PZXHvOzhIGDPe6OkebM=;
 b=qXZwgnFWoFsu31ihP+cb2BKVKgUvM7PAV8nI5fbFWWoFP1NnA0NlnO5JMaHB5IwM0A
 ZEn2VJP4S2NJrz0DXe1ENQ3Em1OYoKoiPPulpaN/hdjKdchB0hIh4QZ2+CajrwBQW3nN
 L00Q/zPNQgkRF7LrfZw6wPvl5NBsvjFk8CIgIN9nqllmacXmYzOwxte9UPD2u9VdXUVZ
 NnPnotya/lE6/l99MQyD3QOrIz7wuaVi9MhQkJ2HOYvD6Og/nA/hhPEvbgnD/2XYBtmr
 IIo4gKvIx8WaXxLg8fSQmwrJRQKP/aXwbaBPI6Od+CWAuedfpOAr+r/ZPA1a5S53a4gZ
 xf8w==
X-Gm-Message-State: AOAM530vCUxZW7studwsxjCRf1hxw8ykaGDtCYGJ5vvzegu0O6blHk7r
 904PqisvfUK3+XdKKyextgBIew==
X-Google-Smtp-Source: ABdhPJz2NyQwlIvJG831Y8wH/2/s8eMw0eLvlWUNc1iKHcnNjz05ZlVRgrBC+IQojO6FNU7cn80pEA==
X-Received: by 2002:a63:c003:: with SMTP id h3mr24405268pgg.261.1638885552582; 
 Tue, 07 Dec 2021 05:59:12 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.207.71.6])
 by smtp.gmail.com with ESMTPSA id b18sm16905053pfl.121.2021.12.07.05.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Dec 2021 05:59:11 -0800 (PST)
Date: Tue, 7 Dec 2021 21:59:04 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] perf/smmuv3: Synthesize IIDR from CoreSight ID
 registers
Message-ID: <20211207135904.GH42658@leoy-ThinkPad-X240s>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
 <20211117144844.241072-4-jean-philippe@linaro.org>
 <e60b15db-4e52-b5a6-1b17-203d250f1e65@huawei.com>
 <766ac58a-ffb7-f673-709b-0f0f740f3cfd@arm.com>
 <53f868a8-c7ae-b69d-b061-bb0a7dc98f8a@huawei.com>
 <d60110c4-c179-45d6-512d-3d058caac974@arm.com>
 <20211207132007.GB255238@leoy-ThinkPad-X240s>
 <675bfd78-69ac-608f-1303-e86b90a83f72@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <675bfd78-69ac-608f-1303-e86b90a83f72@arm.com>
Cc: mark.rutland@arm.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, uchida.jun@socionext.com, will@kernel.org,
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

On Tue, Dec 07, 2021 at 01:46:49PM +0000, Robin Murphy wrote:

[...]

> >    [   28.854767] arm-smmu-v3-pmcg arm-smmu-v3-pmcg.15.auto: iidr=0x0
> > 
> > Please confirm if this is expected or not?  I think this might
> > introduce difficulty for John for the PMU event alias patches, which
> > is dependent on a non-zero IIDR.
> 
> Yes, from previous discussions I believe the HiSilicon implementations don't
> have much meaningful ID information at all (hence why we have to match ACPI
> table headers to identify the counter erratum). My trick only works for Arm
> Ltd. implementations since they happen to have the IMP-DEF CoreSight
> registers with the same information as would be in the future IIDR.
> 
> To clarify, the proposal at this point is to write up JSON files for
> MMU-600/MMU-700, based on this patch, in order to pipe-clean the process for
> future SMMUv3.3 PMCG implementations with real IIDRs.
> 
> Whether other implementers might retroactively define "equivalent" IIDR
> values for their existing implementations in a way we could potentially
> quirk in the driver is an orthogonal question.

Agreed, it makes sense that supports the standard IP modules in
the mainline kernel at this stage.

Thanks for explanation.

Leo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
