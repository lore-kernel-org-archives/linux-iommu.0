Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010015.outbound.protection.outlook.com [40.93.198.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AE4BD119;
	Thu, 24 Sep 2026 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790278929; cv=fail; b=XTKlG0lIjNd1sAqeM9b1bVa8kb26IxYJl0KtDB5GKaKNn1YSUmB2rqyfdEY8k5mzCzg4a16J8zxX+/+3HsoSNzmIBm+8EUJlwFvh0shTzOc+LUlh+VOAYkuAcA6qEHaImA0SxlSQjuAkxFP3/uQnr5LsKV6W9ge1Ma61XKPsfZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790278929; c=relaxed/simple;
	bh=gb4VU0PC4e4cI0+KF9upF4Jw8Rq+rXV2EDFSFv/rBpc=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=T5f9d0NsHjc74EKRHOexdj3a331EDr9AuLMKm3AwdWHORPRGgh7OHwmalmAYUmhYx8MAItfSByL4e6190mJYn26E+yCQqXw8DXMse7MQgqasLslIi0cwPCMeQpK0xsTPQdqY2wWy8LF0T3ofZ2I9yt2Vibl6VN4DNBR6lRR4QMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZqXCZCs; arc=fail smtp.client-ip=40.93.198.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZqXCZCs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtS+sto2U0XE2HqMDTiFiIeNliBcmhj8Oka2RqGRdcvfL7bJ+Uy05HLzAzyXGxpq3qDFVU6oeXJRDsqQi8gIUj4pZKJcP3z8Jim/0f1kCV1IYki+aLnb8Hgy5xi+b4uiRksCft0leiqqVJYZ/Mv02xR/6BUR4TVEq3VpoB7sulg6AtFUGgxuI5t8PeInXqsf3UO2IyqLyzCxycC5aDBoyRzoFZyYTNefH6dMBYZ/217przWF77Wy47YRbD1x+qQyKdzd9c4q3P5MWM8XK5gy2bF9Bxjh1GHSZpP61Mt7trtVUSMPhjr0cpLW1WEOkbBmz14XjihK+US7sP8TtA9U1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmAGenZeB6zBJu7KnGJXJegHCjXsDV8BJIeKV4X29EU=;
 b=vatKLstVvxU2DLuGRZ1RSGH+BctfsfHNubpe3O9K1o725x3D2uwok2mnkkW28p780b0s3kMaa6BGmKGwQNCjEF2s5PzwAb3dlF5e+ylby/9FbxLA9r/T/IrX551RCZ9jbQ2ReXimC2QhGpLtideluYcUwo1Jn6HICDYGo9O9oII4ncghjpXngmJZ5ooAISLicQRYTmd+8UVUZyKSszMu4NvmDfWDauk4JP8lFzQ6JqbjqQndYSlbinrDPj4hH1fDHI1VtYhdI3RXfpuoZ90bbBsI1S29sDhdOLrRsCsaDv0T/9Vwz6212dAfIldFWDqj07krqOGIRXny5b0elazt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmAGenZeB6zBJu7KnGJXJegHCjXsDV8BJIeKV4X29EU=;
 b=jZqXCZCsy6RtDUVW7Pb9ICx8ybczVDwBtFUn3PMQGlCzjuzHdAITctT22MRTxFCDp6cn2bgHi6krKgVmSfO07z2vHBoljsdr8lAiJedJ1dYe07cYeWWbMFqxcbSGquvmPiuEAtIrEXV8FuqM+0sFUnBKzqtmuf0OkP0pkk8V7qALBeO+7HUhjvqY9NFEPlPxUonm4wF7ldl8xYU/+aQ+Jrg9O4ADo4SdpbHxo+6p5J+JVNG0TlvRw7aNA6tv1rRHChfaR3GsgZGS4Y46crohYC6Dkzv8WekrNcfrXI2R3oJ1reSZEbFVFnKXLWv+Y9eEtY9R/jU4X/j8AmW6HRJ9mw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SJ0PR12MB6783.namprd12.prod.outlook.com
 (2603:10b6:a03:44e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 19:41:57 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 19:41:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH v6 08/11] iommufd: Add vIOMMU provider support
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>, 
 Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260917140159.1163281-9-aneesh.kumar@kernel.org>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-9-aneesh.kumar@kernel.org>
Date: Thu, 24 Sep 2026 16:41:54 -0300
Message-Id: <179027891417.104879.5995584402952067518.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: SJ0PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:a03:331::21) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: d63f0767-57b7-4612-1492-08df1a73e4e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZWYtjAaBDtWS/PjNpww0eN4F31yIunjS9qghkDiE2f8aoVs0PpUJtyWTTAKrLDKq1cBco5p0Yb1hn48XZSUcbUu9A9I6N008iIjPSBA8tOLOMVHgro+hG0dsReGQvNz+dIGgDyPNt16QIu54fVUmoGYmx4rvg8DR+KhALsLF62aokT2t29tewZuLb91zI6iKj4VlRRcreZ+D1KArue45lNwcYljQaUhHyb9tmKYKM5dG54n9vx97Prv4DeUcuGjvllSGciWLOxVfMITit0Qg4Eap6+5hZB2k0FdcfV9WLqQTX0CwHAXLT8n2gh7SIAJ/WUljT1Qvy1il1JnXUhKHhtPxMjmwByin6H9OUIu28oPeTdOtH4ijc1vPCr7wuTUZZMEoC06S1PCV6Ubo2ycwi3HgMIHaVBVaB7+N4fA44E23Rfv5A4wyTEEexjKYpsmYxrCgX3h2LTwH8j1O849aJEdjIbfaAXZ6abRclcjnnewhymvitvGnqu+YdddYjhd5/KkPB77I2W6lYSS6oIVlV56KhfguaWPHAczY+8ynkkrai43nwTnuTOfaTZOlUG+9loLX8z6TOCFeIsdP6qiQHcTFytP1R8oIyQ+B/JI9vU+fVNFIIVKpSao8HZF+S1Wd5yR3S4BTh2zp+j5MRUNYnMV1jIZ08nT2QCZ80zfiNpc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVg1cE9QRFFJYk5lV0ZXZWR4V2V0NXZUSERwVThSWmFmK3hMUE53YURyelR5?=
 =?utf-8?B?ZUlrMEdpV3hNdnRId0ttWnlpRVRzTXJxMXg2bXhkaGVBYXRBWXlGTzRkT3gv?=
 =?utf-8?B?ZHBhZHdlQnh4b3pVNEZVSVZDVEhkZURkMG1oRGJ3b3dXb1ZkWFlCb1JQWWtv?=
 =?utf-8?B?ZlI0RVFyK05tNmZqMnUxejlhR2RHQU1pRisyM3dwU29KVVpVcFlwSXZRT0ZK?=
 =?utf-8?B?YkJ5cm1RdFJBRU0vb1JFUzBySGR4UkEvUGFrWHR1VHFkSXlBaGh6ZVpmZzRH?=
 =?utf-8?B?OTMrM3FDUUJsZGFDYUt5NHAxY1QxNHdVTlY5dHFTMFRiVzZ1S2ZNZDJZdUVm?=
 =?utf-8?B?dzJzMGtlb1g5blRQRE9abkowK3pFQnhHY09ndDFLeUozTWNoTDEwT2lsU20v?=
 =?utf-8?B?RHBTK1B6MGV2OEtGWmRMN0FaQ080VVRQc0pTRnNPL0tkQ3E0MkRGaVZVTDly?=
 =?utf-8?B?YkFBNFFZeGp3QTVQL2hRZEkvalZPM0J0TGxMNkIvQmlmM0FDc051VmVKVStG?=
 =?utf-8?B?cHhGeERIdTFSZTZIZ2lPVkxtM1hPRXNXZ0lGV0s4QjdKSzVpcXBIRFNvaDlZ?=
 =?utf-8?B?UjFTRlloMm1BbDhEZ0tBUHJ0YmFjUU5KU1U2MGJrVzNxNUovVnZtczVsR2Jt?=
 =?utf-8?B?cTl5WlRScHNiVnh1RWcxSnRrT29GOGZGazUwNFZTd2kxc3FsVG0rck1lUmlo?=
 =?utf-8?B?Tm52Vlc4WDJRMldXa0NWRWFoUStLNzFqU2p4NUFoSE5vOFZXRExOWkE3YVJM?=
 =?utf-8?B?bHhXQ0YxOHNZYmxoNDBQakNsZ0srRVROM1pCWnMxNGNVMlQ1ZFRVSVVXUlA2?=
 =?utf-8?B?d3ZaMm5TajVpZ3lTTFhJWXVmWEJ2QngwTWJlb0d2Tm5Sd25ZY0VWQldtVlNH?=
 =?utf-8?B?SWtZbW1xb01ERVVoWjVHc2tiK2VKSTVQK1NHZndRZUxLdzRnU0QrMFFzcnVR?=
 =?utf-8?B?ekU2Yy9FMnZIUVZka1ZYeUp1N2E0K2ZPaVBxYU9PQzUvMXVoczFkYTdYeGRU?=
 =?utf-8?B?YXF6MU5NVWFEdFJuZmRpYytJSVhab2Z2ZDcwVjcza3l2L2tYaWlkTWxpQTdm?=
 =?utf-8?B?LzZod1RCN2dnTHFmUTJuak54WUxjQ0l1ekZIMWxaL2hSM0lFMVRhV01IYmRM?=
 =?utf-8?B?QllWd1p6QnQxVkVIRzB2Sm14alIzZ3M3Vmx6WmluWEdoN3ZhY1BFMFN4MkY4?=
 =?utf-8?B?NERsNVRPQXdVSjd0bHdGNGJLejFTTlVsWTUwRkI4YmZ6dXg1dndsVUJtOENh?=
 =?utf-8?B?TzV4YUt4SkxtVGlpT05heUNHYkhwN09pbmgzTXFpVkVBR084clpLdVZNM2JD?=
 =?utf-8?B?ZnNLZVN2Rzk5cU9LaG1qTFNsTlU5K3FWaFBBaWN5VTVuUk9qSHNNWTZtdTlW?=
 =?utf-8?B?UE9tMUZIVWZEMG8xS0kyTzNXbWN3L1RMSUdsMmRBT0QrRHE0RmlYV2VJU2Vi?=
 =?utf-8?B?WU5SSDZUZHFxajNKOGN0R1lmd3lNMTR6UW15b3ROUnlGQWNaWU1wTXBETzIw?=
 =?utf-8?B?U2ZyZXJBNkNYd3k3MG1PUElWNjcyL1hqZ0w0eXg5SVdJUU5wWitmYmEyTHN6?=
 =?utf-8?B?MFBma2ltQmlTV0ZBdmNiaEZGRFhJNVc5QWpUd0Z2T21qRW0vKytRYjZJYVRv?=
 =?utf-8?B?bzlRajlXbCtQcytBZDN4YlFYcDhjWWt5dlNWZmRxb2VvSXBpRGg4U3hkengw?=
 =?utf-8?B?bWpOMnJnMTRlUEcrbkkyWW01bU9DdDZLL05xeEVpbmg1Rk56cXZGSjlSVC91?=
 =?utf-8?B?UjB0bkdaRE1KQUhJSUlicUh1Z2dqTjBBU2M4T25iKzkzSFpQVjRMS1ZKMWxm?=
 =?utf-8?B?T1p3TnkzME5USDREMGxlK0EyWmNwY25xVzRoVUVFU3p5MDFwUytHaFdIUVoy?=
 =?utf-8?B?cFNOc1IxeUxhUUxVVHQzSnoxWTc3TVJhVDNKcDdlRDFhUzNUd0lUL0MvbmV3?=
 =?utf-8?B?QzFGKzk0a2ljeTFJQi9Sd1JxdmNXOG81a25GWnZpbStOWnovTjlnTWxWSHN5?=
 =?utf-8?B?dG5DTHRTa1FPMGpkMk1WTW1pL01EczI1dVRTS2NHWjNzTGltQnlzWlZaQzhr?=
 =?utf-8?B?cFM5VU4yRUV4bVJSM3R1OWtFZ2JPcWh3d1M4ZCtFZ2VMekttY3lGVHgrb3d2?=
 =?utf-8?B?aDhMdi9uVnVFazZMMFlpTDZ1SWZQTlVGeUZENVVIUEVoQmE4aU5sKy96cVJW?=
 =?utf-8?B?bnNMK2QvL0YwQWk3Y2pyYnVTaExrb0pCVGlkbHhxL1pUZVhoVCtjR2lXaEcx?=
 =?utf-8?B?MGx4eTZGd2tBTkFMZ0poT0tuVFI0QzdMOVhGTU1wdmE5Ni9sRzBXcWZTT3FW?=
 =?utf-8?Q?YMhBKbVEdzEbSC55gO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63f0767-57b7-4612-1492-08df1a73e4e2
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 19:41:57.4439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAF2gAiRXdOqIrB+cJLNzZPxKA9bQA1Eg2D1Bs09X4FRUYgMj14NucitPtMBpWGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

> vIOMMU creation currently dispatches directly through the physical IOMMU
> driver. Some vIOMMU types need an implementation supplied by another
> subsystem, together with private data whose lifetime extends across all
> vIOMMUs using that implementation.
> 
> Introduce a vIOMMU provider that associates implementation operations,
> their module owner and private data. Allow one external provider to
> register for each non-default vIOMMU type.

This seems much more extensive than I imagined when I proposed this.

I imagined you'd just have iommufd see there is a TSM attached the pci
device with a function call, and check if that TSM handled the
requested iommu ID.

No need for a registration system because we already know the only
possible TSM driver that can handle it, indeed a registration system
makes this more fraught since that key relationship is no longer
guarenteed.

-- 
Jason
