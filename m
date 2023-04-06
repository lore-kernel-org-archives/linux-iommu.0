Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306F3214
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 11:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWJ/tvgX80dyA3K5XOFF4ABL38tBO1EJ8Wd56L3Eu8PjD2vqx0DHqbLAFGKjYF5bfeLfTyKgs7HPXGh3ujvhkKZwJIDx4u6fpzCvkSWLumJhS+KFiBpJEGDPVzTMY+Jl97EuXFHfVZZrq076AzWY7Ops+0VleLoi77aAp7nmQrczWe7LCpDocp7voT61iY701cHz+LZdGqlHF2rXfhPI/vihOwy640ZGXbUkMSlIAXmEOYH/zdnIzjuIXS/PGWNGt4vmsaHUABkceO6AVBhF3SjISeuFESUQj0vCkbLoAH85acXR4SOq6ooU2gES7pwJoejf64UjV1M98PQObQMhuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdkeLYDaUhnZ19u918uPvo52Y0d4mgQwQD6nCraeMlg=;
 b=L+hjMtfza8AqitOMex5lUwv5c+0i7vu3AarIbfeFY1IygG4wqIR2GOh1zYInaRJS746AGi88Z74kyM3I7kXdTNkBKtHRZU4Wex2msYqZSE8sdKTE8ddbCk9vOz3Z3Db3aD0mvD+QY6fBEIGt6p0S4xUri87WIp3AGgdP0disj2BqZmHXXvAytvruzj7G6rxjBSjkqmoKLJPY4XGAvwe+QhtH6CeVHDsyyCQJBAmi0NOi2dQkfNT6SDjUoCp4cqHoHyLHtEyNdT7AyDNEl/h7AG4I91QgOy61W/QLpZE3hL2ZqnLDJjbtsBbXaStuVK8ehqSND2BhOr+rtwpzkEQdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdkeLYDaUhnZ19u918uPvo52Y0d4mgQwQD6nCraeMlg=;
 b=kosgrkIRwIrWW8CyFv6omY9ML5DbuhrBhEZ1miPDZedBaZupst3VySiMa5L7VNEGL4J51ZC118esa1YBM4wEozZCzqu9Qw7H4WASqn2ja1S1f+3We947UuL39YLxs1MfW8dz7esVNfRKgtPTMGZ6TVSeytqfFy8TwIOg5FQ4sQU7NqAp6BZ4TlfLqP8nfrZNKZgWu/gfrZabl0OuhdJadi5B1A3UIjk36CdNCkcRmUUJ+j3JuEWwqDeP1DCxGAgwGBsZGF9O/aj9zjyXBdAYU2NtXeY3iTif+iCo0y3HZabOsRIwHUYYR80bdomUL9OXjz9Qg6hxggjN1QIsubk3+w==
Received: from SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 11:40:09 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 11:40:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 11:40:05 +0000
Date: Thu, 6 Apr 2023 08:40:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	qianweili <qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZC6vlI7onlUgBidX@nvidia.com>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
X-ClientProxiedBy: BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|SJ2PR12MB8064:EE_|PH0PR12MB5631:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a6df86-fc55-41f5-363b-08db3693aad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gDjYNxL10ZU/DOgGDY/d1F3+xRyV0/LKHoVh/z4Eh24eg19vIQFcVux1cMig9khQgfWAoRPbKAvWWZScydwXaOGvUngZFrHX3GawW7mxjzQPJ0UuU9dGz0Zqw5S+qPp1U/VfaG4HbGTnQcps53aVz533SPBzNdW3ygjGVHMzNc/AkzA61wnq0gzTf1FtBBg962gNRxiqMz/knWlqUFk+0pBaKn9gKIcBEEgItH1sdWtt9XSeyeKdqfpecJ2oM1m3DKaG9+5ynwOLKXDkr6gOkGrvj9LY5ghEgAF2Oq6QBirB4kZNJ4KCxTnPf6iPNz1hDiL354ovTgGuQQm4teG652braKfPMYXpXVH6mwbs4alSVf1Y64kSMMtxhtm4Ow7JPSnYPjyxyi4fwgDYzJHAtCEPef8HLsjqQ7n/2W9y42x7/d56wr5Lp5ohQRbGHhBCs7aFMRB0knBRA6V5968sVzwGUfunVVnlLKf7D9COkPfGEBuCBsgiuyu47whpvvL2J3FufPiA+Rr3zYP2Wc+oeK5yqOdvJLG9qNrSw3asTfiLq52oSfhezvqXGf0N3ayf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8064.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(36756003)(6506007)(6486002)(26005)(6512007)(478600001)(2616005)(54906003)(186003)(316002)(2906002)(86362001)(38100700002)(7416002)(8936002)(5660300002)(41300700001)(66946007)(66556008)(4326008)(8676002)(66476007)(6916009)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ynch7ypYcwyUH5g4VUyRhKm4EMru/qOypUcXboEHfoKBGuL78+AOgXeqRY+H?=
 =?us-ascii?Q?Ba/H9AP31df0hhvc2veuB8fpy6phZRoXLB35P7bGq3Dfwkxd5rWqYhv+SNj2?=
 =?us-ascii?Q?WD2Zmudkc+4lgpUgw6vzp68vuL68fmYy0Zn4eIQUHJ/wIyS/Nq9/DZH3h/Ez?=
 =?us-ascii?Q?b7Pj+xsXVFlKe+jVh0oJ7pMjZPk1CSLxx4+o4h4/xUAvAipU6lCTCAlH+yBf?=
 =?us-ascii?Q?43zbn9MMsxhwIE8b4bKYjCkCCvg256TyCT4Q6xZvmbBdsbhKsqaypyF/1eqT?=
 =?us-ascii?Q?6tRwDgJ3b7YnRThEwFPVKK472alZpp18Ms80DvjbQrEGPxIPCCUkWTu8p1Yr?=
 =?us-ascii?Q?WANv4e/eOCnSZ0hpvhZ2bZN5GWXUA1jHfWGuynri2R4XALKvTFkQFWpHhl9F?=
 =?us-ascii?Q?pOm4hot5SLBG3AMUVfxE5pG7X5IkyzaPecfcFuBOvY5ePwjBFBb2Dhy9aywQ?=
 =?us-ascii?Q?R7GHDyRwZl6g3uB7mp2hHE/xq0NYqzHMLtzj01mc051I97LECkE+5r99wlwT?=
 =?us-ascii?Q?xtCxNH1nsE7ksxpPMV+eQ4XZsME1vKwRyN66G/Zu0xNsSiTTkjrfEXAIjtCo?=
 =?us-ascii?Q?y7iW1hD4D8PcqJaqXvRbm91/3OIo/Z3oQuwOJI1IADLELVvb77f2C2LEdxS5?=
 =?us-ascii?Q?b0ZVIqfOZMj3yosaneFIR0dMLhtvGS3v7VTgw5muewcqYZYuBzC8peqIAPwh?=
 =?us-ascii?Q?f1LIIGB4xyBhmS3xOjy/fuYNulBh8DcPn6bZn2GQIJnoOYsrLzRuDQNqiAoa?=
 =?us-ascii?Q?DDJt0vWsT79BS+vLhz583LxvwH/oNKthQ0ngf9xUnd0DfG1uD3jA+yikb6i6?=
 =?us-ascii?Q?ShV44k4DFf8/Z9BqsIRJ9cftaZrwvhyUbh+t5WE23g2JbdbzQwHLWSh6YKBZ?=
 =?us-ascii?Q?nLoiSs8Hft7kREiS8EtrmQFWzhrUaGjW6hoqKHvt6Ec49ovCkMRqSj7+SbjX?=
 =?us-ascii?Q?c1hK4urCK/vw37ElIW8vtXENRkDRjrPaw59h+WC75gDvnXO0r+4Oxyisxx3u?=
 =?us-ascii?Q?m4YKWQQDhDWMYVAa2jyWA4xr6bBzxIObmmNDDyt2VcRKcNDoZgDdn6zm2pau?=
 =?us-ascii?Q?j1zOGNvo8X8CL5UjpnjrWUe0VDZYX4q7ljgZex3zIaSChwx50+qRB6YQgSZW?=
 =?us-ascii?Q?3dzuzaSeys/e2dtNBMXaIpOvxSKDMLbG8bnnOjh2zXtISbeKQJJw4SNoLNZd?=
 =?us-ascii?Q?ZjC29X+WWBL6Dtz6jrcX7w108sC8qZb773J6cTUsQgisiwxpGSBML3Wl4YEP?=
 =?us-ascii?Q?kXWnO+j8/XFAHp4AGh4mjy7GJHI9PpIy8A7hvzLMnu9KMsZApcQwN7K/HPO9?=
 =?us-ascii?Q?aoL/K3x98z9jeE5BziMeLFroZun05w0kGNIJguRZp0bGefbFEGAxzqpbBjE7?=
 =?us-ascii?Q?tX7XXsFGSoRE1VqfURmKtJYwm3e6jn3+6Cv8Tg5ivyP5B8lNaMJztDPboBkL?=
 =?us-ascii?Q?hxGfdxdEZmEwLvtbqbeiswzDskvL9gJTTWlCOqA8XB44ai+g0KE5QnnvSAdq?=
 =?us-ascii?Q?tUJkcYrUuiaZd4UJE05dQcUozzI3rX2TpzBOjYMB2GmZBHMYde9UZ/LUdNbg?=
 =?us-ascii?Q?oBwk/zM0ef7Ye+Cm2lgVMREcN0xyRHxyDQQDhYJI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a6df86-fc55-41f5-363b-08db3693aad9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 11:40:05.8902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2xQBqwUiIciCHAcsJFUtBjMZHwafj+x6a9UVhHSi7uEYdsXTqihcSYkUcAh2W+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631

On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:

> We are using ioctl method now.
> From the testing, the TLB miss impacts performance a lot, so we use
> huge page method.
> After using huge page method, guest can achieve comparable performance
> with host.

Looks like these tests are not stressing the MM, just measuring pure
BW of the DMA, so they don't get into the invalidation regime..

You need to measure a more real application that is actually using the
MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.

Jason
