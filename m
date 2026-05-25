Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10A3DCDBA
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 08:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696631; cv=fail; b=FzayAa49EAYaRPL4a9aoCLcotyEVcw9rSlIbqVeychKAKsaIrBNziNhoRdeDSFIE5/98nmq46PEf0zJ26FCa1SVCUNCwOA4beuvXSACvr+e7bl9lymPnD8I/paogO26VIk5EvPy8CMdU4g5yQS3/vDtP28EfwHd286z1Xgrwrxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696631; c=relaxed/simple;
	bh=XafRJ5oXq6AoGHY5fLZYsL9RjRX4yZJrVK9lLSnIJq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVLJgKPeZNU9SZ7MW4F3aeNvx8xG3OgPzL/ZLwanXXxIbM6Jytwz8fs17K3sO+O8E0Ye8Oc5ZP2lCrYfMMy5AIzQkoFvTM4LK5UtrCraLUyizEJCb6oiZCoq6brXEk3oOTD8rLXPrGWvfxapvGI6KaVdqd2NiBPu3N9OULo82ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAcqA00O; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAcqA00O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779696627; x=1811232627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XafRJ5oXq6AoGHY5fLZYsL9RjRX4yZJrVK9lLSnIJq8=;
  b=TAcqA00O1N2NGQDd3XYw2FU+Y8Ji8TVkgTHz/A1J3DFrJNcD+i9eYeQn
   xiQcsxoI6tedTMPUsKluzBb2hvVKwvjth+EYkQnziJyrWVEivAnOiMZao
   +XN9Fnn1DIj0EbkaUmfyp4g8G1feZMLI9588Lu+kZ9MiAWF9Rv1p0fmrY
   SMjHOuZhsBLKObPaQ5tkT59tvymtJhs7CfiR/WFhEBm4ntooP2RHgJR5P
   G5SeeryDm01bFcKOY2hMc0pVlqn9D+y09VeH1E/auGAOBjYRD1AKivgFL
   2OB8XM3F2Q2NPEu9M2fEisXPQoOrez/9c6ebSWzZ1oXRyhj9SGu/9VCd7
   w==;
X-CSE-ConnectionGUID: aHEXqce3TSmrwQdCOTULQg==
X-CSE-MsgGUID: IGi7Dh/cSq+OFule6PSWqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="105977536"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="105977536"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:10:24 -0700
X-CSE-ConnectionGUID: bYb2+/GtSeSHn/qFog9Ofg==
X-CSE-MsgGUID: vZjCAbnqRCWcpiDJfzFjMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="238959840"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:10:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 01:10:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 01:10:23 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.40) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 01:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUFc7MWNTvM/UqxrsoPQJbNs9rDsp5xlioybL5Buv6YHR7VcuPp9132CKtP1/IGSKy2MnfkQG4vnRu9cHvYP5b9kG9YkXdbhqP0rUwNdyt9Tw0rKjXYLWBkNkD+z3HQDgpj+PGxRcS7qTExQnv75UFwFZjK4Ir2dUnXlvVoyD5xDrJz1+ZiB67SX4kp0nxjdIrbeFRElBW3HWnsm07bXZUSDKORWujcKXpHma19XvZsY2IPIHuRbg3c+ThLD1T+JPhlU488cthICZAcoHaJe8xgDu1KL7Lsddw6VbIoUPa3avcS5nRJP/vKtj7Um0NQGRV3up+N78YtdfvStKXRx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XafRJ5oXq6AoGHY5fLZYsL9RjRX4yZJrVK9lLSnIJq8=;
 b=GXOHUS6xFEOzdhpa5P2k45u4XIfNIIgsLrTFUw5m/FBogwkKY/JPktuPrcJY0xI+c6DiqxC0I5lEs0Bmv6j6Gzu0Eb4LeMWNZxMTMc5+0eqhxFwHrJAJxRIRleg1PDnNRPGeG87XPPGzOloqjPYOI/1XYLHS1gcdCj50+pl2wTH44Suqc+Isr3ijvBBKORKgUMvb/h9YC1+eIAMgtPO7+iGx7TB7cAYq4DIWFklI9PRXYlLKvRzTuzmiQXey8vABMVv+KTYK/LWSor0eF0nEZV8liHdoOV+7E9i4qko5DBnOHLIp2H25Mu1KOmFTH0yz/XRzegAo13jfRrO4RkrZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH8PR11MB6950.namprd11.prod.outlook.com (2603:10b6:510:226::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:10:20 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 08:10:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joonwon Kang <joonwonkang@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "jpb@kernel.org"
	<jpb@kernel.org>
CC: "Alexander.Grest@microsoft.com" <Alexander.Grest@microsoft.com>,
	"amhetre@nvidia.com" <amhetre@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "kees@kernel.org" <kees@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "praan@google.com"
	<praan@google.com>, "smostafa@google.com" <smostafa@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "Mehta, Sohil" <sohil.mehta@intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "ryasuoka@redhat.com"
	<ryasuoka@redhat.com>, "xin@zytor.com" <xin@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
Thread-Topic: [PATCH v2] iommu: Allow device driver to use its own PASID space
 for SVA
Thread-Index: AQHc6Gp7+Rzmy9QGK0OfKEU3ud75L7YeaBpA
Date: Mon, 25 May 2026 08:10:19 +0000
Message-ID: <BL1PR11MB52710D3CCFA2F75F6B540A468C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260520150743.727106-1-joonwonkang@google.com>
In-Reply-To: <20260520150743.727106-1-joonwonkang@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH8PR11MB6950:EE_
x-ms-office365-filtering-correlation-id: 320cded4-dc28-4438-1556-08deba351024
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003|38070700021|6133799003|11063799006|3023799007;
x-microsoft-antispam-message-info: C4sELPWkRIk1svlY1R9ihm5JbsjzsfW1KNCFmjgDJxZLhDQV+EcmuQhI7c9NqV3oJ8lPOoj7jchTb/gUX6jsmlzrYRqGyX4GJ79RGkXJZd0bHNvy56fAa7mBrrVc1CHL2opln+7i2iXXCVpeQw9HUR/3HPFj74vxZaf9gsBUEhjiNflz5oRNUPnkgGYpIdcamKvXJGzujvOALItcqMq0JcW4HFFXX9ovnZrbn3zKMia93l7WOu4AA7dJE5meXsMce57HpHEyfvGrYCbxDdLKJdJm0g1RSoqkgl0hzBva5Yb7G/u1wWVrvYnft01MwtKdW1NObyoGl6AECIhb8dPmDGYCQ2CFz3+l4u04I5EW7ZnbI6I58e54mOnp7BzoelrI+kzXVmScyVLIAuYEJaq/XEljbBvihnB1rLWs9Gu1t25ClIXtlYsxyLfp8W6QKfRjTwqsMhzF+6WpbFPNx+UV3zUNrPc4w5b8Lz6pZi9krD+SoixdNV4vew7DQXyD9z+I19wQttOauUzwGSglqV26FetONbHdl8LU35nd6fW4nyMDQkjizCElSifc02PhzvjSyV4dXFSjsTYPbItTwbEfqNVSn4jbvVv+EpZ8TadsP6SAG7yARkISWx1WY3yjz8xtXw1P2ge92l4U/DNl+TRgVWJk20RzhsJl0ukLqG5i7ddUCsRF0zgUHiHMEwKvJQ80g1mWe+5ZMTHMMLc4pKBn6dVrngyCkXknjbQBhxgC+KY2It0ckjNDir6JshAQm/iF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003)(38070700021)(6133799003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnlaanppOWFaOWloQyt4THVvWTk0dFdEMFJLZ0tTR1hOUHFGNTNyTnlzbEhF?=
 =?utf-8?B?b3l5U0s3OXpHbUxWSzBLM2dXN0RWM2lOZHlRY0dxOVdXWitkUC9OZ2h1M2Yx?=
 =?utf-8?B?aGpMbm1xcWtzZ1d6MVFPM2VKYXZIbW1iNGNCUjU3VStkSVV2a2pSVjVaV01E?=
 =?utf-8?B?SlpxUEdxbGV4S2QvaUZMOTNGeStxUFR4N0ZoeldiSTdDQXdIazZ2QVYvYmZZ?=
 =?utf-8?B?UHo2NTB5MC9yeGFGeHMvSHVqdEN1OXB1ZmxWUXVBRUl0WG45L1RiY09yc0Vi?=
 =?utf-8?B?L21sclI1ajlrWjZadms1UUtod1ZuNTVWeWp5V0FmN0xhWlQ0Wk5YSzkzQXM5?=
 =?utf-8?B?Rm5BRGErcGo4dE9TbWVjTWtIZTh2U2JYRFZRQ1hURjN2dDBUNW9NZStpeTRI?=
 =?utf-8?B?OXQyRTU0UGl2WkYxODFqS05WOTBoS05TSHJhMnVnMkFxbzNCTmQ0L2JML2k4?=
 =?utf-8?B?TGo0Z1VINUZxVmhQWEFkYXJHRk5jbElDMFlVQTNzZ3pGc0ZtK2tZa3NLaWxl?=
 =?utf-8?B?c1hpNTJocGErTzJkVlVaOERPQ0ZURk9CaTNqRjNZVlhVdXBpTW1WUkVMakxT?=
 =?utf-8?B?aTJEdHZwa3BNQ0RnVDlsb2c0Vm41VVU4Wm9sR01TSENhNnBBNjlNSjdnUzVr?=
 =?utf-8?B?SWpiVnRoNzc3cmpZUllaSHZJM3IyMDByWWNHcDF6cm1TUC9NcmNqeFFQZEFx?=
 =?utf-8?B?dGdrVjMrZTBMVCtOdndwbW1xWmUraEJDdU5YZ1l0WFhXek80Q0tMTjlhV3Jz?=
 =?utf-8?B?dVd1SE1PUWZGSXo3TUVUVGRoektITm4yWUswK1A2SHRsUStSeG52S25ZdWpx?=
 =?utf-8?B?WjA1UzIwSm5GTUtFRXcwZDJ1eFgvMFgvS293UmVrb2d6YndDY2pObS9IaEMx?=
 =?utf-8?B?S1hUTkNFZFZUWnVuR2NQTklacXdOLzZXU3plMUZacDRoSVZBNjhiOTlscU15?=
 =?utf-8?B?QWNKMGF0UkFQR1k2eXJzSGE5Z1IzZmlST0x6M25vaGlFc1M5SVpuV3pVQVdU?=
 =?utf-8?B?dHZZUmFmYTVmK0x4bnZmSktDMlFnY0pHYzB5U3NtR2ZWbXJtUEhYNC9VNXFF?=
 =?utf-8?B?OTNSZVBxQm1ER01LLzF4YTlmKzFtZktEcUtmNGFKTUJSUGZPTndvTnJFOElW?=
 =?utf-8?B?enQ2aklCL25WLzMxeHpkS243OGt2NUtUV0d5R09oL2FwUUwwR3VVdzhUUjBI?=
 =?utf-8?B?dGhWSjVKOFZvN3JCMm5sN0dFZFR0V3dTVjNBVitTTUF1bzhoQ1ppQWE3VEk0?=
 =?utf-8?B?dmw2cWxMQTVRa0pwSjFkYlZKTnIxb1JnR0t1MllpQy9hamdyU3NMejBlb05j?=
 =?utf-8?B?elVMS2UvNFVZeWpHQWdkczQ1aDJwYmRqR2JMUzF4MGRlNVpnM2dTaldiZkZN?=
 =?utf-8?B?OFZXdUZUTHM4SWdqYlUza1ZaLyt0ZnlvQmh0a25jdFNONVFoSUlhNTBlYmlk?=
 =?utf-8?B?T3cxSVNZaERHdjFZNG45eHJ2Qk9taXY0SDhTUS9LeW1jbWYyb3J1Szk5QVF1?=
 =?utf-8?B?eit4Z0NoMlltYkFEcDhHbG5kTFIxYUpDM3hZNy9JclNXR2lyMjFrK1U1TzI0?=
 =?utf-8?B?QnBLTkliY1cyOXFkUy94QXBPV3dSMVFtQWl6eEdEZ1gxdTZXNDVLNldQYUNh?=
 =?utf-8?B?eWx6TUlFcG8vd3FCcTVGdlhUM2JBb2wwd3VnUFZWaXEvUXdTMGxiTHJmNFJs?=
 =?utf-8?B?NGZ5WHdqendQUklHZzNpMlhFd3JPcGZjMVhEdjFaazhtRzVYby9QSmVzUGtn?=
 =?utf-8?B?dVBLL1g1YmtsaXFubHNtUGhsOUUzVXI1VDFyR2ozQzRmWG92R1dYQ2pXT01n?=
 =?utf-8?B?R244YmhhREM2d1FSWGpOOFJidWRkVmtnYkJLUzZrSGtiS0VXVVErWDZEVmlI?=
 =?utf-8?B?YW5TODZXOElaZnNjSzRBUzV3bzl2MjlBaGRlWUNld3NiQjNTQmx2eVpsaWZW?=
 =?utf-8?B?OGxsZ0k2aWo1UVpHelU2MFdvSGVBUk16RWl2TDNrcWNFbVplVStTbC9DdmtS?=
 =?utf-8?B?TWIvckpzOHNESitIbVJXVWpaM2JiRHpNVmY4d1pjOGpkOE4rNE1tc3JRSTVm?=
 =?utf-8?B?TEkzZVgzNkdoZkZndVhxUGtLZXU5UERsWnZCSXlNU2Irb29pWU1QazQ5Uit3?=
 =?utf-8?B?bTBESmJxN3JNY0RoQjNnSG5TdS80UU1CRjBVbXRTdmszam8xajUzd01xTi8v?=
 =?utf-8?B?VTRaSUQ1UFJOV09BZlhiaWxic3JCZWFpTS9qRVkxbWdHMkVtV0Q0a2tHUitx?=
 =?utf-8?B?Y2RTUGU4ZDVRNk4ya042b29WTnB0NjdJaHZ1UVRXbHg4aHlJUkJpMWxKclNW?=
 =?utf-8?B?eStvMXVXS1gvcXdDL00rQ3lLV3NQbFdIbmQ2Z2wrMjdjKzVha1A1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JbJgwHLkWJcDOqjIBtoEC9LVo9nwuiG803w6/V0xTxQxnSMWnNtgPhwmCW8fZvMslheJfobrCVsAYRtwGZmAQ2878RtOKcywxdOgy0+pJU3Fn2ADx4c4RQ6y2FEZyHs/X5xhl6XvrUy0oIb5rXr4ktOjpUyRZMrlXaaJWu4vY7t95p5r+U/ziS81wjr/UakTa/OSuKbVpK1UH1LwSl/EfPZzGgDaIJ+QyUhxZhPEf1X9IpCmrJkaJRkalBWRHGhAQ2MGChRt9yvN+kPVR/dIsCCiTkk2C+k3zLTZ9ASbFuIX5weOV/74WTVKOz+nZ+zpzLiPHGlwyQjsJ+IeaHdjqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320cded4-dc28-4438-1556-08deba351024
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 08:10:19.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HI0u7W2+1K9pCLAr7Oo+GBY9OSIDYTeFcu4p+T3KcS2qPuE5jtO9OoYBjSt6U1VZyGWksE6RJxN5yeBWkbLrfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6950
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb29ud29uIEthbmcgPGpvb253b25rYW5nQGdvb2dsZS5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgTWF5IDIwLCAyMDI2IDExOjA4IFBNDQo+IA0KWy4uLl0NCj4gDQo+IFRoaXMgY29t
bWl0IHJlc29sdmVzIHRoZSBpc3N1ZSBieSBhbGxvd2luZyBkZXZpY2UgZHJpdmVyIHRvIG1haW50
YWluIGl0cw0KPiBvd24gUEFTSUQgc3BhY2UgYW5kIGFzc2lnbiBhIFBBU0lEIGZyb20gdGhhdCBm
b3IgdGhlIHByb2Nlc3MtZGV2aWNlIGJvbmQNCj4gdmlhIGEgbmV3IEFQSSBjYWxsZWQgYGlvbW11
X3N2YV9iaW5kX2RldmljZV9wYXNpZChkZXYsIG1tLCBwYXNpZClgLiBEb2luZw0KPiB0aGF0LCBo
b3dldmVyLCB3aWxsIGRpc2FsbG93IHRoZSBwcm9jZXNzIHRvIGV4ZWN1dGUgdGhlIEVOUUNNRC1s
aWtlDQo+IGluc3RydWN0aW9ucyBhdCBFTDAuIEl0IGlzIGJlY2F1c2UgdGhlIHByb2Nlc3MgY2Fu
bm90IGNoYW5nZSBpdHMgUEFTSUQgaW4NCj4gSUEzMl9QQVNJRChvciBBQ0NEQVRBX0VMMSBvbiBB
Uk0pIGZvciBlYWNoIGRldmljZSB3aXRob3V0IHRoZSBrZXJuZWwncw0KPiBpbnRlcnZlbnRpb24u
IEZvciB0aGlzIHJlYXNvbiwgY2FsbGluZyBgaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKClgIGFuZCB0
aGVuDQo+IGBpb21tdV9zdmFfYmluZF9kZXZpY2VfcGFzaWQoKWAgZm9yIHRoZSBzYW1lIHByb2Nl
c3Mgd2lsbCBub3QgYmUgYWxsb3dlZA0KPiBhbmQgdmljZSB2ZXJzYS4NCj4gDQo+IEN1cnJlbnRs
eSwgdGhlcmUgaXMgYSBsaW1pdGF0aW9uIHRoYXQgYSBwcm9jZXNzIHNpbXVsdGFuZW91c2x5IGRv
aW5nIFNWQQ0KPiB3aXRoIG11bHRpcGxlIGRldmljZXMgd2l0aCBkaWZmZXJlbnQgUEFTSURzIGlz
IG5vdCBzdXBwb3J0ZWQuIFNvLCBjYWxsaW5nDQo+IGBpb21tdV9zdmFfYmluZF9kZXZpY2VfcGFz
aWQoKWAgbXVsdGlwbGUgdGltZXMgZm9yIHRoZSBzYW1lIHByb2Nlc3Mgd2l0aA0KPiBkaWZmZXJl
bnQgZGV2aWNlcyB3aWxsIG5vdCBiZSBhbGxvd2VkIGZvciBub3cgd2hpbGUgdGhhdCBmb3INCj4g
YGlvbW11X3N2YV9iaW5kX2RldmljZSgpYCB3aWxsIGJlLg0KPiANCj4gQW5vdGhlciBsaW1pdGF0
aW9uIGlzIHRoYXQgYSBwcm9jZXNzIGNhbm5vdCBkbyBgaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKClg
DQo+IGlmIGl0IGhhcyBldmVyIGRvbmUgYGlvbW11X3N2YV9iaW5kX2RldmljZV9wYXNpZCgpYCBl
dmVuIHRob3VnaCBpdCBoYXMNCj4gYmVlbiB1bmJvdW5kIGFmdGVyIHVzZS4NCg0KV2h5IG5vdCBt
YWtpbmcgaXQgY2xlYW4gaW4gb25lIHN0ZXAgaW5zdGVhZCBvZiBsZWF2aW5nIG1hbnkgdW5zdXBw
b3J0ZWQNCmNhc2VzIHdoaWNoIGFyZSBsaWtlbHkgcmVxdWlyZWQgc29vbiBpbiB0aGlzICIxIiB0
byAibWFueSIgdHJhbnNpdGlvbj8NCg0KZm9yIGVhY2ggbW06DQotIG9uZSBnbG9iYWwgcGFzaWQg
Zm9yIEVOUUNNRCBvciBTVDY0QlYwDQotIGFuIGFycmF5IG9mIGRldmljZSBsb2NhbCBwYXNpZHMg
dHJhY2tlZCBpbiBbc3RydWN0IGRldmljZSAqLCBwYXNpZF0gdHVwbGUuDQoNCnVwb24gZ3AgZmF1
bHQgb3IgZXF1aXZhbGVudCwgZmV0Y2ggdGhlIGdsb2JhbCBwYXNpZC4NCg0KdXBvbiBkZXZpY2Ut
c3BlY2lmaWMgYmluZCwgbWF0Y2ggW2RldiwgcGFzaWRdLg0KDQo+IA0KPiBTdWdnZXN0ZWQtYnk6
IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPg0KPiBTdWdnZXN0ZWQtYnk6IEtldmluIFRp
YW4gPGtldmluLnRpYW5AaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb29ud29uIEthbmcg
PGpvb253b25rYW5nQGdvb2dsZS5jb20+DQo+IC0tLQ0KPiB2MjogUmV1c2UgaW9tbXVfbW0tPnBh
c2lkIGFmdGVyIFNWQSBib3VuZCBieQ0KPiBpb21tdV9zdmFfYmluZF9kZXZpY2VfcGFzaWQoKQ0K
PiAgICAgaXMgdW5ib3VuZC4NCg0KTm8gaWRlYSB3aGF0IGl0IHRhbGtzIGFib3V0Lg0KDQpidHcg
YSBuZXcga0FQSSBhbHdheXMgbmVlZHMgYWNjb21wYW5pZWQgdXNlcnMgdG8gcmV2aWV3IHRvZ2V0
aGVyLg0K
