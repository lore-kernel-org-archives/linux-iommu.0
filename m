Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0345F18EFD0
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192206; cv=fail; b=q/ZoRvQ7Y5Mc7I4WniyNULb9S+AYt4ZPy+QWRw+e8QUEH7bmZCTyNpnC02xfit4OoshoQ3u51eou1gD8BAEwJ7MxTPIuJLrj8CvAQMFKcAwbogdxtDzUDbQfAVP/tudh7r+VVrjcayU/orJQfHXkjRBr4YBSVpXnsz1dVQJvk6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192206; c=relaxed/simple;
	bh=v45ZaihZW7/PLz4zD5fAQSmJPZUcJg5cFMWOTUPRotc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BzLh/2RnkpG/CqyGbGoPEp4Sfm8DWjCmfCMG2Pub5guJI1Tw0nzHDvtdDGlLAhz6Hrn5c41EtJgtSer0ka4KJ2w15i6vBJX+cJ9SD8xge0P02eQ8ARiEm5rujg0ipvJ1xYVtEATq84kagUUEYG8qQ9KEWS640kAU3On4Zt7iiC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6+YHh1d; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6+YHh1d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723192205; x=1754728205;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v45ZaihZW7/PLz4zD5fAQSmJPZUcJg5cFMWOTUPRotc=;
  b=B6+YHh1dZIOBhJhFKqDRTaR3nVRtPhEhTBS8HpCNP8y5ta8rQkjpVCT9
   a6Wi/fwSxzHoSs8fmucQUtsF2zz3ylwiS5OKTgGgqniZorhw2uLpkQ12i
   2lqfg0x5+IwRoLYEXllpov4jMwAGlmd2WpjRkq10AkNifr6Geohsi+Vri
   sEwz+G2O1weATfFobHTynuD87Hu/UhbkQvydqbyvcrf3uK3YpRONRT7vj
   IbOV/4uDcWzvwRVJfN6r5M8+au3hSAxg+BIBwgEy9vvkhItRgPg046m+S
   g/ARvhIUNfEJk8pjxbLocNgwoeSwtX4iyBszZNjThUDAml7sR45EQOsn+
   A==;
X-CSE-ConnectionGUID: exixLYTVReac0LuqzW1AdQ==
X-CSE-MsgGUID: OH2giW0IT7aHaLVubhbF2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="12930948"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="12930948"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:30:04 -0700
X-CSE-ConnectionGUID: MZ0mePK7TCyP9ew++RPb9g==
X-CSE-MsgGUID: qL8ke6YUQbS6f2/YFsU20g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62143366"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:30:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:30:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:30:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:30:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG6bIwKwV65xYUvWzi3AoIepM3xZRiR0zrn7CXuWoUnFIZjeTMUBI7gDZGHOvU2kLOl8mGVDHhzGFl7cQ9KaEzJ6yG+dkwqlxXSAdYY0OhiTlaT9qgVJSiaq9DRGPqNPYrteqvAPZH07P9sHkHE1WRtM7b7D+vFtcVzRxPCdYlJ4xNPEyz0WSQUElddsoODddsFXupX8jkewCEIIkGZGzGHuTIrKFg2jdFMiRLOwcQoO+TCBlIaj+oGGVjycMWvFWmSpOFr0lcpfpzRp6klDp7LX5UhD7xQUK4vCKcO5tInGvC9YB8+f5COuyO4a762Qrx679R4rBffa8MvkqIJGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v45ZaihZW7/PLz4zD5fAQSmJPZUcJg5cFMWOTUPRotc=;
 b=vKL8/kYySKgZLVi8YCECYDzkJKu34z7V9DIjEi9IqEOQ2Ndr43bvzVjcewJUKgjekfybB0Z21Gg3ZeDVtYwk6uPKxG7fXixrpqbA0FKRl2o8Q6ZRnaFXOqaOBZf0M4i3kYM/8AID8Z9UW0YtyHvuZAxKBPwDBiDGQFT/rmxy0jMQjvD5+WNmdXrV/XzfDW4oK+AiAHZBMFbi4xCklJ9StKQSC5wxno/MHgqur17ImwyMXRW9/GFlNULGClHw1BPsnE6bDUre5gO6BK1dreOo7PAQ/8+fntPuu5yw7A184weAJ4v1D2CipAYyTv9I62RDdIGMA9je0A/3fhy5WwZ9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.28; Fri, 9 Aug
 2024 08:29:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:29:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 7/7] iommu/vt-d: Cleanup si_domain
Thread-Topic: [PATCH v4 7/7] iommu/vt-d: Cleanup si_domain
Thread-Index: AQHa6iEtqhBdxoj+QUyHvy2hUc2C9bIemEpw
Date: Fri, 9 Aug 2024 08:29:56 +0000
Message-ID: <BN9PR11MB527651C8AC91B961CD7E0E468CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-8-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4761:EE_
x-ms-office365-filtering-correlation-id: 63db7785-8c0a-43d2-8f64-08dcb84d7386
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mJfeIj2s97yEVg/2KiQAL5YmWaD23aLGZibnsAuFvE6H1LGju2ucaOJ1LQ8X?=
 =?us-ascii?Q?HWgzkivz1dWREYeKXVTgJ36Vw/4e0KENemAkU2L3aNQ+sMystGCsRnJ1zlhw?=
 =?us-ascii?Q?R/kVWiWeQ3lQoctqfFTf60dW4HVkNwQb6wqqg74DnVadvG+H3ZQvxnEuTCpK?=
 =?us-ascii?Q?xCD4wiosmc+j0SAqGc5NozkOYq85nvhXKf13qLMlLmCBziHiK32434+QOcFX?=
 =?us-ascii?Q?S4K46G2Dw9RNVJPNkKIG/MQRXJ48OoBkTT7sdhwpExTUv+DxI2y9PT6chL2I?=
 =?us-ascii?Q?XvuoQ8slOOiI+1tcxTPul8E2NeEK5AHs/IC90ZBa9dn9rn9M1Zfm5kmzJqav?=
 =?us-ascii?Q?NRIV7lW20PUENBtwFJXfcT7hLAQNc9kh70ohJKuDNj8m41EqTaxpt50G3aUa?=
 =?us-ascii?Q?e0as7Pptcd/+Lt39qiRefE1uS+TYCUxRmaILklSnX0FlvcROgEWOnArRBbdF?=
 =?us-ascii?Q?JwMAJTwTzBE4nn6OdJO2TLV3dWfyjRT7ABngVsSknDFW1ESEKGxFj3pANGHo?=
 =?us-ascii?Q?mX9nBuhMHVUHqZaVe7dsupRB/0PdHMxbZH5Qc90OI8AqhFRwisMvCUZiIGI4?=
 =?us-ascii?Q?UQpHj8WvBXxYV3zZyYCY/gx/d4dgIXix6iFWjHYsfGQs22NmEHxcQLNBDuHu?=
 =?us-ascii?Q?JGqJORhrEfamp+VyDzFVNIgsp5D1o2l6DwFjVCTO3G1u6og+F/6bHE7Vjbli?=
 =?us-ascii?Q?CtaLX5zrmtimJLaWgNb9yYPyphjTzD+wzqUC3TVzA5GR6khf2ilgc8GiqgCY?=
 =?us-ascii?Q?w7Q+cdAeffeVh8pjPaWROMFh2uZRXK3toCGNpP9aMnDxI/5/cpAnAI05h7Zl?=
 =?us-ascii?Q?lq2mti4lagTRDhBt9QWtex9ed3q2H6hvsHuIUePNs4jAYOOOsDC04XFXAhBi?=
 =?us-ascii?Q?Jb/E8AAX02q8u+3VH+qQRV5N+kr5+eaVWpQVMxFHf4i/jQBJjcj1rUAdLyhK?=
 =?us-ascii?Q?6aToN2TqK9Ix/USRL575DHEOaJ5FXNakgTRh3VLVGbMqnEndzU3FMjr/RtMC?=
 =?us-ascii?Q?7K+hNb8IUw/1Vfc96ZoQLoL+IIk8Cban2Mo3MEnryXRLXDIPIkwb6VgZraSp?=
 =?us-ascii?Q?G6pZYXtWyzwwflKR8VSCazRvdhCbcJwaqogNzop+WAjNlcsvaP3POwZLZTNL?=
 =?us-ascii?Q?fTLYeh0ZfggqcbjOPW2LuPHwtUGcJ3JayyR4x8i56zBoYA5+xBu24tA56MRA?=
 =?us-ascii?Q?5uQOwr6qrFDwgx26nvX7IKY4E6PnYB9J3N/v9x4w2bwwyC2X/Onn90FhJ8CL?=
 =?us-ascii?Q?EsjqJP0ziKBactbu6P3NabXo3Ady7soHF7MW80u7hPbrx6hBN8431Tqm+RYG?=
 =?us-ascii?Q?zEbapnxaAUko1fWh+H7vwjgLBdIG/1FELmtCPUlnd1SeMtSvRdgQPxi7lzSo?=
 =?us-ascii?Q?yLIW3R+1PUc25IQbN2ykC0LmPYbfgh1JRgmVCi39gs18+kwmVA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?riX4O0gSkjHjWL/2Rap4g6Fz3tsrdmqCaR9L2yfKZu6+PEeMrU3nvp0Q9VFQ?=
 =?us-ascii?Q?+G4g110M4I+K8VEpx7ajGslt/3y46EJ0+mptv07VeaxOM3K6Tgl0vt9i3bhl?=
 =?us-ascii?Q?q7AQ0CIXRuFw/BNlxy4Oq7DI0f/5MM2xQN5oDnt+pXu5znYZJqfAe/PyVBu1?=
 =?us-ascii?Q?uZvtUCcc89E6JJxnGH9BAjW1zwgEoPIZf9eroZYm5LGSxCXYH9G2SeABsWDT?=
 =?us-ascii?Q?NFrtQ2tpoU9R7Rep+ocQjsKOthl7eYmHNAWqlWRQfvt2mBBa5+kIS59dMadi?=
 =?us-ascii?Q?y/QNhaN5dmqgCkfrkdpmJqhnv0NLw0g3jw1ffL/HWHZl0m3/oLoMQ3GFmriq?=
 =?us-ascii?Q?2jzgojM5ofI/x5S4kcCKFQz5uuUIYgTHIKT5nQrUgoDhYqeFptNYaJB5/VFI?=
 =?us-ascii?Q?QWDB2Rd8K6eJdrMrPZyCK/wOiS0YlHwgrO6cghbNj/xLH4VAfY1FwBYiSH4u?=
 =?us-ascii?Q?7q9peZQQZf03HtCaJz/HI7oI0FmV0okespmb1byeKAtk+lrF2/c+7F1oT3bi?=
 =?us-ascii?Q?rc92gkME9Xh+C36VQGwbRVx1g3+AWjvVIDfffeuqrbA5OxCt4gkuhph8Ltjj?=
 =?us-ascii?Q?nqtRQAU2U3FLmkuzL3UyUu09PeBaF+OmWsFCuzv0iSVeDQzzSW+sp1s8jg5U?=
 =?us-ascii?Q?NASlTMHpzt46qgongwHLplkzdzjwF2ESicBsqnfBJwobSIzqiQPorm5VRd1X?=
 =?us-ascii?Q?dWaV4gzTDzSd6bljBFjDsqmu+ck3bSkMBCbKfBLl1Z5rt3oBP0gHmbWPjLCe?=
 =?us-ascii?Q?sWT1zj6eplK+6EdCAuIE95goP5L33WtDDiIJCbGPYw+1rHFJn37oJhqAlBLQ?=
 =?us-ascii?Q?CX7xzm1+hbrWDGVw9L/UMl7ObxbQd/o+Lz0gN5VnhvbxbBAoL7wkWNWDGt4V?=
 =?us-ascii?Q?Bs6izBFVi12sdoxABqZHD1RoR0fG2AxQYm0u5zo3UPr55mOwy1cuq+Jn3/0M?=
 =?us-ascii?Q?5wGxF71PGNIS9q8auZKxhsOisrgP9OhAjefCA89vJKtAmVouXys47DP7qNMV?=
 =?us-ascii?Q?cAsa2bOk4Xa7LiLcNNs0Tew94JC7V4H7pOEyaWbSUOjA0RTpUZYGrJh0R5ht?=
 =?us-ascii?Q?xDN4doI3Dqe67/mi2kU9J/IfdB2jwjyM98cTa3WmmW08hZzbUn3tvzTAL5gn?=
 =?us-ascii?Q?HWyjQrzJxBtBfmZ49vtw6XTTV/Qq0VqxAPJQ+Ch6euQGdjQ1XsuGskdNvMfd?=
 =?us-ascii?Q?mL/xR4fPpPpK94D5RTzUF1AHv43cH5LusRF3fStByAvzWvKZZSBgdWc+K+EA?=
 =?us-ascii?Q?Kkzxe3dTLOwbpo05yinZY3Fds90PFcnkzPc3AGMJgatpsuYhPa18JMNT/RjR?=
 =?us-ascii?Q?k7G55R8qip3f303EE5QnxIo3i+LQ1pcJ9dhmVZcqsxdIopjn+xdVxPaA0CUR?=
 =?us-ascii?Q?dn0pond2piP4NVSQDxV53pyRpIfz1JS47uWt26eqVbs65EGVAOSrXAYn41eJ?=
 =?us-ascii?Q?X68oYz19pwMPHU6c1nTlAwn0flE2m4H7KFjDzKt7ExkLlLPy4mddTbTrkqlQ?=
 =?us-ascii?Q?w0/jp2P4kr7jFilAgv4bKXQQZT2zSx+nzJ3JWUXbxCAW6zsEtof3Zjd6Pvoe?=
 =?us-ascii?Q?P/cf4FuiipFZE8fX4I7IswLVjPut4KkCL6i6/1ZG?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63db7785-8c0a-43d2-8f64-08dcb84d7386
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:29:56.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tz5P8NuEKXhIVgHiucAeS+FF9c/KIYJ4rCcULGvl2rRvVXRaRpfENBwsb6LFd5raKpnbZEyuip3POoGhZKHgnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:55 PM
>=20
> The static identity domain has been introduced, rendering the si_domain
> obsolete. Remove si_domain and cleanup the code accordingly.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
