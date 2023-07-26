Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72439A42
	for <iommu@lists.linux.dev>; Wed, 26 Jul 2023 16:41:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9H5cv7ucjGR+RlrMV7FV814bk0u0scJ6nIpccfUr2FZHQ2VAKqsdosADzTcEv+dzxkmzBuJbWRy2MEeEsfzRnBpGIcsOl5aYwMeoROjM5rh0mcAJksJVas95JV7LLqaJZ+EbXIRth3a9Oe8d2MaAa3S/wFlcfDBV80jXN8YexU/QcUPsiItGSJQHeAUJ1NGrRghAqvLeiNpopNWsT6phePMQYHEZFZUncHFyTZbZNnQ05qWGrDavOqOAi/AOz0mZ1lzlT4ks1ZEEHzhPhv0euCW9lIK3Sd4jJjQWMWFZmc0ipipMXDJvcuyQHpdfjsreA1YOJcqbWyL1zKVlWYNEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3nJN4v7oVCFLcSsnmQ+ws5cEMKn4BOtFMFfx0Xc00U=;
 b=dVXCMbSeGraotD444aZftJVpMjvJ/pQ/SEiQo4DaSrFTKfi1zBh9gbhdRyl4/daz6cUCNeKIzIgJIzuq4juhjLEXuSCGCPvqdycCWUMKiAnmVgEoRL7zm6Tzx+FRPVqf17rKXkdnly6lMB736eC0JH3VZ91Kv9L29+qVibmdaYS8blosNWCuozVZWJSfz0ZRkYiGfJobZhWrmd4u9fqUKcxJJSG4f4cIfV1WlZn+shGq0Ivf8Sv1alQtpOmkuhoidmr7M8kNoL9BJvHA1sV4pLMHN7KEzoNixBtuLsx/DHtrLQvacthcZ6SVWca8L69fKQoBRcZIsb8W8tMh2SapDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3nJN4v7oVCFLcSsnmQ+ws5cEMKn4BOtFMFfx0Xc00U=;
 b=i+LfCaBDIiQg2gTQSrluN4TEIB3ge3kl1l530pW++kQ93y0/ep70ZzPlN0LZIITGTMHOvK1VMFAJ+Qngeb/uVi/czSe2+oljAIgzL9c6urNkqOw/lNsPPTpzwzM4C0GAWl1jXWs0Gdtw5kHIEBhhk9PMUFmhwNRXDfi0OrMAodtPfELAyuDo3CU1jFH5aiUCP2PqCXKiYdZD6yRzbSJj6n6MNhM1Nj5Hff5P4lk9HD+uBATrI1tQPb9q38zsWBkb8RTTEkfBm7RNiE4uGn6ZZ5jcX1WpcU4efoRXrvhqRQXObt7UDo5EI+HFMYgCcMVhIIYB18YGl7+rrUoBBDrEoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 16:40:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 16:40:59 +0000
Date: Wed, 26 Jul 2023 13:40:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Alex Williamson <alex.williamson@redhat.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Eric Auger <eric.auger@redhat.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	syzbot+7574ebfe589049630608@syzkaller.appspotmail.com,
	Terrence Xu <terrence.xu@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH rc 1/3] iommufd/selftest: Do not try to destroy an access
 once it is attached
Message-ID: <ZMFMmjJQ+yhzxTmj@nvidia.com>
References: <0-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <1-v1-85aacb2af554+bc-iommufd_syz3_jgg@nvidia.com>
 <ZMBCdNIneapDbjUS@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMBCdNIneapDbjUS@Asurada-Nvidia>
X-ClientProxiedBy: BL1PR13CA0265.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4958:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6a4304-fa43-4ca8-e134-08db8df7174d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NgkNZe20xtT2tFO6DcohgIKZt5y4bPtaRn+yGem8vhBjmWaqodpmbc3fsbVIk1JquV6g9hPc84BWROqM5jE7LnJUGnSLkz/sVQdVcLu04B421vXUYjkSoChhBD97ztf3RKNbRlx3svccfDtFKhJIUiTlA0SL+eEp+pDjFEak46fXyOExWs5tBv+GgrFgmUQBm8NV/wdu3fjidgWzLA/j7Y913ALvIHRViaW8/fV2TwLzjEukNCI0vz3tB2BLlatL+KCNL4FjXpvzWuoydoVYFCSqRbOQs8veaLmRcouSBaN8Oc9j9CcwW67UKiMGKRz4r+dibVIJJMvgdDeTiggX9KUm1hU63wloSB1H62PIMDBbvTQO9HHHRunxGDwoYk2lNCTQEYSLcyNMs9wRwB/qTl7E3BwA1ui+penfCw37zxoHTD7OoxamcTW6NJ+WR52fJQ6zjlTkbdYv0b3inY9t6bEfovJrNDmd/LdO37cCCKM0zhZ95FXnFLEmY6IyvZu2MQwKfkMsvuy5tNyvJjr2mPYnIsFTu9zU0iyOZ5IDqJTu8Pmen5rrI1X98iA9u13i94uhUQ+mprDWQeFD6hZIFTsxyhJiG8IKguHJRrZny/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(54906003)(6486002)(37006003)(66476007)(66556008)(66946007)(2616005)(36756003)(83380400001)(86362001)(38100700002)(478600001)(26005)(6512007)(186003)(6506007)(41300700001)(5660300002)(2906002)(316002)(4326008)(6636002)(6862004)(7416002)(8936002)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0WkTUDQjXVJfkOqIVbclFUgb4yPOa1HfX74fGz6m3+Qv2KyI64zdartv4+1z?=
 =?us-ascii?Q?ElISoyr4AGfKHRZSfE0LsbIEjwpzHwuWB0Q8meWo09vDYFpy4MA4CrBl8vvk?=
 =?us-ascii?Q?gwbrvDfkVoxpeQSYQdiju3rYwyd0JI9GfDjxcJHfBTFFK+Puqd6zTzyaGNZR?=
 =?us-ascii?Q?QymCOUXXEnKjKQdrPiHo9sHD7MVCifrvPnLBxnFDO2YnycgK6KCznPc2xSmA?=
 =?us-ascii?Q?f+YvyBTOokf+GtN6pk0cznRYIA3NMd3lcdMwoJtxjTd9gS6vtbDKTcI1Gg+T?=
 =?us-ascii?Q?QG2XEUnHtlNF9FlivkGHImGtsQq7LEHrSeXO3/UCw1weOr8FlBCE2oaBccXv?=
 =?us-ascii?Q?OiKMyzCb1VAwv0TVLPxRA+rsVqvuwag2U90H4uORKhnrwQtAgk5Wjbv+s3i/?=
 =?us-ascii?Q?SCJpAsxVvmSztbVyYRh7owDVfGz8qqa17tAyvkN85K9lrJCaX+XcEfkCs3uW?=
 =?us-ascii?Q?docRLhu67pMY08ssNJei5BBNiXQIsiRHS8VIVl56Q+FxWyRxaMCv9hDPenaq?=
 =?us-ascii?Q?tPzz2hrKab9wh82/vo4oWea/EJXyxA7GCNN8DMLfblHOiD89HQXh/nQUIlOo?=
 =?us-ascii?Q?WuEKExispRGrmotVxe6ttDt7rn8En7M8dg3bOrg8nEEhKhtdSpmFZrurkmTN?=
 =?us-ascii?Q?xkhUXF39D0KB8G8h+/MBrPl1/iRkULraELNtCktV3aBHl5Ba0kvNv0vPot40?=
 =?us-ascii?Q?nQ4cqBe+oRZucMxGuazaXz98qCBYB2HI/Dwgm/P/ou5CFlbJO8MRR3JPqIDY?=
 =?us-ascii?Q?/Frg8oZM1JWNB++DAXXli1302ySIsIYYN15aXaXYk1l1e10K9o/wcu6f5LAQ?=
 =?us-ascii?Q?AgJtPyfl2hiS1ssbfyhBm4hepT9GG3dJCEMyxprAoDEPZjpiXnDtWl/TPzfK?=
 =?us-ascii?Q?yiawIPTWN5GiweJ/6HVL2NVBWQ/EyOSjPurthqv7SbNXJz/yYs88+6PEIfOu?=
 =?us-ascii?Q?zzKRT3WTF/TEnbcRti9jcj05thGzTG9o3NgiLF6w7VHxB0hGK5UnBLq4eOTW?=
 =?us-ascii?Q?y2iUGzUaXNDLIMDb/S3x/0XvUdOz6WmWMTAAEqlzME1McZWaUpxpfS72KoL0?=
 =?us-ascii?Q?Xf1N2nQsvYESnqfaLp78uWn+3+qOqixp2zKg6phDiQdVMrCDOgWLw5Gtbura?=
 =?us-ascii?Q?wHqpvYLxqc2+Ay0FnRcNlJsHRJ4fObMzmNNmqrc3iE4aV5KBrmg75XuXz2Oe?=
 =?us-ascii?Q?TgOOsIjL8p8YgHcGYkERhONYa5zOHKi9elwa94x7RrnTb3RzpT0VlvjEYhEP?=
 =?us-ascii?Q?+1v8vb58HoMCuZeoRKIZr1lsGCZtSLIliKghWUWMW8m/KiwEd6zfAFJNw08V?=
 =?us-ascii?Q?+OVbRTwn+ad9lu6r6N8GfU0v0PqxuyLBtsTeX58XKVVVjfummDOz6TpL9Ln0?=
 =?us-ascii?Q?XjIQdOZdMHKHUm3N8FEbJnUYWqWPeTjZIxmbwRPGIQWzFAGWn97/JzhJC7iz?=
 =?us-ascii?Q?Vh/ZGYbo6bi2dRtwhySamRjdHhlUAWsp3g1IREUaGNNL1ZgMjyK8+libkqgq?=
 =?us-ascii?Q?PdMgESTBKtG8dN83t1qIo6CDcOaPqdieV+s6r3YRR8WIjY5NADkDbaWc2UBQ?=
 =?us-ascii?Q?RkAVlspKhOFw+IB1sX9m8icsDJ9jxBskIYYy5Bn3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6a4304-fa43-4ca8-e134-08db8df7174d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:40:59.2264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EwR8xlVB5noVbRDsHRUYVxRcqCl6bcCl1paE47rR8j7uspDIxxXbxBFaX8suwD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958

On Tue, Jul 25, 2023 at 02:45:24PM -0700, Nicolin Chen wrote:
> On Tue, Jul 25, 2023 at 04:05:48PM -0300, Jason Gunthorpe wrote:
> > The access must be detached first.
> >
> > To make the cleanup simpler copy the fdno to userspace before creating the
> > access in the first place. Then there is no need to unwind after
> > iommufd_access_attach.
> >
> > Fixes: 54b47585db66 ("iommufd: Create access in vfio_iommufd_emulated_bind()")
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Hmm, I was expecting that the iopt_remove_access() call in the
> iommufd_access_destroy_object() could "detach" the access.

Hmm, it does yes

> If calling iopt_remove_access() isn't enough, it means that we'd
> need the full routine from the iommufd_access_detach() in cdev
> series, i.e. we are missing the unmap part?

At least that part is not missing the unmap because the close_device()
immediately before is supposed to be an implicit unmap for the driver.
 
> In that case, though this patch can fix the issue in selftest,
> yet does the emulated pathway potentially have the same issue?

It seems not, and this patch is more a cosmetic change than any
functional issue, but given that the vfio flows rely on this working
we should keep it here to test it.

So, lets drop this patch.

Jason
