Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B41B9B28
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037687; cv=fail; b=DwndiL1XDjBv0t9TpEjosq4aiw+l/z4+35/BU6OIQxfxUtYP6pBay6+yTKfqG5njhcA9k6Z1TXu5rBaBL/OuR0fb/fK7D09VH/z+WOdWNDcB9uj49Rf7cBiVcXw2+1Mwjd8sEvSjfn42TtvX0lGLIbiSPCRzoZReoEzOm086rbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037687; c=relaxed/simple;
	bh=Zv17kE2gtwNsjCOacfMTqdzfbO3OsnvnWGcU2K7+f5w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgcRAR4zhX/k2DL6t8F5Hw9aHsnge3NUHyofo2oThRG7lhuBmvSwFyF9WzQMZqISTgC4pLnX/yqSZNMfamJ3oobj65nC7sqTScsCuOH0RmVdoeoeqT/a1fGc/dNfNAo8myBXwDrC2gttqhnv472b71yyAcqxJBcS5wB9YbbBe/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WbFZduXr; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WbFZduXr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bg3VlGzZCHrQCFdFqQuKgf8jyIkmElDbuhTktgGnt3npqoGFpb/CC5//H+Ht7f0XFS5vXtIOnl8b2BrkP3/mb4r+YNMzCfnZeEL/WioiEP6skyaQYUWNTY0q2sXciNFF8NVJADga0BkavBaQfXUowj0o+klLan3I+zH/cJ0XHsx3rvxP7dOtfD4xuLqn/ox3QMc3WYqW+MtNnKbUFSKrH2q901hQnVYfMX7T9Ut2n02V0J47d9vJb6YinC2vgMrJoHwwISYlI2/CIrcv7y0nn/A8eO2TZBLzdRpG5gWm5WLFa8s2lZTwwxEPozeIooBL//k9bHbj8c7Z94MuHXJIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y6X4EDL4qpvPfpyrQR8igAQUs4TthNX05RpRgZWWWC4=;
 b=JOYuubW+vrceZXzvDSm4zUeS6nDXn06z8VceBXkFG53Jbc6ChEIlg9n3f2uvu3VWGNXrhLN1dT4EwXJBzeW0BpYdjxxfQtQqiYQ9Jp6p2k3Ap/T7I4xDuo8OugcdqJ2mIhmNrInWywuH/pmwC1EYhJWcV+dcvOCIyxMkHW0ZnQbNIeXuQOXWsPeNKaql+5r9RNDdx+MkduQvbm+jy9+kX1b9RDKTAYPFDfTQL+KzVHOwlqJYSALhkM7VlSmkEwYXZ4oBlk13bkdotk5YYgYJNLEeq7l3o8Csb8+fOwp1lo1+Dl9CwoH6Pvc+BK6ofkFdVGFC06ND6As3sIJCrHNJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6X4EDL4qpvPfpyrQR8igAQUs4TthNX05RpRgZWWWC4=;
 b=WbFZduXrt/GrvEj3FFAx44oDXSc9MY1YQqDVpjMUm8c3ZUYQraSuYKCo27+Nvj/cNq244I0s7gVTjj7sQrV1oItePAL1oUgEC+2lDSz8W9dYTGS3mDp7r4l3fyTUquQuXoVF6AGCTZkMurzWXIo8OwSEHJlqxrr1Ifjn5ir37p6+XhoS1tAC5fPhc2umXwek8Bn2I8L000T1a/kkdXrkqwtQYpgHyOH8xBxmAm9fYpdKYWdE6NJ8WvIM7Q6HztyUUxdMJL0PT2rfijQ0jsPlKHdyOse5mBYaq9Ktmv/g2MIqijjEV58mnFlDWDnSGOqt3Vt57b1XGMzKXYejzKJ/IA==
Received: from PH7P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::25)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 17:08:01 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::a9) by PH7P223CA0009.outlook.office365.com
 (2603:10b6:510:338::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20 via Frontend
 Transport; Fri, 30 Aug 2024 17:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Fri, 30 Aug 2024 17:08:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 30 Aug
 2024 10:07:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 30 Aug 2024 10:07:48 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 30 Aug 2024 10:07:47 -0700
Date: Fri, 30 Aug 2024 10:07:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: Mostafa Saleh <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<will@kernel.org>, <joro@8bytes.org>, <jean-philippe@linaro.org>,
	<jgg@ziepe.ca>, <mshavit@google.com>
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
Message-ID: <ZtH8Yj/VBHrzioSH@Asurada-Nvidia>
References: <20240830110349.797399-1-smostafa@google.com>
 <20240830110349.797399-2-smostafa@google.com>
 <ZtHznQwkJmugKef2@Asurada-Nvidia>
 <19c91b5f-e615-4198-b9e3-d0d00084d139@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19c91b5f-e615-4198-b9e3-d0d00084d139@arm.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7eb14e-9549-4cf2-edbf-08dcc9164da2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTk3dnhHdWcrcVNJUDFFdXo1Q09oOXc0QnFRSVFybEY0ZitHZGtxZ0xPUkFR?=
 =?utf-8?B?RmNqQytLc2hyWW5qYTdzdDZHU2hUcUVIc0ZNcGo4bzJYOTc0VGtKQVVUNTBP?=
 =?utf-8?B?MFhCZkU2QVpsRFNzRytiTUJTcVRKaHBteklKZ2FSYlQ5QkRITmtwY3BkQVRp?=
 =?utf-8?B?SlVmei9XWEdZZURqU01KUTJHMjZ6REpIYnl2c0U2eEdrSW1EU1oyNHVKT1B3?=
 =?utf-8?B?cW1lVk1vNHNtYUpXQXRWbUhhZEZSN0l5M1pHcTE4RjVXQS9GeGZuNUNPdDJY?=
 =?utf-8?B?QnFhU1VmTHJqTDQ5N1JPeGJvRnIyZVVwdk5abVU4RUtONVJoMWRlUlBzQXNN?=
 =?utf-8?B?S3l1NEhVWkpqQTRnTTYvNGdDK3ZZWmNxUS9wQy93M2hIanJrVHhRVmJxakV1?=
 =?utf-8?B?NStoKzMzZ2lRQVdwampaRDNuaTJ4MUtxN1RvU3JaZ1hVaUFOM2wveVlkQzlH?=
 =?utf-8?B?aWlMWmJjc05pZ29rMGVqcllBVzF6M1g5dEdWNXNkY2MvYy8xOTlsMitlLzdB?=
 =?utf-8?B?ZDlzUHFuYUlqalNwOHlyVkJHU3VkMVp2bnJGSWxTU2NaL1V4K1RQTWhFdDZH?=
 =?utf-8?B?bzhIM2N4ZlYzK2FXeGEraDN0RDRTNDhvMDBXbytTTHFVM3lLYnBIR24vcTVx?=
 =?utf-8?B?SHdNSTViSkdpME9mSVh5R3k5WTNFTXdYMHJGQUdTeElGUjZTMGFhQmhmNHRQ?=
 =?utf-8?B?d3djZDMwYnc4ZFFtVjRQL053WXpISTZDakdhYnFnNlAzVHIveGRqa3BURlJn?=
 =?utf-8?B?SVdFNWxSMUpiV3ViWlNYVFU1V2wvQ1BPSWxJYmJsMXlJUVBXcDQrN1ZVTkRk?=
 =?utf-8?B?aFhNVWdNQWZSTUxxWE9mQzNURGtuTDRnNFpUMFA2aWluVkVZSEdwS1lRY0JY?=
 =?utf-8?B?eUVadTlHdm11SjFFVGt1cklMeHgvbWw4UndaUTY0ZGh2dG5VQWJVOFg2a01P?=
 =?utf-8?B?MW9qQ2NWRzM2cnpNZTdJSm1VWWk1SGR3R1hhU1dId1VCRzRLQ25US0ZISnhE?=
 =?utf-8?B?ZXQ4Vzhic0R5bWFzeFFxODlYMmdGd2NNdi93NXlPdDduNlZENk5BaWdmTC9j?=
 =?utf-8?B?YVc2aENwVEdlMCtkWE80b0pFOTUzeGpQVkdGVmZ3UGIyMmw0R0RySmdwcHBw?=
 =?utf-8?B?enU0MlBPcjR1TzQzZXlybk5zaC9YTVV2dERBbXcrWGphbmFsMWMrSllYWDNO?=
 =?utf-8?B?bUFRbGJEaDEreU5ORWZvNmVSZE1Eckxhd3R6eUFDQjlydXBRRVpPR3BvZWpu?=
 =?utf-8?B?RHhOT3p5dER3SVFaSmUxVktLb21jdmgxQXpjWkRYUkMxWk41cS9nTGo0QW9l?=
 =?utf-8?B?NjViNmF1bmhSVlEvRlU2V05lemNjd3Rrbkx3djVmUS9QbGVQQUZtQUNMZkhx?=
 =?utf-8?B?UnVmbFV0Rm0yamppUG5QbTU5ckRMWTR1cW92a3hObHdZTmtHeVFINDBQdUxh?=
 =?utf-8?B?TFdnNmJUYjdQMkowSGVxUHFyVHRWa0tTa1FZTUVOZDFlQWFQY2gwODFsNk1B?=
 =?utf-8?B?WGNuZFk4MUMxS0FQdVh3NG8rVEFyQkVBTEJndG52dnYzdUMxS0tRK0lyZExq?=
 =?utf-8?B?cS9TTS9uWkJQUzFLWmJ0M0gzcGFmRlp1R3NWKzVqUGJRTFBKZGFxSTJaVmQz?=
 =?utf-8?B?MDNXdUNRWDM5ZUpqMEcvU2VJem9GRGdvVjBWRjhpenlYZUo5ME9aTU8rVVdP?=
 =?utf-8?B?bjRUcklPWmNDZ3hqa0pRc3F0WU9CTFRyUU5odzhPSXZpb0l2OWIvaVF1MzJw?=
 =?utf-8?B?UTFtMjFmZVBNbUU0N3RGeGNjVmxibFdYdWNhVGZnYnhtQ1hhejJvcU1BQS9x?=
 =?utf-8?B?aWdlSU1YbmNpcUJ3OUh3UTJScHZSeERXYXhtalJKSk9qcVFTU2grSWJjdVVK?=
 =?utf-8?B?c1RXb3NoUDdWMFJ4ellwY1pYYndtTTc3WWlDb1EyNk9OQjhLc05XYy9Ba0hC?=
 =?utf-8?Q?B3PyKcVFhePoDmyKtrKl2QhMnma43Phb?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 17:08:00.7348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7eb14e-9549-4cf2-edbf-08dcc9164da2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181

On Fri, Aug 30, 2024 at 06:02:35PM +0100, Robin Murphy wrote:

> On 30/08/2024 5:30 pm, Nicolin Chen wrote:
> > On Fri, Aug 30, 2024 at 11:03:47AM +0000, Mostafa Saleh wrote:
> > 
> > > According to the spec (ARM IHI 0070 F.b), in
> > > "5.5 Fault configuration (A, R, S bits)":
> > >      A STE with stage 2 translation enabled and STE.S2S == 0 is
> > >      considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
> > > 
> > > Also described in the pseudocode “SteIllegal()”
> > >      if STE.Config == '11x' then
> > >          [..]
> > >          if eff_idr0_stall_model == '10' && STE.S2S == '0' then
> > >              // stall_model forcing stall, but S2S == 0
> > >              return TRUE;
> > > 
> > > Which means, S2S must be set when stall model is
> > > "ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.
> > > 
> > > Although, the driver can do the minimum and only set S2S for
> > > “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
> > > behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
> > > master has requested stalls.
> > 
> > If I read the SteIllegal() correctly, it seems S2S would conflict
> > against the STE.EATS settings?
> > 
> > // Check ATS configuration
> > if ((sec_sid == SS_NonSecure && SMMU_IDR0.ATS == '1') ||
> >      (sec_sid == SS_Realm && SMMU_R_IDR0.ATS == '1')) &&
> >      STE.Config != 'x00' then
> >      // Needs to be NS/Realm, ATS enabled, and not Bypass
> >          if STE.EATS == '01' && STE.S2S == '1' then
> >              // Full ATS mode
> >              if STE.Config == '11x' || constr_unpred_EATS_S2S then
> >                  // if stage 2 enabled or CONSTRAINED UNPREDICTABLE for SMMUv3.0
> >                  return TRUE;
> > 
> > So, if master->stall_enabled and master->ats_enabled, there would
> > be a bad STE?
> 
> Indeed, but as discussed previously, to get there would require either
> firmware or hardware to bogusly advertise both stall and ATS
> capabilities for the same device, which we decided is beyond the scope
> of what's worth trying to reason about. If a nonsensical system leads to
> obviously blowing up with C_BAD_STE, that's arguably not such a bad thing.

Oh, I see. Thanks for the note!

Nicolin
