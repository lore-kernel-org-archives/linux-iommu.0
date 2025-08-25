Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5661F4CAF
	for <iommu@lists.linux.dev>; Mon, 25 Aug 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129101; cv=fail; b=k1jfCkR1M5vbqvnA1N0U5O7E7YPbHmeUdrLvV7Ym5otA5q1xdhqW4b4tnFCI66SQiPIAyeisJZ1Ds8PQjFfnZCNbKjIh5yUjh3FxfaybV7T3XvXNli8kpoyKrsZGOkC6HR1Cd2CPzgLMmucZ2vK62yZK7WJSUYTxwGmVyDEB1UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129101; c=relaxed/simple;
	bh=B9T9X8vltXQs0V15FJoQmdpWUCCz95hVE15Oh5OUE+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UYHc69Tlp7srK2xT5R2VRYIwwlxrVAaN7CQS7LTRTZ2XqH3wK6vpiFJ5aohrx0C9FTYR9wVfKWvvT6c+w6ELlNfUBgGHLPhHVNvsR6m4fStT/GqhHvl/BBJdnWWmkhcXMsmDMet2reGmuGPrrWnOvhrAchUa48WzMXbwtTUu+6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AMROFh/F; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AMROFh/F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpfnsSMWDw+MJSfLqZ5oNhFBkk8F/CEKAW0lVu8z9RB5iEirL8ybZ64dcVQ2oZ9bToQtlw06PBTBeek48BPwluPwfwO/IRI9CtsO+krLpmn/9peYND6l8Y3QZKfFsQ1RMbyIoKSFcR6Wc1QaVCmQe1klcjI+2BQgB2cxmDwO+t4FBrlB52rpTVWPa4w1AYIlRkosBi38UMCUB3ugXj2StFjQwyYYLjwPn9lDujDa5lHqFE4LJQiPqWgl+Z5lp5FLZ5Ql5EWF5qmjU1XZ3yAorSqHmQVEytKFfVBjEXqYFz44B91+1icXMTPmOllvaR8/GNCt/kzduzFwNHVt1YK7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1TniJEnvv7kzrM8E1ZrPYsoFD1IhxfBCEsF1z0e35w=;
 b=KUJyYKSz09S6stsmhA6NcOIk9TRrm5L4h2HG1iDNUd9cgC0IKwPBygjXU4M0MDdwd6o5dXvW0Q8tXQ8RP/XFV6fptHhISVuXVJz/yBYEHUXi/P5UasBYnyRBAC+8YlZnbLWpI8ywyRj/iytp9Q1n7RCieIM1O3jjD/31gZOW0mx3nV5nGCppfe3/oSmgIKbQlpXUveCO/w15LvV7fFlBtoS2/D5++PpTf/VuRVG92NG3u6b8DZ/CKvW/2iF6XNJzu/1hPoi5bvZJ6a73rRm1GMgM4+nto03ueJbvNpGfJdEDA9ra8mvgeC3fVBO8fUhNbEBmc2EFv8MIxTzVDZzuNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1TniJEnvv7kzrM8E1ZrPYsoFD1IhxfBCEsF1z0e35w=;
 b=AMROFh/F81sc/pev8PVPgB3mOWgtdpUPx0MnACeer8nw35qm49zbSBBea2jR9ATYqFxxV0rZ2THiOU4YQf0tmIxkigBUrEVWd8QVc3YhyQYiOK2/0JYt0Psa+FS5+NZRBCNhw3Z4JpHq9SeJr6hrE3loc6q5rhdpcKyIDu1q4SSgstrodzuWXC8xmC1M902mGoAZ5u4VeKysnTyWtdfHljW3V+c8yBsf8gq43tR6XRH6+2Ob1jxPpu7Ysk9UjOScGczW6DCbkUShzXqCF0sE2Nm1B+ScCGzoaaHkakxfawHbt++qGBRq7NO316uN4P5PavEGVTPBZfrxQWTYHdEEqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 13:38:14 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:38:14 +0000
Date: Mon, 25 Aug 2025 10:38:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <20250825133812.GA1970008@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
 <aKjKJhblxtnlrrPG@Asurada-Nvidia>
 <20250822211618.GF1405994@nvidia.com>
 <aKjlFt80ltp3mjcp@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKjlFt80ltp3mjcp@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0354.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 395438c4-ec76-461a-6733-08dde3dca41e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3LFKhuPAazk2vk58xieslDv63+4VhqHNq0KKGRRWs0L+329u7X+aFp6Pmp6R?=
 =?us-ascii?Q?cmE8okOPzGZEUkSddQPhnbEzhrOdkG78Pic7MpYyFV9tQFkbn4q8o+AOtyzt?=
 =?us-ascii?Q?srLn2NviwjjkBYSsQcrz1fljweewVvjCD5CsRyZj7IUTDZiv//dV4k52uy2I?=
 =?us-ascii?Q?VUDRbP187qk1iMqcQi0qR5f0CWsregN0wu0m2YlXIQT0pCWe1wlxUYqchwC2?=
 =?us-ascii?Q?imY2nGcbANISGR8cOpmmrz61deB8xkYlmIztKWyPqMCN7Xu0ZUW+dxsgfWFn?=
 =?us-ascii?Q?rGtD9ItjTUoL5UtLIYAtH4NKu3rA1OgYunZExabWHjNKoeWNVbhV5qJurHSW?=
 =?us-ascii?Q?JJ4BxAu+v4wnL8XQCrkUPbATxmtjq+XBhjnceYDPUocxoL7YXWep49jweN5a?=
 =?us-ascii?Q?/Jk7Ri/4iY8xCqSk8G39Vx39+zMj7MttZKoPbBNOEkDUhD6AoxN/kcgN25RS?=
 =?us-ascii?Q?n+DhtY7r0OoWBhOV/H5JU6q0FcxTby+EYF9baTJj5/yUB0zOV4nGWjKdJ7Yi?=
 =?us-ascii?Q?WpUsjSEn06LQ0yIaq+CUZglo3ksK8kOx9iHfPUxsmZ0JgXbj8gTy6KzCMujN?=
 =?us-ascii?Q?wc4FOg+VYm4WvS1V/5E2IkNKG5I7L+HY9PUcNM7iVmKCfkJU2uLl0tBfmxjR?=
 =?us-ascii?Q?Vd9LzYWM9D8vzIHN5fMxAcERZ2FmDFLq/BskLT4iZoP6BA3k4ax9pUc/KnNF?=
 =?us-ascii?Q?k7AQHz1P5qkGD504B3DUlGywhU/IioEE2e6Fz59r0EKUxTT+MqFFGHHnBeU/?=
 =?us-ascii?Q?91PA7KzTSScEklzE2JtcnlYCJYNSwMgV+9rCkew+vN+xWvuF6LZ+R//8fCMb?=
 =?us-ascii?Q?Hl2iby8rhHR3EIi/sXtvStAxPjH0frDi9k1IktrnMIZ2M8RBZUOXUK5kFlmj?=
 =?us-ascii?Q?iSr7qRteTOhvdojsTO8vKncwDk5cGHoouyk39vtpVvm1x02kHPqH89jL/hlX?=
 =?us-ascii?Q?UOGfRtXx5arHv6dHuKcncCzeRLhWqaWPznCeojLhqOxLMJhQSjz3jly0WDJU?=
 =?us-ascii?Q?SnsBD+1InIrLMK7gUtIAFoWs+T2aWAQp/8AaXxh2cQrmt3kFAS18uv+fQtra?=
 =?us-ascii?Q?0SFJdhmdjr6CJZIjgs8n7CJjI7iCTF5ICr1J7OF6m5jlBkZeOZXHa9ys2Sav?=
 =?us-ascii?Q?UtmZcVoLnE0AZ1Fi93lHTbvkCKCkujTW37aZqdngUbFicQ/3juVSMtoSUymA?=
 =?us-ascii?Q?7Xt3zvI6PC6QiTCb4F18dJhlAR4W6tHRY1fVgmEXa1lAGe4lf59uxHmxagyo?=
 =?us-ascii?Q?y76LbGf9iW9zHmWkKnT+qbQDP+TqLBzPA536k8fK/uNGPf9cjio++4IsmdO+?=
 =?us-ascii?Q?QXHhH8RAMKECa6yAuoFYSGgnlZU9yEsMdDJrTBAfEWv/nYThj2DVT175t2e8?=
 =?us-ascii?Q?CVbsJ0tM7CDonmm9bqWz87WAR7N/qXpnYZARQYebwB/WwHGZ85ACH2O9afsx?=
 =?us-ascii?Q?D+nZQLUn1j4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QZhOGHf+j/NDx7SbLJrMOfcyDDuRChUeV9sNIAa3CQ2nvU5gzY0pzi82rO7?=
 =?us-ascii?Q?gswp/wUVGortpXrhTRzqBopbg58JbsrbHl1ucpObsBuwi/jR4MBA9Uo1SeHP?=
 =?us-ascii?Q?zN+s0HxZIM8mQ4zwy+ho0bEf/S1zvNjgcHfwhJ/gXU1hB3q4C2k/WUpqm5DG?=
 =?us-ascii?Q?y8n80YY2wHbDcsVsaqSTr3vWpuC0aKwgZvxwSG9IwKk8/9L4toLnoSd6tape?=
 =?us-ascii?Q?MKh6DLqCNaR2jKDnYJfivzcmz3tEkplorda8YAMutFXCuunoO1k2vVJJNJHY?=
 =?us-ascii?Q?5ZpqUXQpyKpKRfqTqGslrL5AqZKXnax3PWdM74je0ri5GVLzZ6XP85K0htBQ?=
 =?us-ascii?Q?VCtnvCjOWc6M6zO7f503OkdgjCR4LTq0owJNpe/ZbMe1g+HUyWVpOU1k4g2m?=
 =?us-ascii?Q?OiooGAVJdsTCrmW3rb/Yt0UeS2OAnU1LYWmL8c3tcfsZUWqwTxBxCS/9gBds?=
 =?us-ascii?Q?L65iIrJPMdzrVq2CPAgrehFhCIV9xIVFV5k35JzOEiAycLD3Gf9d/+FFWnSE?=
 =?us-ascii?Q?iqtde1XBfjON6eP9PcB7EzTl19anQ244i9hJaZ0Q0mtuUmfwnByAXF6ZyHQv?=
 =?us-ascii?Q?grrt8HTV06UR2PDNLd2HHuUD4MLZoeiZJ/yboYBGkkKDEyaXDHEDNoPPa/4L?=
 =?us-ascii?Q?5OLQwKPcn8+faKS6J3/+m5s4yJAULumx38461MVjax64qaBxYdrwnw4x/TLE?=
 =?us-ascii?Q?bVMMTTblpjj7vx6h2MU2gqEbaC5bwKYnKaergD2kMhtWkP1ms0lxC8L0ricw?=
 =?us-ascii?Q?XVu4dW0n0HZkVEZFDck7p5lEtkMnki5bkAkKjixz4AGC9pzKmNrekkOsrRHO?=
 =?us-ascii?Q?Q47l9yjYPTnGwEeEAV5pJD1F+f4v6A2w9k+KeKFZCimqw30Yrv1HHzds0sZe?=
 =?us-ascii?Q?DDVk68UxJ4K6uwTGQ2OKDbWrRY+juprUwv9QF7tVSzJ5GaGJ3xUodmqjl3Yo?=
 =?us-ascii?Q?qZBYI86jrHhkWrsm89/SMKgTB6bTEOtYwONB/gjZlNxwECCeG6eFGBLqQ0lR?=
 =?us-ascii?Q?fEt+JUwwwPQAC27V46saOsWN5glUxnzgmAZH1xt4llmErwNWYwGkSTMRLbk4?=
 =?us-ascii?Q?7iXSRv8cO6mO1KBLVecvZpI9Y9cL54STfSrXpAKaqHs/pV6xVZYyLLjARiu/?=
 =?us-ascii?Q?wsQIL6INakanK7Tt2adtg9K4Ss6BoIwrRvV6IHJQ4TFFLGl0FxmZEf3SDvdP?=
 =?us-ascii?Q?3IzerQODlTJ7ShWKtOjssbfUCteWpbmGcoi4ktQSIgw1CPa2wOrkkJwoi+Dy?=
 =?us-ascii?Q?JEuvm5jOkDD6qG1R3uWWbgSRBBxh30tt2M6jQ3PicavX2t8zN8HXHAvTXjir?=
 =?us-ascii?Q?ey2ZHPaZ7g7vVfa1ucSsOgyGzZ3qIRuemzOKhmB2dAFFsO2Zhsi8bSG9/LOH?=
 =?us-ascii?Q?sXhDiFNGa6BpLwahHscIour/W3wg2jkbKkaY8ILM3jH3MwmvwkGB8ab2g3Cf?=
 =?us-ascii?Q?xhqU+c9dM9sy+6u1ZORvSsqHvLcPgLPg2MRpXt1u6rdRyrLBagSDm5U59QWg?=
 =?us-ascii?Q?2NlZkr1tVfmay+bIbgoKh3Ia3zU36nJESXYhqlKDPsksmyLBhoXg2s+8Z2dB?=
 =?us-ascii?Q?UfWyVRY27f5k2GAFkY4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395438c4-ec76-461a-6733-08dde3dca41e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:38:14.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsPQmal5k/qvEAL7owLknqYe75d72szWWlO+K95PUO7Fhca6e2+YLioI1+Uj/+U0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

On Fri, Aug 22, 2025 at 02:45:58PM -0700, Nicolin Chen wrote:
> On Fri, Aug 22, 2025 at 06:16:18PM -0300, Jason Gunthorpe wrote:
> > On Fri, Aug 22, 2025 at 12:51:02PM -0700, Nicolin Chen wrote:
> > > > @@ -3113,6 +3116,7 @@ const struct iommu_ops amd_iommu_ops = {
> > > >  	.release_domain = &release_domain,
> > > >  	.identity_domain = &identity_domain.domain,
> > > >  	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
> > > > +	.domain_alloc_nested = amd_iommu_domain_alloc_nested,
> > > >  	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
> > > >  	.probe_device = amd_iommu_probe_device,
> > > >  	.release_device = amd_iommu_release_device,
> > > 
> > > This will be an HWPT-based nesting support, v.s. vIOMMU-based.
> > > 
> > > If AMD wants to enable its Command/Event Buffers, I think this
> > > should follow the vIOMMU model instead.
> > 
> > I've been expecting drivers to do both, like ARM.. Nested is the basic
> > infrastructure and then the viommu changes what domain id nested will
> > use similar to how ARM constrains the VMID based on the viommu.
> 
> Hmm, we haven't implemented both in ARM but only the vIOMMU-based
> one..

Oh? I mis-remember we had kept the hwpt based non-ATS invalidation
around.. I guess that was Intel that ended up like that.. OK then

> Yea, AMD could start with the HWPT-based one, but that would need
> an invalidation op(?), which seems missing in this series. So, to
> support direct invalidation via Command Buffers, vIOMMU should be
> the only option, right?

Certainly if there is no invalidation op the series is incomplete.

Jason
