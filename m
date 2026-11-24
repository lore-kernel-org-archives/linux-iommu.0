Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795508375;
	b=NwjdZ1sfFgmoL1xY5/bddRQRM31KEJ8AwbHRHBsB/eQRq+DMZVu/o7eKKiXLywiiY2QH
	 62gVBI8ww5JInZR8Eb5mSSJRo+3XErmKqIYMnN3ecUp8U+o90N3HZNJABaqjD8yimAUdM
	 fWZvyKuYD6iDbSJJ8I9rC2y0xzmyOu/wZkdUdr0vllaMNWN79MD5OkfQIfXQxK0+6UuBz
	 FHKALXy4Px4TVzlpTE7LggC04PYk4nNS60k9rIsYoCvtZU2rTMoa4aUyP2l286hJVSiqQ
	 xXreUxXxV/Qq1miSO6yfsVD1ajQr1SqzCDzKAEBcyS/brf5TGgaUiuAiZtMyrg4uXqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508375;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=FMqtcjWdxKo4PBGFZEmGnwec3HAl0050lsh2aIZLfdc=;
	b=dw4VocVi4L7pCGDz+j5pLH2AEtRbpXBoHrRU4q7Iogp4p7+NgHLHMMOyNPjx4wXzuuHE
	 +/7jFtb/mU8m7YZ+ScxwCTFYrTYQkfOpAiSdJJmDl/2b1Tlf4f6hdkUijgOo5g/5VKyqq
	 XLpFep6ms2/Mwqnl03ImOGGWOc2Rla+7JS3Z5igypneskdP7ipxz/rHUUVPOJZ3PK6DUK
	 lbzST2JSL57a712/KYu8pAeCgZ7dcLfeWYmsj/G07tRQ8MZmxrlFKgL0nay3YPv3kO4xr
	 5+AU51YeXRyLG+HHGhC5oBgeP6iK07PdLt2YW1qB/7Qo+b43Q5Mc82x67Z0XUaR+WSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ngEj+vh8;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=g0h0qBEX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ADB606A321;
	Tue, 24 Nov 2026 08:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8ADB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ngEj+vh8;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=g0h0qBEX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508375; x=1827044375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSMpERtEad2IVWzCF8wlXk+nSB3kS4q/dtIHsGe9cuE=;
  b=ngEj+vh85zrGme+hEX0HISWBMdOHTj573EniBfpneaJ/cpbsZpqSZ4q8
   ipJ9tVMdTo5CGFrYnMbO7+o/EnZVFxachVkBfAUKeTqiUt+WcHI9Wl6ID
   QAsLtDnjGO2w3s8jUtQprioOvlhpSV4XmlPQvKl5M49jzjNyuas+YLAQd
   bDIn0On3kO/PHkKkfzjsk08vN35lh9zvYxi/IfqK5PpkBHzP85pmN79nd
   qVMWEtxU1BPHnKBwqqsP6T7W+7nhIbyczjrOfCupzE7BeWKlrbbuwiCc1
   t6+lAxyiKYUgPkG2c8yQZr9vjs1r0l/88BZ15qdqJfr641vepdESRAruN
   Q==;
X-CSE-ConnectionGUID: JfBBTz9rS4qRxnmqWWy47w==
X-CSE-MsgGUID: dJpmtxFzQ8SWnE79cnbXpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4440273"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4440273"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:07:24 -0800
X-CSE-ConnectionGUID: t7HCdiA4RV68RBAZ7sMyhw==
X-CSE-MsgGUID: 2W7lfID5R4OJN82YK8mQ9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="13292105"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:07:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 00:07:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 00:07:23 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 00:07:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B2UwH/l9PR426JtI98XfF0a8bv75Lz4E5ZLepNP6S9G9rgeWn+Wvim8yVdN+ugxmCmJcFd6BsAgjoxxEhsp27Z/K+l6fFx4QsUZursyTaAnkI5Imko3ep2APH8ulrrp/wjtpL8yYbomx56iFcMfdieQM+B2R/F7zZP5cmkPpWL5bx90fbN9rpHO5Uje7+fDitsvJ/oeWSnXGOlPkTdLgtghM8gElpEt7+JFe0GIDxP/6lY3Ah9WgzfvNuxTakeNUr75KsIUNw+r1V7WI8ga1W67YCxMvbi+w1ovF/e6XZYWxQ3pyWWPB2pdXRZETKrqeXidNx45i4M4cG93O44vUJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMqtcjWdxKo4PBGFZEmGnwec3HAl0050lsh2aIZLfdc=;
 b=MMPtWgNqw8q7kQ4qVflVu56c70PFmn4fVLoNSG4e4mW5f/jUt+FMvT57e7nq+rJPnaU5Hoq24Uut9pU4uPaA8SOorC2vV0gMVmJYlV1q3THMI7VfjoZI4Y/qmFAbH2Z3Oa64gOIggCPruhvtUBw+iJ7V4Iy/bRz2ArKej9yhjqQ8y03Hv7ST8+JRYXgadyBlW2nDCZZAlyZb3MviqrWK8OjPFYWad/P9oMK/UEZ5DbDzKOMpDiiKedNFFJVo3peZJ4Xh3k8MYJtxK44ghGgIKpGTjq66BmrOCx5lpo8p0Ez0017mdbrHC9+0qMa//obDNT9hIbeX6yECW/8iGRIG3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMqtcjWdxKo4PBGFZEmGnwec3HAl0050lsh2aIZLfdc=;
 b=g0h0qBEXdWeNBESRfnuyNob+H2Z2Fp95QATb0tn8TB/xQVoxBDgeQIeUKGxm2m33VB7j/bA92d/1XNyrkJcB9TgZSDR+dUUYrlH5djs6nbU9ZgwiMIwo6DUJRtsDef8js1k3+RQNayC8k25idDES/rtBxo3YIYIaJoCy85gi/w0=
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by PH0PR11MB5190.namprd11.prod.outlook.com (2603:10b6:510:3c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:07:20 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 08:07:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kiryl Shutsemau <kas@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Thread-Topic: [PATCH v3 1/9] x86/virt/tdx: Add SEAMCALL wrappers for IOMMU
 setup/clear
Thread-Index: AQHdcmBxwINOrwn4hUKPFyjx+DVgBrc878jw
Date: Tue, 24 Nov 2026 08:07:20 +0000
Message-ID: <CO1PR11MB4835FD5EB44EB94467A82E5F8C442@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-2-baolu.lu@linux.intel.com>
In-Reply-To: <20261112043054.2664857-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|PH0PR11MB5190:EE_
x-ms-office365-filtering-correlation-id: ee26e0a6-2675-42fe-5fe8-08df4a01f697
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|261026121527099003|4143699003|10067099003|11063799006|56012099006|261026140227099003|261022105027099003|261028144727099003|261022075727099003|38070700021;
x-microsoft-antispam-message-info: UpZJwC9PKWEvov3qjxRNG0KZ5rngTdlU2pGNt0gMDAlwbs9kKR42/wV7YrlNTYb8YxKOFxyOetEu28ESpqSbaZrr38eclVx/TDdsRaFn8QSHI9iJZPmFHy4qR2MNthjgHn+xyL0BW2CuIoeMGbtFN090dBRh2SFIiPpBPufi+Mc6bI+HwSAWq8LN4cDWgR+dpU+gVycLSbDkf+hr4BUHlXhMaLtDPGNgU/8xztZi1x4eozsonQE7SXkK6DNn+ZhlFreF4DTZtZqd5Lj6d5Vfk2wRtqNP/QTM+gPdKNYUJpsa60nWm/0tYZXka9rdsEZ/1PJS8dvM16+epAT22zPqx1SGZ51J/hJw2+SQmYFpeOCO8IDFnzaCzIFak2SmF3CEIBnpws8vW5XtfWC3TmYNPzEZHmdLh5SJMYjvkbWPqqygd0gY8IwmkeoEkqyZMbVJIXjslsUxZKXfOXclHW7n2oIo/wxdIRQDAzLt1hH5PlLingYr+K0yAhZVGnuRmsrZsehoofrLR0us7eofIITUF810kQrkbaSzkZ3NSWqqKAjpd6VvOBzkGVG8Adbee9Nro2di19e2BBI1t1LdG72ryAyEDkSBF3BD8lOkMgr9k+AsF88oertvMl2AqJLyjZD8+f6p5oXErygdx4VjmAlGjNWipIbyMk7DTt/N2G/1CEqlHycX9peqcgiof+1gQhP9lKj06wdANqPFMxdx3N7V7550ylb9prZnPoPQnOeFVuA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(261026121527099003)(4143699003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/zgyfGcLJXdgSkIrdl8N3To7DIYUqfPj4LCBTP8IH22HaMKf2yaYNZJ1zi/y?=
 =?us-ascii?Q?oxnpyC2+eHvss52pitP0j6b5XUUg8bW7OkNveuNRB31P31ttt6U60uTqn2rX?=
 =?us-ascii?Q?HsVYsLBoHvxFBNg0Hg2UDCy2Qqgue+wJ2PjKXhrl4OYmleBv/3YK19NGpP9R?=
 =?us-ascii?Q?c8K1vaZ+tjF9y8Sne4EHVf+CJhycf42Ql9HUfCmvHKwX4GDwDbsJW+IMCZ4n?=
 =?us-ascii?Q?bb8UAp2tn2WgII/LY9/in+vb/eKziw2YuMUUTExlGm85Fp3ALpOxBo/gxm8F?=
 =?us-ascii?Q?IiMi7dC9hS+YKvOcbgjNUfWwIFdcxkd11eTIdnuDYhpIqpnlMK61iYmyGEqy?=
 =?us-ascii?Q?8swhjrEZM6D015W+fgF44KkV3yT42doWElXewL1LqGa6OBcmOKmBwZMxO9i7?=
 =?us-ascii?Q?pp9+AvVncFVmeZmWtAgXiuYgNYOd4w2ieyDr997p8awBKXh5yDiI+daVJq3P?=
 =?us-ascii?Q?bYlB0+6wnlY5f9LlsC0F4EVCLE/r1vWhuWRuri1ssilCvkfFCEYDqbdVm4L4?=
 =?us-ascii?Q?rUaKXLReAv/F9yq9bjitLM38Nazg0uQyYMeWUzLUQJjDgK5Q4JHtlRWFINTI?=
 =?us-ascii?Q?Zgf83rkmr0WeJhjPf2mA4G0t37EGhvrHnlqIQkjG42mrAY/ODYSG1AWtKNqi?=
 =?us-ascii?Q?io4GN/vq1r1xcVF40oexkVuNy0TZKEfZiTK9lB3KI7uJPuYbA9vliUeeFU3A?=
 =?us-ascii?Q?y9qNnhHJAjXGFWrx7w053nTmNEksABcDvLoqvwxr3q3ZLkf/N1paSxfuvQfP?=
 =?us-ascii?Q?fuPBd+0dk8er8tW68XllgDHJTxVaocoziDrdubZLqKaeIVsEVyE37Ta13a4p?=
 =?us-ascii?Q?Af1n22fw4ojMQbQVaEkzBSbd8zgH41XhqE5i8NNWLsts3zhXKoSMmFlvtVZx?=
 =?us-ascii?Q?WptXkBQ87Nyi4v+WxRiWruY2gt6aG/OKSJ9OfafmF/FmcKzcbeLDEMB1JI8L?=
 =?us-ascii?Q?6RbCqrwSF1XnbqQewrPc+j5n7/+TXJs25rGxE4ZXg52PIxfIndd0TROfk7AK?=
 =?us-ascii?Q?LZ9QY+k1qtYAB3/chfhvJ4GFzDTHZsXbPrnF/juvYBdFG8mqdb31Q5OY2rkf?=
 =?us-ascii?Q?gY1RPsI6U8mmrIpkfJCA2A38UxOeyv36RiWpCDvr3YqzLeEAyN6UCpwydKuB?=
 =?us-ascii?Q?bad7moyNzfAicXc6YKjeD0AfdbW/FGxCZwU8jjnNzD9+2Nnm+0MU+TptjIiM?=
 =?us-ascii?Q?+p18dq90LfysAvhwjMTiYyMa6kFZTut1pNgWqViOTh3Ot2h4zqu2HmgfyTfx?=
 =?us-ascii?Q?h3nR1flGiUv/i4h53OXW9p03Bi9bs8/Kmc+IMGxMksupxC9NLCepoi9rOfOv?=
 =?us-ascii?Q?DX0DZscSj6k97CodsEQAaqaQaln6Rnlpgx+efVy52TW9yPcvTeTXZy+vVYdy?=
 =?us-ascii?Q?egVUhdPbUZRV8k7Ovsij4I6HK2QsPA7FYAZXKGRByiIjkfmhwxVH6VVguRFm?=
 =?us-ascii?Q?1KDvVVotq0597fWzRQeZ7AUdHsCqhi5IuRuTV1qrZLFFpKiw557X/NeHPPyd?=
 =?us-ascii?Q?ylhthGG0iohzg0Lm9A6n2kygKqw7DdYruTXbymlhahV+Sy8xnZSh9MlxtoV9?=
 =?us-ascii?Q?+7jstacY8GFgtc0jCREf6S5Eu15gQWs0JFHlfCInrv3ta6W8A8UmDUiKqCH2?=
 =?us-ascii?Q?2v4hsU1UwM+ezVup25T+L4ZlYqFeyukHN62+LOcxkC8q61gDrrU+dL7AqDzR?=
 =?us-ascii?Q?TXl20paPvQKvHHUUAYApv6IkKuxmVqbj0vNUu1Yj8rKHCN/W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fQ4k5oT4vtl8kpMt8rMEffqD0fpODrpAaBV1e7CkqL9zAWJXg8V65WbWfvdtMMN2R3X41gIaRTM8QEZheT8ttz/98Ps0rhQnCHVTmfy/uFpMG+Mw5U1gPdK3gFu7vne5b5H9orekbM69lti3nwvKwx5vAsH/WsJAD5ugttHGBvKeen8h4VXIsi0QMG6ot4yHayRNmFpi8WLpuSCN8TmNQnK9RxHUdWdobL35CvT2+D6NNMB3BmMIQYItvmL92jlVhQsbJXfm9Q/bob7KDjmHS93ZjxDmoDPzu+7K0C3D99y2w9d1wx3ViqWbfOyjdZWIm0/zwmpujv7QaZxu4W5TNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee26e0a6-2675-42fe-5fe8-08df4a01f697
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:07:20.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/0KVa30LwQgSjHuic9B8DEUS5AfMVU6ut0w24+0gPld3/c7WXuRPzpYwXATE1j6vTvOh5T1Frh3wdFzNyo/+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5190
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, November 12, 2026 12:31 PM
>=20
> Intel VT-d hardware gains a second set of DMA translation structures,
> managed by the TDX module and used only for devices assigned to TDs.
> Each IOMMU has a trusted root-table address register and a trusted
> invalidation queue, both accessible only from SEAM. The existing
> untrusted DMA translation path of the IOMMU stays under host control.
>=20
> Before trusted DMA can be used through an IOMMU, the TDX module must
> initialize these resources. TDH.IOMMU.SETUP does this: it puts the
> IOMMU into Secure TDX Mode, programs the trusted root table and the

s/Secure TDX Mode/TDX mode/, across the series

>  }
> +
> +/* No cache flush is needed; hardware keeps caches coherent across KeyID=
s.
> */
> +u64 tdh_iommu_setup(u64 reg_base, struct tdx_iommu_mt_param *param,
> +		    u64 *tdx_iommu_id)

No context why talking about cache flush here.
