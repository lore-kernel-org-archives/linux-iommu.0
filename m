Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D78A344053
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298710; cv=fail; b=eap+Jc/8CNmMXoPbzh3iTNV04S5PAhF7qYxe0KGs0LylCKPmrpXJ/H3JQAceK6ocNW6arXGoWkRCUgk3r3QKvuiVL1R4TFgBF60sDcv7bu5qB4SRRUVH3qLuyG4YuHO0oLHL/gwsihK+XAjnIh3/sDcCTbQIwj1bNRIFTPWbeKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298710; c=relaxed/simple;
	bh=y3vS4cPeGv4MWv2h7uTWf99quguLgwmadkNz2PjmVJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qaW2swvOryxurPUwm8NxwO6mi0Pua0su5/7Pyqzq7AX0b6rifildTEBU5oeyE5Evj/Jy5HzQcF8hUxPyo1nnPWkPTSATZ9KlM16HFs+Onr86NgfyhRcrO2sjuGTxpGnijH4Hgl30IuoGnRhpGaQBfgZeuDOFqKm7hFddHWuj45w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ucX4ryJB; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ucX4ryJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqAjrwiTmUahIYajBMJIhXW3GNnaEuDRevAiSHp5jMBGVzeLnYAfG9KpSJUgTlXfXNJYe1HQMvkcqaDV3PU83RSOqvP25DgAi7QKfS82HzA3YU+VslEDKnH/0OUXQfGUV1s6z1eWpL5K6ztPCW+7kkopwZN5yLbcD8t1aCUwxhJFIc2km7DftbpUqOg95syfziHoTMQ5tVJEuNTGdQlghoJuqzabAtL6XVRyQwVhTVPK/igMy+4GWIEdkmDZq/zHZEuMfl9y7wtzQNWqOthAi1QKGHcS2WcoZOTNVtGZNw/ztDjWqgq8uypbOt0frmn0MeWAA1fh3DVHJ7VbA97eBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGLAKKK0zXGzO+NiIeCvB2qY4/agp8GMk1nXi7aVci0=;
 b=KUDUncJnaoQquJuYIvuP/S83jgiQKx4Mgf4vee8T713/Kr4cP5hC310TCrjN6Y0IGrtWa4m38evRbz3qG5NaV4qdR0FlXRaCB/fOUvmgZsk/Pp1mcYOfAq27AhoQgDcsIKuIer/Q6tDoQ1NQ79TAbzxEqnI5QS9E9MBIKpOJOTU5S0L29hsUGyeU4BXVNcYcxoDuE9mzvCx/Ri98YO7STWtU2L4fFnFpnKfg7Dtua5nWV8VMaO5B9LMMhEi6ItaDYkOEQDYun+Ek2xaCYJZziQc+KmUHEugupdihszXofMsU0chGCRgwaw5r5cTPva6Co6a+H5jV6XvxPYEQLzx0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGLAKKK0zXGzO+NiIeCvB2qY4/agp8GMk1nXi7aVci0=;
 b=ucX4ryJBMVuNfJKBDtpKzuZHz/Sy0vOfhFSyMAtO3RVJH8oiZYeSu8sr6niXM7hJ6XUIVycGmG9m4LgCBV6q+YMQudTZVDxP5c7F8BNdRPJyTCXTj8Yx2sawduXjggrXEwGORWg47P6XHwbqr9hNVJdOobzMRFT4yOwx/uM7IT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by MW5PR12MB5651.namprd12.prod.outlook.com (2603:10b6:303:19f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:05:04 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9499.003; Tue, 13 Jan 2026
 10:05:04 +0000
Message-ID: <7d25b66c-069f-46a3-9bb8-e6732745ab75@amd.com>
Date: Tue, 13 Jan 2026 15:34:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu: simplify list initialization in
 iommu_create_device_direct_mappings() and iommu_group_show_resv_regions()
To: Markus Elfring <Markus.Elfring@web.de>, Can Peng <pengcan@kylinos.cn>,
 iommu@lists.linux.dev, cocci@inria.fr, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20260112032116.49781-1-pengcan@kylinos.cn>
 <34ed442d-6ebd-4907-a77c-2c08db799411@web.de>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <34ed442d-6ebd-4907-a77c-2c08db799411@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|MW5PR12MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: c71d1bf5-793f-49d1-44b3-08de528b38ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjlqbDA3YmxiaDVvNGNwdE5ab2pMYWxvUEl2ZUEzczBFQ1VGaDRkOCtZNzlp?=
 =?utf-8?B?dVRTYzFSYWlVdkt3akZpcWwrRXlPRTBLQ2RreGk4RHVwekdwTmc3bDUzNStx?=
 =?utf-8?B?MXh3WnNqbyswcWZ3V3A5Yit2amtrZGFjUndPRHV0aEM3dGtiVHI3SVAyWTJ6?=
 =?utf-8?B?bmo1MVZhcURON21jZ2xBdlVobUFHWTFjVVR1UU0vbDRENUdLQnhRSnJvN2dy?=
 =?utf-8?B?UlpSZzVNZ2NiUGdVOStmempRdmFXQ2Uzdk1vUHQ0YWw3Uk1sc0JoSEZ0MjA4?=
 =?utf-8?B?WHdZZkFRRTE4VllObVIxOVlmTEJ3MFhjUHpLUXBwODNqQWJQVFBLSmk2aUtR?=
 =?utf-8?B?RTBjZUhhOGlCNS9HVWdjbE5nUzViajZoV1p5Z1NVSThNaGVwUCtPc2dpeFAr?=
 =?utf-8?B?V2p4d1lMdTliVHFyanovTWZTdmFpbWVCeS9BSUtTYmc0bkJmM3lzTU5EalM2?=
 =?utf-8?B?RmdwR0RmV0xpMktUREZ2SjlIc3NhbE9xTU81MjI4elR1SFh5VWZqalB4RzRh?=
 =?utf-8?B?eWxxS0ozSXdCMWRhelBQZ0F4SlBDQm1RV1FSajdiVzJqejZJSTFMbVFJUHVq?=
 =?utf-8?B?RG9BSDNPbnhseTJjQzVCVEhlNG1iZ1ZqYkRVUkNLSmNvZ01mQWRKQldGbUk0?=
 =?utf-8?B?NktPSHprdGlQb0VvVmYrOUpqUTlwZVJOeEs0bE04UHJqenhnYjk4MzhwYWNl?=
 =?utf-8?B?cnlVcmFHb0ZQMXJZSHg4S293ZUNxaHJpVm5kNEdlY0p0NzZIZXdVMWZYdHo2?=
 =?utf-8?B?VHVhZHJJVmdmYUFMQzNiNTE0cFB5c3B4bVowZGVwZkVveUUwUmN1ajdnSnNN?=
 =?utf-8?B?ZURZaUFZSXRBQjhDZnhWbC9PS0JsWTdyMDFnVEVPVnRFeXh5Vzc3YmxxQ0pm?=
 =?utf-8?B?dFVzYlYyMFdhTGgwRG1GdU5CbjRyS241MDFXd0dhVnNrTUpjc0U0dk90MCtz?=
 =?utf-8?B?UHhOZ0xDZTFHc0g2T3ZDaXBSTlFVbGxSdU10WXIwQ3o2WlJjQ0p0L1VxK2Ur?=
 =?utf-8?B?Rmp3MkZPcHYzd1FramVCM2gvSWMzSGFvaDFXZ3hNT2pyNGZBQjUzMUU5RXVh?=
 =?utf-8?B?YUE1bE1yK2ViZnlOdEdjNnlkSitzQUxRK0ltMjM1YWt5andaeVA1NU1mcGoz?=
 =?utf-8?B?WS9BS01DbG5DczY1YldGN0prUExabWpJNHc5bFlWZVArMnBtMk5FbWZHaXZR?=
 =?utf-8?B?bks5SW9uczRNMzBTNkxMcStaeC9ZNDQxMW9HWisrNkdvNU8vbzlxVVpVaGpY?=
 =?utf-8?B?elNnUjkxSW1sOXE0RUczR3lqTjc4Z1k5ZTJacGIxY0NhMXowZE5KNUhpNzdP?=
 =?utf-8?B?TFlaaE1NRW9PT0UwVVZiaURvTjdOSmpnVmdWUit3cjgvaWV5R2xGNlNVS29L?=
 =?utf-8?B?c2RPRUtZazc0UWtnTmZGZ2hMUDkzTjUydEJkYzZqZmxCTFo2d01kR1UyY3FX?=
 =?utf-8?B?UEQ0bnJRZW1MUHllS2xqS1BKK3FGaUlxK0ZKSXhBOHVRNWgyQW8vOU51bktt?=
 =?utf-8?B?MFA1VjQ2UEZZcnlzeXJvR2M1K1owRXdFR2J4OWRVN0pBbEgxMkdvWFA5MW91?=
 =?utf-8?B?M2ZQbmtWbUowRGZMY2tRTUlaVDE1OWVLZjc5NzF3Rmg4Mk5NcUxvQ2hsM2Ft?=
 =?utf-8?B?REhjbmFDL1dKQWcxN083N2pUMXNYR05YT1JPemw3L0RRZk95NkpuZk9zelFl?=
 =?utf-8?B?NTB0NkoyQkR5TEVmQ3A3aDM5MFVTWCtTVWs5U0s4djllUjQ5SmdQRTlMc1hB?=
 =?utf-8?B?Zk14ZnYzVklCYVFWVVVycHRKcFE2anBGcTVhRTh1NkpMWVpHdG1YKzRTZExB?=
 =?utf-8?B?d1ovU0RlcW9sVHdkSXFiSG1lTFl5TGRUKzN0cUN3UzlxMHB2eWVlTjNvS2FG?=
 =?utf-8?B?MGd6eGkza05lMjcxeXJFRjhuQVY3SExVSWdVNDJsR203czJiMCtnSjl4YW9G?=
 =?utf-8?B?T29iTm9Ld3ZSMFFTRTZmS3E5WGtzZTh2b0tHL2YxYW1sT0Fqejh2Rm1xNXFL?=
 =?utf-8?B?SGVJUlZueURBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTNZQ2h0TFVWUkQrYmp4SDRvUWFjMU9aN001RU9JZ0F0b1dCZGt5WjM1S0ZV?=
 =?utf-8?B?d2NEVW01TkdVRnBDQW9TazlFVVYzczExQ2p1ejRSVDJ5S1Z0dkdGdGtLUnRj?=
 =?utf-8?B?c0t3azlHWGNCNkJzUkl1WDVjcFgxRE92TnZyK2htZE1SRHJWZ3RFTGh2Q0xK?=
 =?utf-8?B?eUpjN3BFTjhxTUxxWUlJbFB2dlMzRzlpWC8rQTRDWjNxZVNyNDNYOVlxSnA2?=
 =?utf-8?B?ZmFUejZKeGZkQXZneXNMYTNKZVRiV0g5L0pzMXdxUTB1bStBenk0UDRDMW5E?=
 =?utf-8?B?UEhUcFl4QlN5bkNRUmVvMzZWNXZHZFA0bDlkeXlUaURtV2xaYkx4Ty9tSEJ3?=
 =?utf-8?B?dkNHdVZQZFZHZlBnQXRkemVGdUUvcTN6aWd0cG5nRGhQUEZTZVkrbk16K092?=
 =?utf-8?B?Um4vNTZRYWw0LzllRXh3TXhIN1RoTDl4T2tjRExYanYwL2taQmJJaFdjT01r?=
 =?utf-8?B?QXhGVkpnenNtS0JHM3VRaUlFajIwbEZ1TGNzTFdVVkJTRXVwVXlpQnVDMFFI?=
 =?utf-8?B?czQ2bGNlc0JIZzFXZWdtMlEvVlNjdytBZjQ0UnJhWENlM3dlckduVlhORmF5?=
 =?utf-8?B?bjl6dzVvRW1UUFFCbm8vUzYvL0JhWmFZRDhvRXd4T2ZWZ1gxY1RtRFpibmRC?=
 =?utf-8?B?SjZNZGFRc0lIeXJUZ09teXpHc0hjWGZwV2h2WTJpckdueTNaR2huWmM4YU5B?=
 =?utf-8?B?a0lnRUs1ZSt6aWpxZCtBalpFa3NMY2tlUngxSXhxN0tIMmV5QXJCQmFQK3pq?=
 =?utf-8?B?Rmh2eStyVCtBc3J1eDVwN3hFSHUrc3RqV1pnZlJ3WFgxazdCODFYN3R6b2cz?=
 =?utf-8?B?NTNnOG85QUY5K1NsNmR0RVp2WUhQR1RmUmZTQzc4ZkEyaUtuSFJYSlRhaVFr?=
 =?utf-8?B?WU01aldhOTlEaFdMTmFYK3BHL3M5TTF1QlpwazZlcmprVVlPWGVqYUNoSmNF?=
 =?utf-8?B?VGJSbDhhN1dGcVFjM0o0dVhHNXFaMGI5VEhCOUFxZEx2RER0dTV5K080R3Fl?=
 =?utf-8?B?UFBuaFhYd3hrVlFpQkxSbTNSR0p4aWxuSEFIbmtCc2pOYjVWeVE2endCQVdy?=
 =?utf-8?B?S2JoeDJYSHBPMFI3K3d0SW9GL1N4ZHZBMVYyUTVlUmVwWXFPQ1djRkNsL2t0?=
 =?utf-8?B?N1BvQ0lhUEZHUFJxUGs0T0t5U2Z6SnBMb0JyWlBYejVTU2RuWjJiRVNGZ2Ji?=
 =?utf-8?B?YU9KdFlad0FmSTJOblRyb0wrOHZ5NzMwS1NHcUlSY1cwOS8wQzNSR0U4WS96?=
 =?utf-8?B?Y1hZWC9RU0hKOHBCZmFTN0Q5WlEyUmtNaFNJZGZ1c1pXUU9XM1VWR0ppNCtn?=
 =?utf-8?B?K3lYc1h1OVo4ZUJoZCtTQVZVVUN6RnQrcFJwYmpuZTB2TnF0TkgwUy94S3Mz?=
 =?utf-8?B?bTdIQllmempNSkw1anFLT0VuQkFkTGxvYkUyV1VxYml2K1ZvaWlVSXZoaWlE?=
 =?utf-8?B?SjQwMUY4MXVaOXNyU01FUFlrNGZVMkFnU3VMcWRQWitRa2Z3Y1FOTWxuc2I2?=
 =?utf-8?B?Ym93OTV1QVo4UFdDd0ZUQS9TMnZ3Y0pQWFUrTWFSTWdKREU2MnBLSFBGNUhL?=
 =?utf-8?B?QlJxc0hwUnFnR1hUV2phcUlCcFVVUlIxci93VDBZcU1Ea0hTRnhtalRubUdS?=
 =?utf-8?B?bjRUOHBlRVpNM1hsM0VLS1dUcnVTQTMrYTNLKzZXSVNtdFBKZkt6RDlkaWZs?=
 =?utf-8?B?M2xTNWtwcm1EbW1ENnhXMFR0T0xMd3hIYW1aZGRNYlkxQ2xiWVNnSjBlc2hP?=
 =?utf-8?B?L0tPTkk0TS9pZUZlVFIzNlNZYW9MT2l3bUI4YXZmYzkxOG0vUmNjdlc0ZGF1?=
 =?utf-8?B?ZHRFQVgyRVA3eVQyQ1MxeFNrWmdpU2prM2xvT0xHTFh6bWFpQjg4ai9uOVpt?=
 =?utf-8?B?dm5SbkVMK01ZMmZ4OERPWDBSZDVsSnNPSGlDWTAyc3RkVkRIelNjK1NFNDZQ?=
 =?utf-8?B?VlpnQVM5YnJsanpUQTUvdTZFOTl2T1NGNjZ0ZDc4S2Rabkdka1VFYnNxYmQx?=
 =?utf-8?B?RlNnZldjTHBpNzFQd2NVNGMvVlkzb1I1YjJUWURFcDBQR0FGbmk2NWtaTDVF?=
 =?utf-8?B?eEpqZHhYc01oUTYwY0E3b21adEI1cWdaeWdmTHg0RDZnV3IyTkRLZSs0SVdC?=
 =?utf-8?B?RVRKMUlzdTNlQnZ1aUUvYUdTWGRKbkdxOWFka2xoZHBidlpsSlFsOTFIRGlM?=
 =?utf-8?B?RE90aVgzNmltT1JMN3l0OG9LWC9paWF3RHQ1V05WTXZ2cThxWEFhV0plb2xq?=
 =?utf-8?B?bDdJd2pESHY4R3dGRjBSejd2YUdoSmxMUlk2TWZsdk1kNGVLTWM0WGlBdGsw?=
 =?utf-8?B?SXpVcStmUWU0QWpXMjVHSzFJNklDL1FNRVpXTEVLaURNamhZZ1huQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71d1bf5-793f-49d1-44b3-08de528b38ea
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:05:04.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js9T3X5g3ExUVm/fi++P1SnZrZU39LO5mM9uHwjD93xbsmKswXB9qklfdUvjHQYCz6EsH05wrwtFbqES/NIYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5651

On 1/12/2026 6:00 PM, Markus Elfring wrote:
>> Changes since v1:
>>  - Extend the cleanup to iommu_group_show_resv_regions() as suggested by
>>    reviewer, applying the same LIST_HEAD() pattern consistently across
>>    the file.
> 
> Thanks for your interest in further code adjustments.
> 
> * I wonder how they fit to the feedback “Applied, thanks.” by Jörg Rödel
>   from 2026-01-10.
>   https://lore.kernel.org/lkml/stpavkxy3sbevk7zmt4kxyecqy5gc6phubvcfutbtnuk7vphlh@a7aimtvk423i/
>   https://lkml.org/lkml/2026/1/10/235

Right. Patch is already applied. @Can, Please rebase patch on top of iommu/next
branch.


> 
> * A shorter summary phrase might become more desirable for this patch variant.
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.19-rc4#n687
> 
> * Will development interests grow also for another transformation approach
>   like the following by the means of the semantic patch language (Coccinelle software)?
> 
> 
> @replacement@
> expression e;
> identifier i;
> @@
> -struct list_head i;
>  ... when exists
>      when != i = e
> -INIT_LIST_HEAD
> +LIST_HEAD
>                (
> -               &
>                 i
>                );
> 
> 
>   I determined that 175 source files of the software “Linux next-20260109” contain
>   corresponding update candidates.

Interesting!  Thanks for the stat.

-Vasant

