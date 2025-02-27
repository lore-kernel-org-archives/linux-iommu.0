Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF821D3EB
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685842; cv=fail; b=OvZag8mGIZpT5UuicCOn9rqluEQylZ7+mWWj5hnPo1Tf0YzjAqguyjOM8N6t70wgOlSnkWi/RmFnzvRoi7c2RbjY973EZWxqhV9wygVUK5572E6+eqLvCIa6Qp+A/5X8SkJy+J4MdaekCMe63A91I90qtrwMiKeZxwLmw4KC/SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685842; c=relaxed/simple;
	bh=s1YnAcMyft/Lj20qEepr2pBjljAMJqVpaN8uO1fxYv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sqm78h61SS4hVIgICWufTGYOkPLz12XTv+oFfRdCA5k9/oZ3mp+E1iz/6ptkZLm1clPxyUYFWn4/W3qBI53cOG7SOU9vjiJ8tDKnxeFvAsUh5d0bmirkFnnpGRPwhThk0CebsQaKp3MMG8zYM4oL3605yzhwSI7IxYpMWd0OcPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m+BFMpm6; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m+BFMpm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMFnQLSxmfIDEDPY28paLQeyD61mos/0VQCipVyZ58oD3sJt1OPBfErncMHi6IJA+e/VwlJSz9MOkn7DME8ZI9VCdY45hXi8GNrKeGy3IGNVbtAR13s7YeoieY4Nozq7Tk2YpGAcTdfzAdJNQWfFp48ittO4syI7PHVePdMqRB8+dMz61RvGH5gKY60ShFLuhP8w/h+Uu+1Jgmjgqg2ub/XuT1a4uLIxL9Jp3M3gl3PqjyYqcRuhY5J+it0N8O1QGixMG+F3bvRmaiyAuh6/NCPV7rRmQX+6UYEdcBkHHK8+Hk8LqXxNl11JAumYpFSphEjm7NxI7OTTgMuG4bmMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dholVvtiggUzVnBaLTWESOSFn0evx4/OUbTefhPpaxs=;
 b=LHGnSFkSYWarYzq+TxzOif3BPkDO/EiMOUKx0+ReDXyk9rkBEcTF3rFrvD65iwnocgumzsD42svKnDB+bCq6cICqnUah61uYHfv6AV0JHIALufDIJ8ILpCuw0nHLmVGkeoUl0LGuGmf7eSQo90SCobrG2CdV1YYVwBfAsiZM3qA7FqfcprksEG/Nnic4GP/ijJYNOas8RAyuJvjFZyqAPf/ihsn998AO6pkwQcDPXmiEgiwHYJp5d1uKHSd9XCxRdm4Nr/u2YU80njluOnPCAaKt0xO60jZjfg6X5zhHskhQtOOBvV54ZeCURIMal87GlvxpUcNtnx79aEvm2ryWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dholVvtiggUzVnBaLTWESOSFn0evx4/OUbTefhPpaxs=;
 b=m+BFMpm6sK8Qn+7MkuuYnTvrhQjgT0tbaS5SgAAnFV7kf8hpZ3yMYNGztTWdMwhZd9wMY9IxIMw48tZzJgUmMaQ8/WQTI4obDWfIwwQi2JzGjJWpnUR9HFtLA0qsmll5I1ywdZuoCfl7X27bYaKoUI01oTTd/r5VySw4VwqdsWfV7Dj7QwGBSE/3HnfnnlGdSxb0TggRvY6u5tRWkAd3hfQu4HviFpsFe4OhIOsJFpuDfnyxqaAGCa7nOwKSHeA9tDT04ODkUcsorB8lTCcD9QKK4ArUbydF8R5A670+sVWo+4oMHHKZ9wbg/rG8J1H8v6K48rthBtTeMrMW0rAM3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 19:50:38 +0000
Received: from MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f]) by MW6PR12MB8663.namprd12.prod.outlook.com
 ([fe80::594:5be3:34d:77f%2]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 19:50:38 +0000
Date: Thu, 27 Feb 2025 15:50:36 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	alex.williamson@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iommu: Add iommu_default_domain_free helper
Message-ID: <20250227195036.GK39591@nvidia.com>
References: <cover.1740600272.git.nicolinc@nvidia.com>
 <64511b5e5b2771e223799b92db40bee71e962b56.1740600272.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64511b5e5b2771e223799b92db40bee71e962b56.1740600272.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To MW6PR12MB8663.namprd12.prod.outlook.com
 (2603:10b6:303:240::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8663:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d1a162-255c-40c0-74a1-08dd576801e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QnqZrBSYHMOqb68ah9UsFBfDdjVho2Y70WwgWfxmGue9tefNPlfbfNYY1zH1?=
 =?us-ascii?Q?2Y+Hy+cAix+oCVqlqV7UaR6t5H6ulio0JrEA2sWAZ2hsyiVCKeCxaHqMUOzJ?=
 =?us-ascii?Q?AjKRj70KJ2tobH/ACrKmohD8gFtdMa76ogvPSbCczK3XUpJIzb97tLEYuBpF?=
 =?us-ascii?Q?LbKZdv+w4T3A6IgdlJxWS3IY3pCmZCn9vQQeXwN+u/wTN8cSyGnbeCN4Ft0F?=
 =?us-ascii?Q?3zPQs5UpTHF2vpfR3YfheShMpdf661FYukGlEUCvo0orkh/Js0YRZuwW/LUl?=
 =?us-ascii?Q?ixGmC2sTSpPKi+Y7qQDrZsScH3ozdWE+iHwp5iv1YMaPNyVn8HQGfWLNeMmb?=
 =?us-ascii?Q?TBk4pVAihr/SXtmUoEQe71uYghwf+tIIW9NrYnrOAuREdBZb7QyCw7uVffWb?=
 =?us-ascii?Q?uxLDjqX0BNcEjFVnFv20bKibaB4BLjR8TxSvnuFTI3kI65Bpklvuu8zsD+lN?=
 =?us-ascii?Q?/SI9zhh+nhdbVZjax/y+Ys49PxVfYRetiHgz/8GFXqtOQO/19iIwQiixj8z+?=
 =?us-ascii?Q?nZvmdxGkEArWqg008km9Awh9hNRn1EVMgB+AFyCXHiXOoUyWiQ0bouM4UIqX?=
 =?us-ascii?Q?tmRnoKYAeUsoctmqVrrXDaxAGZWsEoqxjgh5IGweBxwPaR/EtR2jAklwYF+w?=
 =?us-ascii?Q?fDCYN4CsyvIC9SSxkSS96P2i+mMKnI2vWkxoyYmXugBngAyl1B9M/c2FcIgU?=
 =?us-ascii?Q?X+Eb0dbZkKI/gzjWyMPQxfSPZl4TSKHCZoEs0gekAAicN27cR5cH0k5W0uKg?=
 =?us-ascii?Q?TMD0NDCmc8IkK0AzVLNgUkXJODfdqX8fKIa24E29dxHDLz+esfhfQ/jj0oPq?=
 =?us-ascii?Q?x+oMe5HojaOaQ1X1Fu1liLE7K06dpURQmmoapejZdmo50S3bzlt648tj7DC/?=
 =?us-ascii?Q?n2Vyyuj2BtSbLtIhkrFC/QK7nfdDJpwjYKlKJ2NAwD3f95JsYFmDp69O7CAB?=
 =?us-ascii?Q?nGey5ZLE7r1ShOK5ruWw9k/5D8hpK7Zz9JK/qR5ZLsBZisTseELqg4th3UDL?=
 =?us-ascii?Q?tcKNT+DKEjnn8mKTsYnCPko+3wRn/P7NEbRFVRvOD26Wg8NGSp3N1s/4j38A?=
 =?us-ascii?Q?6DG++1KVsrMi5UxHVQJCyCLrdqvCEOfp3yGlzyC3lHZNylYiCWD/32txhmdA?=
 =?us-ascii?Q?Yy0u3hpYaFx6ndS0HArjo2AFg1H9l4+rPv4PS6ZrPkz2lKH8O2sS1cHLdg8D?=
 =?us-ascii?Q?cWBTdyRzwF4wQKJxgW7eouJI7MV4EWFDzeqz/o7lPLYolxmE6WSv6+UmSACO?=
 =?us-ascii?Q?xA16tZfIlrEqhdd3O/9+1iumACgBXd04So8b7Kp65cNnEKoNPN5eIX9Lsoo8?=
 =?us-ascii?Q?eVW7prdP8JHVVDx86ZtJ0+yj+cA0B13GVi4My08sXMzPIdg0aMsjrqCQzX2u?=
 =?us-ascii?Q?XVotjUaYdRKhNVh6nyKKVG+pVJAo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GeNRw1svhqjATDSDsyAxsW2qysZO21GEEKxuV6GXJQgBGWuSycsRDO4J/mKh?=
 =?us-ascii?Q?JCupQNUleMfhgRkS89MQO0JvgvkVlVmrQggJrMha58ROVoOjhVozh3xeaoBJ?=
 =?us-ascii?Q?jGOU2m/LbIo0otqiwXI8OgwPXK7PHJNa2j60j6BcCuad13WEXQ/80bJuoFlC?=
 =?us-ascii?Q?h1JA8bcSeL8YVFQidx7IEXSXBvR60Q/6a9lCbcwNkVpHSmsxHNZgLyXWRsat?=
 =?us-ascii?Q?xGUJVoGkN7EEjeFGijM+WUMW+8Vlm5In+KCWWDcctkHZbWmo0ylk1lvmdXE/?=
 =?us-ascii?Q?EuS/0kaBwNOwgAXh41eMc+PvepnjvSh1oEMlvxoV0WsSn7ME7Ur41ySvoEMi?=
 =?us-ascii?Q?O6KfB08H9+THyMY6ZJ73Y9CckzqALd0F3rDrlTjwb0uMe2ycuCI0nZMvgyzx?=
 =?us-ascii?Q?OptRk1AGjvsTFFCOMk5ssS/sTBoj7SDitN79RuP0ZDBooTPNeN4r2sI2viUj?=
 =?us-ascii?Q?PGL0kfGI3BdrqMIKO5GexYKioZFdSl4Kro+QzjmcDM9OL7sxdWTrXaNEnXhi?=
 =?us-ascii?Q?efoLqGBidehJQSZef4yacyG4TKuct7X1/xscwb/G5t/TDexulAi0ZZ6QeEBe?=
 =?us-ascii?Q?UR/BL85r6zZpXn7XaMDGIZWK3/SP21tKXdeOgwgd/uFVdIvVBBP5ypVV/Z/d?=
 =?us-ascii?Q?Z3bcN8LVe3GnH/mjtAQNkpzOaUo2QkxSgIzChJCGm8ojkUl9mgS01A95yXfx?=
 =?us-ascii?Q?r7djRH5bLt/d6B721JwfBKoJy7qyXMt7z8U0A1ZVaQ7v3rU8E9oyvYIdLnhp?=
 =?us-ascii?Q?UL4fIfLiUYTzg4BCxAJcfHILuQHe9kar1EW8sX/qDxCMuHMlSd065FKyGnKi?=
 =?us-ascii?Q?I4BBo6+QaCRzgBELnfsKjGKq9io1HdEV2nqTszQNp4FTCDJGvSzkZ8A2zjzl?=
 =?us-ascii?Q?eDx3G59XIGA70tlLEibM/Z/Ba5kUYXMs8FUiKHCxVz8oJWiLxLect6GnorAg?=
 =?us-ascii?Q?2vEqsRXsgROUAGiYCAW1lSq8vAdL5zpzk9H6hKSm1Dpwh/KsqNsZ0Flj2uHl?=
 =?us-ascii?Q?S7TNHaMJcz75MN3PAJLs7POb5lBEWOJZy2OPaEZBEJR9eFRJyeQAl+Qz1ZgH?=
 =?us-ascii?Q?t5Q0ScXgnmyXPks9wx2M4cA4ylvv+zXifxcKGH7KxjEWdHTXyo3bOBnZndFA?=
 =?us-ascii?Q?USASQPspNChTUXpbu6vZcWDanSKgc+l5eX29YowQkHwxM2YbvHCnoAfmTxfC?=
 =?us-ascii?Q?Hr+Kieb92wEuMIr7sjP0Jmf3C7aOuGyLDupfIgdwM+hVxIo1Ji0CpN4Zdy2L?=
 =?us-ascii?Q?f7kjJSCg/RB7qthJQwhTrThWaYpuHMXA3NHZCj6qUqm7Cr+6eNR+MdvIvrJK?=
 =?us-ascii?Q?A+jPOurV7+NoPNOM6vlY8m68BYyYO980ibspBdzxJuF3YTkNQWjJeuQy2WNT?=
 =?us-ascii?Q?++sfk69xcNgdMmXHDV/SUL5G5Qd7/Evqm0fP2gU/7g/OX+dC4i6QJXWqQNPq?=
 =?us-ascii?Q?J8EGHQLXEflm9F94MmwmduCfzKnqjtaYGu8NNlEWonnK75HaewJEjWMXv3PL?=
 =?us-ascii?Q?w4GfXAZKa2j31UnSqx20e7mu2cb7/EjfIF13UGxuDPVeGHdOeJb4WZoZe1Hw?=
 =?us-ascii?Q?JXk+9afNq+dh/L9cx7Ny8ksTcJRjsh2/HB8UlAIK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d1a162-255c-40c0-74a1-08dd576801e7
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 19:50:37.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /g2owN6NXWHj1NHGtq211fdmO75nsZpmZyag1PJr/Zu4VX9kgSMNR1sTEuW5OuUJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

On Wed, Feb 26, 2025 at 12:16:05PM -0800, Nicolin Chen wrote:
> The iommu_put_dma_cookie() will be moved out of iommu_domain_free(). For a
> default domain, iommu_put_dma_cookie() can be simply added to this helper.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Let's try to do what Robin suggested and put a private_data_owner
value in the struct then this patch isn't used, we'd just do

      if (domain->private_data_owner == DMA)
	iommu_put_dma_cookie(domain);

Instead of this change and the similar VFIO change

Thanks,
Jason
