Return-Path: <SRS0=tLZ8=KU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBE1C4707F
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 19:53:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE846101B
	for <iommu@archiver.kernel.org>; Tue, 25 May 2021 19:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE846101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13EFA83D51;
	Tue, 25 May 2021 19:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qxPX9qBNUZU4; Tue, 25 May 2021 19:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A28B083D46;
	Tue, 25 May 2021 19:53:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 891CDC000E;
	Tue, 25 May 2021 19:53:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE677C0001
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 19:53:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC39760B49
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 19:53:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QLy3VImA9EAt for <iommu@lists.linux-foundation.org>;
 Tue, 25 May 2021 19:53:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::611])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9832607D6
 for <iommu@lists.linux-foundation.org>; Tue, 25 May 2021 19:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfZjo6lD8cvWwxfP2chaopOw41rQUFF2Sha01+QlAaZQzCBUGrNMaVXt5Nd7ML5uAA0GWvuNynnpljYzBlxri62JcEePOg4jBdXx65CuLHi6BbMZb6z8Ees3qoV4ezSRuFt+Oit1LR0J1uJT/Z3dqs9HZaPjvo6S8u3AflR9i8LQgU/XNGXtumqkGL7s7/e9my3sDcgDFZqAgW7VLe23IqiCZlBXiZS8yPR1iO1qMhC3HhTNggCMZuKHIhKnbR4u5EElJBHYt10rNx5PfpbsCEuGGpjrcPA1e3TSn6hV9jMk+HmFHyJgMIAXadRRqN4F5NkiwFSKekFAUgInW9Ku4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ez518mnFOeVKnb237EN1Z0Us45eGb+SvnOrdSmi2FQ=;
 b=jUM8bxFbwaZ1ZaQvPFp7HYKkHhdHruvqaGusjYaiZ6qLhGC4Z1mNCMAEkN1uI5xpmgusI15pbe7pImLKzuxBiwUkQuA0K1fEVgQHalKb8E+MhCLjMHVJlkIVD3qGKhUAWdQX111aUbDfb8gkU8ezscLD/vpR+r9SJ3UWLHTsMrXVdDaAK9wQWLWa/5T75U7E+5O2z/TfDIAL6ITGYc+UGUnkkWsBOn+xgQzmybyVDykJlZFYqnslJTaJOwzG/hSeJ07C1T1+Lv8o/GPkQ5tU4DKHY/0yDvCOaUOawIx6e3ssl7FlnDIxelJ+Wu8X8tzPzR0qlztjmocn4srPNbiDRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ez518mnFOeVKnb237EN1Z0Us45eGb+SvnOrdSmi2FQ=;
 b=AXt88h7yrqnTV6zQ6EzJrOpllPEsiyz/yMhcG0r/BS+BuZq3zmUMROTPI7bVZXPOv7LpYZ/UE7hgfDqQsEmZofIMOr2avqStIlgc+lFM8nk/y3FUE9a0mMS/pWrfSrDgdSmhVhvBNikp3n0nZHAOMKyy06wxrS7OOIRLIzJJ7HJ6mAcG0b8+ABSSIHkIMd+bdkzTG1gns7vFJhRz9um0FV8xcMSxy/fv2LaF+6F68N8VMwAu1P9mlpl2xFq21CmXP/+BHpOOqhxH2zruZ4XX/JN0gY/ArcPfc032eBlTAjm3mhSZa9THx61MxKdwR83DeTT3yMhgT+y10qQe7oELvw==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5521.namprd12.prod.outlook.com (2603:10b6:208:1c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 25 May
 2021 19:52:59 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.020; Tue, 25 May 2021
 19:52:59 +0000
Date: Tue, 25 May 2021 16:52:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <20210525195257.GG1002214@nvidia.com>
References: <20210427171212.GD1370958@nvidia.com>
 <YIizNdbA0+LYwQbI@yekko.fritz.box>
 <20210428145622.GU1370958@nvidia.com> <YIoiJRY3FM7xH2bH@yekko>
 <20210503161518.GM1370958@nvidia.com> <YJy9o8uEZs42/qDM@yekko>
 <20210513135938.GG1002214@nvidia.com> <YKtbWo7PwIlXjFIV@yekko>
 <20210524233744.GT1002214@nvidia.com>
 <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
Content-Disposition: inline
In-Reply-To: <ce2fcf21-1803-047b-03f0-7a4108dea7af@nvidia.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR18CA0054.namprd18.prod.outlook.com
 (2603:10b6:610:55::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 CH2PR18CA0054.namprd18.prod.outlook.com (2603:10b6:610:55::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Tue, 25 May 2021 19:52:58 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lld6n-00EZJr-Le; Tue, 25 May 2021 16:52:57 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be89c40-09f1-47ae-0493-08d91fb6b288
X-MS-TrafficTypeDiagnostic: BL0PR12MB5521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55217D30978B485A1881154BC2259@BL0PR12MB5521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcYzBgMBwmCyA9GAJfKAP6vgvuhyI0224iru0w8FGsS8OI/Z7nyLGsBBOc0Nx+T0SIAJMeIl6BYZ+RiynL0kI8aEkXdnlDx5gPJw359b0z5Mo5VA0V7+/LbX1j+vVwYJKAWvuL3FkGESRNHQFu1DmOtgJJh2gOLit3QSGlFsN0LKvsHKSmeCF+xKwb5nn6Y38ehz47bMGDlD2Ijop3kJT1vkHnRJDF5IkMGUB1fq9njhq1LFDR5WC2QtWXmTYujBvOHv7G9VHBzseDBENiheqMRWlEaZDj+DA/e9E7qQIDTM0aLY7VFp/EpslX28TZLQdGaHDdcJ50Yl9mr/X8EgpiacXBOMnMPgaSMSdlovEe9OldNLScoFJ34yYecIj5nvr8R8xuaS+/da1CmgtAJxbw1G8DasvUUNw5KccGitCnOFl1K5nhEGcq5Om/p4uDG5MvwE3N0z8hcHTtrjrabWqRHbKTTJ0kZWIQeys7m1uzmZfpmUVzJdKUK+x6cdGJqN85TAmvTix+JnlJc0CnLn1wZPygxqzlM5egLSDMP9b6mFqs3qhNU6DDVm9HIZnMKX4Wd5wNGoHNQvHYD/Zw8Lk3wmhI530mmmaKOECH8e8Oo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(66476007)(4744005)(66556008)(6636002)(9786002)(9746002)(1076003)(478600001)(66946007)(186003)(7416002)(5660300002)(38100700002)(33656002)(8936002)(426003)(316002)(2616005)(54906003)(37006003)(26005)(8676002)(4326008)(83380400001)(36756003)(2906002)(86362001)(6862004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PqpTzPeLrGqySkDwibZPooui5XgVefXqhYxRW/8nRuJlQ3Upzq2Jsriqnkqw?=
 =?us-ascii?Q?WN0b3SdvH5+nuHEvgY+rxMGmJqbPwoF14r0uIqT9dX3ptBIr30r0C2AVl94+?=
 =?us-ascii?Q?iC3yBxCb0CK+NLnCK7jd25IKqGCLnZlJa0W3vJiGJqEJiebK9RUoDwxZJWny?=
 =?us-ascii?Q?zXlsdFni86/fXu3vxVhFwfBYoOB5obpNfqYO9LMtJpx6CEo8j8pR6Tbgw+r2?=
 =?us-ascii?Q?UPH4iZScA6atRadR/wOA+YKnHu++5IZM+138X51c5kHilzIZVqVGPEb4qNjK?=
 =?us-ascii?Q?V1PQCc9pHBpVRCxz0uGQSfcwQjceJGe20oqMnThjRq0bcqgd7WNYqJTp08sa?=
 =?us-ascii?Q?Abf4nK7Txh/s2m/38Lo+DUUTPf7xx6d005Y1dZ6L8pSGVIBzyCfU0jMPVxYW?=
 =?us-ascii?Q?JVUv42Rjj5GAHHlK0EjhI2v2aqYqiRSb78XUlf7mTVMbAW1fUswhUTgrHAYg?=
 =?us-ascii?Q?3GLY4hbLeKu6ry+lJblYr+0pBPFirqib3ddyjJz1+GR+aCfos7YqtZ5Ao7oa?=
 =?us-ascii?Q?0pPF4Mdq+MfwPF3cPW2XRFfDoyE/MbbZDeWRxL+LyBZKYx1bPoUxxc9MzJfw?=
 =?us-ascii?Q?/kuPJvkmNVMT0q4Tmcb6AmrctHZS2sVZO9hBx3cXiFWpPZNYkXKBTGpsrf+R?=
 =?us-ascii?Q?wJuJXWXFAyeYD6CuF4pq7J1UyE+bSlWnsfC7k5X1ZcRcdVd08VZFyjI/Bo26?=
 =?us-ascii?Q?UwoIJxm3HYs670hPMd0tJE7kML9fgb/bH7tFeSRCeySskBuGlgUvRtNfQdir?=
 =?us-ascii?Q?Jp0bzs24gbi+BLB6+05SChflnzV764twda4I1YTSd/lkZNj0lOKr7K6HHFnF?=
 =?us-ascii?Q?S325POT7jQoPTcxfYFYLX0sJ/qFMZTiSkBlgOMBQ8+55y5p+LOUTOAqf0gyx?=
 =?us-ascii?Q?K7K7WUKNENIWSqN/97OFkUiXN9bNXUoF7QlK4vqCYCRVLSbT3Om564/dyOOM?=
 =?us-ascii?Q?i9ZFB/ObGli/mnZ9HH628gQGh76Wf443D9BEuoE0QuDC4GWvyjSMI8+yu1vQ?=
 =?us-ascii?Q?1vnHhPYNXD0ICmqDX7Dae6W39oCFC1ZAYMtBL3TIb0/ixl7EWG/vccrYiEGG?=
 =?us-ascii?Q?PtOLSK3qNgnniZRqKlpqO1itkgmuVRajtKZhkB7cVtRnTU/eonb2Cue6/U93?=
 =?us-ascii?Q?QgC5fqlFolVbOeBmGaN8ItAYKm8w/RBQqN+udN42qANtZs3bejiUv/NoGnDW?=
 =?us-ascii?Q?CXnseXISrZ3FjLmhHgjzALVeby/QzQBifprHMBaH0dqcMrH5pI2xaJ9VglS4?=
 =?us-ascii?Q?YBhe+W/+biDCfZmirppGeJgWk0ohqZyCYOswmyeSX4Kf/PbEMv+s3z5AHoCm?=
 =?us-ascii?Q?KfVBYqaQDL3M7RjvO5kJKWii?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be89c40-09f1-47ae-0493-08d91fb6b288
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 19:52:59.2191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EAhbALj8xkmFekZCDd7M6Onp9mi8lu5Oq2VumOFiEeu7Z7vRtCkL27KqWCJd4gPU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5521
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Wed, May 26, 2021 at 12:56:30AM +0530, Kirti Wankhede wrote:

> 2. iommu backed mdev devices for SRIOV where mdev device is created per
> VF (mdev device == VF device) then that mdev device has same iommu
> protection scope as VF associated to it. 

This doesn't require, and certainly shouldn't create, a fake group.

Only the VF's real IOMMU group should be used to model an iommu domain
linked to a VF. Injecting fake groups that are proxies for real groups
only opens the possibility of security problems like David is
concerned with.

Max's series approaches this properly by fully linking the struct
pci_device of the VF throughout the entire VFIO scheme, including the
group and container, while still allowing override of various VFIO
operations.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
