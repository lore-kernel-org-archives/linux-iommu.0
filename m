Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B590C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 15:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 931BE60ECE;
	Mon, 14 Feb 2022 15:01:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KV54VHPby0gT; Mon, 14 Feb 2022 15:01:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FB2E60EE5;
	Mon, 14 Feb 2022 15:01:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B24DC0011;
	Mon, 14 Feb 2022 15:01:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 496B8C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 15:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4417F4098D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 15:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AtpsZe6wo5or for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 15:01:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 746344098A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 15:01:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eikC8Lzr11mgLFRjJvs47z43NKP4DBb0/EwgMyRT7VxbXtCbfs4+th1CGgQP2WBTw+ISLDlIWJHWiowg6CKF68SIuhwOl30Ba1066/6OJHW5rHy0kVT/JBEPvcrI2FueAmcu1E8ce9azgmcObw2RV4irshcWC+BGEmgEGSARTdt/BUNVy+/Fqk9FvcS1O5FJTgRkfuiUgozLqE4QA/FXKrPuFRYqwRUdT93SDvrCT2VDf+FtPc7n9C74yHBTKZrX15LnHPR1XrHhEO5qxWtoxCizY05tgxkDTmmcNMj/B8WdLbFMzaYJQAixGNth73BZmhtRtwiu68eKTbhvDM5+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qC3eHKd0piFWLH5SnjN5Jv70/GzKNikK2k0qMvQk8Vg=;
 b=EK2RLBXAPWRGFadmGAhU9Erm/ugbbUvqQ+vk8CgyEoaryS4HIfa2Sgd/2AtExy3IdSoLGdQUTPkRpr4sZxz43ynFwRlz1tcqRbtum8GyDrs0NFWT5IcGdeED7PsKfIA0xAsxJWJ6Ax6KpVNk7pMxCpjouJCEne1nxX/hfU3uWXvzlDNGID+Nilb4gc08fquEQQOJJTVdv+P4a6KdqRmjUYF62sRJsn51Hj7x/XTtDHnPFnlTiOmJ+5Fao/q7SyzyPdhlSu5IEspozZMFUlcPpmXd6VrKXN85xUZPWcNHJVFt1N5gPO8cse60Lu1AbiyExhOuRmUBZT70JKnvfMd3Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qC3eHKd0piFWLH5SnjN5Jv70/GzKNikK2k0qMvQk8Vg=;
 b=FB+nJLyCmTwj4ycoUUWM0KiMqAfeuzyHiFNO/yWKmZDzg04XndQCROK+m1gRP9YFbtSBcSyuyGhRQSXCfzlrLNEbT9e6mDnEkouNslmW3d+rOkP3XMh8z5b+x4WsQvNB3HbhZ+jtmvoLbBhSWyGEytEgLEG2wQk2m4h/AMKI1y9bm3jHUciHErhrQg/vV21UJ7Leu43lotBk/fGbkVcpweWGNbJ/LHQxKUNEwmdXyPDXZqN3kp6/TTGWsTSsyZiyRKYX+wdTJYKV0WOb8pSOtsrmjKA0GsJMg17FlIC0foTBwp8n1xgcyr01y3+o6uq7HecgoYALQVBynO5dzvCdxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 15:01:00 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 15:01:00 +0000
Date: Mon, 14 Feb 2022 11:00:59 -0400
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v1 5/8] iommu/amd: Use iommu_attach/detach_device()
Message-ID: <20220214150059.GE4160@nvidia.com>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-6-baolu.lu@linux.intel.com>
 <20220106143345.GC2328285@nvidia.com> <Ygo8iek2CwtPp2hj@8bytes.org>
 <20220214131544.GX4160@nvidia.com> <Ygpb6CxmTdUHiN50@8bytes.org>
 <20220214140236.GC929467@nvidia.com> <YgplyyjofwlM+1tc@8bytes.org>
Content-Disposition: inline
In-Reply-To: <YgplyyjofwlM+1tc@8bytes.org>
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0249d11b-ffd2-419a-ccd4-08d9efcad035
X-MS-TrafficTypeDiagnostic: MWHPR12MB1469:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB14699AD6AD51316DFD99D9F3C2339@MWHPR12MB1469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1nLQ1th9YRet82/e80peXOxEe+bpTYnoF4YufTjuVmo4mUUzm86ioyR+CNuxRxtJgGcv3neH8o9PdtNbBiusSea1t/FA8GRNmKberBXnN0XvSJqk429xzhB/dAFywYZ158vUROhXXhPzxdSVgzJnhxWMVjlFoRi9ucpPNYsPE2tYvmBAv4O3v7pB4jx5l34MOzy6dMLvlgkoPcfj59PJ4LQjfTDZXO9jJOFhZankLyfrj6ffLoKOzQqW1pgbziWkntq/RUkm/tiyKZt9U4tw9yLO6WAMcttT2KI5RxBBYvuQz7ZZzPUZPoZJlUkY79r68tSJRG+M47kw8wJxu3kQyCAMmsgA/zm7sKsAUsM1i2nM/FM4I5IpLWYCIAz9pIYP0NOmefbJKyKcscPMgFZ/er6iOFLugsjWMCNUJC+uG5fZirFGOO/hil1qq2817yHq9SHSyF6LguGNIhrSlfgpttvcezY5v5mUX3CUvt4+bFoY7F1/ijXq9FshGFu5vWcIAFLv3T5HP2tPFhFS6k2uzzsVg75UKrUrsCz033gPji+BUDTYLJdnVzoeq1FBjR33uWYk5HPLphdDoAGg7WeQCQ/5fgBiuQxvZEm6kBY9Dk8rNYeMCmKpdxVICqVyT85M2/TvXfV4KP8ae1HbtYY1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(54906003)(508600001)(36756003)(7416002)(4744005)(6916009)(316002)(38100700002)(66476007)(66556008)(66946007)(6512007)(33656002)(4326008)(8676002)(186003)(5660300002)(6506007)(8936002)(26005)(2906002)(86362001)(1076003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Dwxduzh2xBJ9RNpDB5XmtU2Ip+0xn8gDRQJi9GOJD+hqjgH2cne1QQNG7Ww?=
 =?us-ascii?Q?IcbXtOp/Fkj08kUag7oUX4oMRB2tJ8YfHDAbTeeblZOR9XdSr75+Mpy4CQA7?=
 =?us-ascii?Q?e/mwUVR4DHSdktNxQWMloVPhKrtY80hK9EH3XxPaMEU4j+7KPKvci5vz8kmV?=
 =?us-ascii?Q?tSiIqVb7f9acSknmuq10BZNPPZHOplGykKxYtlvyb0bGlZfnrQG4vbFPiiC+?=
 =?us-ascii?Q?1Sgb5YLRSoUQQ9CexWxlwCvQo4YzLQazspG+nDin8MoOWWA5wCQCBdt+i4ZU?=
 =?us-ascii?Q?C4qvnbIrnufSs7H9Ikawm2lJra+GZDZSQB5CO++GBlsSemYNeX7fE95CjDyG?=
 =?us-ascii?Q?ovqPpkhdFNWMGG+ifqj5YTsXs3IeypyAnqasU5k9fBFSFpJ+IJvf01E/Lukr?=
 =?us-ascii?Q?u8Ma+rI/pzd7+c/pU5ehIHjD2P377AjD60X4oJL/+bXQmgvZzF4FafTCjkzZ?=
 =?us-ascii?Q?zZ+FryBTJMJr10WRUOIp57z6i7+Fi7tU+HNNZwbICeQt0qIMHcWJQqXvTIcj?=
 =?us-ascii?Q?43UpluoMLwaKg6IfChZhchpM6cXTQBZxCMkU+TP5ihunWx/hpC70QFaNi7+5?=
 =?us-ascii?Q?gfXPEmb0nS3sukySwR584MbxEAUId4bctliicdak/RypLcZp6U60l7MUWzl+?=
 =?us-ascii?Q?1i7t1+24jjgp8CIwgi8ynwuyTSRBdRy+o8WJwTKXQF+pZHJx6szsZFrarJx/?=
 =?us-ascii?Q?T5KMNtTzHLBxKO3GQ8dsGJmCSAIYnVR9N3tY0m2HrDbDpJjzQ7D7gtc2gHJM?=
 =?us-ascii?Q?6qONJgEGDSKp4xVoBMUEqdIMU27dyxIabykcx9nWcwBL+HKuRpaMGDky9Nqx?=
 =?us-ascii?Q?LTIQBeRVpE22No4wwrrD/Ia+PLH5B93Rm+vmQ/kl6kldAGx5g/EwotY8kqA9?=
 =?us-ascii?Q?h0mvbAqY1NOCh5jZ7abVAsVGmm2bzV5VDGG7r3Cnzit3XJ6J91999Two8QXs?=
 =?us-ascii?Q?3zCrs9b0BpV0NDBVLgQIxvxlzKWQLQCyOTkftonB8enYgBgCxbHDirv8HL+s?=
 =?us-ascii?Q?57WHSMiVl8pIcZtuB4oEk3XNgrYWAA1tJGh7ThMBXvMXXEdGF7d8OYpdQbSs?=
 =?us-ascii?Q?nkFSTUJPImvO9/yV1lbgXz+316eqUU+Bak865nmH2XRJDnXMscezdp3J8NUa?=
 =?us-ascii?Q?yAhtWvFqikMrX3gh2q7kSdMMC+rrxGhWoW9c0xWrecETWUJhXLaxyyB2XBBI?=
 =?us-ascii?Q?08nVlbAIAuxk6/6Uo1Omqjrrqkj7/U2uEcWbCiH3urxtH45w6eGIKyTujLFS?=
 =?us-ascii?Q?gncYH5MtdzHmZQ4+6WV7pJ+WiiNJ28vREz7Hk619Y3o8pN9kdZCTO19bejx4?=
 =?us-ascii?Q?0iVkdQMyPpaSCxQb/+RsLzGVw4k76qZ82uIamheAs/ghFAsTnDfxaQB9U/9M?=
 =?us-ascii?Q?2LotRbKSVgmVbdZq7Nx+p1iFRhwxzu/dCb7h/+GbODUws85GX90RzNJDXWHh?=
 =?us-ascii?Q?D9ZosiK5sqINzl60opjfEvHEGTrdi7FDZATEb/kuwNMMtiwUKITwAGofppPv?=
 =?us-ascii?Q?1vPL6GNEvWRIP17tlFr9TtbFelePaTsDW2qZcdhH20yknuj3jyVgQghdGL3O?=
 =?us-ascii?Q?wLsr+enUy38aFbXfTsc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0249d11b-ffd2-419a-ccd4-08d9efcad035
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 15:01:00.6829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duceY3BriB0XQKAOuTDAL0PcO2Cd69aVTrI3Ahpp9Yv8N2IHLIYgjRQ137SWOX+W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
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

On Mon, Feb 14, 2022 at 03:23:07PM +0100, Joerg Roedel wrote:

> Device drivers calling into iommu_attach_device() is seldom a good
> idea.  In this case the sound device has some generic hardware
> interface so that an existing sound driver can be re-used. Making this
> driver call iommu-specific functions for some devices is something hard
> to justify.

Er, so this is transparent to the generic sound device? I guess
something fixed up the dma_api on that device to keep working?

But, then, the requirement is that nobody is using the dma API when we
make this change?

> With sub-groups on the other hand it would be a no-brainer, because the
> sound device would be in a separate sub-group. Basically any device in
> the same group as the GPU would be in a separate sub-group.

I don't think it matters how big/small the group is, only that when we
change the domain we know everything flowing through the domain is
still happy.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
