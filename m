Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D06FC433EF
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 15:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BCA14400D8;
	Wed,  4 May 2022 15:00:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22ovBh847ELp; Wed,  4 May 2022 15:00:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 97E744040D;
	Wed,  4 May 2022 15:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53B46C0039;
	Wed,  4 May 2022 15:00:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A938DC0032
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 803FC4040D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lAS2_IkqRNXe for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:00:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::618])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F8D240AE2
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:00:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFwPzyU25yGzlbOSNP8NdGH9adXma2W0GZnc3cKSDVa7EOszeloUGxyCiLxqddD+SXvfT/X0ZxM4amCqDIfj3ouszEJdnG/vUiqLeV8hT7qvuCjQSIX4XqtwRJfXw/HEyso4CzxtTFVknvrzV7Iy0uStB3lIrFhjzlxVKIc1fByqCogROYGr4DqmKHImW+V+2ruKDgj7CO1DL59FUiM4jm5ukA4j8+q3rBchcF5jzsAznNE271gda/ikIoDVH1CkKC+EGZyTUgQ+95yerGJ++IipkQ/VOVTY5tp4lZnmtPMSFNktk0DA/tWf02zK1pnHCa9ysjYDkjtKDGHbvoLLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW3baAZba3cQypaCbVTcsKzqcX8fHRcsYb2w2rqYKb4=;
 b=CLbhfHigExSBiKarL74vK7+NH6CsV0yH+A9HxV+e1OIoeN1jZMPxDzmFZ8KxasPpGdH4hsd/h/nln5ZQZsd3dYcHwMS4vADqd6JNnRR645mkP93EskT7BFJUvzax8rtDhgEuJYHGfB+kdMw5LZQrTQ5fSsayXRrChXJ6AeL2nc2rjAZ03nmJs11vOIcrOQMb0MDFfhhRefOnh22rOORZ/CJlAa9CeAV1aCC+DLu7vefcObFIRjOd6aX84EdM4N7AN8kTlXrwkkwx+G1kzEfnGlyZdW0JJL16vlSddYRMJIRyq8KZniouYzSxxWbq2fMMGoZTZ3Xoi4PN2XLYZ1V5hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW3baAZba3cQypaCbVTcsKzqcX8fHRcsYb2w2rqYKb4=;
 b=h29dSGK4djRXFQYqobyXjyKAIBKuimdIedBPuJre8XkcjiYnTXgdz0bamM//Mi3RWrajvDGngEw9ZN01LAVBcbEfGaYJGHSyoaWe37NqJZuoXNxQu61ZBxEVEr3hqal2a7mkBM++UqyOELqPhZgY27h4Y8rzTuZ8zjOWGA2SJCUqdZymnElqHGdJKKZcorlUJOa+wrv9nAzFKyzBOosz9f29lz6BlhVL6uhHZOe1tgh2y+IdcPXZCsXjJxbILy1Efti+H2jA1tn/TKa4T6ZVoTtcGhOcoTuRjuD2eQ9IKGCPh3g2BYsTl5KAlLzwu7sc3wejn0apkDXEnKy6y1EvWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 15:00:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.025; Wed, 4 May 2022
 15:00:03 +0000
Date: Wed, 4 May 2022 12:00:01 -0300
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH] iommu: iommu_group_claim_dma_owner() must always assign
 a domain
Message-ID: <20220504150001.GK49344@nvidia.com>
References: <0-v1-6e9d2d0a759d+11b-iommu_dma_block_jgg@nvidia.com>
 <8449a6fd-32f1-7cd3-6a4f-31f71df606a1@linux.intel.com>
 <20220504143833.GH49344@nvidia.com>
 <a783ff02-6406-0e31-679a-77d43b848a72@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <a783ff02-6406-0e31-679a-77d43b848a72@linux.intel.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95571b69-f3e2-4f58-70aa-08da2ddec4d6
X-MS-TrafficTypeDiagnostic: DM4PR12MB6136:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB61369A6A0F982B391A46FD62C2C39@DM4PR12MB6136.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo5dsSErDER8zFqftfmjTq0g6t6i1+DzMtnuZKc3RKrBmYJuuO9//yj/dYd1LIb0UnQq1TzZDl1dNHuPd48F+Am9V3wrEMI+AIxKqaNsz3P6eIzUtEmqD5sgtwIUROXZmDZDwiH76ej7My5NVc+TXx3BvLAlt7wgmSeyY4z0RXJs1R3czOBOcX8Cps1cgxQ7RWvfnZyYEF7jOCLms8kN1CVUwfrNQeKUlS3KTaIeGoOFoawiYpSAL7+xKeQb0eoZjBzAuShcRUYiF+kXo+JGDCFI9BlBjoDhBPtAi/Q+244BRys5gMCW0rjUttbsdXFhyPOWL34AcqhmOI9mKgwjAbj/iN1pBsqgZo0kzbcxBKcwBzO0y7GI9QKgB0N2tFd7R2Tn2yDNrxbLPerUxag0IMCPgBeU9Rclom6JA/Yts6wDJV0BT3jXrm+Je+NoYcgO4KTHEa6R2ZmK/1zouy+Fb8NUnGn858cYMU/4noLz+2mvIL+AUic2ja34Mej+K3EdeBurJ5XyI5xNL0T4iKUZiP2eHzIZ8A2QFLk7dFGSkfqRkuoU9Pg7NjEJG24yKCwhJ9SrYB52jLKHhC2ouK5LxBdXw43biE4fyPGDtSIkRzFnhFZW/XzDjlg92CZ7VYu1j9g3BJut/O7DuTphKHuiCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(66476007)(33656002)(8676002)(83380400001)(6916009)(2616005)(186003)(1076003)(316002)(54906003)(2906002)(26005)(6512007)(86362001)(53546011)(6506007)(36756003)(5660300002)(4744005)(6486002)(38100700002)(8936002)(508600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xjcPPPdHpsvI+1umyoVeLYATeEB7fw16GppWFt1xAfRduUVrygiK2XUIX3DH?=
 =?us-ascii?Q?7McmOHh0dxER5fAowt8TB2PrcVdHd6+bGZ+8CCNJ4iHVzVc5r+KEneMupF+5?=
 =?us-ascii?Q?4+XU18S6lGtvj8rFaBlS2N7Ajehuw5IfR53BV+7ZtH2XygpINpjxgPmK85ST?=
 =?us-ascii?Q?K4MHKBMfclTIaXLorqTCCekbYNuMilCehsWeGKLwgihABfyk4pI+MdLdIUc5?=
 =?us-ascii?Q?i9PGb9ykcsdHF1BEeeJjhbOjPGMZKgmMDmxH3YTVqx8hlMTvwlayX8GWWloP?=
 =?us-ascii?Q?NS9uW8KIgmyDV82k/downWFd7g+rbMQPRzOoPwO+2F7fMgFBlMio4m5dLlzv?=
 =?us-ascii?Q?58JcqQPzfCHe//YDkSM4wIQ4XODPEyhGdNyyrlsBOfHjSExrVrZUkcdSbqte?=
 =?us-ascii?Q?mfwYfk6D7WFLYWKT3VSWwEau4qDDRVhcbSdpSVNpuMPujxpNVo5+JL/rFDYc?=
 =?us-ascii?Q?YwzrunEPS1EzQrfGGe/4UALYSgcEUwZ2P3JODDdRF4xbp+dKbIbNPlAn1ibi?=
 =?us-ascii?Q?l5srzH47JFZKO2ly21qaSP1FWxGFrm6ZjQAgQU/xzolaBO4D3mZ/k8pNCTmB?=
 =?us-ascii?Q?z2oru7NOdGBbZyvbiroCp4Tj0ch4LgtI4MXPPfWvoInWK3i21jbMHkA9lK8F?=
 =?us-ascii?Q?3Odln0QAdM1CGKOB/+nxYHzldu+s5/WqtjiwdxzOweXA/zkioERLHOQeG/Qo?=
 =?us-ascii?Q?oub9gZrqeCA96FUUd3WiN+JNMXOiv/ZoDbNNKi8rlFPTxEoQ6K3lvknvCYVf?=
 =?us-ascii?Q?89lACdjEue+Yux/ccSzR1LOAYHXPdqi1K+LhuvvNsUkaROey6fiYYnlRJhAs?=
 =?us-ascii?Q?PhIiOv3gx6GMobVIL/aYxH3vk+JtWphfK1aJFDflq8+BheSgs5/d4PWie67a?=
 =?us-ascii?Q?hWMYGU1qQWZtEZoEjRC5oFga5YtCsIu1J1vmtki6j192LO1O2WL7ckNgz1R2?=
 =?us-ascii?Q?Vf6DZ2t557AncNlWAGCugaAXN9YBN/hVZ33BizOvyDdDco41I+funJNM1YQC?=
 =?us-ascii?Q?DV7NQumuwnETTsGIJFH3cGWXGDNQDmwrmm49/XJ8m2GKFGgqJhpDWtoKrS8R?=
 =?us-ascii?Q?8tFY88ZUMaJTxvUTNg/VfzulJ6Az02C2Ut+7hQ3a5FJiHxuew6t9RCjsHGSi?=
 =?us-ascii?Q?KEw/jv7evoe/g8PD2lNY7NZpoEfmRYPaZq+fCi0KeJVUxo7AU2e2GZkrVmDZ?=
 =?us-ascii?Q?I7WOeYdr+ysfLV38Fsl/Os54YkBxzhleZqAFiJPTTnlNH5blQixymjXfdNf/?=
 =?us-ascii?Q?HJSXiWMUJLycOqmUjcdzOUJ0doN411f9QCqmZC/W4m15Sui6g8APuDEvDROE?=
 =?us-ascii?Q?FeTEA0dxV2HvIDZXjPdVUZhUcHXEavEpwxJaKrPWaRWwOIQ8SvFlVbEl5jmZ?=
 =?us-ascii?Q?xlCM3toyAoTImxQuNGxj737XibffY66R5KyPyvacSqXOvHUAqAE3mjRf3l13?=
 =?us-ascii?Q?M2X6eu3y/m4zeQsjmBGGU/GRPDQrvLJF+iTXofpQbiCcAs1l9EDzONiaXwFl?=
 =?us-ascii?Q?RbH39F2cdWOxhjJTQ+3a8UNlvXryUOJ5diQv85s+2dEIS3GBZq6fwwClcmTS?=
 =?us-ascii?Q?RTM8Fokp3MGRFkEkiZp2Eky0/huj0U0yWLDX0penzFnNFuogUXnBM2UK2zAF?=
 =?us-ascii?Q?QVKZP4YUDEqGTY84k2UJVJjoRnS5nYPGiZQZl2cVGtJ6coeYrRV0DuMH4QKw?=
 =?us-ascii?Q?nthhuNTmYcKuSO4Ww/MpNEoM3Es5E1Sp+JHPbeXu/a9PETE4MBbMLgzmpPHz?=
 =?us-ascii?Q?D19RECVziw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95571b69-f3e2-4f58-70aa-08da2ddec4d6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:00:03.5816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHmaMEzx3SFlJRKI6j9MvSDW72L4ftJwZOfZlMmvoAOCHIk394JwqqhSMV0KsD1E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

On Wed, May 04, 2022 at 10:55:00PM +0800, Baolu Lu wrote:
> On 2022/5/4 22:38, Jason Gunthorpe wrote:
> > > @@ -3180,7 +3181,9 @@ int iommu_group_claim_dma_owner(struct iommu_group
> > > *group, void *owner)
> > >                  ret = -EPERM;
> > >                  goto unlock_out;
> > >          } else {
> > > -               if (group->domain && group->domain != group->default_domain)
> > > {
> > > +               if (group->domain &&
> > > +                   group->domain != group->default_domain &&
> > > +                   group->domain != group->blocking_domain) {
> > Why do we need this hunk? This is just trying to check if there is
> > some conflict with some other domain attach, group->domain can never
> > be blocking_domain here.
> This is *not* needed. Also verified with real hardware.
> 
> Sorry for the noise.

Okay, great, I'll add your tested-by, thanks

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
