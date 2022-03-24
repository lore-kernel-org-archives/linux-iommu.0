Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77048C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 02:42:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1994060AC2;
	Thu, 24 Mar 2022 02:42:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LT3fBS8N1hjX; Thu, 24 Mar 2022 02:42:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B44F560AA0;
	Thu, 24 Mar 2022 02:42:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AFB0C0012;
	Thu, 24 Mar 2022 02:42:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3449C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 02:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DE944011C
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 02:42:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yNT1ldRVfSKF for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 02:42:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36EAB400C1
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 02:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648089769; x=1679625769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tD+/gY0wwtlyQoP3S0l5niqmigzWECwKC/+zpE9NYNE=;
 b=LE36olrx5UWkPwFTSyLPpaRiWRgKU2Fkno2M+PbmJyFkB8LETNRJnkd4
 c0ZUyi6VUXzo9PmgNZLUizzZNgFFzh2vSeknXmK6c5Y9MuogBH9J5XaCS
 3PeKYVn6sqn4ImC5y+fJUV8w8MeV6GNB3MayWNJte7RdqGqWxkdlKHe3i
 8cMRGcJRKlIeM67QO5va5h/S1rL+UHaEfSNR4R2pZM8hB1EuQVXc2aiIj
 +o0hu7ZFQ3qI7B4nH1gjPkYLgFIOFYkKAe3BnsNZqXdREQUJieVOuB0VS
 7w/EzRAxb8YimB052AzO75FIjO069tO6sRmLIpZFvD9iFT8Bw2on6Zbiy w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="255837857"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; d="scan'208";a="255837857"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2022 19:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; d="scan'208";a="561183186"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by orsmga008.jf.intel.com with ESMTP; 23 Mar 2022 19:42:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 23 Mar 2022 19:42:47 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Mar 2022 19:42:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 23 Mar 2022 19:42:46 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 23 Mar 2022 19:42:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2XMqohpvZghUPDZ3+8u7ZAEHrNXWn+geIRYV7u1qnBC3Sb6pgdWgraXyvuyWdHCga24W7vv6+gzu91Fbi2d/5zc8nN8ynN4QdluaekjNWdz4r/aGKZkaazxqOXDrmQ9OUCcbL3rZGTpx6BvtzKfP2HpNpnBXnJLuQVHOH8155nqbyyebT7zUbiPhvIjMkr6wD0tKUP8NqOCNk/aqqhe3jxBJRa598tM7R8btsO6Cdqa66oQKmG40hkVjyng30rCQ/CcgpyZGJsbJhLAjTlDtChUkYj020YG0p2FJIn4085zQm0bcHNsFLtQ2Jyqw/IqfC60TOCYbKVuRDQ48TUpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tD+/gY0wwtlyQoP3S0l5niqmigzWECwKC/+zpE9NYNE=;
 b=OsrFWS1gWQDcYYHXI4tNO5gaRihKg122I4w1eDvWrCoJqM1T44Yt5LDYz42c40ChJQJMmvjv6PI1rVyt0NJk5iZE6sp45Pvqyo6W6eUt4A/DsgIb+jpCPNpXzg3s9wwwhxtKPt4EEB3GgxFOiM1QQZFoPUC8wxKiU3jAikGTWeu1IPxb9tMFbJFL0s2+PWngDG1M2Sg+ArVZXdv6918B98GbQ85oapIIxr3Xpb2dOhhvAYGOrR8Sd5R8jCFndgren/6s+NZY2ZGyrCAU+26VLn11y6icILVFGO2gIGxmvylazxht5+SPdwO4CFM4ujJ1DjC9uN8IkhS/cXldTEFD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL0PR11MB3505.namprd11.prod.outlook.com (2603:10b6:208:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Thu, 24 Mar
 2022 02:42:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 02:42:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be usable
 for iommufd
Thread-Topic: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Thread-Index: AQHYOu2DSsSjQi9eMEu6J1ns8GLP6azLfE8AgAAIMYCAAAjbgIAADNiAgAI1J0CAAAhSgIAAAkLw
Date: Thu, 24 Mar 2022 02:42:38 +0000
Message-ID: <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <4-v1-e79cd8d168e8+6-iommufd_jgg@nvidia.com>
 <808a871b3918dc067031085de3e8af6b49c6ef89.camel@linux.ibm.com>
 <20220322145741.GH11336@nvidia.com>
 <20220322092923.5bc79861.alex.williamson@redhat.com>
 <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
In-Reply-To: <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13820155-372a-4093-9958-08da0d3ff628
x-ms-traffictypediagnostic: BL0PR11MB3505:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR11MB3505BCD04BB718917C9B7F0B8C199@BL0PR11MB3505.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 03ZMSX781SEVrdtJ7mo1iSe001mL4NubPb5NxgON0BFFvmJmZF3MkaJEX5au8z9WzcbnK0yTB9ruOgARDqfYLuOD1tvQmRQYPdDqn33+5faENO1etoxkCmfW18FZ1jp1a6tcsCMcD0w1F2eyLeaX0s+A77LimlVWSHonO/huYePiol8Rdwf3cIrJigMj0j7KDLWuvyloaTiqzYQxR1XidJ8TX/IQKMxxZkU/WOdkkkJpADKtadvL84PjmmCn3Gdm41/2qbL8PeRS4Yda1p9wmdUxKThVAaXZ8OxsHq93Fk/7timmjVT+UhgbYoHUEltMVw43C1V/Ajd3edclkoJAEnnbid+MEi0i7BF3Kt6n7vZm3I4YusBcPkZERdBWTc8CP4GO0h2mTaXtlgdYzqoFbdKjR5Eycz8TY4Ay4PaYa8j/LdW1f8ZLuuccSAAv5cCoGXxGX2KDiCeHhwzHHgOW8qPUW1F8I2ayqvsU7MaeLd/k9B+57yyYGVlUUCRkpYau7me6GQ5tanNtzZql14f863k+d5C5/AsxOtiBNAGGzgRZzCistbjUfp36wb6JtkrhyS1P4Bp2f9JBv8WP1ZNsETO6DCWL2+//Cx9QD0o9W1I0nEO1UdsVUZTRTbAqg71BUKEwocLVUwdvFIxI72vXGzAXdH4F0P1HjvY2wWRb34KDgekfbsJfzoxxipUb2ri6b3wwaIDdrIdEX5Z0oOkeTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(55016003)(7696005)(6506007)(8936002)(53546011)(38100700002)(316002)(33656002)(122000001)(9686003)(71200400001)(52536014)(38070700005)(64756008)(2906002)(82960400001)(66446008)(26005)(83380400001)(8676002)(4326008)(186003)(66556008)(66476007)(5660300002)(508600001)(66946007)(86362001)(7416002)(54906003)(76116006)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVBIbGxXdUFyLyticllmdUVEeWYzMFpXNXFjNjVXVFNJVXdHODlHQmtnMkdx?=
 =?utf-8?B?Zlluc0dIUnFaU3JZS2pnUWdZSnVUSzQyM2crTmVVczI4WDk3MXhac2ZmdHhn?=
 =?utf-8?B?Y2ZheFR3dDJneVFEYjBYMnQ3ZnNQSDlWZVRQTEczck04TWgwYzNoejFrNkl1?=
 =?utf-8?B?MzYrUkE5NnkyQnNJTE1lRlRnMGdId1ptSUIvT3VDdHRVZWd1YVduRkM3U1B3?=
 =?utf-8?B?YWF3NjFxMFQzR2x0T1FXLzNnR3lLS21XZk55TzZCNy9icGNYMUJsZTJoZkxr?=
 =?utf-8?B?Y2ovU2c2SkF6alF4Y3JkczJKTGxwUFlONjNYRVpqN25rbStSOFQ2SjBtcmVy?=
 =?utf-8?B?Mk12Vmw1alFmckM0SlYyb0w3ek9uZVBPN3ZBcUM0QXprSFBUL1FyVEFvVUlC?=
 =?utf-8?B?WTQ2T1ZyUnBOTURnY1pLRjdPZlpNdVNxY2tvei9NT2ErT3VqZEh6V1Zlckx4?=
 =?utf-8?B?eUsxaU15VXFyNVBVOXJ5ckVGOUpyY3k2S3RHRStOZVdHNmlvdy9ub2hrUGda?=
 =?utf-8?B?cVNUQ2dpa2YvTXorOTM2eU1TbmdHeGhYVG82eUVTZ3Q0N2JnUjgyZDJJeXI3?=
 =?utf-8?B?M3luQW1nNCtJdmI0dm5IcVZzWDZqL0xicWw4NmFwTzgwV0x2MlptL2xNNkw2?=
 =?utf-8?B?V1ZjTC9Od3JJVzBTMC8rVWNnWGtRTERUM3NleWFuY3NsbDZXRHlNRVhxbjJO?=
 =?utf-8?B?aVhuSkM0VGxDZXJGSjZIWDF6SVJ0WWIrVU5mcUdvVC9jRno5aU9WeEU3dDdy?=
 =?utf-8?B?STlHZUg4WnFLUHpkQW9kOUcrTUJoQkt2M01tL0RXMUZZMUtIb0N5MmpnQVZY?=
 =?utf-8?B?S2hKS1dlMk9WSG8zbE9NNE1MNTlGWnB1WkpHTG44S2srK3VrV3FzRVVDdGEx?=
 =?utf-8?B?Z3JpT3dZNTQ0OVVLMWt5MENGNk9CWUI4QmZDMm15L3lUOUp2VSs0SGJ2bXNY?=
 =?utf-8?B?T25vSW4vLzRhdEFBYTZ2RmxldU9CRlJNdUFxOHFSVlIrbkxQSXErTmRianJv?=
 =?utf-8?B?VXZ4d2J0ZlFSdU1KZStDWm40VHh2SDRlZXZESG9VK0pxb2RtY1B5eEhqeGEw?=
 =?utf-8?B?SUtKRFNOYVRDV05BVHEwOGhOd2R3WjRXWlZvTTBxbzQxbkxmdjB3SjA1MWov?=
 =?utf-8?B?R2Y5RjNBOVJ5UWdtMXM0YVJTZkVMQmpNR1E3QlBsalhVVS9ONHVGZjNEalVQ?=
 =?utf-8?B?WHltUUMyV1hNWjc1eVhEN09OY3JwZU5pbG1OdndKQ1BtSERlSmxUQitZa3Rs?=
 =?utf-8?B?SDRNTktWSCtyWmpydE1NQmhnQTFmOEpGNFRnQ2NmZDZOWjBBTzNhQk9CWm50?=
 =?utf-8?B?OFFBbm50VUovQndsL1ZRNVBOWFM3Z0FQaFpwNlIzbSswVmZDU3dzREpuQWg2?=
 =?utf-8?B?RFRSRm1hOEtKY0Rydzl6WVlqZncvbnhzNTNoTDJTV0RWbzJJcXYrS1FNNzJR?=
 =?utf-8?B?OGNDVjE0c3h0ZkljWVZDQXZQbHJXZElROGFQaXR5SlplNmVmck5yaWJTem56?=
 =?utf-8?B?SzBTOEFIMHZ4K25VYXYzUzBTQ1RyUUpoSnZlL1JBTFgySVdOK2FjbVAwYzdQ?=
 =?utf-8?B?V0U5YzlFRjNmZCs1Vnoycm5JTTFlUmd4bjgzZzZJTWVoTnFhQi9EblB0Tm5M?=
 =?utf-8?B?UzE4M0szSDJmN3BBMHR1bHlOcGxlQ21aM3pZa0diNHg1MkpwSE1HK2ZRczRV?=
 =?utf-8?B?b0F0MGt1U29aWjRlWC9SanVVWU5NUGhwZm5FNWhJNFMyR09DeTR6dENHck9w?=
 =?utf-8?B?Y1pXZEw3YmsyUlZzMkVIbXk5V0lBYXZqUjFoMTE5UUJMOEVnYk5OMitaQ2hT?=
 =?utf-8?B?akJlZy81WjhncUtZTEpLVXIxQ3lCcjVsWVhwNVdKbDI0UmJPQXlaUUQ5U2RQ?=
 =?utf-8?B?ZjZ1elFCUE5lajlmMXBzZ1J2bFBJUktVMVExWXU4Y2JWdmRGWVNlUUg4bC94?=
 =?utf-8?Q?EW9IeZ2/I82s308hPXQqnyylrkGfDMt2?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13820155-372a-4093-9958-08da0d3ff628
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 02:42:38.7009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8eTbKfGol6Xj1e3+FQ48AAQYHCgiRKdb5Zq0PVY5riP9xDlHw60LcN+D3vNebr66B07phzp0lw+6vm7CVzKkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3505
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

> From: Jason Wang <jasowang@redhat.com>
> Sent: Thursday, March 24, 2022 10:28 AM
> 
> On Thu, Mar 24, 2022 at 10:12 AM Tian, Kevin <kevin.tian@intel.com> wrote:
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, March 23, 2022 12:15 AM
> > >
> > > On Tue, Mar 22, 2022 at 09:29:23AM -0600, Alex Williamson wrote:
> > >
> > > > I'm still picking my way through the series, but the later compat
> > > > interface doesn't mention this difference as an outstanding issue.
> > > > Doesn't this difference need to be accounted in how libvirt manages VM
> > > > resource limits?
> > >
> > > AFACIT, no, but it should be checked.
> > >
> > > > AIUI libvirt uses some form of prlimit(2) to set process locked
> > > > memory limits.
> > >
> > > Yes, and ulimit does work fully. prlimit adjusts the value:
> > >
> > > int do_prlimit(struct task_struct *tsk, unsigned int resource,
> > >               struct rlimit *new_rlim, struct rlimit *old_rlim)
> > > {
> > >       rlim = tsk->signal->rlim + resource;
> > > [..]
> > >               if (new_rlim)
> > >                       *rlim = *new_rlim;
> > >
> > > Which vfio reads back here:
> > >
> > > drivers/vfio/vfio_iommu_type1.c:        unsigned long pfn, limit =
> > > rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > drivers/vfio/vfio_iommu_type1.c:        unsigned long limit =
> > > rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > >
> > > And iommufd does the same read back:
> > >
> > >       lock_limit =
> > >               task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
> > > PAGE_SHIFT;
> > >       npages = pages->npinned - pages->last_npinned;
> > >       do {
> > >               cur_pages = atomic_long_read(&pages->source_user-
> > > >locked_vm);
> > >               new_pages = cur_pages + npages;
> > >               if (new_pages > lock_limit)
> > >                       return -ENOMEM;
> > >       } while (atomic_long_cmpxchg(&pages->source_user->locked_vm,
> > > cur_pages,
> > >                                    new_pages) != cur_pages);
> > >
> > > So it does work essentially the same.
> > >
> > > The difference is more subtle, iouring/etc puts the charge in the user
> > > so it is additive with things like iouring and additively spans all
> > > the users processes.
> > >
> > > However vfio is accounting only per-process and only for itself - no
> > > other subsystem uses locked as the charge variable for DMA pins.
> > >
> > > The user visible difference will be that a limit X that worked with
> > > VFIO may start to fail after a kernel upgrade as the charge accounting
> > > is now cross user and additive with things like iommufd.
> > >
> > > This whole area is a bit peculiar (eg mlock itself works differently),
> > > IMHO, but with most of the places doing pins voting to use
> > > user->locked_vm as the charge it seems the right path in today's
> > > kernel.
> > >
> > > Ceratinly having qemu concurrently using three different subsystems
> > > (vfio, rdma, iouring) issuing FOLL_LONGTERM and all accounting for
> > > RLIMIT_MEMLOCK differently cannot be sane or correct.
> > >
> > > I plan to fix RDMA like this as well so at least we can have
> > > consistency within qemu.
> > >
> >
> > I have an impression that iommufd and vfio type1 must use
> > the same accounting scheme given the management stack
> > has no insight into qemu on which one is actually used thus
> > cannot adapt to the subtle difference in between. in this
> > regard either we start fixing vfio type1 to use user->locked_vm
> > now or have iommufd follow vfio type1 for upward compatibility
> > and then change them together at a later point.
> >
> > I prefer to the former as IMHO I don't know when will be a later
> > point w/o certain kernel changes to actually break the userspace
> > policy built on a wrong accounting scheme...
> 
> I wonder if the kernel is the right place to do this. We have new uAPI

I didn't get this. This thread is about that VFIO uses a wrong accounting
scheme and then the discussion is about the impact of fixing it to the
userspace. I didn't see the question on the right place part.

> so management layer can know the difference of the accounting in
> advance by
> 
> -device vfio-pci,iommufd=on
> 

I suppose iommufd will be used once Qemu supports it, as long as
the compatibility opens that Jason/Alex discussed in another thread
are well addressed. It is not necessarily to be a control knob exposed
to the caller.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
