Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F27C47420
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 11:13:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49BF239E5
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 11:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49BF239E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5811820422;
	Thu, 24 Sep 2020 11:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d2b4JW-Z97dd; Thu, 24 Sep 2020 11:13:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D554320364;
	Thu, 24 Sep 2020 11:13:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F25CC0859;
	Thu, 24 Sep 2020 11:13:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26FB5C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 11:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 157AA86A0F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 11:13:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id noCZEDIM+khE for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 11:13:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ED500869A9
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 11:13:27 +0000 (UTC)
Received: from lhreml713-chm.china.huawei.com (unknown [172.18.7.107])
 by Forcepoint Email with ESMTP id F173988DD8CE65492693;
 Thu, 24 Sep 2020 12:13:23 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 12:13:23 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Thu, 24 Sep 2020 12:13:23 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Topic: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
Thread-Index: AQHWjaVYIOfN4SdH50ySUPU7pQ9X7Klyx0+AgATDYgCAAB0CgA==
Date: Thu, 24 Sep 2020 11:13:23 +0000
Message-ID: <47b244b99f284790b82b2c0a968ba830@huawei.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-11-jean-philippe@linaro.org>
 <753bcd76c21c4ea98ef1d4e492db01f4@huawei.com>
 <20200924101340.GC170808@myrica>
In-Reply-To: <20200924101340.GC170808@myrica>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.86.144]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
 "will@kernel.org" <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
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



> -----Original Message-----
> From: Jean-Philippe Brucker [mailto:jean-philippe@linaro.org]
> Sent: 24 September 2020 11:14
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-mm@kvack.org; fenghua.yu@intel.com; catalin.marinas@arm.com;
> Suzuki K Poulose <suzuki.poulose@arm.com>; robin.murphy@arm.com;
> zhangfei.gao@linaro.org; will@kernel.org
> Subject: Re: [PATCH v10 10/13] iommu/arm-smmu-v3: Check for SVA features
> 
> Hi Shameer,
> 
> On Mon, Sep 21, 2020 at 08:59:39AM +0000, Shameerali Kolothum Thodi
> wrote:
> > > +bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> > > +{
> > > +	unsigned long reg, fld;
> > > +	unsigned long oas;
> > > +	unsigned long asid_bits;
> > > +	u32 feat_mask = ARM_SMMU_FEAT_BTM |
> > > ARM_SMMU_FEAT_COHERENCY;
> >
> > Why is BTM mandated for SVA? I couldn't find this requirement in SMMU spec
> > (Sorry if I missed it or this got discussed earlier). But if performance is the
> only concern here,
> > is it better just to allow it with a warning rather than limiting SMMUs without
> BTM?
> 
> It's a performance concern and requires to support multiple
> configurations, but the spec allows it. Are there SMMUs without BTM that
> need it?

Ok. Thanks for clarifying. May be better to add a comment here. Our platforms
do support BTM, but I had a strange case where the UEFI didn't enable DVM
but SMMU reported BTM and was causing random failures due to lack of
explicit tlbi on mm invalidation. Anyway that doesn't count here :)

Thanks,
Shameer

> Thanks,
> Jean
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
