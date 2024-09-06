Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0B10E0
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587765; cv=fail; b=LP2l2wkdc8lVFkQTpobp9FXXkE7vtkcGZp4FU5PVVRYFuRK8toESGtsIMcu64qWJbJAigoNx/H+N7RUsy8/mcB1pSxjTUiUvuKEFsGhj3YAObdWonluT6maf+C6E7LkfMZvclL8VVmgf8dTX2zyR7nSMihvvA1A338+u7MwmNhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587765; c=relaxed/simple;
	bh=0bbjBP3vJkhwVnU27/hjX51W88RTbv8ayidV2bAqS18=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Csl7Js+VwZ9F/h+ZMDQDGYFeupXSHe1AKKpHLhxDvfMPwI4j7p3ygkTpC+uYeMWxARe7al/wHrI55Ua2rLFOq8tBBEIsyrKpCNin9K4ZE9paMV1vtUVjABxKbffcFMnIUBGZSa/QCQcFn2XKwKZsCiCyVKTcqfiS4kMahrNoYIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QR6Hk1Wd; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QR6Hk1Wd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g+fLbL3AWH1vVOTbsEYb9BAUsuSkwi3XDxVW7+xZR985pFvqn4YRZqfi3oWPYrOai0LwbpGPnjr7uTl42R/lSm9jpGkBZDk0rB7k+vo37p8njBvphUofucp4ep9P5HVuiphBFX3aS+DCPcZwNcJruEL94BRJjflygiFt3mFJ8rMSYRqOpKT5m6WrREOI0wB5RMwMXUX5EIURzjfXSC9Il5utVjYir5oc2RCJK1EPMUKJiir1CX40Wp5WOyivgH99F2ZqwcsWSdPmJarn1k3pyYxVinfeceuiZPWq11oKVlFmrDrK1E5lvHzq49JxvHXeYC7685L1jM2obfqijZxniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g62OHIlDm6RPa3LerP8kP+x4EUBaFhk5utoxF3b+s0s=;
 b=EtPtCEZv9z2vmAHj2Vfe/YEQiG2XyxnYBeBNU9Q+3w/We1zaceHhH7xUJde8SiQSfSWoEwKljryb4dmZdNfEKG/hADyMWPTjZKNtahw9x3ZIFHFLNjowPetw6I/OPGR82pVxMI9xtUp40xYiG1qCgq13W1yBv9lX2Yz9Ool5xM03JEk+Efq92IVjSHIng0qXGFdhHklbqSpepMIngqjI8qvGykbPhlD8UJYeedLsk7pwYgDmSqPTSy1V+0OacJsF3daQIaP2VJqrTP++LOZM6D/s8ZlUqQFJDn/zmqH39KfgI0xmA7YI6SgN5pHVepwqxf8l2ECwH5O4BIMqypTMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g62OHIlDm6RPa3LerP8kP+x4EUBaFhk5utoxF3b+s0s=;
 b=QR6Hk1Wda0yv511ZXQlVMldW49EzEidGpU9lw1SmiGqYbJ/0zBHkLxWc1ZcOy6hQRNR4iZXKSD1cX147mzA8t59aEYv5q6sUmUoeqUY0LVyGAx0bLYJ39Aj+k5g3UURp4tD1HyZK8SIrqykZOgYs0fmC1+VICPM4OslyJkS9avWi2vkfgl5nVIM0Dikb/vOT+JfGMOLO7chCq7U1/tOwwyHj9nBdsBxPcfCyTPqzbQFlzlF0nFzyIfXMNkWsdV4LBOQ69fPN6FOwZPheL6nPNUYA8VgbqNjV9/C8nlptAXRNDa4rgmkuKLLY7lQ3wcQmJ/oCs2S1TLVweCXJIAXLbA==
Received: from SN7PR04CA0170.namprd04.prod.outlook.com (2603:10b6:806:125::25)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 01:55:59 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:125:cafe::9c) by SN7PR04CA0170.outlook.office365.com
 (2603:10b6:806:125::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Fri, 6 Sep 2024 01:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 01:55:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 18:55:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Sep 2024
 18:55:47 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 5 Sep 2024 18:55:40 -0700
Date: Thu, 5 Sep 2024 18:55:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <ZtphFYr1jUhHOSnC@nvidia.com>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com>
 <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com>
 <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZtnXADX3b6qdqVs0@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aec9497-2d0b-47cb-f8e0-08dcce170dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ioKIPwQbYuqvLXfSuM8bkRtTuXMZIuxaFu0n2j+HNUm3p3aomawOm9YF+arl?=
 =?us-ascii?Q?ViHyaePSw2RX8YSNK/jKOnZB7CMZsSf0ZZdoxiShLfCE1/Fd6lYvUs6vjmJ3?=
 =?us-ascii?Q?nnbQdXUdVk3P5JH31WUbchGUeEjE+jcqXwgBlVHrZKZgyeROGFMfX55yWePd?=
 =?us-ascii?Q?X+P9yYR99V1b19RL/SvVPzFxvZHZn53r+eA/eugoej0aYsTMDijOEM/WWBcS?=
 =?us-ascii?Q?Q5xeghdQkJeA2zCMk13BwFDmSULhWjjId0xIjbTPkF+pVdj9z1sB9nucQMee?=
 =?us-ascii?Q?cGtKDIw9wHnItTkqoPlbOiDuxrwrIzw/Fogq6jf0i7DOMkuUigK5jcrc1jI0?=
 =?us-ascii?Q?vIfB+OGCYMmxhvJBuLNyrJao/6zheL8RogZf+DIQefFkNd7h7ZseS4WC8Pxi?=
 =?us-ascii?Q?OO9dkP7G8oV8CflpqUVn7Uxh8lv95OKHvvtR9k1shRdwQtNQCMk0R9KZKYoh?=
 =?us-ascii?Q?fHAbpqBlqkUR4vWol1SyJWHp04Lhoy/irLlBnfqBS27rbz7ZFQEfu5vGPuGO?=
 =?us-ascii?Q?rR1KDzFyR2FKVRaim5sbdzflDx42uRnXa1UQAPoJiw2Ex//RGXeIV1oxWU9e?=
 =?us-ascii?Q?GkNOjq+P4iEUuZcK6Njo8I6yZIEQ0Da58k6nbukihNRSHxxhn7wWBRztZcL4?=
 =?us-ascii?Q?XWEKHqGXrnsBQuKu0qKW/EoOu+MJAzqeBkR7eUaXSBRF1/pA76SpIYc0kE0B?=
 =?us-ascii?Q?5JcfePyBIYiwdbL1Wbb486UlukZ7BT1EOSUU6/11wIxY54GzXnOdFZ7hbRSC?=
 =?us-ascii?Q?D1vkmHhOXsTIv4QplbWysBZsgFMug5Q2nk3XznIRhR+jEbvC2ElT+4GsdLgg?=
 =?us-ascii?Q?RXtk8JYb3lBsg4Gali0UD35R534k1aYo6SiLXTsG4b/zT11eKBc5rlr6t3FJ?=
 =?us-ascii?Q?gy6drnoMCEIvzx0LC8GGs3Bo4FlT2wh1XYE1jIeFo/3qQsbtwlynQVEtsNat?=
 =?us-ascii?Q?siwwdbB1/6JrlwiG79x+/ut7h/Him55Qinos1Pfd90RvXWU05SYcrcVDpcf0?=
 =?us-ascii?Q?EY6PQcmIfYhWFm9jUOWGnWUu+jVse9iYc1iCZFGkKybD/SPwUV8PyMn4FDeZ?=
 =?us-ascii?Q?yR810/JjugTuTlXCsoEtXzxl1DHRPliKHi4F2Lsjy72RnPYaVsdlGYynkLJ4?=
 =?us-ascii?Q?iN+6pneN5McdkqlM+L1PDpCN/+Lzx/NCPGbx8OWtNNzd4U8/3GtcJ76fDp7N?=
 =?us-ascii?Q?Gb4Fy1x9hZcMHWZwOTXh9h3IsNBirTg+JbxjG9Mp2ovCcO4Fm6cObuHcWlPL?=
 =?us-ascii?Q?CsqGUfsRoIU4+2a65OGVPIWKrsOAvgz4vEjDi/LiVVXzj7aqkJGppYGTfCZZ?=
 =?us-ascii?Q?B+KjLpFzthXMSi35JCykNm8CPxkvt/KliHlqPILp5NlpvE39td4Fj4ludAeQ?=
 =?us-ascii?Q?8/pHhAU9eZ9tvTfBbpujyS/68VhveiysOlw3gQlLIkNbpovew2ysD4A5YKdv?=
 =?us-ascii?Q?KzhrsOjPxfzBVv7UtKZ1Nrju9vHuHt8H?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
Content-Transfer-Encoding: 7bit
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 01:55:58.9639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aec9497-2d0b-47cb-f8e0-08dcce170dd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

On Thu, Sep 05, 2024 at 04:06:24PM +0000, Pranjal Shrivastava wrote:

> > > > > Also, the printing would become
> > > > > more complicated as we'd have to log different fields for different
> > > > > events. Additionally, I don't see that many unions being defined
> > > > > elsewhere in the kernel.
> > > >
> > > > OK. That's a fair point. I think we could have just one common
> > > > union for the "good stuff" fields. Then, if something isn't in
> > > > the common union, do a FIELD_GET(raw)?
> > > >
> > >
> > > I'm not sure if I get this right, but are you suggesting something like:
> > >
> > > +struct arm_smmu_event {
> > > +       union {
> > > +       u64 raw_evt[4];
> > > +       struct {
> > > +               /* "Good stuff" fields */
> > > +       };
> > > +};
> > >
> > > and then based on the fault type we can use the "good stuff" or raw_evt?
> > > So, basically just add a union between raw_evt and the other fields to
> > > improve struct arm_smmu_event present in v2?
> >
> > Yea, I attached a test code at the EOM for your reference. Please
> > feel free to drop fields if they aren't common enough, and confirm
> > those bits are correctly written too.
> >
> 
> Hmm, so you're suggesting to make the event a union instead of a struct
> thus, making reading event fields easy.
> 
> The only thing I'm slightly worried about is if the bitfields don't
> remain constant if more events are added in the future.
> 
> For example, the "IPA" field is in dword[3] for now, but if it changes
> in the future, it may get difficult to scale the union for future events
> If we can guarantee that it doesn't happen then I think union is better.

I believe HW has its own reason to put those fields constantly
following the same pattern, and must have its tendency to keep
in that way.

The "union { u64 raw; struct {} }" way isn't that uncommon in
the kernel, here are a few existing examples:
	drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
	drivers/crypto/cavium/nitrox/nitrox_req.h
	include/asm-generic/hyperv-tlfs.h

Taking a step back, if one field in a new event in the future
happens to be odd, we could still fetch field in its own way:
event->evt[4] is still available to extract via FIELD_GET; or
just define another union exclusively for that event, neither
of which sounds like the end of world.

Having said that, I'd defer to Will. So, here is just my two
cents.

> > > I'm just wondering if that'd be too much to print the "master_name", I
> > > mean what if we simply save the master_name in `struct arm_smmu_event`?
> > > That way, we can keep the locking as is in `arm_smmu_handle_evt` and
> > > simply print the stored "master_name".
> > >
> > > Note: I'm suggesting to store the entire string and not just the ptr
> > > returned by dev_name(master->dev)), something like:
> > >
> > > `strcpy(event->master_name, dev_name(master->dev))`
> >
> > I'd probably move the dump() call inside arm_smmu_handle_evt(), and
> > within the lock to avoid strcpy. And eventually it would be located
> > at "else { /* Unhandled events should be pinned */ ret = -EFAULT; }:
> > https://lore.kernel.org/linux-iommu/8b93be1d913f9e227748de2d07e8540ddc2372ab.1724777091.git.nicolinc@nvidia.com/
> >
> 
> I think we'll still need to dump the event for other cases, such as the
> case where the master wasn't found, we return `-EINVAL` and the case
> where EVTQ_1_S2 is set. I guess, we should have a case under the label
> `out_unlock` we can call the dump function based on the ret value. E.g.:
> 
> out_unlock:
> +       if (ret)
> +               arm_smmu_dump_event(smmu, evt);
>         mutex_unlock(&smmu->streams_mutex);
>         return ret;

Ah, that's thoughtful. I missed it. I agree.

Thanks
Nicolin
