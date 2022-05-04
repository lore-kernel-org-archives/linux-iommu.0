Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF003C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 08:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72C5460E09;
	Wed,  4 May 2022 08:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kdayjTQYPZz; Wed,  4 May 2022 08:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E87E60E83;
	Wed,  4 May 2022 08:22:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28D7CC0039;
	Wed,  4 May 2022 08:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77EF9C0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66C7E60E35
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ED1hpxrXYWpv for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 08:22:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::615])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F2E82607B0
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 08:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4etekn2Nx0SddZpfd5IbYPnmgqO1GrTrNTpLm4BRINaeX2XSRqUnRcxGKWbiYgufNqu0QcDBpnu0Ohwh9p35cJNNf5N41Ft0/Ks1h8io/CxdmYr98BOwPLcD0bu90RgXSowqp42TND5m1um5W5D/IMn788yV6h4JPbB+0t2qkqk8Tg8osZ0Bty/u3HcAjzwS66wxbs3kHgwFUzSatuNQgYfF39D/j+TVijBhy0qctTTEbL4O4AQ2BF9wqc4gTs4Vzq5H8HLVEwlkK1c9cRKO/ziyz1HlwlNWh4d7Q6iAdII1QHTuIJ5FDLLgH8tsNn/M76CDBvjG+qaS9m1L1T4fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NycvyAX4DvoIdpqub0zXHIGNCF+K36sFdebb9ipHALA=;
 b=FkUhpc1wVpM5EL2oOZz/v71Z4Kh7AQIMvlHExY6j1DgSzbo1l+iEBCRGwhOtOF8KiwJbyCofW+112I6K10c+zMA6ku46F1szBezi90zYac6v7+LT92I4ug1jkujjDXSKuS90qXmSkqPUtJ3B1/4+4PvZbZQljMiGDNwafn+bf8O1LTafvRWECd6Uj761nwduws5k/RkcImNWKHEb6h7dyvUWrI2CNn+3sWmlBptG0eU8AObg58uMbPTsrI7vBXvUwhFCSgrfO25jzN6QjHbicUrKtgBqI/k/68f/ys3li2gL9r9eXxabRviZ8bHO6GsAnkITVUtAgixM+P5Am+AipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NycvyAX4DvoIdpqub0zXHIGNCF+K36sFdebb9ipHALA=;
 b=pj8fHOGz813CFEvzn8LwdsMAbSA0M11jTSsY2PpHUwVuGJOSdWYYjkysLd5Q1+01e0CzNS01MnkpfssbH/Z9caCAkOnxncfw/FXr6aQ3ouoKP+jU5zhfiQ0Jj143ZceecRdUNme+gLq3RBg/i8xhjauaqjaXPCawRCfaTjjsLrkO7z/FcrXb4MnAXKCbwl7y7k5+IgsS4f3WDNPHVarkSOjsf0hFTetkf7Lb2IkUKAXlT1CgeN49zCLWoMAOfXltPGwWUHa5gKtxgojvv6LDJit1lOHEupa4OCpmPpm6f7K6ppYeM2XBgmIl+XjgGYr/T5wwrlxXtL+cMJ9pFQ2uLQ==
Received: from DM6PR10CA0030.namprd10.prod.outlook.com (2603:10b6:5:60::43) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Wed, 4 May 2022 08:22:03 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::26) by DM6PR10CA0030.outlook.office365.com
 (2603:10b6:5:60::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Wed, 4 May 2022 08:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 08:22:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Wed, 4 May 2022 08:22:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 4 May 2022
 01:22:01 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Wed, 4 May 2022 01:22:01 -0700
Date: Wed, 4 May 2022 01:22:00 -0700
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <YnI3qKBIBR1RlN1A@Asurada-Nvidia>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993ec104-a77c-49fb-7048-08da2da72b53
X-MS-TrafficTypeDiagnostic: DM6PR12MB4530:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4530E37F69C8AC4D9849677DABC39@DM6PR12MB4530.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNS/+9SfVkgu/lSLPXzZ51BUjwrXVXX5uIidwpZ/jZzm1SXU1sqpOeViWvJ3HPAxLrxUFDO15KtazDcTt986Q8VDl/0HnQD1VsUoozTnVGs52CWQ1Fq014MKw7G9mtqvshgBntIZFuZzBM2Y1SOjHvB5EEtXClUJL7wj50YHxsyVFswE+o/1PbvR2CWgX4vIOAJWFd3gSVL4Wp+SHHoV40lm3bNZNASX0NZTYn5xxXw/KT9B1CH16HoddGSgnAbvF/zH0qZnqFq3mvzgwmIguJGFAvpOheEUyJcQyFoST+KUBW65JlgzLVaKUSJMlN8Oth21kDB/EoIZ7OnHMzv2SYqAxBMsKP0bZDrgzBCVyuKhRprKjOfvkNKSq8RPM1HymJQsVFvjK33Dc/t0ZEhISDvcvG0FsCbzQfSiAn/6i2u5/Df6HW9WsQpeUtRLQrrqQPbqaB0epOTHsx3zjfaf8BlYHty8clNvZJD3j02CTuJoiG461rWmt1THp1ubsylTVnuEgcR2GS2YK67NsM225jGmX93cNkrgyyV8JCKgDHeNHvxUR7F68liwbEFWmL7shSXsq9kWa1n0VMtQO4YDjc0XiVl6WBYeRgu9O4jLc16dQosCfj3zVaGz9t/e7lLHh7Q5kEShBNYSUFgY7oyhZZAG6O2btdsLF7hQeSHSWRzZHeDeQwFv3AqqEJJrCCATGEtLMd/jprYP23Y7q1mvx5l7KkoSUPdC02BDn2lreGE5HPoOmsb72OIUtqIR4PF+jCXOPVXT9iBgFUyj2/HFzUYqhH38ForAx4XNEGpsDmA=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(70206006)(70586007)(316002)(26005)(508600001)(966005)(83380400001)(6636002)(54906003)(86362001)(2906002)(81166007)(36860700001)(356005)(4326008)(8676002)(6862004)(8936002)(5660300002)(40460700003)(336012)(9686003)(426003)(186003)(47076005)(55016003)(82310400005)(33716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 08:22:03.4929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993ec104-a77c-49fb-7048-08da2da72b53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
Cc: Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
 Qian Cai <quic_qiancai@quicinc.com>, iommu@lists.linux-foundation.org, Robin
 Murphy <robin.murphy@arm.com>
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

On Tue, May 03, 2022 at 09:11:02PM -0300, Jason Gunthorpe wrote:

> This is based on Robins draft here:
> 
> https://lore.kernel.org/linux-iommu/18831161-473f-e04f-4a81-1c7062ad192d@arm.com/
> 
> With some rework. I re-organized the call chains instead of introducing
> iommu_group_user_attached(), fixed a recursive locking for
> iommu_group_get_purgatory(), and made a proper commit message.
> 
> Still only compile tested, so RFCish.
> 
> Nicolin/Lu? What do you think, can you check it?

I am able to repro the issue on ARM64 and give this a quick try.
But the patch seems to need to include the following change too.

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 94d99768023c..9bb108d01baa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2040,7 +2040,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (group->domain && group->domain != group->default_domain)
+	if (group->domain && group->domain != group->default_domain &&
+	    group->domain != group->blocking_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_for_each_dev(group, domain,

> @@ -2072,38 +2072,66 @@ static int iommu_group_do_detach_device(struct device *dev, void *data)
>  	return 0;
>  }
>  
> -static void __iommu_detach_group(struct iommu_domain *domain,
> -				 struct iommu_group *group)
> +static int __iommu_group_attach_domain(struct iommu_group *group,
> +				       struct iommu_domain *new_domain)
>  {
>  	int ret;
>  
> +	if (group->domain == new_domain)
> +		return 0;
> +
>  	/*
> -	 * If the group has been claimed already, do not re-attach the default
> -	 * domain.
> +	 * A NULL domain means to call the detach_dev() op. New drivers should
> +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain

an IOMMU_DOMAIN_IDENTITY?

Just a nit here. I will take a closer look at the change tomorrow.

Thanks
Nic
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
