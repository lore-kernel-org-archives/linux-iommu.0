Return-Path: <SRS0=Xkoz=YG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1544C4360C
	for <iommu@archiver.kernel.org>; Sun, 13 Oct 2019 03:00:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375302089C
	for <iommu@archiver.kernel.org>; Sun, 13 Oct 2019 03:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375302089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DFF4821E9;
	Sun, 13 Oct 2019 03:00:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E23E721E0
	for <iommu@lists.linux-foundation.org>;
	Sun, 13 Oct 2019 02:49:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from listssympa-test.colorado.edu (listssympa-test.colorado.edu
	[128.138.129.156])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BB9D86CE
	for <iommu@lists.linux-foundation.org>;
	Sun, 13 Oct 2019 02:49:30 +0000 (UTC)
Received: from listssympa-test.colorado.edu (localhost [127.0.0.1])
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/sympa) with
	ESMTPS id x9D2nKQx013910
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); 
	Sat, 12 Oct 2019 20:49:21 -0600
Received: (from root@localhost)
	by listssympa-test.colorado.edu (8.15.2/8.15.2/MJC-8.0/submit) id
	x9D2nJlE013867; Sat, 12 Oct 2019 20:49:19 -0600
Received: from BN8PR03MB4851.namprd03.prod.outlook.com (2603:10b6:a03:100::34)
	by BYAPR03MB4376.namprd03.prod.outlook.com with HTTPS via
	BYAPR08CA0021.NAMPRD08.PROD.OUTLOOK.COM; Wed, 9 Oct 2019 23:08:54 +0000
Received: from DM6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:100::48) by
	BN8PR03MB4851.namprd03.prod.outlook.com (2603:10b6:408:6e::11) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16;
	Wed, 9 Oct 2019 17:58:10 +0000
Received: from BN3NAM01FT045.eop-nam01.prod.protection.outlook.com
	(2a01:111:f400:7e41::200) by DM6PR03CA0071.outlook.office365.com
	(2603:10b6:5:100::48) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2347.16 via
	Frontend Transport; Wed, 9 Oct 2019 17:58:10 +0000
Received: from ipmx7.colorado.edu (128.138.128.233) by
	BN3NAM01FT045.mail.protection.outlook.com (10.152.66.101) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384)
	id 15.20.2347.16 via Frontend Transport; Wed, 9 Oct 2019 17:58:09 +0000
Received: from ipmx4.colorado.edu ([128.138.67.75])  by mx.colorado.edu with
	ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 11:07:14 -0600
Received: from mx-spsc.colorado.edu (HELO mx.colorado.edu) ([128.138.67.77]) by
	mx.colorado.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2019
	10:39:11 -0600
Received: from vger.kernel.org ([209.132.180.67]) by mx.colorado.edu with
	ESMTP; 09 Oct 2019 10:18:19 -0600
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
	S1731734AbfJIQSS (ORCPT <rfc822; michael.gilroy@colorado.edu>);
	Wed, 9 Oct 2019 12:18:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35238 "EHLO ale.deltatee.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP        id
	S1731688AbfJIQSS (ORCPT <rfc822; linux-kernel@vger.kernel.org>); Wed,
	9 Oct 2019 12:18:18 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
	helo=[192.168.11.155])        by ale.deltatee.com with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)        (Exim 4.89)       
	(envelope-from <logang@deltatee.com>)        id 1iIEfE-0007Md-Fx;
	Wed, 09 Oct 2019 10:18:13 -0600
Authentication-Results: spf=none (sender IP is 128.138.128.233)
	smtp.mailfrom=vger.kernel.org; 
	o365.colorado.edu; dkim=none (message not signed)
	header.d=none;o365.colorado.edu; dmarc=none action=none
	header.from=deltatee.com;
Received-SPF: None (protection.outlook.com: vger.kernel.org does not designate
	permitted sender hosts)
Authentication-Results-Original: mx.colorado.edu;
	dkim=none (message not signed) header.i=none
IronPort-SDR: BJojYsOHWW2eAdhVFmaFEuYrmoQqfxkRxW9P2UFfvHnX1G/BwWhEY4hobRHZqVwmBbMf+qSkuq
	vliR6skdAbqkDFvGOOdM1VAHzkTCaOj4I=
IronPort-SDR: IdGsJRsY4PhgK79eI17GUAEfWXWB9cZij2CuO38JbpBE6jv0G1O4lRjEYe6mrQdn6EOEX8yOYu
	5IbcwQs8G0B8MofhawbHwkkkOWMsJ8LUQ=
IronPort-SDR: u5p9AvVlm7Iu6F/k0s8Qpho6Ic5LXtX8LzjXzJnr1TFjsq2lsomZ8Av43I6vZ68+EDnUwXuhP4
	8UHrSPjg7rTkh+EB7a1Y8BtoxECH1UeNc=
IronPort-PHdr: =?us-ascii?q?9a23=3ATgFgOhVclpTegs69l/qHm7fwRDTV8LGuZFw894?=
	=?us-ascii?q?YnhrRSc6+q45XlOgnl6O5wiEPSA9yJ7uICgO3StLrpVWtG7Jqc4zgOc51JAh?=
	=?us-ascii?q?kCj8he3wktG9WMBkCzKvn2Jzc7E8JPWB4t/3yyPUVPXserYVrUr3A=3D?=
IronPort-PHdr: =?us-ascii?q?9a23=3AUKrUIRTXyaS4J4HfW5Q/7tKV3Npsv++ubCcI9p?=
	=?us-ascii?q?oqja5Pea2//pPkeXbS/uhpkESXBNfe+7RPjO7RqansXioN7YvS+HwBcZkZUR?=
	=?us-ascii?q?gDhI1WmgE7G8eKBAX9K+KidC01GslOFRdl8ni3PFITGZP4YFvfrw=3D=3D?=
IronPort-PHdr: =?us-ascii?q?9a23=3ApT0MaBXEW1ym142K0Sbsyhv81LbV8LGuZFw894?=
	=?us-ascii?q?YnhrRSc6+q45XlOgnl6O5wiEPSA9yJ7uICgO3StLrpVWtG7Jqc4zgOc51JAh?=
	=?us-ascii?q?kCj8he3wktG9WMBkCzKvn2Jzc7E8JPWB4t/3yyPUVPXserYVrUr3A=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0FfAAD+Hp5dbUtDioBlGQEBAQEBAQE?=
	=?us-ascii?q?BAQEBAQEBAQEBEQEBAQEBAQEBAQEBgXuCGwVvUx0SKoQjiQKHRSWDbpctFAE?=
	=?us-ascii?q?BAQEBAQEBAQgYFQIBAQGHESM4EwIDCQEBAQMBAQECAQUCAQECAhANCwkGK4V?=
	=?us-ascii?q?AhiABAQEBAwECIFYGCQEBCg4HAwICJgICA1QGDQYCAQEBgx2CeAWvdXWBMoV?=
	=?us-ascii?q?Ngy2BSIEMKIwOGIFAP4E4DIJfPodSgl4ElidElliCLGqUKSGZQC2nXoFpgXt?=
	=?us-ascii?q?NIxWDJ1AQFJA0VYEIkBMBAQ?=
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ErAABnDZ5dfU1DioBlGQEBAQEBAQE?=
	=?us-ascii?q?BAQEBAQEBAQEBEQEBAQEBAQEBAQEBgXuCG3NwEiqEI4kCh0Qlg26XLRQBAQE?=
	=?us-ascii?q?BAQEBAQEIGBUCAQEBhzQ4EwIDCQEBAQMBAQECAQUCAQECAhABAQkWCIVphiA?=
	=?us-ascii?q?BAQEBAwECIFYGCQEBCg4HAwICJgICA1QGDQYCAQEBgx2CCwWvcXWBMoVNgy+?=
	=?us-ascii?q?BSCBsKIwmgUA/gTgMgl8+h1KCWASWJ0SWWIIsapQpIZlALadegWmBe00jFYM?=
	=?us-ascii?q?nUBAUkDQkMYEIk10BAQ?=
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0FCAABKBp5dh0O0hNFlGgEBAQEBAQE?=
	=?us-ascii?q?BAQMBAQEBEQEBAQICAQEBAYF7ghtzUTEqhCOQRiUUg1qXLRQBAQEBAQEBAQE?=
	=?us-ascii?q?IGBQBAgEBAYcRIzgTAgMJAQEBAwEBAQIBBQIBAQICEAEBAQoLCQgphUCGIAE?=
	=?us-ascii?q?BAQEDAQIgVgYJAQEKDgcDAgImAgIDVAYNBgIBAQGDHYILBa9edYEyhU2DLoF?=
	=?us-ascii?q?IgQwojA4YgUA/gTgMgl8+h1KCWASWJ0SWWIIsapQpIZlALadegWmBe00jFYM?=
	=?us-ascii?q?nUBAUkDQjMoEGAQGTXQEB?=
X-IPAS-Result: =?us-ascii?q?A0FfAAD+Hp5dbUtDioBlGQEBAQEBAQEBAQEBAQEBAQEBE?=
	=?us-ascii?q?QEBAQEBAQEBAQEBgXuCGwVvUx0SKoQjiQKHRSWDbpctFAEBAQEBAQEBAQgYF?=
	=?us-ascii?q?QIBAQGHESM4EwIDCQEBAQMBAQECAQUCAQECAhANCwkGK4VAhiABAQEBAwECI?=
	=?us-ascii?q?FYGCQEBCg4HAwICJgICA1QGDQYCAQEBgx2CeAWvdXWBMoVNgy2BSIEMKIwOG?=
	=?us-ascii?q?IFAP4E4DIJfPodSgl4ElidElliCLGqUKSGZQC2nXoFpgXtNIxWDJ1AQFJA0V?=
	=?us-ascii?q?YEIkBMBAQ?=
X-IPAS-Result: =?us-ascii?q?A0ErAABnDZ5dfU1DioBlGQEBAQEBAQEBAQEBAQEBAQEBE?=
	=?us-ascii?q?QEBAQEBAQEBAQEBgXuCG3NwEiqEI4kCh0Qlg26XLRQBAQEBAQEBAQEIGBUCA?=
	=?us-ascii?q?QEBhzQ4EwIDCQEBAQMBAQECAQUCAQECAhABAQkWCIVphiABAQEBAwECIFYGC?=
	=?us-ascii?q?QEBCg4HAwICJgICA1QGDQYCAQEBgx2CCwWvcXWBMoVNgy+BSCBsKIwmgUA/g?=
	=?us-ascii?q?TgMgl8+h1KCWASWJ0SWWIIsapQpIZlALadegWmBe00jFYMnUBAUkDQkMYEIk?=
	=?us-ascii?q?10BAQ?=
X-IPAS-Result: =?us-ascii?q?A0FCAABKBp5dh0O0hNFlGgEBAQEBAQEBAQMBAQEBEQEBA?=
	=?us-ascii?q?QICAQEBAYF7ghtzUTEqhCOQRiUUg1qXLRQBAQEBAQEBAQEIGBQBAgEBAYcRI?=
	=?us-ascii?q?zgTAgMJAQEBAwEBAQIBBQIBAQICEAEBAQoLCQgphUCGIAEBAQEDAQIgVgYJA?=
	=?us-ascii?q?QEKDgcDAgImAgIDVAYNBgIBAQGDHYILBa9edYEyhU2DLoFIgQwojA4YgUA/g?=
	=?us-ascii?q?TgMgl8+h1KCWASWJ0SWWIIsapQpIZlALadegWmBe00jFYMnUBAUkDQjMoEGA?=
	=?us-ascii?q?QGTXQEB?=
X-IronPort-AV: E=Sophos; i="5.67,277,1566885600"; d="scan'208"; a="287172467"
X-IronPort-AV: E=Sophos; i="5.67,276,1566885600"; d="scan'208"; a="369211590"
X-IronPort-AV: E=Sophos; i="5.67,276,1566885600"; d="scan'208"; a="369151373"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-Original-Recipients: gasiewsk@o365.colorado.edu
X-Original-Recipients: migi9492@g.colorado.edu
To: "Christoph Hellwig" <hch@infradead.org>
References: <20191008221837.13067-1-logang@deltatee.com>
	<20191008221837.13067-2-logang@deltatee.com>
	<20191009065750.GA17832@infradead.org>
From: "Logan Gunthorpe" <logang@deltatee.com>
Message-ID: <c5f6750f-b415-3562-9abe-0937bae94f75@deltatee.com>
Date: Wed, 9 Oct 2019 10:17:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009065750.GA17832@infradead.org>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: kchow@gigaio.com, joro@8bytes.org,
	iommu@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/3] iommu/amd: Implement dma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
X-MS-Exchange-Organization-ExpirationStartTime: 09 Oct 2019 17:58:09.7323 (UTC)
X-MS-Exchange-Organization-ExpirationStartTimeReason: OriginalSubmit
X-MS-Exchange-Organization-ExpirationInterval: 1:00:00:00.0000000
X-MS-Exchange-Organization-ExpirationIntervalReason: OriginalSubmit
X-MS-Exchange-Organization-Network-Message-Id: 4924aeaf-bd7e-48e8-cd09-08d74ce23ede
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-Forefront-Antispam-Report: CIP:128.138.128.233; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:SKN; SFS:; DIR:INB; SFP:; SCL:-1; SRVR:BN8PR03MB4851;
	H:ipmx7.colorado.edu; FPR:; SPF:None; LANG:en; ; SKIP:1; 
X-MS-Exchange-Organization-AuthSource: BN3NAM01FT045.eop-nam01.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-OriginatorOrg: colorado.edu
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4924aeaf-bd7e-48e8-cd09-08d74ce23ede
X-MS-TrafficTypeDiagnostic: BN8PR03MB4851:|BN8PR03MB4851:
X-MS-Exchange-Organization-SCL: -1
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Microsoft-Antispam: BCL:0;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2019 17:58:09.4871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4924aeaf-bd7e-48e8-cd09-08d74ce23ede
X-MS-Exchange-CrossTenant-Id: 3ded8b1b-070d-4629-82e4-c0b019f46057
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3ded8b1b-070d-4629-82e4-c0b019f46057;
	Ip=[128.138.128.233]; Helo=[ipmx7.colorado.edu]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4851
X-MS-Exchange-Transport-EndToEndLatency: 05:10:46.2162871
X-MS-Exchange-Processed-By-BccFoldering: 15.20.2347.014
X-Microsoft-Antispam-Mailbox-Delivery: ucf:0; jmr:0; ex:0; auth:0; dest:I;
	ENG:(750127)(520002050)(944506383)(944626516); 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6GJb0Mvqf2jjXmK7iosLrkmeB5tvN4+cWZpXyBONbuv6RfCrwmTu5p0ommul?=
	=?us-ascii?Q?Rinri221W7owKSWjJ8/eme/Fmu1YyshbVsiI2NBzM983+IfeE3enkFHkmQUK?=
	=?us-ascii?Q?aYIy2qYIrggIuiY/okFdiSLtmZQiTjDehjficxglqE5eNjIk8ypcah9RmE4v?=
	=?us-ascii?Q?2rnA6gkLiw/U243yc8laJbJV+UIQMIKnu27JfkLvtPaFJCHvWmPPdlzxR/Yd?=
	=?us-ascii?Q?jSUdQWZxy8w7qCZyx1TtxrKSXrRfhXjIX/OhKQFjM8mA4xC86kgukV9tpEyT?=
	=?us-ascii?Q?YAmebxAu8ubZVf8dNq9Obut+KTX3uqCI7+PmhdckAk2QRorspcdV68PpAeMs?=
	=?us-ascii?Q?lIJGPHjWNKnJqhLC4JVmMaVLtkCZsDUi/VOw5U/fJ0WuGadmzWB94lixn2nK?=
	=?us-ascii?Q?yVhuwPu5IpB6O7cVW0AJrjYr6OdEkKdKTcMWKvjJ+4Qm0IC8AZTTL3B0Q7xO?=
	=?us-ascii?Q?s3e6wT7j+VrTFGR0GRAxnIJvPyh358eQCuJUfhm7fb98W4Kp9kHFJSHC/o9c?=
	=?us-ascii?Q?87eeYwQwRXUYE9NPXL3RW3K79grVEUCLpwzV+mtg1avmHBFNKHOrGFBs3nli?=
	=?us-ascii?Q?qMKrq6iiYScq4GFZ83FI6paYt1OR50SY+BjG4BmaobDg2Eao8y8w6wXCkVjx?=
	=?us-ascii?Q?fot6QCe7Vl8Y4bg4go+HFZY0LDz8P2jDtlLuzk3ljr3xuNRwQByGxeGTBXgj?=
	=?us-ascii?Q?0y6TKhFr4tpMRghFOhFKfutWkPfaRRJ+Araet4Pjo3EjM7WrLEDD7dMTvnEv?=
	=?us-ascii?Q?dn1/Pp3UO/GxR1i0Cg2JEfwTVmgtle6n+UC5Lq5f5UJMPRG2R0ohjwNKcpV1?=
	=?us-ascii?Q?g9bL2GQM/evMG3EDqQVxSf/qiyG6GIfxqH9IJfXql2TjDmiK3BG3HACzt1rp?=
	=?us-ascii?Q?MOUKmdCJNHba/RbOngEd/HWr6jJnWUERYlvqfmA5h/OIdS4do8P4OaaB/TZs?=
	=?us-ascii?Q?R2W/xy9KGb4WOhUe4C9YrQD49h6OHzqapAXX0dhCVw+iJUuqo34OrB2Voh3N?=
	=?us-ascii?Q?GXn3YKMV0+IajPIY8xR5vRp8cQ2IaCpI8t2Eaq6WYEQTMbVLawl9zfeN52Qw?=
	=?us-ascii?Q?SqpDxf8qnNNCH4EoFUHBT7Kjar7DPsqehPkmnIGAS1MhsjKSrk9lpWbl0hBe?=
	=?us-ascii?Q?/xwrOdz5fVbWXIHwfbHhR29E4Nt82lqvRVRQhQuu5g6l83Xu1ldco2/t4NSe?=
	=?us-ascii?Q?4vclLecYSvl93W2I?=
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Kit Chow <kchow@gigaio.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Message-ID: <20191009161736.cjfxHKTCXzSHOFZXOboYc73lgMbIB19lE3Av9SD6niM@z>



On 2019-10-09 12:57 a.m., Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 04:18:35PM -0600, Logan Gunthorpe wrote:
>> From: Kit Chow <kchow@gigaio.com>
>>
>> Currently the Intel IOMMU uses the default dma_[un]map_resource()
> 
> s/Intel/AMD/ ?

Oops, yes, my mistake.

>> +static dma_addr_t map_resource(struct device *dev, phys_addr_t paddr,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct protection_domain *domain;
>> +	struct dma_ops_domain *dma_dom;
>> +
>> +	domain = get_domain(dev);
>> +	if (PTR_ERR(domain) == -EINVAL)
>> +		return (dma_addr_t)paddr;
> 
> I thought that case can't happen anymore?
> 
> Also note that Joerg just applied the patch to convert the AMD iommu
> driver to use the dma-iommu ops.  Can you test that series and check
> it does the right thing for your use case?  From looking at the code
> I think it should.

Yes, looking at the new code, it looks like this patch will not be
needed. So we can drop it. We'll test it to make sure.

I believe the other two patches in this series are still needed though.

Thanks,

Logan



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
