Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C533123B
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327225; cv=fail; b=l1h+v6xP+Kp6cu9BVrQd/F+qOVhGXdG0Nq1DvDjvKAHUEtaKpKLqZ+Mp3WGJi4B7l9oPN4x2OLBP2iy0GWf3McQz+h5V4CFcKmS567Qwn2ApbKfNTbh4J4/ywIRKHRgaUAUNFXjXHY50C3dAc9upSWjkkD9Vyye5ChPxrO3AFFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327225; c=relaxed/simple;
	bh=cR8e0E/hD/DwMJAUrMs58krak3MysFXGi70SxnAkWc0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5SrYFF8RAKaVc5X+1qatyTLX6emBJlsy2q1bXtsLiwWXIFIJirfTFjPlDwH1g2ziWbgTlvIl373gsbuL/ZZLjMKJ/gOZxqcDE1DF/M+izL0mCKMspbLuUkXEpG8e3bvddRe3r2Lgxa6sC+xyNBnsH3jMqeJQzADEqF17xfeex4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXLU3i22; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXLU3i22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327224; x=1807863224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cR8e0E/hD/DwMJAUrMs58krak3MysFXGi70SxnAkWc0=;
  b=bXLU3i22C1XXEC61RcVRPHk74/G+IvO5ErZ9FUge+kv1LKTwR+q3jZiz
   ox+QsrcfP0hMJ8oh5mHhfseJjSgQe+sfETcYVmEW6HikLcgpEnZn7NqEd
   uwZP4wIQrILkH0wCmpMLulOb1OY0ioYoA3nzmdxLUmPvfhfYdTFaznfQS
   qQyCl0RVnUdFnrBRX9gbdJS3oupjceEpyy5c6Sdgyo/8ARp3qQ1zvr84z
   fXQoXb3T4cYtLcIcltYMPmNHLtwV8jfKBbOM9zY84ob2ZeMUNfM5pgpSE
   5MQoVxDk153LMD+xCiT/B95QlavoDVrx+lngKfDBEkHwGWQ8XB0yaY5Ke
   w==;
X-CSE-ConnectionGUID: Kfgz/BoSQ4OYg5anRoEtBw==
X-CSE-MsgGUID: /xXkh9wcTn+UkXFJ46vaRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88019770"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88019770"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:13:43 -0700
X-CSE-ConnectionGUID: kq77Fs/UQnOrZNzAVT0VWg==
X-CSE-MsgGUID: FgzMLqnlSfeGy7KgOsDk4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="229644704"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:13:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:13:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 01:13:28 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.29) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 01:13:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+fmW7sofVeuprKjS2mhJbjQtHatN0hRjAzJRks4Bs0C94DDWKjqhO7ZCW06KwqXg7lQVGMlDnfzCVzipjkBAapAMavyFqtZI71Az2bGg7qk3pKg0rDSwWZmrNGx9j3e2p6MDNcCYy8jV3Q8HL9MVr3EFmsDBcDbPfavMWsZhrzYyFo4cT55ku/kBYwalt86JyEIs+Tri05S3g+i1EWHSKz1e3pikqjFWW3xGi3ctszM0iR0yBMHaQkaGvKiJ6zyv6ju5iFLTxs0mOeDnVa1Le0ZBenAGGAnie3Fx15g2kTtTq6vT0wpFMNpRh07xJHfCgZVo0E7Y9H54URPJbZOOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf1+Fg3KSoSGOwttl5yfoOwGvB2aMO7XA1Q8brPRoFs=;
 b=cDh8X28F3Mm+GoNX866/oMPL91nz+27RP78r8wotE1DZKny+aFi7CVAFd10Xl4sbdqMGKI19lK9Jsz8XAAhplidpews6ELIKXqGDItcl16Y2EWtIurrzGAdehCYdHo4PTK5QVxHaOBsi6CsJT5oasFBYE4iHp+1cHalKGmDLcMALDxTJ0SgpPEHUqs1T0ByRJCFR6xDnYTFaTAqUAMTQyXjr9CKmr+BCBHvxR9Ff03O1W/5naAJbOfEHL9Awk6ZVpSny69Ntt7419LWXfnfPWRT2hGjuvWS4oIxh7/cc6f492u0Ezskks/CHKwRQhJiLOuT8/Nn2kmyDQPKrIKY4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Thu, 16 Apr
 2026 08:13:24 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 08:13:22 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 05/10] vfio: Allow null group for noiommu without
 containers
Thread-Topic: [PATCH V4 05/10] vfio: Allow null group for noiommu without
 containers
Thread-Index: AQHczFOuJXSww1V8/0i7x7IRtF/FgrXhVy9g
Date: Thu, 16 Apr 2026 08:13:22 +0000
Message-ID: <BL1PR11MB527147EF03B2CD4F76BC40518C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-6-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260414211412.2729-6-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|CO1PR11MB4932:EE_
x-ms-office365-filtering-correlation-id: 7e058d54-42df-430b-6461-08de9b9006d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: E+5VkPxM7BlZ3WHC5iDo63XgBTmMF0qiP6MnBG7QgDHjdD1Zf6QpBIrMym1iVbnOkEAJW4L5gNM8iEjgLFjiDjlrAjIqNrpTlTDZcIhpkp/Yb5kzuMmSy3Urd0gEUX3kilQKq7KA1HJLyeL5AJaZcJ3jotKqDa6saPyHi3diVKConKJbnF9N52cEvj5DraXE+waa1FP4gNkImSlghJfopHrSj17JqnVVgJcTtr3RXeomBItm+0Cje1WMECdTNk/dCDKkJw01OUYIxHzxrRIquO7f2yuL80jpDOHHu9lySaEZluypvTiuH+YIyrJ0LVh1WvDelshV+cMenPx5wk48RsG5n+jIcn3pX4vW8sCU/4L3Qy+RVU31exbTcIcvGSo9xVzkD4MVI1Oe3jey6hFe9H5jO2m0OYfWj384tvfx1XoSaZjlAaz1Ele8Ql5VuqpO34SQy4hCBv6a4hnljZMQDVXk7xt0SDWDCNzunX0tBd7m9OYrw6K2dPp/CGfiysJSlbndFQ0kIMMFbJ0fRKYR/3wzwUkmX1o0vQRp8/MNgGz5yhGvluRYUXraayQqc39D0i1IiSf12hgvzw9KiO3FGlb22K+LGRSH2/5vbHqNiN32lE9HTraYaVmGpInBVp6QSDi5kOAduPjK2R5CkrZJ7zAVDgwWTxBrafkw4KNW6Ca9YMmG2OAFnL+IQmzgm9xNwePrR/VIMeCTlgtjhiJsmDohFxkipUHAg4ggEJ56TziOAtfz5QAhTMEer3Ah/x/qxTqbG0PtEQ9uCg1qFX0vlGBoo2R8GE7cY+6FQF4nU9pV74LO9V1t7JaKiQjeDSYb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ktjx3b0+0lJTDfkg7fnreC5d61bmSz7DCf/fStdJkP/NVf1DcZK5/kUFF0Hq?=
 =?us-ascii?Q?Xqw56o0p56+8/+yf8H9wgh3MAlX8Jkpbj0mkbRy3GqiFsxal5laXE8NIbyGm?=
 =?us-ascii?Q?7fxImKOBl+X0Bn2UbrcRt3gNJu7DTn7V0bXojpmta/uU4dZeXPdVWUBdp2FC?=
 =?us-ascii?Q?fxT5xY7nbisuk6AK5pTNms+LLEuneR5BH9f/5YGB8Mfmn5ggOuecMzwH0obd?=
 =?us-ascii?Q?E8QiCEtotB/zc3fEhBcgV7i1ZAJ3fTaDfo3kDye7d17MOL6ww982y6ffJCN5?=
 =?us-ascii?Q?7nwT39mz+AC+ObSTg5PpsGaLWKZWQ6X/3aQbQ1fFGsXlg+rTnNSAbq96Xfyv?=
 =?us-ascii?Q?tD7ghzhtxr97cYUitzL+iqe2jp1ABhOXo/aHoh1peeYcBG0DggoNtyDZCvr4?=
 =?us-ascii?Q?+TfChTnPgtjfAmLM4HrZskVUWf0OO9IS84UCQf7SfRLA2ATbd612LQerMlQ2?=
 =?us-ascii?Q?N6k1cPqYpOAHxIJqVHGtI3lOqjsbX5G5kToYI4Au3bzWRaruyW7d2iOq1gqg?=
 =?us-ascii?Q?HtWlOrOMc4x35TdoVHYYBxa0gEyLa//ZrzUj1e++9QOLWzmxUvwlWJmbecBN?=
 =?us-ascii?Q?/IhKyiHGtgPYPuA53nYOd/cN7F01JJwefDeKmjcOoFLDaRhMHGwn4/M/SwMO?=
 =?us-ascii?Q?c5ykP9/C7AGTQnhVvI1yrOc2TJIDj90z8kr9tNIk7OW/QTELL9y59LdGuf5Z?=
 =?us-ascii?Q?ELk7HCXFi7Vesus88pzwA7AZ78xFns/m6i53GhhL4E+Hts7IOn1LKuB4aN15?=
 =?us-ascii?Q?/4JbhwsXY0UQxtxnGqeYvn/XKfJYkvImL1V7VdFjYY80vMd6y+maCPkgyy8Y?=
 =?us-ascii?Q?LFTSGte/YtzXHsDt6lidBkoTs6RcMTlhT6/hOWfmfuUOZ/oJQHDwItE/3leR?=
 =?us-ascii?Q?dSfJ30svEfNKCGiDFBdLPTQUPXD2C/qlJk/wqAqIoDYe7MgGKbBC5cwyBx2i?=
 =?us-ascii?Q?UTAztCqZMDIhLE4OCHWSWiRJL77cR0O5aKV/ykep4UkaHmsQEtIzAGfe537D?=
 =?us-ascii?Q?EtI9Q410cU1YiuVsd/VOfsecNaOr9U06yGnmgrb8wM0YjKZ6s74LyzlN9O/e?=
 =?us-ascii?Q?uqT5hX3uWnXjw4E6IUvIUp/zxwVLX/1710ZVZcGnJnTZjYGnOHxEwUZYgT76?=
 =?us-ascii?Q?eCGRqeP7G85IfC719uSOWNJfTrMw9b8VbE4vYQdfYue+MIEV1wAKsiOC4OAh?=
 =?us-ascii?Q?rk0Itauwanzyb1I9mm3OdXlwF/z2jjcozBVjmUF6JhcqWOP6mSwMHsVgGBOz?=
 =?us-ascii?Q?qreFeXB7KO+TH5+RE7WMHWRKvd3FSy8xUzI6n2BwryfnqFzQY6ay22yLuI3m?=
 =?us-ascii?Q?BXVk8wQxSpQZld+ACQh2YHVHlv8O2KzO7fsekaesv1U/9CExJDzePPugSUQz?=
 =?us-ascii?Q?hMatZJsTWM5APN9qRpW2QHkIJ+rPfCF+IS0E1IaoXAxYJuDQI2h1wMyTCdOo?=
 =?us-ascii?Q?Dl/ynKg/FnIGDjF6EbT30d8AOblV7EbqP2pQM+ezQFXzDlaavaqY+hNmE13y?=
 =?us-ascii?Q?05KxhqrfpcsQrF5O4o6TNtYGbXTaKTJ2LD788rR+N472b+ZLG94N2gv2cgwP?=
 =?us-ascii?Q?WqWEt4IggjmkwpPnbYefRUw5lkADw6oZVSblOQXMQ7LwKyJq3aj6wxEbEC9p?=
 =?us-ascii?Q?nUFuV4QjOgxWh8g+qQg3fNeThmc0HVQpUnZK3PYYiffslOBWaq0swXTHHWTc?=
 =?us-ascii?Q?pn99Qd2VMLAaY4rmZwcNlBv3H4q2jLMquekp7j3ldw/zyEz5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BxiAs7VppQPUig/OnWyxKhyUoaFpIEz05htyygVHhMHbKVOi4J0/PfoF3itTfJdthCsaVkFdHZghJHxkrqd39GU1CsNp/FZTGHTbpqJIIoLdC5tKWn5EIzSbW6y2W3FUjbEBkIM7MgDai4MqFVCaEleaZhLHR9ZzuECGuC6gNDU2LXI/59ReQc+YEBzt+xFC63LFFWB7Jd0vv/vFxRyY5E48SItT5YE8ZuGOqTWlSxPwCpQQ4TdOb77Zi//6fggMlC2km4L/CbiRheOyT7Juqa5ozsTxKFMMxt8LGT2zXf6PenTnjJnAldMxbr7b0sd9DwJ7c7N0NjoP2KwRBv4iBQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e058d54-42df-430b-6461-08de9b9006d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 08:13:22.5124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtn/dqgP/Ei5dB0ACZLAIM96lA6pzugE5/kgpAOpLSmFTFbtZBoIy3M+N4R0nu8MAXRpwqRTzUtLAJ7c4MzFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, April 15, 2026 5:14 AM
>=20
> +/*
> + * With noiommu enabled and no containers are supported, allow devices
> that
> + * don't have a dummy group.
> + */
> +static inline bool vfio_null_group_allowed(void)
> +{
> +	if (vfio_noiommu && (!IS_ENABLED(CONFIG_VFIO_CONTAINER)
> && !IS_ENABLED(CONFIG_IOMMUFD_VFIO_CONTAINER)))
> +		return true;
> +
> +	return false;
> +}

'allow' kind of implies a policy choice, but throughput this patch it's
actually a mandatory state when those conditions are true. Can we
strengthen the words here and other places to not given an impression
that even when null group is allowed it's still possible to create a vfio
group for that situation?

Just like another comment said, iommufd is the only choice in this
case, then probably could call it vfio_has_iommufd_group()?

>=20
> @@ -392,6 +396,16 @@ void vfio_unregister_group_dev(struct vfio_device
> *device)
>  	bool interrupted =3D false;
>  	long rc;
>=20
> +	/*
> +	 * For noiommu devices without a container, thus no dummy group,
> +	 * simply delete and unregister to balance refcount.
> +	 */
> +	if (!vfio_device_has_group(device)) {
> +		vfio_device_del(device);
> +		vfio_device_put_registration(device);
> +		return;
> +	}
> +
>  	/*

can you elaborate why the following wait loop is also skipped? then above
is removed by patch7 later...
