Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5A31991D3
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698276; cv=fail; b=nC/ERMmsdtHZwn0uqLXuyM4shNvxSrIcaHOdYDe/35j/olh/pi0NEslmhOcOtcWmFUkG8pIz7HfV0GfViqEaFNMxbZ5Bk76KUaZ9BV4rmZnLXGVy5fOv/RykVGlbsSCZVPsQ+VQG7+fE9rekOSrcZ2RDAJtP14HiQxJwP3dcrpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698276; c=relaxed/simple;
	bh=y1fNpj6A1eb89ZMVSegQdyAcNoSiAXraLfC5lcdy0pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ul9sVA8cz+sc7R+c4TW34ZJyXBqPSYk5A2RG00xF5f0gNlvJpkUWrv8Pyj2MfxvaEowkPxCfqvt2Dn87Fz8P76Z7z6FwdUAWqEvIGgCM7CSXYxJnfmEjBi3HrMhTEDJf9JKGaEZHHY9DcHAwhhhMq9Gt82yrlVF31g3PhuyFyP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k63ORTmo; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k63ORTmo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8CNiatn2siq0bGiVYM2tdYHwhCTkJED8Kkb8HR4XO7GWShk3ieFfGDgQdT68kDj6UC1Vn4maB6FWUohsOznkT1h1b3pBn1yh7lqGdViHxUuIbdJqcRg73xlS2QxgIB+nG+gt9IQgHuopO5pz9GHVMJS0KKu6o4aP6UrYOrjXo6QWSB3kBkTvvYlUL+EoyG9GVwvQk3MtvL6uDR1XFbJhozqatn1AnzzjJQ05LIcaD9mEraSN4oD5XorTUW2mMqsiEKPnoBOzffHOO9SZ0Tj2X4F9aTC7IMb+0xwPhnN9TqeaWM/MhOtHuNObZTC9SS8mFhsnxDbw17yy7ss4rlPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vA2mB+t9ZmNNRqZYi/dBaEd0oBbdpS5JN9UWnf4QGvg=;
 b=RvcpWbVsvSj5L3qI9d65eO8UtYBd6S7y0hsvUjrnRA2IOYZq4FmXjnPSlg8Nr2KtsdmPKNvHILfw769/Jbc8ST1ikUY0+8ptwHDSkJTSAxKOj15hlQvnmVY4L1W4uskQJdSSoiL50FXU2FxsvPEtyFpljsoBnwEwGExWDI8f9frzOtgPneAHW8m2vm/BhIpYfjlEQ9c+sGs3vuIMyyEO2vx3KyACp3BExIZIR6Y9i3FQK4uiVzTYuK/+pG5/OMFzmVbFxrrRdzpGiQ563GGlRx0UA+EEq6vsh3M9T3h2ar2GygIrKnlJrBYtPxYLbHFYOYwGJ4aN9SwLGU5By2MSyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vA2mB+t9ZmNNRqZYi/dBaEd0oBbdpS5JN9UWnf4QGvg=;
 b=k63ORTmo39eGpNdtkCpbQbeHDDWvt5mcpUuafN+vpRFjK+tJyXvU7B9bVKXIRjEUIHUVDuZ+vVBJn/ebTs0jvjZ7p6It8g/y+15ENGay14wvyUOEaNlJusyqUS24l3q2nOocPkZjunO9XFlqN1ne94knkWh9d8BqP2u4CImPBw4wCyyrdGlWxo6/6in+jJiYQtQRsAvNTEiQUxiH/3guE91Vxzi4sg4w3DDlYhfZ5eCtFe+2Wnfwq61c0NSj7Lpl5azVSRv0TcW5tMTmIVjRRQZZcPSeHg4CYKwisuQWNEFpM6dTmbeduYkMgacgP3EnbOG16cOlXuvWPdkeFiTW8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 18:24:25 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 18:24:25 +0000
Date: Thu, 6 Jun 2024 15:24:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240606182423.GF19897@nvidia.com>
References: <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
 <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia>
 <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zl03rsgZl/msa3I+@nvidia.com>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 091f5287-2078-465f-4329-08dc8655e4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RU/P8SaB+QiW/9Ljmo0SYohzzdUYWCSH70rThxKHytOgUHYAmVC6Y9GpiOYH?=
 =?us-ascii?Q?un49rkAlNcufly1XK05TKb57jS/SJctIC7YyPldMIAZvhvNKx4xmN6Vv3ltR?=
 =?us-ascii?Q?LKw4bI1Bg4Xa1UvFx5TbInKh9axCb0XA/lVIWL2CgJyWNSTaJ1G0rtHVYaJt?=
 =?us-ascii?Q?qxGxkVOfEsTDviX2fNKsJHR/63H/NzyluX6XzmuEMt60NrC26hQ9OGjhdeWk?=
 =?us-ascii?Q?puLYhF+FvR+3Xbe/BTWq9Id5R3F9D0wkrFL5BCQcncXeZtWLdX7qA7yVOchI?=
 =?us-ascii?Q?MGxtIA+orHiksdAbka/a/eXpTyEyCIlAdN60wTz/jt8gxycnOwjiwxCDzqwV?=
 =?us-ascii?Q?xPeTVS7DjzIV0Y9z4Etg9BkKtYw0+I9HKEdzL0CYLlwVdVRMgiF+MCpdPnrK?=
 =?us-ascii?Q?+/T3grQtYpc9RlnJBtsMgV5VIN9Babbxsu0SNME2jeUs3grIts//GAgoI2vS?=
 =?us-ascii?Q?c/iEEMbudQn+of0e3NMc2Sufe8vbZKqdvoH1JyySLyVUpInUPdig7U/1MCPa?=
 =?us-ascii?Q?aP702/EP2XA0Ag7ltQJKPxM4BVQLMeczoi+NZmSracN2HvhImwY12GY1qz0l?=
 =?us-ascii?Q?WwCHpKMTZnHZgLm6RZSFr99jFKZlf31rQXIUnU50CS0J4BokP8UrwXM8wlGj?=
 =?us-ascii?Q?WWkuY4j3q/jAzu9WFF2yrv7Yz7tihvFWXC+gwPNSgEV1ZfT0kz/N7Vv0uoQJ?=
 =?us-ascii?Q?jViezUW7rahIn4S0CZYb4q/KI0OZ1kbVb5jNbc/t/KjtpwDhh6RnyM/RRIlS?=
 =?us-ascii?Q?l+yal48wA1bhBMMTNIUs61w5rlbyV5M9WoBAdVoxkRUiGL1nfVXykMSaeMx0?=
 =?us-ascii?Q?PnzvyrrsYwt4yrc/vN+BFkC5EOn/siMI3bTh4thK9w52CUTl/N5SjzO3l18X?=
 =?us-ascii?Q?UU2g+Mm7n7cMBcmJSBeGoZaBIzw7ETXVxfHq+H87C3PWuv3fBmGl7h58DXHr?=
 =?us-ascii?Q?aFiqLPNDvCBFjmXDA1obsARfv57HnfSIXqsjfoIY+lE1iR/3ZhvZt6NabThZ?=
 =?us-ascii?Q?dqDjv1oeczcIjUxGB80zEtOGBS5QDOEMKHli8/GuEZBINh1QQSEFuwekRbFF?=
 =?us-ascii?Q?x0gXWzaK7eCl1PggM1utUm3e7aAyyT8uIe+otzV5JUGIeN15PWO1880tzPeU?=
 =?us-ascii?Q?F+orP0I2ofb9G2PnRsxAWIVTgKDJ5HVnYrHxUYUwTgixNTZsuBycYs4Ln9O3?=
 =?us-ascii?Q?Z+/HmFIv9zJSQgEoDEJGkLFSz/gHjW6bN9pMkyYkgosvYsCXesq9GAW/jAwF?=
 =?us-ascii?Q?jopuKT4J1bMfHK2dTTMMsriw8PyFXFudA3q7VmYmjJGDttbsI+pbOhr0UpwX?=
 =?us-ascii?Q?jXfNbTqSlYMPjrL3jrPhOU0F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lLe35z0ToteTWvINWKN99J1XAWcc462qfwH8w7VT9uOy3nvICkMwussdqM7L?=
 =?us-ascii?Q?MoSoGpchwmO4eVIEE3Ma5R1YZoYZfffclYMzxb0I5LGB5n5orSLiPfiACv/i?=
 =?us-ascii?Q?0FcnqyxemDM0Ij0OU7t/+5el28uoHkBQNoWpcj2XO/iiZ3SiH2FDzl7KIsyN?=
 =?us-ascii?Q?MOMlOU3/hVuIVfHQVgE9qISvRX1mPCrugt0Mox7VLEt5jKg3Yv+1UA/F9IKp?=
 =?us-ascii?Q?ZkdTNf2hVUdTkCoH4IjV2Hq1cBeRE2VZXiHmqee0KLLoaI4Qj+sWaLBASqe0?=
 =?us-ascii?Q?DfsB2AqBPcllDbA8CdE5Kf72iro0euaAHnCmfGjteQ6W+4VeB48PbRsHRfje?=
 =?us-ascii?Q?Pn1REpI3NkRG3B4Az2ot5VzNPoOPsirFLDFmjrSvU0CBLaFnXHbSONfeZ7CP?=
 =?us-ascii?Q?i2LZ5M12Zmkp0QMHWJxvOJppBbGIS5waNMVPYml6ljtsXlB9qXsgrxiuTHXM?=
 =?us-ascii?Q?mJpebCZbL0sDra9Up4MoGmM5nQyp7jGfBFDeK1Egq9gNecpF5D5bu26QfsE2?=
 =?us-ascii?Q?qrhYRvBrvmxU3PrtgMvHqu0h4qI1IcBYoWN+sdNCao+HwB2jqe34NtqIlXJU?=
 =?us-ascii?Q?cVqa+iAuV2HElUBm4oaW4nh8isHpzx6n36uZB2NUMA5WdApZSjUYpdsLJip9?=
 =?us-ascii?Q?iMIIkfNZFfuSgGagDIBpdrBl7rC96jjkgpq+8UHxpxm+CCOWiCTYJ1X7qH1w?=
 =?us-ascii?Q?waSNBdkWfnypLZRLr1TPW3UMQa9khvVhv5S4dC2lJqUJ0gN2mvwCXV+zrgWl?=
 =?us-ascii?Q?KZBaPXuqujlJlnqTR1aplc9k85dpjX4ajm/hMiwzPLqmmI1f7fO2p5ygePg1?=
 =?us-ascii?Q?VfXkeY3MGKRT1tINr54mh/kuhSanrRzQ27POFAbefHTygvUBQyxLTT6hNHLW?=
 =?us-ascii?Q?tEbvPH/KfIoxjGku5AtKm6AO6lXb1CVYLkIqO80j9MZ1SX3Y1vk7f+kAH2fi?=
 =?us-ascii?Q?QWUXiSml12XaIvL0vND+UNHhpkCKr+i1viQx2V3AH2s2ccRX1DDQD1Ios3oq?=
 =?us-ascii?Q?SvbaIcbC5DOAZrRNlHNibySppeHB9oRSNWbftuQMX2ZoVfs4egnv7ORdQjLQ?=
 =?us-ascii?Q?pONeWALg7YAn6sONCuZxKnUtE7JGrBOr4tTc8UMD0nPLgdvMTZm3jbEdj8Or?=
 =?us-ascii?Q?wXBt8I7ke4B9f3x9y2KAJ1nHTvqPcey8dqGBoaunJ/sABWGpn6IuVWlBW1IG?=
 =?us-ascii?Q?UC+5WBE12bnW3IcU6/WlEtkP2JR85+AkRnppA3+eormGek+A7sVPEk0bPnho?=
 =?us-ascii?Q?lqdnV7F0rvL6tyDlo3H0O7WRIon9bfODX/IFDYo1AturXkQPiMgywo3HcWf3?=
 =?us-ascii?Q?PciJAA1KiL8no4w8bGgF5ZXZH2QNi/6rQGJnUog8NZIbaFXCQbuIkrKh+VAM?=
 =?us-ascii?Q?sZBRqQCZUiionC9q7yj3Q3kxSmA3ua9iHjkjXOi5AJhmhkJ92BrcLZrbSKWq?=
 =?us-ascii?Q?SVtcg8L3StyWNK7TS1Rmro3Cj60e3Y5tUMaFw3kGk/a347fWykEYjZAj2Wma?=
 =?us-ascii?Q?1xevSnaXg/AUvLlNpuFWZ++NyO1YGiEDY0pH89nr60TqtnmF1IZAc88Fv4Qq?=
 =?us-ascii?Q?z8qSj617ZQoZ86c4r55oTo6tkTl6ADQeMFXI9ecb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091f5287-2078-465f-4329-08dc8655e4ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:24:24.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h909WFd7VqtfoPzpt3P/tPNX5VdclkZYeeVOUQ5V3SHwKkpAH7OZbryfhuuyIUsz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

On Sun, Jun 02, 2024 at 08:25:34PM -0700, Nicolin Chen wrote:

> > I understand the appeal of doing this has been to minimize qemu
> > changes in its ACPI parts if we tackle that instead maybe we should
> > just not implement viommu to multiple piommu. It is somewhat
> > complicated.
> 
> Would you please clarify that suggestion "not implement viommu
> to multiple piommu"?
> 
> For regular nesting (SMMU), we are still doing one vSMMU in the
> VMM, though VCMDQ case would be an exception....

This is what I mean, always do multiple vSMMU if there are multiple
physical pSMMUs. Don't replicate any virtual commands across pSMMUs.

Jason
