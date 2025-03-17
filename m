Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4E1B4232
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242915; cv=fail; b=ueTgD428EcA9jJ8nwQMTZ/PMtz0GdigZJRZCH89fcTKA9R9SMFO8MpsF2bQtcN/SURlMR1JPNC2D4I9lRO/K/ZstCwCuK5j4l9TXM/8UNrQaxeBehCBN15TfPVP2zUEQpVXFP/Owfp+tW88e8R1C8erf4rUmb7DwwiNZgz5XXv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242915; c=relaxed/simple;
	bh=Jxev11uvWNHTurCdywER7BQ6EvUwCw/xD0HNAvktHJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XkAdfhi88Z37FeEtIG+uDio6b3ZRiKzhXwtVLzIcBxAGKCO5a7DFMZhCx2ExnDg3m3QRE6pZF0J+VLfsiNCq52u2wHuNRsgXspM17Fv4EgaWWRYrG9c16b70hLYCOgsOeDYieccyZ/IcLd9Cwynfa2E9qpzwgSde23cjqnnmZn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lV0Yb5n5; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lV0Yb5n5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1i2JUnotH2byO9/p68o7R2G5ArBJ54NdcAuX+bUJuXiCtTXEgrSrdeb9C1sOhfLLLZTaTeKsAhdhcyOddC9mYKE48WdziTfHmkZNmvy2zMoIsY+1N+bsKBEEPdvesg5tJwl7lpKTWHbexPnCbGM/h6TwvTt1XkAbJcGm3cfpPrhvINqskJLEQNkvAbc3dZcuzu9HdQQyi1b20zdkMvpHTzPoyFDSj9/31rkt1piYn9q8N5/etzjeLn1HfgOT+wAzTGPV3Hd2iTOpAMSnapBCSyGjVDYbCDpIsAxIHpUYBJVe6/fqO+aDAWAzi2uI9bgd1aGak24AnktqmvOulBlJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIQz+s/ysmwtqXY94YqBgBwuL3vgvB9qbmfyQuho3V0=;
 b=k8euk/+YFGlqOZbXv9ejjshoV+njPXr2xCNF8AmzOqNyTHulTqRCwW5f9LvTSWOx1+ACkj43fROveyFqjdlCMWEyT6DN/zOYE+f/NIKtU5YRLNw2DJgnw8Nc6DzFRCeLeJ7pqEUfHguFFatLcG8DFxBylr38gWzeGCFMiJwcXcRjLWrrGzoHv5Sk6xhNEFJQyE8/77ifwvzMmHh6Abt7q8kdgulwdIeF9uHtDyh7Gl+sf0c9QNezkpbeORV5psPgSiq3olpKuCJzVVihva4x+56+c/4QwH4kQN9LC51jXO/ayoODqlpWnLJiTy+nDqOWjY8/snk77itYhHzAqwPzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIQz+s/ysmwtqXY94YqBgBwuL3vgvB9qbmfyQuho3V0=;
 b=lV0Yb5n5qOVtqJeqIzPxWiZflk20CjJgLB7qw+qKnRO9rfXCZy233dPp/W0zRZqThqBt5j/c9liWBu+Obdc1FEQB72W1eRpNrdqXUQgNt2EGxg5YHEnEaub69xOm8IDmRaVoG8qwMmh8/4KafLasHqAdAI4PSub1SDa6MCw5cg5AZk26azTVMDb4RFa2nZ4EW+uWqBBjvvELrpvFbU69G/OR0DQPsq3XE/byCh60Aqq3smOS8ieqeCgMh2KwIPngo+lW5aEF3j6PH6tzVCweLyhG34/gXgnJOMfk2EX5JLkpco1dvrZRSBd+82mbr46NY4RHsqQ0y/U7thN6vaUypw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 20:21:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 20:21:47 +0000
Date: Mon, 17 Mar 2025 17:21:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, joro@8bytes.org
Cc: kevin.tian@intel.com, robin.murphy@arm.com, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iommu: Clean up cookie and sw_msi in struct
 iommu_domain
Message-ID: <20250317202145.GY9311@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741294235.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0440.namprd03.prod.outlook.com
 (2603:10b6:408:113::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 928d49ee-257a-4bf7-47aa-08dd65915768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rx8Quul2gmx+vT2VzdFAmZGJ5bUDAXLZM+emlhp49cHsw4/7qrdIk+I3Swnh?=
 =?us-ascii?Q?DqcpaZRSw0iKRCYwHX0M9IvfojwjtZnndpsaaUMdgYrw1rsUYS74Nbd49ri3?=
 =?us-ascii?Q?y8PvtV+QI/3PKKdJtIXJOwQN7dt2XNqUXDC+O/71t1KXHBGGnaQ5A40XgNz/?=
 =?us-ascii?Q?sUHDLVOWIKwhMyWmrhx+vYbhoF+mwiQVN0WLzZG14UC6hGQANUR30V6rOpHX?=
 =?us-ascii?Q?LnijpcHkrMedV75yNx2jKe1LoJyYphALh4PJC9NfDFaakYaSTrVHvsKPzMcU?=
 =?us-ascii?Q?XQWaPxHn0zFgNQgAHJ42rNFJtu1J6ZCPLN4QDPvNQO7H1ssam5O+aZahMAKR?=
 =?us-ascii?Q?Slq9L1PTcaJ2cRexnw+WJheCLBAm9sqqYWaf6BmpApyRD9eAd2KSzXe9fBEh?=
 =?us-ascii?Q?aGtAHQa0ehq3HvTUu1kYyJt6r28V97q2bkQ4iZWld0vpWj80ZR/Sf0fx08WX?=
 =?us-ascii?Q?HvZBvI8+NVInhXQEcR13BQM9cM3ezm1UTQlMiKoAfqLbLr2Fp+i2EM273IaL?=
 =?us-ascii?Q?i0RqV7Dm4RU+nldEtTiWZSAjAiqYqor0770gUWHFh/bxbSd6KRhbMXRXKr9D?=
 =?us-ascii?Q?FAD2Zj/YT4oeVB8RFUUxor1b/C05glxYY722JuGPH2CAx1HB3JZRX/lro2ax?=
 =?us-ascii?Q?BpBwGBee7F/zIVyJx5d7e6fwNv3mBuhrx0PXcxoyqYNjLpI0yNkvzot7R5xR?=
 =?us-ascii?Q?878Fr9yhvEXvtMLdIYO5T+oo9bT62lhPPNICCCjfbLunAlmDZcYRuEgxuy/v?=
 =?us-ascii?Q?8cgw7s43WQerg9LjGEdtyQMP9tSKntvSDNS0WQ31QAW6FQzasT7lSSK3T9ut?=
 =?us-ascii?Q?eKHtQfhlPRZanOeKqnLnHu8Ex/i7HvAYg/q2KdaT/FT3Uyvv0mDXP/8Jlini?=
 =?us-ascii?Q?HJ4LfDcfTPh75FcGUYwFkFvam7zvyA8hhpa0G6nmCadx4uc0OWcYSSrJFfJU?=
 =?us-ascii?Q?EvUMKkDGJf2+oG0FrxnHoFajI7pNIL/lwHesr2Ds9fwxSy+8f7vQOTilFN0U?=
 =?us-ascii?Q?1/6OKireTK41OO4HRtVcZhyUmSoj9rlMzOcrySSrG8nBA35MbtZg5/+7zRIM?=
 =?us-ascii?Q?nJmLWGKtIZHiqkMSa5rasgbcSc5DJVLr3i7QefmnMooACRjyXr7sk6mzIDtk?=
 =?us-ascii?Q?R6g1TQrxD4cm4hZnKOwC/L84IkxTsIlzTYgk2s10QgkYaosgUIbbUSK5AjDZ?=
 =?us-ascii?Q?fP0TnPQCwHuwj9rDfvt0x3DqwOFf6xl2OToLEHIjKlta3ElAOQGQnXjs8mpm?=
 =?us-ascii?Q?XwdvScPz5ITQWZU2NpnUOqRWwD7jv6JFV5hlQWtdg/letJlZyv9KMR4FprCW?=
 =?us-ascii?Q?4nx4SpP4ySyUEWNkNdLlyK1HruiSX+UYb2hQuku+otulg9M4f6th98pFaUj3?=
 =?us-ascii?Q?3ygejkVZijq3l7si8x66BhPT5goQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oHs2wYqlCash964atIdOwd2cnqV8sM0GVowXXr5FCbvwkEtfR3Ea2PfyXVPX?=
 =?us-ascii?Q?yU939TuNDAfAWHG/e4hqqxYRbWDHqx0a4mfQLaNvSuPjsO8bPyzLWA/2ni95?=
 =?us-ascii?Q?oXECIpA/Uqob1I5mM92Ohbe4IU5dSYYwLXCui4eNfKXRxaUvV7nXShD9TXSO?=
 =?us-ascii?Q?mSy7jR5WRuS/r9hBZf+rYJA7Y0QjHjsaUeH8p1wkVNBG6Ilp3M9kJ1nNB2BE?=
 =?us-ascii?Q?R7i6sZ9zWaugB9gUj3NhUYgNGS264ByYh5GvVQk9ZBKdnm30t2tjrvkooIrX?=
 =?us-ascii?Q?Syno2XcFvl/eyoBIKKkCERfUk7mwIZlPvlsBpjpvhwwf98mwDnnkAqbHc6ln?=
 =?us-ascii?Q?GgUeSC1r9Yam1U6kOzQMHn12DmsEfDwWhEFisHJ5aF6oXgm83Pka6f+d+lPB?=
 =?us-ascii?Q?Oo/22a576yA3sKsF88nmnryHobwXJqi7Wr2V16AzmvChpENj7vjobiA8ago5?=
 =?us-ascii?Q?HskboqRqBkMZev10QP7V7Gz+K3kxmFTVWildhWQZ4pdgC58fM9TlWEE/6DwZ?=
 =?us-ascii?Q?qb6c4cLzAZ3R3XWQR4ygAuKD6e6bkFO+YAXFHE00OJcPju3i7N+MElJVLI+t?=
 =?us-ascii?Q?+zOSR4O9j1/OmxmftEJNysKB/fBZEg/FNKi4uKO0+/v9p7xgpUCgsRzi8sQN?=
 =?us-ascii?Q?283PE17pcZ0oZPPeROPiZt8Qwa73bF35CLaL3crLJQsfI33UZh2FCqnBMPIL?=
 =?us-ascii?Q?WvYllrmQ5c5/Nqx/4Wotfw0CjYITt6lUYiSk/HHT3jNfaT/pc9v4sdfj0Rzi?=
 =?us-ascii?Q?DZj8kydeGeKQCwyNC6QgpPKOvNVxsIXKJcY+B68bRZodWA3nmlMOxlZG81r4?=
 =?us-ascii?Q?k5g6ttRRzRfDe+/QWOBI++EFSVc2ZzPTQIYKVmcfKq6TRrV3lN7HU5k1k4iB?=
 =?us-ascii?Q?DVQQUyfEkIibw7CB6GzyOeGKNQZku6Nwc8CJfyqU7YipbmuAeNlAOZydrpVs?=
 =?us-ascii?Q?w1J3bTkwMbO1bxFXVJSS/6qxuQcxNzTDixnka5BSda5lN6FzKXWAKhn8jsZf?=
 =?us-ascii?Q?HmHObuKhAOx2aE2DTLAEP+92YpRMvpEPg8y/2mxeRa3IGVa96j4ua/lEextf?=
 =?us-ascii?Q?eHG8q4UfJzwolGuF0By6vO4IqfX3wmjmP0KyhVTZtq6OwQqh7Vocx2otiTxP?=
 =?us-ascii?Q?FHykwnL/GxMWCMB8iXfHiJy6MlTnmx3Byk0UXHlNxG/NtQtOEz3jZw8ZK7fT?=
 =?us-ascii?Q?6Rr9VyVuLJp79oxrOzfG/asaDGxOMtWEuufueJlels81Bbl1Hww4RhhmsI8b?=
 =?us-ascii?Q?E0dsOFEhtcN+ZEfDs8kKcowvwzWlfuBqnFVABEvDCtCzLDrIJPrhkg5GmSQC?=
 =?us-ascii?Q?yhUUKdvMvfp9cKx1fzvebHnzbhHij4wF+cnrY0sDpbDi93TXewqLJCPQ+awK?=
 =?us-ascii?Q?PnVDc0PM7l/mQFt5uXqiYM46Yrm1F9UlXbOmRaFXuLFzoEJcUptmXvhtsiH/?=
 =?us-ascii?Q?qYWigZ5rViYwnOK0xusZvjysCGb1SSwY4Mg3qc8Q0al6Dqh5e1Q4auuQaQED?=
 =?us-ascii?Q?DPyawPsPV1YZxmfSlt1ljFSayZD4m2VNaLB5sp0BgWUuKfv6QwdMnAbus1Uw?=
 =?us-ascii?Q?1L5IlB6lp2ZxsLumaAs0gJ5QBxYVHLiiSBpgjev3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928d49ee-257a-4bf7-47aa-08dd65915768
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 20:21:46.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y88VJ/Npxoe9CewfdJtcEpmf+NeNW/xbeikiPYqS7cKj90poE6kXWiV9jFCSVRC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323

On Thu, Mar 06, 2025 at 01:00:46PM -0800, Nicolin Chen wrote:

> Changelog
> v4
>  * Rebase on top of a bug fix for hwpt_iommufd cookie
>    https://lore.kernel.org/all/20250305211800.229465-1-nicolinc@nvidia.com/

I suppose this means it needs to go to the iommufd tree?

Joerg OK?

Thanks,
Jason
