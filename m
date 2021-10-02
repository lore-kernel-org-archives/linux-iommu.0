Return-Path: <SRS0=MlyH=OW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C009C433EF
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 12:25:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D378161B08
	for <iommu@archiver.kernel.org>; Sat,  2 Oct 2021 12:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D378161B08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 988908413C;
	Sat,  2 Oct 2021 12:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L5xZiCljugGu; Sat,  2 Oct 2021 12:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 673AD84143;
	Sat,  2 Oct 2021 12:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F1C1C000F;
	Sat,  2 Oct 2021 12:25:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D63DDC000D
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 12:25:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3E1A425DD
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 12:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GH0yDrixDmqs for <iommu@lists.linux-foundation.org>;
 Sat,  2 Oct 2021 12:25:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF976425C8
 for <iommu@lists.linux-foundation.org>; Sat,  2 Oct 2021 12:25:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVg3A6fn5YNZ3xuimM5SG3evtL9wtXJBj+SLKRXnnm6lxe+I2PAMRrfHPGWWF5eNFXrzYrq7YdAAqOArwnG16Z4QBD7M8g3gJv3ijsrhxv/yKyibmMgu7Twp/KXEFB8mUlO41vs93o27iwinSokYizDxgWHMnwbyOpywa1PbG4YBBWO7ft1P0QdhE/f0i43gza8tc8V0CkBzSQTNH/0sskVm7TBrrn+BuhVKwnHRpc51Q//vjz2KbaiXE6Tbzr94ez0iBc3C4H3nL1C3EvpDr81XiN2qpcw7Q57JU5Ggwt6yRasugPK3k5HaGqVCkraxybelyr8w5MIUTnPpEQgibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3N8/C/nryE9k3k4Jb0SdZjzxciydUTyjJ+s+WE61e4=;
 b=ANf5X5pEBgg8HKDnhvo9urVtBmOtUSomcPIkauAkkdJTm8O8unPLSTnjIqIVptsX9R6K4p2H56gNsgSmmd8I+nIz+ukfy1df+YnaRHED9jW6uLDaebTDVxo/yziWNaARskZJjHJqFtN44qAhCdl3zzl+FTipksIdperHj99lgXDtKOmhIWUpbbi5S8Eg28r5Aqy3dbfsJwv3sz6Sprlc/sg2hxLZf9ifafAbHVBme8hIShCY7fba0em9PgUK04Dr1n9yLtUjoQRh7Hg8ziFL2SRpqFOcYe8OOgpGPnWFZi0Gh/YkGBv6LCmyozsQ0K7uajfNCxyuSJ8B1hOeIaXjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3N8/C/nryE9k3k4Jb0SdZjzxciydUTyjJ+s+WE61e4=;
 b=FDajHLUhYL5fshl/J1Cd8rLqq9qgXK8kzZgHXkZATfHky4+XnkBifr/eRWDo0BPyKLaIo4nHoOLUYDSfwjQdVTHCpB7vwv9GMRfkp/vfkfBV3nMLH4t2JwFNuIGJVtKHLPrUyuZ6hwrcJhwGjIc8df2cqVKCOvL1+QiElIAidsAmxKzXY8NUovs9PW+mv3UJGxeEM4QGcsE6mAMDvYR8J7zvQR+yeYrcoOCBmvMQOPUnLPc1HFsb6YS8IpywV5kzB8Mwl7a8CtRzX9G9iW2K1l7bNFHBimwjGE0DEnF0OJsknJLs2oVZh2JPszJBLXGWIzaTI+NP76Y3Sbvpjv3ojA==
Authentication-Results: gibson.dropbear.id.au; dkim=none (message not signed)
 header.d=none; gibson.dropbear.id.au;
 dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Sat, 2 Oct
 2021 12:25:44 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4566.019; Sat, 2 Oct 2021
 12:25:44 +0000
Date: Sat, 2 Oct 2021 09:25:42 -0300
To: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Subject: Re: [RFC 11/20] iommu/iommufd: Add IOMMU_IOASID_ALLOC/FREE
Message-ID: <20211002122542.GW964074@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-12-yi.l.liu@intel.com>
 <20210921174438.GW327412@nvidia.com>
 <BN9PR11MB543362CEBDAD02DA9F06D8ED8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922140911.GT327412@nvidia.com> <YVaoamAaqayk1Hja@yekko>
 <20211001122505.GL964074@nvidia.com> <YVfeUkW7PWQeYFJQ@yekko>
Content-Disposition: inline
In-Reply-To: <YVfeUkW7PWQeYFJQ@yekko>
X-ClientProxiedBy: MN2PR22CA0012.namprd22.prod.outlook.com
 (2603:10b6:208:238::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by
 MN2PR22CA0012.namprd22.prod.outlook.com (2603:10b6:208:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Sat, 2 Oct 2021 12:25:43 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1mWe5G-009i7Z-KD; Sat, 02 Oct 2021 09:25:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8375c7c2-a742-4a4d-082a-08d9859fc14b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5078:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB507881C234F494F7B259B83AC2AC9@BL1PR12MB5078.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpMnmSbdY7J/zk0yvUmlvbOWlzWb1sU/eDKJiHZ0+R0F/+EW1w5l9+KcMdxDIkWOeT4184FHqDaZra9DOsHlny9ooqIchkPheRdyenOX+PSmjn7UCcuItLLHDg4xX0fYTSsd9atEMpWAPKpfIDQzGSvI/AGQzCdkLIlbx1Vr0GcWfeSVeOgVzaSGF3pDviyaLGaW/pVVRjFxnIry0d8CE1UNmUA2qX1pq1vSUsUNEepjts8BfZuq6ubwFlWOmm5mC9MU34Ok6HfSGyK6OIxN4IT/ZlFVDss+Z4VZZPyvZP2yoQK9GaPzHzoogNjPSVDxF2PV1dhcvDUBaKah7Iqhbes1mO5OAIO/zHlYQF2rL1cu2qzdnIz5i5O/8aJd8UmNsMY2mt8jkhHRlAvt4pBZmJIA3jljo7HWAtZfnPR2GHXqkFDW3GIsOKl9F/q5xyVjK0TBzObaY0kSsqwrIezO/ZU8GJxSmumCRe0NXcwspIYekzexM5I4EevwDjdUhXAA1a2NpXWq7gOcTMHhtnKO+fPt1ybiN8mXOZLIJP61H7E1WpwKcCQNUUQHHGFCtXi8p5CASygFiQLn6tBKRhcAWrwwe/Q4iM1DPcCWgEPWGay9o5uopIiO5jvNtuzAVBQaLlTT3IiADeoqs0i1avNcVcu36pvrx8i+f8lyHXvxBhJtAK63KVzKP8ZTK49oDLff7Umt14w3wPIr2C1is1y2Tg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(6916009)(186003)(1076003)(2616005)(8676002)(8936002)(426003)(86362001)(36756003)(508600001)(9746002)(9786002)(54906003)(316002)(4744005)(5660300002)(38100700002)(2906002)(66556008)(66946007)(66476007)(4326008)(107886003)(26005)(83380400001)(7416002)(27376004)(84603001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6IV/9qFZNmkzzBTDiZuGwqV3b2VIX/poWeTWsNRMf5sZNT+4hHsP+kbLKHw7?=
 =?us-ascii?Q?13h3XudJDW7Mo5peaRuD4gMv4CDVYHjWtVSudXZMNOArG3rbnuiaoCPKpdhE?=
 =?us-ascii?Q?ORPq/xVRGM9qQ5XPlU5nzIhwP3+eTO3m87QHKI8pRXmtEJeWMqfUHH4WIbII?=
 =?us-ascii?Q?Lt0sQTd1vGz6WTxUs94YEWkCeyGwqPF45hRgMhcoX4UkPpdPe7rK+XVHev1N?=
 =?us-ascii?Q?SBITKq7oHTUaFh6wVFHRvDnmXZWBHJLS7O6IaKg+30CovQKit/siJ2GGFfxh?=
 =?us-ascii?Q?buLgCT2n/2QJDf2/ypVCIokw0BJ9h7WKEZxjtC0fNqVM02DFEXZdeuZLfy2L?=
 =?us-ascii?Q?ZKOUAs/PZUmTV3bh3ztmj/7Eiidzp0Kiat6nwTk5dyrnwGiwa6P/J7q4ITDB?=
 =?us-ascii?Q?filFQw20LaRzrhYxMtBF6xJpUR9FbOKGbyt2TqJpynsxLcip540DRpQEeOeL?=
 =?us-ascii?Q?DLy7dvfJ/twAdLKV3GJx7bsF++uULu5Y//QeLdLPjm+qLGncy2ZId/v+bUD7?=
 =?us-ascii?Q?XXy0nusPVn1i6NT9uLkpGaqKE1lEmVeV2/GyOQxq2xbAj840xgjKlb1R4peM?=
 =?us-ascii?Q?scaq55enVJ1ykT8kuzuzRptINuo3u1mn7PjkfyrctXYFaqhl4zNamW6Cd7aA?=
 =?us-ascii?Q?nLESdNPbv/37LdxdKG68OT1NbPIK6O/lR2cwRvJ11kFaQAM1h2MMzcIM6KLx?=
 =?us-ascii?Q?li9TKZ6y20w1MbQYxyEGVKH6eI3uvc7WpjSEPS65uknlH0dSW3m7i44r94NK?=
 =?us-ascii?Q?S8Dyfv195r4HCmeXuLZRlCZmf4JCp76iuNkK6J/DjaHR4UXGTKPyfkYQZC9Q?=
 =?us-ascii?Q?Uh7t6fkGFVrddFfDK7PVAlzHbPxjROmL9jK1liGCj8KGZbwqSm9oq89DESC0?=
 =?us-ascii?Q?m3KJ6I30WELeN0wSn9DhM7l/sbWh5woNjqt4ojZ41+zalNUjUaSE9u29LRtW?=
 =?us-ascii?Q?ShmFXehOBGNKJReEJEy4EKVpVbaR+ahnDDughP6ig5zyF9pSE8E11oHfHFX4?=
 =?us-ascii?Q?40xFoF8qZ6uCRyMaPJnhJGB/DctCsfaxuxfvTdpeb+hlwqVSjccbBKWJuqr+?=
 =?us-ascii?Q?P34xF3F2HXtAagib/xWfIGN/t4Lw8CnOVUSI7FlVw6qBPov/i0dtjY9T2UE6?=
 =?us-ascii?Q?AS9WZIUg25jxytjXk7wBW2i8RiEEQCy02+LaDZvIvCr6l5iJcnbQRXyI7Mkl?=
 =?us-ascii?Q?E2+j6XIgJg2svBCK/WAgeaia8JLWgW7C2mmicgMHVQ8bSuR0HoWitLtvvPHr?=
 =?us-ascii?Q?acjayzb0jIl9wLKdCGSASs9X1Doyx9UyKojphsSeNdsELi7xEAjm7ei99M0G?=
 =?us-ascii?Q?1h4m7hq9YYJZMJh/piY7qonB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8375c7c2-a742-4a4d-082a-08d9859fc14b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2021 12:25:44.1518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a/Q4qKQY0Ao81dgCMcQ+pIoqtLswoYMiRQ+f0Z9W4zRGozB4J6L6rGxLnOIh9/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On Sat, Oct 02, 2021 at 02:21:38PM +1000, david@gibson.dropbear.id.au wrote:

> > > No. qemu needs to supply *both* the 32-bit and 64-bit range to its
> > > guest, and therefore needs to request both from the host.
> > 
> > As I understood your remarks each IOAS can only be one of the formats
> > as they have a different PTE layout. So here I ment that qmeu needs to
> > be able to pick *for each IOAS* which of the two formats it is.
> 
> No.  Both windows are in the same IOAS.  A device could do DMA
> simultaneously to both windows.  

Sure, but that doesn't force us to model it as one IOAS in the
iommufd. A while back you were talking about using nesting and 3
IOAS's, right?

1, 2 or 3 IOAS's seems like a decision we can make.

PASID support will already require that a device can be multi-bound to
many IOAS's, couldn't PPC do the same with the windows?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
