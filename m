Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361782B9C6
	for <iommu@lists.linux.dev>; Wed, 10 Jul 2024 09:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604878; cv=fail; b=t6pGEe9WVdubFYCazYuEIKuWyOcgA68ORZ9DFUNd8DXemCRcgzYfXPRPnnfUmRh81/FOartUF5MJPJPWWEITtZvSKaX23uJQi6v6H69sg5+/o0NCSCnFoNn0wk+BXa0o7JBRfNxHT3LW8WB5Mh666D92bUaDWMK9NSsOGQaNXJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604878; c=relaxed/simple;
	bh=bbjT2rnDwGGSKyzO89jmZqUtT9nV5EE8vcnJLuTwiXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B9xFtXejDWhiQs0a0qwEeOH5eZuHghI59VNdP4sCEjILs6ilHFLfLkcjv4vxGYO1BTDlhQQFw/tv4BetqBikT7cHo7UQhUofH5jnaMcuJvQIS7jlp7tAeZp4ZrzcmkXCb8j+dh18ReBVUAs7xcPPVmQQn1lpVtnGYtDm/N4qmvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuPZ4kZE; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuPZ4kZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720604878; x=1752140878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bbjT2rnDwGGSKyzO89jmZqUtT9nV5EE8vcnJLuTwiXA=;
  b=VuPZ4kZEyhx8HNTAECJYJzBVp0T8qLrNX4GUgsaWBVbij/iG2Ot2PVUw
   90F5M3FdlvlYsMbi82Ymq0/Mc3U6ZWMiri2EyBFsJEclcBqk+ykqkmwAh
   Btk3nhJBPIK3e58+Ko0bA4O6f8WUvjnQT099g4a6H+rVGtXlKenM06XvO
   JRpqN1XfVNvLpfAERZ/fKrubH0JsHmpUmR90evsRKROces4Fa750wGTQF
   jY7G7ni3sHRwGcLngEStZftGnOtaygIsqr2sZ9M5syhqR3HJoIxDJNL3l
   l/PfTpSGadsEtICuBimOc61VxAFKG1DAca6FiwGWVsRzsAlKNPcZg9Heu
   w==;
X-CSE-ConnectionGUID: gMCji5ZqTTacWeVzFrvXpQ==
X-CSE-MsgGUID: 7aa1K5KvQjyhbxN4HOr9tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="21678045"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="21678045"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 02:47:57 -0700
X-CSE-ConnectionGUID: gF+H+J83S6yoo5tV2s7fBQ==
X-CSE-MsgGUID: +lg5W4fsRteozeAMxPuHmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="52546814"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jul 2024 02:47:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 02:47:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 02:47:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 02:47:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzZGfVZm3OjwIS5HrGV+A/Zh1ILJnEDqAHQsU1Uxc7AEyVSKzUyq36Y7I8aW/U4gkmm2spUpVFnshrtr/cU1kTu7RMELCmygSREU1jMIUAPNfgbBuwnPHvB5D0i0V8eGlLhVBs7TpYf05mVWdgMRb2e9n5YT/kOO9n0pqFc6nTdEkHCdVrfxl3L5LVXxIfzbGAm8uSLaZJRbMvhKzUtZr1E/gtg/zIC2Ub5sTEZtVbcpBcpH7SB8kMSROhjuMcmCnAw3ke7U5f2Px9vO0sQis9q5JDlH+YWoHtxqbC3NmDgJHvIacpuMBXsurJnhLKBt2HiFK/4OI1zw1JEvgmG8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbjT2rnDwGGSKyzO89jmZqUtT9nV5EE8vcnJLuTwiXA=;
 b=acc+K9oMKALVBWAqBZ1lA3ROGtBCcVHf16Znhvwbebe8ClxWTYvJztsKREq4lbwz+eEHQmRlaxxmTKRZUcZ8yCIV+O9i2V7ALwOT9U5JZSwyKEH+A6fmnl1a8hUNww4/Kh0o5I+S+vueqYRowKbozZImv2Ieew8wytZ5sJYtGnIqlK8oYl8Df95izDR9cwWpVquqMleYZVEU4F3Lqu9iKiL+CnCbE1qnkY7aN3nt+BxvhwDLmhM8JTNq7B+isbJ8CadnpccjNQdVo9HQS4s4FKjCQGF73veYOmz/5RlF/+xiS/rxH1faxp7n5n7fem+vXrJZmyMUnOuwHB3oFjx0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 09:47:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 09:47:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iommufd: Add check on user response code
Thread-Topic: [PATCH 2/3] iommufd: Add check on user response code
Thread-Index: AQHa0qRg5dAVlSz7R0Ks5bmvdmTwfbHvtoog
Date: Wed, 10 Jul 2024 09:47:48 +0000
Message-ID: <BN9PR11MB5276F6E1AF14683B86105E488CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240710083341.44617-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4566:EE_
x-ms-office365-filtering-correlation-id: e7cf98c0-77cb-4490-8308-08dca0c55b7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YXpUdzBtRHBEN2d3bUM0SEpNSG1GaGZLZ3R1UjdpdzYxZ1ZDVnl0ZDhsTHpQ?=
 =?utf-8?B?L253T2RickxucXAvcXdiVnpMc21INFA2M3U3MG5RSnNibEFnOEV1bDNLUjNC?=
 =?utf-8?B?WGt2UUhlSElTOEhKYmd4OTBKYndjaDdSUjRDZ0RPc2VlSXNGSWhCclB4ZlUx?=
 =?utf-8?B?dG1jaFVzRjNsbERNYzVlTHVtSFZQdW8zMUxjV0svOG1Fc0wxTVZUMTE3S2l0?=
 =?utf-8?B?WkNNMDJVdHJDM0lNWGt0ZVlpUlg3NC9CNFhRNXB5cUFLc2ZUUk9tWUxjNjZy?=
 =?utf-8?B?K1NudTZPNzZSTngyR2RoL2o5azcvRkxWWXhtK3c4UXk4YlczSmMzcDhTTUhy?=
 =?utf-8?B?cFplTWZZZUJsaUFvUGFCeStUK01CdVFzdFVNeVRCandGZGNHMlAzRWF5S241?=
 =?utf-8?B?dUhHMTlucGN3UkorMHlpWloxMTRLS2U4MUJ6Q0pwQkhCaGxYeFhpUExVOGtW?=
 =?utf-8?B?MW9hYjk5dXE2U1p2MWg0YnRzQ28vUkU2WEQwOTh2S3d0U2RVb0tTWWVRazRm?=
 =?utf-8?B?YVdFQzlScGVDNkNVYkhFcVNjTnRKbkZveVJDc3RiVUwyOE9TcnNZMCs3R0JJ?=
 =?utf-8?B?MWhuTzdHSWl2UVg5ajBuMitWeDlPUWlpVDRta2I1ZVI3Y1NIZ0J4bDY1L05v?=
 =?utf-8?B?Q0MxcFA0NHQyNnMzQVdIbGtxV3NFM3oxczcwVkU0eC9IVUFHMEZtVWVKK2VL?=
 =?utf-8?B?bGx5anRmZ0xrNHlab3RHaWZJZzlpM2xrOVVoR3FManFqbENjYmEzemp2SXhS?=
 =?utf-8?B?d2h2djdnbmF1RWVCdmxZd2MwK2lxU25HMmdOY2h5YUVvQ0dCZE9EL0NnWnhZ?=
 =?utf-8?B?dW5jcmRoZDRTZTc0b3BpNEllNVNNSkhtcTdtcnVPSTNhVy9nNmQ3ZFdHRzZr?=
 =?utf-8?B?dEpHRjBJNklsT0ZUckJWM2RkRUxvZmxHeG5DZVlZQUROOElGNXlseUtVQS9z?=
 =?utf-8?B?U3VoRkR0SUc5SEN1Y0NFMGFVYTJVNHJrSXRMd1V4cWhXRWEybndqU3YzM1Fm?=
 =?utf-8?B?OHQrbERJdCtwTHh4MHNmQ0p4TGZZN0srUElmV04wNldCWG1pL3k3S1FiWXBY?=
 =?utf-8?B?N1VWdE90MXdoZGFzTmxCR3NKeWJvQnVEWkV5Nm1waGZLeVZIN0hZNVEwTklh?=
 =?utf-8?B?bVdPTkk0azUwNXh3ZlFvYzBnV2NySTIrY2ZTMDRCaXVPRHBVR1k3RDMyWFFx?=
 =?utf-8?B?b3lSUXlXdnc0V0pxdEtYbC9qUXJGYjZlY1dTWTBwQ240Q0NFUDZQYU1OUGtC?=
 =?utf-8?B?M20wMXBjdEIwN2hoU1B4MWxpUmZucjdETEFMakNMdDAxMThGVEM2Tmw3UjVD?=
 =?utf-8?B?WUhOa3U0ajIrdWFjY0hiVHUzSGxEUlBmazIxTEZneHFXR3hFb3YyamRNRlB0?=
 =?utf-8?B?Q3ZUbE9ub3hjOTJVYlVpYmZiNVFxUjBpK0J1cllRNWFIZnRjSzdTL003VWZ6?=
 =?utf-8?B?ck9FSGJENEJFUGhYT2hZTWpIcExDU1c0ZXJpeEVFc2Y4VHdYV0VrUWN5T0tO?=
 =?utf-8?B?ZU4xZWJ3MmU4T09TeUo0MUE5UkhZanFwQS9yRk1OeGpkUDJRWFdHdmhWQ21s?=
 =?utf-8?B?NjJqWUV3bzc1dEk1MWpkeG5LcWtmN25Jck5QMXFwNE9XUHMyT1RLdWQ5REhs?=
 =?utf-8?B?bW1aT2xyS2lQY1d4UkMwVE52Q3RaZnpQMTJyaVNGQ01JM2s3Nnhud2hwZllE?=
 =?utf-8?B?alRaVUJkSzRwRjRCdkx2aFJFbDA3NWJ4bnE4WEttYWVJcFZlODBERWY3cTFM?=
 =?utf-8?B?UC92dHRENUlCK0ptVEVibHpLRVJ2ZkZtcUhGeXBFbTlMSGFIQi9SNmxyUUkz?=
 =?utf-8?B?ZDNITGN4WlRPWDRSemZwVUo0dnpYbmN6SXRHa3d6MkNUR2p2c2hpSVB3SG4z?=
 =?utf-8?B?eFRlMEdSOUxVSHpkcllYeUQ1eDc4TlpGZkhkV1F1Q0RoM3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzVDSG43dTZMSnRLMXRHd1hTcDFsbURkUjgzZmlLOElTa3BmTGJEaThjUi9Y?=
 =?utf-8?B?TUVaYjNtdjA0TTBrZUt2Ymp5ejJGNjFDRmxmTzRhTEoxeVFaV0dJWHByd0t2?=
 =?utf-8?B?SHJwUVZKdDdOVU5SaTlnUHRwQ0VRUTc1YWRxZThjSDFCY3g3R0FIZUZYWEUr?=
 =?utf-8?B?azExYmZqRjNEbHRCWmx6bGhyMEhsWlRKdUZwUkRaYU93dDkzcVVXems2eEZr?=
 =?utf-8?B?eUhzUU1vQktoNVR1eHR5NHJFMGIyWjlUNGduN0xJc3R0MmVlMmhRTDVrNlc1?=
 =?utf-8?B?S3ZweFlWQXNKc3lvKzFnLy9CR1g5QWdudzlUQnZMcnN1Qk5Jd3ZHSStqMDNY?=
 =?utf-8?B?dS90bnZWVEhFaHJURUxVVzJ5VGRzUU5tU3hPaUFJamVTU0hSSlVqQmFEb25w?=
 =?utf-8?B?eWgvNFdyVkZZRWFFK2ZpQkN5c0l3MkZBK0xUVGJYSmY0ak5RRzU5K0h1R1hl?=
 =?utf-8?B?SzJ1Q1ArNHRzVjRDY0J5OVNSSzk0ZkNoUmxCMEIxT2J1Y09oWUZoUHVldGxO?=
 =?utf-8?B?TWJoTW9kbTBadFQxM0R3emF2VjhBa0d6cUdjWGxZR1JmaFVKeTljam9kaXZY?=
 =?utf-8?B?VldJcENXL3NDYmlhOFduYy8yRkh3bDhsSHdOdDB4aXNVWTNSQkZkeDI0cXEv?=
 =?utf-8?B?cnlFTWxnYVFlK1hHMklnTHFMTTFBVG5XTFhhdUpMZzN0dXhIS2dSeFpaZGsw?=
 =?utf-8?B?ejlwenpXYjRMZWEwbnViU09YcDNvaEZEWXBJZ0xvbGIvbk5qL2czQXp0eE1R?=
 =?utf-8?B?UXN6ZEJhdUlTbEhkNEVQOGt1RHA3NEtEMnNxc3RsWWZwbDl5akpOUUdCVjJ2?=
 =?utf-8?B?QmFqcHhLeklqdWxjUXIrcm1qNzQydE9FR0JoRHJwTTZMa2FHSkM0RXYxT1ZM?=
 =?utf-8?B?ZmFyUytmZENjTE5CTGUwUUZtUVZ4R3NIeG96OGwzNTZaSzlha01mampvSkFT?=
 =?utf-8?B?elJ2QXRsSERXUkg4NjZwR2g1TlRJOFJxazZMTnBHUWRnOTFGQXZHOUtyMEw5?=
 =?utf-8?B?Slg5YytZbU05K1Rqak15Um9iMjMzY01vNjNWeTYxNVovYmk0Q1U0TUJ2bU04?=
 =?utf-8?B?N1JUVkkwSFplRXgxM294dW9RRi95T1NzREk2d2tpVlM0dFB3OVFRNm5jM1hQ?=
 =?utf-8?B?OWNpdnRyRURrWHEwYnVQc1NnL0xSdFBJUGM1RnVSWkJBbUNlNXJEUjkzdWxi?=
 =?utf-8?B?bGpicmlCUEsrK1A2b01scitvQ3FzZ3loTUVxQ0htZDUraEoweVNMVHM4QTU5?=
 =?utf-8?B?RnlhbVlqdGYyTDNqbW1qWjdKMVJkVGlzcG1qUEJqcGlKTFc1M0hJNVY2bkxR?=
 =?utf-8?B?RnF5clZiZWVWazFFVkU2U1l1cWkzSnFReVdRMUkvQUZ4VEdqaXh6VEpPSktp?=
 =?utf-8?B?Rkd5aWZXUHg3OUNaYXFVaFBReWtzYlVVRVhzbStneW5jNTI5UlZyMTU5MWJi?=
 =?utf-8?B?L0FGekpnRk1tU3A0NEFsV3JXaS9wYjlmdWRoQ05Gd3RlSEhYYWtiQ2lyRzFL?=
 =?utf-8?B?TzFrMVMzQVhUazNuNTR0UjBTVlY1bkM0ci9RcythcmpZSVJRZlVSOEVjU0Y5?=
 =?utf-8?B?VElJcWdqSldTNFRkdGNlcEQ1dHZ3VEJkN0krNm83M3pIYmlpWWZ6VU9yV0c0?=
 =?utf-8?B?eElvQ3dVMkJUL2JuRWZza1ZGZlRNSlJTRno1aXRFbmU3bHRiTE53bFJ1S05R?=
 =?utf-8?B?anFYbm1BNTB0NEZpVnJzdEJ3WVFKNERuNXJqRG5Eaml4TThOL3phdmJxT0Q2?=
 =?utf-8?B?bmYrdTJtMDNXYnl5S0FuRWllZEZXN3ZuT01YTk8vdnRZNDNLSzJyWmV6L05a?=
 =?utf-8?B?ajcrTW9BM1djWGlkRnpRNG11MmVQczlEdk5LclZNN2FYSWZ3ejJZcDhTWmFt?=
 =?utf-8?B?QTYwSjMybTNRNHVCR0JIVlU5c2JrRU1rMGQ3dGlCeU5la1Vzbmp4YXRYeTRR?=
 =?utf-8?B?dzk2RHE0ZEphVlliQmhXRU1hcnByN0JYZ0tvQWZjZ2dvOWp6UGNiNDJXQ2ps?=
 =?utf-8?B?K3ZKcUxJY0ZPSEsraU82M29wbFdjZ3hibFVQanJTQzJ3Vm5USFlzZnVwbE1H?=
 =?utf-8?B?WnI1YnVoVXhzaXBhYldMYjJrUDU2aUFnQnlSdzNSKzFIZ1d3cFhYeTNHZDU2?=
 =?utf-8?Q?zLiTZJ83RnIwQWbop1SR9gtBF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cf98c0-77cb-4490-8308-08dca0c55b7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 09:47:48.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJu2JK8hyR8P8oqE+kiv9FzuUGCgg+TGwBxr7hImfWema2xTmw0jg6n3gIgrNGD0jYd8ofMksqNfKf+PcPST6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bHkgMTAsIDIwMjQgNDozNCBQTQ0KPiANCj4gVGhlIHJlc3BvbnNlIGNvZGUgZnJv
bSB1c2VyIHNwYWNlIGlzIG9ubHkgYWxsb3dlZCB0byBiZSBTVUNDRVNTIG9yDQo+IElOVkFMSUQu
IEFsbCBvdGhlciB2YWx1ZXMgYXJlIHRyZWF0ZWQgYnkgdGhlIGRldmljZSBhcyBhIHJlc3BvbnNl
DQo+IGNvZGUgb2YgUmVzcG9uc2UgRmFpbHVyZSBhY2NvcmRpbmcgdG8gUENJIHNwZWMsIHNlY3Rp
b24gMTAuNC4yLjEuDQo+IFRoaXMgcmVzcG9uc2UgZGlzYWJsZXMgdGhlIFBhZ2UgUmVxdWVzdCBJ
bnRlcmZhY2UgZm9yIHRoZSBGdW5jdGlvbi4NCj4gDQo+IEFkZCBhIGNoZWNrIGluIGlvbW11ZmRf
ZmF1bHRfZm9wc193cml0ZSgpIHRvIGF2b2lkIGludmFsaWQgcmVzcG9uc2UNCj4gY29kZS4NCg0K
ImF2b2lkIGludmFsaWQgcmVzcG9uc2UgY29kZSIgYnV0ICJSRVNQX0lOVkFMSUQgaXMgYWxsb3dl
ZCIg8J+Yii4NCg0KSSBrbm93IHdoYXQgaXQgbWVhbnMgdGhvdWdoLi4uDQoNCj4gDQo+IEZpeGVz
OiAwNzgzOGY3ZmQ1MjkgKCJpb21tdWZkOiBBZGQgaW9tbXVmZCBmYXVsdCBvYmplY3QiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KDQpSZXZp
ZXdlZC1ieTogS2V2aW4gVGlhbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=
