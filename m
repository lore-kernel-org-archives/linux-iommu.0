Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C96C352A9
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 15:15:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC6E321D80
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="BwRdef99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6E321D80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C138AC8E;
	Thu, 26 Sep 2019 15:15:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6079B5F
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 15:15:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
	(mail-eopbgr1410125.outbound.protection.outlook.com [40.107.141.125])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7761C8C4
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 15:15:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=QklPmCAXsjQHOg5p4osrHkJmZQy/FM+fepyAx1gIASnc+xeKZGd1KCX3Z8GL9MyCc5FxPvx6YTGRtDRCivVJphSFU+wBvdfv4MJnOOrN/Pq/GkXwH1h+jib7U7Jm1CGIWTN2QmuRu0oXAWC7Z1Jc8cJLnPwb/DFSkxXg+PrasYO0abFvUui8LERKDGGwdS/uztPFVaM3HJ598h5A1X0O6B5RKYEiY7BFtXQGrMMctZISaf15w33/EHnJZV+RHgYGNlF3T/KtxV7Y7PewMILi5czrWRgoiBxj8QZuZ01LWCG+n08+HVt6Pe5+HhR4jpTC0ebNapgBumU/qieIwIap9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JXQEHryglQvLrDuZL0lZ22WNBJBSw7TLMHCFb9lls/s=;
	b=bcmwdKE5VP7O3M6BEFuVeBhqnZkcwnHXXpEDkEkaspIHWfRikoI+FCFyHRWFRwq0akHsnLdjkhhbj05n1Ff5kCq2R9JEMuNP7qap1H1e9krZez2hRaciKCL0lrUCQyD7MhmIFJqDYvVi/7p8twOROjmLbqpu7GY3oo3peCC3PdcRKhwTGOHHZ0b8DMMxjt6qBEOZ4C+LA1L3iYuuw6BA/fDZ1v6u6HrqLWHgKxy+RlqPZzRFtWruhnQFxCxXQAePR/+Pkh54TFgtibfwuhmrLFBvwhJEaR2RD2KpiXAYt6+o254dSMW+k1hnbda66lfOmbumjzaGKoz1D82N1LaA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
	header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=JXQEHryglQvLrDuZL0lZ22WNBJBSw7TLMHCFb9lls/s=;
	b=BwRdef999/jPoX88mbVMhrK2J6Wi8BhELl61BkEAr+VAa8YS3wLSXPX1FX8WvU85pn9R/HdVXwrCL0k+kmINrC5Tredesw4PlGpCWOgMCmO/9rksfnqQvoTt2ICoZTm6HGavMRmXWsenh9/5HdTlz2h3EZhtY8mCFHtP6UphtCE=
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com (52.134.242.17) by
	OSBPR01MB1736.jpnprd01.prod.outlook.com (52.134.227.139) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2284.26; Thu, 26 Sep 2019 15:15:00 +0000
Received: from OSBPR01MB2103.jpnprd01.prod.outlook.com
	([fe80::746b:49c1:925d:e9eb]) by
	OSBPR01MB2103.jpnprd01.prod.outlook.com
	([fe80::746b:49c1:925d:e9eb%5]) with mapi id 15.20.2284.023;
	Thu, 26 Sep 2019 15:15:00 +0000
From: Biju Das <biju.das@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code
Thread-Topic: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching code
Thread-Index: AQHVcqvBG43bY2WiV0uxVqBWaRSog6c+Ci+AgAAKlFA=
Date: Thu, 26 Sep 2019 15:15:00 +0000
Message-ID: <OSBPR01MB21038A984A1DC0FC9CCD17A8B8860@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1569310988-40746-1-git-send-email-biju.das@bp.renesas.com>
	<CAMuHMdWw=hkgXe_79s_zhxSQP2crtUNTpMjFeGDBbULwrDPpVg@mail.gmail.com>
In-Reply-To: <CAMuHMdWw=hkgXe_79s_zhxSQP2crtUNTpMjFeGDBbULwrDPpVg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=biju.das@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58e19f0c-182c-4530-2e1f-08d742944c82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:OSBPR01MB1736; 
x-ms-traffictypediagnostic: OSBPR01MB1736:|OSBPR01MB1736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB173654ECABCAB326E27D29FCB8860@OSBPR01MB1736.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0172F0EF77
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(51914003)(189003)(74316002)(14454004)(316002)(54906003)(7696005)(9686003)(55016002)(71200400001)(76176011)(53546011)(6506007)(66066001)(5660300002)(99286004)(8676002)(2906002)(81156014)(8936002)(102836004)(26005)(3846002)(81166006)(71190400001)(6246003)(66946007)(478600001)(11346002)(44832011)(14444005)(256004)(64756008)(66476007)(66556008)(186003)(6116002)(6916009)(76116006)(86362001)(6436002)(33656002)(4326008)(229853002)(486006)(66446008)(52536014)(476003)(25786009)(7736002)(446003)(305945005)(52103002)(158003001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:OSBPR01MB1736;
	H:OSBPR01MB2103.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:0; MX:1; 
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EfL3kr3GtpzlAlvSy3+PfW22GaG1RGSI4GEkhY7M1NgxitQW9tIZz+xQM8ZZJ5UuK6R2OEdC7dPm6O1TNPtklGOvLwEny6RhvSjrq10+m7hVL3NqgRDuJGCx1EDYo9QcFYBDgWbt6f2x5R+yIl2SPJT+NlTlcQEIFddgq6ZNW94pv14gWFdDfpAr73C5tuFYl8v8UyX6UeDaJ91ZvvWV+8w7lBA9nnsZe6bg5E4h0w1C56ph1zo2/Iamv2Ecq/+M4dSaukERvhTbvzzV+SpqaIlvTUpDJJSNFVz2Za0QCzFsb9vIxg47AizwxBh7PSR+g/7h42ltAmXSarafsyAEQk4Rr9nR6yDeYihwUY5KnIhURkiSCsa7KOiAMkJGrHpmDqW2RMQOsKhIIt/BTVHdeNS8O7r8swQkJRJel3hVUVE=
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e19f0c-182c-4530-2e1f-08d742944c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2019 15:15:00.1038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UpB7bGgDNAOih2yHTzkPJrDD4IMuHZ9Hb2EKk84WmH4sDDSwI6vmkfhRCv2/gmADiCtzwsq/2gcP3Pzqcj3jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1736
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Simon Horman <horms@verge.net.au>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Geert,

Thanks for the feedback.

> Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a774b1 DT matching
> code
> 
> Hi Biju,
> 
> On Tue, Sep 24, 2019 at 9:43 AM Biju Das <biju.das@bp.renesas.com> wrote:
> > Support RZ/G2N (R8A774B1) IPMMU.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> 
> >  static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
> >         { .soc_id = "r8a774c0", },
> > +       { .soc_id = "r8a774b1", },
> 
> Please preserve alphabetical sort order.
OK. Will send V2.


> >         { .soc_id = "r8a7795", .revision = "ES3.*" },
> >         { .soc_id = "r8a77965", },
> >         { .soc_id = "r8a77990", },
> 
> With the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
> m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
