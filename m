Return-Path: <SRS0=XPcP=LW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F8CC2B9F4
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 06:45:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0378619A3
	for <iommu@archiver.kernel.org>; Mon, 28 Jun 2021 06:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0378619A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92F5A402A3;
	Mon, 28 Jun 2021 06:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zh8njz40D26w; Mon, 28 Jun 2021 06:45:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2C4C2400ED;
	Mon, 28 Jun 2021 06:45:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E69DFC0010;
	Mon, 28 Jun 2021 06:45:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 354CFC000E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 06:45:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E8304035A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 06:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o63oxYIz8l2Y for <iommu@lists.linux-foundation.org>;
 Mon, 28 Jun 2021 06:45:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B005D402B8
 for <iommu@lists.linux-foundation.org>; Mon, 28 Jun 2021 06:45:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="204890037"
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; d="scan'208";a="204890037"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 23:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,305,1616482800"; d="scan'208";a="557459933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga004.jf.intel.com with ESMTP; 27 Jun 2021 23:45:26 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 27 Jun 2021 23:45:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Sun, 27 Jun 2021 23:45:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Sun, 27 Jun 2021 23:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwgyMeXL5/bjyQacuSDgL/Ft4kp5OrDMdyNxrrVA9MMdloo2wxQdNU7Uqa+fwTa1LN3yyQNnp45hI8Fc//PjI+FfRwDmXsPMfce4rfWCgy6HPyev6KEJvsCDR03oxpgn6XSoJ9FDthr5xG+KcHetzM6vpJ5R5qYbaL/ggw917sXmobtpZPhfQOxrfcfN6gmFLrro8lz1BVknNBY4HVcQ3/1rLm5KlYoUTcMuMDj98lLjz2o33GOcsT57RcJuizUA739z470BDzTIVKtRnIkaTTijPpBYt1QNe6N3Li1vrSYX3mpmPGvSNKPAaRV1vJTgl7EeCUqvR84spD//0eSyFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=putVtxkI7JmrY53+kNdOd93BXL8RUe1E5lkLqOIxx3k=;
 b=OJNwJqBAxBLdhSFvV+b5jAYGStqv7RtwoWlf2GIE/+qAWFs3I/nRjvIhfA7/tQrrwft15ZasSZk0auQFKC+dovavp1g0v3Navloot+cF7FPmdW7cRYVPGDNp0Xu6RCykstetbswzHpjSUjtnG6OIJMtFQWLy/RFg4oMP9gbJLHp3Ka3UJ8qqH/uYcAJv/8blV9l1Fn/aeaYtupzRxjFu158vFEjGqUgZLOUihm2RrNQSyXthFxc7IfIjIl/wf/GukJdobShvU0oHbw4e1bXpUoGYaKywBJmtZvIIPShB2guMIzHz1ZTqjaiXig6+RyJmZWA1i6VzTNIRjMyDKNR3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=putVtxkI7JmrY53+kNdOd93BXL8RUe1E5lkLqOIxx3k=;
 b=D3ha87ja1WbTxZkGhP+wj06XS3kFUZZ2gCYJGmulDqwQqIVHmtj58gL81g8XdR2gRd0RvxIZOYsNgfmJ4uaXNcsxMkUxB9bjwYIQ/QpUgNjTTLygjrCyuwJXGKL3zbUYD6PoTnCUxpCbe82DjNjz/+sm/UXvvDj3YA7cCZAweSQ=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR1101MB2338.namprd11.prod.outlook.com (2603:10b6:404:9c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 06:45:23 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::2539:bbbd:5109:e36a]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::2539:bbbd:5109:e36a%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 06:45:23 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: Plan for /dev/ioasid RFC v2
Thread-Topic: Plan for /dev/ioasid RFC v2
Thread-Index: AddbO/WEUAFl3MPnRsG8exiH8bwEagB7l+uAAACIfoAAAdwYAAADDw6AAAHKgwAAANd4AAAAacwAAAT4QwAAK587AAA0n7GAAAYKlwAADDvuAAAgbLGAAF6lSYAABO0WAAATSRtQAB5ymYAAEyKHQAAmZhSAAAo/ocAAK16TAAAGdqAAACJdiVAAA3a7AAEa314AAD0+zwAAfvU98A==
Date: Mon, 28 Jun 2021 06:45:23 +0000
Message-ID: <BN9PR11MB543382665D34E58155A9593C8C039@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <MWHPR11MB1886239C82D6B66A732830B88C309@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210615101215.4ba67c86.alex.williamson@redhat.com>
 <MWHPR11MB188692A6182B1292FADB3BDB8C0F9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210616133937.59050e1a.alex.williamson@redhat.com>
 <MWHPR11MB18865DF9C50F295820D038798C0E9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210617151452.08beadae.alex.williamson@redhat.com>
 <20210618001956.GA1987166@nvidia.com>
 <MWHPR11MB1886A17124605251DF394E888C0D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210618182306.GI1002214@nvidia.com>
 <BN9PR11MB5433B9C0577CF0BD8EFCC9BC8C069@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210625143616.GT2371267@nvidia.com>
In-Reply-To: <20210625143616.GT2371267@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.143.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c338813-b04f-4d14-aff5-08d93a004e4c
x-ms-traffictypediagnostic: BN6PR1101MB2338:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB2338D116286CB8A2E1C7BCFC8C039@BN6PR1101MB2338.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAPf63ooUrV53xV6KygKKwYZ+7+D5qBYJBoqH4QkyqLbph8JOBA2yUBClpZe6CDxCrCDH+A2klpx3Psnw+8SkTp9adYZ5eWv/p+8a/yxWq6CtxdnoI2TehacGnl4M7G47lSd/iuxTtg4DId5vobRRa/fFX1vlLl+3XYP+qG+3iwJRGJXHlio7G+ddkwgHwDgNMUGjdgK6xzUZK1wgpGUSp4z4a44N6/c/RUlMJh2al58WJmEhvamwc/4NNlXxThSCFBxjZTktSMF+zwuAf1ubtcOXEOvS0gj5UX+jum2s2UxCeQOEuWoaRmBr9gYoWDbRteQIoWyUsji6rBmxS0jNubm+T4VoYi62a7x5bRyb/7zniLUNIt9cipRi3btN6Ba8VcWo6fHw8MrMbIV2gFOSkeIYAkUIXvgyw1NcpeZ1yfdMuKDW6MSS22519oFx+c70lLHRCUu5b83/mNS/uFz+0bC6JCsbe0EdRzSuY4PRWlTmpEjjGVX4vIy5En97cVO1I2XezctgYhv8AxDKYRrNSDGSOCi3fQD1z1Ly/uR9hcZwnSULerUB3o53Bx9osge7ZJEJhgRpsebE+GaoGzICetV9si6umYljAtk3fBlHYE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(39860400002)(376002)(396003)(346002)(136003)(66446008)(6916009)(64756008)(52536014)(71200400001)(66476007)(26005)(66946007)(66556008)(122000001)(55016002)(76116006)(33656002)(186003)(6506007)(9686003)(83380400001)(8936002)(7696005)(8676002)(86362001)(38100700002)(2906002)(5660300002)(4326008)(7416002)(478600001)(54906003)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oq6k0wcs6u4hkuJiFiS8t+qp0m8NUnr1ZVHh9I+W4PIpA6RdYkRQfhcMBAFh?=
 =?us-ascii?Q?X/c1b9qLVLQLXGs/mApJsNvZOH7OYbQIjj7SOogdlaicYuIulZ3RBbLMqZ88?=
 =?us-ascii?Q?z9O8sqQmLajBuRNXoLzn8usNp/VP9dH8ZK9QD10mOkMM4lZUQjDzzkT3RqcZ?=
 =?us-ascii?Q?4JVu9YxjEDNq+BngLEDAPYT5zpb1+QaXJupz/8S0H16E5PJLVmryQ9TDvpZ/?=
 =?us-ascii?Q?Gy9siuKJ9RyTMYpySTYyh1Xi9fULegB6eQ77TkT7fLFg+n/Bs+ZEjxisjYiO?=
 =?us-ascii?Q?hZj3KOTQAaeiNjMmTc6fL8kwILlq+E24+o3Kj8gqyVAJjtrlcRaOfnpT8oKQ?=
 =?us-ascii?Q?vXDdU5Pn3x3T3vmQehShTX1UiEO0iR5V3oPNA1/ktu9IeXvwEqvVp2or777i?=
 =?us-ascii?Q?D0NObLo2JH+L3Z+PTq+X6GKR66vRdIQ3zRJ91Fsa1cEzlETLRcvWd3y2rAfw?=
 =?us-ascii?Q?+7NBeHlehC+RbQqa2UuN61SfTo5Dt6Hnk+HwF4537TpK/wp64a4VnsuM/Ruh?=
 =?us-ascii?Q?CsVmwHvMjDoNPE1ltyN3CcTEt8BRdmo/vJAiNrr3NmrBh1JEsaW4RfPcNNIZ?=
 =?us-ascii?Q?g+FNXoU4ojXhUqKutUD9p6ggY8bSkV732l9X2cs6AfXYsLwS6xwufzFIe4Uj?=
 =?us-ascii?Q?yf5W5W0+HhU6Nm0Vu1XzM/xjneB1EtnPv8+k9RbNRwSx1TB0uYkIDZYC+bJL?=
 =?us-ascii?Q?ek7/wJ/GlTkvxYcGbDobvXp1wEwd0RJQq8hv97qiYDLukv1+XWDuW5QtAhep?=
 =?us-ascii?Q?jhfErHWPTRF7Z4wI4yI7U8O2a0FkYi36LV33xXzirMGF2PA4665Y+nAvr9oA?=
 =?us-ascii?Q?xR2IzE4vG8zwbuDEfrhKcXjm8KQm37D+XykiE1cyZ4Tq7S79xFTCX8Mf+ydD?=
 =?us-ascii?Q?KtNDm98Xyfs3hc1KJ/PFkkd4ISLpnVY5kVTy3novZEj7DQCcZ66rH/22dBF6?=
 =?us-ascii?Q?74AecOAW67XMzYUoPRVOlRPLb+SYGnzy3k/2KKctGS0qvXWSiPAP5HmDOIy6?=
 =?us-ascii?Q?JUUdZPBz0Jm6OaKwOxZpsS82YW7QHaZV42tGXPJaubbU9wE0Fuxzy5oO4DLy?=
 =?us-ascii?Q?c4Yz8liexNzFai9MYhjKtdT9Zyi4uHUMED1dBz7O9RnaU6yF83EJSA+6oKTB?=
 =?us-ascii?Q?z5DLjnI/Tn3/93FikHTG92er+oUyNUMy1T/QbVzAiAZCTu8qA6pm8yJ9dmsi?=
 =?us-ascii?Q?VsOSL1aq/XuwqqPtZmKc8y8FFsfh3i2Wn4d6YZ7pwPeDs5Fwa+5XVqsOHY7M?=
 =?us-ascii?Q?Evxjf6Zf5+hQCHEecSUr1pGyZbKYiXV8Zsth7rwWVVqXcardE5NePkNyE8TS?=
 =?us-ascii?Q?2becw7Kn1yzGHOHoTRfAspD8?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c338813-b04f-4d14-aff5-08d93a004e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2021 06:45:23.6809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVeZAFuno42Rs+vvy+Naj+KQ0htIPdfQpJ2QjGemnWl19iXVa0Uekf9XSB7ayM1ldMcULckTTG21YKJHfU/YQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2338
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 David Gibson <david@gibson.dropbear.id.au>,
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, June 25, 2021 10:36 PM
> 
> On Fri, Jun 25, 2021 at 10:27:18AM +0000, Tian, Kevin wrote:
> 
> > -   When receiving the binding call for the 1st device in a group, iommu_fd
> >     calls iommu_group_set_block_dma(group, dev->driver) which does
> >     several things:
> 
> The whole problem here is trying to match this new world where we want
> devices to be in charge of their own IOMMU configuration and the old
> world where groups are in charge.
> 
> Inserting the group fd and then calling a device-centric
> VFIO_GROUP_GET_DEVICE_FD_NEW doesn't solve this conflict, and isn't
> necessary. We can always get the group back from the device at any
> point in the sequence do to a group wide operation.
> 
> What I saw as the appeal of the sort of idea was to just completely
> leave all the difficult multi-device-group scenarios behind on the old
> group centric API and then we don't have to deal with them at all, or
> least not right away.
> 
> I'd see some progression where iommu_fd only works with 1:1 groups at
> the start. Other scenarios continue with the old API.
> 
> Then maybe groups where all devices use the same IOASID.
> 
> Then 1:N groups if the source device is reliably identifiable, this
> requires iommu subystem work to attach domains to sub-group objects -
> not sure it is worthwhile.
> 
> But at least we can talk about each step with well thought out patches
> 
> The only thing that needs to be done to get the 1:1 step is to broadly
> define how the other two cases will work so we don't get into trouble
> and set some way to exclude the problematic cases from even getting to
> iommu_fd in the first place.
> 
> For instance if we go ahead and create /dev/vfio/device nodes we could
> do this only if the group was 1:1, otherwise the group cdev has to be
> used, along with its API.
> 

Thinking more along your direction, here is an updated sketch:

[Stage-1]

Multi-devices group (1:N) is handled by existing vfio group fd and 
vfio_iommu_type1 driver.

Singleton group (1:1) is handled via a new device-centric protocol:

1)   /dev/vfio/device nodes are created for devices in singleton group
       or devices w/o group (mdev)

2)   user gets iommu_fd by open("/dev/iommu"). A default block_dma
       domain is created per iommu_fd (or globally) with an empty I/O 
       page table. 

3)   iommu_fd reports that only 1:1 group is supported

4)   user gets device_fd by open("/dev/vfio/device"). At this point
       mmap() should be blocked since a security context hasn't been 
       established for this fd. This could be done by returning an error 
       (EACCESS or EAGAIN?), or succeeding w/o actually setting up the 
       mapping.

5)   user requests to bind device_fd to iommu_fd which verifies the 
       group is not 1:N (for mdev the check is on the parent device). 
       Successful binding automatically attaches the device to the block_
       dma domain via iommu_attach_group(). From now on the user is 
       permitted to access the device. If mmap() in 3) is allowed, vfio 
       actually sets up the MMIO mapping at this point.

6)   before the device is unbound from iommu_fd, it is always in a 
       security context. Attaching/detaching just switches the security
       context between the block_dma domain and an ioasid domain.

7)   Unbinding detaches the device from the block_dma domain and
       re-attach it to the default domain. From now on the user should 
       be denied from accessing the device. vfio should tear down the
       MMIO mapping at this point.

[Stage-2]

Both 1:1 and 1:N groups are handled via the new device-centric protocol. 
Old vfio uAPI is kept for legacy applications. All devices in the same group 
must share the same I/O address space.

A key difference from stage-1 is the additional check on group viability:

1)   vfio creates /dev/vfio/device nodes for all devices

2)   Same as stage-1 for getting iommu_fd

3)   iommu_fd reports that both 1:1 and 1:N groups are supported

4)   Same as stage-1 for getting device_fd 

5)   when receiving the binding call for the 1st device in a group, iommu
       fd does several things:

        a) Identify the group of this device and check group viability. A group 
            is viable only when all devices in the group are in one of below states:

                * driver-less
                * bound to a driver which is same as the one which does the
                   binding call (vfio in this case)
                * bound to an otherwise allowed driver (which indicates that it
                   is safe for iommu_fd usage around probe())

        b) Attach all devices in the group to the block_dma domain, via existing
             iommu_attach_group().

        c) Register a notifier callback to verifie group viability on IOMMU_GROUP_
            NOTIFY_BOUND_DRIVER event. BUG_ON() might be eliminated if
            we can find a way to deny probe of non-iommu-safe drivers.
                 
        From now on the user is permitted to access the device. Similar to 
        stage-1, vfio may set up the MMIO mapping at this point.

6)   Binding other devices in the same group just succeed

7)   Before the last device in the group is unbound from iommu_fd, all
       devices in the group (even not bound to iommu_fd) switch together 
       between block_dma domain and ioasid domain, initiated by attaching 
       to or detaching from an ioasid.

        a) iommu_fd verifies that all bound devices in the same group must be
            attached to a single IOASID.

        b) the 1st device attach in the group moves the entire group to use 
             the new IOASID domain.

        c) the last device detach moves the entire group back to the block-dma
            domain.

 8)  A device is allowed to be unbound from iommu_fd when other devices
       in the group are still bound. In this case all devices in this group are still
       attached to a security context (block-dma or ioasid). vfio may still zap 
       the mmio mapping (though still in security context) since it doesn't 
       know group in this new flow. The unbound device should not be bound 
       to another driver which could break the group viability.

9)  When user requests to unbind the last device in the group, iommu_fd
      detaches the whole group from the block-dma domain. All mmio mappings
      must be zapped immediately. Devices in the group are re-attached to 
      the default domain from now on (not safe for user to access).

[Stage-3]

It's still an open whether we want to further allow devices within a group 
attached to different IOASIDs in case that the source devices are reliably 
identifiable. This is an usage not supported by existing vfio and might be
not worthwhile due to improved isolation over time.

When it's required, iommu layer has to create sub-group objects and 
expose the sub-group topology to userspace. In the meantime, iommu 
API will be extended to allow sub-group attach/detach operations. 

In this case, there is no much difference in stage-2 flow. iommu_fd just
needs to understand the sub-group topology when allowing a group of
devices attached to different IOASIDs. The key is still to enforce that 
the entire group is in iommu_fd managed security contexts (block-dma or 
ioasid) as long as one or more devices in the group are still bound to it.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
