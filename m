Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D625C433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 05:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2A3860B5A;
	Wed,  6 Apr 2022 05:58:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ok_UmcG9Jazl; Wed,  6 Apr 2022 05:58:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9BCEC60640;
	Wed,  6 Apr 2022 05:58:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D7EEC001D;
	Wed,  6 Apr 2022 05:58:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0658AC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 05:58:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E02EF4168E
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 05:58:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cOdJrlzkbz9K for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 05:58:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA70B41638
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649224734; x=1680760734;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YNPWBQujimDRe5P5RugmbDYhY1hpPo/4csW5tLrtJ48=;
 b=WhkcXzOcNx2fAzojm21IU1W5mRAxQ5EkqBzr0S+Stj0Nlzomc+Pkr1Fa
 sDdUbMLgKL0uUDby2WzmDfrAJlQjEPY4M8TL5oGSYEX6eIOlEYeifMqGS
 FKqN56CxwLcuW5SEDggVip7ppX16heLK+kkfUjhUI/uq9RqyxbvKF5vGc
 d0Sk3vvugaBQQ3/194LVwsTH6A2vu9o6RESOqUG5PB7Gh0ahzsEWqTQH1
 eQxzkLh3Gg13v1F99hC7UNWpMPGFfo9rbDmegdullp3U9m2CKyYIQH20y
 fjzX5V0v8CcCW1yqRpGtHsn1XtbqNNu3NDVxSNsff6yGrJaKH0gE+iymh g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324128718"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="324128718"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2022 22:58:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="620655477"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2022 22:58:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 5 Apr 2022 22:58:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 5 Apr 2022 22:58:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 5 Apr 2022 22:58:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwxJuO62BAbLf6iYUSQx0825tODuDXlHtaQiKhhhDtoLEOR6ac1Iw2P6ArOoYz5PmhZarJiXT4SCltYEs4YT6Yq5AJ5fNkVMCDKzJqeXDHHiyic/Yckh6BpcUV5lRe+UYjbIqJSf/CROSkRgZgAmNkE4Uq2u+sb9qTl2GzzbJKlmEIlgqsLEvl68ZdYJsjjnjebySvK4/n6rfUy8yIqv+HeQbFx+dbiibNpxv8YxMdT6jx5Y1RN1hehhe7a/e50af7Lbh+5p8ieU1untEkpv6WI+Mx4NGJbmPstWDvgY5jxYav9kn9Tia+rW5M1yj6eSBkZIzTYGVELxjktvTsVGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNPWBQujimDRe5P5RugmbDYhY1hpPo/4csW5tLrtJ48=;
 b=YluNzTgUORn+7fwuWAg9TFgswdWdEW3Y0KhHYQDMzf07hCwtJGncf702+2dV3mYFPsCbeKHKSlNc2epLA7Jew9xf8baJI2MJjChbtWvuae8JDsP4ascBL8XUY6oK9Go0RBGvWNKqNEEnZ8mMzbulTeNmsEGUuWyL4k04ZKmqMoL8LCF3hcp+eZ9FYtK22ewlZfZSB/cqLJBy5J4AQJQOD0SL25EsSgBfOb5NfW89VarZ1B3O0d1J9TFFM2erYLh6/TrxywLv0w9YQgvy5EIdS8CBnBc7uyrZ7hNC9wRK8cGtNKU3f0H09stt2yfV9FX8ukDRjLUzoaEGOpeHeDbbAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB4497.namprd11.prod.outlook.com (2603:10b6:a03:1cc::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 05:58:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 05:58:50 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Topic: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Thread-Index: AQHYQy+FIia0eWaSv0yH5HJtvKyQTazYSueAgAQE+8CAAP1+AIAEzMlAgAAJVQCAAErBwA==
Date: Wed, 6 Apr 2022 05:58:50 +0000
Message-ID: <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
In-Reply-To: <20220406012334.GZ2120790@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a49b06ad-1f72-49dd-b617-08da1792860f
x-ms-traffictypediagnostic: BY5PR11MB4497:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB44978428C26B2827AFA482588CE79@BY5PR11MB4497.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lqm5zk3LseYWEZzWzamnPNBc4g06mk/1tZ2t9MokP7S2yuFH/aML3rkcVy7ATTYRhD/0A8CqlT5ha5by/fCjh0ONKrxOEo/G/o3ejJ42gSOie34iglfVgUOslzDsvlVGFCNhTqwLSAxq39TVPuQxOVxQluHYHAP5GCQpjkvhL3uYiepcMBnfx/SYeiZ1GCkRdk2tgwkdZh4qeiiAVC7+VTVq5AgMGlUHHxTbAXr8redGV24ci6Koiflsy2it/9spbLfOu/zRG+3BXh670/omiVF38e3yMCm2DxjczPTYqFWF/d0IkfIBuTE1RXLCJse3Qu+zfM42FYzFowejJx4UJKScTcJvLXmKOwamWrN1yvU8uyKxrBdu6rXbRnUUZS5vWPb8RQrgnwNYz2soEpCCtXy8gfOogGQYvSimSHLZVCGsb4OpqJAZfg+D0GEJvCM2G3jbYyuKGA13OZIYBnPr1Zlbm3/w16TuqpfHKEQFQU0bOwixiTcqRdCBV+hsunOM1fjLaZp/Y2h3t2PMmh+h45UqtHHV8TN2cs54ohL800RIG6pvQMeoXhcDvOuZ6AI4F69cs5KRH0lpF9GDOsGIQSuwikyY6RNoAHnnEO7x+8m6eGXgBjfpC5P/9eSFOK8OlIlWkPqMxqOQeJVxVhjgLX41gXHiK2LJHmjQBYC690hsmbUKnArjwIwGy8iBpZpmBiBCPBT90hosaWSwGkV4BA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(84040400005)(7416002)(8936002)(5660300002)(4326008)(8676002)(2906002)(55016003)(38070700005)(38100700002)(52536014)(83380400001)(33656002)(26005)(186003)(66446008)(66946007)(82960400001)(86362001)(122000001)(64756008)(66556008)(66476007)(508600001)(54906003)(6916009)(71200400001)(76116006)(316002)(7696005)(6506007)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zu6cmCGIZRoZI9T++uUPOR4aGOAPA5P4UF13TK3WzeJnaQRwtwisPDPosB10?=
 =?us-ascii?Q?PKHitjfjUrUi4R01B8dgktQYyTFL8h2Zye4B2CRz+p5HWKnZmeNVLjPlzp0F?=
 =?us-ascii?Q?KlpkcFGPn5LOVOJJO+bfU/gm32yIMS8XXiFQR3VRlv1eaFInw4gWL5xQdYGH?=
 =?us-ascii?Q?i48fSNXOneXowvhGJa2IGE3DkNC5sQeRnFeHo+skfJ5DzRtRCV9y3zgVXqNB?=
 =?us-ascii?Q?fbwcmz9xJI/1ZLYQcYoPorh7xHcruYtugI9wDceqMPsa45DkMSaav+QFXgo5?=
 =?us-ascii?Q?+Fwls8i4NevqHdpcNEwcTCS5xsG8U56+tah6y9xRHddKu08Nu96SLkUw7E3N?=
 =?us-ascii?Q?SsXDhQjndHc6ngcXLw+gltRZwNwUu9nE0LmriXbSeJKPnHecYiHQbEmd9zwL?=
 =?us-ascii?Q?yWK1WrRnRYC+AVvpCdvRM+NrRX9RNg21dJmgnOVMfH5da8C9UQ4Pnwi2dxqd?=
 =?us-ascii?Q?cS8lRQCeJEpiWcgUJ6a5y6T7ek9J0/9SR4ZKdwleesH9RVHRvD+Ekyf5/YkU?=
 =?us-ascii?Q?sX2DChbKKcipp6iQqmxaJBspbD3jj9LUWCraWKMsFJ0Tw17znTf8m/Hk0C5A?=
 =?us-ascii?Q?hI7v4cxwZrNEoDdWYMnoTmDvNUUXMxhXNKLLecHRFeXoUvmZ13bEf3i3vMb3?=
 =?us-ascii?Q?fGk29SX/3f0ta5cdrvFV30xhhciJlre0urT8vp0P1MeiJW5sPHBwMc9Ss/YC?=
 =?us-ascii?Q?/5y8fUabSuGAWiAbAEmpdB9V9G5lUThY1oFpd7oc9y9X/PjpAsiU0DvHEPsQ?=
 =?us-ascii?Q?vuunKfqQvO2VvlCKBA63fTXnebDNF8fsM1U9s0oHN4ZSa84zEKJMBWOOSKvH?=
 =?us-ascii?Q?opoWjabS6XfwJL3MXlrI1SxmdWC6/AQWJMgXnLKKFdDSFMkeZNJyasem6Xa4?=
 =?us-ascii?Q?IWAAKpf6AYxrCn/+fjmKLwGHntHWPqPVoA7yQyPCw1nhRrW/1yCzik4NpJCD?=
 =?us-ascii?Q?b+NDezeopBH2ENrwpePXCOws27WtsleDZXeA6TaDwPMvW62fmquvvKZzHQ0M?=
 =?us-ascii?Q?XUUCjrPW7e6LEuI32WsQx8oYiRutIhW5lvjaESPQDw9E03V69fT37vi9q5Go?=
 =?us-ascii?Q?Wu8e2y6xsoucIrm0j1qTgRfGEu0EDYGdE+cFYnd5PgzsC3s0ZY0nEy5IZjN9?=
 =?us-ascii?Q?M1W1WeGk/VBNRPNF8aUYJ3YbP/CMpyFWYpzrsu5VhOZT3pKdHF7ebfszyRLZ?=
 =?us-ascii?Q?KGe3tMOGBu02K6KLip4hEYFPB+nVn5Fqkd7OmGvsoUH0LjXEf0rhL9eWym+K?=
 =?us-ascii?Q?EVmvZ6lnkpuVvIwfXQfdTD4VjkUk1/iFXHBSErQI4f914hbsG+YxRYDADZ5e?=
 =?us-ascii?Q?yBKe22p5KkJeswH+v5EZa2rn0wI833IwljT6ZXluqfHbHlYNq1e+w2AlGEV8?=
 =?us-ascii?Q?2BBldPK5qDCPLdJhvCwlUxDkd5hCN7VraDx3ExXRb0OxLLeID+2xyDwu+anD?=
 =?us-ascii?Q?6RZsWzbtdA8Y3a90hUK9PTW/mE3YyejAx6+igOGBZrL4N8Ojue1v+zmN+isI?=
 =?us-ascii?Q?qqLsGrOyCMIDFfC2MjXJGwnQd9/RrtvSkKtb2/r+thTnB0BcSuH3cr9L9CYo?=
 =?us-ascii?Q?SpqZcm2nCY88/PWajiUD/Eqwg5iNnIMe1BzV75g+K1tmBYqQtVGXgV9TfxvT?=
 =?us-ascii?Q?0MM/BxdDfldaSK6cST1cBG+Bm6KhkVNDTlNkQ/oZ8OJCF8+7OCXG1AtXmKpf?=
 =?us-ascii?Q?XqSXkTLEK60cxJMDabgIsXzPtUvEv+7AGCnAB7LRWNK/lsJnK2N9b6QohmkY?=
 =?us-ascii?Q?GpjSRM8m2w=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49b06ad-1f72-49dd-b617-08da1792860f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 05:58:50.7249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAlpzy0jFHEo4mmOuM35km6O0vZisIEJZhdWHFa5hjo/S2cNWZopUz3cP9MgSsTTUXepPBt4Xdbllq4eKOXUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4497
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 6, 2022 9:24 AM
> 
> On Wed, Apr 06, 2022 at 01:00:13AM +0000, Tian, Kevin wrote:
> 
> > > Because domains wrap more than just the IOPTE format, they have
> > > additional data related to the IOMMU HW block itself. Imagine a SOC
> > > with two IOMMU HW blocks that can both process the CPU IOPTE format,
> > > but have different configuration.
> >
> > Curious. Is it hypothesis or real? If real can you help give a concrete
> > example?
> 
> Look at arm_smmu_attach_dev() - the domain has exactly one smmu
> pointer which contains the base address for the SMMU IP block. If the
> domain doesn't match the smmu pointer from the struct device it won't
> allow attaching.
> 
> I know of ARM SOCs with many copies of the SMMU IP block.
> 
> So at least with current drivers ARM seems to have this limitation.
> 

I saw that code, but before this series it is used only for stage-2 instead
of SVA. and I didn't see similar check in the old sva related paths (though
it doesn't use domain):

arm_smmu_master_sva_enable_iopf()
arm_smmu_master_enable_sva{}
__arm_smmu_sva_bind()

If I didn't overlook some trick hiding in the call chain of those functions,
is there a bug in the existing SMMU sva logic or is it conceptually correct
to not have such check for SVA?

If the former then yes we have to take SMMU IP block into consideration
thus could have multiple domains per CPU page table. If the latter then
this is not a valid example for that configuration.

Which one is correct?

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
