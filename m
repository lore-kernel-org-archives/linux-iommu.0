Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC3DC433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Apr 2022 20:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D0B8416B9;
	Tue, 19 Apr 2022 20:05:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kxhnNSUXpBsz; Tue, 19 Apr 2022 20:05:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CE65D41576;
	Tue, 19 Apr 2022 20:05:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A17B4C002F;
	Tue, 19 Apr 2022 20:05:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ABD8C002C
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FC8760E24
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:05:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iyLRJjy5lyOV for <iommu@lists.linux-foundation.org>;
 Tue, 19 Apr 2022 20:05:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::624])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C388F60E1E
 for <iommu@lists.linux-foundation.org>; Tue, 19 Apr 2022 20:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbD8PCj0eWay7ftzmu/r7EPuMrGh9ftfP/J1oS1fIQeAHEAnaom29eT0qlq6IRj5TLrGZsq0KJB4Vq0Je3uuf5RaQNdvesezgfF7ELv5JaLNP7XWs3l7cVgcXSvvfbNrsFDbRtLUZAS0aGSx6S0WFM/W3Jv3oQfD3VIN1ji17CQEpR0bPazU6oZ7H9oBq66MGox8GPq2KGqo1i7PZE4cWziRc0gURFi32Z0Oll5cczCC/DkuAINudCo0hBsIJTIV8tH9necDNClq38hIURBVh7FF1ayNYkdlhQhHQzqfNrnQHqaI9tjCq7rxiFfJOi5ATvrx0f6zskuO0DldfM8AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59EwnifDT494WPEG/QrDkzsa8CAt8u8HgPN3snz1xLc=;
 b=PvyHhTlgg/ZVg6gPZw/+7tSGuGIRmtF7xq6xA2DsQjQyc35rmSFZBkVunA3Y9YyqS3PjxgbSqiqQo3dD0u5pPxiL7X8gXX+zsObyyG26CwJ7GlB7cOBpPU5GWfdKP5L2tlHtmcCD78whkYVHlM1rwz6erMpzpBpM3xEm+kXeizovzxJrrjKZ2iNRAydcux/CViXpjLhMkiVrjBm9duX7WQuBc7v/w8Bj7MSHFxA0gJs2LaKU5w6lPIk91lq37wkeIAwKO4vZ9cpzh9HwsD5AO+akpyIFvzDtl24S+1Vg1vd2dyzLvy2RcZMfgQ39TdfDXMTnnBWEvxdU8mW1ifhxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=wanadoo.fr smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59EwnifDT494WPEG/QrDkzsa8CAt8u8HgPN3snz1xLc=;
 b=RhVxpfl3RdmQrAzuDAZaRmY/QQS5MNfVNKeGNf5yGo6ZptbURTeiAoLatOIdCxNy7SkATHaHp5sjAxaimIavWE6dJAyrfRsa4COsN6rjVoKdeL5OoWnr31KJDEB7CDAEGdwU7HW41hu7TOwL1lgOchK2DFiAIGoXRb9fE+oPImWRSIELpRXwJO8Pzu3Z/EDxVHuXq5K5KjiUoU0kyanX27oLsjETWduPNEmVB42E5iw+7goRH7DoXMwu+ZQfIFbohG5LoL16FgBJUtRTZHC9+Y9dh7rdZEGxQdGtavjG4QPjofWW70oWWBnQhtTpqvTHFYQpk2xrdzTnVBKM9xpC7w==
Received: from BN0PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:e8::24)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 20:05:47 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::11) by BN0PR04CA0049.outlook.office365.com
 (2603:10b6:408:e8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Tue, 19 Apr 2022 20:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 20:05:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 19 Apr 2022 20:05:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 13:05:45 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Tue, 19 Apr 2022 13:05:44 -0700
Date: Tue, 19 Apr 2022 13:05:43 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Align size in __arm_smmu_tlb_inv_range
Message-ID: <Yl8WF9R7tubSgREw@Asurada-Nvidia>
References: <20220413041745.35174-1-nicolinc@nvidia.com>
 <37c02fc4-d793-b003-f612-206c987a8a42@arm.com>
 <YlcwPG5RXmJ6U7YS@Asurada-Nvidia>
 <13c91dfb-c540-ed8d-daa7-eab7207df221@arm.com>
 <Yloj6GM+yykImKvp@Asurada-Nvidia> <20220419200233.GN64706@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220419200233.GN64706@ziepe.ca>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac803162-af4d-4316-4ff1-08da223ffe6a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5780:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5780E0A91E362BEA1F84E9D6ABF29@BL1PR12MB5780.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAgMmDgrWVUHOOA+ibaMJB3CpkCV+AndrNqn4V13D0bygSdrEKgOESkRQrEya4hu6/TayUce9cafTXYha41jJdmqp9nYx8AUpDl1ZU8uozK1rHHBnwuLRECW3eHVMHAh4bo8t/7zTFEQcAXQpRBoLpi6IKhFOz1Mv3LQi2hnlzZwFUYX10kiVSpsoWpBYRSTaA7R66jfIYRa6jnnN6esUL43zdYBO7ZyeTvtmYvyaqUQ6Cj8uG7t1FQ9mCJbq2bn9MBZZmbPQeFsZbhQJN5ozNLtuT49tKyBBOvncbxMSsXY7mJxfO7NtA4/oKDQeR4DbMJ3wXweg9Ut3Wp4zWoxRt/69XRZ6ZX7anFN9qkdYUyXYltijeDfbHeX6iC7Yu+jEPnFXybkIRtvDHd2DfCv8SCxS2857Ok+l+aoIWyHRv4aogXKUSsqmfI3Zc8CAJnVZMXX5Mp9o9PFO2FoS8E5Q9eWm+3iXlTjHij/am1CSxIgOe3Ah2OdpiBipx8L9UpsEM8P70TKxppWMGY3vuLQNhLlJ7hA91KFDmsHxbK5nbHm8TVTnHoa4+5eByv41h9N3JkiSA/aYZnudZ0UHNfWddGLXYTWIoeedPXJePWjT8kHNMsMebtPdytVH1Sy+ZEfdUBnUsPwXPqXJu1f/b2nOy372E8czU4AmCFEnzvxmhLcpx9czO5GD0wTM+Mj3OpuOfjIqiZGOEl6VELVEw4BXg==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7416002)(55016003)(356005)(86362001)(8936002)(81166007)(316002)(54906003)(33716001)(6916009)(508600001)(70586007)(70206006)(186003)(40460700003)(426003)(8676002)(5660300002)(336012)(4326008)(36860700001)(47076005)(9686003)(82310400005)(26005)(4744005)(83380400001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 20:05:47.1135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac803162-af4d-4316-4ff1-08da223ffe6a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
Cc: jean-philippe@linaro.org, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 christophe.jaillet@wanadoo.fr, tglx@linutronix.de, will@kernel.org,
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
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Apr 19, 2022 at 05:02:33PM -0300, Jason Gunthorpe wrote:

> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > index d816759a6bcf..e280568bb513 100644
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > @@ -183,7 +183,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
> >  {
> >         struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
> >         struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> > -       size_t size = end - start + 1;
> > +       size_t size = end - start;
> 
> +1 to this bug fix. You should send a formal patch for stable with a fixes/etc
> 
> mmu notifiers uses 'end' not 'last' in alignment with how VMA's work:
> 
> include/linux/mm_types.h:       unsigned long vm_end;           /* The first byte after our end address

Thanks for the review!

Yea, I will send a new patch.

Nic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
