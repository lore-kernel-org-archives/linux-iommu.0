Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B247F6C
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216494; cv=fail; b=pnY5e1z1m5DuPZGqxmjVlm0xN2CUdqxp2VIPstUwZ6o8AKhqle1mV6S+7+xwosh91k8Fu+fyLonoOQxsYpcantC4eXkWODudcSVTOBszuPRHx9JPGVgOpFqWQfyfNmMf/a3VCXNQ25/KkCAlnl6XOURo6UYuze7JOmhZn2zhk5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216494; c=relaxed/simple;
	bh=qJKPpZqFk2naBhvz0ZI0MellFDP5HEQ2ptySNtpcpCo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jv1CR+7MqJW/+un0hBVjJYa0FU9I+gePq/OdZYf/KTIfXA9/Wi+7XlWLSXssfWwSIzvsfMzXqrpaw4WvT/UbvzFM5I0ivVjAY9gDo1sazMquklLdjbhqL2rC1pAd7sT0m/mFQsGoszs/bYFy7zEWCQ/nKVdxEzuaV83sVJnW4yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FD7wD5Fj; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FD7wD5Fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719216493; x=1750752493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qJKPpZqFk2naBhvz0ZI0MellFDP5HEQ2ptySNtpcpCo=;
  b=FD7wD5FjPOaWq4vVjMh9WAoYo+aVZGO5kquGClSu1rdbSokOGSqpnxba
   0T/0RBRkrU6ZvY91gr+08tnvvNPOYN/iGHPUCJxVbbv+jvR+FBm5RRypi
   LSkNtu8oJCq8Xzv4kvKYBv11QmrlTKQKeMZB+zyGM7TNM+7+zbTaEwnFP
   +3bgvMFhRcC9XfA3X7WiVf/kQaT0a+NZ8jqQFHsUCM8Av8wQW8nBHm/OC
   LmCHQtE7CAKwPbhpoE8ndqDnGIy7T3JpyMv2H0FDwZGghnav4flcDeE15
   BDbX6bBpNyRo0uZIlVWkuIwa/Q2LT9olU0NDkgCGiCfe0rVAbxoKs3mUr
   A==;
X-CSE-ConnectionGUID: mo4P7841RamYw1PBZ+zwJQ==
X-CSE-MsgGUID: 2dTMEnNvSoiWV2X6tUAOkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="33716797"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="33716797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:08:12 -0700
X-CSE-ConnectionGUID: qG08WYqOStayRsPnroGPpQ==
X-CSE-MsgGUID: w6INKlysQrGeXM7hTMRHLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43318539"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 01:08:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 01:08:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 01:08:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 01:08:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjPaoI07Tq4+po0kmsi6Y5vcJ2JISfU3hR/UjdUkQvd0s4CpCrUiTR4qIMUelwxPYU7vTrk1yt1tmalVxkwxzWdl/ucQsOtFoWXp6QuCI4ffvVogBsqGDSW2J4anfkFztyMKo87x1bb1t8hYyJ4rol4gn+pIY9HXUTFXujgFWRfsg2gkEikY/XKVCqnJvKJNWflpnWrhZ+erFU7fKtXO5jWOP1z8g92Vou9GR/1pk5iVXqWGtbMjPhYrZfyoH51LeL/tViW/L2DkZ0uLRNmvEUC8ngYmWBy3dj963Lx8QamCgAB/ajqL7eWLDnAGvxN25bNSGIy4J5qpRs5iBvucHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MwYteJdn3dZT/1/hQfrNT/fEVHpDWPSmIiQlLGuPVk=;
 b=SqJAcSxQIV9JJ39fTB9ZQv4nODoN9PZKnVs8i+gIufePrxpD8QfH+ZC8IXx4HcQdTkjN8rtKFtgaqyO3gVZGnmKIj5um8mGXAGKcYvYEcq1xc9pHVeAdgjtF86lTlQBR9LLzm3v6TIxNXG+VkPIcmB2I4xcstejuMI5iiJ99wWIwCVHLyfoAXsUym3lqf9mRqQSTyW2gEwJfHaTSeGsuC6gWoRdGXYK4SxU2qhCOiRyDJIuQOQmXPuLK+S/KG/ts9cOCzrlG731CBJJaUoSXUpH/0mkXCZO6wBHpkO7biwuzIkdwbh2L58i0a7iRjbr8CviYbdqzaUUW9ekrdeQrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:08:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 08:08:09 +0000
Message-ID: <b5797453-3e19-469f-8a0b-71fe4c5add1a@intel.com>
Date: Mon, 24 Jun 2024 16:12:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/vt-d: Convert dmar_ats_supported() to return
 bool
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	"Kevin Tian" <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240624052501.253405-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cfe862e-fcc5-4442-35a6-08dc9424c8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHZnenZYVW5sblJHckl1c2tMVkk1eUpwT3RoUUI4Y1A5cVVTa3A0b29qSEpX?=
 =?utf-8?B?UjNzWHd5d3EyUTM4UjVnYTBRZzBRTFFkWTJ5L2lzZXV6QjhjRTY0M0ViaGZH?=
 =?utf-8?B?YWMyVmR4QlV1Qm41QTM1QUkzMGFlM3ZITGRLOXUyMFdLSElEVGtNMzF2b0U1?=
 =?utf-8?B?NWtsRmVpbUd0VDdRVkgwNkRoZEt4c3lYUGx4WDhNNWNaVnc5OHlPT3NiZjdP?=
 =?utf-8?B?RC9zWmlmeGNVUjRoN3ZLOGZQcTdaTFZCYlNQaEwwelVEdUxadmFyMWZoOVlF?=
 =?utf-8?B?SnRqUnJBL3Rocjl6bzFudnBOMEt6dzUxNWFhR3ZDQnFVdWtlK2hiMWx5YVVJ?=
 =?utf-8?B?bm9iMUZtQU5uZlhiRGN5TksvbW9yZ3hGSlN4MnNaMTlWemRuTFhxd3ZBOE0w?=
 =?utf-8?B?WTdaejhSTEZ0QzU5TUZxY1ZyKysrcEdoeWxvNnE2cHM3dWN6SGhPdnFoeTBW?=
 =?utf-8?B?RUw0NDRGU3YxN2lub0Y5Q1F0MVExSUpUbU5xbzZrMXZSKzN2YU82V3RnY3Fn?=
 =?utf-8?B?bmdWY1FSeFllWG5kdnluNjBDRm4xL0F1Uk1HMDZ2dFRMaktnckZqcUx2YmZ1?=
 =?utf-8?B?ZE1WMGFYWEd1V0x6WDlwWG5jaGY3eFZNdkxyb1AydFhVclJFaEhmajc4dU9T?=
 =?utf-8?B?cTBUbEQ1RWd2dEp0UTFvK05RQjlBcCtCdDZxU0NvK1k0dWpLRUpqM0piTzVr?=
 =?utf-8?B?WWlqU3JYUzlRK1g0bkQ2N0NFQWl6cFdLaVh4N2piVjFZc3pwRURidnFuYXJo?=
 =?utf-8?B?MW5RQ0JwVGRsT2FEcDgwcjdyMVhMSU9nR24xZ2tNQzFLM3o0U2I2NlFtc1FV?=
 =?utf-8?B?ZnNrUzU0Mk9GNWJQa05wdVhPdVAxYXp5a1NueEtKbEk5b2pvSnQzK0RNVTNp?=
 =?utf-8?B?TktFbzhkek0rbE9VeEQ4aTNSZG5nMUpDZDlJbW0vYUUyMWQ2NDVhbm94eEMv?=
 =?utf-8?B?ZlBnMUdGcVBtNDRXaE1JVHJzRklJeTI0a3NsRUJwUmFyK3dCWElhY282V1Zj?=
 =?utf-8?B?RkdLbEkySTd0NU1BYXRORUFlMW4vTnp1ejFTdVpQN1lNNHpwZlUvazdJb1Rn?=
 =?utf-8?B?NCtrSE4vZXZxR2NPdzU2WXJVYkJ2RUxERkR3YzFEODJwVDAwUkM3Sk41TStS?=
 =?utf-8?B?MW5oUld6Q1ovU2JZQ1l3Y0NYODhobk5KYkExTTZkLy9iL1JYUTREeHBnOWhj?=
 =?utf-8?B?MmhPOXhhR2w2enNHNGFoUVZIZFIzamcwZGJqaUV6dGlhYmVmYzFkbU9aeVVH?=
 =?utf-8?B?TTB5bGdRcVNnb1VtbWpMbHN5K24zWWFlNjliNXNUekxWajRjS1dvTStHRGZ4?=
 =?utf-8?B?RytoYnk2VHdKRUp2ejJkYUtRTXFWNGpLa0tqZC9FYmlGa1FpdmZWV1lpVVQv?=
 =?utf-8?B?RFdkQnNZOUFOWjZ3UVVuMWJubmhxaHpSWER1K0ZTQ0V1dU9wMjBsaHMvWTVt?=
 =?utf-8?B?UUlGZ2UvcHZubTFsLzRYOGwzQW1JdzBvckhzQlBOTGNSeUJVMXBOUUYvMlNa?=
 =?utf-8?B?SmJCS0pId3N4djBaeUpJejJES2ZzaVZqaHlQRXplcHZ4MVNyNzZESko1cTVw?=
 =?utf-8?B?eHVhYkpCbmIyVzMzYXQ1Qm55VE5NZVM5VGp1cnc3WFpmekVBbmJEWEZHRExT?=
 =?utf-8?B?UUtvZVFEUW9FdnZYZjJCUVQ4QmtGYmdOOEdPakl2QjdzK2VHTTc5V2pjbW51?=
 =?utf-8?B?NERJN3NWUFMwZFFHTVZXblBMSERORDRaSXVoWHV2ZHhxQjE4OVEyNWNwc2Yx?=
 =?utf-8?Q?P9wWTthNCIeZpJQs48=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkMrR0tCQWVORkZ6elVHbEQyYUFRUGkvOEplOWFEZzdhdlhyYm9PblR0RXhB?=
 =?utf-8?B?M3FSckQ3d1ZDRHdTQXFER2hWMi9yRDFiK3Y3MnFWa2JFZFVIL24vOUhpMzlP?=
 =?utf-8?B?Y1VWQk5seUZJUW1YdU1odEhTa3VnVWFySVdsZjJYVFVaWEZBY2tzMzZVYURI?=
 =?utf-8?B?VFRBcXNjNmNsZklxVkdvaUs5dFNTamdINmVkeG5GL2VTK2hmUzRtaVlQSThQ?=
 =?utf-8?B?TnhKRHFFSHNrTTlHQW1RaGFuR2NEcTB1eVFDUFl2RFRCTTVjdzBVWHVHdXhv?=
 =?utf-8?B?NUV6b0FRNXh0YU9KZ1JvNGFVQnRGMlZrSDM1ODlvS2EzOFA4U0E5SnpSa09O?=
 =?utf-8?B?azlhVTBPRzlHNEN5V1BrdXBXR1NaREM3V09OekVGZXFoSityMzYrZ3AvL3Q1?=
 =?utf-8?B?Mm9vYzVOOUdHYitKbmorOGZLTW9tWlErMzJMTnBhaE5QakNscjhmZVN5SGdC?=
 =?utf-8?B?am9Qd2xvWnlkbXpVYzREblRJS25OcFp4TXZFQTUvQldiVGtMd3RINi9JeE9u?=
 =?utf-8?B?UE8raldENGNEV2w3Um9ueVFSalVpUGxncUNEZDBsKzRQd0JnWVordEhiMUhq?=
 =?utf-8?B?VEp3amJwVlpENFdLckZhcUdDUmpHYlcveVJGdkVPYkpVMmlyVUlsd0xWcVVq?=
 =?utf-8?B?VFZOYW43c21YUGMrVUlHRkNwRWZIRGZWV09aUU5SQUhnWi9oSm83anhCYi84?=
 =?utf-8?B?a0tQWCtUVm5ST25iTmNZZno0T09oQWNvdGhSM1hDWDRKR0JNTGtZalNxQUE2?=
 =?utf-8?B?aGc0N1p5Uk1XV3JHRG9xOElVM0R3UmFpNkxLYWt1SE1ZUW5MS3RCM3c0cGFy?=
 =?utf-8?B?dFVsckdDWFFOcmhVcVRPbkREVnhnOEoySk9VSGJCM2o4U3BsMEV4aXd2aEZ6?=
 =?utf-8?B?YllISnU2KzJkM2k1TER2Y0YxNENqUFhQM3Z1Kzd3MjhjS3gzWEtQYzFQanY3?=
 =?utf-8?B?b3pMM0Z3T21hRFFRSDNKeEk0czBqZXNKeEZlSnNEdit1L0ZBOHh4Vzg2NTNu?=
 =?utf-8?B?VGdoMGNjMHhWVUg3MUViM3hpcFhsYXRaRmczM2p2K09Bd2RkNW1ReEZxN0VC?=
 =?utf-8?B?Y2dOa3NWbjJyMXMrMTdvYWJ5V05KTERQUmY3dzA1V0xIdmdLZEtvdk1nRDdm?=
 =?utf-8?B?aHVYQXl5U0YyR3RwdTNHR0FEQlhmc09vc2o2UVYxSm5tSGVTMHF1QnR2RnlD?=
 =?utf-8?B?eXRjV2FsNFVrcUVJaHVLT0ZqdnFhMlZRVXpBTFphMTN5MStBcUU5eUN2aWpI?=
 =?utf-8?B?YURyNEZVNC9jR0tQZnY2QWYxKzV0VVpCZGZ6M3JjemlsZ3pYcnEzWWVvVEtx?=
 =?utf-8?B?Mkl2b3ZSNFpmS2RpMGZvQUFZQ1E1dUxONCtwb05ZZTNwTktjUlN5RDZka1Vr?=
 =?utf-8?B?SmlUVVI5MThkdC81MWR1cUJSa04vaFF4ZmkzSFZzdG9yT25CaVFGQTZ3S1lW?=
 =?utf-8?B?dUl5Zm1jQ1ZYK1h6NHpQSzNQRTBBdVpXOE9GTjVHcUx5TlZvNHk2dE5Uait3?=
 =?utf-8?B?Z09HUnNmUmtFUnhFWUlnU2VmdERjZkV4TWJ6aGcyQmFhWG1vV1hzekErZVlk?=
 =?utf-8?B?dVBHNlRuUWN0eGJZcU0wV0FieW9WY1ZqTFJiZHpXWENxZ21SRUJjZUVNQXB4?=
 =?utf-8?B?VFIzWFJ2NTY3c1JEYlN0STZtd1BQbTlaa25KNmZKM2NxS3VYSFpNamJVYnc0?=
 =?utf-8?B?TzFCRWFIdVFaSGhQeWJNdmNHd3dFNC9MK2tUUEdXSkxuY0ZhTUZPaFhnSVFK?=
 =?utf-8?B?UWpzSlc4WlF5cTNwbjBqRGVkMXArTWZjMFRsSEFTa3haeUluNkV3bGh6NUYy?=
 =?utf-8?B?UUhUQWxHM1B2cWl0YXVIVW90V3NmMmlQVjh1aWZRSGRXMEhIRnVYc0ZiZVU0?=
 =?utf-8?B?NGgxbTZSbDI3VDNtY3RVYVNYSjBOQVJKdy84WEJmN2U4blBtWDUxVUVDd0ZO?=
 =?utf-8?B?MUtLOEpYVnNnVVAwc2RPSm51ODg0M0xjZlJveWlhZXNEby9CcXJBVHFaS0hz?=
 =?utf-8?B?TXZia2lPSGtwbmZMN0JON3BnZHpUUCtLVWs1VDUwSVkwL1NZbGJ1eVpuQmpt?=
 =?utf-8?B?MHV3eUpHeTYwYXlqL2FLQ1hQdkduNy95bkdwNmxSOXBvRUNJZjdKeFJISnQw?=
 =?utf-8?Q?VkWpbPuRWARICHrKiVPgW/xHY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfe862e-fcc5-4442-35a6-08dc9424c8d5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:08:09.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ldUL0Nkwb8gvcwxjySHjiDN2oJ6SMYxk7Sg6lzh56M3yrhnangAkbNMpkTQ/ugOIFsJdprACExQGkv6ETZrHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com

On 2024/6/24 13:25, Lu Baolu wrote:
> dmar_ats_supported() returns an integer that is used as a boolean. Since
> it all it needs is to return true or false, change the return type from

nit: a redundant "it" is used here.

> int to bool to make it a bit more readable and obvious.
> 
> Cleanup this helper accordingly with no functional change intended.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 38cda454fc64..07e394dfccc1 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3043,15 +3043,15 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
>   	return satcu;
>   }
>   
> -static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
> +static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   {
> -	int i, ret = 1;
> -	struct pci_bus *bus;
>   	struct pci_dev *bridge = NULL;
> -	struct device *tmp;
> -	struct acpi_dmar_atsr *atsr;
>   	struct dmar_atsr_unit *atsru;
>   	struct dmar_satc_unit *satcu;
> +	struct acpi_dmar_atsr *atsr;
> +	struct pci_bus *bus;
> +	struct device *tmp;
> +	int i;
>   
>   	dev = pci_physfn(dev);
>   	satcu = dmar_find_matched_satc_unit(dev);
> @@ -3069,11 +3069,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   		bridge = bus->self;
>   		/* If it's an integrated device, allow ATS */
>   		if (!bridge)
> -			return 1;
> +			return true;
>   		/* Connected via non-PCIe: no ATS */
>   		if (!pci_is_pcie(bridge) ||
>   		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
> -			return 0;
> +			return false;
>   		/* If we found the root port, look it up in the ATSR */
>   		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
>   			break;
> @@ -3085,18 +3085,21 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   		if (atsr->segment != pci_domain_nr(dev->bus))
>   			continue;
>   
> -		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp)
> -			if (tmp == &bridge->dev)
> -				goto out;
> +		for_each_dev_scope(atsru->devices, atsru->devices_cnt, i, tmp) {
> +			if (tmp == &bridge->dev) {
> +				rcu_read_unlock();
> +				return true;
> +			}
> +		}
>   
> -		if (atsru->include_all)
> -			goto out;
> +		if (atsru->include_all) {
> +			rcu_read_unlock();
> +			return true;

It appears to me that two gotos is better than opening code. :) Anyhow.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


> +		}
>   	}
> -	ret = 0;
> -out:
>   	rcu_read_unlock();
>   
> -	return ret;
> +	return false;
>   }
>   
>   int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)

-- 
Regards,
Yi Liu
