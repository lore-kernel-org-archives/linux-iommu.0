Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D27C433EF
	for <iommu@archiver.kernel.org>; Tue, 21 Jun 2022 21:00:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA47A61093;
	Tue, 21 Jun 2022 21:00:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA47A61093
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=BttZqUv4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id COMR2VtAdW3A; Tue, 21 Jun 2022 21:00:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 816E86108E;
	Tue, 21 Jun 2022 21:00:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 816E86108E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D3C7C0039;
	Tue, 21 Jun 2022 21:00:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7519C002D;
 Tue, 21 Jun 2022 21:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA71841A14;
 Tue, 21 Jun 2022 21:00:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA71841A14
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=BttZqUv4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1RO3PRaef0At; Tue, 21 Jun 2022 21:00:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8818541964
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8818541964;
 Tue, 21 Jun 2022 21:00:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZikeTw0S7ttyzgdzUwFhbCUqhlGkSHs6vGsOB2gVwsQN8WFaC4xFxReXjKQndC2dmmu2VdwXrdnCAB+dIVllZXtJfPAPZWwmWphLJHRSYGwYaIe+LAzpxUjQ8CZJNPJSIYCryJg3qv6vBE0mRte82PEjH4MHvrNPMcO3P5xOLbz+O7RjWD7KKaCMZhWhHsF9D0QcQQzd5uD4te84DCy8Tckxg3Z08EAXXkohzrmLJo7s85+XkQ3Ut77NA+ldNAs81uRjkKaO6/rlaElx4EoMbMcjFZLbhlwFsQXubsXVozHhTsX5gEI5rZsnZv9qM8jrFdy8GFx3CHUSKS8zUyDMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2zPddrz7DMH2w1GwVWYEI6yBRnFoUWwhGSJj5EH538=;
 b=eceuP3QNjy0tlStTbvYBBLsKtkSx3VzEThxHLSRZGQsPzb8thRMRG422tz7QLikA1ZWxLnQHzQ5c0hNhQDzLT4Ygo48QhfjrgsraT37mjWsKtIrHOfemw0Fq5i7VB24wigDRqjyqPbJoN4xcL980NpaKTgd8u9BKxKteZ429XBuTstGX7T2RukUCxWY2uxWFUVEGyLHKd+h/lGIY735V3bBlDTsrmCb7oCuPbaYmDEnfWBNxS/5YfJlmc/9VZrvPkmn3yG7T9LtMklPX7hBYgGqhAgQdh2bFljAEXTjLqwWr8bIPZZTxGkA0PWNLbSpaq6Xyk2dh5Jbx/+IahSUkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=svenpeter.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2zPddrz7DMH2w1GwVWYEI6yBRnFoUWwhGSJj5EH538=;
 b=BttZqUv4GkeEhYDXThM9SJ5dEvYS3UOV8Wy8kAwXUtt5gfWDaQV8jVt8CI1KRqFp8+6aOf01vY4as7EERb+tjYMRADoJ3BR8vViTBNw1CJdkDAK83+/uq1myr6vYaZBWJLVNeXjknHylytm3oNpQM7c+K5uwirvXZR0Pj4pq9mOFwibkegXoz5SzMGrLi+AzU3aY9WK2FhsgIbVisjfPuLdVqeFKE4imb8DTnlr2ob6wXyy2hQWpgTWMEWdEvC681N4KSrI38teYgl+scbGMXTT3mMz6rHZKP8gy/bCxb3HJ8dyyyY6ODzrybSYWidKWAtchC+myY+BBB+YPfs9ArQ==
Received: from BN6PR20CA0053.namprd20.prod.outlook.com (2603:10b6:404:151::15)
 by DM6PR12MB4371.namprd12.prod.outlook.com (2603:10b6:5:2a3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 21:00:03 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::2c) by BN6PR20CA0053.outlook.office365.com
 (2603:10b6:404:151::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Tue, 21 Jun 2022 21:00:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 21:00:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 21 Jun 2022 21:00:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 21 Jun 2022 14:00:00 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Tue, 21 Jun 2022 13:59:57 -0700
Date: Tue, 21 Jun 2022 13:59:55 -0700
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v2 5/5] vfio/iommu_type1: Simplify group attachment
Message-ID: <YrIxG616H5Pi0Qod@Asurada-Nvidia>
References: <20220616000304.23890-1-nicolinc@nvidia.com>
 <20220616000304.23890-6-nicolinc@nvidia.com>
 <BL1PR11MB52710E360B50DDA99C9A65D18CAC9@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YquxcH2S1fM+llOf@Asurada-Nvidia>
 <BN9PR11MB5276C7BFA77C2C176491B56A8CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Yq0JKBiQfTkWh4nq@Asurada-Nvidia>
 <20220620040317.GD5219@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620040317.GD5219@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 411cd746-5d6e-41c0-c242-08da53c90330
X-MS-TrafficTypeDiagnostic: DM6PR12MB4371:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB43716BA7C7D60392851AF721ABB39@DM6PR12MB4371.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /E1h6WDkvbtStPqf/PKdR7QqRL8imWhkrZ8wFMOmjIL7hJPTwK970ScQSskzv/f7VV283OPC8of4cP+eSeb5GWW3hmpPvDtqjAOsZoHm1nXZCZmlTjijI0BrCTlxlxVHXSdTdIEmwHlVagQGxMs8xVo59T6XouJEKeoWddyNgas7aTyAftf0SDFTY8c6hrmXl+953ojmm44PQ6CFPmgnnX0Pc3RgggDaVw0pK/jo3deu5LbCO9RG7oQ1J4urL0nd+LGoKWhjiOC/62Jk+ntMw3OsiYioa1wuODHrVW2vLx0V9XpzZSkUHxPNwZ2G1Rq3YhkbF/yy80eDrgpYlgoL/z32nKXbmwqQLrI6nDNMUEeA4jR6dCtwHlMcYbAWqr/zCUmzm+lf241+ZMhW98xPys24BJ0RDGucEU8F6NqRDS3LE2KN4V9Ni97R479Xc0mQlElD23abDdZvU9QSTzc0v9I1MT8yupYne/C0nnHZxdVnBSolORgyBqnrTEsj7D8tyVDdQAX9OJPciZCu/2StbH5PW23NKbHKuGFxPWZM+14drseXl88+HENXgcoznYaekcGqm3C3eOCnRYS8IA9+VNYDh0LD21j3JfWr4Feoo8YkHFWBk9YdcsuSD4tn/+zooynylGWLziEAyA/J4VumKzZrq9WHJ92/7QlICBqnRYO0GUEZ7NqR9e1t5DnJm5vO0LVTjaUNBHp1WetTdII+LiaqauXITya9UcCP6K6/s9+IOUQrt/x1Qi25ficuGLih
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(40470700004)(36840700001)(46966006)(40460700003)(356005)(5660300002)(55016003)(81166007)(47076005)(41300700001)(336012)(33716001)(4326008)(7416002)(40480700001)(82740400003)(9686003)(426003)(82310400005)(316002)(186003)(54906003)(110136005)(86362001)(70586007)(70206006)(8676002)(2906002)(8936002)(36860700001)(83380400001)(26005)(478600001)(7406005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 21:00:03.1686 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 411cd746-5d6e-41c0-c242-08da53c90330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4371
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jordan@cosmicpenguin.net" <jordan@cosmicpenguin.net>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "will@kernel.org" <will@kernel.org>,
 "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "saiprakash.ranjan@codeaurora.org" <saiprakash.ranjan@codeaurora.org>,
 "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
 "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
 "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "isaacm@codeaurora.org" <isaacm@codeaurora.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "marcan@marcan.st" <marcan@marcan.st>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 20, 2022 at 01:03:17AM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 17, 2022 at 04:07:20PM -0700, Nicolin Chen wrote:
> 
> > > > > > +     vfio_iommu_aper_expand(iommu, &iova_copy);
> > > > >
> > > > > but now it's done for every group detach. The aperture is decided
> > > > > by domain geometry which is not affected by attached groups.
> > > >
> > > > Yea, I've noticed this part. Actually Jason did this change for
> > > > simplicity, and I think it'd be safe to do so?
> > > 
> > > Perhaps detach_destroy() can return a Boolean to indicate whether
> > > a domain is destroyed.
> > 
> > It could be a solution but doesn't feel that common for a clean
> > function to have a return value indicating a special case. Maybe
> > passing in "&domain" so that we can check if it's NULL after?
> 
> It is harmless to do every time, it just burns a few CPU cycles on a
> slow path. We don't need complexity to optmize it.

OK. I will keep it simple then. If Kevin or other has a further
objection, please let us know.

Thanks
Nic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
