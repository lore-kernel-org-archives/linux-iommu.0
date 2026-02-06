Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711382E6116
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349466; cv=fail; b=s8mpxnToNBhvjp+7X48bgJqIkq7Pw2gBI44uk6dp99hGmgtBtuhvIZ0IRpp3LIkOvpLBRRqTaZseL0m3Tnq6oNqDzFIiEmIneY4HXkSwblgVB1ZCLk05mKo19CgqA4cCGHdIoW/rDW3tHRyEDARq/x1S2wVR6RvJU569JrlERpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349466; c=relaxed/simple;
	bh=azqWwSf9BGm7yZ9A9d1jVwX/YKl2lhz1XndrdfGfkTg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J1Mtra2JaCrGvY5Dvch4Yg8wCsaAmwt3nUDigH6b2yxXK1fpWjmuagfIBzW1fUuTsP118ZY7VPZ8I8D0eYm6LhyM3UjvwbtSR6F7qy4M8zxa/ZiuzDiO2kOWByuh4fLR3zg+K8/8Qvk3CHsEbSObMgk0kdtWyPVx5rmjyK4h3+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2QF5+ZB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2QF5+ZB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770349466; x=1801885466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=azqWwSf9BGm7yZ9A9d1jVwX/YKl2lhz1XndrdfGfkTg=;
  b=b2QF5+ZBslrdu17aI66gjh/BpeLQ7ioFYq+VRNXKBycu/IgRPNrtee7K
   oAiUWXBU2MJdStojRfp8qBYzNsYpqAGp1v+Qw0UiBWdUMS1kxLiNd/B/M
   pxl+zCUuwySN9RPvMXCRnJ1Nagd0C+3aNcRbvf0AQSlOADQ6A+Uz64C5W
   fxAnwhgdJIFhNKpB4ZIYEVGtdEzFA5YvjTeFTOGHW3tHaOdPWCivcAcdY
   FqoNwHTjNx/zIjUq5EZbaadlEb2xkBTQ2oDwuWuxIbrsjN0VDR+OuZ+0V
   32+1X/i1uhMlfk/xFHbTAtyMsAIJNUQPLiU+++nj/406zVAQ73+63b795
   Q==;
X-CSE-ConnectionGUID: o4UT7XxNQX6Bv6qK4OkDGw==
X-CSE-MsgGUID: +W+VK5V8SeGVmYlh7nHYUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71596182"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71596182"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 19:44:26 -0800
X-CSE-ConnectionGUID: ghW/313kRQmuxgRnmx897Q==
X-CSE-MsgGUID: 8wLA4IK1R7Oje9hZdDjBLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215340289"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 19:44:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 19:44:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 5 Feb 2026 19:44:25 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 5 Feb 2026 19:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL/HZVZMf9kvpIY7jJV0rpB9h+ikH+cSRECV+pD242PZCi8d3H1zS8ZFlXN95GYHzT1izHI/RNTVhbDkRLCzCXX7YPi9dykcjEnljIeUlxPXH0Tb2ekespB/4ZjAtnHdtmyuYhpj+wtOHZ1dieQVDZ1b0dix86U+hZxqfKxyOqbDRPRpZgkHZUYsFY2CgOngFABtrWUcKPVuN/Kf0KN+Yfs4VDvBGCPcOHxNxuaTkcvJxFDAdSGgnmfeb5H8q3ldCRZP9Fa6qB9DChcfgnCfjvKQBWVxcqNK2cccWnNv4KtknX0QWUdoGGESACvVc/EIQB9Bt9b64/mBY/7C8QBVSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD/Gg//SsKvK/g7+xnQdoKN6GBb6CjQ8ZPJTT1rEMpI=;
 b=YndDeGBt+CgivbH1cXr5ll3dAwW5xsatLXQOj3PqK/X5LfPkYIU88Z4SAIibcCrx+auxCKnldromO6Fnq0Q1u6KZpuIIQJIXWPVxVMetJigoAjsR8lWReyyQcTRsR8M2ppuVncYqBKdKRlBinA4JjF3cdU6382GsmQ1Qn8KyiHxIVbVgCi38t04KYS0nYjS8KQcDNp3Kadn38dv+10vKtdEld632EWC+JiADW6q2UaJ9g+0VUQ/6Xmg0/I/ttTQpdbrFkYBITMULEu8KSSjX1vSSwLTe81vReI7wAwAvrhSChi2kJKF1+Gfwhq/sUVPfRqE+5HumgO4f0v8SNbMgMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 03:44:23 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 03:44:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Tian, Kevin"
	<kevin.tian@intel.com>
Subject: RE: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Topic: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Index: AQHclkfxNsmY1XUSU0OoVQI0Ea3M6rV01qSAgAAnsdA=
Date: Fri, 6 Feb 2026 03:44:22 +0000
Message-ID: <IA3PR11MB9136AFF8794A8A2018E008179266A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260206004325.GB943673@ziepe.ca>
In-Reply-To: <20260206004325.GB943673@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: ad8fea2e-c1b6-4128-e306-08de65320454
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?PsEsbgjl3n7TK6OsF/rYg8ZX7EWzWtWdeRhfCv3MsnlaqjdKo3/Bk2vFINSg?=
 =?us-ascii?Q?3SRRKRaADEdf4CZ9p33j3CcPhhTkHMbPYFA+Druocl6jOjW8m+3IiOlRKuP5?=
 =?us-ascii?Q?YhF4FAFI37EagseinfPACWLXSTFNCOKu8Um27Ti+catc8HwssHx+qryi9kHj?=
 =?us-ascii?Q?DgJvzFVCLR2HcKri1NUEmQV28OSmeiDwFUU+HnAn7nqzw7vqWxICL5JK6I5I?=
 =?us-ascii?Q?Uc5rEuU0/f54KSbKVewnHLahh7BijSD4r3cxQslAO6KT/H0z9F2Q0tJU0Xfn?=
 =?us-ascii?Q?bl0Aygp3I5CAA52BaAnJvq869LRdE+QzvdUJyLe7ZpDycMZfxDZ53mVKEbMR?=
 =?us-ascii?Q?hgn+VYz6aRSCjh58D1LXAltBv20iIWsrjyD5ESJEPcVKJcY8vJJz1Xou3zet?=
 =?us-ascii?Q?TbOiNaqcNBIlPsdKN2XdctEvG5hwBtK1WD6+icpQjD1lcjLRzOy8O/dOm/sG?=
 =?us-ascii?Q?LHvUNiJJ0fR0XfIrdRhLAI3VVBeYBMKcuHFaHvKULq9miGa/tKrP0Y6TO8Az?=
 =?us-ascii?Q?U+Wm+zvHhdQ1qG5sY6b+m4dhyzLATKcms6mlcPgcAOHZpv4pAmYOkwtBaovD?=
 =?us-ascii?Q?drZS1z7CAY56YknbN+EU6vh/3u2eWyuoC3G211OGhR4cWmWIe4PQ5E+nAJf8?=
 =?us-ascii?Q?Jauk6lB50DxkFqvPaMrsL/gx5MKK2n+1u/OFGAbPMiMELf7bGHA8KtLNPsa2?=
 =?us-ascii?Q?rHlrtHkvcl1apu4E5EdJGB9tiQx7rMYlA92U47hqSXE7NtHUMpK4NymLC8e5?=
 =?us-ascii?Q?2RgTf7VErsSfBWpbFejv9U8oMC3TOAPTM3UNs1BAY0/4z8ojKSRt5Gayskc1?=
 =?us-ascii?Q?F7cSLSigjFw6R/4kACqHzY7qAf5lxWSeVJxR5vDdkxrhw2pIJkX55gryZGbB?=
 =?us-ascii?Q?ycbqBK0zO38jVm7DC7U2OIq8CgWq+dmzNU06euNJb/UUR9CXQyFEqzuKvdV9?=
 =?us-ascii?Q?ymdxRzxZL0B8tJZfpy4u8aN/pomtVMkyKIiDe3tDjWZLGukT+L2wJj/D8GaS?=
 =?us-ascii?Q?nAJequ/tkf8xnKZWfOLUi7IxjKHcALfR9KP4PRY0d3dxhlyfp5LTMQ/m+Jol?=
 =?us-ascii?Q?fmvOP1SH1ti9MA1RGWhX5S/5AUXxYVbQh7lFHV3NmMrPvw0o6PeXltEl3Tkz?=
 =?us-ascii?Q?lacqCrjG5fngRTKODurfP7RP+8V2Xa5Gv7oqItCuyRN6GZ2jjlG5m/Bxtmbb?=
 =?us-ascii?Q?YxEFClW+H8BPLT560lL0mYm8qvYgaMXKzZEdfh4U5itjARDX05FFNpdYD1FX?=
 =?us-ascii?Q?YQ26EhxIYKwx+emo2G6cEOPG0KV878Wx/DT7PsBodIfSrz2zZMArKxFt06ei?=
 =?us-ascii?Q?Qroumn/UwsRM+VRggqPBmyMblfX9lt5umQ16akJXbi7OyR7cI++hKW/Homiu?=
 =?us-ascii?Q?puvfHAn0/0IrmBfhlvFwSSatbbUkDHJBQq4j6mr/q3RS/ftkiqUcdsahmser?=
 =?us-ascii?Q?uxnYrk4fdrr4MT+KqrbCsoW7s0M+UHmzEo8eWf0hdFWFv7W9MvfXhELZiCf5?=
 =?us-ascii?Q?ZuiQ4FH0ns4EXB/+iMfdUCxnfWU6qqFSBRnzLmRSFsik04UXlNr/9D1znZyB?=
 =?us-ascii?Q?o3baMcA2RFj47RWMRHiU8njRz7b/qZk5dr5ORe7UqyGJZb3alO+r2Ds3tPbT?=
 =?us-ascii?Q?yu69W0oqhRPDhuRVdpa92QA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9136.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mAN74sXokUfUr3sy6fNGKCzgOqUxs1hA1rodsHEIvgTxjASQ3IZSQXKjKpQx?=
 =?us-ascii?Q?r9VE9+GGHU4sVaOjojhbU8Q97dJW1AFacK1O7DNvxb3TgFJZ1J4BUwJeJGvM?=
 =?us-ascii?Q?Oty/B87rtgq21sBr47yh1UqiDziG/iS/YjYN6Eg8XtGI4QLOP9fcRpm3DerY?=
 =?us-ascii?Q?ORQ9AA48IahGLHtsWi3KmUrzdpxUloesnX+W1r/WRYDiiM+lDk38Q9pAuK2S?=
 =?us-ascii?Q?+yAL1U76bchpyzp8DbnaXq87ISpSeC+tm78ft4cM06gb4kPQ/1Q0FNHmqgb9?=
 =?us-ascii?Q?5VlgsQ/QAvGupkEAed3y2AIpWy0GEU7pxUgS0OpeoMnCyPaUj8QyPpVlHQgf?=
 =?us-ascii?Q?6lHud0AZtzF8/A4hCdRUuv0JKVV5Ed1wwLFxJ/ac2anS2WE+Sh2I8p5YLach?=
 =?us-ascii?Q?rMw+N0jRwQG8sxIwzg9U9WFqNx/fTaREZ1tLRBluKIf7bfVPB0quzPKK7bwZ?=
 =?us-ascii?Q?3SDwRQqooINiaIVHSp2kEbxtHRw99fAuaAUxE03AYTyarRp0IGULf8sG46rE?=
 =?us-ascii?Q?eSsLaX7mhVgmg+iRca9FDGfOsQtnQgG7m/89K1FbppSFe1xGwA+BIY/w2m/E?=
 =?us-ascii?Q?tQrpLbaKCJ7WvbLn4Nn0QhOjd2v53hTcbngREyH6GKIvl6hCoSAdocxpv6ji?=
 =?us-ascii?Q?IW4LP0cCImZyFScxFN2Y5B1Zm1M8COb7T3kW0jK8QiNQTFvJvuOD3uyf/4xI?=
 =?us-ascii?Q?vZmFwzepXsS4Yxdw9KMRpVdbVB+LIhjJ7aI3PMPaeim44I9C29T4Gw6PaIAR?=
 =?us-ascii?Q?EC5hE/ETWcxSoA0ixq4E1POm1G1i4U5ENAD5AwOcRUcf63Mdo514t+7QcTvN?=
 =?us-ascii?Q?AM9eGxkiB4tIkHeLaUFiGSeskT/Gvtc4u45IHBmsmSLQhEiq9Pb0I2jGRx+g?=
 =?us-ascii?Q?WHZ8wuvuapAu13LWdmktyrM/uCAaxawWPQteGHVv7hMKjXzcc1VBE/f6engM?=
 =?us-ascii?Q?41HOwo9llu/TI5jVR5fCSd95ns0UGEuqfeW81l4OSu6azuq+oGiJo3B/p0P0?=
 =?us-ascii?Q?iNx5HTkVh13u0450zuRXHDCcOoi8+BcR0v6jsCrfzgDtiEX3ImItm2Hjosi+?=
 =?us-ascii?Q?4hfLGaoSrpeyil9P2S0YHZvCYBRK+tHSGCOxoqKkHwksl7JcjwHaH1Tylcpz?=
 =?us-ascii?Q?Y7I0YFHR1ZKecRoTHBKPzFEkOfWTiviLAeuWQ59J5g4B7DaY+xwhi0xqCAKY?=
 =?us-ascii?Q?qqJ3zUS+RoNCtR0C+RKkGatkkcI+S4pNXovBSysGeX1zxZK1uRWP7D2ffM7k?=
 =?us-ascii?Q?wB/AtQXG0+oS07s/Vmt59JePkQawFG7kUH+PKDfsa7Ba7bCLJOcnxxpfyG/G?=
 =?us-ascii?Q?KgG4VT5OvFN5MzoZBGauvyyMPGbKOfb2XadkS/g0LwE7cqWbbYk9GIAJs818?=
 =?us-ascii?Q?mJMgcPq59gzTYER+9SqM2qOJB5XcQEp3ra6b+JCmLM3VMO2i23Dr1jFx0/Ou?=
 =?us-ascii?Q?HRu41TLWPpLna+LMabxH2FkKbK2zwmVoiGwyXo3K8oDp0e0dZDxD8RGSzthx?=
 =?us-ascii?Q?2fKFMLiXDZB2YMDrfLZkbpMbpfHuIbp0Ays48HAFANUpFrT0ikV/tQUyAtQR?=
 =?us-ascii?Q?bdb+EQyEtlbq0efi1Nh7ZmH02Na/rNZUur1Trk3Ym5ct6h7Ux79qVodB+cI9?=
 =?us-ascii?Q?nItI/CgopoQLIAnzsJE6kserKuJWb+7T+mi5HvgSYMxeqc0xfibYIfhIvHjj?=
 =?us-ascii?Q?jZJwP1rPGfWsgH6pbAn5cu0r8ijtiItpNeiUa/RfbCtUVPBGuyrJJ3Qnd6hu?=
 =?us-ascii?Q?fz1rATYkkA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8fea2e-c1b6-4128-e306-08de65320454
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2026 03:44:22.7927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NX2s1Fd5mD32UgNwll/NB3FBrz6sz5ewrbd9Lu9N86al0sJnTVWIHKTOt7kuE9tq5+tr6uf2OKE0Yspsc4Lo3BqZMtpQxZo/dZSiS4DW4+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Jason Gunthorpe <jgg@ziepe.ca>
>Subject: Re: [PATCH 0/3] iommupt/vtd: Support dirty tracking on PASID
>
>On Wed, Feb 04, 2026 at 09:34:01PM -0500, Zhenzhong Duan wrote:
>> Hi,
>>
>> When we add pasid support in QEMU for passthrough device, we found
>> PASID attachment to a nested parent domain with dirty tracking failed.
>>
>> It's because PASID-level dirty tracking is not there yet, by adding it,
>> we can enable PASID attachment to such domain.
>>
>> Thanks
>> Zhenzhong
>>
>>
>> Zhenzhong Duan (3):
>>   iommupt/vtd: Pass dmar_domain pointer to device_set_dirty_tracking()
>>   iommupt/vtd: Support dirty tracking on PASID
>>   iommufd/selftest: Test dirty tracking on PASID
>
>I'm not sure why you marked this s iommupt? It isn't right?

Oops, should be iommu/vtd.

>
>Also only the second stage table supports dirty tracking so I'm
>confused what is the issue? Is it trying to say that if a second stage
>is written to a pasid entry on a !=3D0 pasid path it doesn't work right?

Yes, more strictly, if a second stage domain flagged with
IOMMU_HWPT_ALLOC_DIRTY_TRACKING is written to a pasid entry
on a !=3D0 pasid, it's not allowed currently, by below check:

static int intel_iommu_set_dev_pasid()
{
...
        if (domain->dirty_ops)
                return -EINVAL;


>But it does work on a 0 pasid?

More strictly, it works on IOMMU_NO_PASID.
For IOMMU_NO_PASID, we trigger attach_dev(), for other pasids,
We trigger set_dev_pasid().

>
>Huh?
>
>That sounds like a systemic problem, the two flows shouldn't actually
>be any different.

Yes, just because we have code to setup dirty tracking on 0 pasid entry
but lack the same code for !=3D0 pasid entry in VTD.

0 pasid is special that it can also be IOMMU_NO_PASID if PASID isn't suppor=
ted.

Thanks
Zhenzhong
