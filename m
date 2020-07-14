Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA3BC43446
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CAA622507
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 13:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hmPodxSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CAA622507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D326862E4;
	Tue, 14 Jul 2020 13:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WoZzeXlnVA1y; Tue, 14 Jul 2020 13:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E8B2E861F2;
	Tue, 14 Jul 2020 13:57:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAF1BC0891;
	Tue, 14 Jul 2020 13:57:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C6F3C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 25C2820363
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:57:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TB7jAcI8JK7O for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 13:57:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 60F812011A
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 13:57:30 +0000 (UTC)
IronPort-SDR: omaw+EQAfECTuA9hD0ISVIi4QvPh+nzN6l5nbCd6/Dw8Gtz0L+YzLAYMvwjcAM2qtRjGHngqYS
 /MQO07ACfGqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146385401"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="146385401"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 06:57:29 -0700
IronPort-SDR: HUyaNrsMEeC99FhlE005HPloc5VKquXyTYNk3gpBg4kToNNi2kvZToBk+4atCNL3vGok3bBqjK
 2q4p4/cIWmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="299549530"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga002.jf.intel.com with ESMTP; 14 Jul 2020 06:57:29 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jul 2020 06:57:29 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 14 Jul 2020 06:57:29 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 14 Jul 2020 06:57:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVgEmPSh78PSWyYIbx80HlJ+Dl9zkB/ERNW/R1N4NqqtIcVZRfa/w/KWK6c4fxMZlKwR+lLL+Vvl6SATPs5lhEVKyPf9JLJvZq08dXX+oJz/94Vwj8yrtQUwbjQR6j+UwCx/9VNv4KjUXbucD+srOLbg1V8oRZTgEUhni7mNYHBgqmdtCblTrAKgxiIn92VuHGKhFJ5lBn94+rla10d8XULXC/0FEAOxWQ//bmXnl3tEAJzV6roAIhxqlx2O5Fk+Ea1kplor+SsVobNtlhOhdIPZcJXc/HP2JGzui3+UXCVdeka3UgrJTTiGk9Stsn/YmIFRrya9sR6gTcJYClZWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAPjp+TaCA1szx00SVnF8P/v6crkJMYj+HxZ8UxYfmY=;
 b=Zbmus442SANJurX/cPFR7vOhVWWltsAYAMHQ6z0kFylfHcYketEsegG69BK96/svBbWxOr6c6vx7jMkYCDt3RPWcCbPJtqtgL6qTlW9w6X2wVW2x/+Bl5zEVorWsyX4x5PMu/R99ml6OQa1mxxrE0aqojvmY/nB/tIRE/vq7NebEpCrp1O0cfAz6CUORLmgO1nRfBOk8Tq01nlIqYwkkE+xSc8bKAx5v+8aTLNqFlP3fh193w5WrdgiQS8SEyKtKX/L1bjGhIDnulQ2ghVFSeVVRr26qKUUzFbij9/52QT47YFEHO3o3VwQfGZlV68w1qLtl+bp2Xf+7fKABrzhqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAPjp+TaCA1szx00SVnF8P/v6crkJMYj+HxZ8UxYfmY=;
 b=hmPodxSl4sd32CihmRDu7iezBRfNXoAr280WWKa0YEHVEJdJApGfu1H/8CI/t+UW7oZ/kpCwMZP9mGM3em+eo6EC4nalgjhby0WxU5pv/PJQOUF5fjsjY/0qTgk44xM8nZNxhQ0ofdpjDVxEPdQhypQ4v2+XxNP/XcoPPoedlpU=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1961.namprd11.prod.outlook.com (2603:10b6:3:107::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.25; Tue, 14 Jul 2020 13:56:30 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.017; Tue, 14 Jul
 2020 13:56:30 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH v6 01/12] iommu: Change type of pasid to u32
Thread-Topic: [PATCH v6 01/12] iommu: Change type of pasid to u32
Thread-Index: AQHWWXA1h1KpvcyzpkmsBfdm/bKRN6kGXnQQgAC7WYCAAABY8A==
Date: Tue, 14 Jul 2020 13:56:29 +0000
Message-ID: <DM5PR11MB1435AE416B6167526CD64A6BC3610@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
 <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20200714135449.GI32961@romley-ivt3.sc.intel.com>
In-Reply-To: <20200714135449.GI32961@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ce055f-56ee-492f-e33f-08d827fdb5b3
x-ms-traffictypediagnostic: DM5PR11MB1961:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1961BA5FA0B17F42A4DA568CC3610@DM5PR11MB1961.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OLoPUc7eubCFXHUMjLxGxapwjikiDB/LIzoizXB07C9LbPyk7sUdCbbkdtOduPSqMpGYCSps/ohZgB+M6uxnAOYGagfAwWTg/jvpfuCqvr5JMP08TlfpvQA3JT1JyPVqDU6V3YVUgUBA+lsPBAUojXerxaj5Xjt1vLFmW8pVm9Vf+JDSdDomYufKD2l/ThDM6ssvKuOwYUx6dJPUzqQw+4OpyiUr2NzQHmqtdfp2917IwVoSM7I0N2t0HZAgGzfh8hrx0FGjuCCrJVALn/jmrJ9QzqrkPC3fibUyJWUwTbpU12Smc0yMUGPDNbT8G5E/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(6862004)(8936002)(8676002)(6636002)(316002)(2906002)(478600001)(83380400001)(5660300002)(52536014)(4326008)(66476007)(9686003)(7416002)(6506007)(86362001)(7696005)(66556008)(54906003)(76116006)(66446008)(64756008)(33656002)(55016002)(26005)(186003)(66946007)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 5FbiHqEYxyMcidKmIofRgTWDrYE0ssgIW3+oCUuSUSuHqUz9JuqKSsQmFN5NCjSF0w5wzl1NZPPvNx33rpXtHCYyb361Sh48Kh0OG+1aFQAYx0MogvvAS0ppWpqQE0Ng0nQV4zPk9xTu8vS0etXJSJeMadBabKBAAkeZqZgbCcM/5HONW7xwVRwCB6RMyJzqzdKc1OvlGwIT9o/tLF2CFw5p/PMFUfnwyfePpKlFOEtICUndEqBFhEY2hHF+lckueJw1TBk3CHlUw82jZX2mf89Uk/zyJquESILKoxtt4IqWILK/C1jOtic3w83s7n+Ab5x9iOBjKzIuMYt704ll3GU095bnOMcfY0SM4dRG6edR0/54pB6zINI/KkmR3kZXnuPgNNXirsvGF698+cdsckPxjgqnJEfEruNpLtgcSP18CdYHULNIRkUwTEMKDkEDjqL6UDohz9xClCZR/eU/PZIM0uE2aDtGJberyP1q9A9rXIBA0zlfGYFNeblQUAjL
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ce055f-56ee-492f-e33f-08d827fdb5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 13:56:29.9520 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1kNW/3/2kz2iTBEB47rX+7z2YA3VllLgB3AdwAf7clDkQ7jEIGTjjlUiCD8uHtDgABRp+oa99DylV7dpJ7VYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1961
X-OriginatorOrg: intel.com
Cc: Peter Zijlstra <peterz@infradead.org>, "Hansen,
 Dave" <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "Luck, 
 Tony" <tony.luck@intel.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Yu, Fenghua <fenghua.yu@intel.com>
> Sent: Tuesday, July 14, 2020 9:55 PM
> On Mon, Jul 13, 2020 at 07:45:49PM -0700, Liu, Yi L wrote:
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > Sent: Tuesday, July 14, 2020 7:48 AM
> > >
> > > PASID is defined as a few different types in iommu including "int",
> > > "u32", and "unsigned int". To be consistent and to match with uapi
> > > definitions, define PASID and its variations (e.g. max PASID) as "u32".
> > > "u32" is also shorter and a little more explicit than "unsigned int".
> > >
> > > No PASID type change in uapi although it defines PASID as __u64 in
> > > some places.
> >
> > just out of curious, why not using ioasid_t? In Linux kernel, PASID is
> > managed by ioasid.
> 
> ioasid_t is only used in limited underneath files (ioasid.c and ioasid.h).
> Instead of changing hundreds of places to use ioasid_t, it's better to keep ioasid_t
> only used in the files.
> 
> And it's explict and matches with uapi to define PASID as u32. Changing to ioasid_t in
> so many files (amd, gpu, crypto, etc) may confuse upper users on "why ioasid_t".
> 
> So we had better to explicitly define PASID as u32 and keep ioasid_t in the limited
> underneath files.

fair enough, thanks,

Regards,
Yi Liu

> Thanks.
> 
> -Fenghua
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
