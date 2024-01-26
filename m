Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517E21A01
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261581; cv=fail; b=hOGT7ZlgF6GQXHlXRuW9q1AjZyv7nycaZG8v1AMOqdMw86lZch/+2oFlMsuRNZ6gnrlzFJCpkrAcnC+A2IX1Jkb+hh1ZfaaGuEp2k19gLU1hfoOLX5zLpZ771dSqjLiIyo/LEkKvcLHsIjsINqMzH3qxr04cb+ofXudIFMElxag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261581; c=relaxed/simple;
	bh=gguBiZtnWjqeUj1Nn2yly3yn1ejvLz6BLQZ7vaM/q2k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OEK8fChufZMXQA2YUTWDKPHjifKonWA5KIIhvTFAba3zMIVxudXowfJVNZ/FT8OdeZFm2egYOSyyU35Yy8X/S4Kf8OxlItx3nJ34c+/6eVyvozKEiPnIFq/jNzx7TsiFRVbH62coedWs4O5rvLaYzyjmkqKAOedQ1NSWEJN0QwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOHRbMbj; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOHRbMbj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706261579; x=1737797579;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gguBiZtnWjqeUj1Nn2yly3yn1ejvLz6BLQZ7vaM/q2k=;
  b=BOHRbMbjnPa5N8w84F9IWZOGod4zN2usH0BnJEK++bGnWy/7ephYdC1P
   MOyP4+8k6nn1h9AY1qwCw2PPbYcputj2Kj7c/bTFkKrhlRuI8N2Tr38CQ
   Ys5AegFy49N9LfENuuazkwPFnlkMxpgiLWciqDqgQrP7OfHX2DOrx+UWu
   gcKLa7XNNcLz27Qv5p20ix3V9FgbYgFoj4dhzqrV2f7Ghqvhv4eJJzvnR
   X1Z4Be2/caPjrKDaRVEy1HkZf59hTNv6/3zLaRlmCPyFgo6RZz7z2Fj0W
   4JDMKokz0Fpy2ymsxF5MlJwLJk60SdHw4HL23G5v9i6jTA3WyEe/sosyf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2314573"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2314573"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:32:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930322157"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930322157"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 01:32:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 01:32:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 01:32:57 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 01:32:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7Jbf990DrET41XI6AMvesNiYxqYGfcwCqw00LfxCsc5zJ87+EPeFCV1HHCzhxsRrfgRmi3g49r+Vkg0j0c9yrLT0+biVYkaPKHZ6iCm8t+QkgKOTdDs7Nc4GGEcAO5QlN3BysZLOOOo4QRm2qmpsaZckbnWrmkykVFvRaK6SfojpEm3oS2uSn8xg0Q7HLpadjF5LLn1qFRbvmnC5Gk5fVURwm5eJow3CP8LeWTduLNxnGcpCT03vD+muL25JgddVl0QBphTH57uFnYo08MsqsNjVkV3t7eIx2eViAu/0cm1R/U02ql2ErNuy/DZZ4rtv7lKOEAMxLIBIgvw95oIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ENEGMxivkJN0kVTk5Xf7ru5saJDBlBFSf5nrm6LYlw=;
 b=OBsyHJlLzDxDtqK+yS0g5hXFUzD63RuZyzk/sewOB2GoBNWBMeA6DGO/+beGDBHPYfteSUvyd2BFzNb6FV9MZFFOHjeKjYfNM/MTV9pKlL23XW6rayPhEKYiop35AW5vhh1Sx8H/0exFA4ypdkvUQ/bTwX9eUSu1SmZ+2lxG508cF3XVBAmoEc+l5vTIaaIQf8wczBCnB8hXLPP4FzA6wHg35mjmNI0ohP/UpPCVQokJRVlUtIzNrNRsdU6HTDgyzBHttZXKStxCIKbFWLrRYyZiKnIxbHmtPkSpEdEtORAuftRILgavTI3eSzhdquulCApBE6ln887dAKem6WlAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB5097.namprd11.prod.outlook.com (2603:10b6:806:11a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 09:32:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 09:32:55 +0000
Message-ID: <08a2a1f7-4cf1-482b-a982-f6fffd44ac13@intel.com>
Date: Fri, 26 Jan 2024 17:36:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About unmap pages and set dirty tracking on nested parent domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com>
 <20240125140331.GQ1455070@nvidia.com> <20240126001909.GU1455070@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240126001909.GU1455070@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:4:91::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: edd7423d-19c0-40e0-cbee-08dc1e51c6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2o/MDSj8kxrIJcd9fUPRPgGClqaZkFvDKofLjXlo5/PNBECGVHm5vc3LzrXnXzEJ4eF4fxj7nHeuoxiR+QNWetHWFI536lfVTaf/qpNpyXdJNkyivbdzXDOESIzeJaEAqyXhQJgCgTJGGN4iIYayioCB9AnOJnQXUGrNd+mPKdP8WSurMOy4hiRALjaBzj0o6VqlkvjVHYEyilSg+CibxwuH6l5k3OsvmwALiU0dfqsZKQ3PHH7OpCgQwrOFNZBelONjL9auH6mZgh/V4b9GI230BPQOgmWUNqlUPf8jLNKvG5DoEfzeuFlYpfwHzdHnaNNw5+H3GP5at/TstL+1hrE5V9TKJCDGVb5ZhRasEnFpxXbYwEMrwlwXjTTOIe4n0ltBny85jq++DnyjlBNPpnirxQ1EgfFNDD9v6FyYVV37xssWMgUvZoc8r+Bg+bZMpygX5FdpTIMzl7B7GNnN3oL1bOe5jLFVsVGYpC1wNH1n1Y2Y//H3X2GdqIID9QQWM4lXmcWPTmlF9HRygEmlWkKTsuJpX5NiqIFTEGM3f2bxIZM70VQT5dml3cT+/iSsHcIV5OwdnwQ+FEOjX6LYJOap2Di+U77s/KF4UYXGsJbsuYaXLRKwheS9z27Mw+2mBpq3hZVt0izBBy5HJ12dzbBSWub6ZkBqiyoNT6/8eg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(2906002)(5660300002)(82960400001)(41300700001)(36756003)(31696002)(6486002)(966005)(26005)(478600001)(53546011)(6512007)(6506007)(2616005)(6666004)(8676002)(8936002)(4326008)(66946007)(66556008)(66476007)(54906003)(316002)(110136005)(86362001)(31686004)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1AzbHNMSEhNanUvUlo2T1lMUmxlTCt4VlgweWkvbnMzbHU5OFBvU1ZWUG5C?=
 =?utf-8?B?c29JalAwZWc0U0xMOXkvRFFic1hrcUpXUzBPZmZ3eHEwZWdFZWtLeWIzdE4v?=
 =?utf-8?B?NkxhOWtTY25DNUVWU2UvRmR0VzVqbXcwb29pSnkvTnYzTHI1dm9mUFJ3N0t3?=
 =?utf-8?B?a3BZS1NSR3NSaEZHa3VGMHpvcXJDY1VsREdaRlkxREdzNm8vUDNwU3RsUHVv?=
 =?utf-8?B?bUlsakRlS3JiNFUrZ1htM3hQekVCVTRmd2hTTDBJZEhKNDJYcUpCaEdpVGdS?=
 =?utf-8?B?ZXFGdUNrQnZzY1h1R1JOZFV6ejA3SEQ4ck81bzV2TFhkQXNIODRKYUdWTmtI?=
 =?utf-8?B?VjIrbldZaGVuQ1BibCtvNkhYOWVtL2FnYVhwNEdaeWhKUURSZUJ5bXBhZThq?=
 =?utf-8?B?eUFVa2JBUHdJZ2NLbWZhUlhycWl6KzFsOGhRYUNkbWNQSU0rWTA3cjhqWTNa?=
 =?utf-8?B?QTJ4MTF3TWtXcjUrTnEwQTVpRWViUnFMQ2lXNno3VVhSRWtJQk9aNGpvNmJH?=
 =?utf-8?B?aGszUVBQZ3phdTU5SWVJVlZMbHU0WXdTOHZLUlFpMi9tUFQzMElhTXpBNWNN?=
 =?utf-8?B?QmRoQjdidUZma3RtMFNBQVRMNVlYeTJueDJkUGhvVHVleE5rVFU5Tm82b2Yy?=
 =?utf-8?B?RmpaNVdSbmtGdnU3QlFnTWNmczhxZHdsNHJyVmQ0SHpyamlSVGxlMzM4SXJt?=
 =?utf-8?B?bkVtVGpoUkJyUlcxMkZMdngybmkxaGxLa0g4ck5yZ0dGWUE5Z3F2Q2hSTVpi?=
 =?utf-8?B?SnhFdC9BSWF3WXRUazlER1ZBc2lnL1NLRmMvalZvZ29OaHJYWVFFcTZTZ3B2?=
 =?utf-8?B?UVRuMVpvUW53WVNkNit3VDBNS3dERCs0dlVsendxTHgzNDFkaTBUTWZMcDVW?=
 =?utf-8?B?ZUVXNlZnYkhCbk96Uzd4VlZSWnZrRnVrdktUcnlaclRacWdSK2FHZlFBckc0?=
 =?utf-8?B?aEw1ZmRnaDM0VmVPYUl6R0ZvTVp0TFc4ak9iVjlhaXdaQmV5bzh4RDFJVC9o?=
 =?utf-8?B?RFZzWkxwRWFhNWI4QmFidnFYRytMUVh2b29NblhRTEgvN2dDbUZXcjJMTjZj?=
 =?utf-8?B?YTdXRjNpYkdnM2x0RnY0L1RwWStsVHNDaDA5c3JCTzhVYVVadE9FTVNOTXNP?=
 =?utf-8?B?amtCS2hCMXM3YVJUM2pCL2Uyb2p1TCt2UDNBQXVYcVVTeHBiWkhVSUlNUE1C?=
 =?utf-8?B?aGVLN25zcGZhdXBYcm0za09TbmozbGZxR1hrYWh6YVlpSE9LRlc2ekdxbTA2?=
 =?utf-8?B?M1o4cnpvT0sxVjh4UUlYWitmSmx2NytIUWFiQ211M3BLMGpKbDhKb2hwdjRY?=
 =?utf-8?B?dkNmNTlMOGxvVUpVWXFLQXlHQjd3UjBUOHhkaXY2MWtJbDJhczNCTXM3WjQ4?=
 =?utf-8?B?cmxXbWtCaUl0b205WlVlYWZMNU1JbVBhM0ZJd1hBMEd1RnIvMGpQWTVzRlBJ?=
 =?utf-8?B?R2FuS3lBMzNxSTA4alNkSFY4VmY1TENHWnUvRmZsY3Y0eHM0L0JEcEFrOW9F?=
 =?utf-8?B?T2ZPRUdSRmRhNVF4SVliZVNWMXhidW5yZVpoUUtKQlVOQU5pNkN4WXpMVWNn?=
 =?utf-8?B?M1hLLzJRTEV4Z3NZMDF2WjVrSFBWWlJxRGxaVXFTVXdOTkR6SkNobHA3dzBB?=
 =?utf-8?B?ZTU2ZVU0YnMwZW9ybGNYelZaMjZRZjBJZDRnMjhhRjB0bzlzd0E3eTJPWndG?=
 =?utf-8?B?Rk5PUFA5K3hvRkdaeXBRdWx4NXpIc0ZyTXBZM2lLOEV0RHJSL3pGajZmeC91?=
 =?utf-8?B?T2NmSHlFcFQraUlSeGRJK2tWeEdNRXpRamNmdWtTRHc5K0E1dnlvR0labXRB?=
 =?utf-8?B?RG1lVnoyeHpNREM2cDRTVVFLajNTaXhMbzNsaHJJSW5YQ05nNHNiallRRSt4?=
 =?utf-8?B?c2NaNlR4dm44MTNzMjRNQmhpSUU1V09pK3d4ZE84akwzelExbGtKT3NlTE01?=
 =?utf-8?B?TlcrdUNEZmtZOUY0blNNVlFxWlBPbUoyY3VoSGh5Z0dYKzVwY3Q4ZXBDYkFD?=
 =?utf-8?B?OENtMFkrNHdIWEtESjNxUyt4bzg1NldkM0piZWgyTkl0eDc3czkxQ1pFdHFy?=
 =?utf-8?B?Tjh0VXE2S1JSVkxPcFJFU0ZIbTJ2U1FJd203UzB0UXlMSjdIT3g0ZU1uMVIx?=
 =?utf-8?Q?JOj53bibixH2ojkz2eKF+56qB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7423d-19c0-40e0-cbee-08dc1e51c6cc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 09:32:55.9151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q5+fuPcfiI+PFx4YeS+wwaAC9OYYv/6DlubWUtSPvfWL3Ttp8lD+3bjfkl0yDHQ26Bv+TtTVS1KN1JvXvTKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5097
X-OriginatorOrg: intel.com

On 2024/1/26 08:19, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 10:03:31AM -0400, Jason Gunthorpe wrote:
>> On Thu, Jan 25, 2024 at 09:55:46PM +0800, Yi Liu wrote:
>>> Hi Jason, Kevin,
>>>
>>> Today, Intel iommu driver only tracks attached devices/iommus in the nested
>>> domain. While the nested parent domain does not.
>>
>> Heh, I was just looking at this bug on my ARM implemention too :)
> 
> What I did for SMMU is on my github how:
> 
> https://github.com/jgunthorpe/linux/commits/smmuv3_newapi/
> 
> See iommu/arm-smmu-v3: Support IOMMU_DOMAIN_NESTED

thanks for the sharing.

> The list that tracks where the iommu domain sends its invalidations
> gets a flag indicating that ATC has to be a full flush

yeah, I pass a 0 - MAX to do it.

> The domain gets a flag that says the IOTLB has to be a full flush (to
> wipe the nest child entries too)

yes

> Also note that if the VM is being relied on to generate ATC
> invalidations then the hypervisor must also track the VM's ATS
> state. If the VM thinks ATS is off then it will not issue ATC flushes.

for now, we don't rely on VM to issue ATC invalidations as we don't have
plan to forward the ATC invalidation timeout error to VM. As one of your
prior remarks (it should have be handled in a RAS arch). So we don't really
need VM to generate ATC invalidation since intel iommu driver will flush
ATC if host has enabled it. So I think VT-d side is fine on this so far.

> ARM has a convenient STE bit that makes this simple, otherwise the VMM
> will have to trap the PCI-E ATS config write and forward it through
> iommufd somehow.

yes. This may need new API for device driver (VFIO) to pass such info.

> Tracking all the ATS stuff was a big PITA, I think the approach I got
> for SMMU is pretty good though.

-- 
Regards,
Yi Liu
