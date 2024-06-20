Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1280E1CF90
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852667; cv=fail; b=gvQOD67FH/y0a84GeX8SFRGQbYiZu+VkiHBPZLFtmeru4ek+GC2JyzKO/8VWt9yEVzFxpLsNmdNvH58aGELg8ODFLlUM2D3y9UudGBAo2TZLsb3VDPWSMVYoizX8zJMevXf2jPXkFULC+HVAK27kXWnEdoZbVbGS8juH14Pma/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852667; c=relaxed/simple;
	bh=uzH5wfUpfqLWGt5e6F6lZlGc1GzoLcGZ1VXHlKA5ARI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C0okqTTSV2TWahQK4RCYdA9keqLE1lIj2nyvY872jJrFvhA3N0f0dOkzHcrXY79GUTGUL99LaPtQEVuMrFTVfj0wZE+Ynj8dzLuzEVc1R52yVWlREBWiXnFkU/HeDfqzTYWTN/RVyqOj82zUCkpm0+Yfy55uVEyaRxoeyvFAG5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akd6Y2SH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akd6Y2SH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718852666; x=1750388666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uzH5wfUpfqLWGt5e6F6lZlGc1GzoLcGZ1VXHlKA5ARI=;
  b=akd6Y2SH4hTHZRxVw2wZ/oWIYGvBZLY20KYrfrmnxMrU1GoaIyVOFZmw
   lW6d4TJY7oW1ftTG+ZnVSjwv6QV+vvQ8u7qxzNrP8Kf/Q1BYf6jQCXKfd
   I9ZYDYy4PsXvXEprkDqKeMiFQ969oScDbqYHJzTLddt0Milp4WeV7gILP
   g3+R97g88o5rYcm1mwhGrKcvf4gYFk5TMjKc5zloahwcDH7S3Qdsf1uO/
   BwRY/PPxAo4VvuCjekLSoyDLWZ5R10iWNfJjRHt5qrlJB6al22w0wdRYZ
   OA6FvKdmVR7Yu8400gXQ+AYv/S2clxC3Du2lRt5glV/9kNMY0ZbX5ZpTb
   A==;
X-CSE-ConnectionGUID: yVk1pMHtTlOt2JPaCO+EMQ==
X-CSE-MsgGUID: OCxuxmXaQsW4tN2FM1wo1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="18723218"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="18723218"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 20:04:25 -0700
X-CSE-ConnectionGUID: wkzhFDXLQZieT0JclFMyzg==
X-CSE-MsgGUID: f/Brd7pSR9Oc0SQLi/BBAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="73293007"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jun 2024 20:04:26 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 20:04:25 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 19 Jun 2024 20:04:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 19 Jun 2024 20:04:24 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 19 Jun 2024 20:04:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4/TYjuA39gQ4e6Oi7ZMeJkuZoE5XmX7bPGOi8VF/DrFcGIoivgQywjaKUVlL72KAMaCjb81vTaiM7XR1W04SjhBPh0wwpjtme2s3QuH0FLm+sfg+1KGPUr3I5uvDjFMwTtQqBVU0q6e+Oxx2tyznstF3HSHSMK8Z2Se+ba4ys0rU3QwQALxQNdkRjSk6Z9Sgc//JV8K1PluPGCNDPCs6irNURKRzebatxuW8EZgJCpHwxpubGFtS+XSdEPIXHx4zA8Lm5xGNKTSsaj5j1jm4fzXBVWvAUz2wzDHqxZ4DsoKm9CtzZhBIZGs/evFyB9g/YMXOyw87Jy6bMSoaPazfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzH5wfUpfqLWGt5e6F6lZlGc1GzoLcGZ1VXHlKA5ARI=;
 b=ICb+Y8ohwsnxPKwdC/kkjpWY1gZSyDPDaAHrO3wzCSky/1xCNO/Dd1uTCbZoEpNP5k1zNxqbC32VD6IrgN1Hw/Oml6ze/pzZDnhqWVOWO7YdxjVHefVYkpf3U7k9AAMLqR2fWro2oin+hEcy+ZBElMq1MShL/7rDFvTtBpEW0Rf6Y4qOA87zgDkGlTgiYqhamn4AMvpfdx/udUOv2Ur2Lrfx0Mg2x2SZYXUPmCXY38tyjqX+8Ea2VY5tcofWFkFdrkBL13KLO5pw4+vfOr/9/I7kL4CvPQ5l0eP+AAWAxKKsXa860q53ssQxxTEnTMLdBUl3JEM/+s7QpEDJe069iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6914.namprd11.prod.outlook.com (2603:10b6:930:5a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.18; Thu, 20 Jun
 2024 03:04:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 03:04:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jacek Lawrynowicz
	<jacek.lawrynowicz@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
Thread-Index: AQHawevyEa4SaKI0hEeZkWqSILyCJbHPTJQAgACHMoCAACMPkA==
Date: Thu, 20 Jun 2024 03:04:22 +0000
Message-ID: <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
In-Reply-To: <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6914:EE_
x-ms-office365-filtering-correlation-id: b2a64393-81c5-4304-4a97-08dc90d5af6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?cDFuZWYvZEJqWXBwK1BVVnJoV0ZQRWRscG5COHRVNTJpMUM1Qkg0eEpQMFBh?=
 =?utf-8?B?THhQK0dnbDlXRHlZU1hmeUdqMTEwWE0zOUFDVG5obDA4V2Z1NWlpb1JCRnVQ?=
 =?utf-8?B?aVpIcjhUUU5yV1daanByNWxxd2Qvc3lscXRiUmhQZ3FoT0V0SnU1L0dSVysv?=
 =?utf-8?B?TkJFUzg5MFlxM2p3cHBjempKT1pTcU5EYnQ4ZmV0RGlXdEprTDZEZ3RZd2d5?=
 =?utf-8?B?d1BmV1ZUeEdUL0ljRnI1bG16aWw3SUZicXF0QUtoMHVvR3hGNytBZUtJYVg4?=
 =?utf-8?B?UTcyYnhHQi9aUEN6VWFPNy9wc2VHSkMxeXRJc3c4WUZPRU1iQ0QyN1hDK21S?=
 =?utf-8?B?eHRCWjl3VE5GbDh1UmwweUplWVliSGE4cWZLSFRPYzRqT2JwbWc3eE5FaW9a?=
 =?utf-8?B?cVJtTUxlZk85aEZvUGlVNkNFNkExeWtIRGpQdlJweWh1d1RNNm04WHc3Unpu?=
 =?utf-8?B?RVk3MFFYVlJGTXFWaVlva3lEck1GSk5Iell0QnNWN0YzUjIyZ1VxcUdLcVVH?=
 =?utf-8?B?RHRab2lmV3FOUGJrMDJ3b3RrSlRQWWhPblRUcElnZE9uSHJ3TEFoQnVhZzcz?=
 =?utf-8?B?UXpVRHZwaWsxU2JkNW02M1dOcFFFNXBPZUN2S2dodzZUc3hnNHVydkdvVEta?=
 =?utf-8?B?Y1hlY09OMi96Vkw4RHFqYU53Qm1xc2NIM3pEa2p5V3laWmNvZ09oNGtyUzd2?=
 =?utf-8?B?a3NZUHNoeU1KZWx6a3dPUUhUcUd4RFJqSSs4aUhCT1RNU2VYY2dwdTBiTVc3?=
 =?utf-8?B?UWdDK0dXOWxDUERpVWtFa2xBWTVFMHhmTmVQbEowQ3lDRkZRQktOUWM3TnJR?=
 =?utf-8?B?RythSTd1SnBnVnJHdzdhYXoxbzU3THZFK2xuaFFQeVM0Z0dxNWdrYkVPWnRv?=
 =?utf-8?B?c3Jqby9EVEVreU9STTgyWlEzVHNZT3FyVncvWEU2MDdKbXNJL0NPWlljN1F4?=
 =?utf-8?B?UEtWcVhUWmZoZUJaT3lpemgydUhMak1sRGJKdUVHdE50TVVsOUxSYWtRMFN5?=
 =?utf-8?B?U05HcnpwVENNRE1SSm05VzdiZU9aMEtzUjJEa29Yd0ZUaWk4aWZ5ZCtmQi92?=
 =?utf-8?B?Nklmb0doRkl4RE1OdzZlQ3BiQlZMdmZkMDgwK0lSQUNCU21tbjdrUXR6aG1J?=
 =?utf-8?B?SEU0UXhBY3I5T1dGOHlTZGh2MlA4UjNCU0xYZmhjcFJPSGdFZzVIeGdoa0pH?=
 =?utf-8?B?OWNUUHkvQS9yNWJPYWdxWFRnRzV5MnppYUtqMzVMTVg2R2J5QUlZanpPVlN4?=
 =?utf-8?B?MzY3TVowYnlUWGZDb1ZKRFJ5bnlpdG5YQmtXVXJZa0huS01qQzQ4WkhXMHcy?=
 =?utf-8?B?KzFidnNSbWp4ek5uMEk2WVBDTjd0eExCdjUzUGJUcHFPdG53L0NFa082aGxs?=
 =?utf-8?B?bm41QzZGYWprMjA3R2c1bCs2eEJLQjV4SHhEc085ZXVHMlJKUWZxdkNJRElx?=
 =?utf-8?B?RGc5SDZIRDVDUzl6RkplRFUxWU9JbVBDMWxQS2tINU5kVlhXYXprcDdSQ1Zh?=
 =?utf-8?B?blVOb0FzWFlZNm9Pc0paTDlDWkt5UG4yY2RsMXBIUUJ6MUUya2hFNlVNWHJw?=
 =?utf-8?B?UlY1bU5PWE9xN0plUi9TYzJydGp3ZVdwdGlTSFRIVzlLWitlRkErRFRWSUJr?=
 =?utf-8?B?aGkyWHhjRkU3M1Q5UW1yazVWQzNGSU5leVpQazhvbUFiNE4xL3h1TlUzeDUx?=
 =?utf-8?B?RklCWERpa1p1WGkzLzZXamdMSkI4aDROSUlFY2NYT0MwQW45bGxlR3hoUmhy?=
 =?utf-8?B?Y0kyTzA0Z2x3dUNNUTdtUFRMbWlhYU5OUmx2T051Sk9NcXZRNEdPb01tajZN?=
 =?utf-8?Q?ETmG49IM06cI5NGm2RiHwOdO72RRdKTP3lXfc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnBuTVAxMTVjbnZ2VC9DMTVFbUZtWi9XdkZOT0ZXZkROd3g3akpoYzg4UmZz?=
 =?utf-8?B?anZldHpNOEYyczB6eTRtT0Z1L2NoaDFWVWNaRVU2ZEdGSVNqV1lHQ005SlBL?=
 =?utf-8?B?VEN6VGhJRkdueURLcW1SWll2TC9vaGVtZytVMW9KZlNMWHpVNFhjbFkzaVV0?=
 =?utf-8?B?V2ZpdjlhMGhxZGx3eFhzNG1tdlhhcGZCSWZNYXhyZmNIbVJsMm9qQ0Y0aENp?=
 =?utf-8?B?ZCtnbTN0OHBSdDl0TUFlQTY1em5Lak14azR1bUFiS0RLVlBzUDlDNHBVZ2h4?=
 =?utf-8?B?eE5lTWtNcU91M0c2dGdqQmZkV3RwTDY2OVorYldvYzN1aFBqazMxbmdzNWFi?=
 =?utf-8?B?NkRmZ2VBNFViZDBKOVdDcGZGS251UmVTSHdBL2xUazd0NlJReUFaMk9EelY2?=
 =?utf-8?B?bldzUmE2MWZNbWd5N2c2ajlmdm9KMmJNZDY0V0Z6SkdHYUpWVlN2Q1NvSWFm?=
 =?utf-8?B?OG9qaWZyOHRYbElEbVFicmZaa2FneUVOOFhBOTZXZkloSmErZGhzOFZlUEhq?=
 =?utf-8?B?YkpDTlVjOExBN0N4dlFpN3k5NGYzdUpzdnpjYk9lbFpvZ1NTbmsxSlZlYkk5?=
 =?utf-8?B?NTdWNTV2MnR5WmVUbmZrREhlTms4T240U1Y3K0FOT0hyNmF1eGdnYjVrQ2xN?=
 =?utf-8?B?c1Q2d01QVk9sd2ZCMHRwMWg5Wmp6clBkREQwNE4ydWVyUFRsTEJiR1ljT2tl?=
 =?utf-8?B?WWE4RGxQZTdaaGphK2FmWXJOVUg3UGp3YWtlVXAzQmE3SFF0cVhpamdmS3dy?=
 =?utf-8?B?RHFzWU1YZVdEeXU3dlpDL3YzYWlUM2M4WklqOFNkR1JEdmZIMFRSQWN2bDh3?=
 =?utf-8?B?cU96NGdwSFNlQXRBeVp3SGR5YUg5VXFSN1JXUHFiNkIzWDFEOUc3Q2srSUsw?=
 =?utf-8?B?RnI4bUtINDlRV04zbmtlNTV2OW5Ha1JoY1huWkpJWFREYTB0dngzUmVtY3V2?=
 =?utf-8?B?dFRoMGIrcldiWkIwSzZmY3FxMnA4YnJBSkJ6eHBqUXRKcmRvWmRValZqWmpy?=
 =?utf-8?B?aElXYXduUWFLSEpYbDBXaFBHSWhQV0RZN1N0VU5Qc2JNZ20xdFF5N1JTTGt0?=
 =?utf-8?B?ZkY3RkxpazhXQjM0VGlrTG0xUjZKRFIzbVVBR3dzQ2FLd1QxQkJvYU5HNVZV?=
 =?utf-8?B?SDlDcnMraWdSc2RuK01ZZFF2ME55SVJSWld2NXVmU2k3aEczL3oyTzl1NGZp?=
 =?utf-8?B?Wlh3VWhsRVdLMFFRV3JOYU1jTlpoRVNmbzFacnRROURla2hsMThKSnZwVnBr?=
 =?utf-8?B?ZTc3ckhCcGJLSWVQSStxRW9UYWExSUhBRXpXeTFaZkpyaWhZdnZVRmVyN0dH?=
 =?utf-8?B?Q2RTdnBzWVRYQlAwM3c4dDdPNDM4NFNOb2RTN0tYUjVXVXZZcVE2V2s4eFNF?=
 =?utf-8?B?dW5FWTdzV0F5NlZTeWFmVHBocnRqRVhCSXE3UXhzRnNBdnR2ZUFtVWRDWWhO?=
 =?utf-8?B?UzIxR2tuYnZOTHpuOGorVlllUFdNV0k4TkswelE0ZVordEdCcTdNcERWM1Q5?=
 =?utf-8?B?bysxLzlpZDVKZHBFQWpybnZSZkt2VVNmTEsvTitNVWNHc0lzWS8xYkF5eVNP?=
 =?utf-8?B?aUt2cnBjcDRCVlpJemViOUpudThvSlo5b1JtbGRtc2ttMFlWbm5QZnRydm9s?=
 =?utf-8?B?dE01K3lBNy9DWnR2RnYrUTQ5Q2ZNbjlvWUwyZDJnTVpsdzBDbUpUYXZRcWxD?=
 =?utf-8?B?OVZmaXRHelZqR2Vlc0lrNTUzaXBLc282RjJQdUZvRldLWnQrVTNENkRHNTcv?=
 =?utf-8?B?SHFCVzkwSzg3bms3QzdabmdrbWtQQ3g3cnFwZFBUNVhudlJRQWtRYXVRbTFN?=
 =?utf-8?B?Z2FVbDNQY1ZRZE93bzJpZndXYlNSZWQyczhqMnRKNjVxNTgrY1Y1dVM4UDdC?=
 =?utf-8?B?Q2pGT0lUS2hJSmJBNmxmUGhGd3luREFMRXRZcXROSFFOTU1iVUxDS1BicXFy?=
 =?utf-8?B?aytvYWdUQ3J0dWtadXZ6cGpYOHJUZFczNEQrNHpvZktuak94bnRRNHpIMTR4?=
 =?utf-8?B?MUFaV1ZvdlJRdWJmcFlJUTErRWQvL044UlVUNlhCM3lvb2IyMzQ3em5ESitv?=
 =?utf-8?B?YWNCaXY4ODhnL3hLWnNJR3NWYVdlcjRoQnpreEIyUzM0UDhtT1hJTW9mWURQ?=
 =?utf-8?Q?H1uP5vZjlkI+Dl3Xuu+6TXI9V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a64393-81c5-4304-4a97-08dc90d5af6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 03:04:22.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EaiThS/gS90zGBNRQqyelnuo3RH4uT3SmKR1e9yb8+RpOykIxvoockcbKoDomCvc7ulTuMVi2QVJq9lcrMKNSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6914
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSAyMCwgMjAyNCA4OjUwIEFNDQo+IA0KPiBPbiA2LzIwLzI0IDEyOjQ2IEFNLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gV2VkLCBKdW4gMTksIDIwMjQgYXQgMDk6NTM6
NDVBTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4+IFdoZW4gYSBkb21haW4gaXMgYXR0YWNo
ZWQgdG8gYSBkZXZpY2UsIHRoZSByZXF1aXJlZCBjYWNoZSB0YWdzIGFyZQ0KPiA+PiBhc3NpZ25l
ZCB0byB0aGUgZG9tYWluIHNvIHRoYXQgdGhlIHJlbGF0ZWQgY2FjaGVzIGNvdWxkIGJlIGZsdXNo
ZWQNCj4gPj4gd2hlbmV2ZXIgaXQgaXMgbmVlZGVkLiBUaGUgZGV2aWNlIFRMQiBjYWNoZSB0YWcg
aXMgY3JlYXRlZCBzZWxlY3RpdmVseQ0KPiA+PiBieSBjaGVja2luZyB0aGUgYXRzX2VuYWJsZWQg
ZmllbGQgb2YgdGhlIGRldmljZSdzIGlvbW11IGRhdGEuIFRoaXMNCj4gPj4gY3JlYXRlcyBhbiBv
cmRlcmVkIGRlcGVuZGVuY3kgYmV0d2VlbiBhdHRhY2ggYW5kIEFUUyBlbmFibGluZyBwYXRocy4N
Cj4gPj4NCj4gPj4gVGhlIGRldmljZSBUTEIgY2FjaGUgdGFnIHdpbGwgbm90IGJlIGNyZWF0ZWQg
aWYgZGV2aWNlJ3MgQVRTIGlzIGVuYWJsZWQNCj4gPj4gYWZ0ZXIgdGhlIGRvbWFpbiBhdHRhY2ht
ZW50LiBUaGlzIGNhdXNlcyBzb21lIGRldmljZXMsIGZvciBleGFtcGxlDQo+ID4+IGludGVsX3Zw
dSwgdG8gbWFsZnVuY3Rpb24uDQo+ID4gV2hhdD8gSG93IGlzIHRoaXMgZXZlbiBwb3NzaWJsZT8N
Cj4gPg0KPiA+IEFUUyBpcyBjb250cm9sbGVkIGV4Y2x1c2l2ZWx5IGJ5IHRoZSBpb21tdSBkcml2
ZXIsIGhvdyBjYW4gaXQgYmUNCj4gPiBjaGFuZ2VkIHdpdGhvdXQgdGhlIGRyaXZlciBrbm93aW5n
Pz8NCj4gDQo+IFllcy4gQVRTIGlzIGN1cnJlbnRseSBjb250cm9sbGVkIGV4Y2x1c2l2ZWx5IGJ5
IHRoZSBpb21tdSBkcml2ZXIuIFRoZQ0KPiBpbnRlbCBpb21tdSBkcml2ZXIgZW5hYmxlcyBQQ0kv
QVRTIG9uIHRoZSBwcm9iZSBwYXRoIGFmdGVyIHRoZSBkZWZhdWx0DQo+IGRvbWFpbiBpcyBhdHRh
Y2hlZC4gVGhhdCBtZWFucyB3aGVuIHRoZSBkZWZhdWx0IGRvbWFpbiBpcyBhdHRhY2hlZCB0bw0K
PiB0aGUgZGV2aWNlLCB0aGUgYXRzX3N1cHBvcnRlZCBpcyBzZXQsIGJ1dCBhdHNfZW5hYmxlZCBp
cyBjbGVhcmVkLiBTbyB0aGUNCj4gY2FjaGUgdGFnIGZvciB0aGUgZGV2aWNlIFRMQiB3b24ndCBi
ZSBjcmVhdGVkLg0KDQpJIGRvbid0IHF1aXRlIGdldCB3aHkgdGhpcyBpcyBzcGVjaWZpYyB0byB0
aGUgcHJvYmUgcGF0aCBhbmQgdGhlIGRlZmF1bHQNCmRvbWFpbi4NCg0KZG1hcl9kb21haW5fYXR0
YWNoX2RldmljZSgpDQp7DQoJY2FjaGVfdGFnX2Fzc2lnbl9kb21haW4oKTsNCgkvL3NldHVwIHBh
c2lkIGVudHJ5IGZvciBwdC8xc3QvMm5kDQoJaW9tbXVfZW5hYmxlX3BjaV9jYXBzKCk7DQp9DQoN
CnNlZW1zIHRoYXQgZm9yIGFsbCBkb21haW4gYXR0YWNoZXMgYWJvdmUgaXMgY29kZWQgaW4gYSB3
cm9uZyBvcmRlcg0KYXMgYXRzIGlzIGVuYWJsZWQgYWZ0ZXIgdGhlIGNhY2hlIHRhZyBpcyBhc3Np
Z25lZC4gd2h5IGlzIGl0IGNvbnNpZGVyZWQNCnRvIGFmZmVjdCBvbmx5IHNvbWUgZGV2aWNlcyBl
LmcuIGludGVsX3ZwdT8NCg0KPiANCj4gQSBwb3NzaWJsZSBzb2x1dGlvbiBpcyB0byBtb3ZlIEFU
UyBlbmFibGluZyB0byBhIHBsYWNlIGJlZm9yZSB0aGUNCj4gZGVmYXVsdCBkb21haW4gYXR0YWNo
bWVudC4gSG93ZXZlciwgdGhpcyBpcyBub3QgZnV0dXJlLXByb29mLA0KPiBjb25zaWRlcmluZyB0
aGF0IHdlIHdpbGwgZXZlbnR1YWxseSBoYW5kIG92ZXIgdGhlIEFUUyBjb250cm9sIHRvIHRoZQ0K
PiBkZXZpY2UgZHJpdmVycy4gVGhlcmVmb3JlLCB0aGlzIGZpeCBjcmVhdGVzIHRoZSBkZXZpY2Ug
VExCIGNhY2hlIHRhZ3MgYXMNCj4gbG9uZyBhcyBhdHNfc3VwcG9ydGVkIGlzIHRydWUgYW5kIHJl
bGllcyBvbiBhdHNfZW5hYmxlZCB0byBkZWNpZGUNCj4gd2hldGhlciBkZXZpY2UgVExCIG5lZWRz
IHRvIGJlIGludmFsaWRhdGVkLg0KPiANCg==
