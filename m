Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7E4C81
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771826560; cv=fail; b=nr4i3ianP0+GeEunPNB7nXM40qmKBkrbZphUPhl+biQMeEIFNWGEvZGyyZLRBhqCrVkkOfRlTaddJMMfKVnihNKmhAl/jXcp0bGAt5kPzXn1xHZlylJ58OaXRjgrP3d+THYFDcpwwzabwbHsj01JfheUbDjd5w7WQBrC4MZQ47I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771826560; c=relaxed/simple;
	bh=zpAK3JjPg6eBKJamGJEjoao9kQYMslG5r5QQS0r9+jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gbdrF2T0iAfg0z6bej4jnIHvF/urtYm7yZIcmbb8C0e+NXY1Vxf7wjuzuW64sIbHZxAt8N6glJZFn5Q1IU6zjULK0VFvfmGqU0dJO8Ko628RlN07AYqvE942uks1qF5DLpw8XViUPmK8aYQVCmijeBgsgPY8JcyJOAQ0vSFvPcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=od4rzfe8; arc=fail smtp.client-ip=52.101.46.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="od4rzfe8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unoAO6rOe38J3PkmwwYeE3n3ICm6u+jhZ28nkc9CGQOoj+R7l080WR71xGWBEBrh3kBsup40+mLveb6qW3QZSyE9oUT3U/FMwh9/NfEk+HJJXE5hJo7Jk1E2avvuWUs5stRhI2d08AbPRaMP0BVKx0MDS2w5DuQsrgizJ9/M/7Von25JCZ9HvMVLCOPGIDXVVh5t46IbOr4SZc9lo9RWC9nungwfniyXQNtCoMCJtpkBMJveSnRlJNUMsvqShYt2JpbAKKoqbd7KLc1O2GTZPsQQlBYI7UZbUUP4ocoeAPIiGQt5srwcW7K/FM9iGNslPQZ//1JtZh0PLx7dpKtDFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MYtvTe09iKDiaXnULo9uSiKr2JyCRFlE34iVTYEEDo=;
 b=rbvEO98bJJEaKCmce2d6/OMbLrTZIEKQHyfXt4zMVUCnnSUKRWijbG3SGMO/3KMDjy9YjKDXUB1o1kZoDKNneVwG9P9Nhv7rz0Q9+VsufkPbEmj6qoEyj0T8T8ZKtnqQ/09mPBv7i1FnuAHJS0QDvKrMKPsmgLJ2qLpcrB+lVzOq5G/vSTB95kZALhGLow3KunjzZsrCKBjxDaQFcAUFH05gWvhQI9Kl+Yl7lLSKaOU3mtTSf80G5KpwT687eYOQxntWVRjNgGa/IZPZpK5jMq0Sah3a0GVHWaRkbGDjOoJfkmeCK2PtpA/ATajA+OIdwdyUEFjDIdWe8e4IKcMswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MYtvTe09iKDiaXnULo9uSiKr2JyCRFlE34iVTYEEDo=;
 b=od4rzfe83i9D337lSt39mxfpUuuUqvMyVIxccxt3xP8iwxKMFuhE5e56Cu7KGtxqzyKJsMEpr255w0acP+3PBosRoxcVSVYUKyYP2m3LGVgFsaYicJ03TQWt1fNqzHkcUnv7Vrxz6F5JacjzyyhSMXnXBXE5qCOn3oWy2jwP3Js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 06:02:33 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 06:02:33 +0000
Message-ID: <a847533d-2488-46a6-9f32-79309d7525ce@amd.com>
Date: Mon, 23 Feb 2026 11:32:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Antheas Kapenekakis <lkml@antheas.dev>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
 Mario.Limonciello@amd.com
References: <20260221235050.2558321-1-lkml@antheas.dev>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260221235050.2558321-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::16) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0cd436-be40-45b9-bae2-08de72a122b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0J0T0lmVUhoM2ROaDhKbE1UYnBuR1l2NjFRSjB1WE1pamRqVE02Mkc5YWV0?=
 =?utf-8?B?WDFlRG5BOTdPL1hONEFLZ3NPMitLWjR2UElIRUlMWDg4bEZNMVRFcFBGeTBj?=
 =?utf-8?B?Y2lKdE1WL016RUxaaTIwMVFkRXRCWEdiRGJYeWdibUxnMmhwVXpRenpTVEZ4?=
 =?utf-8?B?bzlXdmZnbjNzZFlIb1FPNFdTZExLRWM3MUlpY1kzR2tzTmlQVFJrb2daU2lw?=
 =?utf-8?B?aHJqVDM5bHNVTEdYRGkwT1JXWVVacVZqeEhxZDA4eWJzOHJDemZFelRRQVdS?=
 =?utf-8?B?QjRtWEhHZ3RJdlQyWm00eDZ6b1QvUnJWMVF5VjEvMkxpYXY3R2ZrT2d5aksx?=
 =?utf-8?B?bDlpLzQ5YmJmMmNwbXRtdENJekVFbnFKTGdpQVl5RVkxaVRJQTllUmdLL3Zl?=
 =?utf-8?B?L1NKNTk5STR4WFBDL3pCTXBFdnVEQ0RMY2Jka3oxYkN0TW1GZmVhZ1B5Q2FD?=
 =?utf-8?B?Ulp2bVorVzNadEhVa1VGTlM4TC9XcmxqajloRFhNRG5ZS0RIWWJIOEdpd2hB?=
 =?utf-8?B?ZFl5bGJQeHorb3hMMWxnSkQvcytVdUJ5aVUvcVRON25Ba2tsc3NZditmZ2FD?=
 =?utf-8?B?d09sVFlLVmhqR2xrTzc5Q3lrOWdvNnVrWlN4TGVFS3JLaHJramEreWJyQllZ?=
 =?utf-8?B?enRFZXNxQWhkMlNwV3ExZGRHbUV1WVdBNTcrSkN3cnlBdTgyWmQzUGZpaHdj?=
 =?utf-8?B?bzkyLzZ3UHMwZDEvTGdkSzRVK3dvTUx3WXBxTWNETzBMT2lzcXQxa0p0OEVB?=
 =?utf-8?B?TGNDVUNkcnc0VkUyNld1VnVWZTcxZnhpSFc1SFpCd3pFNjJoT3VuUFY0cEln?=
 =?utf-8?B?QkpZeEl6WkZTb1VjL2J3YXdSL0gxOXZFbldqU0NzNjNITkM3dHVxU0tlc0hM?=
 =?utf-8?B?N0V5Rm4xOFlEYUxqN3d2Ulp1SEVvQ0dHelVkWHRDVG11ckNHQktzc0FvTjBm?=
 =?utf-8?B?azVONEk3MHlOWHgwVUpxYkhQcGlNYlRMdEhacDBwRnhmaEhvQTlOS0RvRnFt?=
 =?utf-8?B?UktGTW1NMUNnSlQ2TzIyMmJoOFFsZGJIajdhZ05GQ0lSMFN5WmVGbkJhVnQ2?=
 =?utf-8?B?UjhYVzhKZ2ltbkoxZ3AzU2Rta1ZJK29MakFISC9jcUp0VWkycHhNdXd1TGx6?=
 =?utf-8?B?YjB6cVJ1S3d5WmY2eFZKaDExbERMdUlBeWtSZ0xGbi9xRGV6UjkySklid3hK?=
 =?utf-8?B?ayt2bjQvd2M3bkZra3h6a25rUjdYWUhZd09xU1RTRUkrelkyVFBsZ3J1K29j?=
 =?utf-8?B?NG9SUHFKRS9DcE83NzJuV3JpalJWbzY0bW1zZDcyd29PKzNZb3RLY0NEdmtn?=
 =?utf-8?B?bFd6OWk2UkNnSEtmVVpiS0x6MzlMdElUL094bW1tSG0vK1lQK2p0aWtRNWdW?=
 =?utf-8?B?NFIzV0FUcFQzSHVJdVByTkRGN2xkMzFQSjE3Nnp6NkxwQWhCY3QrcG9RcFBR?=
 =?utf-8?B?TFBFcmVYWk1nSG1MTEc5QXAzS1lwb0FkM3NtMHJyc0VWODN2eTh0a24yZThW?=
 =?utf-8?B?bTdCL29NT3pxT3hnVXM5VW5KZHRaRGs4SGY2NnV5OUtzRXdDWmk2QUtaR0N3?=
 =?utf-8?B?NWZFY1lZcWlYN0RSNStEeDdmS2I2d0JaZlpINXAvQUtFRE9hVndma1RFOTIz?=
 =?utf-8?B?NjdqNGpnVlY5N1N6V0tsTndna1J6dmZNajJLTkVRanNMUlM5VnpDUlhKSFRO?=
 =?utf-8?B?R3FhVHBJc0VVbHpsYkZiQ004L2NOSis4WDVUMTBqUjJiclBaaFY1SzFkYWFK?=
 =?utf-8?B?ZnRKSllxUVMzVERLdlhMNVJMdFJhbDl0WnhIQmtFMVJYM2VlWEQvT295ZTBL?=
 =?utf-8?B?cjlFNnZTWGVOMWRvM2FkcUJQS01xTzlQKzJQWGhtQUM2RCtBZENwdmIzSHVW?=
 =?utf-8?B?Y2hJTHp1WGw5MEZvME1pbUFMRmxsb0pqVDNrRFdtTlpkOTMwbThETHZwYzRP?=
 =?utf-8?B?ekFHeUVZU0g0Q2NBNVpTRUphNVlEa2xRV0tCT0kxSGZpMWJYOHQ3QitJYmU5?=
 =?utf-8?B?ZWlRR2RZdEtYeGN6anVYbWY0MmRVZTV6UXRiQzFpUjNMRHlPc0tyeFdxeEti?=
 =?utf-8?Q?t6UmYa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eW9kT3RzSk5BVkQrWVJiL3RiTmVENmZzdUgzdEg1UWI0clVNN1h2djNxVDla?=
 =?utf-8?B?OHR2NHNOYlZUcDRnUjdidXg1Sk9sZmZmdFZKZXB1Tkg3emlIenJCSStvNklj?=
 =?utf-8?B?NnduSzBCaEFMSmxJbk0wWmZJbzFzdjdKV1EvU2xIVUhmUFBrTlFkTHVZNWVN?=
 =?utf-8?B?QUxsd0dabklhNHJwOFRYVHBhZHdBSFlOdUlpdjkrMGxBVHNhQ2YzSU9qWnhE?=
 =?utf-8?B?czgzNm0wUnhuYjB0Y0wrUDRPb0wyU25mMmJCWTI5U0xKZjQra1FXNXcvNDZN?=
 =?utf-8?B?Q2NYR3FKSlAvL3Y5QkhHeEQ2djVkV0R3NjNEaktnYnlCZTd6djAwVDVacWpW?=
 =?utf-8?B?RVRDazJQMnlDNUQ4cldJWWxtUkk4eEt0TUFrMVpXdU16c1A1VkRkMFpORlI0?=
 =?utf-8?B?NmhtTjdoQlRtSFQvQ3RhSFNZVVVyWTNPcFozYUZ2Nmo3SEkzYTNpME5zdHVx?=
 =?utf-8?B?QUNJbFdSRjdXVDhFR01ZU1M2MWpuTXhPZGhlTGJTWVhzZWkxYnY5MHlDWHpo?=
 =?utf-8?B?czBTby9mUy9YZ3c3ZFNMYUVrMkE2Q0RWb00vZVdXcVJwM1U5YUtDTGwxZkVO?=
 =?utf-8?B?R0pxcTRSS05SZHpvbW4xOEQ0T3RlVnBYMThhS3FOU3dHUEczbnJycm1Ld2Mx?=
 =?utf-8?B?L3VMRVRLUys3NG1DZU1hS1EvTEkyWlViSUVDTFp6SG1mTnUxT2tpWTZUeDV3?=
 =?utf-8?B?ekgrZWMwTTd2bmVPTEN5Wi9yekZkVkZyY2EvcDNiaDZKTlpFVWZNSm5NZ29w?=
 =?utf-8?B?Tnd6VXJPaHVsTEMyeTZscVg1VXYybFhCMEl1VmQzK20yYTlPcnRlVTdRalZ5?=
 =?utf-8?B?N09kMGFWZ09ySjIrRnJTckgvY0Y0L1E1ZGpKVlZCdVBIaVZzRDRhN2N2SFkv?=
 =?utf-8?B?K1FPWm1CL1AzaGRjRHdTenFhdGEzdlFGV2RkLzU5cTZ4WlI4UUkyVzBwYXQ0?=
 =?utf-8?B?LzM0ZUoxN3ZGQ0dLdEtLUWVzS1EzcUtLZTdpaCtOQ01nUFdFSUdyR2ZRNndq?=
 =?utf-8?B?OEhPTldVS2lWeHBjb25UQnA2N2lWVEV4VzVLaE1RUmY3OVdDa0Nrc05kZ3d4?=
 =?utf-8?B?V2M1NTg4QWVuNGcvSWF6YU5OVk9hQXlCVnFFcUk2U3VGQzNjK3hoS2gyUmFa?=
 =?utf-8?B?Q2c4R0U2aTJyZ0l3cWpiN1Nwb2dCenNKMlZkVUhONlJpUVFrblNDTkdwSklE?=
 =?utf-8?B?UUozZjBZc0lGc0QzM1NrdURjc2RmeUpvZVpKL1Bsb0xIdms5L0xSK2FMOG9n?=
 =?utf-8?B?alhNdlAzd3UxWTR1US96ZmVLanZhT2RBZUZzcWR4MXJHdEI4Vmc0LzFEa3Fl?=
 =?utf-8?B?bGpxV1VlcVN5cThSMG5wTUFlanR5S3hTVXh5Qk54TUV1VTNZZGIwb1JKWWd2?=
 =?utf-8?B?VFZ0bTI4MGp2VWR5NS9GUk5XSkY1bkw3akdodkxUc1ZkTDFESUxsSE5RSVlI?=
 =?utf-8?B?L3M1cHR4eE92WlpCYjBSK1F5MFptWGROL1JXQXh1U20zTXlHd0ZmcHd4RGdK?=
 =?utf-8?B?U3pKc3hzTzlPNmsvYkFzVW1oNk1pcUc0UzBQc3paa1pkU29ZU3M3YnU2ckFM?=
 =?utf-8?B?d1hudXR3a3Q4T3BiM3dYdTRPSldTOUJwZ1NVQ3VEZzZHTmMxZGxHK3hJS3po?=
 =?utf-8?B?WHloYlc1VkVrc0pvSDgyRzNSaDBJWDlsY1BwbWlpMXFrUms3elNxdVhhV0hM?=
 =?utf-8?B?U2xLUEFZQnczMzFETXFadDVUbHd3MU9yb2Y3WWx5ZDJEU1dhQ0lxM3ZqRng0?=
 =?utf-8?B?R2dxQnFoeDRVaVM5TnV1UnZUN1kxYit6cFhId2NZQUFUWVVmdnE1a003M3gr?=
 =?utf-8?B?K0tqbEpKWDllbTZDaExacnVLVGZRb25PY2U2S0hST3VDV1pRVk5LODdjcU1l?=
 =?utf-8?B?TEJrbEJTMGlqSUIwS3BkbFNXUHJTcGRnc256cGJNUmpBUUpPYlk2ekhOaTdX?=
 =?utf-8?B?QzJTVThmSGhIT1ZIV3dyQ3VmaG1iMXhmZ09pSGlXMEZ6eFQ4K2loR3VGeDZR?=
 =?utf-8?B?ei82T094dnNOQUgzUUUwQ1VGWWRKNHkvdzYzKzNsMEZlQzZrOC9aRU1oTU1S?=
 =?utf-8?B?SGE1U0NLQ2N2SjBSLzBLVkNTMUhLSVpNMlZyc3l4OS9JN0doZHFYMEdBWXJl?=
 =?utf-8?B?UmY0WDBHUmRGVjZpUk1qMFlQT0dtM3RiaUMzKzZGZTVRTGJyY0FTVUJyNHpt?=
 =?utf-8?B?QStzZFZVM2hxbWpraStXeVBydDRkbDdvU1FXbnhTS1hHQUZOT3ZWQURCUENV?=
 =?utf-8?B?ejRCazRVVWdaaTJsdnBLVDBuby9rdldwYUVWcXE0OEk4QjJtWFZtaFVyTEZR?=
 =?utf-8?B?OG1XcjZtcFJuUW1MK2R0Nnh4dDZ4NE83TE16cElaQmxHcTFoTXM3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0cd436-be40-45b9-bae2-08de72a122b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 06:02:33.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSRAD8em1kq8ndVsu2SLnQMQdXqcbVi6smBxZkGgcYHzZoNwl4A4Bt7xaOEIzLjiVlerxUiZ28g7A6C0aYaXSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212

Antheas,

On 2/22/2026 5:20 AM, Antheas Kapenekakis wrote:
> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> introduces the shared iommu page table for AMD IOMMU. Some bioses
> contain an identity mapping for address 0x0, which is not parsed
> properly (e.g., certain Strix Halo devices). This causes the DMA
> components of the device to fail to initialize (e.g., the NVMe SSD
> controller), leading to a failed post.
> 
> The failure is caused by iommu_create_device_direct_mappings(), which
> is the new mapping implementation. In it, address aliasing is handled
> via the following check:
> 
> ```
> phys_addr = iommu_iova_to_phys(domain, addr);
> if (!phys_addr) {
>         map_size += pg_size;
>         continue;
> }
> ````

Thanks for debugging and fixing it . Just wondering why can't we replace replace
above check with pfn_valid() ?


-Vasant


> 
> Obviously, the iommu_iova_to_phys() signature is faulty and aliases
> unmapped and 0 together, causing the allocation code to try to
> re-allocate the 0 address per device. However, it has too many
> instantiations to fix. Therefore, catch ret == -EADDRINUSE only when
> addr == 0 and, instead of bailing, skip the mapping and print a warning.
> 
> Closes: https://www.reddit.com/r/cachyos/comments/1r5sgr6/freeze_on_boot_after_kernel_update_to_619_fixed/
> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/iommu/iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4926a43118e6..d424b7124311 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1224,6 +1224,11 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
>  				ret = iommu_map(domain, addr - map_size,
>  						addr - map_size, map_size,
>  						entry->prot, GFP_KERNEL);
> +				if (ret == -EADDRINUSE && addr - map_size == 0) {
> +					dev_warn_once(dev,
> +						"iommu: identity mapping at addr 0x0 already exists, skipping\n");
> +					ret = 0;
> +				}
>  				if (ret)
>  					goto out;
>  				map_size = 0;
> 
> base-commit: 57d76ceccee4b497eb835831206b50e72915a501

