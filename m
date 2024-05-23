Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D5768FD
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 05:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716443084; cv=fail; b=HKIr6hMWBIjicASeTRrZQYz248Y00+VVOW5RyR8sHo5hgd7zWOHT8pbDPUjJJVpyjKBGgSjDbdSEuTJ/TRpUI5tuxJEjXDULvLo0tqJNYPlZQwSYN1w3OdoSc7RJRb7pw3zZg8I7wvG1oxTZsSWhUnoglBJoWkLe07bxHWB4rL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716443084; c=relaxed/simple;
	bh=rRMg7PIiHp0jFToNvD9HO0AZZVAK90gzjoN948l9rjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=db32sa155+pDjJYONB6y/L07H/ytHdypXF7KkmyeW0ee/uciHgahwfdrZ8Dt13d/TpchMe96yAcNNu6p8M7g/OsQNOYjMyMq9qcHtdFMSik9HEYY6r/U9KltEz9/s/S2qtkd4WsJS3my1yM/keRV8NFSvV6LzVvbTGoEr8dpiXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYxymkzn; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYxymkzn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716443083; x=1747979083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRMg7PIiHp0jFToNvD9HO0AZZVAK90gzjoN948l9rjE=;
  b=RYxymkznp882gCQxf9LY1zl+JEr3aF5eZoA/eA+j1cdkjkhqa6UbUR2F
   5rgHCdAk7EpqmJ4w/8rHq/qL1Tf5BE9+UFz9hOjnLqFdVPQhm6cepE/6C
   D+3roA+ioJx3OLZliW4dGV4zdERTnFyTG3//CleIZbpcWKq6fKIddwYk9
   Jgvxx+Q57Imy3tu9G2FhvWOSTJWhostut3PSxrFaFG84mATeaujWNXXdf
   ZrLwF7PtNfuHb3J56n47sPhPZY+/C2WpIqvRtLqR65+mIMawJ8UxLhOFG
   g1MnioEj8V2mH3UdkEIA411s21QTN5tKhABJdPMseV3Zwvxc2Si7G8/qm
   A==;
X-CSE-ConnectionGUID: z32zGbMkQXKtqooD3zLPjQ==
X-CSE-MsgGUID: XlJGVKBJRh+dfOl8GHiN7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12584777"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12584777"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 22:44:42 -0700
X-CSE-ConnectionGUID: HkLC3Lo3SVyfoxblpSkgVg==
X-CSE-MsgGUID: +MYTd4FPRy+hdfKpH4mncQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="34088100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 22:44:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 22:44:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 22:44:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 22:44:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCj+cAjcbMorMuS1+HFJKdTIixVRpdWdF3GpqGxyIsJu9UcRhd71fEclRv5DUAmml5sJDcupH/VnFVE+fmknZXBzPeWSfSAg5iFgsi7/NhmZirf+9i6tcpACENG3vCI/tvEsfOv33hxh0gLw7kDroFNaovVxHAHfYRe4MbiQKEQ+Cd6LIc0HV0X5suU4K616IKOjkizfkowTHzvg7EH/gQBgJISvB095XaP8rU648XuX3Vq7MZOXtLWf045tqZigvABWVUJoYaL/mWPkbBNYvSujA5dX5QdQFOyZiZ1o+aQFKhEp2a9lXk7NMJTuP8eU1JgW3spMMC5PAidiW4ma1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRMg7PIiHp0jFToNvD9HO0AZZVAK90gzjoN948l9rjE=;
 b=D4OBumMSch+ycwRcuNTi7efwLp+GlY9pumK+8fIypacY3o4kUzQaUaqKsfxThswKkuaN7FXFFDfvMsfWoZy4gqHFFSCYBaTbUy+i6MNteFchKy/1re+AP7Mldo0O8sQM7iEhFULAxq9W4+1AmbzV9boL69Yxm0ynOk74twpAKaKyL2KDwOggJlTEq2jl7nEha0ZA6aRHFE6dIu7kCSmRvzzaJhWH3tmHbTgnuDZzf5CTmNFwzdENXrcaRDJweV050xHnqMRMtv84loXk/HSLikE66Ci15gwD1JtPgF9tZx4z95JX/gSYLG0l1VZhTZV+oC3DTKx4sefqEiPw4RL6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7927.namprd11.prod.outlook.com (2603:10b6:8:fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 05:44:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 05:44:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Topic: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Index: AQHajVVq/X0HjqCDvU+a/LkdwhCQ/LGT28sAgADojoCAD8kmgA==
Date: Thu, 23 May 2024 05:44:40 +0000
Message-ID: <BN9PR11MB52764728D4A8F54CCDE9B6C38CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com> <ZkGZc5dvLigXcWib@nvidia.com>
In-Reply-To: <ZkGZc5dvLigXcWib@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7927:EE_
x-ms-office365-filtering-correlation-id: e1525e81-6f2e-4fbc-1f3c-08dc7aeb709a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?hj+a0bo/GetvGB1aGEDMk2+V1zyB/F8UNGOxLyMQw6O1D34i3Ob/UttIk/ht?=
 =?us-ascii?Q?PlzxVE6S01qGdWsseCpNlePn9hIOqHsQKJk9dO5eh1lMI9Ct8v5z54+5Cg+X?=
 =?us-ascii?Q?4J73HSqzFXNiHkgOHY1R2VwtE+NpKzwXQeFA1fiwX+RXgZ4mPQv+rP0AR6vA?=
 =?us-ascii?Q?fkq1Xk0OpolbIWg6k9iYF/Ojg6ka/p1ZT+VYbflWd0JJJglE88Qp6Ha5hdxo?=
 =?us-ascii?Q?z2NNrA3icTGnmIaNYY6zJEoxDwC+6aDcxRaMVmmkANS62AfnxgqxgqgD8TQZ?=
 =?us-ascii?Q?khKSksIn83ZJ/g77vcTcHIFebzOcekG/5wmY4FRWZGqQPm8k5W2y/Lh9NKxx?=
 =?us-ascii?Q?4HkpqDkLRg1vaOpTjIQFVf+8VzGyjawgJYv52KyXe8DaGIVM5tTUt4Td2a7z?=
 =?us-ascii?Q?GkwdKqg94B4ip4Y6iEsVfzSfhl3xUENhASPkEatLkifSy7xzOi16oxdOtFuY?=
 =?us-ascii?Q?Vd4crc2PMvHi7kkzazHAxaSNN3vJIwhcP7MtH3xqTJhqVrncvMlBNiJ+p+ee?=
 =?us-ascii?Q?0zJtEiUCKjASSorB/ztwZuGTc7jV8BJubZhWyYtqSuZJaZ8zpGjnQNtkfohi?=
 =?us-ascii?Q?5ANG1nvqLZV6i0vhmANyJGsPFCyflxlHKb5P9qWAENraesNx1W1vGGDSOW8M?=
 =?us-ascii?Q?OhHY8S/30LYL0/xhyxnZGA9o2gqbHcpW0gDGZStrROnzOHiJRWSnWaUuFGY/?=
 =?us-ascii?Q?fMCdsdoWofFcOnaXcbH1+7qz/dirC2ki9TB9QlWrpT8D+4jcCy4MfaIw5ApE?=
 =?us-ascii?Q?eRTn9IlB0EKRKmikEzPGHydcvGG9pmXo57tet9QWYx1BUYE4R5E1x1w1hdFF?=
 =?us-ascii?Q?VyFKfapqoLQ2YkayvOv7b6Q6I69tmJJ6z/7RQe6I4aBSMrtuEwDmkRF2mBme?=
 =?us-ascii?Q?YBjKTr/NQg1w2d74pV30RgILorHi2OIWxX/ygQis7PcNe3GfXUl5JsqNM0Jo?=
 =?us-ascii?Q?XErILOumRPJNjqRzCxFvedo810thQ81hiICcjcaWwD2AOo6rwS2Bj2LQbvft?=
 =?us-ascii?Q?YskLawPdEJu5UtqIGiJWfHP38GtpXqkq3Cqy2yo+YDZHurOS2H12gGRISFAc?=
 =?us-ascii?Q?0HzmNSw8uinqqv0lLcSL04TX3SrzBjm0vXvqWiiWnn3Hblql5DO182BpMyV3?=
 =?us-ascii?Q?jeTJPTEsmVD6j0CCKUrxaWaCVdrFpRm1c0NPzwTAQJpVo6QWHa5jBNc8gd6T?=
 =?us-ascii?Q?6G2o1xLeYxtorbWQFZr3WXHoExZBR9KxLFTQzryqWTpvFkW66O/7uZY55O9h?=
 =?us-ascii?Q?w6atx+cvUevP9h3v25IpKzCw7jFTSBxqdj3ADQt8j9V5d6YwU599lBZ1wYtY?=
 =?us-ascii?Q?nQPRX+7C00FyY9mrVjL6LV6ktMf1fyqR/WA/l8hkzCUsqQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Dw3qoBm9YcHo4WfRB7CKqRNLsI3SI4GVYfU/I4Zy5LZolTS4azhm6qs+yu4?=
 =?us-ascii?Q?AUVtxiNkwpcm9Urah99yOo1AlG+9mH+22cAJZgYWGtt/Z1Hvh9usW02Rrh2z?=
 =?us-ascii?Q?jBuetzjZqisTio9Qv5nlkKYEBSTPsZKRIIZFnTSNONCb8Ww1VsFkUl/n1NqX?=
 =?us-ascii?Q?I8oxvoydLjAELaqHn9ZSaxsvVgYFr6AcxjFYORWhFEG96kfVWDyR8G61nCWM?=
 =?us-ascii?Q?0YLsDG67LwIA3FeaPcVNE1UysJO4Ghjo5ONvQC8/6ch0QRqT/Xkq9Bfo0Ppt?=
 =?us-ascii?Q?odbUUSzqRXpBb4iODBgk3qku45UUVTJiHePSwocIBmZ+8jo/v5Pn3uKj6JG5?=
 =?us-ascii?Q?FZsM7tmQFMoaHdT0SfsCJqsNvEZc2I/pCTE3X1ckuOPliHXadOGjcwPPfrYt?=
 =?us-ascii?Q?Pml5ey0BgHEspWqZSBvgfhXr9Y6MnfzYQOpi39UkI8p02/Ff+hyQV8xQ8H/9?=
 =?us-ascii?Q?J9XsEOuPMjUq/wfc54FaPyo77Ut8I6uFepnJZGALVTIGW4cvJ4Z8JlfDbKmI?=
 =?us-ascii?Q?bZO3Mqy4G61tZKL2+thzUKBZnWlhdLzwEJa0hXbhx2DPfh7JaoWfCx55xltb?=
 =?us-ascii?Q?IQk722fnpAx/PTJELwrAWbfu8ti7ulCSF8pVPYvYW7oIxWSJTI2ESvmqeIW9?=
 =?us-ascii?Q?fa4aAbF1kZESckQwSFVyJvgbRTLTCzuZucFTA/vgM5JGyz62/gJDsiNxgI7D?=
 =?us-ascii?Q?Hh+ovf5US/hTMMJYWU72A5RxY/LWzIaDl3adyo8VdOVpaTVuq7vpI/2eLO11?=
 =?us-ascii?Q?qbczLfoBFqx5zQK5pTy9zYgGnT6HP06kcTMjGXmm5tHjglvszvzv/rj9gnLr?=
 =?us-ascii?Q?51f9VpP54iqUqu8/oVw/83qJgNRL3M2oyeX/4J7ifeweEvY6f2fzL+dUNd4/?=
 =?us-ascii?Q?0mJjKpJbllmD3TdaKvXHYEuh28FKuCpX4xiRum+2TtCd21bRcJMQf31c+I21?=
 =?us-ascii?Q?vVa31eNoLzqZOS3TS7RxG2hV5Y+qEvjVN+aYDGyfYG/uCnDsTDDWOx3Kv9YH?=
 =?us-ascii?Q?fo8I+ZU0FHzuVqCV/XC6gRNokzexu5PntYRC9+bd13A7fJnsrNIJnrYrIGVJ?=
 =?us-ascii?Q?TXCv07ZjKRIkN2tPmmulvke4vhlJbEvJPbtDFTQ1i8ZKuLDFVoji1fEd4rJ6?=
 =?us-ascii?Q?KypgJUuv0Hq7s2J842QRTKJDM7eRaPSFPS4HgK2a9fZ8ZsVktpznUMYPluXf?=
 =?us-ascii?Q?rceEu5M4oVkb/8+OaJBk4p3REELKmT6zXLXPmEQT0ycwP2VaxjUyvnOPqCfa?=
 =?us-ascii?Q?7+AKKHcQpnxP7GVeyuYKqDWow07g37Y9jjGbcdL1gMpTo4ICKsSX7vEZ6NeQ?=
 =?us-ascii?Q?wcekl2MuZjxuOKauHimx67HbQjRMv1ePELC+AK64Box37Uf6BOEs/u+4MwkV?=
 =?us-ascii?Q?CWwl3h5GJ0XopnqhTsjlvv5Y3pK/ErVru0OIO8f/OGgoauyWkIPIkEetzKyX?=
 =?us-ascii?Q?ftvpx5lEH2VMQu0FmG7K2OYvAT3xQygMTr+xXJoXYur9ZH3ew3JnyIv2M9s8?=
 =?us-ascii?Q?S0HQZu4lzMDBUBuCv55UQQ6c2/dXQ94eciM7p5ogSBolAo54xsWcr4DCN4IG?=
 =?us-ascii?Q?jdbbReryqFpLrk2eKjSlGHY0+N0K06xIluml0k5b?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1525e81-6f2e-4fbc-1f3c-08dc7aeb709a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 05:44:40.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emBmnH+sQ/lh/h25mVOlRFFy/NapD378PL9FAQzhSyOXhNuzOuzGg0gCOfQmqgb/yNbevIu+wZEgZYUa5D2hHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7927
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Monday, May 13, 2024 12:39 PM
>=20
> On Sun, May 12, 2024 at 11:46:54AM -0300, Jason Gunthorpe wrote:
> > On Fri, Apr 12, 2024 at 08:47:04PM -0700, Nicolin Chen wrote:
> > > Add a pair of ops to set and unet device's virtual ID that belongs to
> > > a viommu object. They will be used, in the following patch, by iommuf=
d
> > > to support some HW-acceleration feature from the host level.
> > >
> > > For instance, every device behind an ARM SMMU has a Stream ID. The ID
> > > is used by ATC invalidation commands so SMMU HW can direct
> invalidation
> > > requests to the corresponding PCI device where the ID belongs to. In =
a
> > > virtualization use case, a passthroughed device in the VM will have a
> > > virtuail Stream ID, used by the ATC invalidation commands in the gues=
t
> > > system. NVIDIA's CMDQV extension for SMMUv3 provides a v-interface
> to
> > > execute the guest-level ATC invalidation commands directly, yet needs
> > > the HW to be aware of its virtual Stream ID so it can replace with it=
s
> > > physical Stream ID.
> >
> > I imagine using this as well for the ATC invalidation commands. It
> > would be very easy and simplifying if the command fixup just extracted
> > the vSID from the ATC invalidation and used an xarray to turn it into
> > a pSID and then pushed the resulting command.
>=20
> You mean the nested SMMU series right? Actually the set_dev_id
> ioctl was a part of that until we wanted to try DEV_INVALIDATE.
>=20
> So again, yes, it makes sense to me that we move viommu and the
> set_dev_id to the nested series, and then drop DEV_INVALIDATE.
>=20

I'm right about to ask how the nesting series is going. Per earlier
discussion iirc the nesting series will go in before VCMDQ?
