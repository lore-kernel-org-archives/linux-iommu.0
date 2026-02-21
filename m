Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012029.outbound.protection.outlook.com [40.107.200.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38930262A6
	for <iommu@lists.linux.dev>; Sat, 21 Feb 2026 13:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771679665; cv=fail; b=grM2YxJJkSixo3N2qKmzM/mVjtvk3WWFhVluyXCD8vTlu13NQq7M+L6mQZMNv82NzT3l80klbIsxLo8LX4KQdiQSpY4dCOTztAmKa1OYBvjxGgbWZRqByMlJKH/SUJB8nUisbonvIsG9EZi9Csj6xz2hSnnVeZMSENaL8tjiIiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771679665; c=relaxed/simple;
	bh=qL51wRfCntZAq+K/mXEwBqe8Y2NFc+T9BDvzvzbaOpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FohStxG8x2GjEjcJOA0HMywQyDRV0iKDc1RgePwSvNwL7l58BDd6TFUvcuQx0NRnAASiW+cGpFf2UafSiY6swlTwJlU6VKy/pBISzIgjturXMqT/BeFYTKVHWIGimN8LGL0dsMROOdlb40ZDrZ0yvxv9LJ0HiPJua1VWkTx/UCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mr5u0Zke; arc=fail smtp.client-ip=40.107.200.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mr5u0Zke"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0ulCvz+0XOjvbFEtqxjr1KLKtU+FH69wAk6plj3W2ZJ9qAgtbS1GZD/vws9pvI0abIZto4SnFmad3Tu7m5/ygcQEh+uT1srQgOtTRqOzcvBB37mquqxPSHD/S3n7j9u8+Mjser0P8KUuUwn8EGUxGajBSh0+nr4Cq/zhlsWC6ZqJgKfy65wWnVYxYCO4vu5ibdGY2OnZWLmaV4iGlfz50dXjYxqLNy6rfIw3blahkYgi0O1t9SfGpLfG82id19CP9wM33PI+X1FTy2oIAncRzIPZfy5GD5LxzhyATV4hiJOdaqZRq0qj+B0LJCi0gVb5I+Y2tCofD+Qh8bfeKzIwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=01EN0j8sJBUZCQ3yTJYjCfWa/5nZYnynlFo0oIU5y/M=;
 b=seMukvYZNk7SPGUJWXHbk/qyIB6rWoX6IoBtVvHfgqFVJW4SEoadBTKLgkdz5J3cpg1zERs6aIbKs+iN4uFTu5oOtRlU0aVtl3ivUKKp3mqsI4GdC4ta4wAX3oiuiSygxWhBVN+yjHrL21x6W3GNzkqiHO5lpm4XSdT6dkkLiNz2GYUGvbBPOmhOlM1/drouHe/oXF574ElAQ6DzHdaLSK/rHoNdKA5RhJrUwDmPiSNB3BuclK9mrUmmf+ozyf5wucsGnhShdz6WApsccpi0sxYdNYYNaC8f2lx/CMs1Zb0yM0gGxa+5Iq8xe1HEHSY8X+hfbFFEOVx97jpOy8LyvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01EN0j8sJBUZCQ3yTJYjCfWa/5nZYnynlFo0oIU5y/M=;
 b=Mr5u0ZkeA1XadR0rxosyVoeP5+GBlGjV3TAEHf1jt8sa+UzGS4+DLlT+Ve+UWgAezBOB4iw8HuZRFmxixtDygbRjEXOPT/ZJlfZd23Q2bNoMYSFndQ7iihjRMgzCjTZ33lgjWm6iRSI3G8M45y08/FCRB2uwVPVhhk5DBQAzoBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Sat, 21 Feb
 2026 13:14:21 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9632.015; Sat, 21 Feb 2026
 13:14:21 +0000
Message-ID: <8b88adf6-6e00-476b-b2a6-4f0a7af4f2c3@amd.com>
Date: Sat, 21 Feb 2026 18:44:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net> <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com> <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aYNi4yYA2_Cu359Z@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::11) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2b476e-7a33-4d08-e2a1-08de714b2031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnM1ck15Q3lQMTFBSis3ZUluMUpNYUwwKzJYSnhUa1cydHVGRWpuOFVRQ1FW?=
 =?utf-8?B?Y1czTDlYZ0xBRmJpckp4Rjg5a1lkVTFvMHR1QVB5VXR3VHFOV3ZzQnlFQ2Fh?=
 =?utf-8?B?MksvQTJEaTZ5TVNkSlV5c3hVd1YvL1QrSU5zR29LazRDbzVRL2ovL2ZuS0ZE?=
 =?utf-8?B?ekNNUTRuOUt2ZE5wZ0tKdUp2djg3M0Q1V0cvTHNQZk5HM0ZTeCtRYXNHKzVY?=
 =?utf-8?B?aUNFMFdJTnZLU1Z3d0lYVGxvQVNxa3FpeW52VFlqaFo0TldiNWE3cmxlYUdr?=
 =?utf-8?B?Y2hSMVhkQmVFUlg1ckFhNU5RcXNtVlRydVlBUnFLTURCaGJlbHFYekZGQVRI?=
 =?utf-8?B?eENhZ2l5alBGZ2gzRml0RjJBRW5JcUswZ1p4dUxpOGNya3ZMRFdreitPV1pl?=
 =?utf-8?B?cGVWOEZwNm1sU2RXcmNBSkVOYkRhU2VtbmpEcE5IZEdUWGpvTVJ0d0hjcHBC?=
 =?utf-8?B?WE91QWhnRlA1azZvZlJpQnRsNm9JTGhZdnBOUDZZUzJXWFNCanJhZUdaMUtQ?=
 =?utf-8?B?QlFEVEZoQ01xdm8vandUZG5ZeVRMYzJWaks2YjkwQ2RjLzh5dXdCaVNES0lN?=
 =?utf-8?B?eWRHbnFMcnk1MUhkV2ZhVVFvTG9WNjlHYjIzNlhMK1JUM015RCtlTklLZFZB?=
 =?utf-8?B?SnJJRWhHSmY4N2VTR3JocGQ2Z3pUTWFRNW1YS0ZZRC9vb2FrUkpoaERWNWVh?=
 =?utf-8?B?dlQydThpai8yTTFHTEh6anBFRTY0MGUzeXZBYVdCQ0E4YWxDMTdBQ0pqZlpn?=
 =?utf-8?B?aGhkMjZoNjZjUXQvU3owWjlEZU9KVk1wRVdsVExGN0tsNHZmeTVwa0JldWJs?=
 =?utf-8?B?NC9iTnRmN0d2V3VMTDlWQUpRNU5YTGxwcU56QzR0aU4waGV6T0txU1RWbUk1?=
 =?utf-8?B?Ky9RNVB1NDYzbEhPTWNBTEpFZC8zaG82ZVYzc2lVaGZ3ZmtwZUhhZC91eXVv?=
 =?utf-8?B?YjRtWmYrdFVrWGlISS9jWmtMMklCYVIwbG51bSt4b1dUR3JOSmVkMUlaZXhy?=
 =?utf-8?B?MURpZ1V0Tytaem1TRkxlSVpEYjBTaTEzMlFGWUhVRjFEZHZJRUFITnREdW0x?=
 =?utf-8?B?cG4zTHBHYlpOUlVvQ2FQcWtyQnA0V3NzdnlRWkNjaGh6TzIzSWdBVy9ySVlq?=
 =?utf-8?B?NzlmbkdHTThjR0RsYVBFZ1lXVGJEZGcxS1R3ZEh3d3ZXeERKZW9jS3VBRzht?=
 =?utf-8?B?TEV0a3I4WFhBMDRPQTZnSUtLMzVadWNDeHhLMWJBL1RWZmsrY1NvSHV2QUZB?=
 =?utf-8?B?TDBvYVZUK2w4a3lNT2Zqd2llVXVXbDFSazAzUU44YTlSc1pXcm1ic3NralV2?=
 =?utf-8?B?Ym5Rd3Rrdll1RGg0N0t1V0NXRHF4RkhDdnhybzNBa2RNK3B6MjJvUlQxb2ZX?=
 =?utf-8?B?azR1Uzd5cVA0K2I5UDRSbU0vZ2ZPblZQSUxsYklpS3ozR0NoekV3SGtlWmMv?=
 =?utf-8?B?Zm9JNjZaT0Q2QVJpVjNLUWJBbk9hRjlQRmtJZzIvclhkOUQ5Vjl3anJXaVpa?=
 =?utf-8?B?UnFXdmU0cGJ4eXpOQ2FYZTJLRlg4NEVIOFU3eWpPYzlaSlRscWVrZUFiK2hM?=
 =?utf-8?B?UGNLd1F1Si84UDBRQmZMaVJpOWZvZ0U3U2JMOEZWMmQ3WnM4T0Y2ZHd2WTZo?=
 =?utf-8?B?UHUzVlhJVEllVTJidVZtcGVHWXM4ODF1dDc5THBnUk5jQnQ1NVRDK29MS0g3?=
 =?utf-8?B?bW1UaU9XYjMrMFJUSmttWmtVMXB6NXlOTTBIbFArWE9pM3F0ZHlsdnZCRDdp?=
 =?utf-8?B?akE3Um93cHhuSEs3akk0SDV3a0RhdHZiYmQxTUJIYWptL0x4a1dRUDVDRW4x?=
 =?utf-8?B?VDN2SjM3OU5EZVNBeTNHcFdveENOY1JNMlJ3VmFMSCt4SzFIb3kyb1VtVk1T?=
 =?utf-8?B?VmxaZzBTS1AvVEtSMjlWS0xqTVVnOGExSHhlSWJmRWFEQXAvK3d6emhEZ1E1?=
 =?utf-8?B?d0Nva1hxaVQ0S2RmUlJzTDF1enVWZDN4RXF2R1lpZzlRMm54ZGYybkxlWEd2?=
 =?utf-8?B?TXB3R1Vrc0FvZjBKKzVQaU5WcFBReE5KUnZZc2lCangzSXYveWFiTENodmVP?=
 =?utf-8?Q?bKI9Jd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVIycjUvcUpKVktjZTJ0WGVXTDlsMzdTdVRwdFNzYStHTDBJOTJ0MDlRakFG?=
 =?utf-8?B?ZGN5MzduNE1mK3hJN2tnSFp0TnJDRVNML0Z5STY3a205WEUwSUxrZDhlaWJH?=
 =?utf-8?B?UmU2dHdjWEFsMTR6Z2JudGRoUzhpRnU1NVN0ZHpjeTgxZXRiN3gvcVJGUDFO?=
 =?utf-8?B?LzFxQlVqYzNScmwzQ2tLWGdXMy9KMmpGMW9VNkVXNEtZL24xcXkxVzR3eUc3?=
 =?utf-8?B?cngvam11dm9HZ3FKM3pGbFJPVGhaOE1IVHRERzRSei9XRkt0ZlFZZ1pkYktE?=
 =?utf-8?B?Vks0UURBcHNYQmM0bmhVWlFqMzdYNGlFWFAwWjRXQ3dkV2s1TnVXQXVqVW5L?=
 =?utf-8?B?VDJ4UERXaGgrVk83dWhYSzdlMHZpZ005S0NqdVFFWURiWDZUejZubFQ4cThO?=
 =?utf-8?B?eVluWXhwQkUvZFRwUXllL0JweHlic0FjSXVzMHhwcEFLY3lGNGdOOG9uRVpL?=
 =?utf-8?B?VHY0MU9CUndmaWdTeVRzZFAyYUtPRExYRVZpeDA1M2EvRU5wSHUzbWRDa25B?=
 =?utf-8?B?WWwxclM0eGJneXVqWDJqOWZpWnU3Q1kyOWIxWFh2bTZKSTNHZDd4NVNXN0ZM?=
 =?utf-8?B?VU9NMXN5NW1yRlJVdkhqZm5GelhnK3JaeC9ydlRGK3ZmbURkRkN2dmRNNHhS?=
 =?utf-8?B?THV2eS9pZkNWRzVxTXI0UXkyUzI1K3VVY1A4RUFCZ0hPa2JEekIyN1FMMy81?=
 =?utf-8?B?UWM3eitDOUV0b0dFZGQ5aTF5bDhYajg3RmNyK1hyelRQeVk5WlNKNmdLOHdO?=
 =?utf-8?B?T1RZOEptY1FoMnMrUysyN0Y0VVRDLzV3RjRqS1RiV1QwS0s4dElmV244amRs?=
 =?utf-8?B?OG9nU0JBVzBrdXY5aXV5c0VjTW9Ob3hjak0vcUVLWjJDSE1QM3lRK1BHZWZQ?=
 =?utf-8?B?MU1WdnNIRHU1U2ZZWDA0QXpPdFNZRHFRS1NtaFVKRFBTRnUvL092eEVmemx3?=
 =?utf-8?B?eXRZbGxNTXVhTFVZQnZTeTRmOCtndjJ6MkFBcmN4SzM5RlVPa2R5YTFCZ0xS?=
 =?utf-8?B?dU1oVkc4Qm8rdEQwWFFOOEUyMUE4VmlQNjBmcFd1ZmxwUkJZazFXeEJKREJl?=
 =?utf-8?B?WCtPZGJpaVZnQjZTR1RseFk0UVJ2VFNuQnYxcEpYT3ZvYUVtQ0M5WFoyNHpC?=
 =?utf-8?B?TWFCTTVNamxjcmdjRnhkc0ZiOWNyUHN5TVB0MHkxRG5wMTdhODVGYzJqRFVi?=
 =?utf-8?B?dmdpSmRCeVR6RTVDQzJNbXFmeWkzYnJ0NlZxeFJuREcrbHdnSW0xZFdZQ2or?=
 =?utf-8?B?LzdFcjVmWlhrQzRyZnA1Z3pQSEpjR2NVcWtvODJTMWZmRDcydU1CaDY2YTVB?=
 =?utf-8?B?Nk9xTkFDa0JicVVBUDhwM1NCMkhrSFNibDlLRjRvTmxJRjRPRmQ3RkFKR2tr?=
 =?utf-8?B?cUxIYXp1L1Y0QlN4ZDJjZWpaZ1NpRTh4TU9paHVtU1prQzFXMThQTStwQ2VB?=
 =?utf-8?B?UU9mSlN0SXBQZHN0U0dNaUR4ZDJXeWNqSzhEbGhWUDRuZlZ0NVhabjJTN0Y1?=
 =?utf-8?B?YzRNeVlqcEdQVXV1enhpL3FsM21YaUtVdlViSVRKSHoyMGFDVzdXLzFJbVFY?=
 =?utf-8?B?YU1lU205K09HRkdPV21OaXNWeVVKZnpsVS91K1RKQjUxbmxuN3BNNUd3MTlo?=
 =?utf-8?B?dFdSMlVLMnRnY2pWZm41RVlOWUs0UTVxOC9HaFVhaVBiMWxITzRrNGs5bTF1?=
 =?utf-8?B?cEpkK21ZN3lkSVhCNFZZaVN0WXNrQkZGYmFVbGhMTkNHS2RqczdpaUtZMy9Q?=
 =?utf-8?B?MkJlZ2RHb01XMDVPa21BL3VqZXNJTDliTU9Jb3B2REd4bzBMMFFOTDBXcWUz?=
 =?utf-8?B?bi9DYnlTTytGejloL1RQYWpramwrUXF3WkRMeVlKMncxem9pc090ZzJZRmFX?=
 =?utf-8?B?MHBOQUpBMEhwalRUczNQaUdZUXAyVFg3dnAxMlcvczYydkVhK2Q4TWZGL0Ns?=
 =?utf-8?B?bkZCT0xnaUYwdldNczZQcmdvOHhmb2dlVkIxcDhJSGo2T2wya0ZNUlM2dnVI?=
 =?utf-8?B?cDFGbXJxUmhxRXQzT3Z2ajFtZ1BRTS9FSXdDQWhBdTZJeitSbzdGWGxFTXAx?=
 =?utf-8?B?TUNrQVRNdHhrdWRnZzBlNkg0d2tYb0xVK0wvR3BaTDdzdU1Cb0J5cTZ2L0M0?=
 =?utf-8?B?amN0SDFPWFVVTDBjdUF1bEgrZVoyd1R4SmMrblVNMVhzUEtCRThFc09lSGZl?=
 =?utf-8?B?K0R4QVdmR1dNVFBib3FUdUFGTHYyZGtvSXJRNUdsWERKMENqVVVlSHdRWEpq?=
 =?utf-8?B?cXVzbm9NQ3hpc09aeDlnQm13QkY5N21XVFpYd0o5dGtGbWg0aHRDNkZPRE4z?=
 =?utf-8?B?OTZnWmVyejY4Ti8rMEZjcldqVXhhK0MzRGRiM204ZHhIWVFXMXVzUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2b476e-7a33-4d08-e2a1-08de714b2031
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 13:14:21.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06v4yA1oYAVJIlbijzOZivRv5tB+kKNhippUWV/FW5zGG7Gsud4Tr2BWiM5YchT5FzjhCXB5CVbO8nindtCyng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431

Hi Johannes,

On 2/4/2026 8:46 PM, Johannes Stezenbach wrote:
> On Tue, Feb 03, 2026 at 12:40:30PM +0100, Johannes Stezenbach wrote:
>> On Tue, Feb 03, 2026 at 11:08:49AM +0530, Vasant Hegde wrote:
>>> Can you try below patch?
>>
>> Sadly it doesn't work, same error on hibernate.
> 
> In case it helps, I booted with amd_iommu_dump=1 and got this:
> 
> [    0.108593] [    T0] AMD-Vi: Using IVHD type 0x11
> [    0.108594] [    T0] AMD-Vi: device: 0000:00:00.2 cap: 0040 flags: 30 info 0000
> [    0.108596] [    T0] AMD-Vi:        mmio-addr: 00000000f7500000
> [    0.108600] [    T0] AMD-Vi: PCI segment : 0x0, last bdf : 0xffff
> [    0.108623] [    T0] AMD-Vi:   DEV_SELECT_RANGE_START        devid: 0000:00:00.3 flags: 0x0
> [    0.108625] [    T0] AMD-Vi:   DEV_RANGE_END         devid: 0000:ff:1f.6
> [    0.108706] [    T0] AMD-Vi:   DEV_ALIAS_RANGE               devid: 0000:ff:00.0 flags: 0x0 devid_to: 0000:00:14.5
> [    0.108708] [    T0] AMD-Vi:   DEV_RANGE_END         devid: 0000:ff:1f.7
> [    0.108710] [    T0] AMD-Vi:   DEV_SPECIAL(HPET[0])          devid: 0000:00:14.0, flags: 0x0
> [    0.108712] [    T0] AMD-Vi:   DEV_SPECIAL(IOAPIC[32])               devid: 0000:00:14.0, flags: 0xd7
> [    0.108715] [    T0] AMD-Vi:   DEV_SPECIAL(IOAPIC[33])               devid: 0000:00:00.1, flags: 0x0
> [    0.108717] [    T0] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
> ...
> [    2.617032] [    T1] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
> [    2.617045] [    T1] AMD-Vi: Interrupt remapping enabled
> [    2.640571] [    T1] AMD-Vi: Virtual APIC enabled

This looks fine. EFR says we have required feature bits to enable GALOG.

> 
> I'm also attaching the ACPI IVRS table.
> 
> Side note: I wanted to check AMD documents at https://docs.amd.com/
> but the "Create Account" button doesn't work. :-(

Account is not required, Looks like location is moved. Please use below link.

https://docs.amd.com/v/u/en-US/48882_3.10_PUB

-Vasant


> (And why do they require an account anyway, Intel and ARM don't...)
> 
> 
> Best Regards,
> Johannes

