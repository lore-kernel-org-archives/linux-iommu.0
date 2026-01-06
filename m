Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5112236F2
	for <iommu@lists.linux.dev>; Tue,  6 Jan 2026 07:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685741; cv=fail; b=q/iJbwuIBkMSckK1nXiBAcwfcVpfpHxUEh5BD6esXXexoNNh8v/F1HhtK8nBPiF5cnwng1oqXiLF7thylRqOcpuVLbsWbQCGc+Q94pncn73tqKC9ZpXBE4CkC+mwDVkReptVj+AXjoK+GLl3y+pI0ClKPWbm5CLdCUBVLyoXDzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685741; c=relaxed/simple;
	bh=X8zyg3zweY3U7OgqoyFaeW3nvdXL2wYS3tavrmtUbdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HUC7R/HEOAWl+xEqMSN1mw+cYOwIV12PMCpz+bkGg5mAgoClJd3sCvJ9yDs6aUbruiUODTvGVyt2a1cc0SRgDnoZDd3IKc0z191ygL6RKFG9sxXlhaeKXrlRHCqhSloeGpV6JiW36f2NKcx8DxxSkRuWLdKOa+i2bLiXWXtftss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYx9IT6O; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYx9IT6O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767685740; x=1799221740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X8zyg3zweY3U7OgqoyFaeW3nvdXL2wYS3tavrmtUbdE=;
  b=IYx9IT6OykMnLzRAy5ceEWa5NbXUb19D9/HLeynU1o6ALM3UjzQFJTe6
   1yjI5E3rOtiZ1jhAQNlIw3gNTzIt0mlhptMK+4Jx56e9j+bLy7CjVHYsm
   TjOBfYQ/t0IMxb/xJnqWdThJzA8r4LnTpbeXbvG2tcJ4A9y2Jdr6jE+pH
   ZcIs6ktZOYREFLlSo5x7AyY5Q2Z90dwPWYfmyDNJ7Rj1/DuluUe3jexWW
   36fCSbOsseGfPmeLqhRgTyYCMkrqEseAm6s6BCKTLs+iTJbMf5bKiwkAn
   /VFpdpCgpnRmGoXfOBY7buPIIfEENpMb41fb2QNYm+lL0oQGzvQ8jVBcY
   Q==;
X-CSE-ConnectionGUID: H0sbWC3qS6iM6gKl4fKv6w==
X-CSE-MsgGUID: fZTEQBTJTiqfVqA8c3QFPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="72895327"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="72895327"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 23:48:59 -0800
X-CSE-ConnectionGUID: Bf3iI9cuQouJ4xNQGorZAg==
X-CSE-MsgGUID: XAxVvOBBQpu7Oijiu+tOnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="206734513"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 23:48:58 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 23:48:58 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 5 Jan 2026 23:48:58 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 5 Jan 2026 23:48:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfYgAobyQ87+nQYJN6hlzoBFMBfVPB/r9yWdqS/1tkNzD7qOg1n2qqAMeb2DD3feKbH95aERr8ahbkdgKsW5uY6LEDrkJ5jhu1VBG3jyRPA/mi4KdBHLL4U9rBLJC+TF8BsH2r0QTI/toLH1DZ6i+fSW8mEKwy4aNvwbiYvgJHsNQOgVdEnBSqPHySvoJ6p+xU9FPJ+Ddgp8DIq9s6WUxmasQHVmHutRUv9NpVigjasCxnvZQMqa+YkRtXu4Ya+jFrllz/KgTT8PJtFYkf3dZTNDagtT1EYpYZiuwobpyK/xDaOle9/tYFRMqpzf5401dwdPKrmtRMCj8L+Z/xXilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usBpcXnzEi8vRtYZHSJkbqoAk1fOXmNzxXIFL488OCU=;
 b=r54gKsZj57LG5hJRxQKuj0W1Rn8LH71/IYO9iZmL82X46qV0fntPKwZy5i2c6vyiSrWxhP4x1+fKcvC6DhM/RSXTn6Iiz7ZgZ/hiX4XemcwTLDxRepySoHK1N9PLdu4hebdbrzLW3wExoWULi287ozE+eyi7xfzSNHHyXFv+4yKr0X/Q46pdvNZXa0uCmrsT5ArtPTXLDpihtCQLSipAV1BngET+GxFnGR1PpB5WrBFDSpFKRs/8TEAKHyQDN6eKkTNJV2IncNwsyYowRXZtuQS0T46jIPd/nLjIuCAPbRvXsMbDt51hVfSTNVy4b6Yp93IkwsResmccGzY6OB2UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CY5PR11MB6463.namprd11.prod.outlook.com (2603:10b6:930:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:48:50 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 07:48:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Dmytro Maluka <dmaluka@chromium.org>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Vineeth Pillai (Google)"
	<vineeth@bitbyteword.org>, Aashish Sharma <aashish@aashishsharma.net>,
	Grzegorz Jaszczyk <jaszczyk@chromium.org>, "Dong, Chuanxiao"
	<chuanxiao.dong@intel.com>
Subject: RE: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Topic: [PATCH v2 0/5] iommu/vt-d: Ensure memory ordering in context &
 root entry updates
Thread-Index: AQHcd1pONBzWAyEdQUC7AlJ00GGhhbVD7t0AgAAL+4CAAAVkAIAADl4AgABFfQCAAHz3IA==
Date: Tue, 6 Jan 2026 07:48:50 +0000
Message-ID: <BL1PR11MB5271B47577A94CE3780D8ABF8C87A@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20251227175728.4358-1-dmaluka@chromium.org>
 <20260105181200.GH125261@ziepe.ca> <aVwI_SHHGPl0xndu@google.com>
 <20260105191410.GJ125261@ziepe.ca> <aVwZkFQ-iQ7OHMi2@google.com>
 <20260106001418.GK125261@ziepe.ca>
In-Reply-To: <20260106001418.GK125261@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CY5PR11MB6463:EE_
x-ms-office365-filtering-correlation-id: eacfea4e-0366-44df-10fb-08de4cf8083f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?hh9qoY/OfsHYTLlog33ghHmoVLmMUAKyCXsaXTEPyArEHZZH/bColLzYwGwp?=
 =?us-ascii?Q?jeTp4oFQIrV/CfKbknRfBL8Nsw9/a4ZAvRO2+PRTwuEFfxD8KdneGJnuz2Cz?=
 =?us-ascii?Q?MRIQGvk7i0OT+6dphiWCoJfOe70gG7mG5pZwiDVhia44ElEYxe7bbMoSQh4C?=
 =?us-ascii?Q?ozWckAtF4QmSXypA7HKJv9xfKUUoP7hmQwOsUWaSAhPZ3dqeGrKKAjxIw0QN?=
 =?us-ascii?Q?+fVcDD/pCUvbYqi2C1wfJrEA8S7WzqkcEnyO7diroHuAC7fvPJrOibU5bt1U?=
 =?us-ascii?Q?sX+x0Jv4yfFlVGZsDfLe1zWtAh76PCn/CJj73VtfPFH7oDtfhbiYOqbxF0Hk?=
 =?us-ascii?Q?NvxQa25Gfwh1RzoLxliTzJXd0Zk78CKS65mkUbG4dXZd3eo71MF1a6USYiqK?=
 =?us-ascii?Q?aFGg8j/Lnr0A2FCdj+f1zPInaAKsEp1EJRTv+RVjQ094b80fzS1elispO3QW?=
 =?us-ascii?Q?aLmNXvZe783XEaSAuHvSDlVaD9MQnlG4bM97w4ckuUnMbNlc317dIsyyMIQA?=
 =?us-ascii?Q?o4GCDf1pj8Bqjz33eC/NMS0vlJ7i5Ix785LjT8RcJaecsGW/tJh1A0znAZLa?=
 =?us-ascii?Q?SWPbYt9BhW2G0zd5z8OzFxiNyIesZZU8N9cq0+fv9qkNKUzdmuPDUrLi5kcM?=
 =?us-ascii?Q?hjvrnnMY2v269im7mFxNODclI4HepJITyVO6thEW3bFbIh4rQMNI5oLHK6Ny?=
 =?us-ascii?Q?XChjk4Yw9asX6qY0MUXoKLCR01LYApF6fxPYyJ74e9Tus3OuRit1UOokrx/i?=
 =?us-ascii?Q?t3brMEE3mUNHsq2YbstM2pn4b9fVucRNFvk53lCQLzwswx/QulMcENI3jQbq?=
 =?us-ascii?Q?C/wKkigJTffD/YqQaKFpG1fK0B5ZH5f590Oux4Z9eVq4NP6pEZam9+XTazw7?=
 =?us-ascii?Q?3bYy3xkVgYg7sAD5FFdSDFjqsJClj378yzhZYmJLogUBnhcI6nYScLgRQgL+?=
 =?us-ascii?Q?UxkC3WgXJozqZEjELhsN8XvBzP10edplH5XNgeP/3KB5qrllrztK7Jujoy8I?=
 =?us-ascii?Q?Ljk8bGZIt7JLbbU3cb+GrBUVelkpe+qZc095veyp8Ly/UDnL9rPelQynnxIO?=
 =?us-ascii?Q?fZSwsTIrcOBk5xwbVNQFKXGjIGfaxkx2fc3IPP567KbWAnKJNyliiPhsY+6D?=
 =?us-ascii?Q?Qx6x0Bp2xtbV+6B7wUr71XKc2Rjx8v+Dm9ls71LCsjA8ON2k0+v4MuIGjwJM?=
 =?us-ascii?Q?Kcf0MNuXfkcWFKDREWTPq+JT6LglPT8HVpLSJe+ft6UdYjBoTbj+iM/pe25T?=
 =?us-ascii?Q?mPbtV0WM7zAybVsr4TKYc3E8+AasYR1cSdxLFz+2xz6GZUE/7c/2jyTgd3ph?=
 =?us-ascii?Q?CTZX2s/MIysJGHvxIEee0bmSDU07hYqVg0pXy9+NJk+oqdZmRXiX8Xvl9RYQ?=
 =?us-ascii?Q?11MS+T49fm2QPoEYwVqGTGv1CMnDFoz4Rb26yaSDDbLtZA95eEI30eP+6ItF?=
 =?us-ascii?Q?LG5FvDPRb2A5GRf7RPJHKY6f1XetoMvM9O+Rg1iMu5U65VOkSjqXCpyOraYE?=
 =?us-ascii?Q?Tg26EGUzpm0ePt4kVgtr1elutm/5mcUpfinZ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NZndgAgaa35Uii5lWDUduXXPZrwEGtoH5U/WcnG9daBqCjTlyZ7tPKbpWj/d?=
 =?us-ascii?Q?SWX0CNM1/bBXjdb8UdMDgZqJ/gNZYNGP9Cuto00T2sOWx96VVh7mJhguDmde?=
 =?us-ascii?Q?jJHnsB6lZ1XUxWGyVK3ffvgDyETHAL2FMAHl4XfvtyB0owvRQ0rPUArLMo9v?=
 =?us-ascii?Q?fWakN95DRtd9rAE08w7MF4IaJBkRrM/Wv8ARCHtb5XN90hZBAR7XbrzMC91i?=
 =?us-ascii?Q?CNtFXFOrV4RFREDWY1YNw20V2RwVzFtoiDqk2939hFc//JYUiEIDGsN2ZNmN?=
 =?us-ascii?Q?76scIjxglE22lAlqrdx2I7leWeJ3lsKGGziu3RceWTVi2sg371bC17EmlLpD?=
 =?us-ascii?Q?/HVWkDMRBBpw1X+dDlaxnZm47UoruXDmz6QNsrSOFFjW11oJkcoMS3ITx5Ss?=
 =?us-ascii?Q?YWLMLV1fBspLQcMfB9mE7f5TPtzi10g0rWWDZFHVZTnk/yfZczfj0CxJLW5F?=
 =?us-ascii?Q?Pst257aXkRlDgOCcRuYNIFG3NgvERSMneHKuC0r+NQwDQ2GfVR/xvy3Tn6Pt?=
 =?us-ascii?Q?/PV1Tp83RcO/QMzUDJuhTEbrcHjrYM5nS77jaTtR7WeEMiZ8jHABU+ABd5Zt?=
 =?us-ascii?Q?g4jWqdtjrXWrBWCoJ1/Ooy9v7Dgfrls1q1972eQUxAbpgbg1WjwGFRCeR1lm?=
 =?us-ascii?Q?uac/BQ160E6Z29eWrfOafX4Zvkl4OZDoPTtMQRDb6btDP03cs/yYGqkwFKHC?=
 =?us-ascii?Q?l1JccDXyHjJQrbYzwZ4Lh86lz2yq/GsjfOKEx6iKkgg6pwSqhVI5S8V5QXBA?=
 =?us-ascii?Q?CjwjsV7hwsCnIZ+9DpZS0IqcEklELoXMl7qFTEfwtF2+JgSMMBIfbi143tLG?=
 =?us-ascii?Q?NFAe7yudPczFT/hYaY251TYEIScJzG02a3h7tr6PSobHhziwrHx4I645OQrq?=
 =?us-ascii?Q?VgaeAvg+xAWvuoHEBdMKOTNhkUuFzNZlTLBCR98n7QdaU9Zk2uO69Ouikxa9?=
 =?us-ascii?Q?P6/RR4Z6rwnjX5vkF3qYP9MgS0C2s8KLPtIO2vgW5CWjtIF2FUV9rrla9xm+?=
 =?us-ascii?Q?fEYrRBdb8hp1y0lghWGGkjj977CHXYARD4vrFIJ7s+HGe2Ha6aLbIDkybW3T?=
 =?us-ascii?Q?npXPSSQ3u15JNbgt7h+t2s/Q26YLRmtzMi7FyC9Yf9dsF3XQtJDFPNuplfmw?=
 =?us-ascii?Q?KQA9m7HZ9YnbDhZ2Ck4lXFrIlG1Z73NAKoEalqmaaL22rxn7w4Caoh7V1HJR?=
 =?us-ascii?Q?wy7R0ZzkyKPGduB8zhUGU2Wu5fVO0M8ub7FV2G07m7sdxN/o9H5/oJCpGWzb?=
 =?us-ascii?Q?lJEMSE296raaPKhiggy4PieL4SJhddMjahHpQiB4px76FZ91NPdaWvY8M+CC?=
 =?us-ascii?Q?KG0bwfkmu2Ee+Rymr0qYIzJh5gS8sBnwcu6pUPfN7t8BNlnHA7KxCuh4eg7t?=
 =?us-ascii?Q?rh834VV60qdV295lpPziy2Di71H1XBem/93N2Fhio0MsULZiztVUoKdZ6BbF?=
 =?us-ascii?Q?HY02iR1cEMexCDNQGH9C8ZyLGQ/qcscxrAWczG/lkNE84I591ADGXxWlaHPd?=
 =?us-ascii?Q?I3OjeIlI+DcRg/EFIqsdq/2C4IAkIaY2kqRgyKQ1BImxC4tDhZPh9jRz5xyI?=
 =?us-ascii?Q?hLmvH0KZ/9FKASk3Z9Otn+6mCzK1OI8wjZR/mTUNp1+k6HuW6fQsQjvZ0nt1?=
 =?us-ascii?Q?1K+nuoWt3GOf5uLPjt9faP/PgH2RL3J95VMcwgAK86daMAjZUqbs24v9duCn?=
 =?us-ascii?Q?zbsYqDnBYwIfd2axmy31WpMSdkbxcDSjW5G66h2PbWepAYezqGLrJDM3SKsV?=
 =?us-ascii?Q?awwuTUbBiw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacfea4e-0366-44df-10fb-08de4cf8083f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 07:48:50.6578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sW0BwilC3uhFYlGqFMs0cvol1sbUOOcNZnZYvAeqyx2nq33WH/rIieBvfe9X6Nj3VmVjtqBsB0wNwwCohD6YNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6463
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, January 6, 2026 8:14 AM
>=20
> On Mon, Jan 05, 2026 at 09:05:36PM +0100, Dmytro Maluka wrote:
> > > and WRITE_ONCE is pointless if the HW is promising not to
> > > read it due to non-present.
> >
> > As long as we use a barrier. And IIUC vice versa, if we use WRITE_ONCE
> > for any updates, a barrier is not necessary (on x86). And WRITE_ONCE fo=
r
> > any updates (for PASID entries) is what was already done before this
> > series.
>=20
> That is an x86 ism and it shouldn't be needlessly leaked into drivers.

yeah WRITE_ONCE() is not by definition to guarantee the ordering between
CPU and device.

lots of READ_ONCE()/WRITE_ONCE() in existing code are meaningless,
as 1) between CPUs there is already lock protection; 2) between CPU and
device it requires dma_wmb() to guarantee the order.

> As this is not performance it should have the portable flow:
>=20
>    WRITE_ONCE(non-present)
>    dma_wmb()
>    <cmd to flush caches>
>=20
>    [..]
>    <writes to the entry>
>=20
>    dma_wmb()
>    WRITE_ONCE(present)
>=20
> So, it seems to me like all you need here is the one line to add the
> dma_wmb() prior to setting present.

+1
