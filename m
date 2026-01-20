Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013064.outbound.protection.outlook.com [40.93.196.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F339426EAD
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917419; cv=fail; b=sUKoQ9anoVged5fChRL1/HEwlYxramOxpZSkhi8J/AVHU+FeoNHo/HZTaYm8tYWbYD87HFnPAUSuOarhlLWhqozaEO5ffvVWCpDI+JqnqICXW6fYBVfS+zDBb3bGMiN26SHzm2W6TvrBzLPwwprM0lA84VMPWVMPlu3VFDku6Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917419; c=relaxed/simple;
	bh=l4J9E4FOBSQhiuGpxwUy94VHhz4OGVfRYCP1mcZsgzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=R1EPuH4RnTipFWPHpqIGZ1AmUMdd3ge7WW1RWFeJQw61u1FFvgZ0R2KRyi8WMXXSAe6lIdWyZ1kN8PqQtB3AaJ2fso8kEmRmr9x0RWPCWHxs4BY6Xj1R3haOTYE6E4ajBAYiWc2Y4VMD1T3d9+KrAtzDE9XJ5QOeh07PZtpDfk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YRo/jw5T; arc=fail smtp.client-ip=40.93.196.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YRo/jw5T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVSDlml9Q8YcPiONJXgo44e3xuxkPzM95NcNBVpIWKSrr80V6NCITEXiAQxGAu2N1991E+hAQXH4b/SdNttkVVv3JUyk427FomQwhKO6EtKUvJZmm27FdIhofvr+s/AyT24JfE2WpWRGOMyz6JfJBvOJTT1iLvtz/zTWXsiv7V1/UaIaLBstjoCH8WjJ3BSdzRxXFYqYhprdOqMGyAz/vdvE+PsyOVACyBz0fu4FVEXdVTCKbNEaiiXOcPfg7zbk6W9tfXFzW1z/fKnMpCVuGeaTp223ke3P/vzPDyJjJ3XGnpwT/OW9wIBHqh+Leg4qglOgjj1MyCh3N+X8Nb4kqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgJyymWBXm8wNQRREnGeoi/qtnGejfwUlLxsBh8XRXM=;
 b=T6+hsYKZyay2aO9dgq4r4tgZ2sSEv+0IU9sbXvHjmdG4bfs2SRjypN4iCmj8GFEPjkzb2PsLuLGQhtDYmWNUJkwAsotcfLmMQnTBGuovVjdxTY9TeLuQsdVnaGtQb/PEGVaC77do6KA492GDTHO3uTnhirz68p9yctnWRcRhvE7VRMnIC3H+06K7Q8aYorZwmZbaltRuIsLHiyP3Z7nx3o6PtG1ClxeZShOFj14+joWrlICRsbb+GDa9wtt9VYedwLC+VU1K6L2QSG8kWwXpbsPUM+OQIlPQ3bYeWKAOvL19xBIZE0NMFvA6+Lqrob0TSPuLDEabLjnMkI/mleEiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgJyymWBXm8wNQRREnGeoi/qtnGejfwUlLxsBh8XRXM=;
 b=YRo/jw5TDqjjtP13IGYg35pLRFsBByJx22tIyPqep9yd1rVcjuRHf1U8ehQF8C3rfVRHf5aIhjl324O+Kner3Tn/bntJ21XOEwfQ4pJRMc6oMPPswBYhF16WN/xM1EFdKdsQS5HZ9msFK+0q88SE7zOtrX9Ys832Hy8sU41sgsgvH/jWcxB2YLFyw1IAeYIUMnxkH3yxt5r7pGLf7PWQzDCdcYeZF01PMDbwsxPAZzW6nvVGP8RUrbL/A6WBeQMbLo+RrR7zV94r1Ue+Dr9YQmso+7el4lyXMYCExAbKcmRva1QX4AWyUmDANQsvf7suKpZBhtQWK5JmM94xdMVEaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 13:56:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.008; Tue, 20 Jan 2026
 13:56:55 +0000
Date: Tue, 20 Jan 2026 09:56:54 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommu/vt-d: Ensure atomicity in context and PASID
 entry updates
Message-ID: <20260120135654.GB1134360@nvidia.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR0102CA0026.prod.exchangelabs.com
 (2603:10b6:207:18::39) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d17f1d0-e42f-4fc1-ecd6-08de582bc551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODVGdldJOE53bW05NStqZHhKblhPcWJNSTRnWXhpR28xMWFVOHhIVVE0V0Ni?=
 =?utf-8?B?M25RemhHTVFwelZhZUM2eFFYZHI1UTMyYUFWalExOGhYUk4yczFweHNvaXNM?=
 =?utf-8?B?RFJFRXUvcTJYQ0VuRlpnVXJJREtxamhaR25UajVKNC82RGZsYXNJWURTV2dP?=
 =?utf-8?B?dm5jdks2YkxNUldHL3F0OWE1dFl6QU5kTHppSXlxVlFTSnFFcnNBNmc2K294?=
 =?utf-8?B?YkRnemdTQnlicnhpLzdWbFVaTjVCcDd2NDRwbE9vQ2VWMzB6cHZaa1VHcWlz?=
 =?utf-8?B?SFlJRUIvMUJVL0wvNnUzTjFoTWtYWE5OeWdPQnVUYnBrWmNPN2hpcWE5WEs4?=
 =?utf-8?B?YjEzR1E0Y1pYVEpwRzVRb29FbndsZVppZm4rcC8zYm9HNE0xbGV3U0hxOHAz?=
 =?utf-8?B?WWp1T3FlSUJoT2gxQUFHSk4wTmlVR0ZvbFc0VndJTFNQY3FuUER4aEVKUWoy?=
 =?utf-8?B?RExMbUwxa2lhb21rVHpyMjd0bmZ3L203N0hDcjliVjJjUjJPbytMdFlGaktp?=
 =?utf-8?B?Z0p6bW1tbzRONEttVVZ0RWJoeXB3WFRSU0dvZkV5YTVJVklteUtXSVBOSkRD?=
 =?utf-8?B?SVExSEE1YkNub2hWcGRGQXU3MmYrcHFESmJxcWQ1eFFZeDh0dDdZeXBLUnRN?=
 =?utf-8?B?SzV3cjFuQzA2U211MHV2NXI0dGpKaHphS08wbi9HVE9TSmxCdGhjOEJpKzZ2?=
 =?utf-8?B?ZWV0VnkzQ0FjY1RZYURtUi80YUVEZko4bStSUDVPRGpVbnNDZnVZUGNaWlM1?=
 =?utf-8?B?a0lPa3YyYldPMWFCcmdlenpwOWFUKzk4R3JSM2N6ckhQclhtUUU4Q1RTM1hm?=
 =?utf-8?B?NXlaS2JiOWd3M01uSTBYb0E5YlRVUkpvbW51V3o4cGR4R2g5enFGTnd5blNL?=
 =?utf-8?B?bUVKNTZqd0VzL0ZMSE1LSDRpQ1hKby9IUFZQZEZGSjRHL3FaTUFSdFRQUVdk?=
 =?utf-8?B?QVlyai9tR1VweFNpQkhnbHBUWDlQbnRwdTRsc1FKeXdNT2FLd1lEL2hKa1RW?=
 =?utf-8?B?cnlKK1M0SFlMa1g4SnFFWDlDZXY4YnBUMGZZZU82RzI3dlI3aXJvOFM4N2hK?=
 =?utf-8?B?RzhGWjMrZGlmWVZDNHYrSkV6RUp1aXdiQTlSd1pURVpvdEZtbGpMTkpYZlZw?=
 =?utf-8?B?WllMWkIzdEJNdDZteDRkT1N4MFVuK3BVRFJxNWozOUZUTDZ4S3B0aHZKckJG?=
 =?utf-8?B?T2dQSTdCUjdySWh2ZjhLTnc0WkR1UkRvL1BPd05kclNqbzY5K3BMWGMwOXBj?=
 =?utf-8?B?U0kySHlwb3RXMDFGdmNWYlpZL3pIS3BtL0svOWZIeUk1WmFpYlhFQUVPL2c2?=
 =?utf-8?B?d09HakpxWit6NmFtZExXVWhqWFI4UWprQzViTmJ1MFNPbG5ZS25mR3lxb25D?=
 =?utf-8?B?b1c5VE5aSjdOc2xUZldyd0NYS1JUcE1sRWhQN3o4amVqeDJBQUFtcGZ6UTB1?=
 =?utf-8?B?b0dFUi9BNmlSUGt3dEtaQ2s2MlpXSHlpNitveTZrVUEzU2dmK1NoWjlmWnhw?=
 =?utf-8?B?S3BDSmpLUXlyVFhpdGRpZHpzNC9YZTJxV0ZtZjhvazk3K3NpOEx5RE95SkJU?=
 =?utf-8?B?R2NlKzJqYzVVa3BJY3lOdVZRbTZZb0FPaGRRaDhEcUhxSS83K042c0FrQUVV?=
 =?utf-8?B?NktFTFlZbG12bCs3TStHZk83eHpROFY0MVZWd3BTWFlPNk9nNDVyaVM2bWFK?=
 =?utf-8?B?TnM4M3VPTU0wOUxUZDBiZ3ZtVlJoWE1laHo5L0R4VXpvZU0vdUJPWlp6cEs5?=
 =?utf-8?B?MmVuMEpaNTA4aVVGN210aXNzRzFIQXpnNGJBQlFlcjQyUTZ3OEYveS9WckM4?=
 =?utf-8?B?by9jbk5ySW5QaGV1S3VRc2MxSXgxTk42V2tqUGR1Q213UVhTTVZybnNnc2dP?=
 =?utf-8?B?Vjh4aUNJMXIwQmM0OFFReDlFK0phSEdwS0tmeXVBaG1RSDlUb1pNNXpMbm4v?=
 =?utf-8?B?dkltcTVoaWtwZGRFYkJlZjkzM1ZQZjBhT3Iyd0FtcHEvbGFDZ2VOU1prTGZk?=
 =?utf-8?B?dmxobGRKY3FBcWRKRkdraFRrQXZVTC90R01Sc0thWnVHdHVWLzYwb2NWWVU3?=
 =?utf-8?B?azNOa1Bzc0tnN0RVTXJqQjlzcU5OZFZ2UkdpZnFsalNYSTB5OVd5VTk4TlhV?=
 =?utf-8?Q?3S20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amZkdDN6UzhJN1ZUUEdtSTZZK1J1bDhMUlIwdmdFTGFpaE8zQ0NGcjJBZzJh?=
 =?utf-8?B?Y1Qya1JzUFRTNXFURk4za3dvWGVLQ2h1TzNjdHhGdmI2aWp2a3d5VWpQQ2FX?=
 =?utf-8?B?QUIrbzBwTHBxak5LbmpWUTUzK01XbWsya1dJK2xrNTkyMlZmcXpEc1pySjV0?=
 =?utf-8?B?YysxL0hWZldsNkNCeHFmRzl2VWhxb3YwOEZVc2l1ekVlZUFobDJKSTdmbEJj?=
 =?utf-8?B?T3ZTQldXTUZDenZIWGZZOFMrVXZBMnd6WjlYUjM4emlPQnNxaXhHOEo5Zzg0?=
 =?utf-8?B?Z1IvalJkbDc5ZzQ1SVlZMUNRT29mQzZUWmRJUlNySlp6WnZxRXdIN25sSTBj?=
 =?utf-8?B?UTNzeTNBdHN0alFHbVhVTUhKWHhhOTJxZFJSNVVzK3BIbHZqUTg5QmVFcER3?=
 =?utf-8?B?TjZ4TUcxT0V2ckFVTXlmME9WOU4xV2l2eEQrN2gvOU1wcStiYkgwdjdxV1VZ?=
 =?utf-8?B?ZjdVRTlvRXljSzc4MTFYWlMvaHdIODJBUWJ4UTdaNm5tZ1VBY0ZLRldGdzdG?=
 =?utf-8?B?dUxNRllMZ1BsMWprVGZMWVMvUlRGM09XWVdwNk9nQTU2aDEvK2c3K0lMb1Ar?=
 =?utf-8?B?NW9TaE15K3FsRkE3S0FBMmZrVFVYU2Q3aFpLc0VWMC9wMCtmSlFpY1dYTXVG?=
 =?utf-8?B?Sk5iRjlnVmtZZ0xVNmp1TjBzMUhRM0tpOWtsdmZRVnFNZXRaQ0ZmUEJIRmdx?=
 =?utf-8?B?bDJGZWtyaERFYzVDWUhyRmxSbWpCUkpZYUx4cWdDL1M3YkI0THNsSFpXUTdJ?=
 =?utf-8?B?TU9nMnczd2V3MXova0w2OXNiNjM2TWVXbmNmaTNLZUt2dWF3Yi9WelFkUVZm?=
 =?utf-8?B?T0lTNGZCejJBL0RMNUZqL1dPNHNZa3NtU2JvYlFNbEs1eUlDT2VNa0tMNkFK?=
 =?utf-8?B?eHUrSkR6Q2phOW9vZHNRSnJxcWl4SXBqc1U4Q2YrN3NnbWx2Q1JxMXlmUEJO?=
 =?utf-8?B?TFZyMFN5NDNKN1FndGg3U0RnL20rZHFvV2JTYTAwbTg0MjNBZXVnZDdmMWs0?=
 =?utf-8?B?QzhqdXZVdk8rTnJPUlRvaUU2a0djVGgzT3dXY0t6ZlF5WXZSYys4OWhDNHQ1?=
 =?utf-8?B?Y01Xa3R4MzZEVGlVeXpMNWd0ZW9RNUhOQzlZdExXZ1ByVVlERVdHYzdBRnpF?=
 =?utf-8?B?VXZKTExzYk1DWjNYb1BlSUplTjU5TU05WTdMRTBKYXlQY0IvNVhwTmphODlL?=
 =?utf-8?B?ekRwZm9pdW1sSzgraTdWSHR2WTBieGxoRDNJUzVhTEdNOFMxaER3dmFqb2sv?=
 =?utf-8?B?Yi9Xd05pRVZ5QXYxeWJoNmtCTTJtRExwNlBlVUp0aU9SeitMS0dEQjdPTExw?=
 =?utf-8?B?OWFGTTVZaGlUU2h1OVcyMXZIK1YyK0xUWnNoei9BbG1ldk9KY3hseFNZMnBB?=
 =?utf-8?B?Q2d3Y3BnVW8zTDdhUmlJb25sRi9JWUUxTC9lVHdITUUxemFIN3JRSUpadXY1?=
 =?utf-8?B?QzI1eGdDZ0F3ajh5MGF6cmQwRHRYazQyTit4T2dPNzJMSnlQTG1GejVyK0tX?=
 =?utf-8?B?amNHZUh0cUZmSUNTVHRyM09tMzFVRC9UQW9KaFJoNzRQcnNjN3pOYjBjYUVW?=
 =?utf-8?B?aDN0U2l0ZzRuZnJYYUQ1QXRSUUtRMW5ITExaWVExNStnZ3h3ek5OQmxsSHNw?=
 =?utf-8?B?YnVCQi9kN2hWQkVpeWl0Tzd5azFZWERkYXhSNHN3c1ZBQ3U3NkV4bG5YS1Z0?=
 =?utf-8?B?dFRkbEV4d0MydVN6UzBKUWZET1hYNTA3K0JydU82TVh0K28xeTN6NjRrQ1VO?=
 =?utf-8?B?U1F6R3J2VktpUkRzMWZic0M4WUJIMk9tL3RCT3FteWxyRTJTNlN5Z3MrU0dQ?=
 =?utf-8?B?WHdLRHZVa1VJaDJkcklyOHNOdjlTZHNMSWJyOVl4bW1IREZxRTlCOGgrcEZw?=
 =?utf-8?B?SVF3KzFtM1huTFk5dDlTc0xyTTZmanhrN2pzOVM0QUNOVCtDRTc4SzFibUps?=
 =?utf-8?B?bFhkc1JGSUhBMnF5OTF2SDlCazcyZFU3RTE1NGpKS3Q5cUt0Ty9UZ3lSOFBi?=
 =?utf-8?B?ajc1MzREQmMyT1FkOTNMS0VEN1dpRUpEZUxQOCt3MWt2MzZrZWpLY2dtQ3hr?=
 =?utf-8?B?SDF6Y2x3dmVDU003NDc1L3Zzakdrc2M3MzQ0a0kyMUJYa3ZUc09vdkZqSGpk?=
 =?utf-8?B?RysyUkxPV3Via2R5QnAxclVzL1RaZnViQlAxSnpmTEdidVIycWdqNldjd3Nt?=
 =?utf-8?B?VkpnR25IWEJoOG5QbXBWRHRUL3did0NTa1FVOThMWUxjbjN0QWNORHZMN0Ry?=
 =?utf-8?B?Z2l6OWpWYU9neG1MNGNDdzVMSEJDbTUrSE5UK3ppdkc2KzhFdVZObC9XSkNR?=
 =?utf-8?B?ZUVWcXBmTHVSK0FpMGwrNkdISEVUalR2T0RkUHM5QWJZNkoxSTFDQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d17f1d0-e42f-4fc1-ecd6-08de582bc551
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 13:56:55.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WO209SGKBkv5TcEgcUAlOG3WDjitW1sdH/e/wvca2ypMxj1/x/SBwNBBgMYR2oGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

On Tue, Jan 20, 2026 at 02:18:11PM +0800, Lu Baolu wrote:
> This is a follow-up from recent discussions in the iommu community
> mailing list [1] [2] regarding potential race conditions in table
> entry updates.
> 
> The Intel VT-d hardware fetches translation table entries (context
> entries and PASID entries) in 128-bit (16-byte) chunks. Currently, the
> Linux driver often updates these entries using multiple 64-bit writes.
> This creates a race condition where the IOMMU hardware may fetch a
> "torn" entry — a mixture of old and new data — during a CPU update. This
> can lead to unpredictable hardware behavior, spurious faults, or system
> instability.
> 
> This addresses these atomicity issues by following the translation table
> entry ownership handshake protocal recommended by the VT-d specification.

This seems like a reasonable first series

Thanks,
Jason
