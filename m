Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84476AD47;
	Thu,  6 Apr 2023 19:09:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vsb/AlD7XEAYdfo5NvEMPBVDK5ovvepG3Vwmyp806J1rHE7kOnjoxBulfwNcMbynrteAlrEnNppwP7lS6I+VeWddTt45kdcph98m61lbLoL51VT0IKq9lbjgvFAv9+X+rn50TeSy3TS+Bw5VhEwm0lCcQNV19M6KBmuw9oSQRAlLBAi38Zq8SQowIG+8CGJYQQ5nZAmhn+zTxfN2A8QLhvPN9/F/U+CoXfbLi/IBrZZMfpR4IEECf/Xq7ofmcsjNbdPYoCSmJlpxptUyTRelzh0TZdCFOz2LP5Fw5dNKtRDBGp05GyvUPIT4aVbaYlnwbv8ERVtUe35r078u1/l9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMiTgC2yKuU/QYI6OTVvhIxoTxhRgo8kPa6qFAUSZTI=;
 b=UebYRTrUgIB/uH7m46hNUk3HIMHjLZwiF6J6W+TxtgHT2zCbCKiB8KZF6neSssFq/9rj1I/7AM6PyOjyNW1sYyimA8PtfQGQ8djD0WWSpOxnGqRQoElOYPgb9aAe1UUspkE04z01aKMjm/9aOO4s3QhliZB977WIBS3Mti8Y20Byemn/XYthHvRjxJayg0gbSvJmxfYdTGM4UMzjK2tDDSX8rzRM6iCt+ZHIh+hqbgH79mMlRgD7kVATAVxRR/19w1iWQa7CNO13MKCrvqvtLWJ0Y6DVsdMXwXA7QmrZmwKIvHkLnvoqHimzeQsXueizHJL+PBgJyEDwF4tzrYgKAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMiTgC2yKuU/QYI6OTVvhIxoTxhRgo8kPa6qFAUSZTI=;
 b=BxmZ/R8SvwThJK4T6s/VW8QM0OjREEgryYpK8b+2CBBSM2a0Gr5c56Laa9c8Ljjz+whrp2bbABja5CMeu2xUOuTgONYvT5As32UvCvJHgmWcDwGkm9NL+96PUd+xlOKlJ1YCmV1NOXSnwDbFfJhSYzJqkvKzRYUlbs+FFGvrKNXtn2MjOXBjRWCr2ibQ4hIJz6bBIrwSrmmU3mco0lCDiQNdKuGFhrmbjs7Zl06Bc68+nHwWY9q3X/mRji/JXKg+0iY0Dy+wQtU/a4icq0CgbxrPdeI0iIpAVsnchohJiYniWCbpo1w/eOTP63Q1bViH4pqA1uftU9vFC2+Jk3HlaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB9045.namprd12.prod.outlook.com (2603:10b6:208:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 19:09:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 19:09:37 +0000
Date: Thu, 6 Apr 2023 16:09:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v3 03/17] iommu: Make __iommu_group_set_domain() handle
 error unwind
Message-ID: <ZC8Y7g99aAQURbtj@nvidia.com>
References: <3-v3-e89a9bb522f5+8c87-iommu_err_unwind_jgg@nvidia.com>
 <26039535-5f78-74f1-7864-978ad6c2810d@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26039535-5f78-74f1-7864-978ad6c2810d@arm.com>
X-ClientProxiedBy: SJ0PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB9045:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b7668a-bdec-4562-41fc-08db36d27716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y06EH3HZoBTT7M6+Un2++eyoQfcq90lU0WFQYwp4gTj32BnABMrTH5N1B3XEnDhm3X/JgoEB8FasHsayu3KzK7e/w/6zeHjZPHrLgm1gL0kBvdXqD4XKJm8wQEh9HI62omz0vRbZTqEfrRb6fjhFLCRt32oxCOF4hvotNy8ni4mOtmSkKeKO59vA/cxoYfle9fcsQweKjg2t+4ZB/fDSIMWTgoaGyNn5CkaaEeCqsZJK0zn6QQWQ7aIIqxr48HpjPZM/TpKAEDc3fLd60ayu3WhKxLK5kY87o5YEHO1mvRvBeGfMQGPrv+O4eJQYCKlDrtcuLYvvBwl+cRXr3/ZvASnV2/CgljJl9vuPqoaLmbx9LMM1v6EB70gBaG0c5iINta2lccU8WmkbjCc8HMmwl1bdweeqPsH4z6lIo+U+TOvv/Qr1V7ZKmle1ePfV56VWkCD4fZk0+yFeQHNSpTfV0XfU4hnc3nTe3jsfgMupP9KvUwpqEJ2a870rAfesRMlpp291G0rXDpDB0/NebNefmXtcwv7UZCjsktDjFhkwHHUWNVyUwYeUADE0zae2GiWv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(316002)(5660300002)(8936002)(7416002)(8676002)(2906002)(478600001)(83380400001)(6506007)(6512007)(107886003)(26005)(66946007)(6666004)(66476007)(4326008)(6916009)(41300700001)(66556008)(6486002)(54906003)(186003)(2616005)(38100700002)(36756003)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9JlARj1DwDJyZGgJcuUFkOq6F4wD2Ka/MTwmyG5V8J3WpIfefAb7QBikzmL?=
 =?us-ascii?Q?uI+QFtkJ8aHgu1YdFWF9F6S4NG+7m8EbGz2ymXetjvOzuihIWK5DUbksBp4b?=
 =?us-ascii?Q?9s10NDTiFPcJI44hDwrrqQm0ekaAEtbaYGOvQ69Q11GGV8Bxo7GOB5/ODISm?=
 =?us-ascii?Q?msJkWp3zDPBzEByY3VWimt6kDTwFhx+btkCguZPb3lyJZ8P18vlYcEFcqeSN?=
 =?us-ascii?Q?UWLiBDoMUrIEAmk3yqq+ku03KfasNmgcH46VwU8Zs+pvZwVotUGFXV7u1Zhl?=
 =?us-ascii?Q?/o9VnKR8Jt5mrb5ncTxg79a14dmbP8uBX5BwSJB4tngPOVCTOapMlIWkVZ4R?=
 =?us-ascii?Q?pBwYNfcWLIL5pc4U1V4p5BLaEyLyXXK4CtAjnvEvz+XTiQYe9WHJZsKf9ACu?=
 =?us-ascii?Q?n/dBeji3vsjXZ+lgtZYzQ+Yl4ECPPPN7BJWx/v/Vz/lUuG2zOqlcxiDiiQco?=
 =?us-ascii?Q?Dp2/UuY4VhCilfSfHnHyo2pUOfJ0RyJTx/skfHcjfUOiKya8CYkWfMGkk0OB?=
 =?us-ascii?Q?pHfkQx9/N/TMHnkSW81H1KsKZ3y42GrZDBW7zlovmlVZ0fhhoOUuF8zyROOs?=
 =?us-ascii?Q?mYlEOhvPanch4EUvsNTQk/yXwbuPOIUaPZ42j2vEObJkU/UvC4xwIHy4xWNh?=
 =?us-ascii?Q?CY50AwZgtipgF8pnwNuBD0lMyilnykINt9KQWvltNNKgP9JW8lKr+c5nTnBB?=
 =?us-ascii?Q?IScddDAVOX/m0hUTysN5PhVblDvwwLH8dgBgAwpxA956sFnM8/nMDoM5vALy?=
 =?us-ascii?Q?l0aD8jWDQxNS8BAnXgboSeFy55XB7MwZ5KYgYiRK6+u/WQ1XtquUTITsO70L?=
 =?us-ascii?Q?bAl0OUmS3KfYFDHOZ3WVVuzNIBcV8VbVzVuPCtn5d6gZGomgVdoWhcO1JHbX?=
 =?us-ascii?Q?bM7zcggYrYZh0HOxhhbtaG28jNXek2aj5POrCRuavy6JhreCeTcYc35Zsdvz?=
 =?us-ascii?Q?INv/KN6PA1hHxpv7MxtO5J4/VQwbaaJv6n07rFRHWDPbKXwMBY09L4pbVFN4?=
 =?us-ascii?Q?3bMyUEe6bRfxwPfbGTW0sQyV/Jj3NL1LE25sFa2p6sWN6RffLmDFfHnZvso9?=
 =?us-ascii?Q?NX1UwCgZPJCQQXKIlffB9G8Nw9kDp2PKycvrk8b3SVVSWar+vMPrA/bPPBxb?=
 =?us-ascii?Q?zfnf35XJNesYE3A1Snj57InVisCZDmK18ELQTdJcmqdxbx1uvP/s9B8W5ZLq?=
 =?us-ascii?Q?ernWHBQc+2ibbN1bwmqCpnevKlRr79cjyG+khbDCAaxORnMDYte8YhlEUFqP?=
 =?us-ascii?Q?Q9x1P2Qu0TMsuGEar9HhONWR3bfeSPcbsiFethsUgi6RSYAEo/VaNpU3tjV/?=
 =?us-ascii?Q?iajXvkQ0c9wxuzxke3wZHB/BJYSVAru5HdIZJ0ShB1zasVObDwEdziGB/RC8?=
 =?us-ascii?Q?cgyeHTcNo0iG77SHWpz6mrt4wB5ac7yIX7U2i2bPujg8b+4x6ydyKN1iO14T?=
 =?us-ascii?Q?di7U+0wYev/kPmJMpGXEz7QfftVA3P7hQC6ECSDM1XMeS4/tgk/e4rLGOKfH?=
 =?us-ascii?Q?Ljg4/HPWtqMw2UG9p5ZYfa+jMdCZXOlHIvSUpJpesflKMvtrdYSLd92UjhBZ?=
 =?us-ascii?Q?aq3hdntloywLQDFdQEqtcFnjv2WGEcmzffh2BFJQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b7668a-bdec-4562-41fc-08db36d27716
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 19:09:37.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQc5SEW0aexcximdnqCdStKgc52Fi3oEhVzggIt+FBSJaD+MijxvCf2Yy/Hp4JS2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9045

On Thu, Apr 06, 2023 at 07:08:59PM +0100, Robin Murphy wrote:

> > +		if (ret) {
> > +			result = ret;
> > +			/*
> > +			 * Keep trying the other devices in the group. If a
> > +			 * driver fails attach to an otherwise good domain, and
> > +			 * does not support blocking domains, it should at least
> > +			 * drop its reference on the current domain so we don't
> > +			 * UAF.
> > +			 */
> > +			if (flags & IOMMU_SET_DOMAIN_MUST_SUCCEED)
> > +				continue;
> 
> I know it's called out above, but my brain truly can't cope with a flag
> named "MUST_SUCCEED" which actually means "can fail, but you can't reason
> about the state after failure". As before, I think the actual flag itself
> can go away, but the behaviour itself will still be no nicer for being
> implicit :/

What I saw is that a bunch of drivers tend to implement attach_dev
with first some kind of detach, which often cannot fail, and then can
fail the new attach.

So, this is intended to go along with that design pattern. We call
every device's attach and hope that the outcome is either to release
the current iommu_domain or to attach to the new one.

If a driver doesn't follow this pattern then we'll UAF.

The primary purpose of the MUST_SUCCEED flag is to prevent the code
from trying to go back to the old domain. This really should only
depend on the caller's context and ability to handle errors, so I
don't see what would make it implicit?

We definitely do not want to attach back the old domain if we are
about to unconditionally free it.

> TBH I still think the responsibility should be on the drivers to handle
> rollback of their internal per-device state if returning failure from an
> .attach_dev call.

It helps the driver stay consistent, but I don't think it helps the
core code too much.

With the two patches to add the rodata IDENTITY domain to drivers I
think we should go in that direction.

Lets have an "ops->emergency_domain" that is something the driver can
always attach. Ideally it will be the BLOCKING domain, but IDENTITY
could work too.

When this function gets into trouble it will put the entire group on
'emergency_domain' and things will be safe, no UAF.

This seems pretty simple for drivers since the attach_dev can just
leave behind whatever state is convenient, so long as their
emergency_domain cannot fail.

> But what would be really really really good, now that .detach_dev has
> truly gone, is to pass *both* "to" and "from" domains to .attach_dev (and a
> "from" domain to .release_device), so that drivers don't have to squirrel
> away all these internal references to their own notions of "current" domains
> which are the root of this whole class of horrid UAF and consistency
> bugs.

Usually the IOMMU HW will be touching the IOPTEs via DMA enclosed by
the iommu_domain, so even if we could remove the iommu_domain pointers
from the drivers it still retains the HW programming to the
memory. Freeing the domain will still UAF.

Refcounts would be another way to address the UAF, then we can leak
the iommu_domain if things go bad. I think this is more complex on drivers.

Jason
