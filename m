Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC58C433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 11:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE3E8188B;
	Wed,  4 May 2022 11:57:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gFgHpcY4EdZc; Wed,  4 May 2022 11:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AAF6E81815;
	Wed,  4 May 2022 11:57:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8102DC0039;
	Wed,  4 May 2022 11:57:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB10DC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BB5264024A
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:57:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FX8uddn4yqF7 for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 11:57:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E5A64023C
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 11:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhSPPdUyK6Fi20a/6rkAbi/sVNZJp2GJBQd050ZcnmMxhA1OjTiL73nCuf1LvPDjyH6GHFjLZZbIOaymso9NDZ5JvFwAXidjYsVQ77aaIfyZASQaWQyuVHP06+xPCwFOaJJnBmhCY4V1wkNO4ql7xFc1nxa5Fq/VwJWrojSpIaWBs2AWevnZghFYigW/T2Cw56H9kNy55UBiPA9f+hJTCYuqB+9Yc3Zr+uQnY24X8hZ0qnR/Lw02sgGRB7sv/iyqqVTTRH3VldDeAX3XLNURXWkeLl5GCY6rl3Yg2HzKyBksxjh7VAljsmEgZLRi4XSxgvtQaLdag9atGIBXzyspjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vm1blDxLD2qBjAQb3qe7TYcEkaq9uUuuMQ/73oMSBCk=;
 b=Xt8gI9hAjJfSQjxObSUJqvj+g8yzod7Wa6FCyDtq/byLRQkUOnNKwi5gG1msrQHjgdEUPFfszMVTtmiljqv+PE+qnaCVdC+p4oSu1j/9nDPVu0dbzMRRZjFJaM1S33bwKXqpWuHPQpHnfWUFbOYGcUNefcFsCbDJgeFxfUdd4Qy/mBqqkyAKYQsLMNkndac73Z94I5aY5cQllAk0yZJHyFJwYBXdyeDPE5SDuHlh9IXs/vax/fLcZ4i/ng1ELJWGzeXVLxhIJJKSgQUp5Dt4cYhRLoAx/Vl0Q+n3qIHYU3N2X3h/e7n27crKfFcoMb/T7b+dq6J37Zk2fyXgGwpp1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vm1blDxLD2qBjAQb3qe7TYcEkaq9uUuuMQ/73oMSBCk=;
 b=BbDpwdgT2CAkFxL9Eks9jcltgER3XPZN6G4L+Wh/087dKDnvV+CLXMw8wVM81hb7T0Si2eJ4WHWfKwXT3+Md428Wk5aVKNH8CPt7drqtiWmTbGn7SvVmyOfEuj42ZDLv7+LIq48N2GL4f773m7uOtHEraazXqaj8lMpXcNA0VGKuE/LnyNe9tTpevNM48j+LYyeSKF+BycaDx3O+up2VuHQJW55Em2yRnCTYmJFIuY66Ao8jtPwI/EJUfEe0QOW8CUJuVaVu5akRmxgMNo3P4rFfS1sv+YOvUA+yuMiFvOzsdHR2Ga1cj5jUbxb1gxt8+y1UARFQwWWqotsIznU0+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN7PR12MB2804.namprd12.prod.outlook.com (2603:10b6:408:2f::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 4 May
 2022 11:57:10 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 11:57:10 +0000
Date: Wed, 4 May 2022 08:57:09 -0300
To: Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <20220504115709.GB50202@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <YnI3qKBIBR1RlN1A@Asurada-Nvidia>
Content-Disposition: inline
In-Reply-To: <YnI3qKBIBR1RlN1A@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 005ae483-b501-4c26-b477-08da2dc53830
X-MS-TrafficTypeDiagnostic: BN7PR12MB2804:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2804FA025977749F888AC821C2C39@BN7PR12MB2804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +upaJ/LHfBlq8deVit+Vq0S4JSyVfOtQ7XIYCndefYw4lb05wGy1vee3vf05RupA5NryMo4pHTjTnniQbYEo4Wj8f3hN5xxNvOzkuG7G0/+Muc5IkQMZc1113621buxIXDamHrlYUDJ9iN2IZw3IgNqa6HYkYshxMMgysHT2HjXul5p1A7QxzIq1bvSfEVxzQyGE4Uv/9EPjeo+mCcVdiFom4Hj2mW2GMMlQa4aJ3up1AAZ8o1+CKfvIGvOXdZJAA6NtBJtQlGMTtYW8z1y0b9AuDa4ZshSwxS9ICpblWYiP2LAxM08rM1nKvCBZHD/23TR9psN9B13DROb1QY5F69+dDuxedlQUBjmTtid1JjF/forP9qxtObdvh8YmeS+99OLOQ9r67lPxEU32aYXW+epZEtv4DX6CLB1cIZZL//UrPctNqL7iFlC8PPRrkiHcHpSMBV4zPIhVpxJBCVHF5CgETu+22FmLcH2ozlQAloOxN9+P/aupFoQghBFxBsPnyMrpw6IzDsZ5Bs7N7lviubpW+cU1VnxsESFc8ZbAv9J1kX/ceUv2hTW7m+v3Uj0XvKc/U5WgQiFwQZ40cY5C3e50Y5Ouy9tSTcB+M19KgFSnpOzL25xhztN4IgQk0xkiOX+I1FvtdjiPpxKdIa0o5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(66476007)(6486002)(6862004)(2906002)(8676002)(4326008)(5660300002)(2616005)(186003)(1076003)(83380400001)(38100700002)(26005)(86362001)(8936002)(6506007)(4744005)(33656002)(66946007)(37006003)(66556008)(36756003)(6636002)(316002)(6512007)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8mpK2RSRcx1SXvYr1x9ZFdMxLI2Yf4munXHuzZAyeGPbYRFb5jAsWBHMweLb?=
 =?us-ascii?Q?t6sAgjI/Tb3+qCkL6Ib4Mc7MiqSNn9imBmDoIgnq23fn0YnAO1ie/RtBkZp3?=
 =?us-ascii?Q?xMPPNmELE48OfJYoGvgCDMO2GJlUoqbKRChTMyeiI2Gw1MjlVMnGgFZWGp5I?=
 =?us-ascii?Q?o+UAlCzLunlgEhH9UKBvbqAjPk42+ZU1bVTlYkTotyEoMXHt2lT6x22BJpla?=
 =?us-ascii?Q?Xdmi9MlCeJfKpyGDS67S/dxwMKmDYNiFuuvdFtJa9IwkTBRd1gLOrETexFqt?=
 =?us-ascii?Q?Hz0rTgu7get8oAK0kUfdLVrvmYQYPcdOmNddt7Ly+V/zVJUR8AZULEYJxgVH?=
 =?us-ascii?Q?Z4yAO1aJ0Spuc49uy5Gm/KbZvLj59wxZI8+DbDHvGirznlIbnVcniTuO7e22?=
 =?us-ascii?Q?kYuHAyxz0HDW49NWoXCTe6CZn5FDufm+SC4W9Yug2nb8TUhXT7dYnO1c2lBl?=
 =?us-ascii?Q?0Iu7ann6jigR6+vc2ZEJoKKu/9ZPGWxjDEkQyX++L7Vt9bBYGSKUonr61a6v?=
 =?us-ascii?Q?M3PipyzpUOuyyXI8chwO+GQ9FVP7puwAiwyUeSn4uJ8xaIBBS7NlwluujffA?=
 =?us-ascii?Q?P57sZkEZHpS/54zR8BxduMhThhdeMWQLLa7PBJZmp+7Ou7eZr/NlYg86eJzy?=
 =?us-ascii?Q?6/pBYDAIkYSdIWulWalbK0v9OBSxaOdddWIyCxvwJr9kyqjwkPq5V6y3p3KV?=
 =?us-ascii?Q?sj3lE4kPxzOSEygYtG5JbEZ7BL8vIKULLujEeQkm7KcY2e9jaYAx+Nq2/kGc?=
 =?us-ascii?Q?qczIMW1xRY4wydFM14fYh35u5fUjDbyrePPg1UCZKWe2rvgOuOjoYwJDmXoH?=
 =?us-ascii?Q?xSL+ae4w9YiTl7VigL4kZwSVMELS2/OxPje8XmGPTI0baeKL8CM3sLkgx/EI?=
 =?us-ascii?Q?nQQKihZS22LM70ak1MRUPmOo5ocz9XAuUBrX3qnu/lt1RtYKXGdqg2KoKAUc?=
 =?us-ascii?Q?GTzZaxcLSvgaJwsYiIUZ8bsvf+r8fHfe6CQr7N216f4UWx84Aw8gh0DWdlNl?=
 =?us-ascii?Q?ycpptnrvBIncFyogoNCMH4s5R9A5au80htMAlJQh4T3CQ0MvUBcP56Eo5Xaw?=
 =?us-ascii?Q?0gH1NM51efDsdnNYMtoGn1gV8NoPIm2RSkTS0uPvYd8zvQDry5AE6M7D7F6k?=
 =?us-ascii?Q?XfhJt2RmkL5kNFUvHB18ZJr0U/Vt0z5BHQDR5x883nefEi03lpMDS8Ybtr98?=
 =?us-ascii?Q?9FtxCIFf6pL13HuHs639dpQ4JQH8yBCWA6PDvp0DWYBC9905KP+ZRTgkki2J?=
 =?us-ascii?Q?P3wzKLHJgFWrmnatjyJ5mjrNjwA5s0pL68bds1Zur9HdECuFTOKFWMNpTCgG?=
 =?us-ascii?Q?vVPyEtVoj9bucYGlZyQ5/F6cWuE6410LXEFwcDBKcMuuxn0NAopfuZkC+Jmy?=
 =?us-ascii?Q?Mnlur/wMve7wPRogO/XsIUX8YHJd+RuX8vivnyLA6ePheqDNcQKy223C/clR?=
 =?us-ascii?Q?Wn+DNYfGbWgadrXm0hqtx1ExM8kVVQzWuOmDZR7w1OHFjTAqZnIPy4Pc4ESX?=
 =?us-ascii?Q?u9qpxfJVbJQLVY1onzkKvilyad1U0UgwicoaZyZyNp/etPQvV2tV8Ih9xvHP?=
 =?us-ascii?Q?0gUp4gG/IdTC6Go4p86drlni7NqVrxvFrWCbeRj0/vFWCFpedpFpvoKXOw2s?=
 =?us-ascii?Q?IpGy6vL6gEgLH4WFjt5xnBNGvKTESPqwnaPobuoY5wSiFwurewldS7Zf1yg4?=
 =?us-ascii?Q?jCuypyLNsoSutZju7X5vfPBfutUZAwBY+aknf4l0v4AuSji9wiQg53JzmCYU?=
 =?us-ascii?Q?h9yfdl7pzg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005ae483-b501-4c26-b477-08da2dc53830
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 11:57:10.3993 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXqL3g1qKUn51zMHvqDcJTvZDLHNUit5b9waXpq9vaGViulxuYsfNPfQ1ReNaT7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2804
Cc: Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
 Qian Cai <quic_qiancai@quicinc.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 04, 2022 at 01:22:00AM -0700, Nicolin Chen wrote:

> I am able to repro the issue on ARM64 and give this a quick try.
> But the patch seems to need to include the following change too.
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 94d99768023c..9bb108d01baa 100644
> +++ b/drivers/iommu/iommu.c
> @@ -2040,7 +2040,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  {
>  	int ret;
>  
> -	if (group->domain && group->domain != group->default_domain)
> +	if (group->domain && group->domain != group->default_domain &&
> +	    group->domain != group->blocking_domain)
>  		return -EBUSY;
>  
>  	ret = __iommu_group_for_each_dev(group, domain,

Make sense, thanks

> >  	/*
> > -	 * If the group has been claimed already, do not re-attach the default
> > -	 * domain.
> > +	 * A NULL domain means to call the detach_dev() op. New drivers should
> > +	 * use a IOMMU_DOMAIN_IDENTITY domain instead of a NULL default_domain
> 
> an IOMMU_DOMAIN_IDENTITY?

Done

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
