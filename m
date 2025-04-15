Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FC2DFA51
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744690922; cv=fail; b=V0+Y+GLAnVSpM+pX1zV3CP6RMCYD/8FFdjkUHwRqSdhcdnD146LAsPZYUAQrhqGNswxfvri9FTLnddgbu4sZf/D6wyvuaL4MvpLIqnNkiLBGl1+XvWc4DSDYS/MMfR3UkH5hfGDbvGDCrgjuMHPPeMwY8mpHPZLO/Z9ud+r+oqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744690922; c=relaxed/simple;
	bh=PSMm7Nvv+P/nFzk/YoVdU4r6fpF2eeBn+Yi6NANP+80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ti3OhS0NY974MLFRh/sPOOWwMyHUB9rYaiJqtBD4UYNjtGUjOtRS3u2iRu6ZaBu6dm6mHrjvKzZqEVyWunO4+pCJxJRRGhpbjDbZi4ogO5ao/HuGDAnHbmwYXkej9ja+85A0X4EvbwyDE71kv3cEKCuBDUs+yqY3F2qDNVzCtf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHhWEWaP; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHhWEWaP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdRF4bQ5rwSBFmGstiN6RWPHO/Q9+1SvaKoJQt/NLdTpacC+2DGpBSx3b+xKC18qLqLjfTdrVdmCuz3zVo7NiqINonCzhKCO75T3W+LDsCCpl+Ih4qgJod3s2YP8uSPatUwHSjx5g7FH/mIwuAI2M7I51H0ljGbrtPIp5EQHRkh6tlYkGzchU9DLle0hmtOp/wOmeqJSIYtxVLlHNaCwtSXNR7qXxJuw1W0jKqH1wzkBin+Nvt8EwmpbuMDmR3A2P/Zr1akKu3b29FFUMWiFuf9bruUNXadMPevbCVw+acPzhz63EvIyreqXYRvPKacBCwc1zRkVv0G/hbHMpjpjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSMm7Nvv+P/nFzk/YoVdU4r6fpF2eeBn+Yi6NANP+80=;
 b=bSd7NaXkUe9UOdge/c8z1+FOIU5esWF9DDgVZmUMXeDcqGCCWmAh1z2QFo8XzvvL/4eLk2XPUBlWOhpDJ1hfZJcfyGLZ+AFEsJ1QqeV74TAw9D4QerZ8QyStKYx3wimacVk0gaAOiLIAbaCPji7zzrgv/mXchH1bV3se8H/+BTc1pLJ3DB26Twc6cJchwZ6nr88FHZDDy0uXDai5N/nmXJtjaTPDHsmmywSfRD0TeZFtD0Bybx6chqc+361QalLsQx3sHnc+xcAcKJSza0HTOJOPDBpMAlsNrtAKRYY/bVrIyl4ghjiKOQ6cKEPy48UL7eLIisTFPb4U9avwGCjiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSMm7Nvv+P/nFzk/YoVdU4r6fpF2eeBn+Yi6NANP+80=;
 b=GHhWEWaPMXVM1weyj8oDIBWwVbKiHdfbztniCO6jJoM1yHmKy6Ycuak5s1/jk3cCHmw8wP9FFrfurunpvmS2c8YrL2EMPx8V0TaRZ7dp0o1djyGA+RK0rBMwh2pwtt/LrGhS4WCZB2l5xBOPdP7lXrqPPuhMoiaz0WeePEzIJMiYO92a++FSFMNcEl2/IZyuPzYmeMIuGk982oCI4Syu8Ol7w9SOsj/UBAPJwj3TMnH/55Nxh4BbH97T/YSjvdC7MpVt/0PxsPje5CJ2HfHyigpFORFSjaF+feTDhg1kBwhA7VzjgqU8pwqned0xMioQttzxxRKWAAmEaSKCBPA9EA==
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by DS7PR12MB8418.namprd12.prod.outlook.com (2603:10b6:8:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 04:21:57 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 04:21:57 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH rc] iommu: Fix two issues in iommu_copy_struct_from_user()
Thread-Topic: [PATCH rc] iommu: Fix two issues in
 iommu_copy_struct_from_user()
Thread-Index: AQHbrXHHWDXOcGORJUqXLURmttZk7rOkIOgA
Date: Tue, 15 Apr 2025 04:21:57 +0000
Message-ID: <6E88BE78-1DD0-4D8A-9CFE-AB3C9F97C11D@nvidia.com>
References: <20250414191635.450472-1-nicolinc@nvidia.com>
In-Reply-To: <20250414191635.450472-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8897:EE_|DS7PR12MB8418:EE_
x-ms-office365-filtering-correlation-id: b7cce251-3b2f-4ae8-e97b-08dd7bd50f61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VjJCcVdWWmYwWWpmaVllQ3A3cWxmUUZieEdMMyt5d3FGLzZ5UGc0ZVE4a3FG?=
 =?utf-8?B?NzRZcnF3RkF1TUl6d3cwVXl4T3M2eXJ0ZWkwcEg2aUhDdGVzMXFwcldxblFu?=
 =?utf-8?B?M2pJRWpHQ3pXNVhBUmF0cnMyb2lNTFpZY2FtbHVPeWtoUUFqMGVPZXRuU1pN?=
 =?utf-8?B?cTd1THl3WGwwMlphRmR3bmxITEh6OTEyL1A1OGprMTNYU3RDTHVEOWVKS2Jt?=
 =?utf-8?B?M1lmZU5XQ1lXUm1Rd2h5TnVtY0dMK0hFMWtJd1BHWlJSby9PK0hNOTR4SU0z?=
 =?utf-8?B?WHA4dUpEMXdOaS82TDlXWXhTR25zNzFrbmM2Vi9QSFFNWkVXR1U0a1JHMVVP?=
 =?utf-8?B?N2M2YURjWHN0b2ppd1BTd0VHTGsyeGcwMVY1M2t0VkhXM01ycU1Nc2phbkZ1?=
 =?utf-8?B?RGVsRTduVjFLNmg4RGhDbXlSWGlmbVBTWkJLRnlJZ0tqUkRjeGl3eXgrS005?=
 =?utf-8?B?VVZ3ODBYL1ROazg3YjQ1aklKR09kT3lKNGxuMFpoNks2OEpEeXVSL2dtVW03?=
 =?utf-8?B?aUZpR1F5TVNOWXZENmVScEJVNmpTYUo1c3o1MERuS1RtTFc0TTVVQkhBK1B6?=
 =?utf-8?B?aXlIMjBrYVBiVzZiWXczVU1NQXFKWjdnTTgrSWxYdURFRmUyZHJmdG9CVW5r?=
 =?utf-8?B?cVFsUkh6QWxaN1Z1RGRUcDFMYkV2WFJtZURxSUVXRS9nUjJ4bm5nMHV4VVQy?=
 =?utf-8?B?UFZoOGtrdnFrU1E2OUFXL1FpWmFiSTBMV3pwUnBnNThRd1htUHUrSlZ1bEQz?=
 =?utf-8?B?amdtRXg0RE5FWG1JY0dNMGRZNHlvVWh1amdJMk9DT2hFV2NCZVR1WEJyTzNo?=
 =?utf-8?B?QmhwbWV6S1YwVzZmWUFUOTVpMVFDU005NGFoemYvdEFsdi9LNVJ6blZvQjNk?=
 =?utf-8?B?RmlTeGdqRDFWNjZlMURmYk50NlRuWktKNEM2TWFpbWxJMzhWRkplSEZ2RGtK?=
 =?utf-8?B?eWlDMWpsaXpnUm1NVlh5VmZ1MTlBWmZzTFJqRnZqNjNtSk1IeG51RWNjb1J0?=
 =?utf-8?B?cVhYQmNCUTNhUkFyK2pGeHNRNFJiMmlWb0hSVU5QeU4yNEkyK3ludWRxL0c4?=
 =?utf-8?B?L3lrWjJEVml3QWUrR1FEbGVpWCsyOEhVVmRaRUNaUDMxNDNoaGNJOXJ1QVBL?=
 =?utf-8?B?UXAyU3lPamVGS3pLM2NlTE5POXdpSjlRVGlscGtBNWdJS1IxNFUyeVEzWXVY?=
 =?utf-8?B?R1NUODFqMEg5cmRQZ3g3NDVSOXF1ZkZBU3ZnZTFFVmZCYnJDeGF3V0xLcnRI?=
 =?utf-8?B?amJ6cjFEWnppVU1kVGVOTWxnWitSOXJMY3pFYTNHTk9VTHdQZHphU0RhUGlS?=
 =?utf-8?B?cjZURnRHNExKQ2VkZm9GTmFTTXdCbTdpNUhaSlIvVDk2eUlXbDdncHBuUmVy?=
 =?utf-8?B?OXZQa0RuSUpxWE9hY2JsSFBJekFaeDRnN3RWZHdkRklscFhEQ3hRcEl5Z2hU?=
 =?utf-8?B?VzFFTGNmUDJQTUhhTnNYVGkvZGlBaWdiYVZHNjllVGN1V1NZZk9QREJFSmV0?=
 =?utf-8?B?VFhvaWJoUVBtNEM3WFN0R3l1Sm9Lb3FDZTlVMmVINFNxQ1FIUkhqc3hxM3Jx?=
 =?utf-8?B?TFFNQkI4S0h5OUpXcGRMTEM3eUZzcUVBajJnN1h0M05kUlArODRwVU9wK3Qw?=
 =?utf-8?B?cmxpUkMrVzIzckMwQm53cFZlQ09nRU5mN2lBYzA5QXdKWk1QNFVrTW1CZEdi?=
 =?utf-8?B?Y3BmWk1nSTYvVjJ3VjdpV0U4aHZXVkxXczVmUXJveEsxQ2dzdHhqL2hCUlhK?=
 =?utf-8?B?Z3h1Q3JCUWlYdHJBV3ZMczgwSFhHSVUwSWZ0dzdTNFRkN2RyR2Y1OHFrVUE2?=
 =?utf-8?B?RlQ3RG92bGNKZGJaNkJiWnl4NzVwdVRZK0EvbGxhS2x5WHpjcWp0RnlJMDQy?=
 =?utf-8?B?N3RRNG8ySlJiMUt2QTgzSW9sdk5YNnk1REVrTzlmOTdGTEx6OHg2WkpJaTVw?=
 =?utf-8?B?L1R0cEZFQUxtaDBvUU5jL0FIQ2pQc29FbzExUk5JS0JDNElSaEgvNnBmQmtw?=
 =?utf-8?B?Z1ZoRC9jRzlnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8897.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RW5rVEVOUnFybFYzaDM0aVVJL3FHSTBIcHY1aVIwTDJBc0VvN29qV0dNUVdT?=
 =?utf-8?B?K3NVdUhwT1MzZ1ZVUWZacFJzdnB2TnlOK3k5SjFkMGZWWWM5TXVCZ0tXdGlE?=
 =?utf-8?B?VjlVZVUwZHZ6ZVJsdjB6dFQxeWp6WlNtRloxbEN1NmJQdnNHSWJoWHFPNGFL?=
 =?utf-8?B?ZHVIM2YyajRwV0FYVlM5NUwxc0pZdzN5SEt5Q1lSRjUvenNtOWp2N2pGbGta?=
 =?utf-8?B?NGMyaTc5dWx5dTYxd0ZvanBQZlFLSW9JV0lJWmN3UHlVcXpNNmRvNHF0cVB6?=
 =?utf-8?B?RDNTL2k4c3ZlSEZqeGxUaDRVR2dWQ3c5bkJ1Q1NrY3Y3bWlBTzJnSEdoVHhv?=
 =?utf-8?B?SHlDc05ncTR0aGRiZGJhZnBjT3pQaGpIbWdGKzc4RFRpWXpISElzd3BFcjZn?=
 =?utf-8?B?V3IraGpYNzYra3RxRnNTZGRJaXpMSEp6MXdVenZyRE5kVTJCcVgvdk1GKzlr?=
 =?utf-8?B?Nmd4aDQyTHVQTlQ5STRjUFJtZEpRY0ZEUnROK1pnKzUzTWplMEJGRDJKQW9m?=
 =?utf-8?B?d09NTWs5VE1TR3ZodE1wcFdCZC9hQ2ZnYy8raWFUSkF1SVdVQ21RTVRwanNR?=
 =?utf-8?B?MW1pQS9WU2t1YTJ6Q0dvd25VTFNmUENNZUI0cldXSzZqYi80ckh6UHdvRTVH?=
 =?utf-8?B?K0VobHcrZEt5SlQ0RWNvdDhEdWoyR3Rsbkc1Mm1kRzBsMEFOQXBiSW9zdGRs?=
 =?utf-8?B?T3h4YkFIR21TNTdpR1dkT3VpYjRERHpHeW9vbk5TV2lPUnhuL1NhMVR2VE5n?=
 =?utf-8?B?dDRFSWhHdXZESkQvdmg5QUgyTjlhRDhia2VpcGl4RkNoT1RGMUo4eFZkUC9Y?=
 =?utf-8?B?RG1hZzBqaDh0YTZvN0s5MGo5Tm55aDRlQlhYWVdBQmhhNzBVOHBNOXFBZ1pG?=
 =?utf-8?B?VlNhMENJTmlsSkpZRTg2b1UvZjBGb3p2djA1Z3VXK1VqekpZN3ZuYnQ2bTdi?=
 =?utf-8?B?bUdhTC9IN1FuVDVJZjZXWGtUSjZTak5kemQrZFlZOFI2bDBFV2xrTmMzMndV?=
 =?utf-8?B?Mk5lVW5jdWJYcExPUENQempMM0wwbmZuaTRGbkZxR0lhaWczSyswNHlvR3Iz?=
 =?utf-8?B?MWVuckhEWjVreUR0eDJoNWJ0T2dQNEFDSUh6amI1VXFqZjZPUXhaT0tMa1VN?=
 =?utf-8?B?UnppS21zbkRxOGJtWnNuV3JFaURjb3FmN0FuZGR6c1RpNElydkxhRFpYcGR4?=
 =?utf-8?B?elBEUkd6MnQ2c0ZUUFNTc1F0NEZDWHdEbzduaXk3dHA1Q0IwMEd2ZUpuZ0d6?=
 =?utf-8?B?RGc2bVIrcDJHczlHVEZ3aFZkRm9RM01MSkNlTTBSSHJQV1ZDM084N24vYTVP?=
 =?utf-8?B?SUxOUEdlNVpML2xsY0ExMmRURGZIMmxWMk1zMDJKbWZvRUxQaXQ1dGNrMzVL?=
 =?utf-8?B?TW9CZDFOV1ZScWNDTG5ObXQ2ZmliczBMSDNaOFlSb3RSTHcyL1dMYTlYeU1L?=
 =?utf-8?B?anJrMlRNdFBlVG5aOXVBeFVDb0duaGI2b0dCRVBEcU5EOTlzdnVjN3Awbmhz?=
 =?utf-8?B?dHRUOTZLOUhOdGZxVEdpVkdCSTlHaWFiOGt1SmYrVlA3b3hhcktQU00rNEg2?=
 =?utf-8?B?MFd2RUdBN0xFK0UyWi85eDJkVjRLQjJJMjBvLytycmYxL05MSFlLTXo3anVH?=
 =?utf-8?B?MGdMNm1XZlYzNDRPbXR3MTBJSVRHOVppb3BMdktpSnFtVFpkVm5waC9aOHhr?=
 =?utf-8?B?eERmZ1ZaVkNyVGxqbEgzQW9jT2o0ZnppbHBsNnZkYnk4c203RWF4N3RhRTh2?=
 =?utf-8?B?YXpDUmZHQmo5ZjNjdjk4UHZGQjRMMjYwRzZmZWZuVW83b2xoSVMveENmbi9w?=
 =?utf-8?B?VWp1cUJKa3Zhd0h2bW45ZjRydUdMd1RZbFVvb0RYWXRmUTZPaDR4Y0Y2UEt4?=
 =?utf-8?B?bGVTUnFIaGlZc3lOekhPdSs1dDY0L0JlY3ZpaXhMK0JiNmRRSFBST3pwa1VP?=
 =?utf-8?B?cTFhT285UkVsOVZ2UWVjMEFRalBRNkRTMVNkZ0I2YVl6MDZXbEdNdGhva0ti?=
 =?utf-8?B?U3Q3bE9iRHAzWHFGMC80VmFaUWVjUWkxK3BMTEorMzhCU2VUUHg3Z2pDWXF6?=
 =?utf-8?B?dXdYTStRUmhIZkp1YUtNek4zSS9aSEk0ZHduWjRwbDdWOWMxVjl6T2Z3YlRR?=
 =?utf-8?Q?5xke4SCl5BSfpZ+miuNwRdLT5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <150EA5E41C7FFE4093CD3BB893BFC12B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7cce251-3b2f-4ae8-e97b-08dd7bd50f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 04:21:57.2330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FtS6g7bRrZHfu2yMEZk6mUyNyESC5H+byevOJO7yybQBUkOv58wHMX6YGTeITZCjNO5IT2zRl/a4Kwtna7BiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8418

PiBPbiBBcHIgMTQsIDIwMjUsIGF0IDI6MTbigK9QTSwgTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPiB3cm90ZToNCj4gDQo+IFNpbmNlIGJvdGggaXNzdWVzIHdlcmUgY29waWVkIGZy
b20gaW9tbXVfY29weV9zdHJ1Y3RfZnJvbV91c2VyKCksIGZpeCB0aGVtDQo+IGZpcnN0IGluIHRo
ZSBjdXJyZW50IGhlYWRlci4NCj4gDQo+IEZpeGVzOiBlOWQzNmMwN2JiNzggKCJpb21tdTogQWRk
IGlvbW11X2NvcHlfc3RydWN0X2Zyb21fdXNlciBoZWxwZXIiKQ0KPiBDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRp
YS5jb20+DQoNClRoYW5rcyBOaWNvbGluIQ0KDQpSZXZpZXdlZC1ieTogTWF0dGhldyBSLiBPY2hz
IDxtb2Noc0BudmlkaWEuY29tPg0KDQo=
