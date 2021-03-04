Return-Path: <SRS0=KoUT=IC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B8FC433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 19:03:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26F464F64
	for <iommu@archiver.kernel.org>; Thu,  4 Mar 2021 19:03:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26F464F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B40DB4634B;
	Thu,  4 Mar 2021 19:03:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rr-wGTNmCTFf; Thu,  4 Mar 2021 19:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7951E467FF;
	Thu,  4 Mar 2021 19:03:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B822C000B;
	Thu,  4 Mar 2021 19:03:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EBA6C0001
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 19:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3650A835ED
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 19:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mGV71y8kzM9s for <iommu@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 19:03:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52A1E835E9
 for <iommu@lists.linux-foundation.org>; Thu,  4 Mar 2021 19:03:45 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60412f100000>; Thu, 04 Mar 2021 11:03:44 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 19:03:43 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 19:02:59 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 4 Mar 2021 19:02:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZ7NdjWDHjomI7Kl+rhQLQJn6XtgHeGSr8jXkM7+dfn7Vp8pymNtiC/qeV4RypFO88liiqnF24gafWLXzVqsPbGOT1UEUanC4zikUXFEoaUL/grgNPEW/7tvRMF2NlROV2JrTVqPbkKsxdCkywHluK1JtAHoOq3HecfVl6+b2aQxQJOIpazY2WM/FGK5BpbCZKt7zrcC4Q5hqY0ig8gODFEha2CS/RwymzcwppxQZe4otxq2uTeIJgh9vjxyJ7hsxDnZ7iE4vIpC9s0TqdSUjC6Bu+5OI/UGz+gSQcpbpHJqjGON0u4V4iLvPDI+rCvxK3S/8Dl7tgQRpyBPHPInFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsoX4K4P4Z7v42HYxZh2fbbvzalzBIz6MU+YUWvMuh8=;
 b=SG3JYb9N3GWINJGThmiBwuFQAbc13h9uou8vfUSMRgPjU5tVVGB8qyy2vo9Q9w6uIQXhEhFyB8XK9QscSWWzAkDRzXfZVuPs7Vm1F66WnLqH/xqrMnOlin9AQNPXT0xszT1FXHgfWP7JDubKXWgZurIoSFcljW+faQ74ZBSgOWypP1SlN85/acpF3P+TxKEd5B7MRp1EUe+jU7mLL2OdAj3txZ0q/UcBMdJYiWGqZjzynrq3kJBtzDCDKDLIv06MQJy1vDChOid7qLxfTN6f16LqqC+kjkA+1JUNFVf9loXA5gsEsTxN3wxvWZ1yuO+2bjQaF80dsOKjRs/QgwJDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 19:02:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 19:02:55 +0000
Date: Thu, 4 Mar 2021 15:02:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Message-ID: <20210304190253.GL4247@nvidia.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
 <YD+u3CXhwOi2LC+4@slm.duckdns.org> <20210303131726.7a8cb169@jacob-builder>
 <20210303160205.151d114e@jacob-builder> <YECtMZNqSgh7jkGP@myrica>
 <20210304094603.4ab6c1c4@jacob-builder> <20210304175402.GG4247@nvidia.com>
 <20210304110144.39ef0941@jacob-builder>
Content-Disposition: inline
In-Reply-To: <20210304110144.39ef0941@jacob-builder>
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by
 MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 19:02:55 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lHtFN-006kRN-VZ; Thu, 04 Mar 2021 15:02:53 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614884624; bh=KsoX4K4P4Z7v42HYxZh2fbbvzalzBIz6MU+YUWvMuh8=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-Header;
 b=Y/+tXoO5Rv7rqnPPVb03AWjy73eBvBv/FvNRCgbIDCXN7yKhA+No1pWHwflPq8mAx
 ctf7TOKCfllF6lXdt8+8tAkqCHqHlNrCJENCXatL5bK/cgGiZEsysjKJcDc0XGJou1
 dsfUs/WDt6irR+h8HZlKm7VTSOGkYGdb6G54n/TfdTP55oPL9KYIgC+FDVfq7HpLbq
 9mwPWlfwcBQsMrPi8WLRgeXR0AVDc8Xo/Zf7ta5xDj57rp7VX7WHlMZwAeaVnAiLwB
 M6VTBAEmhGfqM0aEXTWGxq0U7pOCOBcvP2IhsmGSycNcs+nm2CSD2yzzezItmtAhxg
 eTpbDFsDYSXZA==
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 iommu@lists.linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>
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

On Thu, Mar 04, 2021 at 11:01:44AM -0800, Jacob Pan wrote:

> > For something like qemu I'd expect to put the qemu process in a cgroup
> > with 1 PASID. Who cares what qemu uses the PASID for, or how it was
> > allocated?
> 
> For vSVA, we will need one PASID per guest process. But that is up to the
> admin based on whether or how many SVA capable devices are directly
> assigned.

I hope the virtual IOMMU driver can communicate the PASID limit and
the cgroup machinery in the guest can know what the actual limit is.

I was thinking of a case where qemu is using a single PASID to setup
the guest kVA or similar

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
