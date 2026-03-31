Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7643BE166
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941153; cv=fail; b=BNGV1M7f75xhsOJvZU9Zx674DmW/K6jUkE6zgaRecSLkKMAUEGPB53/91likzqk8Q/l8UpcHc863yBEy7AxZoBTTvr5xyeD8e7IFhalIbqlxLiyGyNvVOJbc3Lzh3a6XQC58UhKXVA6VD1dvY6z7gjAWtTbVqxotE+Jsq6keoY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941153; c=relaxed/simple;
	bh=GD5Pk6/62b0jmdQXM0Ge5NZYz4IVYq1GDIzmAoOudO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UqocqnFkRnSHYMg85bvphKkCWkMVXWZmNSGXZz5A+XC3jr42RVnoUDUhfQnykhGuUcAGdnsYzUH7/6x44wtg4udHk0hPp33X5R4AmwkenXXsaWxJNgTGLNwp5o1lAqNBQ8JaqoRtVk2IvUIlcmFggxMpqo8E5La9vsPCwxzxaCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QrflbwWA; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QrflbwWA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774941150; x=1806477150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GD5Pk6/62b0jmdQXM0Ge5NZYz4IVYq1GDIzmAoOudO8=;
  b=QrflbwWASPwU0j2gvWFgE87dRuyT8cS4mKFucKYZiKLqEZcNiMYp9/Pd
   yU21IXH7DZu3saFgThTtMbtPD3uIeVWheecHVLnF9GeIqWAIwlMdF1ytz
   37g/Ak6MaLbYBhEFZIbvxtfIvfXiEujs9Fm1Yjv1+kczbr3HzFU+7+k8E
   j5bzJHNL7UBTB2GyFrZccZiysHVC0Ubt518MlTvIVv+KfekSjaIgUj8gs
   Y1isQkfXCvrZq+x/hlvPU/mEyV74gDIsBfqRUb2HITVN//LxpOJBvlT4G
   F60e47yboSSTegPb+wYnSs6ulBUcKweqnw2yMpdhBuB9WEQ/UrXYCSXTB
   g==;
X-CSE-ConnectionGUID: O5RybtGGRyGudftc0dLq9w==
X-CSE-MsgGUID: tfdhRT1vSqeLpfVYFl26Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86638303"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="86638303"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:12:29 -0700
X-CSE-ConnectionGUID: ajufDYpGTIGbcx4Hz3qU5g==
X-CSE-MsgGUID: SxQkEZrRRMWYkvll1+fq8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="231212472"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 00:12:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:12:28 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:12:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwFLD4rtTfr53L1QvU2fBsOsIpTgEbl+V7tuA9WjnNFhFaGNGSX/SthZqhJm3SiB3BNMIudWCFojzalW4QLeNjz6UZ7uIbjZs1tJUHHi3SgnGCOpaf8TQppdlIyGkdoUVfFgVp0vw+FxjB/K7WPrcoT4lax2ykItJxkHyQKbFZA4TuiBMWH9oIwZN6Wm852aiWcXodbluX90wkA0rsJVPV5JhtR8oWG8+87aN1RPNm5V2198VaMp+NHZYEpXOWCIwfjBxEEdOXFgkqBou2oZiBpyxl0sIKyQhta1lREw8i8qoXaEJ4eKybq2SItFiz0efb78PfPd3z5+71vowwNxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bxNCjxwwATTDTY0qyDDB/g6MD2jA7bmyFILAqsvBCI=;
 b=jKRPB8HhoeXVfW5amPrRHjBmeCXqjxgV5a4O/pefBI706AkNhmYygOw9H1oUZTSbf+Rma7xCmlMjQmjStVgaxJf4oH2Y5Yc46o1OdcddLG5YqHUcy1lAzhMxBNTFSj+eehAjQtTU1279/LAb8JcVIep1EWMWrfpQp1YiRUC5XklvmSfaHANgKmYypuD2H1Kw2EEBYO4Cj5ynxL1K69gIFqBK6WD+TO0PCVweMxSwKcIGtRSbIHl3Q1k9QkmzfFVBtyZabXEakbYQLL9uyHQNjOUhW3oi+Qp5F3w9lzRYJlGHFob6BFnhIsevGKJcUE1dNPdVuGLlK58QTemg1uMGmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 07:12:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:12:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Shuai Xue <xueshuai@linux.alibaba.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Topic: [PATCH rc v2] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Thread-Index: AQHct1nA8/bevmQlI06FieDQx+fC6rW1tF6AgACtTYCAC7R14IAA1ugAgAVeezA=
Date: Tue, 31 Mar 2026 07:12:19 +0000
Message-ID: <BN9PR11MB52763033F10069ECD005AAB08C53A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260319043135.1153534-1-nicolinc@nvidia.com>
 <dd72f3be-16d9-4386-82ac-1b8e06186e3d@linux.alibaba.com>
 <abxr7XrsK1WSmr7T@Asurada-Nvidia>
 <BN9PR11MB5276A9067B8D8FE3CB899B2F8C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <acbx0NYGq6BOiSDl@nvidia.com>
In-Reply-To: <acbx0NYGq6BOiSDl@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: f4421faa-94f2-43fe-b69a-08de8ef4d902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: VhBWxzP+3v1Wm/pzCRjAo7mq+yPGWiaLhsAiZOmhKtKQk+Tid7OpKddCXP/vmqmXmyEhXLAZoco7zr2W45f9I8Rx7yQGxLam9IbKazmG4W8y94Nv2kDhOKJWhfWdZJ3tsGZapd2mVernEa+9bj61r0HiFwIBez08Ax9mCsE2w2CSQBWowNTcRVEAaybhCfpM3Y7lss4N9IdrKL/KW0QhfdWbHNXOal68CeEFbTscA49PpjwECmi1rF/kN3Vi4MDsVseXbhCycCMfyWdyIHI7/pmHPP55ZVBk/Nj57FohDx1BzeYLOVwwUDdwVDabBfFmethk1MMF/eGgb0FehwP//lXO3IwyhCMezqRGwJCQLwFCrPCVN5Pk4HILBNi4nZIdeJK62kWNsvwlfpegjedBAU9tN+TdXVTSoN9FBtbM6mmqAG2QLw7hwvCGJRY38hidh1jcij6AG5MuJH9tKOzhxWa2WGfUVBxrf+CDsPYQCddPCHSuyJPsBry59O5+nPR8WGPTcF/28stJv4tideh8doYIAI47fTmNqyyy9NhFZqjAKAoRoFvtYQi6shIWEmKI20g44kssPpTh/xknEIdEqAo1Tl/wrVBqrM6P5oEuZp/C7IbLp95RVUlDxzzRpO6p8r5lQFBv9dekxr7GOq4ygr4x00dx8fKWX37Ve5o4AuZzGqonn/UYd7+M1LIQT+MvZ6v9kfqNtdawqXbnUusM3NSF1AqJR8KZaYjtBMgsfz7I3Ukf5dqfkz9vTF5L0Px2DzBBQHYpgcHJghC2TNqYk6cBdyGLKxM+sxTstgxbZP8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?szIv5md3OC5B81YdGKxXd5O8d49c7uqLKGNSZUmyskSGHwLpnwKHDE1JK+tl?=
 =?us-ascii?Q?zX6mi+rAD+XptIC3WDWrSBYrQkERId32sWh/eiuVRvP1QqBkmz4+ghrROJh6?=
 =?us-ascii?Q?Kyq2YJu3g8ypxTOFG2/+MAcLm9Ig1w+z7xJDtZjTc+saJZVbwAWDt6Mny8Bx?=
 =?us-ascii?Q?T3uAnfnghG/NfMJAsSSOiShZB+q1FwH/+r7YtQmEKQ5r8oAN3bCmxwh4zL3n?=
 =?us-ascii?Q?iBToM9VMj4XT/9A39zUrAEih873kyzIf6e3KbLhEyt9F/6z+WxRLmvkzRF/8?=
 =?us-ascii?Q?JBu9/D8JFOYjVoqazXIMpptjVzDiTukMu/BO1B3Wf2KoUe3+xGw1aKzCPPCG?=
 =?us-ascii?Q?curTy/e7JqT7dlTFKqfblyJQyfBtE4C0p3W+6wUT7nQB3VZTGjwOBaR2mFUi?=
 =?us-ascii?Q?kXKoNpZsjjAC9G2M70ygB7KJao3CEjyiIEadTSnMSM9uTyXvDcq+HcCZa+Y5?=
 =?us-ascii?Q?K4rB+Qd6GvrUYR5nG8dtkkdpoLOhPxMrAs/kRQTR6N66WRbOxioSYcJhi+NR?=
 =?us-ascii?Q?RSZnXef0f5kBr6B1ZN+evftCqLDEdEY/hd5J20VlQimivhGEINzgOE8zpwby?=
 =?us-ascii?Q?5PitjAmKNptFt3hblbM1SiZtJRtwvFrcP0yf3VjbXpTN+DxuxD6l2bzwFuGi?=
 =?us-ascii?Q?sHcD/oj0wvVRQ0Ba9etpOQrwsAt9vDZV7Ej0x9jTXwDAfe0YMskArlJDucgH?=
 =?us-ascii?Q?uEFpqxykFrHH/SAJEAM6rztXDlCs3V2qax1TgAMh/xekimmQSuJedkZqm6s5?=
 =?us-ascii?Q?+J5+3aL8kGG8XHYLTPHvTyjdDRNXhe4AJGO85NMSg+hLQPfW8U8RVl/jYA6m?=
 =?us-ascii?Q?VFu6IMJE+ol4VkU2mlOhT074jEtnfbahlkwHC6xSUuzvjZNzsEhn0n5bVKKE?=
 =?us-ascii?Q?ET4IJkzTIDAXRNHRGHSX3Tqix393XrZl2GRo5SjOmhZbMx010qEsIIFhazf5?=
 =?us-ascii?Q?RSRnnyHpqAvby/tACBt+pemMrHeaQ/wFDuR9UHFZ1iyrihSHA9Dkc5PutoWO?=
 =?us-ascii?Q?SvROKkNtTT59j9WeCu65Y7k9lzkTFBFfjj2f2aNvfDkL0jdoE52GFSybEqTw?=
 =?us-ascii?Q?aTztXVjlAxMNDiZtQWyZ/kPzXCAS+nF0xmK/9+RNP3pmangqx49LVNJt2ar3?=
 =?us-ascii?Q?OUHPHIz1yNRBJ0j0AxmlrumCacjwpj/FMX9qsLU69+/3K8Yh+dcSsbFtu9zx?=
 =?us-ascii?Q?0A1twExEENjNdeylN2UfnUaOni40o/iNIAwrxp00ZgbWO5ot+enavJsPrddg?=
 =?us-ascii?Q?ciclakQiTUyJal1URLeVGa8wCrPBlz7I8geMJMWwQkUpdepz0ig8/TbfvK9Z?=
 =?us-ascii?Q?J3MX8PzmZLllt9g6P4XISJp/YocjgOr2CJ1Ha3oxIcGOQezgHVbirosPCLt6?=
 =?us-ascii?Q?NKL5rK6EtOeVNCVybfpV2H5p6ipyh3VtOwAqJTkFlaDq+b1tqG9BHoU3nyCe?=
 =?us-ascii?Q?Jo7Bd5LHbeyvPCTppQ8hXxPM0B3L0SBPbo4yvxkUtDh2gPblJ0wpXqgLHZYd?=
 =?us-ascii?Q?RMOET5jU6Su8Suyt9PW+n+jKjqhTR9vfFKScHMAXELoz06pwjsz3/1ynPErx?=
 =?us-ascii?Q?6SmOuLGnRNZgaQbeTlgTQ2bsdCM6ZICt+UqChhe7139zpJSIZ7NmRrcT0A8X?=
 =?us-ascii?Q?ndRMbZcBjReV4A5rf6Nbe0buQg/aYyysJkgwhRuD76rowxczFxopV6l6fHnL?=
 =?us-ascii?Q?NGtGcCYs+15J211ErRXGOQdPoAaZxRWt5p08vsZzohCv4fxY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PUMGYouTv8q2nPlMSCOOa19OSjgY3Et3VJEVWi+jTksP2obhJp1RObf7wS0GkYgkHeargZhb1NiQzrCCahKrgY2v1O2urY66LaqFCJqRshe26H/S92+7t7S+6veTz7GNytpAUDw7yRISJfXSB0wsbtG67Ir+i/Y+HxhoiWnnprQqbAlDGC6hOWvQj/kjZjOkBQ3cGeLuNHctJg5qv0qTm7nqs/KjPJX6KIXI/vfvARnLcHINLZ7ghor2jPdx4xaKHtE1nX2P8FyQz0B0Ap6hQ04aVM0PdakOQ0TurjkCCEzRqI1Kn8QzM8qf1l9dldOypUg+fUlHkqb1h93rFfqqDw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4421faa-94f2-43fe-b69a-08de8ef4d902
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:12:19.6662
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82kjgFl18T7uOav2GHjHNZlvIpKNhBjnri7/FOmg+/jrihAAe2Zfc2SaZmhyY7x5LA89ppO0Nf22uan9E1/REQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, March 28, 2026 5:09 AM
>=20
> On Fri, Mar 27, 2026 at 08:27:12AM +0000, Tian, Kevin wrote:
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, March 20, 2026 5:35 AM
> > >
> > > On Thu, Mar 19, 2026 at 07:14:21PM +0800, Shuai Xue wrote:
> > > > On 3/19/26 12:31 PM, Nicolin Chen wrote:
> > > > > @@ -3961,9 +3962,10 @@ int pci_dev_reset_iommu_prepare(struct
> > > pci_dev *pdev)
> > > > >   	guard(mutex)(&group->mutex);
> > > > > -	/* Re-entry is not allowed */
> > > > > -	if (WARN_ON(group->resetting_domain))
> > > > > -		return -EBUSY;
> > > > > +	if (group->resetting_domain) {
> > > > > +		group->reset_cnt++;
> > > > > +		return 0;
> > > > > +	}
> > > > >   	ret =3D __iommu_group_alloc_blocking_domain(group);
> > > >
> > > > pci_dev_reset_iommu_prepare/done() have NO singleton group check.
> > > > They operate on the specific pdev passed in, but use group-wide
> > > > state (resetting_domain, reset_cnt) to track the reset lifecycle.
> > > >
> > > > Interestingly, the broken_worker in patch 3 of the ATC timeout
> > > > series DOES have an explicit singleton check:
> > > >
> > > >   if (list_is_singular(&group->devices)) {
> > > >       /* Note: only support group with a single device */
> > > >
> > > > This reveals an implicit assumption: the entire prepare/done
> > > > mechanism works correctly only for singleton groups. For
> > > > multi-device groups:
> > > >
> > > >   - prepare() only detaches the specific pdev, leaving other
> > > >     devices in the group still attached to the original domain
> >
> > no, attach is per-group. all devices are changed together.
>=20
> I think prepare() should use the per-device ops:
>     ops->attach_dev (via __iommu_attach_device)
>     ops->set_dev_pasid
> right?

it's per-device op but the condition of calling it is per-group:

        if (group->domain !=3D group->blocking_domain) {
                ret =3D __iommu_attach_device(group->blocking_domain, &pdev=
->dev,
                                            group->domain);
                if (ret)
                        return ret;
        }

>=20
> And it is intended to limit to the resetting device only. Other
> devices in the group can still stay in the attached domain, but
> they cannot do new attachment (-EBUSY) because that's per-group.

how could other devices stay in the attached domain?

>=20
> > > >   - The group-wide resetting_domain/reset_cnt state can be
> > > >     corrupted by concurrent resets on different devices (as
> > > >     discussed above)
> > >
> > > That's a phenomenal catch!
> > >
> > > I think we shall have a reset_ndevs in the group and a reset_depth
> > > in the gdev.
> > >
> >
> > I didn't get how the state might be corrupted.
> >
> > If there are two devices in a group both being reset, you only
> > want to switch back to the original domain after both devices
> > have finished reset.
> >
> > so a reset_cnt is sufficient to cover both scenarios:
> >
> > - nested prepare/done in a single device resetting path
> > - concurrent prepare/done in multiple devices resetting paths
>=20
> Since prepare() is per-device, the per-group reset_cnt wouldn't
> be sufficient if one device is resetting while the other isn't.
>=20
> iommu_driver_get_domain_for_dev() for example would return the
> blocking_domain for both devices, but physically only the first
> device is attached to blocking_domain.

what do you mean by 'physically'?

>=20
> > v4 is way too complex. Probably it's required in the following
> > ATS timeout series (which I haven't thought about carefully).
> > but for the fix here seems a simple logic like v2 does is ok?
>=20
> I think v4 is the way to go, unless we fundamentally limit this
> API (and the followup ATS timeout series) to singleton groups.

currently we don't have any per-device resetting logic. As a rc
fix I didn't see the point of making it complex.

>=20
> FWIW, I have the ATS timeout series updated (waiting for some
> finalization of this base patch):
> https://github.com/nicolinc/iommufd/commits/smmuv3_atc_timeout-v3/
> The new iommu_report_device_broken() is changed to per-gdev.
>=20
