Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510423;
	b=oc4x94n9qvI5yiy0zozW90botgGyF0mwDkJeWAK8zpLQ2oHthA/6Ar0OM2S3LYy47U0r
	 jVIYjaPi/ty0PXmhjJrpNi8fSyB6Pexm7X2CRoOEcWEtXzBhzU6eo5yWbV/BToevPX/Ua
	 v8QGX9JaQyv7EkQQhR97Ox4E0zlutY1YyT2/+8P31Nw43BES/NeNT4k3AUFN16/QBw77o
	 r0H3JLBywJIWmW+XBlROUs0VSOhjLC2dodBW5yi5sjFsT0ZZPxuVG5f9R1EADEptVFEnf
	 SmMdvPogGaOSrtazIKswzVprig2W91l0GHnHkwUqH6BQxXx/EqYM6lFmSzI6WuqKWSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510423;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=BTho0pz7Y7Lq5FFLrr0o7VuRMThghi9t2f8F2T3ovss=;
	b=EzyI1kuSsHxY9/wkbtUL+zYMRiUkajNycq8vpn235oB5jFOl7KyDz7jybfJVw9KmFJY/
	 j+gJyLMogceSpZVSmJBj3PKYk3NvoF2KlIpB3pjWlLS8b0posLmZ3O8EyjDvzbwVlo+Gs
	 iqVBtGT2Wfy40MXi1lS19LbInheP/gblUk1xtfsBV5iF/6KqT+XxTGEqDfb/7hInpijMj
	 5r5kMnesTxCJwuvgUbadWpVZicZL9CmFzN5nHSrGC3hnrLwxd3IlKhyef3cRxcGJcrSy0
	 71f0BpRQP12zyYMIJu1pkRWWvGGv+HL4E27pyzG9IXFjqcGZg1PSckg5gD6Zc2leNNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="i12k/Rvg";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.45
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418A606A332
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 08:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6418A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=i12k/Rvg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWsjoeoQoMxxdNY3spzsdAUndIHcQH83JtYBVzcX6tz+ITyccd//pRSUkN+XpohEcTmmqorNovppwDHHRI3TXmtaK7ox9E3bm/oU7qVsLIIq4KiQpvwsr1tZzwMIuEbtNqglrThUti6NJr6OTDI6yO4CK2W21C3t7xQ9z5G23BtsEXtv9F2G6tQ0WV0i22Q5c8uccLwEaNhY8WmySJleIgMFHreFdVOm5GMFuQpvVBe69CCqSJtleQfYudgYEdk0AbMQ9yXAi0sdYYigaSGQK1yjDYgtfpX2bFmFLzYgtv5Kkj6eLsbqeta+qszZ7+NsS537Xzmy6eIXqh6eFOo98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTho0pz7Y7Lq5FFLrr0o7VuRMThghi9t2f8F2T3ovss=;
 b=U3xKGQD4V2LPq4AE/yCGWKyAhsPj8hgEOTrgdZuRs5XB+weAi8QjYVxkJM33s2pC7QSjJCKwB3MB3cvnTF9NYgcJAk0g9clMrDqIP0HoOUNjHJZHJuVJeNJdb+xazTt/Ii3sXe48HjLJYjdrRNJyC15qyvmViJGBNvD04nuCiqp90B0j2mBg03oMft0atjex8C2e+27up13WWksPxpEiJ4/p3pSzCxmxcyDX6/ZV3GHK9PGiGjr0BnHziDxDLsA22Q2ZZhwk6fU9+4fLh8Teg8PP7sbFHCkfjwwbcro0Htv/9+74vxDBa8D1TBEsaOIvgPoYr67a8bw5sY3Vy+uRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTho0pz7Y7Lq5FFLrr0o7VuRMThghi9t2f8F2T3ovss=;
 b=i12k/RvgGOv4kEi7SVujtMW22r5sxK/9FcmecZOB1m2O5Uzr1Ip5jIDhEkIMjGGxZcZssKaC4h7jxYRr/J88C9DtBbEstlH3qF7erBO1BDEJTGkUxZbuQKB0cSEDOBmTyW/t4GJmG16erUlD6vyTbjUhWfXLQss41tx9KI3qtac=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA3PR12MB196577.namprd12.prod.outlook.com (2603:10b6:806:533::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:53:40 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 08:53:40 +0000
Message-ID: <ecc47f2f-d0ff-4aa5-9d46-6a0b9ed8c468@amd.com>
Date: Tue, 24 Nov 2026 14:23:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/io-pgfault: reject partial faults after device
 removal
To: Baolu Lu <baolu.lu@linux.intel.com>, Qihang <q.h.hack.winter@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
 <56be2b4e-aefb-413b-8f72-0bea1f9e96db@linux.intel.com>
 <CAH78GvuUtU=zhe-Qbn9k73D3U5n1Ye1=8wtQqR7vCEpDzgNUJg@mail.gmail.com>
 <aceb9e9f-7ba3-48e2-8945-95179f22581d@linux.intel.com>
 <CAH78Gvubo20uU4ntOxzd-+B6GHpUovL_wYQt9yahF-8=x3sEVA@mail.gmail.com>
 <4420a997-82e9-43e6-8ceb-5ede44594c51@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <4420a997-82e9-43e6-8ceb-5ede44594c51@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA3PR12MB196577:EE_
X-MS-Office365-Filtering-Correlation-Id: be84fc63-3715-493b-2730-08df4a086f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|4143699003|11063799006|56012099006|261026140227099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|261009221227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vhf8+5aUNkiZ+7jAutfh/OMwD/8/SddtZ39CML8hY6pEBp49Mn88E0SnqQIXr9xIuUshDpxMD7zmQoDdKQnGiI4TxHe83ZEzXfbQZ952V3VEL6gdJ2neOxrtpqHYaiftMfqDrBpf9+/tI9PnAU5woKtUB64e58C4GtYotmpeo0+oH4oJgpXm5IzdvnVMNc0WSPNKLpR+gsuxZGxQ1YqGR5CDNqEYAYyIPdEh8CkjDXerp8qaz+VMzeaTXrzz3pSX3P5i5JKtJFg5E9qACkMiVi5jc8jpJSrNHHv0AhmaM3szGbV0exzuDQrufzkqfAzPRVbPgVrPkk8M0IQN6Zs9nx4FdVBH0wtZ5Dz6aNiHFKrzYLEJAGo1RoC9G5Uu/4r25twUAVdXzptDSEd8p6BRpDgB6GHVtSPubuvJStuMs/l8Y8DADBqeji6T5/b+3PFtND0HdsborMPbDg2Ye9IWQ/XugC1qGDA4mNQcJ7DACl4AXV+PrZOlAN8wVwUj0aDf2FI7O6in96Jn3kTCyKYnMcpPfilOie9zsRFhbk+ymdjWOqCHSfHuKPtBGqcogRkeLplpNPL1KRxhc33BR7Ro7ZFAyfZAga6aR8U7VqcvZWKJjfh3iIQb7aG8Y67N74f1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261009221227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJGMnFxeks1YUFFcnpCVTF5eTM5RHhyR3FSQ1hSa1dSZ0QwTDhrSWIza1Fa?=
 =?utf-8?B?SEtObnlqT3lLTkMwT2dJblJEcitiVkVIR3dOdVB2S2FLdEwvNnlSMXZPRzcr?=
 =?utf-8?B?a096KzZkeTdxdzNjcjQrLzYrRmdHc0taTnNkZGxFZ3ZGZFRZNDFjQ1QrbUtV?=
 =?utf-8?B?YW54SmwxN045NGYra2h0ZlZ5bnJ0S1J5ZWg4UWxqb1NjdmlYenlrVVM2MEM2?=
 =?utf-8?B?QlhwVllwQmtoN1ozNGswemowckt2ZzNvZVJHM1FWM1dZRVY1REEvUGlnelhN?=
 =?utf-8?B?cTFhUm01SHQ4MUtWbkFLUTduNGhwMWNDdDdoOWVsK3hOWWpaQXBJMXE1eXhw?=
 =?utf-8?B?QmVFbEVGV0VsY2RzZ1E2dnhvMHErUTFRMW5NWUhVVFd3NWhnYTVxeHNDVEl1?=
 =?utf-8?B?SXBqNHJKUTNqOHBlcERtaFBXQ09HMDNqRzk1aGUzYzVLR2V6NVdsVDduWUty?=
 =?utf-8?B?RTl3STZLSnI4YUZEamJPWEtRTTZmK2x6MUtLdWowR0lEaTl4MTQ4QTN0TzM5?=
 =?utf-8?B?L0wyYmducXE2V3pIYytzK25FellxdUNRaVJNaFRrdE1VdGNBREdnZi8vOWJC?=
 =?utf-8?B?bE1jRFBRY3BxN0dvOGpBTkhOYUxTVEpnVHVLVzdySDljRzE2aGh5NkFYYUZj?=
 =?utf-8?B?cU1yZTMyMkFqQUNYeGhQOHVzZVFUSEV5bDM0MVJaeWdmODdaUWRNbUR1TUo4?=
 =?utf-8?B?d2tOVktDSFFJblV0WStJN3BWbFl5T2FmU0g5YURLMXQ3dlRwNTdiTlNZUk1E?=
 =?utf-8?B?VzdJemVzTng0YWI4QXlBSGhNUzA1eUhxU1RIcG1uS1ROdzg2VzR5a0J6eHdh?=
 =?utf-8?B?dkMzcEZvdmVieTltdDVtdVl5SXZvdWxjTXV1dkZ0bDVERU5ybDl6czZieXFN?=
 =?utf-8?B?YURiSnNuZzRUUFI1NWlMZlJNYitVNkRFMHpPNS9mSmhKRzNkaHhNb3FiblBG?=
 =?utf-8?B?QlFvUjI5TktBdjczRGYyNUtvZm9pWHQrREd1MzV4akkza09IZDRzRkJOZ3V4?=
 =?utf-8?B?Yk1JMHBZL2NEeGtranBkZHg1S2RaRk5UZ1YzUk1NcjJteGV4dDZpOHpyWjJZ?=
 =?utf-8?B?MHBIK0ErS1JlVENlZ29iRm41THJZYU83VGFmRVVNVkVoUjdSMWdjN2NJZ09r?=
 =?utf-8?B?TVVyU3FFOFpmM0kwd2RuNGx0OWRzL2JsVTIvMHNIUFdVaGhFWXI2bCtXSXRv?=
 =?utf-8?B?UVhEM1ZPczFBbWtWZU5aQmU3c2hvUW9QVnBRK3NJYmlVUDBGNjFYN21FU24w?=
 =?utf-8?B?L3Nmd25USDlFOEZIWitWRXd1OHJxMEQzcTUrSmhHQnJwVWNIMmxUb3dBak1J?=
 =?utf-8?B?K0dick0wbVdDemFoY1ZpVXo5ZEl5aVR2eWNBd2o0WEp1YjBydGdYc2Y0YTFL?=
 =?utf-8?B?aEY2RVVNdTBISDRGQXREK1FzNWlWSHBydk5BWFZteGRLNDc3YVFFc2RHM1F1?=
 =?utf-8?B?R2l6bEtMWnFEVHYvNGI1VXNQb3VQdkFBclZtSHBtdC9KQWgyT3RKRmlwbGt0?=
 =?utf-8?B?cGJpdko1UTVxYjBLb0NveUxQZUZqN2JBSzVxUGUxREFZT1g3UWp5VnFrU3d1?=
 =?utf-8?B?ZnFRZEtkNFhBeDBuSURrNnQ4TUtrc2tXSkg1Q3JTZjZVaEkwMWpKNlRaZmJ6?=
 =?utf-8?B?VUVQSGNnVnRudTlOc3AyMXdTSnlZc2FyY3NLYklZVXljQ1FFZ2lyOHc5dmV3?=
 =?utf-8?B?NzRZVDl2QVcwVWxTVVN5NUZab1pIMi9QUkloNVRIdGlPNi93OFBLYUtpZ2sr?=
 =?utf-8?B?QW94MEcwR1RYaEd4TXN6cXFJL01kSUY3QmRsTmNVaGdMUWNzOWJ4blp5Ylhl?=
 =?utf-8?B?RUNPNjNYbThSUkRyK0dCUWM5eXJwaEFDUE9GT2xzWGFoZmN5NXVLVFNxMVZW?=
 =?utf-8?B?ZjBlRjlodUNPa1JQZCt1U2J0MzF5eWk1ZFFZQ211S01kOUpmOXJUdksyWXVD?=
 =?utf-8?B?RGZaVXU1dFd5c0o3Q3Q0NkUvTldVVERwOThuKzBNR0h6dktXeVM2ZlVsTWNh?=
 =?utf-8?B?WDVxTWU4WW9kMSttMXpVSFRPb3FZVmdkUzF1aFp4QkE2T1lvVXdmUk55UlBi?=
 =?utf-8?B?cHBTaHE3clhGZkpFNjRUcGl3WnlxeHAyOXI3NEcrdlhCVURnQllvM2dBVmJ6?=
 =?utf-8?B?NHpaTDd2OTdweUNOVTdNdTVlR2VEVnBqN3V4amdGazFoMmRXYlRFREhLVjhY?=
 =?utf-8?B?T3RRcHdQTEhsdXZWNzlUQUpOL3dLQk5mTDYxb21VYVNNYlpnK0pDM1o5WGtz?=
 =?utf-8?B?Sy85U05vdlJ6QXp3SWRYRHcyYmg1d1h5ekozV0diaVRybjh1b1E5aDJpd09l?=
 =?utf-8?B?YkZmMXRwSU4xZFdCcFpXdjc0ZVRZK2U2QVoxS0V1dFIyQXZBNEUxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be84fc63-3715-493b-2730-08df4a086f9d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 08:53:40.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFDRGaRh+u7ZH4D6Zs31srFdvwAa1f5fWOHWE29MxpvZUuR3zBTFB6Qy7u8ODpWXM7622CKzjDGGjDLzknl47A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB196577

On 11/22/2026 1:09 PM, Baolu Lu wrote:
> On 11/21/2026 10:13 AM, Qihang wrote:
>> Hi Baolu,
>>
>> Thanks for confirming the VT-d ordering bug. I'll keep this series
>> withdrawn and won't resend it.
>>
>> I still have one question about AMD. detach_device() calls
>> iopf_queue_flush_dev() just before amd_iommu_iopf_remove_device().
>> That flush only waits on the iopf workqueue, while the PPR IRQ thread
>> runs amd_iommu_poll_ppr_log() and reports the fault through
>> iommu_report_device_fault() directly. What ensures that the thread has
>> finished reporting faults for this device, and cannot report another
>> one, before the device is removed from the IOPF queue?
> 
> + Vasant

Yes. Its a bug in AMD driver. In fact we have bunch of issues in AMD driver.

Below series fixes some of them.

https://lore.kernel.org/linux-iommu/20261105044801.399466-1-vasant.hegde@amd.com/

I have another series which handles draining. I will post it once above series
settles.

-Vasant

