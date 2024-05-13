Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8710039FD6
	for <iommu@lists.linux.dev>; Mon, 13 May 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639437; cv=fail; b=nh7rLnId51oWyZptL8BuOjQ7N75i8Yd03n3rgM7Dm/VyrJxugK2Om+BEqXn9z4jqrVoMCiJoI36NNMjm7ws05Cj/IV+8lYsnND7V/j88l2FoRJu41vFo6GnutUcic6yWDaUJI12pPEPPCa9TKcZfFlH76e+v+8ExxmQqcdy9YDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639437; c=relaxed/simple;
	bh=Nn35AHB89DZNIqfuJgRFpfCe+bA1nNtHY0Kzcb44X/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Et2GBvNEANMGZG3lTZJOsWQ2mz004JtQT3OVFGBnxhbtIc9Lx/AN1KtdJ6nAJalvv6DVjBQQeadbjZ9GtN8lY3m5M1dBhr0sq2K2eJJ2e1CYWnttK76Pxq0yjXydA6uwu4MbhDyNpJIINY3pFJjzZJzT43z4nWrYSiC7xYQfF4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GbYFvzgx; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbYFvzgx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMzmXWHQUbP6UCNn9M64nzGKUUkm4hdgSbyGhQVbtb2usyJqOHGZaBroC2gauFB+qI6vy9A135sHI67n3M+18dEL+dV//OOkhZR1xjToIs31et+UHK0/CY5/GTuRzROhNkLjzjGqJzP5xnj3QS/mLphNrnjWKHUwdUVcXU53qvdEwfTeqmrp+nIDzqnD/mfsOy0T/8lAKN1YZbTIEYVv8jSU0FBCseFDPvsIjyZApdR6yCA9r+sctlOp81IEJ6mHx7P9XIYgP2XxEXrcB5OlRn/mVEjclK4c7Izp+oeb5syEShiwt6YFGnN5qVXIaU0GkYPksjQ86x7gAiQy+Ft4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn35AHB89DZNIqfuJgRFpfCe+bA1nNtHY0Kzcb44X/o=;
 b=EdU6WS/r7lO75yKbPdJ50A9tgnPzO6xzaLO4ZOo2VQ0+xpIGxsg2ZNtsP8A1RUZLrkX3Ik5FwcMc+uNrxyoawDDRlWyj8wzTFLAZLHRblWB2PReI6sjYH9Vx1A4CmLIu3kBsqC+ToHL8Q6JPJJo/rpumcLTDfQBOybg920U1V05pJbodWXK4JMa+lIthYqydrh3YQidNU97sHfLHzqnAkSx96GgUGW+v83atHjs7BWum8W8FTiqb2wBSXs1mjSyiUKNuTsTZ6EEGuE8mXmclqjQ6GVtjRK9PyIqf1kWxqo7OezlcNw0uUqIP/knHJGagl/VIYbcg6Lm7N8BQ5fkogg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nn35AHB89DZNIqfuJgRFpfCe+bA1nNtHY0Kzcb44X/o=;
 b=GbYFvzgxTYMw+GuqCpPbkl+9tI+NvRpXVwPly9UMz0sGitFiOX3XmkzM7b72w13r80SEEZmxzEtsI9jsMUo7mrwhHZBv/tchk+F0jBWOo5uaNalsG4b9pjcAAWX3Wam+50SU2hjPRSzwd30+DHkov/cYltWDczeegDUFfYlJFQH8km00mhK3PVmAjTYY5lhp0RidtkreYfZpqnCV4V8oyovNvaaZb51xcgkNOiaZC5qAw5IKe10W4b20BPoJRKc9pgv9uv+NzxpboihIA743MJRIGzrqN++MwbgxppGuApcItL/lbkKTGG+7ywE8T8Y2X+dD9Rce6QAp92mS8I5b5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 22:30:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 22:30:32 +0000
Date: Mon, 13 May 2024 19:30:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 01/14] iommufd: Move iommufd_object to public
 iommufd header
Message-ID: <ZkKUhxEQUxF5OLtX@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <09e84c7c9099aba07b24b113c70d57d4574aee08.1712978212.git.nicolinc@nvidia.com>
 <ZkDCbWv1DFH25mnh@nvidia.com>
 <ZkFFbIiXBEQH+2Fd@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkFFbIiXBEQH+2Fd@nvidia.com>
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b015c3-8dc4-4d02-2e30-08dc739c4d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mf2Qk6plEjFXBRroa4d0fPtfJN8XByf3/BlUfDBxLMeX0P0cQy+SLjYRfrs6?=
 =?us-ascii?Q?BN0bzhb9n8wXAPY6rNNC/YBprIAz4UW+pKGH5w/EmH0200kQufPy7tXrqyyl?=
 =?us-ascii?Q?zhTNsVDUMYdvv0rz1HsI8p2pshzODLElrpt+unztdn+UuoDTRqTaGN4WP/bw?=
 =?us-ascii?Q?eFRscWLiwVgrwa1iM5IVL821Iv+9KGFXgPNFzO9cNuQYvhsdTHVfCzCY+hVu?=
 =?us-ascii?Q?zxU8nbnpnpVu0f13eIpiyYuuilu2LLhQsoHh/36COzzlSxBVDTyWdFkpT/e1?=
 =?us-ascii?Q?ZzuwwBqvrEUa0HZrfn6GiqU0PHAitPWIYPQCVtJhzA7Bb1stsTLozbBrM2xD?=
 =?us-ascii?Q?nXggt2M5jH73Hbgiix15iWQ0orfN2LZVOjElwqh9XQTiJW+QCc4ugm0H60Qe?=
 =?us-ascii?Q?ovxcGGtHIbLalYE5jLlU4cA7xvXoXwAU986eYDd6AS+bLdO7WB+r0aBRu+hS?=
 =?us-ascii?Q?Pp10gGcj3EWwbKZmxNk3qCe0ejPGF8uMgoVyxNSZ9HQVL2FO2u7Q7XSrNGwj?=
 =?us-ascii?Q?TlzPCpwhUCRicAlTotybU7TZQXJriH1i8gvR2rcrB7jXwqTmBbZoF/YtsX/d?=
 =?us-ascii?Q?WgNPpJeqDJmjoSMqPzIpNSdsAn0+VMWHPSoLYMKRa2XmkS+UHtQf5MOly2Tt?=
 =?us-ascii?Q?2lBp2LFkytm1gdsLum1BGoi/LN6i+Sq2ycUgcE9rZaHcsavjgF1/7mwFsBxy?=
 =?us-ascii?Q?VhZqST1XSVOdpSqjluWTD1W1WoKwop3jYHsozW+G8dJ4VAa1n5dxQM4oX9Nh?=
 =?us-ascii?Q?WJ+EYP8NkGLlYPH5h0fNghWkTrQMRrRs1jLcStdDOQBKNdjzqft5AXQ3YaYV?=
 =?us-ascii?Q?yWuNlh3s4+r2LGSHB6PhVpYGgY4viy1jZBrZnfEBd8uW7aquPaqzyJgnJJPu?=
 =?us-ascii?Q?ItP9kTstNotkLGeun7m/3UgfXTwZq5veDdnIvexHxN2TG7glNlSfmgxH/4qL?=
 =?us-ascii?Q?HI7JZ7AbnDKULflpSs7z4l4WksvbbKHvfEHMSE7oC9ZbTBm3dDFKW0YODDnM?=
 =?us-ascii?Q?9q0evvq/E76kanUx2bAm2ExixV45RJcxiQiBKWYhN6IKrO9A3c1P1fRRhdSZ?=
 =?us-ascii?Q?aCvxjrDMSbJNYRP0ukIcKd48dhp8M5WxtKW39pPAXT8ws4QI4vugoHKnVcrt?=
 =?us-ascii?Q?tyt2eg1EFMD6hyCJEv52UFeN8PwGnlamyl1EXciGuErXzSwe4+RNaDj4BbcK?=
 =?us-ascii?Q?BIHelvidY0622HXeB8IJ25qEBQjRAH1jT5rInGaRcr9v60IQykKT5un/2UhW?=
 =?us-ascii?Q?xQUk86IgiQQ0ekWk2HudXEbM9E2MzueF/orfDOgNag=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mj1UocjIjFvPdjaAJKjQIwIIbZAChRfO6jWbKrL4+o81EIjcrwwLynDb8O2D?=
 =?us-ascii?Q?uzptMNetHZ+amjtrCd6lFkaLbB+4DfJ50hPqn8AG+wA9jGIbVEPHUYs1CuVT?=
 =?us-ascii?Q?ES/PJrrmCOIw7b30PnUOltRoJ2BNUUvcU1gn7MWjhMYSyV11EfzKgnfCkCfX?=
 =?us-ascii?Q?dkNPkR6/X3VMOtpEwVJZkkulOni1qQc/Pj/oeD6lF91riphNcApTzKKZDMfs?=
 =?us-ascii?Q?T9HKCc2uBOl2nTARN1aEnu9CIaIvO1OdECjf3uKUAj7UgelxiniVaeuP+BAt?=
 =?us-ascii?Q?JobybU6/QWVRY3D5PE7jRDlBPNBqdYyO6umytXywE3LbzpCTUxtTdRKYyJ4U?=
 =?us-ascii?Q?xI3JJCUTDxhcddpeT/CYhfupJXWtpN0TBtkPs31S0WsPqG1NVXc0NoY9DsAL?=
 =?us-ascii?Q?ntmgI6XsEVgYzAtsNTCO7G/S9qPPPcaQS+e7SrsCpr+SE+obrRs2s/7lOjyu?=
 =?us-ascii?Q?9u2FZQi2bFGU6AcMgfLTlSS0I4fnFV49t45U7Ph1/XtFQEp24WeMLh8KHCgh?=
 =?us-ascii?Q?1aRLF2aCMJZeEy3e/Q7tolfi6BLT3SltUDa39+Fw3Bg0nOzYmha8F5S3Bpx+?=
 =?us-ascii?Q?IVPqnshSB3Y2KlchMsjbn9EpX40HcsYaBY9IPet668w83rz2qLlsc22swGAP?=
 =?us-ascii?Q?vQ5JuVQxWQFgzVtFRCky5Th3uaiLAlpGoay1o8j58DrDoxGwom2iA+4y4gDd?=
 =?us-ascii?Q?JaIwv8dUKT2hrolGKtDIe6vb1o6kdLIu0WmyAbfq7l7niZxSrtfZSQK9uaiv?=
 =?us-ascii?Q?w8biBacDDHYtoPp4hQxpBzECatvJu5YTA3y6EeOQr61A6H5SCumOQal4Iyo7?=
 =?us-ascii?Q?pqUn98qQ/0lyHKSi9+WU2HQPMYYgYzzUmcPIEacKmC9qusTSuYxkRJx3WBxG?=
 =?us-ascii?Q?2fgCbbBx6+oRiktyl3RH2VMr7W2EbV+oMUpSRFOTte9Q2ULb5zYg1+etdJ7N?=
 =?us-ascii?Q?ei5Rnaepkyf8Wt4+K9aHkcPFeLM6L0udaeQzok4pkerDFRs2gRvIb+Bi9Jhe?=
 =?us-ascii?Q?QZr88UBVsEb2kKh9/qO1fv7sJV1W6XhvKmgKdjrevnYDJr5NXoY69NLEodBi?=
 =?us-ascii?Q?AM3kFwrXElhruQckFdjPoTBIWzU2s9n6dUdbQfKa9KZboCG1wm/4gRvx1QGw?=
 =?us-ascii?Q?pynC+bzjZCCoTXahFqcQQVkQq/Bp7y6ib6GW0R3X5BiBzCLjll4ivq9aBJAr?=
 =?us-ascii?Q?1JDEi7cuvVYaW7DN+KrAqI2ntt0+fzOBmttNGljXi9dC1yafqE8MkVv3SeXt?=
 =?us-ascii?Q?cnWqlg/fPDEzj+2UvbSKMYJanRP15AYf4cGKWFfHwbojwIYgNynqhOEXrISO?=
 =?us-ascii?Q?7xN4YK8yXMEhfiibWz86pkad4aEMN0fwPd1R5fn54d8adKoQ4jINdiivYatJ?=
 =?us-ascii?Q?UQEUmJ8EWo5zA3HFVA0Du/6FP2siCSCzPlr5hSm0oARFhSkKFzJu1cKkVisI?=
 =?us-ascii?Q?24g2aD4gNsk3LANXXlTXJ7ULMU/Pm30z0FT/1fmjEQ155dIPV0EZclkhz6kd?=
 =?us-ascii?Q?r0XzM8S7k6PnM1+HLilCOLpVvGgLz7NGR+ulSIwM+KXTizfqzSoSHL4i722D?=
 =?us-ascii?Q?MHBG+N1NehaIzwsa4JU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b015c3-8dc4-4d02-2e30-08dc739c4d39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 22:30:32.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlJ+qgiTLv/g5wxba61H62lDWUP5KRcfy3lezOf/xoPNOR4vditawcIh5APwWMXh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

On Sun, May 12, 2024 at 03:40:44PM -0700, Nicolin Chen wrote:

> We could change the "enum iommufd_object_type type" in struct
> iommufd_object to "unsigned int type" though...

That might be the best compromise

Jason
