Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0713A276
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049535; cv=fail; b=itBHnnVJj/clbhdkd/rOr7Dsnv/adxJmptV2pGKBPBVLeQKvX0mzDPsHuNDa9VqqK6p2I/o/ZoyvjiiuV2Ak7uiZ06QQ2XzB65epAzMJP+MujtilgEYUNWbr/4b83xW9HPh6EFvb+dPukUpPMvd3XL2XhbgIH3WTVjUB+eInHX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049535; c=relaxed/simple;
	bh=All1+rrMZESQEsrQ1ICMLLgc/dmClgHngllmc6OwcSU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ+JRcyEOccnMIFD1/RQLVziayO0OEAuievrs87ebbfKadspZWbBL9aDW5zr9/OavOBbfS8+nXBYFogK3NC7HSvvbnyiFe4R9oG3f/ihkxwl3IrWe6lWmunaPTIff2nE1cwbbvi7R/h7XnFK7B6ia5PBXPX+UvCVABcCPqTMh9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xkVATJHp; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xkVATJHp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF2eB503Ho+8SNCV20WooRmBgEqAdSV92X0To1O7XQQLAlJH4FvJDnFBuumoXv3YX8iuXXZTfChZcFLxKig01UcKWXfv7Jlo1+Xiyvoy1d6MzG+AOroapRC8PESibSHLQgGT8o2R5RdH8p8sr/KuFwcXjrKLnBMr3D8paQ6wRRQA/egvDWTA9z1l5chMrBg787CJOcrJ+iI365jKLGKut4mvlNoXV/JG3sCoIn0NXYNj9DvsJtRgSIfQYB8D03MuCPtZjmsG/rIj6QNyMj8WNIO2PaMrcfuPE8FeLtgpZNFtWMKlken8nL+ndFJ4Nh2KY8cjSFf3h++m7ShstRCmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MywLclNzHud90SKysex2lgtXuqqlVsQ3kgyOY/2rHAQ=;
 b=BVKc7g4RPL3Ljysb+KfncoGl5n7OUuIM6SIxD8NH/Cu4MNyDJ8Uo0BlVzPR3VVfHR1K6NMM6IKYSQEGrHZJJ3W0Psz4uNLCghruzjbllZpkdD7RaoNcbLXWai0I9MEV/uDKBBPV/PfYqloRg3F22iQWfqn0T1GsEaVx0NajhsvQuXAZIWKcw9ttFfcqUct6rR/qT5UxU/ta3dGD8m1I6uZ+xXo5Gr/urShJ0ex/cRVHltPVAMWSll2kuJoBAU7KyqCvBg/TWZt7R70B3z0J0T1v/GrLtZ9osm1MoAitfcCvw1kr36Wts1ddfZgrWJx54pOeZpKw2MWN3hwqqeqcLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MywLclNzHud90SKysex2lgtXuqqlVsQ3kgyOY/2rHAQ=;
 b=xkVATJHpkmhZZmbX/98rOgf5qbeX2RreMbS4nqouovT89njGksq7R71nr5tnGmOdliTtZsG8Ejb/HP4/HN1ceeg/Ttnednes+goQYLttwqvwrn+iSkKfVh7pntrhTHzBV/DHPEh+RNw+367ERKz3+vdnc+jemr+xGYAHEGV2hSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.30; Wed, 7 Aug 2024 16:52:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 16:52:10 +0000
Message-ID: <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
Date: Wed, 7 Aug 2024 22:22:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240807135915.GF8473@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::36) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af3a0e3-ad9b-4cb3-6d58-08dcb70147b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXFlY3ZpM0srSytSdGxWcEJQOSt0aWMzYVh1c1Z0ZmZSOFJzT1E0MTZvYWx6?=
 =?utf-8?B?N3BYaFhIMmIxZk4rZUJ5cVpoaWVoQWhBb09qdVpZU1ArdXJnUXh3aEF1SXZM?=
 =?utf-8?B?NGlWeUt5MjZYL01rZVFXQWNKODJ4bXBqZlRpZzZDRkxOb1FiT2RLa1djMmR6?=
 =?utf-8?B?WUJGWC9YN2ZGYVcxbXlSbDl4RHh1ZlJDYkNKeVRwSjRtUlkwWXhaNmdMcVhE?=
 =?utf-8?B?Y20zR1ErT0dYU0toeWFvVGdJQUVDcGl1RjBsdHNSMnFBNXNiWWppQ3RGQXdZ?=
 =?utf-8?B?T0x3ZkRnU0hNSEVFVE5FNmw1a3BuWGNIb050OG9td0V5NXRnSmRIbEVacXFi?=
 =?utf-8?B?TU5OMnFHUnU1dXE3VGVHREdOU2MvSVhENXVVVis1TjRHejF4bzF4U2YyaEdn?=
 =?utf-8?B?cG1vQ1h1R25Zdy9zSHF6T1RTbUhJUExjYXJyTlBpb3VSZUNHam10dVNzNE8w?=
 =?utf-8?B?TzBxV28rY2dKdEJxZG00RHd0Wm53anVhSkFKRDhBMlU0cFFiVk1pL0Vta0Z1?=
 =?utf-8?B?SFhmSTRDdVNrekQvU3JBUkJXbjYwMktZdkdFSW5PNU9sSVFwM243aEJxeWlG?=
 =?utf-8?B?Z05SQkZEaGg0K2dzZHVYVDQzV3p5Zy92eVB4TWtYTEQzODUyYmpxclRkamRK?=
 =?utf-8?B?cGRvZlQrNUhoSWIxM0RuSXYrMXJPTXY1a1JnQWtJQ1h6VjJBa3B4OVlSQ0Zj?=
 =?utf-8?B?ZktEMEpSSVRBb0xBSDBML1RZLzNVRDVtY3N6TDZ3eFhTWmg3Mm9rWnB5VW5J?=
 =?utf-8?B?cm1DNnJXSDVFTWZVQ0FxVCs1SGNvSlNtK1pRNC8vRHhRQWxGOEZ4TkdzZW92?=
 =?utf-8?B?VERNRnlTTTJwWlh5UjlZbE9XS2ZaazR2UHBoeHM4a3FYbFhHRWYrNy91UDVD?=
 =?utf-8?B?aFdOL1lHSG9UMUEvcllmL0hQM1FMSG5rVFE5K3lrSzE0UlZ3TnFhMUU2S3or?=
 =?utf-8?B?VitDM1grTUM2VU1iZjBSVGVwcTdHYkY2SXl0dTJKb3dORW1LVGYzdGlyNTFx?=
 =?utf-8?B?eVhiblFRS3hheGNnM2h4VEZWSnYvaWlZRis3NFZ0QXFDQTdPaDVhMDVRU0pT?=
 =?utf-8?B?MFlQQkJwZERRS2ZLeStOd3ZFQmhuV2F1OXk2OCsxZU5Qa3pCMzB0QmdPV1I0?=
 =?utf-8?B?Q1BSNklnb1FQdUs0c1puOTJKSUZqZzhwVGp2Y3NuZUdYSnFUT1FDeFR1emda?=
 =?utf-8?B?S0puQ0FQNWMrTkNHNXZ1MUJ3bFdmNkM4cm5mRFBTbzVjeGxZV21ZTGZmUHNw?=
 =?utf-8?B?S3hoRkdDZFdYOXlncTZBYmNKVzlaU2xZbUxFSTh3MHNSVmpuNkRFME1PZlYr?=
 =?utf-8?B?d2IvMmxwaFVrLzZOYzF2UjdlKzllMmd6TFZ4WmFyOG8ybFpCYWIvSWdqWHdI?=
 =?utf-8?B?ZDV1K2wxemJlT3RDZlByNEpMOTVUeFprYlNTZUhQTHBGenMwS1JQRHRGVU93?=
 =?utf-8?B?cFVMd0JyZmdjZE5tN004K0JqczNVRkdKbmI0aklLQjNwbEM2M2w2amxtajFy?=
 =?utf-8?B?QkZFbWFIblNKQytUMU9YeU5tYjhWKzBqRnp1WWR4RERONVNpVDgvc1B6TU5V?=
 =?utf-8?B?S1o3TzNEY0pGVHhuNDNPbThzblEybjlNa1hIdkNOUVhrUVFuRUFMQlJVSXpx?=
 =?utf-8?B?NjBuMDZnRXlsTENjQjNhSmNGemVjZ0wxL3dENjhuNFJVeVJDQ1YvSXJFdnVw?=
 =?utf-8?B?TEdneDJPVHRzUDRrTVgzaHBQdXIzRnRtUklyT2E4ekM5WkhGVHdrZWhUYUE0?=
 =?utf-8?B?TzdCWUlqWnNQTE5IK1pQYXFqQWJuQWtrRUozRTNCUEwwb3hyMUhSQ01OZklI?=
 =?utf-8?B?RWhIb3V5dldxbDdRZHN6QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0duRDgvOVNoemp6czhUN1NEUkdXUHVROS9MNHJ4T3lCOU5ETkVoeUpoUDNV?=
 =?utf-8?B?bXJReUxoSklzcTZTaWNCOGw0SUpyRWVnU0tQUnFIYnpLaTh1SXZTN083OC95?=
 =?utf-8?B?RFZ4VWV4UU5QckRhU25NQTlzaFNzTnNNNFdzdktjYW5GYnZVVEZzdGxEMFpQ?=
 =?utf-8?B?U0k5T1I3VVpDZWRUelZNRFN2YWhYT0t5NUhQYlNUdGR3S2xLL3ZWMGhuSmhi?=
 =?utf-8?B?RkxFK3J5bDdyelI5aEs3MU9CWFFVQlFRbGJBMk9SK01wSGwrUXF2Zkllbk5H?=
 =?utf-8?B?REovNWlvNitJU0E5MGhoVE8wQ25GZlpIOG5Xem9tVjZlTVd3OXBML1lsUmR2?=
 =?utf-8?B?Y09tb3JoTFFYa00yektuK1dSNE8wemFpQUFlODhaTmRvOFVpS2xFSW9XRW5P?=
 =?utf-8?B?SzVZZ0piZit6ZlVpR0RXSlhJMEtWR1pVanU1d3hFUytldzBJVm9lSm01eC9S?=
 =?utf-8?B?dDhpZVdsNTZaWDRGalU2QlRnb2kvQ010MWt5THJ0QkFHV3AvemprcjJhUmU1?=
 =?utf-8?B?Qzc2N2ZDcEtmemtCZWtMLzhJRHVocllUVE16cXFvaFhJRzBCLzJxb1Z1cUxQ?=
 =?utf-8?B?Mk5aYmhNaE8wYWNuMXNJQ0RuZnJRRDRiUm5vd2VuTW83bE1EWUhYZ3JZY0VF?=
 =?utf-8?B?d1JiVjBhYUx2TG9NMnF2MTVHaTlQaUs2WCtvTE1aZWcyYU85dmlvVm9OL2Rx?=
 =?utf-8?B?WkphQkFPcDFVNnBvYmN3a0RvMnJMNXdQZkNUd016NFBDU1VlRUJIMHB0WVly?=
 =?utf-8?B?bFlsczlpREpxTXRFTndqM1pZRUF1NlBUREMraVJBVENyUXd6dU4rQUdUZjRN?=
 =?utf-8?B?WEc4ZTJkMWpUN3BQblpSTkdYamI4N25yOFUrMGMrN2MwbWVsd2VkQVdPRlBV?=
 =?utf-8?B?dXBmTkZhYlZ6OFg0aDRXVnp1TGpDZDVoZVBLaHZ4b2ZkR1NGcm5QT3ltZDRX?=
 =?utf-8?B?bnFQUWh1U0NJRW1xakJ5R3ZSamdiZzZ3cDYyN1dOWUplOUp0RTJ5aXNPZUlG?=
 =?utf-8?B?UHN0OGRyTzgrMTUySXJiK1M5QXFmbEFGUDhJdC9DVGJ0K1E4UkphTTN3V2My?=
 =?utf-8?B?dkRneDNxbSsxUnJPOWtLbTNnd09rUGNUWDA1WVhZUUlDYjJGUVplaXJEdm5K?=
 =?utf-8?B?Z2RnWjlEakNaL0hCbmZTM3ZaakNtdWtrTkhZREpGd2FnV2dvSkV4aXdwQXB5?=
 =?utf-8?B?L1QvdUVMeWhtNVlkM1R5eDBEYUR2dXBoVDA3QWhSaWQxeXdrY1E5TVBmQ1E3?=
 =?utf-8?B?RWpZTFFlckpoUkVYNW1NNUEzaWcxbWR0dmczRUlNK1lHaFliYndQWktjcUJy?=
 =?utf-8?B?WHdQNXlwbGozTjNKaUtveHRJSkgrOWFLY0ZYSHNpNGlBM0JSVnptNThUQkZz?=
 =?utf-8?B?c3BKQWZhQ1Mwb2FYc25ES280Q1Z1Si8wTjFzS3hiQWJQZnBpb2FDTE9CY1FO?=
 =?utf-8?B?M1JiMmRMSkgvQm0zU2NEeFVlSDhkdkRPQ1JRTDhPbW5tWHYyeWwva0NXZmdj?=
 =?utf-8?B?bFpmWWtIRlp2MTJFTCtoRlAxaDhSRmxwU2l4YVdEQTY1TlRLYStjNC9HclVx?=
 =?utf-8?B?Wk1POXZ2eFZ6d1I2QkVXMVdTNXdrdjNGU1l0UmNNUDBjSGorY1ZGYXRmUm85?=
 =?utf-8?B?QXRYNkFGZi9vb3laTXVxY1hUQU1mRzFGek4yVVJNc01POWVtbGs1NzAzcm51?=
 =?utf-8?B?YkhIWTZpeXIybXRyYXloWmpnM0xaaWZjSE45aHFoUi9BcGV4NCtNaVc2elNY?=
 =?utf-8?B?SXVWS0xFTzRvZ2hQZS96MENjUy80QXVaTXQ5RytEYVdtR2hCdVFDUEVCYkp0?=
 =?utf-8?B?VUlVUStaRkc1Z0llL3V5YmUyYnhHdkh6UjNVN0RCZkEwMEFFWElmbGh0T1dh?=
 =?utf-8?B?MW91cHJGMWpZZkNKRkF2bzljZkhvcEhlL04xUTN2SVNHSHU3QVNlaWhOSENW?=
 =?utf-8?B?bnB0eFVHRndsS2w1djJjZFZ6MmFNbE9RV1grT3p3WTRpNms4WjRPSEVQOGt3?=
 =?utf-8?B?a0VucDVKazc3U3ptRFdhRHFWQXpjQzhVVzJNTjZkNFIzTWJxYVI4WWwxSTNC?=
 =?utf-8?B?WVhFbWFWbHdaQm9GOXlmM0w5YmoyZXVKS3dLN0RaNnhyTmFDUlVra2h5SG5K?=
 =?utf-8?Q?AM1E/NvjIvWCLCKRyMv4nl8fj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af3a0e3-ad9b-4cb3-6d58-08dcb70147b3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 16:52:10.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfVbUtJUBXpypyfK4wsfJbslTA3P0vZElqu8BGr1qxAY9lOtLIwpPIN/+4IllQZlXidUhv98W8ws/wko7jWucw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309

Jason,


On 8/7/2024 7:29 PM, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 03:00:50PM +0530, Vasant Hegde wrote:
>>
>> commit 312c2a99897937834f6a679b6f9956288e8c93de
>> Author: Vasant Hegde <vasant.hegde@amd.com>
>> Date:   Wed Aug 7 14:42:24 2024 +0530
>>
>>     vfio: User iommu_ops->domain_alloc_user() to allocate IOMMU domain
>>
>>     - Include uapi/linux/iommufd.h in vfio_iommu_type1.c so that we can use
>>       HWPT flags.
>>     - Move dev_iommu_ops() from iommu-priv.h to linux/iommu.h
>>
>>     Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Yeah, this seems like a good start
> 
>> @@ -2134,8 +2135,14 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu
>> *iommu,
>>  static int vfio_iommu_domain_alloc(struct device *dev, void *data)
>>  {
>>  	struct iommu_domain **domain = data;
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +	u32 flags = 0;
>> +
>> +	if (ops->domain_alloc_user)
>> +		*domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
>> +	else
>> +		*domain = iommu_paging_domain_alloc(dev);
> 
> I suggest to wrapper this in a EXPORT_SYMBOL rather than expose
> dev_iommu_ops ?

Sure. We can do that.

> 
>> @@ -359,11 +359,14 @@ struct iommu_vfio_ioas {
>>   *                                   enforced on device attachment
>>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>>   *                             valid.
>> + * @IOMMU_HWPT_ALLOC_PASID : If set, allocate a HWPT that support PASID
>> + *
>>   */
> 
> Needs more words, maybe even two flags?
> 
>  @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a device,
>  with no PASID, the device will support later attaching a PASID as
>  well. Some HW requires a specific domain format on the device to
>  allow PASID to work.

I will add this.

> 
>  @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID. The
>  domain attached to the device must have also been allocated with
>  IOMMU_HWPT_ALLOC_DEV_PASID.

Why do we need this flag? Previous one is already allocated PASID capable
domain. Is this similar to SVA domain?

> 
> And then we'd want to enforce this rule in iommufd to force userspace
> to use the flags properly. Otherwise AMD will be permanently broken :\
> 
> I'm guessing that userspace will never want to share a PASID domain
> and a device domain, and current iommu HW will treat both flags as the
> same functionality (use the AMD v2 domain)
> 
> Yi will need to accomodate these flags in his series..
> 
> SMMUv3 support would look like this:

Thanks! I will put it as part of this series.


@Baolu, Do we need to make any changes to intel driver?

> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9bc50bded5af72..c2e46a352d6b09 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3052,7 +3052,9 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>                            const struct iommu_user_data *user_data)
>  {
>         struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> -       const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +       const u32 PAGING_FLAGS = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> +                                IOMMU_HWPT_ALLOC_DEV_PASID |
> +                                IOMMU_HWPT_ALLOC_PASID;
>         struct arm_smmu_domain *smmu_domain;
>         int ret;
>  
> @@ -3065,6 +3067,14 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>         if (!smmu_domain)
>                 return ERR_PTR(-ENOMEM);
>  
> +       if (flags & (IOMMU_HWPT_ALLOC_DEV_PASID | IOMMU_HWPT_ALLOC_PASID)) {
> +               if (!(master->smmu->features & ARM_SMMU_FEAT_TRANS_S1)) {
> +                       ret = -EOPNOTSUPP;
> +                       goto err_free;
> +               }
> +               smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
> +       }
> +
>         smmu_domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
>         smmu_domain->domain.ops = arm_smmu_ops.default_domain_ops;
>         ret = arm_smmu_domain_finalise(smmu_domain, master->smmu, flags);
> 
> (though this will clash with the nesting series I just sent)

If your series goes first then I can rebase it. Lets see.

-Vasant

