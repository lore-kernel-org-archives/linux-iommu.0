Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA26AEC5
	for <iommu@lists.linux.dev>; Wed,  5 Apr 2023 11:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfTD3ve4iV+T/nqcAkxLaAV7sGBrGGhGmK5TLNQOI8AxRd7Pxot0PFE4ZwoNtd2nJ5n9AFVotSUQdPU2DLBn7XmkVljFoK8TD+32MB/uL+rKkV5JpLUGHOsnaE50neyU1Ad2QTzINCt5TVNGUB2UNfnyLsiVBdiUx0wXIFMyGcLETQJjL7r6PuZz8hSF4ZffQJflfKVn67z56KZ8UOsczOtGgXqhsvWJQpxAVvSOwgi4kl1Z1IeBVNH67Tan31kb+gA2r92pFMKdwmsOVS1EqQQhVETir4LLQZbPjv1uPgJaADeicAC4F0tje2cjD7vxnDQ9IUHPjBbMuDABiFtJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiUQxQrv6ixgYYB53AVxQP+Sv7Zd9vTuKPIWj4pGmTI=;
 b=U9a9z11yQaNcTjbOKuFyEZU4/ra+Bo4+NfyOJxZbEutUvMGbieunheXNheYLaIq1u22jsIcNYryYSGws0BJmNyAHNkuiFPjtTE1LJbQ0Oav2EP8nE/MDmZBjPKQ52RMianY9H89xQMSD6BfIj8P2JZiouzAxCoAOt8uf8WYtJuOITOQvWR6bhDrf7ask4FFux7FrWIAZDksquM3ZJUt9prjVDOv5toakssQmSGVUcIO+4JbPBVl3AOcpvdEVZ2MqqTc4DKFfajoWcvXK96MYLi/bIZPT1FJJZV1dVm9KyxGeQshSqpvICgFrCP4yZcJ4aZyQ4s/KnD1VUJI0euakoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiUQxQrv6ixgYYB53AVxQP+Sv7Zd9vTuKPIWj4pGmTI=;
 b=nrwN5bJcs5UQWhPvvqsqSR3DOmRrseFZ/h18dAxEy4umlsyOFQLSSOTMRzzlRqB/PU6vfqHB+g7zM7U/EartPWtZOKryEkk7qf+7f9tabQLLggS6OUCENPcUZxoZXNc6KBknT1TixFzCBWIHKDaKeeUWYcWZA6H06XEv2q9rT8A1bKkVorMe4bNTORJqKGIIhETd4H20qs3JpLFbkTbIvVzxK3qFUoSVrtPjlxzogvj91e8lKZhpFiPM3JqxFjHEGzFySOszcZjnEk/oQNfGLBCmS6p8MS+DtcS2JctJhv//xjzGliO6giCa/Dhv6oi9qdz3MC64zz9rtJj3N7SNYg==
Received: from SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 11:37:59 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 11:37:58 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 11:37:58 +0000
Date: Wed, 5 Apr 2023 08:37:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, kevin.tian@intel.com,
	yi.l.liu@intel.com, eric.auger@redhat.com, baolu.lu@linux.intel.com,
	shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
	iommu@lists.linux.dev
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZC1dlENobD4wlZCv@nvidia.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <ZC0LFM9hxF9wY76w@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC0LFM9hxF9wY76w@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:208:e8::40) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|SJ2PR12MB7962:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: ab593c0a-1c0c-442e-ee84-08db35ca343c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DrgwuIQWQC4UK6frLoH8TsM+BcBfLzPXn6tKsvpc3kKBuvSGQqjDzLegnbkobaTiSGoATcUpft7gPr7UA/MGQ5wQzZTaa/b+TKskFrUPaZWITEIC5fjScgC62BCD2dybmxiJmLYWCjiLcWJOXaWIlma2L3gChybdnI1+maU3ww/lvsWn8J/QrR0U9DfKrEemKUii6JqdBKzIfbXXmX3Jg62iKph+JP7Zqc3AkQ2BLkIA+xKa+OvLdI7fiXK8X6924L5AxGcXD1DyvEt16Spszt7ezaQ9Zbufi+kIrbsvB19uKvsyWGP4w3IJ2dydcFbmfT1dRw/GbjmaN9QAp8gxmOE2pg2gRU9YfII87a+wIFrwMH4AjMYnGMrQRlSWEij1yH4d8U5rF+xMc8p0r21ZIvxk5wPUGG8xfcSpStdoe3e8YApUe33Z8qbT4DgvXczZgaO1UE+Nxj9NUHrCDR8jQaYShSbchwyyTMQudoaO/FYuQiZkX5IyX2ZzuS6OJjdJe9T1mXKgJN7U3gHlal8nquGUbrkbVwPqT5SBadztWPWkmX++Vk+eMD3L/ruI1aJg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7962.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(8936002)(41300700001)(6862004)(316002)(6636002)(2906002)(4326008)(5660300002)(186003)(8676002)(66476007)(66556008)(66946007)(478600001)(37006003)(6486002)(26005)(6512007)(6506007)(2616005)(36756003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KKbQE6a0glKdP6G5ZCkZ5ci/9DmTfBiHoss46cKufvHxKs+NuSAIT6zB/aZj?=
 =?us-ascii?Q?SO+E7g+8UZM1zqkXNRdm4ttwaot1V2An6PTcthSFh/iqakNOSOToHF/aNxe8?=
 =?us-ascii?Q?ylXh/oG+4/afPqIQYQozNpnMLIBQMGNnCxAQ+9zfSndjft2pWP8SAD4W7NMl?=
 =?us-ascii?Q?RswSa7EhiV2fRoSStq7taY6LbM0AuxFC4WjTJGNDj9nOMHO0Eb5x/ckAJ94f?=
 =?us-ascii?Q?pV7eL3E4sQyyqI1ylJaNK7WgRWMZHiDiMS7+jaOqir2ySJJ9vH+vzL/j0oWH?=
 =?us-ascii?Q?5QbY2I94MPKPXDU/XOHsxfCJ/0x8III6sMFZneZsdSztQS0xuwOiB3RNWTdY?=
 =?us-ascii?Q?A4pbKZ9Y8KsWMCwe2RDayzT24NZO64tUhnocDOKlQEw1LLGMb+9JGzqJGRZ2?=
 =?us-ascii?Q?pb+jN60kmKXKCWncKOw1tUo79rjYA3/zoJRrlAZ20GJRa5PBRHSnSyq6YPzc?=
 =?us-ascii?Q?0Kz5YjUY6IZN6wIEZvxTSYkila7qFqqE20iA0BP+rum/H4z2+bOf0oIIV5Mt?=
 =?us-ascii?Q?uA3AJ/D80jKu95gFw7EZTIGgXf6BC9sL/JyqvDRqv5CmLQmJZitraQaddQO+?=
 =?us-ascii?Q?pzwUWvXGfFFlrj/F75Rk/cpZmRtW6n+8G4Ki2+OtqXldMVfyZMeHERY1ouhS?=
 =?us-ascii?Q?BoqyoWySRgo8S+RJVkn/iw/umObFPSTqc/mcAJIcrhFLKYaw3HahRVixqzx1?=
 =?us-ascii?Q?GDXzoMBpNSKpydXHb25azQ0tW32aIWViaTuQTRCyCUOEK7A5xc2qxfIK3Vtm?=
 =?us-ascii?Q?OQKRRRqsxN56bv6w1tPiJTu85um+3w97Jz8WzzpU/8d+DAO5qFLn3F61DHP+?=
 =?us-ascii?Q?sPQacVopWhP8wmxwGvQW8+ENazsmdXM2GO1/wc0XpErCXYvlgtXtQqqU2sPd?=
 =?us-ascii?Q?6nbbzXQxs2ev73esD58ww1bO6iDnJbgQKnlQylp4bkZ9+3Ur4rfS58Ck6PO9?=
 =?us-ascii?Q?mbsj7ZG9iHx9zrQllrA+H3nT7OH1+0nvPKE7nhdzwmqwM05ebWBDzMOjuqhg?=
 =?us-ascii?Q?iCP2+L86LESZimJ/UNqEiMQtIzl//atzZLJ7BYAyOp7pdVvos2oADWNUQaD1?=
 =?us-ascii?Q?+Dox1Jffp89ZiPrHiBkm63ILEZyZz6ro3/vBo2GmejfUWFpdtS5M5QAxukIZ?=
 =?us-ascii?Q?VHz8sdOKxyphSfLa9rkgI8k4XrWWTCVN2+EtuJ1eIG/8Kjcc4gJJi29nyF9t?=
 =?us-ascii?Q?ddwmIxH6oPrZkX912ZM1hStEjqu7EbWC8J2RC7Hsj9ZrUYFHVHIIRhfHyP53?=
 =?us-ascii?Q?R7PpTKld6BGSCenH1WAf5sFseCH1z1VfK76LXJTCmWIti4ZvcXvzpzzkhsSz?=
 =?us-ascii?Q?P+YEuGoU0pBJT1f9C5N/yZJA/nc8gZ6Au2t4NPWnek6iMxYJVNQZnXpN2lXm?=
 =?us-ascii?Q?YUL/iRhPi/1e8gxKsLM8QpdktLL1pIgKqHqnpKuq693w8Rab306V/qxncshl?=
 =?us-ascii?Q?uCLyoT7NZbYsLdcXmW8zzwSgjXQe1QeHjw/yrCjEPE7MyiGMw9Go6oDUOKUx?=
 =?us-ascii?Q?R5eruN3roWViO9KWtHhAV4w3kMw+q0PNbZ5LOKaN4WNuQfRadmz7c9I6YZhe?=
 =?us-ascii?Q?WaHjfVuhKdS3Qbrkx7g/Sn/FHT5mQgX7W25ZHh6B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab593c0a-1c0c-442e-ee84-08db35ca343c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 11:37:58.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHW/xpCKbkvIHYrwRcnlHjDF6bligOvj1hwUyMopccdQT9usCA4JfN49MKbp2eOR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229

On Tue, Apr 04, 2023 at 10:45:56PM -0700, Nicolin Chen wrote:
> On Tue, Apr 04, 2023 at 01:20:01PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
> > 
> > > My preference is to have a mmap'd page, so the interface can
> > > be reused later by VCMDQ too. Performance-wise, it should be
> > > good enough, since it does batching, IMHO.
> > 
> > You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> > meaningful to me.
> > 
> > There should be no mmap on the SW path. If you need a half step
> > between an ioctl as a batch and a full vhost-like queue scheme then
> > using iouring with pre-registered memory would be appropriate.
> 
> I've changed to a non-mmap approach that the host kernel reads
> the guest queue directly and inserts all invalidation commands
> into the host queue.
> 
> The qsz could be as large as 128 x 64K pages. So, there has to
> be a big array of pages getting pinned in the handler.
> 
> (The handler still needs a pathway to report errors. I will add
>  tomorrow.)
> 
> Does the implementation below look fine in general?

In general get_user_pages() is really slow compared to copy_from_user

Jason
