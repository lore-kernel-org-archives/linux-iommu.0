Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40D1270EBE
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397212; cv=fail; b=UPXm9xpGDBH+VsePyESZWv+POkHc6G0X+JocFif70ao4owfN9wiE7a+WHMAXkW2zj0T4UptJ4dUuSVXL4nF8k1k2YKMIGVClXQ9oV76Obz1DFKhK/vk1hV+xtlNieGR4uVZE8gEWolwCf6ToY6BdOZspmyz2pOtS8dpO/RzRsxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397212; c=relaxed/simple;
	bh=PpJeNig5u2NYPGHNHyo/WFkdHebqUShLa7coUodkjsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kIcfqCqd8BmbY9ZOAVsF3qheAkMUZE3iDvM93V4oJP4WOYCVCf5EPFzWo/xbUXHAmo3N6Xl8S50UpvJAEuEAJK/4w2GO2+Uc9ve9ADlFWvaGw8Hw5IyTWh1xDa6cdrX97RXAdcgqWlKtS8sq8dQeUYQvMWYi0M6EgpIaqaB85wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M+BsKLRt; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M+BsKLRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVlwxUZ0/mdnYWggw6zzgE9KIu6JK+Vzmi5qPeOQ/eELBWqVIEwUCv/XXXxmI8Ma+6Z4Pm/efjbJ0z4Ot+3bXDtT+jwjx/Pho2S+K0qAauIE9oadx+BEj83bUER7g6ScUdWG6TQckdd4RGQdTZCbpltuFUzUsvxsLqoA+QTyrbTc1aLN2Te0KcYc6ZzgjwFazW7qBUHJiQMWt/PoM4r6+owWmA6VY9bPFQj5jAuFhQqaZNHUWRqnoPfXWtn1vCg7D4KUGEAFQj1AnmyKQDYltm5RrbbkIJ9SNLiP0GYw5hxXzBIU6eU4oiVBHOy0+lup6BAtn+iWeh71+RwtHVMD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyFOsqTfrqmcyJEFdEpAVnLD1e7XYG5YJrJeZngeXCk=;
 b=cjiI2AtcfB1Kz9UNwR2CxPLOjT9zV+AzSb0kT2BGgzGKWYbOoSeGE3LuI7N/WkHcd3bzSyxjML7sbvma/mOo74/9p0hmebujO2g+AOWVdR5SIVrmkwA2ZMnVJKLTMPN2UGLKZfN24QmQasSrSWK6UWLwPWAsFG55JRU7b/haPCyc/HJB4xbHXDtTzZV1zWwxsg2prkKGpR/6xMoUwOWYn9qEhc1nJUJeB356r00bCLX4CmRHpQ5R+WcKUQO1UQW/tOGaer3KI4zHQIur7S6mNgX67NeyaDJLvCTbE0L304lYm4Mmcje5M1vwkap6TcjB0Kq99OyejDU7SlbxRqFiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyFOsqTfrqmcyJEFdEpAVnLD1e7XYG5YJrJeZngeXCk=;
 b=M+BsKLRtmStWcSJ/+JmMilXherUwcNhbO7ORSEshPgk1PnIFfL4krNWdqUB2JRGxpCcp9KYdsukgDnKthtuHlm0wSUN1KnXnYUM8lltgD/mHKM1p8MSbDE1qPC6Mfz3qu7M+brJdD6eiIrLD0U24TUzn/NOCm61K0ygOkuqJoQOFYkl6I3A81tCha33ECQBliSjlQd2F0L9gH4WhG2i46CtchZY7zmP03H77v0snSQXW3pZG+x73IBcBmB3ypAuPIOClItzVyzo+I31b+WqLhjJJneo8T06t3QPC7KftcTYi3HAsugEwHB5T4xUjMX09lklFg92H+nie/KG59fFLSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB9041.namprd12.prod.outlook.com (2603:10b6:8:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Fri, 11 Apr
 2025 18:46:47 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 18:46:47 +0000
Date: Fri, 11 Apr 2025 15:46:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, nicolinc@nvidia.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fail aliasing StreamIDs more
 gracefully
Message-ID: <20250411184646.GB252886@nvidia.com>
References: <39d54e49c8476efc4653e352150d44b185d6d50f.1744380554.git.robin.murphy@arm.com>
 <20250411152122.GF8423@nvidia.com>
 <9ed7aba6-4d0d-4cfb-a85b-ca943c7e031a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ed7aba6-4d0d-4cfb-a85b-ca943c7e031a@arm.com>
X-ClientProxiedBy: BN0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:408:e6::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB9041:EE_
X-MS-Office365-Filtering-Correlation-Id: 925a57d4-d4e8-46d6-935d-08dd7929368b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FK18VeJQph/nS81FPWVnTcD7ITeb6Xq9XcTsbsyn4LcNTMrqRFbkhtLgD7Fa?=
 =?us-ascii?Q?s9hFfE25UJDwcfrIe6Ud0AtqUB51qhOuufLCW7ICuq9Wc0oXWzlB8tKZv1e6?=
 =?us-ascii?Q?j+tBayGRBjcYfvgF16frMtf0NzrskgX8slHgzo2wlXtpWzQeoAV3QIrMB1Ao?=
 =?us-ascii?Q?th/s+7e890nLwF2tY1/NC2u9c9aqIxWBPdNGGiqxjm+ldiQShO4KzThnazXc?=
 =?us-ascii?Q?GAz6acJDwtXtx+9fdc9+944CiwCG5aI3WE8IHwo3xgOkYX3UCUhrKqJD7qHB?=
 =?us-ascii?Q?/qYoZBlAIf2ykLAGRiMmy3/hAWlrm0wYt1s5QW6eAl2LlpNufJgFCur3cHgZ?=
 =?us-ascii?Q?sN5Ic+YNGfPeIgHEwv60Cs9xlnbYFv4qTujuyCaHswCPQjPBq5P/lU/kKNZf?=
 =?us-ascii?Q?e1pKZ9OfoV3GFMTFxTc5dq65b+sOSUh7PD9nSQwfEwXF9PeIxUA+yzkFS8fO?=
 =?us-ascii?Q?5sQfamuiI+O0j2UqRKZQSIBnWc18H/LQzfH7ujRzJVFAct/jg8eU3w7NOm2t?=
 =?us-ascii?Q?XjpizdjlGGbAO9iz5OIikVoh+EwP/GR4sXKBFMoJqQkXo0FiolpGJQ+SboHs?=
 =?us-ascii?Q?Q2hxOFf74CX+uJZ/F7mf0XH8j0SK7dQ3Ix97TKhd5Trz+fs7w8Iaq7T7c3jo?=
 =?us-ascii?Q?CEYsGP7P8r9uvreUWoZ0IvEKsW9UlBgATmZV5PliBvRNezYItAM1rKL7gM+n?=
 =?us-ascii?Q?4BlzUXE/KslIARx78Rvb+0azQnxa3e/FlFU+DoGrWXLsM6Z9e1cW7mFyK0K2?=
 =?us-ascii?Q?1iywiqxYfNFRBXd5rXNTQDpCQKBpjnwhHDWRuDMEJtiMbb8Xwnwe+etFVhGk?=
 =?us-ascii?Q?44EW0Fkkpj7uUMgIUZFaEYrLsRSpfJkM0Ok3JDugAZR3uaP2IX1yUY7iXr7U?=
 =?us-ascii?Q?K/DWspg2KZHbXcllq9dn3n5sLq5vU6EjTwQOEbTLBdLtifLJc4tBurx2xfL5?=
 =?us-ascii?Q?Xlze5HIEtRor81/twQkIzaO4A1ZFyYw6IuMYmPIqG/dBofC1oVh4vzsYz9dJ?=
 =?us-ascii?Q?WlSgq6wRev4cqRzlnmH2EEy/ToXtieal3bxGnAHwNwEEzR04cspbtHmWyPTa?=
 =?us-ascii?Q?IpYI30R/TKtjpsMC9XJxWJwjuK59TwI8Vn9tjaSgIFp37WxKFLQwUkCiSeDI?=
 =?us-ascii?Q?AaW9aS/Vzo4471kA+EVXKfRfGv/uHjP3bzq+/zRhujavjWUxXH7d1oO6L3q/?=
 =?us-ascii?Q?EB/K5OMw6I/m8Qv5Dn/hamwcTsbuNKSXcqp9Gjnr7nfy9XBzKdzGJeDZx6ho?=
 =?us-ascii?Q?j4JmzcT7bM9LeN/pEKETnjgcn4x35P8XnDJRXGIzrixl/bClasbz9wYQR4yQ?=
 =?us-ascii?Q?gm2OZGKkgtsN86x8bh9VtUEFxMuu5Sua33TQKYWHhTOzzxIGnmVjHX/Ms9n2?=
 =?us-ascii?Q?Li5JGIi0j/kpQqql8xKiM0qC95xNn8qwzq/2lOy2nPKByrdlLTkQcqSTRn1u?=
 =?us-ascii?Q?pHFcVph480I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hvRvc3t/h72/231EHXgQSq1BEcFPq4X3yJpRaEVDa88XJmeSx/Re81voMR8O?=
 =?us-ascii?Q?BBGBO8GI5JknmCUiCH2icqum1s1XRRgbiV9ZPRG53K8geuD2hL+MZy85nr/t?=
 =?us-ascii?Q?9eDkAnX3EnMIJKNhcSME8bIs04x2K/zaTbpaaA/DSyuyfAxGg9LOmn/fEDaF?=
 =?us-ascii?Q?K1nPLDAQ6tc97h7er/oFzka1Q6W24DzOCestOAVr5s0XFNKegj1ECqg5w2Hc?=
 =?us-ascii?Q?dXaHjpF3AO2VtP73y8OLc/cpDsr7Q8sOLUAKVRUuDpF1rJQptIj79t9y0jJK?=
 =?us-ascii?Q?rEHa53icS+WhRZT5eo06lFZSAWjbYf8KHCeB8ilWtOu1bDaQUW3NTDPs2cyN?=
 =?us-ascii?Q?rmyTL/A2Lbrx9uRZHVu9rvE/URw8KYMPWsdFDzSrB/FzJAFrzXHDWog/iGTX?=
 =?us-ascii?Q?kGp9RJIwDJ8ePjNtAzW9+P3rqesaMcH8wWSaZAtiNl3gBonsL56c4XSxNbU3?=
 =?us-ascii?Q?3rb27QL/7zy+k5V7A1LmsygJM83QUSUgE6WzR3ADRj1rXxPW8XRl/Un/Ck95?=
 =?us-ascii?Q?6IBE3Cec2z0ATzMjciItGF7IqRL51xLULtO5pWfCi7Yohbi4yMOYoNIlNb3D?=
 =?us-ascii?Q?EeCrBtUyypp6h2b8vumUMNwJA6wg+NaVEt9Q1qL9V/t576hsCiw3EYV2Gg0A?=
 =?us-ascii?Q?8tf0RyuYuM9974LUyMvxNan2SaZHwj9pCSfJeG4La5vWZnFCfnW62ai6QaxJ?=
 =?us-ascii?Q?UYiBw/bpYz5vuxqPy/d2xM5xaSCCwFoKvXO487ectxbqRNlFPE81xHx9JXMy?=
 =?us-ascii?Q?Mf1ERDrggBgPLkQqevCOVyWtR+gF822JHHuZLOkvJnqje1A1ZpdU/ocMtWR8?=
 =?us-ascii?Q?BRrKyO/LypkJbHS9azj411+m+Skyt1zSOxLDYFIX6zH18bNo3xuSWLvcSQnd?=
 =?us-ascii?Q?DtyUA6s3Ss61m52AC/UGIiHsKPck18b61Ur9qKmcX2C3MpczA/KbGFR1/Jru?=
 =?us-ascii?Q?IdANhGZhjHCVjxaJ+19idWOOyu0oQzd5HnQjR9ACiu47qOQdXIz9vr86L4iS?=
 =?us-ascii?Q?6OyR4EV7JBpEn/2YP4tBj7oIDakWN+mNfvZKzzqv1nXWJBqiurytVp7xoeuM?=
 =?us-ascii?Q?/rrm6Rfo269Ar5zPRrY8E1EaciWAPQA3Q3Nios3RofKlxBKloybluUKdSiDo?=
 =?us-ascii?Q?KuObZITGjZ/dDxMRXVzPelZAuuo5vfXmDlmbm4jPSZ9EHPr4TbPFzpcMQQKU?=
 =?us-ascii?Q?96u10Tvw/UbxGpy+VjfT2F4Z+Eo18XtnE+KxkhLBTRvk1C8TQUW6C5jDgwq2?=
 =?us-ascii?Q?yqDHu9R9hOFbQ69BTbx7/figzSac24wsDRzwlEUgxdG8DzJIgLhhabP5Ds5h?=
 =?us-ascii?Q?AuTgXdiPc+gjBjLfVSvSMllLk6ruDACbVR40nHKgghxX16dadYR4v5QbvbsJ?=
 =?us-ascii?Q?znuBTMx1fMmCegMea0aekOCepuBIcsS5MWBB1W3BEXx8iW5kPxCs0uqlEJGt?=
 =?us-ascii?Q?JzSa/rnRM2Sa1ecudJpheJ3qm8/Xl4m5cPhebiDFEcHRtHvfR0jm1ykyuMUA?=
 =?us-ascii?Q?wXbAxhDbZhOL0sCg46ot8rDVmnBhRMnfLhdwJzDAd0upkNdnoRWkzFiNhLPm?=
 =?us-ascii?Q?Ms7PyRXGrlQJSiClucmzrDP1Scv//ixLOUKM1iSr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925a57d4-d4e8-46d6-935d-08dd7929368b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:46:47.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUQO6/Kp7q2qg/m8dohK/xuSVhLVayOgKA4wr+nghZKdkxHOMc+ey9kFySRbkcmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9041

On Fri, Apr 11, 2025 at 07:16:57PM +0100, Robin Murphy wrote:
> > That is different from the iommu instance owning the device but being
> > unable to probe it for some reason. The failure recovery in the core
> > code should be different.
> 
> Perhaps, but right now this is a trivial, obvious fix using the mechanisms
> that we already have and that other drivers are already using similarly,
> that can effectively restore the exact same overall behaviour as 6.14 with
> zero risk.

Yes, but so would ignoring the error within bus_iommu_probe, which is
close to what used to be happening. I'm a little worried this will
turn into a wack a mole..

If we keep it this way it further muddies what the driver is supposed
to be doing with it's error codes. How should a driver author decide
which one to use?

> Nothing in this two-line patch precludes coming back and doing more later.

Yes

> triggering those failures? :) Annoyingly I chose to kick the can down the
> road because I know I'm deliberately using a quirky unsupported hardware
> setup...

Oh interesting, I'm actually quite surprised that very new chips are
still pretending to be PCI bridges. :\

> Errors which occur during .probe_device clearly don't have to be specific to
> the device - e.g. OOM - but even device-adjacent conditions may be
> sufficiently catastrophic to indicate that it's probably not worth
> continuing - for instance if the arm_smmu_sid_in_range() check were to fail
> then it's clear firmware is giving us bad data, at which point we can't
> necessarily trust *anything* it's said about the SMMU at all.

Maybe, but also, maybe not. The more optimistic view is that the FW is
generally correct and tested by someone and mistakes are narrow to a
single device. That is my general experiance with server FW at least..

Plug in some weird thing, the FW freaks out and does something wrong,
for that thing, but everything else remains fine.

> > It would be nice if the dev->iommu would record that the struct device
> > is inoperable and then we can fail
> > iommu_device_use_default_domain()/etc in a contained way.
> 
> Maybe, but what would the nature of that containment be? 

Just block the end driver from binding so we don't compound the
problems. Not much you can do on the iommu side. For PCI devices
without a driver bind they won't enable bus master so they should be
contained at that point.

> other than leave the user to pick up the pieces, and often the best chance
> for that *is* going to be to give up entirely, fail and disable the IOMMU,
> because otherwise blocking I/O might prevent the user seeing anything at
> all.

Maybe, or the untested unregister iommu driver path will crash :)

Or the fault is localized to the device and we will get a better
outcome by just not loading that driver.

In the end we are guessing, I'm just looking at this from the POV that
for a long time we ignored errors per-device and now we are failing
the whole iommu startup. That is a big change in v6.15, and it doesn't
seem really necessary.

> And for any remaining niche cases of "expected" errors like this one where
> the driver could in principle support the thing but doesn't due to its own
> limitation, honestly don't spend effort on gold-plating that limitation in
> core code, just spend it on making the driver support the thing instead.

Yes, Nicolin will try a v2

So, go ahead with this if you think it is best, but I do prefer
ignoring all errors. If we get a 2nd similar issue lets agree to
change bus_iommu_probe()/etc to ignore probe error codes rather than
wack-a-mole ENODEV across many drivers.

Jason
