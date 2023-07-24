Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5783D6D38;
	Mon, 24 Jul 2023 13:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoUs+o6clIKH8/nrLJyQrugIZbbvBu+FR6EB9xkTGN3Vh/QNbzvA0QkjUpz2MVymBqECbogz9qN8avVrSoXWEmfpLyfsA46PJ5wSeBKdz42C/AV2r6hUXjDW2h2ml240V+axV2vrNepGE+aIItTyG8eu+kyZPu01zhQH2T8xHMnv9PI/FvWVAzL5xkioXxa4qpfSR7/VuLV3gpjT5EM6eM2eHFRIE2wobijhxZXz0PfzRxjnWsxevnWtmnFewI23rVRcu06bzpXwWD/9/kjpOq/q+4PG9QYW1ygsuUvB0A+6eHnE9PqCUQDxoJUyvwJjGctm16bMJMCVv46Ojd4J8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C7D/ccKIBmksIGtzI3fvBIjQVktSNwzEBWgoEwrMYM=;
 b=R07zNzmfq6OFMRC3u16mCxso8MxvTelJTuJLaAUIThtuf8kmWF7hMIqh3kxemEdFDpWjhxAWINQeUqDYvtMbN+FUzljKUFi1Mqe4i0ip63bYmAeGhGkBB0whZnu0igiju4EwbWmxGrOnTLdaqZIew+VnVC0+40opI+CsKbIfbvXFwDKVbKiGKhyCY9e43l/6lD5a8xHG4f4r/GenSo3Skc2sRfaUKTIlkl8swPn/Gskczuximl2tkjcdQd0NwiYTW5sJNzHAfhea7YrkgpvLm8rZOL6V/seBa0IVLxGIVtrJomXbTk+/eSOeMFpFg3AaTvxjWfULPkn8onKcJ+QH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C7D/ccKIBmksIGtzI3fvBIjQVktSNwzEBWgoEwrMYM=;
 b=lNvolwMJgKB0ZbufWgssZ4/XGVTR7sdL+7QRcXuct+RqX2dQ6OcUWcYbN/VVG0DUd9VsesdvfH+jJt/rlyDB9R8naFcHtR544SrDa2js0pa+txUXl8W8xuUzGnGMVDfI+6GWJRRtkVZd5YSJHg0WTCtCMX1q6ANnV4B1P20O37wyWLQch1J9ObkNJScCvJv/kizhIbU74ZYlYB2YB+KzNrBT7eiZVswYrgl9Tsp/xF/W39ZY5hfIuGdtwJsQUx1fQnyz0Dsy1OJYA1PBY1RV6o/EEqHtpKkf2RUalkYqBtZG4u20EULmzAafZ2GWdGOIWiTDvgNpcJySTeXIFGF3Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:15:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 13:15:27 +0000
Date: Mon, 24 Jul 2023 10:15:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
	Orson Zhai <orsonzhai@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 03/10] iommu: Add generic_single_device_group()
Message-ID: <ZL55bnAgCpgM1plx@nvidia.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <3-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <BN9PR11MB527636B9607D852373836ED68C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB527636B9607D852373836ED68C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 521f57f7-8b73-4650-c47d-08db8c480c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c3fXOgZJuHax0pG5KCg9UVSfnXybTKRcQ3z17PRck2Vo3AFrSkYR8Pp6FBn06iAbLVS2ZHSN0sHxYpTYkmQ0owioSCOcO+vmceOfmgf+4mwIKyfLvasN1yoaLvkf3mf06XO3UgyH5pBwPCc7PYMTSjb5BoN8+KcLcYbfKd0V9fZVg3IGm1cIRBRFAhfG2V3hiFTvseT7LrssYhh6TfOsjCQzprd3jxY2RbGaxkcwXqLcMrxcgsFkTkXv4BFiWDLZGoWOeTOFatbXaztGrtu5FqZRffnB3vgRK22W9EXJBrQchDte1g6iQPuyHLGSN8Xub/+EMdKfgT27SeJBjebyyhxSVGHK8xEd6qKPsuOgGsfB30v4I/EevaJ7FhfM4WGVDkUIj83rxcg5ssog26AQtRAgxRf/ZIo35jKKdOBv4/lGc5hnXHz60DavZgyPCIYAjhbmRVEa/ppsF5yivJDq7jhN8xXTwy20c3Mz37OWpEqztWc7GIsjEX6lYNL+NWiYjARFqBAbNKO69uuNMXk5nr9WUhbk4IbD5NkMV1C9YxEvTRrJmwjtYYleL49S39YdOmfFgAjRCxwTvVr3+if/MKiLwik2Czs59eXNSxxBJLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(2906002)(2616005)(83380400001)(6916009)(4326008)(316002)(6512007)(6486002)(66476007)(66946007)(66556008)(41300700001)(36756003)(478600001)(86362001)(54906003)(38100700002)(186003)(7416002)(8676002)(8936002)(6506007)(5660300002)(26005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THNsSXV1dEFKejg1SUttK01uUy9BclJwZ1BZTDAwL21QUzMxaU1mT1M1ODVH?=
 =?utf-8?B?eGYrZ0k3Q1hiZ3BDdDduL3NuSnVqV0kyQXJkc1FvZUk5elZuQnkzRWJXSEJO?=
 =?utf-8?B?YTBnRy8vcnJhMGEzcjdxYk5jVUVZYkFkN3ovZy9XaHZFRE1kbUpNTnh4Zmk0?=
 =?utf-8?B?YVNwVzRncU8raHQzT0NBNXB6S2ZyMGppS2NJR1J3R1ZNcTR5aFVncFFBS0JW?=
 =?utf-8?B?OVRRQjNRQ25FWWtTbjd4M1NnTGNsLzI3N3YrYyszVVBrT0FBcFBCbndTeG9h?=
 =?utf-8?B?UktiRFdWRDhyS0Vqa3EzOHVMZkhxM0hhdW9wR2d1Vm9jQWdKS2JYd0xhWFY5?=
 =?utf-8?B?WEpwdVZidzVCcVRIZTNLNEpJTEIrU0Q5NmhBU0pDdnRqa1l2cGcwQUFVakt5?=
 =?utf-8?B?bCtNdmFtTHlJYW9pSVI4VHg1Rnp1clJQbFVsemh6ZVZ1SFA5OVFzS2ExVlAv?=
 =?utf-8?B?cTkzWGFBZ3Z3STBIVDBrVTNwMVFxaXY2MVFkS1dyTnlZTFpLL1pYeGxreFZB?=
 =?utf-8?B?STk3Vi9lTU8zZmxBSE9FVG50anZnTjN2MGRJNnRnSUFPd0duRFFCUmUzQzdO?=
 =?utf-8?B?di9yYjlzZlVtenJQNEdwN1pONEdLck5sUE5DaE8rakMxenM0UUhhMElDZ2Z6?=
 =?utf-8?B?ZzlDUnUwclZBVXVpTklGQ0ZPRkt3OG1TZzFLdndydkV6a2lNUXZQYWcyU0RE?=
 =?utf-8?B?cC8reXYvYTBoSGJUUzF0RGtTRW5WQkFTZFNlSjdCS0lXamdXbDNyQmRURkFM?=
 =?utf-8?B?RnhZM3lXUU9sb1pCcFk1eTJ5TG9zNVhSR01HaGh4dExYYmxtU0tmd1VuZ0JJ?=
 =?utf-8?B?bFE2RGFaT0JOellmZ1RnMnd1azlMZEVzY1NpWTVBSTR1T1lxVS9FcHM0aWVR?=
 =?utf-8?B?aUtBaXE5TGZIR25aOFFIbEtrZTBTL2FIQ0VNSE9USmpyN0dvWEsxZXBnN1Fl?=
 =?utf-8?B?SytSNHRxYk5mdWFxUlczeVE3WDZWQW5vM3ZFMDN0NHMvMnhDOGlaRTl0Zmkx?=
 =?utf-8?B?ZzhqK1dPY2N4dDR2dGI0aGRFWFVTZVdKMW1VUVpKSHRocTBNU2E2dy9MdWww?=
 =?utf-8?B?cGw2TS9jOXFHNFh3SEN6QkRVWXBzdGI0Q3c1Y3NjbzRjaHE3VTd6eFErdnF2?=
 =?utf-8?B?RExqR09aM1JWdFpWYVZCeFp1dk40blBjUVBQL0E4MWNSUEhKVlNBTW9zSUVt?=
 =?utf-8?B?WEpxMzc2ZmwxbHRCYlFhSlhja0lIT2dMT2IwTWhjQkhiaW4rd0YyUC9YdU9T?=
 =?utf-8?B?bWhDS204WklSajV0eXIyRFpTNU9EZ3BEdUh0Y2lFN2RYbXFXd04rSlZ4SDkw?=
 =?utf-8?B?Y2ZSYXFFMGFacS8xQXRVU1NaV0IwVVl2SU1TTVlITUZlZFU3VXozR25JZDBq?=
 =?utf-8?B?ZGplT0tNbkc4VFVJZDJrclFGbXJja25xRDZDZVA1NUF0bjROZDlKdGhqbHdq?=
 =?utf-8?B?ckh5bEtZMkNmdDltYUp2cUNGMlNRWlp5SE1SWGZvWjhJN205UStndWk2L09u?=
 =?utf-8?B?bkFmQVk0SHNBWjIwemEwY0hHTUlIc1d0SENjYmlWUlQvcmNKS1o5a1F1QXlU?=
 =?utf-8?B?K0FoWTQxYzdoNVZOMEduNHF4a0dtTkZZUHU5OG1laFFGQVlXcFlwN0FhZkJH?=
 =?utf-8?B?a0Jnd25iWVoxQkJycGp6NE9wd3hJc0MwblhDMWRva2pjNWhuM2xSdG5MKzM4?=
 =?utf-8?B?UGpQTndJR2ZFT09LbVc3cXNtQTVrSnZsOHJmVWRqdERtbzVSVytZVUZSbDBm?=
 =?utf-8?B?b2w5OXhNa2NnWU9xVlRscTFCeTlrVWZpTEhENmMwR09ISU9VRSsxdThXTG94?=
 =?utf-8?B?bm9yMlczTVFDTklZTUZJVzV2ZFNCUUQxNEZFMjRSNThlNm1udEd6YSt5S2lU?=
 =?utf-8?B?VFc0YUJIY0NrVDlJYUVRVDdBVURaY2xyVnZmbEowU29aY3ZvdVJPUnZxeTFB?=
 =?utf-8?B?OVJOWnB0U0RQYXlpNUo1aU5sYnJ4L2tvN2tmLzlXTlUyL0liZ1hGTUEwOVdR?=
 =?utf-8?B?N0I2dDhKcm12NCtnY0xJMG14akxuOGoxUU9TV1JlZlptaHZkd3VoSFFNVXNI?=
 =?utf-8?B?R0dCWEFFMXdURFEwbldsME1UNFpMRWVrWVhUSUhjaVJKa1haa1pLN3Y1VG56?=
 =?utf-8?Q?Fs7w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521f57f7-8b73-4650-c47d-08db8c480c3c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:15:27.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sapdbpn/aXQusxbJ+Y52rdRrkBgXxmuR3vHn6Ct8JoI07Om3zCa1zkbFi2i3qXtJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681

On Fri, Jul 21, 2023 at 07:17:39AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, July 19, 2023 3:06 AM
> > 
> > This implements the common pattern seen in drivers of a single
> > iommu_group for the entire iommu driver. Implement this in core code
> > so the drivers that want this can select it from their ops.
> 
> strictly speaking it's per-iommu-instance group. 😊

Sure

This implements the common pattern seen in drivers of a single iommu_group
for the entire iommu driver instance. Implement this in core code so the
drivers that want this can select it from their ops.


> > +struct iommu_group *generic_single_device_group(struct device *dev)
> > +{
> > +	struct iommu_device *iommu = dev->iommu->iommu_dev;
> > +
> > +	lockdep_assert_held(&dev_iommu_group_lock);
> > +
> > +	if (!iommu->singleton_group) {
> > +		struct iommu_group *group;
> > +
> > +		group = iommu_group_alloc();
> > +		if (IS_ERR(group))
> > +			return group;
> > +		iommu->singleton_group = group;
> > +	}
> > +	return iommu_group_ref_get(iommu->singleton_group);
> 
> 'singleton' is a bit confusing whether it means a single
> group per instance or a group having only a single device.
> 
> I don't know a better name, but probably just using
> iommu->group is not worse than the 'singleton_' prefix...

I definately want it to have a special name otherwise it can be pretty
confusing.

The fact it is in a function called "single device group" seems clear
enough

I revised the comment like this:

/*
 * Generic device_group call-back function. It just allocates one
 * iommu-group per iommu driver instance shared by every device
 * probed by that iommu driver.
 */

Jason
