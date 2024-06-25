Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B1B3A8F0
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 02:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282505; cv=fail; b=htKvu7E88/3chdoq/mde6CMmRqTyBJKQnhkTJxZcmv9JMpWjW+xebfWUTa+rCACBMhfSoiAbXOKsqEeGpx28cCcxMTLJUPjO9/o+UJ+YlKtiPfPCeBznjnA85rumCigU8Njb8VJj0yLXBR3V70KKtMAxCfQbiagX8A4tKwiwZcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282505; c=relaxed/simple;
	bh=zRldkrr5Sx36dmf4dl1O1sxaGo0tXJIOQ0SJ5vO/upM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qf8Bvva3yTLVsZ5RY8FgeL092kx43y0c3L3bm9UUxTFTRZcBh/kbaliYU+86Q9WmMxDOEngPkq996SqoPacWbsYweT9dF/OZ/VbuC4LH3GsCgBP9laSjC68Wa6kViz8880BxzVakQt835bSTB1lhB7ykBW5NQHJ62OfA3YiZdbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2G+52Bd; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2G+52Bd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719282504; x=1750818504;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zRldkrr5Sx36dmf4dl1O1sxaGo0tXJIOQ0SJ5vO/upM=;
  b=Q2G+52BdAVTHGYgg2ou94EDQJnWT4Wd2rpvXxHjicIJltDtpP3IBg3+Z
   6zLA/RBxIeBfR0N/78ld48r1hbL0xjzyrfMN7ChRZoeP1gQ3NO+mvQ80T
   A0DO39RJ4Bvi/7FrTtfD4OBnEp2MzYjpd1y1jmzU3Ur95unRTCbKkJHnw
   HorMGaXZa28lThfTI7WUJPyPgzJD52DMuXJmlcwpHqNnxHqbvZVAtXbt6
   moHF5C/OOgG1HWsmvGGRN4OzdpgfSHTmyBl8QyurhFrnCCUWShSKnvAiw
   NcTLZRERIt8qiPy2sSwr3gPfvFfv5uhBFzsGVqSx+vup0R75MM4ouwNep
   g==;
X-CSE-ConnectionGUID: GQLgq6mRRpOWswCYAQvrAg==
X-CSE-MsgGUID: elrM6uqaQWSf4Uo/S9cuYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41697865"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="41697865"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 19:28:23 -0700
X-CSE-ConnectionGUID: 8u4BrSJrQ6W7nZEn83891Q==
X-CSE-MsgGUID: gbXiGQq5TjiHBqiiCO6STQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="48663151"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 19:28:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 19:28:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 19:28:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 19:28:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go0F5J6PXbl+eN2mIpGndAy+MafxnMuf4BFJz56dIScZ4iJYptPodD+3gONChL57/0i/tEn11A7d3Sycb/+cXENqyWC5Vp3yPCQ66ZFMDXBheasuUJfnv52wJpO+7jMxm6VZeghZmZo26hWkZuEMBkgImYkLP6leT9+Cco6fOk+KLepNnvI5AVNpucXDNn5ov3Qm+lXFI3LCCO6iv4j9cxrBNfj4TkkHpv5RdcExh60kTpcbpHYETGHlTtpz5G2E8eRJnzzPl2fJubuxTtceyC9NWU0tOCY3fL4yCI10BnRABssAnN+9dYBroKErEtoi8iN6JWpaPNeNZ3Vp0TL96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRldkrr5Sx36dmf4dl1O1sxaGo0tXJIOQ0SJ5vO/upM=;
 b=mlQ/qQQJIYZ0Rf1/pq3KIzlbO5vsGl28ioF68KKSzdxsrVancjpCEDndk39ZGb9+xI7L11mAa6Zm7YyMgJcIaAXgrR0burboxvomi/LfkRj+SjzFCWIaVosjbAYF5xGE3tcyYdA7w4lVKVBw39HbWozDWlt6FnjAfbhQma4bbDJdYzlDeSuZzWGqy6XWHu4ExxnVBx5p7cf0zIZkGUchdNO09u7GoLz4+jNa+Ys/rAa1+haDQtt4qLP6B29G+0oa25msn8EOj0+iqWpKhpnm8tOLavy2QHue633mWhawgQMVawRtAvugqGo1qk9ZnipSgqWbVcMzN6E2/Cv586LUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 02:28:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:28:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Convert dmar_ats_supported() to return
 bool
Thread-Topic: [PATCH 1/2] iommu/vt-d: Convert dmar_ats_supported() to return
 bool
Thread-Index: AQHaxfdH2nefaKkk/E2Dhiw3bjjY67HXwqrA
Date: Tue, 25 Jun 2024 02:28:19 +0000
Message-ID: <BN9PR11MB527675688BB9B811F3C3AB9A8CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240624052501.253405-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240624052501.253405-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5057:EE_
x-ms-office365-filtering-correlation-id: 026e6de0-50dc-4151-4fba-08dc94be7a84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?6KbddoeEJvz3zaFT3FdPeNTIpWtfZwrTKP/TS6g5fs02nI/339yfRVjhUQ4c?=
 =?us-ascii?Q?uieCQanY2ULYhBTlzKM5d8HUDkEHaxB9dLM63GnK+k6X/z4neam72w8CFoKZ?=
 =?us-ascii?Q?k9t8Ws0Ds2xLXAQiYU6m3+5wslaaSpVB97CbZSm6SBPbKCWhOQxStIxjUucE?=
 =?us-ascii?Q?OxCLS0Pq028LNfGicE8DgbrIG7qMxDrNh50w39h+ztxs9bjHyDJBqxELgHHt?=
 =?us-ascii?Q?YbYEegDZ48SjenFcb9q9hKEUbB5djlDqC2Mh7sxZsu0d63BHunXz5g1VRjie?=
 =?us-ascii?Q?kQ6kjIQyr9HGDBjhLd3linLw+GdkgS/nTVqw9QVvW2HGOTwE1kSrkPSst59V?=
 =?us-ascii?Q?EnpqVq7OpYqzUG2J5n5UkOyBnFXLukwbby2VaWaUQb/lI+WFCMJrK0opz/xn?=
 =?us-ascii?Q?b09usgU6suupWNab7noWGhIRtOr38K6LTEmbGmRyIl6fSqsXSc22xjzRTcWO?=
 =?us-ascii?Q?PTYWIGAvJCHU6vaSB4NMZHc1WDo5H8x3SEdNrVb1Msr2rRzm/CiGISAK6cau?=
 =?us-ascii?Q?CvFmr2GXr7mQ65xFu8Nq5BJ1Zw/DhtXH4eNR53DZrj180ppxrNibbVGsemRh?=
 =?us-ascii?Q?92BlFvlAPWWQBKNbECS9lOd3vy+LtwoE32zpqVUmd3CbaIpO5fz2tfQrYnGX?=
 =?us-ascii?Q?PXoEHs9TdNUk3WBr/DUa9d1UIj/ERQcuBmDVABhrBiqi7Qn2CDkFH6sWsQef?=
 =?us-ascii?Q?LNJMcUwYhXqgNDlFMFR5CMCsv9ObGnyJYb/FGwpuuRkaty6ZjbEdAj2BavPW?=
 =?us-ascii?Q?+7OGgdWTOpvWuFuJuqPTQ+FX98VBwo2NdLxZB7SEiq+Q7TB5qJ/gyRc0MFpJ?=
 =?us-ascii?Q?xaY7tZ3VuKW5oUM0XPDmquiKKX6EnhyBozgnP8mCGUdkxKFPbQL2fGgWGacN?=
 =?us-ascii?Q?Zq/X7g1mSSRHbTaowt1k+6Ic+SAvi2voizzr50FM9NWT6iTNjWiYKxrmrZu6?=
 =?us-ascii?Q?I6PTad0/vpRbeBNk1VT+d3Q6wmiOLIdrwJSRmgjDYARbD9KzuaAKmkm7fjEL?=
 =?us-ascii?Q?Z6B4SPJ+FjiIqCzbTHxRHmuwGvMgnTv8GCpRZHH0ZgsBaEQotK4y2u5sy/xK?=
 =?us-ascii?Q?+4lur851c1s8BfAld1tTS2xaZSDUbYPpqJsyTmqoAAe2Ie59dnUPly08qI0m?=
 =?us-ascii?Q?cORGOxJmxlSsMbfP0vU8sERRkdf9nx9n0CY5lEdLNBapzO9CiHSQnqxsvWKl?=
 =?us-ascii?Q?XcW37eE10YP0vqnZisO6Bfou0htbg0pT6mFeT6y4JiT6tawymm9Ao4JrL88p?=
 =?us-ascii?Q?IaH0B7MB5IssD0MXuGmKA8ztfANNw+7v4+2FDafRR5voyLLS9qVvSRgNn0Es?=
 =?us-ascii?Q?Ke56H524QIXLTJU3E184dPuYDwsuaXr/agSTULMSS0YaJqccBGkXaYJE/a9A?=
 =?us-ascii?Q?yTsv0nk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CnjUuogkhTXybhjpQyXvbQLkP6T12bDhkAagLfV46sS/dTOdgz35Y/0jqeLp?=
 =?us-ascii?Q?yq+2CvSGASXM+k/lxjuMtRyZybaObMSwV8LwlcHRw57V+5XlInzEY00vV30p?=
 =?us-ascii?Q?CInJUYkPRCUvB6Fk/ojoAqLo5YIj3xmutik9iDTXD3uM/v/jGLEz91HpXZ4u?=
 =?us-ascii?Q?FsbYD96YUJWNPyrGC0xsyaUTWfkVMLdK0/KpF7VyUFh7H2/v6LKMhBOBDnBD?=
 =?us-ascii?Q?KEcEvzvx2eF+ACB3SjixRnDka9ANb0EOVSedq11NGrqyfwGcounUp/J3XKLx?=
 =?us-ascii?Q?mEYNQc83rZXDUWMC+yXPbgnU6El7bfcg/fNkWGrgcxJbsOaRiQJJqs/qwg1t?=
 =?us-ascii?Q?BN12TQ6jojIokfwma3RyX2bySqIoPQC3JDQCTQduboynzHuk+Tk0zJA6YkMO?=
 =?us-ascii?Q?kS/9Xp5XYbwysKjuiiiPbEM35IoFBtj2W7Pjp/E+jwXhiI7gtf6NLTYAodN5?=
 =?us-ascii?Q?+2lkFNPvzB95Fhxt0KMkQjyQVG1d0vAVN8Aw11ZCgRr/8JVBJnJ864CBfYKh?=
 =?us-ascii?Q?ttGbJqlULIra6t0q5CyKwL+EE9NcEUFc0aV5pqrabTnuElhPoOAOLVqSKEM+?=
 =?us-ascii?Q?g64FOok6VP0RfAaso7XCEsbBA/rftMZ2zxCnZFaAxLQKfGxhHnXVZQNHS9CR?=
 =?us-ascii?Q?5w8bu6P9gH4+63JaMT9clqrFDPmzIaArjjO27ItgVTgZeoxr85aWlTuSPjir?=
 =?us-ascii?Q?aw7+XafZP6xB4t91ZVyvw7iGcW5mSJq5DhNdmawtg4x3F5kFjZDXI3QMEzgo?=
 =?us-ascii?Q?V3GZym4qoxOuBP55NWJtnp3zZIGV8o3bQcqNM+T9rrQETUpeExdcMCT720aJ?=
 =?us-ascii?Q?QD432wQK4HfeLid2OEUggLlG0sLcFID4bHTr4jL4nrlnBuIulgTBLPo5i/qB?=
 =?us-ascii?Q?nbMqfcKk2I90m9Evuupm+VM6Y40xWq0GWrif6oRc5YBwyWJvFfEyxtQqZYlO?=
 =?us-ascii?Q?qBsKqA0v2hg55JLHEDLsVFD+wTh/iLGK+b4IY8m1Vzi/A0Vp8hphjeL03uq0?=
 =?us-ascii?Q?3jblKA0BB5sc7BqpmsUBl5IMS3NXFtqtcJmJNA1oqbJKXog1O/gv1Rhl4mbJ?=
 =?us-ascii?Q?15DhtL+avdK6/UoG9QiVpENfmATeiBzjf5ujCfUUOjLO7QWtLmOUR4qD/vXC?=
 =?us-ascii?Q?5DXx+Qg2zLE7tNHwyTLSGDIwte/nPaMS/bd12GDSjsSK1YSUtjsdT+p32Y+q?=
 =?us-ascii?Q?O5JOoUPgpy+CU/ysIWUqSWZDS+ItRpshviKjIuNuYGrqqKIGBhx1fdWdxgmO?=
 =?us-ascii?Q?d7jzHgAY8BRmxN6h6zHVgZx1EXKXfl25ZMTlF4XVIYD4Mi3yajvlT5DG8n+O?=
 =?us-ascii?Q?xALnDX8ZoPG3O7Xxn6fHjjyh+xvUUzIo7qMm/F/w1rHVtsdqv+WLX5zvCHcV?=
 =?us-ascii?Q?+cCET4YfXcA+mn+lKLskeVFwV+2drOeheQoc1UGkXSNFbhUvHaZvZ+PFfU0u?=
 =?us-ascii?Q?A3zNI+eIv/22jfgk5nkGFYsx/y5TUacRLtZWvZmS54KaqD3nWtGlfDnE7+ht?=
 =?us-ascii?Q?97WsNOpmRo7zKO5dtzwj+e/blkiH1CHy9RAHp3nayWGVn5GgQhxDEoKP8HnU?=
 =?us-ascii?Q?LV5nPzMYwm6dRpQTS7KNImMWqhx3dl93ychfxDPj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e6de0-50dc-4151-4fba-08dc94be7a84
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 02:28:19.9892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZptNqF3CjtzZx3T0khjFhNaJcHYGrhC7Y+ETQOn4lNUgSC9D2MsB6j/1To4iVGShQVSR+xMJlOG8cQD6YoqSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, June 24, 2024 1:25 PM
>=20
> dmar_ats_supported() returns an integer that is used as a boolean. Since
> it all it needs is to return true or false, change the return type from
> int to bool to make it a bit more readable and obvious.
>=20
> Cleanup this helper accordingly with no functional change intended.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
