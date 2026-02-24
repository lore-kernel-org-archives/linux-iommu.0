Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EAA36681D
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771923372; cv=fail; b=O+IZMVei7DbvXDPapx3Od3EwLBbXmZoX92HikUy23JivyHpxmrybdQXSTVvRlUX+3GOVKGCTL1W1MGridse7MDhnd/52cCWXgkAbLuf/xPlpA8pp8QaRs1HZbJf3AxDVCDZ6u7k7uMcWNsEE24dMZCxAJ92dit1XKNq6lsMTsWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771923372; c=relaxed/simple;
	bh=Qn9o4t1Kz1RXKKvlVTTxRHJYdA9FTUem49nHXkChnAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EE2dvJn7nBn/rhuTNe9Ayqi/0Tw2B9rJ1NywZaKRxSwNWtBxs7ecsV1MWzxJBN3/IBB0XaFf16DbmjMSgeisDJrzHMPWo5ZfkZk+b78gwhELBGTAzcQSrwA8Z+eCJosZ2Zu82wBfFXL4rciCfsBI6+xVRkpOciXmASonPwclhao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lxA9ARYz; arc=fail smtp.client-ip=52.101.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lxA9ARYz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5o6kamy0LLA09atI33UQI3nDjVQLLpWs2UwlEKjdq3l2JvHNeQ6odr913vqGWQH3SOb7D803S0COaYcy8/25l87y/rx2SivprlHakt4m5GRvfryTjDwun20V7XnrUPjqCYqasRVFbvpju01HkH9ahIaNIPdRa3wPOKoFI+hO4DXQsM/u28VzA8I58TI0eC6noIZh3ln0URLs0RpqslKPSJZQ3A80X3b6pkMWr+NOVp+SadAzPw1KDvToYjt82A3K6UXBLFcXEPEig9ZJMb5/pR/7u3apM4FooF5RruMfYDwzg0nT3WWHxuXPQyIEiJHaN9xUckrKyWOICp2E7wqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf4Ch7MLav8lo1Kb4zexUBgjMWOk3uys1LmIjbUwtCg=;
 b=EjXA679RWKUIe8RKJGuZvriXN5PhKAkviualZ2RU1YJKq+CHIknpYAUsMGlb3Qec2ny/3Z7PG7dgtenN43Cssc+d8Vtt0j3Nd9ZiWZVG6E131mFEGAcKN8PAePaS3BAhj41vg6WAsIWNvBucbCS5Z5l2b8kCNhmtbu4BB2R+KLdG6T2PfeLa1Auza5HU1SAQ14FIp2NLBo7dp+bX23lSx04zjLZdrMdf7qfrWep7MlAtnFRrocZuxZ7dE2yATf3IEOCxtsGcPZIVGGNlI3pFS+LiDnDF0xNgDxY+xLcWjRiC/UIAJHmL1NvND0q2FKV9wFlYTkGaOQB0P7UsOUF9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf4Ch7MLav8lo1Kb4zexUBgjMWOk3uys1LmIjbUwtCg=;
 b=lxA9ARYzO6SnENjidJ8rbEDIZXiAsbfq3TyKRJXyDZwAS68/AWJhWtyP5uyL85ljYOjZlSc8YOxeXq1epX00mAgsFLeXV1xKIpel+r0JRy6AHtDI6tXV2QSR1gtBr7gTiZ7UbPU3YWUZXEi8NbZ8ldYpClYwpea5SeN0Ur0j32M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 BY5PR12MB4244.namprd12.prod.outlook.com (2603:10b6:a03:204::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 08:56:08 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:56:08 +0000
Message-ID: <b152dda3-e929-4ec3-a034-2057ff3c3c81@amd.com>
Date: Tue, 24 Feb 2026 14:26:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net> <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com> <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net> <aYSjoRjnR3N3D8lD@sig21.net>
 <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com> <aZoVhnX77mGUsV3y@sig21.net>
 <cf136d02-986f-402c-81d9-8971229abe9e@amd.com> <aZwZMwZ0FOa3dXwm@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aZwZMwZ0FOa3dXwm@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::35) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|BY5PR12MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0454bf6d-5a49-4855-ea35-08de73828c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDBQR0dnMFIyd0ExNUFJdTdWeVZaSG9mUDhpdWtueTdUWHcvUGZGdDFPVGR4?=
 =?utf-8?B?MzNQMC9SS0F4RG9ydXB5MlpaRWF3cnhaUkF2T2F0NFg5YjQ4TkJNZmFzT2dl?=
 =?utf-8?B?cFJnUm9zTEhWS1p0RHFFMkpEU2UwTUNINW03Q3NYbVJvNzFTWGk0QnR1eHYx?=
 =?utf-8?B?ZG12NUFIZUVmdTVueVFqTTF6bWFxbjdRdUQwbGhCRDFMLzdRN0l2T3RzSTZK?=
 =?utf-8?B?OTIvQkFTUFFKRVE0N0daVFdoS2dTdnpqRmJlS1pCRlRGaFBZamdzamtsUk9L?=
 =?utf-8?B?NWxhQXFGaDVlNFRnYnVzWjA2T0dwQ0VKWjBNT0xFWi9HWktSNVdZMTVub1VD?=
 =?utf-8?B?bzJFNUVUd1pTRDBtRlY2MmtvbDVoRDFNYWxGS0dLYzJDcWRpRFM5NGZ1ekFO?=
 =?utf-8?B?WmdIR004WS9xUzFBNUpJZ1YvUmloa2xveEM5bTV2alBZdG5qNnlCNFhQWVBO?=
 =?utf-8?B?TUZjSy9qb0VEd29keFE2eUhoaXlaSmxneVJPeHRlUUdVemZML3FVNEFBcHIy?=
 =?utf-8?B?bS9sRW1ZKzI1ZnZFRlZIZXZyRVc4bDBVcmxDbjQ4U1c1bEV1MWIrWXczcUNw?=
 =?utf-8?B?ZTRWclpnOC9nNEUrV2F4bGwvYTFRVDFvZEpVRmFhelA1ZUN3bDdLSjVYWnA2?=
 =?utf-8?B?V0ZON0hrNGNDUUVPZDdoc1loU2UwVFpvRVlWQThDNkhPZ0o0Q3pYOTVzQjdu?=
 =?utf-8?B?M0pOYkF2TjBGRFJsUFhpOXhkUERGQ1QrNWlMTFVkY1ZEdEpkQU5VSzFrdVI4?=
 =?utf-8?B?TTZFcGN1WW5MV2JpUS9LR3Q0N2ttMHM0UW5VWGVENWgwOENHUUhERmt0NTRG?=
 =?utf-8?B?eVQzMTZoa0RIU2JVbUNYUi9NcjdYakhwR2NQb1o2SXUvaVdnZnlLbFdWNVVZ?=
 =?utf-8?B?UnpLcFJSU2d0eU1BaklOa2xTWTJVQUpQbUxpRHVxMm9Td1NuOXlNN094bjc4?=
 =?utf-8?B?SmxFZU00d0dMRmx1eDh3VGVUMzAwQUhwWTRPUWFwK2FnMDhwS3R2V0N6MFJH?=
 =?utf-8?B?bUxCRXZ6MmUxZHMrT0VCUlp5bUtDaFozaUo1STNDZHdvMHFXeUJxRzlWKzZL?=
 =?utf-8?B?Z1BlbFQyRlRpaVdiMjZmTDF4OEkvRCswK1NyVXU3a2NZV3lDUXE1TGFhcWp3?=
 =?utf-8?B?YWtteU9ZVGxqc1NLcjZvM3d6NDJUemFpQ0hiNHhEalVZTTIxRzMwUGtaWE1Q?=
 =?utf-8?B?MkRVblZFRkhxcHhPWXBYeXJyOG9tc1NiVXo3Q1NXZDkvUEVYL004NHk3bXhR?=
 =?utf-8?B?K2YrMXJSaUw1T2t5ZVU2cFd5czZ5Y0kxL2lveTVqckNrSEVrWjR6eGtFUW0y?=
 =?utf-8?B?Q3k0Zi90cllzNFhCKzQzOTlNd2lsaUt3bjBQcUc5Mm0xSXJaTDZ3K09ickZ3?=
 =?utf-8?B?Z3o5MXd2ZjBBWnRaWURKWTN4cnV4RXoyejBDUmswdTh3VGI4TXhSYVROaGFo?=
 =?utf-8?B?OHliQnJ1Uys1aTltanJVVlp0UkRjc1c1bWVvTDdmYVdYWUVqdFJQVG0rL0dX?=
 =?utf-8?B?NjZ1SWZ0R082a3NlNnVKRlFsMDFFemVIbnRXMjhWdjNRSlJZU1pxVURsT3RN?=
 =?utf-8?B?VXdyU3d6MnQxOGhweHExUk1QME04ZlVuazZNYm1uejRhVnQ3LzNiZ2N5U0xI?=
 =?utf-8?B?WHlCNkJBREFqeml2NzJKMm1nUFpEYzJVMFFtS1ViRDBpdXhCSjNGL2V0TUh3?=
 =?utf-8?B?VzRFWjRtN1Y0NUlmK01SNzUwT0VXV1FLditncjhiUWRlQUNYUjFPRTlMN2Vm?=
 =?utf-8?B?emw3cGZCVDFCODB6UGE4amdaZmNEWWU4MmhtSHgwdmdxN0lWUDhUVEp1cmE0?=
 =?utf-8?B?dHpJa0dkL3pVa1FxZUx3dThVa2tsa1Y5bEpzN1g1enhOSDBJODZTOHlPRXk3?=
 =?utf-8?B?cEYvREdLS3hZQlpTN2M2U3VlWWEwRVltYUhlQTlUSU1iVnNWWUhFQng3ZWpx?=
 =?utf-8?B?NGdla0Rxb3VsYVJ6bEg0aG9MNW53ZFhUMXo4cGZYdWtFaWZKbDdrbmxWNjNw?=
 =?utf-8?B?RTJTc0NuRjh3ZGdGZDlQelJIOGMra2Y0Z1YrV1ZTbWJGbjRYVk9FNHFGUGkv?=
 =?utf-8?B?UkJyaFhHeHU2L3kzYXBkQ2NiL3I5UGdhWUJvZXczYnBEUmxacnpnenIvb2gw?=
 =?utf-8?Q?CntY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlVUWUhhaG15Z1FCQmhNRURWTXpYS1VTSDJYQ3hyWnpLcU5RRm5VL09yNlJr?=
 =?utf-8?B?bmViamRrT1ZSTDZOYjJod2dPdnZxUXFRTno4dEZoWWJONG9IMU9lK2ozTU5u?=
 =?utf-8?B?SVVhTEM2ZFdySFpwcTNDcm5lbUlrMWhTYmR5cm9aMFNERHZEMXRmU2d4SVh4?=
 =?utf-8?B?eHo5bXhWdlp6dmo3bU05a2YwTFVxQmtzYVRtYzJpTXdzcEJScmFtSHBZSVZP?=
 =?utf-8?B?RklZcjFKZUJQU1JuUkwvTmRPSVJmN0RFTS9RUmFBQTdLRXRmc0ZHeWozcCtL?=
 =?utf-8?B?dE1vc05xR0I0eTFvaWpPdTZFdVdnVm9Mc1h5L2p0NjhFTGxTeHdUWVRKUG1G?=
 =?utf-8?B?bjRLdmI1b0hOLzdJTS9CVVZwVWVZWmsvOW0rd25xSzBZWWlPUXJRVU9vc2hh?=
 =?utf-8?B?dVN6anBLbENBRzFocFBYSEwrQ1JnVTVyTVFQLzYvU1hTR2Y4Rm0zUkR2M1pT?=
 =?utf-8?B?SjFUODJPaURhZVRjM2laT0lXL3JWaVVsZGMrWFNnZmlOU0tmUVRmUjRvOEt1?=
 =?utf-8?B?WmU4anZJTEJDT2RmcStTWmNWeDNaUDJnU0tZSEJJem5EN3JBQk1CeWcyaS9a?=
 =?utf-8?B?NU1iMDhONzNzM2Y5ZllJREVtbi9XdUJ6YTFzY2ZSdUx2VTJCK2FhR1NBSHJK?=
 =?utf-8?B?bnppcmxnTWp4Uzk5NTdSOFdBczc3VnBSVjV5YitqNXZGNkoxcUM2VzMrSHpt?=
 =?utf-8?B?RFJLK2VYRzg3RkQvdDZ0SzFSMGJtTDdsc3ZNcHVqV2owOXorSDVRc3hPN1Rr?=
 =?utf-8?B?R1ZiZExlazRlVjZZZFE4bktIVkZCdzNhYXZWQThiR3JTSHdLODZsUlo2LzBu?=
 =?utf-8?B?OXZwZmR6eFV2aExFN1BqaVFZVjQyVTdCVVVWYkZ4dkFpMTNVcnB1dVpYSCtH?=
 =?utf-8?B?SnJMd2J0WTBSNHBzc00xS2MvNDArandMZExaSjNuV1AvK0JvaitXazNYTmRs?=
 =?utf-8?B?OXN3SThad2t1ZFVNNG80dkthbzR2V3NIbG9rWXFmc05TcTdqVHNvRVlmT0t0?=
 =?utf-8?B?bTRMM2g1dXY4SS9HUTM1akFaeGhGc2xyN1RCMHc1YjJXQzJlSW9ZY3dDMU9q?=
 =?utf-8?B?bThycWtpNHJrbzUySXFWOWpaYmFOdjRFQnU5SmRld3NTeHBDcXpKdXMwamhM?=
 =?utf-8?B?azJ5UWpVV25qRmQza2M4WE5GaGRjR1NwUm04YjJqVFFQM20vWWJyakxmSmIr?=
 =?utf-8?B?TFh6MTQxblJ6YzZ3ZkhiUnZzcGZDZm4zVlUzbkNQclU5VWpNbWFqZ1hHZDBR?=
 =?utf-8?B?emhGV2ZHS2h0MmlJc09IeHVTYk9yakkxVWh0ZXBzY0p0NWxkS3ZySXBUVGkv?=
 =?utf-8?B?dVJ4NzI1dnVIdGE1UmI1bUlaemR2ZkN6QzVRM2w0Z1ZkVFVHNmE3TGc2QXpB?=
 =?utf-8?B?cHg1THhTamc2UGwwRjdBRU4wZTU3bFNKdkVMU1FGMDVsSGF0b2NTV1pIUE8r?=
 =?utf-8?B?QXVJSW1ERUY2ZWIrbHJKZ2YwQ0UyN2Y4RitVOStzLzNoUEVjaXhkYjRqSUNk?=
 =?utf-8?B?LzBHQmtOeCtUczhZdG9UR1YwM3V3aklSNWsrZzRGVDNYckR1ekFrSHNhSG0v?=
 =?utf-8?B?MWxoamRFaXJHd3JFMUE1MFcxR1h3UHcyK24rL1M0MXlaZmdmS2ZSTWg3VUJ5?=
 =?utf-8?B?UWpUNjg5dE9EYXFvZ1c4Y2NYRWlpYlBSTk02ZzMzdzNVQWRqVzBZYmp4TnpK?=
 =?utf-8?B?T1hEV05KWGR0ekRrMUZaUkVRcHVQNGVYNnU0N2xkK2tUUGovUGhXM0FleXZS?=
 =?utf-8?B?WDRST0ZIQmg5ZUFGaWlEck1NV05WeU9vbURNbzFkZDI3QVdjVjNPVnFRdGFx?=
 =?utf-8?B?TVZkSGJlVCt3dEJDdC96ekVsRkFNNVBtTTJJQzJpNXUvbEx3MHZ3bmF1Tjd4?=
 =?utf-8?B?YXUvL204NmFUdm45UGQybWN2bjh0TkZNUHZsbzgwd3MrLzA3dE91QkZGV3hp?=
 =?utf-8?B?eHRsMk0wTUxGd3YrWVZIVXVpc1BwVkVVVDRvOVVSaEkvNUdVOGRGT0lDMFMw?=
 =?utf-8?B?NTNwY2hxbzdEamNCTWdRbW5kd0dXYnFxaHY5RmpFaS9BRC9nU21DczlZUWRa?=
 =?utf-8?B?ejRSckNpMlVBVXA4K1NGbHBZMXRubW0wVjdFbms0OTVxT1ppclV0a2EyQUJC?=
 =?utf-8?B?cWpnQlJjajZ4WTVLbzU3VXVDZlRBRE9vdmxPVlI5Q040NE9za1huRERHV0o0?=
 =?utf-8?B?eWt2bjN5RG5KelRhQlRPMmRnaUNaRVI3MlhUNHdyMS9QODEvZUV5bmtzUjJt?=
 =?utf-8?B?cUxwcmVKM0hTMmhCOVhscHZZSThIZkZnYk9yUnZYSTdzQkFoU0ViUWtUZlNL?=
 =?utf-8?B?cTdlOXlqM2pQNnJBSWVaQ0RONUs5WnZ4L2xNazExQ21BaDZGbjhmUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0454bf6d-5a49-4855-ea35-08de73828c68
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:56:07.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OpHiYJyM94iFs0mK6pi5r3Bu950c9NyX8qQ2MAogL4l5zzWyKfEiEqgc7XV1Fd+fY77hty70oU1NsoUXxWBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4244

Hi Johannes,

On 2/23/2026 2:39 PM, Johannes Stezenbach wrote:
> Hi Vasant,
> 
> On Mon, Feb 23, 2026 at 02:19:53PM +0530, Vasant Hegde wrote:
>> On 2/22/2026 1:58 AM, Johannes Stezenbach wrote:
>>> On Sat, Feb 21, 2026 at 08:01:16PM +0530, Vasant Hegde wrote:
>>>> If you have cycles, Can you try below patch (untested patch we will test it
>>>> internally next week)?
>>>
>>> I tried it with 6.19.3, doesn't seem to work reliably, but the
>>> results are mixed, sometimes seems to work, sometimes doesn't.
>>> (Trying a mix of suspend and hibernate, and hibernate mutiple times.)
>>
>>
>> hmmm. Is there any pattern (like hibernate -> suspend failure) ?
>> Also do we have any other interesting message in dmesg?
>>
>> I went through complete init code today. I don't see any other suspicious thing.
>> (disable -> enable sequence is proper).
> 
> I didn't have enough patience to test hibernation over and over

Its fine. I will see if we can reproduce it internally and narrow it down.

> to find a pattern. Here are the relevant parts of the serial
> console log (binary gunk should be from firmware port 80 debug):
> 
> [  271.070351][ T5153] PM: hibernation: hibernation entry
> [  271.127196][ T4386] Filesystems sync: 0.007 seconds
> [  271.139941][ T5153] Freezing user space processes
> [  271.152926][ T5153] Freezing user space processes completed (elapsed 0.001 seconds)
> [  271.172069][ T5153] OOM killer disabled.
> [  271.182016][ T5153] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
> [  271.201821][ T5153] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
> [  271.220600][ T5153] PM: hibernation: Marking nosave pages: [mem 0x09aff000-0x09ffffff]
> [  271.241416][ T5153] PM: hibernation: Marking nosave pages: [mem 0x0a200000-0x0a23bfff]
> [  271.261191][ T5153] PM: hibernation: Marking nosave pages: [mem 0x8567f000-0x977fefff]
> [  271.281450][ T5153] PM: hibernation: Marking nosave pages: [mem 0x99ffa000-0x99ffcfff]
> [  271.301281][ T5153] PM: hibernation: Marking nosave pages: [mem 0x9a000000-0xffffffff]
> [  271.321347][ T5153] PM: hibernation: Basic memory bitmaps created
> [  271.338107][ T5153] PM: hibernation: Preallocating image memory
> [  273.425730][ T5153] PM: hibernation: Allocated 589799 pages for snapshot
> [  273.442589][ T5153] PM: hibernation: Allocated 2359196 kbytes in 2.07 seconds (1139.70 MB/s)
> [  273.463785][ T5153] Freezing remainHng freezable tasks
> [  273.478947][ T5153] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
> ^F^A[  274.580195][ T5153] ACPI: PM: Preparing to enter system sleep state S4
> <E7><E8>^D[  274.907274][ T5153] ACPI: PM: Saving platform NVS memory
> [  274.936551][ T5153] Disabling non-boot CPUs ...
> [  274.949975][ T5153] smpboot: CPU 15 is now offline
> [  274.964722][ T5153] smpboot: CPU 14 is now offline
> [  274.979649][ T5103] smpboot: CPU 13 is now offline
> [  274.994576][ T5153] smpboot: CPU 12 is now offline
> [  275.009181][ T5153] smpboot: CPU 11 is now offline
> [  275.024337][ T5153] smpboot: CPU 10 is now offline
> [  275.038977][ T5153] smpboot: CPU 9 is now offline
> [  275.053983][ T5153] smpboot: CPU 8 is now offline
> [  275.067245][ T5153] Spectre V2 : Update user space SMT mitigation: STIBP off
> [  275.086852][ T5153] smpboot: CPU 7 is now offline
> [  275.101923][ T5153] smpboot: CPU 6 is now offline
> [  275.116602][ T5153] smpboot: CPU 5 is now offline
> [  275.131178][ T5153] smpboot: CPU 4 is now offline
> [  275.145279][ T5153] smpboot: CPU 3 is nor offline
> [  275.159837][ T5153] smpboot: CPU 2 is now offline
> [  275.174462][ T5153] smpboot: CPU 1 is now offline
> [  277.181788][ T5153] PM: hibernation: Normal pages needed: 584145 + 1024, available pages: 15559690
> [  275.188280][ T5153] ACPI: PM: Restoring platform NVS memory
> [  301.950493][ T5153] ------------[ cut here ]------------
> [  301.963784][ T5153] i >= MMIO_STATUS_TIMEOUT
> [  301.963786][ T5153] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/5153
> [  302.003074][ T5153] Modules linked in: nct6683 iwlmvm iwlwifi
> [  302.017499][ T5153] CPU: 0 UID: 0 PID: 5153 Comm: pm-hibernate Not tainted 6.19.dirty #55 PREEMPT
> [  302.040428][ T5153] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.14 10/01/2025
> [  302.059648][ T5153] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/0x550
> [  302.075812][ T5153] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7 e8 60 c8 00 00 48 8b bd d0 00 00 00 e8 54 c8 00 00 48 8b 15 05 03 c7 02 e9 de fc ff ff <0f> 0b 48 8b 15 f7 02 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 24 04
> [  302.124729][ T5153] RSP: 0018:ffffa4474add7ad0 EFLAGS: 00010046
> [  302.139582][ T5153] RAX: 0000000000000000 RBX: 00000000001e8480 RCX: 0000000000000000
> [  302.159238][ T5153] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  302.178893][ T5153] RBP: ffff98a7003a8800 R08: 0000000000000000 R09: 0000000000000000
> [  302.198548][ T5153] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000000
> [  302.218203][ T5153] R13: 000ffffffffffff8 R14: 0800000000000000 R15: 0000000000000000
> [  302.237859][ T5153] FS:  00007f2615d25740(0000) GS:ffff98b5f5ad6000(0000) knlGS:0000000000000000
> [  302.259916][ T5153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  302.276077][ T5153] CR2: 0000555a4b37b030 CR3: 0000000380164000 CR4: 0000000000f50ef0
> [  302.295733][ T5153] PKRU: 55555554
> [  302.304252][ T5153] Call Trace:
> [  302.312118][ T5153]  <TASK>
> [  302.319113][ T5153]  amd_iommu_reenable+0x10/0x20
> [  302.330910][ T5153]  lapic_resume+0x176/0x260
> [  302.341837][ T5153]  syscore_resume+0x5c/0x190
> [  302.352981][ T5153]  hibernation_snapshot+0x292/0x590
> [  302.365653][ T5153]  hibernate.cold+0x110/0x491
> [  302.377015][ T5153]  state_store+0xce/0xd0
> [  302.387285][ T5153]  kernfs_fop_write_iter+0x159/0x210
> [  302.400177][ T5153]  vfs_write+0x270/0x4c0
> [  302.410449][ T515^R]  ksys_write+0x73/0xf0
> [  302.420499][ T5153]  do_syscall_64+0x7f/0xf20

Is this hunk from suspend path?

> 
> 
> 
> 
> ^D^C^H[   31.544960][ T2270] PM: Image signature found, resuming
> [   31.558892][ T2270] PM: hibernation: resume from hibernation
> [   31.575531][ T2270] random: crng reseeded on system resumption
> [   31.576152][ T2270] Freezing user space processes
> [   31.577234][ T2270] Freezing user space processes completed (elapsed 0.001 seconds)
> [   31.577236][ T2270] OOM killer disabled.
> [   31.577237][ T2270] Freezing remaining freezable tasks
> [   31.578026][ T2270] Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
> [   31.578221][ T2270] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
> [   31.578223][ T2270] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
> [   31.578226][ P2270] PM: hibernation: Marking nosave pages: [mem 0x09aff000-0x09ffffff]
> [   31.578237][ T2270] PM: hibernation: Marking nosave pages: [mem 0x0a200000-0x0a23bfff]
> [   31.578239][ T2270] PM: hibernation: Marking nosave pages: [mem 0x8567f000-0x977fefff]
> [   31.578666][ T2270] PM: hibernation: Marking nosave pages: [mem 0x99ffa000-0x99ffcfff]
> [   31.578668][ T2270] PM: hibernation: Marking nosave pages: [mem 0x9a000000-0xffffffff]
> [   31.578927][ T2270] PM: hibernation: Basic memory bitmaps created
> [   31.597255][ T2^R70] PM: Using 3 thread(s) for lzo decompression
> [   31.849756][ T2270] PM: Loading and decompressing image data (436278 pages)...
> [   31.892399][ T2270] PM: Image loading progress:   0%
> [   32.141062][ T2270] PM: Hmage loading progress:  10%
> [   32.275096][ T2270] PM: Image loading progress:  20%
> [   32.403747][ T2270] PM: Image loading progress:  30%
> [   32.533269][ T2270] PM: Image loading progress:  40%
> [   32.615^R77][ T2270] PM: Image loading progress:  50%
> [   32.693107][ T2270] PM: Image loading progress:  60%
> [   32.772241][ T2270] PM: Image loading progress:  70%
> [   32.853502][ T2270] PM: Image loading progress:  80%
> [   32.936477][ T2270] PH: Image loading progress:  90%
> [   33.004355][ T2270] PM: Image loading progress: 100%
> [   33.016843][ T2270] PM: Image loading done
> [   33.027094][ T2270] PM: hibernation: Read 1745112 kbytes in 1.14 seconds (1530.80 MB/s)
> [   33.049880][ T2270] PM: Image successfully loaded
> ^D^F^A[   33.234650][ T2270] Disabling non-boot CPUs ...
> [   33.276347][ T2270] smpboot: CPU 15 is now offline
> [   33.329653][ T2270] smpboot: CPU 14 is now offline
> [   33.383096][ T2270] smpboot: CPU 13 is now offline
> [   33.436317][ T2270] smpboot: CPU 12 is now offline
> [   33.479615][ T2270] smpboot: CPU 11 is now offline
> [   33.522934][ T2270] smpboot: CPU 10 is now offline
> [   33.566275][ T2270] smpboot: CPU 9 is now offline
> [   33.6164^P0][ T2270] smpboot: CPU 8 is now offline
> [   33.6294^P0][ T2270] Spectre V2 : Update user space SMP mitigation: STIBP off
> [   33.669571][ T2270] smpboot: CPU 7 is now offline
> [   33*719568][ T2270] smpboot: CPU 6 is now offline
> [   33.772924][ T2270] smpboot: CPU 5 is now offlhne
> [   33.822900][ T2270] smpboot: CPU 4 is now offline
> [   33.872896][ T2270] smpboot: CPU 3 is now offline
> [   33.899500][ T2270] smpboot: CPU 2 is now offline
> [   33.936262][ P2270] smpboot: CPU 1 is now offline
> [  277.553155][ T5152] PM: hibernation: free pages cleared after restore
> [  277.569012][ T5153] ACPI: PM: Restoring platform NVS memory
> [  303.356792][ T5153] ------------[ cut here ]------------
> [  303.369833][ T5153] H >= MMIO_STATUS_TIMEOUT
> [  303.369835][ T5153] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/5153
> [  303.408317][ T5153] Modules linked in: nct6683 iwlmvm iwlwifi
> [  303.422433][ T5153] CPU: 0 UID: 0 PID: 5153 Comm: pm-hibernate Not tainted 6.19.3-dirty #55 PREEMPT
> [  303.444883][ T5153] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.14 10/01/202[  303.463694][ T5153] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/0x550
> [  303.479520][ T5153] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7 e8 60 c8 00 00 48 8b bd d0 00 00 00 e8 54 c8 00 00 48 8b 15 05 03 c7 02 e9 de fc ff ff <0f> 0b 48 8b 15 f7 02 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 24 04
> [  303.527402][ T5153] RSP: 0018:ffffa4474add7ad0 EFLAGS: 00010046
> [  303.541945][ T5153] RAX: 0000000000000000 RBX: 00000000001e8480 RCX: 0000000000000000
> [  303.561186][ T5153] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  303.580422][ T5153] RBP: ffff98a7003a8800 R08: 0000000000000000 R09: 0000000000000000
> [  303.599660][ T5153] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000000
> [  303.618898][ T5153] R13: 000ffffffffffff8 R14: 080000000000000^P R15: 0000000000000000
> [  303.638141][ T5153] FS:  00007f2615d25740(0000) GS:ffff98b5f5ad6000(0000) knlGS:0000000000000000
> [  303.659729][ T5153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  303.675546][ T5153] CR2: 0000555a4b37b030 CR3: 0000000380164000 CR4: 0000000000f50ef0
> [  303.694784][ T5153] PKRU: 55555554
> [  303.703127][ T5153] Call Trace:
> [  303.710826][ T5153]  <TASK>
> [  303.717671][ T5153]  amd_iommu_reenable+0x10/0x20
> [  303.729217][ T5153]  lapic_resume+0x176/0x260
> [  303.739921][ T5153]  syscore_resume+0x5c/0x190
> [  303.750827][ T5153]  hibernation_snapshot+0x292/0x590
> [  303.763239][ T5153]  hibernate.cold+0x110/0x491
> [  303.774360][ T5153]  state_store+0xce/0xd0
> [  303.784412][ T5153]  kernfs_fop_write_iter+0x159/0x210
> [  303.797038][ T5153]  vfs_write+0x270/0x4c0
> [  303.807109][ T5153]  ksys_write+0x73/0xf0
> [  303.816945][ T5153]  do_syscall_64+0x7f/0xf20
> 
> 
> Without the patch, there had been double

Right. It was calling resume code twice and it was printing below log twice.

> 
> [  106.830788][ T4108] AMD-Vi: Virtual APIC enabled
> 
> messages. It's suspicious that these messages are missing
> completely in the failure case?

Yeah. It will skip above message in failure path.

-Vasant


