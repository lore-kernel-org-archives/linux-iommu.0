Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E24FC43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 02:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 06A2D40524;
	Fri, 24 Jun 2022 02:44:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06A2D40524
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=DSae4u/2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqM9BDYLDmeV; Fri, 24 Jun 2022 02:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B8D49400A6;
	Fri, 24 Jun 2022 02:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8D49400A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA49C0032;
	Fri, 24 Jun 2022 02:44:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D126C002D;
 Fri, 24 Jun 2022 02:44:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1DA8402F6;
 Fri, 24 Jun 2022 02:44:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1DA8402F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dQBGxFIxRbIk; Fri, 24 Jun 2022 02:44:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4412400A6
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4412400A6;
 Fri, 24 Jun 2022 02:44:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IymMV4dt7WpYsQM0Mrf5z7Mea833SSxcPQdRxMkeW35nJdu0pftW/dmnAwa0lYXCz/dxEHthE9wJaiAAnCzqcpdpf7Y2Kvl/1EBHTkvXmeZtpnjd8J7sgodLs/4b0Y7DIXT6TA3EDEtaL/QFVOeg7t50u1g6HaDJ8UbiFhamLUMlPTt/0uVO3oHEick620cSh8mYcaZbqYtYZreSdy2tToREGraKAq0W9QKbZJmCG8o9w+lkd/dd95Xr9b+4az0I05TPGBUpLC6cCW5nzfaPnDwEnismkq/KYDf7mG+satcxMWeyudmO7zLEuIDdUPmp1dE5Q5wCaX1RjY32Z/EWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2R2CEdoCukeHjMxbmGYQBbhBWeg0sK5VS1VqRK1QIg=;
 b=E/57XQnkUGQTKpumLTraj0MGvqEm8e7vEqff3CwgqWNISffDiRa5kat84m5ZsLVhIPhQCiI4aXDtHun4qNFr70q3+1JS19W0X1DcQa6HzM+Aqinj9SSrG/QWFDZW+b9efBS/QhVGkU/eviDJTBftRMpp1QS0+OgYyuxcGizibO13IbnNDp9a4xuFF9PQqsnFo89iz1oJSm5YdyguFqVla/dnA4coJE74hik+j8cFtVN2d0crUjyVRe2gj96H9qVZIgKFNlsz4w+Zv/28hzPbCSyENOrVQ5/z3jgAo7xj8qFSomBygCUNbBYcJGv8j7tzt94KjVIbgNFnfDh8fPIe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2R2CEdoCukeHjMxbmGYQBbhBWeg0sK5VS1VqRK1QIg=;
 b=DSae4u/2DbtodGNFd8Zgr56c2uF1OO3R44LuifpjenB2jBSayOMRdQwvY7qXyKbQ9xMX2mvtsksXqRrj2u0hQKJt9JVr2tYzrjZV6g/DGpt0QYLf/Q+yI2fVxzYD4WuejoCMN5rsDN+1JUZKRTP1tcRbWsM+8pK3IelSlzMqWnc/GzDgfLO/Q51JJfIisdapTs2NLEBvypKgIcwL/+bRqMR6GPq8EHu+EY3bN88E4UwaqUtPsf4qvsE/LdXLVMkgM84TP6MKX5HbpuBTHhgMBwe6YK91YDE01fF0H4nbTq6ymzzzSY+fNn+xAyo4Dkl3++5Nj6GPg0wKuEgCvUBSSA==
Received: from DS7PR03CA0109.namprd03.prod.outlook.com (2603:10b6:5:3b7::24)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 24 Jun
 2022 02:44:05 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::cc) by DS7PR03CA0109.outlook.office365.com
 (2603:10b6:5:3b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20 via Frontend
 Transport; Fri, 24 Jun 2022 02:44:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 02:44:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Fri, 24 Jun 2022 02:44:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 23 Jun
 2022 19:44:04 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26 via Frontend
 Transport; Thu, 23 Jun 2022 19:44:01 -0700
Date: Thu, 23 Jun 2022 19:44:00 -0700
To: Baolu Lu <baolu.lu@linux.intel.com>, <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 1/5] iommu: Return -EMEDIUMTYPE for incompatible
 domain and device/group
Message-ID: <YrUk8IINqDEZLfIa@Asurada-Nvidia>
References: <20220623200029.26007-1-nicolinc@nvidia.com>
 <20220623200029.26007-2-nicolinc@nvidia.com>
 <270eec00-8aee-2288-4069-d604e6da2925@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <270eec00-8aee-2288-4069-d604e6da2925@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 771209c9-cd43-40df-d84d-08da558b67d9
X-MS-TrafficTypeDiagnostic: CY5PR12MB6057:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5TW4vCqbLV1qym1IcY+Uiz8l1iDws9KZnxsjYFwpXUrdb1+vIJr8Arb3/NAPLRSEJ8EYi8+NOEyQHLCkytfYc+NIJiol1rAm+IBPPkSXLXhu2ZVnItpoSuSduXVovdNzTpxkeSyFxbiTl5IW0Fb2CET+y+uMRG5UgPiPlNyygbmnYf2csA8TOhGvzhWKu7lGPR7Xo4KXqz34/u4x0W5BcAXfDgVSyGtbiae5KxXC5ZQBY4RsBgQ7d70Wbfqcf7KKUqemEvOe0svfHg9tbj/1g2bO187YDFBS0ZtCHTlZae88Xa1HMmztvY/tOlnKGgnTI5Jk9g010Daoi3oQ9x/Lopb3dpmxZrBL3H/4bQB5cWbJ1Bb/+GhBpK1O+SATvBz5LjrgrUKMeDQwAOxcYJk2Wh6EUoGafWn76trYJSnlKjaHx4GDOtWNSEkZW9TZYgsok25u5i4dW5AwNCv1pCIDOdkYytBbomX+NItSWPA+wRZtHMu8cdhYQkNzmhNy+pr37jxG6OIdxS+tEIPV9w6ZhoiCb6ApjElQbijpomLUDQ/uB8kdIlDPWpc2fnfGyAWqEP30sIuHHthZWRxQ/kIennA9XdKZtcykr91VFQ/9lzd9DxjelMVUHC+wOGVd9vtoKf38VIQt3Lso6J62hmzrbNg6eauJwmYFmAZBUYch+O8AOMHpEE8J/P0i44D3RC9MmUA+8H1WMGCK3VY0fHwI86LDkVwpjGj/JD/QtUr5lZFsSIFPT6bua3Crk/5KjmlXPM6oauVhJCm4Bg8m8FakNGQMjDrZ8FcD7lgcWAYWEYXB2jpcFGjddGHh8p60CPcz9kxZuJDH6h499GxTjbLuQK8Gy49cv37mF3b0oOpXEw1gAIanpTsamSc8SjzmTjGW5qCcykZOrb7clbIU7GECEcbH5qJcW4ybBUz8uq4SKPo=
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(316002)(53546011)(81166007)(7406005)(26005)(7416002)(8936002)(336012)(356005)(36860700001)(4326008)(70206006)(5660300002)(70586007)(82740400003)(47076005)(9686003)(186003)(86362001)(33716001)(40460700003)(110136005)(83380400001)(2906002)(478600001)(426003)(82310400005)(41300700001)(55016003)(54906003)(40480700001)(966005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 02:44:05.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771209c9-cd43-40df-d84d-08da558b67d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
Cc: linux-s390@vger.kernel.org, cohuck@redhat.com, jordan@cosmicpenguin.net,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 alyssa@rosenzweig.io, jean-philippe@linaro.org, kvm@vger.kernel.org,
 zhang.lyra@gmail.com, iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 jgg@nvidia.com, yangyingliang@huawei.com, orsonzhai@gmail.com,
 gerald.schaefer@linux.ibm.com, kevin.tian@intel.com,
 linux-arm-msm@vger.kernel.org, alex.williamson@redhat.com,
 christophe.jaillet@wanadoo.fr, matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, marcan@marcan.st,
 linux-kernel@vger.kernel.org, baolin.wang7@gmail.com,
 linux-mediatek@lists.infradead.org, robin.murphy@arm.com
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

On Fri, Jun 24, 2022 at 09:35:49AM +0800, Baolu Lu wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2022/6/24 04:00, Nicolin Chen wrote:
> > diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> > index e1cb51b9866c..5386d889429d 100644
> > --- a/drivers/iommu/mtk_iommu_v1.c
> > +++ b/drivers/iommu/mtk_iommu_v1.c
> > @@ -304,7 +304,7 @@ static int mtk_iommu_v1_attach_device(struct iommu_domain *domain, struct device
> >       /* Only allow the domain created internally. */
> >       mtk_mapping = data->mapping;
> >       if (mtk_mapping->domain != domain)
> > -             return 0;
> > +             return -EMEDIUMTYPE;
> > 
> >       if (!data->m4u_dom) {
> >               data->m4u_dom = dom;
> 
> This change looks odd. It turns the return value from success to
> failure. Is it a bug? If so, it should go through a separated fix patch.

Makes sense.

I read the commit log of the original change:
https://lore.kernel.org/r/1589530123-30240-1-git-send-email-yong.wu@mediatek.com

It doesn't seem to allow devices to get attached to different
domains other than the shared mapping->domain, created in the
in the mtk_iommu_probe_device(). So it looks like returning 0
is intentional. Though I am still very confused by this return
value here, I doubt it has ever been used in a VFIO context.

Young, would you please give us some input?

Overall, I feel it's better to play it safe here by dropping
this part. If we later confirm there is a need to fix it, we
will do that in a separate patch anyway.

Thanks
Nic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
