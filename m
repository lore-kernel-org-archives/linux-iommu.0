Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8199AD24
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765524413; cv=fail; b=jbFT7TOG8aVwbWG14mnEeI1Q3ZUK4/W6AcdFfGA++bB8BXkEz+yIX0uhIV3plShniY2N0BKyWnQpq5DQguxQgrD2q6LEHRF3nGiO0WfymmYTQ2U3p6IS1yLi0zILNizFxZYjjwGSNJaFaCm0o9SHDlBBQBfN3y3fqh5Eezqg1LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765524413; c=relaxed/simple;
	bh=vtnihjNZn/SJ2EXV9UbvrRwwwcMuY/ODPjuipwFW2cY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GTRA2WsBDRJwkLyXRj/Loysy5puaMPIP9wvttjA46+FlbaktQqGwChBuhUc6ifNoPrxpDa3LMSDzrDdlmYg9zQPWC9t5fJbORqETp6QQYC9KJ4XZdgvq8Y7vSyQLNP97A3QKM1gDHFZCXtfYzPyUtmPeNQwaeFzOPVzadKpECUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3MGCiaQ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3MGCiaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765524412; x=1797060412;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vtnihjNZn/SJ2EXV9UbvrRwwwcMuY/ODPjuipwFW2cY=;
  b=B3MGCiaQcVtu7WqCS1Ra9QRLwPEBnl+u6HZJZSStb8IhsDMRt6tzkxBH
   DqfIenZ3PXtvJ9k4uzYAhI0AB/pCbYQplgt3YHdN81SmM1F1al9k6rNmS
   XocLpNFJAQ2WQbfON6PZ8T2sYMJZRXc7EfFo/46dNkeL9ni1fk5dbUEuh
   NeRiwgJXa0P1T19eeAWJ1Tp8+PGOmSwME5EDUKz488eJcSwnq3NXueBKx
   R0kax8b7lm4LAYFDhAupf3SCs7xF4mt7XywtaeAv1RPXjHVsvk9MaAid6
   AEVQ8UhYkpY0jHz1NIENUJ33yt0V9H9BLWybvoNLk3eAM50pXyOQVSJ4K
   w==;
X-CSE-ConnectionGUID: EsKDvr3PTMiZUwbLcMWUwA==
X-CSE-MsgGUID: S3JtlrSzTsaCFsFGAJcjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78622560"
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="78622560"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 23:26:52 -0800
X-CSE-ConnectionGUID: 509b//IKTWGPEetNjdEUWA==
X-CSE-MsgGUID: L6kETUrgRzawFQ7OQms3pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="197820710"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 23:26:50 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 23:26:49 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 23:26:49 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 23:26:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeKvwQwpbKwabU8FgLNQpNBMrv8jANTW9rkEV5SCPgpSf/+F8yiksH7ski2oKlYa5w94tQKAW/aE8sqy8CnqALJq9zeDqTHsIUTS94jqBDl5kJQhSs1hctWkN74IyFfGcXgddKjtq8E0bz//4jzK1MNQjVZ7BF5r9VYe99V5ajELWLpHb9joZCtZnY5n6B1tnS1eW8hDP7NrdFKt3KF8h8WG51tuZhHuAuoyl7JIyqk3a8h4WATGKEqlbLH3LQ+Bg+OuALaqqu+DUx2Ur4Hze460X+Q79I//BCUxRMbPbEUFPIrR8IcyhTIIlZBAWj9AQcFLeGYPn9XqgaWiA4Wq/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lrF5qsSrupof4D+W+EdToXLeFKYamMLlSOMxwnPet4=;
 b=wyEcab2CGBesMH0UgYXv/9WYP9YCbzeXUvMXTbGnFNHYZWEdvqAnlFb8RYG0qWDxm7GmZc4wVvYG4rCNThD4W613KDiZniHBLkiCThcFv6wI6GZwJIoOKOYhOLrmtn3OZVupb9YRjnh534LbEUYLdOtV5Ws6aPIljLQLjxigx1AAr2D3lvH4+iM9OoWDPFm0QnXaKSUZtqSZB+EcV60MxFfBeerNbrpjyMbQz0cJ8Xh1bbLBkirxdv0k/32C2hJrhkFiPiJr/iWHxzGfOk6CBPSRy8ahYiDV2PH3e7lb+3gWhetMg/x8CgsjX89hv9tmJJi0yZBGsuX1sFf7tdDpEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4696.namprd11.prod.outlook.com (2603:10b6:208:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 07:26:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 07:26:47 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Wei Wang <wei.w.wang@hotmail.com>, "alex@shazbot.org" <alex@shazbot.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"aik@amd.com" <aik@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Topic: [PATCH v3 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Index: AQHcVLXXOAUEiVu2dUG4qr4e/uuVALUdcjlAgABOTICAAAdG0A==
Date: Fri, 12 Dec 2025 07:26:47 +0000
Message-ID: <BN9PR11MB5276E6194ACDC16D1240DD438CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <SI2PR01MB439337D5513729BAC122F526DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393BFD04F698501F19013B4DCCDA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <BN9PR11MB5276D5D7338261F48FB863188CAEA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <aTu9gUxtvWsmG+WD@nvidia.com>
In-Reply-To: <aTu9gUxtvWsmG+WD@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4696:EE_
x-ms-office365-filtering-correlation-id: f409d5de-2123-4c54-264f-08de394fcf6a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vZt1OsMwMTkxO5KTpfneTyqj0B1wTfPokKLUDeqRrYvjXtAN9t71XU9Sebty?=
 =?us-ascii?Q?RX3srxqcYDq3Q+9+ngpey6mqBQxxTSOvGJlqRbbuXzh7BeF8JgIfQC7QD3J3?=
 =?us-ascii?Q?s44Iwlk+YMro02k+VCxyHXBBYAc+iDtTeO163fyXGXLtKPlVtJAoFbjl3BcM?=
 =?us-ascii?Q?hMhq0WeXFGRSi25EtD0ZjfziiVA4RQ6jyuW/JBOQPUYU08Uo27WtTIDPztCp?=
 =?us-ascii?Q?V3AFZzs1tU70vrzbKb+KwkZSIcUB9xzGEVwGwkpuif476CwQQk5DONgNY/w7?=
 =?us-ascii?Q?3BSMOvtlaKshFjfXJTDKQBJcKRxflTnRmjlRqFrc59UoYXr0+A6eYcUxsqow?=
 =?us-ascii?Q?tWgrzu0D7GLHOcvZE6yLfDfVjFvHvXQCpJ+A8NybGR5cGvLqTu1IgtXGicwi?=
 =?us-ascii?Q?Xx1M4Fma1obgOtV/uDseIBEEhLn6iwcJq6REngwoV5XyFa/rzJGjJDGq47Il?=
 =?us-ascii?Q?0OsD+DMpDi1PuS0V8hReZ6AP+5P8TX3rCS+sRXaZbrkw/gyF4Th3PVJvSTii?=
 =?us-ascii?Q?CXpLr81NAN3gxgC2aJCg8k0gTK81oJa9RxDWmCBEcZtF2s9mrpHVq1A+y8sN?=
 =?us-ascii?Q?K/e3+yBdUrBO7fMSlOMZhewWyKWCZmurOgBZCVMDwlLvG91EBl0tT18d6DkG?=
 =?us-ascii?Q?z2EhMoJUaYpaETlzVWSTBu1mLY45kOfNvyl52I+O4j9Vrp42Kgbrrvei6UPn?=
 =?us-ascii?Q?cYzm1jbXVKVMXh9ygOA3CPWX4QE0gm4Uocgz+yO+RNroQTwN87sQPzqAAQPR?=
 =?us-ascii?Q?jj32e/wVmFzNBFisgKh+CmvqjhOWSfQZLucXQ6aYnISOgVR06fVtxFdo6yRW?=
 =?us-ascii?Q?rUlFMwJI8nBq4xnF5czbxeFvXw2h+ZNiy40FpEF8oYYD3W+rH+SETSLISWDX?=
 =?us-ascii?Q?CZWdSCOtU0mPZ44tVXUASk0J6nD0CIR7OZfNGJoR8djk7NG8JHBGNYBuMXA4?=
 =?us-ascii?Q?+j4HWBnjijaFcuva5da9XfIORjYC0Ta8Q+kUVHNzt6q6q/aqpLoMe4dEPtBZ?=
 =?us-ascii?Q?Fzwd3lpZDPD/9IxlkswPpIfjehAvUDkRYQRK33eCt0J8VS73FL2RN3RNqkyI?=
 =?us-ascii?Q?LKPC8BQvpfcqSMeEcRw/aI6sngnpKPz/plzqU9pQ9RKtqCpfZH1ezvtUC04L?=
 =?us-ascii?Q?IAsJQ6S7tdfs5Z/fcfAa/FJbSbTi7pBvEFtB/bbLBZa3kTK+8l/Rs/U1JbAN?=
 =?us-ascii?Q?0S3a7Tt0rZWMQLDsFUG/fvtUmdp3SUDkgwHKWhCuTmiUoRexiwTRcBjizAVI?=
 =?us-ascii?Q?AotEoHzQm9MPdVWGHikisQqHQ1b3w81yX6c56HE2kxbOBF+b+slMTeOYJ+it?=
 =?us-ascii?Q?YEc7rnBh5imRxKlbvL26oxShGFXRVbqtZLM5DNyIy6fAs2zkkishVO8ksxtm?=
 =?us-ascii?Q?rrL4Q6F6hnh7x+g8n1qaQVd0Ju17TVFL7qchbnpkJQgFxO9bxYPnJ++4ViRM?=
 =?us-ascii?Q?u9qxXgK9ImRodrX6ietWcNZp0GcuP/f2OpMvPLdMxe8hx1fFG7T5sI5pe5qm?=
 =?us-ascii?Q?gA8vdYAbYeioBUTsupomqVp01+ifLBzS9bgD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CmRUSgYt0NOU2XdAJTW3FR5xg/I6Ugt51ptvet4/kMFcdiSLMoixx+Xapkbh?=
 =?us-ascii?Q?VT+6L2FrMGnvOThbB7MlBQlQHdOIKuqy4Sp8yDWplbdZGu0YrYfOy2zy8PzR?=
 =?us-ascii?Q?YGGq6txcWhzGMHFPRcLParwC6Lum0aYbGD8KN7OZ+zdDko1vAgkUFakTZrXO?=
 =?us-ascii?Q?Ow0ppCtoof3Sz1ua/v8Fxf+rXiNz9mQnUb1S2mt4EXEFicFb2TAp+TPintrx?=
 =?us-ascii?Q?TId6E0K+4fCtL93OdQ5S/ysG7H0aCGon2KaAXppzNkz6hx5CNJEO6n2c4m/O?=
 =?us-ascii?Q?OY2bz8362YIXT05JCKCol99GSuipuHa7GqukgP9X+SPEMwpeIe1SRscsaVag?=
 =?us-ascii?Q?4as3f4HB01zt6+gb6MytqOVYvTMANG6nMM+DsJ+phZhJ/xxax/j7VhruF81C?=
 =?us-ascii?Q?675wwc14aewi/orT6Alkw+8HT01wtscacBD4cZhI1jyUIo92Ui7G0VwbFOt3?=
 =?us-ascii?Q?ZDsZ9YP52Ah+n0ZByxTwPVKEEOweluDIyVorAYBViOId8NtNE7Wm+aVOpLvi?=
 =?us-ascii?Q?456JEH9t8KNWwLvMd6rUveClQD0fTqDCku7d3cdo+6vX+6R1l7xnqBnoxJOQ?=
 =?us-ascii?Q?fVAR89ldR5IIXh0yGKqcIiuYkdpsq+rN0FWoraZ6RxrmFCd42FQUkfcVaG6Y?=
 =?us-ascii?Q?gpKmapNZSMTRVSumgsxOkKUT3ey1OkBkEtsmsY1RgCiP18jrbzrxB3Z1NQb3?=
 =?us-ascii?Q?aLPnwlGDscCZjij20ilPpp+RXD8pWtzXFCdKOM0lJYx5JsV+SvWAhQv3tNii?=
 =?us-ascii?Q?cBfQhOQHwFTX+JYEld3s/X0xzxx6Bo2hTXaezWdQPKH7hQxnHWcXMk3N3+/D?=
 =?us-ascii?Q?iM132djTl5RjacJZ8GSCj7vCv/wJBEFzu/klAIxp3O0eriAoBpOUkuzPQR+8?=
 =?us-ascii?Q?oRf0ZNu6Jj4I2Ie2N2pxY1/8Aw3X8xXvJP7JykYjnJlZ+3l71wAakbfu2eVi?=
 =?us-ascii?Q?T2EoOTYgp2NPRq8TOS83okm7XsdpFORH8PKnbSkdPUQDsawgu+L/5wOyNC+R?=
 =?us-ascii?Q?ZbgqN3wKacZD3WwYTf3+8W1XcQFC+Oa7lUZLbEwXvewq9UWl7XiQdu0qPSaG?=
 =?us-ascii?Q?1DXnzYIODEsKOXibE9dCL/L4vTTInxhilhBXujO7skM+MABIkmAtQNKgUCYi?=
 =?us-ascii?Q?YhBClgtAy2TbjHfdYNdJbsum/ZdnHWouQs7ZuxIKUYZOupLNyJCQ0IX8rj5F?=
 =?us-ascii?Q?2gsfbNc5emWE9b1R1ebxB3hvtdeGy9oY++wv8spiTdYNIPzzD1vcht8VxXUV?=
 =?us-ascii?Q?toRXD2UwIKoMXwqJB2zNfx9yR4gs8kJuxPpxmfKw+XKVuLmiWtkPzyAmKdYl?=
 =?us-ascii?Q?BpDnmfi2TX1aCyuGYXwLR8u8gB8yfKLQoebB+LR89oNHTTDtX3XQPoAE5YMx?=
 =?us-ascii?Q?OSAtvJ34BADEgr9LtRlpqKLwhv806YnXqWGY4DoJF8tjrnuLNZoaCl+fLKXC?=
 =?us-ascii?Q?SxoNd/M3QrVrjSVpVsazMULvjnpvux4SNDCboucJl2e2bGd4XCpIhap3mXCY?=
 =?us-ascii?Q?CzPXXU0VIYYw7nk0br4cp4jT8+kavB2QxI3y3jMbgil5irQY1B44vAz+XvW3?=
 =?us-ascii?Q?W9TRkUHktAGsamk3ILtJAYOXctFw4d3LfBLwuQG1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f409d5de-2123-4c54-264f-08de394fcf6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 07:26:47.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDpzlYC088IqKr0fB0voIpIjSTOmji6AjRX/7/mSIrWMqO0Y/e3IJWmnvG05FWYLG/8jPQXczxfxVBOXgOsk9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4696
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, December 12, 2025 3:00 PM
>=20
> On Fri, Dec 12, 2025 at 02:36:46AM +0000, Tian, Kevin wrote:
> > > From: Wei Wang <wei.w.wang@hotmail.com>
> > > Sent: Thursday, November 13, 2025 11:54 PM
> > >
> > > @@ -629,6 +630,8 @@ static long vaddr_get_pfns(struct mm_struct *mm,
> > > unsigned long vaddr,
> > >  				ret =3D -EFAULT;
> > >  			}
> > >  		}
> > > +		if (vma->vm_flags & VM_IO)
> > > +			*prot |=3D IOMMU_MMIO;
> >
> > move into "if (is_invalid_reserved_pfn(*pfn)) {}". it's pointless to se=
t
> > it in the error path.
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> >
> > btw another alternative is letting userspace set a map flag explicitly
> > e.g. introducing a new VFIO_DMA_MAP_FLAG_MMIO flag bit. It's
> > not considered because your use case requires existing VMMs to
> > work?
>=20
> I don't think we should do that, userspace shouldn't be able to create
> a mapping inconsistent with the rest of the kernel for security
> reasons.

ah that's a good point!

>=20
> I think if we ever need a cachable mmio through to the iommu then it
> should be wired through the dmabuf mechanism the same way vfio drivers
> wire the cachability when they make the mmap.
>=20
> The nvgrace is the only driver that creates a cachable mmap already,
> and it would be more correct to have a cachable IOPTE, but the only HW
> tha driver works with does not care either way so it has been left.
>=20
> Jason

