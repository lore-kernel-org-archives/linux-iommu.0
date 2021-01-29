Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7271C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 10:09:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8319464E3F
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 10:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8319464E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C34186FDC;
	Fri, 29 Jan 2021 10:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t7FlUGE-Ex1A; Fri, 29 Jan 2021 10:09:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CE1B287031;
	Fri, 29 Jan 2021 10:09:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7612C0FA7;
	Fri, 29 Jan 2021 10:09:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4EC7C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 10:09:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B427687031
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 10:09:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ie5NHEinoU3G for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 10:09:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8607D86FDC
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 10:09:09 +0000 (UTC)
IronPort-SDR: SdNSmLyb/apYMPZYQ7mwwfDHOMeYt6BA3jMtF76VRLR+F7GV3748PjVF8GgcwgcFGXbqi9fxbz
 9TAKv8r5EuRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="199241590"
X-IronPort-AV: E=Sophos;i="5.79,385,1602572400"; d="scan'208";a="199241590"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2021 02:09:09 -0800
IronPort-SDR: xAi6mRHwJ1ShYJaNbvH2ITErrAAjL+PJsi73dMyJeIj+vz6PR6S6Pf1zhUZR5npbd90C/XGibK
 TGpS83UrhULw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,385,1602572400"; d="scan'208";a="364782019"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga008.fm.intel.com with ESMTP; 29 Jan 2021 02:09:08 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 29 Jan 2021 02:09:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 29 Jan 2021 02:09:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 29 Jan 2021 02:09:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0Mf9IUca/RKqZzkBxDjgK1xKkpqxXGhIJQmHEUWWnoLHpInQ86weHPqZrcyA0cyimFnAuPvk0gAp6sJ4IE+D/yMtNIIPj3mrMm7WVZU040IZJPl14+6/JHhbURwrr4szJSlzJ2ZdQXj4F1UtI8z5K3wpNUFp+V8LiWOWsRxtWhpoZK3vqWyWIrvpuoM5WWmq2qB+bcrTXAI6sS+W/VCv9KlzGuKLlR6X4dX+oLc/VTQ8qS+HB4zoxaxITCk+XXlzhPeq0oRLywSMcZyeaO/tywdjtZGLGtsHToCyFH2oSpd6HofQJDNT/nuUQTYcwv5LrdcajFmB4KF+3F/rR6nUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W26VkqEshLLcRfJRfBXX1k0EiFtt4xE8fP962IX7RY4=;
 b=UHV5VB79rT327THYYsHRnB0fO1htvrVdGYds/bmhwZgvEKQ/yh4rVowTwSuhXUAzVPDcQVPQae/l0pAy5Sx7ku8QN5882sSsq2HO+yi2FNKk6g1QeKjrCZ/8pw3QSGseWWs3K3zZFaRJtTUF3xfW0VtE5KTVh34pMQ9mA+E4lfEN9eGknuJrhRZq/mfyQW9NdLCIOrCmyMG9Z0eiHJDgVyNd+eVVz1m+BfF7D3BVl0l4348rHDlHgVL7dDil1wFTVtjcDgBlEenM8WM1Jd5oQ/PGy1ph2erEXYycQmYO267L07SVGa5I57r75y68jz06FfV8wW/N4xBVqwN9OMwiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W26VkqEshLLcRfJRfBXX1k0EiFtt4xE8fP962IX7RY4=;
 b=zJ6GVnSoL1y5yfW4OCSoHuI3RNarkR/ZHQ3KkIsdMeNfxwwBCpBlZib6tcz+C8bW6//B8wwrJ5QWbyJV6urXL8qnQjeibaDxcxBcOZnYLUQB+AlxC+RYTil4i5U2sGpTeBEV0dMt9Z0MSqzXxYWfn03zgpI26W//tTvPowR0U7k=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Fri, 29 Jan
 2021 10:09:03 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::f1b4:bace:1e44:4a46%6]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 10:09:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>, Jason Gunthorpe
 <jgg@ziepe.ca>
Subject: RE: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Topic: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
Thread-Index: AQHW8vXFZzEtyXCrG0WCf1cOBJGRp6o39q+AgADtcaD//5AFgIAAh9tQgAAe3wCAAAPTgIAFRl4w
Date: Fri, 29 Jan 2021 10:09:03 +0000
Message-ID: <MWHPR11MB1886DC78C5FBA3636B94F2578CB99@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1611563696-235269-1-git-send-email-wangzhou1@hisilicon.com>
 <20210125154717.GW4605@ziepe.ca>
 <96b655ade2534a65974a378bb68383ee@hisilicon.com>
 <20210125231619.GY4605@ziepe.ca>
 <5f64a68042c64f37b5cba74028bd2189@hisilicon.com>
 <20210126011304.GZ4605@ziepe.ca>
 <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
In-Reply-To: <d7fce136c3644755a7aea5794bddf453@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66f5b8f2-5eeb-47a8-3361-08d8c43de7ca
x-ms-traffictypediagnostic: CO1PR11MB4881:
x-microsoft-antispam-prvs: <CO1PR11MB4881FB7FA741FF8EC261EA538CB99@CO1PR11MB4881.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1DsevF5hr1eSIID2pQ/r8Anoxs2ejV44W4NvGL1SbxGNJak/q6fWcDeugHmj4nY5uH6Axt2WnZbwuYN0KN0326wXlvlMhr2PAwv96VkHEJKueH/+aRxYzd4PhUOSUirhiqWePrqwgd1y5W/mMzkHuER1I2vBXdJGpVqOi7fYSCHArlhWDU/PS0TuocR15MEOBkipuRYI7zVdIy8a4fkWYGvUAmrN+HcprRsDkqeLgGiRoHSEt7/ooH2EGBfAnKt/z+0LdHVjEB3a3WJjRo6TS+3Ca6G0n1U5wpPGMqMPKJmam05GktR72zTtKOOijZyO9YVf3abz/zhhv36E1N+zUlB3wfd6jMDsDlJUbEP4Qy28+DzezZRzxJ568PdsHLUKGrg9C8VOux8e4nqZ9iYvDQ9S001TzOw40dGtvK277SxB2YHo8H/nmsZPEKx1iQPeLwq6OdVLXVtjszhSbpIEVJfaC+u7X4t/cKJSAQ3kvVyKEysnPkFF2i7cPXUbOQnWHt+4t7eYk3qQRaKufZzvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(86362001)(8676002)(7416002)(6506007)(66556008)(2906002)(66946007)(66476007)(64756008)(5660300002)(76116006)(9686003)(4326008)(54906003)(478600001)(110136005)(55016002)(7696005)(33656002)(8936002)(316002)(52536014)(71200400001)(66446008)(186003)(83380400001)(53546011)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?U/dCODh7zOMFfEg1zlSuLbPpNYMGCbLgcF+r6A6hM5PyhXK4BuX+nZxgh3dA?=
 =?us-ascii?Q?OUoSlfapbkJIVRysv/2of4BTYHNbkFaxj5GieoTuPEfjga0KmwmXcOHWoRRO?=
 =?us-ascii?Q?JZ5faFgvxjiUO1c3ZRvie5I4yO3604cwlNTHGs1om6rb3EtyOmEywCXoKxnN?=
 =?us-ascii?Q?XfmqEi6WFo74g2t0pbSVArFXEUO3o9xh+rv8aXxMuJFr/0qJWktFFMu16wEw?=
 =?us-ascii?Q?gI3iQutUHPaHg6iexn4OFrmU+FdkzRp+RFgu3yzw8vBvPM/08aQuSClB5HMx?=
 =?us-ascii?Q?YP9PuHHB7aBd6XuZs0c17HhhYEvLbIW4GKDeNjFZVYVT0Tmx1FdROigxmsLg?=
 =?us-ascii?Q?YrkSTKqCPbkejMdc/GLZYfzztX1sAlhxuFPZ1LXuFwwvmYkJx6Ub0IC0srg1?=
 =?us-ascii?Q?Nrkwba0kOiZaDr3QikrnAUiIGZIGWIhBqUVwcZdxK5APngKjwAmrM/T7GH1k?=
 =?us-ascii?Q?as2GeZDhTLwAgKK0hWYhBV+jyxmYve5peikM1GNAPyN3esClsDE/NCjlOghb?=
 =?us-ascii?Q?rHp9D3O+n7LGd5hS+58aKPzTMUG2uOe9reDzxAmXbGPA8QaTTDkFiBABdq7M?=
 =?us-ascii?Q?u/9iAVq83xHk4Jdv/IV4Kmgig0l3vRGNwr64W/9IpfQc5qOZTlf4cvubYAVN?=
 =?us-ascii?Q?wDYxkwEgTWMVgRfgrQQbJC1E7HRc9qzkA9OZD+qDN++bcIHphOw/DdoJyhVF?=
 =?us-ascii?Q?fLveHP7RjHLfdDvCKXeakPL+V67k5trW/iYsPuL45LYlCdDMbqLP3u2qBAk8?=
 =?us-ascii?Q?sSGgpe5lmeGxyXylkGQVIFEAiVqoMxeF2zf/hRFKNtP1WCbCueK95f1MmOK5?=
 =?us-ascii?Q?CagadypmCwcOH+uHvSlLy4Q3D8siqr9UBA7p1YWAisrjgQfBm0r4yC7UGOhX?=
 =?us-ascii?Q?yg9CQaUKehHMPcIuSQW6Ardl4/dOZRdvQLo19sUASwgCouYaPGdTtQoTQ7Pb?=
 =?us-ascii?Q?AcspHUYTqfHngB59lVOos8WFflRrVMgvGuAIOJvP6LWYcvX2Ivw2STD7XnCi?=
 =?us-ascii?Q?85P6WDlaFIq2shkC1luwHaHwU0j8R5QM24vUgfiH0J7z/DU+BbqeRRzTbLZV?=
 =?us-ascii?Q?f0KRWSZH?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f5b8f2-5eeb-47a8-3361-08d8c43de7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 10:09:03.2173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKEu90P3G+2G8scY54P4F8oLsdM1Hk2Zw/BJ6QHz9VTA4x0AbBZUW0l2G5rcnYKCDWKaKEKxG5vx4h3S0YE/ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com
Cc: "chensihang \(A\)" <chensihang1@hisilicon.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>,
 "Liguozhu \(Kenneth\)" <liguozhu@hisilicon.com>,
 "linux-accelerators@lists.ozlabs.org" <linux-accelerators@lists.ozlabs.org>
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

> From: Song Bao Hua (Barry Song)
> Sent: Tuesday, January 26, 2021 9:27 AM
> 
> > -----Original Message-----
> > From: Jason Gunthorpe [mailto:jgg@ziepe.ca]
> > Sent: Tuesday, January 26, 2021 2:13 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Wangzhou (B) <wangzhou1@hisilicon.com>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb.de>;
> Zhangfei Gao
> > <zhangfei.gao@linaro.org>; linux-accelerators@lists.ozlabs.org;
> > linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org;
> > linux-mm@kvack.org; Liguozhu (Kenneth) <liguozhu@hisilicon.com>;
> chensihang
> > (A) <chensihang1@hisilicon.com>
> > Subject: Re: [RFC PATCH v2] uacce: Add uacce_ctrl misc device
> >
> > On Mon, Jan 25, 2021 at 11:35:22PM +0000, Song Bao Hua (Barry Song)
> wrote:
> >
> > > > On Mon, Jan 25, 2021 at 10:21:14PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > > > mlock, while certainly be able to prevent swapping out, it won't
> > > > > be able to stop page moving due to:
> > > > > * memory compaction in alloc_pages()
> > > > > * making huge pages
> > > > > * numa balance
> > > > > * memory compaction in CMA
> > > >
> > > > Enabling those things is a major reason to have SVA device in the
> > > > first place, providing a SW API to turn it all off seems like the
> > > > wrong direction.
> > >
> > > I wouldn't say this is a major reason to have SVA. If we read the
> > > history of SVA and papers, people would think easy programming due
> > > to data struct sharing between cpu and device, and process space
> > > isolation in device would be the major reasons for SVA. SVA also
> > > declares it supports zero-copy while zero-copy doesn't necessarily
> > > depend on SVA.
> >
> > Once you have to explicitly make system calls to declare memory under
> > IO, you loose all of that.
> >
> > Since you've asked the app to be explicit about the DMAs it intends to
> > do, there is not really much reason to use SVA for those DMAs anymore.
> 
> Let's see a non-SVA case. We are not using SVA, we can have
> a memory pool by hugetlb or pin, and app can allocate memory
> from this pool, and get stable I/O performance on the memory
> from the pool. But device has its separate page table which
> is not bound with this process, thus lacking the protection
> of process space isolation. Plus, CPU and device are using
> different address.
> 
> And then we move to SVA case, we can still have a memory pool
> by hugetlb or pin, and app can allocate memory from this pool
> since this pool is mapped to the address space of the process,
> and we are able to get stable I/O performance since it is always
> there. But in this case, device is using the page table of
> process with the full permission control.
> And they are using same address and can possibly enjoy the easy
> programming if HW supports.
> 
> SVA is not doom to work with IO page fault only. If we have SVA+pin,
> we would get both sharing address and stable I/O latency.
> 

Isn't it like a traditional MAP_DMA API (imply pinning) plus specifying 
cpu_va of the memory pool as the iova? 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
