Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010001.outbound.protection.outlook.com [52.101.193.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C3320A38
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538222; cv=fail; b=RNOGLF9eMEtUmZhm96+BraET3XftDiBKsOcS7TG0mOEYlHmLiHkdyMbfcYSQf84n4eKui+SWamm3EiLvAjuUTMz0yRbgdYYrP9vfhhqQztyo8PEetHgYlkiO75v9vrn8XWxx1y+3difubutezQP/0k3DXB3/PmrP0OiIvcBDvpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538222; c=relaxed/simple;
	bh=i0xEFYxe+Ffv/POVsATN1xp82zPjL23qxxRfGPUBfyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QrctY5zIzBMdGdIolMaoGPzdy8ghQOV5HnQlQd4/l72vKvbZMJ2EV1odutzPweepkQqiWFETGxVFW3X0E12GrPVJZ45gon5SoTUOtWQEoPDwomtRy6YXKiq24IA8VZNZAmpEj0R0IRJcIu/7LhlfBh9XSFuhafMLr+bbZ3PgxDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MNreTgap; arc=fail smtp.client-ip=52.101.193.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MNreTgap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+4bOyi7hubl8MwM5OKNYohwWk4aRFYeXrMrHbEGvAC8dvWshfkF9HS4ag1hGlOaTtXPaU2kIvyzkrg5cp1lEP0UEiHU5Z8O1HnM8CGf7xXQpnoNRdGiKkn2QAY0g443DNjCAEUxpujCEQjAKkTC5NWZ9OBlRHPuDdRAw9G6STMKA9cS8vP8d5FrIf3WG0kwI/ariKoS86fWZBfBL018eQ4a1uiQkSfMFBQ2hajrmjBKmQzao8NDn4gvUGvRaZwKHER4pqw2gyWA/OKAvlbwwVp1Y5iZWt0vE7KdGX2OxJksEl4B9I7g+4+7WPwojZ63mtJ9cFwBG6S5wAm+c1oy5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU0oxOJnibfOYIsrb3bb4ytrDxvpRyzGfwl4+dL8AtE=;
 b=DMbKff6sbEGMBkL8VoEYotFn1/U0YVaUfJrp5nGMy+r27/v8ZZ7zjZnZd/n4zKO1f3Lk40n1UCBXZeIZqfnYjtwXZ6si4xZxSGWtQHH1CtJUIIGHw5qEGUduxGNve9GhQLSkAG0o1yiRuXSxsNFNPdAX9Zj37ZllXaH1nPQuNKI7IBbJcUcLmSdYUnfgXH6MQ18G8HVLUwnMEYjZOYOg3dMx8TZlSbzS6faPavn1cJsBEcIVvtT+MrLt+KaWb8HfhG7G3JNic8+feQevAV5Hc5ZjSukauSPAz0vrVJ/OvxFS7sDy9JaNzS4Z7hlkgPCGiwFEHz5eal3ZLu9ViC50tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU0oxOJnibfOYIsrb3bb4ytrDxvpRyzGfwl4+dL8AtE=;
 b=MNreTgapLsBJYIQig5kPnNueXRrcvD5Jxh8jk/9gmDCaV6yhxjy0nxzJhnDsoYIzsKv6f+dcroEbZmxOwOmTmnmByi7E2iIiMRLMuXb2LILrOYMcaQnyanw5OVOVjbdRnztqDrLSWbQEObO1CjbO9Wd69zbGapYfw8bEIisEuZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 17:56:56 +0000
Received: from BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a]) by BL1PR12MB5062.namprd12.prod.outlook.com
 ([fe80::fe03:ef1f:3fee:9d4a%4]) with mapi id 15.20.9275.013; Fri, 7 Nov 2025
 17:56:56 +0000
Message-ID: <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
Date: Fri, 7 Nov 2025 11:56:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
To: Jason Gunthorpe <jgg@nvidia.com>, Wei Wang <wei.w.wang@hotmail.com>
Cc: "alex@shazbot.org" <alex@shazbot.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Alexey Kardashevskiy <aik@amd.com>
References: <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107163614.GN1732817@nvidia.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20251107163614.GN1732817@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::27) To BL1PR12MB5062.namprd12.prod.outlook.com
 (2603:10b6:208:313::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:EE_|CH3PR12MB8483:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6c045f-8d57-4de5-d9bb-08de1e27093e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJ1bWVueUFNUzJBRFQ3OUdzeCtINHhHYVMxZmQ0eVNlR1g0bFFpMGM2cGdQ?=
 =?utf-8?B?alJqdjZGTHlVTmNEL3NPbXlBREo2NEVQS3p1L0pxTzFGM0VsUWRLTDJKcndz?=
 =?utf-8?B?cHkvSElRV3RGd0MzaTJaaDNuS1lFOGt0bEI0UEJXZjk3em5UcUFPb2l1Rk9a?=
 =?utf-8?B?SDFFNkxqeTJkSnl1eFpJc1FPWnlDZkZvM3RqMzdBMnJYVmFwYjcyN21hUHZB?=
 =?utf-8?B?a1lEeENFR2RESlpMV0FmUzlQRVBMb2I2SW5CUC9WY2ZBR05iZDEycTR6RHNI?=
 =?utf-8?B?TURjcGhHdEVuS1R0ZS9uWmF3T0M3OWlFTUE5cXFkNU5YUlZqVG02SjF1clpN?=
 =?utf-8?B?WjhHRTVrU2UvN1AvcXZKLzMvMzY0RjhVRkE5NXMwM1prVWV0WUtXejFvUlNK?=
 =?utf-8?B?cEMrMjdFY21pTkZ5eEV5d2Y1QVNRK2R2N3lCV1ZvOHcrV2R6VW1ERzQwM1ZG?=
 =?utf-8?B?NTFKUG1GN0o0R09KbDdnSGhhczZvWFMyaStnbmtBNnpCdVg2L2gwWlg0SlVw?=
 =?utf-8?B?UGl6cXJ5OTZ2SnFJYmpWckF1TmlBeFA0Znl1UW1NR3VCcWl4eHFUSFBLdXBs?=
 =?utf-8?B?NFY4SkhCd1FmRi9ROG1kSmpabTRxK0s1aERVMkhPWUM5ZXc5NG1yVWN2MHVz?=
 =?utf-8?B?YS9aT2N4OWY1S2o3akp1Vmh1eEJQWXUrZlYxcENobHFScEp0VkhidjVCKzdE?=
 =?utf-8?B?VkVYZGJLKzAzK2E3TFJXV0ZTN3JkMlFXbVdTaHlVYlBYb3dwTFlZdWh5eDJo?=
 =?utf-8?B?Y010U2hrQVROL2docmhGQWdnNVZDMy8vbEhCdCsrWTZJdHVtWFd0OEhRVUZh?=
 =?utf-8?B?Ym1lMjc3Qm1MNEJIM0g4WElPbmVSanAyWDQxUjQ5MXZCMVBjdTA0VXQ4b1Jm?=
 =?utf-8?B?OGo3MUtCVmc1SmI1dnZEdjNvaVY1R25wSW1hTDVOTFBlL3JmbEx2YmEzN3U5?=
 =?utf-8?B?dGpPbW8rV1padit2UXk2aDhrVVVTOU9ON1dVK0VIQXc2eENZTW0wRjJBRi9X?=
 =?utf-8?B?cTdQd1FRaTRmOXNUMzFBZFBjbmpMZUNDZlZGZzRXV1Z6NzlJVnJOdk5hTy82?=
 =?utf-8?B?K1RCM2lSRHQwYTNNSjd2RlRONHpmQWhuTGh6Z1hqL1VBK2s0dFFXdnplbVpM?=
 =?utf-8?B?QnlGSERpemo2UWt1MU9uL1pXeStraGJreXBzUEFJTGY4R2ZSNEhndjZDeHhU?=
 =?utf-8?B?d2M5S2lSaFZnSjhtYmdvQTUvVEJVSDRxWDZhU05wY2tkbzBvNFZGTm5kR0Mv?=
 =?utf-8?B?MmQrUUp3blNtREdFQ2JUdXBrV3VGYkR0aUs4U1oyS2xGaUxNSmxjSjRPYnNt?=
 =?utf-8?B?a0JMc2ozL28yV2gwYWpXT2Uyb28yeXdSSVozcjFHM2pYanNQQktFd01MeWcz?=
 =?utf-8?B?aWplNCthM1dCejlGSGJuamQrZnIwZ1pmSjVaOFVERzJ0azJoZ0JvRE1Ecndy?=
 =?utf-8?B?RW04UEx6SFRlRG01Mlk0Y2kxd3dweVhSczRHMENPdGZnNzlINlFtb2VrZkFh?=
 =?utf-8?B?L1FMaVYyTVVvS3BtZjZMVW96a0I0V2J1WWVsN0MyaDhWdGcyOHhiREFQeTdi?=
 =?utf-8?B?WUhsSURVd0VNSXp0RUl1Rjk1cXU5SWJROWhnVVVXcS9KQTJsNHB1TE9GQnR5?=
 =?utf-8?B?eG1mWmNobUZpTnh0aDI1b1p6MktSVDBJc2M1VkVLby9vZUx1T3YyNG9NdVFG?=
 =?utf-8?B?emVzYXFLMXJqbUE1cWxwcWM0SUU3Vk5RZU8wU0U4VE5GcU8xSjhucFFLbzli?=
 =?utf-8?B?ekU5c1VUMFlzdVo5ZnFiUGNNZEZZdmgvY2xIOFBWbDhHYktwbjMyZTJQOGhU?=
 =?utf-8?B?ZXlQUmZGRWhhUzZxenhXamh6T2wzRUtOMHpManlnaHNlc3ZONlIyS1F2TzNB?=
 =?utf-8?B?U3VpL3N4Nk5zT1BpYjhyRHI4b1VQNVpNN3UxejNZZ1YyQkRUbDN6bXpGelJ2?=
 =?utf-8?Q?Lukq53ovmG+pBo54agXWRoLgdm7f+cmA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5062.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFpnNktMd0QyMjJFL2dXcFJDYmhmWlNsbVRJZ1VpNytISUY3YmQ2TG5ORXVs?=
 =?utf-8?B?V1kvUUxhZ1hidStsb2RsZHZxaVYwY08reis5azA2K1ZCSUR0UlFXU1ZTc1ZD?=
 =?utf-8?B?NTJrZjZ0cVQ4VVZRejVZMnkzMy9FVUtrdTBzK0dQbDJqUTFqeHJZdFJiclE2?=
 =?utf-8?B?T0FHSG5Fb2JQaDBnM04zUDh2YlJTbC84Qi92cWxQdEZ3NTRWdVlDd3V0aFhq?=
 =?utf-8?B?K1VTUUlEMWNKNU8vdWZ1dXRsMmUyTWF1NHhDQktaTFF2MUJJa3FNSGE5VmUz?=
 =?utf-8?B?bFE1d2tOaEI3cXNOTStRS1o3ZHg4aWoxa24zOGNlUXlwN254cDhZeXhCM0pN?=
 =?utf-8?B?bUpJb08wbFFqV29nMjg5Zm9LaDNHSFkySk1BdU02UlVKTDF1YjJGUU5iUUlW?=
 =?utf-8?B?VmR4dXdET25IWWJXSGIva054K3Y2Nm9GREtBUHZNdjJtN2s4dU5LZzV0UUo5?=
 =?utf-8?B?by84YUV2ZDdwTlc0ejNlUnFyanUxU3dXUGZkL2tPWVFyUEU3WDduZ0laUHpB?=
 =?utf-8?B?dFB0RGM2QjUvSXBQT1IzM2JONGdHbHZXdzBKbDA2bnNvaTc1Vi8xVHIyR1ZT?=
 =?utf-8?B?b3lzRlMxMHJVSWFZZitxai8yRFc3SnF2TzVSVi9uQ0daTEtyTFI0NmhlT3lC?=
 =?utf-8?B?Rlh0R0h3Y3dJZFdRY253Zng2TU9memhRa3E2Q21LWlk5RE1kTlVwSHkrTERY?=
 =?utf-8?B?NFhVYytlQTZ0TzdTSGl6dU9HbjAwV1czcE9mR3dXVzZnczlWYS80RDZoakFU?=
 =?utf-8?B?NWdrVktjazFVSGZtbVVWOENydnhBcE9nWlp3RmFaVHQxelRKb2hMWW45UFNY?=
 =?utf-8?B?M08vU1JMZXZHRStkQlZvaEU3ck9icFY5NmhEc0wwaWhQcFdUMURYdDhvRVFr?=
 =?utf-8?B?Slh3TFVNNkxBOFVrV1N2UHhwZUdScGZxRHlFMzNvYnBVOC8xeitqT3FDdm1W?=
 =?utf-8?B?RWFwWUNYUUt6NnpHQkdoV1FURHdLOU1hdHp6bkJaaTVvODJaS25yZHRXcnY3?=
 =?utf-8?B?Y1NUMGM0WkdVQU5CSTNRN1BpS01YV2ZtQWNBd1oramhYNk9vZ3VPeVl1SVM2?=
 =?utf-8?B?U1dlcDZnMFBzOTA1anR1ZmpmODA1cHltbExqdncwSzZWL2FiYW1YK0pnTFlu?=
 =?utf-8?B?U0RwYmg4N3pENURqNkFhaVpBWU0vdnE2cXhzQWZCK1RvS1NVVVUvUGZkS0FL?=
 =?utf-8?B?ZUE1bWFKa3h2WjhYUjB0bTNIUDBxVjgwVmxrR2NKalQ2MmJndkdFRVd3UmU3?=
 =?utf-8?B?aG1yT0VhS0pydmcxOE15YlhSVkFoMmZjUG5xL3ZCMnpsaVpCL1RxUEQxOVMz?=
 =?utf-8?B?Q0MvM2ZIdVQ4UDhvWDdDVDd5Rk9jNXBMeCtIOEptZ3R2ZHRJeVp4Vk1KRmo5?=
 =?utf-8?B?TW5RVW1XNHpGRjFLNEQrQjR4VTY3YjAxV09XN1FhWWpDdlRKQzFVMTM5ZHVp?=
 =?utf-8?B?RkRocVIwRTVzSC9QRE1Za3V2OWFOd2pURWFjdkVlT0dLQzJKem5ES2lOdW5Z?=
 =?utf-8?B?SDJ0NmlrLzVTOW5BM2xtdjNDd3JEKzY3d05VaGJHaVQrc0dFYUxyOSsxUUVZ?=
 =?utf-8?B?LzQ2WDJtOVJTbWxWbzdXQys5WTZvT0l1d1FYaU41SStRbStPc09qT0xINDgx?=
 =?utf-8?B?dWtYU1dScE80a0grYzgrL2VleFg2aFNnbUFlRGJOOWZvWkFoVzMyZVA2WDBi?=
 =?utf-8?B?UzZyQUVUVlBLam51ZVNuRk56MVpZb0FEYkJ0ck5NZHV1UEovUUplQVZmOGVC?=
 =?utf-8?B?ZnRTQXVwaTdrNkZ4RUdFSUNvdE9WaXBiRTBobkhLY3hBeGpZR2FrZXVyRTBD?=
 =?utf-8?B?WmZHZWRGWWdwNWRtSkFxK2NoMnlZdXJWQ0lCTlNMM3FRL0lCdzRjcGNmQXdV?=
 =?utf-8?B?eHE1a3M4bktKWkRWWWwyY3I5eVFacVA4RGVUSE9LaFhuczQ1Q3E3VzAzZitD?=
 =?utf-8?B?RVl2UklyTmw0VDl4c2hDRlgwN0FMZURzUzN5cE5KendYZkVQRkYvVm5GQXhK?=
 =?utf-8?B?NHkrZ1JUcmhvc1kxT28ydFJxbUJNZVplZDc4emFYN2ZuZ3dJbGlDNlBISVVo?=
 =?utf-8?B?cnNZbFFqdlVQOEhyREw2NFIyb3hGbTlyLzhtZzl1QXZyQUZJNTRoS2QrRDhJ?=
 =?utf-8?Q?ApQRrNBs+cZNyPwpR0qY2vO+r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6c045f-8d57-4de5-d9bb-08de1e27093e
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5062.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 17:56:56.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SJ3AnWr0+Kmjfyvh8QFNgCg6hO2im11PXNN47bJ+uu4ELIHqV+lQ5hB/AZlAP9NHwY4ijomXetDp6aDeWhBQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483

On 11/7/25 10:36, Jason Gunthorpe wrote:
> On Fri, Nov 07, 2025 at 04:19:35PM +0000, Wei Wang wrote:
>> On Friday, November 7, 2025 11:57 PM, Jason Gunthorpe wrote:
>> On Fri, Nov 07, 2025 at 03:49:17PM +0000, Wei Wang wrote:
>>>    > (are you aware of any real examples in use?)
>>>    > VM_IO should indicate MMIO, yes, but we don't actually check that in
>>>    > this type 1 path..
>>
>>>    Is it because VFIO type1 didn’t need to check for MMIO before?
>>>    (not sure how this impacts this patch adding the VM_IO check for MMIO
>>>    :) )
>>
>>> Okay, but it still doesn't mean it has to be decrypted..
>>
>> I think "decrypted or not" is the job of the 1st patch. For now,
>> MMIO cannot be encrypted, particularly not via sme_set(). If MMIO
>> encryption is ever introduced in the future, a new flag (probably
>> different from sme_me_mask) would need to be added.
> 
> The kernel is using "decrypted" as some weirdo code-word to mean the
> memory is shared with the hypervisor. Only on AMD does it even have
> anything to do with actual memory encryption.
> 
> However when I look at swiotlb and dma coherent mmap I see it calls
> set_memory_decrypted(), uses pgprot_decrypted(), but still uses
> __sme_set() when forming the iommu page table??
> 
> So why is that OK, but MMIO needs to avoid the sme_set() in the iommu
> page table?
> 
> IOW I would like to hear from AMD some clear rules when sme_set needs
> to be called and when it isn't.

When you are on bare-metal, or in the hypervisor, System Memory Encryption
(SME) deals with the encryption bit set in the page table entries
(including the nested page table entries for guests). If the encryption
bit is not set (decrypted), data does not get encrypted when written to
memory and does not get decrypted when read from memory. If the encryption
bit is set (encrypted), data gets encrypted when written to memory and
decrypted when read from memory. MMIO, since it does not go through the
memory controller, does not support encryption capabilities and so should
not have the encryption bit set as it isn't recognized as system memory.

On the hypervisor, when using the IOMMU, SWIOTLB is not used and I/O to
and from system memory (DMA) will be encrypted and/or decrypted if the
encryption bit is set in the I/O page table leaf entry. If the IOMMU is
not enabled, then SWIOTLB is only used if the device does not support DMA
addressing at or above the encryption bit location.

In the guest (prior to Trusted I/O / TDISP), decrypted (or shared) memory
is used because a device cannot DMA to or from guest memory using the
guest encryption key. So all DMA must go to "decrypted" memory or be
bounce-buffered through "decrypted" memory (SWIOTLB) - basically memory
that does not get encrypted/decrypted using the guest encryption key.

It is not until we get to Trusted I/O / TDISP where devices will be able
to DMA directly to guest encrypted memory and guests will require secure
MMIO addresses which will need the encryption bit set (Alexey can correct
me on the TIO statements if they aren't correct, as he is closer to it all).

I hope I've explained it in a way that makes sense.

Thanks,
Tom

> 
> Then we can decide if VM_IO is sufficient and so on.
> 
> Jason

