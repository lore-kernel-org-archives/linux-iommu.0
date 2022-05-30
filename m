Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E86C433F5
	for <iommu@archiver.kernel.org>; Mon, 30 May 2022 01:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E382940423;
	Mon, 30 May 2022 01:52:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I-GftSQpifWJ; Mon, 30 May 2022 01:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC3C9400BB;
	Mon, 30 May 2022 01:52:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79355C0032;
	Mon, 30 May 2022 01:52:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF1F9C002D
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 01:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B557F60E09
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 01:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZlM6U4O61BiY for <iommu@lists.linux-foundation.org>;
 Mon, 30 May 2022 01:52:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A3DF660BB3
 for <iommu@lists.linux-foundation.org>; Mon, 30 May 2022 01:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jP9XBDDxiB58/XPk4rRso4XnJZn7u6CxLzk76JXa48uOIlZHvxZiOP391Q9fPYmcL0B+1pNpj/bAv/X3pDBIQi5XIvEPIYONQ6jY5c65jWyJU+nD+Ar+Fkj61i21MdBmTgUy0/Gu1BAWZCzOP8bFSfbxhlOsuiHBvflG3QrwCuTgBpT/jxrgnhf35VCmpqTDzE7RRk2fHzkfWV/2T2NE8Hww1OmqS50Uv9udiLe30EDRg4u3S4WqIcxWdf3t9/LmVsPg4zhicQOC5ArrfrimY7xlKlNbxO9V6jQpChv6GzruzJ28uY513U7idxHMtHDUA0x3GYUcKaRQHQRfLlImcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9Tq4ttn1Ga75gXCPrYGMMbiQJapdy6TWkiOMNUXCR8=;
 b=Hov/l3ww/2CU0f+Dix65u52lH+0wmAkrdtB0NtBWUGc85Fdk3ckXkJqdEE1vHzfzz9rCHRi3djixIbsA4waFk6f+xpqM05qFeBuBKPQmzxu3ZSlIi8/ZgiCJwYHhmFMhb/V9iSzd14UxJtDlN+ne52BKzU4dnMs121BmnsWdzFgGL+lhSYCkQfCj7KHHz73OvDUAIKYLjEisMrnGtuaeosKsvwi/ilhjkCBlc8lTA6sLfx/zMyIuD3ISjRdezckJuwyW0hpW9gmBSLEFNwB6o3FYByPdTSQdWag41sUU/NYzuYhrYIRlbsx6XuYgNXH0I5DlfxYJVlFhI3A43nkCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9Tq4ttn1Ga75gXCPrYGMMbiQJapdy6TWkiOMNUXCR8=;
 b=U43maznvBE2MKCRSHnqjmqdn8zjyBREP88SI0SwGj6ULyMnPIauvhdolcTfB2ZcPKOB/LQvkNO+v8gWkFaXTESiDVreohp4p4F+Em+6Qxy8KPlrx7nFCJXYcAoGAFHg7+C84yfkbMjhXcmZoY/+nXEs1dNipfuKUe36wxBvIiMw=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SA1PR21MB2033.namprd21.prod.outlook.com (2603:10b6:806:1b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.1; Mon, 30 May
 2022 01:52:37 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::8061:e9da:aa0f:a013%9]) with mapi id 15.20.5332.001; Mon, 30 May 2022
 01:52:37 +0000
To: Christoph Hellwig <hch@infradead.org>, Tianyu Lan <ltykernel@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "andi.kleen@intel.com"
 <andi.kleen@intel.com>
Subject: RE: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Thread-Topic: [RFC PATCH V2 1/2] swiotlb: Add Child IO TLB mem support
Thread-Index: AQHYXiPNuhMxYMMi+USnjQGOHaoDOK0hMpCAgBN0YmA=
Date: Mon, 30 May 2022 01:52:37 +0000
Message-ID: <PH0PR21MB30258D2B3B727A9BCEE039FCD7DD9@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <20220502125436.23607-1-ltykernel@gmail.com>
 <20220502125436.23607-2-ltykernel@gmail.com> <YoH+mbxQAp/2XGyG@infradead.org>
In-Reply-To: <YoH+mbxQAp/2XGyG@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3031e321-ea57-49e6-8c12-6d5ce4d7ca6b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-28T16:40:17Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6da26841-7997-49dc-fd45-08da41df1289
x-ms-traffictypediagnostic: SA1PR21MB2033:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SA1PR21MB20336106CF6A777493BAA26CD7DD9@SA1PR21MB2033.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUC/kw3/KwxIhf46TYO5k5rRvNwrnQScCnrqvRhnxV3Vgh/R/xglDyAcvXAQ0h05Yfa/OE0uqL8zVR2HZRXRJgVrpy9tmDOz1oxW/LAHd4cZJ+NDLmJIGlOoWG84WFhIYJ7mP+jU5sGqt30QUVoTVBQPW7bnhDzcIc4gTPXIRyyT6vr3HB9MFYWivRCiGHZAR/dQRRyt3gUGzUPpbudcrLvM/fEfZBJf398AzlKpITO4P3T8TzY7oTdAvEvD8LVTiPrayyGUJwSrulXrRiscgNsyBg7EAAJ381S6k3NXCYIn7OJzk6i89yMYSV9DB8TWBJtmp2Qqmv0RHahwdATCzRbhcRI5QFj23X5UFZT0KofZ68dVra6nEkt2JagpAExBi9kdL96zwOffRJ+K58kA8ajuhhk4cxyap9geJjRTbb8y2g8FgK2VZolqC5zKHh8duQZzjsxpwm71/qGA4Ggv6Y3j3iv2aqtUiQhg+4sJbDXHOX8WShlc532dhwpciR09wPjGQAXvyXYPrvJg/6+JzeQcXKO3piE2mCCTHvvPVYTcaP3f1IV994D0Ota2ub0PFj2gCYYGNmG882LSLf8XYceBqdk2lboQccY0FxlSGZ4K+h2Ms2jhXj2n4xZ9pionZOUoVFsvx/E+SHLvaS4EiRMcvYieUOMwbCoB1ZlH8DIXcvWXr5XmDykb3734YoiSsxjp/nwnP7d0abOZeTWCnz5x+wMi4HI+AVIZamwseLyHuZ+BZmLNy772gooA4JupWUc88iVVLPZrWvYbPD1H4V7Xfm/8XQ2jkRQEi7N9Zh5WBOxS0/GXKN33KQP2O3IOIXdiGbE95rDln6gVgfckag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB3025.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(55016003)(66476007)(64756008)(66556008)(66446008)(10290500003)(54906003)(508600001)(26005)(8676002)(4326008)(76116006)(86362001)(66946007)(7416002)(110136005)(8936002)(186003)(316002)(38100700002)(966005)(2906002)(52536014)(82960400001)(82950400001)(122000001)(38070700005)(6506007)(9686003)(7696005)(8990500004)(33656002)(5660300002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PemP/estICdsQsF6vYm02Lw2pDn/nsim4jXCclZSbMZpXnHRdhvlgJV2fR3s?=
 =?us-ascii?Q?cIPwo2Lx3BunvO9PELl7YaUd6qB29R6kBS1NU4cB17Jmf600gJzEwRihCXM3?=
 =?us-ascii?Q?Ee1MuBCUU8VMMghNEzeAfYpwVaOCHH3+4Ff4gED5C3GCzx9oU7qywhhgGTx0?=
 =?us-ascii?Q?LQSWYv3DSzfaXYvW89XpCDhLOmrgTd6zBm7ipnnedRL2idhOD/LVTi6jt6j1?=
 =?us-ascii?Q?hhfXCse/d+uNyxDHDN06klCmyq0piZ2Q6jpzo4njPyRIOYpgsjQWFsizo54e?=
 =?us-ascii?Q?hZf8aS0KQyyK74gl7gOBwsp3I+5KI8LGcSGAvvpmNBDGHD6/LiKna9N+AsDG?=
 =?us-ascii?Q?KSfzF8jCbTYk/2ARbpS9zd/MqC5bNWC+Orr+OB8ZQcpiZNs0lyH1S4xC/bl0?=
 =?us-ascii?Q?86zyZ4kMfKr9RXeWntMqczgj6udlDCuGOQRYyoyjVBjZAYdEngm8TTqjRK3p?=
 =?us-ascii?Q?cA97VxlpZkfyKHUJlkplZtS9ZgW6VAZX6HJqCa/GnMylaMQPnP01SffzbLdx?=
 =?us-ascii?Q?dXemiYyVWF7BBHhfffyBM+JdymME9ISKgLtrPPARC1BVQLCBoFO74SH7zXfB?=
 =?us-ascii?Q?g3arO8wUT7U6xtPvyuryJY53Yg1946TLbyDjPCfNF4P/a417h+Ausd3yeW21?=
 =?us-ascii?Q?nBeeXR0H/8i7bJorQL0Q1TvbW7kuZyKfu12v8+OzYch1DpbKESSFooOQ88ih?=
 =?us-ascii?Q?HPOE0xfNG7i7C1ijXg0/MEHhkiD/ewLYPch9Xgh3FJL0W+OiZdbCHpWWtzUm?=
 =?us-ascii?Q?XUtGjaXvcdplpcNM8SjSFMM5cfi08yNdiPIu11WwzUnvtAsR24wQafZPD9kt?=
 =?us-ascii?Q?C9mWQx9WIvDEtpQ0PdC3J9j5Av9VxW4EX3j6H/IBIb90Uo5bVAMI/32M+uGc?=
 =?us-ascii?Q?EYU6I5MMmiVzcsZB9HRDHGspX3IypyZwY8CgqAllo29hcQ26gxDPlwpUzn2p?=
 =?us-ascii?Q?nLCgpsxyLDLY9WhUxsiOXp8U4RMvb/gRwc3Jx/u3KQ3gILhCGzmx9Nn1q3gw?=
 =?us-ascii?Q?1q0SxgAKNmWGCw5v2IfVUf6xynP3g2DXW5PaO1DFpqAppMbASAx+0V35T8dZ?=
 =?us-ascii?Q?uB6JNvQq+K/Cc1EDgR9Yw6OtL9kS2jVQYrKzQj04nlUfhOR5XUA3hmfi4l3A?=
 =?us-ascii?Q?6jeL91GKrB0+dZfEapGR0sYn8IMCId7tSQTtQNK3V78HVkOoEOanjaOS9Mrt?=
 =?us-ascii?Q?IZ2cLz3kT4NC7djFRk6lw77fnckZMthWClvxE2pPEm4YtJ9mFsYlqWUXr8sr?=
 =?us-ascii?Q?4G/usM/1VkcqkNf5b32UsQGO52eA7859gd8SpWe7W9BjiLg3wPD/KR8cfaoi?=
 =?us-ascii?Q?acH2D8ObsYtPiUTWVjSkclpnjk0yyn7sxTmHgHVY1vY7YOlxTnKEN7jn86VD?=
 =?us-ascii?Q?5HkN7jsb1MHASpONokDnapZwEwR/X5N7KOqeLTfUtgzuUQ2wsu9UrUl1fxpq?=
 =?us-ascii?Q?GQ4wVdyq5kvNljtdXSB/QXn/qrv9sXQcXmAwKcpEPYJLr7+JPAmylby+TaHq?=
 =?us-ascii?Q?N/PrMuCLfZe3+qcvnZZNUAhWjPFOtE5F8tlaj+36Fv91qT/wOe0eER0FYxzy?=
 =?us-ascii?Q?kMMKq9O3XPzYV2/0mfBHRt4G2Ou4Tds5iMocWntXA43JiKP0Jt96Qgz/sEvT?=
 =?us-ascii?Q?N3Yi1dvdX2oxEP9/czNyoKuYZtjDoYX1bloqAzANArjN+7QC6wmqBWxeGYCT?=
 =?us-ascii?Q?/dMsRHWphQgXiFVOn4ghNX2q5KQjTbE30BDKS/hGjiBA3blfYNo0567JT5xc?=
 =?us-ascii?Q?zCdecVSiF1stGETZbQdxY0ghUnHALZU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da26841-7997-49dc-fd45-08da41df1289
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 01:52:37.0423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iM9hMLhDJyiORg9P8LuUKvVyflQbKTHwah34CVIqLsD95HGjsED3cVL5A1m82CJndhC/7PxjznU75hUqJjZKXwoJhECVDjM1o9nU/rdAoDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2033
Cc: "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kirill.shutemov" <kirill.shutemov@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 vkuznets <vkuznets@redhat.com>, KY Srinivasan <kys@microsoft.com>,
 "hch@lst.de" <hch@lst.de>
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
From: "Michael Kelley \(LINUX\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Michael Kelley \(LINUX\)" <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Christoph Hellwig <hch@infradead.org> Sent: Monday, May 16, 2022 12:35 AM
> 
> I don't really understand how 'childs' fit in here.  The code also
> doesn't seem to be usable without patch 2 and a caller of the
> new functions added in patch 2, so it is rather impossible to review.
> 
> Also:
> 
>  1) why is SEV/TDX so different from other cases that need bounce
>     buffering to treat it different and we can't work on a general
>     scalability improvement
>  2) per previous discussions at how swiotlb itself works, it is
>     clear that another option is to just make pages we DMA to
>     shared with the hypervisor.  Why don't we try that at least
>     for larger I/O?

Tianyu already responded, but let me offer an expanded view.
I have better knowledge of AMD's SEV-SNP than of Intel's TDX,
so my details might be off for TDX.

Taking your question (2) first, two things must be done when guest
memory pages transition between the "shared with the hypervisor"
and the "private to the guest" states:

A) Some bookkeeping between the guest and host, which requires
a hypercall.  Doing a hypercall isn't super-fast, but for large I/Os,
it could be a reasonable tradeoff if we could avoid bounce buffer
copying.

B) The contents of the memory buffer must transition between
encrypted and not encrypted.  The hardware doesn't provide
any mechanism to do such a transition "in place".  The only
way to transition is for the CPU to copy the contents between
an encrypted area and an unencrypted area of memory.

Because of (B), we're stuck needing bounce buffers.  There's no
way to avoid them with the current hardware.  Tianyu also pointed
out not wanting to expose uninitialized guest memory to the host,
so, for example, sharing a read buffer with the host requires that
it first be initialized to zero.

For your question (1), I think we all would agree that SEV-SNP and
TDX usage of bounce buffers isn't fundamentally different from other
uses -- they just put a lot more load on the bounce buffering
mechanism. If done well, general swiotlb scalability improvements
should be sufficient and are much preferred.

You made a recent comment about almost being done removing
all knowledge of swiotlb from drivers [1].  I agree with that goal.
However, Tianyu's recent patches for improving swiotlb scalability
don't align with that goal.  A while back, you suggested using
per-device swiotlb regions [2], and I think Tianyu's patch sets have
taken that approach.  But that approach requires going beyond the
existing per-device swiotlb regions to get scalability with multi-channel
devices, and that's leading us in the wrong direction.

We should reset and make sure we agree on the top-level approach.
1) We want general scalability improvements to swiotlb.  These
    improvements should scale to high CPUs counts (> 100) and for
    multiple NUMA nodes.
2) Drivers should not require any special knowledge of swiotlb to
    benefit from the improvements.  No new swiotlb APIs should be
    need to be used by drivers -- the swiotlb scalability improvements
    should be transparent.
3) The scalability improvements should not be based on device
    boundaries since a single device may have multiple channels
    doing bounce buffering on multiple CPUs in parallel.

Anything else?

The patch from Andi Kleen [3] (not submitted upstream, but referenced
by Tianyu as the basis for his patches) seems like a good starting point
for meeting the top-level approach.  Andi and Robin had some
back-and-forth about Andi's patch that I haven't delved into yet, but
getting that worked out seems like a better overall approach.  I had
an offline chat with Tianyu, and he would agree as well.

Agree?  Disagree?

Michael

[1]  https://lore.kernel.org/lkml/YmqonHKBT8ftYHgY@infradead.org/
[2] https://lore.kernel.org/lkml/20220222080543.GA5412@lst.de/
[3] https://github.com/intel/tdx/commit/4529b578
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
