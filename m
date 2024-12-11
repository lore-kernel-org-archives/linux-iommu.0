Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03F1EC4D9
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 08:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907527; cv=fail; b=MJvmq6Gj8exnCM6jjaRQf/WLJLcaRuWjW1dlkWnIsFTA6zeumg5orBHsXvAssZ6EaQ/Q/k+qyfN1XVilUeOei9B05P1KPBU4XtBamlDFl0z6UDBXfNJsV20Q8Mh/vEQM8Bsuf7+22kdMhuV/Opry2I/560xIrUYka2QGVMxmCbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907527; c=relaxed/simple;
	bh=x9FtM8wr2s0mARyqoK/QnKAvTWxLu78sEAzHuoYdOEc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gn2vn6oa2H5YWuc050czD8Hz8/tT+obsWtFqsk62No04G86aCrkdDmFZY19Ycyt7ixXrsg4wxHTyH+GS3Pc4YgWpU7IEuseV9zBQjaG+tA/F+PCecs7zRJcZN+Gh4BMeFENkWWmEcBJG9eJkZFHnPe6XEx55WtH0/7GIEHGIeIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hahKMkAL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hahKMkAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733907526; x=1765443526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9FtM8wr2s0mARyqoK/QnKAvTWxLu78sEAzHuoYdOEc=;
  b=hahKMkALOU5jZcoNtPoPKqpqwdjT5+/pcshczgxDJH9+xypedrkVWMra
   2xgRvVncjB6MWmCc0WiTwMkMyj1RX4TjyGgm1s4kRaxNGIwPQg1T4XMDc
   ilnyDHtYufaP5syR1VoyXVWYMup+zJxJQzB1VT1tjNalBObJOEGnc2R2k
   VFGi4XGSA6q7fCOkxzbprUz/1JaqBwlQQwNC5E2nTJTlvcaki3+/z5X03
   bVpi4YrpNr/lZLX5Zn0uekgzrx+HjRaL13FDYaySOcIBcxtinEemMf5LM
   STT/zvb9MN7nkmPh7RvOefGMM/RAMfbXwn0yVF3JljRxd9CEnTYGAII3F
   Q==;
X-CSE-ConnectionGUID: jm6grb/LQbW/wbLfNzaSgw==
X-CSE-MsgGUID: Kdt8Qu6cRzuy1rMXChE9hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34009072"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34009072"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:58:42 -0800
X-CSE-ConnectionGUID: 8pHf5+aQTL6p5/ucN+73Iw==
X-CSE-MsgGUID: p4KQT75PT2uFT2rPpDxTrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96173101"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:58:42 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:58:41 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:58:41 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:58:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYyrWbF0/a+2BAvpK3JS21ail+FXNAVLdYCC7if4xH5MRzi9zI7GumPFVUvy/yuZdGu5veagERxrHi71/VPdpjB04H2ftgrsh+jfAz2qtdsxZuCIG+p2kAV810YsSQEKy6fwIRSW7yOgp5p9PIk/b65jJRyuGSyODXE+1gsD8zIbz5GLNNfN5ZUgP+ieBl13dDwyrQYGlpspP98ve2G7qwiIxzUtO8lBn8+SBr594ZVt1fw/iCsurm2PWerh50yX4vOqMkLFl3GERgBMiOstewidM3TuIwdWd1hzfkB1tWvwT//4CGrHBFmigavw5hf8B8JW3bRxg/5nCeCkceMC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9FtM8wr2s0mARyqoK/QnKAvTWxLu78sEAzHuoYdOEc=;
 b=L3snhyp8mq5lMmS0FMAlqj2MOXLhJ8hFXcsIKQt7a+gV/unehpHOpp0QzjNB4hyy4UJH13MkxBYtDSKbj27us5YGu/6i7jyKnrBo83XU+p2g4Flugke+7+u4r08mKs/xn/0Z432uXoWePpRElrWtw7kG/kdud1KujpWnV/E3bJTkdP7Gwdo3ADSOYG+uq6APl1bLDZJZVTlMCVRGdLt/XFAjbKGBF3s+3maAYsnK5LcYTZ1xuQg3Ne73hSJb/ZJfpc69mtEL3+NEI0cY3h4oYEP0pjfnpt4zqqgje6GLJyHYaYaMuOydecsUoE0zJsZpmFF5oCdzJL9EX0PA4qMb5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 08:58:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:58:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Thread-Topic: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
Thread-Index: AQHbSJ+9LtYPJ7zXa0Ch7XYZAnHxYLLdHIYAgAAc0oCAAMzoAIAA9+QAgAHFUPA=
Date: Wed, 11 Dec 2024 08:58:38 +0000
Message-ID: <BN9PR11MB5276FE72F52332E1BD40AE288C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
 <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
 <20241209150514.GD2347147@nvidia.com>
 <95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com>
In-Reply-To: <95a85b9b-a17b-4df5-a1ac-7a0880950960@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6492:EE_
x-ms-office365-filtering-correlation-id: e6281ba3-0a1d-453d-5d1b-08dd19c200be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2g0MmU4dlBiMVY4RHhCUlRYYitTNHc0UnJaQUZmaVFMVUtZVDU0R0M5MFRF?=
 =?utf-8?B?YXhYVjVKNWcydUdqK0J2MERRYzVEa0k5SEs0NTB3RzE1U3N4ZFZtQ3VNM21h?=
 =?utf-8?B?NXA5QmtoVEc4Q09weW5RN3pLY3RBNkwvczl0K1J6bExuUlBoNFJ1cVFwVkpM?=
 =?utf-8?B?ZjJuOU8vMWQzUTZpZ3lzNGlWbHdTd243QnBzdUhseStvTkxNdmh2ajlUTWRn?=
 =?utf-8?B?eEUvMEp4R3hxNWZoVUZ6RU9vK2dNVjIrRS9ERW9Yc0hsUklNZ04xa0ZZOC9y?=
 =?utf-8?B?N0RxVWRFVDhraDk2c2tSaFMvdElrNlp5V3kzU2Z2V3ZmUGF3bEd2U0ZEeEtq?=
 =?utf-8?B?QVU3WVg4ckxmb2xReDF4SThoTnVRdjJBZlVoZUwybFRWYjFtMlBVRGpTUGVk?=
 =?utf-8?B?V1NPM0g3Y1JxWHlQeEZHcUFnV3c1NDZyNzVicXdhREM5TlUyVkVhdVhWZ0F6?=
 =?utf-8?B?L0F5dFo0M2FqVk1WOC9WNVZkMXo1VDBlK1dQajF1UlVTOEJnYVJoUzdvRjZN?=
 =?utf-8?B?VjN4ZDVDYmlPZlkxZnE4MzZkcFZOMG96M0k4RnNVN1FRUENxRzRZYitkM1B6?=
 =?utf-8?B?em0rRWl2ZDZvMTRKZjBDNERDUGErV3haZ3V0cnN4ZkF3UmxpTUZpdzRDNXRL?=
 =?utf-8?B?a25uaHd2eG1NbU5BUTQ0TG5ZNk9YWktxUjVtWnZFTlBjK1RMYlliblBzRUc5?=
 =?utf-8?B?TFNUem5yZnRMVG5hSU1XK05VaFBuOWY4RitDblpYNm5FREU3YWlVTC9OaThk?=
 =?utf-8?B?VkM4STJDOTlXWm1zQm15dFAzV0N5TUJ3VDVLQzVGM0V2LzZLb1dYMVgyN2hn?=
 =?utf-8?B?QVpHRG9IQzJXbXFMdExtVFh2SngyNXBJb2RLM0xzWDJiVUtKakZtM0JYNUZQ?=
 =?utf-8?B?VGdPM3RETHFubWg5Tk9UWWVSdDNNaDU2TWlDRTY4ZzIyUDR2RVh6TmlPa08v?=
 =?utf-8?B?QmwvT2M4VVRRbGMvR1FVK1kwOEZPVmJlV3ZCYkgzNGMwQWN0UjNaYkpWR1cz?=
 =?utf-8?B?OUZSTXM5SjNZdXZnM0JkRWdTV2lZd1ZGMFZkM1ZMbDlRbng4dWJabVJIeUl6?=
 =?utf-8?B?T2t6TDExa1NpamFIS1piMnNOUkZrKy85Sk9DTTVRQS9nYnl4d1gzcUZKWXhC?=
 =?utf-8?B?N0pWU2MrclpZbU1iYmZHb1FXcWNub1gxcStndWVORUJXN3FaNXVGdnI2MFQv?=
 =?utf-8?B?MDRPcXNLYVFBbDF3TUU5ZUNkZzh3RHZEWFM3NFJOVzlZQWRESENaVnlpTUJs?=
 =?utf-8?B?U3BiUm9zN0FISGFjUjM2UGV1REFQMXF0MVdPYTAydGJsNllvY0tWNER0NGp6?=
 =?utf-8?B?UGczazY4VlF2TEl3UGhkRjRyYllzSnBlcE1vTForNFNRb0lpOVVDQ0s0RXhG?=
 =?utf-8?B?RVQ1dE5QNDNEblI5aXl6eW9SYldHSFRKdGEyeURVUko5dmREci96OWllZzQw?=
 =?utf-8?B?TlZOSXJyS0h2YzdBVmJzMVFiT1FENEVyZ1dHZi9ZMTI4ZEhwMks1TFJ3MVhF?=
 =?utf-8?B?NUxSbEVNVy9lOXZ5RGZNS09kL2V5OVgvUXFibzQ2dnFQQXQyTFVYYkFVVEFX?=
 =?utf-8?B?TERsL1FGWEJybmVZUkhGNzI0U2gzN21yUjJHZVA1UzJ5VUFYUEN2Qm83ZUJz?=
 =?utf-8?B?cENyOHdWRkY1VjR1WFEvU1JVUFUyTXI1WnRDVEc2bWRDUjh3WVZKK0hIMDl2?=
 =?utf-8?B?R25TdkMrMVhOTUV5YVI2eDNINXlTOUZUVWlLZmh2WGlvTS85V2liSUdDUG80?=
 =?utf-8?B?eTdpQm43ZTliZEIxdTh3cUFNSUt5SE1kcDJhSU9OTkRGbEp2TFZ4MTR4QXNO?=
 =?utf-8?B?WGdnR1JkUEFEZGNaRnhqcE1qODNVVTYxK1ZxVGl5WU0rQXdUWldaSmdDR1JN?=
 =?utf-8?B?ZkxhclJXUHNrUFRNdlRTekl3RFdyWWJocWx4TEhPdkpTVXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWQwUWV3ZmtjcmZSUUlDcFdiY2FWdVFYeUJhdG1pQnNWMlhBVkRCSWU0U2tH?=
 =?utf-8?B?eEI4VVdsaDRwYm8vYlVuZHhpeW1RcEJhMDR0VitLenZnUjR2RlFKWUFweUly?=
 =?utf-8?B?UUQ0ZnBnR0VCMzg0NGxycEx1R2V0ZFE1RzRNc2RGd2RscWxjZUZBbG9FWGI2?=
 =?utf-8?B?RXhOV0R4aVpHUFUzUXBHdXl2Z1JqTi9YeFRQNjl0ZzU0dnQyV1RtWVhiRmk5?=
 =?utf-8?B?clRrc2ozQzJReVE0emhVOHdVQ201RW11dXdpSmh5bHVtaEgwaHJNdVF3WDIy?=
 =?utf-8?B?QVhYWDBBR1Jkc0dsTE8vSVhzZm9aNm1pc1djZ0F3SG1TUWZsYWlDbTF6Z3lx?=
 =?utf-8?B?aHNOaVRrMXpkNkc4VWlBdjVUcVBoMGg1aVhBa0FERjRKNHlpN0xKakVNd0Rq?=
 =?utf-8?B?b1E1Mzlta0RqM2xUeVM5YmJHV3E0eEVscDcybzE5QUVLNjFBVHZCc3JRYUU3?=
 =?utf-8?B?M2l6a2VwR2YyUEVOb0ZZQXpFRmxUd1JZRXFqVUs5OUNoMHBGOEZKRWVzVjcy?=
 =?utf-8?B?THpDY2hNMzFQK2g5ODBDaUZLY3ZSZnlpQndrc1Izak5HMEdjSlV5OVVTcHRC?=
 =?utf-8?B?ZC9zOEZHMzh1eHl2REFIVXdUOGs0QXpvWFpFMG9lclhkQlhyeFJVQ2ExS3hP?=
 =?utf-8?B?RGV1Z3Y2Uy93dnh6T0ZuRitzdXNmUDlLQ1NkUTdWWERJbFhJSmcrVWx0dER6?=
 =?utf-8?B?RGxmanBrZW51bTltSGZjTVpaYy9YODdNdlhMYnp3Z0NqdCtBUkxpdTFXQW9h?=
 =?utf-8?B?UnVKcWIxUmlkTWRyMU9qejdyVFp5L3hRaUUyQ29lK085Mi94QjhLcnZSZHdO?=
 =?utf-8?B?Wjc3Z0phZlF0NEkxQ0JzRjhxd1gxWHBmRFoxSlVGMkFIWi94THRBUEVLWHZN?=
 =?utf-8?B?TEdSNGs4TzFpNVhYQm5BSldvSjd6RklpMzFPV0hNNDlFZHFrb3RQOXg0Wm1I?=
 =?utf-8?B?TGYvY2JwbXRzTkpBYTUzTDJwWkUvb3l0OFQzQi9GbWR5cm9vUVRoay9VM3Q0?=
 =?utf-8?B?WGZ2TFU0ZlAwUGdCS2dINjZUS2sreC9sRGtodmUyQmFFeGJ0Mk90UnVxSHZk?=
 =?utf-8?B?WWRWNHJlYnNwTXlNajZWbkdEdFB3bXNZbEh5U1FiaHJvaTJaQTZHSWMzblhO?=
 =?utf-8?B?anF5REpxaEc4YUFmV1FOWExtRENnb1ltNXJVVCtkcXJuejBKZ2tEM1lHTlZw?=
 =?utf-8?B?eGkvbVIzbkYxUkJhUkdpcUJUaTZseFFKaUFNYmxXUWp4am9ySUd6bCtpdzBI?=
 =?utf-8?B?R0lzaWd3NWdzaUUxYjVnTWRONFFhejlPTElDNllDWkJIb0crQWdzanN0UFVQ?=
 =?utf-8?B?N2NOK2tnWGEzTmZhK2tXTWJvcnNKUS9DN2pMOTk2U01DMVFTUStoYUpzc3ZE?=
 =?utf-8?B?VW1tWmxzZkJnWWpRTFJ4V3NaRWc1a08yc2pCcTFGWWFORERlaUdzQVpEN2VT?=
 =?utf-8?B?b2NwK2ZmeGFrdXNwWGJvUFVWMDV0d0FrSll4MHRzVjhrUUVDVXRMRDlucS8w?=
 =?utf-8?B?SFcrS1d4MFdDMmdOTkdhbTJUUUI2TjdqdlVySTB1U3JaU25ZMHBaSnpCejFO?=
 =?utf-8?B?MndTUVQ1cXJmQXZ6M2hva3EwZmJSVm9NL0QvRjJibUxLYW1icXNqSWwvNWxG?=
 =?utf-8?B?RHk1RW1zbEh1cUpFTnVnUmdSbGZRa2dsdlpZM0FQK1ZnS01XZEZJZXdJdjlF?=
 =?utf-8?B?SThQVy9laG1ySDZCbm44UmdOdmpKdS9FRytZeE5xYnhSYWZOYW5FY1VkaTlU?=
 =?utf-8?B?Tm1HWXFUZlFvNHI0VCtaamNVekQ5UnhORmhuNXg4ZXB1T1pNQWxNZGc1YlFm?=
 =?utf-8?B?MGRrN25KUkVCaklnYUo4Zi80eWpMWkhjc1Vld1k2ckJ3S1NsS0dMTmtuRjZy?=
 =?utf-8?B?SXBvQkY2bjI0L0hYRXQ1K0wvSU9jcmdSMUU0eWVJdnpLYkhza2xxeFYrSkRu?=
 =?utf-8?B?Vm9JSXFxS0pWM0wrbUx6VTQzQnc2MEJaT3NlY1hMN01nd1JqR3FmeUxjQmx5?=
 =?utf-8?B?RU90cFFPY1cvaisxNGFrVDJTYWxXczdITGM1UWxmZzRSdnJYZUQ0a0hUSldi?=
 =?utf-8?B?SFdqQWVKVk5Ec1d1OVhvMmE0N0VxMWV0UFF2UWxKVjNyYXdRcFVBTzRmbVJz?=
 =?utf-8?Q?jNa49hUdQIMA2yQnKm9IUNEp3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6281ba3-0a1d-453d-5d1b-08dd19c200be
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:58:38.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oInTuF9I5Ao4X8h8ccEUU1F8UKZSWhoRnt680EP1gXpGsnDc+CW0LWqE9qOuYl8PlENRfvJvYFu5NgW5xjN54A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
RGVjZW1iZXIgMTAsIDIwMjQgMTo1MiBQTQ0KPiANCj4gT24gMjAyNC8xMi85IDIzOjA1LCBKYXNv
biBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gTW9uLCBEZWMgMDksIDIwMjQgYXQgMTA6NTE6NTFB
TSArMDgwMCwgWWkgTGl1IHdyb3RlOg0KPiA+PiBPbiAyMDI0LzEyLzkgMDk6MDgsIEJhb2x1IEx1
IHdyb3RlOg0KPiA+Pj4gT24gMTIvNy8yNCAyMDowMSwgWWkgTGl1IHdyb3RlOg0KPiA+Pj4+IElP
TU1VX0hXUFRfRkFVTFRfSURfVkFMSUQgaXMgdXNlZCB0byBtYXJrIGlmIHRoZSBmYXVsdF9pZCBm
aWVsZCBvZg0KPiA+Pj4+IGlvbW11X2h3cF9hbGxvYyBpcyB2YWxpZCBvciBub3QuIEFzIHRoZSBm
YXVsdF9pZCBmaWVsZCBpcyBoYW5kbGVkIGluDQo+ID4+Pj4gdGhlIGlvbW11ZmQgY29yZSwgc28g
aXQgbWFrZXMgc2Vuc2UgdG8gc2FuaXRpemUgdGhlDQo+ID4+Pj4gSU9NTVVfSFdQVF9GQVVMVF9J
RF9WQUxJRCBmbGFnIGluIHRoZSBpb21tdWZkIGNvcmUsIGFuZCBtYXNrIGl0DQo+IG91dA0KPiA+
Pj4+IGJlZm9yZSBwYXNzaW5nIHRoZSB1c2VyIGZsYWdzIHRvIHRoZSBpb21tdSBkcml2ZXJzLg0K
PiA+Pj4NCj4gPj4+IElzIGl0IGEgdmFsaWQgdXNlIGNhc2UgZm9yIGFuIGlvbW11IGRyaXZlciB0
byBpbnRlcmNlcHQgdGhlDQo+ID4+PiBJT01NVV9IV1BUX0ZBVUxUX0lEX1ZBTElEIGZsYWcgYXMg
YW4gaW5kaWNhdGlvbiB0aGF0IHVzZXIgc3BhY2UNCj4gcmVxdWVzdHMNCj4gPj4+IGFuIGlvcGYt
Y2FwYWJsZSBkb21haW4/DQo+ID4NCj4gPiBGb3Igbm93IHdlIGhhdmUgbm8gdXNlIGNhc2UsIHNv
IHdlIGNhbiBkcm9wIGl0IGZyb20gZHJpdmVycywgSSB0aGluay4NCj4gPg0KPiA+IFBSSSBzdXBw
b3J0IG9yIG5vdCBpcyBkZWNpZGVkIHdoZW4gdGhlIGRvbWFpbiBpcyBhdHRhY2hlZCBiYXNlZCBv
biB0aGUNCj4gPiBmYXVsdF9oYW5kbGVyIGluIHRoZSBzdHJ1Y3QgaW9tbXVfZG9tYWluLg0KPiAN
Cj4gaG1tbS4gSXQgc291bmRzIHJlYXNvbmFibGUuIEJ1dCBJIGZhaWxlZCB0byBzZWUgc3VjaCBj
aGVja3MgaW4gaW9tbXUNCj4gZHJpdmVycy4gU28gYXR0YWNoaW5nIGEgbm9uLWZhdWx0IGNhcGFi
bGUgZG9tYWluIHRvIGEgZGV2aWNlIHRoYXQgaGFzDQo+IGVuYWJsZWQgUFJJIGNhbiBzdWNjZWVk
LiBCdXQgdGhlIFBSUXMgZnJvbSB0aGlzIGRldmljZSB3aWxsIGJlIHJlc3BvbmRlZA0KPiBhcyBi
YWQgUFJRLiBNaWdodCBuZWVkIGEgcGF0Y2ggdG8gZml4IHRoaXMgZ2FwLiBpcyBpdD8NCj4gDQoN
ClBSSSBpcyBlbmFibGVkIHdoZW4gdGhlIGRldmljZSBpcyBhdHRhY2hlZCB0byBhIGZhdWx0LWNh
cGFibGUgZG9tYWluOg0KDQpzdGF0aWMgaW5saW5lIGludCBpb21tdWZkX2h3cHRfYXR0YWNoX2Rl
dmljZShzdHJ1Y3QgaW9tbXVmZF9od19wYWdldGFibGUgKmh3cHQsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9tbXVmZF9kZXZpY2UgKmlkZXYp
DQp7DQogICAgICAgIGlmIChod3B0LT5mYXVsdCkNCiAgICAgICAgICAgICAgICByZXR1cm4gaW9t
bXVmZF9mYXVsdF9kb21haW5fYXR0YWNoX2Rldihod3B0LCBpZGV2KTsNCg0KICAgICAgICByZXR1
cm4gaW9tbXVfYXR0YWNoX2dyb3VwKGh3cHQtPmRvbWFpbiwgaWRldi0+aWdyb3VwLT5ncm91cCk7
DQp9DQoNCmludCBpb21tdWZkX2ZhdWx0X2RvbWFpbl9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdWZk
X2h3X3BhZ2V0YWJsZSAqaHdwdCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBpb21tdWZkX2RldmljZSAqaWRldikNCnsNCiAgICAgICAgaW50IHJldDsNCg0KICAg
ICAgICBpZiAoIWh3cHQtPmZhdWx0KQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOyAg
ICAgICAgICAgICAgIA0KDQogICAgICAgIHJldCA9IGlvbW11ZmRfZmF1bHRfaW9wZl9lbmFibGUo
aWRldik7DQogICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCg0K
