Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E33CAE85
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943219; cv=fail; b=u2hsI+FU22BWMnmRZFnGBeydvtwfZTxIJMex0h0VUSsNyf/F0Csi5cyu8P/dIAOTRqrNjDOGx+KlsLS7r9o4+YzCo3EEFsqQNqTAAXEbiHxVLXCJwtflbfgbZpmCwsqHCOh8S/kf2iEuiHnmHCitsnoX6g73Z+aB1PEEeYgOTKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943219; c=relaxed/simple;
	bh=1OE1EdUAsMxfk5/phBVXm9leBMiE9TM/CxVRkm5/NRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aTu+QKPEpSoqx31nrdKQYUEqvsXb2Nos4RMk0+lVc4/fq1G35dScj5ZrahXrqTfMbrkaMy+AvtRP2pq02Kw/uJOeKR3cjZuCgmB8D0raZJv0ichZTT/7igUxduSpts/5ffPNRjdxAYY5+Yyacn+QtWOfqLP16CrMIurVpsX8h10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+8xOjJP; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+8xOjJP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774943216; x=1806479216;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1OE1EdUAsMxfk5/phBVXm9leBMiE9TM/CxVRkm5/NRA=;
  b=d+8xOjJPxuwQzQCefK6CngUMVTwtGj80aOODMEc5HUexqBDiCIRevQhR
   x8GdgsEoehxUMoSOlsLOBAdJP7KlLMo8qB9M9Z4+FEvJKZb3nZXmXPxzF
   MAynTdbmB/ciMffy9dUki1RhYVDjCk2QKn14XkW1Ph8ooAoePyH53ndvG
   j+I5OIOsNSqGPAa05IU7i0FbCeWIJ3eMvgU3TbcHkQREeMiIHCmcKQ4b/
   prCqP5aK922dlPSRhFfjaRNgzhUGk5NIHsFFzSkxX7H/JQ6ynnbCA9E1C
   OPWBI+Q+IfUycR+SY2MZVQV2aXt8PNXFHJEvgfqp7Z6vZI/veMvhpfdUs
   A==;
X-CSE-ConnectionGUID: VrKkymD9Sy6DmzJgHmvTLA==
X-CSE-MsgGUID: 8BYEjyUAQlujA3nQsh1zUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75833156"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75833156"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:46:55 -0700
X-CSE-ConnectionGUID: mjG5dhAeTpCjAUbC5j16Mw==
X-CSE-MsgGUID: uROrQDljQwu9oYBb0zT81A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221420678"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:46:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:46:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:46:54 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.38) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:46:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZQwT/LLcEF0PemwTyyrJvXKHHM9s/LTaqJcss4hBdqAFKd+u41xc28RcbcOdQFe4XqZoDt8NEh+McV7Q/cIYYMxL8MG/CnDkjTD0K/wiJSJ18eh4PquVO52NWD3UMnPVJFIu0NsICJzXC3OEqQnMxOMnilC/sP2DZ09UiIM3wSj2KPtSs6Kr968ozQfZ+X5rY4VtX9902Nz9oLwMxwZWycgndAUQ8ZAWM+Ee3+XvfyxaZQCZBTX+xP31A1ASThs/nywhFknTvhNDrXyz5jSU/q9P3HfhHauDJzCawnhSbJvU04Ikzh76ALF4z9pXfOQOzigwpw5RzJV2i7RBqGHAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OE1EdUAsMxfk5/phBVXm9leBMiE9TM/CxVRkm5/NRA=;
 b=LCz0cF532EsRA7mPmyxF89YUWfVpT36tVZcyypWLh4NihmLoh0DrL/oJceS3bGXbO8eXDDJlXoT0SuQa43BsdPxqxWZzSl/3oe57RWYEww61xyL3yVEEDuUL1r4Uy9BtYA5KY55EVl5QQ70W6RtUKCU6IKXtCuABut7fveUs/yU2RA4zdFp2YnMOkC/CcWwPRF84iTTStKsOgRF6xQ5c9+wBGR79H+C+PCUIfE8MFj+K9o6r4ufT2lxa+4rrSPOt3WlZ84xVcbvuT2yDyTKV+gKJMFHUjjkl82eY+F2S2yaZp3xMP0WvL4zJufvMqyhq2mY251rS9XqN4WTV+u1Y1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB7150.namprd11.prod.outlook.com (2603:10b6:303:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:46:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:46:51 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Thread-Topic: [PATCH] iommufd: Fix return value of iommufd_fault_fops_write()
Thread-Index: AQHcv/KFDD2z8fgVjkGhUt2wlkTQsbXIRRYQ
Date: Tue, 31 Mar 2026 07:46:51 +0000
Message-ID: <BN9PR11MB5276F4A90BA662066CF4A64D8C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260330030755.12856-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260330030755.12856-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB7150:EE_
x-ms-office365-filtering-correlation-id: c351a230-9fd1-4933-12e5-08de8ef9ac1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: eeYv3fmV8EIPxyochqrvoC7X6EYoXAROwIvtBfo8tuMtOrON6ykmFJyoD/inCP13LmtfSoQ659zbU1a0HBPGVMPqFsTruYmC+1opkP8oCTODDWYsGRT8N6SYwR7xYlZ3Hj4B/xcHzX+Vg05bCkT6jNqIG0j7EnqOjJXsyGjrZ4+/lJLpPymllwpZluVwc+4anTWO9RFTUzSVRNIghVIW5Q1qwBMiklYcML/FtyINn9XfCefzIXX2LUFa0JdmIb5eGArlrxTQOOlwmHArN78jKZ0iGj/xz8T5591yQ1o74UA+fIsS6cVnQkPHWtXXVtnfywt0pO7abE/NezPHZNcztN5fGrI7Un6NwmmACZdIQMwITDyr0r4D1ye7McfvZH8pHQccDiXehyTEPF8ywz4eHwn5unkid2xpv5aNLHbOPUUy6xdizohm8ozSgVu0936BiXnVRF1kFiPnbf8bkEnT2CACnEXUn0aLmWGrUrg4X3dBgwqSmroRVWf6JkpU/sPVhRbaAXfYe9QXRvjTV2HCEdOxd4u/9Tj6PAAyBc0dX+NDJdWLebK50s/R0VenUOcVfe79roLzJ8kZrLIOWge5aK1Qg02BE1aH3XSFXW/XrTyJcCM5cPSz/1sxhmoL3l1Dc4ltvXFYOFzts8bZ/D4r77zsRWnPqTF/T/Po3wTSTdiA/8IZ+hOV1OjZ5pPbs05TIYJWvejyCQDz2R5vcMF+4qcMzgeb0H8LoSUC0uCL4wei5FREdVLyTVIduq2L8zCYayk1BPp6f1iJO03LbU4UvmxmtrHoSdl7C8JbskeqO9c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kIhZq8rBupH+ZtNLOWLHjkBgAu+qWXKA+SD38G/5rq4kl9ojtnfFfCm83CZa?=
 =?us-ascii?Q?twPXEIhHTCFUkF39v+L0WbPRsy/OuGhi/8fSqBzdXqO4aeLNB8iXFbC7Ublc?=
 =?us-ascii?Q?ONre77kS+evitgu4ei+6eNNDTqhK+2HM8SNi0l3LLf6A2doAa83QTQ8ZMqt1?=
 =?us-ascii?Q?A+K4CuVEQ5aaabUpBVUKlSGe3yw1Ojr+hWwo5+edxsHOG4+6wploKJydTerS?=
 =?us-ascii?Q?AnHSo+Riz2ExAcjTGtTFE5mJqvWaRtmlYZrlPlSEDVKUF7Mp6em4q5SS6NoW?=
 =?us-ascii?Q?lUtxpjtqGx70zpBPGd51VFNuA3iPTgb7NLkUe4l+uOcyH/NXavJUuopJeCEi?=
 =?us-ascii?Q?/+pcHiwwVuDbY6Yo6K7lsfV3NiCSNssATSrh4qGLsUlMWM41FP4gyhXmgcI2?=
 =?us-ascii?Q?XwZ95HYy0z4z8X6YFakNmJxfoPJFaMzB2w3rA7cx3C+kPKbaQqoB1wQ/s8FE?=
 =?us-ascii?Q?gXjlF7FpQ3+cEd1y0MIwpxn2UqdJFJkjh2YTlhOzflk/cSNhaqjMkvPVzyrg?=
 =?us-ascii?Q?xtMVTuDkMZsz3w+BIlbsIuYIrWZE37G9NDccm1Gs4pp4U9iMfTDSYw9MSo1C?=
 =?us-ascii?Q?RGd7qC6pGZoFWxUsakoRGEF1J3fhe6JqfFjznZQ0V7NIr+SbMeBYASHFgSq6?=
 =?us-ascii?Q?M7gt56Qtmmq9vs6W3w3hbbzGPz4FHYSfoBIfI+jj8w6XFW43+8B1NHMmy5y9?=
 =?us-ascii?Q?hgVf2ds00ciRbG6mnncM09FKTxYt4L2K8E2S+tdUIbjLK0vyLFJCUB8hMcHN?=
 =?us-ascii?Q?oGIWEusMWeHugQCj0RMJ5OI1Pg8W2dKDGclr2Q/X/fN+vjlfhfTLliXfiSRz?=
 =?us-ascii?Q?/R/23usIYXdv57wGpkMcIXwwXXwcs7cXVifcP+Ip2WXmoGmkXC+4/kf2V0f3?=
 =?us-ascii?Q?AyNOQUg49vzk/ogcNTQYjwBGY5uKe3Eq+yc9PwZt7XYpW7Bz4hHWy5KFN8DT?=
 =?us-ascii?Q?nQk7yHmqiOx5to+AC1AwuESHAcU57UW3dUQv1SiCmDfYyqdMnyO5Wy9/f7e9?=
 =?us-ascii?Q?QrAryVB6wCWsw3XdJq0U+mYIUEAIifp5/ntc8oiXXGi9JzOc/50eoNJqEEb1?=
 =?us-ascii?Q?CEajNBRQXCNO9r3nV7oQRFdaaGXXm6ri9UI6O+1dnK+1lqV4Xe4yRs1voTNQ?=
 =?us-ascii?Q?72QqH3kFhCxJsuzJiNWTRMEmrAeEhr11XeWv8lHqptdn+sX7f3pzTLA2jl83?=
 =?us-ascii?Q?ma1f1ctGLrReRKybRaHqkkhj0I5IYys6XJySOVp1H8lsGHq0q3gtThRGWXHy?=
 =?us-ascii?Q?+W+ytrcBwAPOOrmVcVm/eiZi0r//jT250PzWExuUNBqKYb+7r9ndjdgTAQxe?=
 =?us-ascii?Q?eGnbM28z8JIwEXvKbL87UZTQVHHarcGGsTtfOJYMM4CtcUbbuNYw+zTDk2Xj?=
 =?us-ascii?Q?Wse9D1JL9dVW4KxfjkuTNg8SYlLMqgFrhJ2rimWIRNWw/xd6fWz2ufrI0tqN?=
 =?us-ascii?Q?R7stU4vA7UeKSiXfRNNvb7LPPYBEbTfFdIb8sDz6OdYJcVUkbgzhG4KH8p/z?=
 =?us-ascii?Q?cFCkhZ6ZrnYpNOhsUYoOJdu+EMQcGOyt1ccEDg7q2rpxSKOwQKStO01DOuDw?=
 =?us-ascii?Q?jF/vUIEZJgr1lF3ZSD4+OBsaWVpN0qROqmAyaB5PmdhI4/4H11hqWvWNcrCv?=
 =?us-ascii?Q?M2vNu5j04jVOLs4S79xQv7gJd37YiCmyguscPYxXhE0wcokDBiqWA/b8fdVK?=
 =?us-ascii?Q?1bZsoUQMsiR3K8+vyK4qwxRKG5aIm86A7hTdODXVrE/roGYJvhXwxwKfyWec?=
 =?us-ascii?Q?5PLhQvEecg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UiBYGkZ17FfCwmXBtw5ccHk0OTCfaoBCQAxs8EkmwnpDDARj88aghqd/QqfPkUfdKJdiGigH/ZS/rJi+aNbjWpR/j+7hICcLNTQUVGXrlERUPtmCncxZzoQ4yDcOmUI4qe2PT0164oQCThlJDnZvcMDH3DE0qKVCIhhRxCExfeY4w0eNoZfSr7q5oNUgGNrtEejSQwPI8I+hcwNnOAtl57Jo+KTuUXgKgoTkaarGX7hsbPhMiWD/E4oCVe6VG6GNk4s5ZrodUBR1YpIXH5A3SqKV15/s5cEPsW8rcVxEexQzFCXmOWBAuQp1Jd7cXlamU5H7So0lQviEzeHOniaBsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c351a230-9fd1-4933-12e5-08de8ef9ac1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:46:51.8655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l1le5h6pF6zdDZQ8JGrNBWngWWurIta7JEFDr3hfOGDGa8u2SOrWNpl+nZ+bPBoRRMHQ2ahacZgnjmpk1v0B4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7150
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Monday, March 30, 2026 11:08 AM
>=20
> copy_from_user() may return number of bytes failed to copy, we should
> not pass over this number to user space to cheat that write() succeed.
> Instead, -EFAULT should be returned.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
