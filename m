Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54D8289D
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707413025; cv=fail; b=db3ci3qfj5vNEfkgZ88udLAs4bqcEhbZ1lMZDvH/gr1h2zKpRhKQkzi2ysAC/7muucNY0NBFvuxXWsPyWTzNZJj8y+2BkeA9KbEgV30s+TGh2lIpxix6ijuuAr8IoqlQPIeeMnpcVM7l8SUX74bKzc+bG56k60c8J8KAyTRMDJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707413025; c=relaxed/simple;
	bh=VxGOkUGaAlp1FvJ/xuoamJRVxQs7LepFNDBxrKgvN6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dBbW9DSqddLHmEy0LR8Jo8B87aD0Fn9scEqjULl3TOXlsL+7jRVI11EIliTaCPnX0G4KOecIqtqs8Ii06u9/FJ8jgyujPd0Iy/UABu/fgwprz8iU4yti7f8leWBi+X6cHM0Hc/qiXSnQ+Chs6kfzjZFCbQKibvBsJRF8DiOcKCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aRgMiaJ/; arc=fail smtp.client-ip=40.107.92.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aRgMiaJ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/dwBMtuTFtwIF7kZSqxOT5sLZolMrPxC8+aFXT7T59N3/sT6nhbj8VZ0F/8aQ9ia8DzIsBP83qHKcrqM34ZW3lEoTR5kSm1Iy5P6RaMYvI3feVyWn50blrQEbahD3FzZsxPb/t0YE7VZlZ4l4E3M3aL5bACEgcYVwSM1oa4guRxk/cd28BNg4xUNC0Mzuf2kZNn1CS/mtQIzAlp1ytRqySfQ5j6EPLasmL/ykCcLFEMoAXmqXc6Brc1yCrl8xC/nYQU8qyOWAUT3RTUdj2uhpTy9jSi3ZDORVBLvVCsWGm+07uktbPcsIFWOV9ptKgNGDNaLnZf+ie+eHeuUWJ8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxGOkUGaAlp1FvJ/xuoamJRVxQs7LepFNDBxrKgvN6M=;
 b=EHPhgwO1Mri9N3zs6+gC4QMSn6CvwZZVarGTbIf6z0nVVs5BI8Bv9XdGlX6KfISeqAk0/orGgQPg0c+ZoffGde70ndWRZLwc3TiazQdaNFcNG1pn/m4x8hr5kLi+yXIh2cHCqpqS3zeIdjPSUrBhg1e9RWaLYdJeR794gUi8Ze8RwLTnUgZ+KRwvKjx+Dp6e8HgHREYZLmB7CPhhZH4qC+YQtu9YmE4D7t8kitAk8zgpkWM/5zwQOKVAlTyxKA+JdPBO180EWptJPf7nX7JsG6LeFdHqRr6DylZg4pPobM8zkS91K+xbqa26tW8DQeE5zQcng2LkOR8Vp3ofwlBK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxGOkUGaAlp1FvJ/xuoamJRVxQs7LepFNDBxrKgvN6M=;
 b=aRgMiaJ/UGxGrDIV1UhoLlUc1V1rCjCJdYD1cJTjjjKLKmu6ZAf2/C5O6oAjhaiT0FvI/X2d0dguKvEgcP5F64cLxNFaAKkSxNgWwKkRQFP96LQqT283TUGKJzhsK1Eb4l5lbxaKwztiKGYCe6RAWaQ94olnCbj1wWgjQ8SwJvaodxQoy4Dzs5hlwjgjXXXyvNCVLr+1LByK8M1I1Ks2lTYxFzKTkgybWqv2MCegXPxhSqnS7Y9vecTn0/N9JGIlNklg44jbsBUgeWSn8YxHBvJz0UGvN1YInoaVNl70mzqwVvJ180sfYPLMD7oQpE/VLSNX4q7YL/SJfdC35dS0Fg==
Received: from DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Thu, 8 Feb
 2024 17:23:40 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5054.namprd12.prod.outlook.com (2603:10b6:5:389::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Thu, 8 Feb
 2024 17:23:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 17:23:38 +0000
Date: Thu, 8 Feb 2024 13:23:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Avihai Horon <avihaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty
 tracking
Message-ID: <20240208172336.GM10476@nvidia.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
 <20240206181333.GE10476@nvidia.com>
 <91aee5f5-82ce-476a-bb53-cc65c369db2c@oracle.com>
 <BN9PR11MB52760A86CB0672C0A646B6BD8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b17fbaab-8d35-4084-947a-c955e9f1a541@oracle.com>
 <BN9PR11MB5276EE3DE0C5A923C9C077E68C442@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EE3DE0C5A923C9C077E68C442@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA1PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|DM4PR12MB5054:EE_|MN2PR12MB4046:EE_
X-MS-Office365-Filtering-Correlation-Id: 1103dc77-1bfe-4de0-6267-08dc28cab01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eDg0SM3jW5RLp0Y0sF8B/AWbIimUMq5eS3eVBxjxH/vVm4XaEhcfVSZ8L/ZkjCqSWh1m7ZpnurjeOjRiwMd77YzITnfVM6NV3OX6xfwAtG66uS5SgkBbAY2ENkeXhhN59sgiEz0n9PeI621BPhXleWD/U6CuA06Wq1cXLyvJSL6wdxfbkBqb2HRyNhSbpEjLbhxTY6hHlEEd/DWLsKz6JwcC08UqWjsAa1d8PfCy2v9eliWyPdoSU158Ab8mgKUEGcjZ4Bx48OX9oyi9xNeFQqpMclno15nnluL7hVXgXbgIeXseK03f/XzaagAxDEY1BKZ2kjZGVdKX3umeS/QbTO3iiY8WpAIPCNs5Yben/RsA8KPrYUJmrhhDvD74d6kLhUxiGE63+WHZpsS+KlgNmZmdhJo+fjFZSJOQgtOKVoWDd7fyIsFyt1U7F3FFpRYNeAYMfX36gKabdloBAj1I+ER2gHyV+Q0C4IfTacxEPQBraQ9UECpOeEh0Irktet/K6FMYQfLGS+oHn53xkx9lZwFOouBEWm5udblWpPJy4mc3jSTeh0BsnKEeVoASXs15
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5054.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(41300700001)(33656002)(86362001)(478600001)(6512007)(6486002)(54906003)(36756003)(66556008)(1076003)(2616005)(38100700002)(4326008)(26005)(316002)(6506007)(66946007)(6916009)(4744005)(8676002)(66476007)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+smySAS3lsLb8nbgrzLWYihOHloO45wmsAwcLDjI1oGcF27x9nQJ2PXH0LAS?=
 =?us-ascii?Q?UocdUg83XYboNxQ5fJ4GS8QNlHR1LRId4Q0K1mfGSbkx87s+XlUs+1hi/Enl?=
 =?us-ascii?Q?HUn+ZDAItMrQoMlfiSX7bRdcVOLubVw7NCRtQTI5THaDw3ayuBfNGLOFD4TD?=
 =?us-ascii?Q?ikQtljKqpBV4BaL0iuNH4EkTgCvCNe35pGxRYhRCIZwxvPZcL8KdsIBtB1wy?=
 =?us-ascii?Q?0VLtmtHwITssnP18+q5TjIideoC0FsZTD0eR4N7IvQeRiVW7B6hakXgmZZuH?=
 =?us-ascii?Q?EkIvwvaVqpRfIF3GVBSNcs7Cz86v3FTfgBb1Ik2ebI/WLRQKg7wVpfTSVoyU?=
 =?us-ascii?Q?EUblMc0w6niECknIDVqYU/pRuhINo8rPub1SVONEVYu6gRdafjJXAPHOLew7?=
 =?us-ascii?Q?fjNiaTW6yuP1O+kx1x8/R7NHkmRtHv5FyCBYD7gejuUUGdNk0Q4T2RZFcbPJ?=
 =?us-ascii?Q?Uces9r0acEH/IzlNC+bzzVcNaAbJF46S53ViziQNhl1zqbn3Qe6iNQFNsJKW?=
 =?us-ascii?Q?eKgFlbF6rLjp1Qg58cK34SxfqOPa2f3KfatFbuP40vCiF2Hajo4kqMm9cExn?=
 =?us-ascii?Q?71wYSPdIOG705mmgWVknOVe0k0JH34HeCbLCf3Ww/M20vWFuLUTUSASs6aZu?=
 =?us-ascii?Q?ySxdRJVaUmcx9kT5OB1gLXTdmjKmNq9vc1eZwQMYAyXjKPsNiYpzfsa5L6OE?=
 =?us-ascii?Q?OJhtSd7kkw9YH5QfpCs8NIzJzUitN3cA/e7dEUvxMRmUGLDzLbhhLLZ56ZNW?=
 =?us-ascii?Q?84lTWJZsNRaYxpcupiZ61XFDg4Q5+A9PoFHj7tixZo7ThG3dWATRpLXv75tZ?=
 =?us-ascii?Q?lfUOubwXxvKD/6c+Z/zr9cwE/llQwZ6FhnYgwg8DEvYCEc57Z9VY2tujaqrl?=
 =?us-ascii?Q?iSLSGjEHPILRM10Q4WqnGjxiLOBW0SXrzo8ZW9DTt4BU61UeeTIP6ev5nHLZ?=
 =?us-ascii?Q?1z/J7nP883luKgjdpKXCVOrXP7oMKcj9j4ZTM7kiZgTxDwqJRaMozdQN0DN7?=
 =?us-ascii?Q?MNjA099OOfk2Qg0GHgoJRITdRgr7EHp0eJW4GQmHxqS+/4H4UexmPas1PiYZ?=
 =?us-ascii?Q?vZbQJvWYpL5LMrj66iNh9tQrkNr7b194sV+51TzHcQDp6v5izGgpJSGPDc+S?=
 =?us-ascii?Q?abT8CpPJANXQBxzB6oPBT2X6BWjefKAFdjM3MzP9CzTF02uHndjQAmQBSrjW?=
 =?us-ascii?Q?wz5cXqf9W8ygF//M7UIutvz4qZ2LeArB16iM6jPnKqZasOdCgQqyFGquKnlJ?=
 =?us-ascii?Q?vPw8CF/sMg3LgJbjrV0+WMVyL9iXTHuserd2uvVIT/tk0/oYj6Epwta/SrRU?=
 =?us-ascii?Q?IiosqACffRVn8z4JTcWXgyzqwta49g8pLhYT4t726gs2nLxC3yOrxdtQsZZJ?=
 =?us-ascii?Q?0nVfG6R3Pqb8AMTYErUqrgLHsNzW3SHrsouwxugyWsTY8+HU6Ey9FuIyXgz3?=
 =?us-ascii?Q?iiuNarEERT1aCrhG+9ty0NJ/xB4jNRDLPZBjHbVNkxEdt5sSHwd/TSPHpT+c?=
 =?us-ascii?Q?HjwS2/a6wnkag20K0FlBMiuH7I9m5ndpYSb6BqYs3CQ4FNRBiAVbaoE0icAC?=
 =?us-ascii?Q?Ak9sMOVfSyRgksKb0XZMQQZB781IEKxzX8+7Mmyb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1103dc77-1bfe-4de0-6267-08dc28cab01c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:23:38.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qyas8D4cXyp0GjxplwIhpcM47edz7vrFnB2K0KPafS55rfDCUZZ8lncxCs7Jy1Y6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046

On Thu, Feb 08, 2024 at 08:21:01AM +0000, Tian, Kevin wrote:

> could be a framework in iommu core which calls @do_dma callback
> provided by iommu drivers. Within the callback the driver specific
> code can walk the page table, set dirty bit, or trigger IOPF, etc. Kind
> of a sw page walker.

My next next? project is going to be looking at improving the page
table code to more completely consolidate it around common
algorithms. Joao and I had shared a few ideas last year and it turns
out there are quite a few needs out there.

A big point of that would be to create a selftest that could do the
kinds of manipulations you are talking about here.

Then the idea is mock could back the mock domains using the io page
table storage instead of the xarray and we'd get a big improvement to
the other big area of code iommu drivers have to implement.

We'll see how it looks, it may be too ambitious.

Jason
