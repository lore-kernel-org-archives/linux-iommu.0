Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5353D69
	for <iommu@lists.linux.dev>; Fri, 16 May 2025 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375579; cv=fail; b=XYcLIYE2H0wylnyedcjERvG2MQs58KK5eIAktAy+OmjK953HFQawDnUhsOXxe4Buy50HjhpmF5KNbdzkjGwJPBwb3VRLtdh+bErKh3xz2xTsdoqun37fbt0Ujo88WCR4Ftnt1Cb9j+C+/7ZIZzDDMYbknU7oMvZhn7atF48QvBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375579; c=relaxed/simple;
	bh=9h4ulqLz8XFOJYmTgeKxFqjuui8nOemZDqGAtL/rZUA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OX4rMLzbHsKHIAC51bLXhn6/vNG22zpQiebRJa+txCT40dR13N2Ox0rXVLfUz1sWpNSiKDrIeTXIUnPLfCegFawu5KEzwFl1zZ3nuIQhWGlpBequqPfAeYxP7dWQO0fEP+Z+7ZL93kVajorGCJUbB38Teo1olCL7/KC1a0xHaQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ThUHybDu; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ThUHybDu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747375576; x=1778911576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9h4ulqLz8XFOJYmTgeKxFqjuui8nOemZDqGAtL/rZUA=;
  b=ThUHybDuhhk8j53f3JdC0BlkHuueJlB4UcAglrU6cbDjUy/SEGPzsgiM
   KYHlnRdSW2YIlPNELgTugvBPoUvC+Tfhjssa1nVqX1jESxAM3Da+xZWVS
   MjOTZH2zp9WkNNmkTss7E2dDbMg/5gg2bAQTyCxtmbmSnV/fkxbypNpXP
   31XbD17ogyDDsC8K6zcijZTbHLLOWHUDjIA5INS10RIt2WgM7i8xSi7Oi
   KCtxIjoh5vPdWvV2jfnjMPanbTKlCj3NnwqEVTky+xmAb1EKJsdsO3SnQ
   qsP+4eSGpxOEd99ZGzq1uATIR3A0yO4K0uyoVApF+rYU7+SVuBB1MGDlE
   g==;
X-CSE-ConnectionGUID: 1ecCv5AeTladTBJO+a7aRw==
X-CSE-MsgGUID: UX+4yCnLQnSg6UfIT4sIvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48588531"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="48588531"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:06:15 -0700
X-CSE-ConnectionGUID: 2CZOOnoZTAuuOyBTVqIcQA==
X-CSE-MsgGUID: 7x2atesFR/yOWs/Vtd9Y2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139480386"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:06:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 15 May 2025 23:06:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 15 May 2025 23:06:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 15 May 2025 23:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAjDOOnh+yOgKyidBw0paEZHmOldBjCpmuaaIB9sHJOGavXx2tzB/m8Owzf0OyeT9Qi7BkOe0M1y+kPcnWC9/aBbawxA/ClCViPKl1aQXix78n0exjzM9tO/+qSaaaDqFdAnnEiHwv/TO9ScfqkSy20BEjW2kXV9GDEDkrMmCMMrSIkq+3XCZzO0EIW9sDSy73dtaV+c6CztKAVH+ZdiDkcIImr6wpfqkEYk1+FxxdtavTyA+GPg80r1h0VZrbP/ODNoiv4hG3ZpRAv1lhiyeE4Fep9IsqkwATqP9/0JbPxxH2pcDffEui6MEjcSsWwE25nk8MYpTtRN55aHEH8SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExyCWDw7rwKt2DqtgdU3P50ZTdvyHQOMzsucT9o88es=;
 b=D1M3zwRgv0hpIe67ohf/FvQ7iTA7ss4uISH6GkQ6MuUFrPWxfzKho7Rn8coHYESuw3t7KGbyhM8t84LjDxX/bEKcIlrdGLC9FLVqKHSueAGRZApMIXtK0ITXyP3RCnoMAGrXCLzal6LPypkgtkGcauqmXEcBAO/AUJA0uCJFsAlxowPkr7a/qxwTmtltvsrTlV+cjdZzZ/IrdT1dBvsqVZTb/9V/qnEetez54GciKjGk0D+Q6trgqOWSdjZ2qSD2pOoy3eTmct9h78LLF7Lu8Ca8wxASutJt+d4P94xO7wAlmdJ+2SWZaUSYTBaQ9fpNNMGYZjc8aK9mbIJZg7u8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5081.namprd11.prod.outlook.com (2603:10b6:806:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 06:05:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8722.021; Fri, 16 May 2025
 06:05:45 +0000
Message-ID: <1826e96b-15bd-472d-b535-c72b58e06561@intel.com>
Date: Fri, 16 May 2025 14:11:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Restore context entry setup order for
 aliased devices
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Aditya Garg <gargaditya08@live.com>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, kobarity <kobarity@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20250514060523.2862195-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250514060523.2862195-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 57d09a0f-1378-4b24-9df3-08dd943fb230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkFqMlV4ZU9hVTBhYXhxVmpyS2ZuWGFvN0J5TCsvenEwcExadE9xelZIVGJi?=
 =?utf-8?B?R3lMU2EwejNIc3hkUHJxVUNCdFQ5RUx1azI4ZDNQMEpVTWVadUFDL3Bmcndm?=
 =?utf-8?B?RUgxM244NFdobVBvajA2UlNrcFk5MExwZmZxY0p5RFdKRTliT0VUUXNxQ2Za?=
 =?utf-8?B?MjdFT1VsSWk0YkVoa2l3YkhLc2ZOZUdxL2NWMUpTblR2LysxdEdDa2RlUG0w?=
 =?utf-8?B?TjhoN25iNjdGTGVieno5cmhuS3kzRjJFSUhPbjhpUVM5R1Y4blRyVWFPZnd2?=
 =?utf-8?B?SHN5dGN3cXVRQjBXWXl5THNGZ0RmRVBwQWlRaXVBRGZOYy9hQXo3QjByYlpC?=
 =?utf-8?B?cTJZSEZTeVovM0tVd3dnM3REbGswK09aZzdRK0Q2S1JNQmwyM3dpZ0ZnMXJP?=
 =?utf-8?B?c3k1TnppQ0ZncTFvL3dFSFU4WWwvYzZyWU9EYnFkcVY4VEw2enlHVHNGZ0xW?=
 =?utf-8?B?b3FGZmNON3E3T2ltNUpzNVZxN1NNVHY4T1JMN1dQYzFpclIrRWxnWjQzRDIv?=
 =?utf-8?B?dzUvOXQzNFl4RDJ1dlJvT1BkY1dLZEEvb0JjNjI5MnJWdm1US2lHUVhVbW1B?=
 =?utf-8?B?bkl6SmZEWHJxTFNLVGZhQ1JpMFB4cHRVTFJhRkEwSHpodFBKZHAyV3RZZ3lC?=
 =?utf-8?B?Tk1uMWJIdm9tUDgveG5JKzhaRElYK3c1N0g1NUhXVzVpT0h0RnQ1WDFkTFRy?=
 =?utf-8?B?S0R6ZG92K0lvQU96NU40c0xwRUtHQjNuUEYvb0ZEdk1XWEtPWlI1dkZ5VjZm?=
 =?utf-8?B?ZWdQbzNINUVGZU9MeU5KRmkzSkd6VG5tU091NzlFemZKeU5BUjZkSzdMb1hh?=
 =?utf-8?B?eHJuSURBb3grUitoUXBjVFZMTmdOd3dCek9zZk5oOTFvdFNmb2IxbTc1enJq?=
 =?utf-8?B?NHhpSWxTek11cXQvS1NTcU5XVzFnekk0dVpIQnNYTTRPbzFieWN6eGtTWGJM?=
 =?utf-8?B?djVqMGdQWHFtUlJJaThDdHRJUXZyY21HQ2UzUEFpZEo0QWozODBJTjlEM1hN?=
 =?utf-8?B?bzk0aGYzT2NnTi90MWM5Tms1aFYvNXg5UFRYUzNKcGtsUEtYdG1nc2lNMDh1?=
 =?utf-8?B?aFR6NzdZS0R3VkpKZzk3RVlTRlJKN0dIN252eDJ6ZzNTWm1VdDR5enpvQitY?=
 =?utf-8?B?VkhTOHBCMWhJK2lIVUgvRFJteFJiWFFJYTFFL0hKVXd3amxMTVZSOUx2M3pU?=
 =?utf-8?B?ZWF4RC8yc05CVUI3bGpneXVUTkJVYUkxakpJbXl4eFZrVkVFR3RWNms0M2xz?=
 =?utf-8?B?cnNQeWRhb2RHa1lFZkwyMTYyOVFWTVlwNG54ajZRVGQ0V0NUTWNZQ015cmtQ?=
 =?utf-8?B?aWM5VkY1Z3VzZVhrVVI5SVJnc3UrMXBwYVBYejJqbmpWdk9zRHdDUjNCM244?=
 =?utf-8?B?eXhRZEN2djJldDd5NFMzRUY2UGU4MytkODRmbVVrcVZPY0p4TGtTRlJHZU5S?=
 =?utf-8?B?TldqY0NmMTgrVWdHNjgrZld6cTM5czJlak9KSS92aUtwSFZhSTNZS1ZhbkFx?=
 =?utf-8?B?WVBIREl0eGJDQUFaaThzUWtubXdPSWpmV0xuNmkxM3FHdkVNbWY4K3UwVzFQ?=
 =?utf-8?B?ZmNjcVl5Ui9LNFh4T24rMElwdS93YXpzTjZZZXhPdjdRQlpOMkZKTldkZW5P?=
 =?utf-8?B?RDdobEtmM3hrYlVrWG9uditpNmJncmh2SS90dW1KVld3VElDMGZ2Y1YrNUFs?=
 =?utf-8?B?M1VqRjhRaEFTTUZJWUFZZ1VZUitURUlKL3BtWHRJU3phN2txK2dsSzdrK2kr?=
 =?utf-8?B?M01ndllDbmpnUHM0WEI4ckZtbU01dytCcXNuelZiNGdxaUVSY0NCdFZpOGh2?=
 =?utf-8?B?UXBPNDlRelhqUWhrT0lJVlBudlZxRmRiNHFKUWFPNEtXWiswWVVVWk16d0pp?=
 =?utf-8?B?ME56L0JNV0FueHpBRUk4d290RXZkY1g1QWNPay9VaCtPMDNlOWVRSWlxUm4y?=
 =?utf-8?Q?G6VMr76lkcc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0FQVzVIWjJGRFVFeU5TZmVNTis5M3ozNDd1cXJmZDZiSWhvemNDYWVSbjd2?=
 =?utf-8?B?MlhDT25LbTBvdzJSV2V5S3ltZWp1QVJhN21WaUFpU2JNZEc4ZVk2OEJ6Z2Na?=
 =?utf-8?B?QmhXeHdNaC9uUnhUaDdMQnA0NTZiazFoRVIvTThHTjNZbkg2Rk1RaVBzZzd4?=
 =?utf-8?B?ZzZ6cW80MDVyVmhsYUNTcnIwZGo2YWxNcGx2akI0RjVZZTFFd1hVRGNQVi9U?=
 =?utf-8?B?djBmNFB6RHJhbWxSdTVvRXNtaVEyeFNsTkI2TGFObnJhVjB2eElVNkVsRjIv?=
 =?utf-8?B?MFpnZU9tSVRPZGovZUpEMVkybWZ3SFJ0ajQ2MC9UWjNjSWNaT2NzWHExaUZF?=
 =?utf-8?B?eG9yZW1Hbm9ibG9HL1FMUHV3d2NPR2hGNnVoZFVLY0lwMSt2K0FqZEcyc08z?=
 =?utf-8?B?VUZtNDFMczJnNXpFNDYrcVJiR2kxSjNrbE1LRDI3em1WYXhjd1dvUC9GbVNE?=
 =?utf-8?B?MlB0S2FhVklRNG4vaHRxVXQ4RGtLZ2Ftd1h3T3U1TTdPUE9MUkVyMG82TXlD?=
 =?utf-8?B?ZklqU3NUQ3FLa2NiYkFMSU03SkJudUF6NTd6NkltWkQrNTl5enBtVjNCdzY5?=
 =?utf-8?B?WjVjN3FTNHZWbEdUUWNSNTFCYzc5VkpsNTloSWhXOTN4MklXdGJ1bmpyUEc1?=
 =?utf-8?B?bFFhblNhWE82bHYxalVGMWE0SFZiNVZWcUpNb2VWMGdyLzRJY2tOM2dCZzRo?=
 =?utf-8?B?dzJkdGxIb25XZkJ1YnhkWmJhbWFqSjZyVitJYTFUcGRkYnBOYldwb2M3QU1I?=
 =?utf-8?B?OGRGanI5bEx0bHRaNDBTeGZqU1lONGtQYlZIUHo3SnlhcU9qMFFiZzNrZXV6?=
 =?utf-8?B?L2lQc0pnL1F2bHlVbjZMTW5CdVhaNnB2YnpqOXNUbHJXUEtKU0c4K0thQnVI?=
 =?utf-8?B?cUtzNnJHQm9NQTltSjZ0L3pwanJsVUQ1TkEzRUFzVkxhM2NwQjVHUEtpUGxi?=
 =?utf-8?B?aVRSUnQ1TnN4dmxpS1hLUjRTS0VrMVZlTENESVRCVjhNbVFrMUxUZm16dmZN?=
 =?utf-8?B?Z2NNWUVGaFpCSENnS3pyekhNWEt1M25tajNuc2ZtdHFUOUVQNFFNeElRQVFt?=
 =?utf-8?B?Q1dCVkRYQkwzMGVCMmZvVW5QZEk2TVZWWlFWQS9vZXhSVDVhbHorUjh1aXVC?=
 =?utf-8?B?NmV2VDVWLzBuOE1NQVJsTzdEcWRhYmxrL0VrMGJGZno2K20wN0xmZFBMdEtX?=
 =?utf-8?B?aldCRTdUOVlXQ0RPNEVONW83Q3hkRCttSGJoNXgxSWFFWWk0RUw1L1B2WGt5?=
 =?utf-8?B?VTJzb1FtcTV0Q2o2MHNFd1BpVzRDd1hOOU1TcksrVmVPRmtWdFFiRFVJSjZx?=
 =?utf-8?B?UGdiSGtMV1FNd3p4K0NudHJ6dDZuVkcyUXovZHhoN1dmb0hoQ1FWaHBwYnh0?=
 =?utf-8?B?WmcwSHNQV0MxN2k0dEVNZU9aTHJWQWRnb2VPdjJKdFFFdjdRWFJKa1B5aXov?=
 =?utf-8?B?SDRrY0ZMV3FNenh4VDNNdHpoNVkvQXlNWTR6L2lsQ3pVa1Z6M1Z4ZWtGcnA1?=
 =?utf-8?B?NHFna3NOQmZOck5jQjRlbC9SRWY5L0U5ekxIdnhha2I2czNuZHpDTm1ycFJp?=
 =?utf-8?B?eC8vbThnSFExWXBBcGFxUTZnVm1WU29MK1NwK3lwNVBsU0JlbHhiZ25DTktG?=
 =?utf-8?B?QkxNRXdCdUZUZkc3TDVRYkVGWnA0M3o5U252WmhEMUxLT3VEVzZiS0xxeWdJ?=
 =?utf-8?B?bXVNQ2xBQmpaR0VGVVRyWDJJSjhBR1ZIN1NaanhNbzBZZDlHdDlDanJqcE84?=
 =?utf-8?B?UXRyVWdHR2xTMUZjbnhQam5kY1h3YmJmc0J4L0praUE3L3ZYM1hJSXdwYU1Z?=
 =?utf-8?B?WXJTS3BMVTdIU2JJc2hZSjhOTmZ2RGpaeVNVWFc5c0c1QzVPelIwRkdxem5R?=
 =?utf-8?B?MkNUOCtPQldnYVdVSjduckR1TitpcVg1cGZUekJ2TURoRDUra01OeTJTc1VO?=
 =?utf-8?B?eHRCZG14enh0NW5pYUs3WUx3eG51VUM3R3EzYlRBWjJvZWw5OHdtRDFFSkUr?=
 =?utf-8?B?NEJPbm5kajhzdHVNclFkSXNZMXRneTVmb0g2U1haVlRUV2E5VGxPVnNtcnFv?=
 =?utf-8?B?WEFoV1Q4WktuZ3VrUDB4SjNrSVdaM0xPNDZWNEIwcUhHaWhDMmc5OXNzTmx4?=
 =?utf-8?Q?nxHusdXPoyyzW4tuEyLrrpdRM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d09a0f-1378-4b24-9df3-08dd943fb230
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 06:05:45.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlnBH3DBoyKHxHFnqTDnAsClNWGiSONt0pb5xnb14umZHps7N3YyHbfkRALq61xBlv99fZJM2TdJIJjK9c67JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5081
X-OriginatorOrg: intel.com

Hi Baolu,

On 2025/5/14 14:05, Lu Baolu wrote:
> Commit 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> changed the context entry setup during domain attachment from a
> set-and-check policy to a clear-and-reset approach. This inadvertently
> introduced a regression affecting PCI aliased devices behind PCIe-to-PCI
> bridges.

I got what the patch does. But just bit confused on the above description.
I didn't see the commit 2031c469f816 mentioned any policy thing on the
context entry setup.  To me, the problem looks to be that the info->domain
is no more accurate to be used for checking if any domain is attached after
the above commit. Maybe I missed something. feel free correct me.

> Specifically, keyboard and touchpad stopped working on several Apple
> Macbooks with below messages:
> 
>   kernel: platform pxa2xx-spi.3: Adding to iommu group 20
>   kernel: input: Apple SPI Keyboard as
>   /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/input/input0
>   kernel: DMAR: DRHD: handling fault status reg 3
>   kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>   0xffffa000 [fault reason 0x06] PTE Read access is not set
>   kernel: DMAR: DRHD: handling fault status reg 3
>   kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>   0xffffa000 [fault reason 0x06] PTE Read access is not set
>   kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
>   kernel: DMAR: DRHD: handling fault status reg 3
>   kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr
>   0xffffa000 [fault reason 0x06] PTE Read access is not set
>   kernel: DMAR: DRHD: handling fault status reg 3
>   kernel: applespi spi-APP000D:00: Error writing to device: 01 0e 00 00
> 
> Fix this by restoring the previous context setup order.
> 
> Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
> Closes: https://lore.kernel.org/all/4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c  | 11 +++++++++++
>   drivers/iommu/intel/iommu.h  |  1 +
>   drivers/iommu/intel/nested.c |  4 ++--
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 49530d5d8c85..7aa3932251b2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1809,6 +1809,7 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>   		return ret;
>   
>   	info->domain = domain;
> +	info->domain_attached = true;
>   	spin_lock_irqsave(&domain->lock, flags);
>   	list_add(&info->link, &domain->devices);
>   	spin_unlock_irqrestore(&domain->lock, flags);
> @@ -3206,6 +3207,10 @@ void device_block_translation(struct device *dev)
>   	struct intel_iommu *iommu = info->iommu;
>   	unsigned long flags;
>   
> +	/* Device in DMA blocking state. Noting to do. */
> +	if (!info->domain_attached)
> +		return;
> +
>   	if (info->domain)
>   		cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
>   
> @@ -3217,6 +3222,9 @@ void device_block_translation(struct device *dev)
>   			domain_context_clear(info);
>   	}
>   
> +	/* Device now in DMA blocking state. */
> +	info->domain_attached = false;
> +
>   	if (!info->domain)
>   		return;
>   
> @@ -4302,6 +4310,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
>   	else
>   		ret = device_setup_pass_through(dev);
>   
> +	if (!ret)
> +		info->domain_attached = true;
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index cbfb8bb4c94a..3ddbcc603de2 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -774,6 +774,7 @@ struct device_domain_info {
>   	u8 ats_supported:1;
>   	u8 ats_enabled:1;
>   	u8 dtlb_extra_inval:1;	/* Quirk for devices need extra flush */
> +	u8 domain_attached:1;	/* Device has domain attached */
>   	u8 ats_qdep;
>   	unsigned int iopf_refcount;
>   	struct device *dev; /* it's NULL for PCIe-to-PCI bridge */
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index d2a94025d0a0..fc312f649f9e 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -27,8 +27,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>   	unsigned long flags;
>   	int ret = 0;
>   
> -	if (info->domain)
> -		device_block_translation(dev);
> +	device_block_translation(dev);

good catch. :)

>   	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
>   		dev_err_ratelimited(dev, "Adjusted guest address width not compatible\n");
> @@ -66,6 +65,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>   		goto disable_iopf;
>   
>   	info->domain = dmar_domain;
> +	info->domain_attached = true;
>   	spin_lock_irqsave(&dmar_domain->lock, flags);
>   	list_add(&info->link, &dmar_domain->devices);
>   	spin_unlock_irqrestore(&dmar_domain->lock, flags);

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


Regards,
Yi Liu
