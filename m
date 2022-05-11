Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3888C433EF
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 03:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5EB7A40ADF;
	Wed, 11 May 2022 03:36:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5oO3DV9pvzUj; Wed, 11 May 2022 03:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2B654011F;
	Wed, 11 May 2022 03:36:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5799C0039;
	Wed, 11 May 2022 03:36:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31F06C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 03:36:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 106EA408E7
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 03:36:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yDe87k1522-g for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 03:36:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AF4F6408A9
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652240173; x=1683776173;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7L6qYkoQz+aYw/cX1hGNV+hIILXIU0LNIeYzuUAq3cw=;
 b=kZ6rR7699Or3V/aL5i/bTzksWSMpOUQHuY9AQDAPOicqeTvlMftFeBxP
 Y6t/sML/1vONPZa1JJl08rAgZMi8LSM9R3/oYWk++lsUbeDRfY/F3DFpU
 drAh5span+KbLHvEZWdI1b/e2+Wu6xdgPzkjpiI5DZkt0Hstrh/sFvbxq
 vq5CP6QufZmaI3RFujQp43EDWvM3+MFVuP3VSYAsh0F+wIo0+T2JWdD1H
 wxG3AM+V54AZ4yd2hJXXbScXkuS3iJ5kyzWWq83Hmib7Y1UUHEZsWIMk2
 uXOb41W3wYSxjR8jItTHeEmiWgsNcLWf7qa+8e4ifss42PRbQZG28tY02 A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="268410347"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="268410347"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2022 20:36:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; d="scan'208";a="739021429"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP; 10 May 2022 20:36:12 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 20:36:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 10 May 2022 20:36:11 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 10 May 2022 20:36:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 10 May 2022 20:36:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1i4NI7NTl0EldqafJGVpXq0CnJE6nHAGwVX1aYPybYTIBn8X46+PVOiYsk6fhYtGejRyMN1bGTw1wkXsLFQdjJjgRG0efxC9aRYB9D0loKCbCx0lkdtTckFnllNekk+bXR7X9PdNeomAQ0wMzqfTa7fqApl4FnnoJiGA9dGHmyFSn/ebM0J+0XXmU2Ve3SazFYlBvHx2K3I/HvHtloWqagg6LhIRGWgFDnZ5So+qKnVKCSaXHteVdrB70TA6c5DFhBtP7OLzdZX7xE/yn3r9I/tPULqHkw3itMix3fkHVoIrZJVdGOwQ8HcV8Z1H+4gSbl7t8JGeqXUnuU6rNelng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8ji1Evc9RAylX5lr9aZzAjxc1NBJrduFqWFdQLtsRI=;
 b=XGhyTRHi+FjFxi34og20seqUUz95m/eoZFXCz/Nauqe2IwTtXez30GWrEEkyUnm3yCRnTYKByJNWOLEo3EQZtp8iyig39R0RnFf4gWnFFI4rtttJlXgBmjyYgixZXEzNPwm5Is6wOoHVBYk4DsO4+ThaFDasc3B7SQQ8e3jyJu96eL/Kew0wu0G8arkSl8mFcDNWoYnOJB6a/08jc3O9/lFTuLRP0R4ek9gknRGBqRIg+KyxrSPlYEtLpKkPS4YQyqpOl/vjLpLvk/0y6mt58aj0qKCXKIUF5s0UAEXCwJsDUtXg3QnFw2Kg32GqgjkiyDSe0bJ3vZSfsXng4bn1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 03:36:09 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 03:36:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>
Subject: RE: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Topic: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Thread-Index: AQHYYLnAHmosHc2CfUSQkp312mWw2q0RWsAAgAAL7nCAAApVgIAACKSwgACAKACABVrHkIABLBuAgACM0lA=
Date: Wed, 11 May 2022 03:36:09 +0000
Message-ID: <BN9PR11MB52767BFBFAE3CB01C9CB29AE8CC89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
 <636a680eb85aded76dd765ba297347ceadc3d1a4.camel@infradead.org>
 <BL1PR11MB5271099D98542F8A3F877D4E8CC59@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YnU+GuPGiFcBXQJg@swahl-home.5wahls.com>
 <BN9PR11MB52769C9F1BD67185A51F16C28CC99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Ynq3vRhBWZxImPC0@swahl-home.5wahls.com>
In-Reply-To: <Ynq3vRhBWZxImPC0@swahl-home.5wahls.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98ee206c-3212-4276-c2ae-08da32ff636c
x-ms-traffictypediagnostic: SA2PR11MB4892:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR11MB4892ED9C32FB56FB449C61848CC89@SA2PR11MB4892.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AhxQy5UbBLGI2f7afFlx2vXDamkuKTi40w8lGgpAgCbT8AEvRvS2ePSYWYWsM5+EMN+IUQlopmyOSUm9kpNOctQ9HkN1wawey0vN/dT0rfi9ryVYyuEsnr/1OUmEFsVkMdL0rOtEgOatGWLeivKrjfwyKR+hAcsusHvF927jP6LJ8n0lag41o0D4NIpRp5Y9se9M+hmwtRxtscEBYtUMKCFSTgkDKo3oQRPHpU3jRvBhkYRiSma+KBgtOYqIEbAE/i886iYBzJC2I/g0xww7fERJLX9EYRYbm0v8w56TN2GbFNBd9RIIp7csV5iqvPEGZ0DtScSn7joAG6J3mWCggtK0twstQkCmMBOJHQEhxvPC6R5z18KkTzaxP8VVT6gOYpBVTKkvCUvBwnDN71KOQ1tW7wnQxITO62maox391wcZR9AbDdHFweXeqIrFMwyLssu/STh6qGMqtqnRd/Aqz3B/7pRrn1+4JCPE44m23/KYr3gmZFulNGGEMGzqJ6UBf3HliBImcIhDd2x0cyL49kzimZ5t3m8I5yRqpRmfkdr8sjy7Gez8Rqv9CFEs1LutFYipdtFvRiqZM5f+g2yuJ13RYOJCSP2coLC7WaI6RjuqRpVKa+RUD66rYzEz+VSvf97lnNhKC44AfjQiF2MfUFD3+/KBcN9rRDQNHlXNDEDiiAO75u6x1v6E94d7vRIsiEqXCy9gHXIWeDQVeJhdZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(83380400001)(508600001)(2906002)(122000001)(33656002)(9686003)(186003)(26005)(55016003)(5660300002)(7416002)(86362001)(8936002)(52536014)(7696005)(71200400001)(6506007)(8676002)(4326008)(66946007)(66476007)(6916009)(54906003)(38100700002)(38070700005)(66446008)(66556008)(76116006)(64756008)(316002)(296002)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tYtAg1JzleV/TbIo0HjXRFG7Ykjb2kOA2niIfneeODnSQ4iNMiURipPxnQ?=
 =?iso-8859-1?Q?dPGvwIwQhkdsGmy00Jihcv87WEXbN0/QHhUK8gXDjSH4IPFpbdOdOX4n2x?=
 =?iso-8859-1?Q?/zkcnVEHe2DfpLdYQorsgR92uwfR7hLZcbdzBFfVpQvfeZQl+GQGhMPiK3?=
 =?iso-8859-1?Q?+8kIFVWNXswaYrgR0UMbItF4hJYjpf+LmelmF5zol2RHu0RuAFNM2WuOT6?=
 =?iso-8859-1?Q?+uqnGxWeGOEbyuI0aK6oonAevxps2g1Ub90MpGO7rgSmHGk3o1teGOXKEJ?=
 =?iso-8859-1?Q?KD4JgTflppoMLjq2Vhlku4rS+SoE8o1mfpogQHPwz3X/0Kj8FGTWFPt0Cr?=
 =?iso-8859-1?Q?TOY+OQT4trddITJrTe8yNwyR6hUo3W27weGodg0iLB163vw0lVfTcz8LMX?=
 =?iso-8859-1?Q?RBCqholi+JXY6K3OqoHZ4YoFwTKRMAVorVgldG4tcxm+DNkgCrRJdWw+pJ?=
 =?iso-8859-1?Q?nlWvOfGxweqSOA1/n7JaUXPFvMU6jzO8uArpI9mWoc7HWDO6VIunv5ZmIK?=
 =?iso-8859-1?Q?TRxL6H6Rn3647fXTtDIeRMVoEBKy5Dnk5sDGlxaMO867OW1m2LsWbSYn+/?=
 =?iso-8859-1?Q?T2nBHYs6yvbWCiVaczaigXLBlDsz7CmFRwuqAi47PV+DvuA8LMlyfDtf2Z?=
 =?iso-8859-1?Q?p+qJ5a3jf2kl9KUzrOrl80Nrh0fpzfFQT8P3qHnHLgcgjexVPhjqm58TI/?=
 =?iso-8859-1?Q?WJfKM4gtxJq4FiEjUTjVD1aHnDet+s557hGii/wHoRQfsR9oAgnSsj7eiR?=
 =?iso-8859-1?Q?pSLbFa94u4nnAp6kuNDE3RUrAAFEOExzmCJFAwz5ylVTfxyZIyKPGapjPg?=
 =?iso-8859-1?Q?bh/CjmYL8ADy3OCYOERXF1NLQVW0rL2mcaIGnIm3lJQF2JPb2Zq7DFGP2s?=
 =?iso-8859-1?Q?QUOudujbUlI9bHMeLy/tM5sH6m2KDxOPU5znH6a2mZpsLekYoeb07Y9Vlx?=
 =?iso-8859-1?Q?56QnPhuE+lZmu2+2iwoROyKii19XrtEXd15WpXYVt8lcPMymeGXxD9CdMy?=
 =?iso-8859-1?Q?QzzxH9J+VdwcZI/OOoV+6ZsiTAUJukWFOAzByJ6sHl7wE9yt6Ah+fKAYSu?=
 =?iso-8859-1?Q?4cudiIcqRxwqUIqygDvFteTgEkYwkF6IxMB81UpSvUDq1AEsO+W4cB4hlF?=
 =?iso-8859-1?Q?ok3xnKFdKFzqsVLd5OEiRs89t1CfSo8S7IjAXnT704NEdg2WUOCOtxwMMv?=
 =?iso-8859-1?Q?/ErcgozUFBdzwyGFk1LPIdHwGFjGzkTRz+D9EOhk3VPsVHEi08P0tWgIYS?=
 =?iso-8859-1?Q?GDXkMPrlntsHkvr3GL9yAXuhd1+0sRXUqxitB0Lu5W0ssA90bu4rfb6D/9?=
 =?iso-8859-1?Q?vorsYHkFNNcqhdZqWwoLFlG7oXSQEoqIgG8sqn7KZ/zefZfCT4fq691vKD?=
 =?iso-8859-1?Q?wdlFnwFbBywRI097xH1c0tJ1WEOd9FD0gw8LMgI5N8ZA25HTezzbG7/4Bv?=
 =?iso-8859-1?Q?Zh6FReEqba6hBGOFJPyTmstcvhjRYDaRj2//hGzTY8UvpIuoCrus2UxZqi?=
 =?iso-8859-1?Q?PvrUeH1FVcIQuyuy0GkkTxklgYASBVE2un2XVbjSmv71+4Jv7x+Gxi8wQf?=
 =?iso-8859-1?Q?2LhgODbmabPFNMv/1P0k85vT2aKG9WaQ/Z5Yv3mqCJQSuk+Jth73htiie1?=
 =?iso-8859-1?Q?63YLcpxCoKedjAJAQk2d9y+hQVQ5sliOJ8yeXSMAgXHGrBTvWKBANs4KtD?=
 =?iso-8859-1?Q?2JsSxbhq9M0YzMsBJgN3ROquGfxXMmUrTx0LAn9C+HitN5j1hbrtsQybzK?=
 =?iso-8859-1?Q?aTQLZHbSjTKt/9RveIt4J6rJMpF94Myt3tn5wAkBCfuGTQs4rC9BY0ebFa?=
 =?iso-8859-1?Q?d+4E3QvHAA=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ee206c-3212-4276-c2ae-08da32ff636c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 03:36:09.1999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0WKjNQd0UGaodQ9r2PSAwwsO/3BSyLch26U50plm24JBmcLSq70Evbc7DE/opUxNHyrXmj/QwgJUg0xROSzLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
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
> Sent: Wednesday, May 11, 2022 3:07 AM
> =

> On Tue, May 10, 2022 at 01:16:26AM +0000, Tian, Kevin wrote:
> > > From: Steve Wahl <steve.wahl@hpe.com>
> > > Sent: Friday, May 6, 2022 11:26 PM
> > >
> > > On Fri, May 06, 2022 at 08:12:11AM +0000, Tian, Kevin wrote:
> > > > > From: David Woodhouse <dwmw2@infradead.org>
> > > > > Sent: Friday, May 6, 2022 3:17 PM
> > > > >
> > > > > On Fri, 2022-05-06 at 06:49 +0000, Tian, Kevin wrote:
> > > > > > > From: Baolu Lu <baolu.lu@linux.intel.com>
> > > > > > >
> > > > > > > > --- a/include/linux/dmar.h
> > > > > > > > +++ b/include/linux/dmar.h
> > > > > > > > @@ -19,7 +19,7 @@
> > > > > > > >   struct acpi_dmar_header;
> > > > > > > >
> > > > > > > >   #ifdef	CONFIG_X86
> > > > > > > > -# define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > > > > > > > +# define	DMAR_UNITS_SUPPORTED	640
> > > > > > > >   #else
> > > > > > > >   # define	DMAR_UNITS_SUPPORTED	64
> > > > > > > >   #endif
> > > > > >
> > > > > > ... is it necessary to permanently do 10x increase which wastes
> memory
> > > > > > on most platforms which won't have such need.
> > > > >
> > > > > I was just looking at that. It mostly adds about 3=BD KiB to each=
 struct
> > > > > dmar_domain.
> > > > >
> > > > > I think the only actual static array is the dmar_seq_ids bitmap w=
hich
> > > > > grows to 640 *bits* which is fairly negligible, and the main grow=
th is
> > > > > that it adds about 3=BD KiB to each struct dmar_domain for the
> > > > > iommu_refcnt[] and iommu_did[] arrays.
> > > >
> > > > Thanks for the quick experiment! though the added material is
> > > > negligible it's cleaner to me if having a way to configure it as
> > > > discussed below.
> > > >
> > > > >
> > > > > > Does it make more sense to have a configurable approach similar=
 to
> > > > > > CONFIG_NR_CPUS? or even better can we just replace those static
> > > > > > arrays with dynamic allocation so removing this restriction
> > > > > > completely?
> > > > >
> > > > > Hotplug makes that fun, but I suppose you only need to grow the
> array
> > > > > in a given struct dmar_domain if you actually add a device to it =
that's
> > > > > behind a newly added IOMMU. I don't know if the complexity of
> making it
> > > > > fully dynamic is worth it though. We could make it a config optio=
n,
> > > > > and/or a command line option (perhaps automatically derived from
> > > > > CONFIG_NR_CPUS).
> > > >
> > > > either config option or command line option is OK to me. Probably
> > > > the former is simpler given no need to dynamically expand the
> > > > static array. btw though deriving from CONFIG_NR_CPUS could work
> > > > in this case it is unclear why tying the two together is necessary =
in
> > > > concept, e.g. is there guarantee that the number of IOMMUs must
> > > > be smaller than the number of CPUs in a platform?
> > > >
> > > > >
> > > > > If it wasn't for hotplug, I think we'd know the right number by t=
he
> > > > > time we actually need it anyway, wouldn't we? Can we have a
> heuristic
> > > > > for how many DMAR units are likely to be hotplugged? Is it as sim=
ple
> as
> > > > > the ratio of present to not-yet-present CPUs in MADT?
> > > >
> > > > Probably. But I don't have enough knowledge on DMAR hotplug to
> > > > judge (e.g. whether it's strictly tied to CPU hotplug and if yes wh=
ether
> > > > there could be multiple IOMMUs hotplugged together with a CPU
> > > > socket)...
> > > >
> > > > Thanks
> > > > Kevin
> > >
> > > Would anyone be more comfortable if we only increase the limit where
> > > MAXSMP is set?
> > >
> > > i.e.
> > >
> > > #if defined(CONFIG_X86) && defined(CONFIG_MAXSMP)
> > > # define	DMAR_UNITS_SUPPORTED	640
> > > #elif defined(CONFIG_X86)
> > > # define	DMAR_UNITS_SUPPORTED	MAX_IO_APICS
> > > #else
> > > # define	DMAR_UNITS_SUPPORTED	64
> > > #endif
> > >
> > > Thank you all for your time looking at this.
> > >
> >
> > This works for your own configuration but it's unclear whether other
> > MAXSMP platforms have the exact same requirements (different
> > number of sockets, different ratio of #iommus/#sockets, etc.). In any
> > case since we are at it having a generic way to extend it makes more
> > sense to me.
> =

> So, to be clear, what you would like to see would be Kconfig entries
> to create a config option, say "NR_DMARS", set up so the default is:
> =

>      MAXSMP?  640

usually we do 2's power thus 1024 is more reasonable. If people do
care about the exact memory footprint they can always manually
change it.

>      X86_64?  128
>      X86_32?  64
>      other    64
> =

> And DMAR_UNITS_SUPPORTED gets removed, and everywhere it was used
> we
> use CONFIG_NR_DMARS in its place?

Let's keep DMAR_UNITS_SUPPORTED and just redefine it to be
CONFIG_NR_DMARS for less changes.

> =

> I can give that a shot but wanted to confirm this is what you'd want
> first.
> =

> Thanks,
> =

> --> Steve
> =

> --
> Steve Wahl, Hewlett Packard Enterprise
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
