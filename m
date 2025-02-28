Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2F23DE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724985; cv=fail; b=P4bHQy6Rsxm5wMN+L1eC8Lk60AeUZBSONLSKRUCfjL/465WH0txmuHMomXBRz25neAK2Bdcx8T9KnlJu/hbKOkGY5iF/INkThaimm8KkY8MEgkckMruoK7TJCVy0lxOx0tErpD9tXrHAecGjsyo70CSfV44TheXpTOl/Hts7RmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724985; c=relaxed/simple;
	bh=Ohqb5eE/tfS5xKtb6GP/ia5IfcFO4y21gCt5pRekhJw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFsr04bUY1TnZlwQnGg7xZWHSZ0X0DA7pk7DpbBi0azVIa4aGKn4xPJND/bWbhpCfK/TC2sy8uEzD3kR0guF/fwMLNyQddGQgCcPVV9hdqKfvaArnQmKbkFYcHIUUhzBovWe+kn8E3asFDICRobdM2IdbXv7bpGBxpxhUPTpvMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+aeRoZN; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+aeRoZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724985; x=1772260985;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ohqb5eE/tfS5xKtb6GP/ia5IfcFO4y21gCt5pRekhJw=;
  b=h+aeRoZNv5Y/78rt0jeF/nvCiwgdj7NVyPBSd91VmTRYkPddSm07h8XK
   RpDwz9DvtpnlmHSRaH/gvBnr4fhrjf7+pt1yet8oqHdropvy2kQ4pEXeh
   AKKBb8okEHhEENjz0OJoRWKJjJMjkdP49m8OhpLHaW+Gmm9+uRQHrnZM2
   Wr3xLXw/IA+qnpkFY1bZmPdpEocqvr5rlmtdnuDWKOzSWtSe3Bp5vyk1e
   L+F22zEx2ftwnTB5u5R8VjZEhpiil0kNSVfdL4THtf+4sChSaXwejz3nX
   SlgrwVlEht8j3k+RC0abf3W2iiHDEUH8gO8ovQNfWWme5SJdTalGYgms6
   w==;
X-CSE-ConnectionGUID: pr//w/a/TRKR+G3lbfRYZQ==
X-CSE-MsgGUID: 2iD2i4zETmuLYWAb+4lYDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="51848351"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="51848351"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:43:04 -0800
X-CSE-ConnectionGUID: ODMpH6SqTECxvurfnRbfTg==
X-CSE-MsgGUID: cnfiEbKITbS+0ATlxC4Skg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="117920394"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:43:03 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 22:43:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 22:43:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 22:43:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=krXP9bNy8RQhhEYUlfW48/UR8XQ1eGFUE2p2ObUJTm/PMjP+PAXk0VSrtWbpiQuhq6W1XgiwTlid9wlDj6ZaW24kvUXJ3xrkQVhCYl4Y7GDEkSJVf1XEcG8S85UFEUbDONKXlWHO0mRqeRYF7AOAvJWQMRkieOOsQa02suUhLmQqOdQQ8gH3g517oo5SG2D439XGm2Z0E74UqMwg+p8sxNdsg2bdLWu5x6fnHPHoqyXyusaGD0ayHCmeYQT3cRFM5qOripwSasZRn6uRldn+rxwEw0yinNo/lC912NZ6qAISHCgDVlzUz/PUFAqqzxaZTgvwklwt6sc1G2kWcFSHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f6g+bcMeSNuCoX5oyszdQJv6Skz1JXMJx06BAp9wug=;
 b=T65zVV/BAEcFQNWTbZD+A3j4YM6pFxcXj4ZXBVRuFakC6sXyQMAMxP4rcVTwQMW+SdaMfg3SKMc1U39CutXu9qBcfSvgc22JPWNGF2oyRx8EMbKQ9Pg2OBKex38iBLUiGoud8qIvbScLJ9sBkBzc/P+1gt+or3DGj6JVdm1sStJuCWt1102GfvdbNX4YRYmgz4hJilE+WzCiiBtj5ydY/K4IjZBj14aHYJKPFReiS3LPFThM4jNVnA3ghvJjfYt2d/uZNSBUbGGMroQuc8tRlKtLjEttr4l5EUFvWhgdkE/8lXWE0EEJDfdgGrMPdjT97vve6pZmkRwEGi3AxNSZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8522.namprd11.prod.outlook.com (2603:10b6:806:3b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 06:42:58 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 06:42:58 +0000
Message-ID: <b153d62d-1d8b-46e1-a7ab-527073a80368@intel.com>
Date: Fri, 28 Feb 2025 14:48:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] iommu: Add iommu_attach_device_pasid_handle()
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-2-yi.l.liu@intel.com> <Z7+SrQFXdheJQzuK@Asurada-Nvidia>
 <db3df4f2-445a-49e5-9362-70cdaf363420@intel.com>
 <Z8CSKOpsl0eDh9sC@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z8CSKOpsl0eDh9sC@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ae4939-89ee-4d80-edf2-08dd57c3235f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjdndmEvaEJwZXkxNEhUL0RCTWVIZlZWVkdxaWp4amFXQURoQWJndDNlaC9i?=
 =?utf-8?B?VHlGc1ZBc2JBT0l3bGczbWZRTjBWenozRzNDMWZ4ajJ6c3gyOWFPcWJvWlRn?=
 =?utf-8?B?eEFiYkZXOThxdndsbEx6RXFtTkhMbytvaVBwSCtOcDczM0pUNUNzSllrY21n?=
 =?utf-8?B?SkNNNmtKcUNLQ3ErZ2V4emp6cldPSGJCRVM3cVlBR05zb1hkYy9td0VhaU53?=
 =?utf-8?B?MEl3TXlkc0dMbFdHbkhLRHhTZFN0VURHaW9HazRmTmFNd2JZbU53RHpwRE1Y?=
 =?utf-8?B?NEVSQUxRZ3J5RytLYVhpOEpIRFhhK3d5alhjWE5DSE8wb0lLdlBZS3RlYXRD?=
 =?utf-8?B?aDBsNnhlUXpvS1YvdHZpUzQzU3BVQ082bjBEcEZ4Yi8vRDhFVzlCdTRUUGs1?=
 =?utf-8?B?cFRoK0dIamZPazl2Z0JRVUN1SXh0TDJEMEpHVHFzeXlGaCtHcmpkRlFLNWRL?=
 =?utf-8?B?Mk1FUjFnU09HSHNuUmhuR1dtRmZJQWt1M3dvaEFWbkI2cTExZm82em9kaDFn?=
 =?utf-8?B?ZUxnb0xhUU9kTEhyUExNZC9yRWxxMDlWbkFPMHFhc0FjdVBnZnZBWCtIRlV2?=
 =?utf-8?B?OGQ4WFBxN2E3Qm1xeFkvSlV4cHI4V3N5TkhpUk9URDFFOTFJeFJxSWE3Ty9R?=
 =?utf-8?B?a05JUFFQRXhTQUJIT0NMZ1ZWanRZaDRmNHRKTVA1Szk2bExockFNZ1RmQTlW?=
 =?utf-8?B?TUFxSHh6RFI3aEtQWG4yb3JTdzZoNldmSXl4bTlXR3I3dEVBTW9XaHlORENh?=
 =?utf-8?B?aExnRXVYSDE2S0JOWjVHTExnejY5RkVMbExaRjNQSXpnSDVnblVLZDg0YUM0?=
 =?utf-8?B?REFvQTloQ3hNajJvUkVVbEIzcWd2OVlTNUhldVNCWUU5U0p1T0ZGZThPZ2Yv?=
 =?utf-8?B?M1h5cjhGeUFIZFpsck1sV1hwN2I4SWtZWm9EY3p3S0xuajV6TDFpcFB6OGRs?=
 =?utf-8?B?UVI1YTNjbjJ3ZlltRzFkMWxWbFRRZUJEQjlYb3NXYWpPejlUMTk0anVRSEFE?=
 =?utf-8?B?MWJ2SHJnUjFYTGpqSG0xZHpvWktndXcxU1pzNk5jU29Va3RvVEJHay91VS9L?=
 =?utf-8?B?UVRuSjFublQ1eThvN1B6aTRQWkZtSG9UZjI1TXJ2ZVRyK09LOUdKRkNzSXZN?=
 =?utf-8?B?dThkNmlScUtRSE9NLzZpNG5veFV5L2UwQ29ZRFNESE5RNkZMOVIya0pUd2hh?=
 =?utf-8?B?ZWpOTjN3c2w5Q25BVW1oUHhEalRIY3luYU44SGRLNktCZVoyV3BOZHV2RVNR?=
 =?utf-8?B?dDhHTG5Dc0xtcU0wbWNGcklFNktFVkMvckJwTUR0N0xIdGJ6Z3c2OUFJU05Q?=
 =?utf-8?B?aXFzRGlIK0hiUWVYNEpoYmNrZWk0TVV2dy9MTit4U0JjZ2cwODdPQVIrVlBa?=
 =?utf-8?B?dVJkK3NxVlp5d0g4enJJNTJ5bjgvZTdnU1dFdkZFNHFQZm1TeThRbStWZGh4?=
 =?utf-8?B?dG5kSG4veGRlVEYyQ29TM1FJVlJQWk5DYkUvbEN5WFJicFBtK002aHJHRWxV?=
 =?utf-8?B?MGIyaGFxWFJ2Ri9yZDFHNEczRm9jUFdTZGczUkx3NlZhRG5tTWVzcFFZT0JT?=
 =?utf-8?B?VG5CMDFwL1B4cjNtUmZUeGw1ZFErS1BDY0QrR0tHck9yRmFwMjBWQ0lWeUhr?=
 =?utf-8?B?VUdTZTRuTkVZQ1dzU1BTVkdPOStWSiswaVpNK2pjVkU2WThrVWJTN0dTcXlu?=
 =?utf-8?B?YWdZRHBsWWwvYW51eUdWL2Rta1dobThMTkh6Q3ZxV25GOWlFVTdSN3EwTFNv?=
 =?utf-8?B?OGU4TzJzQVNmOTE4aVN2ZHNMcktkMlBTaEVkT1hITnVwQVhheWlENGJoQXV4?=
 =?utf-8?B?OU0wY280S2c4YmpNU1BZaFZuL01UeFREV21DRmM4ZmxCaSs4YzVnQzdCZDZ1?=
 =?utf-8?Q?fIXeqy29NQ0nv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHJ0bFZGL2V0ckdqK21wM2R5RVJzOUdGVFlza1NFbWJGbEtsUHVkQXk2cnBV?=
 =?utf-8?B?cVhDaE5SaUd2NFNTTnNtSkpRenI5dFNDQmpCRFhJSUNPNW0zWnNHYWtvbmJI?=
 =?utf-8?B?QlpMVHd6UXA3aXNCNHI5bEJnY3BJZWZoK25QWlVkTkZzVE5Qbmd3bjYvTVhq?=
 =?utf-8?B?c09ScGF2ay9TOWJCTlFPc2UwcDIzMzMyS0wzbEw1SWVhaGdpaXdNcXVENUxl?=
 =?utf-8?B?cGladUY4T1JtZEorQ3MyemlFSWs4U2p3MEYrdWdHaHZveVBhbnFBVFM5aW9p?=
 =?utf-8?B?b2c5djhyZWJDSit1YzJQZ3FqK1JIejFJaGRXdmwyalozZzd5R3pmdnJySHVu?=
 =?utf-8?B?UUF6Mi9EMTF3TlNPejVHR0lJR3hXWTRrc2MrVHE2NGtQSytCd1c2YWRMZTlD?=
 =?utf-8?B?MU1QTVQyWG5HT2VoMW9OMHJ1RUo4ZVkwUjZ5M2lrdm90NVJCWmZTbGdUdTlj?=
 =?utf-8?B?RWI5UWNCbXBuZVBVQnZkUk5aVk9mc2JiaDBLUU16U2IraUNVQThmOG5DcUFy?=
 =?utf-8?B?eUVLZC9ubllQWGcrdDZRNWc2eHBtdE9tV0JOV1VQc2V4cWJ3Vmg5U21wZzY4?=
 =?utf-8?B?VFliVGF2UktEUnF0R2w5bTlVT09NS0JyQ1lxWlFYaTR4d3lheHJScllUT0R2?=
 =?utf-8?B?SmVBY1N2alJrWXFZeERjTHcyTTdVR1MyS3pFejAxR1N1YWJaWHpvVUk2cE1D?=
 =?utf-8?B?MFVaY0dTWlovK3VwdkN2NUNISkIwaldDMDBDc1lDc1lGanBVbTA2dW9vSVpL?=
 =?utf-8?B?QUk4RGpNVUJJNTVIRFVHNTFJRUN6ekd6SkNZUGQ1S2x3bU5qck00aDZXSGxP?=
 =?utf-8?B?YnRBK1Q0cmVFRlkvZHR5M2pvYWNVdlVCQ1RudHF1cVE3NmlYb2phUFBIZ3VN?=
 =?utf-8?B?TERJRTJyeDB5NUw4SFNGTFBxdGxKYisrY1Vhay9mR2plZDRETVRDZjhWRUVV?=
 =?utf-8?B?OXJxUU1RYmQzWmY0eTBzbDBsZ1FJY2JKWTE0cU5raHQ1c3BiLzVQeFBxaitD?=
 =?utf-8?B?NFRrRmVBL2xRTi9Ga2tYZ0FSMjhQRTY5eEFCK3dEcEdBcUVnUy8xWS9Xdkpj?=
 =?utf-8?B?SHorSEJkL05oaSttcFQyVnVjbFVuYml4ekovL2tqY01mOGVnR3BoOEJRWmxH?=
 =?utf-8?B?MmV0T0R0NGZ1WmgybzF6MkxmNWkyY1NNS3BabWVRS2VuUktsa0hGRkthREtH?=
 =?utf-8?B?aXk5SjB6eGl4QUpiQmkyRmVpQURkOU1obHEvYitma0xmTTdtS0E5WDRXOFFE?=
 =?utf-8?B?cXdlKy9INCtPZ2pYNWVzRFZIUkFDMnVsYVloaUlnZlFQNnVnSDBFK29SYWdO?=
 =?utf-8?B?TGNFOEp1RG1XZjd4aVlKRnZxN3FxOHplM0FTaVphT2dUaDZBMUNucHhUS1lx?=
 =?utf-8?B?QnNldWhXQy9UNlAySjJYb3VZNUdaYVJzRkpaWTVtN002VERwOE11SUVkeEJE?=
 =?utf-8?B?UVRvcElRRjZ5Y1lUcldOVTg3QjNmSWtNOVRWaGVKSHZNSmJBOE4xc1NRWmtn?=
 =?utf-8?B?UGYwVDRtTnFOb1NnOHFLRkovUFpIcnFBUytBZHVkUG9YRXdWTlpNcHJZZS9m?=
 =?utf-8?B?TERyaXg1NlBPTjlteVlBbGxOQm9uaGlPR3pvT1JVYUt3NlFwUUdNVlZxZEhz?=
 =?utf-8?B?QVlaS2hMTmwxam1maDJlU2M2c29VeXFMQWJSVzlIR3d1QWw3TEVXeXBiMGp2?=
 =?utf-8?B?ZHZOTTBja0l3aDk3eHdIQzRaYWNOK01nendKL0dLYUczaDIxNEN1NHYycnhY?=
 =?utf-8?B?VUVhWFo3TGFTaS93bFVDeWVpL3FPbjFONG0xT3k5ZzY2d085em9nMmNobmpJ?=
 =?utf-8?B?Y0RWQzRDMnhLWm5CdDVzN3FYaG5pZ21sRjBjTEZjaDUxc0RIMS9SRDlGdm1J?=
 =?utf-8?B?Y3JsaVFBRWVaM2FFYVZ2ZXpnTUdUbzJZRnhweXBsOXh1SUl5M1F0UFh5TjMv?=
 =?utf-8?B?MU1DLzd4dXEwblVaMWRKUkF4MUhOMGN5S3JTbTVyUCtrTkw0MU5WMjRtT0Nt?=
 =?utf-8?B?REZZMUlISEdqYU1MVGhzNVBQRWJYaGk4enoyTVdVSDJ6OVVZQjZ1TGZDSHU1?=
 =?utf-8?B?b0ZvVktScWZOa1Z2S1N2ck0xT0tnQkh0TzdMdzlkd2dzek5zWkE0ZnRLMW0y?=
 =?utf-8?Q?lLpH/uSyLQdhbr94Sv1s7Mksl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ae4939-89ee-4d80-edf2-08dd57c3235f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 06:42:58.4086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIwlJ3orDse8TQq0202P5J0UFhrbbzE1dBgPWuvaCOLjmUMlqzCgS8R7vWsowuu9C2gtMVKe7sLCwDT2zntrCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8522
X-OriginatorOrg: intel.com

On 2025/2/28 00:26, Nicolin Chen wrote:
> On Thu, Feb 27, 2025 at 09:27:12AM +0800, Yi Liu wrote:
>> On 2025/2/27 06:16, Nicolin Chen wrote:
>>> On Wed, Feb 26, 2025 at 03:40:21AM -0800, Yi Liu wrote:
>>>> The existing iommu_attach_device_pasid() function allows both a valid
>>>> handle and a NULL handle, which is not consistent with the RID path where
>>>> iommu_attach_group() and iommu_attach_group_handle() coexist. To refine
>>>> it, this adds iommu_attach_device_pasid_handle() to cover the case with
>>>> valid handle, while let the iommu_attach_device_pasid() only deals with
>>>> the case with NULL handle.
>>>
>>> Hmm, I am not very sure about the necessity of this change. The
>>> underlying function being called from those two helpers (with/
>>> without handle) is still taking a NULL handle, which looks very
>>> straightforward to me already, so this extra layer feels a bit
>>> redundant..
>>
>> I think I should have added a if (!handle) check in the beginning of
>> iommu_attach_device_pasid_handle() just like the other _handle() APIs.
>> If so, this should be clearer. is it?
> 
> My point is that the extra layer of these two helpers really do
> nothing but be two wrappers around the exact same function with
> just different "handle" inputs which only introduces some extra
> complicity to the core code, not to mention that the underlying
> function __iommu_attach_device_pasid is even in the header :-/

hmmm. I see your point. It's really strange that most caller of
iommu_attach_device_pasid() input a NULL in the place of @handle.
I thought it was done in that way as caller of iommu_attach_device_pasid()
is not huge. Having a dedicate helper that don't accept handle looks
better.

Actually, we have many examples that two APIs call into the
same code but with some parameters be static.

e.g. iommu_paging_domain_alloc_flags() and iommu_paging_domain_alloc().

But you indeed reminds me. It's improper to have the
__iommu_attach_device_pasid() in header.

> So, overall it doesn't feel very necessary to me...
> 
> The iommu_attach_group/iommu_attach_group_handle() case, on the
> other hand, does take care of some underlying difference. Thus,
> having two separate functions could make things clear.

actually, they can share code as well. The below patch actually has started
it. Though dropped to not blocking the pasid series.

https://lore.kernel.org/linux-iommu/20250218195756.GG4183890@nvidia.com/

-- 
Regards,
Yi Liu
