Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D01A3165
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740364771; cv=fail; b=Jtg5UAAFrP+1KOYyLex7OpPUwxlfnYgCFkGrbI1j4z/2QY0qikMp/Je03j/QVF5xBvw7nLor3JCEV5hnTSco/dJKRLelcUgx5+VXai2EgCqcuvis5JDxvDB362WsdAF0uz/RCK2jrWybp9h1BKJY3auPtg0RCPcrbD009jtMYTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740364771; c=relaxed/simple;
	bh=dJRkpgjNQ9Ys5zDvcC6smYQQCfBOedS4REFWWQgn6qU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=an7kKST06zbwtwjQOzwssjSrqZm5nFfxlvV3fRWi09pWugQbz285DoaxHqdoZHZFqkU85WK9cLWuHxet+myEdnOlBlAWRhT9T3JTBQsG286JY8ZV2aY+xmAmZy+FlSCQi4bXJJA1nIW2wM27p0aC0ALAkb7v2AOmVv6LhmWXwYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIy2zb6E; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIy2zb6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740364769; x=1771900769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dJRkpgjNQ9Ys5zDvcC6smYQQCfBOedS4REFWWQgn6qU=;
  b=lIy2zb6Eseyjd+fvHrkFaPcM9iBdYNI9uieXdA9vcGBAcPjDvzqnhlfe
   d+JVnxtOf5tQnorHwbrepHYUodAuCQV74pm2Gp9TsvN2sNrlWR4pxGBtd
   jE/gjZ6zngrH3g3oTtPHVi/Yj9FwDo6GnLl23G2DRqVT3aLNzEvtIAcl3
   tR0cqoJY5zk/JdIRDS9KHnIseV1eRyWwyS8s+JAWFNuPnYftbr3sIaRNR
   3AAU6IndB4q7HtKj+PCC01HoM1pfZdeLptRtho7qyMTnbs1Vcd/WRUUSR
   ZQZXsuYQ7kfLIS/2OYTrHkhJx8LQg0rbhKYNiyJrl10gYgJE9CIwF9sJX
   w==;
X-CSE-ConnectionGUID: nWnnC1AXRhKJJmBYMh6d4Q==
X-CSE-MsgGUID: YsNOrxIZQUu9fw7ozDbZ/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41370883"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41370883"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 18:39:28 -0800
X-CSE-ConnectionGUID: BM8pgWImTsWYNT1BLzbKKQ==
X-CSE-MsgGUID: +Vp6fdwcQLOsyMcycL59mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120842465"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 18:39:28 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Feb 2025 18:39:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 18:39:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 18:39:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqYuX4JCO+x5CxZNVJ7tA05iXIcHksQuEEjbN9Jl0qYsW+/Pw0HlHUuzYtup3XdBcDOqNxxPblu6wb5HDp+yrdafEg5I7b9aBrTWHO+ASCvDZdMLQ2Fp5HWLPpmWd6+5gX36QegIpRlw2JxPoNtouOEEDZ/6BD1PxtgqRZr58rv8xDPyh4vSSCka127s4FIr+XVmW1cZc3OiNxKt+6MRA5oDG6+sKDbhVWb7ziBaOyFO403TdS258KExxXRg34GnpMtXa6nzrd/Y6P3Zg7EHjmqe4rR0tNLCbLAfRDYL5ofLtcKtFzVmBuegcTGur8mQPHkYjJ7Y4nTgRRv6VJ6w0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJRkpgjNQ9Ys5zDvcC6smYQQCfBOedS4REFWWQgn6qU=;
 b=sJgstGBvk/mSAWBuqM+4QrdqM1dHWAmsMlLLKMaIRz8ghIubiqsY6PzHga+RFLeoaDDnlMfl0KKtinV+9MaMgVUEPtvz0/MyDko05TX6rfCSpIdY3a8zF46Wu9TBNRFz+0PynmguVO2eT9KesH61XpMMhvK/7sHWiBHCYOqxUXpHqBCR8Ygf4JvDwd2tb5LStSsUS4dQfG9dzVeilUZNaGa6lFhVZGQInc3gVJmcM5I6PGvpcNjDEmzsTBZABl1huF6iLzKVzpRLEoZz9l0TlRj43e6IIFieHzgv7QbjSBhzcWu7Ck7+/lIjqGcY3yBjeJDRdySBa2Cbr6ogZQdxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6432.namprd11.prod.outlook.com (2603:10b6:8:ba::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.19; Mon, 24 Feb 2025 02:38:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 02:38:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
Thread-Topic: [PATCH v2 3/4] iommu: Store either domain or handle in
 group->pasid_array
Thread-Index: AQHbhG2dqKQgcpHGIEKNqrStlyVpILNU4ygAgADeL2A=
Date: Mon, 24 Feb 2025 02:38:54 +0000
Message-ID: <BN9PR11MB52764D5D3DFA97B187DAACE38CC02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-4-yi.l.liu@intel.com>
 <a4a1e65e-3614-419c-a5e3-6ff2aa4f1369@linux.intel.com>
In-Reply-To: <a4a1e65e-3614-419c-a5e3-6ff2aa4f1369@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6432:EE_
x-ms-office365-filtering-correlation-id: 95c02742-ca78-407b-4cf7-08dd547c6195
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWVsMDFXa2pkSTA2c1E5bDNzYmNHUWRTR2VVdENvRzVjMmRWMkhNNVE4bnow?=
 =?utf-8?B?eU9ST2dqcTFIK0d1Vk5rQ0RSdWJuNDBocWxrRnpNTUVTRGJ5TlZPZVNDUUFp?=
 =?utf-8?B?NEt5OXR6OWorVExqREZXMTdaeDJFb3pDSEJDc01VVTlEM0dzNVZjaENqaUlV?=
 =?utf-8?B?S1FJWldRbnRrY0NVdDBGTTV1M1hhUGxzeVBpSE15ZFRucWlvSmoyK0VEcHVE?=
 =?utf-8?B?eXJXSHhQOHp5alBwRGhiT1AwbDZOVnRYV2Q5S0dNQjFsVXRQZ3U2VG1QU2xE?=
 =?utf-8?B?M3EzYjRuTDdoT1pXcnpITXZQVGR5MWF5YWh5c2ZDTU1neHRvclhSM1dDNVBp?=
 =?utf-8?B?dlNkOUdnN29uNUhwUWgyQ1NSY0VBazYvamZueGpaSDdwNnRXUUc5TEFmYUJx?=
 =?utf-8?B?OWtRT3poOXh5Mk5DRDR5eFJ6TFhQNHlsM0dwWm9meHpOSnZRRWwrZDUyT1ZE?=
 =?utf-8?B?VlZzVkJJVC9LVEdKRWIxN1dMSEExU1RVOHZUTkhUZ0RGVjdhQVZnN3ZHRXIy?=
 =?utf-8?B?WWorMXVsdkF3b0FCQWxvNHUzSnlBdFVPNHNTNjR4WVQ5Ukd1UGdSeFpZZEZT?=
 =?utf-8?B?eGM3bW1QeUNsRE1BSEU3dUxMMEZPaC8xRkpmQXVwbVlMSkF0c05TaTQ5Qy85?=
 =?utf-8?B?eEEzN2MwZElwZFdYUlR4K2wxL0FuLzRrVkdWQmxhV0lnWFdVcTV0dmxma2hW?=
 =?utf-8?B?Z0R4YXozYVhKeEluUk16R1pjQkRSSU5LVkNvYk1PL1hqU2JIVzdxb1drbE5S?=
 =?utf-8?B?aC84TWhWNkRsUDUySzZnaG1HUDM3TDNEZEhtK1d1aHJXZ2VtdGhoL0pKRm8r?=
 =?utf-8?B?VXBJY0ljWjFqWEZQdVk5MS96MEdaSmVJUkdlM0p0bXczVmMyVGNybmtaMzRD?=
 =?utf-8?B?b3FrbitvbU0vaEVtK3E3S2g0VGdJN2JVdzFGWUd4RC9PVDJqOEYrcCtrVHZk?=
 =?utf-8?B?eUF6M1l2TWZVSnJHOVlQbEJoTVQ1UDBEMFkzb0lQZCtKRE5xMHhuYXo0TFJq?=
 =?utf-8?B?WFBPSnZqQmduVjRXeGZkYVlBNXIzYnN3VDZBaTRDWUFHSEg3YXI1Qm9IeE9S?=
 =?utf-8?B?RU5kcWRRaFhUcFJTOVA3d29hWTFYWlpTNTBWT1FpeVl0cjRCN3FTb21HOVNV?=
 =?utf-8?B?MHZTU21UelpSdUFmZ2ZYbk1MNFJxMjJjVEZqdit4c0ZYaXNCMFN6UWVzUzFw?=
 =?utf-8?B?K1FHUjBtWTNKK3dSZ3g4bkxXVWNxdnpDVWNOaGkyTE5ZZW9RdEp1VkdUWUtT?=
 =?utf-8?B?SzRRR1ZyUmJYNFhUK1Fvcm5jZkFvVXNEQXRGUkpuY1lYS2FMWGlQQ1N2RCtj?=
 =?utf-8?B?SDk1cGV5ZHVraCsrYi9HV2d5eFhibGRPTmF0allnREdDOGh6Z0VLV1ZXaHNS?=
 =?utf-8?B?cFBRaS84a2VsMU1ZUElnRkhZTGpJVUNMMGp3eE4weXQ4RWplc2h3UjdIRW4y?=
 =?utf-8?B?TmNLOEo3WFFiQ3FPUm4zaGprU1VFcXZtaUQwV1AyeFpXZFJ3SHFNajZ2bVV0?=
 =?utf-8?B?YnI4WGZ0cmIwWVVkRk5UeC9scWJrNzZoTVBUK3B2dUViTHYrTXdyTVc2QmQy?=
 =?utf-8?B?aHdPdlptK3lxWGc5UzNuVDlUYWVCYjZvc1lxREtRaHlPUWl3V21pMlBCZ1NP?=
 =?utf-8?B?ME1uSFVIRldneDE2VnJtbGJOMEd3OFM5MzBHUm8xbEFiRXNZM0pnR0JGNkFV?=
 =?utf-8?B?eGNwbFlXY3AyK3JpaGZLOEx0c0R0SHlEandlYnpmVEwzWEtUZjJkVlR2MnFh?=
 =?utf-8?B?K1NiL1VPOElRa1k4TVkvdUlOOHlkMzZZR215T2lIcFhKOUVsRXZya1VCMVFH?=
 =?utf-8?B?WWd4YS81eWFFUjNiZk8xTkM0N01oTHE0SnRZWldqbkpsZW1pUkZ3UFc5MzFw?=
 =?utf-8?B?SlVFQjk4WWV4OXNUMlU4NWkxcFE1UmdmOExXTUtGbEpKc0dQNms5YTZaNFhW?=
 =?utf-8?Q?Xp7SURXmvGO1+ywFy1FJ/6EkRS7yl6a4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU51c3ZqQ1RoZnUzaW5HanBjVXg2N2huMWs3RVNoMmpWVms0SE1McHJtV3Zj?=
 =?utf-8?B?NHlSUDFiNDQrZzl1cVVRZ2Nmc1NHc1dyL0pVbDdnMFkzMTRzanI3MlpibU5z?=
 =?utf-8?B?bTg3NUUrSUFQN1lGRlhralBBM0VodnFadnEzV3hWV2o5ajNwaXIvcEYzbjM0?=
 =?utf-8?B?VG9XekJQZk9nRXNNU2xGcnUrWS9YaDR1RktGcUdPakw0VzBSb3FLWmhGbnht?=
 =?utf-8?B?S0M5Wi85OHhjTmR6ZVNXa0FrNzVoVXpmajI5UWxVU1lGZlN5cjhKdDF4UWZP?=
 =?utf-8?B?VDlkaHRjbnpKSWxaK3V0QkJkV1Z4clNJcG5VTldaWVNyNjgxWHVPaDg4bUt1?=
 =?utf-8?B?RWRQRG1ZcGYrQTZjdkdBT2tqckIvKzdzZVNZMGFkQ0YrYUIyekhQR3JTczJz?=
 =?utf-8?B?NFJHWlduRXo4MUs1cSt0VCtydDBWQkhOU3EraWNKajVWSk1BVG81Um90bU1m?=
 =?utf-8?B?eEFKVTdMaVUxVi91T3BrQVNaZDlUWmZJcG4rQkc2ai9ZV3VNR3ZlQitSbkQw?=
 =?utf-8?B?UTM2enB5dm00Um9sS3ZFQW9VY0VDWm1wSGVYOFBjN1JrakVhcTFwcFJkSFlP?=
 =?utf-8?B?dCtKNHdIMmUxT0ZuSTRXQndSVU1VR2YyWHNmOHBTdzNIeFNzK1l0UWl1dEFG?=
 =?utf-8?B?UWhjREJmQkpzVUpmd1lVRlFaOWt6RldGSnp6cDJNRmV0bmdSM1FNeXE0NW9V?=
 =?utf-8?B?N1NWaE1iZGVhU01uRkx4OTFkc0gweHdQK2xOU1VQb1UrMlUvY2RDZ3BwMExt?=
 =?utf-8?B?aWlmRXRFbVZHVEZoK3BzTnRrOExWMWhFUUpGMDloOVE3U1NaTUZaTDVWQTIz?=
 =?utf-8?B?QUVyVXlvbzVJV3JPL0poTTFOcHZ4TFM0WnVwaWJERmdtZkduUGx0d013Ymx6?=
 =?utf-8?B?Z3AyaUp4eHdiQmJFWVIyYUFwQnFoNWVxU0NDRHZqWHQ4c1J5Tm1ieEtPVzhE?=
 =?utf-8?B?N0NJYy95WnFoTy9mNmROaTNoa3d0cDNJbFNBK0F5UzlmZUxlazNFaDlCS09J?=
 =?utf-8?B?bTFIekFQazd0LzdIaTc2K00vNzN3YVZoT2xnRTdJaFpTZWkvNHFrY0NZYlJa?=
 =?utf-8?B?bFlONHhIMzB1dzRkQU01ZGJnYld3UFNreThVZ2N1UFhQNnEzNmZZeDVyU2xI?=
 =?utf-8?B?T1JSVTcyMkhXblBiZG9uZy9OeXZDMjhvaHdLRkFCemVLTUtWQVdSOEN3a0ZS?=
 =?utf-8?B?ZGVqOGMvZU9ZVHkycW8zY2o2VldqVDk5Ym9JQXpLUk1Eb3JVZzgrUHZPcjBn?=
 =?utf-8?B?MjB1aVNRK092THFlQnZzd3FXM21FM1Z6WmFwWldWU3p5YnZycGRtY3Z0em95?=
 =?utf-8?B?cmZ1OWhtYk9ZMWZ5azY2MTdtK2tDU09uaWJqR1hQMWNKQUt3K1Y5aHVRc1VF?=
 =?utf-8?B?eDI2Wm9UWTJUb3VTVkdweStHQTQrYVNmTFFPcnJLaDhqSnkzSFNNV3JLRjBy?=
 =?utf-8?B?RktSTGROVy9maUp6TnhQV2Z6dnBqL0VZMjBGYWg5aG8vSTgybVdUZWZhMVJo?=
 =?utf-8?B?eXBNYWVkQjRuZDR3S3k2K203d3hUU0E2MmtwNUsxUVRxYmQwQnJpVzIrWmJS?=
 =?utf-8?B?MnRlSXNOVmJFZ1IxUU9WTlJGVzR6bUJwWEw4KzRwbFNOQ3J3alZ5NHE5Uncw?=
 =?utf-8?B?R2p3Rjg4YTVVK2ZjK3NkbVIycEZCUFRXQkMwYUZ2c05aNStXODNuSEZTRURt?=
 =?utf-8?B?NVphZ0VKaE5CcFp6QUgyL2I0KzBxR1d4aGNPbVFwOHpCSmp0R2lMN1M4ZmlM?=
 =?utf-8?B?cHd6bDhOYUdObXVPNUc5Ym1IU2N1SHRMQUlSSHdMTmtKVG1YRWJVcVZBYzRl?=
 =?utf-8?B?dzZoOEVvRDQ4YTB2OWxNTTNGRk9HZWZwR2FKU2VRK294THN4a0J1cWRReVln?=
 =?utf-8?B?K2VUa2g3ZlZOanBBOElrUnJVVWhpMk5Bd0ZjenlHL0FndjUvQmo4NGxKVUxL?=
 =?utf-8?B?a0NGUVJCS1VOa0dpVnUyb1dZL1RzVVc3T1JCeHl1czRtWDZZTUgxOGIybG1O?=
 =?utf-8?B?Umx2bzBuUGNXbkd6TUYwc1pQWWFKMThFTkRVZENpVzVKeEtDSjlkbzhEenNW?=
 =?utf-8?B?QS80VXo5eDZ1c1dnOUkvdnBUY2p2cWRSUHlFaVVHcm81bFRyanFWMkdyUW0w?=
 =?utf-8?Q?UIX9CsaM+JP7nIvIDmFkjXeUU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c02742-ca78-407b-4cf7-08dd547c6195
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 02:38:54.6027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xBcT09Tos8aK0s8jxOqIWSN+y03DPpNVIcwoiz0LNDbbZjDXQsiGSYA1M+/2H78uST72IzDX38Lc/yivG9VpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6432
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEZlYnJ1YXJ5IDIzLCAyMDI1IDk6MjMgUE0NCj4gDQo+IE9uIDIwMjUvMi8yMSAyMjozMywg
WWkgTGl1IHdyb3RlOg0KPiA+IEBAIC0zNDU0LDEzICszNDY4LDE3IEBAIHN0cnVjdCBpb21tdV9h
dHRhY2hfaGFuZGxlICoNCj4gPiAgIGlvbW11X2F0dGFjaF9oYW5kbGVfZ2V0KHN0cnVjdCBpb21t
dV9ncm91cCAqZ3JvdXAsIGlvYXNpZF90IHBhc2lkLA0KPiB1bnNpZ25lZCBpbnQgdHlwZSkNCj4g
PiAgIHsNCj4gPiAgIAlzdHJ1Y3QgaW9tbXVfYXR0YWNoX2hhbmRsZSAqaGFuZGxlOw0KPiA+ICsJ
dm9pZCAqZW50cnk7DQo+ID4NCj4gPiAgIAl4YV9sb2NrKCZncm91cC0+cGFzaWRfYXJyYXkpOw0K
PiA+IC0JaGFuZGxlID0geGFfbG9hZCgmZ3JvdXAtPnBhc2lkX2FycmF5LCBwYXNpZCk7DQo+ID4g
LQlpZiAoIWhhbmRsZSkNCj4gPiArCWVudHJ5ID0geGFfbG9hZCgmZ3JvdXAtPnBhc2lkX2FycmF5
LCBwYXNpZCk7DQo+IA0KPiBDb3VsZCBlbnRyeSBiZSBOVUxMPyBJZiBzbywgYSBudWxsIGNoZWNr
IG1pZ2h0IGJlIG5lZWRlZCBoZXJlLg0KDQphIE5VTEwgZW50cnkgd2lsbCBnbyB0byB0aGUgZWxz
ZSBicmFuY2ggaW4gZm9sbG93aW5nIGNoZWNrIGhlbmNlDQpnZXQgYW4gLUVOT0VOVCBlcnJvci4N
Cg0KPiANCj4gPiArCWlmICh4YV9wb2ludGVyX3RhZyhlbnRyeSkgPT0gSU9NTVVfUEFTSURfQVJS
QVlfSEFORExFKSB7DQo+ID4gKwkJaGFuZGxlID0geGFfdW50YWdfcG9pbnRlcihlbnRyeSk7DQo+
ID4gKwkJaWYgKHR5cGUgJiYgaGFuZGxlLT5kb21haW4tPnR5cGUgIT0gdHlwZSkNCj4gPiArCQkJ
aGFuZGxlID0gRVJSX1BUUigtRUJVU1kpOw0KPiA+ICsJfSBlbHNlIHsNCj4gPiAgIAkJaGFuZGxl
ID0gRVJSX1BUUigtRU5PRU5UKTsNCj4gPiAtCWVsc2UgaWYgKHR5cGUgJiYgaGFuZGxlLT5kb21h
aW4tPnR5cGUgIT0gdHlwZSkNCj4gPiAtCQloYW5kbGUgPSBFUlJfUFRSKC1FQlVTWSk7DQo+ID4g
Kwl9DQo+ID4gICAJeGFfdW5sb2NrKCZncm91cC0+cGFzaWRfYXJyYXkpOw0KPiA+DQo+ID4gICAJ
cmV0dXJuIGhhbmRsZTsNCj4gDQo+IFRoYW5rcywNCj4gYmFvbHUNCg==
