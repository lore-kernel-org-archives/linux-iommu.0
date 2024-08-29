Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9F9C125;
	Thu, 29 Aug 2024 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892799; cv=fail; b=W90bWe+OKauswPVXSav5VnjWKZ1YDo+c5IJH3hw+pYVaJDJzzykx4TA4imzsbosygDP9yVy2JrGKbi2zE1puGq7hrUp8guwR3j6z1TDYQWFSrGZq3vRIckT+dq4oCh9vbLNyywZvmevwyOfQMoXh/2FE+vHCFEHeb4M6RZhzsZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892799; c=relaxed/simple;
	bh=hDhIHB2to1kbWpDQqo0bP14/folxpmyJpHGM80krQ3g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X0WI9VStzyw06KloqHXFaUp6Mlyvd1d0E5WWiSwixTskb2XI5qSDKCAoRd5DhOytEAGKiOU2UJhYpy8yVFmz2FbFXpkUq/LMtXZnPlMgx2z1ka1Ji2cyHrfp1QDv6L2305jnh3UnygnMlCbu90HXgB/tV/xIiwYoZG+MOKSy4jY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJ6AryoD; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJ6AryoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724892797; x=1756428797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hDhIHB2to1kbWpDQqo0bP14/folxpmyJpHGM80krQ3g=;
  b=JJ6AryoDyFDjwtRKO67jMTVSBlpHeH0+OhKm3YR+I0GAGHeo8naaIR3j
   A08Oe0Lc9uw9SPs8+mmtfWni6KL0wSk3HPZSbmto7sR00YW4qCtNRnFWa
   k90ShHJs6AdeEH6onXJJFkTmra0sAmUEzgsuByASvLclPjAz47VX4AX4G
   Qaf1Hv3mj40saEugs80h3g2zB9apPPWsonG61Gtamka4kwJ1dTmZj9gqJ
   qCpTVGxT3iGrT6lozDaBhMrnYdYAcq2G+hPhdbikh8R4RBCXv28OjhxFE
   6gPhwNRwN3AF/aD8fy25MlQrCWCqXsM15jsRYtZD08+nV8BlTWDTFM8Dv
   Q==;
X-CSE-ConnectionGUID: rcY6IuXGS/iacFUxn7hYcw==
X-CSE-MsgGUID: mvMTnAEfSeSJP77WUNvjQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="40934795"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="40934795"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:53:17 -0700
X-CSE-ConnectionGUID: 3a0e0ZXnSHux11KOYkuSnA==
X-CSE-MsgGUID: 9KnfHENuQPuvi45j1Xz80A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="63391915"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 17:53:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:53:16 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 17:53:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 17:53:16 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 17:53:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQBTatLzSdUQ9uzBFS9NnT8mdGTERR7RaWSDquaA8fHywKVnQ5CH+Y0LaBdlm1BwSRMm5Jbcyjzdczf2y1adlxCuT6RHrhWMmBNox4Kcq2Xfp8FQa6EgAVWK7AYbvsxDXbKZ8lh3v2m/hQhZ/f4OCe52FrHVnItggKEHvLiJyp+gZw0AtOeX8hY1CDDVlh+cZt5cdX0njtac+67sP4FootOteAeW9ZG+V87qRYpi5pf2wKo/3GT80xUcjUhURC/AEwG5TbKp7mPCfYosHDtmPBFZ7q9kblrgNZyVzfGL8S7Wb1fdrsVZJeG/fGOr79ofaKEKPdCMZ6UzAbRkIrc9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDhIHB2to1kbWpDQqo0bP14/folxpmyJpHGM80krQ3g=;
 b=KB9wYo2YycKMlKGDsR25bmE73ZrzPTswlJdkx/moob3q18CWNhQ4lHQXxltIwN/c+EVJG/TN/bW5hn5EYix9vdVmux3CxPTwgjylyiDZ0tmzSPm6ysPbgFkTREXS514LcBtsvpSvy1TYwWTQr0/L1j6+pGY7IJjhwCwQK5PuPwbU72AFKe2T+XTde6l+o2SgVcEywHUOrnS6dmL5mvMCaIECMshfp18NB0NygTUQ9PIRH+RF03JhF/bhjOL5CcqiNFFegARvr7uKOUWKF0YIjYFvg9YI4e1z+bCUpReRcojl6Kv4xBGUXRfOxrLU61/RTAtotqYXJROP+McxdHLmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6691.namprd11.prod.outlook.com (2603:10b6:303:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.22; Thu, 29 Aug
 2024 00:53:08 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7897.021; Thu, 29 Aug 2024
 00:53:07 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Lu Baolu
	<baolu.lu@linux.intel.com>
CC: Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, Jacob Pan
	<jacob.jun.pan@linux.intel.com>, Adam Williamson <awilliam@redhat.com>,
	Markus Rathgeb <maggu2810@gmail.com>
Subject: RE: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
Thread-Topic: [regression] usb and thunderbould are misbehaving or broken due
 to iommu/vt-d change
Thread-Index: AQHa+TT2MgK5ERDS1Ey44fCKLWFprbI9Z5sA
Date: Thu, 29 Aug 2024 00:53:07 +0000
Message-ID: <BN9PR11MB5276CA2E1922D9FD6B9F2ECF8C962@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
In-Reply-To: <c844faa0-343a-46f4-a54f-0fd65f4d4679@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6691:EE_
x-ms-office365-filtering-correlation-id: 08613cd9-52fd-4d4a-5047-08dcc7c4f2ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1hvWERBd21XbFpIOUhDMDlRbXRkUGNxelFOM3EzMWlobHJrbk5ydGZUNHgx?=
 =?utf-8?B?RFdRTEJwK1pTRWFJU0JtRFdIY09DWUJtMEZhOTJuajRmQXJ0T2lYVTI0dlRZ?=
 =?utf-8?B?Zkc0cEUycnhNTkt1Z1pDWTNVQlBkZDd1a1I5VUFnWWpMeVVOR0Z0ZmxZdS95?=
 =?utf-8?B?YUFlY212eDFjZ25lcDdFSHdmNFliWWZidTVaaFJYU00vSVpMbGFoZ09CYUxq?=
 =?utf-8?B?dGl6WVFXYzVZY3ZWc1JVWmZCZmJhUEwrRkRXc0FVaUNmU0xpbDM3L3BSSytr?=
 =?utf-8?B?emkwaUlSWUN0MWkzK3NVd1FMdUpEQnl3Qk4zdlJqSytzRS9HMUl1WG5LclVX?=
 =?utf-8?B?SFhDN2pYdzdleTNvVy9vT2gzNTh6anh1MGhtcDErelUvOXpCT2Q4TDVDT1Jq?=
 =?utf-8?B?cHlldHpSemFxbUExZExwLzR3a0xwOVNJUG1VTEcvUUk4cUV6dURPOVZZZEJY?=
 =?utf-8?B?MFZMVWlJQWI3OVBOZ2hsZGRVK0VIaEQ0bGlzVDlma21EQ1BEdVVieW5TSUF2?=
 =?utf-8?B?anZzcVNWaE1jazBRMytydjVoOEx0NUZDQmFlTTE0Rk03WnVDRGtpQldTUFU0?=
 =?utf-8?B?aUhjOCtTWUI3RzYxWE9Rbk5TYm8wazNXU2h3ZkV5TzgrUEw1UVp0b2h2NTRa?=
 =?utf-8?B?UXZneC9tMHpzLysyRFd0MHF6SHI1UVZrd2lOVFdibmxucHh3ZGJnMU9UQktT?=
 =?utf-8?B?cVhRUUhhcUZWbGFuVmE3b3dZcDZPakZwT20reHQ5U3RrRittTjh5eXdIZ1hM?=
 =?utf-8?B?OWtPNXVnNjJ6NU1SdVRkbFV1WDRkRm9oRHpZUDdHMjJqRGVXRzJFb3gwQWR3?=
 =?utf-8?B?bWNqQnpWT3NRWENOT2FCS0xUSHZnOW5iWkEzS3IvQ3lQK1BKTDVra0hXaGJK?=
 =?utf-8?B?UTltdGExVnFEb3pkVE1IOG9hWnVTTUtuMXBreEZkYWpLU25ma0FWMjZYaUx1?=
 =?utf-8?B?dDNXMFNqdDBoSVBaYkd3a2Vqbm9ZWm14WTBidkYrYzdJTG0yMXdzRm43NWRW?=
 =?utf-8?B?MXhGQmlzYlJKVHRoekg2alc2eEk3SkxybHB0WDkyem9ncksyaUxiRjltOUN5?=
 =?utf-8?B?cTZMUzFHcExGKys2YnZuV0JBSGxFME5mbkp5WUZFSXNzbTlJUGJ1eEsrQ1ZH?=
 =?utf-8?B?d1dmcDVkV3BBZFpuRGJCNis4UUVpZE9hdW1UbTllNmNVYnJGQjV2MDdsQng5?=
 =?utf-8?B?Vk9pUE0zalB0eDZUQWRhOTNaUFF6UVdWRjBGeFJUVHVOVDNGM25uZ1R5ZGUw?=
 =?utf-8?B?WlJGcUo5Yng3THNWVTRWaXg2OWpCcVR4MWpZMWRyZUZvaXRQQjJVS0p1TDVn?=
 =?utf-8?B?MFRTN0trYnI3RlhRN2Zva2Npc0dYdExKVnc4cGFtdmR1ZnJmNHZwQ1hlLzJC?=
 =?utf-8?B?cEZrRXFFNmF3SnorYmx4TnhyaTZPMWxPSFN5eDcwQ2lSZW1PaHRvRmRvbFlD?=
 =?utf-8?B?SmtUQWg5N0hvM0J2ZWtwUG1vSlI2WXdTZjI4azdZMk1ac0cvZnNZbEtxdnE1?=
 =?utf-8?B?SFRZT2FUV0JUUnM1RFIzMzlTQUlLSlVlbFQ4SGVBOWJrVFJzZXZrVXk3WnRR?=
 =?utf-8?B?Tk1QOGZjcEM5OXh6TVMvRFpNc21wemMyUzdwTFYvaEhRbHRWb041Ylk3emZY?=
 =?utf-8?B?K3VFMTM3WGpkbm9xNDJPeHBrT0VEVTB3N0ZwR2xvT0hVR2haUHZmUHpVNXNj?=
 =?utf-8?B?eUtSS3NzbnBKdnJqZHFDa0dNNkllTnl6cm5tYmFXR25nSThVbTBiZGtZWVRz?=
 =?utf-8?B?Z1h0eUtmbzA3UitaSjNKdUhKL3E2dFFjMWZjUUNvdE9jV0hCQ0ZISFBHRG1Y?=
 =?utf-8?B?VFowWlpXSnd1Tmx3YU4vRzBoU2llLzZtOWtnaldFUzRaSkJaUlR0NlFJcFlB?=
 =?utf-8?B?eG0yaTdmM1pzU0lzbFd5bFFPTWptcGEyYXN5WHBYcTIvL1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzlpbUZ3aFhEWXJTclNkK2cvZWxyUnZIMlZJenppUXM4QUxYYlFPemhBVUcz?=
 =?utf-8?B?MExFVHZhVWEza3N3a2dUNkJQV1ViL0pLR0Y4N3FNRkRKWFZrb2lwL28vRytt?=
 =?utf-8?B?dDUwUGhmQkFWc0RHMCs3Y2piUG1aTlZkaXBmcDBQbWdHNThFR0dSNzA4aGtS?=
 =?utf-8?B?ZkpINjhEbDNoNzl3ME5BejRVdkxTQ2tCQVdwelFnaVRnQzFkdS9vOUFnT2V6?=
 =?utf-8?B?R003VDFWS0NzRHVpcVdDaVI1UHdOdWRRcG5tUEtHelhoanl1Q1h1eVpRSmtI?=
 =?utf-8?B?Mnp4VHpCWDBlcnJhd0VtOWVER2VWK1N2K2s0c2lxcDJpYkVMWmpkVHFKcVpZ?=
 =?utf-8?B?TEFMZGhhL3RQZm1WdzFIS2c2VDdDWi9JWUZEeXJleVZXdnIwUU1yK2Z6b0dR?=
 =?utf-8?B?bHRncXI2SWlJK1VFdUx5dFpZTjZ2VFZWMldBdVl5M2JwYmNCcHltSkdEQkJM?=
 =?utf-8?B?MnhkRGNSbzB3TERWWENMMGlaTi9GUlNoMUNKWmczeGNFdVpiUGFhQnRWcWlU?=
 =?utf-8?B?U1AwZnE4cjk0OEI0RFdad21mUitFOEVBY1lFeXN0dlU0WmM4ZW9xaEJXTFVI?=
 =?utf-8?B?VmdGTTFYZktQUzJ6ZHlNSmt5Nmloais0TE1TRHFWTi8wMVMwT0lOTGJhRmtQ?=
 =?utf-8?B?cGlrREp1c3FsNHJRMTQreStnQkhJOVljN0ozYTZvb1pkUUtZcmFPSTc4cHpi?=
 =?utf-8?B?UXM5ZDRjWjdZS2RkU01xTzBYTjhUVkgzV2VEOENmMVNjQWFxN1hYZ1RUMUhY?=
 =?utf-8?B?QzJjdGFjTVBCOGk5b2xVWWcwNWJiWU5Kd0NDV0UwZm4zQVNLT3VZanZ1R21P?=
 =?utf-8?B?Y0ZZTHVNbTJRa1lkOGY5ZzV6V2Z2NDRlbDNlWTV3NW03L2NOMmtDVW16cU84?=
 =?utf-8?B?ZEg4MVhhZWFOYVY3OGFxQ2ROL3ZyOHRJVERNN2I2LzlPUC92NHc2NXM1MjAx?=
 =?utf-8?B?enR5a0VkanhSRUpnb0gyOGROZUxJRC9ZTTR6WThrY1l3SytHRlpCRGVGeEVn?=
 =?utf-8?B?RGJTUVZ2NkdlaE9Qck51YnQ1UVROUmRHazlpUVFjQ0czeFhrUTh4ZXVtTGhM?=
 =?utf-8?B?TGJKTnpzUEJ5U3RkWTN2bW9COTNyWTIxNXlJRWQyRm5Tdk1JNnVlT0Z2ajFG?=
 =?utf-8?B?YXo0Yk15bTNIbEcvZ0xRb29acEdRbktUM3E0Z3Bma010OWJIYTdhRDRSWUdu?=
 =?utf-8?B?dUZHd2dxYnZsdjlBTDlEYWdhSytxcHRyQlVrZWxTTnZPd3E0SVkzem5VcTlQ?=
 =?utf-8?B?K0tPZElJakdraWY0MjdVdXRyWm5JVmJFQit5NTBYMkdIbDdRcDJZWnZhcThP?=
 =?utf-8?B?b3B2YStEVWVsM2w0SkNtSG55OVdDZW1hcHVubjhDSUlzaXJxZjFoRTg0dmhl?=
 =?utf-8?B?SUprMnJFNkxUVEJXM2taNHVBMWdtSlFPeUhQcHEzYjhJWDd1WldCYVVpd043?=
 =?utf-8?B?Z2VjWFFvR2xoN1VyT3RzYmNmL2N2OXpQZjlSR0NzNjN5dnRXdjQwSllRM1NU?=
 =?utf-8?B?OVltaXkwWkthckhGVHpNUzFMRWkrd0w4aXlEYmJPc3p0VWFDRFgxdzdUUWZW?=
 =?utf-8?B?bFpxaTRwdGdza3h5ckpveFhOZGh5UjhTbjQ4Wkk1TkkxMDN3OXRPRTNGNXNj?=
 =?utf-8?B?cXVNdXJFV2NXaVExWk9uNUhrMjZhMlBqSXg0OTdtcjhRd1ExQlp4eGhwRVZh?=
 =?utf-8?B?NlRCL2xkeW1YRVBXRStrbUVQWm1hek9uKzVzcXZXMlNMb3VGc2xYS1VVdTg5?=
 =?utf-8?B?VFhxaE1STllYb2UvM2ZmeENBeGFZa2d1UlduYzV0Z2w2OEFzVkhhdkx1RW5z?=
 =?utf-8?B?ZjVSRlgwVGdwcnl1RmVwWXJaMFE3QzYzN2c3akx0cEQrSk0vTzdqZTBFcTh2?=
 =?utf-8?B?bS8xdUNYdmU4Z2RVRDFPaHJzUERVZHZaOXA0ZHI1eHB6akNxUTVoc0U0NGhC?=
 =?utf-8?B?ZS9hTXdHMmFGbG1UbEVWS05KZWdMVlNKWjl0VHQ2WXJhRXBuRWkzQlpmbUIx?=
 =?utf-8?B?ZzUralJQNUxtYVdnRHRzR3ZGRkJyNjM5c1laZnZiYVlubmZqK21aQW1LRnp6?=
 =?utf-8?B?Y1RNNmpoZTU2OVkwb1VweGl2dS9yN042Nm92WVJpdHF1bndSa2pmbklWRkNi?=
 =?utf-8?Q?EPPncVXRZStouFsC6tIjR/wJJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08613cd9-52fd-4d4a-5047-08dcc7c4f2ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 00:53:07.8404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RxeTJTerU1b9rOWuXWqOPHnOhsRzqtboBLNiRq6K7A9gTywROGB2ni8n1Tpyypi4USNRFUf/UwvsUbJZ+MEi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6691
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9yc3RlbiBMZWVtaHVpcykNCj4g
PHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+DQo+IA0KPiBIaSwgVGhvcnN0ZW4gaGVyZSwgdGhl
IExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlci4NCj4gDQo+IEx1IEJhb2x1LCBJIG5v
dGljZWQgYSByZXBvcnQgYWJvdXQgYSByZWdyZXNzaW9uIGluIGJ1Z3ppbGxhLmtlcm5lbC5vcmcN
Cj4gdGhhdCBhcHBlYXJzIHRvIGJlIGNhdXNlZCBieSBhIGNoYW5nZSBvZiB5b3VyczoNCj4gDQo+
IDJiOTg5YWI5YmM4OWIyICgiaW9tbXUvdnQtZDogQWRkIGhlbHBlciB0byBhbGxvY2F0ZSBwYWdp
bmcgZG9tYWluIikNCj4gW3Y2LjExLXJjMV0NCj4gDQoNClRoaXMgZG9lc24ndCBhcHBlYXIgdG8g
YmUgdGhlIGNhdXNlIGFzIGl0IG9ubHkgYWZmZWN0cyB0aGUgc2NlbmFyaW8gDQp3aGljaCBhc3Np
Z25zIGEgZGV2aWNlIHRvIHVzZXJzcGFjZS4NCg0KUHJvYmFibHkgZjkwNTg0ZjRiZWI4ICgiaW9t
bXUvdnQtZDogQWRkIGhlbHBlciB0byBmbHVzaCBjYWNoZXMNCmZvciBjb250ZXh0IGNoYW5nZSIp
IGlzIG1vcmUgcmVsZXZhbnQuIFRoZXJlIHdhcyBhIGJ1ZyByZXBvcnRlZA0KYWdhaW5zdCBpdCBh
bmQgZml4ZWQgYSBmZXcgZGF5cyBhZ286DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWlvbW11LzIwMjQwODE1MTI0ODU3LjcwMDM4LTEtYmFvbHUubHVAbGludXguaW50ZWwuY29tLw0K
DQpZb3UgbWF5IGhhdmUgYSB0cnkuDQo=
