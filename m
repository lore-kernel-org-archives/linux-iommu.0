Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FB3E277C
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697823; cv=fail; b=GgzG3muoBzIQ1PLToc3xWv8X+tU5gV3xLpO60tIDdcHJ5/QDDr4neeUu68dkkDhAo0UaYfqhUbIlrxyGvXXaCHcKNTg5VhblJJe3mEG5JAUhDk6DJcyD46sU0JRmL03yinI/uVduiA4AICskmEUKzK8PKDYSpqVPz/NykWTsxGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697823; c=relaxed/simple;
	bh=QgIha/NrEK7GObdBnC3Qfm0U6R0K8tS1ctajxUkUkqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGJQFjGyVTzUdR4h9tHWv+kltjd5HG5KrSZxmJop7+WcXe7x17DA97tDbzoJCBMC+WbrscAifN3Lft/ck5fetcfY6o5XY8DkMTbtwXjL8spWxEgDwXmHjl5KNSBWL7liAx4wZOQ8WkSdXbQ7NAMc57IzbD4X9SQAV2FHvNmh7vI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrQ3LBtU; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrQ3LBtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779697819; x=1811233819;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QgIha/NrEK7GObdBnC3Qfm0U6R0K8tS1ctajxUkUkqY=;
  b=IrQ3LBtU00fVKpUCg3Kkf6OQIQVmTclooafBPZ42iJ4teOwN3vh3K/6e
   dxaJ9jWsoUYf6WHNq7bVGp1L9YaolKjID4wLH0Kd5v1WdbNU8ViJNs5uU
   umc1t1VDdjitBfmoVBrArpY7unMeIz819Xr4hxuO7puj9gHo2YHNxFhlf
   t2Vt7UUHBbp/QTpD4R/dDn9qsdcQ8O7Z+vE8xdVjJtduIj9AjBE+caHo+
   rcKEG50iaWLMPyy8Nh1MYpyCJ0Njfv9lz9MuQhYpL/yByN/VzMuu4QZ9w
   6iI6R9qoMAfGG6f72D/mtPy/LvDeqh7DQQ1zlKbNKvJ7UHBUKbMn2Xjh1
   g==;
X-CSE-ConnectionGUID: Ft7UPbq9TtSysbO4Bz416A==
X-CSE-MsgGUID: f43kmkQpRmOn+LluMfjsFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="103197580"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="103197580"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:30:17 -0700
X-CSE-ConnectionGUID: CKYjuozDQpSPaeDVu2330w==
X-CSE-MsgGUID: hQFastZ1SdSZ2fNERbN7eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="246513372"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 01:30:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 01:30:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 01:30:16 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 01:30:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsRa9JaOhObxQMLHyv3IPCojYXdctleuDAThj3p8XkQ+IhDUTrN20K3hVFedb+BqtyOf+YtY8tIdNt8GKYGRINFkAsZIXceJreOX1x74EG40jdbrGOWBv/1NZithSidrYmJDZtBcLTal9R22M/bnwwJhOYkUSSwoehwUu2t6I+FUnHQF3nrJlxm90dq5cQQeyawDMBZTb+wHba6RMoXB6LLH/sS4ic5D93KUBfxhnmhNY9twSpw+sqeUb/ofw2icLtYItD622sZDG+B7u3m3zZnSufV1+UdB1O73yeWzlLzc1af3TYqzwle4ZTn2I9/oFaIVKOazIn+k4G7mV6MVng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV1dIuG4zkkbGBFSWWNPJsqtNCOjG2MlnaheAb+mYlA=;
 b=OcpzymSRkVg5NET0vkgZqifK2bSr7C0pAQYuXg7z1ORtEDkO67ZbappWa2iJUbAz2EbTDQ80FOQ6mMxNL86fVCOXZCdRvBhS3fI6omupkxZz39+TR3cHy2VLpekS+9LKPp4NesYfyDmG1uBtBzgEHTj13CGtO9VulIP7Mx59tm55ImvWUTODLNzKPw0XDbAnwhIta/I97fvZ6iMKVqQ1Qd9XyKL9v/1+HzUCpliD6UzHa7Q4wDoLd/p8pPuOly5sV10p5OUP0Rsmg94FfPjzmubtkRYpw0CG0KjV0ZsZeYqlGmOFehmqvPLkVvYwLsCCuXObBZRKdAXRRRH0QggdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:30:12 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 08:30:12 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, "skhawaja@google.com"
	<skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v6 0/7] iommufd: Enable noiommu mode for cdev
Thread-Topic: [PATCH v6 0/7] iommufd: Enable noiommu mode for cdev
Thread-Index: AQHc6W7kKlQxbMvLHEmr7TDw+tbjfbYebhcQ
Date: Mon, 25 May 2026 08:30:12 +0000
Message-ID: <BL1PR11MB52717A74E37BDED067EA45018C0A2@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|DM3PPFCBDC4B878:EE_
x-ms-office365-filtering-correlation-id: af74b8fb-8218-4c80-f742-08deba37d6ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020|11063799006|6133799003|18002099003|22082099003|56012099003|13003099007;
x-microsoft-antispam-message-info: YJikCv+ESdvYLId8kNejsK/OPNFEj4e/gFZx5224DgmWErEbf4LMkSxkcj79DGOlB7IQC3mHHy7NVHNItC0AGyMQxuqgOzUMFVxDUfUx3kxreBzuTTDmVgC6xMWMQmnCSCvMIy+1wzL/A8y3xTN4HgeAcUQNoZ8xkUZvuVC8hkLJXLrNg4hXxdBsu8DeSy2/l1COv6macGOX76NLuKv7Gelbh35IsXFiSs+AH24chbp6J0WFCBH0Uc/7uAWB8fN1Z/SauwmZVSQT6F8Ao/AdxPYCPJIX1e24xfNthS3DzBmMZS4FtEO0905OG2FCOq+X6S8+oThdxTk8jvZPOuZfaTOj/4kKh492qLD4hM2QPSdcJiVGtt+mOcf8FwB6DtWAn/aJHVjSLpqwqgM0zdkMZZ7wBUZ9ivit1bKp8ehzgg/kiDev2tClGykSrh5+N2HYiyvuC2o9jO0CM/NCGtWDx73Qt8MfiBaL+qbCINZy4A3rK3NLCl5cho70UNmh8vD9WMVQ+0pcHgzSRQ2jUTpWCqrKIss8FhQiPRgewc5hb4A+SBDO3eJN9iWCkc65tq/gqX+TLoq+SgKbxSzGbMpgHsVsMCocH0VjwDBtoe+u7H9Bw65e0LzhIWRhN9JCTgi8uCGYPkY1fOKWOLZTA+mEwd7ew6fJb1PoCR08oxRvdrZ9lZUG+9+rFb80EsQz8vKmwrUO4jQYvSdN9NjSOGxkhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(11063799006)(6133799003)(18002099003)(22082099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xULY4O4/pxIcFyFbLn+sOd4eY9cO9EXkuzRBED0m5NBr7Y/PV7aCcfzl3543?=
 =?us-ascii?Q?cVdJfwq/pqQ6stJZdCoB9ofTb+bHlIgpZKtuVekvbI5HErclv09yljGkZd+f?=
 =?us-ascii?Q?ghdHBj+szxLDgPvOHXZU4gmptlov8cL31gz4K/vnBpZpjqOcm1+ECSRkK8if?=
 =?us-ascii?Q?Fe/jrL49I30Xqw6HhuWZazQiMPBC7wm/N/3gQVZ8A194Tb9qHDUm6+f3DI73?=
 =?us-ascii?Q?6qL80EIWzKmNQXSwqMzp8iwPvYyuMlBK60Ih8bYoy/GH2rrXBvhAja4pt8nj?=
 =?us-ascii?Q?cbNEz973ni1dNAFi1tfelfN9UWRvakI26kYaIzhlV5RPu9EW7LwkxPHRYpNl?=
 =?us-ascii?Q?mzpOh7/rC+50NrMJ+1/j0qd6iAeFP84hEvoMWPGGeOQt7SxDjnF646evOmbz?=
 =?us-ascii?Q?xIHMpAguyRZb+vAMWZHgRxL6Zk3d3iyWKuFX0B5kgQIWArccawn1C9MJsj8J?=
 =?us-ascii?Q?9Pbx96A+VZ7DeFK12rVcjeIJL5XTdRyIUo4DxLUFlti6AsTompB+CCQq56qo?=
 =?us-ascii?Q?Bkv9UzdzBSi+DDTHV0YNUI/E2z2MhlMLXPL4OWXhpI58Iy/KUdafyd1+EgaG?=
 =?us-ascii?Q?dN0OQHRciBjutb9UOPgkGblojORzs4wwWRdBhIxmMvuTrAc0NwqIDnULSrEZ?=
 =?us-ascii?Q?K6I4mmOsIzqXHPSKfNM75TAHHSELl4D2ASm/yTrxyXXBqnl734I8vlMOz++0?=
 =?us-ascii?Q?Iaws7ze9+OeaDKtZ/Yt2nnIGDwojK2GqILzYo53kEmb04ASqodP+FWnTn4jO?=
 =?us-ascii?Q?tFS3vpucU3qSjjZp/+tkwfwbbTSOXffIC39qfv+JK/5X4W+XwRSQxFtFv0n2?=
 =?us-ascii?Q?OhNA5sAuQ68m6sFqzpzhqw+TdR8sMbQmfA4MC2auGlaLznn51QXIWFiZJGbL?=
 =?us-ascii?Q?2ZYlEjxU1Ip26Bx64LoDgGj0wQmUYubnxTBXBcdyo7T+8G4OsOGWV7HznUgR?=
 =?us-ascii?Q?FkC26gC3P3lx0NSKUNBh1i97gGfHuR+EgLjmhNcbJY8q3Myrslb83oFIA4mX?=
 =?us-ascii?Q?plnUIF74wkiEcB3o9FPV/cf6ffVpLFtqBZwIT5+q39cxu07THQYYiyzV3DPK?=
 =?us-ascii?Q?oFMX4rHGej8uqrgmje9+uxM8Uq20aPRFFo9MBjDNZ3SENAibr41RCKp0MiUw?=
 =?us-ascii?Q?Q+2bmQWKqWotVy+031rKDUoOrae9oFAJ3o7JrtHuOhBiq2IHznwioTJMBYeV?=
 =?us-ascii?Q?ShtCwMNQrTiPK3qH/FDoVxQcriOKq5yd0ihwLo1Z6RHukXNOd8dkxv1a4J+o?=
 =?us-ascii?Q?XXZY1ngUhjBeb8MEAW+tk1y+YvkHCLbYcT/+5WVBMG53CBc3+3GseT6ju3jE?=
 =?us-ascii?Q?L9OXpDKngqIKV2nCD1+RRnvsFNdSYdy8c7z+jgE4mpeZAIq48osk8mKaHnAW?=
 =?us-ascii?Q?UN9aX/HfZPvgpiuznBME5OcXrOoRQ9gp2l0GpT0+yQJBgqZBVhq4yvB0NujP?=
 =?us-ascii?Q?GuoQJYq583sKaBSEkglh8HKxHqCZqhGCa5bVhcwIi+lm/DlEYHHqNJ7m4an6?=
 =?us-ascii?Q?UNRLkBSq1m4cPrAuV0OIIHgHibcpKjNXQoZG8moNzJvDJqhUOipqh49R6CmY?=
 =?us-ascii?Q?i0EZfhX6sD9zdf3yL5YS7iakRn9o+iYYDdjz0ycGAyb6+MTlNFRqLaKpJbwg?=
 =?us-ascii?Q?AxJjM1IQWOdiSITLAVrrY6gcIWKby0WNTGpJa6mMga7Ty1VZXetZBhLt8ZbL?=
 =?us-ascii?Q?bNw447jj8G9aMmp89GwgzxP9KLNmdjgecaNvNFvfjEdKQbNKBQsH1MJcRO2k?=
 =?us-ascii?Q?RqV3JYl82A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SMto7nfUSjIe/a5GL+8cQhs4e89kIB0DljuxAAuwKxDtfT+tI/GhPUZwhfU9ZbS7blqCpzu8jL5zvB+dYeNe+3xa05kB9y88hm4sIhSVvKbcM/2P7945k9ZhKLVz2ued6Z8K2IEFyzRq8jKF70nSRxaIgLEj3URDZMsVZjUaiWPnPK9X4MGqiDAnXGbu8bHZWdi2/o/ia6NB7QDQDsT9QlxKkdUhJfADBlXeMx4CM/+4AO3Cu3eAGRtNd1o84h/4NCqBiIUa21TzuMu+eOC4Ijv0/snvhIhaQfzZLKwVCPKy/9IMhaA6PC5ob1uy0RXOwaITrFm97vTl4rJXW02I4g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af74b8fb-8218-4c80-f742-08deba37d6ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 08:30:12.5180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2m8msgfIAK1jSeKzvM9CzPKdtZnllf4DKsdyfB+wWZcncNRX/6xWis6FJtIGafvtM3/GK8Ojt5cUrbti6zB+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
X-OriginatorOrg: intel.com

Could you address the findings from Sashiko?

https://sashiko.dev/#/patchset/20260521221155.1375144-1-jacob.pan%40linux.m=
icrosoft.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Friday, May 22, 2026 6:12 AM
>=20
> VFIO's unsafe_noiommu_mode has long provided a way for userspace
> drivers
> to operate on platforms lacking a hardware IOMMU. Today, IOMMUFD also
> supports No-IOMMU mode for group-based devices under vfio_compat
> mode.
> However, IOMMUFD's native character device (cdev) does not yet support
> No-IOMMU mode, which is the purpose of this patch.
>=20
> In summary, we have:
>=20
> |-------------------------+------+---------------|
> | Device access mode      | VFIO | IOMMUFD       |
> |-------------------------+------+---------------|
> | group /dev/vfio/$GROUP  | Yes  | Yes           |
> |-------------------------+------+---------------|
> | cdev /dev/vfio/devices/ | No   | This patch    |
> |-------------------------+------+---------------|
>=20
> Beyond enabling cdev for IOMMUFD, this patch also addresses the following
> deficiencies in the current No-IOMMU mode suggested by Jason[1]:
> - Devices operating under No-IOMMU mode are limited to device-level UAPI
>   access, without container or IOAS-level capabilities. Consequently,
>   user-space drivers lack structured mechanisms for page pinning and ofte=
n
>   resort to mlock(), which is less robust than pin_user_pages() used for
>   devices backed by a physical IOMMU. For example, mlock() does not
> prevent
>   page migration.
> - There is no architectural mechanism for obtaining physical addresses fo=
r
>   DMA. As a workaround, user-space drivers frequently rely on
> /proc/pagemap
>   tricks or hardcoded values.
>=20
> By allowing noiommu device access to IOMMUFD IOAS and HWPT objects,
> this
> patch brings No-IOMMU mode closer to full citizenship within the IOMMU
> subsystem. In addition to addressing the two deficiencies mentioned above=
,
> the expectation is that it will also enable No-IOMMU devices to seamlessl=
y
> participate in live update sessions via KHO [2].
>=20
> Furthermore, these devices will use the IOMMUFD-based ownership
> checking model for
> VFIO_DEVICE_PCI_HOT_RESET, eliminating the need for an iommufd_access
> object
> as required in a previous attempt [3].
>=20
> ChangeLog:
> V6:
>   - Delete rename VFIO_IOMMU patch
>   - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and group.
>     Use Kconfig dependency to restrict usages and avoid null group
>     checks. (Alex & Yi)
>   - Add CAP_SYS_RAWIO checks for cdev open to maintain security parity
>     with the group noiommu path. (Alex)
>   - Updated documentation with Kconfig usage matrix
>   - Added max length limit to get_pa ioctl (Baolu & Jason)
> V5:
>   - Split CONFIG_VFIO_NOIOMMU into CONFIG_VFIO_GROUP_NOIOMMU
> and
>     CONFIG_VFIO_CDEV_NOIOMMU so cdev noiommu is independent of
>     VFIO_GROUP (Alex)
>   - Add CAP_SYS_RAWIO check for cdev open and bind under noiommu,
>     security parity with group noiommu (Alex)
>   - Add IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) guard in
>     iommufd_device_is_noiommu() to prevent noiommu bind when feature
>     is disabled
>   - Add prep patch to tolerate NULL group for cdev noiommu devices
>     when CONFIG_VFIO_GROUP_NOIOMMU is not set [7/9]
>   - Rename IOCTL to IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA to be more
>     specific (Kevin)
>   - Simplify iommufd_device_is_noiommu, use iommufd_bind_noiommu
>     helper (Kevin, Yi)
>   - Move IOMMU cap check under iommufd_bind_iommu() (Yi)
>   - Fix next_iova exceeding iopt_area_last_iova in GET_PA (Alex)
>   - Fix const hwpt, copyright date, typo in moved comment (Kevin)
>   - Add Reviewed-by tags
>   - Squash noiommu cdev selftest fix into selftest patch
>   - Drop DSA selftest patch
>   - Details in each patch changelog.
>=20
> V4:
>   - Fix various corner cases pointed out by (Sashiko)
>     Details in each patch changelog.
>=20
> V3:
>   - Improve error handling [3/10] (Mostafa)
>   - Simplify vfio_device_is_noiommu logic and merged in [6/10] (Mostafa)
>   - Add comment to explain the design difference over the legacy noiommu
>     VFIO code.[1/10]
>=20
> V2:
>   - Fix build dependency by adding IOMMU_SUPPORT in [8/11]
>   - Add an optimization to scan beyond the first page for a contiguous
>     physical address range and return its length instead of a single
>     page.[4/11]
>=20
> Since RFC[4]:
>   - Abandoned dummy iommu driver approach as patch 1-3 absorbed the
>     changes into iommufd.
>=20
> [1] https://lore.kernel.org/linux-
> iommu/20250603175403.GA407344@nvidia.com/
> [2] https://lore.kernel.org/linux-
> pci/20251027134430.00007e46@linux.microsoft.com/
> [3] https://lore.kernel.org/kvm/20230522115751.326947-1-
> yi.l.liu@intel.com/
> [4] https://lore.kernel.org/linux-iommu/20251201173012.18371-1-
> jacob.pan@linux.microsoft.com/
>=20
> Future cleanup: consolidate all CONFIG_IOMMUFD_NOIOMMU code
> (iopt_get_phys, iommufd_ioas_noiommu_get_pa, iommufd_noiommu_ops)
> into
> hwpt_noiommu.c to eliminate #ifdef guards from ioas.c and io_pagetable.c.
>=20
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>=20
>=20
> Jacob Pan (4):
>   iommufd: Add an ioctl to query PA from IOVA for noiommu mode
>   vfio: Enable cdev noiommu mode under iommufd
>   selftests/vfio: Add iommufd noiommu mode selftest for cdev
>   Documentation: Update VFIO NOIOMMU mode
>=20
> Jason Gunthorpe (3):
>   iommufd: Support a HWPT without an iommu driver for noiommu
>   iommufd: Move igroup allocation to a function
>   iommufd: Allow binding to a noiommu device
>=20
>  Documentation/driver-api/vfio.rst             |  83 ++-
>  drivers/iommu/iommufd/Kconfig                 |  12 +
>  drivers/iommu/iommufd/Makefile                |   1 +
>  drivers/iommu/iommufd/device.c                | 192 +++--
>  drivers/iommu/iommufd/hw_pagetable.c          |  15 +-
>  drivers/iommu/iommufd/hwpt_noiommu.c          |  97 +++
>  drivers/iommu/iommufd/io_pagetable.c          |  72 ++
>  drivers/iommu/iommufd/ioas.c                  |  30 +
>  drivers/iommu/iommufd/iommufd_private.h       |  20 +
>  drivers/iommu/iommufd/main.c                  |   3 +
>  drivers/vfio/Kconfig                          |   8 +-
>  drivers/vfio/device_cdev.c                    |   3 +
>  drivers/vfio/iommufd.c                        |   6 +-
>  drivers/vfio/vfio.h                           |  20 +-
>  drivers/vfio/vfio_main.c                      |  23 +-
>  include/linux/vfio.h                          |   1 +
>  include/uapi/linux/iommufd.h                  |  27 +
>  tools/testing/selftests/vfio/Makefile         |   1 +
>  .../lib/include/libvfio/vfio_pci_device.h     |  16 +
>  .../selftests/vfio/lib/vfio_pci_device.c      |   5 +-
>  .../vfio/vfio_iommufd_noiommu_test.c          | 664 ++++++++++++++++++
>  21 files changed, 1221 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
>  create mode 100644
> tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c
>=20
> --
> 2.43.0

