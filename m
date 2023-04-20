Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCC52F22;
	Thu, 20 Apr 2023 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681977634; x=1713513634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kiykTzHimcVbjuyDr55wf/5M0+s11mxuunRmyP63B20=;
  b=nQ6tZenaZ9fyHCcxPylVJ10/v4/lf+WsU/LjC5/arNDb25NuFgYzyDct
   dIaMdK0MEoL31ue+JZYLWNKP6W/aDjq7XdeCy9Dq5MA9r0NpTLmkDipQn
   e4nFw+tgU6ZuTyZW+EKrlvwghn9spNQUb8jF9mgCVgQGwlglRVmRhRYLj
   x08wQ2RiMstvZQ5hb/b82RHgqYADrIOahRpE0bFy8mIesH4kgy2wxrnPu
   qP8XJnySoe5fV0TxHrPYbLjcMrQHjNgbRCbbgkhNVwufaWhaSHN29vhi7
   1eBCYI1+fxbs7OT/zqd96xXQbDdu3yknZA9AiRGAo0vrx81JZ5IjVWdAY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="344419636"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="344419636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="803265401"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="803265401"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2023 01:00:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:00:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 01:00:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 01:00:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 01:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko0OGlQFoH7glDvyUYvpe0hg836Nc5yqTZcOHzUhnVtAmrcUaElWVWjXDTwm4a7DWoHEq8TSjkBNErPD1TtjxUAZKRzmmHcvLsufK6z+VvdtMfX/04HEfwUC+VMAyjmgeWSntRpyoAva2G39wGPlUYGSs4AnwxPghrMuhYjeERB/Sidf68ie2DOT7J4qpK7K9tiBwFNT6mxJpHb2LB99/6+HQYHW2zvPL63lb5M0VCZ8doAN1cc2z1lBp2JZfXPklTikwMwgvN51nNa+ZTAwHiU2VyHWnXHgmIdyiuoVzs5Q1yjpf4dZ7kJI3bxhEhMkeAX9DafaFExXbf1Epcxx6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZn6HL/jv1MWhFkHURQQ9GunS0XjV6mvUpNUuq/3fAc=;
 b=Yt0k5VFhDub8+S8aaDJ7z44PuBhxMtIsQ+Xc0WnDRyT2OH5HZ+Xe+3tIMnhrBv4LAbpuHuavCjHXtugEYKA1l20nfM8Q/ZhyvmgC/iGjXTumhoMYQZ+kB1ocViSwXn4H66j18DAc0agrIpqPCk1n8I5YHyiT+fHzaY/UHaT82y8jSnXdVCZ6PYPJrCedff5+P+UGhlYJidBSvwIukxLjMH3hrZxyUmRwYRak+YWfjQ/3t4I/f9ML3PyTEwu0PCTGP/44StP9IO8v+Agnx+cW8rfdEgXtw8u64t2gOd6EmRIAc5c7+1had7yx6ftGw++gItQbZYC9zxLFsX3yAQjO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH8PR11MB6831.namprd11.prod.outlook.com (2603:10b6:510:22d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 20 Apr
 2023 08:00:28 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5e54:1212:2071:613f%8]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 08:00:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda
	<ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Rix, Tom"
	<trix@redhat.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Thread-Topic: [PATCH v4 15/17] iommu: Allow IOMMU_RESV_DIRECT to work on ARM
Thread-Index: AQHZbUX4yKLfAStH5k+1RBDy7PmNI68z4Xzw
Date: Thu, 20 Apr 2023 08:00:28 +0000
Message-ID: <BL1PR11MB527165BEE507FED5D3D57A928C639@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <15-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <15-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH8PR11MB6831:EE_
x-ms-office365-filtering-correlation-id: 6a2a8f21-eba3-419c-96d4-08db41754e71
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7pw9C0FE2QspbRzTBN9uH6kOAv9+rEzr3cAHGqy6685AN5aBhpkd6t4zLeffQbgyPohDiNsiMTzKmaPDv0UeIYzJAJmlsWmsTWNF6bglkTNWUxYMLCnDEsxSj/CxzGlQLYeOgb05MTeNLFmRZG24be8PJtFP3qOVfrj3imX+aqGinsygH0kKSpcSP+c+rq2My0SrPidwRpBwcLXjhNe7ayQY+ODTiKSCHIUQ09Ong/fj2Wza/31VdC89mp21zlv4m8IbZ3CkhTu1LeNlFPgkXA/2NFixWIJpkbCFzVbraDikr63nEmMa6rPcUAL7f7VgM6dmhaeAEHHb00CMNFS0uouUIbP6YoIQDkHsoYQt3u7z6SoeLvT1hcJoi+McxU+dL4fIizbvYbGyM08Abn2TEGcqmQLCN7Z9sdtKU1eAhLvbvdS/Lo7veu8OwDa1sNDTnMawOosZLqXu/h5VWmPJCw5hrrxh3xg875ig4ER4Y2t5eAEmr21eOTpxjpuRjPKrkxHg+yUKR+eCV7C7iYiCkLWVDu+/SSKeStd39D0fKbNauwnMIodpNiM9Gfqvc+aCEn9LjNmieCyw3LsDvp6D1yGrcjeqgPeXZwBBtaNUZUwIlSO4z9+abr0oeEg7rsGvm0LHxhSe3tHwYFcnCMTnSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(4326008)(316002)(38100700002)(64756008)(82960400001)(66946007)(66446008)(76116006)(66556008)(66476007)(86362001)(5660300002)(52536014)(7696005)(71200400001)(41300700001)(54906003)(6506007)(9686003)(186003)(26005)(38070700005)(8936002)(2906002)(83380400001)(8676002)(7416002)(4744005)(55016003)(33656002)(478600001)(110136005)(921005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6dLcgx3BW4yOLz1lC69m+YvK6t1mNx5ybHXCEMpR85lToSeqG5NuPYTXkQmD?=
 =?us-ascii?Q?Pvh4USJp5t9HQcTpLGQV1i6qSvo4X4Vk6nR5/1ltL7ktjbjFNtP8HaegMVOd?=
 =?us-ascii?Q?CoT3ih+AU4oKYVg0pZ9LZZrgFxNUExeOhQbAZtofyzgPwoovR1d/1mJ1UrOi?=
 =?us-ascii?Q?qFNM8PPW7/Vp65Ym9iygaoj+L8vOh3o4LRO2Mn4GH/fEPTHdX9m/ADC7e32u?=
 =?us-ascii?Q?3W5SAEHtO06K5FMjFm8zTJb6VjCkbQD1ai4ck1OJI1BnS1Z1bqhjRTrDwmRX?=
 =?us-ascii?Q?QFTxnyWYAF+9PFl1JNS25Bf0+RK/rhyw7LCVlaD7bR3Iix/KDfzSBYsmPliq?=
 =?us-ascii?Q?40c/DxodZa++rykwKSTXR2V5we/sbVwPsGU9M9qSSl+Fj+HBIrpJnNh8tzGu?=
 =?us-ascii?Q?eJjmvu4p/X++0LlkE3MnNeL3KuigcvVN5jrTKctlaCqt7O8NNERTqUuiI/Sx?=
 =?us-ascii?Q?nr09B6y9SMNfd5jjj8/kYKNvXGipJp48zdbVoSmpWaLoL/J6z4PkRxzG3548?=
 =?us-ascii?Q?ECkrrJCrGpc2w0L1+13I+FVW9Tke2XcsbIet4mfMZbc+FrzpDSCdAy0JdFcj?=
 =?us-ascii?Q?C34izMC2VMTZgnYVUOB3bbe7KuKg6qukXQuhPqAlDoPbphb/kNybdCHQvEno?=
 =?us-ascii?Q?vySDQmEVOL6yAXH1EJfWBb1XI+Tncv8J3kkR+0Q0B/inPlTQIRCQNf6A+VoQ?=
 =?us-ascii?Q?68Q1Tvn6JpXJfI90yGzUjkeJlJ+9Vu7wGKXxY/mGpdsdIWILx6T8ffcR3t7s?=
 =?us-ascii?Q?9sIaQCwqZP+ogQVzGWJwkjKnyraRRTPfy2fHp1rJBGQoUPxY/btSocjbKzw3?=
 =?us-ascii?Q?IiNvTXtH0NASL3Egt2sJQ2cgcJPQof0EOmYWJCCfLLsLiC70VkWELFPuJU6k?=
 =?us-ascii?Q?UxLvZ4ypwWxtl6R7lzEAJ40p6W60a7B+1dGvdU57GbN3Nj9vQf00aMiIoU91?=
 =?us-ascii?Q?9qUoqgNeOHF+I6lix4rDn5Q9GARaGjpPJfTU5sVjISc9ERKIh7fWYmFhrYOI?=
 =?us-ascii?Q?Gxv/uomgZACawBy8z4tWEQpIjDfsec2pfIAwnften2PEvF/hgoZ777WN6Vw6?=
 =?us-ascii?Q?obyDEEHhQbWBBxzOYLZKH77JPH9VioAMPYd4hs/UapGGNMgn9r3R8IgmDMex?=
 =?us-ascii?Q?E3AIVxRczmNFgKQisOezamh2NCD/XsvIz+UpQY30NdTnjI3HNYan7pAoko7y?=
 =?us-ascii?Q?OJOntBfh2X/T0GeYDMaGg364pX2wx7rrGMO9jjr9hkOSJeaSYZR/vn+l0gEQ?=
 =?us-ascii?Q?2vr5c84uPCKYqywHYiMPAyCaPWH2DzheDhHeC7kVdYGp3CWklatYEQWdItva?=
 =?us-ascii?Q?syKz5qPr65LCADbbGnVMUg2pDIOKvtPmQiJefBeLPBUaSgzG72BfIFE+PT+0?=
 =?us-ascii?Q?cz6645r1e6E2r2tK50L7HfGWj+YWLzKIafnNybbdd/OnoOT4K/qrYIuyYuHW?=
 =?us-ascii?Q?aScSG1FADjFJyB5N9Epv+6AL2IqabVrirELhyDJMFEhTmeohXvA1PGX3PWQ5?=
 =?us-ascii?Q?FixsGk1oachPTH9bbfx9EPKUN3PNJLmXWGUmaAyrk4cdzLkD0vS++iYQ2PfI?=
 =?us-ascii?Q?K6/IvWduPbwNZfYLqHJdBqrpVbEkj7SNiGHIVyz4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2a8f21-eba3-419c-96d4-08db41754e71
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2023 08:00:28.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLNamqe392DLIHIVQo4+IcEmCADbWCgm3l7n4Kz3WjURUeSSswljzkxRDBaGe4uLWFDcg5Mk8ys+6wXWpEVatg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6831
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 12, 2023 9:52 PM
>
> @@ -2918,6 +2922,17 @@ static int iommu_setup_default_domain(struct
> iommu_group *group,
>  		}
>  	}
>=20
> +	/*
> +	 * Drivers are supposed to allow mappings to be installed in a
> domain
> +	 * before device attachment, but some don't. Hack around this defect
> by
> +	 * trying again after attaching. If this happens it means the device
> +	 * will not continuously have the IOMMU_RESV_DIRECT map.
> +	 */
> +	if (direct_failed) {
> +		for_each_group_device(group, gdev)
> +			iommu_create_device_direct_mappings(dom, gdev-
> >dev);
> +	}
> +

Throw out a warning so user knows that the continuity might be broken
here?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
