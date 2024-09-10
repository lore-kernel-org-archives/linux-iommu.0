Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0DC4D8A1
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943407; cv=fail; b=oQlO3Q6AQRjP+vVWynO3eqfkCzcjNU+FsbMJtKp6sb2+1DpqiggF58AERtEBeZoUxljXYKyEYbadUaJwGGWOKG5UrKGrfPeyxuVy8/zk2yllYFMA9h4GxOFhHVAVLJ3bdAU1RCbk4NPEd+M1pwcbbZpGdlMxqNsHtnSfmwTN2IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943407; c=relaxed/simple;
	bh=N4SqfAQwiVGpDLgzt+YXyanlmI/Lj55BK2TIG+wDrJs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovbpKCKlB0KT8otwF3LUFQQV3uTSyQtESUb6QKbnnahw3hn65dkWrxk19WM+HmnTYa/+In3UDEVE1px5Xv6OD960LiEI4G0dnZ427hdH/xP/MZ9PCWCE4IWrHFadqY/kSx2CqQKYf+xOZ0QNHNdB8mPhSJ0zvxHXkLoEwUOZNk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pXGGUWcr; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pXGGUWcr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKmPe5A/EHCjvT0y+J5+tjpHDvRkW2ZFkw6pAzu32IEd+SOlLusRHyb+KydagIQYBwU1ODHQ3yR3hqMESk4gg9uyygiWYaqALJoIZkH6OV8lSxE489+Lf15DbtckvLCRnxwUaUWRzURP9HYamDKwEQCSvRbjuVQqW19VBjUoHSotvaWX9jOvltN+/qP8zJhFsJyZp/N6gI1DaJ+FI+C/gNM71rViEkJWew8bgIFzpVRBNoM66T82q66Ft0Q8xywaHT4Peu+mEdVJ37Mzzwil+rQlq5484nx0q6ltM0KJ9jvMkGh/olNaqcc5OuMudxbJJ08Lq++2HocdE2nVrjtnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hpb3feNQGAtQK+QbQnjoiVX2JMpWiUkqeS6adhEnl8M=;
 b=ZTh0t7GDexRovkYn2SiJVr+K7AHVQt+mMAWY+YwSdPoat8lGfO0WR141JXPZDC64Kq9ZRRNH6wFFoz6qCOQuUkQKVDrhwMLBbINbaldCUfk2WozCl6TfC4VkOospR1HQ4CQ7vM6YXNt9JEQrp+5SCsprIN8mtms8kTclt5WVZVnbkSbCSH0Bi+Az6KFX31MxEF9wiaf8DaCPOBiDLXSnaox/QC05PVWPfQOqtP/9z0hMkXYILl5jdVMAzPMoc16OYaqzfH9ImRPbMw2c7t0nZQXEEbUZ4wb72q8cFDofyhWpH9ljy4BMXJ1tYmMULBGcSp3CA312NB57My9z9LPSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hpb3feNQGAtQK+QbQnjoiVX2JMpWiUkqeS6adhEnl8M=;
 b=pXGGUWcrE8oiV5hzTcxujjGRCZV0VG7rQjakH1mbIGNy5DhYjwZQj+CsPWInuiHbSxjkujmKJU7v+nqPiifvyCkEipGxN8Lgp692YlDOLXFJ7pfy/Z5FKriVDXuvc6eUwbf/m4nvtMn0dE97KYQTA1JHJPf7aWhWjr9YGdajmTWcEdXLoBQRcFoQtnnrfLay6xob3TXjcD28ESUHoDBhWwBW0YQD/3nUL8PxYFM0vIDN4u6+EvN5uDDX2+MKK0L3yt7w+jDhf6Cnk+UY4osQvzS8CBSo6XJUImD8GsOjwZK21zKY89P9YZQexoQmKBavVKMhYkiBCiY0bhzAdQda4w==
Received: from SJ0PR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:334::15)
 by CY8PR12MB7611.namprd12.prod.outlook.com (2603:10b6:930:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 10 Sep
 2024 04:43:20 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::88) by SJ0PR05CA0100.outlook.office365.com
 (2603:10b6:a03:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 04:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 04:43:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 21:43:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 21:43:19 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 21:43:17 -0700
Date: Mon, 9 Sep 2024 21:43:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
Message-ID: <Zt/OY4mKZhnOqyhG@nvidia.com>
References: <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com>
 <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com>
 <ZtphFYr1jUhHOSnC@nvidia.com>
 <20240906125524.GA16773@willie-the-truck>
 <392451a1-784c-4c35-9924-1a1f4cba9120@arm.com>
 <ZttNF5qcc+jH/3yE@nvidia.com>
 <20240909144506.GA19863@willie-the-truck>
 <Zt8wrkj7Fg4W8lUf@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zt8wrkj7Fg4W8lUf@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|CY8PR12MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: bac09053-834f-4552-5957-08dcd1531864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyMLHGvbwe++D1Jo5t2ZzBuM3r+TJx6kaIY5YAGas7MrvZ/M7UYXPBryPsy9?=
 =?us-ascii?Q?mQEhuXrJiPd89VhGbz/JX7IaLQflXA5ybtPm2CLvaJ8bKaXO5ZFYEMtHg934?=
 =?us-ascii?Q?mGa38r4+ZM2ZPXRXNg6I2WGoPAju9q43RqsFgAH+anDi2TkQIy6fsUnqWGfy?=
 =?us-ascii?Q?I4v6fk6QnGH/aZC5KFt5TYh7PqWh0xwKC+KuufCkP8imaXmB2ua5ECzOFcKB?=
 =?us-ascii?Q?w+E1mPTKGZFV3TkIc+MgWazdaIh/VQtghgZK1pFhRtOx0EYBn1NnpBePNvXs?=
 =?us-ascii?Q?WnDD8923bZ2eW8pNGvBpCoeSxJmtsWMr3aZpaIGibIDx6FSC/OwAHr64jDaQ?=
 =?us-ascii?Q?SwqGaGeVA6/Z3mtBFe9QzcRAUDDctBcNv6OAsotZohmv41zMVxC/p8yEHGE3?=
 =?us-ascii?Q?4dGyCQDaNpojy057k0fuo/qY/lLpCumzb8OK01DrYD7/g9x9O5Ili6uRz2z6?=
 =?us-ascii?Q?FO4jLxg0Ro32v0bLIFbanPDogDVAPGKcDRptA9GY2sIu0brggVtyhXYhjHfN?=
 =?us-ascii?Q?Tn2MKQRBQwGXJyN3kiZ+b61ydJl3GwoLgTeFacsu+0P+5i22DQnT0whF0n4i?=
 =?us-ascii?Q?fTBa7ZUGbzrLTXm+7VcWjDJhN2COiPgQmUSiOIcXo+qjbcSV4PAbMWeqdSR6?=
 =?us-ascii?Q?qGhaB9NX2JVAGsLcrlpTX0dsRBAREjPyf6NUPlFHG/hViBACiaWd8YrYH/gM?=
 =?us-ascii?Q?ZcJMXG5VTxTHs6mYpHmo/ADDQFVu9dRFarF9vt8grzXeoWgU8X2Jz7cJf8bl?=
 =?us-ascii?Q?NDebQ7F7X6aRvq2MtUmak/hn5bZD4wBxrZX9jh//gsIo2bZjxUMOVPDx++rN?=
 =?us-ascii?Q?f4YxXOn9XRdI677boAyK8JjrOT5eFu8qWS8HlkNkeQLKsZAWLQ57BzMEpUi2?=
 =?us-ascii?Q?oCaz4V0gsyjjDfyiuMTZoAfLHDQ5+a204L8ChfHd7wG+EYtMm4d7qsy5B9ZQ?=
 =?us-ascii?Q?Rh1nE1/s71gVQt4cELgxc3tE4gJA9MKAwhEVOceZfX4+kOZUzBfluioUVxGF?=
 =?us-ascii?Q?nhDgD8Ebmo0I3TjRrWHuOouukoZ+GFZysfHWGXJZgaDqWDboZtR3a7F11VFS?=
 =?us-ascii?Q?QinTNpiKyEMi3fD5Fz445P2eH/Hqq3ZlWGb/ESOs9W4dFp30f/BqLNkhqzDr?=
 =?us-ascii?Q?OKp0dA+f4SiEVsQQTIo/v7tvd2c1BaEqU+cXEZLmX7SQTYI77ede7sIhvUQ0?=
 =?us-ascii?Q?+WIKIy717j2zkaYmQDWZ4tbYOm1uzYHI1o1eQCV0zEJU4L1kWjNOoLRipZ6V?=
 =?us-ascii?Q?Dl3jAxKEgw4JFIWxJFkJq5Z9y9kEYMem7nds70Pkda5Fvz0gfgQUsel0nXCh?=
 =?us-ascii?Q?7+mvwn0upD6WiZYpWOnqvsdYU61o/xo42RX9/6kWTYdvPFnXq3gNd/8rAgJE?=
 =?us-ascii?Q?dS+beafdODgIp5WgwFW5RNxWrNRIbqrOFYv0nCKqX71bV7TOkE7SfpqL1de9?=
 =?us-ascii?Q?uM+ls1JwSIxZfPhgY+HQx39ogaBtdUF2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:43:20.1175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac09053-834f-4552-5957-08dcd1531864
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7611

On Mon, Sep 09, 2024 at 05:30:22PM +0000, Pranjal Shrivastava wrote:

> > > > > My only real concern is the fragility of using bitfields. I don't _think_
> > > > > the compiler is obliged to lay them out in the obvious way and I can't
> > > > > think of anything worse than being given a bad pretty-print when debugging
> > > > > a real driver issue!
> > >
> > > Well, if compiler is going to be an issue, I can't disagree with
> > > your point.
> > >
> > > Any reference to some existing issue with compiler failing to lay
> > > out properly? I wonder how other headers could define their unions
> > > using bitfields and stay safe..
> >
> > It's not so much about buggy compilers, but more that I don't think the
> > C standard defines the order and so relying on it can be fragile. If you
> > fancy going to the effort of ensuring that LLVM and GCC will agree on
> > the "obvious" layout forever more, then don't let me stop you ;)

I see!
 
> Hmmm.. +1
> I had some time, so.. I dived into the C specification[1] (free draft)
> to look for bitfield layouts, under section 6.7.2.1, point 11
> (page 101 of the pdf), and I see the following paragraph:
> 
> "An implementation may allocate any addressable storage unit large
> enough to hold a bit-field. If enough space remains, a bit-field that
> immediately follows another bit-field in a structure shall be packed
> into adjacent bits of the same unit. If insufficient space remains,
> whether a bit-field that does not fit is put into the next unit or
> overlaps adjacent units is implementation-defined. The order of
> allocation of bit-fields within a unit (high-order to low-order or
> low-order to high-order) is implementation-defined. The alignment
> of the addressable storage unit is unspecified."

Thanks for digging into the standard doc!

> However, I'm not sure how these "implementations" comprehend the spec.
> 
> > Will
> 
> > > I am trying to learn here: apart from what Will mentioned above,
> > > is there any other reason to stay away from bitfield?
> 
> One more thing I can think of is Alignment faults on certain archs.
> Accessing individual bitfields within the struct could lead to unaligned
> memory accesses. I have run into alignment faults on $ARCH=arm64 couple
> of times while using packed structs in the kernel code.

OK. It seems that we should stay safe with verbose FIELD_GETs then.

Thank you
Nicolin
