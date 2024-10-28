Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A8C17C61
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730118240; cv=fail; b=M6fSls4ANU4jnxubkcdJ0/ud4TuAYzxsOq4N3gtSBj1SXlVskvj6zrdnYLM/aFjLmt1ViyngP7YWlR2ozDn2F41KC/uuFqR3WmpFGqzQtoYxRvcDP1fNw567KaQUChVRhOwf3OQuWpefeayeZQY/jyIDKh0IfQyI40z2LQhOBr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730118240; c=relaxed/simple;
	bh=RVq/LZvth5mRcqjKlfRsDUWdsKVidQzQdwJwyKp6y1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p58d6FvGODjVVn3A+afi+msFPKSEstXa++4lYqs1RsheKn52ABkFZETEpL0uhI91qiogwcb2/3onRUlr/vegWBVbJPqVKwoYuwjCjJb80JQcJSIGSrgRAXe1OTRdJgo0SEnB1tb4mx+LDSgBfwRRCJSik/ou6FxMeIkLiPyYips=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mrPUC+mb; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrPUC+mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpnV3SJ8bn+FC5zP+nGHvDVd4cnrxY63FlQ3m3+GXEbtA2cdIRYygsls21CG2OriBqW43hMIDTX2YwxaWxLZ5hactz14AN0rTMwajYIXtBocP+2BKCuF2h95eVz0lJS0suW4d6HIAfqtMNe3z22i7XTFUTe2Q9Uk0spsX7Rze4Qzll4qnuf9FOQR32C6T6FF8Wk6utJMA5xWoGVZH9EqhbV4eubyTW9BCEXhAXIn8XNx6jdwy+yKGHu3JAkEfLGxfy9Hms21qzLz0Fow9RIimfbC/Qcay931Zw8jhEXueq6HYpmKhi5kVORBEIL7Zw1eDpcR6EEoVK+rXlT2imrfog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5mFhIL9snbwwV8nA06D/Z38usm25ZDXkMfhFeT/1E4=;
 b=QGOWYnjNoPf7AatQfXnB0KIGj7PoxE9gxIpdHtF7uqUZsKDITPfhCAY/1Ipirnr1pqBXBMlXNnfzS41+38vIIzIrcqPLy9xfWLx2silD5PVFt9Cq8B1D2xzV+sNO3NYKS9H8hPLiBYHved+0obuyJEqT0Xz79hjzijdL79mHmpBt63ZyarhrpA4FidWVKClmIi/NY6DE864wQfH6L4p5KKOkxcBVz49hGI1GBlngBYqLSzB/XcgYOweElHCwXrn1dc/fRhFnliaMuSbKoHJjb0Wqwxw1BBn50K4bKdwC+CwJUhx4D7muQW42pHb2Yh1C4SCTS0Vh2OMIKb3eUu3YkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5mFhIL9snbwwV8nA06D/Z38usm25ZDXkMfhFeT/1E4=;
 b=mrPUC+mbUQlnrTQn407enrGUusTPQFqnN8P/WaYsURxxH1epQ69PPEko4j4JndiIqKKQ6TV+kCHEIorvLtefqk+KfLa0SjclWkZgpcFLESAmgAjJHiP/tmbFuBwrATDoY9T5yNSk0io/VhVb/jV1DSARaOI61rPQrFbFj8JQmjvou7vZ0SolMBrJvf3Pfyg7ePi0vga1vFqeePWDvphbxp45ClOAkFU/Evd4dud3ADoO5fDYMHqrzQKIcv5Lgl5i+kO+AOmO74ffygjMTf39g/RRv4/U8Os3aun5LhVeW4zAslJjSjuYixB07lN8VvPbnlB8AZdYK4fXS0g2d0RtZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB7228.namprd12.prod.outlook.com (2603:10b6:806:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Mon, 28 Oct
 2024 12:23:54 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 12:23:54 +0000
Date: Mon, 28 Oct 2024 09:23:53 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 1/3] iommu/arm-smmu-v3: Introduce struct arm_smmu_event
Message-ID: <20241028122353.GN6956@nvidia.com>
References: <20241018180022.807928-1-praan@google.com>
 <20241018180022.807928-2-praan@google.com>
 <20241024131147.GG30704@willie-the-truck>
 <Zxp9kHerb-ln4ioO@google.com>
 <20241024170329.GC6956@nvidia.com>
 <ZxqFx2qFHlUmMtpA@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxqFx2qFHlUmMtpA@google.com>
X-ClientProxiedBy: MN0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:52c::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 9338634e-4ef3-4816-84e7-08dcf74b6398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ST80DoIEJCeCkTFjDCjKxS12/9G7ZPspfmA5GS2/4+98geTUOx6VuizBO1oJ?=
 =?us-ascii?Q?R1EU0NZrj1wK7Wm+IcTWFXiFUVofh2SOR2YXhTtN22j4CikzmoJziJUl5Uqx?=
 =?us-ascii?Q?mnPuKn/nlb+g/kVHBPKK4Urw8TrsDkFa9BqfGgZZ0RWVMaDwhc2a/zZDW2FR?=
 =?us-ascii?Q?Iq2VEJ/g4M7NDgMzLuC0+sfylh5oBOXJOGzdgyWoHlQH5ugfRe27tgJ8XNAG?=
 =?us-ascii?Q?M82aTnc9uH2scbVgCUXg7NYR91/hKVJ9DnBuZz1HFbU0SBqJqf4F5FKyYoYS?=
 =?us-ascii?Q?LMcUMgLcRbdtMTO2XtJozaOc1M6DGoL5GAT/M+6QdAgjw/yTBnb60IS7a9A0?=
 =?us-ascii?Q?1mPqtqfRgYa4BIa9EHwgiSxLt6uby3ASyTTcqdJiJBzdfPPwtsVnjjHN2TcI?=
 =?us-ascii?Q?BUNZ2MKNwIjqKJ5b+QXSTKHnJABEeRNPyDGrB3IjpeYxmvmcW8ZS6ORLKjXW?=
 =?us-ascii?Q?Ep+/cDEtz7ta+8g58C+OysTwqZvwPrVv9eQZ6jQeXurA21iw/NXwx39ATe52?=
 =?us-ascii?Q?aAXQBblR91Q+3tcXFj+evAR2x3SGmjMuccTFCzE3xh3tPyzmQrW8CiXvs9GC?=
 =?us-ascii?Q?mbWjTqKBNYCCB+QoJ3e8cRZrbDWSMUuRdXKv0aPHmzSyo52bzhN5rTm8cenp?=
 =?us-ascii?Q?UqXbi8qkVABV/0owGdMTU0F6re/stwmwFwSWZvRN8iAJIlKIzDDFNXhZF0t4?=
 =?us-ascii?Q?bs443q5REDxC9WRjWKU6+oqZWLwR/Dy8TPUDkmuIGjnhBVztiO8DQsPDPHpn?=
 =?us-ascii?Q?GarGUKxxBTfDmkJJDaCnZNO/Bc0tptWhfqNVPFAVGVCqdtcLiN1GO2LLFhB5?=
 =?us-ascii?Q?qCIQPZkvPFxTKmtUFbwi3tTxi2aHlQfNf5950/gJyYZbtE0/OwSIk6KOcXnb?=
 =?us-ascii?Q?y/VE0MAXzBwqlyAk+ClhNy+Ju4rP8mYHj9EcDAhvndNDmCS9mpDEi7Gxd+3b?=
 =?us-ascii?Q?VRdCXQ/BU+fnt62sHQdP6ixVJCDv8V+RdnBVS1QRC9gDg48MfOdpbHaDudGI?=
 =?us-ascii?Q?maXE4pbd14AZhBHPHOf8uUzFIKwDlcYpVFYIb1lv5grieDe/lAuFn7aJhEqX?=
 =?us-ascii?Q?tMx/rIXDrNoRr2904P7p0irdbJN8WRoh2p+BI8qKnupQFGinxylrN6iVwdON?=
 =?us-ascii?Q?rTcLgtDxLeZn0goIzspnuo2GKGees+TFKuH1a23J1T9Gi0wPYsx/GT8+AJvQ?=
 =?us-ascii?Q?VICbn7Q/bOyPolDfTTeOfaY6phWwwzu4chX6+bnrfeD3+AAWAxJjOpLxWtm+?=
 =?us-ascii?Q?ssQc2WPNFoiaiTdGjnedmPsvhcd3VzQQAuN9a6czV2gW8kbvHQHvhcTRXkf1?=
 =?us-ascii?Q?//8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?csRCDkwV6UiQcDpyto+NT1DDOyO4p3ibzdSSlQY2jfxxlPcvyC3+5TxN8cWF?=
 =?us-ascii?Q?ijRYpDTtxkDuyukrcToEeQUDbtB8QjfTviF41qrWSanILejbmorYzC31cCuQ?=
 =?us-ascii?Q?+otU8EM+ut8JxthV5PVp/05ebuKexxH4n9pWuCnlyQiCmjUnXLjGSVTw2EIv?=
 =?us-ascii?Q?HfdxGAO57JYFbp/wPvVrYtJn/A3NBny/SVqqezYlOcSNC5nbpK8uwmhxaIAu?=
 =?us-ascii?Q?3iDcmcD7liqArt0AmvSjPlc1Z7haM6djE7ReKqWfnNfo7mJV67nFbKKJR89r?=
 =?us-ascii?Q?kD+4snqQE0MV4tNhXcEn4Qll2Xes9jQMWiqH5IwwFQQxJK6+IHiK/VM184sV?=
 =?us-ascii?Q?vdIqHenDAtd7l7w2zPVsOMiHJphgnilTTVtLd47ymEeC5ZXp0+NN+NOTkGRW?=
 =?us-ascii?Q?E2Go1vwC7jLXow8Qxga3iHV+s0TLtaLZ+1I9WuQzJB7Lf05bydLN0fLVSLsz?=
 =?us-ascii?Q?/PlulOd812CS71BDM/W1Uwl/RftRpR5ZVo6+vHT01g0PKMPuk1xgIAzfKXiK?=
 =?us-ascii?Q?Ql705sLxQeQdvuPhbO1vlO+GHmREDbwYOj48MFnm4dxfhLHlxhoAKcTKYsU6?=
 =?us-ascii?Q?O0kQAGzCYDcJsVb0Sga3ii2Q2jntn9rRX5vcKGsCEsbc7pYW3gCnF5oYcyQ0?=
 =?us-ascii?Q?wiZit2q0SBFyMYLGCeQFri1eP1wpTgfxPYhPx3+bd5SJlvbrH7YfOVh5kf5j?=
 =?us-ascii?Q?Y6OIYAkJFM0Rrn0ky7TtMZ3JKZzEFUgMUpkXAK2zQ8W042XZZ7dtXPRM9pdN?=
 =?us-ascii?Q?sDgEx7o+ZgrauOPYkhq7xCnBkrfHKo+kJSq1qbVSZ4zMMexl+52hzsRumb9+?=
 =?us-ascii?Q?WTHf8n3xvMlTo3dgJusfxyt+sJ2Oy0aQ11qxuWh6AXGQyIAKMnv3YNJ14KvK?=
 =?us-ascii?Q?fDJqZ8NBc+Elh6JXo1DDHboamGGZfIJRT1KrkhsPFlP1JraQs8b6SV/nnZsE?=
 =?us-ascii?Q?A1YB3lG6PmgH7hT8Rdpd0w3YnH/5WU8EITi2sp7Dq/0TPpoZ3ed/CrCdg5Gd?=
 =?us-ascii?Q?2vcbbMNKF1Y+eCCL2p+DffXdOjiNW/KKaJIb8f5l13T0f30hEjOOG8msdim5?=
 =?us-ascii?Q?sD1Ft4rXXJK91/L0YhqF39hzTyeWHH7SnJf1xt/Sa2sQidWylRvucmgfesNy?=
 =?us-ascii?Q?d8qsKQww1617/2hMTOzWl+kKtk5Mbu419zCntur6N0jG4Q34G8Uqhp+L9fIj?=
 =?us-ascii?Q?IP97qagLY9ikzvgABPsQ3Jmv2znBR/O9ynbEZKfsz9IpY9AfzxsI+kUUQBcm?=
 =?us-ascii?Q?Rxi/ktq9DWfkDP1wbNVlBqDi6UjiXrPqqZ7xD8UNDnrUZi6pZFZ+lEXTcw7K?=
 =?us-ascii?Q?dVsBjFo5OmRH8gUd7OiPxYatoq8c3h7eeQQbCH6Fyj0umdzojDJ5kXkuwDnW?=
 =?us-ascii?Q?NthAYyGlvPGlzFXSVf2CY5fW8KRdDsSB3sMpyziTLXsqAoLrfk13CoqE9RUA?=
 =?us-ascii?Q?rWfxsnf7FrW+Q2zpSn+r3JQCHGQ7S7ENgnp9p5o6sNVZVxmEV9Z0COh+YZnu?=
 =?us-ascii?Q?noMkUE9eKKs0haDGpayHF1gA05R87mFGvSekUkMdUHk7rU3CQWogh8CX5wGq?=
 =?us-ascii?Q?fKKz8LBkbQLrNCHKvCc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9338634e-4ef3-4816-84e7-08dcf74b6398
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:23:54.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQ7vSPKQTPUaiAcfBb1Nwf5rMvw/0CvnKU0JPtMVgNfZ9CUo8GO+vX5SxhVqbJiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7228

On Thu, Oct 24, 2024 at 05:37:11PM +0000, Pranjal Shrivastava wrote:
> On Thu, Oct 24, 2024 at 02:03:29PM -0300, Jason Gunthorpe wrote:
> > On Thu, Oct 24, 2024 at 05:02:08PM +0000, Pranjal Shrivastava wrote:
> > > 	/* --- cacheline 1 boundary (64 bytes) was 24 bytes ago --- */
> > > 	bool                       stall;                /*    88     1 */
> > > 	bool                       ssid_valid;           /*    89     1 */
> > > 	bool                       privileged;           /*    90     1 */
> > > 	bool                       instruction;          /*    91     1 */
> > > 	bool                       s2;                   /*    92     1 */
> > > 	bool                       read;                 /*    93     1 */
> > > 	bool                       ttrnw;                /*    94     1 */
> > > 	bool                       ttrnw_valid;          /*    95     1 */
> > 
> > Linus has had negative things to say about lists of bools in
> > structs. Use a bitfield?
> 
> Hmm, I agree, each bool is a waste of 7-bits. I tried the following:
> 
> struct arm_smmu_event {
> 	u8				id;
> 	u8				class;
> 	u16				stag;
> 
> 	/* Group the boolean values together */
> 	unsigned int stall:1;
> 	unsigned int ssid_valid:1;
> 	unsigned int privileged:1;
> 	unsigned int instruction:1;
> 	unsigned int s2:1;
> 	unsigned int read:1;
> 	unsigned int ttrnw:1;
> 	unsigned int ttrnw_valid:1;

You can make this a u8

> struct arm_smmu_event {
> 	u8				id;
> 	u8				class;
> 	u16				stag;
> 	
> 	/* Group the boolean values together */
> 	union {
> 		struct {
> 			unsigned int stall:1;
> 			unsigned int ssid_valid:1;
> 			unsigned int privileged:1;
> 			unsigned int instruction:1;
> 			unsigned int s2:1;
> 			unsigned int read:1;
> 			unsigned int ttrnw:1;
> 			unsigned int ttrnw_valid:1;
> 		};
> 		u8 flags;

I wouldn't do this..

Jason
