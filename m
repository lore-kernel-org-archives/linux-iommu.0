Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A23175BF
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379391; cv=fail; b=YSTwIwulgfHS9sE2A3BwEBkZXZSyFhEiavV6KyQ9d5qQJ8VUlojnQDkjCLjZFmEV1hADpI3JZhz8XG1tXnRsexYLl4YDSQ3gmVKYnw/3+YhslstFunfSCg8mML5bjfoOt53WcHIMqu/iRTCvZVlYBZqzGKHyICvYhXNNrqtLV7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379391; c=relaxed/simple;
	bh=uQRvh0W3blDq4speOYp6QwEJeO7c2kyJYh3oNjvLjoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lH/pO/3547Yck4+Csz8XjqX27yTgmCm8UaiD1SFWXWp6E6ioPe3MVz7J6qjQUsWjin8RHWVopxj5d8/WEWOFSG3CK2fHyZfcYkwejUT4byKa69NXtqoLUkgI7U+2JRjD8WDvW3aaTTbxi04ylKwTvanhVkx1x19BlqMKMXrDOcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oKLoNmSi; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oKLoNmSi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C27gVPLXeb5P4RJAIquEpeUroXBKrTh00beS08MxDGp0hC0l7NnUNL9SAUknO8bZPpmwV8pC4z3jGIwMgP/eoqvmjwXQpip4tjxktcOpb4VHZRuR5amV+i1DajoGOBLIpRXLyhzBwmcY1jEuy6Ms3V51MJKjPEfG1qlPuC23wf98T3+PoDa/cf1goNi5YP6vV2WdHBlnhxQXwdkWoeQdf50hJ9O30QXXKxC0OsX1CKwmryZt0Hl309cxUSxDyQV0CbJ/gcJKf5C4MdZH45zF+M9TkTaoHFq5A5GS5tAYV2h9fEvPW1pw24h30LLxUvuTnHA7ZYU+7zKl8VqEUMF0yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAlO3QZTR/AuwxQaTrKLE6Ym6xBzxAJIEVE0ixx/EH0=;
 b=ZNHS0AKMcjbGvghlelpPI8X3Nt+eTIuADYjyXumrNufUtDhciTZwmKpEOI0umzvrad6kcP8FiCgRvVGqG+TFIkOf3uMR9HfFlsCXq8hH0cOZ0Onjqsb2B8n9+m0NPIp4uBBJUa/EzLVrVoRqLEa6HV2ProUAFViW0nTy8CLjYBd2pxUVP/7qXWOl81DSapXyxy9pq4q3MdsBZ/xOP7Yy2dEbBnS962JeLta4/1GdfLkeT7jUm8hnlYeBgkBpakAllZVy+czx6RkZQY1X2gViPUtHA47MBjqeIoc/yfnRy0ciy44dmCDc1fun+6Xzqs39r9Dc2uYj3N0S/pfG6WYU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAlO3QZTR/AuwxQaTrKLE6Ym6xBzxAJIEVE0ixx/EH0=;
 b=oKLoNmSiY+qvInC3/RmEpG0nISlyzcdPzZ5eIoZClXQObNWmzKtYAuIKiES3Kw3zp8Ru16dyRWZkp2ckh8kjz7Er200u2prBhFtpBclJK5EJ6DMtSATUmsiMoU9AeK7aFMlnRHA2RBkwjj/gGJVahLgzCZMvAdTq29ZlPHO3K2SZLJ8Uj+/6vACs3/IqDra5TpitERiTACXXGnujtDfHYRfTdjwUzFO2VoT3O4lIC7YPjEa8YaRF/bj0YO1WZ5f09rRTqRtEkL0Cy/Azzh6Xu/EZ8Cotrfo33fQlZYWuh5U/fku3Xf5br6aKrWTK+0uaoA0LztdaJrizozkJgIHaow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 12:56:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 12:56:22 +0000
Date: Thu, 31 Oct 2024 09:56:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v7 10/10] iommu/amd: Remove amd_iommu_apply_erratum_63()
Message-ID: <20241031125621.GG10193@nvidia.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
 <20241031091624.4895-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031091624.4895-11-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:e7::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: 0061bd8e-b162-4803-a59e-08dcf9ab6c05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kh85PRrBO5WFWoWk8pSIgFSgyOEiPvAXzOfprCkeVlZxXImGjA45o75tGPGV?=
 =?us-ascii?Q?RVlPNnTJG5rJwuUhCuSg6GpmHFUCZadXljxXqzWkN/HBwfO3QtrDsWQSfcT+?=
 =?us-ascii?Q?Z1hXlWNVJgBtS4wZgedbjo2OgVV/69vNp5QDAiRMmHfQaw2bPRSYZksZ1aVs?=
 =?us-ascii?Q?3TrUvO5D+w1WiekgCops62v1IxcWj63s4cdgUy7aJrxr7TwWT++X8MvMa1V5?=
 =?us-ascii?Q?GAgf5EyKcj/qmEaskPOpM3P5hwVbhvuVDyy0IlN5ZePEwgnmKbDDPtDHkcaZ?=
 =?us-ascii?Q?rqLh+G8TM41GUzHyMnyq36ud6uW/rtYiZSVEBVQWZzX1LDCM0NcPSuiguT5O?=
 =?us-ascii?Q?Qu4kWlPH+nWfScFwy+fR7sFT1+TlyyWE2z2OK4ast9ymKsB0/UiQiOpqXALT?=
 =?us-ascii?Q?HhkKFbF9Hdw6Ikx6F+UQAzLdDHc/LN8EbDAU6ZOi5MAjccxAJaO+oKOYIz7Q?=
 =?us-ascii?Q?+rHeYnX0KTKlD2NjJ8H/eLbkdKVotK0/mgWSAUfC205bqlPTe17Hc0JJDYpa?=
 =?us-ascii?Q?xPN6e2U98p98ME42M1GBVMY74JM8zn6r+0KxunHdmcUPARh0ALsz5ITpHaha?=
 =?us-ascii?Q?4nzIo5OG8/xassJCkdXczfJLOL6m3z9whLYeRMpUDEVoLIBZROlFOyKHgAwP?=
 =?us-ascii?Q?HR/7V6LT3ncv02l+WSkfQPYCCcxSaawT7hrAOHyms1HWU5DbKU6dPwxyu8zf?=
 =?us-ascii?Q?jeet5wYrVWgzvbuWDMtIQxqUlE1q0tZRqxBfQfmdEuGGBL6I0aZJs1NipH2N?=
 =?us-ascii?Q?sDj3a5iqfwUnYOTqbGvkO7NgVWmxKLYsY6lksFtoyMvEfcKjsQfDua/TZzvI?=
 =?us-ascii?Q?6XQ27DGkwBkSu9Gct0KB6pWAHRxQ1ddWqZo/eEl496zVXlkoOX0/Fh/3Y5bE?=
 =?us-ascii?Q?BsLjhvSCYgGHiwCZ7CYlE+ZWoH7SX6wKFLjQVqrj18Qf7gF61omPG/BBBizu?=
 =?us-ascii?Q?g+BGpI/Qg6Rn44pOweWkTL4BsGVf8vzQC92mofggTw/0qeZKh2IRoCleHN8a?=
 =?us-ascii?Q?RbThFO4ZeYEeq2ZHFUg7RLcfIHRbEqTBa2zeG7ZSSMeJcDd1h78q1LHx8ifk?=
 =?us-ascii?Q?JYBSKASlHuxN5uvBOXliWVdQnKRXqT0KwD+8YHqacmkRLiAZ4qve0Inv/KjH?=
 =?us-ascii?Q?kcUnMSxU1vEe9I2zvKef5MWkciaiUBXd1GYrhkde8bp34e2+8prr9+dTbFGm?=
 =?us-ascii?Q?BoIYH0AxQbq1fzlJ2z8x4VqevP3QkVYjDOODUQ8k8rwXvquP8Ud0ZckBbMSj?=
 =?us-ascii?Q?WXl7OAX+W5iO/j3jwwF62IXfpGWmmcTvIqLvL3I3B61eei2kyaRWHQsBNkwo?=
 =?us-ascii?Q?nLmK3LOEkvJ6d4amMD1Xd3yN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kYhfJUkOh86O7pd6AWPIS6WGMMlLj3l7bmVTPSLuRLNNlwje8ddJf0v7Xm4S?=
 =?us-ascii?Q?mY7QtE6Rat3TnZaOkakCs0mHng8TPoAO0KiXzi/LqPoM0rnsAehNKGAHXXcS?=
 =?us-ascii?Q?UorEjXJsZbOU9HJrzNiyufhVqMLPeR2d666SYDBegC9VIyrn30h9AaTdgWX5?=
 =?us-ascii?Q?bKxTB/4wpVqj4hPq81CcuHxpifFuXdp8Dt4JhpmtgPI1jIt1rvYqC/DoRIE5?=
 =?us-ascii?Q?0xxjneaPzikRnoySEG/zZdWyXOYYpn8rQ+lvUVIH8Em4qgGVxDYY+m4qMG0r?=
 =?us-ascii?Q?joi64J8Spolc2uUuflnBEJ8wYGmxBJkZKgHdYvliTpS3zbyGKGO6Ik/nKc9t?=
 =?us-ascii?Q?Ot93hQZqbjCeknU8T3TYnRPZ8Ysm1oQFNpZpH3OPch8z6zoXo1hToEAfAkSW?=
 =?us-ascii?Q?LBkHGBbbKpndkUnO2VhEJLZ/0n/d894V7Vn3VrYhkRv3o5QqQni4VyMFQmnU?=
 =?us-ascii?Q?2svhHEEnzZ4+HbxZX7R7smGI7xJ4+Vj6IK9q2yLnru2WJAVy+Bs2yyQ5UnXn?=
 =?us-ascii?Q?7hVimaRDvVtA0jkjQkDIyikUstS0P2uvt+IbUze+m6H21/9Bhl/yD2dAijko?=
 =?us-ascii?Q?Yfmf5dH/UAgWRel4ZNqAJc7FQBMzhFJnGMqQfgq6ErIY1bsOTWbMGVRYGHGS?=
 =?us-ascii?Q?fZWapO45YA5SGM2KLzNgwH1bTVzrQY5QUhfzU6i2csaJDxAK6i+vidafPxCG?=
 =?us-ascii?Q?uRpD7nXqVw13wDXBCwXeh47YJ3dKJvKkHNL6DRRJNRtZiIJuNFp5f0RweXQT?=
 =?us-ascii?Q?7X4Yd08Y6xaJvC62/k1o+CjT9N7CAL8UYKU23xqnEYR8oL8CDttLGbKhzwYz?=
 =?us-ascii?Q?jEUIRd9rAdwTPajSRI8dNt8ROT+vas9Reg0IKYi0ewcbICanacduTSTimTmQ?=
 =?us-ascii?Q?Acu+v5n+fACv8kVeL6faGhhZEFXMt4sxEyETNQrWwYIVCgwE0ProgT/jCqBC?=
 =?us-ascii?Q?MPYpBAbWcmurbsvvYDWtmhG+q8cR5OUGW8GjiK6F1uKahda80tOavG37j3hb?=
 =?us-ascii?Q?brckzxSsS20SAvlxdZRYdYX+SttI5KIGethh4muS1H4BAVOBFSPWBaKCtFuC?=
 =?us-ascii?Q?R8/v2mlh2D/wg0UrglWR70c3DqA3zSAvM1O9ZlIERuaRl7FswQwRUXakQSQf?=
 =?us-ascii?Q?9fKuPFb8Qjurq1Y7FKt6G2ka7UXK/bW+IByF9OLZQJyBc9UAQUhntax33A2q?=
 =?us-ascii?Q?g68ID+ECv49AM9FVFmXjKDq7s2VB+QqMPg5LUevc5urGt52caJnu9DZJysny?=
 =?us-ascii?Q?ulqAKpwb8UHYgU9aqeUFasvGNuNpCbTjf48tqo9QabndHwVPtBDia5uYhbL1?=
 =?us-ascii?Q?VdJ2Wh7yyEKXC0uDMYjPXwYlRvcQYDZI7T2EPY8NrSEHbqJFzQwEUM4ct3PC?=
 =?us-ascii?Q?yVhjR4k9k8xs+aXhZ3bYMP2NrO5qOo5Y9rnfEtDTG+Gqyvuqdv5wW45GCjAW?=
 =?us-ascii?Q?66SLW+DhNTjvVPBUr6eElVrx1eypY6RYiYeGm/wyJWkbb8dudRFnBR7Rb7Ni?=
 =?us-ascii?Q?VUj/2uDQnH64LeBuB6+HvNdxoX6WmkP52NxTJYkgEV9d0JPd+C1klewPO5zE?=
 =?us-ascii?Q?I63QbNvXioIKRvCJwE0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0061bd8e-b162-4803-a59e-08dcf9ab6c05
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:56:22.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRMdC80EoB2FZI7k+/kRJAgXwNQ5qBMMIn6EQwUjTGKtCjIThsWqygYQ/3knRto2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147

On Thu, Oct 31, 2024 at 09:16:24AM +0000, Suravee Suthikulpanit wrote:
> Also replace __set_dev_entry_bit() with set_dte_bit() and remove unused
> helper functions.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  1 -
>  drivers/iommu/amd/init.c      | 50 +++--------------------------------
>  2 files changed, 3 insertions(+), 48 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
