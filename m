Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCDD32D0FE
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468717; cv=fail; b=dhAYpaRGNHQhrnQZFSLo/YZw9nf4tEgE/iEe4L66CVXce5fNOIDAitXdeE+ZmqUKlQS1mrCN7+cMbijewlAYQJ0skiCha02APYklSIkMOn8q260vTX0Aem/mm1ptvLlqxJ01i/Z2Gj9QvuylRuWwhjysVLZcJCWjDQ4qCZsBnyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468717; c=relaxed/simple;
	bh=dpb1ra8qLxSH/3xLnqGXxWoEQBIht6AtJKeCr0k1V9I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VSdz7maG2I4cE/DyDksJOBp49yegJf+IOupHOfh3LMekl9l2GpuIe1Cd9o3ZAVaQNvH713Xcz40+shTbTW6xWWDkMjrnzfpeaCj1MWYh0TLpN9z2mK7z6XomE1M4N1bG/skiaMocr6qYgt/hv0IwlvgOArYisgXBk3RE5bofzeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pL9ahfTh; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pL9ahfTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QfaObR7Hm6l/L75tfc3YAQI28xio758lDALwHg4NPMGed6YeMjcmqGrGCvGP71hNnxrQ9mYa+szCWnzbdbaFg9hSKTkJdNdhoMq3BzKqTGQKIIrcUscnZjs2haK0liMrfBrohluPxwof1I/A509dBNL3qRHixrCqfJT3Sad//sbUfPZQSiu01L6CTlpmW6HjJgvAeJxessRrCt04SlJ+EDoDkBCk527Q2DOzeR/2GeocsK3CV0chUZNv7p5mKOZKnNrfZPme5APImAaTz7mfplxgK+UNUmYKPvDdhnFjd1eLNhzwRzPMedMYjJn/9iEFPARJJf2Ur5syR0PWcothwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA7IAmHG94lwKaycxXM5KVZPTK7v+E0pTDGR66DW1GM=;
 b=J0jBOHWzWF2Oi8bP/URf00YAO4rivYAKBkH+UsjrioBGZ5SZtxq6VQS+z8dG5yNn++loQisF0EF3uSM6KoCXgIBu4KVc4BsVV+euDnOA4oBmeQYg+XrJGXNaRxopw83/Z5om1oK5Bl79DQPaW0iXFTLRx9hQK8g8mHyrlXwK8Z53nbIrdi3ryJf+Z9C8UoHezJurXRQ8Pxn/Vvap4W9XzyrBqvHGHYnupX7DvLy7WOzsi3o0k7gsdMGWcnGknjAVkZp9w4vjEUmxM8g0pg5dTeOa6VgBoEYpD/r5uAohHMRw1ivhEpBOChv36K13f9AShtWLGiUaPD0/BZ4ZJ88HRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA7IAmHG94lwKaycxXM5KVZPTK7v+E0pTDGR66DW1GM=;
 b=pL9ahfThOfEA3Pk9K7I+7v4nl3vZ2nXtfkoc5wCiVC6wOukUzoxsJHr21iV8R9QSl+ztutJzG59+EwPd50Tg0AHo79p+E6Vz385Xs/4ryd+QAhtLW/q6L/70vyVXF89tkaRPlJAZOxEYTNPgEpZAi2fCmqd5Oohb2NQzvODDQhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:18:31 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:18:31 +0000
Message-ID: <c8a9e07a-b4dd-41f3-ac7d-0165349ebc61@amd.com>
Date: Thu, 15 Jan 2026 16:18:20 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] iommu/amd: Introduce Nested Translation support
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <aRZTAgxpA8/7216A@Asurada-Nvidia> <20251117175427.GG10864@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251117175427.GG10864@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: f6743434-4732-4f3b-d918-08de54170c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVFZcWVVUHRyK3NRRXRoVlN3eTVNWjZlbjZaanc0NGpzSnhDdzJlL1BrQzJt?=
 =?utf-8?B?Rk5YNlpXemo2WkVBQ3ZRSStKV3lhdFQzWVF2MWtzelVRdjUyb3NFQnc3YU9C?=
 =?utf-8?B?M1NwZ01uM2NDODBwamtEaEcyQkI3ZXlpTHhrTTZrZTVKejF0bVExdFV0c1lr?=
 =?utf-8?B?cEE2RmRmaU5hVjNVa05zc0RJV2E3U04rYURRU0JmRUtJanN1eTVLM2NJSVRx?=
 =?utf-8?B?UlZBazUwcmNHMnRDbDdpQjJJVldSdDR3UVJ4bWtjS0s3ZDJQSWk4TWtVb3JM?=
 =?utf-8?B?L0grUVh1ZjQzRnYzZ2NSTGc0NEtDMXY5ZGFLdWx5RFFtM1p1RkJsMTJMNG9E?=
 =?utf-8?B?TEpvalBSUisvVENOVzBBaGwydEJhczUwOGxzNVBMU0EveXBHNDB1OFBDWDJa?=
 =?utf-8?B?Q1RjOERRNFl4dUJia2RzNlNScS9Oa0RqOTdTcXBpSzU5aEZqakN5Ky9Dbm5k?=
 =?utf-8?B?dkxTMUlrcUtZelRFRXJaOEc2YjZUL3RMZ3pxdWJTZkdhOG5uRktjVGtkWnht?=
 =?utf-8?B?SGZiWEFPVzQraVBrZVlLbDczTTVRd1V1TUVPdzRzR1JSeVcwditDU0hFV09k?=
 =?utf-8?B?UStPd1EzZFFvUzkrd2VDc1V1YkhXQlBrVHJyMDJrV2hrRW04L1NJMzBLUVVS?=
 =?utf-8?B?d0phNGxrb3g4Z3N2QlU4N2pxdjVRK0RnWWRORlRZRk45WXJLRGRJZXFsekpa?=
 =?utf-8?B?dkVpUUxYdkZUUGpBWiswcnNkRG9oOFhiU21nNXNkNnFMVlpvUlordVdzQTk2?=
 =?utf-8?B?QVpPRzIvb3VLT2FZbmtJdERKVkFidU5xYnBLa3BWdkF3YUR6TElmZGwxOHlu?=
 =?utf-8?B?Unc3NzUzc2lESHg3TnNjK0d6MlUwR0w2T2NjUGthWjAyYWk0S0VHNkMvQjMx?=
 =?utf-8?B?Sm83WFRjMmFmR2dPNktlaXU0MGdLeFJmZVo3Y3BXcm5JdnZPUG9DSTBhdjZC?=
 =?utf-8?B?TmN6N295V1d4VmlPN0NpNDNFRHlaenplMFpockFQL0pVdlJsYkVmSWhvMjBv?=
 =?utf-8?B?bDdJMVhWRWRSd2tOdXV4TjJ5cmYxUXpaYVVRczRTYURpVVRqMTdrdWJISUQx?=
 =?utf-8?B?aktvNWFWcmtOakV6U3FlWmhkR2M3TFpLR1M4SFVGOWF2VzZQLzJrbkFIMGx4?=
 =?utf-8?B?eU1KY2JwYld3ZEVaZkJWc0YrUWNIcmUyeVFRSmlpUDIyZ3V1MTFBOElOYnFs?=
 =?utf-8?B?a0grOGpDTytaMlBTSFhQczBvbHNEaVU2REN4S2VGUWV3dTZad01Xd2E1WTJ6?=
 =?utf-8?B?ZUZONmUwbUx4aUtKaHIva3cybHFZSmx0OUZnSEwwV1ZQT0lyaWJKVGdBZ3M4?=
 =?utf-8?B?bGpyWGNNektGeC8vUVI4VzhYSXBOSzlMOUttUC85MUI5WVg4SXAyTm9wc1ln?=
 =?utf-8?B?a00xalpHZS9TekxPQnNYWmd2NFpWQk9XTVlCSithYnFaNEtvMExTSWVpZzhx?=
 =?utf-8?B?cEdtOC85a0lxaUM2QmhtQTlJeEFzL2NZLzlVZWEyU3Z5TnhoRTcxRUlCUFpz?=
 =?utf-8?B?VE9yTlFkbG83NFNJTTF0eVR6RFhuUE5XRHR5Q1M4UWoydXlES0FrNGEwODFN?=
 =?utf-8?B?TXZmT0dnQWVjZ21hWlRFZnQvSnVRaVlTSGVnd3B4L1h2SlR3N215UEpDbXAv?=
 =?utf-8?B?dDdTUGc3Ylh1d0JJKzN0WEh6VDRWaytuU1pIR3R1QlRRME5jSjUxd21oSDhj?=
 =?utf-8?B?Yll2N1RXZGRvMzJQek5YUUJleFN3ZnZJYlQrRi9BVWFKQ295ZnJJTm1wM1dh?=
 =?utf-8?B?azlXdHptWVJGZTNBS1NkQ2RoODVWUXByWVFVc3E5QVhuTkNrV2JuRThrUFRY?=
 =?utf-8?B?U0ljTm9qQVBIOWw3QTloVTRRdmFucStUcTBoWmtRTVNMUDBTMGY3TWVTcCty?=
 =?utf-8?B?cURhcHc5cGh3NEhiU1pPVjI0eDJHM09EN0kxOXpCN2FBNXJkdDhnU3g3WVZ3?=
 =?utf-8?B?aDRhMXc1MEdaYUNQQmFTNDJ5bDdrUTR0NllialUyU1JEczBsTXNybHVzcHJv?=
 =?utf-8?B?U3lmL2hkNUhocWIzSTNwMy9FSFloWUJIelJTQ2VNejlnalhxK3BPVVNZR0Ew?=
 =?utf-8?B?V0RRV1RqMXhtczV2RmNLTkE0R1NmUVMvSmVPUGppaUI5bE4vc0J5aWpOMFpN?=
 =?utf-8?Q?AicgzGsAdc6bJU4ETaodXZ5x1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGFnL1Frc3R6Rk80cGxHZXZ1QXpMR1JJL2dJZ2pSRXJyRVNTR245VldRUVlk?=
 =?utf-8?B?SkdBbmYrdFYrSCtSR0pBT2h2bHdQS2t6SmVxZkJhR0ozUHk4aDV0TDJHK3h3?=
 =?utf-8?B?blAzQlcraHZTdVpubDlrUjRXd2xlRU93blZrc1JYb2Q3WW5XUFV3NHNFZDg1?=
 =?utf-8?B?V1pKZ3R3L2pidGhHVmF6QUdKSDZ1UDJscUhBNHhNYzMwYkZ5WnN5Rmpqbk81?=
 =?utf-8?B?U0syMXkwNkNETlFMRHlYeEZ1YUlWdzYwNFpXcUNndDFIZTArc1dIRjltSDFm?=
 =?utf-8?B?UzNKdStKR05LQTZXTGgxY3UrK0NUQnpyUWNBT0lod04rSDBaOUY0Vmg0dkIz?=
 =?utf-8?B?VjdrWkJrTmI2NG05YVFYMk0vUW9kVW1LTzZDbWpmZHhCMStUZVBsNk9GVWxv?=
 =?utf-8?B?OUNkWmZYbjZZWWlPaDlMS2ZQN3BXeGcvM0hEMHAya1dKVmQwS0JkcG5PVk9D?=
 =?utf-8?B?aG9JWjdITitPSDFVM0pyYWtCU2tOZThrdUtFc0pRbzBITnBHSVc5YS9kY2ZB?=
 =?utf-8?B?UzFVclVrcTFpZTYxWkhSa0hudXdvZHhib3VBSEM1c0htczBnT2QwZStmQlZq?=
 =?utf-8?B?VUhNNU5qQUpnMUNLUy83RitKeWg2aUZCYm1pYzFnNVpEUndHOTl0MHVpYVJI?=
 =?utf-8?B?MjRIYUtXakdFNkpmK1lTZlBjMVQ0MUg3VWV5Ly9JWERIVm9VMDdwMFlqczkv?=
 =?utf-8?B?Nnlpc2cxR2F6Q0w1czU5aUlzRUFJdUZiUzJ3c0VzY3RFUEYvK0E3aVZFTDVm?=
 =?utf-8?B?aktGem94VXFrT0V4YUZBRDIxMGFzZVZvYm5UMU9Md2NiOFRPOXZHOUx6WmxX?=
 =?utf-8?B?V1VodGhqNEs2RnhzOU96WWljNEwyaFNKZXZwK0tGeDBsb1VRL1k1SVNBc011?=
 =?utf-8?B?UGliUENVeE1FRjhXOGRhTmQ2TkIyekJUaWFmWjQvT3M0ZmduYVh5TW5VbG5s?=
 =?utf-8?B?VGpLbWgwMlZ4Mjk4Q1R0OVp3Vlp1L1Vyc1NsWldQVC9kQkc5REsyUm1BWWxu?=
 =?utf-8?B?ZFI2TkpSSnVrcUxSb2FqQkswZUxmcWhIU2o5WGVZbDdyZUg4U0FRZzRRT3hy?=
 =?utf-8?B?WjNwbjBib0JNV2NCOUZSaC9OM0pPQ0VxV3dBNjRpSkM0cjlURGV2Q2NpQzVn?=
 =?utf-8?B?U21ua0FOdkFtK3hQVUpBRDFTZVowZG4wWExnYWRLRkRJOTFmMWVLa2gxVXVM?=
 =?utf-8?B?T2NzazhRRDJxUTZWbjNNM0dTSTN4SGN5S2FzZ3VrYTQxOWJnejJsSXc2YjZz?=
 =?utf-8?B?MlVuUzlNanRmdjV6d09UczNrZThLL1o3bjE3RGM2SzNrU3FwVmtVbmkxTWhD?=
 =?utf-8?B?UG5zRlYyTzRGdGtxcDdIWU9IdHdkZWVQem42NjlFQ04rd3V1aEJkdHorVHJC?=
 =?utf-8?B?eVZUeWxyNHpybmRpSHFjMFlsc0RZUm9ybjNsanVDTzNEMGJjR0h5T2JKSnpT?=
 =?utf-8?B?RklmN2dkTkNvNjZXNGI4cktObWlFM0l5a0ZNYXZPaFZvUVd4dW9XeHpiY2dY?=
 =?utf-8?B?S1BUbmRISXhPNHA3eWxtdnJNYWVJaUVub296TExoUzUyUm5wWjlzcDNzM2JN?=
 =?utf-8?B?dXFtUW95OWtaUS9SOXhabml4WTdjaE1UMzlzcmRxY3Rjdko4N3dlRHptMUNO?=
 =?utf-8?B?eE5DdXMwOE83SjFmVDRGellEVXphVHhHbDFkV1dOTktlS05nYVYvS0dEUWo5?=
 =?utf-8?B?ZExUb1ZNSXYrVTYza2grc053aWkyTHQvcWp4UENyY3BzWlY4blBZMUI5YkUz?=
 =?utf-8?B?WFdFT2VUS0FLYmFWTUNxMk5HeE9YbWZoME1MV0RTdUhxWTV1czJrV2hKSllZ?=
 =?utf-8?B?Y0pZUzRiSEdmOFBRZ2VlRFJjUmF3TWlFOGJTQVpYQ05tKytzZy9jNFQ4eXpP?=
 =?utf-8?B?WThRVFRlZFlCNlduTUdtUUEwK3I1ZEJUaGExQ2NObkpEOVMvWnpjVVA3Y29y?=
 =?utf-8?B?eVJYR2xZOTYzUXFUa3daaHdBSTdpZlhEWnBPWFdGNzUwbGJuVFU0VVh0VzJY?=
 =?utf-8?B?VTBzbFZUREFhWUJxV2NWQ25GT3RkVnVRc0J1cy9oTzBkbHRQMTNHTTVscXVV?=
 =?utf-8?B?aU8vMjNPazU4Z1IrOUhITHZaRTc3Mld4UjBNSys4OTZsRUs0OG9JRzFPK1F1?=
 =?utf-8?B?K0pNYW5VU2hDVTh6d1F1aTE5dVhhZllQT1AveFVBWWhWS053Vkp1a3RwWlhV?=
 =?utf-8?B?VmhqUjZyUTJ1WU9TRnJoZWxDZ0IyL1RtQTJDR1RZWjBRcjVRVytsa1ZQQUtT?=
 =?utf-8?B?a0FoM0RaWEpIK2xYeHRjR3RvZGx6YXQyck5PMWhTL2YzYWxOUWMxMFU5Umh0?=
 =?utf-8?B?UzhWT0k1RkQ1NEhEUlp1MVBlWENyRDVkeUJYaEZpa2FjY0RHSjBEQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6743434-4732-4f3b-d918-08de54170c85
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:18:30.8089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eO+a3pZIlHEJQ7czBWvUNmHFXxQFq0QpQ0oAiwC/UbTmKtHV7NVDn/07Lr6a4hJ/IaE1cX2U46Dv7Xq1Ctpo4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544



On 11/18/2025 12:54 AM, Jason Gunthorpe wrote:
> On Thu, Nov 13, 2025 at 01:52:02PM -0800, Nicolin Chen wrote:
>> On Wed, Nov 12, 2025 at 06:24:52PM +0000, Suravee Suthikulpanit wrote:
>>> Note: This series is rebased on top of:
>>>   * Git repo: git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>>>     Branch: next
>>>     Commit: 91920a9d87f5 ("Merge branches 'arm/smmu/updates', 'arm/smmu/bindings',
>>>                            'mediatek', 'nvidia/tegra', 'amd/amd-vi' and 'core'
>>>                            into next")
>>>   * [PATCH v5] iommu/amd: Add support for hw_info for iommu capability query
>>>     https://lore.kernel.org/linux-iommu/20250926141901.511313-1-suravee.suthikulpanit@amd.com/T/#u
>>
>> Nit: this patch doesn't apply cleanly on 91920a9d87f5 :-/
>>
>>>   drivers/iommu/amd/Makefile          |   2 +-
>>>   drivers/iommu/amd/amd_iommu.h       |  36 ++++
>>>   drivers/iommu/amd/amd_iommu_types.h |  48 +++++-
>>>   drivers/iommu/amd/init.c            |   8 +
>>>   drivers/iommu/amd/iommu.c           | 221 +++++++++++++++---------
>>>   drivers/iommu/amd/iommufd.c         |  50 ++++++
>>>   drivers/iommu/amd/iommufd.h         |   5 +
>>>   drivers/iommu/amd/nested.c          | 259 ++++++++++++++++++++++++++++
>>>   include/uapi/linux/iommufd.h        |  11 ++
>>
>> So, this seems to be a preparatory series for AMD vIOMMU, yet it
>> doesn't properly work since it's missing IOMMUFD_VIOMMU_TYPE_AMD
>> and the invalidation component (HW_QUEUE).
>>
>> However, the series does declare IOMMU_HWPT_DATA_AMD_GUEST in the
>> uAPI header. I am afraid that might confuse user who might think
>> AMD now supports virtualization using the HWPT-based mode, like
>> Intel VT-d.
>>
>> So, maybe we should either:
>>    - leave a note at IOMMU_HWPT_DATA_AMD_GUEST to declare it is
>>      incomplete yet, and remove later
>>    - keep IOMMU_HWPT_DATA_AMD_GUEST in an AMD driver header, and
>>      move to the uAPI header later
>>
>> Jason?
> 
> Yeah, I like to see this incremental work, but Alex recently raised
> that we should be a bit more careful about how userspace perceives
> these partially complete things.
> 
> I don't think tricks with head files work well, I think what you'd
> want to do is leave some critical system call disabled until all the
> work is finished so the VMM never has to see a half working
> implementation?

Yes, this is a preparatory series for nested translation w/ AMD vIOMMU 
support. Currently, the amd_iommu_alloc_domain_nested() has not been 
hooked with the struct iommufd_viommu_ops.alloc_domain_nested. This is 
should prevent the nested domain usage until it is fully enabled in 
subsequent series, which will introduce the support for IOMMUFD vIOMMU 
for AMD.

I am working on preparing and sending out the next series.

Thanks,
Suravee

> The patch to get the info would have been a nice choice for this purpose..
> 
> Jason

