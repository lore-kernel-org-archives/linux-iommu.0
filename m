Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202EC43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 21:11:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7972087B
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 21:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="ihDo8jQ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7972087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1130E1DE7;
	Tue, 30 Apr 2019 21:11:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 71DF31DC8
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 21:11:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810093.outbound.protection.outlook.com [40.107.81.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E52D65F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 21:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=Z5fuRto6oEUcT+2UnhpiHB/MeHMXoTp2Vo1GAYaMOJA=;
	b=ihDo8jQ8VenrmLIPMtw+x6xzB7BIHZCNUIaZ5KnA3xxIMvSkTy7sVA+hjPbsoM4QcdHhodczxAjHvjKuD/nlATqQG/HKQPcTDEzohfLH8VsuS2XkUXzaUFEM3AKRMQYhZw1ts9L3Tc0y55JoFpu1YO/8/XA5Tx1/o35xn6onLPc=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
	MWHPR2201MB1342.namprd22.prod.outlook.com (10.174.162.145) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Tue, 30 Apr 2019 21:11:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
	([fe80::b9d6:bf19:ec58:2765]) by
	MWHPR2201MB1277.namprd22.prod.outlook.com
	([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 21:11:07 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/7] MIPS: use the generic uncached segment support in
	dma-direct
Thread-Topic: [PATCH 5/7] MIPS: use the generic uncached segment support in
	dma-direct
Thread-Index: AQHU/0QLF7/q9Iq7YkyidXRkO+31J6ZVIwmAgAAFVoCAAAuKgA==
Date: Tue, 30 Apr 2019 21:11:07 +0000
Message-ID: <20190430211105.ielntedm46uqamca@pburton-laptop>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
	<20190430201041.536amvinrcvd2wua@pburton-laptop>
	<20190430202947.GA30262@lst.de>
In-Reply-To: <20190430202947.GA30262@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0030.namprd02.prod.outlook.com
	(2603:10b6:a02:ee::43) To MWHPR2201MB1277.namprd22.prod.outlook.com
	(2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7be7f2c6-05cb-43f5-3353-08d6cdb05c65
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MWHPR2201MB1342; 
x-ms-traffictypediagnostic: MWHPR2201MB1342:
x-microsoft-antispam-prvs: <MWHPR2201MB1342B87D3043A05F1CB25697C13A0@MWHPR2201MB1342.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(346002)(376002)(136003)(396003)(39850400004)(366004)(189003)(199004)(256004)(33716001)(476003)(446003)(3846002)(53936002)(9686003)(2906002)(11346002)(6246003)(7416002)(44832011)(486006)(66446008)(58126008)(52116002)(54906003)(6512007)(76176011)(66946007)(305945005)(66556008)(73956011)(6116002)(64756008)(7736002)(42882007)(1076003)(66066001)(66476007)(229853002)(4744005)(102836004)(316002)(6506007)(26005)(81156014)(386003)(8676002)(25786009)(99286004)(14454004)(71200400001)(71190400001)(478600001)(4326008)(186003)(5660300002)(6436002)(81166006)(6486002)(8936002)(68736007)(6916009)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1342;
	H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oou6dGQ05SuIRbNW26WOJfH4h74lpio/jhOb/CK071+gqjuVxIehKEZ3Lxbq+Ue3vpSp9pFj6lFK0kgMfzhca4G/07YiEk93sZsumWNJwknfKaNSSSd0oVuFtZSdTVl8T2KohoddnbReaWJhJadHjNWl05hWdj+USnwQG/zDNnwHlGq98U7Z3io8jQMM0mDCwDxrpYtafiQGoI9XF7vICxjo/8SPpzQ/YP2Fiq0b4PnCESXhBjfcOlX1cOGhQGfHyeUOsjkKT0yhDCRI8op6sBZpSQhHoeRICIH5q7mDq9J8wgolElH6sIP//86zQIQgssZSxhsyfk3vgY38V97eVMfrq9mjUwrE6pJBNfTIuJzjRcmIJNIL19ciagR/zKom+2bpWLHHVq6vh+UVqvw/li6I45M5S+qpVLcrkw0z/so=
Content-ID: <BE61B5D62A760A468D987D7B2CA91D7A@namprd22.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be7f2c6-05cb-43f5-3353-08d6cdb05c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 21:11:07.3022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1342
Cc: Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	James Hogan <jhogan@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190430211107.hZAdmd0rhr8uNqYl3gPoUTmZrbaRUzYgH6W4DnTxxF4@z>

Hi Christoph,

On Tue, Apr 30, 2019 at 10:29:47PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 30, 2019 at 08:10:43PM +0000, Paul Burton wrote:
> > This series looks like a nice cleanup to me - the one thing that puzzles
> > me is the !PageHighMem check above.
> > 
> > As far as I can see arch_dma_prep_coherent() should never be called with
> > a highmem page, so would it make more sense to either drop this check or
> > perhaps wrap it in a WARN_ON()?
> 
> dma_alloc_from_contigous can return highmem pages depending on where
> the CMA area is located.  But given that these pages don't have a
> direct kernel mapping we also shouldn't have to flush the caches
> for them.

Right but dma_direct_alloc_pages() already checks for the PageHighMem
case & returns before ever calling arch_dma_prep_coherent(), no?

Thanks,
    Paul
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
