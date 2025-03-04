Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B251FBC89
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077499; cv=fail; b=DTwuvkVThyidFFGQILWWBek0hZ4QXBWrrDrjheItq0RpO8zJwLVgKkkDN1VePiYuqU4n/jxA9eGSA8h+uS26T5VReFZa1ci3dO8WLh24wRA2heUmHj9GzLC6t+8yQsoqZSaOstAlDHFa4K3vcDIvohH4ZGyd3a0l/7+qanMUj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077499; c=relaxed/simple;
	bh=qFuVjmBrwtbZGTTIX0b9kjSyyoU+OBpOuAu3lKx1Xa4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fMF0eybRTvNlh4cJL7kmVzRr7UHV/pqzHDuzraJ988HpVOSG7gWKKDLXdohY8NYAwHD7+6b3fpfU1/7C2W06fz4+dZxw84cvqxZ+RgMD+Hz6zQPIblpj2N4TqgcXvcjuUD+PZTLD+atq+JuWolOlv+GxdIAqtPK6rdUoA8t+RVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfZs3EvG; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfZs3EvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741077497; x=1772613497;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qFuVjmBrwtbZGTTIX0b9kjSyyoU+OBpOuAu3lKx1Xa4=;
  b=bfZs3EvG4YU/0ScqL53rUYJRu/pbM+Bf25vypqEc5/UWcDp3UmuhLTkV
   IO+UVqgPzHSYIUaICQRBxpHG2/SUPzRRQMA7UcjqSEwdSsWY8IZx0N0C8
   oNo+xABww62y8/WGxtjptHgac6cR4IWRDfrOWEa9d17/cYP3gSA79g33O
   4gsoDrCMCLs0lDTrfQZT6xlqwD51XTZWjLi/yyHgIzSRKab4xnEaraL8y
   /5t2SDY/x1pwlhqYbzykLF5gEocHl0PlNlpf/8O4piGGUQ4d/XX7k9Xw8
   gUioXpEl5DGKQK+8+Tcav3urK1lt9DqbrW2wT53tJJ8k2lplgTNVoRbuZ
   Q==;
X-CSE-ConnectionGUID: WTJfjoaFTv+3UpfnFa4BqA==
X-CSE-MsgGUID: 7COJh0YKT4SluSZipGa/BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42108748"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42108748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:38:17 -0800
X-CSE-ConnectionGUID: mFRiGT30QSa2u0Or1aWmLg==
X-CSE-MsgGUID: WXgvseHcT4qf2wMOV1CSuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123517314"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:38:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:38:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:38:16 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:38:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp1b2gcGvfdMknd/AZym0TN1IKzQw2Nys52Ysn5OqzMa22whvPKy8mZWCe3VB7YoDska23fYA2sabfNsD0VwkeYYYLv+2mwItnqUEXYP5metFsrv6hMzX3VC06PSk5BYCsKcqpE2hkMdyKxk7h4DJr+ewMQc3syIFR37VzxERTaJrzl0N5jaSXsQJkXsNjCnxDhuLl5irs8fR4Zehnz2L3i1WsEUCw7k4GMzHhpekbKKZ+VhF9ghDUZgeQcc3m9xwMweTFLnVWoX8HdAyHJCOKjylkHxIUI4PE8QS9tBfnPSc0xjYBn0tYLHZUFfvSPXSXDP3h8z3B6tr12LT8dZ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LunTItEodSzwFxhdAgH87A9VRAHNXjtt2VrXBFzwvQQ=;
 b=qGtSzOCgi+soQqIWb5b/KHj/iVZuu5rryzkkjd605FArxSiQzsS/o/a7JmqQzBLlJzMt1Y+C8Sp7gYM+qWzz+sv9alrU0otheL1RhFKpEmhVZfsJeS7lONXiD+BrqOhovokQE4YchnXEYHirnLSB2UVLzBQz6dsnAVHuY1jP73NAcl/G7MtDiOaLltwhFg3Kr9BDuowuz20ed0OPlFTjLfmWOUvX9Gje6GJci9reG/zp4WCZenoRK9lo3QJEyy5/Z/EZQbaAiAf0Zrmb4q35ZjEbv3xEGd3DglzyZDtzM+ihKbjAIgt4VX1DO5c9ndVMLKyaZvhFP6S8782wQx4Npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 08:37:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 08:37:45 +0000
Message-ID: <f7d84e3d-a648-4292-a652-408f704411c7@intel.com>
Date: Tue, 4 Mar 2025 16:43:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250224051627.2956304-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bac8038-4740-45f7-b03a-08dd5af7d64d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmc5YnVXWFpTeFZ4cjRTdG11bWdHazltUnRqc2J1OFNxV1QzRzJ3NjlxTUtV?=
 =?utf-8?B?RENLV0tWd1JJWnNPWDRyRGU4dUNlQVZyME4wRU9DeC83U3B1N0E3Z25RZzBN?=
 =?utf-8?B?SDRoVGk1MXNDeDBHT1M5VkVBYU90TWx6ZEdMVVg3MGZDWTdNTzdrMTM0N3dx?=
 =?utf-8?B?bUVaSjBSMXN5VVNSQ0ZEZVhwT2FhcWtzdldBL1R5clhLdGErbzNmV1IwdjBu?=
 =?utf-8?B?Rjd6ZEtBMlJmVVZhWk1zbno3bnZGMFhPb2pyNjUzcU1aSU11bHMybXQ2QW5N?=
 =?utf-8?B?VHZuc2tDY3ZxaDVjTVNCM1FlM1pqZWkvNE5zTmp3Wi9VN25FQXI0OXkzeGUw?=
 =?utf-8?B?SXhkN2tFMDVwZVdwSTAybFBRREZycU1LWUhnendiUlNqcHQ3OU44bWVBTWY5?=
 =?utf-8?B?UHBFdHFHZXJNUi94TEE1THkyZFVCRnNYaUhyS3hxY052NkZ3R3hya1k3NDEy?=
 =?utf-8?B?OTZ6aUlnQUhWcnRYOGtyakxZVG0vTTBONU9GYjUzcXhpcTcvVmwwVUJ6OVJn?=
 =?utf-8?B?NmNaaHQxVEVBVFdWbExrSGNKU3RNNzBxdUFIYWhaWjhhNGxXa2VRbXFkTDVp?=
 =?utf-8?B?aFE0dHlydU1iUXNaK1NMSW9ONDNrVENVSEd2cDd5SFE0b2xUQS9TMGJNYTRQ?=
 =?utf-8?B?TG9VcVEvR2hSSzk0TW0ydm1BcEVod0ZjM2hudmFqb1p3U05FQmNTQndpU1VH?=
 =?utf-8?B?T1F1ejVjTGZHNjhSOWliUCtoUVVJUEl6M0EvY3BZQzdwREs4TjZ2THFsQ0lY?=
 =?utf-8?B?OVRqUVV0bVVnUy9IS3d2UmxyVCt2dVRqMWsvSng3VExOUlJ0dmxzcmVZelFu?=
 =?utf-8?B?ZUhhelRZdWdPcFJEQmJSMkZrY2lrc0JYNFFmenBTb3EvTG9jTGswUlVCZmRy?=
 =?utf-8?B?cW9oSkVRZnN0MjJoNmhxYkJxOVpWOUxmU0Jva3FWajJyVC9zVlBId0ErdDVD?=
 =?utf-8?B?V1Uzc3N2aU1qVkIvQ3dZbzdkc0Z1RUdyRzNQYlE1M2lXZUgzeUlQalUvYzBC?=
 =?utf-8?B?OWZhRnAyZnRYdVNOU21aeVltWUNrTVFJaVk2OElUaW11WlYybVNRWTBtemRN?=
 =?utf-8?B?V3lVT0JveEtaN1NiODNWSnBlR3E4OXlBUmN4cDFpVU9TdExsWmU5TElwdlJn?=
 =?utf-8?B?RFpGamtaaXVWK0FiMFg1T0t0WUhuZC94dUVCM1JuOEN0N081cEFiNDNvdEdJ?=
 =?utf-8?B?T1Rnd3BNNnpleitDTmxxaG41UkJyMCtjWnBCMEdBbWNxa3VtTDdOU1UvZHNj?=
 =?utf-8?B?cEt6MlJQMHQ4QmtZWElIcFZIR0dJSVBnNEZnQUhIa3JacEw1TkVKUVN5NG9h?=
 =?utf-8?B?bnpRaVZsN0l4dFBLNkNxcTJpVW1YVjBtQVpsN2NlY0FWNkJkL3BlbnVNazRR?=
 =?utf-8?B?eFE4UDZYQjhiTVplZEpFZ3d6aWNoTXNZMWh3TFdwUzlKckVWd0VVZHI4OWJv?=
 =?utf-8?B?NXVTUXVTdjJpSXpEWGdoaEtNd0x1YUpId1ROTlVENVExUE9xR0U5Mk1oQ2lh?=
 =?utf-8?B?OG5qekd3U0lraDZRc3BKTG1Sa01wY2Q0VFFKQVAybXZTTlp5SXNnMkZBdzJ2?=
 =?utf-8?B?R0N0eHFsZXhxQzJkeERsMVgrWlRITzBleElQYlF3dzBFTlgxZTVGK20wdGMx?=
 =?utf-8?B?dmo0blFFeG9RZUpPSUpqdnBLa1BCS1RQSExzSFg4QS94U0N5bXI4aUF1em01?=
 =?utf-8?B?c1d0U2c1Si9lY0o5R2IwKzg0a3NGaXAzMTB4U0FRZFVyYll5VkFGakFraDlP?=
 =?utf-8?B?ZWoxN3ZuYU4rM0FrM1R6RnZWd01SUmVVOGV6d1MxNlJPd3pUQXUrUlBGalI4?=
 =?utf-8?B?TlgzKzZGSWZCWW1CMWhMdWJiTTVVWnd1WVRnZmdETmF5OEhlaVZiTloxdnJi?=
 =?utf-8?Q?wRA55H0J4A9mr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am9WcEpaZUtsNGlrRjViWDZDaW1uTms2S0ZRVDB3N3NveStuTCtXMU52T2w3?=
 =?utf-8?B?VzNwSGphdE5STzdINkMrVUZrR2l5QlJUejBqeGxXenA4a0RqVjRQNUJ6UGpD?=
 =?utf-8?B?aEEvdExlTGdGcGdyb3hzVFZjcWU3WjRLUWlUQS9GZWhLdUszY3RsWHZhR25O?=
 =?utf-8?B?cDdEK09BRXExRVFRejM1bnJGczBnVG1lN1g0RVRIV3RDV2N5Tnp4UDRjeU1E?=
 =?utf-8?B?SGhvenkxSTRRSldPYWhBOFhYZi80dkdBSzF5YU15OGI2emFzSVBNTk1sOXR3?=
 =?utf-8?B?alpkM3JKYjJtU1RUdVZpd1dnTkFUc1IrNENJSCt4KzJ4Z2hvN2FZMUZ3alRZ?=
 =?utf-8?B?OCt5MkR1YXlIWS9yR1o1Slp1MnVyRzVwUkdvVDVpZllmSS91OXEvT2Nxb29T?=
 =?utf-8?B?YzdLRkQ1TVVtOTVoYjhSUGhJWkJ3UU1yRDErOXowanJWM1VDczVZSHFnSFRI?=
 =?utf-8?B?dnJpaGgyekxrb0orMlVzbHplV0VMU1VWbVhXUURpOVRGSUhieTFtQUYrN3JO?=
 =?utf-8?B?K0ZEZGNyTzZrSUNGWFY1ZmlKcy9CWW5kc1BxUHJZYWxRSy9ySmRGbU5YVWtP?=
 =?utf-8?B?SHh5cnl5UzFHQzNwYWRUTnc0QVdKMy9rMERBWmRySDhQbHFvYzBmM1JKU3pu?=
 =?utf-8?B?bzFZVlI4Z1pzak1RajRUUVFHNFFabUh6eUR3V3pxbldYb3BsZ0dEd1JabW1F?=
 =?utf-8?B?VFlyR21FbWN3dzVUY0dZdjFqT25EU1lteWhYQVVTZEVBOEtiTVdqdnpOS3o2?=
 =?utf-8?B?MTA0OVdWOHlzaFZ4TGJnUG9laHlwVlBHWEk2M3RGRGlhQnorS3VuUjhUUkcv?=
 =?utf-8?B?QkNocGZBL05vcDRsVm5TSHRteWh4bHZlaEdJREFtUWdiWDVoZFVFUFpnN0xu?=
 =?utf-8?B?ODREQzQ0Z3dUTlB4NTRSdmxGZFczbmpwMlFDcFpybTF1TmkrVzhGcmJ6VXRl?=
 =?utf-8?B?NXJzYUkzdCtDSnhmNWR1dk9SZ25iVXVVNW1yTEdpcFF2SUVHTEhDWSsrbmNt?=
 =?utf-8?B?TWlzczB3ZWZqVjU1MVBrbktzaXFMcGx2Rlp5S3Urc2FpejRtSFk3M1Bhejlk?=
 =?utf-8?B?N1JENU5vZUcreU9EZzY5ejRCL1BLVGh1M1NYT0dNYjhEMnVmakdMRVNhMEdI?=
 =?utf-8?B?SUVhUTFzdjJoQ3pacE14bUZ3bW10blpOcUVwN3hlU1ZMQThpU0J4K1oxRWpT?=
 =?utf-8?B?U1QvZkJhaTI0UW40Q3JvS2pYU0lpMTlvcWc2SVZCdzNDVlVyNGJDVEVBNUxC?=
 =?utf-8?B?dW93YmU1Y25MRHMwd09mWTN2Y0x5NXg5THdNcW1PNzRXRFM5TzJsRHk0U01t?=
 =?utf-8?B?N0dTdHVmZmEwUGp2U2VwRFpFZDNNTHYrQVVqcTNpNVJyTjhEVmNZVTJGVUZG?=
 =?utf-8?B?ZE02NkdxZncwcEpobktuL0JKa0xuOUx5T2N5VnQ3KzZmbFpCVExGRE9mMlkw?=
 =?utf-8?B?ZkorSy9YQjFSRzU2YXB1SmV4UDJlSE9FM0VIVDNjT1lyUjRTZGw2WHl3ZHFw?=
 =?utf-8?B?c3oxa3hmOER2TG9rYnp4dlZmQzF2OXphVTFCSEhFVGVDbnFxT1k5YmNNYitw?=
 =?utf-8?B?cm93SHhYVC8ySFRkRmYvZCsvNmZyMlNuK3l1cmtZYXIzZFNoSS9XdkhoaEli?=
 =?utf-8?B?WmNzQjFpOXZRZVVtd1NNOHA1dCtXWWFsSEhHcmJ2WmhuMEc4VEFZOEVNcHla?=
 =?utf-8?B?RGhTSnpEdDA3b052WUJyRlFDODI3WG00RmVjbnlYMmJ2K05VTUYrRy9TRkNw?=
 =?utf-8?B?Sml6blVTRW5LYVBOZmFNMFlnZlk4WWJ2cHFQWlBXNTVoeStmUVYwYnIxeEJY?=
 =?utf-8?B?SFpBazcvbEppYkZOM2NPVjNNMXBYaHU5aHF2dTZQVHFXanNUSjZzSkUrbXlo?=
 =?utf-8?B?aWdiSVdSb3RTS1orNUpGbXVXc3lKWktIV2U0NkwyUW51VjY2WUp6TU4yVnE0?=
 =?utf-8?B?akI4ckdqN2U3cERQdk1ZY0VkdVd2OGdpNG1SWVg1OENXcG5VL3NvNmVscFA5?=
 =?utf-8?B?SGFhU0d6K2h1TDA2emVaQXFQSWZjWFJLQXA1dU5Jck9KeW0yOGxtV0k2UGtR?=
 =?utf-8?B?UmJFZFZ2MDNjMG1Yd3ErczRMUG94U041VWpqemR3TmRTdjhDT2l5bEVsYXlP?=
 =?utf-8?Q?fxjndppYhBeUdSP3Gi2Mn2mSP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bac8038-4740-45f7-b03a-08dd5af7d64d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 08:37:45.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kb07ht654s+lDIaZlwO3tYM4oZY/ad+9xdG2Agxkg68zEbOezdWxoE8ylz0Ff6zAadeC8tHq/Rhkp4bcMUndjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com

Hi Baolu,

On 2025/2/24 13:16, Lu Baolu wrote:
> The intel_context_flush_present() is called in places where either the
> scalable mode is disabled, or scalable mode is enabled but all PASID
> entries are known to be non-present. In these cases, the flush_domains
> path within intel_context_flush_present() will never execute. This dead
> code is therefore removed.

The reason for this path is the remaining caller of
intel_context_flush_present() is only the domain_context_clear_one() which
is called in legacy mode path. Is it?
If so, it seems unnecessary to keep __context_flush_dev_iotlb(info); in the
end of the new intel_context_flush_present(). Also, since this helper is 
more for legacy mode, might be good to move it out of pasid.c.:)

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  2 +-
>   drivers/iommu/intel/iommu.h |  3 +--
>   drivers/iommu/intel/pasid.c | 39 ++++++-------------------------------
>   3 files changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 91d49e2cea34..1d564240c977 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1730,7 +1730,7 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
>   	context_clear_entry(context);
>   	__iommu_flush_cache(iommu, context, sizeof(*context));
>   	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, did, true);
> +	intel_context_flush_present(info, context, did);
>   }
>   
>   int __domain_setup_first_level(struct intel_iommu *iommu,
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index f7d78cf0778c..754f6d7ade26 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1306,8 +1306,7 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
>   			      unsigned long end);
>   
>   void intel_context_flush_present(struct device_domain_info *info,
> -				 struct context_entry *context,
> -				 u16 did, bool affect_domains);
> +				 struct context_entry *context, u16 did);
>   
>   int intel_iommu_enable_prq(struct intel_iommu *iommu);
>   int intel_iommu_finish_prq(struct intel_iommu *iommu);
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c2742e256552..a2c6be624dbf 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -932,7 +932,7 @@ static void device_pasid_table_teardown(struct device *dev, u8 bus, u8 devfn)
>   	context_clear_entry(context);
>   	__iommu_flush_cache(iommu, context, sizeof(*context));
>   	spin_unlock(&iommu->lock);
> -	intel_context_flush_present(info, context, did, false);
> +	intel_context_flush_present(info, context, did);
>   }
>   
>   static int pci_pasid_table_teardown(struct pci_dev *pdev, u16 alias, void *data)
> @@ -1119,17 +1119,15 @@ static void __context_flush_dev_iotlb(struct device_domain_info *info)
>   
>   /*
>    * Cache invalidations after change in a context table entry that was present
> - * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations). If
> - * IOMMU is in scalable mode and all PASID table entries of the device were
> - * non-present, set flush_domains to false. Otherwise, true.
> + * according to the Spec 6.5.3.3 (Guidance to Software for Invalidations).
> + * This helper can only be used when IOMMU is working in the legacy mode or
> + * IOMMU is in scalable mode but all PASID table entries of the device are
> + * non-present.
>    */
>   void intel_context_flush_present(struct device_domain_info *info,
> -				 struct context_entry *context,
> -				 u16 did, bool flush_domains)
> +				 struct context_entry *context, u16 did)
>   {
>   	struct intel_iommu *iommu = info->iommu;
> -	struct pasid_entry *pte;
> -	int i;
>   
>   	/*
>   	 * Device-selective context-cache invalidation. The Domain-ID field
> @@ -1152,30 +1150,5 @@ void intel_context_flush_present(struct device_domain_info *info,
>   		return;
>   	}
>   
> -	/*
> -	 * For scalable mode:
> -	 * - Domain-selective PASID-cache invalidation to affected domains
> -	 * - Domain-selective IOTLB invalidation to affected domains
> -	 * - Global Device-TLB invalidation to affected functions
> -	 */
> -	if (flush_domains) {
> -		/*
> -		 * If the IOMMU is running in scalable mode and there might
> -		 * be potential PASID translations, the caller should hold
> -		 * the lock to ensure that context changes and cache flushes
> -		 * are atomic.
> -		 */
> -		assert_spin_locked(&iommu->lock);
> -		for (i = 0; i < info->pasid_table->max_pasid; i++) {
> -			pte = intel_pasid_get_entry(info->dev, i);
> -			if (!pte || !pasid_pte_is_present(pte))
> -				continue;
> -
> -			did = pasid_get_domain_id(pte);
> -			qi_flush_pasid_cache(iommu, did, QI_PC_ALL_PASIDS, 0);
> -			iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> -		}
> -	}
> -
>   	__context_flush_dev_iotlb(info);
>   }

-- 
Regards,
Yi Liu
