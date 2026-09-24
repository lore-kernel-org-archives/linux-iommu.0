Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D03E3D8F;
	Thu, 24 Sep 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236467; cv=fail; b=QG2fAJfjz7LvfeQtC9DSQQdBV/IY4gsERGcf8X2Xm9YnuACXkIuqOuMOirsF1aDjnS4KJRFV1TwUZTNp7xfv4EcJ/6Bj8+kxAa6iCwzjQ4dIOB33idyIPWG8JlHLBH6PLu4V4bAnDvZd0IPbOfnUbenU1knSBcaH4BmYbII9y9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236467; c=relaxed/simple;
	bh=LITYmTmoOjb09q1csEu5dsdbjCyub3F+qHsx7g3P/YI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G1FZNihyXLjx4HIKPzsCm3PD8Fvi2CdXwybpvjYOKQvMwgjyQM7d5+pJRq1yLRCAxgC0nYDJ+ryrq1FO7Ix67ZnrcskqVevZ+q+Kw39Lqn8YEQFMz0wYFLN84Zr3X8G6RfX38CoXRR6EFUXIpzFsHEccaNLC9Q4dveoErhVdguo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5UaW2xT; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5UaW2xT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790236465; x=1821772465;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LITYmTmoOjb09q1csEu5dsdbjCyub3F+qHsx7g3P/YI=;
  b=Q5UaW2xTape1WApZVExhTytNhJlIu4AlnxNFmZjS46q/1aThbsl1QV+Q
   IH9rWca+g0xYZJHskgYGFz8MR/9LBuw/7uDqwCruvWA1oJhKVUjWUWWKs
   uTkU2TQdh1QnCR5LB3iIvrioOiQcURdtujsHWaud5dNp1KjcVuoHdycNQ
   6Y9TmHwWgzEv5mclV0UlQtArtAMEmZgwF6usUS0ZunrIQ2/eM7VWMCbrK
   HE+ARMfmnWCLSIwolp7Ra3MBVv88VeXvwfEr/njtFgdjhmGDZ0YISgl76
   L8SzJvdndp1hOxJpDd49FVBglHUJ4FnI57KL4HLZZNuf1bBabP4aa/P68
   Q==;
X-CSE-ConnectionGUID: 9VyD46z1RUS2k4KUhMEViw==
X-CSE-MsgGUID: FomfcEvvTIeBZRZUapJmxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="89770321"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89770321"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:54:24 -0700
X-CSE-ConnectionGUID: iMCfGK8wSPufX5XmMhUF4w==
X-CSE-MsgGUID: /lPYUOM9TYiyPJM0kXeYeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="277700112"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 00:54:24 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:54:23 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 00:54:23 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 00:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNwJ1XNP6AYnTTVHjWSrvdM+8//zBMFfp8BNIR0Z9NYbpf5vbEFubPsBbjBnUknDMZKDtl5p8ik9eO2obfELy8q5bAehW3nrX7LzO7q+ui72q9kyKHVs+sP5+4sOTvyHE+x2tusGmcp22xw+WdUXK/CqIyPps+J4+M/94BmM4CVzyuQT69pamF3jJ7EIaBKvFGRs/XFnzRpRGmT3csBCrKpS4NOij5D+n6QJo+OcbA+hcyf2y62h69K+oh6zuFPBgrMJpO0ItCRGnrRuglvkpUwgAUTLQAeQRZzWfqWpS5RmU2A39OfEWRw4Sz40+Yjy+/MvJTWvjOzCDtcqyfdpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBAJrvPZcjWfXa8Ch2MrvxvXckKWEUj9vPg1MTeBZkM=;
 b=M71BlvOi64x8SBFScEYi7agsIpGPkbfo13gEQ8xLiNQNjnFQThpDFYAUV0qNOUE93CCEk12eaEjS3BfI+4MfwdGcUiuMIF1WrpSMe9b8K+tl21S1CoDwKfyDfyXMAkJqdos+Czz9OJebD9IS/sbhJo8DYQRLuNLONGdkeEa0jF3181O6PEJY1cU0XPltpeTTwPEpPu4lHZoXW4K8IA/ece3kz0z4zmWw26S6H8UqJFp/73COD00uL2K6nHsoluWyYSalg29omGz0UrQU80s7ZzwnhSgNfsGaJgXohHhE8kqRMznHYj8Bt/EEuLzNY6sW4+vGJMiKXhANMm7Ex//ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DS0PR11MB6350.namprd11.prod.outlook.com (2603:10b6:8:cd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.22; Thu, 24 Sep 2026 07:53:45 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:53:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 02/11] vfio: cdev: Reject duplicate bind before
 updating KVM file
Thread-Topic: [RFC PATCH v6 02/11] vfio: cdev: Reject duplicate bind before
 updating KVM file
Thread-Index: AQHdRq1Ig+cVqk+GgEy3sNP+dGd3HLbdZQ7Q
Date: Thu, 24 Sep 2026 07:53:45 +0000
Message-ID: <CO1PR11MB483540981ADED57ABF6EB4878C812@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-3-aneesh.kumar@kernel.org>
In-Reply-To: <20260917140159.1163281-3-aneesh.kumar@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DS0PR11MB6350:EE_
x-ms-office365-filtering-correlation-id: f2445dee-2401-4818-9e4f-08df1a10f587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|38070700021|10067099003|56012099006|4143699003|22082099003|18002099003|11063799006;
x-microsoft-antispam-message-info: QM86vTUzZZN/RBWeoUZkmpP5VepEBSVvTFCYdDFhPXwTjd6U9o0akx5y3zhyoRhjEFS7YtRXWOjCpUupPBblipL2wFgA/XrrkmlmlSSuk84DgpOFfReEQEVCIQ02DQezX3LXHqbneAjC1hB2uTXCEznLFjymJFqeqioTgDfzuIg0t+CgUJ06Rz+pUMJr/Y4VLEndUxvckgUxeMVPMw1lyhnDKB2OgMorGpT1XJdaPtPOsuSaWOognjidDw0Jy7nXwr1y2IaYDNeZXcwJe2Y1R7SL3JiUNKoTKerdP4qZ7QvMHqrodZHrLARyQkb2KwptwwJG7i5oVH2RMfiHzTlf3RQXn38wIPkKRoIEcNt2gCIhVS2fkGHD7phJrlQsdlIdJrdf5L3KU9snVrYmH+ij03sI9CS/UKvwOd9WyJ/D4MYD8Y9DYA0ceGEiToEWIIOBfeLawUU+L17cFZDMjzQYNc9o+Ltln17Uew7ovhzbqyxQaFJmpjilvuv4OxnyGgNXNwBJ/OpHIuZI6nC4/uYsBt6BkLPkP7u6kf4FWPyUODeXWNiQM4bYknY280zEb100SKuvbdVQsp7GgzorcdjaFWNSknBUKFEoR3AitzcdXdCGIdbWILPBE01Qge0761RepRpiKDrksx92kUPQ07AsDw4erwQY15l2GlmVw1bUR4E2TuVzSsv0LxSeAelsH9pDFyYziqAh4m1EyCSx7e7cMjsGx2j78JDLnWT1/hkUze8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(38070700021)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?osrQi5VZNPqH85wmfnS3iZKIOzPN56KBjulvbOkbXZpFcelQzT0c0YtdmT9U?=
 =?us-ascii?Q?4Q3ifS0tIsswEjX+fZ9MX0+3ie7jzxupiig7S6BSuAFq1knx7OlO9tUOBsYi?=
 =?us-ascii?Q?T/lCtVzUkqbBCdHGCvpW1vOi8SElBeUgL4Pg5ohh7Ui2CDO4g2e+C9MVlkuD?=
 =?us-ascii?Q?mUxFSxgfn42cvij6ieSXbnTH3754LX2Ru6cAzq9GgBDWDZ7vxjph/rI+tY1Y?=
 =?us-ascii?Q?3N8kBXb++2UOuRsYaqg+ZqDJd8CvlUkuZeYRmpyo7/Qux+YQFt4jX2JVBjA9?=
 =?us-ascii?Q?brikZhbBt2SibYGXZA65pcHyupQxp/MjfODMJZm7H9Cwv8RR8JXwHEn+JMHV?=
 =?us-ascii?Q?prn7Is0PfNiMvLqvYa94NFD9tpisuiKo+cOgXHoa5faw9O5WGBTVrMsVhCMW?=
 =?us-ascii?Q?TCXFUXtxm1X/zZXohscbzFTertWYaF8DVemd0Zh5dH1jz6JVVYlW3hv0VJ/N?=
 =?us-ascii?Q?OzPZAflTbqauckQ+5zOdnXH/ivqATiDGaZ84bzibZBpEeo2/yuJjij2Ilb2X?=
 =?us-ascii?Q?aBwtvQMRvCDIq7+rzEVVrp0yK1e11KILm+shPuJhc0QUtKWJ3qLhvBsqrKKE?=
 =?us-ascii?Q?tgbY0VmEkmqASiB7VpDFNT7d6wHmoPbNCk70wcwj8gAgKz9jIDuwVfITOk1v?=
 =?us-ascii?Q?Sp7oYAnTATyGy3hEnyHdC3fBC4qbFt7xRydIMg6qRj7JVxEi/kntSag3qWZF?=
 =?us-ascii?Q?AjSJczmEJuyL2376kX7+FUJ+3vea2HYRD3+6FsM8a+YndfjZqlu4JMXRBetG?=
 =?us-ascii?Q?XPZfMZGtNY5qx0nE1pF/g3DvpFEz9QUyAtWD2qgg0IoEJif0RszWOkQvdsst?=
 =?us-ascii?Q?RkF/fRuuukOOHD2Y+6ouOZWKR3TphoOw5kuc9RmWqL2D4CgOoebkw5q0KWyO?=
 =?us-ascii?Q?P83kTWURs4dHzYzxrC/WqV/ysf4BcrFLzMoAbNvtTLguW7v0VOMldA4KcBUM?=
 =?us-ascii?Q?tvzsV7qP0AI/pqdSPwioV516l3xXMIiDv7kA/nUGJXGS6zGL8qfXBJ0gaEbk?=
 =?us-ascii?Q?HG/aZVU8gZL8W01388mE/QF7Vxa2wll2iMbPm4shCmDqvlcgMv0Hx1bCP+8Z?=
 =?us-ascii?Q?7Jn5I34VyLdMLhMWz1tQ01lv1Cs/knLQqBDsjSeIzpPmdyYhu9eKyAG/bbXv?=
 =?us-ascii?Q?AxrqCjwjIRoghQcabQEY67U6SjfvL70PzS4OBGAV+UE3wBM6WxqV9hFkPpjg?=
 =?us-ascii?Q?z1jXWHc2lsDyFbA7L7ezuTbVgi/pbAHpEzMwSUFmywJO/WOIgqWXB+p5nVm1?=
 =?us-ascii?Q?yt9oJuwCJFf4umqeFjEbSh7OQ4oTJwhGepBzb44/rpz4jL7omgNgWc9ai5WK?=
 =?us-ascii?Q?GM3p4PjzuZc4AP3WpnlH7dK34gxYUghDeZCGk9txuf0nU5AKfiGokJ7HEmmt?=
 =?us-ascii?Q?206znNapJT4cp3ia/VI9HJXot+gyiNIatNkKopqTOpijVtQbrN8X8OWawfog?=
 =?us-ascii?Q?dqCL1bI+GxgVAJdK4wN41gaTKnlUT5L7IPbcH25QpvN5Ih019GZfS/r7tjRu?=
 =?us-ascii?Q?gVO5zsyWn0fuoVrahjJnCY3CLYnNXjHqbBdXPdkNhAhBzVi/fbeAJ2rRNaM5?=
 =?us-ascii?Q?R90kXCo8a8Mgk+axHEk7yJvpk9mxVGQOMFHf26az69bnLSg9UG7Q+V9Z98jg?=
 =?us-ascii?Q?kXHDCL/Tu/wT0sEtZ8U7ZDkdiTygyAYHetpMjTQ0OApk/51Zy5GZZtfLCpuT?=
 =?us-ascii?Q?KH2IeZ/9yDyF07u7I0cJOmyZ+NRwqGxP64I/pntg+Cl+kEZx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 20QworIHPpG60k3nWXkKIsqw78l9k5Ju+1E/QJAU7kY819+JS3DEcPke8SgIuR/Sd9wJ7zIQUXpOnOO6PYw4+oL86RyxXzD+wugcVv4zIMvQ4flDTX3wx3movUkP9Z53rKWSplQzzp06+keqyvXRZVfK6M7H3CDIIdr+aNK4m9luBuIVEGeJ8bOr0vTU+yUvZ80B8vN9maVYPcPDhkEj98fEJ9VcUFkmL69/zKBqPyQu+pzC94YIm66lzMA0c4P9Ff3ODq+1zpaDphlPP5nSWmzhgqtNBhwVGoVvm+pqu1tMh0nyXvWiXzpOIAoVrTzqK5ejL1y1oJA2tEo5e5riFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2445dee-2401-4818-9e4f-08df1a10f587
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2026 07:53:45.0521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2QVM1+GRkk5du7ckJxiR1C3tME51M3yZpBlyrLqfEwrxDzt2Ntolnm0kMfRTkHIbCd2Cb+wmqgWO3dn33RNXAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6350
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Sent: Thursday, September 17, 2026 10:02 PM
>=20
> The cdev path only supports one bound/open device fd, but
> VFIO_DEVICE_BIND_IOMMUFD only checked the per-file access_granted flag
> before capturing the KVM file reference. A second fd for the same device
> could therefore replace device->kvm_file, fail later in vfio_df_open()
> because open_count is already nonzero, and then clear the active KVM
> association during error cleanup.
>=20
> Reject the bind while holding dev_set->lock if the device is already
> open, matching the existing cdev single-open rule before touching the
> device-wide KVM state.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

could you send it out as a separate fix?

> ---
>  drivers/vfio/device_cdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index ca75ab8eb7bd..67e48f7ebfc3 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -115,8 +115,8 @@ long vfio_df_ioctl_bind_iommufd(struct
> vfio_device_file *df,
>  		return ret;
>=20
>  	mutex_lock(&device->dev_set->lock);
> -	/* one device cannot be bound twice */
> -	if (df->access_granted) {
> +	/* The cdev path only supports one bound/open device fd. */
> +	if (df->access_granted || device->open_count) {
>  		ret =3D -EINVAL;
>  		goto out_unlock;
>  	}
> --
> 2.43.0

