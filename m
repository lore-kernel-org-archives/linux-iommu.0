Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011052.outbound.protection.outlook.com [52.101.62.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2632F749
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057327; cv=fail; b=CjjYIMMr4ayM6r42/DTKn+j5H5EKeT8K4ppKaEV/13+4OwltP8zxJSDgokLMEbohE3zTI9AsIb3H9RiGQPrKdLTBMVpFkaJ/CEXCIbNyXLa9nadJ8ZM8lm5ZhfUdyp5igGuiTXruON/3mv1rY7nlVqGnrpHmleOlpVbnFe2tfsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057327; c=relaxed/simple;
	bh=1TU0a1J9fYsfXmfZJz6C18x3MizG7c0OyIO3P3MDtY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o3hIRgIdWvaliwaQ5jQUMF7UzFb3ALYIdRldygekCQ5zBQJE0i0yVRSVH7XZ78GxExMoSR24oAPO1EiGnurWTvHsYCbYZ5VVvIfJ0/WL01awY4SL7PRc51KO5iTzV9QsZTXXdLPVRapJF1JWtwwr6e6+BtqPhM3zkwHCF5w6c44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PEazRWDW; arc=fail smtp.client-ip=52.101.62.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PEazRWDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jh2kHgKO+RHxEVOS7go9EDNg+RMYJEzWYQSxz6wggowCWOoscLDWL+UfNJ4H84UK0RlP/aJG++AxGoSLLzFujoH6ZM0J0L/WkIvz4LN4t7RXfBbnubMX+01Ylu4TGv9ktsI3hevMXOVtte6WT9mkiQ0UFA3ySsganjs/vfPd5acyzvUId4ZF+XkFBQdTDi+EVNxBFoVVCUAsEO/s6mxsRza8ufWx8bhN9PzIG6Zx/H40FCpz8909H70+pY0Rv8vdWZmW4d0mMeywaB3g/crrl+xjweawn2uW+dUz2mjslvefZIDgn7LpmRTfm4Zm3/B08nDm1aQ2Vj6ZdjV7EAgf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMRcif/MuEe33GkigtJYORBZxlg5emDQ7ciQXcgUwCY=;
 b=EUKeX3HWEx2mw/cv5X34HaUPlcNsGmC0LvTPQy3zp8mDSA5EGIg3x4s+Lryn2Hl78cn0AE6OT8cBunDrko47MGrfY83MP4UKVn/pnUF/yRWENZcWWF5vpccVwaB31pAqQ//AhNwpohaKyKeQBQo7Up1YzVwmkK4mXMxXHtJdJqPx4r3fUsrcywR++7LgiBBJqhiZJ3NTlwe4JGlMVegmoBJTauEPqO9/M2XinXUOjJjXkrjntl0D1oFSywg1h5gpa5wvQe8dmFtuawvHz2nfwRJiwbevEBJ8PRbQ2Hnm1Hc/8uIXdu4vYBl9O7qsgMAu4BF8oRGo8CVfVW11e5lfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMRcif/MuEe33GkigtJYORBZxlg5emDQ7ciQXcgUwCY=;
 b=PEazRWDWaTjrrCP0HeWsE/xB1zbkggDn/+2UwvmyWG5F3Y800mRtYMuJuxLcYcZfpkuGwJRjIbHgvakESMzAoLwfOUAHZqtK59NNbobfpNh2W1Zd4bkPSKkdwVKvlLbZnySPNU/5yaLhQ2b+uLvK73NFatPUxWhc/Hmsp9DPA6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.12; Tue, 21 Oct 2025 14:35:20 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9253.011; Tue, 21 Oct 2025
 14:35:20 +0000
Message-ID: <62bb3eee-588a-40eb-a2c7-739166ac774e@amd.com>
Date: Tue, 21 Oct 2025 09:35:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/amd: Add support for hw_info for iommu
 capability query
To: "Tian, Kevin" <kevin.tian@intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "will@kernel.org" <will@kernel.org>, "joro@8bytes.org" <joro@8bytes.org>,
 "jsnitsel@redhat.com" <jsnitsel@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "sairaj.arunkodilkar@amd.com" <sairaj.arunkodilkar@amd.com>,
 "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "Prakash, Prashanth" <prashanthpra@google.com>,
 "wvw@google.com" <wvw@google.com>, "wnliu@google.com" <wnliu@google.com>,
 "gptran@google.com" <gptran@google.com>,
 "kpsingh@google.com" <kpsingh@google.com>
References: <20250926141901.511313-1-suravee.suthikulpanit@amd.com>
 <BN9PR11MB5276E624B7CD6E1D6BA1E12B8CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <BN9PR11MB5276E624B7CD6E1D6BA1E12B8CE9A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0191.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::24) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: f89ae50a-20ea-4a2c-70cb-08de10af0f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHpxdHNQUi9OQWVuMTZSVkZzOGh4WGFBTTI5S0tzWElPTWlZZnB6U3JWWlUy?=
 =?utf-8?B?cm1ObDl3RG5GbzQ5RStBQXE3MlR0bmM4Qnc0aU5ja0NNdnl3cEY5UFEvUVFF?=
 =?utf-8?B?eUhkZDlPSmM5enpOeWt5cEFuWFhZTkR6OFJYQlNqQzhELzB0ZlhBYXkvTVZG?=
 =?utf-8?B?MDRBcUFFenJYZnE3bnMyTVdGTzZiZDczZnpMaVVNTU5PRkJoMGJ5VVh6ZjV2?=
 =?utf-8?B?ZUZHMi9Zb1ROZWFOK1Nvai85eHBkZGIwaCtreCtGNld6eHZIK3hlZDVQZEgv?=
 =?utf-8?B?OVlhc0p0QUx4ZzJFMUJUS0JrNno1SHc3NzZ3ck1DVE5rakV4aWpjMDduVHlF?=
 =?utf-8?B?SGV4WWhkVml6OGwrZnZOR3I1R0JHemdzNGJCZXMrVE9rRlE0dURIYStpOGtz?=
 =?utf-8?B?MjU5czdENndzRWxXSEhpc0VHQ21RQmt0aU1BMEtZWm1sWUw3eWtsVVNsdkUv?=
 =?utf-8?B?aUhoNnhIUDk3NEltbm91bHFSMGpWNEZqS1N6MWNWUDNOSU9BTFhLOFg4NHk4?=
 =?utf-8?B?MVRiYWNSZ2I5ZGtpMEdtZ1lsZnEwMmVrOWZscE4raFRYMnhHcUhTOE44c0Ur?=
 =?utf-8?B?WXVXb1NFY3dnRjNteHRRNVVWSjRWNWJieDNCWEZzOUY3QWd4dFBiL2FhWkRu?=
 =?utf-8?B?alZQRTUvaVFJNVQ5ZGpzbjhPbkRvN0haZ2ZQMHRwSW9MbHZhNUZMcTFaMWcv?=
 =?utf-8?B?dGxVNUl2WExJNzZ6elFlcUhTTENSZ0FYbHZObU9GVHJYNkRmMnBMd1lBQTA4?=
 =?utf-8?B?YTFZblhGWWMwT25HenF4VWprakhra0tCZUZrMTQraG9SUmt5U21nWWlNNGtY?=
 =?utf-8?B?VUd5RC9ZSUEzU2FnWEV6SDN2UDhpQXZBQU1mL3daMFAyQTF0TklZdGVKZkNl?=
 =?utf-8?B?WmNqM1VGOXRaV0hyODkvSTBDbEduQWErVElWeGVrNW5uVDFNYzdTdUZBUFFo?=
 =?utf-8?B?V0ZCWmdaMllRczNhU3MxNTBkaGNBdVFKRWZ0eFVmWUo2TCtGdnVwTVcwbTM5?=
 =?utf-8?B?cW9MQU1LQk53SUdOVi95Qm8yT1NaYW5jY3U3bmk5dnNZMXA5eHllM2R1VS93?=
 =?utf-8?B?TlZyaDlKWDNISTRSY0NDbjZWeWJVR01JUnNNNjRIbzE3NXlIUlhPQmVGUVow?=
 =?utf-8?B?QTE2MnhNNVE0ZjJ0UjBqNGNWRzdPeFlTWVpmalFhcU5UeXNudUpBNnBYcXha?=
 =?utf-8?B?MEdlbTE3ZUxCQ0h0UWRGb0RtTHE3dWVNQ2tNaktvLzNWZ2haZEMxb0w3aE1E?=
 =?utf-8?B?UVVtT2RGdG1QTitCUHVjQ0trMU1GTVB1ZCs0OU9RSWorMjFZMVovUTN4bDlt?=
 =?utf-8?B?NkFPNkhVSjVrNzVpam1TVDVEOTJpWVZLVld5ZzFlUDRiMFBDRWh3Zll5Qnp2?=
 =?utf-8?B?LzNUbWpwVDNLRWExK3RSd2wwMVdtTGErS2xhYWFDWlA3WU5MRXBVK0kxbzll?=
 =?utf-8?B?cnZzY1dqYmt6aFBJYklJNWtYcmJ3ZEcvWktDU1ZwVXNIZm5zRmJBWkNoanZ6?=
 =?utf-8?B?MllQanQxNWhLMVpmSWh3YTRUMTVsLzdUY2hjWnpVeDIvTnd6MjZmV3E0d2pv?=
 =?utf-8?B?a1lKRW4yc2psS2p6Q1AzQWlTdTc2a0VVbHBxck1jT1BJdTdzY09udlJqZFF5?=
 =?utf-8?B?Rjl6OXVLRnVUMjJLNDAyeEYySWdFSk00amZzTVVDRFl3dGZla2ovc2pmZzhK?=
 =?utf-8?B?Q3BRZUpuUE83WXNYN09aTHNJeHFPMDI4WGZ1ZHVBaHJsWDdXaVFURGs2Y0xa?=
 =?utf-8?B?Y2pqREhBVnRQNWpvMDhIbWVVZk5nQlVRcnduVGluUjA1N0lXUmlISUtEQ2g1?=
 =?utf-8?B?VFNzUm5sUnVqYTVwdXBGa3NDS0NQZFJQRkkzQzlCd0MvMzRyOGxEQzdVSVFY?=
 =?utf-8?B?ZG9TbENtT3FVaU9xZVpoMXNNL2puMGtjUmdqdnB4cUtJUXZyVlN1Vi9GQ25s?=
 =?utf-8?B?dFZ4Y3ZZeDk5SVQzWkJFZm5nV05taWMxdUxEeTRxTEU3cUVaWUVtRHU0WGR2?=
 =?utf-8?B?QUhyUXVWNFN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdSWGRxNnE3MVRrZzVkZTVJd1lrTXBESUNYMEtjVHFLUjRrS3FTdmw3UHhT?=
 =?utf-8?B?V0hEWDIwcGJtS1B5N21jSEhYMTRmRGtrYVppa3V6Z2hsMzJnMVFUZXdDNnc0?=
 =?utf-8?B?UlRCaVZmbGNpNVdWVGl6bE9lVEt4L1luTm9UeHZNRFFKeU1mUnFRQ3dVOXEw?=
 =?utf-8?B?WjR3QmRXazNWWGFkL1FKT3dGeW9nS1NBa3JZenQva0dFWXVHUUNHV1VTaUtZ?=
 =?utf-8?B?amQyNUZ2aUtuU292WWlPSjMyZHVmREtDYmRKdTlPYzA0T2xXZm1rYkROdXlE?=
 =?utf-8?B?MU5mdjVzTGF4cWU3cVZTbzBKMDBZUVo3S1E1MjZKVGkzREJjd3hPNEc0cmdK?=
 =?utf-8?B?ZGVZT3VtajhZd0toRUY0QXZpdi8yMXJiOFdaaURkYUs5cSsrTk1TQzZ5M0pX?=
 =?utf-8?B?Zjlac2xKeHZyZUFuMCtLZTRBNiszajA3YldzdzFFR09LQ1AvcUJKSzRVbXVp?=
 =?utf-8?B?TS9BQTZvMU1SV0hHRmdvYU1YQ2VWUmlNa0cySXlJMFdYbnNTb0R3WFRVTFAx?=
 =?utf-8?B?M3FlenM1Z0hCOFdmOG5RazZxeWpNQ1FWNnVJYTVCcFVhUTdCUUt1SDM4M3Zo?=
 =?utf-8?B?MklWYlVIem5vYmsxTGttTDRGTDc4VUwwVjNmVWc2dzhpNkdLNWV3QmVyWXha?=
 =?utf-8?B?dWZlYkRHTStKdDNVZkczNjZVNk9lM05IS2hBV1dlMC9LR1N0UVlwRUdGSUp4?=
 =?utf-8?B?L1prRnQxT1d0R2ZzcUZJZTRJNTZLd1hnZFdjaXgrQ0VwOW5jU2hzQ2RjeWtr?=
 =?utf-8?B?Rmg4aEg1ZEc0UDI2dFJ1eVFnOW8zbUJvcWI5NktYV0h5cUxoaUVFZFlObEFV?=
 =?utf-8?B?am96WmgxT0NvbTRRZ1dXRHZSVlB1ZWxpVStpUEkzMVBpbHk3K29MZUNiSGow?=
 =?utf-8?B?SHlvZ3VoUU42ZGNiSEwreHRTYnN1RWpsYlJJL3NCVnI0REhOVjdpUVE1Z3g3?=
 =?utf-8?B?TVRrRzRQdlVVVkwvM3dDWitoUTQ1UVpVUU1UNUw5S2dWOFVZVDVvZ21xVlRE?=
 =?utf-8?B?Rnl1QTRTUit5bk5nakhUUWlLNm5tU09NV3daL29ITDNQb1IvNjZjTDRTZnEv?=
 =?utf-8?B?czZaVGV2R2VXeFFMRXB6NWhXRkgvWmZmSVVhUDZ0d0ZXM0FnUHJxRW1RaHZs?=
 =?utf-8?B?ZUtqbjc4MlU1cWZsY0xpOTg3N2dqZW1rSm9hMVQ1dm42UE5nSm5NOFFlQy9L?=
 =?utf-8?B?UXBBdTgwV21XRFArbno2Y2JmNlVMbnBLNlNQZVdsZlBnNnFWTnUyOWNybmFI?=
 =?utf-8?B?eGROb3B6cXNEd2FmZlJ2b0NiTFZFUUp5eFFZRnhOUlRqM3JNaTRHaHVwTUVh?=
 =?utf-8?B?VzFyVlA1bmZIbnpoOCs0TnNwZ1lIdFhRM0p6amp6R3dJUng5L0hPZ0RVS0gw?=
 =?utf-8?B?ckIwbVlRZEczejgyQXVwMU1vOFpkZXpnNlprUjVpRXFNVmpmWmZMb3BNN1ZZ?=
 =?utf-8?B?OVd2Z0wrbkFhVis2dWZpai9ma3E4ODBLWkI5VnJudGNuV1ZLMFo5R0ZHUi8r?=
 =?utf-8?B?MWRMUW5QeWdOekRvZllwZHIzZlJMZWkrRzgwYkRZMHZINU5nV1A1QzVKSy8x?=
 =?utf-8?B?RmZmZ2hNVDBVK0ovOTluUzdoOVdadDQzNWI3cm9ucWFxSzRPVE5XL0RZU1RI?=
 =?utf-8?B?ZFhhMTgzQU1VVlRkNmcvZVpJR2t6emloYUVrU3J5NjdqL2M0TTU4ZlFPMVhL?=
 =?utf-8?B?STJTdGVmT09sODJpS0crTk5Yb0NRQzBybkJrK1BzRi92ZFZUMWplRWJ5RGVR?=
 =?utf-8?B?UmFoNzBhMXN6OTFIWTZSeVJMNGUxR0lyTDRIOXV6TUY4RUFUYkJMQklSQ05I?=
 =?utf-8?B?NzM1ZFNwYzRsZk5VVVQrUCtSWmcvaU5vMkpDRmhva1RQaFJZWldRMjR2bEFM?=
 =?utf-8?B?S04wSHNuaGV6bnRqSXlzMDZIc01SV05Id0c1c2FSMjZHamVaQThvT25yUzMx?=
 =?utf-8?B?dXdUSUdXd3BBTi9TWkpkQk5EeTdFQVBkUFJad3Z6ZGNpMnM0MjBZWmtOVHM3?=
 =?utf-8?B?RUFta3BTZkw4a3lMd0dDenhPcmxTRjdpcGhwVE5JLzNKOG5Bb0pYWHI0UHBD?=
 =?utf-8?B?SU9sS2F1amphZ3VNQUUyLzRCUXVqenBqOW5GSG9PT2dsek1zWDE5cWtybEpQ?=
 =?utf-8?Q?4ssXFC0rERfoEoTpTCEscK9Oc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f89ae50a-20ea-4a2c-70cb-08de10af0f9f
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 14:35:20.2337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05doXwv4AhSC2G4AbPZe4GeoMrLVE1+kkAtnMWw22ENfo+AzqGaztj3+xRqItpyahnMqeFZtAhr3KItN3nJG4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659



On 10/16/2025 2:40 AM, Tian, Kevin wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Sent: Friday, September 26, 2025 10:19 PM
>>
>> +/**
>> + * struct iommu_hw_info_amd - AMD IOMMU device info
>> + *
>> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR)
>> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2)
>> + *
>> + * Please See description of these registers in the following sections of
>> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
>> + * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
>> + *
>> + * - MMIO Offset 0030h IOMMU Extended Feature Register
>> + * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
>> + *
>> + * Note: The EFR and EFR2 are raw values reported by hardware.
>> + * VMM is responsible to determine the appropriate flags to be exposed to
>> + * the VM since cetertain features are not currently supported by the kernel
>> + * for HW-vIOMMU.
> 
> this hw_info api should work even w/o HW-vIOMMU?

My understanding is the hw_info API is independent of HW-vIOMMU support. 
It mainly exposes vendor-specific HW capabilities.

Suravee>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

