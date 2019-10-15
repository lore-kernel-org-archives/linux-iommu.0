Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE65ECE58C
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:28:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F242064B
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="fquTLtHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F242064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6D1A3CC3;
	Tue, 15 Oct 2019 05:28:58 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B3C96C2C
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:28:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400103.outbound.protection.outlook.com [40.107.140.103])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2305A5D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=CY9LtJrNWz99aPvdMnG0EPRaI9lN3792hl03i3TjKytnnUy6LHTn+5PNWb8NNwzJ055srrOtNyIRiY7/AFTVpUE9M9Cux57IB2Ec+UOjZTsJ7b/x0LDxO3B71im/V/MvzPxXa6Q2dtZE87sm04RygYGrioZNUModQDeZWO8kWnJhcYnxm6jg5tqWQdivl4QRpWcHy0IBOGrW0awXtqGyWAKRC126rLK0cvN5q8cUibDy5HLBUXEOka4/QnWwLueWP67+lSINVNL/qb3RtnhtOfF77mgyjcWNVFcrzVHGk+f6srtsG3DBLzxIOutbvIIC/1TU0xO7nfA8Bxq7IUvFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=a17fE3H7Pa6A6k3bdmkywBlj9KQY/4p2C1/+Pgmlp2A=;
	b=XxXBK54qL8tpH83tZG9DPOvDn8N+aoLt1JLwddwZWL0eTEu2NcKJhqxR/MwG6Jy0VGRwuWxsTioEw4PFrd/XJvj/UR2y5/m72IAjz7f8lYGNBtlVXkxWclFvBbxmk3Axcwow7zwp9Gpj7ReGIpzlRXwTdLG8+Tlzg4SIFabjftDZUyVhHZm3+Qbmpd7bmQbMeppnx0xAhZjA+awo1gRmu6AboTj8Of9C9TYZy7Ge949uIVISqK0gAjdqNOb4yJvNKGajDxDKzNvsIZOFdrNV/9FU+t/gxtk3epg9ttsichRM0XAbFR+uwPFhUCeE4ofXYC2N8YC1fW+4be80o/6WMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=renesas.com;
	dmarc=pass action=none header.from=renesas.com; 
	dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=a17fE3H7Pa6A6k3bdmkywBlj9KQY/4p2C1/+Pgmlp2A=;
	b=fquTLtHWqCHEh0XIjPGKGobs1hqjM7NcU9wgSFsc0ca9WG3X/0XCIwUd2WXNxFm54Cr1HsBxaXs0PmSysZ4BD9p+6Kv8/5R3N68MspakJgeLPDjzOTWPsYRmks9YdMf4ToRKn1FYO4D4GmE1g1BACKFvW6iEzXULkY3KFurkPEc=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
	TYAPR01MB5229.jpnprd01.prod.outlook.com (20.179.173.81) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2347.16; Tue, 15 Oct 2019 05:28:54 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023;
	Tue, 15 Oct 2019 05:28:54 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 3/3] iommu/ipmmu-vmsa: Add utlb_offset_base
Thread-Topic: [PATCH 3/3] iommu/ipmmu-vmsa: Add utlb_offset_base
Thread-Index: AQHVfntNLlJCEf0ASk+p9SghIphMRKdVYuwAgAXS1YA=
Date: Tue, 15 Oct 2019 05:28:54 +0000
Message-ID: <TYAPR01MB45443D65491480D1F95ACECCD8930@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdW-Z9xkE5Eh7rbgufHSDvqoPyRJgsFhp_Ne9uk2XfUnEg@mail.gmail.com>
In-Reply-To: <CAMuHMdW-Z9xkE5Eh7rbgufHSDvqoPyRJgsFhp_Ne9uk2XfUnEg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c756eacb-417f-41ce-3a5f-08d7513091e2
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB5229:
x-microsoft-antispam-prvs: <TYAPR01MB5229F879D43DBC1B4CFE792DD8930@TYAPR01MB5229.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(199004)(189003)(26005)(8676002)(11346002)(446003)(486006)(256004)(66066001)(186003)(476003)(8936002)(86362001)(64756008)(229853002)(6436002)(66556008)(66476007)(81156014)(76116006)(66946007)(66446008)(74316002)(7736002)(305945005)(81166006)(33656002)(99286004)(478600001)(4326008)(6506007)(102836004)(7696005)(76176011)(53546011)(9686003)(55016002)(6916009)(14454004)(25786009)(71200400001)(71190400001)(2906002)(52536014)(54906003)(5660300002)(3846002)(6116002)(316002)(6246003);
	DIR:OUT; SFP:1102; SCL:1; SRVR:TYAPR01MB5229;
	H:TYAPR01MB4544.jpnprd01.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: renesas.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLEiXfLfr6RaNQjJ6hr9CYiUkv5eNJf3TrD9tHIWNzhdXEZ8o2Qd4/lkdt9v2eJASc/Tp4JlSROsz7s00iosc77AeDRk2nEDeXSYtDYs7bsJhXQvhW+uDGGIYAFXcJFnJkDgKUiCQkJD824FJv/q0JNgu7JvlaJiJCBgghs1SEQnMWZdS3U3KVekRX8NezRg4gpBBdA5lbIlfBKWAebSrSSdDlqtm1PQo6vcdBxDPBvgcZ9pOkRC78bJFr00WNDPFF8gJZraLBUBdkZpJTcTrHVB3vfcBoUcG3UscUbZT0BGPYLyLKozqyVE6B3dUgPuIDSMm/V4n26Y4594MlnnL4ewLU0AEI3x9+Zy3t8AS2ry9JpqdGwovf7+lV1THCRPX0xy1c6aEJ93FWcadVXfajFfH1YHKKIHNkxvgbXVSKI=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c756eacb-417f-41ce-3a5f-08d7513091e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 05:28:54.2088 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4l2Ql/17BQaTSMkzSoK0iWNb2BWm1eL3qDkul5pqctYAlb1FQ2Xf45wsDY2RUdMuWCy51NnC1XfzaCkMxcfolGpe/MEBsQlM7KJJHAKSGhNilpguKYD2etVOtQosLWiR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5229
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Friday, October 11, 2019 9:32 PM
> 
> Hi Shimoda-san,
> 
> On Wed, Oct 9, 2019 at 10:27 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Since we will have changed memory mapping of the IPMMU in the future,
> > this patch adds a utlb_offset_base into struct ipmmu_features
> > for IMUCTR and IMUASID registers.
> > No behavior change.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -52,6 +52,7 @@ struct ipmmu_features {
> >         bool cache_snoop;
> >         u32 ctx_offset_base;
> >         u32 ctx_offset_stride;
> > +       u32 utlb_offset_base;
> >  };
> >
> >  struct ipmmu_vmsa_device {
> > @@ -285,6 +286,11 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
> >         ipmmu_ctx_write_root(domain, reg, data);
> >  }
> >
> > +static u32 ipmmu_utlb_reg(struct ipmmu_vmsa_device *mmu, unsigned int reg)
> > +{
> > +       return mmu->features->utlb_offset_base + reg;
> > +}
> > +
> >  /* -----------------------------------------------------------------------------
> >   * TLB and microTLB Management
> >   */
> > @@ -330,9 +336,9 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
> >          */
> >
> >         /* TODO: What should we set the ASID to ? */
> > -       ipmmu_write(mmu, IMUASID(utlb), 0);
> > +       ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUASID(utlb)), 0);
> >         /* TODO: Do we need to flush the microTLB ? */
> > -       ipmmu_write(mmu, IMUCTR(utlb),
> > +       ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUCTR(utlb)),
> >                     IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
> >                     IMUCTR_MMUEN);
> 
> Like in [PATCH 2/3], I think providing two helpers would make this more
> readable:
> 
>     ipmmu_imuasid_write(mmu, utlb, 0);
>     ipmmu_imuctr_write(mmu, utlb, data);

I agree. I'll fix it.

Best regards,
Yoshihiro Shimoda

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
