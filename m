Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0840FD84
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976230; cv=fail; b=jM+a5BKRv6rHaAcdAZ7ZcT8r0z31/R/jgC2RbVWdaU6wQF11CHwss7DHlyikn2ie96bfkGOdVl48GIi9/VVuhNLlHyM56bIMW3pQQ2LfIO2MST3t+VMA8FL5J7JpOMdTlP/Y8RvKtzoRAUbQFnUHGzCPcajreDTI99iOi/FK4uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976230; c=relaxed/simple;
	bh=k/ZkrmRpMLrdckibIUq4+0cxPAfDlTtN8Gh+Z2I6MVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGMMQXzBhMBhD0ScfGPDwNxGK28wJ5FodFkb1ODyXOPjE4pYbc3fTg6Z8gDlIDdmwX1lfr6jkkFfXNNkJdU8acDxVSCAwrl8BGcPbfXRyfmlq2ftxNFAHHsuKCbhVcXblvhbHoBYU3xeBiyObP8S797nbyrnfyC4qrEw7WH3cnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DGLBBxcK; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DGLBBxcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768976225; x=1800512225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k/ZkrmRpMLrdckibIUq4+0cxPAfDlTtN8Gh+Z2I6MVM=;
  b=DGLBBxcKw03oXsNrlORM6Omu77/m2EstuXG0mJ7MWX/kwcLzbgsfCydT
   g6/o+Mcy5kKMokRkmfQAkLYTUWVY9HGC+uZqW2t9xWpDivekSzrFnA25Z
   +OFQUn6pYjqgk7xV6pdqxKoIBY1gjOOpG2RVXtnbcjj7Ilu7c2GNk7Uri
   4jG1g2ALKQ13x7ujVK2Lajud+UFvBgCFDHlwZbeqPOhcG/XDcK5Fad+Jf
   6JGGbAcY+luu7FSMnl58rEPfF/aA6KoOLbikCxm5a1XyPo6I3UZL/Eq4O
   5bLGhRzyGHKl6Mhc+yTyB3juzy/oWbOCTDcHZCoqe3SYMf3Jz5Vw8OmwL
   w==;
X-CSE-ConnectionGUID: 7w1ewrGISwOVjcKDYtgEdw==
X-CSE-MsgGUID: +BZhyDk2SSS800S+y07Xnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="73825229"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="73825229"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:17:01 -0800
X-CSE-ConnectionGUID: HTmUCd8+RoG3Tq1jIu7tZw==
X-CSE-MsgGUID: pu1e/gO+TBypBK5GZnRx3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="206270342"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 22:17:00 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:16:59 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 20 Jan 2026 22:16:59 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 20 Jan 2026 22:16:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VwuqjcQ4z+EdTwWj484VwlJG5c414cgTVMvT2hmYk81rW+Iym7I1i4lJnc/z5VeozEN+H8FjpmDHUnFnc5Pl22/5RxlBoFi0sNuVX0XD2RI6qY0k0S+u1JLlm0SphErLs+nvnA2qxyRLFLsW7cxvVDqU99k8HxHDsn4nViNuBXcPl7MbDhPw2J2D4hxep0AceoSnq+fSV+eMuvMbZ4mbYrYIEvjIjzuodx2ZWNXdEDLfoq2V/XJUtPKgbVAZB4uuyRFaY3FPMkoefrDwPGxbNaPE2PMiokfbH2Gz93NK7FeZB2ly59QdoP3DxS1hwf6C5dKbSwVyH/F3cC5e723Lgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+AM85uZD1XbhvOdt3zEbv21xJ/dqog+8JaB+3vTbHw=;
 b=FMg7SQlJ0vt6LOH7U+K+HoHIELmfIqiNI9cGaLufZudp6bujgj0eN/mwTaAwh/qAMoBw6yQfE8AkZyscQXJsU2Dlr9Takf6O8B7e+stMXs232QWvq3RAqK8wBSUmkBWTVtAUlwJuhoGqa5XjroV6JwUYNwZRGMm3QjNeHVeXEkdTQfrwQzO+uD0Wfp2ym2a7odkTPQkX0LaWNo+8IzvMCz90lRp+PrTM73kVThiyAQQzEfGjou3G4zhlE3bhwpjzaNA+ShDqconn8kHnMK8N5OSyZ0I/f1NSeILbUXJ/nw5Rscwmcky/+eNb+6Slo21rY1T4WFqp6GQmHc0a3Ri21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:16:56 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:16:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Thread-Topic: [PATCH v2 1/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Thread-Index: AQHcidTxSTpmzJaBDUqR4g/dJ5Ke07VcJz/Q
Date: Wed, 21 Jan 2026 06:16:56 +0000
Message-ID: <BL1PR11MB5271A25BAA9CBF53FA381E438C96A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
 <20260120061816.2132558-2-baolu.lu@linux.intel.com>
In-Reply-To: <20260120061816.2132558-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|BL3PR11MB6388:EE_
x-ms-office365-filtering-correlation-id: cdb9170d-f448-400c-7df5-08de58b4adbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?1n+APkGBmwSLHI/lZyTKzF7oJxla7YjSX0K9FqFN4CDg8PU3tzCgbO7g9mS7?=
 =?us-ascii?Q?H7YOzVrW2230t6ISstt/OIC6iT/NDbZ4rbLYEM737LoFDVayLSHkIA5LtXq7?=
 =?us-ascii?Q?vcXmUrQN8CsfvD3oFoBHCnWRWG1PdsDG8nWhcwtKdBUKy6h3slRUfaT3ymRw?=
 =?us-ascii?Q?C2vVgO8Gx++HQ8nOmQQJk1xlWDsXBkonNSCYi3rJgnS6xSj0JvsgDRIOmG+5?=
 =?us-ascii?Q?3hb1uIZRCAQR/w6D8kozbHOBWgia6FYUtIkXrvVRsF1hFEd1vHxwFEboAPrb?=
 =?us-ascii?Q?6tPx1LFKEIzi4ErSp7KS4iYNiDV6ULUR6rIz/5gIkDJmNZeFUciQwLeD9O8S?=
 =?us-ascii?Q?mHY1vyoorncvHUU/1mSnOi/9kWwPxC5t2ye9/56/NQmE2PEjoQJP+W+4JfRM?=
 =?us-ascii?Q?qdumMCY2kFyenOLwXqIZJ8wLtLFhjaVHrJvzXrhxXbsQEdjO9ZwqHGtwDiuN?=
 =?us-ascii?Q?iusxZ6UcQvjP9YAQteEDgwhDwHM9I6mi+RgmQ9zNQ1BuMzmGqDzELMLhzDsZ?=
 =?us-ascii?Q?o4VBMkiu/JlRjyBXQJu2FnsnGzaRJ+Se3Rv2xB5aXWKKNfRgA4WpxbjZyep5?=
 =?us-ascii?Q?IpjUImY4ZlblCes2LdfkdWrb5YBcg6N5Gubcj234ciQE7e6GseZ4QMKg0kkF?=
 =?us-ascii?Q?Ud0c+A/4DU/d+Tb0/gjXKqjrOyaMLvXJSF2C1NzZl/fiIlH8gtiWkPf2PHo7?=
 =?us-ascii?Q?dmCqkCxv2pIWzei2KTZqlFp1/spkYwbJS6r5VQSHWpnFKpt48Zo7LSWXbmf0?=
 =?us-ascii?Q?2lmD07cDcmgbcIXBMOm22PQfwThB7U3mcsrDy/x1U5cyHQjD2wZ6Fnsz0m3w?=
 =?us-ascii?Q?f6vJhMpQO/ZIz4AIvwwjafGOjHg35d06HqC6WIODBR9YWpO+twM8vB3e6c6T?=
 =?us-ascii?Q?oeiLvA21pd0K5V9Yo98cbGpaOl9yKYzW1aAPnjgyO8E96c048BmTxVR1y4jj?=
 =?us-ascii?Q?I4KeRlhKZ6VFg91R2ovZ1w8xa7khwBWuXd2pgzhZp6Ym7XaXi1gKcoIR5iVY?=
 =?us-ascii?Q?0FCcYkAqy37WDerQYy3i+Ly55ZvoqNZOQYdvYPgA7/GgaDynZXepAOdMNmlM?=
 =?us-ascii?Q?mRUBYYOCAM+WRkxb4kjsj0vVPRgftdXiXIUWspEMln63/XxNh9wXu9kgp5Pk?=
 =?us-ascii?Q?Z6/8gpyKuWnUZnnHF+A9OzvQD+nIlBZ+e6H5XY3v/Tcn9qsOK+CiPct6HUxJ?=
 =?us-ascii?Q?ke5nwdJrDHseGiqvYp6f2RzLo1xD7+BD8HYZVvPphpPI1nFDz5/ac034PgxD?=
 =?us-ascii?Q?nV4pMU8SZSBay2PemMJAHuPnrZ6SnjptlXW/Z5epsyqb7ek8NQLVisBEVDN+?=
 =?us-ascii?Q?f/uRR07sXWWvH3ElT33THuQzfkHpS60G7m7GeqbdaK2MrFhKapHY0dxpnmNU?=
 =?us-ascii?Q?vabKtuQFxyVydMgIg3a3j9jUOuOH/kJpTlVQwMWx3y63EI7DLTiCWFx4RcTe?=
 =?us-ascii?Q?qrN//mHUgLY6l/5Y08AFYIMvybQI2Jtfv8oKo8fZTXY5XxZbmADQmgd4CE9c?=
 =?us-ascii?Q?4T+DwEctLE/U+zseZfredznT2pIf0doImIaMHSMDV5XRhm+gXdjuixzA+P5d?=
 =?us-ascii?Q?GD9eQF+08kg1iz207jzw3Tn1kScMQL78IaeULD0D2XKJMI4y9CjAm9gBakvG?=
 =?us-ascii?Q?3rGvqfgtnZMMcTOJa7sMpqY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+eyLS+xJJeoOlci4TYq6+WFeSgo3gKyqI98ml/hm9Mr3yv76FQzNWeuVqy2x?=
 =?us-ascii?Q?22PX16fUsV2T63cicWUAW4wqqzDKH81Gi0sXhrb6Za7acrMN08RNn2JxFlpl?=
 =?us-ascii?Q?Ge4x11bAThwI74cnH+E5fNxLqzMMuHuSaCWD07WcZVUtQKwcnCslXP6TEJL6?=
 =?us-ascii?Q?ribr16Hc1wuwJ+ZPqXYN6gQL1baYhXKehfYaXAo15oF6tWoJbuTlQsuN+JkQ?=
 =?us-ascii?Q?AczUcK/NpRE+DjBANlyEuhYsynAUSZwAYHd1VfEGLyreKWoLyPdKqasNi3C7?=
 =?us-ascii?Q?sVXoVQRxM9zypmoqyYcC2Sg8XWQH9FFopOb1y8EjH6EjuVHc2CjVCjpxbbdD?=
 =?us-ascii?Q?V3kGEvv6csReo6YQ5561uv2OHF6GdWuAV+cq6fYQYgLbVxd9C5uyuH4fFKLb?=
 =?us-ascii?Q?Yus77JjYKkrQ7hMluy+f5m3CgIMN7rrU7cCr6V30SpXhTzDQyy5KvmLyHG2T?=
 =?us-ascii?Q?zzrBfA4CBT+S3NUZzMWHQI9ZEBzTN7/CZewut/vCo4CvVtthC5WlbmcOf3WI?=
 =?us-ascii?Q?PuMiSTb9ztf3mLWhtX3+iisrHEkpsSTK8onWMFJkwvJp/ISKiDOonz/KGMZs?=
 =?us-ascii?Q?2MqBJPsD8l4fpv01M+kfL1VyTFh8sURMobqLPJSq0xAF/yigOxRlrPCfG7i2?=
 =?us-ascii?Q?t+RsZzHONkaSokx9acII/dvxuhaZ8YpgA0h0ln1qinHd5jVXQraKitQprSBX?=
 =?us-ascii?Q?tVZZWnDPvbvqwHLU3mMu7FsKuBXC92SVN0KiDVNfacgb3qTfiYuLWGIAxE2W?=
 =?us-ascii?Q?ZH3MKVyQYi1mW/GmeBHGXmDhF5ij4CcUJBUmLz0rVWph1YMBfOsDQ/DXDa3Y?=
 =?us-ascii?Q?NJuiRdwtfbOKZuOABUkRzX00lcQjOknHlfytKxw3O1mUtpoVYcAWpMBtOSpM?=
 =?us-ascii?Q?kFPbV9x+0hgfSpqdbag8DiBRKhqx+ct2aHnAuRbf01jKH6S5vagF648XtK35?=
 =?us-ascii?Q?AfxbkoO/p3+o/qz0aps3fG8gMRjMo7GCNIX3jsc6c7u9V2lSnnVG1k30whFm?=
 =?us-ascii?Q?kT0c8YjglV11EJF4DVPvfEikL8ZyMIRldpCWfXtGFTaprVZaPLIaZvFHxSJO?=
 =?us-ascii?Q?xyhmYWjjCrUxIYQ3ASYWRKHYV26P/l3EV9EVU+7oLMWnC+FlNG/GZs0wr7SN?=
 =?us-ascii?Q?RvOPVttQUlZfaS7RgbYL7h2k64mW+4vRs+zOIjd+yvz8jxaRtlmyEtUaaAJj?=
 =?us-ascii?Q?2OZ9QJDCuqV5+XuhoDhwd+MEEEGICw7dl7X6Kx2qNKZREfpSQF8v1Jg3SL3Y?=
 =?us-ascii?Q?gugfeKwOTpoSV/ChxUHWN6j6DrNk0XlxZJ06AgyDJnbveNPpxPGA2wtIF7E/?=
 =?us-ascii?Q?nx6N9V+2/70q9OkXib+qHkFgoATW7GX1lp8hLyxJis4/kgnAc+Zoz0z+jD7d?=
 =?us-ascii?Q?foz3vvmSUMMXqjViQiu0OftkqYdDLyordj8TDY5+KMdnc6/651zN+pWpHt+a?=
 =?us-ascii?Q?skmKdfKh/n3qcEMYrrjjgaNdUrdCntRZDLi0oknRKJaWperu1F/xr52eFHpX?=
 =?us-ascii?Q?ZrNUo0JQRdoeVxIMw/cblXUbl0A6E7AR7BIRd7W60vQXEjtJsdqyodFXR+lt?=
 =?us-ascii?Q?GNTfANokFOAnIiJNDQN19/ydrQGTN8Mw2ZnQOIxDBHFXKMLchZ3JbKsrRUb6?=
 =?us-ascii?Q?/wVtmwlMV+vMdXcqduZJeLqWKvKHYWSljkAuVVRm7935oMjVCCmn3HadBcyv?=
 =?us-ascii?Q?vlnzzs74OV8xEuaol7rUf/odKvDQMfbgLeeqnhBGTaBFmK+RE/N6p0RDIxL9?=
 =?us-ascii?Q?EAvQR8k5HA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb9170d-f448-400c-7df5-08de58b4adbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 06:16:56.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jx1mbz0wmRaqaoygfPYjKYZVJaIbVz3l1bNQ/7p1REJk+2YxczNWEZety62a2O3j4+Mlj2fIr9dhvPqISO30bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, January 20, 2026 2:18 PM
>=20
> The Intel VT-d Scalable Mode PASID table entry consists of 512 bits (64
> bytes). When tearing down an entry, the current implementation zeros the
> entire 64-byte structure immediately using multiple 64-bit writes.
>=20
> Since the IOMMU hardware may fetch these 64 bytes using multiple
> internal transactions (e.g., four 128-bit bursts), updating or zeroing
> the entire entry while it is active (P=3D1) risks a "torn" read. If a
> hardware fetch occurs simultaneously with the CPU zeroing the entry, the
> hardware could observe an inconsistent state, leading to unpredictable
> behavior or spurious faults.
>=20
> Follow the "Guidance to Software for Invalidations" in the VT-d spec
> (Section 6.5.3.3) by implementing the recommended ownership handshake:
>=20
> 1. Clear only the 'Present' (P) bit of the PASID entry.
> 2. Use a dma_wmb() to ensure the cleared bit is visible to hardware
>    before proceeding.
> 3. Execute the required invalidation sequence (PASID cache, IOTLB, and
>    Device-TLB flush) to ensure the hardware has released all cached
>    references.
> 4. Only after the flushes are complete, zero out the remaining fields
>    of the PASID entry.
>=20
> Also, add a dma_wmb() in pasid_set_present() to ensure that all other
> fields of the PASID entry are visible to the hardware before the Present
> bit is set.
>=20
> Fixes: 0bbeb01a4faf ("iommu/vt-d: Manage scalalble mode PASID tables")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
