Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33E1C433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 07:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77B58408E9;
	Tue, 12 Apr 2022 07:44:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tSJsyYizlRn; Tue, 12 Apr 2022 07:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB15D408DE;
	Tue, 12 Apr 2022 07:44:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C1A5C0033;
	Tue, 12 Apr 2022 07:44:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 977B6C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:44:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 853FD40133
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:44:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FbKnebTgW-tR for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 07:44:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3906940116
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 07:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649749492; x=1681285492;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vpmkWKOQA5KN5G2j2WoeQhABOk1zzOZZhxhKM2ovmOM=;
 b=dy52cct49mSwII9BGDWB58jgrTThZPX4G5RodYNLi/zrXLGNskAdF3D6
 Mi6woB/g2XiKSrVQqrd5Rr36cuK6reHmOCKtDugjw+69MsBYDld2mdNWE
 FaIGNQ12RYlu/ftbUzoxzkCPGayYtiflxbWy6VCRkk2vysgHRpbTYPaLh
 M7yGlvfbXXy1YttACHIO6mWsmxL3YQLsy0YGTmXsHP5I6VLbbkkndc4p/
 xwqjMK9Hjs5JDmPXzDJdpL4gvcSYjzhTgNmKeV3c+0CbPCOxeJ6Ok3JEA
 yjOxZxjjhDrHvgDYhTnXhInivKmjmfOmyM2NP5Qc/PTW/rY3uZ4rSvWnT A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325214754"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="325214754"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 00:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="660381282"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 00:44:45 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 00:44:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 00:44:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 00:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpqAYyFmdbi7gTU9fncTn+Cag20w2a5wmQuVSfnbhAUd2MhwVcEg07FdJt43MTX5tFetG42Yr2mxxOofX3hYbPMKkPEE6Tofa327oBeflTWUtewl9ejRxVdiItwCGy9rcEWJ2l3gM4jL9X+63l4Pucx0OPFnlZrYF/GXuiWa7OnI9lkQWriLntGZX/993PpRhv8Jeex5AjPDqA4nCVZ9q7oWTgcVodhMT2JODmBRjv3ptc6R4Q7uhvfeCVgS0RQF/ngQija6TcvAGWnnP0UIOYBk+tzLoji2lK7TanXBWUOFOenHA2xnrrdAJnSxZ97KsI9t8ublAYm+zzlgKWNxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpmkWKOQA5KN5G2j2WoeQhABOk1zzOZZhxhKM2ovmOM=;
 b=hxE97/uxtb2+2cqXbSwkq2r3KehRMGMHRCvozgGU7hyechtW8Vw6eTYNGbUuhbCpwgOlk7SVP53WpFCpl2iyRzx/286FH5ZMeXBQASEhQ4aMQFMhKqzrfX8WdQnZVIFVTPjRhjwdQowK0Pvg+FRPi7sG+P63IKOowianiANzr8SIHpUtGKOKKWGwkxUNSPBljCZU1Xav32hKJAZlDm4Md+SQUl2e11Fbrg1LV1cnRdGdBoK2yDfQym9E6aMKn+ZLfhaQ/edTGfY23YOGVWwheP+mUieEawI9bJAfAnzNuU8xaQibIeEWMdv+PjCBVKqVmAWLxhuxPOzjuuAF8agL3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB3615.namprd11.prod.outlook.com (2603:10b6:208:ec::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:44:43 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 07:44:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Joerg
 Roedel" <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon
 <will@kernel.org>
Subject: RE: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Thread-Topic: [PATCH v2 2/4] vfio: Move the Intel no-snoop control off of
 IOMMU_CACHE
Thread-Index: AQHYSpODjq97KCkZqE+HgacEjq1/gKzlqx6ggAHgngCABGEPsA==
Date: Tue, 12 Apr 2022 07:44:43 +0000
Message-ID: <BN9PR11MB5276FD53286C0181B4987C958CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <2-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
 <BN9PR11MB5276796235136C1E6C50A5AF8CE99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8df77a0f-55ee-bbc3-8ada-ab109d9323eb@linux.intel.com>
In-Reply-To: <8df77a0f-55ee-bbc3-8ada-ab109d9323eb@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9972d6c3-1342-458c-0198-08da1c584f39
x-ms-traffictypediagnostic: MN2PR11MB3615:EE_
x-microsoft-antispam-prvs: <MN2PR11MB36152F6753F32A35693ECBEA8CED9@MN2PR11MB3615.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2SVw3A6EDUT/59zPwSLXUqVWtRoWEqLIWyXMHXeYT1fjf5EfgqN3kt77UPbHHlkLS+QQE4AZtKxRHD5zodCqzym8fQsK1iaRB3Qsq+EdPzVnUCnjeIhwbocwjrNsLmCIn+6rX0BFXMivYB6Wp78Q9U0c0sV4i7j9q0+M8JVyByYaNMoJkUxwn63yFOfKrZBskoz4AHcgxnV+TtBa8JH7BGDTgZoM5QWU/rEmMc9OXTzXmVHoLBNXIddL84pHTvMJ24OGFSLQbzH062bU2nsI7KN6pIZI9BFAbxtpCWklLD5jet6i2fvSNigckcMOpeiCMwh8Pb3fspJhjfO1f9FLQu2yedaNBkpUHY+DhnnI8jF80EuGivjJz/TDHSdYAALsFurZ9RHl8ya/0w0V/w1fxAhdwFahJ1FgFL3ZKWiVnVO/cCrA/THmS11+vmG/3BuWJoi3JgBlFDOgB4OdD/5HBy9l3NWMlgMI+otUPbA1bNjfWRu74pQtI5rP0SoIqwbd+TXNXmyq8o9YfjXm4z/AN4tE2705Hz36Ph4/ng3A7fJ8+of4CeQypzt6XrN3oRBBWPQHAq155yXPVMe/tBN0HUILkYJOjJci3vQdikZUAt3B0V9YAXjMuyEAepAGQKQx96C+VC+ut+Pb92O5trnbN4Ob9icu9Fa4W+p2tcL24QbGfNLIBzhM+RerlJ87JVwiDy8d+MnYcqazk/VkpyNEVDbbMqVfyLsffw1gvvIUaM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(55016003)(82960400001)(122000001)(53546011)(9686003)(921005)(38070700005)(33656002)(2906002)(83380400001)(508600001)(86362001)(316002)(52536014)(38100700002)(71200400001)(7416002)(8936002)(5660300002)(66446008)(66556008)(66946007)(66476007)(76116006)(6506007)(7696005)(64756008)(110136005)(54906003)(8676002)(4326008)(26005)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkYwOWl4NGFNS0c5UGxYVStaVHp2SHI1NXdXV2d1a28vNmlaM2svaFgrdWg2?=
 =?utf-8?B?RG1ndlNkUG53dWVaa0pHOFJEVFl1WjNOR3hxVUwxL25oMTVSRXEyU3NnQU8y?=
 =?utf-8?B?ZmpDZzRDQkN1NjcySW93YVMvTHlIMlVRVHVtK2dkdWFhMzd0aVZxRjFFa1hL?=
 =?utf-8?B?MEgySGQ1NloycFFuVmFtTHZhaTBlemgwM21VbzR6OVFTWWFucDRqOFNnTCtz?=
 =?utf-8?B?VG51NlRjc1Q4a2Nxd2V1cjRSYlJyTGRiZXNhQVROVGxqVE8zRW4vUGlHTWk2?=
 =?utf-8?B?U2ZPVjVjOXZnanhhS3JyZU90OE9nVE9GVVVhMnY4cGxhM2xwbUY2cFAxSUtO?=
 =?utf-8?B?ZzBNVzFnam5Gd09sWllQVVRMS2Fjd0FYOC96TC93MFVsNEhZNVNMdmp6VWk0?=
 =?utf-8?B?Wk9UN2RRNWxEWjNVV2N1K05VRjAycXZMa25aZjBNTzdCcnl0YUJoTmFneEZz?=
 =?utf-8?B?QmhCelVVN1ZnZUtUZkk4WWgweFBwYkVqejlzcEZlNnNNMmlVMjQ1aEJiZGE5?=
 =?utf-8?B?M05pVXFkeHFVTzBha0NaQnoyczJMelVRWGNodnNNdXo3Szg2NnlkRjZFZE55?=
 =?utf-8?B?SXkwTXZ6V0NrcUFvdGpobkhCR1BnazV5aDlaZW1UN0FuNEU0VnlRdWVlK2Zi?=
 =?utf-8?B?SHJ3cXY1cjV4ZzVtSFR6Z1NHQ3o1K3JHYzVVYjEyVGdvZmxYT3ZTT1JEUGFQ?=
 =?utf-8?B?TndVZkM2QmdYUW1TdFMvNnZuL2lqem1OOFp0OHZ0MlU3T0hCQ3JOZ21sb3FK?=
 =?utf-8?B?VlgzV3NraHJvd2xhbzVuOWtvU2Z2TUl5em1CWWxZNzAza1daaGxZRUpqazlo?=
 =?utf-8?B?cGdoT01lUk1jaTBCaTZQdE56NmtyNFNvZG9MdzV1eE4wTVM2ZksrcDFVbDUr?=
 =?utf-8?B?S1AzNGpCVU5jRVNIM0ZYaStNM2wxUVRSZ0ZsZmFOclhDdlFEQUczd2JiYlE1?=
 =?utf-8?B?bkNTaGpXNmdWL3ozMGZaSlIvSjZoNlc1cVk5b2wvZ2dDdzNzQzBkZnBXRDJC?=
 =?utf-8?B?Zm5FV3pNc1lnTFpzcllhdEh6TXJlQlc0RjBoNUpTNHpHSHRaaEtRcEV4MnBQ?=
 =?utf-8?B?dHdVMHcyUmQxSXZQSE1ZWjhmN1BMdENwT3h1Nk1hVHFVbGQ4Ym1CWnIwUGQy?=
 =?utf-8?B?YmNhM1NjaG40Uk5IUSs1aEp4K0JmQWZOc1ZlUDM5VWx1cXdBNExlSnRkOVlW?=
 =?utf-8?B?TTA1NUlDRFNHMFFQeEwxRFIxN3JUbXRPcEhaY0J0Q0NXckl5aWN0cjFJa0Ji?=
 =?utf-8?B?a3UrZjNPTzRvMW40dHduYnNvdjFjd3ZGckpwbnZpOEJvSExMSzJnMnlsOStE?=
 =?utf-8?B?dG5NSmJmdVo2cUVQa1d6MVgxeis1ZVZXaFBvbjFzOHJXZk11M0tFeER4T3ZN?=
 =?utf-8?B?bXhTdWs5bGVyTmMwU1BINmdjTjlZbjA1NFpaMXVLK2lQOERJcmVuTThGWHJx?=
 =?utf-8?B?VWM5M0pVUi84NnZRcFpsa2R6bGUvSTloT2FicEFiZnRJdVU0Yjg3Q2FjUW9B?=
 =?utf-8?B?S1cwVzFzY2pyenc2RWlJbVpVZGcrN0F6a1RnV042UVcxbEgzTnBacHpxRzNn?=
 =?utf-8?B?Y0d1KzNIMTh6SFdxZi9xL0l0SjdKSHE3NUE2SWNFVTFYUWlzVHYyNDBHSXZF?=
 =?utf-8?B?NzFQWmE4ay95YUp3MVBUd21oM2E2Q1NhMENucVlaSG5oeVdHMTlKY3FxclhH?=
 =?utf-8?B?THNwM2xDcXFjZFc2aGRFRG5Bdld5UENYK0hNRExRcEJ6QnZ0L3dCb1BISzZI?=
 =?utf-8?B?NnY2MEhkN0FqbG9HQmozM1B6cGVwWjZGTW1MdkhGWEc3VWc1WEMxNGIxVDZ4?=
 =?utf-8?B?cHNHeVYxSzZzQ01LYjRsVnZaa043MmdRM0RxaC9ndEJaTytkdkZmWmhuVHlN?=
 =?utf-8?B?dzh1cVB1bkxEblBwbmZMZVZQTERnbWY0ZUVYd1JzVkRjWE5LQjZ6YW1tMGo2?=
 =?utf-8?B?dEpJL1UyRUJSTXFJMWIrZTVmc1YvN3JldW15akR4RCtDSFRWbHlyQUtQd1Jl?=
 =?utf-8?B?bGpKbG4yNW1ER1MvQlJYN2NzUVhockJGK1FZUmQ5YXI2QWViMXkxV2NIbEVM?=
 =?utf-8?B?MW1YVkpweTRYNFlMNDVVZVBMbWpzNjlHK1pQUVZ3ZTIvL3VKWEpWQmlZYzVz?=
 =?utf-8?B?R2VEdWEyb3J4OWh6cXNwUGRNQkhkK3ZzVjRsT1o3OUU1SDFpUGdOSjhOUXF2?=
 =?utf-8?B?UWRHckxhckx2SzdJL2ZuQkwrVUVLQm5TYzZnSTlSbisrd2Y4VXROamt5dlF4?=
 =?utf-8?B?MFlYU1BmeVpkRTVKQm5HcmZmalNiaS93WWE4bndOcXV5S0JGY3hhV3pka0pS?=
 =?utf-8?B?c0hTSm5HK25VVzNja3Q5VjJDWUFFRWQzZjlmSlpvblBHbmpwUGhsdz09?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9972d6c3-1342-458c-0198-08da1c584f39
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 07:44:43.6776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lyv5aXvsTgO4Z+6CKwN33DvzXXGYkgsDI5rxNz/zwA1fliXUwAhI7u2goDI0ArJG9WdKdkLiTLHoLn++J/Zr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3615
X-OriginatorOrg: intel.com
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Saturday, April 9, 2022 8:51 PM
> 
> On 2022/4/8 16:16, Tian, Kevin wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> Sent: Thursday, April 7, 2022 11:24 PM
> >>
> >> IOMMU_CACHE means "normal DMA to this iommu_domain's IOVA
> should
> >> be cache
> >> coherent" and is used by the DMA API. The definition allows for special
> >> non-coherent DMA to exist - ie processing of the no-snoop flag in PCIe
> >> TLPs - so long as this behavior is opt-in by the device driver.
> >>
> >> The flag is mainly used by the DMA API to synchronize the IOMMU setting
> >> with the expected cache behavior of the DMA master. eg based on
> >> dev_is_dma_coherent() in some case.
> >>
> >> For Intel IOMMU IOMMU_CACHE was redefined to mean 'force all DMA
> to
> >> be
> >> cache coherent' which has the practical effect of causing the IOMMU to
> >> ignore the no-snoop bit in a PCIe TLP.
> >>
> >> x86 platforms are always IOMMU_CACHE, so Intel should ignore this flag.
> >>
> >> Instead use the new domain op enforce_cache_coherency() which causes
> >> every
> >> IOPTE created in the domain to have the no-snoop blocking behavior.
> >>
> >> Reconfigure VFIO to always use IOMMU_CACHE and call
> >> enforce_cache_coherency() to operate the special Intel behavior.
> >>
> >> Remove the IOMMU_CACHE test from Intel IOMMU.
> >>
> >> Ultimately VFIO plumbs the result of enforce_cache_coherency() back into
> >> the x86 platform code through kvm_arch_register_noncoherent_dma()
> >> which
> >> controls if the WBINVD instruction is available in the guest. No other
> >> arch implements kvm_arch_register_noncoherent_dma().
> >>
> >> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> >
> > btw as discussed in last version it is not necessarily to recalculate
> > snoop control globally with this new approach. Will follow up to
> > clean it up after this series is merged.
> 
> Agreed. But it also requires the enforce_cache_coherency() to be called
> only after domain being attached to a device just as VFIO is doing.

that actually makes sense, right? w/o device attached it's pointless to
call that interface on a domain...

> 
> Anyway, for this change in iommu/vt-d:
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
