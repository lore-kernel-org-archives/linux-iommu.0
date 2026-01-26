Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A231197F
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414194; cv=fail; b=ObzsOxmYTOyyavWd/M/MImheqxIzPqJ4MfoOllukgHNc0ArRhHBWoFhbDWouAFyQIfZC3dmoTJmiK9fgkhICf8ZgVkpGrMAARq1fpjtV46BmMjYpqnX+Sm+aBqZLFtavMsphRqR/HE254nTLw2aq5sWtLDXmKftYSiraWLGNC+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414194; c=relaxed/simple;
	bh=6NV7lXmeisykR71KpI5VWjaCTBSqHI9i7m/ES8aoVJw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iKBcuvZrHvBJiOQKSPiw/eKl07NKYdJoOyw+te9TflTV3UgrJbWRyEWfeI7FOxKTGHUexm9vkEQtbKejnDbQZX2aGflGLaoziwOFz2UfTBflCebl14tlC6+KbER/zaScxR3e132vemVmiMp9SNOvue3yduLhKvH0+o12spl0edw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SipMhXoY; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SipMhXoY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769414192; x=1800950192;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6NV7lXmeisykR71KpI5VWjaCTBSqHI9i7m/ES8aoVJw=;
  b=SipMhXoYqZdq2hdK8hrDgc2+jHIj31wkTcQrlBcusBjMWIbVXzvIVZhR
   LwQ6b00zh9KKZjs3NpxifPQlPfbdUnePBXzv8EzRSvwhbaqFwVC9GrDbj
   j5zIwpmfTJ3qupVEDfb4ayTPGCZINGIEW2FxKnkHSRRaCpAaNKW2BpBQp
   1V5Q659rdeFofomFuV8P54hn0nEOboZrUBCKutj0JAXRLbWXZumCQm0Km
   j+RFpuPKf+a2T55bEaVB3OD5KkPpCqBRjPBaUcSnd5HnJlCac1AsmYUbV
   eq54qD928SSmXQdTwW8LGiouiFu71X2XJfqZOTA13/mMvayFd8ILxG83c
   w==;
X-CSE-ConnectionGUID: XTba9dAxQgOAeuC40lMprQ==
X-CSE-MsgGUID: DIQUMiPuTs+zKRDcF/ZZnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="73176206"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="73176206"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 23:56:31 -0800
X-CSE-ConnectionGUID: JxSQfZtmShuaUrE3+rASrA==
X-CSE-MsgGUID: PtrMaVusQcKbcxvBtxMAkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="245228359"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 23:56:26 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 23:56:20 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 25 Jan 2026 23:56:20 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 25 Jan 2026 23:56:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uttd5CCSo5KdPstSFoSBnFwux5XC294fak6g8AnzCmyQ5YbjkU8g45qzeZyo0zaIG7WhmVv0xs/ZQyKXhMEGT13IziZQIdIpspuAXZ79KLaObirkTVot8h2aFGc4llcSELQRwErnN+mpKYKIDG/EgvMfdgLDSWfc4nyD7lbihXJgV6hqmHrrP+62yWsTk7ZWA09sE8lMB8eYkflzkcQJOTD1d1O8HLTFznhgaZl/M3Podwhxt32CQEKppE2pg4GmefpnurzkBKP855yoOFtXc5TdVZz16fh6Dp4TTJmOEFXM8Qh8bEnx+PPvEhlotsS/40Of+EQ346SRGmpmzMF4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NV7lXmeisykR71KpI5VWjaCTBSqHI9i7m/ES8aoVJw=;
 b=zAi78EUSEOKoJSesYKT20vwdlePARWno62KCYI7zPeMH2QCGBTJLRfjpijtvog93wR3/iXL/jH+QG/CFVNPC1f5moNOfUxEag/0yrh9NNQY9p76YAPfbSKJbe/RwNV/n5apzT2vRRf34RYVPb7IM77zt2m24nIVDVFc2HdtpdisKXw17QWq9xcLI0tb80bwpT7msPuGwCZsfn9qMbFFQOUu62FV9TEQSWBFZTmYJRgpuyTuCppbw8QLEKoGSYTft861cj3EulxKR+o4UivtvDaFdngpzk5jPZOl3QcQd5TDUHeImZMYYT7NoVlTPOoUQiQBl8iJrvcZEXy3wMnt72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS4PPFE396822D5.namprd11.prod.outlook.com (2603:10b6:f:fc02::59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:56:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:56:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"syzbot+df28076a30d726933015@syzkaller.appspotmail.com"
	<syzbot+df28076a30d726933015@syzkaller.appspotmail.com>
Subject: RE: [PATCH] iommufd: Initialize batch->kind in batch_clear()
Thread-Topic: [PATCH] iommufd: Initialize batch->kind in batch_clear()
Thread-Index: AQHcjTSDT4iBCgne/kiB4xDHHvbVDbVkF93g
Date: Mon, 26 Jan 2026 07:56:18 +0000
Message-ID: <BN9PR11MB52767CBC338D081AC8D753C58C93A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260124132214.624041-1-kartikey406@gmail.com>
In-Reply-To: <20260124132214.624041-1-kartikey406@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS4PPFE396822D5:EE_
x-ms-office365-filtering-correlation-id: 7ae498f6-f697-4f98-7f27-08de5cb0635a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?QKJQc/pYxl5D6QmfBoCz5KLkiTGqSGjQV0o7fR+d5bYzB7ftQfItuHe5Itsa?=
 =?us-ascii?Q?5EPLmDg7rsktVKJlJ8uAkICp1n2vARNRta2johIVwHqf7I0Qvhaes1uD4YSB?=
 =?us-ascii?Q?YQSDE6Pguvpu5zdsG/fw0J9ynKk0dplhophsokbEyerPkoCT+kyNqNNZ2Ssi?=
 =?us-ascii?Q?Pp2CkSvdv9NQ6O6DZf/FOtHRUTOWrql7cUibhpHUsYLVWpMG9UxXnMIzAfGx?=
 =?us-ascii?Q?6zegcJE9+o7D7b4WbT+F2VYckFdqs333OekcaZs44LoZKdcdl0YX0YvK6gl0?=
 =?us-ascii?Q?Lf9IqA1tbu6KxKCbGtKAbARU2HtDRD0sbz8lnsos5YBvkJHVUHqpjnMJyprS?=
 =?us-ascii?Q?RLxg2+YxIunB4x9qbvDh4Qip3s72/dwB1opnWXYxwko2JQ9n8GlpEIRwlpbc?=
 =?us-ascii?Q?+AKZVdRE+WmyalKvwxzGxz9WfBWxMQMal67lDddToAHhfHC5S9+y+L0qEh8k?=
 =?us-ascii?Q?tyWpx8vpynLma5DWQpy7aERGWEgW+na8gusxiCc6lzMpAL/SoBrqrrgGImTk?=
 =?us-ascii?Q?49V8N+pbaUvf1oN5GcJIt7hZpmnIGkiOAda+TD2xFhVAZX8hrqw891saLKYg?=
 =?us-ascii?Q?ZwoF5C+SGeJfWADeYacL4fD6tjjTquOu1SapoGVQcyT4B0kG76II4dGuG0SV?=
 =?us-ascii?Q?18KlZGKgFpOs0ZLIzpnopqxtzpcZxqgOaJxW8tXkSGxBxTUG21d4KCWatv7B?=
 =?us-ascii?Q?UVQBI8EKjv2mC/AnNhDiHlsEzs6w+UW4au64FNhLWEY+SG0uQwZtWx9rmAp8?=
 =?us-ascii?Q?Ycs8MHkjcsKn9WxQc11N2FWxZfRxGl2kSjDz3aY2Fnl2jzLrZ+exMePHj0mX?=
 =?us-ascii?Q?2kBnZ2aNnWiRHo3Sn1R05QpI84R5MH7ilNpZ+y0I7eobPauftOjqIawpFf89?=
 =?us-ascii?Q?pwrrI7/lcPqx2x6IDwBOm1pckS2uXDQkj3eIS3bf03Tq4fOMyz5oJeHm4Ne9?=
 =?us-ascii?Q?kNpRuiX4ziRlR4DjoeA8efvgmruwvhfDsy1nnwzlvfV6aoSrj/WLat+tjSzc?=
 =?us-ascii?Q?GjEjoevenU5/Tkxx0IGAddmFOCfiz0+kwmZHnsCyJIkXMarhPFuEiA4K5vDq?=
 =?us-ascii?Q?iWksB23ZgJ4H1PcVcqkXjNMcEHw2cHwGY+tl+qDTyW4fH1Hxi+jDTozPGWLV?=
 =?us-ascii?Q?x/2+Pixn1geYy1NaHueMmIYSXZfRWEL+pQtsYCjM3VWmIHSrHfFKZTKNwSBf?=
 =?us-ascii?Q?QpfBfeStm+Ltztmxagg4zmAp0vktiupfDh5D46NOVo8UI2JhByRkTRg9qsOw?=
 =?us-ascii?Q?eVGruIXNFztzRL/1cxMTSj8U2SrZBjsOLUUM2ytcd0pixscT4eweOlscS9k9?=
 =?us-ascii?Q?vLoBiCImnLPV45nIAbasbD0ArCnShNkQHa+Ajgml+YxvmIausMuptZYLM3wE?=
 =?us-ascii?Q?UXKK6H1XH7GTeLdHspQSkpg/rWTMNgLF+arpA38gI+qWxXIPn9XvieGuQKqt?=
 =?us-ascii?Q?kmfkDk2goNOCVMdQqQ9HIK+7BLvYYjSHBIZ8n3NRZBrcPojEPUIy630SIC18?=
 =?us-ascii?Q?7Li1nthqPQO1xdg08jlD0zYB5nn36XamqRE9OaZ0ONkyme8Tiqo/338K/IaT?=
 =?us-ascii?Q?eVh7M79BexcleGrcXbg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uRvKDa3frfmQxUpNZwP4472cNjOIibpNIMF2jTesLAsT+18cqV0YooFMAvlc?=
 =?us-ascii?Q?HWOcUEAJNLUxdgIZX7z0rW/P4r9LDDCdJkB+lgJxew9Gn/DhW3GLg1S3S8Y7?=
 =?us-ascii?Q?oGgLAvl/oBkwdXfE9HnSfgNHpVvT+QhMJNhDEpCZWvRoOBP8E62wE+MHctUM?=
 =?us-ascii?Q?Id+D3uQ1aIwB7jDof0/uIAAhrUJFafqsZJqNhtxiT/7v8X0ZNQdNgYcivT0d?=
 =?us-ascii?Q?9cSo95jzpniCteRh3MdcJYICxmVhs2j5CBIltbXLOrFjpow3iQxpH97Hybkc?=
 =?us-ascii?Q?UDmAmgIg4Yr3PdHhb827artKmIAuQDuY3S5LNA9YtbOwryZoS6NX2AH7Qtar?=
 =?us-ascii?Q?bGkhe8T3XPGx/YxnUKIFZKB63gw23y+3smEePmF3hrW5ccs2STaq2Ui4//ex?=
 =?us-ascii?Q?qMpw/B0/QBuIX8TYHv3AWK8c4P46fPK8bEWDuH3dU9ulArcT27Rjmn9bCy+s?=
 =?us-ascii?Q?Mx4hGuomSniXEPwJuxP+UyBRsZQb5QeexYRZn3io7oKPufCj4uNPd2rL5ASw?=
 =?us-ascii?Q?EJkPGoaH9y6TXyzuARejYIIpDp/9czDk7PADX9WQBc95UljedkIEErb72bni?=
 =?us-ascii?Q?VgKz/bGeRTZH2RQ/hfeWZZmtod/fGQaMLJJ+YrXWbDu+D7Uaep5hisvA+HTQ?=
 =?us-ascii?Q?sGkrazI9ed17MbDgYhxXiyxJimtCchBSOqWKJsxEOLTGxlNOjoa9IYWRYI0S?=
 =?us-ascii?Q?vx4+i+lgqEyPnsBJMDSVSBPKakhrlQVZ6I+zSWRvp8f/H1HJpp+sOprcMohm?=
 =?us-ascii?Q?6c8GNTlqVBVxU6EYB1AK8whQrEO/80sv/e1BGL21PRPVnl09fHTgEU1eD2N/?=
 =?us-ascii?Q?NMD2yuwFCTOXe3IhiHpptH34MbDGiZPDWpeNAmlFiSaDLzkhFtU5MJJZTPSv?=
 =?us-ascii?Q?EPBAnduiRT5zyupCbEA8JPG2ODgbnxvYQ/ehFyr02uhQXYvEo8II+d35XMxh?=
 =?us-ascii?Q?53Ox1Gvvm7sYRgJfHuDfg906grks29FgXVycKjg3Fk+UikfuYRVQCyN/lIhD?=
 =?us-ascii?Q?3BWqWfWWoUaYctguVWk9Ne9jXCukPoabyubkBeBvFA7ay4Qg33Nub0BjxKH+?=
 =?us-ascii?Q?TGPo4iZEzOjSB8SGdNz3iA3NYN+pO0bei4AZk8t8hHMMK3oQww0pxS4JXguv?=
 =?us-ascii?Q?1+d/lMo6NCW7US20uuHGtubNowq0jw7Tx45Lvhq9aEjGlKOyAA78dm7RfXSE?=
 =?us-ascii?Q?ETVZ0faveHtWmTDw4FA9mFbGCes5KMtFmJUUjDsusBc2nU355GR9ZEsis6Su?=
 =?us-ascii?Q?OoAc2ML9e+XZJR/zRJNDHzQUJxvGvb7+44eWrZ0DS8Eym7A7rbtD54S3xrLc?=
 =?us-ascii?Q?AqLMnTOB7iKX7Y7t55YR70VlWvYBRdERAuMtN1XAIPyn3llP89K9buFrOkoq?=
 =?us-ascii?Q?o/iFa+X8DnQjox8dkCetPbArTD+tiAe2Hxj3oKY/0IkLIRZIAGvhNBZuugj9?=
 =?us-ascii?Q?NiijmAb+D14LE/LJaKiqY+sOkNcLg04rVMnia1TUfrSEvhrmb9wevjJZLaui?=
 =?us-ascii?Q?uLtTi1q5KAu2W04h1qnRAJhlQ17lcZXYGAh2TNw5AkCDfdA4JAaeyUFLfmXz?=
 =?us-ascii?Q?ALOjqbgtnyACLF36gvdROKyN4j4zmwdeuFg9lRwyGouv8ttfPmsO+sS3IgHx?=
 =?us-ascii?Q?rCfhDO6pC46RtKvW/42Q4Qwj5ZYHktBtTFERKsLlrTccgwdhN7JHcRlkw+Y2?=
 =?us-ascii?Q?JKxE4UUHIM7hfIhNkdC2KCTwofRUJH2WBrjxpoxx9cnAFktoxARwmYzZ2PRg?=
 =?us-ascii?Q?IQbrYCFYrg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae498f6-f697-4f98-7f27-08de5cb0635a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 07:56:18.3491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgq8kakPFJxu957wh8sKDa3Uik9R33SUI+4q5VJ5DhoxhqejeL6wCEkJnad4hP9GwWOtOtyavSWy9RczCaW+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFE396822D5
X-OriginatorOrg: intel.com

> From: Deepanshu Kartikey <kartikey406@gmail.com>
> Sent: Saturday, January 24, 2026 9:22 PM
>=20
>=20
> KMSAN reported an uninitialized value when batch_add_pfn_num() reads
> batch->kind. This occurs because batch_clear() does not initialize
> the kind field, leaving it with garbage data when a struct pfn_batch
> is declared on the stack.
>=20
> When batch_add_pfn_num() checks "if (batch->kind !=3D kind)", it reads
> this uninitialized value, triggering KMSAN warnings.
>=20
> Initialize batch->kind to zero in batch_clear() to ensure the field
> always starts in a known state.
>=20
> Reported-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ddf28076a30d726933015
> Fixes: f394576eb11db ("iommufd: PFN handling for iopt_pages")
> Tested-by: syzbot+df28076a30d726933015@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
