Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E7C56202
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:58:28 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6962145D
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VI+Wqvwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6962145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2DA4F233A6;
	Tue, 24 Nov 2020 23:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VsFE0gz4JZO9; Tue, 24 Nov 2020 23:58:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0998D22844;
	Tue, 24 Nov 2020 23:58:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E25B8C163C;
	Tue, 24 Nov 2020 23:58:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C532C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 82B2886A63
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:58:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xtLypi8xgrHP for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 23:58:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from nat-hk.nvidia.com (nat-hk.nvidia.com [203.18.50.4])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9379A86A5E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:58:23 +0000 (UTC)
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fbd9e1c0000>; Wed, 25 Nov 2020 07:58:20 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 23:58:06 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 24 Nov 2020 23:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaPy94/hVVeVEiA++QmvDG3pqgfYe8SjycrTfyi27VLc/pLowc4La/rH9cvX59ORC5ZEyiA9MvbAAPwQwdON9W4s98RfuZrKi47ghHCH0Ma7Etj1QiRDqtDLiFacj2MbARNAsbURb95V6twLOry8Xw3pqm64HKflNYp+VSk+mZ623oJUyCBSU3Zqd9mr8MPHEOtt8AanrrvF0+VeNeASnH+Z//Ho0DLNqaaXR/VWG/devG6CjwCQhIZO9uInpb7h/kbuBT0Uswa63sTb4e7w4Yh0KUBap0/xndl+bGixUmt4aaSBKczBlM/cOY53dHnRnuvA15WwuRtQ4yORY/zQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNXCWd37DiW4O/BysPyDbRzRNxU//BonL8Lxaa+WvVM=;
 b=j+519wigVVHD66hkflTl+DUnuca7uG8jU7rRVfcfmwhUjqOtYMFQP1Qz7PV7dAiAvNrW945YYQ8bSY3yfEHo2oPDRnWf1w/231ZmhmlQmx2IvjocSpQ8s0N3PrdvioDzyQODqfFyjj2YJziwRQayssY2csPtfupXtgf0c0UEY1YJiYrntreNGS7eHMwqI19V97FOyXvWE28KYBhS0vf7TWuH+v/I1IehS0NApoX1kAcWCDVUHxUXscBcPE5q5bw+P/+b3bZYy8Scx7kxmeZRRw7Jx1gBwwz2CfTAJc6mArwI6rfAP0sjjAgY6X4qWFzSAM9PZXEtD+EqonZZMqBhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Tue, 24 Nov
 2020 23:58:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 23:58:03 +0000
Date: Tue, 24 Nov 2020 19:58:00 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 12/13] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20201124235800.GA242277@nvidia.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-13-jean-philippe@linaro.org>
Content-Disposition: inline
In-Reply-To: <20200918101852.582559-13-jean-philippe@linaro.org>
X-ClientProxiedBy: BL1PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 BL1PR13CA0099.namprd13.prod.outlook.com (2603:10b6:208:2b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Tue, 24 Nov 2020 23:58:01 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1khiC8-00112r-Qu; Tue, 24 Nov 2020 19:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606262300; bh=KNXCWd37DiW4O/BysPyDbRzRNxU//BonL8Lxaa+WvVM=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=VI+WqvwpH7YzDvHJNUIhoSRGBymy7u7GbbVsf4hscr3+KjRd2ZasNTWb8WZQUR0Ym
 OYHqUUm170aFIZGL01pq0jMYWkHGc6CCNR89KVNdkaKfnyurg28uEipI2uaAaE1VWu
 EjuX4pMbqgGmOB5Llkv3DYepROyKUESQivy8DMzoEwEFEjMAai4EnEvkCpT8i/6n60
 Ego/s4pfq+rsmtL1+BZ83LcvIp3GqvwUn+Lb57PksBTLGdPBKmuKIytm+wS5aNFpNb
 AjP6onUHMoUeeseUUEKfxS7JjNb4P9k9B/K9oJTXm7/DW9KJ/0toRaCn7tiwuOCPDN
 wcDAEaolxTibg==
Cc: fenghua.yu@intel.com, catalin.marinas@arm.com, robin.murphy@arm.com,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org, zhangfei.gao@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 18, 2020 at 12:18:52PM +0200, Jean-Philippe Brucker wrote:

> +/* Allocate or get existing MMU notifier for this {domain, mm} pair */
> +static struct arm_smmu_mmu_notifier *
> +arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
> +			  struct mm_struct *mm)
> +{
> +	int ret;
> +	struct arm_smmu_ctx_desc *cd;
> +	struct arm_smmu_mmu_notifier *smmu_mn;
> +
> +	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
> +		if (smmu_mn->mn.mm == mm) {
> +			refcount_inc(&smmu_mn->refs);
> +			return smmu_mn;
> +		}
> +	}
> +
> +	cd = arm_smmu_alloc_shared_cd(mm);
> +	if (IS_ERR(cd))
> +		return ERR_CAST(cd);
> +
> +	smmu_mn = kzalloc(sizeof(*smmu_mn), GFP_KERNEL);
> +	if (!smmu_mn) {
> +		ret = -ENOMEM;
> +		goto err_free_cd;
> +	}
> +
> +	refcount_set(&smmu_mn->refs, 1);
> +	smmu_mn->cd = cd;
> +	smmu_mn->domain = smmu_domain;
> +	smmu_mn->mn.ops = &arm_smmu_mmu_notifier_ops;
> +
> +	ret = mmu_notifier_register(&smmu_mn->mn, mm);
> +	if (ret) {
> +		kfree(smmu_mn);
> +		goto err_free_cd;
> +	}

I suppose this hasn't been applied yet, but someone asked me to look
at this series..

Why did you drop the change to mmu_notifier_get here? I'm strongly
trying to discourage static lists matching mm's like smmu_mn is
doing. This is handled by the core code, don't open code it..

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
