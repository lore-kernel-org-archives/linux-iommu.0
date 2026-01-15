Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011005.outbound.protection.outlook.com [40.107.208.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F833FE12
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468823; cv=fail; b=ZcrwKChnzIvb/EvQRsj2wc42ohhoT1IAsucy0eQhYB9yQhlwGj4nPrOhZaZPhOFHGUUE1wRHnAz7xEn79FO0GVgqkt7DR9/9FVPir9KkGfc7ZAiUzW1ULNquPAy8sc3K3Xs7MzEfkNkoK/fGS2Iz9yDOM9Ul28JNGN+nF3kVLKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468823; c=relaxed/simple;
	bh=X4VB7vOQB5bamDDtpw2SjoITXbdcU4Icu4GYv4VNgWs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YqIx5H+kcX1wT9uGt/ZaOmrAcV/l4vm8piHDh90qTDBSdh/foXy28vpRSC41hSCUxmqOAiqp7lcNHwqBR4/Wftndvcq/KOhpUTkVGn0pUylloxp4WJrh0co8hmjAVZXOyWM7ec0AxPG2qqV4nLJTGrFpEsQv8uiXVHMNcyLszpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MH4tthvd; arc=fail smtp.client-ip=40.107.208.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MH4tthvd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ksml192dl0dXAeaGDVePkHDHtdYtadZM8NIAZPzEmno/pc9FxC0YOcJH+fxTRwx7WG74kjfnyrSYafmdqFyk/fl9C8VP9NTHsK4vfjGoL3kaV9MtHdgntNfrPiNm5DZzdcdV/OvyUbc8pcZOU3NQYl0Pq9NEAgATRwevO2pC1dHGnRW3L1Hmu0K6UOV8+eDjtrmlLsBIetTV2MO5xKju4v+grP2cOTcUHrgZblNWqkDpfsqOKq4r7sY7VGC92wrmyqTqSviAhJg5yFlx748yHi1Q8cozxDixivuIS7+aBkJ23kO8BCupYyN6H4MzXtzygfKJL8rUSHcanJnC/WTWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhCr4wrGQrt1TJPqk3zhngVkX3wxH1HXI4Ksoll7uoA=;
 b=FsAZ/e624jBaKBeZZSPvNa3ScCe1YXo1wJ3yapQ6sajV5KoKoMRWt13lqOTfR87vEoXmZIqJqMMjFetcZw3Pvb5XR2/jGuBvHTvfuzN2uBqFJF3nAj+NzUi8JajInn7SS9BnIJnTvxPVPm5tSocXZoBBl6g559FRw+oLUtppbGyrUipqLHCD6ckqtGcV7TAviiZ6/OgpQFQFP7gFTot9Q8ECcs5hqZJgG5KDeGWWUn2vtp8lpiyTxlDD2o6c6XPCGfP5gMZqx+eO404P9B+/dQg2LBAK7yzbh1coXYlhFL5c04D2Xv4qZJPmBXJN920YR/gBI4m53bKvyIUmO6cKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhCr4wrGQrt1TJPqk3zhngVkX3wxH1HXI4Ksoll7uoA=;
 b=MH4tthvdo48Onii1mRilKeLPHby/jqr8ndJihOu2s/11Sq5ec3y0Yjas3EpoeYXHde35XSBVpgzbVaGRGhZLiyq4wJxGCi26PDANRvIWnpDAyZ0fZgika72r0GFA7Fg8EIk3no/2D1Y+6YDWN7mMwRbsTD1lTttrhjsckaL51xk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:20:19 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:20:19 +0000
Message-ID: <8ab60419-5fbc-418e-a059-e28e6c0682b0@amd.com>
Date: Thu, 15 Jan 2026 16:20:08 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/14] iommu/amd: Introduce helper function
 amd_iommu_update_dte()
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-6-suravee.suthikulpanit@amd.com>
 <aRYvFmHdUImiU0zA@Asurada-Nvidia>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aRYvFmHdUImiU0zA@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0195.apcprd04.prod.outlook.com
 (2603:1096:4:14::33) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: 05287559-4066-481e-ed90-08de54174d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU04VHBHMk9XZUFiWHdhdlhiQXlzVE5FeVJiRXFVcncySVZjWEhXNUJYaE9N?=
 =?utf-8?B?QlRaTTBJblBURUdTd2NUSkc3UnhFZVErdDFVY2daaXBtU2ltRDZPOXhtQ2sx?=
 =?utf-8?B?V3hkUFlDdVVYamF3QTNvQklTRzhGNjJLai95ZGlEajc1My85RGphUmgyYmlZ?=
 =?utf-8?B?c0RaSERJVzdSQnJ6c2paVm5Dd09yVUNjWDU1T1Bxa3E5aUNxcXFYM3d4Z0xo?=
 =?utf-8?B?ek42RUVEdGVFWEd5ZU5sUytkcFVvbDAyTmZsaUQ5SmVqb2tTNVZOSEtKQXAw?=
 =?utf-8?B?Q0c2YXZGanAra2o0T0ErTjFaMW1USnE0azVMNHVWb0JkY0ZMb3ZFcFBQV1Rk?=
 =?utf-8?B?UmdZQ0V4Qnc4eVJvWWkrQitueGR6aVNEd05TM3o3R3AzYld6T2FhdUpZRHZP?=
 =?utf-8?B?V3VJVFhsazRHZXp1MlptWmZ2TC84SXBzOWRvT3J1R2RuM1RxeitCby9KNGZ2?=
 =?utf-8?B?ZUd4YzQrajBGbG1BWjJjTm5qTjYrcDN4cWtVUmw4QytpY211ZDhzTFFuTDZk?=
 =?utf-8?B?NWNKOTMyWG9OY1JUWG0zUGhmK01POFVsaHB3S2hWcm9ST0hXRTBYN2tVSVNm?=
 =?utf-8?B?NDU1dkd4RUtjQjRaOWxZeGkvZVJhTi9oUjZ5MkNuYUNmcjIzUjNNZDNBQWs4?=
 =?utf-8?B?MkxBbnhKbDl5NDh1b1lmU1lGTFVYWFY1bjJVRUNVbHFnTXRnL2tCMlVOUzZF?=
 =?utf-8?B?NSs0eE1JZWpERkRMWDdtVWd0WTBrNXFTTlhmQkZwVEZZc3hZNlNFdmpKL2tW?=
 =?utf-8?B?a1Z6ZW1TeVN4TkkxQ00vTlhTNEFwa3NTK2tZTTAxcldPR0IwVUI0MCtOVWFq?=
 =?utf-8?B?MDFUWktHeENBSTlwMU1kMmtOMjQzcWlSTkt1c3BxVkNLK2RaMWlLWmpHUUcr?=
 =?utf-8?B?V2hIaE9wTURibXVTME84bmMrWTJ4T0h3Mk1wWG1rbU0ySFNzbCtROU1IV3Ja?=
 =?utf-8?B?Z1lUWXhKcEpaTHJIZHNzazNRSHZIaDhnYTFQek9Jbm1PWi82T2tqR0k4M3Z1?=
 =?utf-8?B?R2FneHBkK3hLOHVpdkFObGVJa0dsczhQUmtkWENuYUlUTmVURlFkWXVzOGJQ?=
 =?utf-8?B?WCtuSHNxNXhFSWZDRk1Xd01FRmVtR2U1WEN5QmxRVEJqM3ZlOEs1RGdXa1No?=
 =?utf-8?B?c0txaWNVSlRuWFAySEp5eWhmTkN0M2JJV3hoRWx3Ymk4SjNHOTd4Z1VmQUR0?=
 =?utf-8?B?cm5Jb1k0VEQ4ZWorUis4NzIyd2JRVGd1ZEJFaldzS01LMHFUR3V0TmNMT05q?=
 =?utf-8?B?NStWendNMWJiaU0vY2lSZHg0d3R6ejh3d0w0NFN2d2hzUzB5cEc3WlZZWnRO?=
 =?utf-8?B?SnprRzdQN1crNXhCQ0w5QTFKRklIemNWc0VFdGpoYUN3UHNNWDFHYXF0bEVi?=
 =?utf-8?B?YWw4YW1NemtQZkFsV0FWdGdTdXFudnlTc2pubWRaakVuSWRRbWNhelFwYWZl?=
 =?utf-8?B?OE15K29LTjNXL2JQVnZmM2duZjF2SVg0N29Fb3lZMGdrQVordTlEcllzOFU5?=
 =?utf-8?B?VXNHZ1F3Y1ZuMXk4a3RhUGV5QWN6M1R3SlJxbGFjT2VoWTZ2bUtINVlPQ1Rk?=
 =?utf-8?B?c0RRdVBLMUpyL05KaXdScnE1QjV3anI3a1hpZG1MSCtZUXQ4K3hUc1NERG50?=
 =?utf-8?B?MmlKZE4xaHB0RGc1Z3IxRlU3a2p3R2dEQktlckpob2NpckVsWjAzR0lkbE40?=
 =?utf-8?B?Y2ptcE9PVGQ5NkorM0REdkZzZHZJV3RnSEJCZWpQd1RtejB4aHI3MDNmRDlz?=
 =?utf-8?B?MGxSTTFpaVJxR0U1ZFRJajBiZWdMNlF1b1ErWXJ6L3Qwc0ZmRkUxdlcya09x?=
 =?utf-8?B?ZTlURDU5YnV2bjFSaitIMmttYU1ESEZrZ1pPU0ZXNjZDMG0rTm1SZUFHVHZy?=
 =?utf-8?B?OTZpOFRsT0hKQzVBTnh4V0FucHdza2IzUWJRdGR2TE9sUEdmM3dFY1BvWFox?=
 =?utf-8?B?WDZ5WUF2STAzem1QRTFFYXFxN1BMUlpYMHU0VE5VZXBuWFpacW1oa3B1NHNy?=
 =?utf-8?B?UTlxekU4SjhqZkI2N3JZb2kvWXA2emxudkY1YXczeEJXWFRQOUw4Mlg1TFds?=
 =?utf-8?B?dWJkV1U3ZHRsWkdLbXFEbFhZanVBM25ldEtMQjg4WFlXSUoyRmF6NUV4RmF2?=
 =?utf-8?Q?H4AM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGVHczFVNEptSFZpZ0t3eFE3ZzdCanV0VjJuOGdBb081dFVmZUtmUmhyUmxo?=
 =?utf-8?B?UE5XblhlWGVDYkx2MmdIbE5ZZm1yejl4aFF4bXpDQUFKYzJhcmd5emdGTXNO?=
 =?utf-8?B?QkV1T2dOay85MmRFbVFwOUFxK3RkTWh3VzR1RDl6M04zOW03SXYwK214OW5o?=
 =?utf-8?B?cHc0di96Y1NqcUp4SWpGNGZGL1RHT2FXYkVCeFB2Mm9OMWZuZ3RLZ2dRK2Ey?=
 =?utf-8?B?U2NVTlptK1NxU0IxL3d3R1dlL0VLamo1MEd3dnk5UGcxMmZKZVlMdk5LWlp0?=
 =?utf-8?B?akJ2S0dWZjllaERPNTdLSFEvd0swTWlSYVFOdGI0dCt1SHJzb3BtaG1NYk5s?=
 =?utf-8?B?N2RDMHExWXpOSytYQUlnUlRzc3J2RVR6MFlkQlBHbHM3bTBRMlp1VGhiYkhN?=
 =?utf-8?B?SFpzNEdrSVgwaHg4RlBXejh0TEZyMFJWNUhSOExVenJlUnBJZUh6Qkp4anEx?=
 =?utf-8?B?YzVEQWk1QXpNb3ZOcXdiMHB3enRIUSs5N254ZWFSUmkvZVZoN1FmYTdBQm5X?=
 =?utf-8?B?RFV6dHZlUFd6WWdkWW4yZDdZWDFoZ1pSSTdVU1pIMWFibHRSZmszVWpJUFRj?=
 =?utf-8?B?cmZkblFOZWVSdUpoWGpmWlFya0NFQWxFek1aRXJiQmRQWGozc2hFdDcyY0Ni?=
 =?utf-8?B?RVU3cmphQUdwS0ZRMFdMcDJlMzhrekVrZkh2UWh0RStSbFllM3BiSEJtajVT?=
 =?utf-8?B?enhSUFNNaXVBaElxUzVOVmEybEcxV3prQUhQMWtwUjJuOG9meTdRNGZyLzVZ?=
 =?utf-8?B?RWFRYUNWVXpnV2t1aVdjR284bHNyeHRKSzJxeWRFWXB0SDJUbjA2TXZIay9Q?=
 =?utf-8?B?SHZCbktiOWJsZGs4eVF3clhoNDIvSDdUdnhiYjNrdVFNWTRNRlJzaHlCWEp3?=
 =?utf-8?B?YzBadHE4QStVUHJPYnNORFM3a0RuQmtCYWxXc2pRemJkY2hXdkVjNXpYdGFE?=
 =?utf-8?B?ZHBCTUFxekU5VURvYU1UY1pXSTIrcy9SWmhOa1E4UmlmVWo3cnhCa3FRWWw4?=
 =?utf-8?B?d3ZmVGpDVDdKNm5nekM3cTBXMFVSL2pKdGViR016WG8zVHlNcTliZjhGWUcy?=
 =?utf-8?B?a25kWnZtRm5NQ0tpdUJzZXIzQkJIaFBXbFdhRHorRkllMmZvOXl3ZWdwUzVJ?=
 =?utf-8?B?VG1rUUV4a2Y2THQ4VDBIZURPR1F6eVJtUHU2WXF1aUI3T3lsVTV6czFESmVJ?=
 =?utf-8?B?ZUFFZkJSMDJWWWVKZGlrYW9Db2loN2kzWVpDZGNWSkp1WW9ZUHk2MlEvUWZx?=
 =?utf-8?B?WEVrQzVjeC9aNHZ4NzNqVG5DdlgzS1J6NjdCVTFTQzM2aFA5bHY2MmRYcDk1?=
 =?utf-8?B?MDBuN2JhL0tCdjdLN1krcXpKNUFNNlB6MHYxYzdJdWF3M2ordVRmeGozakhB?=
 =?utf-8?B?MkVzZlpQdlMvYnphUHFycW9iYTFOelpINmREUER4VHd0T1hrTTFWaGMxYjQw?=
 =?utf-8?B?Nll0bGJ0UHlRUjFQRHI5OGF3MzNOR2wwSGFLaEIxSEtXRkowbTQ3OXNYQUV5?=
 =?utf-8?B?K3lIdmN2cWpKR2RURTk2eDhFQUhMS0pnZklMWnJTalFhS0FWNXBMWkN6bTJQ?=
 =?utf-8?B?Q05RS0RQNnp6QmYyalZCMjhscTV0MHZ0MlcxTVg5SGU1K2tkQllranMrenRk?=
 =?utf-8?B?YklSN0tTby9Ma1h4RVE5T2dLSnRwalJlSHNXVTdQcUQyL0wvdU1zSzZmVjNC?=
 =?utf-8?B?Mms2MUZPdmFrcVNxNllnZTRuZWtkcmVUSUEzK3oycHl4eUN4L2gyZWNuZ29i?=
 =?utf-8?B?ZWU5OXFPUVd1czdoYzRPUXVXc2hGbXJaNnJQUzlSZm5WZ2VoZ3I3ZUVjdWdW?=
 =?utf-8?B?Y2ZRTEdKQ1RudHVidWFzSWsvSElSWkE5aHNnOXRNUDNOaUpTNjVZc2orNWxE?=
 =?utf-8?B?UGpqdTB1WmNCZElSQ1N2am1KUmpBbWg2cUdrYkJsQ1R1V3JuRUs3U0loYUdY?=
 =?utf-8?B?REZlY3ZZYkJTc0Q1YjUrWTM5KzRSMUNKek96MVF1bk5Ec3ErYWdCQ0xIeXBp?=
 =?utf-8?B?YmNFakRJVnY0dGpLUDNxVkpaK1ZHQjFGYlAzV0x3YWtXNy83WXcrV0JnU1JF?=
 =?utf-8?B?eko2am8wekk0L0pHOTFDMUkrU25OTDAvS3NOcFlJNTZIN3pMcTFmZG1NeFIx?=
 =?utf-8?B?SHRoVnZoQWpYczRNMTNtSWUyd0hXa1NEUnQ4cDgyZjlzUEd5T3RjdzJ4aU1w?=
 =?utf-8?B?MUpWR0ZiRWwxVE1VU0dlNmwwM0ZaV3pOU2NKR3dyVDU0QWR6MjZRMzRoalRZ?=
 =?utf-8?B?S01uVXBmdjcyRm0rREx1eWJwYlJxaWlKZEF3NFhyRXNQajdRazh0Z3N2NVFm?=
 =?utf-8?B?aDMxWDc5Wm1PdWltd3E3bnhqWW1YYmI1a1BpZEYwOXVxN2tCVGZiZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05287559-4066-481e-ed90-08de54174d0c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:20:19.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mK8YB90wU20XWka8pBMSNhZGRUIfNZfvaamRXAs+UqFdT/44B2a+E7+bfySG1Uyqj4k3d/eQEdeF8107l8UhTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544



On 11/14/2025 2:18 AM, Nicolin Chen wrote:
> On Wed, Nov 12, 2025 at 06:24:57PM +0000, Suravee Suthikulpanit wrote:
>> +void amd_iommu_update_dte(struct amd_iommu *iommu,
>> +			     struct iommu_dev_data *dev_data,
>> +			     struct dev_table_entry *new)
>> +{
>> +	update_dte256(iommu, dev_data, new);
>> +	clone_aliases(iommu, dev_data->dev);
>> +	device_flush_dte(dev_data);
>> +	iommu_completion_wait(iommu);
>> +}
>> +
>>   static void get_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
>>   		      struct dev_table_entry *dte)
>>   {
>> @@ -2088,7 +2104,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>   
>>   	set_dte_gcr3_table(iommu, dev_data, &new);
>>   
>> -	update_dte256(iommu, dev_data, &new);
>> +	amd_iommu_update_dte(iommu, dev_data, &new);
>>   
>>   	/*
>>   	 * A kdump kernel might be replacing a domain ID that was copied from
>> @@ -2108,7 +2124,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
>>   	struct dev_table_entry new = {};
>>   
>>   	amd_iommu_make_clear_dte(dev_data, &new);
>> -	update_dte256(iommu, dev_data, &new);
>> +	amd_iommu_update_dte(iommu, dev_data, &new);
>>   }
>>   
>>   /* Update and flush DTE for the given device */
>> @@ -2120,10 +2136,6 @@ static void dev_update_dte(struct iommu_dev_data *dev_data, bool set)
>>   		set_dte_entry(iommu, dev_data, 0, 0);
>>   	else
>>   		clear_dte_entry(iommu, dev_data);
> 
> I found these two are somewhat unnecessary.
> 
> set_dte_entry()
> {
> 	u32 old_domid;
> 
> 	make_clear_dte(dev_data, dte, &new);
> 	....
> 	amd_iommu_update_dte(iommu, dev_data, &new);
> 	if (old_domid)
> 		amd_iommu_flush_tlb_domid(iommu, old_domid);
> }
> 
> clear_dte_entry()
> {
> 	make_clear_dte(dev_data, dte, &new);
> 	amd_iommu_update_dte(iommu, dev_data, &new);
> }
> 
> And given that dev_update_dte() now are just calling these them
> without any other thing to do. Why not just unwrap them:
> 
> dev_update_dte(struct iommu_dev_data *dev_data, bool set)
> {
> 	u32 old_domid = 0;
> 
> 	make_clear_dte(dev_data, dte, &new);
> 	if (!set)
> 		goto update_dte;
> 	....
> update_dte:
> 	amd_iommu_update_dte(iommu, dev_data, &new);
> 	if (old_domid)
> 		amd_iommu_flush_tlb_domid(iommu, old_domid);
> }
> 
> ?

Currently, set_dte_entry() is called from multiple call-path. Therefore, 
I would like to keep this way to simplify the code reuse.  The 
clear_dte_entry() is called only from one place, but I feel that having 
a separate function is simpler to read.

Thanks,
Suravee
