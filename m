Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8EE2556F
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719216157; cv=fail; b=Nwb0/d46T/ZilpR45AQucNCW56ZDzllnbXEph0/ahTcSihMrM9mlyTKImUsbJkhwqhqDCySe09y7uznR1WYyoB9qMPxMtig55Nhoenv0rnzPMv7eBKTsQ6USrRnoewOw9/jej9cZbXovO+9R7bZTZH+9wJTS3ysTYAS8fiRCG+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719216157; c=relaxed/simple;
	bh=i5O2aDT3xUI9+B8Q0EZ+f8NsMhKK9vwRo2ifaF7tbjc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eKwjdfWxe3cKQ6TLQ90BkC5cAhUALN52S/Y4DCJrjPDvyEj/KiS11qXXWIFbvp9J20bX5QM4dyfidiEvPsqY5DIe7flpIQ1D0qLoXKMig2Xpho1rjMzjs0XQoORao6s9CCSNy7MEwwuDjnyexaYyf2pXkk8pmT18QpX7T+3l7+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZDZzs1v; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZDZzs1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719216155; x=1750752155;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i5O2aDT3xUI9+B8Q0EZ+f8NsMhKK9vwRo2ifaF7tbjc=;
  b=QZDZzs1vrbKLol68fUd/0LmYfFhvurVvVewm4qIfFSn6TtfUMVf3zk6f
   vm3oNwQ9BpyGOfcJfntOxwOHX94gq4NJD1F7L/rvF78BTxzcnjL+LBGhJ
   4DPNfn2JluFftYTdfVY4cPp8KCWPjivBNdTXf04zFBE1mPItpnK+WNo7N
   Sd0PsyKxCbvUEMHRkubpY6wLL2n4uB4QhyCqeS+ZWhz4QkoVNLogJi1mp
   5Q8oeQqzDAeYl8toqJT7owoUkylLvJd6uDeB8p8KDK4LAZCpQ/fcJEh5y
   1+cAb47Zg0PO/TnmsN/hHsbNPu/DBPB7avtfRfoIJiz7cr17ejWpZzMz2
   w==;
X-CSE-ConnectionGUID: AamkTUxXQeK7hQHm0gXMqw==
X-CSE-MsgGUID: fH50AZBfR9ms3GA6g11e6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="19075015"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="19075015"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:02:34 -0700
X-CSE-ConnectionGUID: yW3XKTf9SduZEATezeD7zw==
X-CSE-MsgGUID: 6p3UE6G+RuStsgO2F0snBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43200078"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 01:02:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 01:02:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 01:02:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 01:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRrLSCvih6EP6Yaz4ckCHvX3DAuMknHqrlhiGE8Lhwm3/Mg1Tq17KBJR+kPB+uXveKqPS+pGEesJLwTsT05IBAV0R0Mc/Lz9ZTnBHchgq7UQuabzF/hz/eLcpFM5UYKmpyMvkJNjsvokIu9Qnew4P88LzqYxGSm7PTc4nGsv2EvuoEV3MvKWhOUrejIiJQ6gREbn9CE8jD+mxTii77rrRCFsDe0NMmSvzn1Su0Cw5+m3T53I3Ty9/qq59/2vQtVufF4Vz/32MhMT4jbJfI9P22zeWE5u8kbB0gXbHQpEmOOBBa8wkA2jbad+klbVbnE08t03SfaPBt9Eur5rJfT40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAfRGBFQiDV4rH4oNz8UyuRXatoqkthxOmmwwhssIQU=;
 b=ZjrG9jNpDtM715fxd9yMrgXGCB8+Mrim2ZHDG7GcANtZQh/ts7TC+85URkYReOg4Moke0hqCotzUBBd/OUsKTl78LTd2zdYm40uMa0+p7WW2SAoxUBMYI640ycPnHIqv2gdV/jzQ0hf5k4ypbSs198gRI6hAJFJ05BTBUPExBRzFLcimRrzEj2st0Lz0vwSGN0iVJgZmt2OZ6vBUWigsc9pP/rUAyiW139NLHhzDErVN2KUR47qaAnVZfX5q2lA/a+k6xL5/tWe2uQU0Sl6SHAjaWBgwdoUZErPJx7wIZoR7IswxGijOOBxI+di8t1y/nev9CM+BR0jctKR4DZMeQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW5PR11MB5930.namprd11.prod.outlook.com (2603:10b6:303:1a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 08:02:31 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 08:02:31 +0000
Message-ID: <15590835-ed6a-44a5-94b5-663f159653cc@intel.com>
Date: Mon, 24 Jun 2024 16:06:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove hardware automatic ATS dependency
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	"Kevin Tian" <kevin.tian@intel.com>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
 <20240624052501.253405-2-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240624052501.253405-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW5PR11MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e839446-052c-46d8-9ac3-08dc9423ff4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2I0N3JQRFQ4Zy9EcUxrOHA4U1N2TzRWY25teGw2eWRXaDBnS0xKWHp2dHBJ?=
 =?utf-8?B?UFdzaWRHMUVvMWJsQ2JUZ1JMTzVoY0s0UGN0VlVzK1ZoU1hnTngyR1Jic2Ry?=
 =?utf-8?B?OUx6QllhSDRhUWM3c0VYRi9yRU5RTkhHL3RGWjNXRDEyTW9ZQlBMeVQrOFB3?=
 =?utf-8?B?ZE9aN3l5S3NhU2JYRlNGblk5bWVqUGQ0T2NtV01PNVJRbHBZcndsbzJEQm1C?=
 =?utf-8?B?TkNSRDZyVC9pREJVYStlRGxLVHFzUDJZemg4UllraGZIQlFjdFFvUCtKSUFz?=
 =?utf-8?B?M2hwdDczZytrd2xUTWdNbkJJb3U3dDBEWGhCYkc4TkhkcFEvYy9rSGhERUxZ?=
 =?utf-8?B?cnR1bk0vWDFoYk95MFVjR1RwU3N5WFVzeFlVQ2JoNEFlTDRmNmNZeXdLeWtl?=
 =?utf-8?B?eDh0aXIxUGpxL1FaUTdCdHJmczJyNlp1UzJyL0k1V0xZM0VPQkVEYmh0L1kw?=
 =?utf-8?B?ME1rd2c5TnYwRXd1bXh6UHVydHkvMEw1RlNpWlpCQjZTVEV0cnJVNlo2Qnow?=
 =?utf-8?B?bzEySkdIOUppM0oyMlhtNjY3Nm5JbEY1OFp3blBaVmQ0b29QdzYzQkdDeFlw?=
 =?utf-8?B?aGIvRFdMb1hkMnNlRkI3VmdHM1pGem01M0ZzUXRwZGxCZTM3MExzRVlGanFm?=
 =?utf-8?B?djFtMmY2bVBiY3hSOXlCaXExOU5rUUtVTG9xUGNQMThiMlNMNkZrdzVJS2pU?=
 =?utf-8?B?V0piSitncXB0UXJ2UzBySktlTkRTVk40WFJXYk5UdFE3NGpDdDZqWEgxWGNK?=
 =?utf-8?B?OGUvL1FmdWRjRnRkclpZR1JuK1lSZFhySytobXQzK01iRGkvalpwMjRDRHJF?=
 =?utf-8?B?a3RyWjNOUjVqZEVwdENPNmd1b0xpVUJMUUJHbUlwSXRKQnIwUzU4WE1DWlNa?=
 =?utf-8?B?V21sK2NaVCtPM29ydk1NbjlQVjZtWHUwbEI0b2RpSXFFcnFKb1d2ZkJLT3R0?=
 =?utf-8?B?QllXTU81dGI4RThXNVJDYnNIdGVxbERiaytRKzh1KytET3I3c05yRWpqazlU?=
 =?utf-8?B?RDdUUUFvZk9lYTIvRFNjUTJJaFFZWUN3NTZvOFl3ZEVScGhZQXd3UThpZ2FL?=
 =?utf-8?B?cVM0dU1NZ2syUjYxcG9oVzRDa1ZXbVBrUE1hcDBWWUtpem1nSGozYk1xaTFL?=
 =?utf-8?B?bDhyRHhxSFU1VStVaXRPODVUQnZXMlhpSytMMGpMbkJJNUxnSWd3TVROWkFu?=
 =?utf-8?B?ZGk1WUJiTmdzY0ZLY0M4ZE5CWFVoV1ozekJEM2lhMVdGYzFvRVA4NXAvTWRY?=
 =?utf-8?B?aTVvd01SRTltL2ZyaUxYK1NBYlhCSVV2QWIyZ29qUFBJVUs4UVBIU2NLaytJ?=
 =?utf-8?B?UHd4SXd6ck1iSTVQcFVUVi9oSVRhTkJQNlYvYjEzNGpPelJZRGtlNFJDaEtm?=
 =?utf-8?B?YUM5VDVabXhIYzBXU0ZnZzVjL0k0S2xldCtvUS9HRkZWWmFGanF3UURhSjZG?=
 =?utf-8?B?TlprbUZqOTdIc0tqRDBxa2VxK0tRdTc2M1A0czh3eGQyT1A1K0lvbW5UNE94?=
 =?utf-8?B?bTNVaHlndEZDM0szOXJIWEtta1pIS3hWOWdvMWQyaVZDNmY3VWFDTWZKNmdE?=
 =?utf-8?B?UVdZSi9aVnRTajU5M0FVM3NpOVordnlJNlFZMHg1VGpOY1BVclVtazNkSjJ5?=
 =?utf-8?B?NXd4SmJ5Y3RSamQ4aU1aSHgreDY5WGF5WDhnL0hPM25ybytsRjRnUVRucU5S?=
 =?utf-8?B?WEFMbFV6cG5ZWGg4QUo5bWtZOURXNERrR0c5YVQweGRsd0ZvWHVYQVk3dDh1?=
 =?utf-8?Q?RNjOtG9rzheCQDh28Q63kOLh6wtoSSwCgYk7JjR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXNjUkRYK2ZPeXVpRWY0K3pvYWM0K0NkNG5uL0ViK3pIZER5ZHQxam1McVFj?=
 =?utf-8?B?V215Nlp4RXR0WVhnYmYvRzNVUjZWWUNHZDV5V1EvbVJvMVRoeGx1NUJFQnZh?=
 =?utf-8?B?Wm1LM05Ic2c5RU5TMlR4MmFyc0V0bGg5T2V2K3hMeWdiR1czL2V2SHlhckZI?=
 =?utf-8?B?MW80SnpwMiswckkxQlE5a0FpczYvNWFHKzB2YVlMSnhGSUdnNlFRR202dnJC?=
 =?utf-8?B?bXFmVVozS1NUbzY2Qjl3TnRhbVF6TElzdnRNVEJYVmNlcTFqaW9ZYlF3c0hi?=
 =?utf-8?B?OVlFL09RNHhhV0VYL0toUTR4RjdwaGdML2ZiNmNRaVRCZEZyQzZrcFNPVTdy?=
 =?utf-8?B?bm1zT2N6NHd6RjFuUWxqT3RSNmJmUlJGTU90U1o3LzRJRE9MLzEyOHFwUlgy?=
 =?utf-8?B?dnhzWHZlOUVzbXFyd1lPdjdDb0gzdWpaVDJ2ZEhFTTFPVGF2eVZzSGVPOXBO?=
 =?utf-8?B?Kzlva3VScnlMWVVTMnV6SHJENHhhR0U2SGpDb2tFdzRYSnVwaGVPMXFDdlov?=
 =?utf-8?B?bC9rbGVrVlh1Uml2d1ZjQVErVVZXTWhheEwrVkRaR2FFQ2M3L1NReG44aTZq?=
 =?utf-8?B?SDhwYlkzREUvUVBpR3pPaUFlOXZjaHVYbXNxR2o2Z3BNTmV5cFZoaXdXWTBo?=
 =?utf-8?B?dHFuMTNZZndWOE9QVWQ0ZkxkMm91dEtxNUliTHFOYzlMTnYzY2NublJqbE43?=
 =?utf-8?B?ZmtLdUxkdU14aVRMOW9RSnBjS0YyelMzTy9YcUtqV0xtYjROUk1wTzM1aERG?=
 =?utf-8?B?ZFA0cjZFanJhV3lQaUErejNjOWROUU5EVVBtbkpOaE9uU3A5dklIU09IR2FJ?=
 =?utf-8?B?cmJiSWxmQ1FaNzNYRHNRV3NSaS9Jck1sOUpIU28vY3dDMm1aUkhJZTJYR29u?=
 =?utf-8?B?aGVJWjlJeVJLaGdtb2pTQzlHNCttNWNCajZXdlYwNWJ2VXNPTUg4Mis4Vkd3?=
 =?utf-8?B?Sis5YkpmWWM0QW5SbjhpYlpUa0owYTgwd0ErQWpIS2xHZjBTWk0rVEVyQUxD?=
 =?utf-8?B?SEVlOVljaG5oYy9wTUJFZ0J5TjQxWkc2dkhrV1V6Q2dHbm91WHlUUXlHKzMy?=
 =?utf-8?B?RlRKN1lISitxenE5WGJGUSsvTmJjTDJZT0E1OEl0Y3gzbmpab25jdEoyQS84?=
 =?utf-8?B?SHQ1eUo1Z3pVNDVrWTYvTStZUnFNK01ReW1GSjdhR0FmUXBKa0g1ZXhZNnJF?=
 =?utf-8?B?K3hJR1JGS0JGcDAwVmw0aTl6NTVqQ0tiWEdBSXRsdUVwSjgvZEF5K2pzZXlH?=
 =?utf-8?B?MXdQWEV3WURmbE9hN25DMlJweEJtdVNaTGJyVkliWUZ6RTlFWW56dTU2ZWNh?=
 =?utf-8?B?alAxZnVkUmJ4WDRzYWp6MFhFU0M5VW4vdUViZFU4dGtiMEkxdEJxTmcyM2Z3?=
 =?utf-8?B?YnNrQVFYckFJSjZqYWdWNlBhL2RoaHR2ZzhvR2dQVmNqYkJaWGJyL0xRem1C?=
 =?utf-8?B?VEJzMlRlOVZ3aDFYQ0cvTWJ0TDdNTmNxMXNUckduVng1TUtsR1BUbHY0dUhS?=
 =?utf-8?B?TmUrL29GUkdPdDcyZ2Vlem4yTGFnb2wrNUdNVkNsckI2U1lsVVh4eGkrRkpS?=
 =?utf-8?B?Sm12UUVSWVZIRXpMSFl5REIyTUdUdUViS3lndityOFZ0VitCUzBSZ05RTFJF?=
 =?utf-8?B?UHFyVS9oSFBCZWFkNDR1Zk5kS01QRW1IVzhtVGRMamIyQVZ3a2RqWkZCMVgw?=
 =?utf-8?B?enNwYlRiRGwyc2p5Z09uTnpPQ1o2MVVnWTl2NFh2TDkzTEljTGlud0dBak5t?=
 =?utf-8?B?bWRqMnpBOGZMbTkyTFFwYk16SDRiemFNcDNic3k4aXJtM0J3Y2pqajJFWk51?=
 =?utf-8?B?dzFEb3JVMEpIWENZLzZraFNWaGpHVm5GZEhDeWZCYjZOSGpQcnZhMDNUa0xq?=
 =?utf-8?B?eUluSEJXOFd1MU1SSGM3TzRJRldNZXgyRUVuZDV2VTBaZHdGbEpuUzBRcEhT?=
 =?utf-8?B?Tk9DQndPdkFzNFlvYVRYNnBVMlZWSGlQdEdMNzk4ZHF3Uzl2VlFQckVRcnRV?=
 =?utf-8?B?UU0vaVkrZ010cFZ4aW50V0dnTmVMaFd6Q1hKd2Z3ejExUFFKZDlUV1U0aVhL?=
 =?utf-8?B?bjNvalVIbzk1SjZmRVhIMnNZdk5yTHFPZWZCeVh3VXFqQXV3T0I1aXU1VUpu?=
 =?utf-8?Q?6ZjrAifWG0f41LDlPMTfdOsWz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e839446-052c-46d8-9ac3-08dc9423ff4f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 08:02:31.1880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqtMACsDmA1+X9oG2pERuCXgx7nCB0wYyffbShNY25m+axpJ4EwOI/A0U09pHpOLNtoWPkbVSn/ZT34pLVmsxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5930
X-OriginatorOrg: intel.com

Hi Baolu,

On 2024/6/24 13:25, Lu Baolu wrote:
> If a device is listed in the SATC table with ATC_REQUIRED flag set, it
> indicates that the device has a functional requirement to enable its ATC
> (via the ATS capability) for device operation. However, when IOMMU is
> running in the legacy mode, ATS could be automatically supported by the
> hardware so that the OS has no need to support the ATS functionality.

It seems like if VT-d hw is operating in legacy mode, ATS is enabled
automatically? This is really suprising. Maybe I got it wrongly. Could you
elaborate a bit?

> This is a backward compatibility feature which enables older OSs. Since
> Linux VT-d implementation has already supported ATS features for a long
> time, there is no need to rely on this compatibility hardware. Remove it
> to make the driver future-proof.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 07e394dfccc1..b63347c8bf5d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3056,14 +3056,7 @@ static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   	dev = pci_physfn(dev);
>   	satcu = dmar_find_matched_satc_unit(dev);
>   	if (satcu)
> -		/*
> -		 * This device supports ATS as it is in SATC table.
> -		 * When IOMMU is in legacy mode, enabling ATS is done
> -		 * automatically by HW for the device that requires
> -		 * ATS, hence OS should not enable this device ATS
> -		 * to avoid duplicated TLB invalidation.
> -		 */
> -		return !(satcu->atc_required && !sm_supported(iommu));
> +		return true;
>   
>   	for (bus = dev->bus; bus; bus = bus->parent) {
>   		bridge = bus->self;

-- 
Regards,
Yi Liu
