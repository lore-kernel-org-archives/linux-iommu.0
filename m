Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A7E1843
	for <iommu@lists.linux.dev>; Fri,  7 Jun 2024 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720612; cv=fail; b=PHjI+iJEecymFcaNRXgAv4jIiCNTZ34witm+JLAgsFV5dAWDAXFe4Pj5gWlYwSN6B4FdL4H7X09Wx7nmcI6Yij5JBel+KWUZSI17DNxFT5HWlHeypdh8EA6WmIWtC494q1zKBI/TMk0yD2JK0nv46x5Ze5cDGTgjh8e5pCiUKEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720612; c=relaxed/simple;
	bh=UaGl+VCsyJmZ4jhmVJb3+JOv6CwunZSKZWtVmuy+kso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBW2CCkbB9sxsZ/US4aRMapQvBUHIi9Tqi0qt2IVYze9ImV9oNXV2hWrsURC5ZB7J2y1E7NdCsR+qPnp5P2Y4aliCDvXUEqNt+EObLgmDbaTIlrnpFgYH15gkeRFZICOi5BM42BeOstu0G6W4qzxS1qWysIThBW/GwVx5A0Oet4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gPA9N8mr; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gPA9N8mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717720611; x=1749256611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UaGl+VCsyJmZ4jhmVJb3+JOv6CwunZSKZWtVmuy+kso=;
  b=gPA9N8mrERLy0usu2hfQcxOS1FgZ2+Q4aoaQhoEqww52Lf3yGAsk0nqR
   wg7xXquWlwIcAh+83vg9Wzf+RyMYLH70nnw1uTz8beoDomhojf41Ey9SF
   cmG4pYaDjMY9EcHa0xBlbAsERKCAvba/BFn8YfjtDH05AFJW6cvAvCkUS
   kbiAgPAogJEQ87xmuUtAtkAIFn1zIwpj3w8P5Cu5ARJyEmGw4xCGpAbTq
   xJH/YtdcggaJGA8AqkzzRBVk84Ig77yAAVJ/gmg2xXlpTPVaNPS6S7v+n
   hWgp0eYsMuvjbNxGHcQeSVVYo76rAkIq1MYaeo3LCzd8T2oheHY3Tfdrm
   g==;
X-CSE-ConnectionGUID: 5wbIVYfDSjSM9wS+AQw8vg==
X-CSE-MsgGUID: y42aBlgxSp2exmCL8U5lbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="25830296"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="25830296"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 17:36:51 -0700
X-CSE-ConnectionGUID: qrHHV+zyRXiIR3/C6GkaHw==
X-CSE-MsgGUID: XRpy8zJAQamfKF2qAtG6mQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37992173"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Jun 2024 17:36:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 17:36:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 17:36:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 17:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbm4hcPHTDTrrmpZnso1TSndrnpuOJa7R/6XuWwTBlRS9KuQyg72s95tiNF3C9Hdue3UyLXiv/487BZ3DsKwHDwK7S17gfcwZBpI2dGrgwFxeBaHu6ELIGAZiJg0LpWCLIZiSNni2kwYjgtv3i6khRSnNh9ZsaTj6PxwxmFD9BBzRoP9tc3+icJNf2s/C+Tuv1JfNSNA3ofSGo/+ECKDHrw59bg6JkzD/rA3FvIrhNmLIflBzjyWgGFOLwwNC58x8OkybrEWydp0BayKKrXyRP1f3jv1J9pnZT7IzPWciesWUlFKhxvXkeQyHC5hxvrPneVwYyfA1ZP53ROS0IuBJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaGl+VCsyJmZ4jhmVJb3+JOv6CwunZSKZWtVmuy+kso=;
 b=hcpRjv2Cf3zE2tWUNqhmsCNMZCwzqZ+Gqb6gIHoGXFYt+Tu+rRpAqo7UWcmtEiqgHNjMKuwVZKZ8LqVObyvgS6mj4N/AwpthpHdMY2xH0uvmQHiekWwC173Y6CcJk9jstpzZLmRqRNThiObdLltNMbXZWskp6kas5i3rP26t4AoOPCKhnHkb8gus/q/KBmpHRoru8px/A/exFDheudyAM0XUej+o9jGyudn3YAwQ0X+ZqB5/yPevKQ9sr+J5GL3GyBg7Id2zfRR3R+HrsRvS68LlomBmh8LcJPu4j83KsoOzZx+AyYoyuWgpfCu+WQ8PnWYfy4L987qU5nz2zp2NkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW3PR11MB4617.namprd11.prod.outlook.com (2603:10b6:303:59::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 00:36:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:36:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
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
Subject: RE: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Topic: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Thread-Index: AQHajVVl26WkVBqVE0qDV+tml8yTY7Gkmr6AgAGEQoCAABbGEIAAaX4AgAPpupCAAtXxAIAAbUsAgAAHhACAAV8OUIAAC42AgASA5ICAAfF7AIAFsh+AgAAFwACAAF+ZgIAAAdLw
Date: Fri, 7 Jun 2024 00:36:46 +0000
Message-ID: <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB5276BBD592021507C3A0EBB38CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlY886FT3HHLC8Cf@nvidia.com>
 <BN9PR11MB52762EA9B444DA71F551C3868CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlafEktUu5znDsNt@Asurada-Nvidia>
 <BN9PR11MB5276AC43120376A2502D3D148CF32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZlfPPwsnY6P4SoGF@Asurada-Nvidia> <ZluWXYQjroz0fqqn@nvidia.com>
 <Zl03rsgZl/msa3I+@nvidia.com> <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia> <20240607002707.GJ19897@nvidia.com>
In-Reply-To: <20240607002707.GJ19897@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW3PR11MB4617:EE_
x-ms-office365-filtering-correlation-id: 83b05a62-5477-4c11-bdcc-08dc8689e97c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?Z5WSl857IHKLFLQF8ASTP+LDy/V13gOxlFio08V723ymyuP7/pJHUvVEnRLh?=
 =?us-ascii?Q?A9Avy8Ikxhuh8KjvRrW5L56Vlo0/iQx5QCXgH4aTFLi2ZQGcKysZDLmJRV86?=
 =?us-ascii?Q?FXwQp9EawPdMb6rOKpmdfky8YsZxxyG2JDyEPZOBqbJD8CLFZ5nF06kJKa5p?=
 =?us-ascii?Q?puodz7CIVY+4Grmq/AjqmyAd5T4XxnZm3sz2jjS3UjpsAcLoJqg0p8hIAhot?=
 =?us-ascii?Q?MVHXgVty/wDFZGAoNPvD7/bOb+Wbi64gJgTTah6z1wobhWNhJjvHPDMo9egN?=
 =?us-ascii?Q?4a1e+toGRsdOD/R/FBQRTt7D532GY5PzHMtGbGqkpSU2KLTbm2pA4FRE2fkS?=
 =?us-ascii?Q?Ln5L1NYE8zh6UBn7EwvsZi/mc4FIF0ZqO7DbQR5fDjSzmbr+h/HBhV+restq?=
 =?us-ascii?Q?KZLbUY48B33pj5EyJjgmbZ0YDAILN64XE2ZCSuXLIoSPi0Kcg7+aarwu7V09?=
 =?us-ascii?Q?if9eaB0JWK8Hv8n0XObQJlFofYWy6ClpfMHisaK5nLUo3Dvtq+PAkh7a1lmu?=
 =?us-ascii?Q?j09m16l67ce3eOpH/AQuSMiVStH/yuFjT6hUtkVZkk2YKT6Q7ARi0c5QWEYp?=
 =?us-ascii?Q?rIPbRByEIECJnhoF4cy0FAjfpXy4LsRAzL0y0aXxvHvCeSK4HmHdX3v2Rs3l?=
 =?us-ascii?Q?AU5Fju/5N7cVGyRWEjtrIQbrQvX4kj5nKT6356uD1ueaUd0HS8DYkX3k0eYv?=
 =?us-ascii?Q?EAWnoWFsUTbmHCQSz2TPmmV81Gs/Lh7s6q90w6dBai4twe1p25NdRMUmBWcL?=
 =?us-ascii?Q?ECwMBSHBHTXWBZWez+TIhA2wtLYAkliQbPQRzt3tfRC11c3zpzGHqgdqjpHj?=
 =?us-ascii?Q?aR41UZGr3cZLr/xs/nzhZBOiHE+22ibZqn+9KyirAKt0jY25sxbD2Fu3DOjr?=
 =?us-ascii?Q?MELId9EScPrtQFw411IBuhnGho0XqWv3/tU2rHu7w//okTZYF8jdSGVHe2ON?=
 =?us-ascii?Q?OATp6m8M5UIw7h6FcATWZzC7rMIaI04tePbVpHH+nLu19Tq35zwjC1+e9yOF?=
 =?us-ascii?Q?geTpud3CDd+yBPsHM9ge82VSRz2/pHtqkDwPMxV/ADC/zbQm1hOAD6hhkC8z?=
 =?us-ascii?Q?XzVwNyTrd0JQ99++i1R4Pvi60Q4QNIWw61/HUVC83FE2RtEFg/KQURRAwfwk?=
 =?us-ascii?Q?TbUoR9NYwy5bkhjnkpJijz0owI2ut4/S5u4gmVuFPs0jAG9iQePZXStIgLZe?=
 =?us-ascii?Q?q3OEpXXOZUNXhwsJNnbsWX6q6wzmZlw/UWo9Rga8y4Ynm6y/dTmvgluMiqwP?=
 =?us-ascii?Q?gQLlFZVYvF5jti+HUixNcXfgljDAzrf5jpb7BlVK9cUm6gVe1eZSyeCsaXmQ?=
 =?us-ascii?Q?8xQAu8r43SPGng5X9jcpmgmHWjlKkMfjFVk2w0u8iUR6/q0f7fE7X5nmDPok?=
 =?us-ascii?Q?s8/ndMM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CVyBR5dndsxzz4GK0hRCBXkXrFmKuYgsYQ9iUWp2ZItooVKK6JBSKtCjEkLW?=
 =?us-ascii?Q?orqhgvIFFuBJYGrrdDnW0rACmSR2wnwKhLkZJiylGYLTs29xIZPbUf90sAvc?=
 =?us-ascii?Q?FKqx/7mnfSjF3yOGKemCifgD5ROH0WFosfTO3w15AlcKG/F1TC8yLnsAwjeR?=
 =?us-ascii?Q?jHHF2RnhfyZLrX01X1rmvkRSowwX8AtLk2cqhho8yWMZjCdMUdSIc4/G0lnZ?=
 =?us-ascii?Q?omG22La/z/RmgucVNonm6qGOIC5TYpId1RR2MmfHM9SpOXWB2J3zubGWgIPE?=
 =?us-ascii?Q?i1FUNqUclRldSDYa4wxC2TaQMb/qQ3fVQf1w48v4Og9ikyr1BoUS0jp9b8RS?=
 =?us-ascii?Q?0r/B6WktGBbxhegP8L2yiqY2V8QmDM8wUpfrpG0PyqhzcwUgAY4U88NiRREE?=
 =?us-ascii?Q?ZA9JOtr5PNa8YSkRgDS8eu4EXPI79ZMaBMM0tii/p+wEdOc8qfNcT4T07loZ?=
 =?us-ascii?Q?3xS5CQdNYFQU9gePBxFfV54QJnSn9gdrvRzCU/BZJa28cbNo2pfQPs9u+Z9T?=
 =?us-ascii?Q?D9aEItLFtzkRuXtHr2XB5v6yB1s2njQKrq1czY0ugNovrvluzpD5lGIDaphN?=
 =?us-ascii?Q?ru1b4E3Wlr9zVhDzetkeBrd0dxD4SleXZl9AZ2u6T7xANLNaTC0b5ogv7SW3?=
 =?us-ascii?Q?Q/WP7jmi4xxuaEsxYLuH49nTDOZkthLIaC+gBgptWowytlm2/nxWyE0JTcpD?=
 =?us-ascii?Q?qZz6qCSe7gqw4rK5Ld38Y/O59XNKHxmHghkGjRij9NgMLAqvm2s1TUNFaiYZ?=
 =?us-ascii?Q?VRAUzkGWv/LeD/Jl05ycgV02CG+JaTW3JkucbJD+JR02Amv/LqZ5575IR+cu?=
 =?us-ascii?Q?QXJE9y/dWzSH0PezMARljZL3BSm80STofb3aQgZTLlaFd88l+VDR/jPhUJwS?=
 =?us-ascii?Q?PhOzDT+bSJxjpbqn8JGgk8svb3M5VDdq4qp6GU7prdvEFCei2rhQUBNkDLa3?=
 =?us-ascii?Q?44A51sOCMDDqaioHiwtjmciYzyD061m9J4Xd2EPPa1fuNFEKst+AaahHGYI4?=
 =?us-ascii?Q?Rk0Hog/WDqe/JAnmHCEsfieIBSoBFLPQWFt8k7Kdut5binGokzXANxBmsFJc?=
 =?us-ascii?Q?ks0nsxB7LnWv/3ETYNu04aTi4EGbdHf+FUJwgl0YyM65Nv7r3vJEi5Vi2cPm?=
 =?us-ascii?Q?3V4w0paP34z95pinVYDYjSnqFMUm7DUWrJc6xlv+mLagxctMe5iA/RGIhimt?=
 =?us-ascii?Q?U59p14P0rih38JMmmNd8wiaUTMtKO6aeZsM46F3qE65tLv8tCoa3KFA1fSjI?=
 =?us-ascii?Q?WGgFyOTXOgZdAVePoIxm66wU26D2Bai6WMwZ3SXeZzMKBvALt4RiR8TOWhiO?=
 =?us-ascii?Q?x7xUsEYmBu4B0Xv8PcN5Xxlj9zcr7KY7XMkS5JJBmMtjhtG219k0gbQQodd/?=
 =?us-ascii?Q?JFsHKTWACX/pd7sn9rCO9IAxKg/Cp0mIrVfCy/4gk6D1toTQm98op7vQK2jx?=
 =?us-ascii?Q?pWKfGuL1ICBcodTxi24R9hoaGAMW2IevuDq1FJ9IBBIhplb2Z5joZ/Mxh4Sm?=
 =?us-ascii?Q?oRFeyBXfGViBT2WPcLcv5ELG4XS9CjszLM37Imgyghu6LfcMtQvPUqJHE44Q?=
 =?us-ascii?Q?3OECvCLh6cgLIPl2eMGa8uJ8lIc8QXf4ubVFNTdt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b05a62-5477-4c11-bdcc-08dc8689e97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 00:36:46.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUrOfvpqi1RAixQj30TPtZStn8jkF5evlFvRM3BF9ouS3qcrO3dJ8ampsuJ+QGviU5Lu7ChhRZ1jhNlo3cANZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4617
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, June 7, 2024 8:27 AM
>=20
> On Thu, Jun 06, 2024 at 11:44:58AM -0700, Nicolin Chen wrote:
> > On Thu, Jun 06, 2024 at 03:24:23PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Jun 02, 2024 at 08:25:34PM -0700, Nicolin Chen wrote:
> > >
> > > > > I understand the appeal of doing this has been to minimize qemu
> > > > > changes in its ACPI parts if we tackle that instead maybe we shou=
ld
> > > > > just not implement viommu to multiple piommu. It is somewhat
> > > > > complicated.
> > > >
> > > > Would you please clarify that suggestion "not implement viommu
> > > > to multiple piommu"?
> > > >
> > > > For regular nesting (SMMU), we are still doing one vSMMU in the
> > > > VMM, though VCMDQ case would be an exception....
> > >
> > > This is what I mean, always do multiple vSMMU if there are multiple
> > > physical pSMMUs. Don't replicate any virtual commands across pSMMUs.
> >
> > Thanks for clarifying. That also means you'd prefer putting the
> > command dispatcher in VMM, which is what we have at this moment.
>=20
> Unless someone knows a reason why we should strive hard to have only a
> single vSMMU and accept some invalidation inefficiency?
>=20

migration? a single vSMMU provides better compatibility between
src/dest...
