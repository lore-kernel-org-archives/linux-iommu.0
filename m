Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87263FB8B
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524090; cv=fail; b=TbR2yvl6/K7CLib2KGstan9zYlmMxoJ+yyPBJtn4/ywxcF1ijkJzy8mqJ2XYEPdVgOR8faCIH58hp2JBV2iecaGBYkXbzVbwuTEIh/XQjCr+O/xAStU8nEexRknQtWWdFwAlm3YLoB+HGRGYoCNvIO2uPa29P5cf46phoTXt6Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524090; c=relaxed/simple;
	bh=Ew/jfVJArBqoTLvbtuZhuqeyLhxoSexC80nxgq2R4ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TUqiUtvQ7lGFewcGP/QcKBdHNoCERk2AeVRhg/zLpshFcvUt51V6UMyYyn8BnZrozgRDd/P8xCfbM+jJHKaRou7UTHhfYmuiMAmBZ58dbwwMh5bOndszw+dJmHqijWFFwbsiEr+qEiflt4gMh9xXZYGZQ+Nts3JmQAOhIXLuPJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=shBh7XZu; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="shBh7XZu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMSd4AfiNdGQg3vgM+AYwpdMVD99OYuZF+gwb5rpH14Fcyy8+nXazVs+J5Jcv9sz6qmPQR8W3JdO/RtD7pvSt4XlO0iHBbrNvv+JiRGtiOIx7G2d7GHa/WOH6vBqYITnBsSvKuFiJIUNfSngPsFTsMhVBdFtpP+vV9rI6qE8213tcQV1unyJOdPD7Lh/GZ+pFWn1dsn6/Sb+AaMsF9dzDKp5iVzO3g6jQKg2HqD/Gtu3WjmmTgvcNLGENn6t2qQSKd7fDVXxeyEJhHogt6g+V0XtsUGMS725muDm+lhsc+uMqkR+vjwnoKY1u6Wp8cWotuCpOYjOH0P4N+/afIl22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSv0s/1kfncmFjrayaQrotpp0/BB2UgJ6lo2pNme4v8=;
 b=gjKRUVCV/ZhEsb/PBIdUMwkEtIryCqYkaI46GMAyntCaOh6apFFftwM1X7dJOjnF2XU4ONx9SGqvLyLjIcKq5kZsXsaAbVfOhcTU3QkTF7QLV2C3MjCJPzmcDC9FJPgIeCemIFZoVfY4e0PR93OSUYRBSlDMNb/pRYLOPBLuEiahVbijmX8a/pEgwm876hJtUlAh0H4HAJkzXk1tyyM0Q6/DNt8dAOyRSidcVVGRupHeRG9VsNsXQ/5HuEk0zN80KVN66amPxeOPWWIWeWErpbwz91c64MudHchqI8nopDfBXOYYYcoSRr+NTvEJzvfcLev0mo1o9bZz0uwv4X/NPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSv0s/1kfncmFjrayaQrotpp0/BB2UgJ6lo2pNme4v8=;
 b=shBh7XZuQgg4E91/uwWSGF/jtjPU0OmK6zHBYu9qwK02opyhaCjrbsy9tO/Un2DsIztMkMqSKoNgaAypJ+9yQ3aSY95T+v7eoW4G8ULUPh2Z3Ah7GRcjvvoqhftInSLFId5onvo6iHHEPePgTwJPN2OuEaHDphxe+E5j0fk4ybGxEYvpwy3sPinTGo0MFJsK7fKcnzWTMjM/e/IAvGCD7VeJNqKAOl+5a9jxbWwZyT6JcKNjSqfpR2aEfoGIa4Pk4Ae4hDSpJrKLhqYeg5I6VcgQlGG3j6P0AV0rLluyEp0pmvZgIPAyAw65F5xbikHw9nD5EWvi+nwLhbOLQBgwYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM4PR12MB8570.namprd12.prod.outlook.com (2603:10b6:8:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 14:28:02 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 14:28:02 +0000
Date: Sun, 12 May 2024 10:26:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 02/14] iommufd: Swap _iommufd_object_alloc and
 __iommufd_object_alloc
Message-ID: <ZkDDlMouOmfTaRRg@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <43bab81816a7bb08fde868a43d62c439ede91f9f.1712978212.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43bab81816a7bb08fde868a43d62c439ede91f9f.1712978212.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM4PR12MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: a2cb9520-62ce-41e4-a602-08dc728fbaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PaNdz7fQXLQZN37U7qAMWmOd9+4queqBej1+OJCzOMKqEFfCudtHZtBkU456?=
 =?us-ascii?Q?cCp3T9i0nY+c/yzlz2n7TVBpEGRnKouexMoBDtMHcsPDxl03kzsub8j3IVf1?=
 =?us-ascii?Q?oWSRmd8Uxvu/e72VpZKiwcNXcHpSNW3LWJXthyJQ1tjDUXYOlKlA8K2ni0G5?=
 =?us-ascii?Q?CxBZ//3sQiqQzMwan/+ARVlDG9JWsA0BniRB/Ym7SOujJ4G/VUysZhcs0aWs?=
 =?us-ascii?Q?j+THY5523b61QTnQAC6fJpQl0/lWXGPU4J8DVrLf6hhWOt7Bo29IWRgvt9qp?=
 =?us-ascii?Q?LV1n/eID2exNhV2Q/sWtY17dgAiP05sVemqOSnH1+yRuqkp87JYllzB1HTv0?=
 =?us-ascii?Q?2H0E9oBWin52Shkbf6wykHdTBSV4O9VldQBgB82BYY9+JA5Azkl4eGP5lcdN?=
 =?us-ascii?Q?urNbU3zvIfla4YBj1muUyuPyGcM3/plUO8Soy+5wUS0g+Y+5kCdpr3/iCux1?=
 =?us-ascii?Q?O39ijbvQz5hA0IKiU+TzkOUP+33QXmlUwUPTz0iUjFEhglk2XpWdhbXwob2r?=
 =?us-ascii?Q?j6PvRr+MbJAq4P7OFdv3+jA0fYzLaW5hKzhpIQXoXbCrCChS988o9JqU3GIr?=
 =?us-ascii?Q?h4P0OVjjdmTp271BeeZU9wA1rqOlr/H8G1WH2WpByYo14HI2fn1SsSC44YGD?=
 =?us-ascii?Q?PHdQJiA5rzuWuLYUcKkAD86CLmSepGN+teinhHkAxaz49sm6XUsZuP4PHsq3?=
 =?us-ascii?Q?ydsGS6vV0IdeDNlBkHHNrUtxA7bqaTEat1wRs32lxNfyACihG73y2YoVqCgt?=
 =?us-ascii?Q?kcRkKgo/5lyNE4meKZAqtCztV9uQkiXRyzNO08/YUdt/XmEuuTuzgGPj/ouh?=
 =?us-ascii?Q?FpfD2OYO8bkWS3PJvvwijGY8dGlIHtqsqWM4C2f6eHpuqbspL5maYhVCzbzY?=
 =?us-ascii?Q?pXoNdYBo63LvfY2EuqIFUdlR0dmlDxl/9n/zRKg8A9Ah9xMeNYHcl7/JmCO6?=
 =?us-ascii?Q?YhQjqVHSKv7JpVuh+iAEJtucuJljjE1InZpdIkc9UuE9W/a/YAnp/IPVMsqq?=
 =?us-ascii?Q?u67IIyN9OiZzUNdv9hoerfLthpKyG7RsAxWPN1qrvqIqmrg70hzWWWwY2CRn?=
 =?us-ascii?Q?Tv9MD9P4TFBZ0TDshmN0xVZ+HMh30esJZyjH+GDzST9P3hu3lFQB4LzSlESB?=
 =?us-ascii?Q?R1M+d3LjgVvcJ4D1YWfUTcxTlbVZZs+P/RhxgQdOeSYLx7oQS/ZpqA0QE2Tf?=
 =?us-ascii?Q?+onpZOE/HhA5TVm+94xGQalRMqb68CDNT+gokpkUki7vV5G7QdaiEFbq9PEE?=
 =?us-ascii?Q?woCfYfgMFwQUtTXozQQPm+d3mZkRyVkf8iUfqb5FDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1oXxczY2Bcasam1ll3Yk6kswdKRd9WIADrIUPwZAOuVecB0JvFlbikge2Qo4?=
 =?us-ascii?Q?EJlqBdZBLOlubnSV892PjS7Er0C/SXgEx5lq8iYLJQYMOIG5ccJwZeDXFdMX?=
 =?us-ascii?Q?Aafq+2fjZj5sEFdfBmqQpN3sgBdNfiEoIZN/65asvuu9poN6MxosymvSOJJM?=
 =?us-ascii?Q?LVCS2lCWtrWZDTAUVKvg/wmNEC8twsoHVBgugIar8ZJRShKiKI52qC/5PtqE?=
 =?us-ascii?Q?7xbfosVmIpfzzty0dDaSCauqZF/NOoa7Zm27aIXWzuJeBIXjSZmzUSFWc704?=
 =?us-ascii?Q?kws1yFZxDTdujBdeqFUw8gy1aa1G0Wz+v1eBlIrEnZ/pysYDTdhPKDmxekZg?=
 =?us-ascii?Q?37ESpnGzaFsbx+yQBnHdaIfTmQglTa+8hvWjo+vryj57ZIkM4ZAZyLe+kPbI?=
 =?us-ascii?Q?w2yJhpH3QiX38bDCu73uZodrQgvKqSRkmlYfJ5q5mUP21F3RhfGNvbo8+XGb?=
 =?us-ascii?Q?KrJlOtYa8OiLcy2hHX+LzyirnUPo9gnuQp0nPkSnz+N4ZjBbfITGgj1QU8pL?=
 =?us-ascii?Q?SIUOO1kBJgp8ga/Il4Z8IXA9osV5PpLnZBqHbPaqHcaEN4q6Q8dKyvh2yiuL?=
 =?us-ascii?Q?qS5ob/GtjUe3fmmtwx1rPiyoAjkgMQZoAIeELFeaImqKmnuGzNBh7KDJsqz3?=
 =?us-ascii?Q?zC8H/eJMYRaSqrn+PbQvdZocTvosyEQNvChGnb14VnvRKDWvYaHm4uAquDza?=
 =?us-ascii?Q?UWxefV438OG56BIATLpQgZ8I8tB6O2kv5PDzbwhYKr081jU60TQpGdUpWa/9?=
 =?us-ascii?Q?Sl6acEOFwx/H7tEuOnuzOQrpN+VJ/4O+xHde9wMhRlwj54Vq6ydgTa5NiFJz?=
 =?us-ascii?Q?vCv4hpjD0EKn16FNfOkUV5YSKqo+z5xs0bn2MfAMMX1HSa9vlJUauFpKc2B2?=
 =?us-ascii?Q?zDft3h0FsbNKtT4rRYGK9wzU5mF8maBSUFaJ4qyY32sfjeVFZVozHt304IU4?=
 =?us-ascii?Q?tuS3UNm7ELL5/hvccwvE8k/R0joracZT53PVXIBJq++rXOZFzLkH93685ppA?=
 =?us-ascii?Q?+SGncdW24YHZaWh04NTPZaQ5+JbHO8Gz/PaBLPLbG1znKy3V8d3X8RkOSreH?=
 =?us-ascii?Q?vv94a9sLX8Uo2k5G1BMxbo5tFaXHr9JN2pM4IVaoyH3YcOky+x7PH7bVXau7?=
 =?us-ascii?Q?E5UIFDU1THxKX4jSdpN+RUZwyDAYzoBPQk6NnrbvQgwT1ObO2eslJw2Ne0+r?=
 =?us-ascii?Q?BRK30x0+fTsm9ouTlqsiDWfJaQ226SzyP7f1XPHfGfsrLHh/ruV6Vq21qNwT?=
 =?us-ascii?Q?6UmWgUCDg7H7i2aE92TyJGFdK0G+1stSCfZXuPE6bAeuFo+FOb0htsXTAgi8?=
 =?us-ascii?Q?l+NRJu1x1PvlXxdibIZHDATJ9G3cdZyHo1t1Rm5aHKkk12eojW3PxoHd8dZw?=
 =?us-ascii?Q?fscY4DWpSu8N2SWHrgUBhNjyUP22RlNHEkOlB37Ro288Jxk2aiOxwnxZbIv+?=
 =?us-ascii?Q?GVSg3Z6v9AweHN/N681JDoJuB+HWpkrIs9YSPiS/dNoUrf6KTIMx9uQovo2i?=
 =?us-ascii?Q?6kgfUBZTnG8dbpqjrfQrAPl5t2SXxkvNavbCVjQ/eWMXAvZCI6iUXxKAM53P?=
 =?us-ascii?Q?hGh3CaMn+mkxra6uohxosweGCIvK27XD8rYAjOkM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2cb9520-62ce-41e4-a602-08dc728fbaca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 14:28:02.0585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWl7LJUIt/DDV+beI5t6L76hDCvqWK2uR3hjX5/3KVLJvha96ZlCduHxmvhbp+Tx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8570

On Fri, Apr 12, 2024 at 08:46:59PM -0700, Nicolin Chen wrote:
> Currently, the object allocation function calls:
> level-0: iommufd_object_alloc()
> level-1:     ___iommufd_object_alloc()
> level-2:         _iommufd_object_alloc()

Let's give __iommufd_object_alloc() a better name then

It is a less general version of iommufd_object_alloc(), maybe
iommufd_object_alloc_elm() ?

Jason
