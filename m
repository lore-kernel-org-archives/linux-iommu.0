Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD8DC433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 13:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3279F409E9;
	Mon, 13 Dec 2021 13:59:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oFJlTUOqXYDE; Mon, 13 Dec 2021 13:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB4DB400D8;
	Mon, 13 Dec 2021 13:59:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5EFDC002F;
	Mon, 13 Dec 2021 13:59:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FE5CC0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 13:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 30CE741FC1
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 13:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LSyyxqv0nEqU for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 13:59:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7474641FBF
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 13:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWduDpTPrdlz2F1PQT4xAxJ88pNf4Q3BtFwq2i/Av2HZCKUB/MNLdi5hIWchV728Ga0BBWyMR6eqrUQ4UNN0JtzNjEjoiYF1ao9yPI5PdpbfkE/4bhLVQft/Sho8stKExX9OGZ9fmgcMst95LuqpktSZdj6uu0m4KuJmxlPdi0fRs4h5OTrGb77EnUWcUiTcDfkSLIlCDyEyEfHXMpFQzMisMvK9MRjAvc9t+jNO/i3TRkYqm0v2D2sQO4IpZSg4J5cipFgAtd9nUEwFYhy1A+JudbHVdZEHlBFzES+A6o4H6ZawzD+3Omznt8ynD++3bq64k90XDQMfi0OavPeOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkFPlW9TvxlO7m5Ez9bnzEycr+6qecCL+TDV1c0gS80=;
 b=Lm9HLiZiCY8AIxSjn2Is6VPo0aevAnjVKIO0P9/EaADlvCYKqwQh3oEeqiZP5OWSJCpQ4nJzt6YXMHE7JKKcRTsVtfOuoaUFYS46HdGoVIw+FFBN44YB0ov861FJN4vsQYKsMdIb5VXNjNLRZZvLlXQZ+zD8IX5y5g6gMqnwVjXdfscOHnJhd3gXzUHFgjx229V5G8M5yKkN1ULAFCMcQ2g1VNK5P4KJogL6SY3xpEyNSLeKGp+3pu5voAGfppUNV7PCqeJFcw2TdpsHX1slh1hfRJ+mTMNBS7t4LgF1AbTabKWk9dPqZttnEYDKLw6TbO1DoLh8DwR7toqLCWEuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkFPlW9TvxlO7m5Ez9bnzEycr+6qecCL+TDV1c0gS80=;
 b=lK5g0RwVgVZDA04NQ9WLadJYw+ktHVuHTYgj4FD9wtqZTTbbYBW42dopd0h9bffpHc5HhlpAaM+K+SXL7oYWLGcKOCgzc5eiG5fjYPK8KPYbmMPkh1mMTvAHuiF0ykOQwwbmFYtZRaXOZrqJ2Yvh2M8EhGpCCjZEn4tSenlIFkMFfQT1UQqc/Eq6CNboE/rExRLW8SweOBVCLtcbhQjnRuk2CdUIbD0c+6DFX+UJKCFGw5bJgKsN/BbKoGZAc/vmBvJJB2fgo6XQspuvAxnUW1O6N5K0+bAbDS8eW9E/yap1mPCXqj0mYze/7Dh7SeghbaPHuvgjPPK3Wa2UUGK3/g==
Received: from BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 13:59:47 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5047.namprd12.prod.outlook.com (2603:10b6:208:31a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 13:59:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 13:59:46 +0000
Date: Mon, 13 Dec 2021 09:59:44 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 04/35] genirq/msi: Use PCI device property
Message-ID: <20211213135944.GX6385@nvidia.com>
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.434156196@linutronix.de>
Content-Disposition: inline
In-Reply-To: <20211210221813.434156196@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2faabb0-ea2d-404f-acbe-08d9be40d20c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5047:EE_|BL1PR12MB5255:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB504724086171BB12633D5224C2749@BL1PR12MB5047.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycHDvDrLkZdfcREf9UVFOZ5gfPMEg2VV1vYmaD0LwMlTdRvspoj00xOu5RbK1EljzErHG70TX7J5q7T1pzEMH97srnif6/79iV+KazbwOUEkAyql5bneWDrbG+qkngI1IPwSGoEmgqHE9CtvF0DbMF/sgzHD2O5mIIa7NmB6fUATaBclGr0DFGp0lIM41bT4AUVFb8XJ66QlIWYN6jl9YmJChXw/t/FoIoO/AjI0DND99qnF3B8L6HaRbdxO8ohdHfcJ8mrsQcu/BDuU7ddtLoSyJLFt5qiR9PSYkhy3yQd7l8ByZ7ll9TCsBZTTJEomVMnV2jqWxDTGnaNPLhw7K2FtExoi1Arj+VUzIdWbDbrQ9TQCRBN6WeLnaSHYKZXB1jiFbQ+wXtCpGnBnJMPVj/9A2MnaeVOaU846mwB+Ns6ogFLkJ8dfpCW6+FFqfDONsC5oLSGDpIZ54/bndPzzMfK8Oh1xClloyzUax2prFgGW1/toOo2hvSe+Mtp7uPsiDArSg6HGRK8+zqu1NN8xDc+sXHHI6oOyJJoCP0untf+P8OlpI9JuE4XvJI8uf+Z1M0xgJdb3mYeaAayTh8mbKm9ETRegMt7EhVOt8kFSqdpZ8NLk5vD4oCseitFKx0k5n2yMIIDh1SN48SHeh15RyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5047.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(8676002)(66556008)(2616005)(6506007)(66476007)(7416002)(7406005)(54906003)(38100700002)(6512007)(66946007)(2906002)(316002)(186003)(6916009)(26005)(36756003)(508600001)(6486002)(1076003)(5660300002)(86362001)(8936002)(4744005)(33656002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcWBpSphOyXV13f6ypuuUB4LZ4B4nBshQshtCz52KpTS9IaHuTL/SIU8msOb?=
 =?us-ascii?Q?JpA9QiS2gTxNbbDzMW8uwPC/ydTP5b06rpqUw5vuU+j0kSWTY+gJbwObYYy7?=
 =?us-ascii?Q?uzuRPHHdeblX4/7gyQx9PMPub6H7GxeMBn1Y7VYGiG23FZIzYLQ/dL6QdQJk?=
 =?us-ascii?Q?me5eQeHLeU7cz7Fxpc5VF2vXM5OJAt0iJNVze6tzbLLD4zsiWC9kqHv0zFeC?=
 =?us-ascii?Q?xWORturpoNjUPqUH1gD4jIp4KqnSqJSyguWsia+TP+wj9tDmK7/WyUzuQHyy?=
 =?us-ascii?Q?qvfuEgYuRHU5XHCYAbudqa+76OXo+MNf6rxrLiXdtkxgA7t1E+3g9tVj6w0V?=
 =?us-ascii?Q?oNOZKxncUVq+iENbtLRBsCVrMk5Hb4UCwJtUQmakL+2PKTPIuqiC0rpFA91w?=
 =?us-ascii?Q?F0JF/4/2ZTmR7/6CIR8V74BtaOFEJbb0KSrjkjHdQ2XuZwiDxAhXNo+Tj/Pg?=
 =?us-ascii?Q?1l9F9iCEIam7qWefv+44r+Y2aArT0UiV435/6nKr+WDphsTWTus4JB9IGzLu?=
 =?us-ascii?Q?rnAvqiJg9ZdgyMYO8gEoKa8LcNPUEnKcv1ICsgbc4BldseIM/Ye1xdzpfeep?=
 =?us-ascii?Q?uvxHUSbLmNOdg6UFuUy28kt7NE85lO+Xp5/hHphx4JrzGjeUAoMixDTj5L5k?=
 =?us-ascii?Q?vcAKkyzRcq56Kf0BvuYP96o7jeXDpVoeco9XFe254gmcMlm6bot/SiuGBlug?=
 =?us-ascii?Q?jNxqagoLwDpUBmTWvUpzzjB954QWvGIaoJ3FoZCNNfmoX1gf8ktVeasvBvwJ?=
 =?us-ascii?Q?mgP0R2RyWa2nFKXmT7j/0cqn3Np7fm/gatMKGPuQ7ZyiZCOm0xfL3UC79ls3?=
 =?us-ascii?Q?NbGzi0h2KTaCrnqMOHoKLVDFlIUjDhXtOYT8ljJehpYJIR82/MY027qmWyHZ?=
 =?us-ascii?Q?74bNyBB21Vh4F6DlF1xus9QU54GsBRx6rZNzjszQZkKYvZJ0XchweP8UOVc3?=
 =?us-ascii?Q?tw2WtV2B9ZaOrWFRvUO3FGWo+5S2HyHfEjIR9O2kqX9bYoSENmDt8cvu6nhU?=
 =?us-ascii?Q?2h9XVDoSlorDu4x5FlLqQgbXZLC/LgOSURVxnUw5CxyGKUAfx77GRtPAXJGh?=
 =?us-ascii?Q?vk658EOFIJkfSo6QfiGAnyu8TYF2sx2KxnYoj8l1y7I83R+BS1AkXjD66zGs?=
 =?us-ascii?Q?r6ZmCTWKQYWx0WbkU0seLLvfbRUlZfF4w/v+91nCXqdgttUMESe7HCJTfIsG?=
 =?us-ascii?Q?YIAyc55z5yL8ZE5X4dFfsTDWfIGxq1ykLukMmSsKf7qMhjFMr8qp3b6WhrTc?=
 =?us-ascii?Q?rKK4PmyTfVPGAH1mRP2gz5xbP+o2Lgi8XMosKIXjB/+cXksQ6g4mAgr2gwSm?=
 =?us-ascii?Q?QFY6xFfHmvkpZFv4DJuDd8A7Y2aLOIc9iic60u21jKBVLxPuJnqRrmlkKIwi?=
 =?us-ascii?Q?8vh+l4hD2n3DG4aIuVYptUTktDc0+G9CGeiHGemXDdycoWVU7/hu/CqoSDz2?=
 =?us-ascii?Q?NMwgVUB/hAib3JJp4B6yq+3i1gUH1o39yh2cJMaeQHYHcq+igUJLp7duqEKT?=
 =?us-ascii?Q?33xSD1WdZ3NWkA6G0wej2eAdTk7dNQQY20eQGLmAWzTjrI5Fm4thW+dCXMAp?=
 =?us-ascii?Q?4SURXOMcRLZuJ5xRHRk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2faabb0-ea2d-404f-acbe-08d9be40d20c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 13:59:46.3834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjp9tWRpKzBkBPyQzwWJU5qivgMmVf8b3FNdpQ3LqLAdCJxlLO7cM4LA5XsTTUH6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Jassi Brar <jassisinghbrar@gmail.com>,
 Sinan Kaya <okaya@kernel.org>, iommu@lists.linux-foundation.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Megha Dey <megha.dey@intel.com>, Juergen Gross <jgross@suse.com>,
 Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Marc Zygnier <maz@kernel.org>, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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

On Fri, Dec 10, 2021 at 11:18:49PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> to determine whether this is MSI or MSIX instead of consulting MSI
> descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Use PCI device property - Jason
> ---
>  kernel/irq/msi.c |   17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
