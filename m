Return-Path: <SRS0=Kg+4=TA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA4C43219
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186A520644
	for <iommu@archiver.kernel.org>; Tue, 30 Apr 2019 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="rqyrmEOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186A520644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C19671DC8;
	Tue, 30 Apr 2019 20:11:20 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 946D31CA7
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 20:10:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr790118.outbound.protection.outlook.com [40.107.79.118])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0B1415F4
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Apr 2019 20:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=TpyZcDxXbvSkVotzFkMyCfj5WDHtPiC8BJMokhhTj0Y=;
	b=rqyrmEOTkXXMHdeq8q69CgmrrrQ+9Fgqq+X5XS0SuL5LucAN77lC+XrU2jlHTwXBGefGmGVcwMagNVA6MmzwFxdIonRIhxBtEPmxVwjrX/CgNmSoM18hipDWOHigbujb4Z+x4h1X7kEkqip+S4R97LIoB8e3y3W1hhpEbmRBjAk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
	MWHPR2201MB1135.namprd22.prod.outlook.com (10.174.171.37) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1835.13; Tue, 30 Apr 2019 20:10:43 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
	([fe80::b9d6:bf19:ec58:2765]) by
	MWHPR2201MB1277.namprd22.prod.outlook.com
	([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1835.018;
	Tue, 30 Apr 2019 20:10:43 +0000
From: Paul Burton <paul.burton@mips.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/7] MIPS: use the generic uncached segment support in
	dma-direct
Thread-Topic: [PATCH 5/7] MIPS: use the generic uncached segment support in
	dma-direct
Thread-Index: AQHU/0QLF7/q9Iq7YkyidXRkO+31J6ZVIwmA
Date: Tue, 30 Apr 2019 20:10:43 +0000
Message-ID: <20190430201041.536amvinrcvd2wua@pburton-laptop>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-6-hch@lst.de>
In-Reply-To: <20190430110032.25301-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0048.namprd06.prod.outlook.com
	(2603:10b6:a03:14b::25) To MWHPR2201MB1277.namprd22.prod.outlook.com
	(2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [12.94.197.246]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35a5d8c8-1a26-4e3c-c1ad-08d6cda7ec7d
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);
	SRVR:MWHPR2201MB1135; 
x-ms-traffictypediagnostic: MWHPR2201MB1135:
x-microsoft-antispam-prvs: <MWHPR2201MB113555E0F0052FB7F0F1CD61C13A0@MWHPR2201MB1135.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(7916004)(396003)(366004)(136003)(346002)(39850400004)(376002)(199004)(189003)(26005)(6486002)(11346002)(99286004)(229853002)(486006)(316002)(476003)(6436002)(478600001)(446003)(68736007)(52116002)(44832011)(7416002)(33716001)(256004)(3846002)(58126008)(8936002)(66066001)(54906003)(102836004)(6116002)(66446008)(66556008)(66476007)(6506007)(64756008)(66946007)(73956011)(386003)(71200400001)(6916009)(71190400001)(6512007)(9686003)(76176011)(53936002)(1076003)(14454004)(186003)(6246003)(81166006)(81156014)(2906002)(8676002)(97736004)(42882007)(4326008)(25786009)(305945005)(5660300002)(7736002)(41533002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR2201MB1135;
	H:MWHPR2201MB1277.namprd22.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: wavecomp.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +9J+Cn3aaCVj5xe7+TQH5xq4oPaO5heVqSkVR8aFAeIardtTcJ5USai7QKjeVnqLT0dRLRKj4EL31gCR0pyAmPKEZ2mDJFgJcrSwa0YdwN4G1Q/lrzx+e8HujouiScUDKH8LASpn1gYIkDugTTgpwB2n/jihyPYVsyAGn7dNsul/9WUqElkBxG04YOE3KQL00oVsfBh3Zgel+UGJ8gYPgvfmgfSmQY+zGiaCMyJoq9c5jykYaLJ6G1Fm1MjQdHvPP06BOmiDCCJxqjgSCbG3Cs3lV8uShxawxkIuiCzi/IGtOBhJi+WJ+3k3wagiT5fh82XUblVhJoRBpwLBYSE4sh5y6EXYgCRs83nM5nAdjy/ZY12/0/6PSov58ATY8rQ2+a1N2d0pdhPwje2qhMEr65j27W/H6+9RLldNJQvdNgM=
Content-ID: <D2BEEA2D04956B49845701064D9E0881@namprd22.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a5d8c8-1a26-4e3c-c1ad-08d6cda7ec7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:10:43.5014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1135
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
Message-ID: <20190430201043.pMwf3TUVNzrwSgYAea-asQ0Mr6o759x_1KOe8PztBsg@z>

Hi Christoph,

On Tue, Apr 30, 2019 at 07:00:30AM -0400, Christoph Hellwig wrote:
> diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
> index f9549d2fbea3..f739f42c9d3c 100644
> --- a/arch/mips/mm/dma-noncoherent.c
> +++ b/arch/mips/mm/dma-noncoherent.c
> @@ -44,33 +44,26 @@ static inline bool cpu_needs_post_dma_flush(struct device *dev)
>  	}
>  }
>  
> -void *arch_dma_alloc(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +void arch_dma_prep_coherent(struct page *page, size_t size)
>  {
> -	void *ret;
> -
> -	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
> -	if (ret && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
> -		dma_cache_wback_inv((unsigned long) ret, size);
> -		ret = (void *)UNCAC_ADDR(ret);
> -	}
> +	if (!PageHighMem(page))
> +		dma_cache_wback_inv((unsigned long)page_address(page), size);
> +}

This series looks like a nice cleanup to me - the one thing that puzzles
me is the !PageHighMem check above.

As far as I can see arch_dma_prep_coherent() should never be called with
a highmem page, so would it make more sense to either drop this check or
perhaps wrap it in a WARN_ON()?

Thanks,
    Paul
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
