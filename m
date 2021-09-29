Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BC0C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:29:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F7B613DB
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80F7B613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D66E80F6A;
	Wed, 29 Sep 2021 02:29:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISlNF3iGQO4a; Wed, 29 Sep 2021 02:29:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 28F4180F2A;
	Wed, 29 Sep 2021 02:29:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1D8CC0011;
	Wed, 29 Sep 2021 02:29:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3BE9C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:29:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D7D980F6A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:29:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0OVfGne6uqNQ for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 02:29:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81A5780F2A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:29:26 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="204334313"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="204334313"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 19:29:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="456852609"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
 by orsmga002.jf.intel.com with ESMTP; 28 Sep 2021 19:29:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 28 Sep 2021 19:29:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 28 Sep 2021 19:29:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 28 Sep 2021 19:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvX6HKEHcHyByyvPNJf8SBONr4sT4YAFyl03H7+oVffNZn+efWuW1dhFnO3TDHwi591lBFdiaAvGd6qI/SyO4qjGpaYbZiAihiBGdKzDNWMjzReTmv41A7rI1KYdDf+uKDdwhrNxnEkJ/i9Qi8HcZDpg3zYTND+xnFHG9p0KuUvVgE+vyCUtYNILu8ifkP6os80H2PalkgtagfEDS6G/TpzfzhK31BicHisqgprw2/W8Y/at4fjUfqLGpXXjkiNcJdHc2cGo2p5cugut6b4R8Ou80cJG5AbJXBGKyELtE5ZS7wKs9ghKElwpAr63mzhF23C1uVtJbNeef01P56GXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ckcHQpvTNlEgl5V2dP2OoIHAUwxRSJmOiQnN2HZiOxU=;
 b=OdE1RYk+Z57oatqhB4vsEau607gkg2OrnDPqL4GzIzrY3VhHD/HbGRGQe2UEZnoFeNpl2n9L4kCctQMpk5bvjXKBQBMuLS7HeIqixv2oI/fCqlufVTvU2MIfzHAZKzeNRxUdPzFlU93bO1nCZl2BqxC/V1NOFhVQFl0Si3Pnwap7TGvtlV3VCDRvnFv5LOYpX2IzoeiJhW3MgZ7AOALfrm6/6xA0iybdAY5M0CPrtmxEEG1U2gvA5NKiNxxcuVx/IjRBo2ji5I49PzWq79jnz6aV+lAc6QB7ACouqVSDRvgLgH6JiaMRLNoiGwJ9M887ssFeY7/qklKcQNW1YFwNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckcHQpvTNlEgl5V2dP2OoIHAUwxRSJmOiQnN2HZiOxU=;
 b=ENA23bwSxtAJK9dXATPIqc97yTOyzD6TeXXbtNvYSkq9LbKxj/6cQUsJ3UfuIvVAa+yoDUCNDS471RKqjpR2+xdeuu91DRn9B79WGPrr+Je8gD4UfrXVb5hjkrlVYvjh0ym2BbDnUil5DiaPdkjS6dvH34H8cCITACEF2e0xUJI=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB1796.namprd11.prod.outlook.com (2603:10b6:404:103::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Wed, 29 Sep
 2021 02:29:18 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ddb7:fa7f:2cc:45df%8]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 02:29:18 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
Thread-Topic: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma
 interfaces
Thread-Index: AQHXrSF9WDj+Z+DU+UqMJ7tQK2EdmauuvK2AgACKnbCAALw6gIAHYVYAgACkNwCAAQ1OQIAAT36AgAAbKoCAAAj5AIAAzVwAgAABm9A=
Date: Wed, 29 Sep 2021 02:29:18 +0000
Message-ID: <BN9PR11MB54338527F3D400A559EE0B058CA99@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210927150928.GA1517957@nvidia.com>
 <BN9PR11MB54337B7F65B98C2335B806938CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210928115751.GK964074@nvidia.com>
 <9a314095-3db9-30fc-2ed9-4e46d385036d@linux.intel.com>
 <20210928140712.GL964074@nvidia.com>
 <4ba3294b-1628-0522-17ff-8aa38ed5a615@linux.intel.com>
In-Reply-To: <4ba3294b-1628-0522-17ff-8aa38ed5a615@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f1f41b-19a2-4189-01bf-08d982f0f07e
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB17967A875A8A29D1CB1E96C78CA99@BN6PR11MB1796.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hFd/7VjvnVzy7gye8MYZb7uCvTWXNtSunuwbttbf4yc+yiDSiIYhpdYgSG8fMYhE+703aenZSquM6YOJHh8XIDX3ClHHyrK1dtVzvUux71jmtXd7vmU46wU6ynxBzuDaDoQ2dPpCvPIqIVgqgKTI7h6ucdKitoQ7+AimmVpbtjI2eigHJO1jWF/nSrl0RZxnufvp51timnHLvKSNbwoHTKDOZYAiD29KGfS4LbOZny86UytzL0YJ0N6PaIiGVzIkl8VjliJh4Uoa/KTjUbthi7uA1hEzmtVDP7KRMZWuVJDCk37RNgVnpsDSOEXlRzBHuwEU+eiG5yQX/nBvbJWWKF6QKAHCLCPXVnWacD2Ql2o//FPH9NgdOUEu5oCjWyGCDmgSKG7tOAl4rkMLSDzd/DxErgVv6b0ZsrJ1Mx9WWk1uLKwVe4ldnD1Plu2mWzLjKBAsGU60yjIqoM6+p+paS6xzYNPl8bV+/mwXJpPiOgdzRhmYhM2a+U0xa84TyDtAAHFGSFz1wNCgam0U/7H+SvqxmkzR1S8VxCN3f/xD6pcpRFAgjCSnbPxXdIAXUOD9FJO7y3xwzSTqhGOB7Pi0naKb05GgM00fm3QuKOXGUy0DwYtVuI2PcLdr2IJG3YwVSPK1lvUaGQM5ydm+2v6NwPVaJ7aqIwza6rfCuvZrZcaUg0g+7HEtkdp/5hTB6ZxCVFFC3jFVnpKN01wVaqtXIPciki1BpUuG+4vVagk948W55fDqIbCTHfP4kH07PXCGFih4c1KyKP06gATYVT6U6adeGJcPvsRB6tUCZo9vVBQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(8936002)(122000001)(38100700002)(26005)(186003)(2906002)(83380400001)(86362001)(966005)(38070700005)(508600001)(64756008)(66476007)(71200400001)(6506007)(52536014)(55016002)(66446008)(54906003)(4326008)(76116006)(316002)(7696005)(110136005)(66556008)(66946007)(33656002)(9686003)(7416002)(53546011)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RktSNTdReWlBbzcrMnR4SXovWGtsYWhvblRnRjkrNUZ6bzd4S1YwaWhxYVFr?=
 =?utf-8?B?b2VydE1CT1Bkejh5azlocVBRcWpLd2hHZnFBRkhOZHd4Um1IMk9kZFZlWHZY?=
 =?utf-8?B?bnh2NWQwdlN1TzVRdVB6NkpXMEgxdWdndjF0OVJYWTl3YzJxMTRyWmxuTEhB?=
 =?utf-8?B?M1JvS3hGeDhMZ2Vudk9DQ3VOdG43Y3FRbVh0WkhkeXdBaVZ6NFYwN0dNZ0c1?=
 =?utf-8?B?V2tELyt0NnFkMlZWRzFtZGdoWE9mSU1rZWsxaW9hUFJ3eE9qM2loTlpMYWp0?=
 =?utf-8?B?MHVoQ3QySlRucEJFdVRJQjhEUjVFK0JCOWgwdFJmSTY3Zm45UElYU3Y3ajdX?=
 =?utf-8?B?YkNDa21Vd0Y1eFdXN3NIT3lndWYzTTVjTkQzNi9TM3gxVzliL201WGhrdlVS?=
 =?utf-8?B?V296WXRYcHJKUERMU1JMTXNqREFpWm9PNXZJSmJkMWNxY05lZzkzSEsycG5h?=
 =?utf-8?B?QWNacDZ3RkQ2T0NrNTE2SFI3RDhqaUlqbThzVTk4RE5HdnVFVVlLL0ZiQUpF?=
 =?utf-8?B?dEZCc0VKbnZucjlMeWdyWEtMelZ4OHo0V1AvMTU3ajN5Z0NDb2tSdTZ1U2ZI?=
 =?utf-8?B?Wk83US94U2NBY3FQTW9qTlJ5T2V5dEdicnBOSmlab3l5WDJpcW9SVGYrWS9U?=
 =?utf-8?B?WkJJM25Pb2Z4dHdTUGhhbUxQQ0NFaFoxN3RWVDVWemxNdmpnMmR5NWxJZTB0?=
 =?utf-8?B?NWh3UStBcFgrUUNOL2h0bmVuMXA2VEJoaTJzb1FQaUZDVEJKRTcvTkY2OFhp?=
 =?utf-8?B?aElObUVHUjFNcUd4Z3pyZ0hMZDZKNmNlQUFkU0V3RFhTOUJVM3ZPMDIyUXEx?=
 =?utf-8?B?aUp1bjJEeHkwRHowQ2xtblAxbkNac050bjQ2TXZubks2R2t2enNkWWJOUHZY?=
 =?utf-8?B?L1JmTVpQWExhT0N6d1hFdGkzcDRkazhFZkRpUVF5VG4xSThENVY1ZWpac2dv?=
 =?utf-8?B?YlhiWm9rZ2R6dFd2blhTVzdNM2hWbWdKRFhXN0RMTDVLeW13RGNqVjdibGF5?=
 =?utf-8?B?bFpNeno2R1EremhmVndOTEphMXVJZUVXNUs1ZE54QjZHRnMzREhjVW9mcEZ2?=
 =?utf-8?B?TVpJaXVzaXBLUVJJaU50R1QrUHZzSGlRbTVqOThXcFJLZytmcGl2U3pRMFJE?=
 =?utf-8?B?YkNTN0I5b2ZyTGhrcmZ0djlaOExjTWtlcGFqU1pueklmbzZ6L09yU2ZvYmVz?=
 =?utf-8?B?dXEyS1pqeGZUckpsZXdSTTVjSzkwc3EycEtRdkpZa1huWEZmQ2c4MEltNEJy?=
 =?utf-8?B?QUwzSEhHZ3NmbFh3WHBEWTV6clNPalkzajZqbVBxSWNpOWl2RkZuSjBETEVD?=
 =?utf-8?B?UTJZK0pMb2dEQWVkbmEzTFo5ZTlORG5KU0U3eXltQmpndGtGWlRSUndzUDE0?=
 =?utf-8?B?b1BiYUNnMVQ3N1Frdk5pdU4wSXZzRHZuWlYwTll6RUJneHhYbjUyRlNGTTV6?=
 =?utf-8?B?d3JMdyt0bUJZeWxtZUtMcFF3TklZWkducDBRcnpKdlNXV3N6czVUeEU4d3Z3?=
 =?utf-8?B?Q1lITW5KajdpdGE0Kzg1bmUzcFphdHBOMGNzckJqT0pyWTlEa25QNnpLZG1i?=
 =?utf-8?B?aDFhRWMrODNNdEZzZUNMMDlMWVdvTTFLRWtHT0xXdDV1R01Lay9rLzZKbllN?=
 =?utf-8?B?WVNsOVl1dmM1S2MxOUdXYm5pOXBpdW1NeG5FSTdrMWh5MUNtSldxclpEbm8z?=
 =?utf-8?B?S1l2bkR0SjJteTZZdEdpT2tLWFZGRTZ5UkkwcVY5K1JLQmtmaDkvckxVazRD?=
 =?utf-8?Q?FAUOTXl9FJhwzom7Kxx48vkUxjZuuXPqdCIbd/S?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f1f41b-19a2-4189-01bf-08d982f0f07e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 02:29:18.5330 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Fx33jgAfGGA4fq6MWfwjgVBkdqC9XMVIeK2d8A/6FyjpnYoc8SSYNOdm4A3J8Az91kmK/bhLUk6CqOM/6Bo+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Wednesday, September 29, 2021 10:22 AM
> 
> On 9/28/21 10:07 PM, Jason Gunthorpe wrote:
> > On Tue, Sep 28, 2021 at 09:35:05PM +0800, Lu Baolu wrote:
> >> Another issue is, when putting a device into user-dma mode, all devices
> >> belonging to the same iommu group shouldn't be bound with a kernel-
> dma
> >> driver. Kevin's prototype checks this by READ_ONCE(dev->driver). This is
> >> not lock safe as discussed below,
> >>
> >> https://lore.kernel.org/linux-
> iommu/20210927130935.GZ964074@nvidia.com/
> >>
> >> Any guidance on this?
> >
> > Something like this?
> >
> >
> > int iommu_set_device_dma_owner(struct device *dev, enum
> device_dma_owner mode,
> > 			       struct file *user_owner)
> > {
> > 	struct iommu_group *group = group_from_dev(dev);
> >
> > 	spin_lock(&iommu_group->dma_owner_lock);
> > 	switch (mode) {
> > 		case DMA_OWNER_KERNEL:
> > 			if (iommu_group-
> >dma_users[DMA_OWNER_USERSPACE])
> > 				return -EBUSY;
> > 			break;
> > 		case DMA_OWNER_SHARED:
> > 			break;
> > 		case DMA_OWNER_USERSPACE:
> > 			if (iommu_group-
> >dma_users[DMA_OWNER_KERNEL])
> > 				return -EBUSY;
> > 			if (iommu_group->dma_owner_file != user_owner) {
> > 				if (iommu_group-
> >dma_users[DMA_OWNER_USERSPACE])
> > 					return -EPERM;
> > 				get_file(user_owner);
> > 				iommu_group->dma_owner_file =
> user_owner;
> > 			}
> > 			break;
> > 		default:
> > 			spin_unlock(&iommu_group->dma_owner_lock);
> > 			return -EINVAL;
> > 	}
> > 	iommu_group->dma_users[mode]++;
> > 	spin_unlock(&iommu_group->dma_owner_lock);
> > 	return 0;
> > }
> >
> > int iommu_release_device_dma_owner(struct device *dev,
> > 				   enum device_dma_owner mode)
> > {
> > 	struct iommu_group *group = group_from_dev(dev);
> >
> > 	spin_lock(&iommu_group->dma_owner_lock);
> > 	if (WARN_ON(!iommu_group->dma_users[mode]))
> > 		goto err_unlock;
> > 	if (!iommu_group->dma_users[mode]--) {
> > 		if (mode == DMA_OWNER_USERSPACE) {
> > 			fput(iommu_group->dma_owner_file);
> > 			iommu_group->dma_owner_file = NULL;
> > 		}
> > 	}
> > err_unlock:
> > 	spin_unlock(&iommu_group->dma_owner_lock);
> > }
> >
> >
> > Where, the driver core does before probe:
> >
> >     iommu_set_device_dma_owner(dev, DMA_OWNER_KERNEL, NULL)
> >
> > pci_stub/etc does in their probe func:
> >
> >     iommu_set_device_dma_owner(dev, DMA_OWNER_SHARED, NULL)
> >
> > And vfio/iommfd does when a struct vfio_device FD is attached:
> >
> >     iommu_set_device_dma_owner(dev, DMA_OWNER_USERSPACE,
> group_file/iommu_file)
> 
> Really good design. It also helps alleviating some pains elsewhere in
> the iommu core.
> 
> Just a nit comment, we also need DMA_OWNER_NONE which will be set
> when
> the driver core unbinds the driver from the device.
> 

Not necessarily. NONE is represented by none of dma_user[mode]
is valid.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
