Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6F9C433F5
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 11:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3258419B2;
	Thu, 28 Apr 2022 11:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EO1JdZTEAhp7; Thu, 28 Apr 2022 11:54:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 59696417BE;
	Thu, 28 Apr 2022 11:54:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C3B0C0039;
	Thu, 28 Apr 2022 11:54:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34958C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 11:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 231DE8319F
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 11:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HQUtQG27OGKK for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 11:54:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::602])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EAE7831F2
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 11:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGLZr94wt7eXy2/mMOVGUjXfkxjv5YCcBa0nvcrDK3OVfO6TuXuwhbtGGFZMFauYO+5u1Jw673U+Q2tSy0r6EsahFDyOh00hw8xgx+kwEnTmZlyAWfYZcrs14tHvIokIjSdmw0uwNFMeMPALK3PjH7jS147tY32o/fkiLZSyYbyqNrk6ElGjtIi28Oa5fVgU4sa9GQrf8iXPKR+YMmE7+hcmLyP2CaTi/F1BiKhiwY524aLBCq8BncCh5nCYvyzYOvydZR4ku0DhXCLgzkwXF/mRuNYZ1zDBAN9Yg/Pzd7kKSMxyeirNDp8MjGLk0WFRE/95BhlpuZEa1mx6AnnsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbr6e9pUtGzdHpL0FAj8pqrRWrJRnKQ0poHDoazb+mI=;
 b=MEyh2edDkqCqG7ElMK0y8ILFW/IJXPyraaww/FVlKuN52EIb/0Eei6YT7pxIGjCC9g/sG5B3M4hHkVdIFRFUO8HjoxBZZKbT5kGGfbitQ6i8s5khA57jc4lP9kSDnw375gUwTSP5xNPZmuwhqeCA1nF12fJVxxYGCw0tOCekvdUrOxcrRypEbwQt2w+Zxpf+ZlqDQjVvreM17QnA7GjClHB0bEXuVZ6Ant6xstOHex1TrUqYjn4jqv9w7c0ASSC3UsI1fCnK6m0Ec2ud9LkCtPp/7Iw2wmRZU+7iFAqLAeNNo8sSEyF7B+2ucKpeVsz1QJH1Az5JoTkWXhy3ELC2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbr6e9pUtGzdHpL0FAj8pqrRWrJRnKQ0poHDoazb+mI=;
 b=t2CIuH8l2tI19PmS5dY2zYOQxHr1ijf1G9N1ju3+AxEJYhRZCPCd+VAyj2A7mVVIXXMLlZCaJnivYOZ5py7sRI5z2v6yCRVEEA1QFxj3yg4inh/PhS2C4z6Yrt97uPizn2xW7Bf36iEQpZvfn0OJTHkvO/f3Yi34pHvJ5wkQy6S1T7KRKhzUpWA82aNekmpd8njz4zs9bm4qskhSavkgX92By52u2urFsifFCz6wYWcNUVblv34XNQIrU8BMRDHPoN2iKXnCCX+oSMyoW9GKBhwCSQuS/7DrMuABhVyOjG0DX6h8mOaShTMzs7w4tgu2RAoJ5EJaHY1kjDY1pKHiLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB5694.namprd12.prod.outlook.com (2603:10b6:805:e3::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 11:54:12 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5186.023; Thu, 28 Apr 2022
 11:54:12 +0000
Date: Thu, 28 Apr 2022 08:54:11 -0300
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RESEND PATCH v8 00/11] Fix BUG_ON in vfio_iommu_group_notifier()
Message-ID: <20220428115411.GA8364@nvidia.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <YmpfFA1iIQyGBipX@8bytes.org>
Content-Disposition: inline
In-Reply-To: <YmpfFA1iIQyGBipX@8bytes.org>
X-ClientProxiedBy: BL1PR13CA0258.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f01d6e-ba10-4ea3-21bb-08da290dcf9e
X-MS-TrafficTypeDiagnostic: SN6PR12MB5694:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB5694DBC7A5870D93897FDC5BC2FD9@SN6PR12MB5694.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CB0kYq8iqHUEluxvGkfWJ6nkg05qAUUwxb1B2vqqM8hQdARgSJW2eE0rBfy6uCZ1p9m1FRbZZFag+L6SNdcBIzVtNffHlQzhYADBsXlNz0YMwBgrBGqUDI8jHCThvNsIw7PoCzozyoRsqanN+JeuJBFdJruzfeOqegmBMjqXRUhihTdjq5Iv8vGRAziEfxdOgz4EwiRkO2uNYJ7eteXGyw/MHZhUX/yKpouYTogQWnIyrArYYpV8g1AtCLvYDVwZdV7H06JgEUSTWkJsPb3HiUxKhXo1joUUyKqLtMysceaP2JKTE47Gw5Ya11MF0HkQZTIqR46Tw4eYwPiSuxbKfZDBK+w9Z2VozePqUwSON7lsxWltNxx7NDa5abJomkcyHvWKiQX3HxI5QJKR2h/KAhJ4jsghyNJuMUQsE9S125tE6xJ3HsJtL3kRl5LjIIYof709nyx3Cc/t20Tnqx1AyVFt8gIKabc/0qGySW7gTPTA/5oU8AmG2hyzT/GHQs+2vj8gRLx/KJeV27yjRlyn4xq3ejyXcxFNJI6AvKoL3VMzz1cCUqiko5+5iDZfe5W6ckhT+sWuXPr7Lodc7y2QzEW6aBZX35l/OuXCu6O+3tPbqAxpUrMIkBSPa6de1yXOs5QLVL1lFOZQOS5muCS8GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(6506007)(6916009)(54906003)(6486002)(8936002)(316002)(1076003)(36756003)(6512007)(186003)(26005)(66476007)(66556008)(66946007)(8676002)(4326008)(2616005)(33656002)(86362001)(38100700002)(508600001)(4744005)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/Na5eumAl+C9qBdCwGlvvQUHVEYP5SXqeFGLOgQ3i23Fq/H7sZtrFD2NXKG?=
 =?us-ascii?Q?Gu3wDDgfLY2T7xlhKirntQ0yBKssD+1YJlgNjO4tnIY7WvfFhZELpa5af+3V?=
 =?us-ascii?Q?W4GCIsONylL3vjp+hpAa4ia0be/522g+SjNVLWE36FpjhxL2M520slCXn1pN?=
 =?us-ascii?Q?Y+8/Jp3zmmPVUxndKATaAZEg6/PiRacrnvWgLQ9xAvJzHZcN/wi6dAOHz3t5?=
 =?us-ascii?Q?DzLI3dSp7oG38jajaCAeaJWeGjldqiEfqGAr2MH4CTxkDCL24VSxxlbEvvBI?=
 =?us-ascii?Q?FU2+uA4pbM8m9xCsVraXUXjOpxTAEutKRa7MjZtNptiEY8PgWJU0GGq75VcH?=
 =?us-ascii?Q?w36VmsE/NTT2svsvmXBY1oMvTphpsDPp3CnY7fWyOQgSKvJVL/Z2TZmY+glR?=
 =?us-ascii?Q?a3A4NRgfE3pHkisuSN+2r7556JCyF55d9x1NBfUOc+YeC51sJxBZ6gGTvpzm?=
 =?us-ascii?Q?JJc8akabnA6EdQwT2RRnTx7SsdNsO8PYXd3ZU5IMaraQ2FhMTFy6FUYJjvUw?=
 =?us-ascii?Q?AZ4BD30NDJub49gWzzY6me59ZCsHJS9/xgK17SmlNjOoN0MJKHGMIIV3JqD8?=
 =?us-ascii?Q?G7McEcXrQHrr9/SM5UtCAC+hEpJ5WgU2rTK3qC3JJugDOQcWZKn24FhRS+NU?=
 =?us-ascii?Q?Pv+QRlrT8JM+v1xLrjoh2qN/bYd1jGTfOEnU2xDxNue2iGlXJKBsPeOWB7hz?=
 =?us-ascii?Q?MsMEoW+oG20HraTOUawucNAANCV6b0jmAYcJ0in+caLDHWqcUFSxq6jYmNW7?=
 =?us-ascii?Q?jEwFnlZG5Bk9Dd/mhxEDL+vqS7SjrcXgyBeJPc7QVps29tHHR7imdLvlt2IO?=
 =?us-ascii?Q?T7G99rDebcqwUdL9pSdRkbnnlZhCy/oBciHcuwX2knEHlot6O2dQiuFjl7YZ?=
 =?us-ascii?Q?QMkLE09DfksVBnPxJP5ipH783qZdcIj3Q5FY+EbnaN7rZ4fSWbY15+R++K7g?=
 =?us-ascii?Q?iTysIQaVdkIoE6J4qR4dIJbPyS1j4Qev6cIRBMAPdh7VioszTDXR5Q11P3NY?=
 =?us-ascii?Q?wAcAqPp+MM0AJg1SnxZcdEq+edfzl1uzUD2nxDC0knaSjW+OoB2/qwp7HMB0?=
 =?us-ascii?Q?iFRudx1dQFSZ8gTF7nwE0QGFGFup/aOm64D+MGUVCW3bJSogS0Kj4dCkLeQU?=
 =?us-ascii?Q?nVYv+mdzeW0k5a1CGfL8d5/ZTWzRhNVTklfdUAjyZ31zeeIxIas4X6MoSSIY?=
 =?us-ascii?Q?UgUBYYd7Cl6ipprXGDb5Isrb53ZhduVQcBV8eB1vlNMKsAVQo0tirYAmAbez?=
 =?us-ascii?Q?CMgGuLupLr9tcn3b2mYXqIFBzH7qR5RA8tmzN3dUAVlAFx6Hiy4hd39/CQFE?=
 =?us-ascii?Q?Hdvzeo37JLEGEyv/YEtn03SKsGuOt+gEhsJ8GRCBkIiUKJtjQjtAHPIh48fK?=
 =?us-ascii?Q?6iqAMXVMtlpnThvxbR0NRqvRT2Er892TCuizWU+Q0PjO7C5Fa7HD7Bgb+z1m?=
 =?us-ascii?Q?/EIs+W7RffCTsD1T8vCQyB7lapnwQfQbtMfZxZvYfFjfWYxnnReTDjVYbrRV?=
 =?us-ascii?Q?6vCVOFQcdwo6ikKmZtnKLb6KZqafmFoLJxi9Q0iFIT3lL7guDoU2PoDLj+KU?=
 =?us-ascii?Q?bpOPeoHv7kPofs41DrcbEVupB2K5xUiR+gp6CXouRoWzkFyip4/aJ3M9y0Mo?=
 =?us-ascii?Q?dDS9dJPtquQgfb9yaquf5IiKo804eJETiF49qmudVorHuTuR6xda7E9o3Jhw?=
 =?us-ascii?Q?P+mRyNG+t/XS+ooFvOgnxUydgODfieBR4i4ToVEdLC2XWOADZQRtTibKMvq7?=
 =?us-ascii?Q?QCkT0COWJA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f01d6e-ba10-4ea3-21bb-08da290dcf9e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 11:54:12.2637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSMToULVdzaaLYaFscIb5DGxdcMPvucQQU6hHSFXd6EdveQMMqrJKusDgHT/jjmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB5694
Cc: linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
 iommu@lists.linux-foundation.org
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

On Thu, Apr 28, 2022 at 11:32:04AM +0200, Joerg Roedel wrote:
> On Mon, Apr 18, 2022 at 08:49:49AM +0800, Lu Baolu wrote:
> > Lu Baolu (10):
> >   iommu: Add DMA ownership management interfaces
> >   driver core: Add dma_cleanup callback in bus_type
> >   amba: Stop sharing platform_dma_configure()
> >   bus: platform,amba,fsl-mc,PCI: Add device DMA ownership management
> >   PCI: pci_stub: Set driver_managed_dma
> >   PCI: portdrv: Set driver_managed_dma
> >   vfio: Set DMA ownership for VFIO devices
> >   vfio: Remove use of vfio_group_viable()
> >   vfio: Remove iommu group notifier
> >   iommu: Remove iommu group changes notifier
> 
> Applied to core branch, thanks Baolu.

Can we get this on a topic branch so Alex can pull it? There are
conflicts with other VFIO patches

Thanks!
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
