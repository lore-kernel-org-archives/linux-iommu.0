Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557F13C3F2
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087386; cv=fail; b=iLnDqZH2OKaQytVGroPD+zEUSDUemikChC1+BXdKET/iyTpMODbljTz/RngSsLDJIvHY69D4i4F0zYWa/2z5KBQ5oMNk5vIAVkW5FEf5sNuOf7fcVFYNUWfHpdU8cZhp8S2xgXn87pnwKb2YbDh5VUQ74I1bXfzlwMkT1TUJv/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087386; c=relaxed/simple;
	bh=gqyJNHFef7y+zzXN2FeQ1JR7JpbFKmzvILkXT6TG9Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r7Q0px6twj7dNVfs9QnvLbNwKBVVg5xpTgUAoHUzg3LOmna/vxBgQeAkxxmTEv7C6nmFeXO/N/7oYS7zZGqzFXnIgtETYYDvJJpU8zKsCbFSW5Ow84Q8DhoW3mt7eIccXn6F5ASfJ4dz9HLQtyYmiTepOGse5E3+c8pai5fKfJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gQXtsKUz; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gQXtsKUz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urfthnu2QQtNVUs63uPLAo65SUGhIggqm8waxjia1iaVOD0Oc2xwyZlwsq4bRifGLxhdvzGVyvAE1Kjm3Hu0UAqcFKbPDI47OOgOwrZsEw7SSW6nvH54PE+1krZ6Iwx20o/c4pbLNKa+IpDIRmPUDplShUYdO6B66XUw1Rz1liiZfTitMj10GAax00qRvEHlugt9ADxHpet2HftG2yALblndLFavaDZEUdWnsjVjaDpml1yraG0Bykanqjp/EZ88ntavTvVBx7K355BB7QqaCaciGsZXZCuwBK/k5TqyuKc4tNx5tsza5hSmMFOHm1TBSnV1xAUwWVst/1aNOAC2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/y/cM/nnMFfbjcC2PDEJrIw60BlNnmdlTDVj0Xr+5o=;
 b=tWFJLIRL3yODxvu1879zh7UoSQ7kAkZdcyR+DTosZ8IRJxqn64OHnjNaY8hTuzgmoUOSfqet+ghHKScwch7qfJY1JOktYAnm8kfXV57Bh95HpWtw4UJo+dpFguld6J2es4Pb0YKvvBx+JzkeZyQobIQ6sKm1NNgXL2VpAvPCGOSekC/IeIxw/1Vae4vH0Di1NRAGN/D2Wa7eLhVytZ30mvjy/BpddpJhCVpMb5eEE1YzeO25zPmWQYWmE5ScPyBKBP1CIFQ6fF/doG8PBaIaZMrTKRVGLj5tkX12+VLq/8V3JFY2IOYZmcbLBoTBMC/LwUoFFcJug2Ou5mjhLeqaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/y/cM/nnMFfbjcC2PDEJrIw60BlNnmdlTDVj0Xr+5o=;
 b=gQXtsKUzpFxmELl+cwX7OWuQTH520BmrhrvnI1SUK9PHvrpi0FtbBlHxnML/BGoyVlcTyAFGhti43udRGhjW8Hi9nmxXooiP77yaJuQqW6NB9yMjdvzH+eS0LvJ/ZRDFHnsv8xEzDSbYHVinHQvlJCODjxFI1PNWN6gb+GNzwwMsHptbva1H7kCluKIAp2tBT+xQldPh8gUMCjVbJBKnBV+lTWu9kMSRLm9UeATk9RKMp4IiyyPsCU7IKyrxJ+oFibHsv8NJWI81oJ7UfjMOglxXYQVmTL6NDhNddHan2EqKol/ACzbm96I8Gupcywz3lWG/C7ECJ3wu3Hj7ukoFiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:09:41 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:09:40 +0000
Date: Mon, 19 Aug 2024 14:09:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH] iommu/amd: Modify set_dte_entry() to use 128-bit cmpxchg
 operation
Message-ID: <20240819170939.GI2032816@nvidia.com>
References: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BLAP220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 54799c4f-7de4-4a37-dba8-08dcc071b68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/Ek5OoRkNswmE5jL6UjdHwFoZnhK3RX+whsOghZ5p9GQf8e/0BreFKFU5gm?=
 =?us-ascii?Q?xPOfkjCvcVDE3zaZJEcHJS+L4CztYImfLhK3vYrHRDuWBuiQZGZ2tYmzvMyN?=
 =?us-ascii?Q?201UYnD8RpfPewJ2jtDaDrECgJkewaQyVPRzaYtqBw4SYr+eKYqsDOZYCWJ7?=
 =?us-ascii?Q?tSqj6ABvZXoB25fMnXgXOalNszuMRacLmHo2SQCIgWi88R/9o57N3IY6qsMa?=
 =?us-ascii?Q?wEm8ccTi9sySfuVeNIN7MJ9p6G7WKilxYJXY4IOD/T9OV2axTGSPbuKolcqw?=
 =?us-ascii?Q?zObSM+FvfmfTw3c+/1Qg9C8eIi4m93I7YaI+nsECUD/+TMKNPI1Nri9+CNwT?=
 =?us-ascii?Q?eKVZ0JRBQGMPee9WO4xqbHDgtq1Ms863dJeJnzWHEW6BGBZ6S8vvED0iFZtM?=
 =?us-ascii?Q?bLxsD5eYqLkFbrMX0uf1+tG2YrHnFCk9Y6J6icv7mT0oGqZEeVwxLpqupOxk?=
 =?us-ascii?Q?6z129u6EAHW2gjX5/Sy5dXSdZf00z/SMPMsjzCXnNuCmVBI9mh0eTluZug9M?=
 =?us-ascii?Q?w4zzZT2JDm33noYmhZVXgsKkyHtCYdp6xgn9odglsE1QSrU8BMJtRVC8Y50p?=
 =?us-ascii?Q?rbZaQwH/ORw+y6hfozlnC8HKDrSIw07UjLxHzURdxQZ1Zg1IWlLycOw++MnU?=
 =?us-ascii?Q?s2vOsWup2zUFGbKaybGCxyt4VBTGu2Cps0A5mDExFCS5SZk5eB+tKg0k2viH?=
 =?us-ascii?Q?iq4cWzcc1KxXfLaypAO7cmKL63etTCSnvONa5JdVEIgllyzo4xkAyQ+P8VPq?=
 =?us-ascii?Q?Y44AaEM8JlmyHf3Jei5S1Yh/jJUlWaRHl0KbJ6DtrUFKfV8vyiX9hoXcOVrV?=
 =?us-ascii?Q?TfDHeN2hcfQMBWlyHFf4k5wPOgcJ3M/ADaT36fo9QdHGhwtFUJTcLp+cZ0jE?=
 =?us-ascii?Q?ilF+dBvoW8oZU8tZstlxWh4u0YBckm9t3urlnXFwC0tV6IAxVA/yPRqKFDTy?=
 =?us-ascii?Q?g9BCRSKv1esoYv4V/0aVulH4VgvcZ8NgVgL1rMHnkf80XYWni/0T+DHrGqGI?=
 =?us-ascii?Q?H6t1k6J2M86Lari/qILFcioYKzm38X2uQo/5qKFwhHEXGaDP/SkO0DcKkQwC?=
 =?us-ascii?Q?mhmc7NYioUTqfkkVM0JOUoYBQLEi/lM9Uil2V6Wz0AzIBHkxLNlEBKa/vIlF?=
 =?us-ascii?Q?L5N9j56ccIwPpo2/yr8yQLvB/jqp21d9Os8oqFVpyMHmQS2FSY4SWO/ybycL?=
 =?us-ascii?Q?piZdfrrN/YdSWdbmgIYQjUuRvYNUff+YQo+CBvoRqe5uIzd5/742nze08iei?=
 =?us-ascii?Q?cO+Otl4Gh9S/mTab6vcbDqcNUL3Cox2eTUbkAe3nQ7dowfzRnuTlOPmSEhSu?=
 =?us-ascii?Q?ULIiVFsaPaHXaestsFuR8hPBKb7QO36rB6XHGoBSvfalUg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTWAh/x0Tlci4Ah3X7mO/itLi/68+Y1DgSGxm/ISsQ/1UkXFsuG0wyvbit0O?=
 =?us-ascii?Q?qqqe+ZoX0jeQvFq7XH5qpoSZsBVdq9zsO7M7lGISzL+h6LHZPMR98QiMrsJ2?=
 =?us-ascii?Q?2NZpGItrZHV3NOBIxl0kkBmOCav+nfPei7ggG7EKXZTadX0WSpZQNmftx7N6?=
 =?us-ascii?Q?KK2l8xpct9mVbykeJXs8LABaRydtYpTaWzMJmVzW1Y4aktURXfH7CRraVC2F?=
 =?us-ascii?Q?qk6dggrVvUt+iC6a2l17aqv7BQwRbkjKcRLFuOvXf7ZuGWn84t6dLOj0PYHa?=
 =?us-ascii?Q?wC7Qsqo0GhsR7G/K8AMc2ZBYyd04AKdSau6obuDP1ldW6QNQRrtmICPx2z7o?=
 =?us-ascii?Q?33YDcQp/Sk5gRj7F0dFAmz+nWQvdmG00DhwHtiXw95v2La0sYU2E2/U4RWW8?=
 =?us-ascii?Q?zRH2482IrR7qObHUXCN4SUCL7VRfSbFFro6gW+ei5ChbamJ//m3NFu8WHFTy?=
 =?us-ascii?Q?7gTgDUy+W6toJLblvQnVl31gJ71yB/psXRyMFHlGl3QhOgszHvr4YmchrVme?=
 =?us-ascii?Q?PZ9lfw8zT3yU1w14YtH2peHdYVkgViGDcRZ6KHxk5X5kzFTy276ZhWTeoGI+?=
 =?us-ascii?Q?hvZNsDT2HbtLGfb14r/4LSgUZkvZ02mJjklLTNqXqTu5uUBChvnT99v2NHHg?=
 =?us-ascii?Q?5Y6TdCUtlTBvrPKFHcb7dfVsuoLgIIsBzbI+wlHQv47i++KS27bU63VcWSjN?=
 =?us-ascii?Q?YUrHp5BQmNdmXJF9TFi80DhfrF+wr2NuI1iaa5rqDctZ4XfmG5bqrWKX38u3?=
 =?us-ascii?Q?Ja7uejByLeTAIK/rGa8KljThk1Za160DwzMqDqNwhz0z6tSRkad0U9WcWAm8?=
 =?us-ascii?Q?3Z6/VbUP7z2RVt4RKJiiigzWv2hcjrEFum7Wls7Zrd8bs1ptbWnC+60HSSwP?=
 =?us-ascii?Q?afukYonRYmbYZyOHRajbzmy3suKu9EelqMFIS/3p6RcLkeYpLXlSDv8lC3vC?=
 =?us-ascii?Q?Vbd9RKxPX3mRZxrhdH3tndThYf+VVhwRJ7RF78tpf6Arqbjy+cKxtKAwS2Bi?=
 =?us-ascii?Q?jjdXDvXmNnSaowHHbFebjgHdBjoCNKBDzlleX7Py5Mh24fLxj5836Cd0LpAQ?=
 =?us-ascii?Q?Oj8squgmtKHCKjP8l7WTydt9zhvkivSLOPLmlYlvPLFY3h14b0U7UedC99Rm?=
 =?us-ascii?Q?w7+7CNFXDMOkbHz399Jh42PfTLkUgZVDAWG8Zw5hm7y45hyx/f5lLyJOS7ar?=
 =?us-ascii?Q?ybFyIk4SlxupTIYWInk2gSmVdDHdxpNx5UtQbwFDzs+QHJDmtHWaypCEWr6s?=
 =?us-ascii?Q?rAGLmjkLbyLYhjcDx1NcpMPLK2RU9LkEluXnM+fwDME+s99s4JStGkmJoW0i?=
 =?us-ascii?Q?eyKMa/3L13yRbB88KrTd6oM28PFTeOK2G4Yh3kZ9y374Rq9r/ZPOjCRMGxTB?=
 =?us-ascii?Q?SvC59QchtrvpHuEC2s5qCAXrLLdFx7HKog5OSc8nhzDe0kW69JxNHqV1KZHN?=
 =?us-ascii?Q?2iJEWVlWPLhJ6OqWGHc+kidEMi25T8/9hxPNt7QAqKGnsN6sT3aZfqZvzztQ?=
 =?us-ascii?Q?1azxkXPindO3BsWxzNImSG9sOPzZ5sQbvTJxVKZCR5q5YulQLeV2pgs2czNq?=
 =?us-ascii?Q?MsxefPHrC4Lsx1eokkloZN8FaSdzJucQfOaSG+JN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54799c4f-7de4-4a37-dba8-08dcc071b68c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:09:40.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsZ5PIlSfCHuLcGbKn+o+9tXv8sXnHAkT/qzfTLjEKvirI4ShZs0DZEbYvkg00XE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986

On Mon, Aug 19, 2024 at 04:18:39PM +0000, Suravee Suthikulpanit wrote:

> +struct dte256 {

[..]

This would be alot better as just

struct dte {
 union {
     u64 data[4];
     u128 data128[2];
 };
};

And don't make a new type. IIRC the cmpxchg likes to have alignment
and the u128 provides that..

> +static void update_dte256(struct amd_iommu *iommu, u16 devid, struct dte256 *new)
> +{
> +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> +	struct dte256 *ptr = (struct dte256 *)&dev_table[devid];
> +	struct dte256 old = {
> +		.qw_lo.data = ptr->qw_lo.data,
> +		.qw_hi.data = ptr->qw_hi.data,
> +	};
> +
> +	/* Update qw_lo */
> +	if (!try_cmpxchg128(&ptr->qw_lo.data, &old.qw_lo.data, new->qw_lo.data))
> +		goto err_out;
> +
> +	/* Update qw_hi */
> +	if (!try_cmpxchg128(&ptr->qw_hi.data, &old.qw_hi.data, new->qw_hi.data)) {
> +		/* Restore qw_lo */
> +		try_cmpxchg128(&ptr->qw_lo.data, &new->qw_lo.data, old.qw_lo.data);
> +		goto err_out;
> +	}

I don't think this is going to work like this, the interrupt remapping
code can asynchronously change the values (it is an existing race bug)
and if it races that will cause these to fail too, and this doesn't
handle that case at all.

IMHO the simple solution would hold the spinlock and transfer the
interrupt remapping fields then directly write them without a failable
cmpxchg. Maybe you could also use a cmpxchg loop to transfer the interrupt
remapping bits without a lock..

Can you assume cmpxchg 128 is available on all CPUs that have the
iommu? I see google says some early AMD 64 bit CPUs don't have it? Do
they have iommu's? I had wondered if the doc intended that some 128
bit SSE/MMX store store would be used here??

If cmpxchg128 is safe checking that cap and refusing to probe the
iommu driver would be appropriate. Otherwise a 64 bit flow still has
to work?

Finally, the order of programming the two 128s depends on what you are
programming. The first 128 contains the valid bit so you shouldn't be
writing the second 128 after, and vice versa. This will make
undesirable races around Guest Paging Mode and eventually viommuen at
least.

If you have to solve the 64 bit case too, then you really should use
the programmer from SMMUv3. Everyone seems to need this logic and it
should be generalized. I can help you do it.. I have a patch to make
that logic use 128 bit stores too someplace.

Otherwise you can possibly open code the 128 bit path with some more
care to check the valid bits and set the order, plus the interrupt
remapping locking.

Jason
