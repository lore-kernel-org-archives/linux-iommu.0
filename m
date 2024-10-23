Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E014D6ED
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729670524; cv=fail; b=ZBaVG+PZLKiJmWpRkTReQZcA8aLbo5kHAYUVykWL0EywOcU1IjeG5vViDXnf0Xdf/TigVmRM5ozOpTKOgHB51cMbyvrim6DLyNroEwP/6U1FLBmBPN27kst4zbHMIlmpOFL6PZxfaIGrCgD76Bz7enDHheze75aVM/fiTv+Lf6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729670524; c=relaxed/simple;
	bh=JZV7zN2xG38fG7ATAKvTs06tHbCv35wyrxZ44lvE6UQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HVn195/6hG6gIRuQVOIWN7Zdx4Vny0w+S7qITLGISXemi8RzYyrGloZ/Z6tBiPqhPRHpJzrlpauQBixWlSi+1080J7Sj0cdVEQIKVaGJgfNnXl8QTOvcmI2AC7MYCd8vSYUFFegs3+uZEtqjWthpB54e2/4uzbqKtee7JCs4Lq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+V4LYS4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+V4LYS4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729670523; x=1761206523;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZV7zN2xG38fG7ATAKvTs06tHbCv35wyrxZ44lvE6UQ=;
  b=l+V4LYS42CqLF129wV6Z5r5UZ649dY551xrdAms0BYHWUIqqi+0EQQcg
   VZnFCR5dOo+sFYnuk1Y4X7JWl+KOv+FgTJKYWLZvm2LfubpQJboqQxYK2
   olwKN5LFNY8087t/S84sXe6swl4e0iI92e/ak1Xc8wudw2XdpkulbilDE
   o/Gq4m2F2WWKXiWGVsZCXHd1rtLDAP9cXkKl4XG024ZdTLxSs5KUZbiqR
   9iWKiwXiMoGXd1a03fsujNTg6CYxdxWU8cYv/tDBftUOkvG/lxuo2uU8N
   zyLqvz6eZIwXRyKtUgGrcvsLEB0puAoNLIsLAgMmJfknIZw2GLGwja9XG
   g==;
X-CSE-ConnectionGUID: 2SJBt3QrSTKx7m7U65m04A==
X-CSE-MsgGUID: rcy2N3chT7mHh8f9HTPZKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40364634"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40364634"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:02:00 -0700
X-CSE-ConnectionGUID: Q/JFrgUJQVaJWf9DrT1xhw==
X-CSE-MsgGUID: q9cdsXL/TfGBkp849YKynw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80042351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 01:02:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 01:01:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 01:01:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 01:01:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSZQeg4eB5/WpS2Ctu3TAH1ozl2QswCzdEAzlPVnP2QFzBNwyGlClpfVnSAJFK9asTsEtPIsZSJiLKmFftjAoZWXlq5mfNeOKJI2g3esynvA2RUo1la7iXYawDOdO4npeU9oOULO3yjo9W6ve/9FWvi0S6xjslTt2FMBXEZ56eqT2usLM06k3UCT5foZWKZ1NKYHn/gLPWcBLzHYnFE6WvPmUaEYf/vbRzrFuLkNU2LSn5mVW0wA3ORlquxY9/j77Vz92Th6LpINXRQCBdq/BKKh1SmYVFm+O0fR4/5/yBHISvjbNIZb0kOrHod63bYMj7AjT/EwgGsuO8fBGk/0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIGwOxrHwsQ147gTgJ8JbZbjbyx9brxJg4z5Zc887S4=;
 b=yZAeheABEavqVCSAA+oBRPU+ujWMEe8uQjvgkGkJF4cgG56VPvCoAosb+6tU0dNOwqsi8g1r6OyxnFZBq3w/FdVLsaiJ65FlkDKCy3ULWhTiTqvkxUumakmzDXpIxOvgsdfLb5NTLaFUNuQfB9UbA+dpHvOKL9dK8DRYTjksDpkJVilnTKN1ZZy0VaCPagyCH4BLfBmPte7VFGXDL+5KD80gtw3mxPbXmsJGXZUHHMlppJ+0gprEF7tTKj/Pot1LhDD0CAevkKnFbET+QYfNGHXso5ciNizXajEvQ06VG5e4NcFW5C8d1MaVrh1wtThpiBmRGhADzOVsP7/f5VZ5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA0PR11MB4573.namprd11.prod.outlook.com (2603:10b6:806:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 08:01:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 08:01:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 8/9] iommufd: file mappings for mdev
Thread-Topic: [PATCH V5 8/9] iommufd: file mappings for mdev
Thread-Index: AQHbJMWdx7yi6EQXgkG+p1rWJZJEVLKT+RXw
Date: Wed, 23 Oct 2024 08:01:56 +0000
Message-ID: <BN9PR11MB5276E04633A8E0A3F877FFAB8C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-9-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1729630838-24586-9-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA0PR11MB4573:EE_
x-ms-office365-filtering-correlation-id: d2888459-55e6-4668-b8e0-08dcf338f6f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zxyj3h25OsI18usMBHcEfKQKt0Wp+FFg6TGTAWFLRRmk2kNCvsg65JvP6k6f?=
 =?us-ascii?Q?cie4D5GMqcOgfUg5D+7C4FUGMLfCEdfe8tbzif2XCT9a8D8IiD2thX5S12SD?=
 =?us-ascii?Q?cA8D6nl17P/7NwtMOPs/QMMmExBIKiqfmuwUEQcrxG3iLeK+ZqzVOBBnRFQZ?=
 =?us-ascii?Q?mhj5xVxknP3cWA9N7JdGtFOHkPoZzUs4wqJmbFYj/JxJHUJO3LIicnHGy6NA?=
 =?us-ascii?Q?UgbNFttDXw5BATYOF4aVQRUHHlHkWeuUX4uF8z7cSfOTQYCkcTe0KegmM1Gb?=
 =?us-ascii?Q?GBtRH7I2v/PHzBbzJzaJIcWoyqXStMo1jzgeIq6Ikxa93GO6wqvSlssbmQsW?=
 =?us-ascii?Q?2c7/JS5vPoZBpwN5jpR7OplQSSPqDkD0dRdnVsBrqJXq4OSQq29JNLBqvS3q?=
 =?us-ascii?Q?fD1xMqA5v7X87a200UDYGiVcRbETDSWUItKSkt5TxE4lxgeHO4cA6vDTDBeb?=
 =?us-ascii?Q?ckIqDjIOqN2c+H3siTdO+kg0xNP0MAI0fcR7I4PFhM6W+4fu+278y5gxtsfS?=
 =?us-ascii?Q?SAMkcbbhjZFIUaEGJ9SUyiOGyWTuUxP9EEjPE0mzjvsLgvL/MS6ZxS1nHcqv?=
 =?us-ascii?Q?Dbjn0psKnK3fVDx78XgjRIjRQBoTO2RzafzAx5NSXGwtYO+HAZ0B+HpeF1d1?=
 =?us-ascii?Q?BfteCyeHf1qeRz4FIQZVHR3/JAlkG8E8Zgt1pB/iv6SNLLTAtcpvRLDtCvKj?=
 =?us-ascii?Q?peGtGHeb9Q0B3cXrcmGFgAAFPGIwVJEXnh92aiNW1KjPXMf8+X0fSNGvhRtb?=
 =?us-ascii?Q?50MXVfY0N++seepoVkbTfV0KUZYL5J4fsfvOT7t6efpTYqn+PtTufMevOFlf?=
 =?us-ascii?Q?sS+U27thbgTWZfsgUWf/55TE92/m6fFdYlO+WT/w2E0sMD438irLVPTqsywT?=
 =?us-ascii?Q?a2GanWJCWJKwDFATebp5iZHvsP+FVeftGPeIsbTVqqVnAzoAQeVmSlfr5Ws5?=
 =?us-ascii?Q?P1eiGbFNZgmwD9YXgveWhsmphD+A7SsHu/nIEdi5krIREQRB+wvGkJ5nV+TB?=
 =?us-ascii?Q?mcHb3fGYOoYKViNlsj5rRHZcI91Uu03stQz2I/zXQKw+ycGZbIBrx1VA5kP1?=
 =?us-ascii?Q?tHiSWOiUl+lsawA1hNu1zF40+SXmzw0btZF4v7hBc6kWwJgNoTGZx0RJ9eF0?=
 =?us-ascii?Q?V4kRjjsn2i7JMayhkNP32nwIAFNGKYP/7Lxicchpc5IMMyu2thcwLBQ4PHNS?=
 =?us-ascii?Q?pcEDHio0uYt72FjjSFHKxHnjP5XlV57cniMXViWaqrYSlvXl8hM1BhTf7HYp?=
 =?us-ascii?Q?3FiCuOCD8qS0aiHwaXPAaFiNqEm4JvhZKhIiRs5w3Mlr2YlCk2oU1hKT9KDs?=
 =?us-ascii?Q?ju5D9Y0V1eZ+U+Ud9pGn8I6SY2BhHzjpxbBEozcKw9/YG18ZVXUcMu0xu7go?=
 =?us-ascii?Q?+Rvvc4w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9k5BOB0BwG7z0OMjuN4bA9UB80OiMU8+Br1+GHbzOAVqo9oD66Nrc+yNIKvM?=
 =?us-ascii?Q?3DmErCTHI5YSPOuNCClzY7ykhJsrpKXBO5rZp8z+Ye11FsLYZ8QfGZqTKo6x?=
 =?us-ascii?Q?wEdcLlFTVWhzyCq0l3SWF/xDRrGntsjztMQ5clLVjhk9+x9Hn6gVZgbxuUu4?=
 =?us-ascii?Q?TbEIP4cxS3JPv5Nds1g3mGfUzcYxKQv5Gc092JOq8G+Ey9CQJ4Myi6oB8hA4?=
 =?us-ascii?Q?v1neGAHlLKD9hLs9TgGGDxwPiiv3kd95V2tQaAYJmfI813FpqVBzUoZELyHM?=
 =?us-ascii?Q?MHc0ulxImewvFO8hdg2l1DhZkUdksMv4hgZUKoLGHcFUFhT8wDkPbvKrrjMQ?=
 =?us-ascii?Q?HJFCcKMG9cmvPSOJvJRT/TSYusSd35QoPe5uwi1Y5JuSwJvKIs3KJxMT7ULy?=
 =?us-ascii?Q?iz7aAtvOZXPPoE+YTt7qYOn+POOLwBUKwx4m6HGz+bVsxflKs+fhApejxSUc?=
 =?us-ascii?Q?pH3sKOBNF8aHIaAisU9oFbDN35//0TzidFoO/RrscrP3h8JUz1KpqwuDOJE0?=
 =?us-ascii?Q?y9HGvsGdQGcJfBl9JKjosFGB6p7lzAiEkLSA0zJJxq9hB/5k6xpvHJSU2zci?=
 =?us-ascii?Q?KR5+8fzcvLQNAzyF73KTM8kIgYGTbBqCg4oGMu+HNEyynd0okFksWAC/Rs59?=
 =?us-ascii?Q?BxzEwSwBwpVlzS4aP/+ZqNfCRLXWCelqVXzkUZc7E+cNFgIWjCn1UuRo9H2u?=
 =?us-ascii?Q?goyMJBQxFCgGSIHGOMoBJHwRGmgh/VpfqV3fIbg8tM2d6fKPkknWtOlEEN6q?=
 =?us-ascii?Q?VZo8abWEdwgFmv/yc0Lb2DiEECtU32dIoQ473oxfx+bfqAgwcHZuTE9MHzn2?=
 =?us-ascii?Q?3DuZCyyNj7by1jRz14mzDi7T+AUg9A6FB6cRabElN3FQ3NUfRq19bJYurFHR?=
 =?us-ascii?Q?AAuJR3w/LErAZALB7cBVEzQ8LY1NibkSR6z+QBiHvj4VhoOTX7ECE1gTEDus?=
 =?us-ascii?Q?9HkO/5gnVfAdyQQITZXeGsxzu71jMU1NW7ZdZqBdh1xMtB1/Htak+TyQWens?=
 =?us-ascii?Q?jO+xRUV0KtMWGoL+P7KLgP3MLcYaU29icq4L/ihW0uRda9AEGbVhSWXDlPLA?=
 =?us-ascii?Q?PByxkaQU1YGCd4EZAOsn1/6d4K0FeqfNl4opiirfBAob590oVZa4/0gyqK1a?=
 =?us-ascii?Q?HLlvVXl1yhc1Z5JIkFJW3vXvB/qVcGair2E+vbLTilXSS1dm7Cvrwd9FSsL1?=
 =?us-ascii?Q?HodZduG0uaT9DTI5XWblwLX9cg7GoYEXCk0T5Zu+8rdyPmov9e+8n8mnc3XK?=
 =?us-ascii?Q?CgB1+WoQM17NpzuaxXG3nixj4in3PLEnU0+qooHtw7wJ+YBFxqrYCTNEPFtd?=
 =?us-ascii?Q?VuMsH4N5C6wDn06PWWdwSJnAc0+dYXnJKLNhFpNj8HU1nfNUEEjDmQI9aoU9?=
 =?us-ascii?Q?lFeDvS/iDbVlHTXzi8kmjXmXwbpxzkPmCfb1FzO8zaMLMLgOsR+cRAiEBYlN?=
 =?us-ascii?Q?2NSRKMKJTQ3X6F2j31gJYhRH4rELDj41ffeMwv0ERFfXgoEEtz79ubWNKgSN?=
 =?us-ascii?Q?QPp17UVGpR4YgMlHjmb6L9HuHxQI1vwlbpJHfUHPHocEVIRIAHhDBCS++vhi?=
 =?us-ascii?Q?iJ9Ymfik4HXfuGHIqCakcz+MN5ZMs4xwNSAV382j?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2888459-55e6-4668-b8e0-08dcf338f6f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 08:01:56.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WowQE5ORnNB154P/HYp1E7ECEWiBbV6Z7uobQFlLnbz76eDehrhq0+r1ZtE8fVf9chXbOWBjv9wSIKFedLqOBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4573
X-OriginatorOrg: intel.com

> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Wednesday, October 23, 2024 5:01 AM
>=20
> @@ -1973,6 +1973,10 @@ static int iopt_pages_rw_page(struct iopt_pages
> *pages, unsigned long index,
>  	struct page *page =3D NULL;
>  	int rc;
>=20
> +	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> +	    WARN_ON(pages->type !=3D IOPT_ADDRESS_USER))
> +		return -EINVAL;
> +

is this check necessary? if yes why is it only enabled in test?

also it looks duplicated with the one in iopt_pages_rw_access().

>  	if (!mmget_not_zero(pages->source_mm))
>  		return iopt_pages_rw_slow(pages, index, index, offset, data,
>  					  length, flags);
> @@ -2028,6 +2032,15 @@ int iopt_pages_rw_access(struct iopt_pages
> *pages, unsigned long start_byte,
>  	if ((flags & IOMMUFD_ACCESS_RW_WRITE) && !pages->writable)
>  		return -EPERM;
>=20
> +	if (pages->type =3D=3D IOPT_ADDRESS_FILE)
> +		return iopt_pages_rw_slow(pages, start_index, last_index,
> +					  start_byte % PAGE_SIZE, data,
> length,
> +					  flags);

there are 3 invocations of iopt_pages_rw_slow() now, each counting
3 lines.

probably creating a goto label to reduce the lines.

> +
> +	if (IS_ENABLED(CONFIG_IOMMUFD_TEST) &&
> +	    WARN_ON(pages->type !=3D IOPT_ADDRESS_USER))
> +		return -EINVAL;
> +
>  	if (!(flags & IOMMUFD_ACCESS_RW_KTHREAD) && change_mm) {
>  		if (start_index =3D=3D last_index)
>  			return iopt_pages_rw_page(pages, start_index,
> --
> 1.8.3.1

