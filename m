Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016921E3CB
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729046674; cv=fail; b=MhtVYf1A5jRvz6QlWcbQJdWZmJwuFGrEJG2zdKAqxOjXixUm2fjs6VeKeeuAlJsZZWXdS5m7zuDe4nTUALAovBdrtF76BQEVJlFPD2t2JuzJSmbwb49uvvoCJfmlhtxLZ8k1zS4ELuJ4Nc9x3JJJvBeGRPEwfc4aI9hPWw7AS9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729046674; c=relaxed/simple;
	bh=Yd2VoSfvl4g82thO88ZS9hnWFxSLTnJa0QmrD9QlkrM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j/18yNNkjY3oM2A9ua4TJsWQy2dXRTQ5GyOcBngS1irRi0E9epVQ3fxawHHG2ySzSPDCPkM/klyQ8jkwcuIcB8J7aVkBh/9CRhHzY0AuOkTi7td1J0Voa89b6hca0KAFYU/PhtU1vwpdrPtapuklSdXrmjzJzrjpO0T323JcGic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZKCzf2A; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZKCzf2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729046672; x=1760582672;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yd2VoSfvl4g82thO88ZS9hnWFxSLTnJa0QmrD9QlkrM=;
  b=cZKCzf2AsxD2eSWgu91y3k6xucjZH2XO7uxtracCxHf6j6BfmWLrnVt8
   F9xI+4Vws95h0UGyKzeU5m3KpACHtP1m2vFqVCwoztpoJ0OLeDlf0VLlB
   a85eZSmtOcL0kyy2YAyk0lz183/4dwoQJ0JOKAtj+KqI89uZ9k9Mp3bXI
   5rYdXd4i+eaMOc4/iJ60znzZMyJz+4KMyv8RMvhCV2EdB6LM21px5movk
   M/NcObrAWdIFeDGB2Md+5Af/iJ+2Ux/HqiD5+nqQvq/ho7Fx5SYf05OQu
   r5TPFqxf0+VdN846Y1g3XRvcVj0z8SZwgKeJCb73gkNnBhFu+xyYBeryA
   A==;
X-CSE-ConnectionGUID: 3Z8O0ESMRY+Y90xjMJWMDQ==
X-CSE-MsgGUID: fLBNJXT2SleRE7Jrnj+WNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="27952505"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="27952505"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 19:44:32 -0700
X-CSE-ConnectionGUID: OeClEUJTQs6z5YA0CPJJMQ==
X-CSE-MsgGUID: G0kbTvWeSmKbo4Af9ZTRQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78153831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 19:44:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 19:44:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 19:44:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 19:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFTVVdmWn/ue3RE8PDoCVzvtKiQkiIJ5xibM2Z9VMNLFkaSqVm3ioA5yTDYZG9tnOYcsSJ3Wt1XBxYPgaPxKyBpGWnQjUcJJPtpg0j5eABm58T/KnaH/ivOz0e0+yl4xwt4YnUkblokp/HmbYqXc+VVE3pPUSciiu2jZ+6wKEz6r6WzcFv4SopPua2KQJO4u9E4xHuRK3tRZJQp8v7zwjrmureznSBL4ibuZP1xnqM6qGUvdvMM+Je3KCGOnJ4IWqRH3nNYfIhRUL8+KqYje42GP+SoTKFxO0XnHr/6imdwkPZYc1m7QRvdosaHbpQixmtghnZ4OvipoJXmM+nQS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpRLIeJfAEmkYnXwltjOyzjxi0OptJD9jrJ7XR5At7s=;
 b=htZMmq3MnxK0Pokjl4i2r/KRbLpu7QYEqAAOAAKEVlVveTYKgMO+afOXLIVLP9vXG2JBE8J0xg+cqKv3tNv8Nd+XNo+1NzsN0ACAa+oTk7fCgYZOiqYMdHMc93HN2BycQAO/+Hf7pvTob/rh65+vvOyaVU/FW2YiUB8U4llbRBglOHVib6I4rdJ3n6yzIuhn0Cs7pukwZ4P5aZJW1esqk2u2ZBy0aTBThYM4tmxRURL1Hi/6IDAoHxs07HnWN3I1yOpfx7CZSyS/KFBWJOsKRUw0u0SBZULOgVXIAubhYgfZI/W/DBKTJZMaecgBK6VG4WXTP/ZdGMq7rHoA4d2hDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6202.namprd11.prod.outlook.com (2603:10b6:a03:45b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 02:44:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 02:44:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
Thread-Topic: [PATCH v2 2/8] iommu: Introduce
 iommu_paging_domain_alloc_flags()
Thread-Index: AQHbBDRE6u5zVfoyV0SOdUgALEZpF7JTiWgAgDQjU1CAAEc9AIAA7iiA
Date: Wed, 16 Oct 2024 02:44:27 +0000
Message-ID: <BN9PR11MB5276A476409D2CC666A36BE28C462@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
 <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
 <BN9PR11MB527639C51F172B6A3C6996EB8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241015123142.GF1825128@ziepe.ca>
In-Reply-To: <20241015123142.GF1825128@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6202:EE_
x-ms-office365-filtering-correlation-id: 12a04888-859a-4abe-43fb-08dced8c73d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?X6lJGp2AT0407k6k5Gr0/UJPKVgNMyvohKm6y3KsieC56qqfXn9zoBq36t6j?=
 =?us-ascii?Q?VgKGX5zXiqOLKIKtSWcG3jE09KRSP4tjUIZNZlHrZxBx0rHKzZpXm7BETh1U?=
 =?us-ascii?Q?Bwg0RVJfHsXCLWXRznp+C9Nq9dfX+IyYYRcIZr82AbjI6c4nc+DeUgJ9pBDS?=
 =?us-ascii?Q?RXwGp/a7Rl6WbonVqQN0rMmheNGepw/NmR5uq64BnElvleTn1Kz1xpuSurGy?=
 =?us-ascii?Q?CCT0z/40IO3gulkzphXWnuRPUkGRqxJFnq0h/J3QIxe2g4Pab0ntcl7iVCX3?=
 =?us-ascii?Q?vCdaXOe52qXxL0uItdqWQc8gw1C1sjAPvdWkNdI5Skq8/6RzbygERV1eNVQG?=
 =?us-ascii?Q?g9Evm/YM78neF345MAxkWQhYUDP+AbtZN4VqHqdZrP0sr+USuKTu9mH5Kmyp?=
 =?us-ascii?Q?Ks4Eaj8J2HfS/u7xb1K/zEyqftuuK9Al1cjD4G57rUTRkJ0jJWVvq6ShJqYk?=
 =?us-ascii?Q?3TBhVnvaUct2CxX3+Gl+UA/teO0pz2pLV61gDAcmxLegGoG1fRIaRnuvpDD/?=
 =?us-ascii?Q?ezW11jHFoHLmpD3Wh9iGvPmU9CjkF/s5VgPrhhNktSW8+uNRboTehsbwhNqq?=
 =?us-ascii?Q?vlM3dGnX5s49vGDEYrSyR0JA68kAYZuI3y5FxQiQeiC2HT2trjAZ6xqdEFTu?=
 =?us-ascii?Q?92ygjJ7ViyLdTTLAX8KKjoiBjYIdwrg1wdfJhqO4XpivqRQ6kGN9EpwbvDhl?=
 =?us-ascii?Q?vsrRai5lqeI4JoD6VYn80vMH9HL2scpDyifKEfaVNJZ9897uN3OCOkFjxz4w?=
 =?us-ascii?Q?RR1ngivh68kmAiajEXiD/QJcKuim0+Jdp2vXuBZXpbpNXlhPW+FGjCIZ47JR?=
 =?us-ascii?Q?lQuooBCCDelU7sGEqqtFozmddO0O4p6IJ17hy2Pylz/L9KuXOI2jza2A+/oo?=
 =?us-ascii?Q?+kYPapnQH47i+kzo1MKE3PS4vBEgULNyd4dS1G6uzburNKMmjB4UY6AbuAMd?=
 =?us-ascii?Q?3Rd1bCYkn4/zEOdYJVbRMniKCAv4zvDKEpOvNizPvhF5NEZcCWv7caZ6TlXw?=
 =?us-ascii?Q?3jYrTtJkYd5SxrzntLmQHlUmf539ut/dJLByh6Az+VSYBbIl6U/8LmUxnoXz?=
 =?us-ascii?Q?abwkGyNk8qmvJ2qmeb7BgKRBWmyHEYVl98QW1opoa8PwxC4EMBpMKlzhVRc7?=
 =?us-ascii?Q?1e+bjcAYQxEYv52SH+vawVjTkNe/vqpSenww44aBiRinCsh6rLSoEp3aTiS+?=
 =?us-ascii?Q?casiHXWOZOj0E/Wcqf8+v1R2vj9LYgIU76FMSRJmwONq7/XvTrXzY800Bfgc?=
 =?us-ascii?Q?8E2390yMHbKcUu1eAPjXRUhIDhw6EJK/bMklxzj21MjFzwobp3Je5JJvRso5?=
 =?us-ascii?Q?PL0t4exuNm3rLCYrf/iDmhR0WMER8HsMFj6lUFLNtfLk9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZcDPyWFtEUj7Ri+TgzYrSf68Ixnvm6Csd0h4RKBJX3KKgDZ+UfYHVN7FCWFv?=
 =?us-ascii?Q?4pNU+0ft7vV7DnchPbfa+uG27xkGGS0Zf6HyQB9yzPrdlbcWfuzQd6dBXufy?=
 =?us-ascii?Q?YuY6VrGQT/iq0Q9fT7C3tK8Ls5Nii36esuQBUwnZ0VfTwMIOtD09X5GtKvKH?=
 =?us-ascii?Q?cH5JF/Qwjzf/UYvA1myxHxv6lb2m6xNWd0TcKGrRnFLtkGnn3EY0SGvAd5+o?=
 =?us-ascii?Q?SbNBCyWnex+rBHPtzMyIpZfJgzmlJ+mu8ILvDrqC2V/aC12HOU+Otj6xdM9d?=
 =?us-ascii?Q?4AQTu8WN2QwmZP+WDK9iDZpsVEdtOZYiHcjgxfymILannyt5twFcSBMwXXSB?=
 =?us-ascii?Q?s280IrWBJoBwIPawFW9PxWsvLu7KQApBgvlYgDuceKRc/pnFiMZButgzyjMk?=
 =?us-ascii?Q?ChI6GzcP8MENzVIuNK+QTL7HNwPbWkmkMMOBl8JRPrkGuy3isVx9dUk7KU4z?=
 =?us-ascii?Q?h/oo9W3N2Wu+Jo9CHSg4EuqDksir9uWJ2eC7jqTluWnzt+PgeKW/xxB5xTZj?=
 =?us-ascii?Q?E+KsKb3cXHJtpYiqN7rpYEKzpUO0SWOqtH8UNYiJZRoc0FG0ikte8G69q/kh?=
 =?us-ascii?Q?oYqWv2fduZfPmuqhX0+KnMtwVp+20XodToza/T1sDLtyscZ4ahhngEh80I9C?=
 =?us-ascii?Q?LFnT7R0IXfGUXSRHSGAPIeBwNppAyGjGZShFWErqYNQi3fgF7ZNOjA9fcA5t?=
 =?us-ascii?Q?lfLvE3SsWp1kNyjoZ1SRtjVAZkhwIyolWezbw5UCVpyubEgbuDgW8tzDohlJ?=
 =?us-ascii?Q?mjGLJC0kAVANsvVxOqU4B78QPlI4aS1fxVetj2eGw9fyzHeeJmXhzS/AoVBh?=
 =?us-ascii?Q?mpagR4eoi2IHheg+VXFIJQ6SFaXH4yOI2VpJSARz59frJrNrUjVVEqydGMEE?=
 =?us-ascii?Q?h/wGql6ITUtV0UyZSPvHTkZjD4hVallFaBK3dfbJR1jYgVGxqdFCvjCeZrRD?=
 =?us-ascii?Q?zc2/VXXFbhqRwbIReK1F2YQhIDk0A63bhMdhHk9iiBarOYmKrtaWDz0hHFkI?=
 =?us-ascii?Q?sD7IimaMMYSYsLqTYwmsT/FmILZsT157U3GnhGmHIdAZyBtfn2+wSaE1WK6u?=
 =?us-ascii?Q?lMG3T2SjfgQjmAjB3+dcyFhq4MUIoA7zmd42Zt+OqRniPpMXSok6AQb6MyDn?=
 =?us-ascii?Q?yDsb7jys7GbGDKDtobIK1cCT1YWcIdSmOmz2xFSvwQ0eI2gfpBZf+oT5zWn9?=
 =?us-ascii?Q?ENXiC7CL17lvTpTPFdFJb6wvtj+KUJWQDxCpHd9EU2l0WrWnR4jdlko413ah?=
 =?us-ascii?Q?/lUF6oXWeZLV2u7GMCBI/Lmk5KP5UsWsHwz69zU8dAXDF7Ux17XfrtAfu6Gm?=
 =?us-ascii?Q?nmQhL8Rzg17m17MXqgTDy+97zr2oVT7UT2EnAuwzu9lzZPTcvX19koUN+quF?=
 =?us-ascii?Q?GFwxjLqogVjQ1k4qEFYC/HbD+1J2Nbd8xDq/6Wczh4rG6pQdVJqUSUBDcR0f?=
 =?us-ascii?Q?o21AbNz5EzPmd3vyXpMnKKrokHqsuMwb3J+JPC48tPsw1SGU16PpYO3hVJcq?=
 =?us-ascii?Q?p9NU12jSDgnGweygEU1Ny5dolRlYEUmKznVEQEAtA1iVqL6fIGnYheFQ7J8e?=
 =?us-ascii?Q?g4HByRFqa4l7ACCr/fy3Mb4CMC4wRuAepG4ApUgF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a04888-859a-4abe-43fb-08dced8c73d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 02:44:27.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EvKCVcAFV2+7VCJDeot8bXTtCzP+3/NJYqutnCKVgUEpAe3QLY0oyaVn0A78rlfrFtub/0u23vrsywtmyj324Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6202
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, October 15, 2024 8:32 PM
>=20
> On Tue, Oct 15, 2024 at 08:24:44AM +0000, Tian, Kevin wrote:
> > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, September 12, 2024 12:05 PM
> > >
> > > On 9/11/24 6:19 PM, Vasant Hegde wrote:
> > > >   /**
> > > > - * iommu_paging_domain_alloc() - Allocate a paging domain
> > > > + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> > > >    * @dev: device for which the domain is allocated
> > > > + * @flags: Bitmap of iommufd_hwpt_alloc_flags
> > > >    *
> > > >    * Allocate a paging domain which will be managed by a kernel dri=
ver.
> > > Return
> > > >    * allocated domain if successful, or a ERR pointer for failure.
> > > >    */
> > > > -struct iommu_domain *iommu_paging_domain_alloc(struct device
> *dev)
> > > > +struct iommu_domain *iommu_paging_domain_alloc_flags(struct
> device
> > > *dev,
> > > > +						     unsigned int flags)
> > > >   {
> > > > +	const struct iommu_ops *ops;
> > > > +	struct iommu_domain *domain;
> > > > +
> > > >   	if (!dev_has_iommu(dev))
> > > >   		return ERR_PTR(-ENODEV);
> > > >
> > > > -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev,
> > > IOMMU_DOMAIN_UNMANAGED);
> > > > +	ops =3D dev_iommu_ops(dev);
> > > > +
> > > > +	if (ops->domain_alloc_paging && !flags)
> > > > +		domain =3D ops->domain_alloc_paging(dev);
> > > > +	else if (ops->domain_alloc_user)
> > > > +		domain =3D ops->domain_alloc_user(dev, flags, NULL, NULL);
> > > > +	else if (ops->domain_alloc && !flags)
> > > > +		domain =3D ops-
> > > >domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> > > > +	else
> > > > +		return ERR_PTR(-EOPNOTSUPP);
> > >
> > > How about
> > >
> > > 	if (flags) {
> > > 		if (!ops->domain_alloc_user)
> > > 			return ERR_PTR(-EOPNOTSUPP);
> > > 		domain =3D ops->domain_alloc_user(dev, flags, NULL, NULL);
> > > 	} else if (ops->domain_alloc_paging) {
> > > 		domain =3D ops->domain_alloc_paging(dev);
> > > 	} else if (ops->domain_alloc) {
> > > 		domain =3D ops-
> > > >domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> > > 	} else {
> > > 		return ERR_PTR(-EOPNOTSUPP);
> > > 	}
> > >
> >
> > There is slight semantics difference.
> >
> > Original code picks domain_alloc_user() if !domain_alloc_paging
> > and !flags.
> >
> > but your code will pick domain_alloc().
> >
> > Based on discussions in this thread domain_alloc_user/ext is the
> > preferred one. Then below is the right order?
> >
> > 	If (ops->domain_alloc_user) {
> > 		domain =3D ops->domain_alloc_user(dev, flags, NULL, NULL);
> > 	} else if (flags) {
> > 		return ERR_PTR(-EOPNOTSUPP);
> > 	} else if (ops->domain_alloc_paging) {
> > 		domain =3D ops->domain_alloc_paging(dev);
> >  	} else if (ops->domain_alloc) {
> >  		domain =3D ops-
> >domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> >  	} else {
> >  		return ERR_PTR(-EOPNOTSUPP);
> >  	}
>=20
> This can work too, but I think we need a few more patches still to get
> there?
>=20
> The order above makes sense if drivers implement both
> ops->domain_alloc_paging/user, then you'd want to prefer the more
> narrow one.
>=20
> Once drivers don't implement both then it would make sense to switch
> to your version
>=20

Okay, that makes sense.
