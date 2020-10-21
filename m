Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B96C388F9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 18:24:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E12C22464
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 18:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bdy3zt3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E12C22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 131E187510;
	Wed, 21 Oct 2020 18:24:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zKCgI-XFCVzz; Wed, 21 Oct 2020 18:24:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4FB1687502;
	Wed, 21 Oct 2020 18:24:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 405C5C08A1;
	Wed, 21 Oct 2020 18:24:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87670C0052
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 18:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7E036870C8
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 18:24:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QT0Y95IWcjHY for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 18:24:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E67BC870BB
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 18:24:47 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f907ce30000>; Wed, 21 Oct 2020 11:24:35 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Oct
 2020 18:24:46 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server
 (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 21 Oct 2020 18:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm+V9mype58dG1Zn3Q4vYCV8+Cxb1ZJ2Akx9ftuPjv1hRx1RFYGJqBe2sZ8H7SYfg/8OJRTUIsDSsfBxshzLpw4eEqBVCij5lxHJwYfy/zHkzg263oJsG+qwakMumaovffBoOdGN/YjELH/SSZ8ep1hLR9M9TTFjkpviZkGypA3ASKKcw4Rz/BC97HwPO3iCkxCigUJuw6n7Lf+c/Nlg5dKnBjPOkUwqrIAZSwIE8s+CHfVgPMFmVTAT31CIAw4r8LQiO56FJP5sdtVUn2wN4D4yZ3P79l56LUIvTH6ZNJZhfn9LkFZMiK0FWO3k3Ni1fhDgNmfJ5xVdFEDI4zz8lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NgPxzLNUZzeKlTpQJekvGEV1+nt/QXlzaHcwUJQt5Y=;
 b=GjfJZ6SJUmFVhiODdyVSwA4hdPb23uJ1Yiei1mJG83BkkUvj0UORM5oXKeW9lLaStg0sLX6NTgG+pfFfDMTBcFlFCTN5bq1+9NcDWl6aA5LEDXzeTBk/On08kAEwJzdj/3SqskRUFMq5IM2qbqLkIgl0yoLLriXK+MQo72wWEAbPp67cvyBIe2sxXB9/dk8akzYd3GSqoeKDUz7mYJBHaBr0yQw+mvXmRPCBRHkbEn2FIWDPNczrHW/NVc4NDf0qFc8/qP3kTc64MVyTaxtMHVCmiMRIeFLg+r3H1EL46wr25SJIFggBXd+GwVTQawKXhxnDdGsqfPAMGKM4Z05YUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2488.namprd12.prod.outlook.com (2603:10b6:4:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Wed, 21 Oct
 2020 18:24:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 18:24:43 +0000
Date: Wed, 21 Oct 2020 15:24:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Raj, Ashok" <ashok.raj@intel.com>
Subject: Re: (proposal) RE: [PATCH v7 00/16] vfio: expose virtual Shared
 Virtual Addressing to VMs
Message-ID: <20201021182442.GU6219@nvidia.com>
References: <20201020140217.GI6219@nvidia.com>
 <20201020162430.GA85321@otc-nc-03> <20201020170336.GK6219@nvidia.com>
 <20201020195146.GA86371@otc-nc-03> <20201020195557.GO6219@nvidia.com>
 <20201020200844.GC86371@otc-nc-03> <20201020201403.GP6219@nvidia.com>
 <20201020202713.GF86371@otc-nc-03> <20201021114829.GR6219@nvidia.com>
 <20201021175146.GA92867@otc-nc-03>
Content-Disposition: inline
In-Reply-To: <20201021175146.GA92867@otc-nc-03>
X-ClientProxiedBy: MN2PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:160::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by
 MN2PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:160::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend
 Transport; Wed, 21 Oct 2020 18:24:43 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1kVImw-003eNU-FQ; Wed, 21 Oct 2020 15:24:42 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603304675; bh=0NgPxzLNUZzeKlTpQJekvGEV1+nt/QXlzaHcwUJQt5Y=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
 From:To:CC:Subject:Message-ID:References:Content-Type:
 Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType;
 b=bdy3zt3UXZqrIG7p7ZaOsWwJgj7Rz3bgeb7w1uBKL6anURiWOqhzAXWNf44TP3U+j
 8vmsREk9wfrTVW0pqV9NRMUnUyn7WL21bO9pgsHpgg0ifGZCm46RR+ogXkQGXbNxeQ
 oJmYDbDLxJJhi41LhZLu70elIlyLtC8CU0wNfcI+eHnUldWFxTwFo51l8CTTLRl0oW
 PUZQAySfiBkCCcJqba2LEEanr2O6F0FlLoOHMiVgFk4+B8XsS2SUL8r5qo0nhF92p8
 ZUGy3C6CqL7EPkHlx2YygPmr1tgCg6u18RkaUI4L8zeBh2K2O7Z7DqgUAfZjYF1HsE
 5/ECpbV+gfrLQ==
Cc: "Tian, Jun J" <jun.j.tian@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

On Wed, Oct 21, 2020 at 10:51:46AM -0700, Raj, Ashok wrote:

> > If they didn't plan to use it, bit of a strawman argument, right?
> 
> This doesn't need to continue like the debates :-) Pun intended :-)
> 
> I don't think it makes any sense to have an abstract strawman argument
> design discussion. Yi is looking into for pasid management alone. Rest 
> of the IOMMU related topics should wait until we have another 
> *real* use requiring consolidation. 

Actually I'm really annoyed right now that the other Intel team wasted
quiet a lot of the rest of our time on arguing about vDPA and vfio
with no actual interest in this technology.

So you'll excuse me if I'm not particularly enamored with this
discussion right now.

> Contrary to your argument, vDPA went with a half blown device only 
> iommu user without considering existing abstractions like containers

VDPA IOMMU was done *for Intel*, as the kind of half-architected thing
you are advocating should be allowed for IDXD here. Not sure why you
think bashing that work is going to help your case here.

I'm saying Intel needs to get its architecture together and stop
ceating this mess across the kernel to support Intel devices.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
