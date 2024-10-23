Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D62148FF3
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673327; cv=fail; b=X5HVw+xZ47/lUadd5R9/v0ntrdcL7DuAlEg1tzAjTNSmV3hxAscvAyMoJW0qRWer/VHADxTugYAYKUnFSmuMiJ7bjPG9EKQ6PTLUmyfaB3BrKqlickits9N/bvcYPF4wcZkxRMgU8jktHGzAICSc1ZxrWThNUJ0x2crTKh2MSiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673327; c=relaxed/simple;
	bh=w7jMjGPr0vuI0KnfbVyqYHUSD6TZAqQxkMvFMUNvhL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YiUYjyoTcYLuw1a+eqcd7DBQ4WFMF0AzgPL99jWGLFHZQl5ynC8X95ZpoEX6gQoiA7AIoQaU8/RFAxe4Kla+sK257CKzj3PeFbcJv/S/9jGnTq1UeRlpxskkjXqUMQ9IzSY/Ky+qk+7Jo+6yCdJ+pMETuFf92SYBas79lb6Nzlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ffpUn5r5; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ffpUn5r5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2BX0kLrOkA3CKyXXdli9kZhj2ajMi2oZ/vF/vL5Kn5HDSOFdR/R9b4nlXzSsGaaQPnnytGLsl/AIDh+LkzGZfbcLqaW5G/aA3iRAPyODSx+7MbDCGZtABKKkSvQ5TNDhcA478ShtNu4OKRRHJEeyWclAEJHyd/M/QzeaJcrCtVmo/vxDFzZObrK4MArz/CBrtzZM2/mEMMf3ZSgw2NECQ9zoi4DWKu1pLLu8p+R4ZWBAN65Rn2EHkTXzwm7LDZRcyW1UbEVkNP9w8fPPqK1Toy0UzAWgAuclq9B/Jp9Ib8ffyFB2Cv3atG+aQLNdF9QJzeqA82jWMuqOGJ/7j5Q0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYDwZtUCYwobdu7sJM+Rre3BW5vNOBZrmPuA1T5Zqo0=;
 b=GffHhDjKmtIApgSf+/4qWzemYMTpHi5U0/HPpNTZmNEorT0iADU8w310jBU7jjsgApzYkxLRNMjxh0MnN/ErI6bvpQtu3ZxsK7oiAjOBe8/e5+dyTTLXUgL/5s2e5yVDXnAyCz6gyW4Hr3PiKUbshW1PBLbVolkRL65LVqgbQ9Uzp4oImFdytdAmADcOcfHg/zmqbkqg/7wuE42hB5+Xf8pdbyVBCzTMODedqXNtSP1f/qhynhVci0Y5l41aoxT/yveuSajmBNnBdlKSYpYweNt0OuS7+zZd3AWwD99CXQMlMBaIej9VEg0GgcbjC/uSgaDuUZI24vXuDIVvR6YkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYDwZtUCYwobdu7sJM+Rre3BW5vNOBZrmPuA1T5Zqo0=;
 b=ffpUn5r52b2gfiPrr5Ghun5bz0fUQLRHpC/GtL51CyXmy+ZJbxEgTz0A5YMiMeRnHsjohvIR+JS51JYbpfATUZO05rv6b98RC72hddqpOq7dREHa2sqqVZUDEh6aEWExxs9OnRzB+KMO1ZWK0wBL9R2Xs9uKM+xX9O/b35HxS5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 08:48:43 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 08:48:43 +0000
Message-ID: <ede12a39-bdcb-44b0-978b-e9b956f5b035@amd.com>
Date: Wed, 23 Oct 2024 14:18:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/12] iommu: Domain allocation enhancements
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241018125005.GF948948@ziepe.ca>
 <47b5397e-d706-4c72-b849-a91f6ef1f569@amd.com>
 <BN9PR11MB5276C874735B30D48475C3B88C4C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276C874735B30D48475C3B88C4C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1611123e-feaa-45e7-61a9-08dcf33f7fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXJHOThrVWU3OVljU243aXovV0o4bkU4SW1PMHEyUGQ2c3VMaW5rT3BmWnBM?=
 =?utf-8?B?d2ZlUk9xRlo2NFFyaW9OUFFYQWFtS2JqT2l2elVHaGkzbDFMbmg4QVl4bTdx?=
 =?utf-8?B?eThqVndxVFZ0eXIvVUt1OVdqZkZZSG56N1ZZd2JQK0VsdVpKRVQwd3pqbllu?=
 =?utf-8?B?UklJWmFCWXZsSzJKM00yMnJWMitpT28vbU5sQm5QdDBuN3dMZlR3Szl5aGZk?=
 =?utf-8?B?ZWtoVktTMFZPUXJDSVI1akQwazdlaEY0VmRHY3VXODY2TjIwT2p2Njc2Qm1p?=
 =?utf-8?B?aEo2eUFBRmdJd29hS2gyZUF4TWdXMWx1bWwyMzB6SDk2WDZ4TW5OZVdrdjJn?=
 =?utf-8?B?TVFia1A1WjMvUjh2cWtPbzRIa0N0bEhSRGQ4cFZSM05uVnZsMFMwSHlJbVNC?=
 =?utf-8?B?ekFwaXRwSGN1T3BET1FOVkt4LzZnM3BhenJOTk9OVTd6b2lIRTNjYlBiL3ND?=
 =?utf-8?B?K0hSSHBYMFpZRWYrV29kRmpDRzFxbHNlSTBndlRqMUM5VVNyK0pqYkF0SUVB?=
 =?utf-8?B?bnQzeDdoUHFkSGJpVDVySmg1c3E2b3RBQVpZTW1qYUxJZk9tMnBUc1lNc2Er?=
 =?utf-8?B?UzBOWlJ6b3B6K2ZlVFBoazFBT0VXNExPVWlDcHVYZGh4SDYvTHp4U3MvcHZ1?=
 =?utf-8?B?dVBxSkE2WDZGdXAyQk16dmJPWHU3bXJlWFUycGtnd1RDdjJJU2ZGQlBIR3B2?=
 =?utf-8?B?RzFRak1NaUlma1laTkdqVmcrQVFOM1BFR3pXT1k3cFkzVVFOU29XRGpCQjhv?=
 =?utf-8?B?b1RIL0NLM3VGbUtDVlBkR2lNT3Q2OGVYNEZ3L0s4S1pYczZ6b0FyNWRra2F6?=
 =?utf-8?B?NDYybHNKQnpHVWFhamt5aEpIUmZjYlhCK3BBdk0rR3o4RTRPQjFiRUh4MjRK?=
 =?utf-8?B?eUZpVWVEZitNTkk1aWRna3JHQUQ1RlFEdVdDMTFBdWNjT1hNSDVwby9MY000?=
 =?utf-8?B?RklqNUZUQmxKZGlqbE1YV0VqSEVpQWh4Vi8yVkhtR21HZEphV0JWVi9CdWFk?=
 =?utf-8?B?eEFRVEJmVmhhczltREhGYkVJOFdkR3F4MDd3U3VoRm93U3NqOFJRaHVySU54?=
 =?utf-8?B?cis1K2d2SVFzRVA5NEkzczVDK0hCU1JQMjJISkNwdHNCM2xCQkkzamN3ZHZU?=
 =?utf-8?B?T1V6NldJNk1xMnhqY0NmQkp2NDdDOVdIVWUyYXRub0QxMXJKcC9ucVd2UUZ3?=
 =?utf-8?B?T2hzS1c0QlF6Q0IvZGlhYktXS2lvNkNwOTg0ZkIxbmNrZXp0RXNkNjkzQmQ4?=
 =?utf-8?B?SHg0VHFRcjJLdVpHeEx4VDJsaWsvTXlYcnM4M1dISmVtTVduSlZBZTB3S0RK?=
 =?utf-8?B?elVvVnRwSTZhMzNTTThZZmhQQ0FMQmQ1ZGNaZDZlRURWTkhLYmEwOWtCL2M3?=
 =?utf-8?B?alZud2xESTArQ1JXSlJYOE9qdHRleFFORFozd2JweExVWVRuK28xZ3Bocm5D?=
 =?utf-8?B?NDJMcWpQL25xdEJxVDJWc3hQQ0k5dXNPQUU3bmJqc2w2azVYemFVajYwRmRp?=
 =?utf-8?B?ZWQyaEJwWmhNYkl1OW1rbFhOOU1YQlZodURYSDJKcnRwbFBsa0xYMURMcGxN?=
 =?utf-8?B?dnhOT3NHNWd2TWNLUW11Mm9ZSi9PK1IzUGVsNStyaUtYeGFhWFNQT0d0UCtD?=
 =?utf-8?B?Q2RJQUtFWmpLUFM3cFlERWZ1NWxOY0xOdlB0QmZUTDdoK2pJVlVqNjRWZ3l0?=
 =?utf-8?B?dmhZVTVPaVFWWEFCemREbXNtaklOc2xadFZtdXZMcFdCSHNEZFUwaHBiTjY3?=
 =?utf-8?Q?O2MyXajavzeSuhsnjG1UJ9X/RMZMRQypziC4qgg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1JKeE01eW0zeFpELzBFNTFLajBkcEhSWEZvWGYySGVnbGJHbHQ5RG9zSy9D?=
 =?utf-8?B?SHVZVzc3ZU5UQXpRRGV6dE8wSDB6dzV1Z3ZxT1hWVEJ0THRhL09xQVdhRlRS?=
 =?utf-8?B?Z2VWRVJJOXNmMGdGdGd4NnlLcDBiTm9KcVIwVjlxN2ZTL0FiaDh3KzRYQ21q?=
 =?utf-8?B?N21Xbk14YWUyNERrYVROTW01SG41MG9HS3J1dlA0MWJoRVliSXFQdytRZUlQ?=
 =?utf-8?B?TDFyQ0ZxWUQ0b05lQzZ3d2d1UlVLTmxuMW9KSVA3Z2F3RXprUlZsaklqVkFL?=
 =?utf-8?B?cCtHWXA2Qnd2MnZhWWJkQktjQTJoWmNxTDhGV2w2dUhtOVVWNWlkbktnb0Jr?=
 =?utf-8?B?SnFqc2J2N1FUemZ4NG5LcmN1cmhXeEUrWUZLTGszdGFDUUptRnFMTVhDeEZl?=
 =?utf-8?B?cFZLTyt6RU5Jd3BuWGtDNDVVN3JhbStMdEk4RnRXb2VyT3B4c2lVU2xMUjVV?=
 =?utf-8?B?RGtCU3RpVmQyUjZWTXlEbE1uZnVZbGt0dmUzQUdBQzdyazF4L0xpclFOQjBv?=
 =?utf-8?B?STYzdjRTWGx4WFZrSml5VVp3aVpKejNCT2MySVRUNEdBcDIreS9EMXlSMzNG?=
 =?utf-8?B?L1hkU3ZVNDFSNVQyQ1MwdWt5K1BvSEJJQmFzZXhBMmpZK3RIZzRrU0hyWUZh?=
 =?utf-8?B?UitpakdCYnI0YzdnYUtRcUx6OVk1czVJa1R3UEo0NDd6WGl0Rmh4bmdRcW1P?=
 =?utf-8?B?QW9xWHlRZUQ1UnpocHI3bnBZZ25nUXoyR2pCOUZwa2NjMk1rL1I0c3RBMm9M?=
 =?utf-8?B?bko5MUI4L0xvY29hZ0FPWnZSWEZJQzk5RVZvaHF2N2pXZEVhSHNEM2hocEUz?=
 =?utf-8?B?MWMzQy9OVVlyZDAwYUIwWU9TNUROc0ZwNS9GL0o5QXlsNTVON1VxQ0F0dDF6?=
 =?utf-8?B?K1krZTBpdnZFZUpjRW1YakRDbDZiRXk0RUpMSmw4REl0a0QxaVRVdmZCZ2NS?=
 =?utf-8?B?eWNNN1JPcUdDZExMMDJOT0Y0aVQ4VmRyZFJCSEgwdXhFWnVNT3lrQ3RWd3Rh?=
 =?utf-8?B?TnpyTmRzMDBmS0FqbDBBSE1ubFlFdVpzQlRUcE02VWdKNUNKYXhNWG53aGFC?=
 =?utf-8?B?cE4xckNDMlpvSVpPV3ZLZ2dVVFZuZzZ6YjZ5RFMraDNtRTd0RXNsYS9XbWxJ?=
 =?utf-8?B?QlYzZnUyWUJZMjdCZmRNQVYzSUZNZFlxL3hBNURLQVpUQVpYbzIxZmVCSGFU?=
 =?utf-8?B?NStyTmxoMS9PRUR3Ykp0UHNEL0RiS1JyaXk5L0h2UUl3eTlITWRydG1ZQzJE?=
 =?utf-8?B?UXowd29vZWdvVmN5S3N2akpmRzh4elp3Z0lpN2FoNjA0U0VkbWxBZ3cwYkdo?=
 =?utf-8?B?Z3p0WStRekdGc0xTNlhCSUV3RVZDR005T1ljRmlvUStMKzhMbTVKby9qeHNM?=
 =?utf-8?B?bTB6b0xsRVVVZW5iTHB3SnptV3dDbURIZ29Yd1hZeEFPeFlpQW1XbnJYdkhM?=
 =?utf-8?B?OGVrZ2lnL21PY0Q4R1g2anZzRUpIeTNucVVBY1JYOWhDdy9FQXh2TjFvV09J?=
 =?utf-8?B?R242SzNFai9oNEJCTjNabFNYYTJlSjY0dE83dlF3QVV0cG5Tci9KVTgvbG94?=
 =?utf-8?B?a205NmgyK0ljNnVZUWgxdXhrLy9VUURhZTFpeHhIVVZhQlkrMXZYNVh4eS9M?=
 =?utf-8?B?RU5uQU80UnhFaFVUd3AvVzZBNmdHVXFEaGFJK2hITGNhcDFoZ2lJcUlRbzRC?=
 =?utf-8?B?a1NXYzgzZ25iUlpSck41MHZQS2Z4SmNmcWtpWEhVYWp4ZnR3TlJyWHNpQ2dD?=
 =?utf-8?B?MExndnVVRHlia3lMZDVZT1J3Unp5SmRaQUI5amhyRVE2azV6SytwMXZabnZs?=
 =?utf-8?B?aDRrSGUyaW1SbzM1dGF6RVAxY2xxVjlqSXRsbEprUXdmMmxwVHRjMUoxZmVn?=
 =?utf-8?B?clBhTDJxS3ArNXhzSHo2bk5DV2Z3RVZXdkljbkEyNkZ6VjBhR0YxWUJNUEI2?=
 =?utf-8?B?eFlXSXBuUSt1M0JESEJzZStDbG1VNHN0Q0JWOThCQWFDYmFOelAzOVZyZ0Vl?=
 =?utf-8?B?R2lXYWhlSWpGMlYzbUtMc1JRR1llWmxsVTFqZFBMK3NsbUZVWkcvVVg3ajRt?=
 =?utf-8?B?ZmlqVjYycHJpb3p1alVlZnN2MFAwcUF2LzRCOGFXbFBmREMzZ0FOa3JnbFA0?=
 =?utf-8?Q?YoIN3b9DiDSDpBO/Vx87oM2NX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1611123e-feaa-45e7-61a9-08dcf33f7fb7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:48:43.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sC50B7Myp/6lKpXFcZu96sOCXETimp9Oyw6cf3t95uSECQWBTCfYl8zyZ9eBpJ3YcDMCTm9BHfMn7malYxNLrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295

Kevin,


On 10/22/2024 1:20 PM, Tian, Kevin wrote:
>> From: Vasant Hegde <vasant.hegde@amd.com>
>> Sent: Monday, October 21, 2024 5:09 PM
>>


.../...


>>>
>>> I think you should fail in the driver with EOPNOTSUPP and then the
>>> core code allocating a DMA domain should detect EOPNOTSUPP and try
>>> again with a 0 flags. Is that what you mean by first option?
>>
>> Yep! this is what I meant. Let me fix the code.
>>
> 
> I'm generally OK with this version. With above and others' comments
> fixed the next version should be good to go.

Thanks! I will address review comment and post v4 soon.

-Vasant

