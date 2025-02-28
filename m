Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F9A2505CA
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732484; cv=fail; b=AJd0NY1S/OLT7s24re6KEDlhJYmAUSuZ61Pg0QZirtYXtN3B1TBsN8ioQeVxo1LBWEapdq9DRAz6cWcVtSLIUJ42OXoRPF8ddiQbrcCYjrKE1wnYsiLaZkhTD+1eM3Ri+UUEIrzyEWk2Xfnd8Wx1H8+YOXoNHAecyIcO2pPNA4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732484; c=relaxed/simple;
	bh=FF1+L8A2AX4EZNjD6DhsMutE88ty6NeZc/G/RHE7qUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KcqcNIpCeNUsOHE14jcTyy17bclBpTPsOjT/e9aJE8i871S+RnhG+qfx49WkXCqNJw3uXI/VnpGJrVUIuxQrLoe1PnVyrsq8Kb3ACkeMHBZ4c2NSMQnkz/I77mTugZ0G2+GxTE2csTaqbwo1BAO5nMYzzkRIjMquko6GzTABykw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LB0ujuRT; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LB0ujuRT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qL1S3yvWhQMQTdfiND1S9/HTvM8awf2Gc0Kv7XwKnPTWmO+4JJSCEFYmZvlgSrnlBRfLJ64q+/0UHmq6DhQgKNCB2tmiXeZfpaO7pjvFs9RX0rsemEqZTFeiMsENDNLCIMmkfnbc8xHzd1fcoidPnU6iz94mF1EzlA6ucm8V5xBAjSybF3PyEzjSft5XWGkNipY+Lsxth+KzCjEGUKg6rH8JNzfo1Mm10JCKVcKdpWYBjOv6Qs9FvIkZ2ER0Cte0OWkj4/aAtyEzwom6+86lwHyCUvBn9QWWQby+Py2Rn6odEn3CgTHRpJftF3xbZCPpYxAgrEK3g93oU7E7iNTWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbhlg8TIy1o+kaKzuZaefEBuMQHSV4fMasVhGva7H58=;
 b=ibMJGZyohifwF7Xr9PKl7XHYKextKxCtW3CqxkFw9Nc+pNFPWjrPDS1T4C/Zg/F364zIbJF2xBI6AdUOYIAN/iIcHNPHM6S3lUzxqxrH/Kh64Ogr1j6K7AFBOnYu0Lhqr4a7CV4iFG4EHKoReYqyPFNnUes7aXzqDW6VzIN/ugeJKlKP/8GyZMEugMhpJHtyq1Rq7CW9m6yjtuOY4Fkn1j1qH3UDJ4lhilAD0Lu583hYDyxNTEu/a8sPQKxCho5JRCrsO3Tnt8D1S6kdRTkD09zF+9Worhs6r5Ddm8qDfsTrnBN3KNJuc1Org8MzbOCYBu4SDn2f9K5p4RcIYrBo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbhlg8TIy1o+kaKzuZaefEBuMQHSV4fMasVhGva7H58=;
 b=LB0ujuRTrZgGoPUb2CCjPmlz6aqLVy9AkMKWprhKd/2WKUzLfc1saGKogSwa3IBB9itsqrarnjg0fYOod/DZwkXBE/ixOWYeDIcqMz74n6AzqJZdMuCFSPT8/R+bmHV/oa2HKhU8g6/VqNmR9XNfGU0qTuWS9cIUTE/jb89F64Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Fri, 28 Feb 2025 08:47:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 08:47:59 +0000
Message-ID: <825ddadd-6770-46b5-936e-f17988534984@amd.com>
Date: Fri, 28 Feb 2025 14:17:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0188.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e0f20ff-b3d5-4acd-0273-08dd57d49a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDBpVkljc0lKalZMa01mMlNGNDZ2bGVxMWVzVlVNQjRnOXExSStkMzlMbmNa?=
 =?utf-8?B?a1d0V0dJOHhZRUFTY3lhRFhObEZ4YVZqTFhLTFdWK0kvb0wwanhRK3o2TERk?=
 =?utf-8?B?MUUwM0RmaW5HUzVTSEFENGJmWHcxcHFML2xjeFY3cXNhU01DV1FyVEtadlh4?=
 =?utf-8?B?dnVwY3ZBUWlVeHc0MU1uejNBRWlDaFBlYlhYazRLVTV3M003dVErQWpJbnJ0?=
 =?utf-8?B?WDVNU3RlYnh5V0kyUmRzejVqWFluRUpneFoyVEswYkYrUG5FV2VhTDB5cUk3?=
 =?utf-8?B?dnYwVHREQ1prcHhpNTE2bVA0am1JNlUwTkZqeUJ2YkhBREFEU0J6N2duT0Z5?=
 =?utf-8?B?U2cvMk5CNTA4ZERRNkNOS2t2dkU5RE1DV2hWOThyNDNhamY3b3RZY0ZtTWRU?=
 =?utf-8?B?eG5nWWVxU3A3OGxhVmtlMUplMjV1dlNiZ3liZHdJNzFLNFdQdml5dWZzN0F5?=
 =?utf-8?B?SzZzeHcxSW1wbmNwSDBYeDFQT1lpVTJUc1RvQmVnNktGTjgrZXFUc2xORUo1?=
 =?utf-8?B?RVVpRXArKzdIVTM1WStyN2ZjdmpDUXFNWG9Ea042elA0QlVQMk9GYXFUZmZo?=
 =?utf-8?B?b2hVQlYzMnRMYzBQYy9sSHhSNVVFWnZtOVhvWU5HSmV2dk9YNk9OV2Fpb1Rw?=
 =?utf-8?B?c1BuaTJMMGxkNDRDUE1SUWVFL3BZYWVKVmkwZjRGSUwrVERldnFaY1ovUVlu?=
 =?utf-8?B?WHhOcWsxMkNsek8xWnRhem1OeUo1NjdEN3h0b2JxaGp3SEE0T2g1ZkRybnlt?=
 =?utf-8?B?a3NHVkJqRWxIMHJWaXNLSm9IeTMyUCtjVk5sNFhDVjhpeWZRZnN1YTI3WnhX?=
 =?utf-8?B?b3RmWFh3MWtXWGptOWJwcnp2VEdzVVNYenZ4aUxxZnB3c0lLTlRNK1lyTjRm?=
 =?utf-8?B?bDB1d2FZbW50eFVaejdrcCt3TXM3WEkxc0t6NUdITHAwbFRzTTBNdDdaWFpC?=
 =?utf-8?B?S2t2eHZRMk15NDkyYlU4cWFWNG5TQ1RxYXVzSG4vbzN0TVdRTUJRdXpjZkJ5?=
 =?utf-8?B?MXpVb2JnWHpVSWVpSFRpQTloaUgwakdKeUk4T2VWazBBWWlZWk5mTE53SlFT?=
 =?utf-8?B?MEVjSDBvUnJXTnpoQmlHRWNiVlJuWEF5QnBLa01ZdUd2SlpmY1R3elIwUnNB?=
 =?utf-8?B?K2J2TjdLdGRDMG15RXozekNKdHNBYTRzaGlLR3h3dmpZYjk2S3NyYURjNlZj?=
 =?utf-8?B?bzV4YWZCTmdqVm5Va1BDZURKWFE1SlYrWGtoazBMcmJNM2ZhM3hmb0tWbFV1?=
 =?utf-8?B?N3VpdTZHcXQwNmxoRnB0Q1hJbVJxdmtDWmk3anRaV01VeGk5UGMwU3R3RXh4?=
 =?utf-8?B?bkw1VlcwZHJzM00yNkNyZWMxMkxkTzhSTzM4bFN6R3JIRHU1SHE1bnczZHJ6?=
 =?utf-8?B?WWRrT3RrQXlZMS93N3NzTXpuQTlHMGRBcXRjdW9CeEhLMUVlWGdkRXJOV2Zo?=
 =?utf-8?B?SFdxUFl3UncyenFXbTkzZDZWK0dVaDhNT2U3TVNuSXZhN2RWMm0ySmY3NmVB?=
 =?utf-8?B?WE9aNGxjM3owelZCNFVtaFY1YlBjSHJBdGZ6M1llTGVpSDZQVGtmWnh6eXFy?=
 =?utf-8?B?SWVHL2ROdUhxbysvZC96Z3h2dGRhN0JjMDgxK2IyY2l2R0JFdE9HZllqRTl4?=
 =?utf-8?B?Mmk2SEJCZFFHeUYvMStsTnY4Q3NaaGcyZzNzOGdrMXpUbld2OGdFVGl5YWJr?=
 =?utf-8?B?S2pTQ3pBWDVMeTU4L0lNaUV6ZVRCaDYxdG53dFdaYktlVVVvcG1HSEJXbzZF?=
 =?utf-8?B?VXRlOTI0ckV6aWhqODVaUTJscUVzcURQK0dPSlVEOEhpMjB1OHFXNHk0a1Qx?=
 =?utf-8?B?OU9sMkVWUGZTdTBSQ3N3R1Nobmlpd1lJc3d0OEpPczIyVHhtWFl3ZmE4enZJ?=
 =?utf-8?Q?zje/BARq+gwpi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjJydkZHK2F1N0xiODVwTzdhTXljbUlkc2w4bVQ3RGlmUEM5eFlqdmJ3WWkv?=
 =?utf-8?B?c3hjMTNZSFZ3WElNRmQySXV5bDFlUENKNVhydklvZllSRm81TVd5NVhZck1H?=
 =?utf-8?B?Y2d4K0NUY3FqN2l3RGhycVh0K3ZlUVFKREorNkVrTWw3N3ROWE94SmpFNExr?=
 =?utf-8?B?bEY5T1pXSHJIM2ZDVzdRZ0kyYjhSc0JQUG1MY3Y1ZmlqeGJ2dlNwVnJyMUtp?=
 =?utf-8?B?MjM3T2hhNzkxb1ZxR2J0UmpQekZESDFha3V2SUFmaGJmOE0wVFNhL1NWUnlh?=
 =?utf-8?B?ZDg4WDN2eVorUzFtb2tVRkRaRCtLY2N2SXJwUUZUcHBRaFNudjJGaHlJM2tx?=
 =?utf-8?B?dk9vV1ZGUkdjU0k5Tng3L3NndGRxbE9hZ0VMYkh2TlpVdjhpODNEWkR1RVI5?=
 =?utf-8?B?eUpQZG5JTFJtbHFNRVAyZUdVbmhjQlRML29lWkdzeTJDcmc1SmszTUxUVjEw?=
 =?utf-8?B?TXFOVkIzUzVDOFFqNjRkaURCanYyMkgzRk16R1ZIMndFNWxSU0pycjZUTDhT?=
 =?utf-8?B?a1ZZd0dUWXVvdDNpa3FmTzM3RHYweHZ5N0tyVW9iUGRoMWVjSW93YjhwNVl6?=
 =?utf-8?B?NVFCbGF3WHZwek1GYUZYcVZEajFkZWxlbWY5YmhJTk9vYnF0NXRUQUVrRlNH?=
 =?utf-8?B?VFQwYkJ1Vnh1R3hVWUNXLzI5TGtOSFd5VkJVOGh1MUxsaHpZc2Z3YnEwanBR?=
 =?utf-8?B?QlRvQW9zM0FTeWxtQk0wMW1Vc3g0bFVxSnJKTFhYekwxem8yNktwWEVRcDFz?=
 =?utf-8?B?VEx3QkREODMyQWVISVJIVElyYnc0SGFsaE5rOS90QUlEUXVYNmJzN201ZVVr?=
 =?utf-8?B?aTBaelYzM1lkbmlVZFkrbEROSXBtZkNhVm1Jc2JTeFJOMGszVjBLMExjbmFh?=
 =?utf-8?B?RmJUdTI2OEwxbjR0UmFMVzJhTE0rQzBDaFdLaTVPTyt5cDRSSHlMU0EyQVpK?=
 =?utf-8?B?NlpTN2JrMitPMUdoMUlpbmdUSEQvMGlwSzI4d3BrVk1LS1NoSlBnMHFPckRM?=
 =?utf-8?B?ZnZJN1R3TkpEWWRyM29wVFQvSEZCdzlyaGR1akF4UU5NaklVa2FvM1FUUUx3?=
 =?utf-8?B?TWpsMjd1ZkQyalVWNGdhVGtRaWQyMzQ1MHFPYTZJdVdlTTB5Q250UUE5L0lT?=
 =?utf-8?B?Q0ZIdUxTMUlPd1FWaWFKMDUxdDlHNzl0cWdPL1RzMUNpL3I1ZkdLN0ZVdjc4?=
 =?utf-8?B?SFFXQXQyUzNQV0FYdkRFTVI0Y3BXZUdsWDBOdktwTUZYaWRuSUpKd2h5RkFD?=
 =?utf-8?B?bklsQm9GdktOY3RkSWM3YUk3eVYybTVTRXlSVm5wR1JBSHF2Y1RpUG1HY2tq?=
 =?utf-8?B?eGlia1p0dk1wKzVrd0ZiZUxPbW1HcVoyWEhGSENUWWt6NSt6ZE5MQlRRSjNE?=
 =?utf-8?B?VkJNLzlWSmtTeTdmNXZEbnhNL3FhODg1QmZlNHFDdnN5T1VQREhZVFlPNUtZ?=
 =?utf-8?B?RWh0YUlITWdRR3Y0K2N4bTZzTHlTQnVxTXEvLzFLNndYSUpaL0tTaUpXdmJo?=
 =?utf-8?B?KzBDdldxeVdyVlF5ZGhOeHgrN1hONld4dEl2RlBYakl4RlN0V0t1T0VhODFD?=
 =?utf-8?B?RVp0WnZmY0NCcmd1NWpXN284VG1qK2EzYjRJT0xnME0rZUh2NFZzZktiM2c4?=
 =?utf-8?B?UFB2SUhqaU91Z0twQjg4RjZjeFJkR0JMOVJUaWhPVmNDM3dJcDBWT0RYS1F6?=
 =?utf-8?B?R3pvUkZyRU93YVUzRE51N0EzL0oySXE4VGVra1pZOUxwVmpkSGpIN3pHeXor?=
 =?utf-8?B?TDZiM2JSMk9sZktpYitMMlgvaHcvcVUyL295OXlxZzh3dmN6UUkyTnNDbUNy?=
 =?utf-8?B?WnVwT0srcHpRWUtBSElnYW10M2MzNWhvaGVJOUVKVU16OWZQbENxK0Y2U3V4?=
 =?utf-8?B?V3BLeHJhOGZvdUE4bWNpT2dLNHU5NWwxRU9RQlJQYkpjZXlkZ2Z4Y3VVSmxY?=
 =?utf-8?B?ZTRoSlFMcXB4aXkxTjF5c2ZTNGZwcGlxN0l4MzVVNTZ3Y0tDZ3J5cGIxQ3FC?=
 =?utf-8?B?cFZac1hSZUVkLzAwMUdyV1NOVHc4OGNaM0xLcWF1MW1jZ21BcHVVdldHTEpr?=
 =?utf-8?B?MkV1NHhRVG1qMHo5RGxxR2M4Y1J1MTNvK0RQQzRXSVJvYXB6c2hKeU5rYXFW?=
 =?utf-8?Q?wbHN5mm9c9dpX7WO/HuIvPGyO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0f20ff-b3d5-4acd-0273-08dd57d49a85
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:47:59.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNNAdM2vnk/T3iPAiA3IEXgBw0s6gn1bpNBtmT+kx9GdXhjqtbwYgIwSh12P/ff4dOolmeK7Ac9Qmn7eX/Jyig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246

Hi Yi,


On 2/28/2025 2:17 PM, Yi Liu wrote:
> On 2025/2/28 16:30, Vasant Hegde wrote:
>> Hi Yi,
>>
>>
>> On 2/28/2025 1:13 PM, Yi Liu wrote:
>>> On 2025/2/28 14:32, Tian, Kevin wrote:
>>>>> From: Vasant Hegde <vasant.hegde@amd.com>
>>>>> Sent: Thursday, February 27, 2025 11:28 PM
>>>>>
>>>>> Hi Kevin,
>>>>>
>>>>>
>>>>> On 2/26/2025 12:35 PM, Tian, Kevin wrote:
>>>>>>> From: Tian, Kevin
>>>>>>> Sent: Wednesday, February 26, 2025 10:51 AM
>>>>>>>
>>>>>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>>>>>> Sent: Wednesday, February 26, 2025 9:18 AM
>>>>>>>>
>>>>>>>> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
>>>>>>>>> If above understanding is true, my preference is to support a sats flag
>>>>>>>>> in domain alloc (nested_parent only and PCI/CXL.io only, as the start).
>>>>> For
>>>>>>>>> AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
>>>>>>>>> structure is created and updated according to the map/unmap calls
>>>>>>>>> on the parent S2.
>>>>>>>>
>>>>>>>> They are functionally different things, and have different
>>>>>>>> requirements on the PCI topologies supported (eg CXL.cache vs no
>>>>>>>> CXL.cache)
>>>>>>>>
>>>>>>>> I think they need to be different flags
>>>>>>>>
>>>>>>>
>>>>>>> Not exactly. They are functionally different but serving the same purpose
>>>>>>> to the user. From user p.o.v. it's sufficient to have a general flag for
>>>>>>> sats
>>>>>>> when allocating a domain. The underlying driver decides whether such
>>>>>>> flag is supported based on the domain type and the associated device,
>>>>>>> just like checks on other existing flags.
>>>>>>>
>>>>>>
>>>>>> Chatted with Yi offline. Having untrusted user control a security
>>>>>> feature doesn't make much sense. Probably what we really require
>>>>>> is:
>>>>>>
>>>>>> - IOMMU core exposes a separate sats knob per probed device,
>>>>>>     allowing the administrator to manage the sats policy which could
>>>>>>     be no ats, unsecure ats and secure ats (might be further set per
>>>>>>     domain type in case the hw doesn't support sats for all types or
>>>>>>     the driver doesn't support all hw-supported types in one batch).
>>>>>
>>>>> When you say "sats knob", you mean sysfs interface?
>>>>
>>>> yes
>>>
>>> in case this is the direction. This might be a per iommu_group knob. do we
>>
>>
>>> want a default value per some info that can be probed by kernel?
>>
>> I prefer kernel probe/setting default values so that we can enforce HW
>> restrictions (like SNP, untrusted device etc) and then....
> 
> I got untrusted device. How is SNP probed? Is there any bit for it?

Yes. There is a IOMMU feature bit. see iommu_snp_enable().

-Vasant

