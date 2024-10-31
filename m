Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4419D064
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 12:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379192; cv=fail; b=OLTSMf6uVk5V5VodJIuP1tovA/SWqVkAnEjtd42CnxeTvzAzvBiCgvnkNFGrbsqYY/IjfA+gSqaOKVQt4f6ZU24Z1yaUB6Nb4Z9Uc0FD6yq/Ngz2/BpZv+hjjeZr42YDZcSWrz0U9l6ec9t7h2wQiXmHC5QnL8PQI0WYCXxBnwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379192; c=relaxed/simple;
	bh=P6tRTQ4bY7rwnG3wFlY6m0Fze7h0H//IQXZrnQfxj+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o2/VMCiBCARL1hlae2fTS5/2bla1/eqDBoQNmGKZ+4yilofcsTxHD0R73YDqQmLetNx2qvgV5IV5a7HHwVpD6/nE000u84BLBjrP68zvCh50S06oUL+LqDi1IC74T10U7IlXQRoQTKSipUapiz07Z9yYbOS6L3rnuEqwCNvl8Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iuo2UAlx; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iuo2UAlx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8FmyhniHWiB4hcGtKI+7g/nAuHdjVTRVx9Ofpy/82VL3aYoMNkmeUJH6KA6mim1PJ8IHlq1e+hW8y0eh/KDvuM2RnBUTq6jSFn4g1yxULuuhaOjFoebHl2xvcCcQDiRZJLN+6JbIfvDD+FmX+AgHpdHWEm8BKO1f19QyHIoczGl17hL2EAAd606CX7wjshir6jJc4LbqJEj66S4Z4frCo32HiTPy422jQmXEBA/NW6MMJgGvUE03cm/3CO/l6zwUEjBwBhRgL6lXzygWX5hw1Crjcdj0IpkA4WnfSKItpA0hdo0bTg7FYr5d9Z+hYrTdZIc5GzJPz62tK4wr/OiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfVkgN9hdfKaLQVxiBJBiiSNb6rxN3Xj+MGEL6lg72k=;
 b=uUweA18RV5LVKeqqcegLYl1y6I5+9RCa5zugfIMbtAUvmOHjlfHr2JQcL6y/O0jd/UzVYHgB6ws2PfhpIcvEGlISk349z2tnODWrntV5OCAeBCBbkdH7uto+8rnkv+as1/GRmLGXxGE9X1Moc1xafMNpauevg/QHk2ELJoly6T2k+dJ8jydfozxXFxkCc+stmEYBSQDF+M7VcUNYYjM4ircLB+dJ/iJ1WJeXv/cQqvflXIPAcf2vhFoYyxtKfhAB59Ywr2VgSjmBLvfkNEfiqK9ZFHWGsQDmnHWxVOPygi2ZPwSrLjUkTI+q4eKbTYcQIVlvwAu1E9v4KOn1+hip6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfVkgN9hdfKaLQVxiBJBiiSNb6rxN3Xj+MGEL6lg72k=;
 b=Iuo2UAlxuX4jvw1YBWC5noxQu8wSfWOQ6G0XqBZJ0OAjnZ2puxVRkpkClLH8jV7fwPHlWZCmeN2sAtALMzkboqaKiOwFQ9GPDZq9YW+Nxfc9Bq6drPgLhLvJ15AW1Cj7birovYwMfNjzW4kU0/5V8ENth8RU54Kk51fj3EdsGzmChthDbo9OuUAHM8/y2xvVWIWceJ3SXe3nWym70WaYJ5lHdr4akIgYXBBHkKzDNex6NqZojTsaGj14jSOk3SIu1fn+e1hcY4Ish9G21Jg+yn3rzHVuugNt2xAtr2mOOniFk8c+ESEvPFNlox3ftchL8+Y4xosocxBRvo9n2oiZfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 12:53:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Thu, 31 Oct 2024
 12:53:07 +0000
Date: Thu, 31 Oct 2024 09:53:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v7 06/10] iommu/amd: Modify set_dte_entry() to use
 256-bit DTE helpers
Message-ID: <20241031125306.GF10193@nvidia.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
 <20241031091624.4895-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031091624.4895-7-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1PR13CA0302.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6bd0b3-4f0f-4f08-2420-08dcf9aaf7a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LN+z8GOTt1Pc0Y1+1ocr3EaBHmrmvctL2t1PhKZIXcvxQ31AG24qZv3uk4vc?=
 =?us-ascii?Q?pC1G2TthIEeFuGC6Ov+ZT/eveTJLYtzpuzKG6RxLNpVq3VJOk4BAmbKzNm9t?=
 =?us-ascii?Q?JRVqZ1WhM9uZ3cICkXMDFaD7zKk9xjMRvgAMQTY+Iz2eE+fddqM7MQYy6okW?=
 =?us-ascii?Q?IC4LclM0x235AZy8SBaFN3L8kX/AYjXtgu8Pqqj5kDbFWRvrc1fCRGfTHoMs?=
 =?us-ascii?Q?x0PlyZ2ASh02fzzXb7n0gDG3ieXZkOB0CJypLZlXxmOQQuuUkKks7FymOrED?=
 =?us-ascii?Q?Lofx56fPTBCh3SMd+LsyBqH+47akzBoj/4ui93j9OncZZLPf6ofe0dcWSvEN?=
 =?us-ascii?Q?qvUUHaEkHpVFdVbX0uAbigukkPf8gNFSnctnw7dWxfpJtDFybuBPjtlXLLJr?=
 =?us-ascii?Q?vPI2+D6kbfrvrAFo+ZxeTfShWwQO+8VsRN9TP8T9AWegRrtQZTbxkSap5a/u?=
 =?us-ascii?Q?s5U/pXta+SxuBzcx9Ny2nE2w+ztc3Ff/Y2+CqEQLdxplnKr1n7UzhjMggbga?=
 =?us-ascii?Q?ogm9VjNBTN424Kg0+PuaJGZyvydBn24LPTTtNTXStrUBp/iu4HgtEg8OLVLc?=
 =?us-ascii?Q?cuKeA/wu8+Lv2muq8cIetROyOHDSbjko8x/9nvraxw2AKVJiowFYPwUJSvzK?=
 =?us-ascii?Q?KuILa1KWJU0zTItTOZecPAbZqdMW2s8TZkrYg33C5D5K8eBs8xwJgumBjqnl?=
 =?us-ascii?Q?XET0mTlr9T+Bbx9o59rl1Po6gSvArX/MMwTCagD41te3bRejoxvUtwYEokW0?=
 =?us-ascii?Q?qZh0jvdEzIRSClSqlrwsaDWcaY2yojsi9RBfBDSWjn0ZMdFHRMdUqskR5uVV?=
 =?us-ascii?Q?/GbpOrySZG0ejE0q4xZJ7HdU+YFGaYauLTOEn/GphRxkA901QuCMRi3epnyw?=
 =?us-ascii?Q?mQ/2C8miIqRT20Y3Mwlxwfo6o4jj9Eudp6vil4O7nfA7dtA+tGpuoWLAeHvg?=
 =?us-ascii?Q?fpt59oZ1nGMoGpeAZFOEspSsdCwcRmX7nDmxEJW1cEgyxmyXSTzH9iVv6EA8?=
 =?us-ascii?Q?hxi86TsPp6WoMkZIcm9x60j5REMjBxm38bAXQcLVw7rjmDLsAvCP+efGoFo1?=
 =?us-ascii?Q?Elvyf1tAaWa5J66j1NlQsb0IFEyYa7e/5qrFoN0L5azj10IsEoxOcA8xMX92?=
 =?us-ascii?Q?AoFSMo6L6wzLNEf3WpM4PzXgfDvkutzdbNOu3BFBfa+a2X1kpB3fa1Zj7NqX?=
 =?us-ascii?Q?1ZZhGiVMZN9WahH5D/nr7WGErmc/OFMOmrybthdQypW0aHVJMaAl1q2iUIAJ?=
 =?us-ascii?Q?BP90ZuhwjSt8jpKTQoui5u+NybeosCEfP5u4YoO7Sltbn+JEjQhILzscu9b/?=
 =?us-ascii?Q?5PQBaU3hCuRiPCtNb2MdxC0H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oqZnfQB5FbFvUhIM4+HkhPFv8yLrLxiQolJr5RCQHo9daSAVG928dht3Ea9g?=
 =?us-ascii?Q?v/62bnG2urBAnatvomdUc/yXPI7J8tC9gKF5Ic5/FVAWJlr+Y3AiGxg+E7y8?=
 =?us-ascii?Q?XukQ089IT+63K2eJb2eSxsIcgznKCWY/9qDSjWpmvXnyqcZS2ek30KtYy/li?=
 =?us-ascii?Q?3il5FhHZJ99w9OHq29k9mgtqH7LMJhdvtT96dnkhLOXFU6LbR2rsdamT25rs?=
 =?us-ascii?Q?iK7D0LGMv4uUfzJCmY02UR0i3D/cFcRkyEBkiVJhjH3QRrE1TofdnanUuwGX?=
 =?us-ascii?Q?dYwUacQ6OquRxeGOo7/zH82qfRsH1wErQweweQNXlrQy1BcHsN29PEAwkHqK?=
 =?us-ascii?Q?/1W51NOq1liT0AOUFSQ/9Cjm2yw3UuTE/S+jJPfaYZmo1sHNCAt5qrvP7Wmd?=
 =?us-ascii?Q?fg25AMYKWDP7ZMTsJUhmdRhu+XtAvzLvs4l47xM+tjv2QhJpASZJq/8JKIVf?=
 =?us-ascii?Q?SgZhngQuZRhwI8nnV0ys0NQ7Zo1D+95ROgkS/YE97xK0KE6HdKSu4Gkd8lhD?=
 =?us-ascii?Q?UWgOBvDmi+y0ZAtzJIkazgKwfOGCB6VoBBDYqpJDyFobw69ruRRW/jUnl6uL?=
 =?us-ascii?Q?AujNHTVjtGfE/gEtpZLP/k++QtBmLaUM5p+57cUEZJoJlRUjPKCqmlIEnDZ5?=
 =?us-ascii?Q?AZf8VH/vxQEND3hfpq2FfE2VduHm31OJe75+S0nzrTZcBNONEcPhUEVlPwdc?=
 =?us-ascii?Q?r153dPzPNdYSPmI4wgQcb1OeVhuJdHlJvUWLh21HOJR8Orymtg3XAZWhBjQ8?=
 =?us-ascii?Q?2nN6HBR/r6SQuQWdln1tHZE0Liy1mdArD9dwgls39+BSLKWJhAehn7DWXnAI?=
 =?us-ascii?Q?M4L/tcHK6dJz/R5PGQbjOGHp42Y9yL6qGmgAClAdK1eD8Fr9ZFrQlGipU9Ys?=
 =?us-ascii?Q?0yo/Ymz9ffFQnr0OYeQOrD/1pcCBOZPss9jKg+zBjKwbDA4P2WPlpksnfhcG?=
 =?us-ascii?Q?aIZVI0+6rDiBD0YoOhaud8Navst15gaMOKI/dLq2eU58zm87tHi47QLOAEDz?=
 =?us-ascii?Q?dviN+vOBzQroMjYAcgTMZVlKY+mwbO4YlVmNHlYtFnhAeWexnRjr8yCMNI+C?=
 =?us-ascii?Q?ZHdAtb34VOGQo4H73XBbexNPGcSb3tKteUCwnzahD2GkpMO8+nO5jV8ffQ7L?=
 =?us-ascii?Q?TTZAw8I9jjot7lZ+Ug0daXkQSgkWBHPoBpI2RNHkYz1/bzI/XvrZolQgfpyx?=
 =?us-ascii?Q?+bCVUg4yQjz/bXsYdhTzBNn3Xb+r80mn5jrXkf3K7X3kBK2FGCZylwKVkOSC?=
 =?us-ascii?Q?3VBgwIwEKpIYEwyrACl47ez/pqHqWUF1EZWeQ7i4j+0RnKds6n16GB7EzdTl?=
 =?us-ascii?Q?Arsq0MjLD706pEAYeAi8qCL70whvQtZudRjo6hOQ5nh0PbkLJ64wP3BVylun?=
 =?us-ascii?Q?MbK+gQ3zRrjSIYoYV7iCZUbVeTa0R6pH7o72xbbIYj/pw4QbTLsALeo6qgw7?=
 =?us-ascii?Q?nssBltlNx2KgNCL5p/0Mk8nPfC0oWKsu6GdywTr0nOAJLCbinvNSy5Pcdo09?=
 =?us-ascii?Q?UuQW2Y62EqQxi3uSvuaShwTZWLdNLdkX2YwVpJOEAxNEprLGah6A6Xj5xe9q?=
 =?us-ascii?Q?idHCvcUSK/f3hL1x0D8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6bd0b3-4f0f-4f08-2420-08dcf9aaf7a6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:53:07.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPbW5gK+APWxsV4JzccVp9RDYa9J6sR3izE1tyGF1P8u2XEHWnS8eR3g/1prtLco
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

On Thu, Oct 31, 2024 at 09:16:20AM +0000, Suravee Suthikulpanit wrote:
> @@ -1148,6 +1146,28 @@ static bool copy_device_table(void)
>  	return true;
>  }
>  
> +struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid)
> +{
> +	u16 f = 0, l = 0xFFFF;
> +	struct ivhd_dte_flags *e;
> +	struct dev_table_entry *dte = NULL;
> +
> +	for_each_ivhd_dte_flags(e) {

Maybe the list head should be on the iommu? I don't know how long it
would be if it is worthwhile.

> +		/*
> +		 * Need to go through the whole list to find the smallest range,
> +		 * which contains the devid. Then store it in f and l variables.
> +		 */
> +		if ((e->devid_first >= devid) && (e->devid_last <= devid)) {
> +			if (f < e->devid_first)
> +				f = e->devid_first;
> +			if (e->devid_last < l)
> +				l = e->devid_last;
> +			dte = &(e->dte);
> +		}

f and l are never used, why calculate them?

Isn't (e->devid_first >= devid) not the right way to check if devid
falls within a range?

Based on the comment it seems like you want something like this??

struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid)
{
	struct dev_table_entry *dte = NULL;
	unsigned int best_len = UINT_MAX;
	struct ivhd_dte_flags *e;

	for_each_ivhd_dte_flags(e) {
		/*
		 * Need to go through the whole list to find the smallest range,
		 * which contains the devid. Then store it in f and l variables.
		 */
		if ((e->devid_first <= devid) && (e->devid_last >= devid)) {
			unsigned int len = e->devid_last - e->devid_first;

			if (len < best_len) {
				dte = &(e->dte);
				best_len = len;
			}
		}
	}
	return dte;
}

(and it would be smart to sort the linked list by size, but again I
don't know how big it is if it is worthwile complexity)

The DTE code looks OK

Jason
