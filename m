Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA48238DD1
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304033; cv=fail; b=OUsGZdvSNPqsnK/+vc6NjP05mFcdZsv/+Kra/FHjjYHnxeMt/t2NIs72EQ/RmiPOUzE9nAEUpej8UIpwhG4cdC3uTRgyxqFSockgAF6GaLLad2hqNh9XAnoLEBA6fP00Wm39Bp+VIIVXlYUaFQXMh1jZMCts+jU8dUDoVqNWbac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304033; c=relaxed/simple;
	bh=s+4Z/qTuqSG/tE3CVXL6xQC3Dx6MbWSAxFTOtUqanhA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nHXxBNQUxW5DPIGAyM1UKZxUQ2CQfM5Z63jK4Vs3jd42QpdB1wFxhMjfN/FZXZYZWw60Y3WcUB94vUahtFIHh1MPnp826s9YE7jInVrofnigH4einYByjyF66n2q9j8Zyy81yZEBef4v1Lb2laF/ogVzO94Un3tpyM0U2uO/Dx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+2wInEW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+2wInEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742304032; x=1773840032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s+4Z/qTuqSG/tE3CVXL6xQC3Dx6MbWSAxFTOtUqanhA=;
  b=W+2wInEWk+2DNWGKNuC2qpJRDNtVsghNO3IG7zqfk9Cuocxock1sZHhA
   jLpEQlZGyPNN4QTunFMqE6iYDd5qTb+UPxFTHZ84L+QdnUCHuyrAB8mhU
   I6px+SA3syD78h5gMCqqv19BRA8p4/9BpWkWcdAxCl97WLuLYWkOAQxES
   /ItsXnE8717msVvUUhIy7VQ4a21x3xhUzMsUbTk8w1hnkldsbthvLUsIB
   l9mvuAnSI3q8P3F6OdLkLJ3PtP0i3U1J5HmE8y+6SksHXRK7mKmcqxGBs
   mz+u7FZI61+YcbenQxU5JqaMfYwBXYKbSjFuvVcPvJIt3/KFjguw4Gp1M
   Q==;
X-CSE-ConnectionGUID: SLa1m1GFR5mS3sPuoIrtPw==
X-CSE-MsgGUID: 05pksxkvR8ubylaMUz6ubA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68794010"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="68794010"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:20:31 -0700
X-CSE-ConnectionGUID: 0311lidAQ5yltj3PL+oxfg==
X-CSE-MsgGUID: NVm1DrIMTx+8SjqO4Jfhjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122086451"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:20:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 06:20:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 06:20:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 06:20:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptQWm73XHHkVDanHafBqT2iCfv55DO9jrPCcPMe5FlDWKfxJAsiUiddGKLCv50XPpc3aKWrtbC0vkwnMXrNHKhTsGABiMsoWOuSviRd2/jy9p8m6lfAzqphv6SLhgfl6hl6qN1X+ZsFpu4qrPbbbkjWNqgwKcU68AEE99LLOJsW+yeo/7HY8cvgNgCWmx6u5HQHfBb9r9BT9ys0ZWJbSbE0K5JT6bNg4dZi8fvY+daDqOioef7VkdrhW/Vfi3EaWMCk3KPT84XhaAmht8YdLL/T2Ye/18JpMPXSZfOOBNAm5Ef+bud7xpBfcofUJEr27tH3iIhi8425Zl2/Fi1UCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcqKAXz1uleLmsEPh0SA3FbqKK7POmDo+TsRZuvcavs=;
 b=DrTQk3kbM/ssKdUT0OO2o5WfIURnkK7Kg6ukwtv9gUEJv2xfDY8t7HqTsh6v1XsD9LJOtsNVcS2UNd/puVxuvLw1D+JX4vV4Vv9/nbR0MkAAkqxHjpZgDrWENQH4G6aZW5j3mHaoq6d+mnesopFB+1HxEs2eIUj4ccryw9GvOOnHVtLtmbKpMgKgl69CgtfupfmTUIy5jWj9J25vio98+7zlj4vQC+9Ome8oSBemw9qXHQkaSwJ0fHoUgVN8jpFkUiQSXjfgpugKwTcDbhYt1q9du+fj8GME/OwGa75qpHJ24KXgoAIvKh3GbHCX0FBHuE9QfD2AnJE3B+Lv2CvfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:20:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:20:28 +0000
Message-ID: <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
Date: Tue, 18 Mar 2025 21:25:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking to
 handle
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
 <20250318123406.GJ9311@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250318123406.GJ9311@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0139.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1bc0e5-604b-43d1-a072-08dd661fa675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bmxFY2hSdVFzQ1RHcDQ4WUIrUm96cmtUbHhLZmlxS0xDdmlVU0E1SmVvUzFB?=
 =?utf-8?B?a0RrZkpBcVE2TFlwL0poTXZjVXVlaFVyYWlkS1NzOHVyMkFOSWg3QlNXbVhB?=
 =?utf-8?B?V1ZXUjVHd1d5SGtTMjZYS0U4NzZiRlFaVDNEWFBrTHB2SUdTZ0ZObXJLVHRD?=
 =?utf-8?B?MHNCRFZwWFZIaThyTGt1OXg3T1BwQjkzZ1JtcHhsZXIxcnV3dXd5TG40OU93?=
 =?utf-8?B?NHJ2bndMc0RoMDF2Z1E3SHpmYUk2N0dFN2k0OFNONnZBS3NJd1FoL2ZidmtY?=
 =?utf-8?B?YmZiMFlpazRhM1NiZy9xeGo4N2JFd0k0R09KYzRwdjBiM0dkN2JFRWpIOVVQ?=
 =?utf-8?B?N0s2UUVHc2IwaEUwMkFsVWpvb0pYNXhFcnVKb0RPVUxzbHU5alk5NlhDeE5R?=
 =?utf-8?B?QkhsYUF0bUVRK0ExWGNoZjhvTTh5M3Rnbm0wMHd0MDFHMi95S3RjdmtDMDNX?=
 =?utf-8?B?akExakY0UG9kLzY4NDlrR1QvRk5NTG1SSUlxQkRlOFJqeENFNnNVOGdXeWtr?=
 =?utf-8?B?dkxTM1lRdDBPOVZyc3Q3Uk9Xb2wxTkdLY25abmlHTmtCZ01PckovQjltZVE3?=
 =?utf-8?B?cVBVWVNmZ3NLeks5dnVqYktmVWh6TlpwUk1ueUE4b3krdTVLQ0JNOFhRVjRv?=
 =?utf-8?B?U3FjZ0U4bmV6NElxUEhwTStmQWFTc29aMUt0RHRZMUhoK1llZGg2UURFQ0ZZ?=
 =?utf-8?B?WU51MVRNdWh4aTlQSnZ4cTJ4dm5CVVM1SXBWcWVnbTl4TXViR1B2YXZtYTl5?=
 =?utf-8?B?MExOaFUyZWtKeXg1UmdHZFdhMEtnNk9zVzkxdkFBRHgrenRlbjBKSnRCN3lU?=
 =?utf-8?B?TnRnbkZKdFZidU5SMEk2dy9KTzh1VG5iZmtnR3E4dGpab21mdTNnRlJMYW0r?=
 =?utf-8?B?Q212TmIwMXlPUmtBWkZXZXJYNFd1OHJyaFR2ajk1MlVmazFKZ29Va0pBTlkz?=
 =?utf-8?B?TWFqUnFKVDlJeTFlNHpQTDhUQ2VVN1RXTWtGakZMSGIwb1dpOU9mb0R6THRR?=
 =?utf-8?B?eEQycmtldS8vTlc2TE9zMmMvRmxGK0tVVFU2MVNCWngwNzhDazNuNEJ1Z1Nx?=
 =?utf-8?B?akRLYW9zUXYrckJvMzdleElydmRjUVJEWDJxd1FwNExOWXdZbnBOUEE0eTA3?=
 =?utf-8?B?UkNzM0lEc0FMcE00SDV6bXRrMFlXdGFGcHFoUUtmVkZTcUtvT3ZYdm81cDd2?=
 =?utf-8?B?bXhsN3MwMit2UXJSaml4cm9pU3Q2RmVzNG9ycmJ3Lzd3Njdsa29TZ2JtNzAw?=
 =?utf-8?B?aTYzT201ejBXMTJWMmlqbDlmb3FpQlpxWWtoZ0MzV2xmV2dCUkY0Q3hoaGxJ?=
 =?utf-8?B?K09rTlNrTlJjcC9pd3ZoQ1VQeVo0bnI2a0hSWktLbkFWRkUwUU9ueU5lcGNG?=
 =?utf-8?B?Tnk0ZlM4UTYrWmpRSFNqOEJuM3ZxeTNtTmIvUWsyKzBLUGdzZDBnTTZtdjQ3?=
 =?utf-8?B?SnAza2FBdithSHY2WTRwekZ2RXVZY3M1RVFMdHQvMXI1dU5KV2VOWkdjRWll?=
 =?utf-8?B?VW1mRVJwcU9oYXVPbG9UYWdpZFdvbTBiQndtSWN2d0lwWVJNR0JtNzVmdTQx?=
 =?utf-8?B?WmhJazdKVm1rVnRmVWhsNVc2dThzTTMwcnhnMk52aEZmSTRobGhYRjlaWHNJ?=
 =?utf-8?B?d3pTZXhiY2hJa29sN2o3OUdZT043ZlR4ek13OU1vOHdDd1BZRnhTM3BCK2N4?=
 =?utf-8?B?bThBNy93eGdMcnBJa0R1cnF5SkNIeUluVVZOYlVheks1dFB5dGtZai9GbElX?=
 =?utf-8?B?YU9ZTnpYZmtSUWduMHE5dUFtVHRhSGxua2tId2JOS1pqeEZVbHdsK3RVOVFl?=
 =?utf-8?B?bjlEa0laTnJYci9KZVBhVGNRbXZKQjFSQTFkdGhmTWt5a0Mxa0pFMWE3WXNm?=
 =?utf-8?Q?OoSxQetaprr29?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZMbWNVOUVnNWJDK1dFSjR3OVdDb1NmQTVSbWYzSGJFeXl2NXZleE1VbGdZ?=
 =?utf-8?B?YXNWQlY5RzFIWW5TUXJsaHFhY1oxaE5CaGd2cEpDWWFnMEJWaTZGWHJRSm9K?=
 =?utf-8?B?YXVFOURYTURhMWhoZ3d1UWl6WXRsUDNGcmFpZWdEaUdyZCtLQ2czcmFhOGpl?=
 =?utf-8?B?MzRkeE13RmVFTS9zUDFLMEEyNHd6RXk4ZXVOdmR4cE1SWVRYaEw3dUlmQlNF?=
 =?utf-8?B?dmJBNEJDZTdGTjBsTiszbEtTaEYrMUdMdWExR21mTWF4NkFraENJOG4rVFZk?=
 =?utf-8?B?WXFJRWtvMlVUd2pLZVpVYUFIMVdyZ08vOStZbTVlU0RoSTNaYVNvWkhDWXFx?=
 =?utf-8?B?dXk3bWQ2TGF1bnZRaGZBaUNIWkRRWGtTT09mSlV2Nkw1QksrQjFhQ1N6UUZv?=
 =?utf-8?B?YzN3K3oxVHJ5Zm5PdEdsYXN0Q0Z0SjVSRFpkbkZtbjBuRW95ZGh6d1A5VEo0?=
 =?utf-8?B?bStPcVQzdlFnekl4V1c1YzR5TWlWcGEyVTJYeG9EcU5PUDM3OHZ6dXJmZUxP?=
 =?utf-8?B?ekpmeHhOSEZBNG1jdHlySlM1UGg4WURXeGdqVzAyNEVISk9pYXRnRXZKQ000?=
 =?utf-8?B?enlvM0drWGdxdjRHUExLbzBtdkdRbmhFbnhSODdwNWczZ0Z0TTFIRGdnOWtk?=
 =?utf-8?B?Ky9PdmpKSENXRDdKeEwvamJuN052dVFid2lIRVVlRFVtbkZzZFd5NyttYmEz?=
 =?utf-8?B?VmdQOWFLcXdVTmRoQVBvOHg0L2x4ZWVUUlkzYjFsOVdqZStlaFJmSVMrLzFL?=
 =?utf-8?B?RmN5QmRuYUpsS1VMbVZGU0t0Mm5INk15UmYvdjJpTTNZODUrMVNQU2g4QzQw?=
 =?utf-8?B?Smo4dzZRclM1WVNkbDF5QXR0eUc3Q1RLOWhmNFJ1MkJRam8wUkZUV1RCTFE5?=
 =?utf-8?B?OXBpV1FWeDRTYjF0cjF5WU5NVUxBUFh3dERkVGlvWlc2VFBWUVVEdkJDU1pz?=
 =?utf-8?B?NkZyWkgxU3FFOXExR09QZGE1UzgzWmdSZ2JsSjRzMVNiZ0R0SDVpeHlxaG9Y?=
 =?utf-8?B?Qk1zWHhwV1FCSUtBcVUwcEkrRXdzWnprUTl4T1hlbGwvc0tKUEZWR3B5TjZ3?=
 =?utf-8?B?ekJTVU14U1g3YkYxdmZacDB3VWVha2RrYkJZZ09YclNSZHVSeWJyRXBUSlUy?=
 =?utf-8?B?aW15Z2JmSU9WVHFZaUZyZTYrMHpyMXI5bTNxL1djb0dZZ1FaMWpaUEVtUUYz?=
 =?utf-8?B?enZOMXluQ3Y5RlI4TDVsZVdhVVZZdkFIbFd6OVZUOWdWRzFZRGpkNkNJWklX?=
 =?utf-8?B?cU8rZk9HenJZMGgyY2dsU1MzWWIwUkpsVXFVR2g5WHZDMTdRNVZEYmgyUUVi?=
 =?utf-8?B?cWFkUG8vNzhaQUJ1VDMvTW4xUWpURyswUnNVaVdReWJpbm90MFkvSHZYc0Mw?=
 =?utf-8?B?OU5STlRPVWFKbXVKTkoybGh4Z1lOdmY3SmNIZWZ4UGNZVXVXM09UR3czakVi?=
 =?utf-8?B?UnlOdzROWUVxQjRWUE1YaWc2ZXJWampTOS9LaFdxaGF4V1Q5eDcxU2Y2bFlJ?=
 =?utf-8?B?anN3ejlmVmhWWjhGdFMydmlDUFdRWHZLdnEzTTl6UFdkMUIxQ1AzYzdJSUdG?=
 =?utf-8?B?cjJlekJXVkhoK05leldjQzJPWWd3WlN6SW5oOVl6Vlhzb0dtV3V6TGl6RUpy?=
 =?utf-8?B?QVd2KzhZbkVjbkdVSnFnTzlLbGcwTkllNWdhSHV3U2FtQnhUd3NSS1p0MDQw?=
 =?utf-8?B?U1dicWFaRzF1MUNPWHBCN1RHN21EWVZ4OG1GTmsrNDYyTStnVmNiZVl3ZUd5?=
 =?utf-8?B?SDdSYjRUSlhKVEVxYW5GSnF2cXovbS9sK255M09CdU1qK2NDRU5wUHQwM25v?=
 =?utf-8?B?SVRZWXlpbERsN2NsTjVGWjdNNHViTHB4SW16REF4NnRTdE14bGJPTDVLci9F?=
 =?utf-8?B?cWQ1S0xxTXBwZWQ2aWZYVVpqTzRpRS83T2JxbW9Oc3c4SDdWMS8wd05VNThz?=
 =?utf-8?B?cjVsWlRySnArTjN4NEdLSC9KS0hqem9UejMvNmtTSXJTL2xsc3JVdWwyemJa?=
 =?utf-8?B?bHZyVCtYanlIdE9hS0pYYmo0d1RkeEJmRndtQ3Nob0Z0MzNicjEvZ1VGZUlX?=
 =?utf-8?B?LzhSZy9nbW9kaUFEL1hRV24yZk9YMlpvbDlGN01ydmJPdDB3djdGaGJQa0lV?=
 =?utf-8?Q?xKDdQHCBMpA54TezsM4o7qU90?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1bc0e5-604b-43d1-a072-08dd661fa675
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:20:28.2365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iu9NJWYVnpOK1SziKXvGyyUhFf9CaZELR6cPCfW7PJeO4eY9rDWoDL2aPBpxlpRPD6HmveLmSHvLNr9pPmC4Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com

On 2025/3/18 20:34, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 05:35:22AM -0700, Yi Liu wrote:
>> By tracking both attached hwpt and devices, iommufd_attach_handle is
>> prepared to be used as attach object. This prepares for adding per-PASID
>> attachment by using handle.
> 
> So this is the patch that really requires re-using the handle..
> 
> The issue you are trying to solve is to avoid a second memory
> allocation when storing the PASID in the xarray?

and another is to avoid copying all the tracked devices in the device_array
in the replace path.

> struct xarray_pasid_entry {
>    	struct iommufd_attach_handle *handle;
> 	struct xarray device_array;
> };
> 
> ?
> 
> I think I'd just accept the additional allocation and not try to make
> handle re-usable. Every unique attach gets a unique handle allocation.

If so, we also need to loop the device_array and add the attached devices
to the new device_array of the new handle.

-- 
Regards,
Yi Liu
