Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE812C491
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796285; cv=fail; b=ttpNavLicamS82b24gHymKUb7v3JHoRnKsNo//xtPRRyDgXXOaRza8hQghWzEzWNbrBFphY1SSLQPasV+4yhxoWTuVvSWSQ3hvj6yla4ZWrs7z3YPS7xsxr7WNAAHNKq4JIF4nmZgcTGarvHXrFTL9CVIORshoJ+MhtrxRpTW+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796285; c=relaxed/simple;
	bh=ZTCXfVDwHVFhk8pNkmdX/uEill4UUBUqeCSa8VR76Gw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mZ9gGxeCAT0eot6+GLFL049HjFYxqWnw/eUPnsvvCF8oAQrsSsPjGGwLf2iTECo7LPQLkPrO56M0GvLDy3obkEjDLvWzQlWM+jMqSLKZ5JRwivR4z5Y1gg0TNn3O9qXVhkBdE4lLpktfo5UQ2KpuZce3LVMUjlzZFGnpbqDHK3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bu1s5BJA; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bu1s5BJA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XiyucrOrKy0OrehAJa69rzfwkSi4P2zB6J5RQgh4c1Y8PVnk/XLeKbfsInHVWhVoVo2/8MRchzSm2YO+KmfdicK0uOe7atqQyJkZ+lZ8WvFgNxCXmu2MfiHMRRXy8KTlPHYd+S5QUZnKV9Naw00zjD0IpY13fvS0b1wSQYHUNMeYATaradgIdJudROE7+NWqB4vNb/LKXms6MXqLfDtS68pZnQXZM83G5neobxPJKvhI7hgQO3XDUcMp+7VAVV9M+0MD2/I1BQXy5I0+xw92eISCSWGVCpQwKPmDk/w/MkT5fH3W8IJggDmpx+tdbNo0OoR2YBXR7ngVRUnPj2b7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvzwEvt2wfGu0j6T4Ka9i5hpHplfIr8kOidg/Tr7+hg=;
 b=moK6uC56VsGPWw/XD72vQKk0vxjvU9StZ3AiwYBO1kSli3Q0H4jTAgz5HhZYSjRo+Q65FXogqy2hWM6J5bQg03DDlPENfzWSdAH0pdWlHcOMVQ2VVkyyFk+YXx8CxI4a17LNaAVPuQxGLCF4icGL2MUoU/607gHqLN3GPjT9ykT/E27NgvocUrjZDIZ6NwgYZmh2yQH72kCjDp0BF0eUC+upZQt+EU/iGp/CxBVfpkDseWH+RVyAMow6vyk0cnVxjCauXiU2aB4zfMSRFlnhkPzEPlpj107q/pz2OJOM3plZjNyCfOXE+hVbv9tcDpCwAnEqIfurhdoQyHoLuOH35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvzwEvt2wfGu0j6T4Ka9i5hpHplfIr8kOidg/Tr7+hg=;
 b=bu1s5BJAGAcBuUN/aUQ7ZxXFBGsLV/923Pi2HTWWcKD2aY5s+kojtaTqmI1Gwl93J/3MA/I4Ldkx1JCAi8BNCgWatHYfKaS3oDYXWv7I8xRQevBpZAgPYO5IoAwgYrVNle9WdBVJ6KA3JpMY1/7kzfHzkXiRfWvnJK7scAeG/HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7925.namprd12.prod.outlook.com (2603:10b6:8:14b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.19; Fri, 16 Aug 2024 08:18:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 08:18:00 +0000
Message-ID: <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
Date: Fri, 16 Aug 2024 13:47:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
 <20240815134737.GK3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240815134737.GK3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0222.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c71233-9c4e-46a4-0649-08dcbdcbf147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1h6RHZGdEFGV25UNlNlMkMvMmgvbmV3OGdvN3Z0YXcxR2U5amU0OWwveURP?=
 =?utf-8?B?cWorTTFoSk1wRUQ0NllIZ0dQejFyZDFFa0FQOC8xNXp1akwrQUJYd25rVEpx?=
 =?utf-8?B?emZZK2hQWlY1Ylh5SmZJemVlMlptUmpXR1ZNK05qRS9IQmkyQ240K2dLeURT?=
 =?utf-8?B?c3NrSk0xWkM4cjQ4Rit2Mm5DVVBTTFpqLzB0QmM3a1VEUlAyb3VETDF3YjMw?=
 =?utf-8?B?QUcrZzBvNmJrOVZBVDh3UlJPSlQ0Um9pYUpPTTBsR1hUakhaNFJvNXMrUlgz?=
 =?utf-8?B?WEtyUDhsMUprejVrYmh3dXd2K21YM3ByTEU1Zm1PSnEzTXZGZ2h2dklEQnpR?=
 =?utf-8?B?bDhuVjdNNUFOa3U4TDlmV1VYY3hCWmlSQ0JwbVN1dkZRdlBoSXRXYnFYTi95?=
 =?utf-8?B?QlBlWCsvMGZrTXlEZlBCQnJuS3Y0S1AxMEFNSkdud2ErZlV2LzBRckkyYVlN?=
 =?utf-8?B?VWNFWGVoNDZlV1g1WGlEbHBZNDQyQVRZS1k5dEpFQ1ljMkdLM3VOMGU1N2tO?=
 =?utf-8?B?eUU5ZkVQSW9oRmhVeHdqRkd0V0tLcVhZWm9oOEtwL1dqOWtxWnpTZ2tvNU5L?=
 =?utf-8?B?REVHeXpiNmZNeER3TjhlTG5nRDFzRTlURWk4K3RLK21aTFZnYndlVlpQV1o2?=
 =?utf-8?B?aXR1cklNckVHTVRidWJ5blFyQ3VKTnJNM1c1eVFTbnRlZWZPeURScTJJdnNt?=
 =?utf-8?B?c0JuSXZTS2JJR2F1cDhuNm4zbFRrTGRLVWQva0NMRGJFYUYyYXBjcXNjR0Vh?=
 =?utf-8?B?UG9KMjlnWHRaaFgzU21jSGhDNnYxVk5QU2ZOVzF3TG5NcVFvU3NiZzlFd1VJ?=
 =?utf-8?B?R2lNS0tRMmdZbkc0VlBUdGthdXk3Y0trYTJqSTI5ZGhzaTZ6L2VXQXcveFM1?=
 =?utf-8?B?L1IrVWM4QjYwd0N3dEcwQlorZkZ3ejRWRUd6SU1WZGg4QjY5dHFsMmh3UFdN?=
 =?utf-8?B?OHhZZGFJVk10YlcwZ3B4eFFQd0NyQVZGSXRXYUtCL0FzRVkrOUJ2S1FPMjlj?=
 =?utf-8?B?bkhhMTJoM3RGQ0F4TzhOcHU4NWxTMmw2RjVYTExoUG5WL2JyUDNlcEZXVzRM?=
 =?utf-8?B?RWswazROdHVkcnNudGkzN0Z6enY5M3VETDcyK2d0cmJJYWg1Mk85VUx3Q1Ny?=
 =?utf-8?B?Y3hSMHJmR0cwK2VmeW1GcVhTZC8yTWhKeGZvNS94QXBPLzRYK1dORURtVjds?=
 =?utf-8?B?SEdBdi9VSURtenZ0eFViK05neXJqVGJlc2FHSjI1aXJOa285Y2xjdEVwWE9s?=
 =?utf-8?B?VldxbElMWTliSEpJQ3grL3VzNkloNDZ6ME1UcjRaTW9rcVIwQ09VdjVRUk5F?=
 =?utf-8?B?SmQ5dHZQeUh2amYwTWVqNTVWVDg2Z2Z1K2w5KzFvM2ptUXplTzBtS0ozV2JV?=
 =?utf-8?B?N1ZlZlZWOGFXU1l3SzBoS1NjZnl4eTFVblVjS3dHS3BJaEtuN01KYzJsQnU5?=
 =?utf-8?B?US9OVjdqdWtKdWJHYy8zV3BxWjU2cENHR0RxbjVwb2xIL0c1eDhUVkRsS3hI?=
 =?utf-8?B?eFcyVXhmWWxlcjVkeFcvVUVucmREc0pJazNOa0RPdDllQU0rc3hqcGFhUEhP?=
 =?utf-8?B?YVliTGNITE15WmxsTTNGL3lhU2pQaWFjUGMyMXdGazVRRmpJdUt0QnJEbld2?=
 =?utf-8?B?d1BMVVYvUzV3RDNWTStuclhEOHNWY1dqZ0VaMnBhZmgzaUxvVllGVElLenQ0?=
 =?utf-8?B?emVEOWR1R1IydmwvazdUZERJcU1RajlRbVRwMWd2RWVlSmpja1N2V2ZpMG9Z?=
 =?utf-8?B?ZkJWMDlTTHpHL05aU0FjWDJ2dmpXVDZUR3RNbno0MjgxL1JPUHV5aERaOUcx?=
 =?utf-8?B?TzRpQzFDb2JUNlVsNExrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnkrSUtUQ0V3S0Z6bE5ZUDdXcnQwaXlRVjMwWU1UWUNoSGhKQTZzUm11UDYw?=
 =?utf-8?B?SFBxNy9HWmNINUNYRzJmTzhMendSOE1KN3BtbzZiQTJacGJ6enZ2YlFKZUJx?=
 =?utf-8?B?Z2o4L1dCV3BYTzRybGZrWURHU2NoYlU2ekVDOHI1V3RyREtFdGZwN2V4akwv?=
 =?utf-8?B?TWlsVGFYSUc1U1hVUEVLbC9jZ3B3L0pLUlZURmp1WVg1YVcreDZ2N0dncVZ1?=
 =?utf-8?B?M2VtUnpJWUFwYjkxNGxmUFp6MXhqemJPNzFuRUR1dWowOGhKMHVQOVdXVGRZ?=
 =?utf-8?B?NTh3K1dUUjRqRkFNKzJKcjZDU2tVSUFDOEdYTEl2M3lRUzF2Q2tpNXI2Lzd2?=
 =?utf-8?B?ck5nRGQyWEdyR0w5MlZ3cjRaWU8xQUZCdGgzTzVwN29RYnBHazVXTGJlNVVU?=
 =?utf-8?B?NjVwcGhUd0lKYWVzRGRacy9uWlc0WGUxRFZFQk1rVERuM1AvbHFVUHNiWEcy?=
 =?utf-8?B?SDgzdjVSbXh3WGFKdmIyeWdoWUNaTXlEUksvTGlwNFRkeEk3UE9FOGhwMVdL?=
 =?utf-8?B?TC81UlM2aXJ3dG9FS0V4WnB4M2lmMkxYZlZZdCtud3NicDgxNE1zOXhxWEUr?=
 =?utf-8?B?Tit2dlgzT0VKVldzdlRwZkxiL09nNE9aU1dKNEZWY1ZKa201dkdKOXlXajIw?=
 =?utf-8?B?R3ZtbGVDNlNzY1h6WHVvbTIxcXcvcmwyUUVtSFZUQy8vOTBiM3dRbVFWT1Uz?=
 =?utf-8?B?Q2EraDFOV1VLZzFTWG9mVTNVdDhHRVB1b0VZOW5VaEFMamF3UVkzcWFmOGVR?=
 =?utf-8?B?ZnNPcm1ORHlveFh0dUxEL0xhVEZXM3AwQjdRbDR5d0daMHI3V2lhUTlyTUw1?=
 =?utf-8?B?dkhnKzFnU1JGQUVEYVc3YmFucGxmdmp4MXc1MFZvZnMvWkszZ3lkZm5EdG9J?=
 =?utf-8?B?K3lIQ1Qza041VHBhUHJydXN0MWtObFNxRFh3bUtOeGN0eXB0WFc0NFVOMmY3?=
 =?utf-8?B?NWh3YWlUNmZFdlJCbWxMN25BejRxeWc2UTRUUkFxbXQrWVdmSTBtTE91dHNM?=
 =?utf-8?B?T0lrTE1LQ3RHbWdOTWVMM3hxYml0Z1dNRUZjSVdvaTlYZDNYYVc1WTNONkx2?=
 =?utf-8?B?dEE0R296ZzU3UzJHRVorM01HNS9tN2VUNmxWbEk1anVvM0JDcVhuWXM0R2ZN?=
 =?utf-8?B?ZTBXdGQ1aFAwYWxlcUpWY2MzOFAvdkRnM1RxKytNTlV4eEh2d1ZCVnpSRVQ2?=
 =?utf-8?B?RDlGVlZhTzlEeThNUjJVWS8rRUNVaDdWYlNUN1NxcnlMV2V0M2JPVFA3Q0ZL?=
 =?utf-8?B?RVJ4RlBTUTdhOEpna3pZR25ETjBxcmNpNjBhR3FvdTg4dEplWEdRTllUUENp?=
 =?utf-8?B?ZUk1S1o3bnZweEdKaTBCNE5xK3RUR1puMFlUM2ZmS2c5czBESWxVUncrem9H?=
 =?utf-8?B?b28rYjRzZVFFc0NrZTFHMHdKeE42RldTUFNMQk1BVmxyVWJmaHVZamZyNGJB?=
 =?utf-8?B?aDFVS1c5VWZXTXo1NU1WNmpRRWhhVmJKNW4vNHAvOWdqd1ZIbmFNOTl4ZGt2?=
 =?utf-8?B?UVlkbWVoQmFvL3JYSGx0Q21uOWphbU5ZVXFXNUlRN2JHS0JPY095YnJCMnUw?=
 =?utf-8?B?OGI2MDRoNlovMkZuMUFQK0M1anIrQnd1V25VcTZINUFqT0w2MFZZbWxZNTZH?=
 =?utf-8?B?cWNGa0VXUHNReDlDWE1rbzNQRDU5a0R5K0pDRFI3VThjYVlRQnZ4K09UbXBn?=
 =?utf-8?B?R25ISFZNdm1uU3FIcFdRR0tJYTFaMllOTkRYcGRubVdWcThTT2J6TFFhMTk3?=
 =?utf-8?B?VEY4TTlEcFlEYVZjTUNQeG1oQTZyN3ozUVFXRjdVRE0xZ0w0NnBGbUc0dSt1?=
 =?utf-8?B?UDRCZUtkc3ZxcmluL0lrQkZMd3VtK0JvRXVCZ2hwbTVHN21acHhwaU1GbUUv?=
 =?utf-8?B?SjhXYmhLUWtzS1gwYkd4YUhWTTdCcVRYRVlFRGV5djJZNnoyd3hOUjBndU1q?=
 =?utf-8?B?ZE4weG1UTUtoNk9qdExkNVZzb1MzVE1qbXVxNkE1Um9INld4TEZvdGYvbDRV?=
 =?utf-8?B?dEdCN0F0c2tWeVppYUttT1l5REJQNDhkYzRHVThqdzFqMDc5V0ZMRUNGYWFR?=
 =?utf-8?B?bXpxYW5JeEhjdisrSis5Tk80aUJjaDUwa1NzSlErRncyWDlwVFl5Y1FmM0s2?=
 =?utf-8?Q?M8l9e279sp/4CYwRr+ZCtAGoP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c71233-9c4e-46a4-0649-08dcbdcbf147
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 08:18:00.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: up78jzBMlo9TjzI+uyiaUPkpLxf1PbJc6ISz0lGGTlaN4CyZZC2XbvuxnkwzI73zXxJlM0XHHi7tsD7eJJokqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7925

Jason,


On 8/15/2024 7:17 PM, Jason Gunthorpe wrote:
> On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
>> I suppose that this also includes converting paging domain to user
>> domain allocation in VFIO (ideally vhost-vdpa as well), right?
> 
> Another thought is to add a flag to iommu_paging_domain_alloc()..
> 
> Maybe like the below. The small duplication with
> __iommu_domain_alloc() would go away when iommu_domain_alloc() finally
> goes, then we'd be able to directly call iommu_paging_domain_alloc().

This will work. But we have to define NO_PASID flag and pass it from vfio.

IOMMU_HWPT_ALLOC_NO_PASID
IOMMU_HWPT_ALLOC_PASID

is that fine?

-Vasant
