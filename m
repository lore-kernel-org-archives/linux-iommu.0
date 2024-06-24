Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B33A13D8B3
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239176; cv=fail; b=fnHziPlcZEf5MZf4eaVIbyyiqcqU9n41UPbUGdt5fip3lQ99pdLNkqi75XchuNCTA4e4pAOYpxeK3TeqmnLplc19ePt9p1fy2su+KccPD4KYlg5tTIu6Pw7b69f4cJ2xRdQSzSqWVHBg/OrDL9U8w8OyRmpo/BfRgm5daDcF44s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239176; c=relaxed/simple;
	bh=oGmDqbGH+Jp5OP4PfaKfc0TvkqR8k80OWRbRcQLdSdE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kNlmVWoFzxYWs2iMt+XLGXKVf9HfNNnwpSfETUEouWkqLOhkK3WAdBP2so+YDAm1fUXeFh9QMLqFg5iiuECeJZsf5BMzd4za2aFjzhO2G8PY66vxG44HqaFexSmyForurHu4HdqkRSAzP9umN1W4MG/BFrelAFGoe3m70dJSBG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZnALgJNH; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZnALgJNH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOUIz/OnLKay64/vegWp6PdzstC+AiZ5I3xXWS/RBagRjhOmpn3yvd1HxTB6qKQ7z+w50+XVATQWjpUrOcntAxHL8xKZbKvm9GEDr/us+FDvrISqOpRg0/JWmxTFWqRNMQ/pXvsMX3zdtXm7BXnQToZtWis36aqjoxptRaVSOBJ6t0SFttATNUgYVMFwKU+IodAlkRs+kygGSzWfMEmZrNPujGUGyDClsXg8i0FlNTT7E1DZ1yHeC/rTuPYxexNgy3+hxDtyGmM4I8R0wOhWNqe0jnfw1eovPdJQaAPVQfxLF34LNPFJ4aKBNCiCQKO90FeFf+hLuaJ33iJFn6OLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxTanFFL7LhaLHUuTyalyKM8z7/iCO8ksosBlNGicRE=;
 b=ItOne/PGNQOo8xh4lua9cfoT1YCQrwYBNDD+esNbk0Y9Rq1mCd75+4fWoJ6TkOwtG0sv/PvJ7P/w8dTsDwKNDYLu5ogDrh3KPE3YfsUqaXlzz/ZUAq9nqViT0MN3tvLemWvI2HJn0jTlwUhbHb2VKKU6TxXZwPvv4YvKVVLWK5ziaATym+l36YO5zfgXNovi2rHzy4Z1nly4bUq249XuHT+pTZl8xkmcCCgnGW87pDBxeNUqYDWAtnzshRiv5BAnPsyNMhJV/dlE1WK/dN+GsJ9avHoo9ANtyDE7khhYATKPXt+w22ywXQMj3WSPLoRfCb3rLy2EgorbHom1ySB4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxTanFFL7LhaLHUuTyalyKM8z7/iCO8ksosBlNGicRE=;
 b=ZnALgJNHgKmYedHl3Es1giWE736iu+yHIxZudGCooakIKGn3O0Y0AfedYGk28Z6Zo2jV2cjs2IZuI35g7Ij/3xuoNl4nJI5muD347J/I/KMkHydl0ntdHEL+Dys6Q4MEIuM2IBpyAzoNNM9LP1SDmBsaTgTTx9/eiRSYyo1Ha6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 14:26:12 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 14:26:12 +0000
Message-ID: <92033ab6-fb55-4206-9cb9-f81b5b6eede6@amd.com>
Date: Mon, 24 Jun 2024 19:56:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <bdbb40da-faa5-4321-a58b-5fcffcbc818c@amd.com>
 <8c78f966-539c-4c81-92a6-32d32bb10e8b@linux.intel.com>
 <657c7e03-91ef-4765-be7c-1f57eb45e467@amd.com>
 <20240620140815.GO791043@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240620140815.GO791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::44) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 65813613-d495-47cd-0299-08dc945998cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjQwZ29XZ2p0TXl5NXZQdm1pb01hc2pkbmlqb1dkQVFscDlHYXEvQ015Vmxa?=
 =?utf-8?B?MlhxQy9hWlB4UGF1TksvVVRBSmVOYjJLWERPN3BuYUFuN2JWUTBMM3J5cTlR?=
 =?utf-8?B?NjAyeEpBTExHaFk4OEJFeGVCenZhOWpaSFh4aEtKVEwydmJGaE8zaGZsMWsx?=
 =?utf-8?B?S08zZWQ0a1FoemxsVzZ6QnhvM1ovRTYwY0s0ZXZlM3hQNHRoVnBpRWVHdjVo?=
 =?utf-8?B?NUVSczRGS0k3T1lDNFNnMDVOdGprNWdOSHBqQ1kzNkREVUFaLzJobHUxUlZo?=
 =?utf-8?B?LzYwRHEvazVaQXhaeFRhWG10dWJjYmlOYUZZNHZINnNDYXVITFFyMTF2UVlh?=
 =?utf-8?B?UVoydzVoQmxEQ0pCL29BU3pCcnVRcmNyWXZPSlVMNi9VdXJ5bG5CclZiaStw?=
 =?utf-8?B?d2J4ZVFpazBSOW1YVEZrcmJkZUZETDZ3aThTVEd0cWN2NWxZWW0zMW05VGs5?=
 =?utf-8?B?S00vNHl6ZllmRTlEcXRCL1c4djFQZXdyb0RhSFA4dHJXVXdpOXk1OWY1d0Jz?=
 =?utf-8?B?Z1ZLOVJRY0pPeDVTWHc5VHhKRitJeHl4ZC94MXlFaWtRSEFFOFdkZkZCbEY2?=
 =?utf-8?B?aDYzVHBnMUZTYmVmL0FjaWZDdEtZSWpyMXcrZy9uYm0zRkN6ajlWRWlkYStR?=
 =?utf-8?B?WjlwaGpZQ21zSy9iREdQY0V4NXV1ck8vcFZwTXl6RGtZY1VObDNjdFR0QmND?=
 =?utf-8?B?ZVB0TVM3NkhndnFOQWVlYmwxYnNYNGlQYVluc2lBZjNjeDBOTFBzaVNmVVZG?=
 =?utf-8?B?VExVakFGbExHaXBDeS9DTWU5U2JaU1Y5Yk0rSHZ1V2pkR0I5Zm10OUQ2NGlD?=
 =?utf-8?B?ME5oL1NsbUdsTUNVTjQ5OGVIdEtUeXdSVlVZUUI0VEhWRG5EOHdtSW14NGdm?=
 =?utf-8?B?SERmVkpZZDVreVd6Y3NUclo5MGV5VGM5bDlrUm4xVHoxalBHbVlqalNZQ1k3?=
 =?utf-8?B?NXhHTmtoRCthMDBMUjZNb0gwa3BHK3VUN05wUXpFeGUvVytHN21TU0YvbUJI?=
 =?utf-8?B?M0V2WGQyWXRhUG15S3pINUk1NXlGeXpzOFI2QzF0bVNJZmhuZzA2K0Irc2d6?=
 =?utf-8?B?MTRadXAwUTJjQ21sengxbWFLL0Vvdm5mUy8wVUovVHJ0RVBackhRZW9MdGdM?=
 =?utf-8?B?UWIwQTkvV2lqV2dXeTlteXhjNHo4QUZuUmtjQTYyT0NiUElHRy9ENDl5Wjlk?=
 =?utf-8?B?ZWJFTE1IWnB0WmJoSE1vVlJmS1QyMElLM1VQZDVyMElpV0dXSzlJeC8yWGZh?=
 =?utf-8?B?bmwzQXBhVlFTaHFHcWpBYmhXNUZRTnhVSllUa3poaXFhVjhlZWd6VWZONTlo?=
 =?utf-8?B?cDdzbnRtaVdCMWRHbzdRbEZNK1MrbHJjMWxYU2dZSnBzSEpCdlh0RlFGUWVD?=
 =?utf-8?B?N0hhOWg4V280SGNYT29vWUp3Y1FWZldrYzFrUWpKNGluNXZDSTVhMU9TQ0ov?=
 =?utf-8?B?a3pCeUxlNTRqNytFaURrUnBTbnJNQ09sOU50SUFORjNPN2xRZzVXWEptQXBO?=
 =?utf-8?B?NVc1MThmaHFpZlJlc0NZOHQ0ZVZHWEc0OEFvVCs3OXhQYnN5ekpCN3VhVmk4?=
 =?utf-8?B?WjJ3V2VmZ2xjQXR2UnNLaDFMaXhRRnkzRzNKa1BISUxjc1R6Z2VDM0xqWTNL?=
 =?utf-8?B?aW9aVUgwWE9idjN6REdTTm1hcHRFeStpUG5MTlVDVlc0ZlZpcmpuUHNya1Jl?=
 =?utf-8?Q?SyRtcpfGmqD1kHIuvV6f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1hoN1Q3NEVnSnB4TDlJYWFZczBiVXloQXJPWUU5LzNEK2RjOVpEVmdnU2p6?=
 =?utf-8?B?Z0QyMExjQWJTMVNXZmVWb0dPQk04M3pCcE1XaGExeWdSV1lyb0xpMVcvV3pD?=
 =?utf-8?B?bDFLVFpGcmNZZVFlUVByODRIUEZVWmhydFQyaEtsZG13TDlJRXFwTkFkSzZP?=
 =?utf-8?B?THV0MkRSTzdvR2VSZmxzUE0yb1kvcWMwSDhhSzRBcHBxSm5SMTBuNlp6bGVq?=
 =?utf-8?B?UEhhRlVaM2RyUHNndjZJWXAyN2ZYTUdJVGxkK2sweHN6SC96ZEdOWVFFb3Zx?=
 =?utf-8?B?Ymt4UEtqNUprTWpzNkZDZUsvNUlRbHZRZStlaWF4UGNLVVlqVXQ5M0RmMTI5?=
 =?utf-8?B?dHBXMDl3cWlhRXMrNXpxRDg1ajRIUTFkTnJmMW9ZQStrQ1ZLbEJuTjRSdEEy?=
 =?utf-8?B?UVFuZElhaFFKOGtQN3NjWjlzK0EwNjVyWkNpazBkU0hWd2hEY21QbTRBS2p3?=
 =?utf-8?B?UE9aNkhOQ3BQNE10bHFyVXlrV0dtN1ZEeXdzaVNGUFV5bWg4ZDlMRml4dGRs?=
 =?utf-8?B?TjZhRE1UL0ZDYStmY0w2RENvcklJQm5ZUUVpQ29JSXVYaytyaFRXWTkydC9x?=
 =?utf-8?B?MFBsQnZQcVJkczh3MVdoU3o5OHEwU3FiTE9tZ2djdVNVK0VzZVNaWHBmVXQr?=
 =?utf-8?B?eE0zN2dBNjJ0Y2VtRHZzRFEvY2V0NEoyOGlIV1Evd2VNa0tBU3ZoM1pkcGNl?=
 =?utf-8?B?WjloNjlxRFBYNmFGbitKNDhEcUlGT2Z1WlpWVGdPcUx4alliSFVLNTFOOHlH?=
 =?utf-8?B?OThsV0RqUWNZeENUSnhXSThuZVIxN0hObWNOR081VHJMa09DL1Q2UkRKaEtX?=
 =?utf-8?B?NWNTL0JGRHZPZ2dhRmMzL1I2MjlNM2RwVnVCdEFTQjdCNjRSNG5kUnY3VjB4?=
 =?utf-8?B?L0pFeWJvNHJHT2tQTldrMHBVQWFmZnk4QnU3cXoxYzNpV3pFL1B6a3Y0Tyti?=
 =?utf-8?B?L1hmSGw1Y3oxSUVvQUY3NTFZSUozTml3K3phNjJ0eTZ1UmFTdkVIcUZJcU9X?=
 =?utf-8?B?REU5dXBOYVR5U284VmFETWY4V3o4aVNpaDlTMGRud2lTUnhXTlNDd1hwOU8v?=
 =?utf-8?B?ZjBZaGNXZHAvMVFQRkgxRzl2OFc4YnBQaDRWbDNBcXBoMmh5QmlwdDhJTnB4?=
 =?utf-8?B?ODFvUTIvYjc4anoxR2N0bENKQ1FreEZzVStNbExiVkNhbDlFV2paTTdWZkJu?=
 =?utf-8?B?YjZlVlRqUGdlNnlmZ2RsK05xVmtiRnUzVjQ0UkJWVHNXUm5lcHU4cW5uN0tL?=
 =?utf-8?B?aFEzM1V3ZEczbVlMMnoxZFI4TFl2VmFaTW1tT2JPcENOOEdVUTJhcHgwTnZU?=
 =?utf-8?B?VjR6aFFTUXhlNTQwMjhYYzlaaSs1NHNLbVpBUnJwaTl0d09sWTlpWjJOUGJx?=
 =?utf-8?B?UXhPVDdQcTRVelFENHlraDA5bDNqM2d5bGZkcm1aYkVSUDFZZUtGaGc4RkdR?=
 =?utf-8?B?ckIvZWFJTmFFQUEwUDBOMytsaDA3alAzRVFPeG1sY1VuMHhZd2d0ZHhMeXY2?=
 =?utf-8?B?VGxQWkhxT0VxTWt2SVpQR2RMNG5IN0tpUXRneHlPaG1VR3FuSnk3UmsvZFgx?=
 =?utf-8?B?NUVvRGo4eXg1b1lwREJ6V1VPK3V1WkdYT0p3eVM4cnloK0RLTHRhb0Q5My9Z?=
 =?utf-8?B?ekxWcnhDakFpN2FsSGZwSmxoV1BMajY1QlZhYlpVUW44RnRqMGFEekluT3o3?=
 =?utf-8?B?WVAvOUpTRlk2endCQW91VFdFT0hINjRFQUV2NjRldWhIa1FWa244R1FVWVp3?=
 =?utf-8?B?OWNDMFI1UlBFcC84VnBiYWErS0NWYjFrcWJuNzAwRVNzR0p3VnQrMnpLSXdv?=
 =?utf-8?B?R2t1SFpkeStNMjRsRXl2aDc4aVlORkJ5UForeWxZOEJiczBVaEVQOStJRnVp?=
 =?utf-8?B?RTYvSXA5WW9oajhtclo5ck5ZakRQNkdWNDhIQ1Z5ZEVWK2VZN1lYQmQ0MkY0?=
 =?utf-8?B?TnFSeThzZDhmT3V3WG9UeGo3UktwTXF3V2haSmZCWlNjSjZYaS95UU5wSjl3?=
 =?utf-8?B?bGx6QmZ2ZVJVUU0wSGFybmVXRFZhRzFpaENGdDRqN1RBcDhqNHQ4bnhwU2RH?=
 =?utf-8?B?Y3dzY2hqYW5JTkRPaXNuRzdmVE9ob1JjbEtGUXJvVFZ1NWxYYy91LzJsSTVs?=
 =?utf-8?Q?G58Ghj4dfUSXu7Mzmxm7Z3z6X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65813613-d495-47cd-0299-08dc945998cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 14:26:11.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dm0dndDoqtj4KXGUmEOmY64In54F52moXXEk/lskRzBRwc4JpYHEWXXJ5vPk79yHyl91JE9j1XM9nrB7eQwz5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471

Jason,


On 6/20/2024 7:38 PM, Jason Gunthorpe wrote:
> On Thu, Jun 20, 2024 at 04:19:46PM +0530, Vasant Hegde wrote:
>>>>>> seems that for all domain attaches above is coded in a wrong order
>>>>>> as ats is enabled after the cache tag is assigned.
>>>>> Yes, exactly. But simply changing the order isn't future-proof,
>>>>> considering ATS control will eventually be moved out of iommu drivers.
>>>> [Unrelated to this patch]
>>>>
>>>> You mean ATS setup will be moved to individual device driver? Is there any
>>>> reason for that?
>>>
>>> Not exactly to individual device drivers, but it should be out of the
>>> iommu drivers.
>>>
>>> https://lore.kernel.org/linux-iommu/BL1PR12MB51441FC4303BD0442EDB7A9CF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com/
>>
>> Got it. Thanks.
>>
>> I remember of this discussion. May be we can provide API from IOMMU driver so
>> that individual driver can enable/disable ATS (like iommu_dev_enable_feature()).
> 
> But I have a feeling if we do that it should be done by re-attaching
> the domain.

Right. By default IOMMU will enable the ATS.. But if device driver decides to
disable it (say due to HW bug), then we have to re-attach domain (in AMD case we
have to update the DTE and flush the TLB).


> 
> For instance if you look at how I structued SMMUv3, the ATSness is an
> effective property of the domain type and ATS switches on and off
> dynamically already.

In AMD case its per device property. We check both IOMMU capability and device
property before enabling ATS.

> 
> Having an additional input to domain attach "inhibit ats", as a flag
> would be all the support the driver would need to provide for the core
> code to manage this with some kind of global policy.

You mean for attach_dev() ?

.. and what about PRI and PASID? Don't device driver needs similar interface ?


-Vasant
