Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64708C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 04:06:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0377460F41
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 04:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0377460F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2754405DF;
	Wed, 28 Jul 2021 04:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGhyQuBbkF3D; Wed, 28 Jul 2021 04:06:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 76779405DC;
	Wed, 28 Jul 2021 04:06:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EE45C0010;
	Wed, 28 Jul 2021 04:06:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E75C0C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 04:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C901B83A43
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 04:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ysrSTkYGUPYo for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 04:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86EB683A41
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 04:05:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="192169351"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; d="scan'208";a="192169351"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2021 21:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; d="scan'208";a="517263166"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2021 21:05:58 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 21:05:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 27 Jul 2021 21:05:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 21:05:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOzpEg63hsN55ZxY0UDi35HF9Zc4JG/RBu1gc0aS0tdonU7HKEVSP2o34FaueUICXqGxHAMO8M8MgIy5/IA3furvAJ8Sj9IuQqLsW+g9UavIi+C0wsQY5zB5UghxRNfpcbD+14P9m8PTJMPQSFx363rcjnBdcp6Dv+cR1ZIMPE02Kvve4DLqeMMA3TdK+/vm0TZLFvBFWY6q3HALt8CD/TnCLLpB0Jnvd4hy2Kyw8n1ZWz/XlLC8L/k1CN3eXBqDPaeI7l6nNDuciMFsb9ON6WN6wkzT3mV3Vpurnbfm2gYeOiXUx6NQrL4vgmMlGTaaXvwjfpsVI4o5ihc3sxTB5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqaFBr7jDo7BSxNbUsq2HAZcFeEHxnuMIJyvK/W6Ngk=;
 b=i9qE9r0ovqpdHGv1YB1rwISwD1H9iz5N5XVW33B76SyAmQcecwgIA0YmSZVYMZCVx/w7Zy22LAb3Vc70DpBsfQifY7Ti0Aii3d1a+VKk7zFJSmEydowXSd5M67Fi1HnriPDUSCiSDiVL9B9zMwJSB3MfXr5NYmjDIoVoImn/GV0ROnkYvnYQUd7GokgTuZnzem/XAolx5xs254Exx1DfzaWp1qMOMPn7Wvw07Tu7DkTwqneoh7XTlTb3poEX8VNBy3V6JpavTJOz+oJz3HWXKL3Wjm9CDvJAA2uVu20OXs5244yw4zo2LM3HFY2xL5+jGbjXlZ9EAigHMaoP1jkLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqaFBr7jDo7BSxNbUsq2HAZcFeEHxnuMIJyvK/W6Ngk=;
 b=pxHscYxv/QPyDcO5Mi0opeo5synaP1EL1l2Pi1vq/yAJBlOidxvhoEXhv2TkPrVRQ76NHY4JDeFBXjCe/kaCYDkGB56F5BGLFgk0QW3dZN1/x7AsvGqGEbDYm8Z8kUdQgPTLXHALaXTlblTD8g4UWxB4A3oPj7Ui0f3di95R5oM=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 04:05:56 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%9]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 04:05:56 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQNX5KMAAFvh8lA=
Date: Wed, 28 Jul 2021 04:05:56 +0000
Message-ID: <BN9PR11MB54337F6363CC350D2985D5008CEA9@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <YP5u7Fk2pylHNGeY@myrica>
In-Reply-To: <YP5u7Fk2pylHNGeY@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eab97b96-d694-48d7-ab5c-08d9517cffef
x-ms-traffictypediagnostic: BN0PR11MB5709:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN0PR11MB5709C4813BF5DCF63DC9A6718CEA9@BN0PR11MB5709.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DcdRQgA4681qRiJvC+yaftk3mWdbbh+uYfW8n0hV3gxIJaydv5GtwC7Dy2T7r2UwyuCdNtOfNR0p52SWYyL3RTX1uOcO1XoRLkhVIsaFaDujnkBdG5ikNLK+IR7aW+ciiNSeglS7cD6HuseU/q++1WH536lMN4U3OcBsdmTgWvZ/lshtq3ICi3uwsfUfBK1SVRthUH9hSU1z/blg+Y8V1igXFCtuFkRMrH9St403ZT01bL8L0LLXqyxZPVkb3y/4Y0opF1/YJ+B0itvQvF10Thiwbc2oPoftUE7ETGnhgKsTzIejPWqVeOMBEtZ2SVubQFmBw0TRHjLTElCoIfFi8fFprmruFEgsN9VT/cUoSo74YZ5/LjXyLbWjKuryIf0y36d+R3DZATu7xPHSnvteS0kCQ9YwlPdLX3h+f/C6KUF1clMuWEMJWGtHOoOM+n/YQboO1ZjY4UBJDBsvl7cIoBLFnDxN6fT+ZxQmv6QvSK17uXEw3Ch8aM4/dDvXljwnKxElEMkAxtwN/96wLSeFGDwGQNIyeq143qDJqGqqDDvppdqt7JjERMduLD3eY3L1BphBIjsgUR/RY5D7JDnTw5fvEj4hogQoS+r0ixdrtHkv6pdy71NSOuPV8Yhm+fERG0Karvamq5alvnZXUYrCjVo+HyHDlqc8pX05ijRbLAQH8+Sugf1JrG1p7pinil5kLKKKshMGrUpzv22DdqCrA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(55016002)(2906002)(9686003)(86362001)(8936002)(4744005)(7416002)(71200400001)(8676002)(4326008)(7696005)(26005)(478600001)(5660300002)(66556008)(6506007)(66476007)(316002)(38100700002)(33656002)(66946007)(6916009)(122000001)(186003)(64756008)(66446008)(52536014)(54906003)(76116006)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ikcL22pvOvIJ7dh4t2qymYbPb+GSCqQMucp9E9vHDuFoF4mZ8MxchDN6jqKl?=
 =?us-ascii?Q?jYXzGqHJhaCgWp1bvmWs0rcb0u+ZIzp7+BOSnpRE19sMELiTtYvLEPmC0u8B?=
 =?us-ascii?Q?mR17yQpgv8qGb+FILAA3KWhqAQelxNQeEzcxF2lxfj79out1+uSgcLgn1PwL?=
 =?us-ascii?Q?KkKxHhJC0OjKZwTFcqxPAXHhE17Vxl1qwcZ0nCLhCZZo40dXX3nhf3vIvFq5?=
 =?us-ascii?Q?SzdmsFRnjeaa6Q4obIAmI7bJq5v+iUr0QY665QxLNWAv8uNo8ixpOZgzai7g?=
 =?us-ascii?Q?t4KwA/fgZrZ7oacqgwT4iBn/f8QXI/yLmHxWDvDsZGNJ9DFlcRKLWID4nz1E?=
 =?us-ascii?Q?hIlNFYs3txycP+qOvZhB2jShNxDj4P8G2obsER6/SxzMya9yAbHoKjDkUp5g?=
 =?us-ascii?Q?jHeQG//MYuAel9sPedTiKgJZUowe+OiA5egzw2biv20EnZ2S5ugi3zLr6bzj?=
 =?us-ascii?Q?ffWMJmvy735CfNCPpgmXL2OjopQWYbH365z93WVItSpOuEt4P1b+VhxW76Cn?=
 =?us-ascii?Q?lDWsbIcGI++sn7xV3nSJ8LaciCyIjEZg8PFlXy09OBuHxzkpPc5+Y/O2t1Rp?=
 =?us-ascii?Q?J6y5qlnx0PL811Acjl6MyCb8C5tcZT330cdjc424DCwz3iG280uVfBcp7IOx?=
 =?us-ascii?Q?vPgT9b07K5n0cbZ92nX05rhwmzhy0VfbjT8tS3maRIsVsp3ncYTGW6X+9sNz?=
 =?us-ascii?Q?wdTFDRUX4mlAlE9p0+HAXbhkrPke55lCFK5RAZSuIt+Q9uq1NN6jrsaMPAco?=
 =?us-ascii?Q?L1UdihfTsMQd4sI+6Lb5Bh7bfTq1uEv8OQnc46wHALD7X+pGNdN5eacP6jIi?=
 =?us-ascii?Q?eDfd4JnZhKowGhtejPgECbw4sjh3J9BIslqZ7trp9SsHLWzNwBXXKFxIG+am?=
 =?us-ascii?Q?Vz+53KjiEpI73yGWskr8jLiv2aoMvhCuvT+BzE9qUJbIn08VfY+lHH47c5F7?=
 =?us-ascii?Q?Hm85iDl8wZt9W9cwzH3Kcy2h8KZA9iK+c1VICdFOyxPqUZQRVhu1Ieaenbmc?=
 =?us-ascii?Q?bl7SJ7Fx5qLt6f+1AyPceltae+49CzZQqQVuWprauNpmBEM7T7yQ7IPUyz4B?=
 =?us-ascii?Q?JcKfcVW8GDBoigkA8/DQuWLNoHWKfp3SSHpQtG56Pgrk6/ePdmdCuOcIejV0?=
 =?us-ascii?Q?4xxSCM8+AbM0LvGWQVhN1EGVhjrjGt4d8Z7wxZ/hAd74Zj7vJZ7SnCTR9eSm?=
 =?us-ascii?Q?ShmRwU5a8Fe4veV6AhlNJ9kOGg+ZaHOnbMRF0qNeFtJesrL+GFh/AwuqkT9g?=
 =?us-ascii?Q?TL2BdNmHx3OHgdXc/Xe5LH5V6brzmGTSV5NDtCYtBbjQRRw4CYkDrU9026NI?=
 =?us-ascii?Q?prMPCRyV5DbyJG5wfW1FVm6F?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab97b96-d694-48d7-ab5c-08d9517cffef
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 04:05:56.0451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DtsQ04hW3uXaFbGfQGe9CqcfRCH3oDXg1r6yyeKI7F2mUgMZR7Fnp+qNuVsDUbgyZu+lJLhiFMLk4JAf2fIrkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5709
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, July 26, 2021 4:15 PM
> 
> Hi Kevin,
> 
> On Fri, Jul 09, 2021 at 07:48:44AM +0000, Tian, Kevin wrote:
> > /dev/iommu provides an unified interface for managing I/O page tables for
> > devices assigned to userspace. Device passthrough frameworks (VFIO,
> vDPA,
> > etc.) are expected to use this interface instead of creating their own logic to
> > isolate untrusted device DMAs initiated by userspace.
> >
> > This proposal describes the uAPI of /dev/iommu and also sample
> sequences
> > with VFIO as example in typical usages. The driver-facing kernel API
> provided
> > by the iommu layer is still TBD, which can be discussed after consensus is
> > made on this uAPI.
> 
> The document looks good to me, I don't have other concerns at the moment
> 

Thanks for your review.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
