Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B6A333752
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468923; cv=fail; b=LKU+1gCEIOwmal4SJfILiRKjPizLMSWPQ+MyXPma4L/e2f4tbhaa06gkwV66HWmf9dbFst/ifNSupWNYv6xLRggUpYbbFYB6fVpGEjhMv2/zQfnmEUcfXSKusY3+OU7DOWWF64tfqG9dXqwkw6JUbbrUm9WBieQRg70wzJs6gwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468923; c=relaxed/simple;
	bh=PWi65tZ01bF531YNnGV3elURIXc1HoXu2+EBUeVka9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z99ibI4YIbjLQI64JgI5SPviXkBYz3C1ZgzhSQMhDAbG2n6Cl4601Saoq/7s7EbreuV+K1cOjsp4n1HLA8qLFQz24qpzv3niTIJXmQBm+poG+TBg7hNBAhtr2mrLj08/LRGi6kOh8dQTE3W1ZcMT1eVRvK7DUdZjkhtFsjWUSrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wrIqH9ri; arc=fail smtp.client-ip=52.101.61.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wrIqH9ri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9gyEsxrdN2m87poXrw83E0x1OMMULSqKwFnslgCcMIAVfuTzYiI5MJr0R5bxczic9D8XnMLrjE7/qbw7nQKl30qbq+6rWQc3ZDQQ90Lvn7mtJEGhSOEtlO32jJPAm0w4hLZjUXgG5JbgiMNRmykdKtLgjd8ooRxkn8fJBqCS78cUrA5EyPOUMKQlEhJH8XmWcWQuv8aCcmiB5rVkEHtXbLF6MIzMgX5JwmGtAhqRqRZumrymIXVL2troeokarFWmq19ZIdS682wIC49Jm9EaxisTTaHfQkDLih0+2RYDoUT3ZbG26qmDpOMEgud4tf+9okpkU51DNVOYeYUccxuaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cl55LstZ7pth8AL+CPDR44z+AQqwG9rG9CE790jsDC4=;
 b=U1gi8OyKKrGbpu3+FD4BKaIDQaKhMqIU9cmqUFjkj7m9nrYwc1GYX0W4m6inxIpIBEKuF3Y67oPuUpB75HLffzpy2YAbyo0OjtKa/eHkQENFuu61vFKLSvfx57Lp/9xAAjo7AW7Gybk1fSIKvNziy6AgvS8K3OptGjBjjnYQQdVBHyz2c9ATpp5FPUNsBGOlthZH+dWN90DE26c27wFrcEHl856MBdJkcuIYV9asoZeJg2Ei7wPPuxzOeVKKA6zVyEhLG187Ep5yyJccTTDNAErZeJUORZEGKomfJjj3WvrxAu1w3S1KNInlHcH4MQd8SeVrNnfHxnKXVMAmHuA1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cl55LstZ7pth8AL+CPDR44z+AQqwG9rG9CE790jsDC4=;
 b=wrIqH9rinuIBZ5yNnwWzXEGwFhKENUHdk1a1onqqcDCC5j9/bmg8RM7oqp7VN/92f5V0/pkDnoWx8Q92QBrTCZ+FKsqk5/aUPleSSI7fjT28RAh4k6tvm3xLoKONYxDRqmCeu+n4WHthQOOdSQBPCSlWhaII3TegAPy7P7F0vH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH2PR12MB9544.namprd12.prod.outlook.com (2603:10b6:610:280::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:21:58 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%4]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 09:21:58 +0000
Message-ID: <de939eb6-4305-4dd9-92f5-346997df9357@amd.com>
Date: Thu, 15 Jan 2026 16:21:47 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
 <aRZBN/nBz6lqTzmt@Asurada-Nvidia>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <aRZBN/nBz6lqTzmt@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH2PR12MB9544:EE_
X-MS-Office365-Filtering-Correlation-Id: e180552e-3246-43cd-885b-08de54178877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmZ6bnU5bldNWE5FbVlxZ3dpTERPZll0SEkyd0ZxNE11cTk0NHBIZnoyT1ZF?=
 =?utf-8?B?ZXpoSFg5MUpJUVh5ZmFNN0JSZkZvU0R4VzZ5Q3pVSzN2ZzgvdUZqalhzU0t6?=
 =?utf-8?B?bkZYSXdwMnJUS2I5cndZUFRLRFBlMTFsSG8vTmhUa3RORHhiSytNTGEwMEtj?=
 =?utf-8?B?YjFOQ3dnMFVXYjYxanZoc05tOTZmUEVZWlhsQ1pDNi84NE1IMGZwem9NUDY2?=
 =?utf-8?B?bjloSEpxcm04MSthTzFFQzdPLytvNm5XWnhreG1aaXpZM3dpVU9iOGRLT2kr?=
 =?utf-8?B?eUp0RE90cnpCNTUyNFZtdi80RW1MMWhMOVlOcERHN0x6ZHorWUFPYjJZV1dq?=
 =?utf-8?B?N0p2MlJCQmVNVDVRbkhiTFVSdmh2N1FtK240Slpkelhqd1RnNXRHbWRUVE5F?=
 =?utf-8?B?cC9LQkVWYitaTWhUZkpyeEtzOWVuNmRRdlVXMkw2Z09DbVR5b1BaMlF1c01K?=
 =?utf-8?B?d08vVHNnQXJUWWJkeitjTFFsSk1BRmhJTW9KUTJ2cFZ2WHg4a0RDNW1ZeFJ1?=
 =?utf-8?B?WFVaSHhINnZZTlZMMWZDZzY2RlhVMjcyb21RTVJ1TmtrSmp2Z2h5TnhqakUy?=
 =?utf-8?B?aWcvNXlXOTYzcFR2T2tib21HSGlGeU92MnoxaVlhSUdLMjdPSXFIUERSSXRT?=
 =?utf-8?B?SWdQTyt6SFdodHJTUmQ4WUhGQUpjTFZxbFlKSVJMd2lQdmd4dER3MXNJZE55?=
 =?utf-8?B?WTNQTUY3NDRoTms4MTVGajY4U0cwZ2wzcDJBTytXYUloeE9GMUJSNU1RYmFZ?=
 =?utf-8?B?Y2NPZnNhNGg1L3lxMFJ0UUNHMFAwQVB0UXFSN1BOcGM4WEJmZm1XbXhWc3cv?=
 =?utf-8?B?Rld3bDlXbUZORjdBektiTDBBcENLYlp3MXlDayswUEZBa2xyZU5jRFlSOU04?=
 =?utf-8?B?aXZsQmRDYlg4clQvcVd2UFM3Vk1KeXRqdEkwQk1PSzdVQnVCaXBwSnlEMTdK?=
 =?utf-8?B?Y2NaTzYweHg3c1o0TnVhS0pZU1dIL2xSUm1kL1ZlVjRBWDUreHkwbm5Gd2VQ?=
 =?utf-8?B?N2tNdERqQ3FkSkduVXZMTnY0c1VNTnArMkxmdlljUWtCVEE4T3JycjFWVzVj?=
 =?utf-8?B?aTdqYVNETHRuRTdUeXI2TnZZNXNGdS9abElyR21oUDdaZHkxYm1wLzdSdlZ1?=
 =?utf-8?B?MVB0TmxPRVhVeW8raTZvSnlqRmFXV1lFSy9pNW9BaThvbkR0MndHTTQ1WDBy?=
 =?utf-8?B?U1FYMVFmMW1xbldXdEtkYlJOUzNBbTJLN3JyS1h4VFVTaFFyNzdyT1dZNTEx?=
 =?utf-8?B?QkRrTFB3TEREenNnK3VvNzQ1SDF4T3Z3Z0tKa0xIN2VWVHdyaVh1RFJUeDA0?=
 =?utf-8?B?TFo1VGVuNkNwbU8yNGJIelBGYm5aMkZuNHNIaUIrS2lhMEVOd2xXU3dUcys5?=
 =?utf-8?B?SjEzdHYzbEllSklNcW9vV1JpU0p1OExYUXVFUldXL0Q2K0VDTUNKUlNkVU1K?=
 =?utf-8?B?QjF1ZFRwd0hRYWZVYXNKWnBUVDJrSUpWbDJsaUhvWVZwQ2lwWWYzOHZObTJo?=
 =?utf-8?B?VUJyV0lkS3dBL2VYRVlicTF0d0hWdElEU3ZKaHFtbGUxcHBCOHlFNmFNRkVo?=
 =?utf-8?B?RjdmZWV0ZEJlMGJGZHVFaCs5cWdxZ1gvUUhTQ3NwdXJNZFNvNjhQQTlMMTVy?=
 =?utf-8?B?YzRCOXpjZEpGTkZIUG5BcG9TN0J6b1VGVThic2laRkI1Z0RVN05oeFVMSmZQ?=
 =?utf-8?B?d0h0ZytsMXUvOVczam42WEJzT00xTHdvSG1NWXU1ams4QTdEM1NRaUZKNlBR?=
 =?utf-8?B?RGZ0KzBuYkIrVms0K085MElOQjJOaktCaC81UmlrVWlSTklEVTNCdHNsN3Aw?=
 =?utf-8?B?TFdkQWlwZ2tiS2RCMWFOTDhvbnBFSmFqZEJTWXpOKzRDL0xUM1Y5aUxrdnVk?=
 =?utf-8?B?UlA4emtPQ0V6cGlZTDc0UzE1WmtjRjRndFJzRHc0bWZrUnI3NWJNTlgyRzJL?=
 =?utf-8?B?VEdJditZUTFLNU5VbDJ3eHEvZUxmaE9WY0NYdkZTV2Z2b3ZhOGdQZzhGdTk5?=
 =?utf-8?B?VFJlNUpIdEZiY2hZalExeDZidGpsN3Juc2VFajNIOGs2OStpb2NVcURQd09T?=
 =?utf-8?B?NnNUdkJYZzhpTmNxbXRqaUxaVEhrOUd1ak0rZGNDVFFQNTMvZHJTK3dyVitH?=
 =?utf-8?Q?Y11U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVIzVUl6cjltNEhVUFRTRUZOQVhCejM5L0p3S1dMMzRvRXZnMlBybU1RV0Nz?=
 =?utf-8?B?ODRtQ0d6UmxadVRIYVNLeElpOEVRdkZsL3dwczN0MnFoMXNMM1dwNFBoTlF6?=
 =?utf-8?B?eU1pQkwxaUpHTWFhL3RVdndrRkd4RFpLRkRNa2xVK1BTbmVYUVg1SU5ncnVn?=
 =?utf-8?B?dDBobkg3eDcxN3FIdUxadGJnQ3BlMmdTdHVaQnZPUTh6Kzg1RS9Lc2xBTW90?=
 =?utf-8?B?azI4K1d5RWpoaG9OSTZxd2h6SkpRVkFHQXhoT0RJbVViTlhPNlhXTlhRUE91?=
 =?utf-8?B?UENNVmRudDRYK3luRncyNEkzZnZ3Zk8yRnBrdDJ0RUhPdi9uRGF2ekhaeGJL?=
 =?utf-8?B?SC95Y1Z5TU84UC9yQWp4VUFDQ2xtS0pKTFY1WlM5c1h0L2Nvdy8xUWtMVnor?=
 =?utf-8?B?UGZ5TzF6cUkrMHF3MFd6eFFLYzc5bytWQkpXOU56dWtTTGI0OTFZRzBETjRL?=
 =?utf-8?B?bTlWZlZIV3VRRGtoWmt5c1prdkVZdVpGVDljWWNIUGRkYnJYbzRCL1d4UUdK?=
 =?utf-8?B?V2YvdEV0enY1eFhjL2NJZ0hOMnJSUlhKbGZ0a3Z4aXpibjAvblRRMDlIWVFB?=
 =?utf-8?B?WTVXOUdGL0UwdDRuK3V5UkYreTFFOFRFVHdLenJFU2JkbDNvVVpSdmpVT08w?=
 =?utf-8?B?Rk5xQWxsT21SOEdiUEx1dFo2dU4rbmJVdVpKdkJ6QnhWZzhZV002OFdUVksw?=
 =?utf-8?B?Y1dDMVdxQ0JSMFVUeWE3dEpmSGcxckplZlBlelNJaXVON1RWUlhGdWZ2SUxx?=
 =?utf-8?B?U1UyUzhWZnJzSnB6NzJwT0ZuaVFCZklRb09QbE80eDdqOVRJMmdmc3pLNG4x?=
 =?utf-8?B?dU5KYmFRcTFvTjFZN1RDNHJIRjZvYjRGTi9EUVpkMjVWa210enQxWmNhZ2dR?=
 =?utf-8?B?VWFuRVRrVlNkOFZSN3dzSzdqMU1sT1oyR21wMWxZbENvSWltY1NvWk9ZYU9i?=
 =?utf-8?B?VEU0T0M5aWdBa01SVFQxUGtrV0lpbHkwcmU4RUtwS0tGYnE5b1FscjRDcHNr?=
 =?utf-8?B?eG1hOFlUbkhwdVgyZElyUy9vU2syeDVIa3lGQWdwR0Fnbmdmc2Nud282NVB6?=
 =?utf-8?B?VnR5aTZLU0FmaVQyTTFYVEVXcU5KQll3WGlSSlZITjh4RDNRRHVLbTZUb2hT?=
 =?utf-8?B?UHltNWlWbnVpZitjZDlKdEJuaXRKT3FFdVNYMktsN0FaMkt5WmJtZDI0ODJt?=
 =?utf-8?B?c0FCeEEvQ2ZFbDZZMmRNekQ2OWV0NkZCM29mM0xhWm5YMEpYZ29vVkF2Ky9U?=
 =?utf-8?B?SEFETWRjcnRHT1phL082dXR5YWZUTmF3OFpsdUk4SG5wYmtwdXRJREZZVW9h?=
 =?utf-8?B?Q0FFQVV6T0VORHV1NDAzeWhqaFRFZWY2T1o1TWpWdnZzTDhSR3pJbzJiQjNG?=
 =?utf-8?B?eFMrY2kxVGpMNXRhN1RpN2g5WWV3bngzcG1yRVNNS0RJMDEyQktsWXFsUXVZ?=
 =?utf-8?B?bG50TytMSDBaQlh6VEh2WFBKMUVYVWdJY200T2o2MUx6SEF5VkxuMVhKTER5?=
 =?utf-8?B?QTZCOFNRVnlMRmN1N0ZrUG11R01HMzJmTnpycUdEcGVXYzNXaFJXakMvSVRu?=
 =?utf-8?B?VjRWbTJyYmpBbmZEbmxIamxlTmZUZ3I3c001Tk1YUmVlbmVOMDF2OEI5NThy?=
 =?utf-8?B?ZzlMaVRNdHZGKzRiSHJ6TXBQbEJEN2p2Vy9XTjlXaUVmTlhYdGpXWi9NbnYr?=
 =?utf-8?B?RWlDRjdZdVFxSnhMR1BZRkx0WmllVERhc2FXSDZUMm1uUDMvTHF6UUYyeUJs?=
 =?utf-8?B?TnR1cktnU3BiaFkwdjBlTHRQWHNNMDJkcXovNUR3RXU5NlQ1OHJWOFg0bG1z?=
 =?utf-8?B?dmxFcEM4Vk5sNnlWZzArRVpWRDBnREdRejdWRlJDU0g2dWpDWkFxMFN2cXNB?=
 =?utf-8?B?cU8vUWNFemlYMWNNSTJzdzZPMXIxY0pUbFNOdCsrNGp6OFBJbEN3ZU5ocHpT?=
 =?utf-8?B?dTJTbndKbXlINUpnQ0lXWXd3RVlKbmJFZ2xsS0J3eGcrTVZSc3BwUDc0TFp3?=
 =?utf-8?B?dXlaUE1tRjlWKzZqOVpkYmpob1V4bGo3dURyMUc4UUpzeU45TERnbVZ6Umhv?=
 =?utf-8?B?bnNRWk5FcTNUTEVHZW5QbXFGanY5VE9xejdjL3RHZ3YxM0NnakIwYkxaVXNa?=
 =?utf-8?B?SkM4a1VzTi9pMUk1MEJ0SFZoL0RhR2JuK3Zqd1pCWFNSMnNvVDgvSzgwVWZM?=
 =?utf-8?B?eS9jcXVDSHBVUzJOR0VtSXlhemV0NG1PcHV5a0tRQnJlbS8zNk91YVhZUDFX?=
 =?utf-8?B?TVBWcVRBYXJKOFhhQWp4RUtlbnFQczFaL3JhU0RxM3pKd2pRQXdVQzdaM0pk?=
 =?utf-8?B?SVcyYWlFY3ZSc0U1dm9TR2Z1cURIM0dWZzZuQlFhZ3FVcWNmdFN3UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e180552e-3246-43cd-885b-08de54178877
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:21:58.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRhWfRlGtPT0EJOUL6Cb6lEJkCR+kBa24spF+GcdyJxJALddIsFa12eZ4ZPWIp82dpCTn7FRGRWKPr1H+uZKng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9544



On 11/14/2025 3:36 AM, Nicolin Chen wrote:
>> @@ -92,7 +94,60 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>> .....
>> +	/*
>> +	 * Normally, when a guest has multiple pass-through devices,
>> +	 * the IOMMU driver setup DTEs with the same stage-2 table and
>> +	 * use the same host domain ID (hDomId). In case of nested translation,
>> +	 * if the guest setup different stage-1 tables with same PASID,
>> +	 * IOMMU would use the same TLB tag. This will results in TLB
>> +	 * aliasing issue.
>> +	 *
>> +	 * The guest is assigning gDomIDs based on its own algorithm for managing
>> +	 * cache tags of (DomID, PASID). Within a single viommu, the nest parent domain
>> +	 * (w/ S2 table) is used by all DTEs. But we need to consistently map the gDomID
>> +	 * to a single hDomID. This is done using an xarray in the vIOMMU to
>> +	 * keep track of the gDomID mapping. When the S2 is changed, the INVALIDATE_IOMMU_PAGES
>> +	 * command must be issued for each hDomID in the xarray.
>> +	 */
>> +	curr = xa_cmpxchg(&aviommu->gdomid_array,
>> +			  ndom->gdom_id, NULL, gdom_info, GFP_ATOMIC);
>> +	if (curr) {
>> +		if (xa_err(curr)) {
>> +			ret = -EINVAL;
>> +			goto out_err_gdom_info;
>> +		} else {
>> +			/* The gDomID already exist */
>> +			pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
>> +				 __func__, ndom->gdom_id, curr->hdom_id);
>> +			refcount_inc(&curr->users);
>> +			ndom->gdom_info = curr;
> This looks racy..
> 
> When a gDomID is shared between two nested domains, a concurrent
> nested_domain_free() could enter before refcount_inc(), and call
> refcount_dec_and_test() or even free the curr and ndom.
> 
> Then, this refcount_inc() will blow up, or curr/ndom will UAF.
> 
> Actually, I don't see where amd_iommu_alloc_domain_nested() gets
> used in this series.. I assume AMD will use the iommufd's vIOMMU
> infrastructure directly which doesn't mutex across nested domain
> allocation/free calls.
> 
> So, the entire thing here should hold xa_lock(), use xas_load()
> for the existing curr and use xas_store() to store gdom_info if
> !curr, and xa_unlock() after gdom_info is fully initialized.
> 
>> +			kfree(gdom_info);
>> +			return &ndom->domain;
>> +		}
>> +	}
>> +
>> +	/* The gDomID does not exist. We allocate new hdom_id */
>> +	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
>> +	if (gdom_info->hdom_id <= 0) {
>> +		xa_cmpxchg(&aviommu->gdomid_array,
>> +			   ndom->gdom_id, gdom_info, NULL, GFP_ATOMIC);
>> +		ret = -ENOSPC;
>> +		goto out_err_gdom_info;
>> +	}
>> +
>> +	refcount_set(&gdom_info->users, 1);
> Similar risk here. gdom_info is stored to the xarray before this
> line. A concurrent amd_iommu_alloc_domain_nested() could get the
> stored gdom_info and blow up at refcount_inc().
> 
> Make sure the entire thing is locked and safe.
> 
> Nicolin

Thanks for pointing this out. I am fixing this in V6 w/ Jason's 
suggestion to use xa_lock/unlock w/ __xa_cmpxchg.

Thanks,
Suravee
