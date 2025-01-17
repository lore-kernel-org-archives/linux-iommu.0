Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACCF1CEAC8
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110733; cv=fail; b=bbjWD3cNxP9Q0AWGJruwtdCNt/ZyF+PNSiTu/3j6QzL2aUE2+PTNqL6OdnsKDy3taZc41kGCcnSy+RaZnHqUf+Rtmn/0Vc8M1AaY6Ux+8pkCjiWmPIruCY4b7sDVixyPYTdZ8btDpW6tC0pYOTn4huwGbL6tNxe7t1+BPq1zgb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110733; c=relaxed/simple;
	bh=jxYQrRLX3ofgW5UPR+Hc4tum3n2OWPwfEsVdMKRPKFs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YcE7efLi+T7ck0JTSUT5g+fTjadDr/C4LtZnc55evigqv6AVaKcROy3DtNRu1TD/w1cw58xenyXHNxp6Lh4ehM7uKoTUWLMY2Cx8AOBI1WUWmJGzFMrZm3qhLVycgqPhpsjhVjoPOKKhgsfbqAMfI+5tS1O1Mh/pSIWJ+d4Ex68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3HRHQIx; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3HRHQIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737110731; x=1768646731;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jxYQrRLX3ofgW5UPR+Hc4tum3n2OWPwfEsVdMKRPKFs=;
  b=X3HRHQIxiAl9nh5bcNuCDVZ813bHFv+PCuJTymkilCJEO47RftLoE09z
   uheReNtZzOd45TvS8cdatSRvoGvuJ2avnZfMvfPA/YE8CrLuQM3KTxxqI
   aR6LojW4L446S0KJoV+P1UAlV96o5Nuru3PIe7ipD9IHE/ECsAOczhI3W
   4bxkk+OYvdOrfOjstexGJxu0szfOcUW0r5OKON5eYNd6/FCreYVLvkEf5
   vcdUiVEfnD0ESeB3F5ZIs4kiitCoygss4kWN1E87K0q1UNdvot7+RMAHo
   q2S4fNk3/92vr8N7FkLC8aJJXgRVoa7hxSovzvpRjLARgLls3Z9d4rDPL
   Q==;
X-CSE-ConnectionGUID: X+lz9vfmTc6hKamsVBR+Tg==
X-CSE-MsgGUID: T1C2OIwETGSEYby/em6T7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41470573"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="41470573"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 02:45:31 -0800
X-CSE-ConnectionGUID: lf3XAQfYTEqJKxWuFbfN1g==
X-CSE-MsgGUID: dL7TSRpiQF29Ps1ZblK7vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109835940"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 02:45:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 02:45:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 02:45:30 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 02:45:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZYWNTvjhQDMn4oHUinM7Wjs2uS3fXGvGMJRJWAYluppMBHcSonVy3x2OokfyKdD5rrOIsBx6wMGBY9LkZETU4mvzwNU5gJ35ZPY0b7PP3Przp7emBkp54FJTGDltDM0cmXm8yEgLG/CLCTEwOQsC+KAP1ZkdCXD7pnRUGLac3p603+ZuruexAS+oRG9tn2IVLEXlJ/oF79TIkKtmPdy8IDHlNQGpVAS5DO5udHPCDdfIoWB3AyEz/V+ei3gPRjLlifOzY4y6+bjWVKsWUiz2NsKCNop3nGeQ0505KTqwctHN2L4TGex4smmIn2FSpXbdplQtQ/CuaB+cuOXkOd0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJio37is5dYfVmIR9yW7K8H0cst3VmPh738ibVNhjdU=;
 b=BCEJyFEeeqVlIbPRDKe2Hshp8DOK24GNN4F4H/MA8X3ktOb5059DDQ6l78fSArkFxMc9kB7rd5HsrZ7aUzbIQsqaGVXCYQSNuo5Gt3XUDFYRdD37kCFAPcBM2pOj6FtI5PMKoNQ2Ed4KwskC3nszXMmO7whCWAh5Uwfk5zd9UfYqG3b04IrsCLDNjNplUHU5uh2U3a4Cit70mCxK2bjO1CTgGijO983DdTQ4xFgturzvXU4SMq/PwGe4Yo7YP/IF2oFtVQckR6CO0+Rbqc6Mpmno8R6VIF9Oz1WsTMFiRvqA3W7F2+QY8+M9J0JlF2+bAN60xh+5WEzI6gTgLSD6+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB7304.namprd11.prod.outlook.com (2603:10b6:8:107::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.15; Fri, 17 Jan
 2025 10:45:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 10:45:28 +0000
Message-ID: <43fc17c7-8f1c-4480-b67b-f875bd63d5d3@intel.com>
Date: Fri, 17 Jan 2025 18:50:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/14] iommufd: Mark PASID-compatible domain
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-7-yi.l.liu@intel.com>
 <20250109145431.GA5556@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250109145431.GA5556@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a0468a-7329-44fc-36ed-08dd36e40e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UkpxQjJiZ25MVG1YcElpSUhXWlYxbmp6NVVVY0cvWSs5c1JOUndUaXdhRHUw?=
 =?utf-8?B?aTVUajNaRWxIdkE2Q09ZNmc4ZmJyMEw3S005cTNhbGNDVW04aDZ2b3lnVnNQ?=
 =?utf-8?B?UHBKcUF1NTVYbzhiYytjSThaVnJ2NDlrK0M1ZFl6d0JVQXk2UEJQZC9sNkF3?=
 =?utf-8?B?MCs3S3N6QlZIeFJSTHR4U0pKUEZIdFh5U0JzbkJqNSs0MHUvRmwvYTJzUnNx?=
 =?utf-8?B?QUFiL0gzUHhXYUhCS0VBUjJZd1ZEUjRoalppRnlabitVdTRjUVV6c1d6RDZ4?=
 =?utf-8?B?Rko4OFd5NjVnNUFoVEtyVWhDWW9nSHQ5YU80SW16ckJhaVM4QUV3WkJ6WHp4?=
 =?utf-8?B?b09td3g0NHg3eWd2eHJ3eEVMMXZITjh0V01IMWJnL2NFUDBvOGhwODFyV2FV?=
 =?utf-8?B?NmR0L2g3eXBqQWxkTzJkS3V2anFSRWpEeEJLUXJNczNKMDVCUHdkblBXSnJp?=
 =?utf-8?B?aVFYYmpSWEhNMWFTdHNJSGJMRmltdU9VNUdGdjdtaDJoMnZCcjY0VDJ3d2p4?=
 =?utf-8?B?dytlSUVnRTl4UHdlY1lKTUJCTXVKOUhhMFh2VHlrOGdHSUwzNitNb3l0bzcx?=
 =?utf-8?B?SGNNRXBoTUFZdzVTdzNWRnpkUHBmdFN4dWNYaEVzS1RKcld5ZWI1eXFOTy93?=
 =?utf-8?B?VzYyc094MWFXakVSZE1vcy9xeUNSR29sZmJwbzUramxUTjNRL2RQcnhWT0tL?=
 =?utf-8?B?UzdBMkltakdZOS8xUG9Yc1ZNcHQ3QnZ1OGljaTVzWmdTeFZaRjlTaTZUdSty?=
 =?utf-8?B?U0c0TWluazNCdGxSM1dKR2hEK1pKbjQzM3NOUFE2UEljTW91Skpidk1DTXJa?=
 =?utf-8?B?emhac1hMOUZtU2RMdlkwNkQyKzdjS2RJYVdPUm9EZzc2YXRCc05ucjZyWENY?=
 =?utf-8?B?QjMxU0xQYktlMHFsWHhoRTZBUFZuNHRobnhtNkJFTXE4SzB6SmRjdm5hOXRT?=
 =?utf-8?B?UTZrUnY2Y1UvdWFzcW5vcnFkeGpmeCtSWERFd0I5UU1ockUvNEpkU0JGenBu?=
 =?utf-8?B?SGovSi9KUlZaZ2IrNThrbEcwNVdtcnhoQlVWekVXOXJZVi9YUndFc3R4TjRD?=
 =?utf-8?B?SEZRUU51WmVCMW9UWEZYckFhMUdOQ0plSFJ5c2VXQ2lrYWFvUVJEeFRycnJl?=
 =?utf-8?B?RU9OK3BHbzFFenRlRWlsL0E0YTk1Zkcwa29pUVd3UDhCU08xQjJsOGxTMVlT?=
 =?utf-8?B?QlR4cThaWlRsbm5GQ09BMEdGdVJCdGRzYTJaV2FnQ1g2T3pMTmd5SHo4YVpw?=
 =?utf-8?B?V1QzVlRJNDNPMlNBWmFudUJxZ1BhTWk3eGxNN2RWZC9kS2hLQ3J3b09lOExF?=
 =?utf-8?B?V2RhNnp2Y3pDZDR1cjZPSnNJNzZqNmZwSGtTV29Za2xlbmRjYzltK1MvRlcv?=
 =?utf-8?B?M2FHVXN0SU42Z0dvRk5zcWx2R3FtNkUzNzJQemFwejVxNWI1UWg0eEFuVkNS?=
 =?utf-8?B?SFcvTmp3VlNIMXlFK3ZhdjBXcjBwZlNvYmRyaC9zb0ZwYXh5ZjBjTE1QL3NZ?=
 =?utf-8?B?eEVkSGE0N2c1am9SdzZSeG4wdm1WdytCcUM4ZmtwK3R3UThMUUFSZlQxU0xB?=
 =?utf-8?B?UGVRbytHN1Z6L2trWUxsengxZnpUa2dJRE15TTJkZFZ2TVp2b1dNd2FIUzZJ?=
 =?utf-8?B?VFFPN0h2Yi8vRlVhcTBzbWMvc2ZpWGx5TUZYb1JLSld0aWRHcXQ1WlpRYkIy?=
 =?utf-8?B?d0ttNTF5UTNOUE56SWRQd3VMbk1MVXVpb1lZSzBRUjJ5RllKcCt6MDJhRk44?=
 =?utf-8?B?ZmFQdGZ0cmdSejF6WjJxQVdlTGhKNkdMbjZHR0tzVDJndk45cGhUUlUydGRE?=
 =?utf-8?B?N0FSZXI0QXAvRzM5TWlpUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVN5Nkx2ZDVZL1pjTWo1MUZDcEl6UkhSZDJISktzZ2lFTE5JdUNQVE5nUkxM?=
 =?utf-8?B?RWVtb29HNmV0eWtEemZjOHVDZE0wbUVXbGk5bEtJMHJKaDVOSzV5aEo2ODdt?=
 =?utf-8?B?QzZ5Skp4MWphWGZ2ZU41WHdUcStOQno0dEMvOGV1SGtOVE1yU3Z1S1RIeC9n?=
 =?utf-8?B?YXY1bUFZQ2hpNHJBMmJXR0FHTTFrWmlVdW9qenFlZENvTWFQQmZ6UStOMzkz?=
 =?utf-8?B?cmFUYjI0bFVKTjluUUd5ZG9oQklzQjVDT3EycVhtbE1jeXl4VXQzdnhxVmZk?=
 =?utf-8?B?V0ZCdVdXaGZ3QThDZDNkbW83Vy9kNUs2akR5dnpUcnlIRDBpL1FTaHpKbFhG?=
 =?utf-8?B?Z01uS1VHNDI1NmN3TytlSkpQQXRKOXl6bWFKc3JSWFlYUC9McU1zNWxjNjFG?=
 =?utf-8?B?eFZzUjFIc21WNWV1d0lod2VpZlJ1Q2VkcGtkZVFQeC9odHhMbHVKTE9NTElY?=
 =?utf-8?B?SDBJei9XRHlkMEZ3ZFRPLy9RQXlYd004Z0lZRkZTUUhydkd5NzZwY2RZNVFo?=
 =?utf-8?B?N29tNHVBN0RDYlQ3MEVrbjJHQmJ1NVU1NlpPNGdERlBTZThWakFHakJOcWho?=
 =?utf-8?B?MWhuaytvc1c2endMa1d4aGFGdnU1U3JSZjVWZkRqMzBkQTRwY3N6Z1pMMGQz?=
 =?utf-8?B?eEszSktWMm1SMzJ6eHhzV2dWSGx5NHA2ZmpXSEpjQVJoMVJram5Yb1BrZTQz?=
 =?utf-8?B?L0J0OVNuUmtZS3VOL2trM3ptT0t1RXBXdGE5QXRNYXBvUXlUUUd1YUJGd2NQ?=
 =?utf-8?B?dVduUlkwcFBwa1JCZG5VanZsb01BMEYwOHl3RCticW1LdS8rWGxvaGVwSXFs?=
 =?utf-8?B?bnJjMUVnazRCTzU3SzhWWEJoQ21xMkV6MEswN1dURy9od2tuMHhTcTFydVNr?=
 =?utf-8?B?K2Z1bWlJS210dzhXRHpSSkIvL0Jub2dhajBKOUdqZGZrdUYyaXJNTlVkUkpi?=
 =?utf-8?B?Wkl4N0FqUlZkdG9pK2NTbG80YVNpd0U3Tm84ZjZWYVh1MTc4Y0UwQkRkdU5v?=
 =?utf-8?B?ZEJhUGxCcHB6RHdWbEIyVmovUmFrYUJ4ejgvTTBRejMyeEkveHdNZkgyV0VO?=
 =?utf-8?B?RStoVkNadkxQUGFwVnZQek1jNkFJTEt6aXpMdGdvcWJPdWV6ZTIyak4xTG1m?=
 =?utf-8?B?azNnNHdxS2JIMFBHUUw2VEhEVzUybmdtOXRVc1ExeEEycHY5azdxODJIUFNs?=
 =?utf-8?B?NXM5VnppWktkQ0xUM21jQ0NrL0tJR0hFRzJjT1FoRTlOTnZGTTkyN2t3Qlhm?=
 =?utf-8?B?eDhWN0UvYVdTb296UHhRdkhSSCs3aGlkV3QzSEkrVTlwc3hCSVNSOU1KNnlI?=
 =?utf-8?B?YmZVV1RScDl0NnpCaVJKZkxOVzhveUJNQ3FzZ0lxQlhUalcyQnVqZ2dTb3pp?=
 =?utf-8?B?c09JcDlIeVhMa1BoOENDRDZrN3o4WERUcDdTQnpaSHRLVTVjdHhIMlE1UnND?=
 =?utf-8?B?WkNrM3FqcU9EQTZWYVJ5Q2M2bmE1bmUzZEphTno4eWdCeElGVWVkYXIvZm9G?=
 =?utf-8?B?WVZMKzNnRjVDZEpabk5DMnUvd3VrR2N2UWllMjg2Y29ObUNONlFndzFXKzNO?=
 =?utf-8?B?YTg0S1IwakZuWmV4bWNLdVlWS1FNV0RMMWpJQ0lYcUZXQXVqQVN6YnRSVjlE?=
 =?utf-8?B?Um0ySnhXTmxuNXYwYTNPQ1NEMHRma1A2TDVWTGFjMncrZGVkRUtkYkpVdlhq?=
 =?utf-8?B?eU8yQ3JaYmJLZkdRVTgwaEtiZ3R4VjU4QzQzaXlaaU82dlVGd0tOVnBMVXJX?=
 =?utf-8?B?SVQzZmtFaUtiaXpFZkFJdkRSS2dHODZDSGpqN1NEcy82eHkxSkZTNU5xOWlu?=
 =?utf-8?B?K24xbDV4Nmc1R2R4Z3d3Wll0elhUN1FJT2lvUjhxRDZ3MkJHdkxhS0gvcEgr?=
 =?utf-8?B?NmdyUEMwL29HY25uM1p4UWcwdW5GUjZJeFF0NmFBTEhyS1dlMGFLSlZVQnZG?=
 =?utf-8?B?MGNFU0tZU0xicThPVzFNQzBnRzRIbDBLUllqRFZvZnNvMGNjVUtzTFFMbW9v?=
 =?utf-8?B?d2taV0x5Y2xwVXNZTVdIaWxvMGl3VkVER0tDY290T1ZOVlZxajM4RVJ1MnNC?=
 =?utf-8?B?WmNVU2ZWbERuTVkzdTBqTHcvd1JJQ0FQQmhGN1FQWGdNeWsrd1dSVElzZGJV?=
 =?utf-8?Q?bhigHtbkt/7AIMWC4dNrWrDyP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a0468a-7329-44fc-36ed-08dd36e40e7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:45:28.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKlVU5e1XhmnY7Hg54gBJoMBnHmu46uz9ZD0MUNouB5ouN7tk8fPiCOZruERYfRbldM5Mw7/uj61bWh2tdwCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7304
X-OriginatorOrg: intel.com

On 2025/1/9 22:54, Jason Gunthorpe wrote:
> On Thu, Dec 19, 2024 at 05:27:38AM -0800, Yi Liu wrote:
>> AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
>> devices. This includes the domains attached to RID and PASIDs. Related
>> discussions in link [1] and [2].  ARM has similar requirement but does
>> not need extra hint from iommufd,
> 
> ARM does use the hint now, exactly the same as AMD, it is merged:
> 
> https://lore.kernel.org/all/2-v1-0bb8d5313a27+27b-smmuv3_paging_flags_jgg@nvidia.com/

got it. Then I will mention both AMD and ARM have such a requirement, while
Intel just treat it as nop.

-- 
Regards,
Yi Liu
