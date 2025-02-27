Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3646861FF2
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620712; cv=fail; b=u4CvBEChdhDyz4Gq46LiHz9buW9o+EFxJUMDUzLSYNuezG2IZGmliLxoDRozKpToVDmMVOLL8kTjBgeKm+isw2Ueu83Lp2RLUCcLCE3AKK8Z4sa8QUK2tNK9rZDMAmvHCmN3tmdNM3bfQTcUXc4pgXGI8/306K9mndgR4CUufuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620712; c=relaxed/simple;
	bh=m33TKLJtmAWq9COddrmCwjn5er3vPZWqiX7eWTcLeao=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DmS3fWqgqYz+1j7YTA0QJgzagXWYygQuLPMRJz6cwi5XF8CaN7FhD/m3e7B+lFyX3zLqXUlidLudW7339sF4nOUGEo7ajPkisFXaciX5GH+f9bk6AIfEAS5JNSoMGRaOisj3/znegSOZB+QcBkD7wF7snYOdljlkCshXS5Dlpno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nvcYBtY+; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nvcYBtY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740620710; x=1772156710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m33TKLJtmAWq9COddrmCwjn5er3vPZWqiX7eWTcLeao=;
  b=nvcYBtY+2Dimmr2b/10CL0nJkguOkn2wx27RGZn4Bp2+dg6lKnZCohgB
   hv/gT0ZdY4N4eXGi86zYgdN3+RLp0K4b4XMltnAMWA/ukqKr39OsJqkSX
   hDkuo/GFfNfe3jp2IFq+zuW/XJqmc9xaogCcLyySTl+9sXd7N9FURqXOX
   Y/+vBKKSbnYlFrS0RXebzkTUxFvT086yjuw7JlbY7S7k5RUVUljlc6iXr
   QGG5qPDsYE5MUMuVH0RJCl5qa9oU+fRXcFVGs6CUgfZDSS4weffg3UaB3
   lQ7ofuJhUVyEftdirqAkcWx+o+LLkRbaHa8OfjkjJ/v2avdm4YJQDbm/F
   A==;
X-CSE-ConnectionGUID: qYnHngRcQy+Iqn0tw2nfkg==
X-CSE-MsgGUID: 64a+k9YTS7SrCbSzZYwNrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40734596"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="40734596"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:45:08 -0800
X-CSE-ConnectionGUID: cAesYexFQcKon56fRvGQ3g==
X-CSE-MsgGUID: 4SlIfu+hT3yNsdMI8iSy6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="147703588"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:45:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 17:45:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 26 Feb 2025 17:45:08 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 17:45:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ju/AyLf0+kP7h2TNQxGd++PgGfkmjNTk+PtXgSzX5G9BPC2jgovhSSR8G9X7X6Oik497SylLFDNRfFb2LMLz9iMhYteqMufF3KyGfTv79Ns/hflX5AQYnZlEIX6ramxQUS0QDlcdUB9Sj/nLzaHcmjGm5IpWqck1juNAOq/ONl8FXUI4FvvURlAfJVgqNpkNJnNVkjVzwBGBTW0PagFhFExiPr4N4UANU8Q5DOpbJPYYpnUQT9AqgkdmDxBk1Y2bf439b+0OsKrQWF30LSGJLmitwP+DSieWwvEbmj/6k3bRQbqt/oohtccjKNR2sBN3dLeyNv8e7lonEa8OgQoYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6M8ZcCkvrFRqOoavXdSEmmaqUzo9WSSjOTeYVgQ87I=;
 b=LMN65wlGwoanD44BxXCRjagyCm9S69YgMaQ50EPYJtH5V/sHbwyjhmWlfASUOUXKc3Vc/fJyI/J0sPbvStNdpZpSW9wGvzf1LQxP2nnYI6mtLZHtlHTBB4/Us8vZVrUhALQjq3V9k6an9iKoJKCAMiKF3O10msRwX0evSqKQYmLbE5b5SLwoiQzizk0xYUUTkZ8ninT+T7URXhFazgiJHfNVgRzYXZz02QUjy/r0gVVRxDGmPbBbXswtZEjPY2B6nZYuI3kcEJ6lTU/ogYpeR5wFx5KALno/oY2gBc5ucQVO421Uf3YXzHdI3pgiaV1M2lako8bjWPVxOrppsJ0iIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 27 Feb
 2025 01:45:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 01:45:05 +0000
Message-ID: <1cf0cd58-3154-4412-ad39-0dab4b701ba8@intel.com>
Date: Thu, 27 Feb 2025 09:50:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com> <Z7+sQOLeSk5hEcr4@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7+sQOLeSk5hEcr4@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0115.apcprd03.prod.outlook.com
 (2603:1096:4:91::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0d9956-243f-4ca9-648d-08dd56d05bea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjNhY0xyZ1hZYWJ5TzBsemdTYXRWL1hBZStMKzJFV25pTWJjOWoyQmFTdjVR?=
 =?utf-8?B?Zm92MlU4bmVLVDBBN3pucnF1TlZLWGU1QmtWUjZaek1EWFZXZjg2L1YzRlhm?=
 =?utf-8?B?L3VDcDUxVm5yYVdaZGE5ZERJNi9WUnVsWTl2OUx6eVErTnFPVG1oQjhSV2k1?=
 =?utf-8?B?OW52TWRkOXlHT2lLZnYrcWtGL2czeHorWFIweGV0R3d5Ylc5Q2ptclBlQ2s3?=
 =?utf-8?B?REUrWUFMRmxCNDVsaFBERDA4WjNmcnVkVG9JN3lGTU5ubUxQUGhJeENjRVdH?=
 =?utf-8?B?eXgwV0dWeVRuTHRGbTR3OGxFcTlFR3YySzJGOTV2MWgzSEVDRmdtRjMxakZG?=
 =?utf-8?B?MU05cXBaNEpxc1FOWURpUDlJaWhKanNyUytpOVREdVJ2MDhYZ2hQc1BQSDZY?=
 =?utf-8?B?YUdZeW1yOUo1Kyt2T0c0K2ZaRmljV01Mcm9IamVMNTE3S1QyWXpNQktDWkN3?=
 =?utf-8?B?ZjM4azRSSmJIVlprd1JEKzBEYjZNWVUxNjc4MEJDeWl0WXhaZCsrUVBzWDli?=
 =?utf-8?B?K3BLSlkyK3pjRVZTWjVXYzNXWm5lb0VkMDhYT24zN0Nwc1lKNmNKMkt2VG9H?=
 =?utf-8?B?czdhbnNRK1h0L3owOEIyV1lVanpuOCtSNUNTc0NVb1BRWTRrVWdTRzN4UGs4?=
 =?utf-8?B?dXpkWFlwVmpMNm91eHMyY04vZm5HQk5pRGpYdGFTSTk1UGI5akQvVkZtQWJD?=
 =?utf-8?B?djcyWXNwQ1FKMTRnakVmZW9WZDRZSlNtdHk4bitGV3NWMHVNNG55ZHdyNzFR?=
 =?utf-8?B?MTVDSmtVbHcwUks4UThiWVAzcUNPelZlS3dVU1ZRSmE1YkUzd0lsTnkvbU8w?=
 =?utf-8?B?MUNXSms4Q1Q3R3BNMFNiUWRmOUJJNm1BeUlUd0p1amMvVFhjeHdZS1pRMThC?=
 =?utf-8?B?NjRPaElmdmhmYXhoemZLbHFmbE9rbjRtald6dndPTi9TMUlMcUpNRTVjMDdo?=
 =?utf-8?B?aTJvbHJ2YzY3ZWp6Vi9IVGJ1Y1lUTzFsQ045alA1VmdLMFpwYml2VUpDc2Zs?=
 =?utf-8?B?MWZ3bFVjTXo5Y204dnp5b1RGRWZ6eE9SaEVGUTc5YjQ3YzlSMWlIbHFyaVVp?=
 =?utf-8?B?WGx4Y1BHbnR1RmlIVU1wVGdHRXM5UkYrSXBxTzVrNUxmN3ZYTFNWNXZzMHM5?=
 =?utf-8?B?ekxOc1k3UUgraXVLNTRPdS9yMkdFSEk5bVJQUVBUMEpuZ0pXdTdFamZBUDY3?=
 =?utf-8?B?VndwNHl1dlhsempMNjJkZHp2bjQ5TStCQ2VELzJVZXZqbjhjNU9CMWFaWmFh?=
 =?utf-8?B?RjE1RHhWRlc1OSsyak9ka3dJSmdJMEJTL1RCREFFWXRTV1d5TGlhMFZoSWJK?=
 =?utf-8?B?RFlGOXdXdU44ay9mWk10cUtCNGdubTBlREhDdFE4WHQzUXhjK0MwTUsxV3g1?=
 =?utf-8?B?OUdsZHQxZFJuSWY1cjFVZHorTC84cENuVWppUkdjbHpZdEkrRGhDQSsybmx3?=
 =?utf-8?B?UmRYME9qMUE5YXh5cVBJalROQnhCSUxNT0NpM21tTjhCZml0bVVkeXdkUS8z?=
 =?utf-8?B?OFNScm81N05iYmRkVG9sTWNFakhIbm1CMGdib2I5aWl0MzRQdW5iS2JrSzZZ?=
 =?utf-8?B?bkNsa0FEUk8vYUNTTnVqVUptNkRNQnBQV0lwbjBad3l3b1l6dmpGMCtkQjFx?=
 =?utf-8?B?bkVBYmwxRmJpeVY3d3NUTUVpeEhmWGE4a1NiclhnWEtBVDZkR0ZpSlBRVE13?=
 =?utf-8?B?c0F6WXIvRGdvbmRSVHNLT01HUzFKeGdVaVBJeXZZcU5tZDZ6MDFNeE5uS01C?=
 =?utf-8?B?Y1h4enphNlhTWXlFZUcwNzZpMEdvbWQrbU4rU2tkWjdSRCtqbnJKZWU5a3oy?=
 =?utf-8?B?TzdrSTBseCtGTXJ6c3pvbTZmVjRHMGVhdy9JOEQzMUxMRUREOFpEYjQ4Qm1B?=
 =?utf-8?Q?fLYPmePZygTXL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWxOU2FrTWtmNUZ2UEsrRlEzNFgzODkwaDhaUVVKUzR4VEZnN0VvS1VMTDVH?=
 =?utf-8?B?MWZuTVR3N3E4dTlxVTg4YjBVb1h6ZEZlRk1QUW9ScWxuM3ByTStNNG9yUXBk?=
 =?utf-8?B?TTdyQ1N0SVpSbklvTWNZNDcySjJ6UVNwZmY0bDc1ZEJQSGtvbDRYMVlWWXJv?=
 =?utf-8?B?eG0rd1gwdW55My95b25vSHFjODBKOU9aZVVDaDIzejIrWSt4Nkt3OEZXSEJC?=
 =?utf-8?B?L3BHWDl5QmxQck85a0NiajFHS1RFZ2cycndXZE1sRjBORXRvVzQwYkx0dys5?=
 =?utf-8?B?N3pNdHFRVXZ2ZlVhR0RhUXptaUtSSURUdVVMcVlpcytHUWdURVR6cGNjS2dq?=
 =?utf-8?B?OHdqd3REaVMrR3d5SjdsN3o3Q2wxWnRRKzhmQmVQTU1Ccmw4MEhSWmRFcTNJ?=
 =?utf-8?B?MEFOR1h6cFZEOU8rMDlRRHpGTGFDb0RlUUorL1dvWS9ncWtZVS9pUTRkaU9B?=
 =?utf-8?B?ZzdUeTZwSG5kSythNzVLYXRMTFZVTkJ1TDRJbkRuTDhvaS9TakI2S2Z0ZURP?=
 =?utf-8?B?bjM1SWErdVFrQXBsNGNudFk4SXF1WWlIZnBtYk5naldjd1QzMStIbzJJN2RM?=
 =?utf-8?B?Uk5zRk5lZmxpem9SRWQwSjlscGlNSjNaVTlHTDBnUDF2bzB3SnRJdzQ1K2lE?=
 =?utf-8?B?Qk94dTRObElmQWxYRDk0em55YnppYTB5d25HM3h4Mm9uZlpRSGszdDNmWEpC?=
 =?utf-8?B?NXVRQTY2dk42ODVpaUZxSnk5ZFFFcHppS0RwaGp2VnYrQ1JkSTVObG01dTcr?=
 =?utf-8?B?UnJ1UGNqV1lGSlgyWG00cFVrUDZYSGFnelo3aGhjc1d0NU1BNERneFdya2tm?=
 =?utf-8?B?Z2FGbEl0VWEvZkJyVjBUcHVIVjBBSjYwcmo5ckUwUWJ6OXRqNlJYL1VxTGpj?=
 =?utf-8?B?YjFTNGxzb3V6VXBGTE0ycTNLTGgyemNIR29FV1VTWExmc0JTOUl6b282YlJh?=
 =?utf-8?B?L0tnc3JJUGFuVmZUWHU4RHpybDBwOEZ0US9keDhmUXI1LzN3cFZNRlFkL1lG?=
 =?utf-8?B?THZUV0NTQXA3aXZjQWZQeGd3aGV4RFBhcUpTTXBEaGJHVlJ6WkJzS2JFOEth?=
 =?utf-8?B?TXNsKy9iVUNuM283eTd4dXozaUtqUEdYMGhoWW5PekRhdHAvTm1XUUlHelFD?=
 =?utf-8?B?R1RwZjVoL2dROEQ2UUtKdzYyZzRiaE51QjBzRWZqQ0JlL2tUOVVmamJjRnhR?=
 =?utf-8?B?VlpQSUhGWXFDZzlkZFJUUndHZkMvdjVUbitlUlhuM0JDSFVwNjViTW16RUtB?=
 =?utf-8?B?UHVaV0dRMHpNQVl2emRITnluYmRseWhFcTA2eUsydWxqa2VGUU5SenZJUmdq?=
 =?utf-8?B?UExrTVcrc2FxR01uS1VGS2ZabkhaRzRUNDZaeTVTUi9GNHJnbDNJK0pGNGRv?=
 =?utf-8?B?di9JZGZSUVJrOG5Za1BreGUwa1d0bUFsYytIM0RVcVJvb1N0dVV5amRqdXNB?=
 =?utf-8?B?Q0RzK0JGUCtkNUZyamxneFpJQmhqYk96akxwVHhOL29vcmUya01VR1hkanYy?=
 =?utf-8?B?aUlrbE1QU1BJbGJZV1E5bFl2YUZDTHhDQ2pHVVc5dzB4aTNBeHZ4V1EyQ0sw?=
 =?utf-8?B?WUMrUG5sSmVEZ3gyWDQ2S2hZYWNjakJyL29UWUUwcGs3UjV2b1g4bURWajY2?=
 =?utf-8?B?akJjODZ3VFdSZDZleGxBcEFzMWFLNzZueHUrZW16NHREaGRpYk8rQ3dvd3VT?=
 =?utf-8?B?c1loZU5oQkJiNDNSMElYRHNpSFZ1V1k4SXdwTU5tcEQ3VkVJUmsrK0wvVk5U?=
 =?utf-8?B?L0JBSWRXN0UvNEE0cmZYV1JCTmcrQllhTzUrWGd2VjNaNjV6QnJ3ZkpXL1dC?=
 =?utf-8?B?a1Vva0Z5NGhTYnl4Qmh1OVVQTzBLT3R0NHptZVpWVHU1cnVEUmdsRnNJNzFq?=
 =?utf-8?B?WUxSUWxWenN2eHN1Uk52QStjS1RKZWpqS0FKNW9oeTlxc2xtVkw4cU9CdUts?=
 =?utf-8?B?ejV1dnF1eTNnZUIxVHZORy9oK1JpTWh5WE9JTUg5VmZPUXE3YlpHM09GMlc1?=
 =?utf-8?B?ZUJCVys2OE9pM1RQczJTV2FzMjdHRTlvOTlwVjU1UCtXcGh2bkkySVdmbFNP?=
 =?utf-8?B?WXM3bUdseG51cndLaEhkOGZpQkJmbC9ZLzZ5Z3orOEYxQnB5K211bXpGc09G?=
 =?utf-8?Q?GO0cRQ9X9PXM7+9qtLuVwYESe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0d9956-243f-4ca9-648d-08dd56d05bea
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 01:45:05.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMaHRZSqvdsb8Nsmyg0IXWnDr0Z/qYhDa1DNPt6P9BDmrpPamwsRGtuLou3XRgLVmtrOyI8HCvKrT/txttB+fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com

On 2025/2/27 08:05, Nicolin Chen wrote:
> On Wed, Feb 26, 2025 at 03:40:24AM -0800, Yi Liu wrote:
>> As the pasid is passed through the attach/replace/detach helpers, it is
>> necessary to ensure only the non-pasid path adds reserved_iova.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/device.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index 6ec7f6935115..72f6195e32f2 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -471,6 +471,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>   				ioasid_t pasid)
>>   {
>>   	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
>> +	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);
> 
> "hwpt_paging && pasid == IOMMU_NO_PASID" is already good?
> 
> "attach_resv" sounds better to me.

got it.

>> @@ -620,7 +622,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>>   		goto err_unresv;
>>   
>>   	old_hwpt_paging = find_hwpt_paging(old_hwpt);
>> -	if (old_hwpt_paging &&
>> +	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
>>   	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
>>   		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
> 
> I am a bit unclear about the use case with pasid and replace. If
> we replace the old_hwpt_paging with pasid != IOMMU_NO_PASID, what
> would happen those reserved iova on the old_hwpt_paging?
> 
> Or does that mean a device can multi-attach to one hwpt_paging via
> different pasids so that only down the IOMMU_NO_PASID path would
> it remove the reserved iova?

yes, and only the IOMMU_NO_PASID path adds it. So only this path removes
it when the old_hwpt_paging is replaced or detached.

-- 
Regards,
Yi Liu
