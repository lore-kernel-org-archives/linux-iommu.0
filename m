Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D930F7F0
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764604462; cv=fail; b=kXvx6HSY7LE/ZBloYrXSD/6OnxLXxJsdAB7BxcwRGGkA9FZAvwo/I56DoGpNPxTJTs150jg3UtF29quvUX6+bu15VZr6vlBqCxpPdAU/JT4I3B5uThKGAFCDJLfqR1mg0yaivcaMJzmrxuacuQfEH9NGDmIMGq86cIXlQioE+Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764604462; c=relaxed/simple;
	bh=zJI7FreqnlTIoHsvnNnpOlMnuppPXYHvFRB8vsRMhMw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Prt0HCKiXrBu5uLN8qVgLGuTFiQDLDHaUnNPd10Q/59kYgF3UceNIsrgbmvyjivMbrrnDnAZg+FxI2WAZVi0ECfWLNRDkMbvw6D9xGDJLcqrvbO+M0XCeTl4bI1dZ2ZRl+gG97GdcDbWDzgDjbYvYvl9ERnKb/4jAoARVsR0xsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQh7FVmY; arc=fail smtp.client-ip=52.101.48.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQh7FVmY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLDdrC+t4/GQRzOnYnOPV+xs3N9EjN2o0bYsgaXIfHNBj8bO5DMUUCHY/16RfCkxN3Aqp4QFou2qsIK8Z7JAr6xojVx7IysRJXegQGArY9nkpnLpdyLgDpwgpZgjwZk7KV7xF0egniu4YecMy6G2BKKotkxfHzPgj7vlTDlDrq2YfiaRWt1cnbqYP4MYTbtfm28KplOlwcMrmZmTUM87B2S5D04wnXIxR71wwPdy59m8qFz6owhSD9v/RF2NqD3IUJUQx94X1qLifdoj2vMvRk3lpbDx7+K8VrsZhwHl7fp3C4WFxR+LV7J28ZvmQRj/P7P45nPXfJVHo1SlMJfHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QXzObpXTJdSCFODEzgPh1Yq4Hs2svxFg+WtMONlat4=;
 b=AtZNdMd7YpGujmZqy3SJHHSHGyhyMXn4oQRfkd3WMfjKJLjj/oiw3J1dA9coimh9uc2Yn3omrzqtWJ1rFpEktnddq/dgkIYHPlJBoLVnox9lHBk/A0QMj0BfDQM3l0CbvnQVM8k/KKRFnHLMH/b9bdHlCbgeYTAdisokVESXtnaP4rdonHVt5HIcdrufHwULfUuMD/opqgnF5ooKdqFiK49WmFsrWUNoj1/y5n3mRJYjBbrE1bC+eluop/NIOfmZvmyCDothQnthfUNEyzxfL8/38s1e+xpQyTUOAnR7fwJ7hesQTAAPx4w9zoKhbq4OMbfPL+B5GGkl2yNmfyCVQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QXzObpXTJdSCFODEzgPh1Yq4Hs2svxFg+WtMONlat4=;
 b=mQh7FVmYi0XJNcBq+QJE3DiGC6WDkjKUSf9gz+hLbd2e3YsbatyXZ8wc1jZKl24I7WGQ2V62vwc4LhySdGQFROGQELC/PUEJsOz+NfpRwj54tUrmzJx/+CrTh4isLW8zHTTmZ6IQ7MInPw1YtTd3WB2sKNr5RHUI9j6C1IoBi01CA+/zoimr3bU81rxe6hg4CwoJoZDQcClei6uasdqJN/tiss7qffTqBJnSs+i3ZTh9v/+JdaWkOJPsd9h8djpDBbY46gVkeSB5wXmzZV/BWefI+IJz2hpvKaVxGHznBGx2QuIQ+8yA83AAvEli1rm6XscO0gQdaJbkdpvYWRKGBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 15:54:18 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 15:54:18 +0000
Message-ID: <cfc91cbd-e5bf-4e1c-aeb9-795e5b621910@nvidia.com>
Date: Mon, 1 Dec 2025 21:24:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251125071659.3048659-1-amhetre@nvidia.com>
 <20251125071659.3048659-4-amhetre@nvidia.com>
 <dff3a962-82dd-4aac-ae11-69f0e95ba04d@nvidia.com>
 <acae92d8-3394-436c-be8e-8bed7a923e85@nvidia.com>
 <r2mkiktazyn3nvhirbs2ac7n5ymdw62ueutpxt55cnivdi7pdn@6i4hjtvxp2ph>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <r2mkiktazyn3nvhirbs2ac7n5ymdw62ueutpxt55cnivdi7pdn@6i4hjtvxp2ph>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::9) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|CH8PR12MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea0cf4b-acf6-49e8-c833-08de30f1e24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1UzWkNrc0NFVnIvdThXejQvcEo3Y3FQMEZ4R2U3ZktabHA3S3NsM3JEMHNr?=
 =?utf-8?B?c1VROXRJRExmVktoU0JabWdTRWF3bXlhL1NXZVNWMHQxTHNoRUlXRTllN0ta?=
 =?utf-8?B?SDZYSVpEdUxhVWdacU9UNWtKTURHOEY3SWdDUFZOejVlUmhpWHBVT0ExL0Rk?=
 =?utf-8?B?eGVXck5oZ2plMlZlNkpyMkRVSFhSSHd5UU1hUGtLdWduMEtIbWQzVTQ4ZTNY?=
 =?utf-8?B?cmJkMVpQSmZ2NzZlR2h1WWJRNnFJSWhUNTRWZENKU1QyVWE0bWpUN1FnNHNw?=
 =?utf-8?B?cDVLdzgzWG4wdmltcW9NNlR3eFZOcUlmYmdUMHJNZE1vdFdyN2Vmc3ZOUmRK?=
 =?utf-8?B?bDA4aThQNWZYVlhQWmNOWk15N0x1WEpLZytIL25yUUd0eHFETWtjN0JWUi9V?=
 =?utf-8?B?RkU2QXRQNEFEelJJSnRTNFlGRkdrcUQycjh6c040ZGt1QTRlb3l3UFU1U0h4?=
 =?utf-8?B?UkpHci81ZnN0ZjNROFVlTkNrOEZleFJnUEh6azVqekIvdnI0R1VLbjkrNHBz?=
 =?utf-8?B?ZG9ZL1JIb0RQcHRmanZUek1jSmRydnB2TTJybzBJM0lmTjVJYUxheXFkU0Ns?=
 =?utf-8?B?empYL3NpUFV6SEJRRlpla2EyNkdlSGdpenVHWjM3TEhCR0FtcUY1eHBlcFV5?=
 =?utf-8?B?azd3ZlJkSFpIMnNQQ0x0b21MUkx1b3dxVWxyYUcyVzFEdVJRUTN6T0RSWHpr?=
 =?utf-8?B?TFNuUEZvcXNaQm1qYURzOVVuUGtpanBiSzdCaGlFN3NCbmVXS3NKZVp0eXk2?=
 =?utf-8?B?THdFMmcwRGJpWlBjejM2WVVSQUpIZ0orREk4ZXNFN09RekwvUDVBS3VWMUpq?=
 =?utf-8?B?Sk8wSWxLaUcvVHdqSEdVZDRoTG1ueVFtM2tKMldjazRMVzA3NHllcXUrSlZ6?=
 =?utf-8?B?dTJCY2ZJbzk1cFhZRXN1dUhxQWpMZEgyL2EzSm52YUNjRFJQdys3d2taK2Rh?=
 =?utf-8?B?RHJGSzROdG5MM2pvVENXdWpXalBkZ3YzTVpCWFBRRTQ5cGplaUtPS25ZN0xl?=
 =?utf-8?B?eXA2NGRBQ240Y2pqdU5EM2VSUytOeTFuUHNxcTdxbjF1Q1VaektDWDU3a0JZ?=
 =?utf-8?B?eU9yc1NEZEpWOUpJU3B3cXVSN2ZrWGVDUVRqcXd4Vmp0VVFpaTA4eHc4MHhH?=
 =?utf-8?B?akMxaER4K3NMUUtsTVZOWGdlcUh2UlUrakhmMW5kWFQ2ODV5THJGcmlXWlhM?=
 =?utf-8?B?RDJCR0xrdGFmUDlGTWFSYzUwUFN6VFFTMnZ1aVpJeWhHU1FKR1VMY0Jjd2N0?=
 =?utf-8?B?aWJIQ0NBUDNndDZRbExLYTFIakdkaDd1ejZJTGRtTVpkZSt6YXBCc0EyMzhs?=
 =?utf-8?B?RjJLK3pqSjZWdmJCd2pUMmVXRVNHWWViU0cveHpYUjE0MGNqSWRlaVNXRWRK?=
 =?utf-8?B?Z2FmS1FBM05qVmduTmNhbm1JZjA1T0VQNGcwUnZPSi8zS2NXT3FvTTcvd3dV?=
 =?utf-8?B?WUE3SkpjalFTYk5mYy9ZRCtSS3NiMlFQT0NmS0JHbFVwM2Rrc1V5OUNVbzcy?=
 =?utf-8?B?eXhMS0tyVlVyYlhBYlRydFRtTjUzN0haZEVmUGF4OU45a1BWWEl2aWppK1Jl?=
 =?utf-8?B?WG5MbzNuSC8vdU1TNFl6TUxSZmFQVWNCTzJ6ZWdZbS9meGhMZEsxbC9FMUU3?=
 =?utf-8?B?andMbUMrazNIM3B4NzhPV1pVSFduOE1UUUo4UTN5VStxVGkvM294emRxUmZm?=
 =?utf-8?B?aTlCRGFjTFZrRWFGTytVTHpHWnMrRjc0T083NjVSQlBKMWFCeFljOHIrVi8v?=
 =?utf-8?B?ckp1cXRsTG0zOEJ1WWk2V0g2MWdjalpXYVQrVXpyMTFMaUpjMnQ3SHloOExp?=
 =?utf-8?B?ZmcvSGZXRE1mdGs1OUFEOS90eHM2bzZhZCtFMmxLU0NBSnkwbzdhSFdGVWc2?=
 =?utf-8?B?WE93QXVGaWxDbHV3bC9wRGN2RE91Ri9YZkdjK2swYU9GSmEwVHRhSlkvK3U2?=
 =?utf-8?Q?w9GRfS3uesKNP10fm4fUgfT6NuYC88ol?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nit3RlVGb1ZKR3ZvQkJXZUd5aml4ZWh2NzBuK1FQelI3eW9aQ1hDRXY1Zito?=
 =?utf-8?B?VlEvbnBaVUs0ZkFKandMSFVZc2d1OHdmYXdYUDZ4WThSbUwxRG4rd0FlZ3U4?=
 =?utf-8?B?a0ZVZVNqNm5ESnc1ZjhCY3I5Ni9LKzkwbFVTSkM0YTh5OXNlTjFpaVpwbUJv?=
 =?utf-8?B?M2k0VlNmVFhzR1NEeHN6b2NlMzMyUm1LK1p5MmJlekVtZEpkMkUwcWxJNkx6?=
 =?utf-8?B?cXA5Qm5ma1d6RW5VT3VNblcrRjBNWFhFZnhkRWJMU3hxbmIreldzbTNBcXB6?=
 =?utf-8?B?UW0wRGJHQ3JESUpqS2NTWHhicXJVVmVoWSsxVEZjZkxrdFErQlJUSU5YNkg2?=
 =?utf-8?B?Z2NOWGVuVjBvdHY1T2U5NnF3bU1TQXBRK3ZKMzNoMlU4WlE1Wmh4MzNpWHJV?=
 =?utf-8?B?ME85dDhETXhoV3llQnh1WnB5eE9FTVl5QTFMQ2FTdlpQUDU5ZjlSQlE5RkJs?=
 =?utf-8?B?Y0JUWnhyd3paK2pJM1FWNmk4ZzFiSm1Ca1NVd0k5WXhFYzNYWTI1RHErS3Zr?=
 =?utf-8?B?ZWErM1diTjd2QzhGK3hTZ3hJTEpxSjhWcjN0YW1LZmw1cnRiWWVMazhsRFh2?=
 =?utf-8?B?cmdNUW5rRnMwSkFsVTFjSmNRQlliV2FnQ0xKaUNmSTN6Y2tXZjdoeE5GbEVr?=
 =?utf-8?B?K1VBTUgwQVhkTDZJWEZ5T2lNRkwwZS92cUE3VFhQejJWU0w1Nk10SkJoYmov?=
 =?utf-8?B?QWhoMk9BbzBvd25TSVhNbmJvdHY3eHlubUFrZDlIUlJobTg3NjM2Z3hyZHRE?=
 =?utf-8?B?SVQvTTFqZU9BQzl3QTZhdE5HN0t5TGpyN1oyRU84cURlQ3pGKzBUdU9hYTdk?=
 =?utf-8?B?dUxjSHh3dE91Yk5mMDQ5RGU1ZlllNi9aOStJdWxtVDFiYmpqVWZ2TVVaVmMx?=
 =?utf-8?B?TlFaWklPOVgrL2x3Rjc1d0EwamtvTWE5ZHlMeEtoeGRLTVVjYkI4Y1Y0Z2lr?=
 =?utf-8?B?UU5SSUNIZmNoNTVWUnZwUmNQSlZtRU5jaE1WYVZsNnRMdnBvd3R3NGFSYzhD?=
 =?utf-8?B?bXdiVmZNNTVHckE4bmQ1bjQrQzVMbFVNcTRKMTNSUldVNWR1NTdxdDdkL2Ir?=
 =?utf-8?B?SGZQbWlIN05XWEZ4VTZHQ2p6TnYyQlFTcFNjSnBZeFZuanpCaVhuZUtGdGwz?=
 =?utf-8?B?U2Y5dWt1MDhsVnBXekY5d3pjdjlCK3B1NTVtcHUzZ0xLUURjMENSYVNUUXZZ?=
 =?utf-8?B?Y0grTWxZbFZMRUVFTHhtZHZOTXg5bjVTZFc3V0o0MW0rTmlpaXN0T3V4a3JN?=
 =?utf-8?B?QVNiYW9VMU5ZZEJCYVVzeVhTQkpEYWtiZVZiOFZYZG5vaVBlMjk4SmRZellN?=
 =?utf-8?B?ZjNxcDlhRjFwejhXUCtoY3lBUFZLUktqejlUT3dEVUhoZW95eDJvL2N3ZE5I?=
 =?utf-8?B?eDFOR0wrSUkzaTJidk5xYXg5NkhvMHAxckhGNVExaFRQcmEvcmVsWnZnRk9i?=
 =?utf-8?B?R0c2d1VzNzFMVjN0WDBWYXVpa2M2YjF2Wnd6YU5PeXBSLys2cnB0U3VIVk1Q?=
 =?utf-8?B?Z0daa2JUWmEvbE5YZnF0NGNDNVgyWllubTdrRUlVOUJ4WU5kWTdjVGNBTDRV?=
 =?utf-8?B?YStrOEViMjVZVkFjK2lScFpYQWNVSnBpblFVK1JZSVF6a3hBVDdyRHBsQ20z?=
 =?utf-8?B?dFIzNTVZVHRPd0hpbXF5Ujl4TkxLVnpwOUczdXV4WTM3clZoRGRWQ0ZZSGJm?=
 =?utf-8?B?blpEdzJKMnEwcTB5VWdMR3V3YXRPdk9Wcm92Vld2MGllRnJTQ2tyMUVpWUor?=
 =?utf-8?B?SmxyMzVnUlAwYVYybEUzaWlPUENlQmF2WHBwcmRYWFgxYmhuNmpVWlJsMEkr?=
 =?utf-8?B?SHJZR0dPczUxd2dhLy84VjB0eUhoQnRxZDRnQVZvdnpOVXJDQmhDVmVJK0Jp?=
 =?utf-8?B?Y2tyZzJtUXNLRS91SHhtM0pwbXlRNWh3dE1iYkptUm5LL00xblU4RFJWdDQ3?=
 =?utf-8?B?VWx5M1F6Q1VtTmcyZGJWR2VBNjNoejRENlBzK0dncmN3V0RQbjV4azE3aHpn?=
 =?utf-8?B?WWR5ZjM3VGt0YVBOS2g0bnkvdkh0SHFYNXpzaDg1Ryt5S2Q2L29iMlJseC9P?=
 =?utf-8?B?c21xc1Zmcm9iZUUrU05OaDZoRVE2UjBEUzlhaDRTRkpNZ3M0QjhHb01TMzMr?=
 =?utf-8?Q?jVOeuGaZjoEbfk8FKvKR6Opvb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea0cf4b-acf6-49e8-c833-08de30f1e24d
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 15:54:17.8252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmA9b1A3+3a0lA8wa9C0cfpDAEkoFjVHTyy4RggKhRuYyqJn6F2gF3TdPmpHBcZGg6/39UMyrTSsk6eBdoYrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9766


On 12/1/2025 7:41 PM, Thierry Reding wrote:
> On Mon, Dec 01, 2025 at 03:06:55PM +0530, Ashish Mhetre wrote:
>> On 11/25/2025 3:52 PM, Jon Hunter wrote:
>>>
>>> On 25/11/2025 07:16, Ashish Mhetre wrote:
>>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>>> virtualizing the command queue for the SMMU.
>>>>
>>>> Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
>>>> CMDQV support. Add device tree nodes for the CMDQV hardware and enable
>>>> them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
>>>> instance is paired with its corresponding CMDQV instance via the
>>>> nvidia,cmdqv property.
>>>>
>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>> ---
>>>>    .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
>>>>    arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
>>>>    2 files changed, 58 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>>> b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>>> index 06795c82427a..375d122b92fa 100644
>>>> --- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>>> +++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
>>>> @@ -26,5 +26,13 @@ iommu@5000000 {
>>>>            iommu@6000000 {
>>>>                status = "okay";
>>>>            };
>>>> +
>>>> +        cmdqv@5200000 {
>>>> +            status = "okay";
>>>> +        };
>>> This needs to be ordered in the file according to its address.
>> Hi Jon, Thanks for the review.
>> cmdqv nodes follow same ordering as its corresponding iommu nodes.
>> I have added them immediately after corresponding iommu nodes.
> No, you didn't. It seems like you sorted by type and then address. But
> we always sort by address first. Type doesn't matter.
>
> This node belongs above the iommu@6000000 node and after iommu@5000000.
> The same ordering should be respected in the DTS include.
>
> Thierry

Oh, I got it. Thanks for clarification. I'll make these changes in v3.

