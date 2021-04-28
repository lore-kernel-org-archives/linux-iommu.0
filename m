Return-Path: <SRS0=OzJ+=JZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F44C433ED
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 06:58:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B9E610F7
	for <iommu@archiver.kernel.org>; Wed, 28 Apr 2021 06:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B9E610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 237354027A;
	Wed, 28 Apr 2021 06:58:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2D9iTyaJEAii; Wed, 28 Apr 2021 06:58:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC48D4020F;
	Wed, 28 Apr 2021 06:58:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD48CC001C;
	Wed, 28 Apr 2021 06:58:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B411C0001
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 06:58:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F2CD94027A
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 06:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YmXRaAKoEX8j for <iommu@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 06:58:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28A934020F
 for <iommu@lists.linux-foundation.org>; Wed, 28 Apr 2021 06:58:27 +0000 (UTC)
IronPort-SDR: qh2/KK8b9405HsSiPegVjba2rKtN+pzW0nD586dqo2VLw9L3HPeJzpbzO2gz2dnEJDAxPJUNIE
 EGHYCkc8aXuA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="183816027"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; d="scan'208";a="183816027"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2021 23:58:26 -0700
IronPort-SDR: FfN5exNlnxjQRMzb1VhsLERGNwda5RDbZwhw7OoRG+oM81TTHd3cmVos34CEni3pUpzAI6wzJy
 sO70kO6KSUvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; d="scan'208";a="465792456"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP; 27 Apr 2021 23:58:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Apr 2021 23:58:25 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Apr 2021 23:58:24 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 27 Apr 2021 23:58:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 27 Apr 2021 23:58:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6e+gO/u0INYHowPIla2qA8iWuE8BA90YgIhx9lgkwZbC267zwEBUg7L2oLhUHHO9edYIDOEg4rrnPpLrDJ78si8gG0olgneg+XnuI/dgRnn2/F3UCiYhFvrohXbfc7SRvLQ3WcWq5qTaFVg9KWtIDEpXKX3KbFxR4dfhG3YPr+ZlxuQq3INgnHL/wKFn9XlFrnGSaqYKOyE4KgvliUfuJFroLGK6q/XnkGJL+iYy5YMJOiCb4p8iwnZ10Q73RvL/m/K60VqVEStcejs1vqEHit4kL15dBmRlMXSD3/mD00SQLW3o+qSsXsbMpcFy0N7zJqTOulgweqbCb+sv5x8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCkC3H9KVnRyH2B2gFhztpBmeG7E9L+T37fDrS9qaLM=;
 b=MVOGiGMea7EUco3o63zLlxTBikPyfnEtPiZta9xZwVKDPVF3BVc0A8BoovWC0r3XsCir4fVf9E0hbZvNfRJYS2H5/BKrDGSqI3k/obbIjyBITjnjPnB8dEYcRVNmecVMNAaPjTK+I/+8lNRxUAoxVoPLyVdSfmAwujFlTIGojFVAcUIGLcsaVrInj6KiCu5Z9ZJANeDMIE74YQnn+r5rocVSd3ErRsFCT6S2M7oKTFTEIJIa6Ex9/FEJgLv/I8GOr0MfQbNCBUCUnha6SKRU/dR7JN3HxmqFV3e7ofreOdZZw4OlXFoKdZ0JothAjKPGVkUrIFoAnR6tGyTxLmHt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCkC3H9KVnRyH2B2gFhztpBmeG7E9L+T37fDrS9qaLM=;
 b=CHbkdlKSlIvvUruXzMRuL+HLnxBRrZRcsLsh/LTKcSWWk9U8cp/sK9aN/z7jkcWrJpKh7g53/105s56pbnoTfTjBvqM8CU5NPeaQEyr3Dvg8df5vrtlNA6ZeJj0kdyaqbj7lsKLye9GW0YoK0Cm/PKD5Zf9yUZSdr0hr9NgJFQY=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2224.namprd11.prod.outlook.com (2603:10b6:301:52::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 06:58:21 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 06:58:20 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIABMLWAgAAMMYCAABwXgIAABlIAgAAsEgCAABE9AIAGpToAgADKIACAAOE64A==
Date: Wed, 28 Apr 2021 06:58:19 +0000
Message-ID: <MWHPR11MB1886F0818D30329172C420758C409@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210421175203.GN1370958@nvidia.com>
 <20210421133312.15307c44@redhat.com> <20210421230301.GP1370958@nvidia.com>
 <20210422111337.6ac3624d@redhat.com> <20210422175715.GA1370958@nvidia.com>
 <20210422133747.23322269@redhat.com> <20210422200024.GC1370958@nvidia.com>
 <20210422163808.2d173225@redhat.com> <20210422233950.GD1370958@nvidia.com>
 <YIecXkaEGNgICePO@yekko.fritz.box> <20210427171212.GD1370958@nvidia.com>
In-Reply-To: <20210427171212.GD1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfd68d45-33a6-4045-e59c-08d90a130208
x-ms-traffictypediagnostic: MWHPR1101MB2224:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB22242076758BC9464E43BC378C409@MWHPR1101MB2224.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6sNydbla6QF2z/FQoPu1thYXjj63x4NZN8DI0gekss9RMja3fvqabhTSzLj1oT53Jdk5CTArA+MRgDjtJseyGeRzq+UeXLxfow3oiEUVpm7D8hbG5YxSLmUjRkCZR9JLIoW2Bz5TSUbUqZSAcCrQvkGw+MD8LoOYaN2tmCV7lg4w00/sPLNbiTYzYC7U4POR9YGVXs0W6jAOEmXQ0YD/nQAYP8zZIIT0cToDbbSMqjkWRaGNj5lWTL11wFyIkJ0BrXxIA7BJ2hrs6sRBvbqKiky3PRfrooCO2/GbXIs8Q1Z6UGbeZigPMWyIlbNX6Ye8yKB8YodNWVWU059mmKiC9ToJ5urkoHA3Hagbi13MTn/NUTGNpgWUjbTxcMooZaMX+isNWJj9TUk7fMTjIcIaLPotXR4FqqjoXD5xFKu2rKC1VOzkfK/uHndpB5gAu3vTc5LyapYEVkKrsPJEFZt05L3EruVjz2xY/vqJUyvuMn3bjZaCzuomuh5AgCo2Oh0DKuPHeuAE7ACtGdygInuTWLc8oWs3hysDQFums3V6jL3giQ0erH74gQMTccq1/RvpDXidh5XAJysaigAoMRrkhPZVzK2vPu9JskqprYtKGLJGIa3A/JioiSEPRdSlR/t4SGXhR0SGtUvrB6klWBckw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(366004)(136003)(39860400002)(396003)(376002)(7416002)(38100700002)(9686003)(478600001)(26005)(7696005)(186003)(64756008)(33656002)(66446008)(66946007)(6506007)(122000001)(76116006)(5660300002)(316002)(66556008)(55016002)(8676002)(110136005)(66476007)(54906003)(83380400001)(8936002)(71200400001)(4326008)(2906002)(86362001)(52536014)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oRxqPOxSwKQ4quAvoSvYZmv8EfNZdR+eZPu8i+CUOGF1CEdGAdg2fOCRtN8U?=
 =?us-ascii?Q?JmSxV9QIV1XEBGAHw9gWooHaX3lV5INXvxBXS7ne0ucULOV7P3b76KaiFrg8?=
 =?us-ascii?Q?XumiJ7PWJpcNLErS4pQuZHN+MwIf1hZecGlxgt2wOkyTD69uY/YNLzbpNdYS?=
 =?us-ascii?Q?HpojDHSm9vIg7Vpdq579/XJ0Ek9b9fCxPd9v+LiXAKmCTFjqOQhyuccCipMX?=
 =?us-ascii?Q?snifG00FxIFuWWz3yFOSFk1w+Q3Ckp9TuJgqyfn6xQSMTI2EdZo0CnvNCPHh?=
 =?us-ascii?Q?Ycv/1XztGesmFCYUPopwVskcHoGKygR4oy5GXlBBAz14oFSt7Un4WTjU8biI?=
 =?us-ascii?Q?GTU5gl9Z5U8ZMvO8XhwbQFlt5JFnfEDPOX0Pyw34wJpEKkMT2s1+0fMYVPWm?=
 =?us-ascii?Q?GDmLkalezkWZ1i+HTN9xkeU60fNNJJElCTn+5Ea4p/Ty3ywxqtd7Yvis3TBt?=
 =?us-ascii?Q?3Z8e3bKJ7N/qcvLbuijf/NkWPzL4GvVMr5txfcmaIn8ABhzo8OXNj10H7FTN?=
 =?us-ascii?Q?qT5ETs+NkAi32Iuxe9t2Ez1oTXFBBO6OEDKO390CCCnFnBldZejqWnQCK5Um?=
 =?us-ascii?Q?kUB0+HnF4GTFappaHV8WKQdef+bXos9bFMW/Wfl0VDDCzkMzN+Fs/xJiWF+2?=
 =?us-ascii?Q?Prxd2H26D9Wmh1m+ZUGbeuDowjK9QzjH9nCLiKliY2Kh6Khk9HHw0cwEFinT?=
 =?us-ascii?Q?SEQcd8rDncuj5ZZWoLr7bu2+qYa+A247qw+1VtanKnxe0E285SYgiZUw8muR?=
 =?us-ascii?Q?K15/IVSFSU8mchYXKIz+jk7Q8++vp76BwGRSMXodxUflgVijOQjtLvbO1POV?=
 =?us-ascii?Q?A3+h6UZrN8eqsJci9jU/qhKiFCG39bkvgALRQVjL2RJ4pZ/QG3OE3UsHeID8?=
 =?us-ascii?Q?H9983HZYyr5nNcUU7bhAdSRSqW8gP6PySG3pWhPQ/5/+EPTEv8krKoHwm8mH?=
 =?us-ascii?Q?scY5iUwnqZiNqW4IFWmOuo+T0Afht/FiplZVdiIqvdleTuipRIViNNlzXj1H?=
 =?us-ascii?Q?KV0zeFKmx29GtA5+l6w6hXl2hJU08k8bNqZh5FgG6ZAL36LkyZbLSth7JNEL?=
 =?us-ascii?Q?Creg+Rg9ZGK/neo6ZRIqNnIV69TwBdXPYnFw51ky48zCcAWEVNoTpMPS7/uH?=
 =?us-ascii?Q?PW44Sq1X9w+Nh569WSRSOzB+kHz6UsYdGZsUkpUFgN+BQ5eA07RlDvb9/BeO?=
 =?us-ascii?Q?VP2QVUu7zyef3TcL3GMtG25PwfXHITnMJTq6N5BrQoS0WvqhR4mqFYYnzyQ3?=
 =?us-ascii?Q?TCB/Km5/FrDrceeMJTT2DebUkApv/iir6wtwOlHpY0FXNnZs+2lde6HGbmgm?=
 =?us-ascii?Q?s2lARtYsBRygA8dSlzYA60d/?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd68d45-33a6-4045-e59c-08d90a130208
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 06:58:19.1395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRNKKo3TPkH2KEPWcrwaLSFA8VuwK9qXAHPrQrHpyMBGr1SuhfR1tiWKChBIEViEE3ws8ILGdF4vmES1A5uB5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2224
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Wednesday, April 28, 2021 1:12 AM
> 
[...] 
> > As Alex says, if this line fails because of the group restrictions,
> > that's not great because it's not very obvious what's gone wrong.
> 
> Okay, that is fair, but let's solve that problem directly. For
> instance netlink has been going in the direction of adding a "extack"
> from the kernel which is a descriptive error string. If the failing
> ioctl returned the string:
> 
>   "cannot join this device to the IOASID because device XXX in the
>    same group #10 is in use"
> 
> Would you agree it is now obvious what has gone wrong? In fact would
> you agree this is a lot better user experience than what applications
> do today even though they have the group FD?
> 

Currently all the discussions are around implicit vs. explicit uAPI semantics
on the group restriction. However if we look beyond group the implicit 
semantics might be inevitable when dealing with incompatible iommu
domains. An existing example of iommu incompatibility is IOMMU_
CACHE. In the future there could be other incompatibilities such as 
whether nested translation is supported. In the end the userspace has 
to do some due diligence on understanding iommu topology and attributes 
to decide how many VFIO containers or ioasid fds should be created. It 
does push some burden to userspace but it's difficult to define a group-
like kernel object to enforce such restriction for iommu compatibility. 
Then the best that the kernel can do is to return an informational error 
message in case an incompatible device is attached to the existing domain. 
If this is the perceived way to move forward anyway, I feel that removing 
explicit group FD from uAPI doesn't make userspace worse...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
