Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C1C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 12:37:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0A9860A7E;
	Tue, 25 Jan 2022 12:37:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u1_OXmjKYh1R; Tue, 25 Jan 2022 12:37:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A46AD607F7;
	Tue, 25 Jan 2022 12:37:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77CD1C0031;
	Tue, 25 Jan 2022 12:37:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED046C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D7BC083F68
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gy9lkAneGkn7 for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 12:37:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8650582FEA
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 12:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfLYbe/6jxu7GPPu9zMvH5XIOmrvAYiHfOLgXLCrZD5WILyOvHVRTAlgRiinAFKcPb2oaybBkL8LnVk6our7baFfQJ/8B06SwrGyx9nTNtL4fKJKQj863hkce3W/DYfvagV+0fg5Zfpc9cDNSyblx2eZ9ea2BFyC6ghk7cBhtrx3X8/rGIcerJlsoQp2PQX44wuq38WLgWvWqkFATQLT6kkGLKpjq86fNh+dGgBxe5dOZNDEfITS4AHYs6V1QeThOho4PYRHUqPk1LsRY42ko4tD/Qw+DJAq19nuquAo48IB6LmAdlJ6of5hZu7GxoGRGkM0uoEcF6q2WYAK08LCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVayoa1OfJQ4SRLhYfxNygg7WZ8I19J9wCHMAmR6u7c=;
 b=aMjZt+CzqTbwK9d5M48Xr/IR5K2SJt4+Wy/fx4QwKEO1+XTSOUA9w154TKcNg+eV2DjzA0Bi5hIogyObKHKWj1CzYeX4nZAzMJ+E1brBXT3zS59Gou7/L8cJTVcovFkBntkerU6OCyC9kvYJi7SVUTDhpcY+rse97hWzvxWk2uJn0iHkbD3NfY1KzGTCczBuFqR6u7JoD5HNk/p3InXNE4DMRZxDYueJTMSOXfFRAAUkG1qeU0+4uniwK6NX8gSeGNf8f9Ko+p9ZJ33CrClLZsRM+PjsJB7KmsnQU/uLHyveOr0m7WKSDALXWjCSnkvzFOqc9X9VhSJ2zkQB3LcHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVayoa1OfJQ4SRLhYfxNygg7WZ8I19J9wCHMAmR6u7c=;
 b=kj1657DK6B1LZCagjgKnJnLOPIB+oGftaUBEOsurj4jAzOMN41x/VLwU/YZuY5diE7h5UV4fG/PRzWjqhE2Yj11Q1KCKvvTm/zsgYl1NXiN4VK7mEk38npzD1MLoBKbJxI0fRxJ99P5ixnjq4KhniKvIrMT9bHUvfxsu7stNdqLT4xjcQD/dwjvf77YVHIVGJXSb4vm1+hUPYSpqGfgNdQ/F0HJuSDwzS/foZW+9WlVmJQ/77QHlnRnFJp9Ud07L7fHBPrsLcxRzABk0b0aaIghy+jJltpR6bZctanKBFt47rYWl3xBcN+b4F7ZcW9bDoeFFYb3rEsJdP2zh+Eysrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 12:37:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 12:37:30 +0000
Date: Tue, 25 Jan 2022 08:37:29 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Message-ID: <20220125123729.GI84788@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <33060cd9-9115-013c-7253-52a36aa467e7@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <33060cd9-9115-013c-7253-52a36aa467e7@linux.intel.com>
X-ClientProxiedBy: MN2PR15CA0032.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee57e80c-b561-4fa9-59f2-08d9dfff740b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB51388D9C72C04841283698EAC25F9@CH0PR12MB5138.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uh8TR7E7PgVVUzmltAmptc2ZBiiXxOS8JeX8PBw/n97MCndKer1Inu0loB356/WjEKdRvdcxXA9Z4zw7ErsapzezhjJZJO/f1RFA7EEwmd8bWlpdUnjUCSfJBaB0nMk6DEfHhIR6IxE2HCl8jgQpIbjVGnm+CNUDdxYCW9Asi20GOYuIgiHZRPNJxT8K9S80jagsabwhN3RqCTPfRfelmLSgMpezghdVLPNMjKAYVZJp/2TDhPDTOnEo1pHoDP02KOehYLqSnMxpXAJh4f5fSg+LFitLmYP7pR5zzA2niYkt+VqqHCSManhCbz0rLSXkpdfB2M96FMhk7oMASMORdaOsG7LQX13DloX95fh7qBryxXR3zq5IigGTlSZEELUmjnHXICR/xOfdB2XJmZYxT+iGyhl0dadqDeTuDswAb26Y4LHFnP46bJGi037fNRhWvjSiv1pIGgU6z8aR0B5BkIf5Z9V1Y5/prLwrCyGKE8zjU9AKQNA944aDb9h0x1drNftPs/EmcwZx9MzJXuo/hw7bhVqaXZ/BhkDzJHfPDGywcClrEYFR+CJN14GwW6FNmihfsNM25ZqdN4hRk3wjLgtRsk7YxfwtBn/2zL8mBV6S0VacvwbVSqHh3lledhFqpfjoNpCk052See489JHxkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(7416002)(508600001)(6506007)(186003)(4326008)(2906002)(36756003)(6486002)(86362001)(8936002)(5660300002)(2616005)(53546011)(1076003)(26005)(316002)(33656002)(54906003)(66946007)(38100700002)(6512007)(66476007)(66556008)(6916009)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LtbUfj4D85iHgjSDH77XJrI5ZA16WG08E/M0u1fzHH3PfK4cDEcYlvdXsnLl?=
 =?us-ascii?Q?vmOhQ++LMIbhvAkjrHHCdTlokJ030sYxghozR4Ie/K29LiKKhoYF69cOo76z?=
 =?us-ascii?Q?T6D19YTjWPVXcnr+U60WpD9nBcx63GBOoIOESNUBBEV7l9UntwR5cxYd1QN+?=
 =?us-ascii?Q?Ebct396oex4jsjDxXzUjbtsyRPxHAA57a4DOTOs2wlY6bU5m5NQ/gB4yRvn2?=
 =?us-ascii?Q?UVSGVEqn+hezeVOrGZzk5YzfFC4g0tn5ZhtxSp0fAeO2h22e/473WiThBNm+?=
 =?us-ascii?Q?dgWM+xlgxXdtQN7hAC4ObV261ODsbmT/FPk1SjzUlJYUo5EV4NyTMGNevZOC?=
 =?us-ascii?Q?xrQQC/Hv4isx8aSmkXbJVgl44TWglkB6hZ1Mfjx1IZQbUM79jDcrUy2JqwWe?=
 =?us-ascii?Q?psQ9tfuO/tA6NMKnMMRS9xuChQKJtJblAAppyEe+em17k3I0mnOPd/O+MUoF?=
 =?us-ascii?Q?NfDyblGzjKkVcnUhG7FymSOGbMVJ3o/LlXOMho/jeXsMmlZC3PmjXbRMZVx2?=
 =?us-ascii?Q?TAL8s7oQLeYHtPhQdUZydPu4xwHcpobGrecQTECIQ0mQaLV+jSBAUvodWwoK?=
 =?us-ascii?Q?kW7NZhMKMitzIHtRR4wcWGlM7GQ7t8l/D1k1vnvaUx4JP6z2CLxBf8g/Uk/J?=
 =?us-ascii?Q?Qp9y/AUDTgj23urmC6HrGUiOo4zR0WIfdN1o28HeY0tBP3LWDNHeie0+g3+r?=
 =?us-ascii?Q?YQQdeTUewDUe+7cmxWd4dLcDIgQwrSAPlc3qr0EwqXDiSScvUk46OhUhuB85?=
 =?us-ascii?Q?p5H50WG3kYSjUuJh/dSujky/+mS2TH3laFJGBFgpY3Zu9CNYYuFUjySuOH4M?=
 =?us-ascii?Q?bBnR9jhKX4+1sHHBBtfCCEc5VjXaK2nSR3AGvP9hMgRoqfYnrJL5LVOHUnVX?=
 =?us-ascii?Q?/J88njUgdTnKYyiqMAWHO+K464fBdkTeH5ElnXd0MUlX//9HswKlmKk7IAz2?=
 =?us-ascii?Q?RVUMwlcMTC1hJKYC/ekG6Hgjfdds1MV/KdKXJkxg3c7s9QKdwz5tSD+jCKR3?=
 =?us-ascii?Q?YCUn47CUjwU8f/efbCFj1hOlA26jdAfOrhB9RkK3J/af6Mqd0Ceq2Eq10R8R?=
 =?us-ascii?Q?if1+xYLMKYlwfql0CKCzFR2yMruPTfnUmEdZMiUKDeBRz8fHlltXfZNU5ius?=
 =?us-ascii?Q?3mgMlk78sP/8ZzdV73sT/LK3uTmVfcW85OW3BMu+b25ebJA5ZVnbY3/1V0Pd?=
 =?us-ascii?Q?Pi433bE3GcUgx5bCgUPIoU7iOBP7ARDRDeWGXy/qSyMONhTUzqyKs2IF392U?=
 =?us-ascii?Q?LJhADTqp2JCS2/e1bYJCnMyKFn8Gne57rZW6W3LHWmc4XdIyjhIRsLptqM38?=
 =?us-ascii?Q?haH2ps/8Ny/5YJTsR3KlENMiXQp58b2D9CGw3V91pxrtUz+bvLoklksTNqW3?=
 =?us-ascii?Q?dOsc8XIfFkPfUrvWIZuwrecilvegATl+aHkUuhThIz3QkJ886Y6wY/aRhgUV?=
 =?us-ascii?Q?RZe6vIslLMemPeVwcYNl/huboIBZ7i0NDyODaWbhrWBsgPW4NTLjPNCoN8CV?=
 =?us-ascii?Q?Yaxkns1983as4WJjwAma8FgSu9saXHqU1Hia4ZUSoOHaFN4QTlLz65OPQFq7?=
 =?us-ascii?Q?A+eev/OfEXgWdn51SF0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee57e80c-b561-4fa9-59f2-08d9dfff740b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 12:37:30.7441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: erTqbzItaWigIKcMoLo+TY5ZUnpBtxPy0O7LPstyoBeXMFCtl4B5ZFqPYhUgoZnt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5138
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On Tue, Jan 25, 2022 at 12:59:14PM +0800, Lu Baolu wrote:
> On 1/24/22 5:58 PM, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Monday, January 24, 2022 3:11 PM
> > > +/**
> > > + * struct domain_ops - per-domain ops
> > > + * @attach_dev: attach an iommu domain to a device
> > > + * @detach_dev: detach an iommu domain from a device
> > 
> > What is the criteria about whether an op should be iommu_ops or domain_ops
> > when it requires both domain and device pointers like above two (and future
> > PASID-based attach)?
> 
> Generally ops belong to iommu_ops if they are only device oriented, and
> domain_ops if they are only domain oriented. But it's really hard to
> judge when both device and domain are involved. Good question. :-)
> 
> Perhaps we should leave the attach/detach interfaces in iommu_ops since
> they are related to device capabilities. For example, some devices
> support attach_dev_pasid, while others not.

Isn't the attach process for something like SVA or the KVM version
actually rather different code?

Ideally the function pointers should help minimize case statements/etc
inside the driver..

Or stated another way, I expect drivers will have different structs
container_of'ing back to the iommu_domain (ie intel_iommu_domain_sva,
say). Any code that needs to work differently depending on the struct
should have an op in the domain so it can sanely container_of without
a mess.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
