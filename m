Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7444DDDD2
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727072916; cv=fail; b=Agx6cOtsxwvrO+tVn3MDDhOIqqdVX+XlTqGPLzsZ1Pvt/MDkW9ReO5yifZiVoJNxjR8V7mhJcVRHzqAboqB30NVTqacYfq28cuYAJURQHvS92ttqVbntkTZxemWZm7Ia13tDvB/3vCIdKwopC9iwPFmDyMZIFLoFnTOUZ9c39ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727072916; c=relaxed/simple;
	bh=Taki1G0JZAA6Zxa7hy9vX1h0xfdhDWL23Db0KSTlXTc=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IiKgfbx5m2WpNZaAo1qMnVjopt02I79FiJwksb21JpFhv43TGJqDrk1w14nzhsbqOHoCgJDdKblh1hrEmwRYp9Fd0YthaOQy6I0eTBGnPtrgR1DiFFJQYL194GEdsDDvUe9P3XbyxCs2mIXDlkdwAauBzg41jsHUcTsH/PAQ4JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6ysbQr3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6ysbQr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727072914; x=1758608914;
  h=message-id:date:subject:from:to:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Taki1G0JZAA6Zxa7hy9vX1h0xfdhDWL23Db0KSTlXTc=;
  b=Y6ysbQr3ue0nc1JPwslCSDkcmyoVGQ/9vY7DHF07weGmUQtQdO/B14+C
   GaetM+GA1KMvBuSBlM7hBEpr/cju6WkcOV+4tH31vrDDJvN5yfxmWN7pg
   MRogmYO/AsDGC/uO1Qf+vHG0/qHLwlBDUfBkw74Qm2pcpUa1ILWscxg2q
   +CDIsWnv9LWAzCwI90vJYwp+d2+xkUSdjvXymMyXhIfnOX8a3Kj8gRnhs
   DGGN14fCI0DpKKoObQbCkrO0YZiJm7u3W2mo2sRoZ6vRCMaG3CwgywZ+x
   1wHNesKUGqQG7b01upS79C1fV6RB5ZG+LtBAIZdd+zUu0o1Wy5K7xP6a7
   w==;
X-CSE-ConnectionGUID: NDmCpL5kRb+kCYcZXPcF2w==
X-CSE-MsgGUID: qWLgm7IASfOYaK/DQOwssg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26196030"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26196030"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 23:28:33 -0700
X-CSE-ConnectionGUID: F12OKlO6R2eov4BYfR05oA==
X-CSE-MsgGUID: FjQGgyKsTcOWB7M7+AuXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71275404"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2024 23:28:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 22 Sep 2024 23:28:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 22 Sep 2024 23:28:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 22 Sep 2024 23:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMykkzNOAwyns1++2vArTPqBISqKiPhbjZkQvULqBQCYTH39M85E/MYEBF4DR2BxiJLBfJ2oqPiEu6lIh0l2PG+ZC4q+c2PXymtckNuZCzbuIPlVnSpLCYDUEyDEWhAe89XKpSKryjVtXGAN8TSDmLpI+Q73Qv/9KSnnt+NiUgjnyBiw6G+7ltTv0mEHzUdyZ8Tr6rNMVO2/VbURP5JOv4lQri2XRByN/eXmYRvgEHJI8qW8nETqG2T6d/VYXWRDrbueXbPZAxLXNA60YX4XGXU6XHWRyR2ZyVxkLXEZlTW4xK/N+KeCLz+zG9QCj7opftKZAXozXTc0yLHUVNczWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnoAg99+YbmuDeDy/fUibRaX/J6z7FCHKqKEp+ZqnAQ=;
 b=d9aAqUDiY/9zYU4GeyGxNLBJd0J6Jt3OPCin2n6JS6ocbFoVJwRfm+TlxoZOGSWOkcJZw/QRcZbPXFhP6tIM/5Oqd2yWThMRKt9leWP68RNTIFid2auXCjK8ImreCNQ3c/dfSwDWC8hBqY2hDiXEP9WW2sYYMWrPZRUNkQzVyA5FU6SjHjCSUuB/PSeovoJDUxnXm8UIWeSMr4WvIIkEd/zV9gnigt3jfs2s3C/HR+OyyFaPFTglUGBXcQKn35prYL8dTTyvKJkf+uPtEnoi1w+/ko5hLEHjxAqvSrDaPmsBoFB9u4R4x1LrQnaCBaJPE7ee33lnbeFSa0/giuwLew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6181.namprd11.prod.outlook.com (2603:10b6:208:3c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 06:28:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 06:28:30 +0000
Message-ID: <0294059f-90a1-4e5f-92df-9c25d2c30667@intel.com>
Date: Mon, 23 Sep 2024 14:32:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: running iommufd self tests
From: Yi Liu <yi.l.liu@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, <iommu@lists.linux.dev>
References: <d4475e43-0d6b-4f22-bd26-37f62ccaa1d8@oracle.com>
 <ae3bca38-9efb-491a-bbaf-184e7d51e491@intel.com>
Content-Language: en-US
In-Reply-To: <ae3bca38-9efb-491a-bbaf-184e7d51e491@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: aae001c6-fe22-41a6-eea3-08dcdb98f0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WGRMcUFyK2VoNkRSVGE1dThYenJBT01lVmxlTW5QaDVSc05xVmdSVzc2U3pY?=
 =?utf-8?B?eDNyYUdlUCszcmRTQXdyaUNHUExwSlNuM1ZDZ2EySUYxejVHMUlyeGFXYjcr?=
 =?utf-8?B?MmFUM2dtcTM3R1RsMU9qMjZyQjJDYm9FSDRGMXNucUVacEY0RWUrZHlzUE8r?=
 =?utf-8?B?VzF0UFFXeGxEQ25GajExNTFTZGdseEFTWFBkdUEra1I5MjEreUM3ZTQvVkdN?=
 =?utf-8?B?VWV4RmRRc1FURFFCSjh3MXZHNnQ5VnRzUWx3OUF5K0o4TTFQdFk0amtaYXRp?=
 =?utf-8?B?TW9hWWF5aWhHM3FwMjZhNy9JWUs3WjhLMWwrcXNwdVgvVFgzNkNvZmNlMTh4?=
 =?utf-8?B?Ni9ITWREYVo3c2xYYkYwVXlGVkJvMmtEaXBKMm5RMzY2czFqL0RrRE81TE5L?=
 =?utf-8?B?RVZkTno4bjhoUTYyckhrbW1ZcVRIMXg3Uk9yTVdSTHZPWTd3V1QzakI4UjRo?=
 =?utf-8?B?U050Rld0V2EwRUdFRmtkcTlYSU9NbS9sVWYxSThBYmowU1I0RDFoWitYVEEz?=
 =?utf-8?B?UlRJb2pEbmxoTEF1bTB3RCtIY1pRYTNtYUkwbGFld0NZeCt5NFVXSVFTc05l?=
 =?utf-8?B?TzdZQ3dGUFBFM081bmVkUm00QnhaUU5tTXlqY3AxS0lZSnNkU3VnTU8yVkZw?=
 =?utf-8?B?S1pVZklJOGJaV0Jad1ZWQi8zc29FZU1TUEhoaFNqdjkvZWNMVzc5NXplWkFU?=
 =?utf-8?B?Yms0Rkg4akp3dndHekp0aU9FbjZlMm1RdkpuVko5YnJDeGg0dFRrRDkyMmVl?=
 =?utf-8?B?MnVZNkYwa1lHVVJjWnA0SmtNNmhiNnFLMmgzaER3aDgvOVFJQ2RETjNub01k?=
 =?utf-8?B?dFEwdkNZNUlISldYdWxheWhqb0E4TGVZRytQS2VOQW1sbjdMaytCZHFOUXBH?=
 =?utf-8?B?ZXpZTXB2ZFVBMG4yYXNuRlJzSGVJUUk4UnZHMjE4bTJVRjV5dmRhUVJ2RjdF?=
 =?utf-8?B?Ni9mZk9WaEVKQjVtMkJHdys4ZnRCM01PV2tvblBwZW1vNzNVaWdPU3VzVlI4?=
 =?utf-8?B?OHkwWmNwMnBtQkJNVytsNEdoUjVISVN2b0h2QkVPYWZ0azZQQ3ZsNzYyclFN?=
 =?utf-8?B?MTNtbzI4ZjNSck9STCtVaWVySnhURktlMTV5R3FzdGlPQmJLcWpsWlpYU1NT?=
 =?utf-8?B?NExqaHZmczQ2UFFjRjZSd2NtakZpeFgrZGJ2NWp3cVJpTDQzU1B4MzRnNVpR?=
 =?utf-8?B?SnJUeC9tMTlMRDV0NlIvT3N0SjVKWUptN2x2SzVLZUNIcWJ6RHFWTjVrYndE?=
 =?utf-8?B?bWtzUFd5UTg0OS9mcDBYVVgzeWhJM3B2MDY4NHp4dDRoNE44THBZYm0rb1hP?=
 =?utf-8?B?Zy9WUnY0RDdWQU5QVHgzYVNsQWxnZTJCaWsxZGlkWDlQeXhsdE9TQW90aTJB?=
 =?utf-8?B?S3JabkF5UGVweHB4N1VlbVB4Nmp3K1BIdmxkUTYzamZBSXZBSWpSaHVhS2ls?=
 =?utf-8?B?dVA0cXJ6SDczeVJDbUFHZ0h0cXJ2d3ZoNkdxZkc5bk5FVlpxbFY5UHFtazVZ?=
 =?utf-8?B?RTkzZENsR0Vtc3duY0k0TC9IQ1pURXFIQ0IrWlJIMGUrRjc2ZE1La1V1YVRk?=
 =?utf-8?B?ZnEyclJuSCtsU3F4R05rUncxWXdPT1paSHVMNk9oZ09aNU40Y0JlUGpqMVZB?=
 =?utf-8?Q?mKv+QQcEQwUA/U/bIevExRRKx6WVOsSe0NTK6lsyXIy8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFRsbW5RMEVUNE0vVmgrZUlNbHpHczlJM21pRDNKQmc0WXBhVjBqcm81YXc3?=
 =?utf-8?B?WWY2OWZDWEtEQXJ5dFJ3T2Nhc0FKcFJadUx4Vm9MNHg3dFJZbVY2Y1hLT3Zl?=
 =?utf-8?B?UDhib3Y1MWJ5L1VBMDUvWjJueFloOUFyMGFiVW1OWk4vT05tYW9ocmNzaXdM?=
 =?utf-8?B?VWJXWTJmMytKa0YzQWc0eHVPL3ZMVmpkRHJJSVJUeHJHb2hLOUxDcmhOU0xl?=
 =?utf-8?B?OXV2aG80bHIrd3ZVbUxMV1VoZTlmUG00RHNITm1xUzVnaEI5OU1uckQ3TEtD?=
 =?utf-8?B?VmI5SURFSjlWbGFFa05RT0ZpU2Vid0hPOE1hcGVHcGYwVlMvWFRMQnovSmxS?=
 =?utf-8?B?ejhtV3BReXBTekhEUUdMVkZ3MmZzcEM1b1VYVUQwQ1ZiczZkMG10aHpncVl3?=
 =?utf-8?B?dXlBOE1QK0l1V05JMlNiSzRsMmxJNTE2RzdDOFZFcWtaaTdEUWc4ZEUwUDhX?=
 =?utf-8?B?ZVBnd1JFc1I1bUNGNnVOaE8zaWRWNk9HdWttRGIvYlhhNHBYaVpWRWxpVWlZ?=
 =?utf-8?B?MzdSbi9ab0t2VlZ4dDBESDNVSmhieFpiRlpMOVBhUkVFM21mSDg1ZW1qZnl0?=
 =?utf-8?B?a0xoUVRWdHNBWXpzODRuNmJ2SS81YzFsZjdaSkZibzVYa0pmWFBkalhPV2RP?=
 =?utf-8?B?M0NZOUNCdTBaYXZGZGVpalZKeDRYWDJRWTdGY0xCNFNaTkJrZmpvM09Lc1Z3?=
 =?utf-8?B?eVhiYU5ISHVreW5WWlFyUmQxNVh6SThBRHFWWDcrU1QzR2tSSFo4bHpQYXVn?=
 =?utf-8?B?Y3RZeS9WZ1F4L0VmRDlMMmVNbGlad2RieUpyNzNrQUhFVmxPdzRVeDA5dVhs?=
 =?utf-8?B?MytoT0IwRkIzN3ZIT3dXbWEwZHUxTmhmQmVQeWxZK21ud1k0bWJHYTF6bDVI?=
 =?utf-8?B?L3ZJbldsS1I4MWs5cC9LVDBUbkFURGxLRFducytCMVFFQ1dmNmNNQmFtNGhO?=
 =?utf-8?B?ZVE5MG5ZNE95VHBqdWJlRTFHRW1FNU5oN051YUY2ODYwK28zYXNJMjc1Vnly?=
 =?utf-8?B?T2lscXk0Z1JCOWk5TU1lMHhnVWxMR0xvUTh4NWJ6MWtmZzZLc2ppNEhXY2l1?=
 =?utf-8?B?TldEcGNpb1hBSXIzNTJRc09pdzEyNTdSWTBTRW9YR3lpRTZRQXFhWmhPM3I2?=
 =?utf-8?B?V1hsTENFeTN3Nms0RnBZOExUTjBFQWxpbWhhUlNxd2gyRktiRFU4ZTk0Zkg1?=
 =?utf-8?B?NTVYNCs0YmJuR3o3VWx5TTFpYVNBVTZBbVFnbmZaQnI1R015eGcrOHFTRGhX?=
 =?utf-8?B?c2VHQkNSU1MwaHVnWC92Znc2a2FFdEE2RFNrU1FQTkpYemFxd3d4YXZtRkhp?=
 =?utf-8?B?eld2ZmRjeEx0WjBuR1V2K2NpWmZqTnBYTUpnM3hxbU9kYnpMb1JkYUhiZWNr?=
 =?utf-8?B?YmROVmxBSVBZYnpFRnlwTHF0WTdqdkZ5NENXdW8wOGNYUyt1cG5kSFJiN2ZF?=
 =?utf-8?B?eXBGazB5WU5jVktYZzJXWFJHeDE1MG5qL3dtNFdORkVRcG9zTFNqSXVLYndL?=
 =?utf-8?B?N2p6Y2J3K2liR0h4NnFXWVlOWnNSRy94MmZPdUNuRXhFVm5uN285alVBT1Fz?=
 =?utf-8?B?MHptUUhFOVRBWUZhWUo3MUhQUkRtcEVzVWxJNzFZZXovdHVZNlRCYUw1N3pY?=
 =?utf-8?B?MVFxbEhYUkZUQXIrUyt2Zmc2dms1WGVDYWd5WnE3OWdsMDlXMllOdE1qcXhW?=
 =?utf-8?B?R0pQZzRWUU9BanR1K3E4M2I3eXVWQk1vK0pCbkgyRXpPMVp3cGFDMUpHZDlD?=
 =?utf-8?B?cjlNR09BaFdyQ3Q0WXhubSt1VUcrMmFPbndwSU1nOUg4WXgwU21YVTE4YnFS?=
 =?utf-8?B?d2l6L3FtL0h5M2ZxUkprVVRGbjRxQjFuckNCNWl1aGw4TTE3Wk9KekJIbzUv?=
 =?utf-8?B?aTJzYmNhdlgwS2d4YUs5TlBEUlFMNWFkRnhZbnJTa1d2ZkRWSXkrUlM1OXg0?=
 =?utf-8?B?S3JiSkNGWlJMbzA2S28xdlYwbWZGZUdXMWk0NWIvQUZUVHRxb2FHaS9Bb1Vz?=
 =?utf-8?B?dmZ6YUhxalU4TFkxbXE2L3ViKzcvSVdTQ1pEYWJJNS95bWtBYnhwakZDaDRa?=
 =?utf-8?B?OWRJNmxDM1QvemNzL1lqYzVtS2VZV0xWNmFJeWJ3OHZkVGJGMkEyVTJVc2Zh?=
 =?utf-8?Q?b93IMxCiIdvhQ5yZWUlqa2cnp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aae001c6-fe22-41a6-eea3-08dcdb98f0fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 06:28:30.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB3gZ6RGve045TDH0oujawORap8kMX9OI8+2jp3rq75A8rpyxzgIe649Hm29rYYoP5B8jVeheZ2GXBCxJGQ+JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6181
X-OriginatorOrg: intel.com

On 2024/9/23 14:16, Yi Liu wrote:
> On 2024/9/20 22:22, Steven Sistare wrote:
>> What userland setup steps are necessary to run the iommufd tests?
>>
>> I build a 6.11.0 kernel with:
>>    CONFIG_IOMMUFD=m
>>    CONFIG_IOMMUFD_TEST=y
>>    CONFIG_DEBUG_KERNEL=y
>>    CONFIG_FAULT_INJECTION=y
>>    CONFIG_RUNTIME_TESTING_MENU=y
>>
>> and make the tool:
>>    make TARGETS=iommu -C tools/testing/selftests
>>
>> and try one test:
>>    modprobe iommufd
>>    iommufd -r iommufd_mock_domain.one_domain.basic
>>    FAIL
>>
>> It fails in ioctl(IOMMU_TEST_CMD) creating the mock domain:
>>
>>    iommufd_test_mock_domain()
>>      iommufd_object_alloc()
>>      mock_dev_create()
>>        device_initialize()
>>        dev_set_name()
>>        device_add()
>>      iommufd_device_bind()
>>        device_iommu_capable()
>>          dev_has_iommu()  <-- false because dev->iommu == NULL , so fails
>>
>> I suspect I am missing some configuration steps related to the
>> iommufd_selftest_iommu device, but I cannot find any documentation.
> 
> As far as I know, iommufd selftest is broken for now. Baolu has a patch to
> fix it [1], and I had a test patch [2] based on it as well in my testing.
> It’s originated from Baolu’s patch.
> 
> [1] 
> https://lore.kernel.org/linux-iommu/20240111073213.180020-1-baolu.lu@linux.intel.com/
> [2] 
> https://github.com/yiliu1765/iommufd/commit/2af6b607c28e8d86f73f2390c954b5953651da60

correct the link for [2] :)

[2] 
https://github.com/yiliu1765/iommufd/commit/ff0772d155c1ae2841e7b7ff0d7ca889271b81b2

-- 
Regards,
Yi Liu
