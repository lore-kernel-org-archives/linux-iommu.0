Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FD7C56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 00:37:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF3420B1F
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 00:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Lb1r96H2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF3420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 701F38761A;
	Thu, 26 Nov 2020 00:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ITyQGa6oKjRx; Thu, 26 Nov 2020 00:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E80BD87618;
	Thu, 26 Nov 2020 00:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBE02C0891;
	Thu, 26 Nov 2020 00:37:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4C1C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 00:37:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E8DDF87619
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 00:37:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0FRPao1XjjlL for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 00:37:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2F68E87618
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 00:37:42 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5fbef8dc0000>; Wed, 25 Nov 2020 16:37:48 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 00:37:30 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 00:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS42/3hnAb4YCtwFwqUP/hQLhYWoz5f/T6mWKpwtHdjktkn9Ah/ngH/g6cMXhBlbj1C+iBen3YPNoZ+sbqgSS3mEiLFAxyollJ2cvfh8JotqD7HZRI5yniT/Vnb0+VQ3FiU+0j1HqyPQfiQFGH3wl7fcpXhHOE6XiUEmxrPvSXEpFjkYfZJL34DN09LNp3VQF3fi7GnRw1/Z79MOdo46RrkQxvm0M1BeqG365sejJTfUV1st4J+YPd4GVmSGpCheE+6zj+aqss98qIFNqS58skxtWFqQoQgkDt3YvVJFwJsfmweRuunXW9cs4+kiJTC0LGifEYbdPEo9xBEdG/ErYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbzsTp3wxHd9dOviT+Eu4ZEFLammA3l7NwDYpVtYxtU=;
 b=JgeEURBFwyizjlGKGJSB0QllUfUhOxS8EsliE3d9ZjnUhiaO79mZP1zzK9qijvdrzoiDyeHa22+yuC8aWRTtMq0VUedGCX4SsKuARaH8l6q1ZfAp7p+t+uVcevGxfBkXcUOnqwKOxCvk+G33teDmmLg+1QujmPC+qyEJiVFHUeWmSZtrlQJ7UyfWiQBU37MOZMClxe3CrYQgOow8Kg6oW9O6vWB0xfqw8xh8rIecZHtQeH8W2eZr/piSdmyq6A6DI1gaF3SiFJGcqcCnLHvtC+NeEqmlBNlnDO0hfE4Ljudcw5r/nJZ/PVGEwg9SLwcqzDd9OO4upgAra4DsXT1IkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Thu, 26 Nov
 2020 00:37:28 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::7503:d9f2:9040:b0d7]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::7503:d9f2:9040:b0d7%7]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 00:37:28 +0000
Date: Wed, 25 Nov 2020 20:37:26 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 12/13] iommu/arm-smmu-v3: Implement
 iommu_sva_bind/unbind()
Message-ID: <20201126003726.GR4800@nvidia.com>
References: <20200918101852.582559-1-jean-philippe@linaro.org>
 <20200918101852.582559-13-jean-philippe@linaro.org>
 <20201124235800.GA242277@nvidia.com> <20201125092749.GA2445658@myrica>
Content-Disposition: inline
In-Reply-To: <20201125092749.GA2445658@myrica>
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Thu, 26 Nov 2020 00:37:27 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1ki5Hq-001Ste-1M; Wed, 25 Nov 2020 20:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1606351068; bh=JbzsTp3wxHd9dOviT+Eu4ZEFLammA3l7NwDYpVtYxtU=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=Lb1r96H2PGUQX1q4HjZrOCcGcxSYiNc1NNa4IJdvHR8dW39dbzWxQ2L5Sgaf9NLGm
 n7wjlh1Slm6hrDAaDUjpPEtXKo8571i5Py9Knr1Q7tF8ZN1UVMYRUsXkVl/p6e1F9Y
 ivoo1bRG7BCQzwvA9owL4p8A0jJeLvjxRsDyMYI7Ouk6TCBAnrCSCs0BSrLRHPgbIQ
 Fgf0i7xDPOwtyCx9zcvsqoDAErddqc+M1fmOrcooe24LpgX3pmmAMez9svIZTQJRmQ
 jQkbjHYfIBxL0YimWEOSPjo4tw29w30FfgQ/+gSVaLnm6gCXfnRPmONCDmez04TbjQ
 GnxWUOPpGVylw==
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

On Wed, Nov 25, 2020 at 10:27:49AM +0100, Jean-Philippe Brucker wrote:
> > I'm strongly
> > trying to discourage static lists matching mm's like smmu_mn is
> > doing. This is handled by the core code, don't open code it..
> 
> We discussed this at v6, which wonkily stored the mn ops in the domain to
> obtain a unique notifier per {mm, domain}. A clean solution requires
> changing mm_notifier_get() to use an opaque token. Rather than testing
> {mm, ops} uniqueness it would compare {mm, ops, token}. I figured it
> wasn't worth the effort for a single driver, especially since the SMMU
> driver would still have one list matching because it needs to deal with
> both {mm, domain} and {mm, device} uniqueness.
> https://lore.kernel.org/linux-iommu/20200501121552.GA6012@infradead.org/

Oh, that was a long time ago.. OK

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
