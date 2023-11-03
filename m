Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE4121A03
	for <iommu@lists.linux.dev>; Fri,  3 Nov 2023 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mouAywdC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmKPHl5KEV9UuBBCk4eNoVzb56/u4U6qI43rNw/gRuJ2msG5ahtQ56uNi3MvTcA0rU6u9BpECzA695+8qT6Hi4CuSATmUa3vWRdM5MZgIRZdrzvjz3gz+J5Di850sDhxgg6cNfGBtV2yCKfByd9xMk92DXU6DFYWVXCNtQxHBPKE+8vpIgg5m1/EaBJ9mlne0CUqtXsGrcR4ttf7vxadlFaGXgO1BXu7wNgwiteZ65G1JGVSNUx9o6tmfOz7WIlN+18YEAMTdfARsIDdjZY1noar40XjQl+e/nzbIT9xrrqgQuAGTwMuRj6T0JaqNAKOahyMWTit/hRK8sZizD3iiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VxqhxnV3APBThoPur515WXv7XkoBKI7g6DAgdXBr34=;
 b=h7iy5YCPmd1q+ZTPAKhYsnSAtSXJJSefye2cHjiXjIemmDf8vEjVspCvb60nbSUcVCvCeJwVlOxnrThdEjcT6viHMEhfqW4+MsXhyTGL+AelatA8MnY+Ma5a6SAVHP2SB5clir51osUdUAXkdXXB6DvAx2l+gStasC6u7n9WqvNdPTZ7tVpeIO5hLf4ojAjGmPDxlrWJu5LAJ4T3USrnVeB4J9sFNUwF5lAMvrq6y9n2oYGtVvpGfZq68S8VsRV72vwgqmosVA4iJixZXLEoowXYYY3cX4hbSqz/5o+d+2KqluzbsVl/dGND+qQxijsTHkP8OvqNKaHqE2dwb/2izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VxqhxnV3APBThoPur515WXv7XkoBKI7g6DAgdXBr34=;
 b=mouAywdCJY80k7jvGXyGt57vNnL+ONEzEkfXOSvzryYdXJcoJIGJtlqhoUnAfIlDYgIIgARMhpbwSrpi6j/HnkmfXZW/lrFDFdQ/zsTq1avnUVMD9bX0sDGS9mGztLIdyxKTSbfKitV1gADNRNEslO0cJPYT5J5vUPfaA5m16v3k9s2RrouznqIhftMq7hnKQaHs3eOMAqShD+z+6beIzJMvY0JC2ibtCh0bifEeEfS62yZLp8NYtJiKtR29IpLbgTqB47qBnCm9J7U9ItkKyo9VOGu61nKugZWjYWczAcpw3TSM6QEWQodPzaem52alNywsA5Du7YK5xhc8GxGWKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 18:23:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%4]) with mapi id 15.20.6933.027; Fri, 3 Nov 2023
 18:23:15 +0000
Date: Fri, 3 Nov 2023 15:23:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 04/13] iommu/amd: Add support to invalidate multiple
 guest pages
Message-ID: <20231103182315.GD223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-5-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-5-vasant.hegde@amd.com>
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: d18cb39b-3776-47cd-9097-08dbdc99f25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0BYkxJNFa8/oQF9wOTRKiCaLDnqUVrD/akU9lThZJPlgaOhHn3X7i2q/2IV+rYUqaY8xlR7e1/CEzVmQ8q7V2b88nfyNDEhn0DX6qHaNQXcHjXXAj0odgYhKlbzhJYhTa1Y3FciIVHT/R9H78GDaOyL3KvlRT9G3jpvuqDBLoFgnQ+CCQTuoehZxW5jK3qA4TzFu8qokz7pRd5xTLQmaOGecTQZBwyGd0jcK4c0K8P2awnBedjI29AmvVNsyS3WaNnn731vDLd9o4qippnXg+XSqgNYWXLRCO8zyx06BIkm29wwlSN3+a5ivbUWmBIfYTLpHasnMzyQjqIfZLdQtbGH4h/0JJpoSSpYNgqvIy2vLQ/UMka/Er4A0gGywnK8Rd39JHNsloc+RAvbMWXcZsEfiRdkqT00CQQHHXDoLrbh3AsynYwBH7tGSpALiDBGpNcziow8r/17h8OwEv1owuZZNrLIqI5iJSoT3MYtk/SH75v9FKAXBey6I/MLsj3h1G0wC3tXYI9wTNj9mLxz4ki1ubcVZmdgdAfxuk9SVB2Tq9NPnMcoKjlrEQrgwwL6vefb+8EuQduKOoYv2H6cC5/mO/cK9nTGoIn7FvQyZgKpxKuGATnYKPxdY6SJt5AwW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2616005)(6512007)(8676002)(8936002)(4326008)(5660300002)(4744005)(41300700001)(2906002)(86362001)(38100700002)(26005)(33656002)(36756003)(83380400001)(6486002)(478600001)(1076003)(6506007)(66476007)(6916009)(66556008)(316002)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v4Pb9fyCmQLxHCQl7/J7IKT3cSXLwhq1ANQZy6Cll9l1WWZu/5dkgHVqwBQM?=
 =?us-ascii?Q?qVQsql/AVNoDRroq2UY0z3HsIVB/BsMAB/5WGUpI09brpQSEHXXjV4AVxD0H?=
 =?us-ascii?Q?S4pm4s4vMd+uWeGja9bSS8gIiBU6JlcYZtUsLhjTJ+HXvqXmO4+LvIssLvA2?=
 =?us-ascii?Q?sTG6tM9FzeU/Ha7m0MAKyYSTyf/Ux7T1e+/LiHryDkrxChUxVItL3eHdJ6Bh?=
 =?us-ascii?Q?SiWj2ZpkAsZeFBYVNLoNRq3WaYFjYwJpS9a+EDUfzI426FK3IXL+n/fGgG9+?=
 =?us-ascii?Q?XvHPDNWzPdS3xUBlRQpaoXf1+f6W0a7rdpUW/1gsv0qaY8euyYeDRreBkY5k?=
 =?us-ascii?Q?ZluE3c3klY9nThnvXFWBIT0r4eH+vr801BvXe4ZY/dt07+h6YXSVw7Y/3/3T?=
 =?us-ascii?Q?W+lGqo/TAN7kGKHIARoQi62CZbfumUpYS1G8tAtYCweJRK0Yh3WpnrMB3SIk?=
 =?us-ascii?Q?r56SGZprZnIE/8d0NPAxJLHvyNiN3G7v3Mp0sAFHKgXl1CCc2iNZUFHbfDv6?=
 =?us-ascii?Q?spfPaNBmeHdUS7GtlKfZI4OLreEJnzfrbR2fuVp4irhGrJNXSjXHEcdjxlVw?=
 =?us-ascii?Q?fLcLNshP020jIeQ1T+AAtV1P/r2uUTPsrEwKTxn8EQBWhQjpPARy28cu8FZ2?=
 =?us-ascii?Q?OKn2w8Nb6DYQElMmyYlvJjTRw8hGJiXNS3Ywml9yPCb8jfJrT6Z0bCHngNEE?=
 =?us-ascii?Q?ugNZZneye4MkkrghgnKyxIKO0GQAJnTHUJ5Wsk0k1m/+4PD+zalJrPCN0Lr/?=
 =?us-ascii?Q?F2qvDRKwtNyj2ygYWu7tKd7qNRJsL+J+FRvHIWTUi8xnCyLLOzL2jb/osCaC?=
 =?us-ascii?Q?CgqoHEnmkE13h3tO0kldag9kVhUp3PYgF7hEB3spSWj73j/cF6SGuXyU2HHn?=
 =?us-ascii?Q?ukqQDf/PXgtfiraM3l1drzbLjVr7yy6kSVn2MXHSEA7xyYiFPHGzN4Cv5EY5?=
 =?us-ascii?Q?MPIEH4KhZ7KbnEsT49lvV9Bz7udlSBhewFIqO0kInSKKCidtdehFqygAoYgB?=
 =?us-ascii?Q?XzA07sbvXIWNAN35iUtShBlww02QmG1XRbYerV5/95BBlHfVf7I4hwaT/JhO?=
 =?us-ascii?Q?dAfiS6X5ImEkjPt8hXeoM/sTs8K5v9yJmJzsrqdbzCu4Vy//Jxv3rEAj8apw?=
 =?us-ascii?Q?knCDXjofax0tLEmSet37ELmkUmmhgFTg8jZ8+Coqar2Rzyyu2vbJfh+RGl5I?=
 =?us-ascii?Q?m/VBwwVzjtls/hEF+TzEUNdiVXpdhzmFgHhcx/ruhb3jjWHqc3WevjSNcgfN?=
 =?us-ascii?Q?nGWbOBMMa8zhBGFvrfgiUTJKdGPkexfyXdi5zj2YZu76XgPKXYQIMHP2/Mgh?=
 =?us-ascii?Q?ETmE/ZWBxsXFnVj3AOXsDVE7ciH5HKpguxQ7x4QmK8McSDP3333t6A5vXGjX?=
 =?us-ascii?Q?3iwhZONYaRMkSyD/0QksihK8aos539YW6qqad82X6SJ3nekL0lz+6lyxLoqL?=
 =?us-ascii?Q?BkLSOxjbNbeZ/MfRLSZFQ8CUcVEwmfvA6c7eSMZPiqoRyuwbHXtqEP6EVR7w?=
 =?us-ascii?Q?5V8cnKstfsbZDXHQXSxbVwkd63VT90WiuUmYoXI945QGMEqOaKc2IBNVMGDA?=
 =?us-ascii?Q?uhn5ixzTxpoFyhtWkQg4NDXLRg+X/sAjE0L0x6t3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18cb39b-3776-47cd-9097-08dbdc99f25e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 18:23:15.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvY+mOgjcXH40MuT9e4+8vCH6m40ty/4VzQTP2jdjpAOHLVzlpNmyMdBNhVO2MIl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

On Fri, Oct 06, 2023 at 10:16:15AM +0000, Vasant Hegde wrote:
> @@ -2580,7 +2576,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
>  static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
>  				  u64 address)
>  {
> -	return __flush_pasid(domain, pasid, address, false);
> +	return __flush_pasid(domain, pasid, address, PAGE_SIZE);
>  }

The idea of passing the size to flush seems fine, but an API to
invalidate a single page is really strange, we never have that
workflow in the iommu drivers.

The only caller is iommu_v2_map_pages and it has a length > PAGE_SIZE
available.

But the other parts are fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
