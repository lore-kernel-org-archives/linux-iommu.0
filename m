Return-Path: <SRS0=CXUA=H4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C11C433E0
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 09:11:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B1964EEE
	for <iommu@archiver.kernel.org>; Fri, 26 Feb 2021 09:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B1964EEE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B029C6F8E3;
	Fri, 26 Feb 2021 09:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sojuqwDnBydG; Fri, 26 Feb 2021 09:11:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AA356F89B;
	Fri, 26 Feb 2021 09:11:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EBD9C000B;
	Fri, 26 Feb 2021 09:11:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6490CC0001
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:11:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4616184166
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oIRM8xpJEgvL for <iommu@lists.linux-foundation.org>;
 Fri, 26 Feb 2021 09:11:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from JPN01-OS2-obe.outbound.protection.outlook.com
 (mail-eopbgr1410112.outbound.protection.outlook.com [40.107.141.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F29F184178
 for <iommu@lists.linux-foundation.org>; Fri, 26 Feb 2021 09:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSV3vuwGvH0Q+z1Gsj4G6GoGjrqtrNGckh5l7mXONfKzdqbz04HbH6kzkwguAbRcqCtp2HSTa/2mMOveZYUCeEQCjtSxd0ya53ni6vBSX/q8TZx2NSG2+AtGaosEo254PjRRTMkC9y+mLQeogpaaSFJXEXsaA4Gjd45r2WeSqbi3GDnOd6fjNDN5JwuJusPgAQP9P/zHbB3uxagX0oTFUILKOU+x0KRE9V+QrGKjDp+StLKBkWMHpie73mHE9OgjxCwajD8xj2MmgfwrO/NbuVbTkk5sw7gItXEfh/8+3BLpphPeXcUxynaIqAXLk44tgvBW/f3Jbh7Q46fAlCwh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHB/e0sDdnC/tHHpW7e5KsJXh5YRcVbyRKhAxIbUOSM=;
 b=mbPMUjUloNQtDIVQ00p5osPfc0U8xk10zrDeVRxF4/MAo9VsQxiRKLrft2xLNIAvaYN0GthqDtMTZNhr24vFFn5OPco5J3mj32ogBoia5/VJ0+YeMre4EI2QS3B+GWzyxbo2jlaVEY8j7rx4LDg9NXHRcBPQLcq79FeD5iMTBcHs4m0RFGrik6WJ0X6WTDSXo3MnvtFsKBsShu2Hr89beSfJoAJlvKBQ4JAtdzjMmYO/xRcAi1Jvs5kQVpxehyIZuI6kRrkEVEZoKZMvhgflKftuKyjvwIPncWTfy2TOOgDhWRMQVc/mTdohKtFT9ED0Xk/tEP4gK0oFVaow72y0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHB/e0sDdnC/tHHpW7e5KsJXh5YRcVbyRKhAxIbUOSM=;
 b=LZq8PqcdWwVy16E/NFZTxTU0agad6mU/W/5ECUgsR/7kc4sT6IrIP8aiPi8PwO/VqhVpwx/R+uUL1g3xiclar9YjR3UJRRBLVC8jypZdTuwvEVlMx1PG9xtz8grKgq0k3WPTx6vEv5njHP6mOJJF0TiS46Q4n1lrjvZsuewwWbw=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB4224.jpnprd01.prod.outlook.com (2603:1096:404:cb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Fri, 26 Feb
 2021 08:56:10 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::cb4:9680:bb26:8f3f%4]) with mapi id 15.20.3890.019; Fri, 26 Feb 2021
 08:56:10 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Heiko Thiery <heiko.thiery@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>
Subject: RE: next/master bisection: baseline.login on r8a77960-ulcb
Thread-Topic: next/master bisection: baseline.login on r8a77960-ulcb
Thread-Index: AQHXCco3XflnpHFrIkuPxbP3mqKvjKpn14oAgADiRACAAAGDgIAACfsAgAATgwCAAUzcoA==
Date: Fri, 26 Feb 2021 08:56:09 +0000
Message-ID: <TY2PR01MB3692262A3ACE5B673DF753FBD89D9@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <60346234.1c69fb81.cd55e.770d@mx.google.com>
 <7ac4a45f-b95e-acc0-f5bc-e4f870ac0bf1@collabora.com>
 <db197ccf-3b55-098e-bc19-ca8adc98c6b2@gmail.com>
 <YDeFbC8DzsB1GYNY@ulmo.localdomain>
 <6804ffd9-4558-abd4-db17-22eb5617d996@arm.com>
 <YDePENfrhpr5M0F2@ulmo.localdomain>
 <CAEyMn7aQVRh7x4t1gjvD4T69FkK4JJrNnbm=HjqQZ1dJ-nKB3w@mail.gmail.com>
In-Reply-To: <CAEyMn7aQVRh7x4t1gjvD4T69FkK4JJrNnbm=HjqQZ1dJ-nKB3w@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:e5f7:ee15:e4ae:ce73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e53aa84-e87e-492b-355a-08d8da345cb6
x-ms-traffictypediagnostic: TYAPR01MB4224:
x-microsoft-antispam-prvs: <TYAPR01MB422468C3F63CA068376B3762D89D9@TYAPR01MB4224.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vW2NChNnd9BVc+/pFnN2i/TT4OC4gcZYLimHl7VVaHlitOjUIcCEmRMuTJj6385IGS2+eAslsEpgLhMWyoqAgeEdFR6o8PucXKtCjmqfkenBG8mLyisLgLBZ47BNJKCKQ8MyEguS1odPKtH0CyJVMNjr/PavP+QyR0svUkmmRIF5uMf2vX2B+mtqetToq0JKHkt5wJspXVRctgqc3gydcIzHObVT7WTTxSuMZyEvsHynG1QRp9e/UaYzb+TMLqTmuauNYugNv/z5Z//dZFKNLwZ4+0fjFsuTchsfh7nju3J1WWfOPdekltLBsJ+8UhZ+gsfD6zMyqFLZfI+UMZsZ1orhgLAAHK9Kwtc1dqxFHV/u8e6KY51iNeHpZnRkLbF/XM/9Kx2VGC0hDPaETfnxymnbiYXV65qH03o9MnFngrgNQB60kkXZB8EabJ4xHAe8pmohNdxWfuMU4qYJmmxROVD3pq0kzY+37Sb9W5iy9khBDZnAeCjQFeYQlS3ytya/vwsXT4xic+DdgZc76ljVeRQD+5HCNnYhbFVul+ffmdtsx9c6TnWhZObjL8iPhnYA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(76116006)(8676002)(316002)(53546011)(33656002)(4326008)(8936002)(2906002)(186003)(54906003)(7416002)(7696005)(110136005)(55016002)(6506007)(5660300002)(9686003)(66946007)(478600001)(86362001)(64756008)(66446008)(66556008)(52536014)(71200400001)(66476007)(83380400001)(45673001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?s88OFx4sZoPjw+4tYNFMZR5D7lf4AvUIZrdmschJIc0S/dVRf7zBz4Fg/jqk?=
 =?us-ascii?Q?nW8yxyiZmgZpi78N/zadxty/USG9dLweyZjqRtW44B60F23lnV0JXZKfOsn0?=
 =?us-ascii?Q?hSlLqFeKlTY1MZTlPKFbSY6apufvJTMIfYXgPvnYddDod/WsfQhoj0IsSU5S?=
 =?us-ascii?Q?2GtIvX2Z9YNhkW/xYr7yzxPciZgbf/gjrkAxD018UUpQc5KPeWtquLgB2Kyp?=
 =?us-ascii?Q?DbDO8KvzNPG8VbSPvv2Jjucyi/U6FlTOzPNx6BNkNdJ1ykAW0w4MHyhmJyYw?=
 =?us-ascii?Q?epRx1zejzNQMI+Vpc5Ee05UwuVO3/2xVNPn1voLbUSIonInJGu+0xdhWqUOD?=
 =?us-ascii?Q?YGaKGlbkpsx6nitMxBXCk/BlJb9XIkb4LHnMSjOjJHd40BOhnHjfzM5mMmdN?=
 =?us-ascii?Q?/FhObaReTOZYAWf5UhVj9Y9CrKpF7O3OtE83dyIjpmJJtc7ir1Gf2YYxVba9?=
 =?us-ascii?Q?ZGPpenpnyCgPO/gau9U7vto//L/LGLI8uVa+3ONJdflAn9BpVS6RR5E1+8Pp?=
 =?us-ascii?Q?C6DNgU57RhDvqK53jTlNoGScdxdKnYu9wMgePUBj0UBjdMkzRNo6/9vs28+x?=
 =?us-ascii?Q?Tg02KM5KYbyRvI3JwrLjQqbEZgP+XpTI34vOErL1ipRnyRVmx0NQoXHaWg+V?=
 =?us-ascii?Q?0xQsr9gYffIV4g0XJAjTnD7UiCxnhS2nZ8fHqur5/7Iz9V8JqiIyryc+QzHO?=
 =?us-ascii?Q?v0MpjRQ4TGxrRXdvE9GrFZLmUPXaljEiopOZYczmHle1TbEi5FIbsUsmfWfq?=
 =?us-ascii?Q?Zj0eS+eBgQV6+HeykPRjboOYm05Hw23IEXJqRUVmArR5ujsj04Yk+WZwQNM/?=
 =?us-ascii?Q?07NenhpXq9OAPrYsSxqr1ZWuTm2LQFppViEXDqQbFwbLEeda/EumDn/gWQo6?=
 =?us-ascii?Q?6kQPjmMokk11tqHYNr8riLFSmLvpv3/1XqIYZeJWbMBxt0pMA3+uGjnsGfb3?=
 =?us-ascii?Q?PjuqWGo0U4C1qNFUOD3AxfpHC9ZONoUmmE+xMEBUR9LnRenbJxjcThhgp+Qe?=
 =?us-ascii?Q?JOZpdB8gunUF/vWPk8o1vbaUGLIrjYMbOOs57znaRYe/N/EeYnjfs8tASYW7?=
 =?us-ascii?Q?iCbbqVVwGeL1dLWPu6f9DZ0nNvR7J4+a80aUrXeYjo+slC0Cl8p9kFaHn08l?=
 =?us-ascii?Q?av4SLIvJGjz6RWBiANAufyLXH36RLoJ/dxsSGoE8MzYvX0hphAq4db0rzWSI?=
 =?us-ascii?Q?VbdGJALuidGVy8tKD7nx1OlcjyscyLzsVPZ9SRLLEANJz8PF10MAX94rVCiu?=
 =?us-ascii?Q?pRox1uP+SJUdr0qooc15y2fqArC5/LVjob34tRaOxJvT1Y3ykIuiloWiDJgF?=
 =?us-ascii?Q?0WNDix5SE2uWVM1YY+mnsWpGBzDUxncg4gnsj7pKv1GMsoc4hgQgn5dxg60j?=
 =?us-ascii?Q?62Ccwn4=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e53aa84-e87e-492b-355a-08d8da345cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 08:56:10.0535 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yXHaEcfZMG9aZq2xJZ2KKlD/aeZTsnJYsrNqqafkbXKI1W1nkbL7xBSq0zlqxdi/z4qX6JNf1n58XhRUeQnwIo5ATX2r6AJQNRySeVuRQzOd5vZWMW6VLK2+vFihZWsH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4224
Cc: "kernelci-results@groups.io" <kernelci-results@groups.io>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Guillaume Tucker <guillaume.tucker@collabora.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Jianxiong Gao <jxgao@google.com>
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

Hi all,

> From: Heiko Thiery, Sent: Thursday, February 25, 2021 10:01 PM
> Am Do., 25. Feb. 2021 um 12:50 Uhr schrieb Thierry Reding:
> > On Thu, Feb 25, 2021 at 11:14:57AM +0000, Robin Murphy wrote:
> > > On 2021-02-25 11:09, Thierry Reding wrote:
> > > > On Wed, Feb 24, 2021 at 10:39:42PM +0100, Heiko Thiery wrote:
> > > > > Hi Christoph and all,
> > > > >
> > > > > On 23.02.21 10:56, Guillaume Tucker wrote:
> > > > > > Hi Christoph,
> > > > > >
> > > > > > Please see the bisection report below about a boot failure on
> > > > > > r8a77960-ulcb on next-20210222.
> > > > > >
> > > > > > Reports aren't automatically sent to the public while we're
> > > > > > trialing new bisection features on kernelci.org but this one
> > > > > > looks valid.
> > > > > >
> > > > > > The log shows a kernel panic, more details can be found here:
<snip>
> >
> > Yep, changing max_slots from unsigned int to unsigned long fixes this as
> > well. Thanks for the pointer!
> 
> I also can confirm that changing that to unsigned long fixes the issue.

Thank you for the information! I also confirmed that changing the type of
max_slots fixed the issue on my environment (r8a77951-salvator-xs.dts with defconfig).

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
