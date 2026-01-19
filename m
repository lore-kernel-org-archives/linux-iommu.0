Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59022576E
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804280; cv=fail; b=Uprq5UPkV4yYtCbPZhvV+JBLWItb0xGbDFGrsp0N/I0rEk3QAVpir5l2DUBPY7X86QeztGYCmC5C2aWV6u5vOBUWYMChEOdFIeyeKtMTfEWkX8nv+Aw2jtdtp1m4aCfFR5g61FYxJ4YQaxUvL3RcSeLdKCpy1lQzWsCteRE79eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804280; c=relaxed/simple;
	bh=taeQwJmUSwaWkmuLyaYAX5iym9kyc7HZtXUWOaT00m4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VcWoS7KAc+jUsGlP9nesj8qebm932h3UXJe4Jqq8RxFwGbVDnAwD6TiRPTQ6JOHKI1hMlcRGnQYTKeC/asevXh9XGLGXq8orJccci17NyzEBtQH5IUscBaQ5zMztPk7YNK/L2Rla9uZTxEW6pbmQomHArXIWz3kF/bPMR62S4gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/2EcMfJ; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/2EcMfJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUyhu+YmMI3xSdKhSFpNiiSIW7v6KEfXeaXGwhk303GDGJZLVUblZ4AhbPOgrRoYhwzKyS9IDL7cCSoKVVRCxzVGUJM8WNzOV4nDScqn0UPIpEzjjAKf9Gl6imexPWKaIqC8m14fnMvqYboU/rRz/tKNliDxo8KpqHdiLIPPJAi3O/FcVt2EK9MLQESjqJZt000yU7HmuRE3YzJ9BOdpRd8oUaWPPrXUJeOTZR/naRTFX+/32lczPChO2nMa1SThgmgqsoJrkmok61UnBhh5xTSdO7c6MaPws6piT5RERI0TvQbwyZIm8e/XxtpGh3i36DaHiotxkOdOMvXIspja7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sMCEgelD7GXL7c9n8D4wIY3/4J/KGpDqp8TlsPJ1rM=;
 b=swX2mWEHvotRvKIbJoW0QhBrrgTqYgwl1frsDwNyqQFgWGcNEaP+Yg9iZ7TCyYkVT4FOT37PS0FW5o3giW4WeeX3r6FHNE79s8pun6Usnd1UPdmlBU5qFZAn1qDtpDR62Yrhe3E8/SUoovII5A9y1cihTc24OZ6XkOyFsnSpB1SBa+6HX6woPkIK+FfTjQowlR2Men3H7e04YvbCnZY77mW3LxvclCMWFzBotII4muGKJHA67WZXwaoviJahy0444s10NFNbhjXb+ZGQrheP6s6RNpK1xINKCSupGSBhh8eG24C7/1+Za0yiOy4r/mIx65cCLbfcc+pSsWikv2Aq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sMCEgelD7GXL7c9n8D4wIY3/4J/KGpDqp8TlsPJ1rM=;
 b=2/2EcMfJP/wDXvfwAey+x0SuZ+CXVT3+zSLepihiec4PMo/TT5iP1CeBlHJZUGG8ZjwjNJlQJgQLmTiLRHscdlS4w54Ru5KEf1fn7rEwNk71VEPbYhKGCmrwZm/mb8vVDGMQiFH/kvyR89xDgqqMemi1bA3WiEGtQRjhRZR019A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1SPRMB0013.namprd12.prod.outlook.com (2603:10b6:806:22b::6)
 by CYYPR12MB9014.namprd12.prod.outlook.com (2603:10b6:930:bf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 06:31:15 +0000
Received: from SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a]) by SA1SPRMB0013.namprd12.prod.outlook.com
 ([fe80::fc4:fa00:c2d9:456a%5]) with mapi id 15.20.9520.010; Mon, 19 Jan 2026
 06:31:15 +0000
Message-ID: <e809b1dd-c03d-4f5f-998b-75b0966a37ee@amd.com>
Date: Mon, 19 Jan 2026 12:01:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] iommupt: Do not set C-bit on MMIO backed PTEs
To: Wei Wang <wei.w.wang@hotmail.com>, jgg@nvidia.com, kevin.tian@intel.com,
 alex@shazbot.org, joro@8bytes.org, thomas.lendacky@amd.com,
 suravee.suthikulpanit@amd.com, aik@amd.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393C9B731ABDA050A336166DC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393563CD72EE92D40EC565EDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <SI2PR01MB4393563CD72EE92D40EC565EDC88A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0125.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::7) To SA1SPRMB0013.namprd12.prod.outlook.com
 (2603:10b6:806:22b::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0013:EE_|CYYPR12MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0cdde9-3391-4bb0-26bb-08de57245874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFVaOWVVZXhnNFlCaHpxMjMxTFVjN2VVT3MzMkhsMEtRblNaVlN3YWlQRTU2?=
 =?utf-8?B?M0RlM0c3OUJBazZheFVobzNrZ0xrZHJRU0dXMUJLR1BTUjY3MVlydG5NdmtY?=
 =?utf-8?B?UThkSG5nVU8wOHBjaVBUNEFsRE85dTJyTi9TNHhXQndVTUgwa0k4ZUhjejNU?=
 =?utf-8?B?YjBJaDRkRk1ydyszWXQrbjZMZGY4VkhBcWNhODZkVkRFek9Lc0JhOU9lbVFk?=
 =?utf-8?B?ZTV5VENnSlNFTWFpYkhJVjBQcjZaOW95enFabTZSOFRPZksxazYwYi9ZUnpL?=
 =?utf-8?B?Rm5ORWtrdXJxSWl0bzZmcUcyVGlPREJCZ0s5ZXNTdkdoR2J0WUlJbk0vUnV6?=
 =?utf-8?B?Y1hmQ1Z6Z0FxZndpVWxVa1dHelg5RjMvcUwvYk5NUEYxbHRXRXdpc095eFQv?=
 =?utf-8?B?NCs2UFZic2FPYXFiNWhYaEtoU1Ara1FBUlZheXNxRFlYSUNDcGhON0ZSVXl5?=
 =?utf-8?B?MnV5NHdvdm9jOWRTM3RXY2c5YTNWR1JrNjIxc2taamRYWDBxYUxNYnVoQ3p4?=
 =?utf-8?B?NWlGcWNkL0xBUTNybGc4NnFWZDBtaHRlcVhWVFNiaWVQMDlJeHlPVFJCcFk3?=
 =?utf-8?B?aTNaTU9nNkNVNjU3amY1UjlWK3hZVENTQWJzU0hwTWFvdWpYVmVOTE0wU0ZT?=
 =?utf-8?B?bW5lSGpSQnp3enVlREF5c2ZHVCtKelkwT2tsWGRDUlFMUzNUZXZPclFoL0s1?=
 =?utf-8?B?Tmx4Tm1LcUdFb3MwNDJXNW44SFVHUEUwZzN5ZEJ1U1k2T1lqd0w3MXZaQ3cx?=
 =?utf-8?B?T2dhSHJ6cjVveSthR3lLU2Y0THd6bWFoY3ZBYnQyQi8ySVdkS3VOQlFDY3R4?=
 =?utf-8?B?bnk1L1VTM0hlQWR3ZzgxYWxxVXcvd1VjZHVuMHhRYTdGWmRiUVNMVE5LaWRs?=
 =?utf-8?B?Tk9HeFl6TE9qcDloSmdBZXk0VndEUWh1ekRPRmZHcyt5Tm00VVN5VWZkOTRJ?=
 =?utf-8?B?VXdnYXAxZ0dHMVdGOFdDMHZjRFltZFRRQUUwWkRVQ0pIMFNFcVBTR0Joa0F0?=
 =?utf-8?B?UzVMZWYzV2dTMHdxKzh0NnZKT21ueWlFTmUxRXErUkYzNVdmVjVkSmJkSTM2?=
 =?utf-8?B?aUNiWktIN09IbGk3bWVwTEVEalI2WEhrY1NpTUtQeXBKNC84bVJEWnpVRDBi?=
 =?utf-8?B?ajNScTJjQVkrSUxMdjJhMkxBOGhvWFo4cFJrZG1PVkFZS2E4UE9nb2FUZmgr?=
 =?utf-8?B?NTdnYXNqbm9EeEFrOTVCOEM4UENFeFJuM3BvallWdGhjTGhJd0NRMm9VVERE?=
 =?utf-8?B?V09uSE9QYWJhRk1pRitLV1B4ZTZtVXFGOFNRV1BLSW5zS04wOEt2R2ZidENI?=
 =?utf-8?B?VnJHYVJxNm1ZOThhTVBtSjAvZmN5YkNXeVJtWDhrZFY1SXhLL21Zcjh3UEpt?=
 =?utf-8?B?Q3ltVjhKM0tKL2hiVmQzY2hwRHJWNDBBcGlSV24zcWdHTnpuaVF1YU1FNzZF?=
 =?utf-8?B?WTdOTFdrWGw0U2FQaERBZFhkdUxrM3Y5cVlHdFZrSkJkZ05xUGRGa2pPWXBR?=
 =?utf-8?B?TGxPOHNVS2NaemgxUGdNYjllWE5tWGJlYWFGZExiWVFaRUJmRTdnVUxNWXgz?=
 =?utf-8?B?bENvQUhPelArRXFSZG5FTDhpZGJQTlFjKzAzOHlJK2J5a3ZIMmhmSFlXM2FL?=
 =?utf-8?B?RGpYbWlmeDhkRzVqOVdBdzhQQUd0RDcvVUx1d28wKzhRR2c5ZVB0MXZaOHAr?=
 =?utf-8?B?dDdXeHp0SW5obk8wZWdQZSt1cklEVlIybCtTMlcwbktsUElFQUdSV3BiMXJD?=
 =?utf-8?B?QVIxbUNJdUIwNnVlVFBqS2t4QVlrMzU0VTh4RXR3bmVBby90bGRiU2xST2cr?=
 =?utf-8?B?REk5NEQzOXk1OWNsU2Nzc3JrVDNqTVpIMC9xMW1VZWN4K25EQVVWTm53ZXd2?=
 =?utf-8?B?RmZxSHRVUFVldEJYYlB4YXJOVlVsVXJSMnQ0UUVkSGM1OEVqMVk3TEM2dFo0?=
 =?utf-8?B?V1JCdkFKOWt1RlgrQkNHWC9oNEVrMVo5Q0lIajN4SVhldUU0QkF3SlgxaVpu?=
 =?utf-8?B?SEZyb2hLdEQ5TG1lNXpjWWRVT0oyU3pOcWxiSFhoRWJQMW9zdEdlK2l0R0tG?=
 =?utf-8?B?aDRnKzREejlmUGNOd3I1Mm5URFR2V1VuUzR1dEU0WUZpclpJQUJJWURabmNL?=
 =?utf-8?Q?sI5c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0013.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFZsU2o4ZXI1aThPWmV3MnVRcnhmZXpGM0JRcmtmN0h3cDJwSDd4Vks4RTg2?=
 =?utf-8?B?ZUxOeUx4S2JueVZmaXVzUDgyZTRWdmlYaDg5T3JLL2dEa0RxS2NMQW10ZmJW?=
 =?utf-8?B?b0JjMEYxUWtDd0FVd2p2WDlTSW56T1Buc2ZtOFBHSXNTR3VsbDB2ZHNoMkF2?=
 =?utf-8?B?dnFFTHU1ZkQrQkF1MHpHYm1LUEg4ODdXUlFjM1pqd093ckJtMGF0RTJoT1hJ?=
 =?utf-8?B?STZvQStCaFkwdnloRlpSQURRREZyR3d3Z1N6SCtLcmVZQUt3bmIxYlEwQVBV?=
 =?utf-8?B?MTd2TWJ3cy9yRmZ5bHlwSnFPTU1Oa1lLcG1mVjVYUjRhL2lxYzllUzFxZHJK?=
 =?utf-8?B?dVM4MmsyWE1QTktyYVROMWQwZDVRbFgzMWJQT2lsOC93UnhzQm04dTVJRjRw?=
 =?utf-8?B?eFVCbXdGdFhtRU5OQ2hWRU92SVgwQjdLczgxMFZOWG52VHVWbUFhcjlZVW9R?=
 =?utf-8?B?UnhNVE05MjFsRHNGaEVsOWFRNHUzRzFTaWtXTnN1R1QrUFNMZUhOL1U4cnZv?=
 =?utf-8?B?L0IvbjlPbW0wbHNxOGo1VEJkVTVvOVhyYktoRThoc3ZETHhzejVua3dNUExh?=
 =?utf-8?B?a2lvOXQxbTRLS1hZK3d2TmltdjBKN2s1MTVNS2thTElLV3ZyT2cveVpzQ2No?=
 =?utf-8?B?cmpQRk42Z0hmSmM0WnlzSCtHSG50aHdSOWNiOEpRcithRERzQ2RsU1JXQk45?=
 =?utf-8?B?OWllNHNwZVBEYVV0ZEVXcm9ndGk5YmwrQ1RGYU1sUkFtZ1F2UC9ZOGJhUkxs?=
 =?utf-8?B?MXRGbjBudnR1NHZWRWN5L29LSThPNXFRWUQxWStQQXVCeTlJUkUwRFNOQkQ4?=
 =?utf-8?B?L3Q1VkZMbDVXVzJLQ1poa2taZVE0dGx3dHZYUjhJQ1lCL2tldm00elpRdVRk?=
 =?utf-8?B?Q2E3UWw0UE9LZFRyUWFYVTdxRXd2cFpRc2hvNUNMTjRVNkZ5UUVkWjdUL3Zj?=
 =?utf-8?B?QXd2cGlVbkplcHRGQVpxR0o4TFZmS3laenRPME1Xd3NiMUl5cXI5Wng1VXQv?=
 =?utf-8?B?QXdmekFzVEZBeVNVR00zaytjUjN4Ui9tUWFmUytvRlRDbXNlMzhqUkJkaG9Y?=
 =?utf-8?B?NEpyY2RWRDlSbFc3OUFrbHFZMXZ4Nk5PWW4xQlJCZTVPU0U1RlBITFRPY2lW?=
 =?utf-8?B?bllWcW1lSm1yUEJaZlVEOE9CSW9wTXhyeElxY2ZDQkVuL1VPaDV6WFNlOXV5?=
 =?utf-8?B?WDE0TERXZUpBUGJRaWMrNVJDNFVYQ0FRSkJ6eEtSekJGaTdoQllLeXBTMUxO?=
 =?utf-8?B?ZmMyY1NEV2M3bG43RXloQlRVcDEwc080endwbEJJdzl0UjNYYTVmRDhnb3Uw?=
 =?utf-8?B?OUpxWTNXRkJnVnlXUEhlYlUzMXY1YUtJaFdVQzh6UHBBQXNWUDhxQUEvUWw3?=
 =?utf-8?B?Z2pVZ2tkTXptK1l4ak1keEdGWXk0SkdRNmV6L0VrWHNaQWV6aDkvYTExZkpL?=
 =?utf-8?B?Y3BldUU5MUVFMlJFZjB3dlRVNnVNV0hDYkdDbXNUUHBLV1plVm52OG1LK1Q3?=
 =?utf-8?B?dkZsNGMyQlIyQ0pFYkxwSC8zU2tsZ0JiU0RlUXBlSnNRNWZXMGp5OUt4V0xv?=
 =?utf-8?B?L3cyK1RyKyt0dDdxYWIvNTRIemNTYmc0U1YzdkdabVpkeTRaZVZFN3dNd091?=
 =?utf-8?B?eHA4SjR0dnVndGROZ0VXa1JtV0pwRGlZYUhDQWJJb1J2RTJha3N0WTRTQVBQ?=
 =?utf-8?B?QmpoUUtlNDdNbWRvR3F6ZnRHWUhRWXJLb2VwUUdRZVZkL1poZi80STNDUWx4?=
 =?utf-8?B?bUhjTzdvSzZxNWtpdWdEU2Qvckh6aWI1aVB3TTJsTzZkZk9VbVVPUmx6YVlD?=
 =?utf-8?B?MC9TNjlJSm1OVU16a215Z1R3cFp6aE9pSStHUmYrUzFMejd2KzRWWTZQR2lS?=
 =?utf-8?B?bFBWV1g3Vmk4dU4zM2lDTEFHeGo1bS9taVZ0Vmo3RStVdHFsVmhLSFpJblpx?=
 =?utf-8?B?RlZhZVBGREg1S2pLTTJBTFpCelFkbVNnM2lsYUpoL2tab2g4MzdxT0FlLy9m?=
 =?utf-8?B?NlpvOWo0dFhmUWxqbXpCNXA1UmowZGJSTm9Od0JXaWRyWHZwOGJuTWRvRWt5?=
 =?utf-8?B?ZmpSMUhmL0cyY2g0U2FyWUg3UHg1L3hpaXNSUGJqcHJ5U1g0enBOS3R6YW54?=
 =?utf-8?B?QjIwL2RYZDZ2WGxoelJ0MHlIZG1VTmNHcjVaNHp1azVwOUhSc2FCeEloc3BC?=
 =?utf-8?B?QUsyZDVpWDl3eVpyUksyL1VReWRvSzJ1NC9YWmx6SmRvRnE1cW1Tbm1ZNUNU?=
 =?utf-8?B?OG10VnVNaW40VWhWTm85WWZ1N0xSalQzSGJ3VmFwbGMzdStPTnMvSGFWOUxx?=
 =?utf-8?B?VnRXUDBEMUFPRUxMSDE4bDJhTklHSnE5Zk51cjBvdWN2QkFERGREZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0cdde9-3391-4bb0-26bb-08de57245874
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0013.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 06:31:15.2148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ry1xvVO4PzmYM0hNrwNOtnsr8AXhv3a7oxcAx7Kc+w3ScG/cDCGKt/pBI7jlkB+g3dwl19pSp/Wu3mnxyQDKDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9014



On 1/26/2026 12:49 AM, Wei Wang wrote:
> AMD Secure Memory Encryption (SME) marks individual memory pages as
> encrypted by setting the C-bit in page table entries. According to the
> AMD APM,any pages corresponding to MMIO addresses must be configured
> with the C-bit clear.
> 
> The current *_iommu_set_prot() implementation sets the C-bit on all PTEs
> in the IOMMU page tables. This is incorrect for PTEs backed by MMIO, and
> can break PCIe peer-to-peer communication when IOVA is used. Fix this by
> avoiding the C-bit for MMIO-backed mappings.
> 
> For amdv2 IOMMU page tables, there is a usage scenario for GVA->GPA
> mappings, and for the trusted MMIO in the TEE-IO case, the C-bit will need
> to be added to GPA. However, SNP guests do not yet support vIOMMU, and the
> trusted MMIO support is not ready in upstream. Adding the C-bit for trusted
> MMIO can be considered once those features land.
> 
> Fixes: 879ced2bab1b ("iommupt: Add the AMD IOMMU v1 page table format")
> Fixes: aef5de756ea8 ("iommupt: Add the x86 64 bit page table format")
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

