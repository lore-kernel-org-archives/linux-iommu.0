Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D741FFC47
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471411; cv=fail; b=WzUeem3oDdv+FDvzVyBi4vNorXmZ/SNjKO2PoP1JjHVWfS8w/3x1p2gCJFIqhHEm1+bN8BnbaHheIAkuBum0ztWBXHs8kO440L83pTyFS+ojPLhLTO9iB/e5xRe1va2JT4r9iaLOX1zIoBtflX08zmEQIR65FNIZIN4mRiinq8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471411; c=relaxed/simple;
	bh=X4nPPNsTEcr++CQDqor8fEs7A2Rs0/IS1piq00z6wlE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oM7rQHmYLRbJkzA3Bmguh9EdKGXTYPw4qizQNvAkDiO1kyh954GKGjt0yXWCR719aFSbvc9BbElqB8iMHsOTNw1c7EfYcE7v4Ys/8J3azH21a1DULHn0kqGK+NhrNSmIAtIna8CJjeozcXhUivpOPyMJ2SgFVlhXyVJmDkc7Knw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yx9xIqPR; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yx9xIqPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740471410; x=1772007410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X4nPPNsTEcr++CQDqor8fEs7A2Rs0/IS1piq00z6wlE=;
  b=Yx9xIqPR/D6Bconwa8KRBfXqvFa9DBF/+VctDfVVfg9gaB5ozHwXdB4t
   xhMNgyjD7Dtz4VweVPkzbcQv3Me1WlNTn6F6vdmkCuXAJwSmOQonIcmQo
   Hrc5FIgPYtAJq1WEvhAzUvxLdxZm2jEmyTa+Fkf3iFUZXQYnS4T8WT++a
   Rm/uM/w1TGk+veYLtoUkO1Vwgf5wY9Kb2s4n7/8gJuYdWA1sitdrneo+D
   ur7d/MCh0ZOqzaN+nxk6UglqxghWagc1ErTpJTZ+y50yDAvv2IKoV98ce
   +QcLKxlRClBKM+LFhgC0ZHOdXVh6YKqh1B7VGnmuqIgONTytcaidXi9To
   Q==;
X-CSE-ConnectionGUID: fdaafz3EQLyd0yevAVVfUg==
X-CSE-MsgGUID: ZrePkuPYQzKT2iajnbneUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40501854"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="40501854"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 00:16:49 -0800
X-CSE-ConnectionGUID: X/dfW7mxQneQAm2iO6YDaA==
X-CSE-MsgGUID: si63/OU9QH+7+r/rffoIBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117248632"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 00:16:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 00:16:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 00:16:48 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 00:16:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Quu0EsnoC8xtSpKoKYs3Da5lH5I1LSZFKNOUZCgBMFZeHtIfWlUr8qjNsyMN2UXzHxnigNfyXj1LlBqCOJGUPFSlz76GBxFO46dOzmKbwZP6l8NaQ1nfRajWDbq+UoaX8fVqc46V/zdJmCuzWoLriBo7QyGyZVKFIKUkCT8zLVY+M++RHsmAcBzGTxACh99DnI2oplhbkSNFuwx8HW/jBjuADH0G63ChbhY0TE/ZObPfaAD4yL0qFwMCBAZ8CPgL0tLopdNDbpAtxzNObisg2iq7pryfExe2XQgyvlaKtMaZzAOZRdJWbQCuFiMeYJ1mhU88Q/wmZYrhGX55sNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4nPPNsTEcr++CQDqor8fEs7A2Rs0/IS1piq00z6wlE=;
 b=IcAa4pKoSoMhItlZRbtYpf1ccRaZxTO1vflPU8RbkhibFeTJ3X5aoJpms5IUMW/8K5U7Fs5/PEHw/SlLBLUrjLYYEgLZDV64LrDVV2Eh0g3WOS+AVz94fjZZhyoZ8hPDiZxdm1gKHOickpBc7cvQ1zdDboXZiNa1NVsRk/lcGPQVt7YHzWDOq4dfpl82UH6xjRSTkHZ4qZintYwnC7uUuQBozoU+1yfxbMiJCC7UtL6ueI2rEXlDiUW7su/fKLAvuV+t99CxG0UfsRnm+KzJpKksHz9r+jT3fYZVjrK9GJ83wD8XzildYon50TF925p0y/KpobIQFqPhqHUTXPBoHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 08:16:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 08:16:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH v2 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
Thread-Topic: [PATCH v2 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
Thread-Index: AQHbhntPYr9qyvyWUE6A5/UXtDb+7LNXqlvA
Date: Tue, 25 Feb 2025 08:16:46 +0000
Message-ID: <BN9PR11MB52761B11DAF35BE3CEA5CC6E8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-10-baolu.lu@linux.intel.com>
In-Reply-To: <20250224051627.2956304-10-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4620:EE_
x-ms-office365-filtering-correlation-id: 9464f5f1-dcce-465e-01e8-08dd5574beba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hujIeMT2OYvMDZVqmrtR+RTMsn6FUCOetR0pf3brMKsUguYb0CIWQ0lB9Azi?=
 =?us-ascii?Q?OTgi3q6Z9XSOUk1zbdh2VxntLniY9AewWKmTC7/nKRHr7CpXCGK6kptFn4rX?=
 =?us-ascii?Q?P6Gw8sIGDULCSIxw0TxqejLuPWDVMa7YGX6dSbF0NCD3n15ih3H904LGVrMj?=
 =?us-ascii?Q?VVBMBLarckd/MWTE3WBiXD+GvG6yUbyKFX27C72Ev7hdNNdUuLSkzs3fnM5d?=
 =?us-ascii?Q?ckAXcqdinyd5tyLmFeibSmYZn+d5nUdpbKjlWjSR4Ko+LETyMUthGqUhMAL1?=
 =?us-ascii?Q?FDP+qfSb9G5pvqLH4bCqBNI8v24nqGKfCQ9PO6AnAl7VE6ugNeh4wpQkXFLr?=
 =?us-ascii?Q?FLVXi33FxXe7bW96BqzWtFSGdfJHFFsvOKeKAU0PWRu135FXFY9nzju/B7Mn?=
 =?us-ascii?Q?RwwM86koHGwGNAaCLhRmpzeCDxi1m5kEPHCE23nG55CimxXC1tV33jqLSfCA?=
 =?us-ascii?Q?Pr2MEa9W6i7UBLiak4IBI4JwcGZHNHbImOY7rGo+ZD90h4X/2z+Y3eu/URy5?=
 =?us-ascii?Q?uxeA0aU6rww573Mi3Jhl6moc9D34XUWyGlgkqSEVXoDbxQfY5fe7/lIpdR7h?=
 =?us-ascii?Q?FcnBTUpqxmEkDAyL1CrnnVvkGpVuE1CqdTbYeBS7Q0ACRBDtN1/VLXFFRPkI?=
 =?us-ascii?Q?pgFcFrjwF3dUqreyHa7cH8u6diW97aDzY42u2igedn9DsIuytT2hegD/xcXY?=
 =?us-ascii?Q?+EdWU3E6i7yV79cpkgQj1kt/Pe3WMiYF35l34Snqcl1JIbqBg+ie4bFfDnMO?=
 =?us-ascii?Q?AtqgTXBHqi3llAhpF2UPDLQ5eUzIHivMGTNn2tEIqu9oIAgEEM9DhdQ3xqmF?=
 =?us-ascii?Q?Rro8PYU8GiuEHXXUbZ8oJrthOmvX0zwIBiTIVZ1F1YhCiZDc0F+wkhCxQWSE?=
 =?us-ascii?Q?ew0vQoCZG4avrxaH4kLrf1ch/q3LHT51jPmmtCxmwXwPzxJ9O1JX7xhOU139?=
 =?us-ascii?Q?KNJ1qKVsYJcP/b1vzMr6lw+QR5+HYPJ2nZmBfTY37DLlNZsiuY1CCqTigoWM?=
 =?us-ascii?Q?aeJIVCcybHnL20R0pigCunb4fFeN+L/U02L4D3gsQvN1HlVHi3WPgIpjHA2q?=
 =?us-ascii?Q?4oEe+RjgsvqQfBcwZgFA17VXlLUScy7LCcOSlisoixCCxRR4ynhRt/Hg2Qr5?=
 =?us-ascii?Q?6Viz7lVdDf+bs77ykUzc9S8lJHuRpUZhIRGtRc20vVoBEcj0xfKT/Mv6iSzl?=
 =?us-ascii?Q?doYA6h9m1HND1F1WBmS/rgiXkPzJPdS+eC34G7OrXJRcIdzXPDI2APWanYkU?=
 =?us-ascii?Q?Uf8OBsHPgawxo6nqL9yc61YduaepU+BFkWP9WaKNFyXIb4zWBtKNWGBwLX2W?=
 =?us-ascii?Q?H4njEfrf8jhkcL9DvqLizb7keGFTBwcQ714kEr0xVq47Wuh+MVi9qal2fLwF?=
 =?us-ascii?Q?SmG47UG7xhat1/QLtusTur+2OfbOkhDHfS+XPw4oBEuyjthWhkJXs0Ca6Zrl?=
 =?us-ascii?Q?0k0P77Q/UUCRglVRBEu8FGR0bAlefwa2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oFIFHby1XtJwhJ9QuNF+t0iDIJ631usInyQo02SIMKh910wbHNrG0FXA9l14?=
 =?us-ascii?Q?Pb10VcQcDn3wIyC1i3JAHXYI6xDdLS+bvPsNXh6FUh1+1fTWBh9odcX2S4bU?=
 =?us-ascii?Q?GAAZfX2YdocFW2tlPB9SpDJU7nAT/v27vofB6T23Iu/iPSJ/yNR8LDEaHSs3?=
 =?us-ascii?Q?M6UqW7pIkj1lARnwxfGAIdCpKUMe0V1VQntJpiCoxG2JJygDoF0Y5ODdl7Jr?=
 =?us-ascii?Q?XAba4MSDqYxj/aSXGfR7ooux82oGPkbD6cGxCRKp/y8uXYfQgBWEdm703c5v?=
 =?us-ascii?Q?0CF0bPK1pJkKXlWWvtJacD3z98PcQFK9eAxvpiwI4iGpLqgc2/SpBZ/Vyv5a?=
 =?us-ascii?Q?e4z76uNS/vcjsKxgvQImImAB8Q3Ra0KYazRRDsN9NmW0+HWkBLSOiUmVYUV4?=
 =?us-ascii?Q?oAaQkG+aFMG75Br9MPwSvMXPAw+lXkOGzGc2VwWb3pFRQMPpSFsrpS7crp8j?=
 =?us-ascii?Q?jM3STmdsYhAngCQTtPQU6yDhtrrulIAFD43Caz+A2pY96HoIn7kAzgx7ImY8?=
 =?us-ascii?Q?40JUSH2r9l+ogYppRanwCyzNDzYTKdNLPnwel29lBDYPusi/nEFV1KZHbowz?=
 =?us-ascii?Q?WdJo72EKJ9AMevYqjNo4JI/ZIiWfJspTj3ER1bptx/Sdj4OulMwgnMvnCN0k?=
 =?us-ascii?Q?z410X7jRe85YF7QhkBfuNbl4IzSjrw2asC+rj7UqnvYySEK+kE6qpOGonicA?=
 =?us-ascii?Q?YlPELansN2DltoABFnhV71v2cVzyFGXgLaZ63isTbh+qaMdbJrR1Jh9RyRER?=
 =?us-ascii?Q?EAhdOrYeF6KJs2CrD1BXqlrXQk3mtoC9SwpKuSWTBmqavm3VUW/eHUAbNjOU?=
 =?us-ascii?Q?Lj0GDyKJKvLAlgygaSmDu/4bTM+SfdU0V7SUkdqhkAm5uiP2AB7jSZfV4jMS?=
 =?us-ascii?Q?di5ZU0fIEROzSQAyS9zJkzuRfLbK0oEGVyAwg/Cbuv4lZA2Kf5HkwWCQtrvg?=
 =?us-ascii?Q?sXuZPIVyuUtunjbX8bqz/5b9Nmikx9aUfYJw5I2e3PCzIuJLBrXdZopgjts4?=
 =?us-ascii?Q?C03+ZvrVHH/oYFhdg9++j46xqJO0/mWNcdjDUDvVU/pZ1GeQnn5RCqTWUJxa?=
 =?us-ascii?Q?DkRoNeSb9uHPFN4e8bmBTFr2mzT7aRZB4Y6ft3+FFMBJF8BLysJJwEBPmEZl?=
 =?us-ascii?Q?m4TqNcl6a0l3H3FZl/TRuv51scaq4x/bGh+s1RfIcCAyz1DnV+mmQfSh4vMD?=
 =?us-ascii?Q?bmRfB2npQnz/CsDqLwjYFNCcfHtjualkbSNywJz/3l9OI371EtoWCcxHz+wr?=
 =?us-ascii?Q?jqGfnq39qPmHw+kttIrBnK0dihqTHez8YhAhRmgajbcDStePau635AzDKwj2?=
 =?us-ascii?Q?32p65uhjjzVYwKZlmEp1GmURRRsaWvG2T5Ak/h0aXAZdeyDbpWEAx8+qzmIR?=
 =?us-ascii?Q?rj3KB3rzPX93VWF0lbxOJgYXZh0+l6ijaZ39DWPCIGZ0+9TqWRBqAXsbF2P0?=
 =?us-ascii?Q?k9mwNsuWixWfaApr1kg37ohfwZy6jqR1hpA/pD16/6JXpQ3fCtngO4uWZ+og?=
 =?us-ascii?Q?KyyLatM3Bv5fOw6Ae6d/Gf42srzU74G/I/bRG8sLyURoPptizUgx+06G7L89?=
 =?us-ascii?Q?SoodRXfjpUNq/CvFa8YHNi5dvFd4tRC3alQPoF8y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9464f5f1-dcce-465e-01e8-08dd5574beba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 08:16:46.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7yd2S2MVStEZD0CD6ZoKYaHqtT5KX1h8P3Z47fFWTv9O3y5Z03WlIshVVQmOILrZzTcQ36rvS7HrzZUnUZOlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, February 24, 2025 1:16 PM
>=20
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a
> no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
