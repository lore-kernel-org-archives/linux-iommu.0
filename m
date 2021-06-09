Return-Path: <SRS0=g+Up=LD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF9C47095
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:43:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68D07613AD
	for <iommu@archiver.kernel.org>; Wed,  9 Jun 2021 09:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68D07613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25199404DA;
	Wed,  9 Jun 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SK7moiW7CLHG; Wed,  9 Jun 2021 09:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B34D5404D8;
	Wed,  9 Jun 2021 09:43:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BFE7C000E;
	Wed,  9 Jun 2021 09:43:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F0FC000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FFE683C0E
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kj0KvWZSS4He for <iommu@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 09:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0AC0C83C0B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Jun 2021 09:43:47 +0000 (UTC)
IronPort-SDR: h0Dn2P7FkiToiZ+2msXgzDMHjYoaDyibzO/d3JpiQgrg6f7ZMOJjOM0DmMl6UxLvth0l+P21sz
 5XwIs0h7S+qA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192149712"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="192149712"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 02:43:46 -0700
IronPort-SDR: wVbLfh9aWFL2/9GfBxHpYZmEEAV7tEylRLv/fqb0YV3dQ726YsntZpwpFP0NDxQehJmMxoO15D
 4ENmL9/KJgng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; d="scan'208";a="476905397"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2021 02:43:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 02:43:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 9 Jun 2021 02:43:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 9 Jun 2021 02:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjN5z69gDJtuFw1w0ByYlasmyXt9oeI6uF+LKrMCzR9L3e5+3rtP+BOqeESDKcS5tVVd1m8WDfx1gjn6agF8Xbab+X5V9iIdhUV0QLZHENZLZN2y5RcWg+OEGc0BPjonKD6N7Gxk41JINzdFZx8EYdrg5/oXN8PPoFa7J8jWOLj0xNaSWagkId4bT9jyXQGYlzDcglM7q0wYpB9kaCIdvsWSTkpRB8H87tYb8wN3ilzLDcYLF1gjMEwjM7UHFeJZDDw42gb6xzuJyLy1KdT+PQ5I/wP7s4591DChdeXXhE2dj8rrH3aDwSlwGW5CCv+mmx2uGssI7lCEdIpuZlHedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EQSxn5Devqi0B3HE1BkOKWkPhN/iNL5WsRQ9e/2nRQ=;
 b=d/aSeMVLK1iWKgMamNOf7th8ezsbVcP7yXVdnztWox4vAqsbPpcygitAWIchiFhOV+oxbFjvo71OdP//a74GGzemZfT4lcjQXLdhdEPlQ/R86DFLNlwD1W9842IVjFOLLnHBhLrmwpDicD3vbWKqnAJBgpz7Bxije4mnOCNxvqDt/0Bes2S5ku2/FnVQDuKqzbinJWU+w5I165BSncCtXMi6s7riZG8XZW6MPxVOxoTDmq7+6Bu86cbCIBxEHbfrYM5ueZFzHkh+XphfGM17/olXu6SOrFv3xcUEPojYUFpYAyRqZqTxGtoxVtZ2mjIAfgzuMaWyWGnfHyQlpaVLqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EQSxn5Devqi0B3HE1BkOKWkPhN/iNL5WsRQ9e/2nRQ=;
 b=rbZE+daIEoXLLO6AmOxU6G9PUhDe3XDLzbROUdd8f+ujyTdjdALsK7ESuCvgrX4oNknvKU1gLOljtIsuZX25HB1bs5IoF2l08UC+V4LZ2uT7jAwuMAwa8dLoERCH1vbGvwruXQsO1YuAwOxnmRhQr1xfu12c/ynMpuXVNzxqLj4=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2224.namprd11.prod.outlook.com (2603:10b6:301:52::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 09:43:43 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::6597:eb05:c507:c6c1%12]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 09:43:43 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: RE: Plan for /dev/ioasid RFC v2
Thread-Topic: Plan for /dev/ioasid RFC v2
Thread-Index: AddbO/WEUAFl3MPnRsG8exiH8bwEagB0h8+AAAFDh8A=
Date: Wed, 9 Jun 2021 09:43:42 +0000
Message-ID: <MWHPR11MB18860C8052D73508CF023AD28C369@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <MWHPR11MB188699D0B9C10EB51686C4138C389@MWHPR11MB1886.namprd11.prod.outlook.com>
 <YMCDfWLw6r80Wdu3@unreal>
In-Reply-To: <YMCDfWLw6r80Wdu3@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.80.65.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08d0a2d9-3973-4c2a-0968-08d92b2b11d6
x-ms-traffictypediagnostic: MWHPR1101MB2224:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2224A6547F7B72F3EC9145F38C369@MWHPR1101MB2224.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uzak13duy7JfTDaZUEiMTslr6qu/PF/rQ7KNSCWTqm4WXyrQtGrpXDAPQO+xQ4bGIj6hFaJitwDSDxo8XfRpCsH66I5dCRtNrDL+V/E29si5HqH/K3nvHE/ocZb+8zbAzpncmhJ26AGPzF+M+mMGM6cgH3uZzysnOWNo9O+hoMHfqEgF2fZP+D39AV6mRDewd2LHoA4bNm+mnYVq6FOssMgJ2hLAou615qdbr90usJCh+QZbvJwf7IAfPbAGYLoinvI7jLCK0EYphIRgyc1qpAZJzzEtRNFteEBCXIUOXJWs+lx17BOlJDxS+dnuR0o07FUOvgunP1WsdLNjU1VbFyBG9jEpYYLMkRVSzEWZy5HIh7P7W4jWEAHN9etmhEjcxcgxUJ5EMLH6te4S2veSN7VZdoyxyiKvzrX3IYTHGVJVC6Ma4oKf2zBbkMu1PtjDTxS8Aabje+AW01cGRbncoeiOT1nbUFxUcYNQvXyh+UEltlxWnOLCTQIAVXBoWbFdGVx1CXz9pq+AmDz/XPoj29bAK/3JufOJmghsl7GBGfnl9g2Q2sUem/MMMcOAoQ2DlCi3ekSFWMU260eJAJtss382h3YVftVFImuAmOZlLPo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(26005)(186003)(83380400001)(54906003)(7696005)(316002)(86362001)(6506007)(55016002)(2906002)(66476007)(66556008)(64756008)(66446008)(66946007)(478600001)(76116006)(6916009)(33656002)(52536014)(5660300002)(122000001)(8676002)(7416002)(4326008)(8936002)(38100700002)(71200400001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kLAdEExpfYzex+MBTBlkhmtqhWiJBpIJJ+cZhQ5JO0ACwuNSTAQAIPI0Giwf?=
 =?us-ascii?Q?AsygfYFdabA4iUFaqyLFP4RlEHSUXQF19HdmWFZGwuZNqFYHdKouP/A6fJhB?=
 =?us-ascii?Q?Sh+iFOzk0RUrz1tx2uzTMPsS4PKFSoKovVqKcA+eYInxlyqxsKGrCUY8HEll?=
 =?us-ascii?Q?7oasYhaKQCMaNT28W4NkZqHtgYY0yYjexMi84VAuwRXkF3DUye1fViZhvR0S?=
 =?us-ascii?Q?aLeR1OsBxKy0G2+eyQ7V/crltJjrBfEqv99aeiT8uwdajqJFEh9Rjfta72b8?=
 =?us-ascii?Q?ePZ/q5be59uJ+oR07TNz2vb6RdEv3+Zjpqxpjj49mKxnSmdl8eZ+spMqL75q?=
 =?us-ascii?Q?wMisZfHtahL/6M6GhyP/mcgA9BNGIXWVN0d9o5Wv5ICrB1m3IUwyoyrg4VDb?=
 =?us-ascii?Q?C4BRlMxlvuhhEGPF44zp5J0PyH4htu1KsoEhiv2mwCXQWAS05x5YlNZ0KJRl?=
 =?us-ascii?Q?9Qq1yLQcLlwsbxHzyXOsFxTc/j0IvLvZ+55pORpyjnqVxATdI9ByWN5m80gX?=
 =?us-ascii?Q?Yec2Ft12Z/jpFIDISIGzn94yu7WKqMfRmOT5x8GxvPNLpo5NsFaHVoh+fZPf?=
 =?us-ascii?Q?SAzds0dOPw3jgevsGUxR/Dr/gg9fuAi7DU0sZf0Psg5UhqCU5gx8xUKFTEB0?=
 =?us-ascii?Q?iTeHxdlAj61mmyIOwIz1gwuUIeK3a1z/GFd85mLfwERewu26mSLtanwxMl/7?=
 =?us-ascii?Q?g4eHWHS3dCeE2qSkaRaSSJnVF0L0UhtuVK7kPuXC+DTCZex0eRv8KSwF7jQc?=
 =?us-ascii?Q?4O77au+lrwDBOnDNlflDbjdMjcoJRUmNhW62s0DeYjtM2MGkHJ79jxGwWGcp?=
 =?us-ascii?Q?moz4vG0M++Vm3PMxc7ThXLF4NGplx+hVFimaOdbCD34502QMYcYipBD2eAJD?=
 =?us-ascii?Q?RTC5NGtjm95pXEc7BSXSFj1SbrvqCexEebRl6gV2+4ctqkygNzSh/K//2GoG?=
 =?us-ascii?Q?C46ocoOnbFTlqwewrxvcDnWAhgv+AI6Gk1Uo7ky9fPz1/sGXUWn9TqLImelf?=
 =?us-ascii?Q?p9+xFMJlsnqVvLVv+nxJn8E7b5ATgsq98Yfy1hqCpE0TkEKFnkfPL4PI7rjs?=
 =?us-ascii?Q?H51rViYObU//gLmm+/m5j7kENi+BV7rjzWoYFszZ6Hlu7PClCujBciAlRRw9?=
 =?us-ascii?Q?uR1HTeOtBnfGb17Z6IzBddINUWO84jTZFOCDB0pgAzlg5oQQaIlBqX3PEsQt?=
 =?us-ascii?Q?yVqTfSOPiRqr79DPJa4S5364hgUBZhIbkY8W0QZMxIKoXnYoLN9WnZM5k+Yj?=
 =?us-ascii?Q?YTdSHz3Ks6LnWxAlGknlBWrd7Sv4RLTl1g17pUKtmiOjsAOqII20Psk2I6UW?=
 =?us-ascii?Q?hns=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d0a2d9-3973-4c2a-0968-08d92b2b11d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 09:43:42.9764 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0HwHjiFrRdIdwWFjZeBAmup8wK/V/qVHUrL570qUcVvWKv3UYjqGb7SCtW5T/IG0LbMqaeykcRqkRnH+lFNeow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2224
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@nvidia.com>, "parav@mellanox.com" <parav@mellanox.com>,
 "Alex Williamson
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

> From: Leon Romanovsky <leon@kernel.org>
> Sent: Wednesday, June 9, 2021 5:02 PM
> 
> On Mon, Jun 07, 2021 at 02:58:18AM +0000, Tian, Kevin wrote:
> > Hi, all,
> 
> <...>
> 
> > (Remaining opens in v1)
> 
> <...>
> 
> > -   Device-centric (Jason) vs. group-centric (David) uAPI. David is not fully
> >     convinced yet. Based on discussion v2 will continue to have ioasid uAPI
> >     being device-centric (but it's fine for vfio to be group-centric). A new
> >     section will be added to elaborate this part;
> 
> <...>
> 
> > (Adopted suggestions)
> 
> <...>
> 
> > -   (Jason) Addition of device label allows per-device capability/format
> >     check before IOASIDs are created. This leads to another major uAPI
> >     change in v2 - specify format info when creating an IOASID (mapping
> >     protocol, nesting, coherent, etc.). User is expected to check per-device
> >     format and then set proper format for IOASID upon to-be-attached
> >     device;
> 
> Sorry for my naive question, I still didn't read all v1 thread and maybe
> the answer is already written, but will ask anyway.
> 
> Doesn't this adopted suggestion to allow device-specific configuration
> actually means that uAPI should be device-centric?
> 
> User already needs to be aware of device, configure it explicitly, maybe
> gracefully clean it later, it looks like not so much left to be group-centric.
> 

Yes, this is what v2 will lean toward. /dev/ioasid reports format info and 
handle IOASID attachment per device. VFIO could still keep its group-
centric uAPI, but in the end it needs bind each device in the group to 
IOASID FD one-by-one. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
