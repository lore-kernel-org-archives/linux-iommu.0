Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF60C10F14
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:28:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA8F2064B
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 05:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="r0VSa+55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA8F2064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2EC2CCD4;
	Tue, 15 Oct 2019 05:28:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4CB0BCCE
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:28:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
	(mail-eopbgr1400121.outbound.protection.outlook.com [40.107.140.121])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 125355D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 05:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=PIqQwpJwYW7kWVmJJn0TiMId/Rfb1PgUwiepfEw/bQ9F4rIdt5eitPIuWU2mAJequGZo0mf6LCpVmFz6K2fAaCYzjJwUoupksP0bZJ8Fm/aRkohlozr+X8k4T/bLQ6SqVqo/98tiTd+DBdvYzePELuLc5wje/DkpMZg4tV2L0vTwsXcvmjMlG09OmeuiCKkJfWA2WBMAbnMoGLks4hEsRX2bl6lHWF+D88QszrRXB9HqTI+sl0uWma9E8OGgyp17yht76wJfnE34Q/xkFe1ebn+m0+GyPEbdqJBHFtp0c85V6HX3XU04FQEB4AEM0PMbh5Lw7KfKQxeD4b5js6Xx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QelUmAPW/GgTuV0owG7bBbuKiZJq7V14QjPjTuItX9U=;
	b=aG5boPaYrzwD3kj7wZTZZiDoemSoZCl8tWGIb/5f1Sy0jK3CcW3i0RWUFeX8qUAEP2kh2TQz4hdYNnqlHrprUBuuAzEHPCGMy7BTAV0rCCLD7Ot0iGqbLpvvdY4z6wIlwJomHbutTkBqz5HvNfZADERPHFraSSD+zOUte/sZpnkclhMX2bcUWuQOK7nJYzzdg+RwQNkt41CESCsM25Ki4S6khEenpONK6XTLZpCLu8C79njL+yUdF9DabC5RDAS9py1eVRRyK7WQe8pz7/PSiPPXEnON9zI6qBI6cnaxEq9osPwYvGZAOBu12xbcUfVauxDAfKQNSMvfJTBMrTQxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=renesas.com;
	dmarc=pass action=none header.from=renesas.com; 
	dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=QelUmAPW/GgTuV0owG7bBbuKiZJq7V14QjPjTuItX9U=;
	b=r0VSa+554yvAJX3L96m9WC/Bu2RI8kCnkwsv4GaMKpAWRqk3SarZ3jaD4Z1bi9A6WF6VGTtiP0Jc7lAcHUCuEGlsqHivo1UzNNsUgFNAOz7JWK82N5Rlel2bKEZTOJI1A8eUiOGOapCTEEtG5ejllBGshCVWG8HMa++jw66qGXs=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
	TYAPR01MB5229.jpnprd01.prod.outlook.com (20.179.173.81) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2347.16; Tue, 15 Oct 2019 05:28:00 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::548:32de:c810:1947]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
	([fe80::548:32de:c810:1947%4]) with mapi id 15.20.2347.023;
	Tue, 15 Oct 2019 05:28:00 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2/3] iommu/ipmmu-vmsa: Calculate context registers' offset
	instead of a macro
Thread-Topic: [PATCH 2/3] iommu/ipmmu-vmsa: Calculate context registers'
	offset instead of a macro
Thread-Index: AQHVfntNJwDAogugWk+c3XT+CqZTpadVYhSAgAXSjeA=
Date: Tue, 15 Oct 2019 05:28:00 +0000
Message-ID: <TYAPR01MB4544DB942C8B4F016E043B21D8930@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <1570609609-1332-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1570609609-1332-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXv3ChOHO7RyOjQ0mL+9ugRFWnMUw7MfYD-9aU+ZZMSTQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXv3ChOHO7RyOjQ0mL+9ugRFWnMUw7MfYD-9aU+ZZMSTQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [150.249.235.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2fcfd06-901f-4064-0a45-08d7513071f8
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: TYAPR01MB5229:
x-microsoft-antispam-prvs: <TYAPR01MB5229783F27077E8FAEE82638D8930@TYAPR01MB5229.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
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
x-microsoft-antispam-message-info: M+DGxdUac5NJkzn+1l/r8II4uKjkmEDZVrsYCrslAYQ+rFxufkiaj4V87fKMPQ96MogFpO4aRgPurjQERTdA+ytRvITylFk4sh7ia4ve+Z0v6tN1mGr9dEA09PjqZ2rYDO034RfePVknp2TKQEJNqLTgC5KFYYKdtMVRKYZ/6IzmA/TatnGv3d36u2gmDYjkpa2CpPNbNTmheYK4iFCbQI4wPCBwYZ9elqJPn4hmW5trtv68K7/vYPoydxjow5YeHC21GMiE0/s/6kXDaI5tBUx2LtEaDdvS0RiDNIH33vLJ+b8/YPf8zs8uqlRmS1TECy1g6WR3qRvv+Ragc62pnCLyAivjWQlZLauyY45pVxNg9dBy0cUzcMGX+dkFMXxOtOQ0fb6I9dXcZ3MZj5J0O7JX88JpzEAWpiFDbSHyHhA=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fcfd06-901f-4064-0a45-08d7513071f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 05:28:00.6436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sa4KQY98oDGrIvbOB7/A80Q8TcDlbt3Ql4faFEHSrorfFfhoe+EPKRBIqLrmfNP0Y5dsEQWMw6msaHigQ34rUaI7ciHKgZIfoiG6CdQ8I3g3fKmQL+tNiVsLh+bKUR3C
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

> From: Geert Uytterhoeven, Sent: Friday, October 11, 2019 9:29 PM
> 
> Hi Shimoda-san,
> 
> On Wed, Oct 9, 2019 at 10:27 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > Since we will have changed memory mapping of the IPMMU in the future,
> > this patch uses ipmmu_features values instead of a macro to
> > calculate context registers offset. No behavior change.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -50,6 +50,8 @@ struct ipmmu_features {
> >         bool twobit_imttbcr_sl0;
> >         bool reserved_context;
> >         bool cache_snoop;
> > +       u32 ctx_offset_base;
> > +       u32 ctx_offset_stride;
> >  };
> >
> >  struct ipmmu_vmsa_device {
> > @@ -99,8 +101,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
> >
> >  #define IM_NS_ALIAS_OFFSET             0x800
> >
> > -#define IM_CTX_SIZE                    0x40
> > -
> >  #define IMCTR                          0x0000
> >  #define IMCTR_TRE                      (1 << 17)
> >  #define IMCTR_AFE                      (1 << 16)
> > @@ -253,18 +253,25 @@ static void ipmmu_write(struct ipmmu_vmsa_device *mmu, unsigned int offset,
> >         iowrite32(data, mmu->base + offset);
> >  }
> >
> > +static u32 ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu, unsigned int context_id,
> > +                        unsigned int reg)
> > +{
> > +       return mmu->features->ctx_offset_base +
> > +              context_id * mmu->features->ctx_offset_stride + reg;
> > +}
> > +
> >  static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
> >                                unsigned int reg)
> >  {
> >         return ipmmu_read(domain->mmu->root,
> > -                         domain->context_id * IM_CTX_SIZE + reg);
> > +                         ipmmu_ctx_reg(domain->mmu, domain->context_id, reg));
> 
> For consistency:
> 
>     ipmmu_ctx_reg(domain->mmu->root, ...)
> 
> but in practice the features for domain->mmu and domain->mmu->root are
> identical anyway.
> 
> >  }
> >
> >  static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
> >                                  unsigned int reg, u32 data)
> >  {
> >         ipmmu_write(domain->mmu->root,
> > -                   domain->context_id * IM_CTX_SIZE + reg, data);
> > +                   ipmmu_ctx_reg(domain->mmu, domain->context_id, reg), data);
> 
> Likewise:
> 
>     ipmmu_ctx_reg(domain->mmu->root, ...)?

Thank you for the comments! Yes, we can use domain->mmu->root to ipmmu_ctx_reg()
because ipmmu_ctx_reg() only use mmu->features.

> I find these ipmmu_{read,write}() a bit hard too read, with passing the
> mmu to both ipmmu_{read,write}() and ipmmu_ctx_reg().

I completely agree.

> What do you think about providing two helpers ipmmu_ctx_{read,write}(),
> so all users can just use e.g.
> 
>     ipmmu_ctx_write(mmu, context_id, reg, data);
> 
> instead of
> 
>     ipmmu_write(mmu, ipmmu_ctx_reg(mmu, context_id, reg), data);
> 
> ?

I think so. I'll fix it. Perhaps, I'll make a patch which changes
the function name at first.

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
