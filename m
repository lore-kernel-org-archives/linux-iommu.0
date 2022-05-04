Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBBBC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 14:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 928F283E9E;
	Wed,  4 May 2022 14:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXrNJNr027sn; Wed,  4 May 2022 14:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7169583E9D;
	Wed,  4 May 2022 14:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 461D2C0039;
	Wed,  4 May 2022 14:38:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB7FAC0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAB8640128
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CuY325oR0Cwu for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 14:38:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::60d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58968400D8
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 14:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD3uoekFRYyVzIBY89QaUsjA4D6JvbgqsnctVMewypHxShx1+EgtpyllMy8GFptCXHA5Gdrf/4KWmbNOKqZx5nLmxEmTejPh7VtOkaMxhkQWxGHA9ScqyxK1FJdhc4ACKdCu8cWVfjt2OGJx8WidCX6or3rjY8tfDUqB+Hzl/95tQb+UWCuZ68LQ/Q8YeDebUNk3Kj+95P638PyutRDDSuYAMikvxM6MhwWfPLrx+ajiHyKJsSUILGgApj84ud39a10IcIdGY7KiX3ADcY69yFCz5hzuAxv0SYtkqDEI+CaEKZdlS6g1VK5HVP0KVSV8+drXYox1qsgDtPRd060jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50zmreOXbqtWVhXEDBB1GG/64JuP12cJ4jwfM464TBM=;
 b=nQerL6VapVcqTkgWvmNJcSiUeODvNMPDT2YH3WIjHpVgQWpPsS8kBixFLziujPBVw246d0v7dSPCDv0ZENsH2lvo6Kl796ElmlPYXoKUHi/Zfb/8LVgZvYJoXw8KgWFMRQ4Zq+VCemKTvmvwIufjWDOuWHpwqrvBlsn/x4iKKvCTxTuzVWEJ29+BcAcn1JNyr6ju4stu4FNF5qC+YdPLa3M7lyppWMWJTIQ5cWxcZG5wwl0OEsEaHVhkXvWqrIIvOoY1zcRLRLPWugWQTyd5KECl+DCO9A1i/FKc7ieBvB7RO9mjUUzAtZ06fzdD/JRni13BJIMu0wXfieGI3J+y5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50zmreOXbqtWVhXEDBB1GG/64JuP12cJ4jwfM464TBM=;
 b=XLEtdoPQAviQ6xtJ+cp8/RbOSS/YIZo7ecmUsmSQBV4j191MS0N7SjITZ83OojkdqPmNBRx1hSdlFiHd7fyOytMDZAI2sEoxm7WrbKuitcbsvNzA9KtpEmMnBmA3lXGJoH/qlxpMmMnekWa25HLmIUoDNLWKXuCDEebaJJrYHXJnO6IPFaV8yxNuHaTzH5YGezM3jfJf6ToFf7GwbKfDbhOVmAYGqkidXR7D0+clfLaGUGWE4yVz4myq+G6S5FItvScuZAPXxsgLbvT0Gw1UiDbnnov3ThAEBJ5s7v8eU2G2mKCV+Gbkab8QeD+bn1aPJQ+XXsPlhS5byaeLVSE9lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Wed, 4 May
 2022 14:38:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 14:38:35 +0000
Date: Wed, 4 May 2022 11:38:33 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <20220504143833.GH49344@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <8449a6fd-32f1-7cd3-6a4f-31f71df606a1@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <8449a6fd-32f1-7cd3-6a4f-31f71df606a1@linux.intel.com>
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae5400a-74b1-4939-1d4f-08da2ddbc528
X-MS-TrafficTypeDiagnostic: SA1PR12MB5672:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56724E317169468F54D08271C2C39@SA1PR12MB5672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ok/Ny3suIZOTAURzmZ/85P+0zbWfYtPgYQsS5auyU0+QP4ZqEGMzmPYvNpAy6Gj70v5RwusLwGWrC+4eRvfThH6TuiJcnkxjnB2M2HcfwxcHY58OOkFzLzMRbvjpXSjwXjbCznePfTqaLZ1YrrtYYUALchQy0Cb5F2RZuKPIOsgtYMpvA7yu+nx8lC+VMiGeGj+ZGYQtuyq/rPDYK6LocKqucJVItDfh2eCg1SaLiWvIZLzT1ioIWhoR6lqDNMsK82oPK/G37EuiynR0AdB6Bq9z+yJ5fhzUufP7JYOhybX5vFDy8yX55q8eLNrfh16x2oIttAZLGNLoqZ52bfaibgl5y4Vyrm62cvm7tyGzf7UTuCwxCdJKe2ZrqsQ9hRuoJnO417ciP07UzAED6q5M7hhZAu3Vm+zrP1bXkUjNyZ2x2JfRJ5JPvbTK94FPUq/2IHVHxd/NpYNnaDwvGdmmP5buhmO2NzHyj4pkUC80TmqOAgCmoFU63JWPKKwgzeVeEpo7zhDrCpwV/oZVMP+kNIYbtJK2+arHn0IG9tlR+QUTwboRSlfMHAZPoYBkAkOwlLDjat9SNULg78O5nm/4Lxt9zr27XckPFv6IWf5A+1Vs5OHcCkeQ79qD+zg+BuEcFC6evOWYZr8VyZfX2X+cmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(1076003)(2616005)(186003)(83380400001)(2906002)(36756003)(26005)(8936002)(6506007)(6512007)(5660300002)(508600001)(66476007)(66556008)(33656002)(4326008)(86362001)(8676002)(66946007)(316002)(6916009)(54906003)(38100700002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nwz4u/zsxEvp2cTbkSO9EK1waqqWEKEv7xAdoOKgLYOeCU92SyO7dZL1eQm1?=
 =?us-ascii?Q?aifSzXeZPBW3ei1jeYnqLmCj6S+D8VTNQ2mWmhDgq5YexGYcmGTkAjOzhgcA?=
 =?us-ascii?Q?3g4wvGXFHoX2SSdAtkSe82yr6N+4zZF0j5e8OC8x3Pzk/8xcmDriPX+L9tdN?=
 =?us-ascii?Q?daQgEjVZo3jcE9vh2wv924G66fjcewdF8SSgJ2XJMWHYRbBEMtkeuqyDOKNY?=
 =?us-ascii?Q?ktglmsKQ1Ksq6rDLbwwO5Prrac7ZjgNDSgjXCwvk23imjbu/dWRFz5Ef7lAk?=
 =?us-ascii?Q?x6ZkyQAPnyAfgstner6n/fOv0c8AUkqruFJi4D8Y53vZYj7Hb+J7oigclumF?=
 =?us-ascii?Q?P6g9y2OQ2Mo0FMhLY5NW0ayD3o7gCsBfBV6Gel2AKVsz9J9lkkuHmIP3WWoW?=
 =?us-ascii?Q?REV7w01cw8U8/2XT64BL8VYtNGL+/TcQIUqcvJExqaH072fvAiNXjXsk3Tnz?=
 =?us-ascii?Q?rtJ/PvA3G1fwdc4cNVUzqPPSuz2Q/AaMuK5hrSYSjkQTvvD/F+cwtFEYA3dr?=
 =?us-ascii?Q?ooHyYr5IemXkfzsFWvSz1SLHweFJ2GrVgD5SK3pyOCKtpXZTDLF8wKlW+uuG?=
 =?us-ascii?Q?rqBxjsFQMuWb7M8XjP/jeuHUj+0lt2zE3rlbHsC2OHcCq7kAfxfkSt3l4vy5?=
 =?us-ascii?Q?zA9JhrY0pa4HRly3awPk5V91OPRCYOV9WjYjDK/DaQAq7XDzyKoO2iBMnc+X?=
 =?us-ascii?Q?EkKTPAlmDvyWSJluUCGHXZKZjMgWhxgjuKmL8/SKCJHr6th0d1m1N4RyFzoF?=
 =?us-ascii?Q?pGPBn322A7flVxUWV3o/+y1osyH7dMSZiFsvjYT+dmdaHee9lb7pC0ZqGsv+?=
 =?us-ascii?Q?fwfRocrJuoFluNLlBiVFOUr7jR+dbz4TKVpFSNlLvsFUd8o+ecfflKBMySZX?=
 =?us-ascii?Q?RUvEFHyngkYHIW4ORb8W5zgWRkYAo3Su3oR0TySp6uiGlS5+SZ3GL3X7TVRw?=
 =?us-ascii?Q?U2ZeTtTU2LD1uNnUlUqG34CH4MclmYB6ar19/PqVCM+5KXHlBM+/aTtHboNl?=
 =?us-ascii?Q?Ot3p154BSyZnQpot1x44FhIXvQXTf17K5UqYwMPSAu++llrLEIifetPx46VS?=
 =?us-ascii?Q?TgitRsDh8QNWjHIBWxJY+e0ch+bDlpFLbGu0r9vLXa2c+S41LuEh5lJs6iLB?=
 =?us-ascii?Q?8W2OjBdMW83gEFxQWIYs/1Dtfg24l0GL6sIBGRjUnYB4XbPFYDr4az7dg9Fr?=
 =?us-ascii?Q?r8kWmU6728EGa1SsLFUquYUoz13544FcfN+sG3a1nQAapdQ32N4iSVj8YAE2?=
 =?us-ascii?Q?2Tn6JMucXc7Udh8jtaU6QkHZkUojORryxn6q3zOLpDPonhcC/PLDu7GrD33t?=
 =?us-ascii?Q?YFeRuUAVI1NXaFMPuka1qrBFwUNLc61hoVaKv6J+827TgHkJoXwTs6Y5r4bN?=
 =?us-ascii?Q?YnN6RddYTrHkeM0K1ZFcKEA+ysggIY1luko546mGnpZH+N1MRag7w/6hCOtj?=
 =?us-ascii?Q?kTg533NTkaKQmXmNUg9qhNzsIL1N+2bu+ueYEgOqnsPgqa1Lajmk13/QiP+n?=
 =?us-ascii?Q?qFuPC/thMt+L0PtDsILVmktaQQhm8nCYGSpvolcxYt8dcI83ugEXPNzGsNyV?=
 =?us-ascii?Q?4We1RlWz+rjjqlAuy4N8wVyhgUePoTwvx1+J/SlVbydGCs5dBgJJlKcXEAYF?=
 =?us-ascii?Q?a1+I58NlpguuZwNzuwEDHcEDH7cS8gaRSHvHCVrzIUs3/i+4nhsHg6QfHB/h?=
 =?us-ascii?Q?mUoz85GvCYkBcv+Reg7iCvOpoJb+PSRp8abMG6Tscis9eHRKyVGnX2cJY6H6?=
 =?us-ascii?Q?XzKqDV69EA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae5400a-74b1-4939-1d4f-08da2ddbc528
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:38:35.6580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2m01l395PzgsI/is67D3+4WfWiz6xAHwvF0Ec7XfLSUvwrYHnCNmttr6JOlWlPqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
Cc: Kevin Tian <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Qian Cai <quic_qiancai@quicinc.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

On Wed, May 04, 2022 at 10:35:12PM +0800, Baolu Lu wrote:

> With below additional changes, this patch works on my Intel test
> machine.

Thanks!
 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 513da82f2ed1..7c415e9b6906 100644
> +++ b/drivers/iommu/iommu.c
> @@ -2063,7 +2063,8 @@ static int __iommu_attach_group(struct iommu_domain
> *domain,
>  {
>         int ret;
> 
> -       if (group->domain && group->domain != group->default_domain)
> +       if (group->domain && group->domain != group->default_domain &&
> +           group->domain != group->blocking_domain)
>                 return -EBUSY;
> 
>         ret = __iommu_group_for_each_dev(group, domain,
> @@ -2125,7 +2126,7 @@ static int __iommu_group_attach_domain(struct
> iommu_group *group,
>          * Note that this is called in error unwind paths, attaching to a
>          * domain that has already been attached cannot fail.
>          */
> -       ret = __iommu_group_for_each_dev(group, group->default_domain,
> +       ret = __iommu_group_for_each_dev(group, new_domain,
>                                          iommu_group_do_attach_device);
>         if (ret)
>                 return ret;

Done

> @@ -3180,7 +3181,9 @@ int iommu_group_claim_dma_owner(struct iommu_group
> *group, void *owner)
>                 ret = -EPERM;
>                 goto unlock_out;
>         } else {
> -               if (group->domain && group->domain != group->default_domain)
> {
> +               if (group->domain &&
> +                   group->domain != group->default_domain &&
> +                   group->domain != group->blocking_domain) {

Why do we need this hunk? This is just trying to check if there is
some conflict with some other domain attach, group->domain can never
be blocking_domain here.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
