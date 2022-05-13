Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2100C433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 19:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EAC8404A8;
	Fri, 13 May 2022 19:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yC_OOskiQirH; Fri, 13 May 2022 19:06:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 110BF404EB;
	Fri, 13 May 2022 19:06:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7426C0032;
	Fri, 13 May 2022 19:06:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D41DEC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 19:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BBEBA8315C
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 19:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RiewtbkKBSjE for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 19:06:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD5B383148
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 19:06:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVluheBl5q1NVy5zICsPTUYPCslXEm3qJAAXDn+gEgxIf7MaZ0smffv7ojf/7u84lAds5aOnAZdm05IbEJ93JbMXbcm4EOgLiVUDrSNPjtTHLbDg6DlcKAeR3BvVgvNFRodZo7HXel8B45HyVKw9LzAdEhLCgb7mJjdSPsS2udN1AnaEtAasX7SuiIzA1CXAmW7/iroEdOlD0lNTiU+WOjaYFPMDZW58albvZAIEy5NuLbYy46b5dMSUBP1BcS3cDhz1+XxERdhiEpnT+Nc7i7+Yj/ED2njhVuaQjCwNyrjBp73zjh8DI4H9sBiRkR6nGlTZGv9EkimzVA7NeL89vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7TugaAgWAhzr7rY+7UWV7rebYfTMDpZLXYoLwFUnmI=;
 b=egeMzXIkObGUAqfzsmO2h0VWaWYbz3/qRpOSY7OG+4XNsN3ATkx09yQjfl+uB96r5bFITgHiJfid638CYDBGD6nEas/guMDKNV/Y56RdQBWTFYRETPsTNjwSznl+gVtG/Vz443TDKu6utmFJESUjhioYTbSAtvBlaF2AWgvB6qDVjRY3d101+Ru68QHYZ17mFS51mN/NQdeOiI4pCrXo/frgO6/RPj94uQkcwSzEph4CEqzz/RsjRHLYo7NTjPXmC/uhfOpyy3ZK+5H1kzHoaiHA0rtbI0EyMQ/my8mEjAOqtusaqjKlTb7k9wDp+febukJpeur/oAr11yXPdLInAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7TugaAgWAhzr7rY+7UWV7rebYfTMDpZLXYoLwFUnmI=;
 b=BOAnIIop1ks5bk8MUaMpO07NLNKlPMjDUlnniOkXzZC4XeAmC4TDFfuweRDG0LyLZJeZ0SkLUERINrX51f21Jq4WoEoyn5b1EvPmpm7OM9hs6rLTg/XtulIKnzHa8rIXA6c3jGAjkvASdseJB9ir4wEeoVyZYJ/SJLQXCH+5jA6hefmDjl4hbMEhBSey1FcYk3O/jLio1XrFmm2T+A4HrsFTb0zBn+Miu8TSnMJ/4RTEB4QDztoDM9pT/T2HbbdUNnkktFM0Iynxu11vWKYydNYKbrRh48gzkRG7asdafwXNG6uKx3mIcGYrscvg58zLF4MGuN8NjvjDTQVJxemQYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 19:06:18 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 19:06:18 +0000
Date: Fri, 13 May 2022 16:06:16 -0300
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220513190616.GS1343366@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220502161204.GA22@qian> <YnI8Xy54M3XQpS0T@8bytes.org>
 <20220504102956.0f5b5302.alex.williamson@redhat.com>
 <Yn5+GKHlQlX5bszi@8bytes.org>
 <20220513102548.5cf2a3aa.alex.williamson@redhat.com>
Content-Disposition: inline
In-Reply-To: <20220513102548.5cf2a3aa.alex.williamson@redhat.com>
X-ClientProxiedBy: BL0PR0102CA0059.prod.exchangelabs.com
 (2603:10b6:208:25::36) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80745be5-c1b1-4d06-e689-08da3513a8ed
X-MS-TrafficTypeDiagnostic: MN2PR12MB4176:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41761CA89647E3C35366AF45C2CA9@MN2PR12MB4176.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2cco99tVOMQgIPUFl7/DPCPG2i75h4ypDopamyj1TIbEBV9oGPEHlY713ZO/XFJ9RrqU25WMwzikF/en0vv0VQkLghVkBZRQ2sePoZLEXhcOEQfVFJzTOhETjHdQwgezOlRnBl+AjIzSFGZxEYyMlSrhTKiq/3+oqEaCT9XOrvC/uvcYiXQ4QxhO9OFHxdKDCO7NtNSuk6hxYgUzz/1QeFCM4whveQh8emGcUlUU4Oi8S6A3+1EMdVEBpKGBpkdFPVa3a2YqRRK+74Rm9pfqs7FUmlVn8BiK4oSDWRoPTnIzNH1epz6CYwFniUK97iYYfYr6DTSc7PPoNhmElSx06j+4VxgKWGxVO7NJ/AIQvvKA+WI6USs9gl9lvscOuFO1K4bTf2aG58pRj1Px6Kk3OpchJB0I8WnuYdpVoRMf41R5uY7CH88mFIy56k/dIV38bJcb54DkzgAVjbPPM1noCXXJOQjrmtbyCkf/NCEWJXiclzVvAYmF7qHV2iyaqCgH3wcI5m8stfprNwX9qwazVZAKg858yZ6KSN6BI/F0ZHbdyH2V5PnMSO+uzrAmEHF7rFHDENKlTgme2GNmcTy95o1HMPHQHGhAxIecmamX46Hx2dZ+n5cYIuiXPHr4pHHALpSRk+7hq0Y2mM8DWLaAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(66946007)(66556008)(36756003)(4326008)(86362001)(8676002)(66476007)(33656002)(6486002)(2616005)(1076003)(2906002)(6916009)(54906003)(186003)(83380400001)(5660300002)(6506007)(6512007)(26005)(316002)(4744005)(38100700002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/tEZHaXa4obkojNQswfc4wsTJrbz0VzKgfoN9G3++Ugz52x52Ss+N2kuOXsr?=
 =?us-ascii?Q?IlWeviLLTa81jeX/EqCmtzSCOA9yAMrLwDMAtuK6NpJ+ElsNELl1Xt+vrBb6?=
 =?us-ascii?Q?RXDVCugwziLeeb1nxTHJKImQnYraxyEGNHndgaCXnbitsRpURUrnMuQ4Q8di?=
 =?us-ascii?Q?l2NOecqqIrwMUJR1mzDIh2vIxMDPpDSsDuGA619om1vSKkwKjn215TbgzADD?=
 =?us-ascii?Q?pu7zaTLXQhDk7Yb7Zm54gyGgupCgz/eeBl1GMpESy7uV2bvtbR2ZOU+RgsBt?=
 =?us-ascii?Q?5oy6Bi38OtaFduce710jdrkxQFWY2hLBx3aOXHZgswAFZKURDGtbFIcQ5gZs?=
 =?us-ascii?Q?tQV0rcmM4zEdOjCvLqwLFW+R3XOqEozsXkSNV3V6l+lXcZkvTA3VoNVXPh8R?=
 =?us-ascii?Q?inyjP0wmZPwrohg4BGCRejjtry1Vmp6khCbTgIwSYG1RUzaaGJaJg1LsRE54?=
 =?us-ascii?Q?v0UfUT5JAqq1Zo9SpMgT/ZjTuOhGH3BXhQtinr099XeAKVihgez/XqlCNUom?=
 =?us-ascii?Q?VIy1bUrhw4B0GWLHAqZFPItFqGSPXMupcuoMi5K0yb74yGFd5HGZC3fLpdw0?=
 =?us-ascii?Q?KjeGgqithqOS7j3FNEcojY6ogItJUQmgwi51Y7YM/opimkPebtC/FnEma1nu?=
 =?us-ascii?Q?BB0mh8zd5pRj+9PXPxr+MEI8HRyeYnKjO6EJZK3lmgA9HVO/M/i4THSPy1pM?=
 =?us-ascii?Q?wq9/MPYkAwbe0MZEOQFC0HUXJMNYpXd838xXdgLHzlVVu6iU+/N7RlCrCb0v?=
 =?us-ascii?Q?Zu91OAcjmsMTiJBY28TS+QXXTlpZQSwOVpuLJr7oRgCOLTNyteraP/a49QZN?=
 =?us-ascii?Q?XPcdE+hNYCxayKFXE1tZ40D7y3ANJWvk8cv0igI4kkfk0pwYNhWCu3ZXsiPN?=
 =?us-ascii?Q?2Na7H7WxpKg8inrbkK1/wYnhHqJD4buDZWHJw8cDrni/QlaNDC9NnWolxpeT?=
 =?us-ascii?Q?uzpCbXrX7egK+xj0nJK3LcQeLQi1yEolNSQYju6eKF0VUGuEqmUTmZ+X2WcM?=
 =?us-ascii?Q?3GWKzic4p/vuge1EOD5w19MnDnhSsNW5UFpX61OnB94SJA5qY5G7/ISMnZ1Z?=
 =?us-ascii?Q?NKPGOnD10v9ttarbe/R2qkveVZyJkd/NP5tjoXh7zBBocfP07VgTop3Ytxt0?=
 =?us-ascii?Q?bTNM9k2lwlQUyh/O9pie6Ys+yfuJpdoJgUD0mamhHylGWBumed7Uei8OFZel?=
 =?us-ascii?Q?3SM1ihs3LflZVDB7h6/aSk033OPqlyN1CstUtdl7G+PbTp99voV7zb/tvnyC?=
 =?us-ascii?Q?4qwEJz6rDi26jIXb9Z4IjMiM9LLIJkIEx9yc6eSxUUYfOJYWWr4eDCQBrNA6?=
 =?us-ascii?Q?Y1HXRD9H2RfVXa9xfG1d8kBJ6F51a4u9bhiGd9X8MDB0MsFSTTyrtsVsDtGh?=
 =?us-ascii?Q?IgbmsjpOHf+/0JKXErCEGcXzthJta1mvLB1RSbkk+x+jGap9WVI/H1Ga/neL?=
 =?us-ascii?Q?dw2/Na6liVN5cdgm8xn5rFVmnwkqsAH5bYLWrO6jg4gMZfQq4JTfbpTtmohv?=
 =?us-ascii?Q?yPlDhei903zS8OyMvmeq5fNc/ItwG6mpfLZkyJVg13yPoxqoYu8FhRaVnITY?=
 =?us-ascii?Q?B8yPCNphQk/BGqWZvnsj/QttTu/xC/L5zOHAOsglk/k69eyPgL68rPm72DZQ?=
 =?us-ascii?Q?ZYpzxM8EhKzvlYEW7QRwSAXL4iMqiZMRvH/d2P+AiIeipvMu6VwkwTvj1Zsh?=
 =?us-ascii?Q?X2Ewrr9C2iH0t3BjccNStTig9tT3DYn5PczYwxgUsL2xide8l5bbootvxEek?=
 =?us-ascii?Q?gpPYn0DOng=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80745be5-c1b1-4d06-e689-08da3513a8ed
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 19:06:18.2722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7PoV66bptYsj9vvaAo/+4F8VOMgaiILvqzsq/b2Mkk/Fwb70OItzQS7RBiz12Ge
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
Cc: Qian Cai <quic_qiancai@quicinc.com>, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Fri, May 13, 2022 at 10:25:48AM -0600, Alex Williamson wrote:
> On Fri, 13 May 2022 17:49:44 +0200
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> > Hi Alex,
> > 
> > On Wed, May 04, 2022 at 10:29:56AM -0600, Alex Williamson wrote:
> > > Done, and thanks for the heads-up.  Please try to cc me when the
> > > vfio-notifier-fix branch is merged back into your next branch.  Thanks,  
> > 
> > This has happened now, the vfio-notifier-fix branch got the fix and is
> > merged back into my next branch.
> 
> Thanks, Joerg!
> 
> Jason, I'll push a merge of this with
> 
> Subject: [PATCH] vfio: Delete container_q
> 0-v1-a1e8791d795b+6b-vfio_container_q_jgg@nvidia.com
> 
> and
> 
> Subject: [PATCH v3 0/8] Remove vfio_group from the struct file facing VFIO API
> 0-v3-f7729924a7ea+25e33-vfio_kvm_no_group_jgg@nvidia.com
> 
> as soon as my sanity build finishes.  Thanks,

Thanks, I'll rebase and repost the remaining vfio series.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
