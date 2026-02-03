Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435F1AAE17
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770097139; cv=fail; b=nzp17ebuDcg0KLYPgNwprD/H48m1Fs14+TG1SwRCK5dPFDzRyUGe6LqsCORtDDx/oXOgMLrYLoqOU3tdy9bal0q6fBt6gJZGEJ4sU/1FqBIpuHvVyDBnDA2PJe1UCRG1KV3ixBkVq+QCqGuSLFJADuHrFo0B3DhFx01LQT7KZ80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770097139; c=relaxed/simple;
	bh=N/Q8kIh0Cf4YeiaYxj33nzadnzWZ+50U6RB46fop100=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JctVqsbjYXgh7y72S0MhnqoRu99ha0FBc0VMZW6VgepiIRI+t8tOzq7Sf/qi1RLZs4Ti85TtRvCdbw4GFZy55TmqKyMbgdGWw46IYfntKqWeJ0OuD5j4LFhcXGaT6mW4GIK64Mao8JbtgQ/JFbFyx+C5DPMnBJtLUP787nCt2dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ULhMcq4K; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ULhMcq4K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybCIO51dwPEpIBjZFQ42TjufWSTOWGNZD7hODU7iot+W8k/7u0qtdZN5VTW1xrKvzPuKKTHbTHZwSohkuQFGq9pNreUeUucuMl0fuB4K71+vuryWNGqEWtfoPPoIVzPU0FUuLGy760vOzYnptub3LEmr9EBDB9tjajg+NoOsSDAL5YjPFJ+SfGsN62XXgLlEdZY78nx71T3rJ7ONSbBZPl24nJS1RPtH9WMNCEiLqWdxNKTdezcZMTL1zrIm0az+jhcTFfeTEZ7lTiqQmqVznVskY6KrkzoTtHY6oGV4CAAN1tQmVJtWpO3T+y9cBFYnPzFf4w6CqKiMsaGLixttWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO3y3L0jXmKHTM2Gjg6QoFbRT4sbDUhQxOZJzGtF0C8=;
 b=nh3c1WiOBrpY/8G5Vo5jGtd/roPcwExmFJjsy8BeDqYi8h1crgAhLWu7D/2q0yz/kUpJnlzvozyOOwi5tPpF2c0hrk3ZNG0ClWj/BCyuqIUaevqzn0V1vcxLotkU/J8A8VNSlIKqJFxu4bEB3QSZzdS2YADgCGxqH8TUZ8bafoowTtSD2XOtpRF2Wxal35yO5mZclV8jF8hHI/hxHa+Jr6DQfR9hSvU+AOOpwuNaVby2oiUFL2vbUvG26rIKm632tM95vPX03BTaauPVJgwsr1oIl6SMjdnMmUSXBtUyABowd26GC50cae8UQ1I793vut/iT3s8TiS8tCnu25OVq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO3y3L0jXmKHTM2Gjg6QoFbRT4sbDUhQxOZJzGtF0C8=;
 b=ULhMcq4KeTaQxXddi2PJ/SkZVjNit2FPN6lc1lRt6O7FrDGcla0h3b5Iu5m9xXdgA/VhpUCbQvTijzPJXB+2jiInPrxpWVByT771ZxYpUljps5HKx6DQCq3hR3TU66jNgG+p8FHV86JZPsUoihCnhGtr721VscjSD97pFNbmx4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 05:38:56 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 05:38:55 +0000
Message-ID: <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
Date: Tue, 3 Feb 2026 11:08:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net> <aXnXX0P-XsEFPlJd@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aXnXX0P-XsEFPlJd@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::16) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fda3c6-9f86-4e91-d01f-08de62e68573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTh6ejZOeW9pdDRSdkRlZU5NZytvTDdaTFY5UU9GQitUUUJHTHdvRnFlSmVK?=
 =?utf-8?B?U2lQQnY4dUpsajBWWitoWFlGL0Z3Z1BsaUkyL3hSSlhpV2oyV3l0UUJiWVZ1?=
 =?utf-8?B?WStXT3lUSFJMeVJpWldhVlVvL1F5ZkhqNmNicGhuSVM1OFlTWXFuWlRsQ2Y4?=
 =?utf-8?B?YkRVcE9xWWhUWEZIQmVLcW1OblJ5dU1KbThaNkY5M2RlM3l3L0V6UTZhVXdm?=
 =?utf-8?B?eEU5alhBRmkwdnpoenhpelNYZWNVMjFaRUNXY0d5Y05hcnZOc0lzbHdnMkFm?=
 =?utf-8?B?bmcrT0tobHFZZENLeDYzNmQ1SHdraUVWc3dhV2NScXBsS3RheXdjSUx4eXR5?=
 =?utf-8?B?Ymk5M2RNdWVnUlUwbmNvdXVTb2kvcEJuSmtPSUhzVnBwa2Vnc0E1a0lKM2R5?=
 =?utf-8?B?aUVMRnhqanBJMzBxT29PZ0NBVnVxVkVVWTNoU3pBZmJhVTJLYXFoMFFCQUVX?=
 =?utf-8?B?VTYvNlNnTlVCVThCbW45MXRyWi9DaUl6NHVmaC9NWGpxQzRCMThMUVJScDlw?=
 =?utf-8?B?SnRaVUg2VlJVWmZpcnk2NmErUUlTTGlzUzZNNGh2T0FuREhBYVkwY0hRTTdM?=
 =?utf-8?B?eEZKbzdOeWp3Q0M0cWVSa29VLzBJVlVpVTl0NUdFcjVTc0lkRzU5bkpDVGJt?=
 =?utf-8?B?VDBtY3FNNFNpYTN3KzF4THpPSkRyRUp2MUxtbzN5TllTcXlPVkpxU3lKQlhi?=
 =?utf-8?B?TnY4dVRvTDVrVUd6Ym1MZ2ZHZXFpRFZXajcxNXBpQTk5aUd2RnJBZHBvVnBD?=
 =?utf-8?B?STh4NFZ2c0pZVmFjN2RqS3VJL25lOVY4Tkh6UXpkcDRMbEJmREZJNi9CNGlh?=
 =?utf-8?B?dldKVnhjcGY1V0t6TURiNVhiaHdMMU5MSnBzMTFvaTBEZGV3Ukw0dEw1a0hu?=
 =?utf-8?B?RFlHT25iY1k5RFg5Z3FzWHRMR2g5dno4K0UzRkU4L1lCYm0rN0duY1ZBaFpr?=
 =?utf-8?B?OUdtWjhEcXd2cnZVUzlOQnpDYTRnN1k0MzRCaWVGWW1nckVGdmxEdFAvSmdD?=
 =?utf-8?B?VGNjbDY1Q0RMeUx6ZDdKdUo5TmZST3BlZkhBUlBpNFFaTzhETW45UVdCOUZN?=
 =?utf-8?B?YjlydkxyWklVVUxMU2Y3YzNTYVRLcEh2RnRCZmJwSUd5bXc5QStrR2ZMMi9U?=
 =?utf-8?B?Zm1aT1BCaXRRM2hEelo4UjhNNm5VblIvYnBLNURxZDlJTUYrVmRGVlJKR2dC?=
 =?utf-8?B?RXplaTUySU1tRkpaRm1YZ2VNRkNESE1sQ0lYVjVaT0FxN05wMnJHQVBvM3Jj?=
 =?utf-8?B?c1RPTkJDRURCUlVyWG5xWGQ4aVcwV3VBOVZpNDRRWi83TEdKSCs5UG1DeXVL?=
 =?utf-8?B?Z2dxNndndThFd01QSTRjdGpIdFhRaFpmS0JKcWRHSzA0VU5JazdwV29QS09n?=
 =?utf-8?B?L0ErUkZnM01EWU5QZDBvbEk4ODJralJTUkhaekVQOG82OVltdVJtUTczbTFX?=
 =?utf-8?B?L2tQeU1lNU94TzhReWlYeExjOGx4S0t4Z0ZuSDIvWk1iblhXeUVrUjJzQXBI?=
 =?utf-8?B?R2dTVC9LZjh0ZXU1VlZTWGxEem1md3AxcExZK21TWDMzd3FRQlI4VzR2MmxO?=
 =?utf-8?B?NmtWYUdyUUM1VVdKZlQ2SDRYdmFwOE96MW1Da0hIQWZ4SElRd0E3LzJHNmp0?=
 =?utf-8?B?emJVbmE0ZEdDK0xMZGV6NlNueGhONTliWStldnpUbWZsUGJKUTB5R3BNNG1i?=
 =?utf-8?B?cDJKbE5MZHUwblFGYXpPUkpCekpwb1hvb2hYUVdMS3hUbWZjOTNxWmNWVTNt?=
 =?utf-8?B?bThnbUd4VGYrWWVZSHNsUWRNeUJFSi9GQ0xobi9sVXZhZFJYaW5CQXVBNnNC?=
 =?utf-8?B?ZXhnbUdoSVd2dDBiaXVodEMrQTM0VmxrdWdqVHpoMVNSQWZxZkRKS2wrSnMz?=
 =?utf-8?B?SHdVWDd6NVN4NXpPdS9FbFU1OGFaNTkrUEJTd0hVRlJUQjVtS3o4NVoyNjVp?=
 =?utf-8?B?TWtCUWIwak1Tc2ZBOWhDY080WlRjVkRVZG0yK3Z3bmNFVVhHZkNJZU5BN1Yy?=
 =?utf-8?B?YUV2dUMxcDVaUnVMZSt5OWpETS94TVFHVU80QU9XR25TOFNDUjRFRXdOckU1?=
 =?utf-8?B?MyszVm5HNy9XOG9MSnhyR1F0SHlnUy9FdjNtTjdTY0NnTnVTOENFT1ZyYmxR?=
 =?utf-8?Q?PSJs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRFUFU3VUxZN1FZS2ZuVDdTRVNBdFhHRGs4MFZVdnpoWTh4bG8rZ0ZocThy?=
 =?utf-8?B?N0dEZFIrNmRqWW5VSjhRM0NES053akJaODdSbnB1UExCNFRTUUw0dDBYd0lo?=
 =?utf-8?B?L2ZLbm5hVmE1Y2YwcnpIZzQvMUZOM3RxWlMvRWN6aFZTbkZDQ0o0RlUzZnd2?=
 =?utf-8?B?UDlJVmtTckRUV0hMeS9zQ2N5eHUrc3lRbWJ0M0htNEZKclgyN1FVV0hYR0dm?=
 =?utf-8?B?Z2Y3VmdUVjBBWkdhaktVa2VPYys0RHZ6YVlkSG9UVnJGdHp0a2hFdDdVbS9i?=
 =?utf-8?B?RlU5N0Q5YTR5VzhMdXlLSSt5Sk8zUStoQjN5bTR4QXdYMGN2Q0VvMTZLTjdZ?=
 =?utf-8?B?WUMrV0lCR1paMUIyQ0IzNGZERTlTUTFNRzRZOXhWYmNRcStqS2Q0NnVjVW0v?=
 =?utf-8?B?bVdiMytwc04wejJmMVJxRUVLekNlTk1lTGRrL0ZkTVMxdDVWcGJCZUluYmx2?=
 =?utf-8?B?M2RPVE9yVGdGa3R1Yk5pSjNTUmtDU0daeGtTaEhLUSs5eG82ai9MVEhhSnkv?=
 =?utf-8?B?SE9aUW9NYThObWFZcE4yYVQ4RFFROWpGWFgxTkhBN0NhNTZaL2RTRmE3NXhW?=
 =?utf-8?B?TXE5aG83bkxDMDB4QXFFZVpZN2Ywd2FkSDhSSC9JeHA4NDdCa0ZRZUVwbnY3?=
 =?utf-8?B?azNvR2tFNkc1ZFlZYlYrMG1SZGw1dThQSTRoWWV1MFl0emNLYWZicUtvbjZ3?=
 =?utf-8?B?RjhQY1RxU2NHY20xaWhNV2tTQ1VBN3k3eFVPQWRHOWU3MHc1L2FCTW1OazVD?=
 =?utf-8?B?VVBwdHBiZlJzS1l6VU9pL0VVd0xRRlY2TFFDbUZ5THB1SWp0YjA0cXlZWUll?=
 =?utf-8?B?M295RE9Ed3FMcmg2U08xMXd3aFRoMzdaY2p2eFFHUFBCU1RaekhxVmZnQ2VC?=
 =?utf-8?B?UGpXSDFmMlFUS2NPRUtTOTZVeWNVdUZKUnlOWElEM294YTdlSlpCN1pZZlNm?=
 =?utf-8?B?cEJyWk9JMjZyUGRyQ2doRGo0Nk5nQVdYWGVFZ2xiK1NUamNaSkZONHZsdUNn?=
 =?utf-8?B?VHo5bnhXUHRiZDVZelZQcElwVHZLa016TFpXUUdSeGRReWdWMEhFbEYySnc2?=
 =?utf-8?B?MkVDT3lRODZaUGdCbWVYZDl1dW5wbjFTWGp1QUxaRkRLR0VYbmU1bytjbmN5?=
 =?utf-8?B?RHlIOHFTLzFVQXpTVHlDOE81OUVlSllva0E5QktrMlVRcFlxL0JVL2FveS9G?=
 =?utf-8?B?L3FyQTVSUGhjcHNWSzdGdUJRb2w3bDc0M1YwakxaMVJFNTZsZkM5WlRaRlVw?=
 =?utf-8?B?UGY4SXgxVWhQUFdlYzV0QW1jMXU4ZmRQOEhlOEFlcStncXRHa016UjY5Q3VM?=
 =?utf-8?B?SVJreGJoOUp4K0pNZE42TWwrNlAzTTVpbDMveUdpNXVCWW5jcXQvMDcwRjh1?=
 =?utf-8?B?S1RKTHdkNzR5UXJXVjdqUjFQV2N1YzBKbXFNbERsU0RrRHBKK3I4L3NpRWNV?=
 =?utf-8?B?eVl4NVpIVG84YWRzS2VlWXprTnJQM3dlYmFQQSt0MGZqcHR5VDRBV3dNZTRR?=
 =?utf-8?B?T2JKcmNNV3V6OWRZMC9WZkNLdnJQRWYzS1VFRXYxNEQvTUVNZ1NsbE8vOEZH?=
 =?utf-8?B?cW1yUTdlU1NqY055ZG1UVGpUNEJPaW9SRFZMZWlZaXhsNy8wZFR0QS85ejhQ?=
 =?utf-8?B?UGJWWTQ3ZGpyYjBMeGp2N2s1NjVDWG4wU2hyTysrZ3gzdlZuUGdOSHFqM0hp?=
 =?utf-8?B?c3RZT1hVdkxjNDREczVVS1ZUNFdxRHBqQ3NoZlF3UnVhdVZHMFh2ZC9sbkYz?=
 =?utf-8?B?TkNOS1o0UkxqczV6Y2MvUjBCaVRDQ3hKWTZsbkRUUldyMzEzWHNmYUNkNFlm?=
 =?utf-8?B?Z3N5cEl3NE0vZEs0azVQK21EajFzUlcvT2J6amdBaEpPczdPMHVIYTErc2E1?=
 =?utf-8?B?YWtxbGdhTzVFeDV6U25QcEJHWWd1Qy92emQzRW8xMXdITEhSY2hrbUZlcCs2?=
 =?utf-8?B?WTQxQkhiY1lSc0ZuWm8wSyt6N05IL2JPdGlwRFhBd2lmanprSFQrZy94VkNu?=
 =?utf-8?B?VG1MV2p6U0REM0NoRFBYVUV1c2NUUmRvQURhR2JBK3Fqd3duMEFCR3RNd2Y4?=
 =?utf-8?B?WFIrQlNyRllJQ3dEYUJQYWRLUXRBVWhVU3JJTWQ5U1ZNMjRVNE84TGFkWmtT?=
 =?utf-8?B?S2dwcGxZSC9oaFFlcXpWTitFbUg1NlY2RjlTbGF5aUE5aDF1eldVNS9jQW03?=
 =?utf-8?B?b2ZQeFI1YmJ3bXBPQm9VeUQwYkc4WVBVS0FWaGx2dHVPM0Y5VHJyOGY3RHVs?=
 =?utf-8?B?YjNtdElMWXAyaWVIcnN3NFFxOGcySEdQdGhKb2crd0pVTHVMc0Q1TmxLTTNQ?=
 =?utf-8?B?S3ZBSGJ2cSt6YldRVnp5OStHQmpmSjRaOXZsLzluR3owMEhpdFRxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fda3c6-9f86-4e91-d01f-08de62e68573
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 05:38:55.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGLlUWL9uQwVqJA0WRsmZjGA/Tgpig4x+vrHWu8xJj2HmUk5n7Pf4pLxj8tYKkvcwneqsCVwoYdLOnvJzFwsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

Hi,

On 1/28/2026 3:01 PM, Johannes Stezenbach wrote:
> Hi,
> 
> I was hoping to get some response.
> 
> TL;DR:
> 
>> [0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340
> 
> - is it Linux or firmware bug?
> - if Linux bug: please let me know what to do to help debug it
> - if firmware bug: what additional tests to run; how to add a quirk
> 
> What's the downside of amd_iommu_intr=legacy? Does it only
> affect kvm guests? What's the relationship with x2APIC?

If you pass `legacy`, then it only affects kvm. It will not accelerate
interrupts to guest.

interrupt acceleration has two modes:
 AVIC works with xAPIC
 X2AVIC works with X2APIC.

Generally BIOS will automatically enables appropriate acceleration mode.

Can you try below patch?

-Vasant

---
commit 84410e2329ea6cd8b36869e1d8beeaf215dc95d6
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Tue Feb 3 11:03:27 2026 +0530

    GALog fix

    Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b4f90a..78d8cc3f7608 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -960,6 +960,9 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return 0;

+	if (iommu->ga_log)
+		return 0;
+
 	iommu->ga_log = iommu_alloc_pages_sz(GFP_KERNEL, GA_LOG_SIZE);
 	if (!iommu->ga_log)
 		goto err_out;
@@ -3024,8 +3027,12 @@ static void enable_iommus_vapic(void)
 	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
 		if (iommu_init_ga_log(iommu) ||
-		    iommu_ga_log_enable(iommu))
+		    iommu_ga_log_enable(iommu)) {
+			iommu_feature_disable(iommu, CONTROL_GALOG_EN);
+			iommu_feature_disable(iommu, CONTROL_GAINT_EN);
+			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
 			return;
+		}

 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
 		if (amd_iommu_snp_en)

