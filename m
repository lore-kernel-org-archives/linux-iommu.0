Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC70CC433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 01:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C2B980B64;
	Tue, 10 May 2022 01:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ik0cxeqwsHPP; Tue, 10 May 2022 01:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B02780B55;
	Tue, 10 May 2022 01:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBE63C0032;
	Tue, 10 May 2022 01:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04054C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 01:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8F8240117
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 01:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rQYZsyQAzp7G for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 01:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E8894002B
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652145390; x=1683681390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v5odE9/MZ+vTDnTXEmoS1s0g48US6xj+cz+wZzTwbLk=;
 b=lnossCjIxXQB3Q2PbQfiAc2xvhRjxUPbo/Cef+oq+7pO5hnHscQl48uk
 YB8xTXllxqC2k4f20ar3oF1aXz427Ozw/U9AhFgK62AoWyaxH4XArfcmi
 DqudUf56Hqe/J80waF5qdZdPyJ6iSxruuIF2ZY+N7ica2D1zFfXp+DE1O
 s8++O8j6paf9FXFm8bjTiM1MGjHD7DKiUToJqZwKE/sm/HkOZIsKehtlt
 CB+J8/F3k4WHcgW45aRSVJOUSfmI+GKvARQ/kyeONz/tl4eClTpyO4xXA
 JQCjG5s2ww6jrrHs+/Qa0OB6Q4dHFq+r/bt67xWDLZvi3/uE60CgaFisO Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249122335"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="249122335"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 18:16:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="657401875"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by FMSMGA003.fm.intel.com with ESMTP; 09 May 2022 18:16:29 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 18:16:28 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 18:16:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 18:16:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 18:16:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7+vNsSgvGMqXURRALEqPXlVlgtHo69jEv25BdTD+MDrDDa65G3YunWZizGXEIijm3cKGps1EO7UXwTdVvykQcunYqShCaynqGx7CJOQm+iE71f8200+d3eVE8fRv6YkPp4LfazaRCXpz6fVAtXZErkLY1/YvkHp5TjnhtvqEPzNuSh4TkoIAV4e11EtTj0MJlvSKJGAsAwoRxpPKxNW/Qpcy4WPk5VVncnwN8LQFqcxmrLipkQkPDrzfukDR877KID6ZRa1TNKU8Hc+EKpl+efbcVY9OxPJH35H4UIKLeIBalB9kWgNOffHpbKJyYlWLd2AmQ/PvVucB1Q1SoF8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdflppwZ7G6ZASCgLnXXnyCVTr/uSfMhZkZCmaMq/oQ=;
 b=LI8vVPK3sCPRPrUtvaRE9+PrPhi4MHOxGAx3DB8yuJ+GnViHr7XIOlck7DlfjSJ7smfampgsV+uHIkwUAV6KgSsN+gd6LkuPWXe945xaVpIHHaZug9NECHvG6qFyGqoa2z+aBixFRglv+Y8u8WLQHopuqFirHW3CRuqiWcZkbkHhr2vqKW1JePO4aTPaGogcky+Jps54tIigHHM4R25R1TKqe/W1WSAn6ALaYAiSFqjmXjqpQUJ0kRGPGhwCNZcGbl6dmgHwNCcC9o21FSwrEVediF2sOU9wRei+nGoSN+tsF/xcnbT0jFQsyVsnLyoEBwQ9Oa5FNsDmLRQPsuvZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5981.namprd11.prod.outlook.com (2603:10b6:510:1e0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 01:16:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 01:16:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>
Subject: RE: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Topic: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Index: AQHYYLnAHmosHc2CfUSQkp312mWw2q0RWsAAgAAL7nCAAApVgIAACKSwgACAKACABVrHkA==
Date: Tue, 10 May 2022 01:16:26 +0000
Message-ID: <BN9PR11MB52769C9F1BD67185A51F16C28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <636a680eb85aded76dd765ba297347ceadc3d1a4.camel@infradead.org>
 <BL1PR11MB5271099D98542F8A3F877D4E8CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YnU+GuPGiFcBXQJg@swahl-home.5wahls.com>
In-Reply-To: <YnU+GuPGiFcBXQJg@swahl-home.5wahls.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f4e3608-8ca9-4bd9-4511-08da3222b483
x-ms-traffictypediagnostic: PH7PR11MB5981:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH7PR11MB5981D4E30238E7B0309004728CC99@PH7PR11MB5981.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5FYqBEj23/og451avzWMbhFtFfZS2bz5jGcp32QZQswjR0awC2cDQ/Y8/LpzfBgRrEAmCLfYpq6LmSN7ncKxWLCqWMFEV+JJoJ2UlF0gPz2ri0UwzNFkKUgeFHz5u7LtK7KJ+NG8tw+WR92Y9y/w5i2aT8fSyQxm60+r8oFnClmEFyIm71jpVW0mZE0GlfW9EFiRosxqAwO/85oFDgGv1fN5K85SkaUVtsRsYJvGs4VqAGsBJ0GjLaKSh+GjxF4TpaoOr7vccSk+nEANKW1XVH7miA1fW6Sh2fvJaP/gJbtIdvUtK2VN9BAzFYi1kWDtpOonskyMBSPEZOFilhxjV7sT5hD4wr8nejssWDg49Sy9E785rN/EYhjz09J2xuqUUyc5hlIiyIOPmUNKmJew7Bma6PBBDe7HKkpHSS0ZM9pQup4FuG0CMwy3ZS+KLjIY9M/WvAz4hvm3CvdqL8m3XDG8iW0X6V95h3lWXbO1SoCVEZua7pFXgfLeJmq0fGv5Bcbo+zGb0yZ50bMzQgF9snYlNePPdbnXfFAOaLSefS8qQ/gE++whQ/IL5faAFl/XAnXz5fQabUXoMv5fv+kkvdrBBPIK1CmMLb860OAcszHqIGSeN6Lne0PjwYaI+3Zn+ViR8WD9AZ7v1oMxfK01uNvolJyR9Z+B2pCoYEmug1UuFRpgQxhKU73e7DnCWR1R2p6i3Q8RJlKmSFZTDup9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(122000001)(55016003)(83380400001)(82960400001)(52536014)(8936002)(33656002)(316002)(66556008)(6916009)(8676002)(64756008)(54906003)(4326008)(296002)(66446008)(66476007)(76116006)(66946007)(38100700002)(38070700005)(9686003)(26005)(508600001)(71200400001)(2906002)(5660300002)(7416002)(186003)(7696005)(86362001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vzi/A9N9yPiGPoFlb36kpwUitLhOOZEwA8u3omcoBktON+dRNAZ8emKxoa?=
 =?iso-8859-1?Q?qatNQSDT4u1haZt7AU9EtHSdWh/Bihq1kqTEXywMLAIGsJ5xASZPYt85d7?=
 =?iso-8859-1?Q?UAYgQRUUZmE/ngbkA1G7yQhRFGqF5nLgvlY9RuEHBA2qhWQnON6NTM2NbL?=
 =?iso-8859-1?Q?mzEMhadqpmCaPizEn5P6fMiLvHGwgg5BubCQbz7YW7Qo/wBnkfP0V4IkJ6?=
 =?iso-8859-1?Q?9rGD7quAZ0JzKZ1vQ8s9s793P167DjvR/+TZkecw1+wKW8BMQSOPcA0LA8?=
 =?iso-8859-1?Q?ysq1TslZ7SJTKI+2/kQVHC3f4H3EHjZ22bRpiSbG15RkkYz6f4hZVTI+oy?=
 =?iso-8859-1?Q?jXI3gvIdkEbxvCYTWZKibMcSoZ/JBsxMPYnzqx5zR1dLnk5oa3HxWNx1MV?=
 =?iso-8859-1?Q?9MGQI1Id8FCBTWZoEXAq6rJYxUDkOU26YHs7Nh9vEjnQ8dKcHXKwzGcn1s?=
 =?iso-8859-1?Q?tqsRyk4OQ7aXAPs2eV5rp1j2mC/zfAcSVrKb0hnf6Ctmkt7gRCpxM4+AgO?=
 =?iso-8859-1?Q?kjl8q9KZzBL1xVod7+yfk8ZbqhIf2sH+g62LSg0VnJWAqV8LzYfy7xYpS6?=
 =?iso-8859-1?Q?kZATubXCvDr+8HhdjB0UdParjtaTuqQ75xOieAgUIApAQUETP76ncQBmEi?=
 =?iso-8859-1?Q?TWi6+franyCGVus6Mk/YYqqvgPy/29S/EWCV2mqegwAKEnf/mDqYJ9Pxfc?=
 =?iso-8859-1?Q?Hkjetc0YFxFqk2iFEcEBZ8WYIshoMann5GGrAVGw7bMaVG0ynLCs2tZ2Xc?=
 =?iso-8859-1?Q?Xetqp9DRT/s+5JKILkph1608CmNxUEw0kBmKKPZkNC6+7bGgCWldwwYEuN?=
 =?iso-8859-1?Q?63WpCD0Bxvz9bG0TsbaPRWrnh4fHXPrucYqH+1aljmic+CvcXdSddzIj95?=
 =?iso-8859-1?Q?QO0w1jiSCAAAR0ZxUdhn3uUawq7loBQZGdlclHQ18Qeu32EQuhAREhK+9h?=
 =?iso-8859-1?Q?O0W8QARhOsm5uarrMSrH9hvecCRNK9kRATF42ttFLQhy/QEiQ3nWOPfL1d?=
 =?iso-8859-1?Q?z77V7+vFa++WJ71bng4myK8uhOiIZ1aD1BKR3iFcY0gtAimIOK0cgdpXbr?=
 =?iso-8859-1?Q?fv1D+71xfXkpzc8PSy3KV2x8y+JaY1EsRmWitKRezoSsjuLywkpfA+T+/U?=
 =?iso-8859-1?Q?v3r79fUb+ptRKuFbOgQo3BRR08VuU536hMtMN5+Hh5NInUiVtCjNemOCNH?=
 =?iso-8859-1?Q?8kIYOP76fuC5dkHgZyjji4r+IBiIWiYAn45L0fwhoANDCA8QR0H0Ol5GRo?=
 =?iso-8859-1?Q?j8egGjb92wYrLY779Yf9SOKhMV5vSJKHikd4VsSH6RRnSWKDc0JB6XWh3U?=
 =?iso-8859-1?Q?TN6WQP79S+GaCTK6FOUtgm8S4JGu83kMcU/YB56fDQ+kjueaJFFsS2o73e?=
 =?iso-8859-1?Q?x8FzY6E0wB24Be9FLHmwSbiTkiw+KPluLMk+HMH7TITJvp3Dy0UqFpofdx?=
 =?iso-8859-1?Q?cA6rImuckiSOTg+WY4XuKNqV8jSgex5MzzqUmQyJZOudFoOHBqPK5UB9Ct?=
 =?iso-8859-1?Q?bKWMfBHijkbgyHwmNhiK4X6UlLbFYWoCgD21fO6YkMrqORk+Gsrie2lLkH?=
 =?iso-8859-1?Q?6minoiJGGCC7nF9CTt6jyKBJ5r2//J9ePJKTttlwT7kOVp9fHkMJdRWYFj?=
 =?iso-8859-1?Q?zWCkg/a3TJRZmBFnioQytrB29Y8zbjcjoPPA3EHgD52ZMWhbM0KLdt1Gv3?=
 =?iso-8859-1?Q?LE2nK7JuEeLXy4QIl77FvMczypioO+/oow+SiinJP/o5t14noalw9egABe?=
 =?iso-8859-1?Q?eYor2hyvbmEN4R/xJK0jfCkTG4zDPNDCf+7s+S4QVf/o7IDX6DGG73+a/I?=
 =?iso-8859-1?Q?mnOMoLw5Bw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4e3608-8ca9-4bd9-4511-08da3222b483
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 01:16:26.4656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +kO4DhE9IiRIBN3f9NrCGltVH/bP49cx85JHS7MpDbwdxSV3wyxKFutXVTrGTzACU3MO3EkKIbE3oG2jU/Iehg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5981
X-OriginatorOrg: intel.com
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Rodel, Jorg" <jroedel@suse.de>,
 "Anderson, Russ" <russ.anderson@hpe.com>, Mike
 Travis <mike.travis@hpe.com>, David Woodhouse <dwmw2@infradead.org>,
 Kyung Min Park <kyung.min.park@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

> From: Steve Wahl <steve.wahl@hpe.com>
> Sent: Friday, May 6, 2022 11:26 PM
> =

> On Fri, May 06, 2022 at 08:12:11AM +0000, Tian, Kevin wrote:
> > > From: David Woodhouse <dwmw2@infradead.org>
> > > Sent: Friday, May 6, 2022 3:17 PM
> > >
> > > On Fri, 2022-05-06 at 06:49 +0000, Tian, Kevin wrote:
> > > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > > >
> > > > > > --- a/include/linux/dmar.h
> > > > > > +++ b/include/linux/dmar.h
> > > > > > @@ -19,7 +19,7 @@
> > > > > >   struct acpi_dmar_header;
> > > > > >
> > > > > >   #ifdef	CONFIG_X86
> > > > > > -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > > > > > +# define	DMAR_UNITS_SUPPORTED	640
> > > > > >   #else
> > > > > >   # define	DMAR_UNITS_SUPPORTED	64
> > > > > >   #endif
> > > >
> > > > ... is it necessary to permanently do 10x increase which wastes mem=
ory
> > > > on most platforms which won't have such need.
> > >
> > > I was just looking at that. It mostly adds about 3=BD KiB to each str=
uct
> > > dmar_domain.
> > >
> > > I think the only actual static array is the dmar_seq_ids bitmap which
> > > grows to 640 *bits* which is fairly negligible, and the main growth is
> > > that it adds about 3=BD KiB to each struct dmar_domain for the
> > > iommu_refcnt[] and iommu_did[] arrays.
> >
> > Thanks for the quick experiment! though the added material is
> > negligible it's cleaner to me if having a way to configure it as
> > discussed below.
> >
> > >
> > > > Does it make more sense to have a configurable approach similar to
> > > > CONFIG_NR_CPUS? or even better can we just replace those static
> > > > arrays with dynamic allocation so removing this restriction
> > > > completely?
> > >
> > > Hotplug makes that fun, but I suppose you only need to grow the array
> > > in a given struct dmar_domain if you actually add a device to it that=
's
> > > behind a newly added IOMMU. I don't know if the complexity of making =
it
> > > fully dynamic is worth it though. We could make it a config option,
> > > and/or a command line option (perhaps automatically derived from
> > > CONFIG_NR_CPUS).
> >
> > either config option or command line option is OK to me. Probably
> > the former is simpler given no need to dynamically expand the
> > static array. btw though deriving from CONFIG_NR_CPUS could work
> > in this case it is unclear why tying the two together is necessary in
> > concept, e.g. is there guarantee that the number of IOMMUs must
> > be smaller than the number of CPUs in a platform?
> >
> > >
> > > If it wasn't for hotplug, I think we'd know the right number by the
> > > time we actually need it anyway, wouldn't we? Can we have a heuristic
> > > for how many DMAR units are likely to be hotplugged? Is it as simple =
as
> > > the ratio of present to not-yet-present CPUs in MADT?
> >
> > Probably. But I don't have enough knowledge on DMAR hotplug to
> > judge (e.g. whether it's strictly tied to CPU hotplug and if yes whether
> > there could be multiple IOMMUs hotplugged together with a CPU
> > socket)...
> >
> > Thanks
> > Kevin
> =

> Would anyone be more comfortable if we only increase the limit where
> MAXSMP is set?
> =

> i.e.
> =

> #if defined(CONFIG_X86) && defined(CONFIG_MAXSMP)
> # define	DMAR_UNITS_SUPPORTED	640
> #elif defined(CONFIG_X86)
> # define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> #else
> # define	DMAR_UNITS_SUPPORTED	64
> #endif
> =

> Thank you all for your time looking at this.
> =


This works for your own configuration but it's unclear whether other
MAXSMP platforms have the exact same requirements (different
number of sockets, different ratio of #iommus/#sockets, etc.). In any
case since we are at it having a generic way to extend it makes more
sense to me.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
