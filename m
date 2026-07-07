Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D393A1C9
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435524; cv=fail; b=dVTPAT6kp6bFTMdo31DPB4Hi8Hrk0sYxFoDLxAiKT/VPMp3z7QSbLhWelEST9HzZh5wNStNyabVNPgVeLSOx2xsT+G2L+cHTqvdQzegUZAM1zj8ep5N5YRRgvOGO5opB5Ou80zGFuueLnr6TciKfGEJ7DRND5TbfxPjtlgNghNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435524; c=relaxed/simple;
	bh=cZSRIsO9jCtV+LgSmVXVgOGjYiyPv4dCO+PC7M/DB7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gGodKpIM/EsX9Ky6XxU1X5FrDYn0BmkOdzw+VYFAI6vO68+Hn0pnhZg6H9NBI0mDQOpCSegJgJMfecFER9m3k6YWDA0jheJje0ab2Yd6BlJFRZ6ZDHRgWw5EfCpRx2feytquke9y8FS+I3S/B8TtzDzS48b1NTDRpJjXyh9lcl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kh8Otb/d; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kh8Otb/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJhkQny3gqsPdC0uOixX+Idm9shs08K0vyjXOwBO155E2G2v1ma+RFiEL0jmmwWfjZpzwuBx2D6cijpySTEpZBL92maK4w4NVRCnJA4vFTOh0q0PbEK33hpbF1H00f9gmNRO+VorhA32JvGjPP8ykN8CRQGrCo1RODoYuy53ORIx7kFv8ppjgGBqCPii2xUA8ICHwFD1iZzgPsI+1Z+AW1581fbq0j+Z3a3zdZd7V12Uxqyi9GClheFEvNmVPo302VnYFguJ09N9D4Tl8ImZFYhHkYGGFtuxq3kw4+0WeFZ7HPFhTXwlzFKFowIPFR/kXAAX8TMK1FiYukr/LPxKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyWhEFx6A9PhCQKJnvv6+QkJ0b5Y/ILBDRXTqM/TkiU=;
 b=vh6aPmwqemYY5lNK40sbskWS3ArEGjc0Qo921CCzFPUvokuf7BbiYq2njYdOkM2AXh2+BAJnww1iuun//ETddlP4xSmfHoxlGLO9IT3p9LEIWXMH39mMpjhXqKZb/ixlOjumkwMH7jWgnBzcldxsKs1RKqPms9BeU3WLeHFt7Gqv5B1FphBg4dkE51dqVmfIKYCfwUVgo6ciJSUiDRfVt3/iURF+EKbge3nwoncphdIePYFjm1qE8O97YmqHXDFfkKBkVdsddYgDUq0PFRBDpvOUS9kwSulCg1avWaS2eHTYP3Zonyimx3qG/ITXTDqWziXR/BmH4OlJDkGxixPXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyWhEFx6A9PhCQKJnvv6+QkJ0b5Y/ILBDRXTqM/TkiU=;
 b=Kh8Otb/dav0rGn3aGKOeewCzddBlVY+DyHipKaQM7o1gSUMNImv6UIlwkCJinfJy+jUCm3MwYOxRx7tfwP9P94fRVRa7u6REAY+WeA+nvlW8Aa3ZKXvrkjk4A0lwpZqlF1n/58a9wnN2AT0RdmGgd7cfEk+g9P1gC2KuVKoL6eaa5pROJqm0FMo2q3qLWUKEotBvUwvsGC1f2Hxpi+xLNg/tcti1TMLi33eKULqNEexBQIxyKPxGWuMTxVRvUjumtR6CXOJYvk6Y/6iFMPQSGkMGtqswEXc0hAWw2946oW+BlNgsZ2/5Hn/5jcOR3BAaQWK0z5c0bNdHjc/xb0mvrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:45:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:45:18 +0000
Date: Tue, 7 Jul 2026 11:45:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 00/22] iommu/amd: Introduce AMD Hardware-accelerated
 Virtualized IOMMU (vIOMMU) Support
Message-ID: <20260707144517.GJ220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT3PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::23) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e68052-7b80-47f0-6f83-08dedc365d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	B6rh0cKg1/AJRRX2StnNfYrQ4YUYHPXV6oBU7gXNMFe1DViqJdHahL9AKU0qUfEOoqohjwuGAHqRL51y6FdRtxrRhz/QDRsDEU/v9aGZU+t2OO2rp6h0ce6VOHzKSAHQmbnPQb/psaOWO+03mRd/CpGJmZQCa5qoWk+k7EF426IxIerfoTdQL2AOZQZI69zJjT5t8O5fjeaDmslbyEA6itPGWYfWSc5JiaXDN3ODi4PTVmAdS9a3tq62EOCpyHgAjVbbHM7ZvzNjCMkw0DfYtnNcebiK2u0L0kJyVB7E1H6RNU8Bi9x/BSrkOtb0DBa21XTzKwSbG7BQq/VnIFH/LOEhQjC8dPt/KxMExvcqEOZdplyH4SlLkJxuaVUKaCcCF7mfIfvAspJfKN96mdcHpYRVq3askQ5GjyyJFGrD8QFT/A7WSrAQUCq4IhV6b3Lu28zJwIw3h8u03wxxNJuINMqjH3y/+18jq8f1tQLWUNyDtXsdpBw2BaV5nool5dna6FtnfTdASAMZeTWn8DZBcZiUO6qloFZa7dfPP3Lx+jfvq6zyts7AL/BCveRlHfRsHPFs5m/H3lu6US7S/M7YCu8ooaUz3IHUfW75NEc6Qk4AVnq3AztaYKy34Ul90fb0ZN1mMQcZ8QpY5bpoARi8PZbt/4phVpNHW3zc1G/09+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lE/Cd1bNHT+sb4zCMYJiA3KxQCIlDA8dGOxLznX0ttEymRLUi2gTuXrWCnNm?=
 =?us-ascii?Q?hP8z8wRnmYagRFJIC6a7rsnHhhtlvtQqzKSHPJnpEddt8uht1D3JxJxfl5V+?=
 =?us-ascii?Q?T3YHHrGKTl4FuT7/KRyo6LoOkMryPSs+7LTBCDQwlHnUYYg1fubO06g57TLi?=
 =?us-ascii?Q?1M3LJ0kRBUYyMX/Svzkdy1CnPjHAR9hMb84vf1y5ONGRbixIoEzdYmIa11xO?=
 =?us-ascii?Q?FWmarad0NcZSlMbS7Njz47PCJh+dT8P32KPjDaGXFacbDVb+0wx9ArL9Wlg1?=
 =?us-ascii?Q?APfksp/rDhS3dMXmBIhEVDbujLtKp8fPa8BEA+kvvznz1EQeLbucTYeLXUIt?=
 =?us-ascii?Q?B65Obsi/VU6lnzoOKFBnsSdGDNDHbvpmJUg2pNA3H5xaV7ZokHkaPSvvnkuA?=
 =?us-ascii?Q?0ocKrPC2lRXNpiOkbzS7Qer4z9NkcJnNRIUQ/cc6/gzJM46SGmU8QJjGlwoM?=
 =?us-ascii?Q?faRQpPbuxYYnoJ8nrBDbukPJo+CCGWAxKt0SuitP7C9cSyNfqkBEgwtAISKF?=
 =?us-ascii?Q?PZ8J4L/CIudtQ+pdnhmBtdm9zuRXQuYxK5/6xFxISBrOykJbYEZ9G1cTxzHS?=
 =?us-ascii?Q?CkpGhorAGUQ/xnNiEWmtzhiD2E2Tk+Mqefn8uGNyu0u815oIxPnbTxvZK0bx?=
 =?us-ascii?Q?xKdOBMBmihUAMhAtvzFQWTrcqo2vFtuQ8pk+B2PAT08f5q9O3lPYDRSJ8ZZ+?=
 =?us-ascii?Q?WK6gIFQDHiI+Dmw/VJXyUxLo2/o62pAfwqmXiBQs3zxoJvLFlh5lJXXOCiNY?=
 =?us-ascii?Q?oRovTfKZ14+uLJUxwqnzXCIBwC9C9IAvBtnuADslRawQGjWwoeHv1Qupy9yA?=
 =?us-ascii?Q?VjBK2zFs/aXY4u8pfNw+E8NANf64imMzkZbVrAbvNMmXjP/N96O2/GfpcztZ?=
 =?us-ascii?Q?PwLDdbaU72+tUbfWeuSUpaAg3AYrUxw3+rC6DQHPd+7RZJsF3lQJIaPmawlM?=
 =?us-ascii?Q?h1gT55N75axQkhbvpPtNQKm9Uxs1FuS33h/a7vHg16G7Mw9sfS8HqMSEufvI?=
 =?us-ascii?Q?iaS+LjRBV4t4GUxhl2E3oVJmdi8uAXQN4XMa1DqDcssjpOQVQYZRV7zdzljy?=
 =?us-ascii?Q?vfvJDWHPIiF5AN3mNCspASAmMI8Cjx9k8xJHv+k8+b4wKcMLEffZPftF7FWT?=
 =?us-ascii?Q?BIbccu3JGEAKZWa0WZqoAsj6s7ghxQEBdYgIsLLLdmdM1vU+YrqTsI/C6zeq?=
 =?us-ascii?Q?PHMgpVgoRIaqwEIIWrOneBSad++wjpzddbG3MXgUjNPESVqqDCV9nxS+f29L?=
 =?us-ascii?Q?f4zTXnYgok5v8q7j/gN1M3Zqm/XzAgDWRIegyowBIc9Me1aUaYi76B8DBCqK?=
 =?us-ascii?Q?1iuTNyW3p7NA8feJc5Nc0GSwLQvIrRNq9V/GJVjawASQHdHoYSl6fksfjwsH?=
 =?us-ascii?Q?JehyeqPboTXHBwEaL0qhdeloO2qH5bPC2ozTKz4WKESUoXQthoBBBonX8EVB?=
 =?us-ascii?Q?1ZjhipEjyqbyfOyf+p1sxFDGaWSgrI46Ew/soi2Srfys4qExalfAe3ZEqIFO?=
 =?us-ascii?Q?J0ac1VJMKPdAn7SGPw/eN8UxGDb/TyXtUZkr/W/DKeKNbd2Rhv7qodHTkW/v?=
 =?us-ascii?Q?xJ74Kv+YII82HjYzc3W/+xXjuzzcvkBkk+0tNtII2iEcBavh3hQRsvvGj24O?=
 =?us-ascii?Q?rRtaAJNJ06dI55M1tpbRuOhBNfOZpJQgGXMxWvNeP3dnq99G3YAvP2r/qYXQ?=
 =?us-ascii?Q?Y9hcCjIok/x60KfkMv2HhCBeOpBOWV95JabRRd5z8UJx/yax?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e68052-7b80-47f0-6f83-08dedc365d4e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:45:18.7862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MAlFEcZOOSqOhV4XZr2lMYvRktEHfl/Y70CM4jfZRJRZ63iphv65ZJP15Hs3r9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

On Mon, Jun 29, 2026 at 03:35:13PM +0000, Suravee Suthikulpanit wrote:
> The series is organized into the following subsets:
> 
>   Patch 1-3   : Preparatory patches
>   Patch 4-8   : Introduce IOMMUFD vIOMMU support and VF MMIO setup
>   Patch 9-14  : Introduce and map vIOMMU Private Address (IPA) region
>   Patch 15-18 : Introduce IOMMUFD vDevice support for AMD
>   Patch 19-22 : Translate-device-ID pool and per-vIOMMU translation DTE

I thought this is pretty good looking now, it uses the APIs as I would
expect other than a few small notes

Jason
