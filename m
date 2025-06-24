Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A702A1A4
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767901; cv=fail; b=tmq+rQu4UMF/cZIouSV9SziCSIxLkAr9NT9OtmWz749ICUqZK0OdHVnvQz90NilwqSfRy2UlK9b1hrREz/6tmdmfxARErWE8FoPOHLwz9UmGQe6Cp/9FTe/dW7Ww61kAwlZOJUQqJS2G5twApryZDj50rCQOJytQPYAvZZtWYw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767901; c=relaxed/simple;
	bh=wrzbE9SV5EqskKRX2ITpgR2Xo4/2mq9ZrtimxFMNyus=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HmOK8gM+G+EQ8Bm48JcjxPT+7lpCCLm7VrmWN2a5c+k5h9O/ncdZuJ7+xxgVhDV3vII84WQ3z4n0yUfGWQ6Yfo3gZmJ8J2jFxeIyKH9gJTp5oT+KjyzlS9odEXB72IsLX590OUPSnih51nd2LXwrLIR6I+G6khx77rMu44bhNCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRayj7F2; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRayj7F2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750767900; x=1782303900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wrzbE9SV5EqskKRX2ITpgR2Xo4/2mq9ZrtimxFMNyus=;
  b=fRayj7F2vAMkXiOTVOF5IZnyHyUhXFBxZ8u/Cqg6Iu9HtsQNElbfplw6
   uMO5bwy7pC+r6NjqA5BJaMKSiR3MG1CdLXGDTO/R20LP5VsMkcSBY8f2J
   L5Gm9uKDHziblX/wm5nSQG/z1cJ8Dk5rZ5k5+DN/vvDvCB3N9bQPTNrn2
   zzyrKlIz7zIONPc5Dk1n7X8yj3cpzsh8lCgia+3Y5aNaXkafKrDfw915Z
   7dtDaxeY2yYKCpTbyFLdUz5ZTLRTRw0eZ31von6FORbAb/lyVCVzHD7wH
   yiM3/9QjQr03smSueKadJHkeilvEcHlSFwGdLrj5uPVQAI4DbT8i2RLLi
   A==;
X-CSE-ConnectionGUID: z/OsSHysQzaiDkTJidbG2g==
X-CSE-MsgGUID: RUa5QA4gThuIQiKC4t9jIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52121014"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52121014"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:24:59 -0700
X-CSE-ConnectionGUID: +4/NQ8qPQ5SH7vT2SKoipg==
X-CSE-MsgGUID: jCg2wW12TcCZS7Hfk12cqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="156477231"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:24:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 05:24:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 05:24:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 05:24:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZ6vIASdgtanv/QplUhKnnmxqWFdhkKsoutynGeXrgsTbI17Qak5L1jZvw72XF80m/B1ZNdB/MiAsi8fDR/C820dqUi5TBMUt/ihMrV9Vsc3RCk0cCibggRVymnEQx0YbbTsTKx2QZ24f+wBHWUdlOR1tFBmOxMo4QP3TL5OH02jnYASuX2f8Il+Q8AiV+0gEsjCyDjojRjq5qq3y3WvtAWOItsP6I/ytxicx7NwzUGuGEXfHVtgDg2NLJmYr0S/A6WqTxrS4KeU8GfmYYVcRUvBnv/ajy/L8ADx0MQ25qQUUIOWwC5o7bu0NR639nrOMGnpKyq7YcXkJtLQlrdPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SQ4Wg5oBy5sP34nwadGUEiqy28gllcriGGdO4yzkJM=;
 b=GSKssCiABq2zN1ktzpkmrQjMS7pZCxBfdfp9denV/zw0u3EdWagbO+KdcE2aR4wAaE/1y7VwzEYMT+Ej/52zhdYO/NVmNZJE+IjgUlO6wFH3p4+YRO3yEmxoKBtkR7BY94Ipmv7R5mOdJvEh2hmaSho1bwb7qv9ViZGBharyp6ieWa2416KjAL2wM2cSC6XoNnmW3dmv4Oo/30ZAcUYkBJuoBNDQHlKzZl0RIKf5d6hdTmItFrQ/IM1zw3QJsFhCMpnfqF1fc+d/7U1BLXWZ2Nz4+mTfO2NvJvOWrAwoD5NMnGxCRbYu1GWt5Xi4E4kjDwB9y5107Gs0+u3HH0/Irw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PPF5217261E0.namprd11.prod.outlook.com (2603:10b6:f:fc00::f21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Tue, 24 Jun
 2025 12:24:40 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 12:24:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>
Subject: RE: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Topic: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Thread-Index: AQHb2dRy0pZb6YCA9kCQvhSriVTQbbP/KocwgACgJoCAAOcYcIAAW7EAgAQtLwCAAA6p8IAAwFeAgAEAUQCAAK9oAIAAtsMAgACH6YCAABWYAIAAAh0AgAkjV4CAAB4LQA==
Date: Tue, 24 Jun 2025 12:24:40 +0000
Message-ID: <BN9PR11MB527677E136550FEBBF3AAFF28C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276B467ADCC57BC6571CA458C77A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250613124202.GD1130869@ziepe.ca> <yq5abjqotim7.fsf@kernel.org>
 <BN9PR11MB527633CA2F698E83E12BFBD68C70A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250616164941.GA1373692@ziepe.ca> <yq5azfe6ssev.fsf@kernel.org>
 <20250617183452.GG1376515@ziepe.ca> <yq5awm99sjmr.fsf@kernel.org>
 <20250618133527.GQ1376515@ziepe.ca> <yq5att4drtj7.fsf@kernel.org>
 <20250618150018.GS1376515@ziepe.ca> <yq5a8qlh5t0c.fsf@kernel.org>
In-Reply-To: <yq5a8qlh5t0c.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PPF5217261E0:EE_
x-ms-office365-filtering-correlation-id: 84cfa244-1a47-4b9b-9155-08ddb31a17c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DgFiRDIfAI171HeOAlLcGts4DUW0beKXb/NB8KqUh6RrC51jMr9g4NJC3jUP?=
 =?us-ascii?Q?NKr+5ohrM69/GXGC4FpxDvAJvxHlwUswWdk+0huSVHn6IjfIFWjKV8GsY500?=
 =?us-ascii?Q?7+zun+aIriIU76EiY+Th5alfAIQv4M3erdO/KkspAxxXKK2jisK2iwEgCesg?=
 =?us-ascii?Q?hCzO7e9ymi7O74baNZ/xe7d2MozNmssUuxt/9f1PKK5eB8kFpPY0NMCOWX0m?=
 =?us-ascii?Q?KwgmXXL81UStycbiFARYZq7bvTMqeSEOscKyx7nAoQdeWrSfava4VT4lppVz?=
 =?us-ascii?Q?JX+mq2Qu1VvqE87NME2okmfA6pgJkyfgLSzDAhL3rPDh5PAq9BeLHfUjmZL7?=
 =?us-ascii?Q?nnuPWim8FJX+lUZuRvV7TUivc78+UXZY43/HmTu28FLLyq/c4zhufd6VoBEU?=
 =?us-ascii?Q?YVLdF9dj/YyDTKd8RsR8nVp2CTLy4RXAUYri1ZywU4Lejf50CQ2sjkbEy7aV?=
 =?us-ascii?Q?2PO+fOQ5P2uhmNoimtRVl3wm0BbJvBh1RYwQcUAxuSHspRwH3SEbQHoN1++O?=
 =?us-ascii?Q?ZOXQaLm0PeCDdKnetELuY2dWeQxx3qfvMRWBYeMX0hes0YD0ooXFCXfiicyl?=
 =?us-ascii?Q?q9F65ioln7FvPz23uo2M0cpRJUNowA/oZ10olHAD0EfxE0y5hRxJIqAUXPBV?=
 =?us-ascii?Q?n275I12Y1ZkxVjd9cQaEp50RqRNHnd8Ptm+6LPNbbe7z/R8sovLhNehjF133?=
 =?us-ascii?Q?DoGaDPX4K5ZmH3l4xMCZztudXHhG5cwOIi83CC9vS0FhCDmpcVFDPT8MR95i?=
 =?us-ascii?Q?+Lz6xQj9Bgrt8cN8OfjUx5+fjX7PttL1OaEY7rwysW1wKH0OxdyrsRqz7SlB?=
 =?us-ascii?Q?V1Zj9T4h8tGFdzAAdzLXbFo8mU9IRj7WLe2VDxU3M0tOOoAK23Ks64adyJzD?=
 =?us-ascii?Q?FiIxJMt89DDpP6dLzQ0rugZQq2XWKEBaLsq3g0/gSWbDpvb/sNffbpUJ3H8P?=
 =?us-ascii?Q?By5o2lf1GoeQbZ+iEeaLCGJvsEwZ5fW0ex1Z8zREBEtV4n+jJg3Fdzq/aQSM?=
 =?us-ascii?Q?1cJ0LIcj5OsAFxsLC87bMMb52VZml5QtNWPxhGYe6Bolvaa0EA6Bgzd3ODop?=
 =?us-ascii?Q?Lka9Ek3pYcQ5Q0qAn2xYBFVr8Q1HbvnuGQ+ft62tM4U01Ecl+BJ0Lv44czBY?=
 =?us-ascii?Q?80r/gg2Ew+XD8pXCwDSiu4P7D4J88Z2AetNG9XTWh52mPrm56j7uzZWYaNHK?=
 =?us-ascii?Q?NvbsWh2+Dd6dPlNI8iLquot3J0pXMIXJxbb83egKcariHTPvImYTofz24lrH?=
 =?us-ascii?Q?uqwgV8wSNmxnQOPR9H+jIrvqojhDyNbw2EJJgy/rodbicW0s1ln/r4HglVbF?=
 =?us-ascii?Q?T5j7kIHFN2Sn4nhN0h5ImaaFD2e8LbNLKBF4OhYbgSoq3rLOUxMa44+yPzW8?=
 =?us-ascii?Q?yha0Wn7hUsyLjy+Gx5B+/qbM2GFDHtubUEIeveyI3Aoa3+XDLtBxTAbEkgrI?=
 =?us-ascii?Q?d9gKOKhXkMKZxG9+OArkdtmtifJDkaIHNGVBzq+LQ0j4yNP27cKzl9YSBQP+?=
 =?us-ascii?Q?yhp6ZgC+Or8quUQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GZavI6Ovde1NZ9rtccKOHgtVL0ZWVpkZkKoQsJGxUtj6LX6GMl/P+qg1Jmt3?=
 =?us-ascii?Q?1e9+l/Tt5LqzCXBj6KzhB0DVSIP5fG7cmfgRs3I7G681bXtGZxEaNJoH6d6q?=
 =?us-ascii?Q?hnpzTet3/bL674JbwPFTS9XIIr/dhq4E/GzV+EgskDjPrmABb9F5RphOG99Q?=
 =?us-ascii?Q?Q5HSwliDbH7TQ32sOHvYouVprJnyqf5/tuEQ9T+E8wl78aGAuyb3mM8jgnZV?=
 =?us-ascii?Q?guqxHp0ZRr33iFIUpBjZq7pvKZbABGQ+ad4zac7isgsj0KaUl7DqZzRdmQDs?=
 =?us-ascii?Q?U0qBilAP/lEdG7VRR1AQxW9u6W7QSNg7no2Nwv+2riRETQBHUS4bibvLLW+A?=
 =?us-ascii?Q?wtgKRpdNmt6/OjgNBDHU0JnDEGwIf53eLQRKn4h/fnhfqylBSNLX6f1Q0SH8?=
 =?us-ascii?Q?oU8zAdjjKFvXorm4lHMTtum1nIQ5HIECGo8Yy7XzHdJb9e/Q+mNqZ8ZkpOJY?=
 =?us-ascii?Q?H3lxUIvh6NsHC1xO/raGEPg/nnH2X4PfScCR0dcHr+aJRAjBvl+vH/CYy5oi?=
 =?us-ascii?Q?i3Ps4EsCrnQB2J1FDrkIBiLWnp7AdA1BW2XKU8Q6YUK49ncuzaP+K+yrtMCk?=
 =?us-ascii?Q?EpwuAMwhNPG4ZfcM7C72pvpCYdEmjB+w1IXAAMOd/+aOUqTyeBOMPHlDsPxW?=
 =?us-ascii?Q?ql0qKlaBR78OW5UeEt9F9sScXfPI9jZIJBWuXE7462yS1DuZvjPdNCe3uukI?=
 =?us-ascii?Q?4M+IeKI2HwEu/TUlOwfpKrjbbyKJTpelcNVSlEGUlL9a71IM08TKYUsHJD5W?=
 =?us-ascii?Q?ay3t1pnAW9MO0DrX8jVUDhgoi0TsPRPPXmtIieeiHxpTuahSIzTGzj7UUC7r?=
 =?us-ascii?Q?9mCt7RLmLVanqRrEKN8aISrx5hW6nmQ1SifBi2EGjaBBSEfL9HuhGcpP8lXL?=
 =?us-ascii?Q?cP8raR3sVtjaYiKrXzAXsy6HSZ0lAfks5z8UewUcS+qIThjyOfsP8oom8B/s?=
 =?us-ascii?Q?SaDDZc8/xTvH9KjuG5RlApdkBDn1GUFHW0PfBzBq/K05AHBmxKLNSfFV5SQa?=
 =?us-ascii?Q?XJRApHS+HNytoBtBwW1oyijBCG5Rya/hdv1wK94usMqKxsx6VUgadG5jCKBm?=
 =?us-ascii?Q?ajQXHPGPBPI2+QB9dMpf5mASXKFYNV0jUatFEUnhpI3B6N1n5/zhRG/FEPSc?=
 =?us-ascii?Q?v2kED5v4Zr4Gb3xR3h5lVHqQF0gd4rnMSB1BggUdBrk1PIiaPElmoCli8kFZ?=
 =?us-ascii?Q?6kiN1zdah9vwgT9JqXnsEGpt48sm5CwTshauC/fPUdHlxHrjyAu34MtbazMg?=
 =?us-ascii?Q?ZvuB6E3Yb1vzh1ushvMk8z5kFA+j/S2KK7PNJOswtNau2DHBrJfEETXCzfoH?=
 =?us-ascii?Q?IbuEJ9A3zreKJwc+wbX0wvfTyAzEF6cJJfpjgCg5xI3cn7vO+KR0qouybpKM?=
 =?us-ascii?Q?1vN9TbrveBSp1qbNn6Lhj0zdW2slVt5ix+QkFRhrSqdbfRO4a1+jTu6unCHh?=
 =?us-ascii?Q?3DVAYG7ZLjgt7tRmElAnTA61BBvV065dtH2gaWuUe/SPzifiaHCsO9ubEboq?=
 =?us-ascii?Q?3c2iiPLm6hpYEALZiINqjs176eWLtiHXqvom/0Xr0uqIhjT6DyWY5VuDqsJ1?=
 =?us-ascii?Q?rt/okkE3cffLu8kz0ZVCuXotnVhn3q7nQlci+vWW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84cfa244-1a47-4b9b-9155-08ddb31a17c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 12:24:40.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rn/5XOUNIti1Vl5K2GiQRhC1ntEeNYksvoUrliMQ+GximpdSyPgnVsZOwjQPmDI7qLnClCuTbeB7jZmJLmAYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5217261E0
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Sent: Tuesday, June 24, 2025 6:33 PM
> Jason Gunthorpe <jgg@ziepe.ca> writes:
>=20
> > On Wed, Jun 18, 2025 at 08:22:44PM +0530, Aneesh Kumar K.V wrote:
> >> > The full sequence I would expect a sane userspace to do is:
> >> >
> >> > open(vfio_cdev)
> >> > ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> >> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> >> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> >> > ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC)
> >> > ioctl(iommufd, IOMMUFD_CMD_VIOMMU_DEALLOC)
> >> > close(vfio_cdev);
> >> >
> >>
> >> And if the user does
> >>
> >> open(vfio_cdev)
> >> ioctl(vfio_cdev, VFIO_DEVICE_BIND_IOMMUFD, iommufd)
> >> ioctl(iommufd, IOMMUFD_CMD_VIOMMU_ALLOC)
> >> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_ALLOC)
> >> close(vfio_cdev);   -> this should call vdevice_destroy because idevic=
e is
> getting destroyed here (we will put XA_ZERO_ENTRY here).
> >
> > Yes, we have to destroy the vdevice internally here
> >
> >> ioctl(iommufd, IOMMUFD_CMD_VDEVICE_DEALLOC) -> No error, we
> convert the XA_ZERO_ENTRY to NULL here?
> >
> > This should probably fail since the user has done something wrong and
> > it would be the only way to realize it. The failure could clean up the
> > tombstone, or it could just leak I don't have a strong feeling.
> >
> > If you leak then using XA_ZERO_ENTRY is easy, if you want to clean up
> > then you'd have to have a global static 'tombstone object' that sits
> > in the xarray.
>=20
> I have a related question w.r.t iommufd_fops_release(). How is that safe
> against a parallel iommufd_destroy()?
>=20
> in iommufd_fops_release ()
> xa_for_each(&ictx->objects, index, obj) {
>=20
>                             ---> A parallel iommufd_destroy() can free th=
e obj here ?
>=20
> 	if (!refcount_dec_if_one(&obj->users))
> 		continue;
>=20
> }

@release is called when a fd is closed, while the fd cannot be closed
when there is ongoing ioctl on it. So when iommufd_fops_release()
is invoked there is no parallel user-initiated operation.
