Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123D175D48
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378934; cv=fail; b=ubtRu9W4THozf7SQpV4A5fIAUDF+47J1i3Jvq83eVdnIWloDoXgGjePvpiRcgGn6DayIYtKjVpJQNJuGfzwt5dwUp+vS31yagH8bChnJXtCM8qdVz8ltnTLW8nPZxy+vBNVgacUssh318Mijjpp3KUlUwPw/xIQ8pSLHwguwOqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378934; c=relaxed/simple;
	bh=X/tFqQ1tFzKjM3qROhR6fr7z5d8SK1IHDKKtQfiYN6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=COUvWmEwb04zlruJJpDVUSCK3pZWu3RuOAKbL20EnhVLceh3uncyn7Z25T4rJ1aCXUiNkJ2PRHislecgajy8NHwAMHafUKDpxS+FyGiV8//kQ6TFWomJzyhFYw+jKOyY2bTehRApOTzkDNJUN7/I5oQzlbK0Jdv1hpQO+nJ0wxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LTQUkXbT; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LTQUkXbT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RLrMi+JnRSUQqWyoVti+P9C/fIoDS01xYQjqWbRt1k7FbJRtplvda5ugxeijOAB17HbuhGoXuniNZIpZCc15WVMTyk5sOiqn0RvYJL6NE7DDuDd1apuc+gkxBXuDTDNrzyoNdHA2kODSWcXuWtggW6v4ODTJtaDOV/op1ZH3BthSG4ZTcJEyLGWnM1gRWNVxr/1W/i92PC5E0f0D2idocd1Zy6ZLy1p3dDJitAU8tGyKOV1EEJ4G4HUmvlYhT7aDQLawULyXBKyMZJ+fZRp1aw5NamrEBFH6XHos1iM19xxvbjzJyjMnDYXN5CHbkBWCLFLi/3rqSW/FFuf49sbzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/tFqQ1tFzKjM3qROhR6fr7z5d8SK1IHDKKtQfiYN6Q=;
 b=pNxaQYW7zvr7tIqiMUe8v35toGk63dZp78y4Nb5OQau2CL9HP+2eotWP3JJKFr9MJ0KPmkJyJjrrKXzG3zYyp+vpgrCccnLMC3m357zvzm+OOFfXgIpYCPtjHvAhVEbKrdRg2rcPjPE9WYaUToSNeTn7CRV9Z30FBgQO5Z+ZbaOYVa9v2+DrD9VXZWytBv1eoXQEj1ZM5Zijpos/WfrF8iYjWBJ0qlzKDWD2CB9IU0100O9GZylaxLiUalur5utflS3Ai/NwY6XZkNeiSEmCyscGbORIArsE0jLxDajfkVVrTJy8bDpNrIxj689Rytgllh7NHJmSgoErxQUf03TNxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/tFqQ1tFzKjM3qROhR6fr7z5d8SK1IHDKKtQfiYN6Q=;
 b=LTQUkXbT8LWBXbvxGdBGFl0cM99a0k0gsL8026cc+2yxASY/2pJKYaoPPOCQBiG1Ms0BL9u7kw2kK/SOgk3jmd1p8RHFeApcyUk6yS0mkgzL7fqaonugq9Fhx4AXtLEniKK2dOupYdVLMKGF+Qg96g/92UJeKGDrLxmhBvNg1eIcZpu1CzMWuzMDeF50Kn84KK3fr/2HKI1IlHu/UkufnDNzHTxMgdRi2exw4HaiR6mhxklh5vmNdkiMl0AxDnOsRplcSNIUuc4BIdGaWlkqreGgU2cHFGxxgHzJyObYk5Wm4ZFBP0893dSfvLsJ2+UTCdC/k3/nTWkleTE+oTP3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 13:42:06 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 13:42:05 +0000
Date: Fri, 11 Apr 2025 10:42:04 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
	will@kernel.org, joro@8bytes.org, jsnitsel@redhat.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <20250411134204.GE8423@nvidia.com>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
 <b62f5ea3-99cd-4e9e-a2a8-cb325308ed34@arm.com>
 <20250411130155.GD8423@nvidia.com>
 <Z_kaprkADtmMLyiH@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_kaprkADtmMLyiH@google.com>
X-ClientProxiedBy: MN0PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:52f::34) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: e85fb78c-c6a3-40cc-6c0f-08dd78fea5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBRjGQWis95/BqpEDGBWcpOjav4YgSTxed2HqMnmnv8Uiwv2yQ2Fm6o5KRaa?=
 =?us-ascii?Q?btOiiGy9S2Mr6EWfPqq/maP1QiLu4Tr94MO361CcsRR9wW+snAGGXZk9MdIB?=
 =?us-ascii?Q?vCIKEttE16yiPLCDsmWoB86FzHDrWCGPqHu9RXgEKYQcuulTuTQGinPGsxg3?=
 =?us-ascii?Q?f9+1sP7fZVsq4rnfp/bkbBn97ZjHxB8MNbXy9JI0ioqYSPnJ+RNAjWs4e8ft?=
 =?us-ascii?Q?aLXtUg1iR8rfKbBvEXcggdPiS/MP524QT80WIZdyPUb29kvqrKm+oiaermkf?=
 =?us-ascii?Q?QFpf055w9E8Vn8izvwHEgvpxcgZ6G2M/DJzwTO+YzjTmQk+rhoReuv8VBm+P?=
 =?us-ascii?Q?CEaxinBWu7Ud9yPivPB1tsLFxOdvHIHR/+Sev/HB4sgQ2AeaNT5PQtxLN86m?=
 =?us-ascii?Q?6SbvaULm27ktWGYIR74hPaNg0XPZdpuYFkhqyWfYD0yfYsfW2tNsM/9gwLcI?=
 =?us-ascii?Q?wF2fzxgHy+qMDtfA1mj05CoW+VJFo96jWo3krkoCevN0f4Ic9f7agyNVgfIv?=
 =?us-ascii?Q?9AVymhPdwZTDeF7r1lbBkQr/t0WQgQjghZFJIQXP+ANnycmEQCf3Hp5nMEXe?=
 =?us-ascii?Q?Dfzz7JYJoIjQfwlzOdQvDm2UymKEuXKsUZp+c8HBOLXQmvEMaw1qxzRiIucG?=
 =?us-ascii?Q?6UxhqxpNlN1gZrjmMF49DHUd2VTiKkO+1MCYpaaWNPxFGYyLGpOH53TYePoX?=
 =?us-ascii?Q?xgDQE95vgkWhgXVKX+hgt5n7IRK4VrawMLlzb2ciRxjbiIAcC87nrv5v91Ja?=
 =?us-ascii?Q?LNPwsnxmXRuMl1i4ks96MrPzv3fmNjAjoSAghRml0BLfUq/GEvUuZKqBCGN7?=
 =?us-ascii?Q?rInLs2MSDwnd5tvEHw7juq/YTuiCSKSwLw8v5OydGeg68HEDiZKo52zqualg?=
 =?us-ascii?Q?TCI48B7r+ta/R8ls8YHag4WgfXttaI99qIc/hbEQgGj4DIqMGNvua07+lBm7?=
 =?us-ascii?Q?XglNifhlbjpk0tsfdkRGNsfAgsJQ5nHXYicDUH5Sc9Z3yKBOWCTqs5ig9L6/?=
 =?us-ascii?Q?Zr7zU/NBwAgvf6UVRO56atYFu6EMylbPsNo2dFHrTXlAMIUF0JZtPZ2/iBaQ?=
 =?us-ascii?Q?olYaWn1ui4iyyY8BtFxxVqhfohX85InWFh1b8YsveDhkhW6Z+MikRjh88Av+?=
 =?us-ascii?Q?XQTQNVGOvteZ2r+SWLYK2xDKieXV5nJPfqtf5bi2laDHaZk1Pc41nsAfYKYo?=
 =?us-ascii?Q?VgHgoUyl+/Gy8iDZ9T6vNSn7vuD/N/feOcU/aB3d0eu2czBDZ71tZyRhU21w?=
 =?us-ascii?Q?a6fVUQyKnQtlmQt0dgDNIhirJkKO47i5fPjvEDLYpJHZyzqqsne1ctkjR9p4?=
 =?us-ascii?Q?Zzt5gSpeLaaElmckmNRTygmE0keCmEoXEesrgdQx0T0nOGg/a5oS78k6gSfk?=
 =?us-ascii?Q?8mmsVeM4DWjzGPPvFYmjHek1dzdedAWyGK6s5w5pLxW56buxdKcK1Q1p4n+5?=
 =?us-ascii?Q?iRuiofXkrDg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?41dCp6XBtm1h9l9qzQGor95JGBOp5jLrq9mezUPKCeRKdhuAzxThxq8Y6ixw?=
 =?us-ascii?Q?Waq7eyA6L+0YlIHmfOOGOGY0OtrfN8ZGOJnis7yPHirYEkuEGJbmmtN9QqmL?=
 =?us-ascii?Q?quPHzJJlgUUOfh4wYi8UmdGEZt2FW19K68Yuc7j25ssOAgs2T9jH/IQoiCDM?=
 =?us-ascii?Q?cwKNbWekiDIJFLZPWyGBdahmSwAXm3HOPs60qhh8jAtzUCcJVWYqd1VeCtp9?=
 =?us-ascii?Q?24dogHJ/jPCMNqPpDTzpWPiNLVJOcnlipEyzEQhR0rQvDZ8+W9lkPgA5FS2G?=
 =?us-ascii?Q?zpmAUAIG//ziN06QPIZPMpvTe/FSmRLk/Rm0xPyiNBZfcK3D/IAIspfLTGlS?=
 =?us-ascii?Q?Yy0sHUrveBr6Q7O1OlWEHNZC/Lm81tFhtNTsxlAy3xpnQRcguQaY7B7D3BzT?=
 =?us-ascii?Q?NaDFmlXB3iArMkWCRAv8RCuZn3Xenb/v7HE7hYpR/BmTgZNBY0V4lqrYedD1?=
 =?us-ascii?Q?uEjgw43DrKfWArhstqK4wRE6aj5EavMjO1g2ItsmgPi3EkXmKSevJiBgB+UF?=
 =?us-ascii?Q?YuTK77e/ozzIUsAfWljlnq2iNUwqZvw58lZT+pcLpFs8IA1xKnpwhI0wL2d+?=
 =?us-ascii?Q?4XoPdruNtqhNhuOBkXGfHAsBJarW5CxYOX76fMubqpEffF0Pt9zRyazsLsFz?=
 =?us-ascii?Q?wVsUfyW0H3Xu43V35/MCdq78FZv31uAPCyFKYR7G8qSDz0rBdH1fQ0oEIhRu?=
 =?us-ascii?Q?4e+4dYAFEcljt9+AkRx7ehjSMUZwog6VQPZCnqbZvSulf2hCOrTtcRLlkqIs?=
 =?us-ascii?Q?sh7peBby2Q+ijFxjmApmW9jVwjQ/dOYSK1e2cIaT0YUuM1a6uQCg0Ik6DWeB?=
 =?us-ascii?Q?2zPXMAYxjix/qU9SdMUyGpNvlIGcAqG4XY/nBc/UCFKOmME3xjjVnhROEF8W?=
 =?us-ascii?Q?N7lj1BHLhkvyqLxq8txa5i+N4kN7TN+W85KUriCS7CKGKmlyKYOfnwaycuLK?=
 =?us-ascii?Q?zvaORGxMuJHOYkXrAhit/bYjObF1+d/VhABhr4ThfEQCnfRguk+E/qvPLcCn?=
 =?us-ascii?Q?h6NjFXuEs2duN8m14G4hxxYvaYyIdVJ29DcJ1CACHhbiLcmvG126MteUe1xO?=
 =?us-ascii?Q?uORov7+S5G6Uo8lTeVGVt1FFkXisD28U8/FxFdpCQ24QWS+MzrjQp4BhX0DL?=
 =?us-ascii?Q?wtAxsiJvDfTmWRk8J7jNqTO1/ayXqLzhI2DQt+6gzihhmUfrXwacA1omYZP6?=
 =?us-ascii?Q?nSu8lOjOC/YfU7QB44k5bGaetAwePh3JH+dTvITmZx8STYR0i8JLwr3qSo1I?=
 =?us-ascii?Q?q4tbIKJ2v8vyd+0p2/0XcBXWEWdQNQATOzHm3BJFt1FRkhgWkr014iJD/DK/?=
 =?us-ascii?Q?OBf6IWse7r3wF4LUU1Ra7vA9cE1UBO0htmc5UYeAbyAZ2Qh40IET6+4XrKur?=
 =?us-ascii?Q?mkJB9P5pL92JeRjMAn6B7zcAF0V0WUDtwfCqwpGmWRAb0emJicg9CoVq96kQ?=
 =?us-ascii?Q?GTvaBNxfOTcbQtKTsErCJUW3OrMFLreTYCMS2Qqr1wpZpVHX3KQtsoLd08aC?=
 =?us-ascii?Q?afQlsdyN13VyOORq1Uo0/EzcCzcPHnkEtbexCQGIxMEf6JbvSSq7nOvT2niA?=
 =?us-ascii?Q?G0mwX7/muNcJbL67ooutTd+Sd0WtodFXjCcDXDfe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e85fb78c-c6a3-40cc-6c0f-08dd78fea5cc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 13:42:05.7718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA7jqtZrfWrOKbWTMKUlRqGmVhFUmrau6odzp0MuACVYDlItFlvpsMMQLppSA+kK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

On Fri, Apr 11, 2025 at 01:35:34PM +0000, Pranjal Shrivastava wrote:
> Isn't the device grouped *after* the ops->probe_device call? I see that
> the dev->iommu_group is assigned the ops->probe_device call in
> iommu_init_device.. so I guess this would still fail?

Yes you are right, we'd have to also change to setup the stream table
inside the device_group call back to validate stream table groups are
the same.

At that point it is probably trivial to just return the group already
in the stream table.

Jason
