Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA3C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 09:15:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745FE60E53
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 09:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 745FE60E53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4026B401EE;
	Thu,  5 Aug 2021 09:15:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rTwAaLardQjC; Thu,  5 Aug 2021 09:15:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 32FE840412;
	Thu,  5 Aug 2021 09:15:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10219C001A;
	Thu,  5 Aug 2021 09:15:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCE31C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FA45831A5
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:15:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzO8LIKN6xba for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 09:15:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300092.outbound.protection.outlook.com [40.107.130.92])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03428827A9
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 09:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMmABY9WN2SlKtH1hGMVFtCccXGQlz30z7gslfaHSKVVZT8vX5OO2N9QXKLWq/BPEtYOoI/sVQR8Q2EXOKbhUGRYCVkP41XgaC7q+qwLU698wsJ5ZjEsj1NtOyhVP3bwyTbcITWgi7B28JcWIzIJN+c/sv+O3wHGFBVn3V5y9OoVIYdFWJl0VPOP9lJ/wdhxya9/nqkGWVGbm5o/viKX1Qlvv/PYKk8QgO9038YRH4ky44HhX4SS1pknc7leFzlzUYOqjlG7NBIz70jQ7P6YNsX8ss3iZiM+5YJaWWxdUwWx4y8uvaEZgY54eoOtruHCetI1M8sCEp5E4zRwTqVQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buOjPaliHqExFib11ZhTwE4NP5iintijYiNmfZL9Wr4=;
 b=UtpPV3Jfr9h7Yh8rsuZl50RgBlHo0ngVdfRzcxKpELH2rek2Nj48pf7ftcm575w9C/Bl0D2+feQhDBz8TPltUABB+WUHcpn9gfeRJjQFF9zhV0K9D60TmpE+fZ4BNic53toQ3cMAqbWl+j1aarGPSupjl5AL0IagZ5YGrJv3HX5iv7/mMgHBP7GQOFTGU5W6+y2oWBpdh4i/V4348vg8iSKGVIamgRgyCgIxGfC4gsYJ2ygsmpNlIASDgEQaURJP/lLv4H1JgKD5P2j3TMRd59Qj7b8kpwPGNc91vractyl1NGjA4uznfoxeOV16UX/SdF81xQs1zIEl/6ecWLZSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buOjPaliHqExFib11ZhTwE4NP5iintijYiNmfZL9Wr4=;
 b=jjfJLPZ/qSXl2qwk1HH9q8YirUjDzHxPddR0Z10DF98ItVUm7GVOTYkcKS90WHVzn7FVhU55+jdG/98hnZ8VdxaP25yb54dpEzjmYN7Z2VLzFMEkN/jHnY17uCGo76WNefa7hn3c/PHV0Nj7FqC1k9Db+FsnNaO4tdBypb0ztOU=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB2171.jpnprd01.prod.outlook.com (2603:1096:404:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Thu, 5 Aug
 2021 09:15:20 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::7db6:310f:a5ed:82f6]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::7db6:310f:a5ed:82f6%3]) with mapi id 15.20.4373.027; Thu, 5 Aug 2021
 09:15:20 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v3 06/25] iommu/ipmmu-vmsa: Drop IOVA cookie management
Thread-Topic: [PATCH v3 06/25] iommu/ipmmu-vmsa: Drop IOVA cookie management
Thread-Index: AQHXiVR0bCeWsuwZoU25HY0YeNFgPqtkoOTQ
Date: Thu, 5 Aug 2021 09:15:20 +0000
Message-ID: <TY2PR01MB36924CFFCC20B9E3CC7BB594D8F29@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <b154a2f088699b739d8c4823c458bf5fc0aac2bc.1628094601.git.robin.murphy@arm.com>
In-Reply-To: <b154a2f088699b739d8c4823c458bf5fc0aac2bc.1628094601.git.robin.murphy@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624bd1c3-726b-4c5c-d2a3-08d957f18cac
x-ms-traffictypediagnostic: TY2PR01MB2171:
x-microsoft-antispam-prvs: <TY2PR01MB2171CFBE62BB64748C1624D4D8F29@TY2PR01MB2171.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nsdBr5i9fhI9UBm1GE1Po1+n6hZb+++sUhvwU7b1RwAql23vp68QmgJ79vbqpRb5nmd/In6L9bZZpzLcI8Pv4EPNOPfjlFghWXindTJkjyvXlLe1kwkPpybuM6Kjwg2vJQV7KTBEHnV4Yscv1qw3lzAKEinh9yj1r/BpFUlqZmCGVstAYIaj7fF/STLdoDBlwUN09u859Di2bxNBpzwvN2C9uBf4imx8VWX8l3zT+S2gbu7riKDn0dzdjJX/JlWKk1ZAweSRH1qZd0LjhH1JumZtDOp6LsBYpXmcmA+KAFV64Hf9zH9bwFezrKy/TjFPPR8rEIjiwWYb+PM7c8BFFNbC6NlzFLwls4HgkOuhFPjE2RVRcvNC+EcDhglJRkfFnYB1n8W7PcxIoYM4J3log30dh4KoSA4pOgn9lgTSBCmtJXYUA7HjNCQBxmPz5Wxl8Q+V7GkcyqDcfgKMhopRQ+RO3PPYZ84aFiAQ3IXBqnFiE5PWE9+MTyEDLa5uv4Gm6ma+hoHI9aobZgi+N3aiUhe6lMSUgIQyLBK2G4PCMFbF8l+DLeehtB3+tthYvZNfQR2FwjYO+Ao7gFx88NLByyOOCGcHGVMJ5uLAgzi/70kSqYLIo8P1w7wq5GHfsL7scfmgSaSWSSjTaofopTaiOoESpNnRphFAnytpuyaj/2vFYvMuuEvuC0wdPj2bwusKqOpehzikLMJCgqaMcJXAlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY2PR01MB3692.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(122000001)(8676002)(55016002)(33656002)(7416002)(66946007)(2906002)(5660300002)(7696005)(66556008)(66476007)(64756008)(66446008)(26005)(8936002)(508600001)(71200400001)(76116006)(9686003)(52536014)(4744005)(4326008)(55236004)(38070700005)(6506007)(54906003)(86362001)(186003)(316002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KzvRmHKx/wXlGjavMU021ZvokYpHbAconJs99ET/p9rJkAz3UyQzdCeiA/Uc?=
 =?us-ascii?Q?XrFtfYZyHMuXBaB+E5dO++QZ97fsQzsNvnRRbEzTZfPRQFDQVbtKchYEzYwm?=
 =?us-ascii?Q?3mkYKjHzpI4aMwh9NLvOUhZs66GAWSEUEDLSFDOtJkT3rQTfl4xHsDGGb7ib?=
 =?us-ascii?Q?lXpdxgs7w1oj6hcL5nDWLWCDvcn2sbbRnTFK/yfspoe8v8iRb3MxMvqRqnXo?=
 =?us-ascii?Q?cIg66RKhQxoJtpheMDMHjRkL4y3K/m90nM0LC6Gt2D3Fa3+67tYSdtc9bf10?=
 =?us-ascii?Q?rDjWmORbmQRs11VqpGiDZP/MV+bZrY69BaqV725C631inEtM5vtZtHSTE/6Y?=
 =?us-ascii?Q?TrOfqe37/l90smEkci/TgVFdi38YUzk1+fQdAfvhtfBVuYD6aoDakZn4GRXm?=
 =?us-ascii?Q?AHmV/5fEvrblvuiS50dBGuJa/hwPqaWtApZEsqwHDsS24FsSt8gVJr5Xr1qG?=
 =?us-ascii?Q?503Imc2SfUkURCJJkrJVhi1X6E3aJnV3AzIUVSpPjeYnJj197w4jHlUjCCdw?=
 =?us-ascii?Q?HgRtJDB0jAXR+lXb8UDmsf+avYrlU3031WZ43JAgkDEq1bDUfGJfbGrXKIc/?=
 =?us-ascii?Q?+YHoFaCRtN3TFc6EmXH4hdAUw8zXKA6FqlsC2Ny/WikFmkU0hKGHtgVzRqal?=
 =?us-ascii?Q?5jAEdTcQ+qtRHE9hm6pmnDyfe71H9Ph8FFsZyQ4O1u73JvFE4Ah+cOJKodm1?=
 =?us-ascii?Q?06mRLclIrSPkepKI2+ZWA0E5Hd/fwjOC7gkzvoNuosxJjxk4yGfbKDd0mzdt?=
 =?us-ascii?Q?iC035L+7QOung8TvsKpcVPT1RLYZpzUZRmW0IldAICcF0/Pkha3JPEO/CV8M?=
 =?us-ascii?Q?Wd3+3EqmzLKtNsYkYMBnq+nr4SqorurDg1BoERCiAhYMwZGvaJwFZT475bvU?=
 =?us-ascii?Q?jr+Fao7f5GCzey2K92uoUkawQ9ZMOAHo8+FMQRYS9SKIgxzdcrFks+2P8pRb?=
 =?us-ascii?Q?fwpUm3Y5OhAetGZjHcJ9XWH3cKRdsc0R9Tr0vtDbVOdhxseOzZ7ERNWuboot?=
 =?us-ascii?Q?KYYUZxtF0v3CPtBahS42uAgx+hPVNXe+kZ9X9d26tdEaRpvqzEDyqtVvo8sR?=
 =?us-ascii?Q?N27fjh82Ap5HI2/7iZhubbBQygJXWPtIqMGbHM3Qe1waz2DHEgbvVnBSHmZ7?=
 =?us-ascii?Q?B04cj5XWvFY5Bx2JGn88kpPr36xYw2j0I13DM/2jpvDI5ZJX5u2qhd/LD1EI?=
 =?us-ascii?Q?1q7Sh9e8ea7mQKV1VuCYRqmOu86tyKFCpdtLT4nvz9aoIhpEq/TXSMMdmbQ4?=
 =?us-ascii?Q?SXMzRWZZxk5TfiBbUHktTkSkXKc3EBSj8Ly4L7bTPJ8jeigHLj6MnJ8b0jXp?=
 =?us-ascii?Q?lmjdqUABoC0Hk/Ax7XehjxW7?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624bd1c3-726b-4c5c-d2a3-08d957f18cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 09:15:20.7447 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbAl4ZIF1dSbxw/Xzsl5Ag9rmkI+IbVzXzd3ZRO+d6fMuixsfQ9YOMjy54cJIorhblm0vCpUWhLAvEOuDTUDlBKzdKBp4hDK3e/ZsHTdlEQQmfMoQ/WW4rjikhA0dB/6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2171
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dianders@chromium.org" <dianders@chromium.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "rajatja@google.com" <rajatja@google.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

Hi Robin,

> From: Robin Murphy, Sent: Thursday, August 5, 2021 2:16 AM
> 
> The core code bakes its own cookies now.
> 
> CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> CC: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thank you for the patch!
I tested on my environment (r8a77951-salvator-xs),
and I didn't observe any regression. So,

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
