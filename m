Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D376282E1
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432632; cv=fail; b=VNu1x9OGAZu+31S1SLwNi1zg5X9R0JkkRnTTFxHtTkqSJutS6rf43fNsqcYPz64Va3SWVft71LKqgKXpsyv1tajqMZdN9/wHip3wzLe7wXXhFdVbZzP+e58FBQTu7faGHaRSkA+yabIQOtMTp0nvuVUSuYWSG0/cVFbiF1C4MHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432632; c=relaxed/simple;
	bh=vOUEuSlwBMzExaGv4LqEhDVQKLYPODtOkzqTYdA/ZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJHBLNzujs+KRGeyDJOnTk0PQplbTY5iG7DMYmXOvI9cMEgSSFmEP9FQE77C1xHXZ0nY/eJZa/l4YuCitWf/XvdtEeVUDeRcUxp9YijOJ47XSzn9JE413p67gWL+3y282+fHAyLZ/EZ5Yj4q/Tkc8Z30eYbvFoTMNjCbhkgGb4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/rrtKAZ; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/rrtKAZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfpTyzGB56r89NEVr1yWJARGlNn9mn1WAXmxB/1FaoNVHUDBkcqgL+1XoFb03Vf82HEpwym11n7B/9qtXgJKEMs4v/DI1LMiS2dFBmvp2tqYKQmONxIgZwq4aSBpf4RRaQ3SJrWSv34bGqoMXe5ZKHu0Q+Am7FNKMH89IbuRbLgdypUX1sYrRqklz2ZH+5bOTVcEEeR8g4K4dr4UN3FlaRRdGTGcnW+3bSryCVcQ/TPpVL+YLpoe62pmuoKw8q9EQ+7ZVQUIXUK6eMLlMiliuRInj1aoX79Dn873CapmrIeHnvciSIwxTzd2iczl4hNcOEGahZNzMtOm5sPvSbsVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZshVi/qH1bua0CyVZ3FPtpFMNljgCp5L4a4+b+3Fwk=;
 b=b8mYjwfeQND1QfTcA9nTWEEx02HokGK4rr/WgmKI0D8mBCNIHBdcfZjBX2iyDNmh1o2uS5zNz4NdnhpSqopkYCOMBWHS47q4z1VNEFtbKYszFOppm2O3ecjPuuW3att6ZClo4iR+jxgFArdPgD3bJXPlPem4TikOt0MS1g4bsuK6uSULlvP9rdLVFkOKvTOADT7sllyzHvdlUxXRhO7rR+mMm0OOy6DSxmgViUMTEkEo5cLO65JdkCmn9/7YEqcT2oWmtNFJ5HJUZoNu9231lIa12ZGs7C4JHWY36+kkLBK4WwCAtWM/kO7mkQDQTxCm0x3VvuBsKBvvyQXDO6qXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZshVi/qH1bua0CyVZ3FPtpFMNljgCp5L4a4+b+3Fwk=;
 b=Q/rrtKAZXDbvzV6wff/dzy25Xo2Va+ARfc1ZoVno+0FvPzmfrx6+d3GjGfQCUTmlktZllsoC/NqHr9YZXyKxN4XLDbIc9Nbhfo1pNIO+lDgPWUqkxJ5OaqbafcwGxjTYyKwtl+q7RwS0pR4XuQgNulL3gVKSfaZXR5epk2nRTWJ07B4ilDz7aioXhupZr8U3k7MXkFe7r9Q/UDe7imRnZBojBHic34ObIURuDiiaVTlqLYhXl1noMpkrzE8+2OFsYKlw4Dk3pZqX9Y1CkbL945Kh2c0JZFawUwKmoZMbBwfkA6qkWNsQt1WgfXY1aMUzK2q/q24ucG28PJaP64MtKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 20:37:05 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:37:05 +0000
Date: Sun, 15 Sep 2024 17:37:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 1/9] mm/gup: repin_folio_unhugely
Message-ID: <ZudFcANtENlaRJ+r@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-2-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: YQBPR0101CA0278.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::12) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 5351b300-245a-4952-f595-08dcd5c62985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qR6RxWd7Srck3JdHjdEwFTvI7VhKPbK7Ym2J+nnR2f2UV5ygK7j9anZHHh41?=
 =?us-ascii?Q?Tyn5t6pRI9ERvnA5QWXpVuU6/6ggBNtadOOFqPpp5kaa4GaXUbLMFb5BienR?=
 =?us-ascii?Q?vT9BK26v+3GiQcx9xQcniBDharYB0qoiKix+EvpOu6ZBtGmp9XF7Zq7es8g8?=
 =?us-ascii?Q?3vzccfjFAj3/ezKPokrrtALZU8FV+l46AlW2YZdqhYXNn3vJTMcK6MO5aVop?=
 =?us-ascii?Q?AU5VII+ZDm2Y2R6jUSvYURQqjMI5pml7H3FGsHNuoILEJvxuSXcAIS5YbP5U?=
 =?us-ascii?Q?RLrc0+aH59ofVIJ/pVp1hu6nK9XsZa2XEH9wML6GywVApiXTlA44cxatMKPL?=
 =?us-ascii?Q?l4tQd04sjDBHoZxy3lyobFKE2avqwcrHoVbVKyyV68fVjCqsqdx9oodKqG8B?=
 =?us-ascii?Q?3Ff4tVxvJkrHdHbSvZ2h2W1ERtvp/uPCkwRElvQgVPge0qhW9ru/UFTrAw6f?=
 =?us-ascii?Q?za/4Nr64YawMgd5EGNg/mXD0jVLZ0qiTyGa21c9Awi8WZTU+krVNSbyDAObR?=
 =?us-ascii?Q?KYCuc4gcUHtMaJAOdeefEit5+qd4UKGr+4ZlpgTncNU34d+QDDVUNmsqlxs4?=
 =?us-ascii?Q?9YMLvgPS0ut9ZJzj8XS8NAJEAiBPFg9IiajashA6StUPfYlZE8DVYz09+0E3?=
 =?us-ascii?Q?ZOPvqco8x9rDsPRHY2Q+TB3hhFA2ApjPq1s6Rhu8mgFoHQSERxz39ManPmb5?=
 =?us-ascii?Q?6+44x+RluMnDwlq5gjWel9tLgKAtPF4j4LMflskwm9r/YX1p7956JzIx+U05?=
 =?us-ascii?Q?uJDl2dJrJANnIAvecbUXs+ir3ikTWMCnk7s6b2OQg4m58n7HiMCqdK8MG+QS?=
 =?us-ascii?Q?R0M/lvV+zxIfRYZbgGgxcmJXv7sHvJ56GBrHL4bdE9N6VRvwZzE1oCYPRG5Y?=
 =?us-ascii?Q?OnxINrQONRfnhsXAZ23rqn+PfNe8EnRAhjfVBD9+K9DH3xDkn81yvUOtUnxt?=
 =?us-ascii?Q?7onR6Fnj2ba5aL4aDnamTih2jJwRA2U37lkjt/Ja5FEazV+umO/7rSO+SUv3?=
 =?us-ascii?Q?CvRxtrlUQ+gUWokEL8Mr6IhNAM91RkRXKQKCiZSFehM0m7gRGQgpy5HKYCYD?=
 =?us-ascii?Q?OJQNCzcmB0uXWp2UcOOFzUYQfdP7wc69340OiUslfivjdi7nrzo4pJIo2KXd?=
 =?us-ascii?Q?zz6qBgTOzOj28HC784e3aHCciyjL8dM97ra/BYOhI7Mu+cSlznDAKMIQ8uXH?=
 =?us-ascii?Q?xY0LHO05eJHWmKcIyZdxcJDZ4FOdEjcDQZ98FhHOhDoUCC+W2wF2EX1TRQbV?=
 =?us-ascii?Q?ZlZJC1KPkDrzFWTR62ubsuGircICW9B9XOTyftglmGzF4dIc2duByong+/Hu?=
 =?us-ascii?Q?CXrnZR+rkWcu2OoDorRMFI/6NTIg59AoOTBh5NnZPnsGqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7zIiV639zF/nOPnsofg6Me6SkEbPRvgA45jKvpic+vDhspRQhGyQv6oqQmKp?=
 =?us-ascii?Q?PYWJrFZy7346ZHNhUfhjqLlRFX4O3paIx5NiKd2rR4qJ53/MfxbxVBnT8BQH?=
 =?us-ascii?Q?O/7uC+OkBMh3r+S/POvw6vfQ6aIODfvoPmppqNvZs4jSTOOxQOFbbSS61Zlg?=
 =?us-ascii?Q?cUVEN+iYEsyG8QHpBhS6vY9tVwQcfhH+rCsQ6UaP8SJuvx3HTmwaZ1Zdmviq?=
 =?us-ascii?Q?3oOkXmttld8gGEx/cWR4e75HlS1Mi7CtnXzogGR5QyuDeT62RgDR6FzJrMrm?=
 =?us-ascii?Q?0dpRN5zg2OvM7u1Gy1vraH5aQDkHsHDZISjGMDz3a+o87R9V05Jug2yc/5cn?=
 =?us-ascii?Q?Le5unls2bpDthrjaBeuuaFfuiFK/qf3EgJ2BFYFApJ5A23TDu/U3MIFx+Amf?=
 =?us-ascii?Q?zTNCgUAw8HxiNO8TZ68TXQFWo5zgsqm5kgAQCh5CGVnvg7mUiaZ2V2q5aNAv?=
 =?us-ascii?Q?Q9bSQwrKOb8tc/W5y7GqClOz6PnrfWNrUwEfO588XmlGs2WZTMhRRBN24y2B?=
 =?us-ascii?Q?d+UA9zNoGtdLvbTLhGe3+tjF8jhxdRrNEa3egP8om1V0cSReGLsKu3VQ1yg3?=
 =?us-ascii?Q?Z169xeEwTU8QpMJsH9npLZAGQe/lBXciC6EPLeC5Dr8sfffCD8t9CiY9YLtl?=
 =?us-ascii?Q?wBCrtWAA5UDCO6onR+4C1hnTte9fS2yt5z4wgHcqA9qWguAGMd/+cvxRte4I?=
 =?us-ascii?Q?qlH0FkG4U7MPPioJUl4Atw+/2VvS7k5cYtxIHhXKUmixTElmLpSB0ZIMYwAK?=
 =?us-ascii?Q?QELYXUFGjXDefb3sYBIE03fVWC3JVDsSG9Ks5CrRc3Mpo4drgo65tMr3HYvC?=
 =?us-ascii?Q?aomVgL72u1fZP4AjB/JUQaI1bKVJ7BOSDwzUl4SNNzghNu6kqhD8S8fGH86a?=
 =?us-ascii?Q?Psk3uU0WsTaSdXjjfkvfqTPWTer6wYlFKZXIJ6jZtYsnFxqqMHvc1BJcyTgV?=
 =?us-ascii?Q?4WQN3QQ4QJqRaHZoUGCMRHqm8RHWXAHO7Uj8/D53SzoaqxuX9/oE/GrvRnnH?=
 =?us-ascii?Q?g4RNJty960ElBwg+ganM99h4EEvgDKgdUHisEkAKjyGNm1m1c9yOj9q88Gnc?=
 =?us-ascii?Q?I4GHXWMo//lXUjS9AyUWJaa82BG7UMA/UTkCu94fuBYC6HmKOTtmxy2Y35S0?=
 =?us-ascii?Q?yzA/opI+a06JzVgLYh6mhE9iIcSWsH6gi9RNB11eKXh9nscc4G+G2lMjJ7a5?=
 =?us-ascii?Q?27p1b6Tlau9TTjgSrOHUr+/M1Ry6RoQ8Cjjvt4NkNLuZ5JTN2dmqSdGpfgsn?=
 =?us-ascii?Q?10N1sMdNK9niuZcm32hMSMK5VhUQwasg9+gPF2YpA/v9lQPz09Ww/zvT34fj?=
 =?us-ascii?Q?47oBPs2+0IjYBkIY8+NrHs1dhZS6JpBj0bv2rtbon3cA6lCEhHignUP6OfqE?=
 =?us-ascii?Q?DncRVOWLng9SMfXL8ef8UiYy2BgDqMwiYKfXpyH/GV2QBbmwk5McOehRfRHU?=
 =?us-ascii?Q?qlixBMcJZwMby5Ilu1+2tXXDcGUnSy6dV30CnUz1fKocWeJIMXEjz0mWMCke?=
 =?us-ascii?Q?B07eAkx287Nao190zlN1s56LfuDhi6az3Z2mYc93i358s7CbqLYdwyyHGjDj?=
 =?us-ascii?Q?+DhqOyUQ7aSfORt9GXxBMAfvsrtcrJq99oSH4Vtw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5351b300-245a-4952-f595-08dcd5c62985
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:37:05.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVPm05zrL4G27i7TQEeKvxl05xosNIEGqjc1/zfh8tIg37noydDLuVPEAR8vuxvH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365

On Sat, Sep 14, 2024 at 06:05:50AM -0700, Steve Sistare wrote:
> diff --git a/mm/gup.c b/mm/gup.c
> index 947881ff..f8f3f2a 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -3720,3 +3720,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(memfd_pin_folios);
> +
> +/**
> + * repin_folio_unhugely() - repin a folio at small page granularity
> + * @folio: the folio to repin
> + * @npin:  the number of pages pinned in the folio
> + *
> + * Given a huge page folio that is already pinned, and the number of small
> + * pages that are pinned in it, adjust the pincount to reflect small-page
> + * granularity.  Each small page can later be unpinned individually.
> + */

I think the language choice here is probably not entirely consistent
with the rest of the code..

Maybe 

 folio_split_user_page_pin(folio, npages)
 @npages: The new number of pages the folio pin reference should hold

 Given a high order folio that is already pinned adjust the reference
 count to allow unpin_user_page_range() and related to be called on a
 the folio. npages is the number of pages that will be passed to a
 future unpin_user_page_range().

Which anchors it in the purpose a little more

The implementation looked OK to me

Jason
