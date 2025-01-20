Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAC7DA82
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737351444; cv=fail; b=R2qma2i32ZWoXl/txf3XbAlRgaWqML8JknyDPvss5fGHrobF+rFVy4EeybC9BjQ79ynJLehvPe8C2QBxuVZbtjTioHkH9lmo6WJv495xTFuyHieutZmJ33ty4NTS0zlKPgf+lJ/+Re6U+DotdwvJV064uKgGOMNVajNOoOg9ISU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737351444; c=relaxed/simple;
	bh=rfAsebfLH8Vu9aDCgYwvtoithvCV+K7mXoE7tWYjXuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hLWyodx60sckG5hTbyj5/QMr/YiDla8/urNck7kKUzX1gQs1tZvt4sHG1GvrRZ+Y4Mq44d0ZLWkPIxGETSTCTpVousbV8dM84d0jBL7M4CQ97Jl97ETg//kEls4R0s1cpWXuEVHLibOHC+uPT5XH8F+g0srQlgrC4TLm0WdLgkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ed2NguCF; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ed2NguCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737351443; x=1768887443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rfAsebfLH8Vu9aDCgYwvtoithvCV+K7mXoE7tWYjXuk=;
  b=Ed2NguCFSr6K4V+ItCSVuNKs76LcW7b0IPhYNbuF72nKn/q5FxO0zvRh
   X1ysrbEUpLZSBDEgUUKHWlwnNNnhj8OMos4T9/XJ1/k/EX/iVIdBz0Roy
   PyAIrN2PuEtOaFgoL0uAexDjOVxU3Oa6khKhfPYlUKtki6uwbRzYFUgQv
   a1qspDd0rigrpRi9tXlnPKsjQw1V08vou9a86VcoIO4MBJngFAUFQpbQO
   HsTLqyBtaoGEbpnRaRwObxgSnF6JRKVNxBWBmTAjZX3G9ZdCVp0jynA0t
   zR/RQ4TX1lir+gz08jT4pwFZ2rN940qDeQptPTZ4EEMIiOWW9mVTDe5rJ
   g==;
X-CSE-ConnectionGUID: H8WLWRsLQT+Um/9AxpmJvw==
X-CSE-MsgGUID: R2UlsneYQEKe+czHH1pjQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="48301631"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="48301631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 21:37:22 -0800
X-CSE-ConnectionGUID: pjX82p8yRtay2FRtiJ8Gjw==
X-CSE-MsgGUID: BnNVUSlbSia4YBuFgH5p9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="111362434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Jan 2025 21:37:22 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 19 Jan 2025 21:37:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 19 Jan 2025 21:37:21 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 19 Jan 2025 21:37:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAet2qIOk8Z8ZjbXA+RjZPQu/lW+b/REV9NVjypGH7KpWpej2VaUw4nTGK/Q651hSy1PzrYPP816uAZzaK7Lx5cPCO3fGpK0fzOkpkGbVRaBRQTdKhpALqz2Sw6eyruof75gHALNUlxvEgl6YX4s0SaTTeItoIlhICsFXfFWe7kz/W4jbCaDmVR8tDdotYi9PyxSPacvIy0TxkH50oCm17z1Ca49f1QNs+Ih7hrvElheBoX09JDDadqB+/CdvAnroK07H4D9JoYa0GEZWEI9Ugcgs3ielIjXIL5V7auXYxag4BrZo20RFJT5DbH1MXxzX15JeZDGjV819w2R8kr/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5vgdKaVxZVMxDJp5Pr8+1GrGgQ2EiKOZrOvMHMH+6w=;
 b=lR01cPBgux+z2ts70WyPt2UWCVeSt9oPYmGZMsC7gzKjC02b75koMiwkUYR1o/Cx2JNz08wmJrnfehq4jgaYk+W3WkQyoNshcIBhvAKGTSz/teXaiOY7AShLppAdXk4F5Vt81S+LnI2ta+aV0GKp5UG/nYyc29gY4CI4YZuAmMlIbAj2qW0GGhs2TsgT1TUgo6sQ3aBK8VlOVGklot3dktgtyMrBsT1wldwOqMGn/ERgdObjtWANMh44WLOziXszylw+QJ8QQtAP+iMPrfWDgk2NHN3m7iZxVNblzbqfrdioght/jkdAWwFbIbk38bf/gZO+kRDU3U8wKn16yscfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5075.namprd11.prod.outlook.com (2603:10b6:303:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 05:37:13 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 05:37:13 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Topic: [PATCH rc v4] iommufd/fault: Use a separate spinlock to protect
 fault->deliver list
Thread-Index: AQHbaRYveYJZ4GUvMEO/7u4k7dDKFLMfJ6ng
Date: Mon, 20 Jan 2025 05:37:13 +0000
Message-ID: <BN9PR11MB5276FEBFFEACE603E45517898CE72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250117192901.79491-1-nicolinc@nvidia.com>
In-Reply-To: <20250117192901.79491-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5075:EE_
x-ms-office365-filtering-correlation-id: 89f8a4bd-31ff-47d8-1e4f-08dd39147e17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?B+FqfGVguECUIUJibhf7LTYLllbUzXJKIlBciwzXdZ0zGIugu1fZv0GNGAwg?=
 =?us-ascii?Q?Ako7IEqpaHZHDj0BlbPhs+KxcMy6E0gY25mkjhKC6/Tz09HrIKQKWdOJ0nJM?=
 =?us-ascii?Q?UAim/naGvVj4yqgEVVEpp0DvAsPMT2pZuKQRELtJZHkDu5Pellf4GxA4SgEc?=
 =?us-ascii?Q?+W/08tHVTAL/LueqwI1UkkhkVQVwRdhP1TZb+8sOtSrbNlBe2pLvxfzwvtpy?=
 =?us-ascii?Q?0DUE37Iisfplr8UfaMRXEBOmoDQXLe8kfpEO0799K/lFcHF+vR1RnM39G552?=
 =?us-ascii?Q?Oixiw5vQg2vEnd8U+ZkwKOn5IqlBVY3rUq7bvTu7NmDm8ilnOF2fLrOaGHZO?=
 =?us-ascii?Q?4a1f3aOue3NLmEwNGnnOzLC44NA8kZ8P3Yk0HzQ7u0pTqCmRsivlyOqLebjh?=
 =?us-ascii?Q?FFrdLkrsmC77B5npegyQ998TNFu5AhJDb4oLgHAwgDZAn5ciE1TL7cbnBdnh?=
 =?us-ascii?Q?kYDCG6xlrMB59FtbDq11CwX5r3wlOE9nT0s6qduFaqifRv5SBk3zr414qDXp?=
 =?us-ascii?Q?Gve8FZYa9/UP9e6si+qf7GSaMOA4J1FAAEovb0xkSZEi5oCmP++DxDjxXxeC?=
 =?us-ascii?Q?vAyKe1gGjUFoPM9j8gm0CKM8wF2YOwKu8ErsIE9pyMDNjyjzK8nuFSS2t6Uy?=
 =?us-ascii?Q?fE3Krd4Y5ABsKLny4pMhRYMksK70wvq+7mmDDSXsg4bl/XmWlZPzTATFapzC?=
 =?us-ascii?Q?BFOAeWGQxdHksNgzGLVxGUuj8DpfXum6ZAW0jwC73CMPmdeC/D0aJo09VDrZ?=
 =?us-ascii?Q?SVsqVIWNVPiqAbXF2gIm9yhL30JMxheWp27/e2i2O21p1vyV0tUgpqY37UOK?=
 =?us-ascii?Q?pTLMZkxTZoIOLWUK2FagM279sTTem2wLKF1ZS4r2eELh79s7u0YakQDE92UC?=
 =?us-ascii?Q?CQuUuU1gl3qCChZBo8AhESJuvE6E6KVUHbQOyr4PxXfAb5EQdqDFGjVgiZF3?=
 =?us-ascii?Q?FR3Mna0C3miNr/os754OiuSFK/kaeQia0JKMEGwVvNK1SNYdYf4u2KUNHiqL?=
 =?us-ascii?Q?NtkH9MuSnUKrcgbekdaBffLpe1y6RHXoRr3EmPZ3iO/WH7u2KzkCxuL02jb3?=
 =?us-ascii?Q?4pEx2eTI/MWD/xtr7alXnDXF69TPpxe1gUt/bpqY18C9RqYGBOK7FO18+Gm7?=
 =?us-ascii?Q?jCPq2YpodABiPzXAwrDNSZ6YnN3mJTGAQmap3Q9dUgrfDCx4GpXtTqSRKK9t?=
 =?us-ascii?Q?YdSgCh2w7dge+WKX2eGr4pV230oYCGVvzAfUcUGkRHy+OnBv54nlk+b2oR9u?=
 =?us-ascii?Q?6eH66NMyeHC1/GY+v2kAXAX14+FnhNRSHFPX686SSRdKgLci7BdEZ3ryp6kk?=
 =?us-ascii?Q?nxwpBFaZg7S/a/w1wxTx9rOf2IScbQx/HQiB5PkKM3MKuHNN7mxICPiiJohI?=
 =?us-ascii?Q?ZhbzRAz+9BQmWscmkMXMwkzeXDgvHmu8IerjlQSlAfoA2c6itsdpWwqU963s?=
 =?us-ascii?Q?Lgzc7aN94FLThNfy+BIMdO+/h4XAqmxB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cgI+5SzHcE8NT+nrV6iJ1erJ+ZPbcfB4iK2SoQTGOJTtuL7I9GOKqmRbmSMe?=
 =?us-ascii?Q?0Oq4szKfTL8QnlXQ7hAs7PTCjalBuTCqvCNAodGMlsHH57gzSBtZYer6whX5?=
 =?us-ascii?Q?erJNYWBpk9XwGOT2Wv1zG+24ReMxkEgmbATxRJZftG77XdDkNxzMhGbRrC9Z?=
 =?us-ascii?Q?qjrZDB+Kz7xVAZUgI/iyF1gF5PBfSHo49Lu029kgYc3YPSWI5GogeUlNYcVl?=
 =?us-ascii?Q?0XxO0sBVAWNvQSksj1B1keNLVpHCGJQ6YdRl5jQxQ5qD7TzXMksZ+32ReZKb?=
 =?us-ascii?Q?5R2CC3DcHblC5Dz98IOcT3GBaHVKdf64mHCOHcCisWjSwf8+l/z8XxUplXvf?=
 =?us-ascii?Q?BkJ8YLVjGhPYQ3cRJAkm+S9A1wwvRnwwRG03KLcHZdlj5mpRAmPgTK6NnEmf?=
 =?us-ascii?Q?tKb49Hx/NS/ONP9K1sMD2clzNf4Pz19w5ueKZCyu/cpe5NBrG+E0qeH4d1Pq?=
 =?us-ascii?Q?33BTOoXljjWasSMwi+dYjEIDYe/xuz5z4pw3QYNjqdxZ5Zma+A4ZcGvwhTM+?=
 =?us-ascii?Q?4JpovdrPEdnpzKAbEimt/RZOaik6mxwLim4ZfMthpOk1NS/V5NkTWm3+jiGh?=
 =?us-ascii?Q?JF6s7VljEGwdT3tmgkKJpQilWq/jQgv84WZuF5+NqrBNC5jXI9d80IZpzsWC?=
 =?us-ascii?Q?maxUfoxfyDV8MlSYv1y+Oy/iH3CMITmb5wncamrzNYhz8wWvTu9plpGEXhan?=
 =?us-ascii?Q?jF7YFqgZbFNXPJ3lz2nARLntcAiVIQTkWG1pYUDqJUH+CZUSjlgfZYhOQb22?=
 =?us-ascii?Q?2rcRw4vgKAROseIr13NdcgXVdNK/9O8Ob3Dn/cZmin8hj3wpXoHd+7VDrd9x?=
 =?us-ascii?Q?re3PTZEkP6DwtXwq4mlW4uP+Vc0NF+OOYj1FEHxDLf1idS3Tbn5Baw1adh62?=
 =?us-ascii?Q?0g7rgBMg2OqFOjcE8Rbtq7e42Qcg5soh/UY271u0dDMfLAe7sJd8VCrGp4vJ?=
 =?us-ascii?Q?rV1/vGZaRJuCQetDrCs15aXPEqB4SDI2tFwqfr/nHcXH8IixaOFs4fJrk+bs?=
 =?us-ascii?Q?VIwDZAzqfh3wZiuvaOKX+xWAfaxMkkTw5ulwM+0W+Ppc7ZZPsfx2BfzfzIhY?=
 =?us-ascii?Q?FporvLt2XyWFxuRwr9KZ6slYj4IUFKE+QFpsguaxfoeaL1ImgaYpA/OF+v5O?=
 =?us-ascii?Q?+Leq6tAoZSKHF9sFGkIGCmLLTCyYh74qxAxtraVeAyFoZBU08DBHT1oIAS1l?=
 =?us-ascii?Q?olS+MqIMOX6VTttU12O2TI3LlQIhj4fqOVvdIJ45Gtj2ywTEUUXmlziOpEA7?=
 =?us-ascii?Q?Yc7ckwVbvRPnBbSI5EdG8L+DQ1e7w/hloUPMs6Qcodaqo0/rUgAtrq2q3HFH?=
 =?us-ascii?Q?XSG9WoKhIXZtIg484A5zQoBcgtTfykrh/aj2lFAzXm/NfmjNb6+ozWFsAxhi?=
 =?us-ascii?Q?G4Ss5hTr/NVwWqcdXr2QMnMEdFvEVc9911GWfkY9aoN8802Gu7QnAvJFFsM/?=
 =?us-ascii?Q?FfIeXjc9FdSnuhzaYK7RbClmT1yc9/n6LatE4gpIGL9gpwoyK4vbRqtq3a5X?=
 =?us-ascii?Q?0NhlUHpNLbJyFZ6cgxgcvC/8kUJt85Eks7mJwbdrhZamXLDn1mmoHf4f2Z1g?=
 =?us-ascii?Q?nBxUohhY77+s1FvyzgTBeCubRS26hL8QJ4G7ZxrU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f8a4bd-31ff-47d8-1e4f-08dd39147e17
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 05:37:13.3636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10tRbt96ZNqU20ySGmdcVuOBVA70r+ZuiWkUk3FIN09dBt0cTo/7v79JjbUNjDvsx15fP8rjElBHmjHTMZpeHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5075
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, January 18, 2025 3:29 AM
>=20
>=20
> Lastly, move the mutex closer to the response in the fault structure,
> and update its kdoc accordingly.

Then this comment is stale.

>=20
> -	/* The lists of outstanding faults protected by below mutex. */
> -	struct mutex mutex;
> +	spinlock_t lock; /* protects the deliver list */
>  	struct list_head deliver;
> +	struct mutex mutex; /* serializes response flows */
>  	struct xarray response;
>=20

And the comment for the mutex should be restored.
