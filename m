Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793258764;
	b=tRElw5bt12cwHTeKYglrNObBkCy+lO4M4uRZ0KFVetN4Dl3J+LquRXh9xex8DqLFG5wX
	 h+9Ksg5J2nN0W7IZ+d5uRb24AfSdfAwINWBY47nwhf1OwU9q0D0CoDynLM641X2QfYGka
	 9orZuxP29xSBbodtaISsD6DkdSAlBhF8kKUMNe7tgb6Ww21RDRNyUMQafxSqAZwtIdF5p
	 BoqndDD/lH9tezdCcxteej0Pm9YMIICMFTnGSRp203YbYYpunU3JT460VQjMSWE29PuFi
	 B8A/4BkgUngEDmQ7E6eBuNGLX35sEKtP8O2v3YYfv+6nxNz3mbtf/MepwZ5TVKyd71g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258764;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=TWaA+WvEx0Gyxn+Z8ih1f1qHnHYPMB/zRMQX9TslNm0=;
	b=UWBHBAGWRKAD9QXa0waaVVzdNqWtBtySuo0gj6HHTvF9CYGVkGKjfoYab3HsUk67Nxpv
	 zF9GRCANw1Rzxh608KzrUsclaK/BmiuKyCbutTw1HsOpTIYASzP1iVqnK/OpV0TSHMFlt
	 Z/Gs622NARowc2huxw4u7ZWkgIBogYrs9J3NGyd7ROGG9JqbPHHZFsmc1lZ3Tck81MtB6
	 jcKCDWUcamf7DJu+6223DcC2lm0h0mSmBcXEG/uydH+6grpuR5Aw/fjBJ/ZCMDCNenRVY
	 Ox5aSfhQ9uRgrr9JxE5h/dDFiHyCgWFIRrp6u2/CQ+RUHVg5eMk70Sbb4jZEGpqjjdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dfs4TmpH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABF9606A31C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dfs4TmpH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793258763; x=1824794763;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tNeQ7DhnRx52CQ2QRFVV5YZHta9qqtr2A+mtDeNSFKU=;
  b=Dfs4TmpHVd2+N8nHKYRZh8EIUhcNUG43De6C5XF+mjDS3eO+SAjgABj0
   72qwS0nEaTGQM5nkrbcZmA+ubJhGyn07L72wnDUXskbe0CnvBWJaXqdjh
   vuuAvs0fJcFFlv0Szz4zQLj+f5W7Y4BN/qlw/kCHeLnKzKNmCoF8/Gs1s
   95tKfdTLZWbKZJkZBnWp/vrQwnJv0ayGMq4UwkfKmC1mt8SHRtQ2D6riI
   2s7KM69nruqCVBspDJJR+8xwOI02s+aQulkm8cjWQDsE7SDwp0294ehtf
   jFCxV5WviBOc1H87vrbMyQIbjsTuPD35gtgGmO4ft3iOI90Vw0Mx2qQwu
   Q==;
X-CSE-ConnectionGUID: MHFppJ1sR8qMV5Cr+MtCMg==
X-CSE-MsgGUID: ypga8xSvRE2DrGg1Wo4RWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1882058"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1882058"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:25:58 -0700
X-CSE-ConnectionGUID: ZjuoNx3aQ4Gcdw7J6kuvEQ==
X-CSE-MsgGUID: HSJlbBkIQKioS4Iuptqj3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="4966728"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:25:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:25:56 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 00:25:56 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 00:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHHbfoNrEdJd4z4REwMl6+mOoLEcXGvb+6GifVG9ecxKOEvccuZC5485tkK2RI3ZkWDSd74osSt43cMjvv1b7u/avbV+QKyYQVZibcbUjx8TwwIRo9zGzV3jBF7yJy/yaoBrcowY7XzgbDZ6Jw2crnU0TcpauT2fTrmEpoFTfM3pB1KwPTpnBgk7RbZXvLo3zqyAiupCMI0wTitS8Lly5h36krjzvbFwzAMzLkWRANPtK1dF1ghWrjA5JNdIrNtgmSHTzw6WABMwdypZq5LWMzbTpC36P4cLh/MuJAxEohVUzmzTQO6K3C1IUrQ0b+7nDntJdGlKT1jp+5FMVMb4mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWaA+WvEx0Gyxn+Z8ih1f1qHnHYPMB/zRMQX9TslNm0=;
 b=ByVOn3qtTyYK2ObkIoMK/fsBoaIlFt/UEQHS+ScAjUnfKcxQ1eIwnyoqGDB6w32GLIAiw2zP3bKoVwutAQZPVyoK+kjfn48GlhCTqLLJKfXrtopc4zJwh7xU4bPGWDAZOYl9yjVVUfyAeWTVIV97EDvX7t9YCij5ZZjqbegcdslMZOSQj3xlc4LuruVrCaA2ElkN0dfjwHyh82TbfLpdnjT07pA92jeYumobz00VUkGZYJTWCcH4HGxVkPqNa541tdBqz3N+6SS8UPU7h8KzlvCjTYBlrnafLbqHEkkDBXvNQREn93AbdsgyY0B74931fWGyNhkdoi+z1dl4SOM4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:25:54 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 07:25:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jpb@kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
Thread-Topic: [PATCH v1 3/4] iommu: Unpublish the old attach handle before the
 group replace callback
Thread-Index: AQHdUFzfUPpa8Rov+UOYSfzTDqgP8bcUSuRQ
Date: Thu, 29 Oct 2026 07:25:54 +0000
Message-ID: <CO1PR11MB4835DF015165BA9306D022178C6E2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
 <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
In-Reply-To: <73ebe081ed668c214628fffc546b9744b662afb6.1790718296.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|CO1PR11MB5203:EE_
x-ms-office365-filtering-correlation-id: f7a1d215-e24d-4f91-1141-08df358dde2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|38070700021|261028144727099003|56012099006|4143699003|11063799006|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261021135927099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: zdimwsboYOmHIGlfsUL9rjwG+8vXjQPLpCCJxvp95+R9Oyrwx/k5xprr7RXZKtvSjeVPZuPRShoHL6Y5j9f9sJov10ocmctV5Kyyn5fGP2bFBznbDEaPbDFV7RAwYl8nZKGabzRjiiMjl/SLtzOytuIb4rD/XFc7YoEWtDcamfsbkSnjG0vjj/6TdXEDUH7qqY22tubaCGPW1EXBwYMDyM+TpnqmPK+obcNRGqEvk0z79NexdyPRm5zFgc39yQX4jKbkbV2BzAWHvQ17YfxucRZhLzwpGMCK/Dh3Jtp6o4ZS9yoQIR64I+oqXooreCKdRfviLK3E6JxS6evsl2mJab2x6ph+cQ6702SR6duCszGqczQVP4GtXuVWI3AOre+i9yoZGgqzdepfZpQAkJAvF5OcS2sD7GFkYpskuCCV8USlB9aA1HLG4nXhQU8z6oML4IfQpGKdKcAkWqL4A0U//+x70uKhu63iU7brM0cJpq/JCPUTMMD3kqNx3ZzMGEMxf29FazOLcbg24C415PxOSVI4+R0B7fmPxQ0AVXHbmdBLw/2/ZrUumDbtPuEOkyDPSITCS5SXdfy29Gm27u9hJ35dUJwInHy2tOvS/MgAGkVUQ14wnRrwQUiT1YILMTE1W5p3o1WTg2n2e+oNb3Pk6vRq9q7yPE1vp37oiZr55Eqz3vYoHZlzE8pf2NnMphmmu1XW6xMdOYeXzjSkmgy198zRqROwU25bk/U25TVFHDk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(38070700021)(261028144727099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021135927099003)(261026140227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7YQbC6NOo6nXYaH5ZQkkYDtnwutsocOa/F3ye5D8dZF4lyoLe0aPi/amELBj?=
 =?us-ascii?Q?JL+N2MDgP/sEb/gHVlVKf2cegOjGQQcVqACD2NN1AeTsY7UwaAcjLbePPeCr?=
 =?us-ascii?Q?u8QdAqG/DzdWHJL5VCdVkE0vndLYgDUH/458qKLcg/Pa+k0n4w3qWca7MJyC?=
 =?us-ascii?Q?DN01rbTvMwfjxrZdEZNA18KUEHT9Gp8V9qPcG0D6E+lHcSOrQAvNRpPulgwt?=
 =?us-ascii?Q?nBQjT9i+G6HImnAKQGquKoESkV5QzGayxoRKP3mV4MbJ/oE8Wj/nrMXs+NrO?=
 =?us-ascii?Q?dVsfm/MOvtGpaIljZY8jJzM6QQzDq8gBDYcHSYuxZJ1wxh9KVARCMAoptZQU?=
 =?us-ascii?Q?u56ppt0qpAAMx8srGLfR8YruUuoiWUKP1bpJ5CkF6/iqErhHo6qUqcvDq4wB?=
 =?us-ascii?Q?yo8hVFswPbA6X9YL5m6Xgb8xtcASiB2C8dtoox4VLMwC8t2ECdmnJRk8kYdG?=
 =?us-ascii?Q?JdvJknmy4EdFOseLC6c7giQ+o7Il5BXTYO/JMp1LXmNynV2HwTal0OJAKk+o?=
 =?us-ascii?Q?GabnWRclKnLGcbRcVe22NzO4r6tUk2Xd9br+OhK6hHEU3wK8k5qnWnCBdb8Q?=
 =?us-ascii?Q?mDx8QTB74Uw13hH5zcOqnsRozRr6587zHczu0m44EC26F5VTuQChYBBrOj9H?=
 =?us-ascii?Q?63aWjCGW90seGQHS+q9OGlzIzGmNaEZFS0Tp1w/5lryoOdooTPGYHNhTO1dO?=
 =?us-ascii?Q?yIY8pgL99pdb6OhWT5gRBLzZh4aus2KmSwoa6nXDSlQ5IelRTVu3/67UX7nZ?=
 =?us-ascii?Q?VKho8vB4gT4PV0Zy11YrgUgny6osPYizwPw15dAUx1D2wmBNnqFXloWa/Bo/?=
 =?us-ascii?Q?e56cb2ECfk4nTisY1k8ruaxHhgUvmQpoPvWztZsV7Yd5BshB2NC1cxcmyS+6?=
 =?us-ascii?Q?42VEiNf/In4tzS3bilC+dJzkUOp20OPATug2kNRZqgojwBpxZnDMfEKP9ZMC?=
 =?us-ascii?Q?tnudZhWINErR607dSnEQNQtptm9Ij9clR/P+eqwTt4ySILyecQhlSM18BoTK?=
 =?us-ascii?Q?j4NUfnUgeFVXQH0Atidg5PnqkKSGC/jxQV73gedAkAuOXrU/WE/iwZsO42hU?=
 =?us-ascii?Q?vS3DZ8x31R08iyVXHmvOmsaaPhiKIzsWzXl1VTYnvaTJ1jlr93SeM/7RMDhD?=
 =?us-ascii?Q?LJQUq3p4QNTj8p+885IpP5/B6d9475iqS1IoywmIQoeucQd70gRm28kRYJP9?=
 =?us-ascii?Q?BDegOCt7HnfZrZ2bbafUQGLs3nv5oq5Knpvz6NTgMVyh6Zd/maJef5vqO4RF?=
 =?us-ascii?Q?EvYj8lJucZWnBafZF9W3D16tNX3zoXWwbT/PXCJQ0xyn3KC2GV7tEA7WW8Sq?=
 =?us-ascii?Q?ln91tPmhYT/GzNmVyk3FOiTtf7e2HPdAniwR1gIPWIoL+j2syGybCH5is6Ke?=
 =?us-ascii?Q?u0ratBBdwESHGxmFJdO+kI5hL+b3kZMG6fN+1htDWIA/aE86RuvhvwGyz/VU?=
 =?us-ascii?Q?KVDh/Q9O0c0kyHM/nqNtZMs5yJtbye/vk/xS1GYgbkw5OdR+45pk3woTIEHK?=
 =?us-ascii?Q?rYqHQY5sYacH3D9wbCdmfLB9IvhZY8DnjG0msYHjU2VF2jMxR+6LFdVfzO/D?=
 =?us-ascii?Q?pojiNVPszpQkmEz+BWuPN5G96ehWkbmSnHSCMYsuKdZui2fBFTnNM6jHsFNz?=
 =?us-ascii?Q?A1v4+pTb+gCJZlTmR1egvxuXzqEAtjNpnPcGV/ALBSIE7wqT1rRncn+x1xl0?=
 =?us-ascii?Q?KpyvVfXmpOQoI9gmWX6U3tZrs+3knTvJkLvQ8clsnb2FjIj+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: K/4lZMoBdSRj90wJ83PvwWZhXhrmGx7U24AIiF5dZfAZTnmca5SgjQuIsDzyyVV7SppaSB3k3xT46Rfucl+kHenk+OiOQZ72aSIOopSMmA28kRydoZWdemiBxMICcFcMOjs0bMXEzXiJAUVqVG7gZBChNfioYg41SZzSdemoq+vYD73PX2pVs/e7b0OSQWdu4uffPSLl/CVHlbBONrORfDASKsjRNw7ZqdT+RPKHzb3CC3YlAnpqSK1wNg8Rf1U1TsxkC94ipUAvRS2txkxC6h9bUsavY74ojzuH5j1DpwfcWFyBX9kPbfJS4Ehw5qQek3uIb8sJfBD6tbWKpkFhTg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a1d215-e24d-4f91-1141-08df358dde2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:25:54.3832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +2VyjQVDNi3h4RuzZ1ssCNWjEzVSc4+UlVyb0aEH5AcPLQ+PPh/uKoFcR3Vx44DCEMGR95wGh61gyrn0jEJNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Wednesday, September 30, 2026 5:52 AM
>=20
> iommu_replace_group_handle() looks like it hides the detaching handle ahe=
ad
> of the driver callback. But in fact, xa_reserve() calls xa_cmpxchg(), whi=
ch
> stores only when the current entry matches @old=3DNULL. For a replace, th=
ere
> must be an entry sitting there by definition (i.e. @old cannot be NULL), =
so
> the compare fails, XA_ZERO_ENTRY is never written, and the call decays in=
to
> a plain read.
>=20
> Therefore, the old handle stays published during
> __iommu_group_set_domain()
> and only gets replaced after the call. This creates a window, during whic=
h
> an asynchronous fault path might hit UAF:
>=20
>   core, holding group->mutex          fault path, no group->mutex
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D          =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   xa_reserve()                    ,-- old handle stays published
>     no-op, the slot is occupied   |
>   __iommu_group_set_domain()      |
>     driver attach/detach ops      |
>         iopf_queue_flush_dev()    |
>                                   |   iommu_attach_handle_get()
>                                   |     reads old_handle
>   xa_store(new entry)             `-- window closes
>   mutex_unlock()
>   kfree(old_handle)  [caller]
>                                   UAF: old_handle->domain->iopf_handler()
>=20
> Replace the xa_reserve() with xa_store(XA_ZERO_ENTRY) to unpublish the ol=
d
> handle.
>=20
> Fixes: 8519e689834a ("iommu: Extend domain attach group with handle
> support")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

btw I just realized that neither old code nor this fix can actually support
replacement with lossless fault handling, but I don't recall whether it
was the original goal (then destroyed by a following change) or intended
to be a future enhancement...
