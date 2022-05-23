Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7887C433EF
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 06:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F6D8405B0;
	Mon, 23 May 2022 06:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7qqEVRC801sr; Mon, 23 May 2022 06:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3FD284026F;
	Mon, 23 May 2022 06:43:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CA06C0039;
	Mon, 23 May 2022 06:43:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 594CBC002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3944783F9D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5zzryubhcqo for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 06:43:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D9D8383F9C
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653288213; x=1684824213;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y0s/1QxsVq/RVeKumAjj4DpIvMB5NrZPmKbmriyWnwQ=;
 b=MU7EydD5qD1Lc9BoG36Bkdd6PcRqwbzuunwVIyBFk34xLzjuwkfd7xMq
 CPzuTOmoNnPLHZAVvcACd3VQ6YTwYoYUnRECacRbz6EinomaNCHdtpRMP
 krNhbDdHoi1xiAZG8Tf8nTXWUdsiHj8OCOIM3x8nwKdqljeEVxuLshBMB
 xuVw2zEB4Rny8NZb5lEJF8DVtVfxwCaEkt4GjI4U1AH+DjabCN1l9e3t6
 83V8+GfNFmvkXY3bEVfv+cPO3FJ7wezG1NzF8SfiMthijfJ8YEiVQXRHH
 FcyHafku3yx7ssG6wmeWyInO9hpgPANgpggTPB5pC51hSWFb75OM3Dzlt w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="273242566"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; d="scan'208";a="273242566"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2022 23:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; d="scan'208";a="558500786"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 22 May 2022 23:43:31 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 22 May 2022 23:43:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 22 May 2022 23:43:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 22 May 2022 23:43:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK51QQngYAq9jh5KFsqGSOh2G0miAix0rQRyfnm9+kxwPDiKsoXD1ip3MLKmxZtR7WnvnSujGj85OZyrjUus3cro+hJNT4gwRvnmoz806gZ1VIveSEMomCvf2xOC3G45l20YgtAtIva+XHlrIF7SZ/B24O88uITCn1If3NTWKh77maVJz7AtkquI8f4wwObJUzXicpmA3YFAcc62qXzYgzP9r40/UcCvoZRQK7JPGvh3BUlrx6ARojyPUJGC4RRQp+WSGha5D+f2GktBivEqqDoY/8sypUanm231XGKt8Fp1obOsQOeONvzc9zRdciX/sQzh6VrgvktLZgazDtEvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0s/1QxsVq/RVeKumAjj4DpIvMB5NrZPmKbmriyWnwQ=;
 b=StotKHUl9EqFyFBWEa3PZ8xGrYXx2yJ03C+sB0nR3/h/MdwK5y9O0t7N4ov2AAClrUkTyDEuyaTluAYon3otSC+5VHXWiXRc+og7D1+3k+j923fFcbSNW4HW64ZilpHulGgZ9jUmaO43vX01pF4ftskD4pxZoae8fftLM5XUBVgzBJID+tGli67639cmy39DUe7PaFm84nEL5HOkGJ7hMWjjN0rMCfs9w1mz48mHw+VeR7SvKFAsuAvKaMZpQPEf2kE5FIhWIXQiF05J00HhZRBPh9Euf5V8kKCGRa37WyH8ATu1Cv2/VFD5P1doKvw80VqTsH7iU5VygyHl7qPbig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4222.namprd11.prod.outlook.com (2603:10b6:208:179::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Mon, 23 May
 2022 06:43:28 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::24dd:37c2:3778:1adb%2]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 06:43:28 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Steve Wahl <steve.wahl@hpe.com>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Thread-Topic: [PATCH v2] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Thread-Index: AQHYZhLniAt2grbgkE6/+ZNTpYBKuq0b32AAgAAxggCACQY6gIAG/JPg
Date: Mon, 23 May 2022 06:43:28 +0000
Message-ID: <BN9PR11MB5276747991B624B62B8CD1248CD49@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <20220512151309.330068-1-steve.wahl@hpe.com>
 <Yn2UYst0ETp42uzq@swahl-home.5wahls.com>
 <2c65b8cf-3813-3ddf-3f5b-c374cc842678@linux.intel.com>
 <YoVP3w5cJWriLBlu@swahl-home.5wahls.com>
In-Reply-To: <YoVP3w5cJWriLBlu@swahl-home.5wahls.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2957abd2-4cc0-4892-7a37-08da3c878b5c
x-ms-traffictypediagnostic: MN2PR11MB4222:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4222ADAE406C4A230D5CEB9A8CD49@MN2PR11MB4222.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AKC0RnXqIyX8sSXLhXESgLw8M8zXmD23b5gpW3lAxtyy0kt6txz8gKgGfn2m09k7HRO3uxWNaqVIAu9fYfmpsfF4Yn/Sm5bf/XWqHMDf8odN5hknTk68ZBG7uVo+ocGu6CbTrECwWzszAHG+lrfyLwAIlJMo3xXJ+tvFDgjVVOpxX4Z7uPA1nikhBz7WKdAPPCMThlbxdIZ8dOEWU/WvlXXL4Micje161dsr7S2wc8vF4KjpmV4PaaCFDFSZASFjGE2YcfcWfgm6wpShf9aZOk40FwG4Ou/i3UyrwOuh9JSzwvOyJx56EvFizW1B2EGDeb6C/s6OoM8gTWXa1FyCtHVkehwdEOwltYgUHOimoeOQFtNdzCOBNqIgDsACBROzepfcd+E+FEMcV+LWx99lmP+o/hxItKO9IED/bt+OzXvbScOhTiD+44SXDPedi81aIz4qqNXSY65zwsSBYFGVRh1M5MzsF7cyASOoOaDctEiTp0mIYNSNXAjhaYbvSgEADmUbM9077jtEqFXT2VZxeh6xrDpc2E4wKiqDfNa3P/2VoZzsK+zKd9FkNxD2BMDh24fbCcUbqP8gKwfLMtGufyVgmTwdvHXm4lnUoO5My0FzI6dPncFBisqEZ7y2jQDjM8SwtFidqoBw/BEPw1EYYodAIDzcU/uOVljQxXY1UrGSNomRrDa/dCdah7DrOzpItjGSlDf8ONERYYciFM3OA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5276.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(186003)(52536014)(83380400001)(8936002)(38100700002)(7416002)(53546011)(26005)(6506007)(9686003)(5660300002)(7696005)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(76116006)(54906003)(4326008)(110136005)(508600001)(55016003)(2906002)(33656002)(82960400001)(296002)(122000001)(316002)(86362001)(71200400001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MZ61yCPap4232q939l+pGMTz/l3/cnBSGFRGo3RPdrixTquRB4KDbRgln/73?=
 =?us-ascii?Q?kjwtRrkgFNOBlOmvcMTwmQHYyevDJA7K6J2ELRM8MDH2+xA0FGGUZt556qqd?=
 =?us-ascii?Q?VCFam1R9WCToG9b1i7wjwnv1G8YqA7YC39nU7J57N+YGMHn+RiEiMmig6jAv?=
 =?us-ascii?Q?LATWPwBRxCrx78/afHSzyoS4C3z+ZGuiniNI3VSGDRwH4N9JEY5DXv1nosUW?=
 =?us-ascii?Q?KZ+P6KBfigPV9Bk4zzj7whFsx1LL5wPQM2Fyhornr6M51o0deUxqblp0tzzB?=
 =?us-ascii?Q?fzo3urrrqrRdaBnurywjMB9+fPVyWu8OgQqr2/hsuhrEknC33Y9DZ0ZJR4nH?=
 =?us-ascii?Q?lJdnE9hmD9WuQGjK+CHVwfHZqIaX8+cttadrs7jCZgBQJmAdZ8cVM49vCP4E?=
 =?us-ascii?Q?LBxnFPqYtFxbOXU5r0FEdY0XgmbYHM6tS8latQzsG6HXz4oVXCz0PupQEGf3?=
 =?us-ascii?Q?zUp1SoTjGLIG88z/uafBdA3DQsSkrDnuFMz9RG0q19e4Ux0vmQS6a8GLvtaa?=
 =?us-ascii?Q?wM7wJqfoI3LH61kyiXLo9WOcDynHDkYBJHnQ8rJouj3S306fheYYuUN1am+0?=
 =?us-ascii?Q?AH08TPM1F+cNwO/ausHhQsBPButG2JX4EH1X4M24+9/FDRVdUQBUJS72u7fO?=
 =?us-ascii?Q?me3g4e9S7OzxUvt67tFsEUUflHb6N/mY5RZTditsebsCeqB8WxIq30QYGusc?=
 =?us-ascii?Q?LOeLnjmFxJOsGfTt2a9G9lfvvo0UwlA5HE+ti8zMPhRELEbP/qYrHcz1zpsb?=
 =?us-ascii?Q?vT7tUGC5hlIMY+MKQP03gDNMC5ZvJPt53O8b2HPS+Lu+CoYCXyD8lP6vrHWp?=
 =?us-ascii?Q?JacB2o4rAIDsUrHJ0azVCuzN8li/f839LN2fIQBkJOZec11nzMAg20igjW/m?=
 =?us-ascii?Q?H+YJhZMk96DreWGkdQnkOoWaLiFhD3eazrLYKg2AH/yPV0b/xo8F3OaxMb8z?=
 =?us-ascii?Q?zlU4yQwXRx/XFe8BP+WO0xYj20Yd8d8NaRRVHHj2U8UYZK982A1bdOzQLqk7?=
 =?us-ascii?Q?nWdXdQanwKW42jES+iWw6lHWrO46dToGJB4szJnFXUOcu5zUeWCqpXDewi+n?=
 =?us-ascii?Q?tf4rrQyveNtw5Dys2WDDlU5DgvOr2HR9MO6TIG7pLmhuidda/uO4S/s3yhjD?=
 =?us-ascii?Q?1XQUKMKCJXmHTKddM8/cH1Yb5svvS9P0oJ/aXbMlMSyYKsIwTSspoJpjCLU3?=
 =?us-ascii?Q?AmEjca/Uqz8a0Xh7wwjHQogImUPb4AiiG34Kz1Am6aWEUbyoqg2/THlT9hcO?=
 =?us-ascii?Q?i+NYqcaQOC+B/EMs9BTJGbIm1vZ6orRkhPlBstmFV8Q98Z/qRVhk3QGKnVK5?=
 =?us-ascii?Q?miu1k2ETPLkOBGwi8xOl/GNuK04BIDU9QHAN559ged2o6TSqR0WhAiWcbcjr?=
 =?us-ascii?Q?prJ6gtWPZ2LlNgC2kZsvzrYRez/msBmcd3hi8kx2ByPSdsqmUs224fNnA1mH?=
 =?us-ascii?Q?P0NJh0gFo7QCBrG2D20qVZAx3dS8ivKRV9wJZV9D6FZh2T3QS8bYAopUUEc4?=
 =?us-ascii?Q?bmjNLQsjqk89/yHgPlz+Ou+9A0VFTcNvaZUk06J3dGtvs4aVfMn4KSjCUtmc?=
 =?us-ascii?Q?rGpLxpNLrCRPFBf4y+vy0qY0qoAABFDOPen4amB7e3YFX6VJq20Y99+fhZOm?=
 =?us-ascii?Q?hCl0unN5zy6egn/AWRgCVb5QLnhql6h68df7p9wKG8ErUd2DDdd62l3RXRWT?=
 =?us-ascii?Q?a78CPklOdwf5JB1GJFq5ydDTbEuP7jhiGn4IyRLnQpuxGcxN/VjD8siEOuS8?=
 =?us-ascii?Q?4TD+NYATJw=3D=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2957abd2-4cc0-4892-7a37-08da3c878b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 06:43:28.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jvirq312kblhA0d4mCI5tlc6Ymzy/ziJKKSslZOUhrWmvn61MU0rEzK9levtItPDpTVrC3ObzH2dh31h6w9Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4222
X-OriginatorOrg: intel.com
Cc: Dimitri Sivanich <sivanich@hpe.com>, "Rodel, Jorg" <jroedel@suse.de>,
 "Anderson, Russ" <russ.anderson@hpe.com>, Mike Travis <mike.travis@hpe.com>,
 Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

> From: Steve Wahl
> Sent: Thursday, May 19, 2022 3:58 AM
> 
> On Fri, May 13, 2022 at 10:09:46AM +0800, Baolu Lu wrote:
> > On 2022/5/13 07:12, Steve Wahl wrote:
> > > On Thu, May 12, 2022 at 10:13:09AM -0500, Steve Wahl wrote:
> > > > To support up to 64 sockets with 10 DMAR units each (640), make the
> > > > value of DMAR_UNITS_SUPPORTED adjustable by a config variable,
> > > > CONFIG_DMAR_UNITS_SUPPORTED, and make it's default 1024 when
> MAXSMP is
> > > > set.
> > > >
> > > > If the available hardware exceeds DMAR_UNITS_SUPPORTED
> (previously set
> > > > to MAX_IO_APICS, or 128), it causes these messages: "DMAR: Failed to
> > > > allocate seq_id", "DMAR: Parse DMAR table failure.", and "x2apic: IRQ
> > > > remapping doesn't support X2APIC mode x2apic disabled"; and the
> system
> > > > fails to boot properly.
> > > >
> > > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > >
> > > I've received a report from the kernel test robot <lkp@intel.com>,
> > > that this patch causes an error (shown below) when
> > > CONFIG_IOMMU_SUPPORT is not set.
> > >
> > > In my opinion, this is because include/linux/dmar.h and
> > > include/linux/intel-iommu are being #included when they are not really
> > > being used.
> > >
> > > I've tried placing the contents of intel-iommu.h within an #ifdef
> > > CONFIG_INTEL_IOMMU, and that fixes the problem.
> > >
> > > Two questions:
> > >
> > > A) Is this the desired approach to to the fix?
> >
> > Most part of include/linux/intel-iommu.h is private to Intel IOMMU
> > driver. They should be put in a header like drivers/iommu/intel
> > /iommu.h. Eventually, we should remove include/linux/intel-iommu.h
> > and device drivers interact with iommu subsystem through the IOMMU
> > kAPIs.
> >
> > Best regards,
> > baolu
> 
> Baolu's recent patch to move intel-iommu.h private still allows my
> [PATCH v2] to apply with no changes, and gets rid of the compile
> errors when CONFIG_IOMMU_SUPPORT is not set, so the kernel test robot
> should be happy now.
> 
> Is there another step I should do to bring this patch back into focus?
> 

This looks good to me.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
