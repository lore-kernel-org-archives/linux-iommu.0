Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA0A23DE
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 06:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740724331; cv=fail; b=qdeS/JHWpHFl3m39MCIjM4Slhy7k7FuWwS4HvjBTb7e/qMvGFRb9xO0zxzei1XyZaAEooZz+hgcWWwFVDmEd/ZKwKeDgFaTDSE6Bq2NWDokPwEVgp8QafO+YoIpsDqYNdDCUjbSp4vaJPAeEOJZC15jvjD0PeNHjmb9BcdfE66c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740724331; c=relaxed/simple;
	bh=sk0P0Jvg5g6Ie0QVFaBgzbdK0+WH0P0gmBX799/meQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VXWlYVh2prdhm/t5g3NYeS/rL+b4fQN8PVvdF4HPg84xBpmMrry7VU7hinBXwMAT+xHb5lk/uXFBM3G7jSCHYWy9kpDxSd2BpwuxcmUarn9ZmWWYUlgyrXyGiZhQIvkwzUruzYhJgutrSmmJYJYzWStTCsG4E3vF02ESrvJ0qC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM+dYATw; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM+dYATw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740724329; x=1772260329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sk0P0Jvg5g6Ie0QVFaBgzbdK0+WH0P0gmBX799/meQU=;
  b=NM+dYATwx9rZkZxjhZp8Z0eUhi6EOA+h9geZhMLcbbWFgAoeB9aPxAKR
   P9ebikUBnswXmpXOyjY1Rnf1MWd/uRuK/zPXJihyMiHGytBzU5kIBMHrC
   n8ELDgovKdB9sLlGoPRuovxgbt0NCEU2t07mIyf7tFR2hzFykiYTrovTJ
   moyIFeYSwIof4uinaRF2y1owtEDSHDLF+Bw9nQjERkXHBZCAT+3kdYhUD
   8HdWaLsP2S1m/g2skRtGhHOvarRxEzAiFlFsmQ6Ogk7t47Sk66U4N/BjB
   8TfAQmZmy88wvtwl/1f6hx5ssRaXe9Clxb52yORbtyIFIZegebI0/6x9o
   g==;
X-CSE-ConnectionGUID: bRt+IsGkQy+NUiETBmx3Cg==
X-CSE-MsgGUID: OhFe/MO5T2yunmK/AWnUvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53054162"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53054162"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 22:32:08 -0800
X-CSE-ConnectionGUID: GObuVjXtTb6f9ISoh2eJjg==
X-CSE-MsgGUID: u7VUh8iwSUmGNHplLN+w8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="122381440"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2025 22:32:07 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Feb 2025 22:32:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Feb 2025 22:32:07 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 22:32:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJDA04Q8oYnj8tYbYRXqwpPEHfD9UikXx5gopxi3BFONKgh/49RJ2jFeskNEZzy9ZkMeyNYMOUFSltggZKgvTV4hvTkJa4RfDX8hAprY8jqc/eZ3VY3KWj61XT9hz/NiOFahpjl8OIrCHXNokN9CdvDtzhbAGexLQpj2HsOBvfXxSVeoeDzuMzo+nx+tdpguEtJX5LPbUhNcpWN340NH2f0UwePW0OxzKMMAokLGkGXkG5CU5XGIeaPEObgl652NHV2kLJaziMEg46JGvdOGPL7Q/k91k2uerW5+dePRTMX7MiVstPnxBxCzaKFxF47PVkSSE6QPMwlCRQIBFYYZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sk0P0Jvg5g6Ie0QVFaBgzbdK0+WH0P0gmBX799/meQU=;
 b=r6Zq1YKXJFQP+VNpekWx/J3DRuHsoMxDUUxkYh++a4KQP/pbQ7lxP8NFpjLchJxtLPzaYaS2rLHAwhsvz/r9Mx9ZJtfMtcwZv4CczDFuO2Y+L2T6CHMi5yNT9tQhbaiIgem/wv6HtIBw7nKM8d5pmtZSVdmyYTEXoIVigjCr6HHBXCmCYCSDu3n6MDLKCHYt1eBgcRBKPxIErzvci6TaQxvrq8y1fs+T1nwNgqKFDPEVoihGFKDDvM9QD8zbzZkzslXpDHnJMDKslosCx1fBdFjpLKNADGzRnKRtS2IAlsm0jmNAAPIa19wdib2SGju4jdRKy+FlxRBVkknuQLFIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH3PR11MB8435.namprd11.prod.outlook.com (2603:10b6:610:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 06:32:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 06:32:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsA==
Date: Fri, 28 Feb 2025 06:32:05 +0000
Message-ID: <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
In-Reply-To: <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CH3PR11MB8435:EE_
x-ms-office365-filtering-correlation-id: 79f9e426-bab1-4cec-959a-08dd57c19e3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWdYTnpRYzlwdUs4UlFNeFU5U1h6SkNLeEJIaHg4aGw1eGxoenBkdmM5d01Y?=
 =?utf-8?B?UTRnNXE3WXZBZmZCbXMrMk1vaHFQOXIyYm5UR3pDRWpGK1VmbzUybGpDc1o4?=
 =?utf-8?B?TVdHTE1SOUpOQ1hQQTgzVWJhaC85cW1IWk9LWEQrTHBDWlFRWkhKOEFPTFN5?=
 =?utf-8?B?R0lwdWJYUGlpVEFTQkxNcmNYMEVwUFdRSDloVlNJNFJ1bWNMMXZ4TndHUVRL?=
 =?utf-8?B?VFpqM1Y2MmFxR2pwZnNEekcra1VjOTlxcUc1Uy8xSjhpZ3dFaXJ0NXVaeFd6?=
 =?utf-8?B?WFo5UmRPY2g4K2FST1hhWk1BL3pJVWt1QlBOWGh5Qld3SWVJYnBWT0h0RldL?=
 =?utf-8?B?blIxekZTa3VPUVZGZkkxUDlmR3Jidmd3c2NSVll2QVhYOGhPWnFUVEN2Mmd3?=
 =?utf-8?B?d1ZPc2h2c0NRUm1wV3F5WVVrL2hlUXhUUU0zdmRRbm4zakQ2Slh1dlUvakth?=
 =?utf-8?B?b1VCb2dGUFdVaG9JdjNnTGVIK1NTUmJ2Y2kxVWplbXFXdFFHZ0RHTFdySjB6?=
 =?utf-8?B?MkRmRjdxQmZML2gzYnBXT1BjRmJSTFhQMVhyQmJuRDcxaXU1SFh2enA0bXdT?=
 =?utf-8?B?UkVjSU1DZmR0YWw1bVhWRWhHa2VUdVJKYmtTOW50R3FFWGtyME11WDhST3la?=
 =?utf-8?B?aUxoZFUyNmdDYnE4MVNYVFFtcTNsK3pqQ3QvRlJTWDlkZHM1RFgxOEN3b1Vl?=
 =?utf-8?B?eXpwQm1xM1I1TnRiaUtNM01vbGt6c1l4QU1VREtwL1Y1QW82MkpteU0wUEV0?=
 =?utf-8?B?TlY1OHNsOXV6UHBxVmJnNnJQZHlBM2w3Z012TlpUbnRYdjhjQ0RZS0ozWnJn?=
 =?utf-8?B?ZTV0SllyOFZTYkdoNmNKWmpEMGNnV3dGOUV6QzhIMlcvc1ZYajlqQTlSL0pS?=
 =?utf-8?B?NDRkYks0S2laQnFleVc4WGJKdVk5Zmt3dytjUjQ2YmdER0trb2tGV3oxcGc5?=
 =?utf-8?B?ZFpURFdZWktxVmoxR0tqYnc0ekJEUkIyNFdOOGNCM3Vqb1VYREtKcU54ZlZS?=
 =?utf-8?B?OTRsdm56eDg1Wkk1aDY4bUtKQnEzbmRocXZHMU0xQmNGSkFENkpWYzBickcr?=
 =?utf-8?B?cTFQM1lzMlNVSE8zLzBRNmk2bkE0S0tvTk5jVEtHN0lRQXNzKzJaNER2QUxl?=
 =?utf-8?B?MVZmSGFGTElLYXV3NnRMblRPTTcreHpqVHZTdUN5amJVcnY5bnhXcVc3RzlC?=
 =?utf-8?B?UzVFNUJTWTk0Q0pYVC9xZlMxODg2SjlKdkl0c3RGMVk2NmZ6YTdoV243WVVh?=
 =?utf-8?B?MERhem9QSFdCUDZsQUFvYnpud25zSFI2ci9DdXYwZW9ETWFBVEtoT0tHaEoz?=
 =?utf-8?B?YVpPVVovWUxnMHFrcG1KeEp3NTlqTE04UENaNUYwaGV4K0w0elNxZithNXp4?=
 =?utf-8?B?QXFFaDB1cFJmWWx1TC9uaUJlYWlXYkZDNzNSb0IvMHpEM1NrRVg0N0JLTnEy?=
 =?utf-8?B?bTVSZ29nWWxSa2ZUZUZlYnp0emkyajIrRWhCV3hPd2xGRllEenpVRHNJWllK?=
 =?utf-8?B?U25lWitBaWt0VXVLZ3BjZDRDMnB4NUdDS253aS90RW5ybEpqSXgxOC9jT3E3?=
 =?utf-8?B?R3BQOExKZEpzcytlSnNHWUlyeTJVb2kxRjBnaFVQUklRb1k2Y2F2clEzT01m?=
 =?utf-8?B?UzdORGprNTdteittSjRzQ3d1OFRyRHgyK01EM2lEdmZhWFpBVmlXaXR6Sito?=
 =?utf-8?B?T2tISWcrbDZlV0ZsTDhMOWMycFFmSWJ6am1aaHhRYzczTnlRZEhuVEZwcFlu?=
 =?utf-8?B?aW9jNzVhV0d1SVFIaGZmN2JyM24xaFk5d2czcks3aUowODdHQlRLUWw2SWhq?=
 =?utf-8?B?dVJyd09wK3IzMTU2SDFJT010M1pFL3RZVmVYUlVYTk1OV0NITFZCVEwyRERW?=
 =?utf-8?B?cmhFdlRxdzgrRkwrekRKWjFDMG5Eem5Dd3hJSnlFR1B1d2xpVWxlVEFOT0JD?=
 =?utf-8?Q?wzZiDEfWCKOaeYamFKn149Hov0svXqcQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmNVSUdycUtoZW4vcTlkYzE0dmlldnRUTGhxZkVvTVdnMThQUDcya3pCY2xS?=
 =?utf-8?B?aWpWVTFiNUVURWRtbWJrTi9YVG1FSnhDLzF4emZYVjZ2eENqYUwwSjVmcFRQ?=
 =?utf-8?B?TlJSMnNmVXFEdk1VczU2Z1RlSFNPdy9udWE4cU95eUhTL1lYWi9ZSzlnNzR5?=
 =?utf-8?B?VndUeWZIQjE3L3c2TUxQRWQrTVBqQ29nbWJPS256OHc3bE8zUzdWYXdEcWZi?=
 =?utf-8?B?WnZNM1h6NzA3YUM0WHg3MjM2ZlJDOHlTMnFtcEZiZzlqaGZlc0tKNTVlV0dC?=
 =?utf-8?B?SUVHQ0l6NFpoOE9ZZGlsa29xWGg0aWV5NldsNXBBd0xDTHV0cEUxbHEycnZv?=
 =?utf-8?B?ZWkrQWRKb0hTNlB4QTVGWVZYbWdFcHRKRGdLamxEZGQ0Tjk5R0RBaHcrZHRV?=
 =?utf-8?B?K0Z2eWRYYmxmUjk4MWYwYWY1QlQxcmpqVGdaTnp4ZC9iTlVHc0hCd1ZXK3hD?=
 =?utf-8?B?S29nb2p2RHdwOVVaOUtKd25qS1RHY0tmRTUySld4OXZYVHJhQlF6NWJpWmIz?=
 =?utf-8?B?Y1htU2szbU9RSHV6Yk96cFJWQ0NDRStZVDJNNWZCVEMxNFNsRFM4WlUrbnF5?=
 =?utf-8?B?djduVzFVbW0yYnQxNW1UUkZrS09haGwyUWhLdjRHTytkWjIrd01HUEo0bTln?=
 =?utf-8?B?VE9Fc2hpQ1E0a3RxMXRqcUR1WUhhN1lOTmk4bk4vMGZHM09FalJBSHMrN05S?=
 =?utf-8?B?dkNlam00dUFwTnpLQ212N29kNDd4NXg0OGNoQnJVQStOQldPQVMzVGo0YTQ4?=
 =?utf-8?B?RFhZdHI3cWt4a2QrVWQ5TWtOSUg3SWR0eFhDMjNCbS85MzRXUXIvRm9pSkdS?=
 =?utf-8?B?bnJjbTFFNHk0RXJDcjJsZHg4Vk1mUjdJcHN3M3JydEhhdDBaOHluV3RzN1Zy?=
 =?utf-8?B?WTBLVkg2OTB3ZGtjSnZBTGpmbDJUVTg0ZW8wanY5bWZRUHdDeXhENGYxUkFM?=
 =?utf-8?B?clE4VllIVVdsTTlNRUhwY3NJNzRYdWs2RndTVk8zU3lLcWF5emlwRlhyZGJL?=
 =?utf-8?B?Rk5IcUh5TTJrODZvaDJJeG5rT1JibjVsRnE1dDVXTTZxR2swc1BJMmFTUUt5?=
 =?utf-8?B?WTZzb1JFZnJ5N0hlWmNjSndNekZJcnNHRFZ4YmhXb1M2Wm0veGY4aVYrT0xF?=
 =?utf-8?B?ZCtEeHN3UlZvQ0R2ODRzeFJoWWY4Sk9qVkdEQnpFbExBTm1xN05UM3pnMDFW?=
 =?utf-8?B?Z0hrOWg5ZVB4cjJjbDFnZk9sN1lqS2ZvcW9kU0hvMGVzUndtWHZrdkRQSWg3?=
 =?utf-8?B?b1lrOXJBeVRuS28xV2xXN216c2ZxSDF5TGJvS2FNbE90dGh1WC9oUllBOXJy?=
 =?utf-8?B?ZCtqdHRDcmtCZmRvdzhBM1NwWS9OZ2ZyNlNXOEpnNy9LWk5RT0NNcGQ1LzZG?=
 =?utf-8?B?aEFrUE5kQ0hxemo0MnJCN1FjS2VHdkVmOEJWSUJEU1VabEVHNHZXYUM1Q1Ir?=
 =?utf-8?B?OTBkZ3VNVXp1REdNUmdBUjVQNTVyVEtBZnVzRThUb3p6c0VZei8xWVorZFp6?=
 =?utf-8?B?djhRb1IzRWVhaGZqU1RMNDJsbThYMFF1NUg4Znl2ZlBKOCs2MUY1UkgrZncw?=
 =?utf-8?B?Ym0wY0djSlJldkFJTTNKSVd4VnJLaTE4a043Nm92U3JRS3dSdUpDQldQM0kr?=
 =?utf-8?B?SGhYakdHT2ZraGkxb1g4VlYrOFJxaEtBMU50cS9tSU9mSEZvT3JVaGpMUlRi?=
 =?utf-8?B?QnAzWXc3NUhIRzJCTnR1RE4zSngzb09nUnhDUjVZcng5VXRtd2VJejNMMTVl?=
 =?utf-8?B?K0ZnOHlNQXpXWUtMeDRDR0p1OFg1RVBLeFYzVnJJVGszck85TmI3UWZmaFFY?=
 =?utf-8?B?bnJyMjNRMDR5VnlGaUR2aWZiZnFwYkx5ZGNCcnpHUTlaTTRrQlB3aW5VcE15?=
 =?utf-8?B?b3UrWTBQdzgxeEduNnVnc1lvcktJQ1NURnhQdExWRnBBK2h4a3BJWEttRkNV?=
 =?utf-8?B?L2N5QTh6aTQ4RURxVXc3U042NVdnYU1xYlpIMExTNEpiVStmemRvdXBvV2lH?=
 =?utf-8?B?YXdiQytLNlpJaWxiVWswNmtTUXdxeURQdS9jdEhGNE1DYnF5WGx3dHg0Vnpn?=
 =?utf-8?B?Z2U1R2h2RFJ6YVY2WlVxRnpPY2VGM3I2b0tmMHBjUDZLSmVBZ05TZDl6blpk?=
 =?utf-8?Q?VusMYSeKUc4qZN0JngucGSVRK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f9e426-bab1-4cec-959a-08dd57c19e3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 06:32:05.1517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMb1sEJMgPb6hb8VjFBm3p/vGkBc5TXOd06W8qHR8aE5kM6FSHq0FKDH0Z55vvgsZget2pVtUdh4YvYQjk+E1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8435
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgMjcsIDIwMjUgMTE6MjggUE0NCj4gDQo+IEhpIEtldmluLA0KPiANCj4g
DQo+IE9uIDIvMjYvMjAyNSAxMjozNSBQTSwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206
IFRpYW4sIEtldmluDQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgRmVicnVhcnkgMjYsIDIwMjUgMTA6
NTEgQU0NCj4gPj4NCj4gPj4+IEZyb206IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPg0K
PiA+Pj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNiwgMjAyNSA5OjE4IEFNDQo+ID4+Pg0K
PiA+Pj4gT24gV2VkLCBGZWIgMjYsIDIwMjUgYXQgMDE6MTI6MzhBTSArMDAwMCwgVGlhbiwgS2V2
aW4gd3JvdGU6DQo+ID4+Pj4gSWYgYWJvdmUgdW5kZXJzdGFuZGluZyBpcyB0cnVlLCBteSBwcmVm
ZXJlbmNlIGlzIHRvIHN1cHBvcnQgYSBzYXRzIGZsYWcNCj4gPj4+PiBpbiBkb21haW4gYWxsb2Mg
KG5lc3RlZF9wYXJlbnQgb25seSBhbmQgUENJL0NYTC5pbyBvbmx5LCBhcyB0aGUgc3RhcnQpLg0K
PiBGb3INCj4gPj4+PiBBTUQgaXQgdHVybnMgb24gdGhlIHNhdHMgYml0IGluIHRoZSBEVEUuIGZv
ciBJbnRlbC9BUk0gdGhlIHBlcm1pc3Npb24NCj4gPj4+PiBzdHJ1Y3R1cmUgaXMgY3JlYXRlZCBh
bmQgdXBkYXRlZCBhY2NvcmRpbmcgdG8gdGhlIG1hcC91bm1hcCBjYWxscw0KPiA+Pj4+IG9uIHRo
ZSBwYXJlbnQgUzIuDQo+ID4+Pg0KPiA+Pj4gVGhleSBhcmUgZnVuY3Rpb25hbGx5IGRpZmZlcmVu
dCB0aGluZ3MsIGFuZCBoYXZlIGRpZmZlcmVudA0KPiA+Pj4gcmVxdWlyZW1lbnRzIG9uIHRoZSBQ
Q0kgdG9wb2xvZ2llcyBzdXBwb3J0ZWQgKGVnIENYTC5jYWNoZSB2cyBubw0KPiA+Pj4gQ1hMLmNh
Y2hlKQ0KPiA+Pj4NCj4gPj4+IEkgdGhpbmsgdGhleSBuZWVkIHRvIGJlIGRpZmZlcmVudCBmbGFn
cw0KPiA+Pj4NCj4gPj4NCj4gPj4gTm90IGV4YWN0bHkuIFRoZXkgYXJlIGZ1bmN0aW9uYWxseSBk
aWZmZXJlbnQgYnV0IHNlcnZpbmcgdGhlIHNhbWUgcHVycG9zZQ0KPiA+PiB0byB0aGUgdXNlci4g
RnJvbSB1c2VyIHAuby52LiBpdCdzIHN1ZmZpY2llbnQgdG8gaGF2ZSBhIGdlbmVyYWwgZmxhZyBm
b3Igc2F0cw0KPiA+PiB3aGVuIGFsbG9jYXRpbmcgYSBkb21haW4uIFRoZSB1bmRlcmx5aW5nIGRy
aXZlciBkZWNpZGVzIHdoZXRoZXIgc3VjaA0KPiA+PiBmbGFnIGlzIHN1cHBvcnRlZCBiYXNlZCBv
biB0aGUgZG9tYWluIHR5cGUgYW5kIHRoZSBhc3NvY2lhdGVkIGRldmljZSwNCj4gPj4ganVzdCBs
aWtlIGNoZWNrcyBvbiBvdGhlciBleGlzdGluZyBmbGFncy4NCj4gPj4NCj4gPg0KPiA+IENoYXR0
ZWQgd2l0aCBZaSBvZmZsaW5lLiBIYXZpbmcgdW50cnVzdGVkIHVzZXIgY29udHJvbCBhIHNlY3Vy
aXR5DQo+ID4gZmVhdHVyZSBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZS4gUHJvYmFibHkgd2hhdCB3
ZSByZWFsbHkgcmVxdWlyZQ0KPiA+IGlzOg0KPiA+DQo+ID4gLSBJT01NVSBjb3JlIGV4cG9zZXMg
YSBzZXBhcmF0ZSBzYXRzIGtub2IgcGVyIHByb2JlZCBkZXZpY2UsDQo+ID4gICBhbGxvd2luZyB0
aGUgYWRtaW5pc3RyYXRvciB0byBtYW5hZ2UgdGhlIHNhdHMgcG9saWN5IHdoaWNoIGNvdWxkDQo+
ID4gICBiZSBubyBhdHMsIHVuc2VjdXJlIGF0cyBhbmQgc2VjdXJlIGF0cyAobWlnaHQgYmUgZnVy
dGhlciBzZXQgcGVyDQo+ID4gICBkb21haW4gdHlwZSBpbiBjYXNlIHRoZSBodyBkb2Vzbid0IHN1
cHBvcnQgc2F0cyBmb3IgYWxsIHR5cGVzIG9yDQo+ID4gICB0aGUgZHJpdmVyIGRvZXNuJ3Qgc3Vw
cG9ydCBhbGwgaHctc3VwcG9ydGVkIHR5cGVzIGluIG9uZSBiYXRjaCkuDQo+IA0KPiBXaGVuIHlv
dSBzYXkgInNhdHMga25vYiIsIHlvdSBtZWFuIHN5c2ZzIGludGVyZmFjZT8NCg0KeWVzDQoNCj4g
DQo+ID4NCj4gPiAgIEl0J3MgYWxzbyBjaGVja2VkIGFnYWluc3QgdGhlIGRldmljZSB0eXBlIGUu
eC4gQ1hMLmNhY2hlLg0KPiA+DQo+ID4gLSBUaGVuIHdoZW4gZW5hYmxpbmcgYXRzIGZvciBhIGdp
dmVuIGRvbWFpbiB0eXBlIGFuZCBkZXZpY2UsIGZvbGxvdw0KPiA+ICAgdGhlIHBvbGljeSBzZXQg
YnkgYWRtaW5pc3RyYXRvcjogYXRzIGRpc2FibGVkLCBhdHMgZW5hYmxlZCBhcyB0b2RheSwNCj4g
PiAgIGF0cyBlbmFibGVkIHdpdGggaHcgZW5mb3JjZWQgc2VjdXJpdHk7DQo+ID4NCj4gPiAtIE9w
dGlvbmFsbHkgaW9tbXVmZCBtYXkgc3VwcG9ydCBhIGRvbWFpbiBhbGxvYyBmbGFnIGZvciBhdHMs
DQo+ID4gICB3aGljaCBhbG9uZSBpcyBhIHBlcmZvcm1hbmNlIG9yIGZ1bmN0aW9uYWwgZGVwZW5k
ZW5jeSAoYnkgUFJJKSwNCj4gPiAgIGhlbmNlIGJldHRlciB0byBsZXQgdGhlIHVzZXIgb3B0LiBJ
ZiBvcHRlZCwgYWdhaW4gZm9sbG93IHRoZQ0KPiA+ICAgYWRtaW4gcG9saWN5IHdoZXRoZXIgaXQn
cyBhbGxvd2VkIGFuZCByZXF1aXJlcyBzYXRzLg0KPiA+DQo+ID4gSXMgdGhpcyB3YXkgcmVhc29u
YWJsZT8NCj4gPg0KPiANCj4gV2hhdCBJIGFtIHJlYWxseSB0aGlua2luZyBpcyA6DQo+ICAgLSBJ
ZiBIVyBoYXMgYSBlbmZvcmNlbWVudCByZXF1aXJlZCAobGlrZSBBTUQgU05QIGNhc2Ugd2hlcmUg
U2VjdXJlIEFUUyBpcw0KPiBtdXN0KSwgZW5hYmxlIHNlY3VyZSBBVFMuIEJ1dCBkbyB3ZSBuZWVk
IHNvbWUgd2F5IHRvIGluZm9ybSBjb3JlIGxheWVyPw0KDQpJdCdzIG5vdCBjb25mbGljdGluZy4g
V2hlbiBlbmFibGluZyBhIHRydXN0ZWQgZGV2aWNlIHRoZSBkcml2ZXIgY2FuIGRldGVjdA0Kd2hl
dGhlciBzYXRzIGhhcyBiZWVuIG9wdGVkIGluIGJ5IGFkbWluIGZvciB0aGUgZGV2aWNlLiBJZiBu
b3QgZmFpbCB0aGUNCnJlcXVlc3QuIElmIHllcywgdHVybiBvbiBzZWN1cmUgQVRTIGFzIHBhcnQg
b2YgZW5mb3JjZW1lbnQgYW5kIHJldHVybg0KLUVCVVNZIGlmIHRoZSBhZG1pbiBhdHRlbXB0cyB0
byBkaXNhYmxlIGl0IGluLWZseS4NCg0KPiBJZiB5ZXMsDQo+IG1heSBiZSBoYXZlIGFuIGRvbWFp
biBvcHMgc2ltaWxhciB0byBkZWZfZG9tYWluX3R5cGUoKSA/DQoNCnRoZSBkb21haW4gZm9yIHRy
dXN0ZWQgSS9PIHdpbGwgaGF2ZSBhIHNwZWNpYWwgZmxhZy4NCg0KPiANCj4gICAtIEZvciB1bnRy
dXN0ZWQgZGV2aWNlcywgIGJ5IGRlZmF1bHQgZW5mb3JjZSBTZWN1cmUgQVRTIChtYXkgYmUgYSBk
b21haW4NCj4gZmxhZykNCg0Kb3IgdGhlIGFkbWluIG1heSBwcmVmZXIgdG8gZGlzYWJsaW5nIGF0
cy4NCg0KPiANCj4gICAtIEhhdmUgYSBjb21tYW5kIGxpbmUgb3B0aW9uLCBzbyB0aGF0IGlmIGFk
bWluaXN0cmF0b3Igd2FudHMgdG8gZW5mb3JjZQ0KPiBzZWN1cmUNCj4gQVRTIGZvciBhbGwgZGV2
aWNlcywgaGUgY2FuIGRvIHRoYXQuDQo+IA0KDQp3aGV0aGVyIHRvIGVuYWJsZSBzYXRzIGRlcGVu
ZHMgb24gdmFyaW91cyBmYWN0b3JzOg0KDQotIGlzIHRoZSBkZXZpY2UgdHJ1c3RlZD8NCi0gZG9l
cyB0aGUgb3ZlcmhlYWQgb2YgZW5hYmxpbmcgc2F0cyBicmVhayB0aGUgcGVyZiByZXF1aXJlbWVu
dCBvZg0KICB0aGUgZXhpc3RpbmcgYXRzIHNjZW5hcmlvPw0KLSBkaWZmZXJlbnQgc2VjdXJpdHkg
cG9saWN5IGJhc2VkIG9uIGRvbWFpbiB0eXBlcywgZS5nLiBvbmx5IHJlcXVpcmluZw0KICBzYXRz
IGZvciBpb21tdWZkIGJ1dCBub3QgZGVmYXVsdCBETUEgQVBJIGRvbWFpbg0KLSAuLi4NCg0KQSBn
bG9iYWwgY21kbGluZSBvcHRpb24gZm9yIGFsbCBkZXZpY2VzL2RvbWFpbnMgaXMgaGFyZCB0byBt
ZWV0IHRob3NlDQpyZXF1aXJlbWVudHMuDQo=
