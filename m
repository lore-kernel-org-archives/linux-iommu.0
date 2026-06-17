Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A834A3542F6
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680474; cv=fail; b=ZcnVmojJhlPiQE1+3EKnXH78D8RXdmTF5x/LTJtsdUYIV0HHaX/LuNGaCYLoOtl0yy8V2LLidBw1QGTgrj7hF6Vgcr6VwOFF+YPmF1be4p4wCCKWOx607ZUQnJMa2oOTfUkZ4xW4Vp0x4MKKG2OQv36dknjQpYdL35XVlaeLTGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680474; c=relaxed/simple;
	bh=DwCg/1UpmeHT/BOHbif1OJXLTGG5ipxzIHbZ0BFc8nw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EeXhQiWjOr2T7hHBReo31SrIJgQSnDS7BMrluaXL2brfZ8KhcRvRfk9h+3+u3V6U79GLB0O2VrVnsH7Fl+/SiX7nXBPnGIUTEQUOuhEPT23vFIgzawDX1cHvX5bNEoZyk/WckQZBAsDJDSSAx6cD1zhuYcMGxG8SlYC/5HnD8jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUDIJQT9; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUDIJQT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781680474; x=1813216474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DwCg/1UpmeHT/BOHbif1OJXLTGG5ipxzIHbZ0BFc8nw=;
  b=jUDIJQT9h6p/tq2SW1jHZ4cImw5IcIpHSCyZgYiRSMVdfjjFGE84uEza
   PUg4i11HUwJyEuef3vOqsUjCNTwY0HJIUPVb8D6UQmss+2DHlvkeUfD1X
   2HbJU3QfTjqblJ2ede/7hHZRivGeuH+wiTl152zWq45m/FHOFBuW/cQR9
   ZB9g6anqPTB7TJJwKdDxDpOOOMLOIedI7UO4BhwPaO9FpqvUwYfVimppE
   aq+t9DOZ+2UkQ+Y+YYgWk3Kloj5LI08I3YSn/ALFnpoZEl2CEGRzyEYT0
   ornVhS7pM8ZL1iHfBmNzcbnBmcOi7nCTiRf0/2s+rTJGfLc1HXYIinvEz
   w==;
X-CSE-ConnectionGUID: SmA6lay6QdqPF7ZCH6qt5Q==
X-CSE-MsgGUID: mTuzv1OAQhG+M9duNwtjjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81594494"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="81594494"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:14:28 -0700
X-CSE-ConnectionGUID: dyfj53T2Ra2DWNGkBQkgVA==
X-CSE-MsgGUID: qGBYYvX+Tv6KTT5TlKf6ow==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:14:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:14:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 00:14:27 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 00:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfUzdk/jY5LHOAmCkmZUuFFpfDY+/poGxzoxsNSfsRBvRb8l8eMimtUo+KqgQ1yb0bhIuqYG4RIHE8BshJCLncS2IQ40CYz9asdCGglWMTzAOfYgEXb3DnbLBfNjG3wRs532tRkbBDmflSuOk0dkutpYPOq7cp7Mlqnt1vgx25lGPe64uKLOPM8GWfynB3Bh73tNkxPMnlpxmM0hxBIupyHN+K/ATEKUKffwkQjeKlUUMr51pfP4zyqXMxbguVpnUSwjBzpO1WHbFZ/1+Sidwh7lnP8nSFBqcc+Qnk6Wn6YtN9mE+Qe6cTPjqh6wTgG6DA20n9iHrxgNFFh74Wh8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwCg/1UpmeHT/BOHbif1OJXLTGG5ipxzIHbZ0BFc8nw=;
 b=aj1Zgbx+dwenTDFxXdXqDz0eY0Rn8kSYHCE/mAMUN2F/LGArOfXGOVN9mYX6QYXCNnXUk5yCGuuAuSXv2OD/3JjleVvY265CLBY5FUaYSnzg5kdPQSkfDmMrY9pUSH45/4GjB6zXYZIqHjoGs+bhGGAK+0RNilWcbX2Hf1DyiLpv3wv5V+gEoA6flqPwTC5gnua2dkWNskqRQAkWG4lhB4hLQtQKiW+8UXs6fPAd4N+YA1RHA3dBPfo/yMvyiofWEBZ7QZbjs7BSa1gObRwVw7SGeQwAtrJfUUvCjgscDnqCQPb3pNVUdWawz8ayLg827J6vQDdO2S0XuyM63snDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by MW4PR11MB5891.namprd11.prod.outlook.com (2603:10b6:303:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 07:14:24 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 07:14:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Joerg Roedel <jroedel@suse.de>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, Ashok Raj <ashok.raj@intel.com>, "Chris
 Wright" <chrisw@sous-sol.org>, Jesse Barnes <jbarnes@virtuousgeek.org>,
	"Mallick, Asit K" <asit.k.mallick@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
Thread-Topic: [PATCH 4/9] iommu/vt-d: Consolidate dmar state management and
 force_on logic
Thread-Index: AQHc89/rGIuyxu1Md0mi0qVQ4r0sVbY/IAiAgANHqHA=
Date: Wed, 17 Jun 2026 07:14:24 +0000
Message-ID: <DM6PR11MB3690A320BEB82740F86424A18CE42@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
 <20260604051540.592925-5-kevin.tian@intel.com>
 <c6ddabae-09ee-4101-94ca-d077514bae5a@linux.intel.com>
In-Reply-To: <c6ddabae-09ee-4101-94ca-d077514bae5a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|MW4PR11MB5891:EE_
x-ms-office365-filtering-correlation-id: 55b777da-eace-4563-f475-08decc400f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|22082099003|18002099003|56012099006|11063799006|6133799003|4143699003;
x-microsoft-antispam-message-info: aI0Zs4Tg9vLtaLT+/Nr/DUBqZEE/0kVnOojXp6oAE2rVllqIIqhwkvAfZM4Tadr/14M1ITFQj+YIY9dwBa+3SXI9U+xCkzvseKh1VRT9fUVduu6xHrarV9fpUq8VcyWKiPtIf8VN4tbnpviGqeb/nDvxfVgihYwVyKQD5lgN48ojIQItGwRdm6FF7HimXztvC3VOilDTlqu0ezrUcSOFKCoqqAERAtIRky/Im3dKxtwP3MflGmfqH6txCNhfmrVxiN1TgRJbfMeCGVg3itWlFtugaaEJB41S5KWCnD8RTygfoVIIga+o09sKZKe2usT+NkmQbuQjebN4QOILVjDfAc3DEFHLx/cjII6pJsi3SDutIQDYS3jGuuFziyyA4Jh+cvRR6+1htEv1BVWKEM6JRrqNjxPlb6789farG34CTrQYR8KhzVDqepOS32ETV+FsnxAJ8Ya6qQcLYkGAKpyf6zKVJPEY/pSKMUdv+JAZrmx6BOpoVQRwzGpcGNxjgTnnOumlRfINitVEQLpcMBQMFo0M1jI8sIp7zOzgxtxHb/pZnZc7YLOl27yK9hNhTC6hwjYcyLGKOVAEWPJgTcesRl+1uFRmndktYiig8zAFSXQ7IDmTvKZczmi0gt134LnYaTseLLTMO09I6MFtESueTzYnNRzhZutY+tmpy8sPuM3m8ffaecv8WfM4TX7Ox600zPESdo0tdfsV8sg4HkJxnpscOSdY+DOHN5tj/6MjOESTnemJ7yFy7hrb2C8SRGrs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUt4L3Zsdy9iOGlnd0VGeS90dzhnVlR3d0ZkRlF5NlZkTjhqRlIwaDA2WE1X?=
 =?utf-8?B?akpCVDZKeis0RitmTlJWem5RVlBudGgxUlhMajNZcFRKNEt4ZkFDMEk4NEpq?=
 =?utf-8?B?b0FnU1hLY21vbjJlYkdoRTZQN1I0eFJweC94S1FXbTFSd21rRDVrWjRnNXRO?=
 =?utf-8?B?QzhMb2tmNzllN05xaERoWTdyRDkzd25CdFVDU1hIVlVzRDI5S3BjQ3RUYXhz?=
 =?utf-8?B?dXBLb2lla05QcXhwWFN6bVBxRWR0enpGbXpWbHBzZk55VTBRZVhGU0lvTlM5?=
 =?utf-8?B?MFYzWHpWMVRPa2tsTmRVcllNYzZ5SFNadE9WOE9IbHJ4RVEzNlBMRXpZdE50?=
 =?utf-8?B?MDJ5MkV3b3pKZTZQbnZ6T0IzNG93VWdWWFF4a1FDTW9CSnBLYkNZM0k2ZmF6?=
 =?utf-8?B?M2NEdTVZZzUzb3JlcHhubGdGQ1JFL3hDL3AveE1VTFI5cWc4MFpSaVUyMnJ5?=
 =?utf-8?B?UW1GYWU3NXhMU2drTlFFajFVb2V1L3lXY1J5cStYVzN0NFVrWW1Vc0o0bXA0?=
 =?utf-8?B?T3RWbEJiajlTa0pMUmNuQ0lOWjR2MEw3ZFp2MEowVUxySjZVdVlKNVpFS1Yr?=
 =?utf-8?B?NzFNMkVFZE9IODRDR2QwRzNrU29XUXRpaWJWdnNULzhwaWpmdi9HZnhmcUpZ?=
 =?utf-8?B?cG1ZV3lCU3htVzNuamVaOWV6SUw2ellVZ0I0UXpkTDFvMU42R2FFNHh3RWEr?=
 =?utf-8?B?MTRMcnFLTk40RXBRT0E3YVBIQndacVVGVnFEVG9GYnp0WlF4eUVEWXpZckpw?=
 =?utf-8?B?ZTNjVVpNT1B6YlNGc0szSXRkOSt0L2psMDBSTUdwek82dGExSmNLajlvS1ND?=
 =?utf-8?B?VFZ3UitXODB6LzdKMHNTNWhUSzgxRzAzR0pEaXZyTGtrZUdvSDdtN3hqOC90?=
 =?utf-8?B?ZkdUY3gwQjI5U3dBMkM3V1R3KzE2dXE2bHc4VDVRN1IwUUNzZGlOSHBKRW1p?=
 =?utf-8?B?Qkp3Sm5VOWVZNHRFaWljeDRlZS8ydjU1cTRpZ2ZyNjRnMENMTzhZcmRibTJk?=
 =?utf-8?B?VVd6ckdHakZUbHltT3BrUkJrMm9hTDRQUms4UjFkeHVKTU9RUVJmem9tMEZi?=
 =?utf-8?B?amI4R202c0lRVFBublhZejEvUm90Q3BBYnljN0taSjRMWXRqendDR21RNnRM?=
 =?utf-8?B?Z013ZnZTVlJsY2tRaVdZczFZUVR3d1lQdWNWK2NrczBoRXhXa2pBVkpXc0E5?=
 =?utf-8?B?NDk2N29iRXh2WE1qQld1aG5BQ0o2emV6Q0FpUjkvSjZpUkdyVnpra1Q2TVFk?=
 =?utf-8?B?L3JSS0l0RFJwa2xFS2pIbDM2S0JKT3Brd25KT3M2M2grZk9TeVBKUFc1VklC?=
 =?utf-8?B?bWY1citBK1BRQllJOGVkd3lPcVdGU3NSbXR0VVhYM1d1ei84QXF4NkJnaENq?=
 =?utf-8?B?czNLblFCRlNwWWJpTjBGTHNCSkI2dnV3bjdmMElYVVgwejdDUnJFMVNPVkNP?=
 =?utf-8?B?TUhVbzJSSmU0d0Zla2ZrUDdYTmd6STFCZHRyR0VzZk1xODd3dFBReWlmeDZk?=
 =?utf-8?B?bFVKWkZLQzZoYldObVNNMkRiZDVZQXdzUmxVT1NlTS9IUURrd01HdFZiZk45?=
 =?utf-8?B?SjUzTUx3eW8zN3M3LzNPaW01THoydVl1bVdGUHFmTnpRaDJ2MGFVNGxJOCtu?=
 =?utf-8?B?N3pON0hIQlVYaUNOMXVWWTVVai8xV25ITzVJd3NueVFtSDNnNjVTaTJybVJP?=
 =?utf-8?B?cjZqckRpZDQ5bEd4STZjNURLai9tV0RqbU1JOXc0M3dvWUdrM2FzVHJvdFFm?=
 =?utf-8?B?dzNnVktVV1VYWFRxWnYxam5tOU0yaGhRckNXZkVMSUxwM29RUTJ3MThXNlNJ?=
 =?utf-8?B?Q0VraUo5dHdEdUNuVU93bE9PK0wybk52WHpPNTdrNFhtSXByLzlEWXRSd1JW?=
 =?utf-8?B?ZUcrbC9sdHNIdnk4VE5xSFJEWFZtaTRWN2xEdFZ5SXlLeHZrY0U3TWdlM2xN?=
 =?utf-8?B?RmpzWXRWMU9Ob1VBTG83UFRCWHl3aEFyNUpncldiNFg0T25scDY4c2NWY3hM?=
 =?utf-8?B?ZDVtZHJxbEhGRkgzT09JUzdtUkY0bUVJejd3K3NjZHV3VXJ1c3pYN3FKbWhk?=
 =?utf-8?B?OHNwMEpiTzVNQk9kNVhoSUZJR2p2M0VTcTAzN3UveFpGRFJPQ0xvd1h0cmFT?=
 =?utf-8?B?aXJCVStkY1B1WG1walFaUUNUekorUmxrd3JFeWdTcmh5M25PNEdhQms0Y2Yv?=
 =?utf-8?B?S1hyckplMUN0anVrYnFsajVRdkVZUHRHQTByeXBzREZLMWVHc005eElJZDUw?=
 =?utf-8?B?UjNmOEJCNWFBWWNkaU93ZTlFQlRvTU5Ca3JnRnZPNCtPSmdEQmVlSEhhR3J4?=
 =?utf-8?B?TlVtaVhSdk9JcTYrL3VWZmdXd2Z0dzBWakJRcjhlRVZEUmVrSjllZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rSDOnRznW8WNcG2v6IE4abGglo0pKIgQ/TX7CW7E3gsrc8n4x6egsnlGGf25YWjvVvk5eWWiPmv0Skh8aeJ7tFSHNCxpy2QRUM9HqV/ssYeUYfXPdJjW+FRfWqTeLQJOrykKiCToDmfumMDa5d7yilF3g7NyRQphzy1jCcIO3dVeQj+5tGIYQA1tlHGbfco12LncLApswpDhGg9hJP4c+r/If4J6USIpyKxt4SwkSmwxBY5Rnlw7Fehwq7C01+wgFOzFFaEufJw7CGuJGY8UNumWZI8ZWX48gTSyQFl5H9CbJsc6kAtdlltoKcPJVUsEal3662r49EB+PbTb5+ftmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b777da-eace-4563-f475-08decc400f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 07:14:24.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QBWHSRAqFIk5lBFNFgWlft8jcoKUFMEir5q+Y/sU8OJ9szkupc58hSPTxg9rEprLCVPukIUwDrc6CKwoNU9FZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5891
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25k
YXksIEp1bmUgMTUsIDIwMjYgMTowMSBQTQ0KPiANCj4gT24gNi80LzI2IDEzOjE1LCBLZXZpbiBU
aWFuIHdyb3RlOg0KPiA+ICsNCj4gPiArc3RhdGljIGlubGluZSBib29sIGRtYXJfaXNfZW5hYmxl
ZCh2b2lkKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gZG1hcl9zdGF0ZSA+IDA7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBkbWFyX2lzX2Rpc2FibGVkKHZvaWQpDQo+ID4g
K3sNCj4gPiArCXJldHVybiBkbWFyX3N0YXRlIDwgMDsNCj4gPiArfQ0KPiANCj4gVGhlIGhlbHBl
cnMgYWJvdmUgc2VlbSB0byBjb25mbGljdCB3aXRoOg0KPiANCj4gCWV4dGVybiBpbnQgaW50ZWxf
aW9tbXVfZW5hYmxlZDsNCj4gDQo+IENhbiB3ZSBwb3NzaWJseSBtYWtlIHRoZSBpbnRlcmZhY2Ug
Y29uc2lzdGVudD8NCj4gDQoNCkNhbiB5b3UgZWxhYm9yYXRlIHRoZSAnY29uZmxpY3QnIHBhcnQ/
IA0KDQpJZiBkbWFyX3N0YXRlPDAsIGludGVsX2lvbW11X2VuYWJsZWQgd2lsbCBiZSAwIGFzIG5v
IGluaXRpYWxpemF0aW9uDQp3aWxsIGhhcHBlbi4NCg0KaWYgZG1hcl9zdGF0ZT4wLCBpbnRlbF9p
b21tdV9lbmFibGVkIG1heSBiZSAwIG9yIDEgdXBvbiB3aGV0aGVyDQppbml0aWFsaXphdGlvbiBz
dWNjZWVkcy4NCg0KdGhleSBzZXJ2ZXIgZGlmZmVyZW50IHB1cnBvc2VzLg0KDQpvciBkaWQgeW91
IG1lYW4gdGhhdCB0aGUgbmFtZSBkbWFyX2lzX2VuYWJsZWQoKSBtYXkgY2F1c2UgDQpjb25mdXNp
b24gd2l0aCBpbnRlbF9pb21tdV9lbmFibGVkPw0KDQpJIGNvdWxkIHJlbmFtZSBpdCB0byBkbWFy
X3Nob3VsZF9lbmFibGUoKSBhbmQgZG1hcl9zaG91bGRfZGlzYWJsZSgpDQp0byBkaWZmZXJlbnRp
YXRlLg0K
