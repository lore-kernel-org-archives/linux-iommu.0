Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819B15C13A
	for <iommu@lists.linux.dev>; Mon, 30 Sep 2024 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682284; cv=fail; b=IX+6syEHPBbyLaBKXL+vP2kFn0/FPw8uGT4//wpfjmNBmckHTLc6Vly+dUGpvP/C4g8v+0LUZzs6Oh/LqDv4fzi/mrxyfxX9HLc910r84A3r0MMfvqIvx1Oq/5kfTL6xUmHtFi7WwFSF8jlWhsCuxQwctz8znSMUGWmHpvc8UL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682284; c=relaxed/simple;
	bh=GrymNXqa389jTqO99qH640C0Fe3Wnoo0ArULbNvthv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rTJdDmRyNOdobrpQyjUjv7y+qVs5WbK8q/DCxViCU2DDXYoRZKehyxXAYXFtHsPZrvC+q4UrSLXSQ/wo44KePLlP+rqKmzosbFUGipCMOgYTwZw5+ohh85xVqIJOvYSDd7rAa4wAyh/yWHb0PGT2pYJEBsqShgGtit4wTEujq3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzS6D7dP; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzS6D7dP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727682282; x=1759218282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GrymNXqa389jTqO99qH640C0Fe3Wnoo0ArULbNvthv0=;
  b=AzS6D7dPrxeRxeLLAN0WJdmRoTCuietcqUPrIAcZy/Llig8eMr+V0rvb
   sqGBCSfMHnerSIkLZqydOm5nP8xDV37B72EBKcsmsTdxFN5359l7Sv1ah
   x2XUMcwWwgLaBxARmUq6AvhGuFsNZmDiFmtqQrn+GVLWqC8s+st41v6Fp
   SCnpBTuKeEaqiG/N6R5v00GcagVioL1G+ze/gZUsJc/BPl262UT2db/XI
   QiI5ksTDQ9mgUbOT2UEEO9NlZeNNZhD752Y5Z/npiSV1JX+ntOIeciBUH
   ddpkrsxdG+ZsHgRR7Iix1zxnCOwqBO/v9VaSXHSsg4mXZ282f4a2QwfzO
   A==;
X-CSE-ConnectionGUID: kp3YPZvrR3urw1xcML5C2w==
X-CSE-MsgGUID: 9zuopDewSgezscaWy/jC2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44218449"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44218449"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:44:09 -0700
X-CSE-ConnectionGUID: R5jXlb8QQLiRKW/3Wto2IA==
X-CSE-MsgGUID: BYPr3qKsTCGvgBKvJB2y6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78034064"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 00:44:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 00:44:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 00:44:08 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 00:44:08 -0700
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.24; Mon, 30 Sep 2024 07:44:06 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 07:44:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Duan, Zhenzhong"
	<zhenzhong.duan@intel.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>
Subject: RE: [PATCH v4 03/10] iommufd: Move the iommufd_handle helpers to
 iommufd_private.h
Thread-Topic: [PATCH v4 03/10] iommufd: Move the iommufd_handle helpers to
 iommufd_private.h
Thread-Index: AQHbBRWMU70FVbIeS0S49O7DPTessLJwDqRQ
Date: Mon, 30 Sep 2024 07:44:06 +0000
Message-ID: <BN9PR11MB527657FC837DEE418875D0E98C762@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240912131255.13305-1-yi.l.liu@intel.com>
 <20240912131255.13305-4-yi.l.liu@intel.com>
In-Reply-To: <20240912131255.13305-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7786:EE_
x-ms-office365-filtering-correlation-id: c2e3e5e7-4e48-423b-daca-08dce123a987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vnT808WmhnDlZr1j0MrevGY9f6jkkdbBmteo3Ei0/6pVybcXsIsZDDNelZ9A?=
 =?us-ascii?Q?uMwzRpH9MX1CwPt6oJCYMOoJ0o5JHOww+aj6sbi6O2RDx1oRPjT2sazKsbRY?=
 =?us-ascii?Q?PD03HLyJuNzZrnMCL7OlF0OUxcYtqUfxUb6FKYxGw+TxMxSnuYS+AW20PZWm?=
 =?us-ascii?Q?HM87eabs53TmNkIJRO5f2kAMoKKlMXvn3kvpt4/9Ir1VYSCVQZ1RVvzPFB9g?=
 =?us-ascii?Q?kEDyIMn9snZXDujo7qytNJkaRIuxX3HgerOy+w1hfbHQINHXlzEZqQ1rW9tB?=
 =?us-ascii?Q?9ZJiJvTWfXsOd5bDq9TXNU/XzIy51k6m37Bfl/q+uhypecQHtRgRBYOb0o1T?=
 =?us-ascii?Q?8PAXHGDs2d8GnnjDoqT+n3ydOMr9RXX1hoe3KktF4eqV3QzrpUjw8cvI0ki5?=
 =?us-ascii?Q?lFXRhMolGRFzxoiaat/5u1rYTlAyr85+VFr25tApXzd8WtgfTgShnj12bljF?=
 =?us-ascii?Q?WlpyesHtaJOBULtlE6c0jMuxt/cKbzAfQl5NTH2pbJ1EGxDNp1Ala7L+cxCK?=
 =?us-ascii?Q?4JzmauU9W5mqjqsLBU8RUGEPfn5UEnccgRNHuv7b3A/omhnlTXrESRxSxNNz?=
 =?us-ascii?Q?n40uBqLqgdB76voOmILSHVD8c3y9HFOJIFgBvD1jCSAg9wnUOuUMBywblVj5?=
 =?us-ascii?Q?gqHrlC8QoNe0VpHcq5kbukpVQI5G2o1dl3sruoeV5q7dGIxkQ+UHzu8esqVT?=
 =?us-ascii?Q?eDFmKR83Dv/rNk2wP045vNnxsrod4Rfh9zs9GFPu2q1+4WBl3gFxVhzw99uz?=
 =?us-ascii?Q?AID3n5k9qb42sUVwpwj8TLiUtLrqzz1z2bOARCFfz+8ZEJXrmw/RK9695yFm?=
 =?us-ascii?Q?Rw2Tn/denFH+vwrBczfZiVJNSDnPyK9iCmpQcLYAXTgmlF5Kveok0c58SBV6?=
 =?us-ascii?Q?bEw3pVufcZjPJ84Jck/lJAB5Q5bJz7/PdP/XbTFrr42u3XFLLitc9EkaXKoa?=
 =?us-ascii?Q?zwkFraYMXVDyfHFh/928VARaGCsMRNAf7ojAdKZ1V3SfHDfSY96KvbGAQWHp?=
 =?us-ascii?Q?8NAZxXVJi+yNEA4NydmLc6/mutEAg/Y8kxEcWJBLJjGBLydDvc+G/KLSDzR+?=
 =?us-ascii?Q?pOS5z04AaL3W/zSOnsolcwCvyofNxHsq+NX92H3RZ2Ld3eL21eKItgG4LsXI?=
 =?us-ascii?Q?/J83jb5CRmdAHzgsVObDIUoVJiy+OfXHkHe1PxM/O6FTv+NMQxH54wD3oCvW?=
 =?us-ascii?Q?3Vc8e0wGe9btDWh2MxOZ1tNTA9aNkW4fcRiL7LjFTadXh+a0KDlEPbUx+Go+?=
 =?us-ascii?Q?+5ZjLN9pO3FRzT5xBsMaDeYZ+y8jbRB9LTPPHarFLgp7b82m8RKavXjAav7X?=
 =?us-ascii?Q?Uo0hVjMtX/2+60t3JxEjZAZA5YbWeqNskALkLaJYEEF5IUkyYlU96yW4JEQe?=
 =?us-ascii?Q?QHA4A13inJZX+GCRvqgcRWLgJVBgaq3VenLARn4DMxu9l1ZcvQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6RJMQsTrUlJCcokOm+QGOjXLAFJ9wNgNq/jNLjde7XrxH2BFN+L1cUJs+2br?=
 =?us-ascii?Q?w61NUZ5PQxjoRtN81P3z6VgYlpeV6evAyYzQUeqx21/dUow79XP9Dv5dwG2d?=
 =?us-ascii?Q?Jk8ft7ohUh+S5alt2bkEDjtT8cSPW5HR9MWXjydivGMnVETVseWiRBHe1kPO?=
 =?us-ascii?Q?ZbdYgQ6xqTh3cvMSADWD5681EpEtzQMBDWLbSIvhr3y88CCo5TvCbfxRXp33?=
 =?us-ascii?Q?8LQwXhN+KoJD9+XQmPfye+WmrOWNEKJJ9hZzHXCo2P59F7WJqBFP10vLZ/pc?=
 =?us-ascii?Q?Zc56LdT0SSeSpA3fx0UmYe1zfqqS6c7f6/WWjTyEpsHiJmy8y3aVKkZwArmo?=
 =?us-ascii?Q?AFad9yPsG+3lViChMQqTRIaiBkQuZLDv2EQ16Tu/0aNcn+GzP8Dc+/DmgtxN?=
 =?us-ascii?Q?1clgh0QkUdJcnIHsSngu6kmECZY8mqV7GH0AWPbqNQLHd6o7qeMFzRZv6Dhg?=
 =?us-ascii?Q?qX+UBR+ymnk1ybI3o2v4tkJiVeK2FP4ELTgu1VArgmz1OYFiBP4uD4CHZZKn?=
 =?us-ascii?Q?sQpfSvTnNX2Hg7sd/zRdhoockGkNL3AQuA//A0ejRvfzstbl44fAJRDjz7ZJ?=
 =?us-ascii?Q?Wj/N6PsCbeULGxQhfePoqSvuqG0US+2ZvTLjXcjutwDSFVBew6+HoBJOPWfg?=
 =?us-ascii?Q?XnZZ8XOnkePdDQI85Rv+tEr5+vIPnS5bcVPv5Bm07dfXQA4fn+RVO++jAQUk?=
 =?us-ascii?Q?zO60Ku5UUhBX44QegZjjSAoNxb/PBni4Kf2a7+kT2VjK6N4rOzXS63RuBAXy?=
 =?us-ascii?Q?GvJGK8gQZQZafVaS5B9L9nYypDzLgx362b+C6HOJ6ru+5tZrHaSroqQ3Bj2p?=
 =?us-ascii?Q?jmCKzIAaMDb7R5lvunuHOTA7c8EAIXYEyXaMJzWkeJJU1Es19ANhEP3UamHT?=
 =?us-ascii?Q?fT//u4/7slkwajW/zEyMkMhJRlY4hQl33Xu/2236DIScp3GhobeF3zP8/JbI?=
 =?us-ascii?Q?qhjVFRDFqDpuMQY7Pztqxm9zmt/71H31+tHYEFk9H0cQNG8Tfoek7gXrBMEE?=
 =?us-ascii?Q?JG/qhxe1NkCWH1EtsE4vP6RRmIY0yP6x4R2v41UrAxTLmh6ZWqasRTu5NBXI?=
 =?us-ascii?Q?yQbZUnpxj2ImOCYmvJS55hn+xxx8eeeXVF8tKko6TFpF2zGZLbYF7XwdFBGZ?=
 =?us-ascii?Q?ED3q1Yng0wp7vAwbeWJ2NbMOwb/gFGiDhHVdSVtnCsUnFycSEvxmWP2pKEtH?=
 =?us-ascii?Q?MzeHFlnSWlCoizVRXocPjtniEv9VicLsSQOyEnaOnHs6f5ARF4Dv6eZJU3Pq?=
 =?us-ascii?Q?LKyIbJJNjRSHrg9R81ZTaZ728nElU13Y2lbtHIA5S0ub7BGMn52HvWtjj3TW?=
 =?us-ascii?Q?qhS8jC1MqrKy3FAkCP8aWMKtF2lb/1YgAKCHuBUXitp6LMs8tiIMhK+J9i9M?=
 =?us-ascii?Q?hpo+jN4eLEyb+cY8EzPi0xRfM7XTWuBrV2LzJkwP1kRMWNUaIykT0c8DLj1N?=
 =?us-ascii?Q?p+KftaSpgMOijgSBi3g31X08MPvi1jO+NL9wtoX+LnSUWe45TeVBrD/1oJLG?=
 =?us-ascii?Q?p1nvBAPY36jik4/slS1ZJNDc3J4w7xU0YhQZvaTSWOvhbj/JJgpvLMZdMSgq?=
 =?us-ascii?Q?Qnw+fNvqVNZL0Hkc2ydJBeqXC1vWdhvJDDK0T0nJ?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i1Y5lj1Q1dO2sTJ1ifiznsNkTe+3FtwjnXYGq4FOCFolrCwkYkwFZXpI6HTzxL+WtfsZABJxzq38cUOQ0jZ1SoqBWQ5qtDNYcU6F7i5e4CMZ2ZtiiUxL0ctgtJQcGxPt4UvWQq/oW5ZT2rYJqZn2t/aancSFMaIp2RATmBLRuSsk+hM8NKx3OGtOvmcUi1HyWtnzdGQk7aL0Qd7yywl2YK/FRI+JGFQUin2OLRYzVKe84hMvoY8+gpJKV+Oe7uubGfV63NyWvibm98+990T9Ub7pOnGYtbcuQUDesJjBYdskmuCy65sWBaJXah/JeNB5FnCP55jLlx8hauKMBC6aUQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9E62OcDzRYWWP8s8llJx4YIgD7dEKoMY/dgqGAqxpRI=;
 b=DXWZIgsIhBA6WZUMEV0W3XrUAZ1ehc6Kw7sU0NnI7UspSW7R/fnpUzelIcZQctKToYipgG5PpZCJPcqJO5xQ28o6ZtU2ZDwuHp1SUvnYWqTksQhu72Rw44XelifnvCW3Xv1l5XRjweTshH9h++miDKJ3+iJQ8VggQhkhX5TR2YBhEcFVoyZncvzK3JaZ5ak8WeePU36mBI837YjcR0JpAQq9dN2QR2NJQ8AwaI2V/6+1gVfSqs+Z4ghqikJFAgTfNfTKBoFeA0S+9FfZ4lFWeAgWGYS9CoAGmP8SwEp8/dJmJG20mg54PHjIQeF38dNjOx/X7v7mauR7N1bXXZQQJQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: BN9PR11MB5276.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: c2e3e5e7-4e48-423b-daca-08dce123a987
x-ms-exchange-crosstenant-originalarrivaltime: 30 Sep 2024 07:44:06.3605 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: GasOqOaGb7CAMOaL9x6YYFkaqLzqFqCnmk4D8nmqJX2NEcwe7jxE1sLhl47mgxV/Ckv+VaF/ZdjzkEUfb+vNJw==
x-ms-exchange-transport-crosstenantheadersstamped: DS0PR11MB7786
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

> From: Yi Liu <yi.l.liu@intel.com>
> Sent: Thursday, September 12, 2024 9:13 PM
>
> iommufd plans to always pass in an iommu_attach_handle to the iommu
> core, so it's no longer fault specific, hence move the helpers out
> of the fault.c

again please put the reason for why iommufd plans to do so.

> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -458,6 +458,63 @@ struct iommufd_attach_handle {
>  /* Convert an iommu attach handle to iommufd handle. */
>  #define to_iommufd_handle(hdl)       container_of(hdl, struct
> iommufd_attach_handle, handle)
>
> +static inline struct iommufd_attach_handle *
> +iommufd_device_get_attach_handle(struct iommufd_device *idev)
> +{
> +     struct iommu_attach_handle *handle;
> +
> +     handle =3D iommu_attach_handle_get(idev->igroup->group,
> IOMMU_NO_PASID, 0);
> +     if (IS_ERR(handle))
> +             return NULL;
> +
> +     return to_iommufd_handle(handle);
> +}
> +
> +static inline int iommufd_dev_attach_handle(struct
> iommufd_hw_pagetable *hwpt,
> +                                         struct iommufd_device *idev)
> +{
> +     struct iommufd_attach_handle *handle;
> +     int ret;
> +
> +     handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
> +     if (!handle)
> +             return -ENOMEM;
> +
> +     handle->idev =3D idev;
> +     ret =3D iommu_attach_group_handle(hwpt->domain, idev->igroup-
> >group,
> +                                     &handle->handle);
> +     if (ret)
> +             kfree(handle);
> +
> +     return ret;
> +}
> +
> +/* Caller to free the old iommufd_attach_handle */
> +static inline struct iommufd_attach_handle *
> +iommufd_dev_replace_handle(struct iommufd_device *idev,
> +                        struct iommufd_hw_pagetable *hwpt,
> +                        struct iommufd_hw_pagetable *old)
> +{
> +     struct iommufd_attach_handle *handle, *curr;
> +     int ret;
> +
> +     curr =3D iommufd_device_get_attach_handle(idev);
> +
> +     handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
> +     if (!handle)
> +             return ERR_PTR(-ENOMEM);
> +
> +     handle->idev =3D idev;
> +     ret =3D iommu_replace_group_handle(idev->igroup->group,
> +                                      hwpt->domain, &handle->handle);
> +     if (ret) {
> +             kfree(handle);
> +             return ERR_PTR(ret);
> +     }
> +
> +     return curr;
> +}
> +

why putting them in header file instead of C file?
