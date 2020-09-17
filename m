Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB0FC43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:36:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A9E2223C
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 14:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZT6Vo0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A9E2223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38FF38752C;
	Thu, 17 Sep 2020 14:36:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wr0FdIHtdJv8; Thu, 17 Sep 2020 14:36:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A131B86CE6;
	Thu, 17 Sep 2020 14:36:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B2F6C0864;
	Thu, 17 Sep 2020 14:36:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 782F4C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 71EC88742D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:36:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uR8SAyvzcNUI for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 14:36:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E3BBC86CE6
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 14:36:44 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id w2so2213107wmi.1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=P7D4WnMwHuKlW/InpS80Px6tyIzBCn9GHqjz7XEWep0=;
 b=zZT6Vo0gdloLV2r5IAtGKlETaaV+YgxDw9RyN+D3sUyexDDrU5FBQlOTyJBSZk62cG
 AIbrxpOp7ZqubviXA4KrQdN+XGWabRnTHlOi3gvdC+SA6WTUPWgeZ8dme7DtX83tUMDV
 suxxZFDGLP2yTdahmcScSrAeeRWMcsSGmY+qJNG/JFpj7rC7KGJc9/9SIKlzkYMzLLYq
 rHYTScBevMdJLOO1ImQEQi5ohC32woVvI3UWFBTfSPqT+hmrF6Hby+vKnGHSVMDXBDeY
 EPyYEXdlTbvvhMy8bqg6m6HszKsI2UGR/1oMpezhitpXmdo6GEGTyOzmNqP3Nd1y/NvG
 FSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P7D4WnMwHuKlW/InpS80Px6tyIzBCn9GHqjz7XEWep0=;
 b=FCuqp4LdSBBtyRTx4Oo9o6BXF8ol/Kit24xEGTyH8NkBitVcltvnMgTNwMi7y8Il5h
 gTcyR2PZCgpBUwE6MrsRELfWbR+ib72/qzm2hSKSFVZfOUcuXMfTqo38HQOZ13CBREWf
 HZtS69HuIERcrmL2lbOgwEwiRi3eZQBa7ble3NBaMWwHiVguvijynmBZFGOoEKfZ1NAz
 BJxx3RMbRpWHMf1ItRQmjTvzv90WE4IrOccqNNQwHJUWrJmsiAMnusFC221G6qjC1oPX
 K+m93UCkR4AiRWu7aJxFogZZZoeafNMIacK52et9N816TWODL0Lu/tyfr9eV/FxUGFsF
 ut2A==
X-Gm-Message-State: AOAM530Ebbn3B+ZCPisU2AEDxSVXMDR9/jKLS1bEzX0oInnehFPMmxIX
 sLTncrCUoLDZM51mlG95H3Udmg==
X-Google-Smtp-Source: ABdhPJxyoiJTqpc7tnmXVquEaTxl+PIgKAx6mPlN9FFI14FWqFSbDdGzfvgaLatcx8NxLUkS/15c4g==
X-Received: by 2002:a1c:3d06:: with SMTP id k6mr10279412wma.27.1600353403359; 
 Thu, 17 Sep 2020 07:36:43 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c205sm11178054wmd.33.2020.09.17.07.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 07:36:42 -0700 (PDT)
Date: Thu, 17 Sep 2020 16:36:23 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RESEND v9 00/13] iommu: Shared Virtual Addressing for
 SMMUv3 (PT sharing part)
Message-ID: <20200917143623.GA134903@myrica>
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200904090834.GG6714@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904090834.GG6714@8bytes.org>
Cc: fenghua.yu@intel.com, robin.murphy@arm.com, zhengxiang9@huawei.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, catalin.marinas@arm.com,
 zhangfei.gao@linaro.org, will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 04, 2020 at 11:08:34AM +0200, Joerg Roedel wrote:
> On Mon, Aug 17, 2020 at 07:15:46PM +0200, Jean-Philippe Brucker wrote:
> > Jean-Philippe Brucker (12):
> >   iommu/ioasid: Add ioasid references
> >   iommu/sva: Add PASID helpers
> >   arm64: mm: Pin down ASIDs for sharing mm with devices
> >   iommu/io-pgtable-arm: Move some definitions to a header
> >   arm64: cpufeature: Export symbol read_sanitised_ftr_reg()
> >   iommu/arm-smmu-v3: Move definitions to a header
> >   iommu/arm-smmu-v3: Share process page tables
> >   iommu/arm-smmu-v3: Seize private ASID
> >   iommu/arm-smmu-v3: Check for SVA features
> >   iommu/arm-smmu-v3: Add SVA device feature
> >   iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()
> >   iommu/arm-smmu-v3: Hook up ATC invalidation to mm ops
> 
> Looks like the mm parts still need Acks/Reviews?
> 

Yes, I was hoping that the original [1] would get an ack or review.
Hopefully it will get picked up for 5.10, but I'll also Cc the mm list in
my v10.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/1600187413-163670-8-git-send-email-fenghua.yu@intel.com/T/#u
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
