Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60476881E
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716772127; cv=fail; b=k/7/zNZXekWG/Ts5yeCHlrGTZrZe+J0oxwefEL5nrwwfEe+AK+UKoh3ZeiCqV+RbhX2dWQXi9SddX7WDDzFjOtMYzj4OLk2IUTl66mr9JB0PGQSUYhRzn0OcX6NF/UKi9qrhcIvC5LFKjyc01OYVrH6l1SVvXVzyQP/d+ZAfmO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716772127; c=relaxed/simple;
	bh=kPgGsQVHsfsaYrC2nKi9IwfYY6raJOZiTK+/5oO8Q8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FMW4xUe1G5+ZE093SyX9oa106HROqbtuMC4Uz2BWhPxnguABUhEei6UDzCa/zCg322CN82yTAyGfFvPo8kf7s2tLWCP0gsJTIsMwgkHRWWUf6HaNrmTBHnAqIHHGFIIofz/3TEDYjfcatkpRbX7jKoXY4FYySMk2EQ91tJfyns0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebDHfQL4; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebDHfQL4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716772127; x=1748308127;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kPgGsQVHsfsaYrC2nKi9IwfYY6raJOZiTK+/5oO8Q8M=;
  b=ebDHfQL4tI/+Se3BdxcgcfPIwjKqW37Ceq9WkqXu6L2lE0G7Ab3VJFdi
   bm//W6Zma/LExgsC0g4opxcrpjti3aZKOUoAHnGzVodsvHgSJHgo3bMv5
   poZWddTa6fzzzkam3UL0xZTe2gkdId6m8FtAfeuUajG7ag27sExGV4iEH
   1aXBS3PoxJ/sWwVsDwkvqcGOGxVJKTnTeLfqAzK6npCaEkBxgJwTaJLjb
   gopSe+ZOSwzx7eKPfIz7xfkyvo3f43WOzPRPucppC/up2TpCwNXPnuSXF
   HCsJlD8af1VNWIZbU2EPxkAhuao/I3K45NQ+yaQzyILWN9LekSFtoqdz9
   w==;
X-CSE-ConnectionGUID: eEav2n99S8OZDzy6H3YoKg==
X-CSE-MsgGUID: PVHbaXtzTauO0D2JXeOOYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="30582605"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="30582605"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 18:08:46 -0700
X-CSE-ConnectionGUID: mrwM64xyTAKQ7haV3ZHrFg==
X-CSE-MsgGUID: ElZXpbjjST2D5E0a42eSdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="34574885"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 May 2024 18:08:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 18:08:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 18:08:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 18:08:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy/WvNyMfAyVLyhOtElSWRymha7/T9iYI17apWAL6VxVJryvwiXpesvnllvY5z2cgLh8IDgqgcGs/co+x1pk7GU6DdU5vKoRlz+En52ApwRlVduRiU/PYG93FNsIywuMcM9oRzkHAw2wBSUnyJfcfw1iY5njKsPzn/7omMaM3nEerAD1afh6nkHT60vtHq2E2hv3B2ADz+zQ4vSzSrj91ulMuvWqXW21/8IrDUFwmQCtF9Etyb5RoElPCKLfN/d5oe8uoTZeF5q7eryL09Rxltl/tz0auWRt5RakFzpX7G5PvnF+kKltHDsJfW2trcCSpYXGYdL+Pcr4O6+KyIUC1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPgGsQVHsfsaYrC2nKi9IwfYY6raJOZiTK+/5oO8Q8M=;
 b=iXjpsuBPPBk7/qDRArSGpLAmXtU//DPvNcIU3fG5GmSPQwe0zDf3+QIrs+mEbW5fpjQxx6E1vDNbrpl70Cz9TAfY0S4V8yRpCm7+WQ6nm3Qse1cD37eC1IaYaKi+5Z3I92C/2nhyU/SwDzc4oZXDKywFfv78GuT1gqGXVNr84EomTtE/otCUHQYGOSUw9kCkzB/h2LbmW0QT52w0OQg4vaFg+d7Veo86tBMKwr3E+AZuRvvkRhaC7d1pdfiI9eCffRUIRI+v6bguLI+S6dJD1aXZAg64qO1Vmz16t/TN4Wi5NKCBCI26ixDNYlzRM8GzKvubaaKjxMmfwvXUfVwk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 01:08:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 01:08:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6AgAGEQoCAABbGEIAAaX4AgAPpupA=
Date: Mon, 27 May 2024 01:08:43 +0000
Message-ID: <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <c97a98a72ee3498c587e5898d6b899553ccd9b27.1712978212.git.nicolinc@nvidia.com>
 <BN9PR11MB5276A897A5386DFAC9A35F9D8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlAoN3s96HL7ROth@nvidia.com>
 <BN9PR11MB52762A0BC67B64D4171480C78CF52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524131912.GT20229@nvidia.com>
In-Reply-To: <20240524131912.GT20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: 97060423-90b7-4c16-af88-08dc7de98d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?tsshlSvA9C4g4yRd1a1qaKJT6hFXB6bPsonEI2AhftHtWvJdfXgwnSYmRy30?=
 =?us-ascii?Q?ozt5H7iwZ0gxTalTVMQZT6lbIm3oNd7QGpTh2yGmgoDvnppdfzFXxG1AB2T/?=
 =?us-ascii?Q?dR7U2zleGQZpyg6sOpGnSrEaaV+WdBwaWgJt4nqHYtYAdxevmvY5m6OKbhWs?=
 =?us-ascii?Q?SiBV80A3E9DNNnwOratNXKg6gcuO2RGN0HqoU3mwtTpUcGOAuZwuWXyqUuzX?=
 =?us-ascii?Q?thPfKIFQVrpWFJlleVkbqCcYJ50X11X9FHMlavM9lagWCls6YX3mvpbZwC3B?=
 =?us-ascii?Q?6EnHMgIPdtQG1ummdKZlmMNZTn9Wcof9VJBJP7gmyEoKZW9TdTwgO974/SDq?=
 =?us-ascii?Q?dF/ON4ycZlYUUzDJwWnAN9ZhAVz9nSw77UfqkgKwRvYR5pYbWZf7S3RWLUA+?=
 =?us-ascii?Q?qR0jF3tjnspOdbWnYXRINXC2DZZqz03/OO2MfXZmdpQEFRP8lZ5yC559sxab?=
 =?us-ascii?Q?Juj30D+rKfp5R3TtOw2qUxB6KP1326rqy/Xr4mk2c9EYUIVrCu5b/rsNb1Re?=
 =?us-ascii?Q?njPxpsaIbQe7sFTlaZzg6WG8cCwkgq2vYmkiaF1kQ3WIg06qGPC9ANKFACHT?=
 =?us-ascii?Q?Ww7ks0t1/26uaQUVY8SWwdr2FOxHeflLHYxDRiiHOS2+q1p2QHBLCPScDheZ?=
 =?us-ascii?Q?yGpnmwGX50vNA3CqQboAglkC4HCULxumPAFDOX88RdKMSG7UkjjLrLsoX8qq?=
 =?us-ascii?Q?p7o7uk/Wc1z5cqYJ1nDOSn1ohud3vywruVMtbtctB3Q9m8LNjeTQfbsyy/W6?=
 =?us-ascii?Q?gPyNM7o+d55rj3xZWw+t+AT7TXifYT3oB2EU05IuECckswpH0WmEXI3tHlv9?=
 =?us-ascii?Q?OzOTsRGxHRXmkbu5Sv03PvGsyxrFVu9piyWx36v27ADegyNkdqDPPvbdJ9L3?=
 =?us-ascii?Q?74SitvQP4HQ+Al6rRpVk7McSxtl7tYduf7FUxj+AmXMOKf+2bNi1qIMkCveY?=
 =?us-ascii?Q?ewhwdVRz3esgp+gdueJe8ybdVMpwpkOA37HkxOSi4WM/oBfEqoa+Fkcl3ril?=
 =?us-ascii?Q?N473cBbJRd+rjWeItSRvskGIUF/eHWNMMUwM9bza/QdOwf03ajuUAPpO/1k2?=
 =?us-ascii?Q?TCD8h+sPuzV70zWP93jSO4B6kWoz2elWvbx13QzAPbIBmYq7ejhCKNuov1pK?=
 =?us-ascii?Q?KMugl47J6fA47pse+BRfKe2qxzVeq1Qn0QQyJ9kZV0tWtFKLReNkPKw4gQfB?=
 =?us-ascii?Q?ThbeNHEOOxqyQrbJOaoAcL8PNEw33aOuE13O7JsffSxMHhAm3O16Zfmd6Q0c?=
 =?us-ascii?Q?fKePSR32ErGO8bVF59y26OmSoEQLd4OCHs3O9A113MhpopDFF4uwMRbiWNk+?=
 =?us-ascii?Q?X2OWV1UeG/sCPnRsziIodw/dHS3qARFCfWJuVNa6Z8tSEQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gNC0wMOdjkQGNUyIrJsmYwQZFOyVO0JYjqqbHbxxp+224dfNU6xM0f2u1Srf?=
 =?us-ascii?Q?5GAP3Foy3AtL34KLzR5gWLyuzunDl2sPUGWjhALqs0/KR8aagzmxpxv8PbAU?=
 =?us-ascii?Q?T1lR+H2w1vPA+4FZwcz6Z1GoL1MccuRfkUk3askrpbIco+EtpMmg+0Ku0f0H?=
 =?us-ascii?Q?YsqbW0zCqKZ48lHdz50jTMfIv6llDWhAOASpdNfFAErR6cO58GRoKwQ2BMmB?=
 =?us-ascii?Q?ZNYXoDoo3uxc6rYkuSY3P8sLN7U1UN6ZiCrZRRBZazvInym/fvrJfQtOvYvK?=
 =?us-ascii?Q?s4Qfy7OF9CCrfrzFPr5P2sZejyi/io/r2bC9jp31mHWSJ913ZjmcRwnIEakC?=
 =?us-ascii?Q?0QfXkRu8ayNe6Qfxpou6fzaTKbGLJLE3maIMaZJ5FU6AiKSEpuMJjH62eH1K?=
 =?us-ascii?Q?1Vxv78QVZoK0ZAmR/lmXNyn38TgN6BgDId0zqNtuhfPU3jDuyZOBZsZgrZxw?=
 =?us-ascii?Q?TLKQ9Ua/1Z/BO4OAfoL/X5vpWDx/hilgWe9c9e7oRC5uVPmruNinVP5CpIx3?=
 =?us-ascii?Q?U2Bd7O6QiREzdZ0n8o9o13jA9sdMUW1B3/yPVeGC1TXcgKHKD5FvafIQN2jk?=
 =?us-ascii?Q?zqjYNlnPGb11U7G90a3zi8U+/hjFfFdn6Dwq2ACRS7eCq8PCi7DbepCWWswy?=
 =?us-ascii?Q?D5nB+HWbEj7rPUKW3ZJNRhM4H/CpaZsZmEZCQUp2o6MIdwq906+XZJO5ijV0?=
 =?us-ascii?Q?NkGqh8MtJicJQbMHGMuAZ97Ahzprt6KOt1lN1YZLfmr7GWop3SO556aMXUM+?=
 =?us-ascii?Q?QK/Z1syMPQ+0ppR6/V01pSNyzxHQZ/ztANhiaPhgNJMFePnw1GsF839Lp/V2?=
 =?us-ascii?Q?8PmODYHw5Ay27qxeW59k2yaIsNTyYE4Bp+Ya5BViACMNhheoyUW+45+WimIV?=
 =?us-ascii?Q?2pLc4mwU27jQFlNCT6TfRz8Ivft411jtIzlFB7sA54u7Icm+UW2BG/rldu96?=
 =?us-ascii?Q?eBIIL3sNtWjDIMUftH3goLuzjRd3eIqQT7VlrWB301NegEjEO2MW8y5k5W9L?=
 =?us-ascii?Q?kNgzdUVNyktVGv0YIKwHOwDBiU1G+bpuIYh+uXEOcfDOA8IZmF1HdcsQiyCV?=
 =?us-ascii?Q?pWj6oXYYohuP2q1V01+KTmfRS/wrqWgPXJZ3XNADiokb77Ef5IdHSZYF/k6e?=
 =?us-ascii?Q?yVcjF1Ds534Y6HpZC2KP83x5QVuY0Rj1KCkP5i6rrckv4pB1MaYHAy0bEFh5?=
 =?us-ascii?Q?jLfYEB6x7QtM+dhIMMO1s5xs+nRd6LMv8Q/0HHjLqtKZz6rZavbYIaUgLLPQ?=
 =?us-ascii?Q?F+1ElmeVliD7dJMsVjKLS0aDktdbCTHbYjkHLwPtT68qg+FqLt3XsSEK84xo?=
 =?us-ascii?Q?D8LQqUDPP4z92iyf27WuLx5yBT/F1nA6UuEQ6EYEYTulVjeasYdW7qgzIPnx?=
 =?us-ascii?Q?hWzcV8w+e+2Q0vjhHQXCgg7gbFPJx2Cyp0wezRkVLlNaPWicZUAdwI+6gcJH?=
 =?us-ascii?Q?5vQC9mD7uUhwJdxsIxvwX6vWUzTR8OZ4yT++ZX8cTahOIFNiqmYGB24l7qME?=
 =?us-ascii?Q?kgxrNAeIbFb+Lh/EeASyYuLDZRIkzYf7f9xcywvq1c0pZeT8ZgR+RLiOSBjS?=
 =?us-ascii?Q?XdgssO0IezxSAMODB2/R1Rna6N1IlawX811MUgid?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 97060423-90b7-4c16-af88-08dc7de98d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 01:08:43.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OjfRpUfv0o3hGu2bMj6nRJft+EWdsWClWZVnzk2yhZI72ELopuCX/jMaPs6eg7+dXBNVATwDWgAfaiYs/1jNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, May 24, 2024 9:19 PM
>=20
> On Fri, May 24, 2024 at 07:13:23AM +0000, Tian, Kevin wrote:
> > I'm curious to learn the real reason of that design. Is it because you
> > want to do certain load-balance between viommu's or due to other
> > reasons in the kernel smmuv3 driver which e.g. cannot support a
> > viommu spanning multiple pSMMU?
>=20
> Yeah, there is no concept of support for a SMMUv3 instance where it's
> command Q's can only work on a subset of devices.
>=20
> My expectation was that VIOMMU would be 1:1 with physical iommu
> instances, I think AMD needs this too??
>=20

Yes this part is clear now regarding to VCMDQ.

But Nicoline said:

"
One step back, even without VCMDQ feature, a multi-pSMMU setup
will have multiple viommus (with our latest design) being added
to a viommu list of a single vSMMU's. Yet, vSMMU in this case
always traps regular SMMU CMDQ, so it can do viommu selection
or even broadcast (if it has to).
"

I don't think there is an arch limitation mandating that?
