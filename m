Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B8E7FBA8
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716367206; cv=fail; b=EQ4LzvicOvLjCPuCk0++Fh6lxWjLTfi2luLw/jldPZwuviEYtaMjPHMTUfcH0n0lFJXZheO4/g7lDHXG15uxWMYP3jMu9DY7vJLOqYYP0AUI/HXbWGk2xs9mES+RF6PwK2IBABqbmQ8hZyBfoVstFvpGClHm/ytHSsfbGq6s9p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716367206; c=relaxed/simple;
	bh=fRcFFbDQM3xVjp5VJx1P0UERF+xAsIjC5R9lJX0Tba4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OrHP4L4t0Vb5ucPwEDr9LeMeLW7A/aj/YoQtNtC8mUJcD6+GM9KPQYSWxCOOnH5Izm8Z0ijfRJIWAZ3C1CLwdOSkVx+WU78cGkz4PldNna8g/MTo6Ub0kA+izafiBK5W4K49Pix+a0pXNIs/lL1kKxhfhbYygF/LnhuHkXHsWj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=amWTBkK3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="amWTBkK3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716367205; x=1747903205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fRcFFbDQM3xVjp5VJx1P0UERF+xAsIjC5R9lJX0Tba4=;
  b=amWTBkK3ONIBbSCSZEpw4f2Snxr3wH8NZB/M/A2NINJbRAbuw27bm0H0
   /G9GMSNYLBJ6GgldrjdqQ/ucGMtMgWOU70y+Ljoeu9wPLMoWZBRoCW/n3
   3U6Jjg/OwJX6kpf/RdXxwJCNAJbVYMsyMbyUnEmLPppd0OnmHB8T4B4jh
   /k6zyBOyuQ6wfBGh7BuXksPhMIQdgNhGigwZJg/HmO5QMJrVZxaCB+J0T
   wmUVxv2bKD7IqfIktzsj0ncSedNm+pqkxA2gxF42s8OggGPgI0WnpU6Mb
   b0h+n714XI9Cl7Ujlw9qyzY6QTg+KPjxdYt+E4UZxCneZQCO+2TpcpdI7
   g==;
X-CSE-ConnectionGUID: RGJ7vUu+QNu06f/rzDoAFg==
X-CSE-MsgGUID: hcoCLtsTRn+Q1SA4a6OXJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="15552947"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="15552947"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 01:40:04 -0700
X-CSE-ConnectionGUID: 9UtGJsLzTBGIErWWHLM4Nw==
X-CSE-MsgGUID: TJfHUyQCRAyjjycq28lr0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37794600"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 01:40:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 01:40:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 01:40:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 01:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djzt5AMsMfXw2I8wqnNQ1ucIIf/d8C5ungEQTGReuhogKdj+xysF7RlHqpAubCWyvwhx8bLRmXUGmzjst8Do9f1uErXZsxg1DE2Yy6emAVWK7aFlBMdpgLRBJPETi1mi/jFgAqY3uYKv1/vOeGGxhetCWvO3+DoyrfvYgcO4ziAcccxnJDZGZOmtsTYaljyMQ32oGFByVFk9+3bBEyBSKtJzP7GL5qIUgc6TFh+g29PR6sosOcPCYMmzGsHXaOumh9LDddHi6zGUoTTl3/8vPRUdZFmvbtJ5dEGlCoGGHMDf3zw7wmQTHRofTGpUSxgc7fgOKLBwrXmbPVK0QZqrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRcFFbDQM3xVjp5VJx1P0UERF+xAsIjC5R9lJX0Tba4=;
 b=QQLgFTlzUM0lgHvqZFIcGrOfTofk/8qUwqeFdyj1Bwp6Ba7nxedwgmvV2U8ophgU1ainzkBSYWO/rVt9ID4/22U8QUo+CMQeXzXQSrinzh4vO1kE7Ir8Q+OxWpdsQp6AuAOTsr4DHd+2UdKVVl13WclCtkA+2Bwc3ogYN5jpQUGCDYUZcUUj0yXmNgeLIypz+2kEyEfDM3Pdf0s8q4JZVxefHK6s3yXF4xR7i3h38PJm56RPDjtuDZiOaK2OtG9/Kqf0GyVwM3GTfNZbwdI3FkjnYAvpD9uU/TwIenPWTg5LBoxCBJ7oU0S76UQgSVAXgSiyaIABpuLSrgY8LU5Rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB8198.namprd11.prod.outlook.com (2603:10b6:208:453::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Wed, 22 May
 2024 08:40:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 08:40:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part 2/2)
Thread-Topic: [PATCH RFCv1 00/14] Add Tegra241 (Grace) CMDQV Support (part
 2/2)
Thread-Index: AQHajVVgzSKGnSPg+UW1Z+6EC5j/q7GjLESA
Date: Wed, 22 May 2024 08:40:00 +0000
Message-ID: <BN9PR11MB527641C15DD88FB0C44323D08CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
In-Reply-To: <cover.1712978212.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB8198:EE_
x-ms-office365-filtering-correlation-id: c60ced56-02f2-4c31-e3a3-08dc7a3ac4d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hMztg8L1USz0Zr+HKw4GazHKD4JjFlBC2idXnEjK/53217SLyjhuEd/6obbn?=
 =?us-ascii?Q?shaZjCT8xLBqWbH96sz9vcGQW5MqJBhOWRwZ6dVsoYZTKFRONqm476oQGmHo?=
 =?us-ascii?Q?xFTY9Zkczm+rrYmRMDj950Np7yZETvIoolLxlA8rqbCH5tZAdgwkueLuQPa0?=
 =?us-ascii?Q?zCIdWNFCHz2QNLBffNRV62qY0SOd233EWgP9eqyqRbtTvBPRRAuSRKcBs+Ds?=
 =?us-ascii?Q?N4tzYVB0032Cy4uU+3oT4mzNkxLG0hjbo8oWbNJsmU4l4rqrHz2xn+Sx9A0j?=
 =?us-ascii?Q?0FOfIso7S7PgMGbEGpD7dhMgef4Jw6TAsdzHceNKtyY3fbqmeBm8z5lTgcbn?=
 =?us-ascii?Q?9Ixxt1vawQVc6H0blMEmQ9Tz0dZ4fJ0laMORoDdRVgLFJ8t5jOnlrumjnUkQ?=
 =?us-ascii?Q?em/xY7TdjUHRPNeXiXyO6kgxVD+A+5hmkmMyaNreJK/H07nERGiHDibAIWD/?=
 =?us-ascii?Q?AbMHTh1caLa6LfDaEbGFVGsD218v1cZ0THOSHJ1VH/FrIQcbq/Mwj7RnAYKT?=
 =?us-ascii?Q?9RG8YPXIxXgdUKikSKOROb8LWFIKYz8g0foaXDNnKa1iTFJ5JVEaKnzmdzWp?=
 =?us-ascii?Q?5U+OcU+xZQ6YbllV8SC+/D0u5ZEaXuvFhR7Ort4z7vfGHxtSDDslmltS97eV?=
 =?us-ascii?Q?uWd1Q3SN8ivVDM3wbgFP5pBIlS+V/EXCZ9xXFHclsrDCgRZb9RvNb/tcbMFp?=
 =?us-ascii?Q?yGKbnAD0X9LRmCMv55WA2iXhG/M73OLCvNOUv7OeOPyuf374ScWWZjxv+1eY?=
 =?us-ascii?Q?GU0u5ijPDhc1d1qvRTauAJeZAoLBA5bUhVKDLiNS8RFWouELYZfbzSgAMBhW?=
 =?us-ascii?Q?/mEpjPIFa2IentmqFTh4SXj6CMQi99kIl6q/ATKMUxy4v+Yz/2T2CWCdouAM?=
 =?us-ascii?Q?gqiB85Uahj9XkNIJ/95U3GLYDKV8xNtGJokI8jlzWATF27w+yA+CH7ykMe5N?=
 =?us-ascii?Q?FkCahPlJx8ltYerfh8NgdW8jr0R81MKgoEzSjfxve3nhtXtnZnkcsq+C0i1V?=
 =?us-ascii?Q?Ajb9yhNRBwqxz1s94RlBE1RqxLtByXIW+2Sjb1+N6xZRQ/SAwol3RHc/TaTb?=
 =?us-ascii?Q?OtzklfzkCilfFdVEjwKqJhvjcZFMhghJvyreRlu20wIJ5NXsjit7YOX1RHPz?=
 =?us-ascii?Q?qpc+tAdwHnAdk+PcDIAYg116MXQY96GQ41L2zYsTCDQSSRTqlXV3kkYNPXd9?=
 =?us-ascii?Q?JSgXhB3GKKPU6BYinvMhQ4g6vZdBgfVRfnK632Br1le7lYaBlwAYD+QXO1v/?=
 =?us-ascii?Q?iT7XmDHbVXof1E0oa6ITOf8SgZFaVKdmXiT/ftO5KlIpTTuvPH5Kt36iGDPj?=
 =?us-ascii?Q?aRd9cfsgtkjvr1Yj8x4qQSOhwt79LC7jNIPIG+trYHg0Ow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m69rZApktbvGeaUflDjNTBfDLOAtyaihZcL6wMUwXTK1LxAKCd9AK8BKfhYt?=
 =?us-ascii?Q?1yaVFBprzoOtcXRevSX2s5SZZS02RH7qYKcghNyxfXBP3qTZa5I4zdNTFEfe?=
 =?us-ascii?Q?/+xkLzMjlhUbSme06shAoC3EbjfiYR8Hvq4eBoUY1Qf26+TdGie6dUWD0MLU?=
 =?us-ascii?Q?mfzMrQmBjwEVI+JhNulbbsjFnydSh/onpPTT6aUY9A5OY4vpoUFcbOrEGDf1?=
 =?us-ascii?Q?0P0zay9vpa58270LFu5zZkLHmadzLMPgi1Z565CHJVnVU7lNjyKFTUycYnuS?=
 =?us-ascii?Q?OgSeaHmaZmrr88TEVls/UWh63kHq6GoAhDIQDSa0UWgQ/cy3E1st4MWwWbVQ?=
 =?us-ascii?Q?+8y5fu1FEN6HAsDq59I2P8O+te3Zo9pfryJwVNkWYeI7Gbonaxv2HoikMirq?=
 =?us-ascii?Q?rbipuo8dAQYMi9BAqaNNS2bGlov8HtI+hyFIXaHwI+pThVkZSZm4RXLijcn/?=
 =?us-ascii?Q?xTUfHsNpfRVsKptNfbJ9yKJkzsxdGXjIBTozclz8jbjKKUPyp1zmZMG27tkK?=
 =?us-ascii?Q?GbzZ4HGMpzpHyOg+hdaVuFOz+NxtHrAAQf1L6exL8R5PY1g4H7Q2jt8PYs7h?=
 =?us-ascii?Q?f+Bx/k+z3O5/2X0nccO6EAw1aW+mcdmnXeiZJ4/IEqqc7KT2cLxfGHIOjcHN?=
 =?us-ascii?Q?1lhsNvjkdFrUClVsJF+SY3CGHmpawuBF2Wjgn9u0j9gmxyexU5pWOAIqz44y?=
 =?us-ascii?Q?P+VM3ucHqVb47YYfFIMcTtxcK1zrtWT/1zbGpsZ7yQCQz+uvg4ZlDa9KLq25?=
 =?us-ascii?Q?Qg+y1UZAf3hKtzfi56IA3OEfHNvuKPA7kue+4LJuH1OwljiHOBPG8zR4Ga6P?=
 =?us-ascii?Q?gFswowTEJq7qVTX+floE6xDuxVFWweOucQ5lhoosPLZHon3cGbNnqYFDydTj?=
 =?us-ascii?Q?+o8nOJLa67LTZHZ6kc2jCoBy9WlNAsrJBM6GzMacoLY/KlRXRbKDiT7WEcP8?=
 =?us-ascii?Q?ygeDwqhDNQeUVswXclSovMBDAvUNDKWSGnOsxlXOlCqRFEkvYw6k8CFjxg1f?=
 =?us-ascii?Q?fPmh1/UUxqEHQYwot0t6iPKdCL4NRQE6S9mgz4iIiihennUS2XaJ0IE9/8YB?=
 =?us-ascii?Q?+EClhimIUOYaBX/S+pkcvYlsRQ22dAw7EnZm6E1d5PIJIFVRBHnH+x3+4CAE?=
 =?us-ascii?Q?PtUtE1GgDGoPAN7CHijp4Ly679nUQY94SCJNXlzs3fxSieC+IQGrGm298br7?=
 =?us-ascii?Q?vHxVAPjBYIdvtr2r5KBaXjoZRaZzz/TRX/tHrzz6rul04k2rhHI4yDS5D1cj?=
 =?us-ascii?Q?1YV3lQFi0j2FUvVp+r4Y8LwNV6wrCRfHiAXxSKjn54ITEQii9PcDF7Z/6GQH?=
 =?us-ascii?Q?38bvcySQCJWO/9DWqw6wWrvpKGl6MopZ+ufxHBln3fsr7CYYvXGLj8ie13A0?=
 =?us-ascii?Q?8Edxk7SnpHxj0C4cAy9Ns9qtuW8trJmaHEJdNnMwooqJS6r7rx38IMMFZOVL?=
 =?us-ascii?Q?IkVbq0qfPRJoh0ANfaaSfP2hUZojhHq51Oxh/iqDsvv2drlJz1lJKh6ZjHXN?=
 =?us-ascii?Q?+n6ywjZkay68mZwm55MLqZtFS6GeyjqBmVztyNxYDEPvI4qhKsjl8D+SQk5o?=
 =?us-ascii?Q?/3Sc/N1ZHRIFSccV7ceAjO0jhMYNZXyJmYPT/U40?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60ced56-02f2-4c31-e3a3-08dc7a3ac4d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:40:00.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Sbxg1YQIUN6YQw7rv2uiR3dn1rS2WLs62ChUt/xHxp4soow14y4z6SCI/1G0UrT5QG1TdFxBBzdcpVtDZyhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8198
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 13, 2024 11:47 AM
>=20
> This is an experimental RFC series for VIOMMU infrastructure, using NVIDI=
A
> Tegra241 (Grace) CMDQV as a test instance.
>=20
> VIOMMU obj is used to represent a virtual interface (iommu) backed by an
> underlying IOMMU's HW-accelerated feature for virtualizaion: for example,
> NVIDIA's VINTF (v-interface for CMDQV) and AMD"s vIOMMU.
>=20
> VQUEUE obj is used to represent a virtual command queue (buffer) backed
> by
> an underlying IOMMU command queue to passthrough for VMs to use
> directly:
> for example, NVIDIA's Virtual Command Queue and AMD's Command Buffer.
>=20

is VCMDQ more accurate? AMD also supports fault queue passthrough
then VQUEUE sounds broader than a cmd queue...
