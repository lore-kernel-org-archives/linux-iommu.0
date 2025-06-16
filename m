Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5D8F5E
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750051203; cv=fail; b=P0fVZjgBVM3QCyXKGWmLv4Gc8kCxJy+eprhItGU1bXW4Rsfrlp6h4RblKVS6MT4wEmL+7wK9BUJSs3V8c8cMvHu8TG1d/XvZsyVH0bJ1hSZlxxzqaXAAPUk2c3yMU+kbtrLhSnpKhp4Ef/06405x9ZtEmt52cdS9sTmNEx8mJpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750051203; c=relaxed/simple;
	bh=u/TiqiPIdYePnK7UyqdNYqIGtl3MlO05sV67MIvUuqQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z/nkduEd8dqQ16jGSBcoMIHE8+xVBxrWXYHdGVKjX538VYbwNSREX8IhwYEqj7JlXN/znrcJX0wxLvaM0dNysoBnTh+jsBNc6Uf2Aqqmgw1X++GcnGCubbnMNTzJt8qrVh+nyLvQYX1e/ieY14959GCR9eALffoR/2TIXJ7hMl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nh+ytONk; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nh+ytONk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750051202; x=1781587202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u/TiqiPIdYePnK7UyqdNYqIGtl3MlO05sV67MIvUuqQ=;
  b=nh+ytONk95ctnzmMuG6hqZFfGSxazKtL6q2bJbog4c7qK5M1LTDz+A9h
   ai7WOgehCouoVd4y5vs1mDsYv5qHPr2r2o194iFqgJQQ4I7FmALvYpnZr
   KTfyOtx3jvf/IsW4crMwa4HWTkNDPJRICFM49Wx5dWSoy3X4ESfXii1DK
   j908F6fZXE6kl5gs7TYkELHhycovMrmcDkr47MEVz7Wp5FF4xeQqZLh8z
   kHSgaRrW5AKuEEmlpnLx7mcviq2dOJZWapum7fIZ48UogYR103E4/9hb5
   jJ/LQVGe2qObX4i88/MHXxPqKs8KSyIF7Sh0z6Bx+dAWok79pD5J3PDkS
   g==;
X-CSE-ConnectionGUID: D2oFwYM1QGyfav9/Ehvjug==
X-CSE-MsgGUID: UXPLMgsGS1a8zHeuIrFp0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="55983918"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="55983918"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:20:01 -0700
X-CSE-ConnectionGUID: pkN5QP0sSA2vC+lVAqKpRQ==
X-CSE-MsgGUID: 6LcRZ8M8TxOSP23nIIyGRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="153518601"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 22:20:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:19:59 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 15 Jun 2025 22:19:59 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 15 Jun 2025 22:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQcKD9o/O5OBPFbokd7I6KPHlY5yCWqJ/O3nWB7n4szLa1BQesAcoFlpxWvOVlE6p7csORELzBBN5bg1JdyRvpes5ipTGmAdmfLf6MFBo5m0IUOHknHg23gsI+u/1JFT30vkrg/Dc9BXR0wgPRSG4mL04JBBxLQD1u+DweDbFTx/Bidu2fIjx0aI9qQqfTLkaJh0TSAdU6ccm55KpiUoFassxKMD0hV+Q14kKsXOOpBhg0bJilXkppX0asYDJSBnq30g6CULDf8yxP1loDm9ONNjvcwu0SRxO4uLJPl2OfQEn40SzOWLOZVCc6BD98M9K+m9NkQg3ispaP0yW6ShEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/TiqiPIdYePnK7UyqdNYqIGtl3MlO05sV67MIvUuqQ=;
 b=nakWufZJhMjTVvh+95NQMOcwecd7T7MwcQM9j/j5mbxC2m0LjdtzLk+E9qmPa3jQGQqXq9K8FHQSxNvMMHoYaem3JE2OWdNt0/9IYO43CBhzWIJxKnanof49/lf3hy0Tx8VpzIVoF/z8AKQRB0mZlm8d9sryio6oEPgXBVdeXTx+Hj8epnr5jVobCIfTsX+FDpk/UYf8XP6eH4oEKNYTGXTNYv+XNGaPhoJvJehzF5IDkXRfMBdu1hfHPdflJHbRKuS8xkSTNTg41GL1VCvGMDxMMTlDwH84eDeA2n3C2jjNNyaxY2DRUY6fVOysnaB7gFj3BeALEVlWaJJ19CQY7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8528.namprd11.prod.outlook.com (2603:10b6:510:2fd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 05:19:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 05:19:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgACgJoCAAOcYcIAAW7EAgAQ39wA=
Date: Mon, 16 Jun 2025 05:19:42 +0000
Message-ID: <BN9PR11MB52765E4F52B2428307214D5C8C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
 <BN9PR11MB527606182417BB7A35349F598C74A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250612172645.GA1011960@ziepe.ca>
 <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca>
In-Reply-To: <20250613124202.GD1130869@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8528:EE_
x-ms-office365-filtering-correlation-id: aff881e3-eedc-469b-da81-08ddac95667e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?FYqX2j1rb0trNtuhL0et9PpBE4aTL+zbpQNbLKO8ACT6qQALFIs7MioPXOIo?=
 =?us-ascii?Q?sSJ8a14fQrcV4gXf4sIEBCJYLLCyBo+L9i97fqt7E/oqmR7nlbjRLSUL4MXd?=
 =?us-ascii?Q?f9TxvUMHkN7hN3MPW7JaHlkxu5xzuLHvEJO1t4GVMuEq+0uUHeoZ6RIqjdPu?=
 =?us-ascii?Q?IlzhWUpBxKxqZWieG0YRDxXvdhjI2A1Q/aa4YwiMOBRkZY4Qw05smg83KA6a?=
 =?us-ascii?Q?SMUCh66Zy5ky+3JG1wQsSB53ei/FGk5whY+BnKdT45USHwSyhkUtQxtrVrYl?=
 =?us-ascii?Q?uez4GFk/2fRc7K9ODjTSZLe0HUh4QtFdHAS0EKMEB/6cJx+X6w8KW0VK37hZ?=
 =?us-ascii?Q?9oQZVYCWxfKn05ZL3hUDSO5+86L9y7FotOqjFAmXZLhOabYK3LkzCJEClZn/?=
 =?us-ascii?Q?avrjdg0oE9lVlFvhEznfHCPMRF76rWlS9ketVWPxVaFiqeifpL0PjC46VGue?=
 =?us-ascii?Q?0RNIJ/xXjEzbi9PXu/ktzRB2ROI0qXmRVgpOmRUSaCeXYIcMePA7PTcberVt?=
 =?us-ascii?Q?XSjm8Yq3HJ9HuBBl0i4C3YFLJX0rY5lNwTSCPkUK8z4T6XqHqZeQeS0GWmgt?=
 =?us-ascii?Q?QpTikl6xMpb4FFv54e8xnQoL79PdqrKIs8Z3AwzI4HGdfYc9LP9sDJ03Qd79?=
 =?us-ascii?Q?FYsYORp2TuIRKIofZDtf6/LpjLjgGq2CWOttWy8l4wsVO3vwHXOIwfU+j9bt?=
 =?us-ascii?Q?bQGmYGA6m/mSC4TQC8xWr9SGn51GCYyqBWfnyXWdvOFrXUU6Na9tRUr2RpaO?=
 =?us-ascii?Q?D/a9CHL/kOlWwzOM2flH9HZuu6oug14ICU5kfPRxsNDrFY/89S3Ejq76pdrS?=
 =?us-ascii?Q?IaXjC7uK0VUcUcSplugi0YnOIFQKvKULzNE043iSzwgAeVU9v43zXH2cJo9g?=
 =?us-ascii?Q?9430rWqblMtCdyh+0e4IP3b8Hz0FvUnv2mYJXVC+7QISLPZlCOkhbh+7QAs2?=
 =?us-ascii?Q?MQujAjZnij0G578cVBYPp4W9xzsfw1HecAzf2PqTtvDs0I2ijiIykRLHEngv?=
 =?us-ascii?Q?17x35ZdIRTKoNmbiWfLDHEJXvaQCpwSwetMgnMwPqbEuQoOZapmAiJzUbWhV?=
 =?us-ascii?Q?e90uMfUYUSJeR//pw55jU4S4/RGxdg52rCJJAfovGpfiWl/T5oIe+mUtivnr?=
 =?us-ascii?Q?fXwoHLHrtjt5jSufoOytoMQa/2fmxgNaYt2ggxhm+0El7lVV478j/0+J0tTF?=
 =?us-ascii?Q?7aJl7FYaHyzg3lFXDFz32kcDZNAQZLm39flS/1Z5MT6SQ84k+0kmpuFnhQLf?=
 =?us-ascii?Q?43KYveL49JUfJFUEF2zwaRGLegXGamBbUvC9ZXwh8LKue/EnydTHzOtVaV/x?=
 =?us-ascii?Q?efusCvWzI5q3B2U5Et6GNt1bBIoIHrBlmrLpna/JKmUwnC7aZbcvwhB6fQaJ?=
 =?us-ascii?Q?5Q/wo3j8mVdCGI0vZey63luCxxJxX2LG/283wF1o36rVIOZJUVF7HcHNSRRz?=
 =?us-ascii?Q?W90LDyFmYqis0e6qnDLx213VK63hM+MZzHTJJ03xumXwz5Ufpm9Sjg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?61t04W9lZaTzwbGP7mjJUeDR3rG/s+iNE/O9RZ3vUmTL8PEPjURZkC8bovsU?=
 =?us-ascii?Q?x6Q6JNbVKRPlXweHItMNFn90HAdFN+tQLNMDsbyf7XU1aYs3IsF5QQVCgd7F?=
 =?us-ascii?Q?eylJXDhLupWdNvW2FHG5Ez/qi67dxoBv610b0JtcLbx0kdxmlgdG7mDExMRe?=
 =?us-ascii?Q?Nhlp2s7BvAExaqOK6mwGw1ctmwJhsfQ8rnrumuYEOgX1wzWG9b5F924FZlhJ?=
 =?us-ascii?Q?UMAjcK9OWVW51L3OhNxJ1XfYmkzvJymNxrDlh8alKFBa8vgUHtmHWO4XByod?=
 =?us-ascii?Q?whiDyJvVUJIp3ZgVPkCh1FSPfHp1P7ZPMN0DIAnM3u5KxWdYrFqwan0TV19x?=
 =?us-ascii?Q?COWv3y2XzuDKKSwdj53Dpf2NAtnrS6y1BirQsHQBs0/ARLnY2zxqxVVBZ6VP?=
 =?us-ascii?Q?FMu2bMYkT5uJpwG7qoMV/CpF+75oX8LCGCAsFD4uA2NzJ3dvNvUK0LrXYhc3?=
 =?us-ascii?Q?uO/6yXKWLZZ0CJ29Q7uF1iDNjm2+a3GWEkKHEypzoQRRLmIHPCXR7COs1aSz?=
 =?us-ascii?Q?j/3v+Bvjsq4916DAuej8jdcP0SF8Tt4P0TLLWUUORUHDSdRYU0r/+0RoFR64?=
 =?us-ascii?Q?uNw1PdsDFmXmuginZxyIXk1i+X6tlmsaZKqLI+xkhCYzh6sVPVvOrPiEkW3a?=
 =?us-ascii?Q?D+3eD5CCzI8CnrPYD7GU+ze0tl45zjkPjaZJgQQoARhLg+rkT6Nnofr0SBG4?=
 =?us-ascii?Q?GA0eD7KpWRQYMNfdxbKVPUwRCV222vXKVtb117VZjo0/w8j0AYs7xzWbVHVI?=
 =?us-ascii?Q?3DXTjDmxxnKHnAMcdp1KVsTqDba7ajCDs7kyi/CzamzKtqHB2Upt23IyU9gb?=
 =?us-ascii?Q?ZxydsPf2IIja9qufax352+Ja6e6jYVN5gN8iHMIgg50BqxPgsnDYvS4Rihjd?=
 =?us-ascii?Q?USrA3fryHWaW5bJoB03CmMfeQcClTq3H5Ked6aZgD+ZEFxdC1AVZGCkqbdcY?=
 =?us-ascii?Q?OH76CIvv4/4gAxIynnR8uzQQmlGAcXccIW/gYMDb8lmGAxOamdiRHj2D3XfV?=
 =?us-ascii?Q?a5JaLttD0/kuuUk6H0EDjmrHqyLVKPynRUezXfR1qHfiiN1XLnHt2HRTPQ4h?=
 =?us-ascii?Q?JmuKSWHkt9gWnrMkJlRvqiuTBb0mtIi3WLTkkg2xh4+eBV7hN4ssn6MYk5yg?=
 =?us-ascii?Q?v2XwUB7X2MJWEIKI2yQoXd2paFYSvG8Z6I3SzCFeAmXv8BCx7adkuEEyZpSU?=
 =?us-ascii?Q?ceLoBjnmK6xPm+ptQKFcDVtDTk8fyx8SetVbS9Vcoi2RCYS1autzZmfD1WRe?=
 =?us-ascii?Q?usM0pRavLE3DN9sum/xMoWb+KcB0v6vnR/k6MBG6jL76KZXjSpZ4k8JAnPFf?=
 =?us-ascii?Q?zIbVZP8/VvaPAvdH/jAfHtaGA6lTgDl9C8Rb9SLE7+og0bRJjZIwLb7rky8q?=
 =?us-ascii?Q?0yLuKOa2HchFbNv/YNXWPxIiaz/q0CEX1X49OI6pE82ZDCmI52qSsKOFe9Aq?=
 =?us-ascii?Q?CJxxi4FvSKUE1Zdzmk7eV3Q3UCnT+FKkQkrR2+tOQ66LskM54vJ8gb4Rkv+1?=
 =?us-ascii?Q?r/hsw1iyiwd+6UXEBkI+jGlF/BrPYl67n5vFpt5U+nmS0ggkQSnbz89n1kx/?=
 =?us-ascii?Q?U/u/2zzXI3cPpBq1Qho8jXDNndw9RMGb3GnFbZRU?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aff881e3-eedc-469b-da81-08ddac95667e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 05:19:42.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2Py7rA6CV2vW3RZo+f2QDjuf/xvF8UwVdgTDM9aV4SoJvNEB/LAyEJm96S65i0IoKp9FQmp8hIO8eXjRHDO6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8528
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Friday, June 13, 2025 8:42 PM
>=20
> On Fri, Jun 13, 2025 at 07:31:48AM +0000, Tian, Kevin wrote:
> > yeah that seems to be the option if the said life-cycle dependency
> > cannot be removed...
> >
> > conceptually it's still a bit unclean as the user needs to know that
> > the vdevice object is special after idevice is unbound i.e. it can only
> > be destroyed instead of supporting any other kind of operations.
>=20
> I would say userspace is somewhat malfunctioning if it destroys vfio
> before the vdevice. So the main aim here should be to contain the
> resulting mess, but still expect userspace to destroy the vdevice
> without a failure.
>=20
> > hmm if the user needs to build certain knowledge anyway can we
> > go one step further to state that the vdevice will be destroyed
> > automatically once its idevice is unbound so the user shouldn't
> > attempt to explicitly destroy it again after unbind?
>=20
> I would assume a malfunctioning userspace is probably going to destroy
> the vdevice explicitly. If it had proper knowledge it wouldn't have
> done this in the first place :)

Okay, that makes some sense, though I'm not sure how much gain
the tombstone state actually provides to a *malfunctioning'=20
userspace (vs. a destroy after unbind gets -ENOENT or wrongly affects
another object reusing the vdevice id, but still with the mess contained
within the context)...

btw do you expect the tombstone state applied to only vdevice or
being a generic concept to any userspace-created objects? If the
former we may need pay attention to future new objects which=20
create dependency on vdevice hence may need to inherit the
tombstone state. In that case certain mechanism might be required
to help detect miss of such state propagation.
