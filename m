Return-Path: <SRS0=whWg=N5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA65C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 07:29:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C703610CB
	for <iommu@archiver.kernel.org>; Tue,  7 Sep 2021 07:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C703610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E81380C3D;
	Tue,  7 Sep 2021 07:29:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzFzPjNNwOIl; Tue,  7 Sep 2021 07:29:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4918880C0B;
	Tue,  7 Sep 2021 07:29:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21A57C000F;
	Tue,  7 Sep 2021 07:29:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2BE6C000D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C73C80C19
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzgGtfbRiATm for <iommu@lists.linux-foundation.org>;
 Tue,  7 Sep 2021 07:28:58 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300117.outbound.protection.outlook.com [40.107.130.117])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAFA280C0B
 for <iommu@lists.linux-foundation.org>; Tue,  7 Sep 2021 07:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed7Xev0Jizri5M5DUuKbPyNCFAiSOO+SOs3hZfPyd/rXUsHSkq0z8nvi32kR5e2gjzLpp6fNbMgQUIxXkYGvvqUt9z+YbZVJ2uQRPE/4kdEss3qoI0IjpplOt9Qs0r4uOIGKqbRJGzWN1xiecrsHmUlnmprPNDW4Jno6wCR0bPL3ltVaJ3ByaSJaR5ie4G6T1T9/ZkzWeZ9EhlS3FA1D0eL+UdrT19dJomoQxNLjhGa3BTl+FNP9QVwJSBYb40S/sNYnyNDzmgwGw6z1aVqXUCsxryZyaPrEpYw3AKiU2JKKtH/zpsSxl6ooBt3NBrYQVI9jSUQ/w6YAZqi/TUOinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=6+Cy2MB0039rXf3Q/K+tjH/P/o5Ht7H+bIoDd7azmQs=;
 b=SOmFThBatbTeFW0scqan8CvCLWU8zWzW1lJfV0P6Tj6toXHeO+RnEtJmPnTWTP3MzsboWTIDbwvbwvcvVGJFSJcZq+Qc7O0u9W0Ec1MQho3SdAcOEGNkfRU435H432mLt9Ec6Juv0Kt0Ch+5ffFgxWqbpQuCzRAX36Ow1wC9df0Ra8A77WdionswI2lyavXLR8U3Ok5Hlzh35HyBMmTtH19SHWwJCEhJBdlH9LzPuOW55/cCIWXCn51leBh3Izzwe3gP00EUgqaCoI7ycDWwc5MpJVEPozEtuc4G5p6MlzIX9CmEHbnSXnzksGOhbm6C80TDL5v8O6dP2cfOeV3kwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+Cy2MB0039rXf3Q/K+tjH/P/o5Ht7H+bIoDd7azmQs=;
 b=W+LaepwNBv1yAGuLe93AMwvRn+AKfWOcSO0ZQwad7+GGr3cnEPDxabajXYRGNd3+sPtvUrWJETr4ewDtauNiVO45Bp5kZajs4fVCkUxnUXanFeNF35NbhPWQbKJLrLsOw1fByXmiFGkDOSQn6PuNdO2cOpCYNpGInB0w7YzuBO4=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB2572.jpnprd01.prod.outlook.com (2603:1096:404:7a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Tue, 7 Sep
 2021 07:28:52 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b10a:f267:d52c:1e5b]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::b10a:f267:d52c:1e5b%3]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 07:28:52 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
Thread-Topic: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for r8a779a0
Thread-Index: AQHXnxvyoah/Riy0106C9EDQXIK2f6uXKuaAgACM7RCAAG6YAIAADYEw
Date: Tue, 7 Sep 2021 07:28:51 +0000
Message-ID: <TY2PR01MB36929B7C850349E2FA9E547BD8D39@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20210901102705.556093-1-yoshihiro.shimoda.uh@renesas.com>
 <20210901102705.556093-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXwf0_+VKfuiFQf6roZErz-JAm06P5RBzD-Jwm1uk=p9A@mail.gmail.com>
 <TY2PR01MB36928CB43B188D4082829A1FD8D39@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <CAMuHMdVmkJqiK3XB3s_ibnqy9SUSUFW6mny+kefOYaWi9Ce-4g@mail.gmail.com>
In-Reply-To: <CAMuHMdVmkJqiK3XB3s_ibnqy9SUSUFW6mny+kefOYaWi9Ce-4g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none; linux-m68k.org; dmarc=none action=none header.from=renesas.com; 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aefbcf26-3ed1-47a7-9c62-08d971d1244f
x-ms-traffictypediagnostic: TY2PR01MB2572:
x-microsoft-antispam-prvs: <TY2PR01MB25726D32B2FBA45BD29AC945D8D39@TY2PR01MB2572.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 75ypaK8Bsv2j1YkEQozPLaY9dxGDpD30Wz93/08Ezs3OwZRxL8fSvd4P5kbFsrNFfOAoCiBfGpB6919tiupWxgdbXJVIzo2vpHixsyANaSqF/dSIaaPIhToVRzMYBMEE9j9CMNImvRja9zvfHpVI1GymR/u0NpYLhT6qgy8ML4jutk37azjlNINDp1QTy7c8g0Bd1sk2+L4TGIe4xBR48iWuQn4JGj8RXcldCvuldfpqY1FWUs094O/J3onX+3GOnileS420BRT2N/XInNh6G2EqzjC4Ge5kOFnJuodjCZ/0WFVVCYOoA80GniQHeeY1WWaCz8Q+XvVyeMUiBDlBsKEm212NjC7rY8DWW/jTFXzg1lS/aKFaW3GAJs5HvO3WUDaHBqibd6La5M32m3g4oXn4Xtf6T6B20trUCF0XfPpHJUZzjDae0UZk1v55vcTHtlYqVRaUdI+15C4jwtJiFr9QWVK+jgeuLKWVi6kBrwT+q7yVQSYm+QDCfaLWE5w8wRV5k2nPOFbHJl9cw7/64yLwXl4AyuLCOS1boetOOHt7w1+tvwHyMiluHsU/bzTRtuxqjjWEEeFqQFzqr0lwDSswAQP6oE7uN1cCu2dQMCVZ4oMtcI7QrEUrmCzLny+AxDstgzw/IVVSGLpOF8sy87isElfyEl0KUO6rhtrX1AgSXeKfhhDVng1dNjJ+LekD/J4P0ixfZUvzlJatktcWfoya8CTrZzjR3aNa7ez5bH8qcP3380KRjiueMf71T/msMxUXuBB1Dpq3rbki+2hqGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(38100700002)(38070700005)(86362001)(53546011)(4326008)(55016002)(122000001)(6506007)(8936002)(478600001)(2906002)(66476007)(66446008)(26005)(5660300002)(52536014)(66556008)(64756008)(76116006)(71200400001)(54906003)(316002)(7696005)(186003)(9686003)(55236004)(33656002)(83380400001)(8676002)(66946007)(6916009)(138113003)(98903001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFY2R1R6QkRWYVVjYUQ5TVd5WlM0SWFwajliZDlpR1U5MmJTNWFuMFZiRWt1?=
 =?utf-8?B?VHJPQ2dvM0pIdGVyVXZSRUdkM3dCZnhqUnNyUkxBcU1zYXdJd0U4ZG1SQlhv?=
 =?utf-8?B?cll1Ti9peHhtVThZL1BwZ2k3eHRQRkE2OGlUdStyd3p1VTBOWXcwUDFXaXFU?=
 =?utf-8?B?L1p6dUJvQm5nSGp4WmRoMVpIdWVsLzk2djFoZ0xacjZ0V3RsSzU0bEZveXhl?=
 =?utf-8?B?MnVoTHVnNnNpazZPOVNPV1VHRWc1czFLSnE3aHRMb1pjVER1N3VxQnM1SVNJ?=
 =?utf-8?B?b0hEVWl0TC9xc0loUEZqQmlZVVY5Zis5aUducldqaWxySDBMazVPVzVqbHlh?=
 =?utf-8?B?RzJTSWhyT1ZPdGt4aE5hNnVjQmFMQTBqU2xtWGJybTZxQjNJSUlCbG4wTjRI?=
 =?utf-8?B?RnIvdzk5bHZabWJ5bnRLbExrQlBqYzkwMHNUcHNFSUFUcjZtdjVXd3VNOWxV?=
 =?utf-8?B?Y1U4VXdpZGpuMFFDbUl6eXg1aDdRZ25aSEsvWFk5dW9oUmIvUjhTVmQyUUpF?=
 =?utf-8?B?VWg2UTZjbjJWQkJxS2tLeUlZZHhqei9aaFo1TFZoRlEyL3l3M0oxMmlLbnZn?=
 =?utf-8?B?aHN3eFZYL20rL1pmTG1QZ05tN09RcmEyMnViR1BaaWdIK3BtK3pFZGJpWnpa?=
 =?utf-8?B?dEd2R0tHNlFtRGZuTGltdUFQR24wZXdRck1XUURneG1PUmxZUnFKQkRTRzFM?=
 =?utf-8?B?a0Z6R3ljSmxmM0RSbVU1bDd3TmtsTDlidjJYQlhWQjVMTWQ3QzVhR2ptcnJY?=
 =?utf-8?B?bDl1K1ZIK20vdE1naTFkbTZvVFhpODZTVFg1cW5PckN0TVhzdXloYmZ2Mlo0?=
 =?utf-8?B?WVVScGlQMGFRQlZQcDZwbzFMdDlSTUtLSm9ITFFjMzIzdisyalpFVll6RnpG?=
 =?utf-8?B?UGMvRHh4RExZa0JpUThldjRNMlRvTTh6ZTlaZFMxRFE2RVIxd0Y1aUQ3aklr?=
 =?utf-8?B?cGpiZW1Scytzb2ZmM3RDdDJkMG5qTnVxR3BjMkpnRElpT0tISjNUR0VGNlh5?=
 =?utf-8?B?SUJHTzVxSm1USWI4T01NcDFrdXozbGR5cHNYdTZIUDhnblM1Y3VWV2QvdXpL?=
 =?utf-8?B?QURZZ0JETWFxVkdHVXFZT21qbHJUejd5QzdteHpDMUZ1emtiajJ5SW4vWVJ0?=
 =?utf-8?B?WFBsRUh3YVRvdnFsNy9ZTHhFZVVYNjIyZFI0dVduTXQ1a05Ya2V4dU0zODAz?=
 =?utf-8?B?Y2VrOGFjZHBRUVRNZmFZek5qazFjREQxRkU3YUJ1V1Q2L2pHMkpzK0FwSElV?=
 =?utf-8?B?VTdhbWFDMEZCVmhSRnl5eEE3bWZLUUlmc0ZWOG80aXR6MlgvdkRmNy9Ld1g1?=
 =?utf-8?B?bldzUmJ1d0FoY0lleHBuK3dNYzkvaWlOazYybUtia0E2alNPSWpTVldlTGFL?=
 =?utf-8?B?MVhUSXRnZndaUE16MVBZeHdKOUtjOUdaK2FYdlN2TkdoS2p3ZVcremk2ZGFT?=
 =?utf-8?B?Q25FZStkbzlaYmVLSmtqWCt4SnpPVEJTY09KNW8rT1QyT0hReXluMm1Uc1Fo?=
 =?utf-8?B?Vmx1cVhEVXd1R2FNYm1xeTBBdFJxNkVUZk9JSkxwaGpUaEdYK09xcFNLU2d2?=
 =?utf-8?B?cjRQKzZac0FRZHdDMWw5QldLSXBDdk8xTC90Q0h4QWRRQ1JORlJJeHNpZDhH?=
 =?utf-8?B?Y3c5NEFrc3dubHBiemdHdDJITzU1QjlwaGlaL01Nc2FjWGJjN0tlblNUMzRy?=
 =?utf-8?B?b2dPNTNTYWF1UlZqdTFaVG9tWVVzTlFvNEd2bk9QV01adTNmQnc1dmxmTjI4?=
 =?utf-8?Q?JMcwtYxaslfHc6LYAMuE8DElE8RCK0beBZH3zCA?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefbcf26-3ed1-47a7-9c62-08d971d1244f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2021 07:28:51.9677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FzVnB3Zr39STKVdwei+czx7w7vn35Ir8MIUSRCmn3XBtOASCUzJNVzwAEfmwKUm4vZxSjbQC90JrF9LFhSuNrLDDqkUd6uBbETpPnHFxXbC8TAUWFdl6AfrDCH0Eoh5b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2572
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Tuesday, September 7, 2021 3:34 PM
> 
> Hi Shimoda-san,
> 
> On Tue, Sep 7, 2021 at 2:02 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Geert Uytterhoeven, Sent: Tuesday, September 7, 2021 12:34 AM
> > > On Wed, Sep 1, 2021 at 12:27 PM Yoshihiro Shimoda
> > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > Add support for r8a779a0 (R-Car V3U). The IPMMU hardware design
> > > > of this SoC differs than others. So, add a new ipmmu_features for it.
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > >
> > > > @@ -922,6 +922,20 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
> > > >         .utlb_offset_base = 0,
> > > >  };
> > > >
> > > > +static const struct ipmmu_features ipmmu_features_r8a779a0 = {
> > > > +       .use_ns_alias_offset = false,
> > > > +       .has_cache_leaf_nodes = true,
> > > > +       .number_of_contexts = 8,
> > >
> > > Shouldn't this be 16?
> > > Or do you plan to add support for more than 8 contexts later, as that
> > > would require increasing IPMMU_CTX_MAX, and updating ipmmu_ctx_reg()
> > > to handle the second bank of 8 contexts?
> >
> > I would like to add support for more than 8 contexts later because
> > I realized that ctx_offset_{base,stride} are not suitable for the second bank
> > of 8 contexts...
> 
> Wouldn't something like below be sufficient?

Thank you for your suggestion!

>  static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
>                                   unsigned int context_id, unsigned int reg)
>  {
> -       return mmu->features->ctx_offset_base +
> -              context_id * mmu->features->ctx_offset_stride + reg;
> +       unsigned int base = mmu->features->ctx_offset_base;
> +
> +       if (context_id > 7)
> +               base += 0x800 - 8 * 0x1040;

This should be "base += 0x800 - 8 * 0x40;" because the 8th context address is
0x18800, not 0x10800.

I'll send v2 patch to support 16 contexts.
(I'll change IPMMU_CTX_MAX to 16 too.)

Best regards,
Yoshihiro Shimoda

> +
> +       return base + context_id * mmu->features->ctx_offset_stride + reg;
>  }
> 
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
