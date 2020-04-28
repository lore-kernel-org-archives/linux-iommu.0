Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B96C83007
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 08:25:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FFF206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 08:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ozCRrozu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FFF206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AE38A8624A;
	Tue, 28 Apr 2020 08:25:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ozJbXkwqCVKN; Tue, 28 Apr 2020 08:25:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6AFB8861C7;
	Tue, 28 Apr 2020 08:25:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 526A2C0864;
	Tue, 28 Apr 2020 08:25:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCB12C0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B5B2487ADF
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:25:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nIcz4P+k15OM for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 08:25:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80087.outbound.protection.outlook.com [40.107.8.87])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 44EC187A1D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaPwuwp+LNVMO5sbHRRKw3zb1MbyMhefKPIvpfsY81hJeyvrUJsyuYVNgES2f4tTeJr94vNzFR9oApFmMjHfxMvJvR3DFuwEhNXc2hUIbU9E7Wf8A+LZlsig11tU4A60lyZooGAYL4PajcGYy/8jXgn82D/Xt4YgUCQDGu90sdg5BJOHosyUYWW8Ta6fB35nAn099Qr4G75TgHdqKxuOSOdm8oaELB4SWQDPF21rgBxsYs8ylgj4TiaCeWPbSYPnp391lOG9Hk8+pHMbFUGQOvnWN3YhHzgqhObrDa3h1ZGV/gQNWEBE9UayT2ux1gaOJQKUtmN0ToAvOesmSJ4ozg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlw8bIFYxUY28tZAnQDAnDvvkdqtZ78OGLsv81bSHCc=;
 b=hznfmm4daLQax9hlivpBd2uwMCSzEqdrnWvIJtq8X7OM33i8/lBdzdGbXxorK4suAWi4XeMa+CUV4VoaMbgFqOyJ081ZHqZl7e4nSib9GV0ab9jzEEBFX3TZznn/l2kSduqqv/maxzHppnd2kwm0UMY2ljPnIjAcku6odIg62n7RxZRcDMNP/YuijgRJdJUxXaYJeor1PxqUHnFILRXiaUO1mF5sWWS18sswKpUfy9fk8SYmDqpdrKa0OG4KrLphoGh5IyY9j2QQToSPU45BMvfK3qhmyeesLqNISAGwcFSYNha+TsoJV0DLlz5ajhfvsAbkFtwYtcq9Hui4ds6MCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dlw8bIFYxUY28tZAnQDAnDvvkdqtZ78OGLsv81bSHCc=;
 b=ozCRrozuW7lhxMex/g5kIxsJKEN5W9AnVlaI/l+N2UXjY2PjiLT4kmdxlvwk9LBFGQ/dXri0YKkkcBDGbkQZ5ubwBEKXmbYW16Yg1ew3igACX6uvj+dL94N2g1AzQLuqaxkwFGj8uz5g3tsp5aMB73LNNQTkmWahbsDPsGG3Vhc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2774.eurprd04.prod.outlook.com (2603:10a6:4:96::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Tue, 28 Apr
 2020 08:25:51 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 08:25:51 +0000
From: Peng Fan <peng.fan@nxp.com>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
 "sstabellini@kernel.org" <sstabellini@kernel.org>
Subject: RE: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Thread-Topic: [PATCH] xen/swiotlb: correct the check for
 xen_destroy_contiguous_region
Thread-Index: AQHWHTCUGLGxU19LnkuMxSfwKxPy/aiOLjMAgAAEXoA=
Date: Tue, 28 Apr 2020 08:25:51 +0000
Message-ID: <DB6PR0402MB2760A05135338B0CBB28123488AC0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1588059225-11245-1-git-send-email-peng.fan@nxp.com>
 <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
In-Reply-To: <1c01e97a-adcd-a703-55b5-8975b4ce4d2c@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c952341-0a09-49f0-1c35-08d7eb4dc2fa
x-ms-traffictypediagnostic: DB6PR0402MB2774:|DB6PR0402MB2774:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB2774DAE2ED2273FB88D0E18488AC0@DB6PR0402MB2774.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB6PR0402MB2760.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(52536014)(186003)(33656002)(81156014)(8676002)(5660300002)(44832011)(6506007)(53546011)(66556008)(64756008)(66476007)(26005)(7696005)(66446008)(76116006)(66946007)(86362001)(71200400001)(45080400002)(2906002)(316002)(4326008)(9686003)(8936002)(54906003)(478600001)(110136005)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wp5M9pRkZTNfLrbzQWLN5xAF4qPHU2zhrJC2H9zEZx6TdtZ+MqwgC/bWFSjXVv6/rC34FM4Co8KucAkwII+8CeUgRRjlgHDz9uL8ZDT4IvRT5iaGMKNa2IiOC0oxvGH6wvj0Yo9fivLxN4dRce36dnAFgPzKB77vq9hARJyWYgz5Ie+yqUbLZe09bqKLR8PjhEhYb7tbQUOwrDdC6S0RtoyGsUxgpZComiFqOVOjJ4RTkKsCy1WdJghuc4br8cGoP8IGuZDvW69kUJF3GL3FU2kcMYeLmU4uDJLU1twH1S6bBplJRxtvbHjw2DWbYNRzN93yQn9SbdsjVtaeeKsRmnIVMggmDEsZk0iAYiOfTs5ToTSTFcXkLMsHNPnY2smmd8hlAnVthUUxwsTF6f3FeCSEOAozBEXYlZ2ljSsMFQfKS7KWPybYLS1Wa/CLoUYy
x-ms-exchange-antispam-messagedata: 9DTbD4fEBCogK3eME4Bq825PLA2tr3PbNEFE5q7ldawQmCTD2tBgamLD6UdnddwH29bQN8O8/RKIxRYemi63lCC6zLoVC+Z4dZOTWF72GDzuRZ6OvnX45MnmRDx2wVmhoZvPA1WBssbA8b3WBM1r4YcrWp0Op/Aisu1zdBUOwGYmFXU1gKlxnHMVv+3/O15dVpVx5rdiYqQughkgD8QZMQIx70fyGw4nSlRC3qhDEGk9NHOYLrTXGsRfeOl52lA3268bAMSdTUQKb7qb01+IE/b/6sX8RQFkpusJdXeiNJDWE3TNpxMxa1MMhVQi/yMEmUaP2vU7uCRhKHF7eYPZ9YADWsqp+q8BkTKeuaU7JxVg3jv1h3phLuDXiEO2JuDHs9E91vp8wNge+4fWm4Lr7rkQgO6XFSSxs7n0jrapQDwWBMoEigN7nWdPn5CJ1s0WcsU4up/fYM8xBG5WFm7+ve6GyL4SnpkMv5FqpWnVaYsr3+n0FlBH0JeURVHpVtGVBVyUwT2McSHNFjWQVBrwWFdPNooXZ4AZN7VZ+QV6i2hH90YGIVf+27dgaJIxwO9J21IZsnI18gGCWJ28CKFyJaa8pZxPII6blawP4NBdTVv6ReGpcVGK49WyNotHH9YQxPmv6d/CXaJGROJlz4E0E9QptTNVD0sJd+8jrl6SooTGrgaRn1keBYeZkEUCRilzcbKzoqXfCanYe9cYmOkHi/+lTF8Aid6ivKJVU0ijaihseqwsHx7JGvHddUnzBLcQGKGnm0nNBgaFLBpo6TuEBVIqUIR6Jl/W0OgmCq3YSVU=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c952341-0a09-49f0-1c35-08d7eb4dc2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 08:25:51.0895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7dODyBu4e4WcytpCWJycYreIF9rtxjPzZXKF59BrTxzikPu8cwCgPkE7S1s9RDlQmREveKlk/PO3GYuaRRTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2774
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>
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

> Subject: Re: [PATCH] xen/swiotlb: correct the check for
> xen_destroy_contiguous_region
> 
> On 28.04.20 09:33, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When booting xen on i.MX8QM, met:
> > "
> > [    3.602128] Unable to handle kernel paging request at virtual address
> 0000000000272d40
> > [    3.610804] Mem abort info:
> > [    3.613905]   ESR = 0x96000004
> > [    3.617332]   EC = 0x25: DABT (current EL), IL = 32 bits
> > [    3.623211]   SET = 0, FnV = 0
> > [    3.626628]   EA = 0, S1PTW = 0
> > [    3.630128] Data abort info:
> > [    3.633362]   ISV = 0, ISS = 0x00000004
> > [    3.637630]   CM = 0, WnR = 0
> > [    3.640955] [0000000000272d40] user address but active_mm is
> swapper
> > [    3.647983] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > [    3.654137] Modules linked in:
> > [    3.677285] Hardware name: Freescale i.MX8QM MEK (DT)
> > [    3.677302] Workqueue: events deferred_probe_work_func
> > [    3.684253] imx6q-pcie 5f000000.pcie: PCI host bridge to bus 0000:00
> > [    3.688297] pstate: 60000005 (nZCv daif -PAN -UAO)
> > [    3.688310] pc : xen_swiotlb_free_coherent+0x180/0x1c0
> > [    3.693993] pci_bus 0000:00: root bus resource [bus 00-ff]
> > [    3.701002] lr : xen_swiotlb_free_coherent+0x44/0x1c0
> > "
> >
> > In xen_swiotlb_alloc_coherent, if !(dev_addr + size - 1 <= dma_mask)
> > or range_straddles_page_boundary(phys, size) are true, it will create
> > contiguous region. So when free, we need to free contiguous region use
> > upper check condition.
> 
> No, this will break PV guests on x86.

Could you share more details why alloc and free not matching for the check?

Thanks,
Peng.

> 
> I think there is something wrong with your setup in combination with the ARM
> xen_create_contiguous_region() implementation.
> 
> Stefano?
> 
> 
> Juergen
> 
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >   drivers/xen/swiotlb-xen.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> > index b6d27762c6f8..ab96e468584f 100644
> > --- a/drivers/xen/swiotlb-xen.c
> > +++ b/drivers/xen/swiotlb-xen.c
> > @@ -346,8 +346,8 @@ xen_swiotlb_free_coherent(struct device *hwdev,
> size_t size, void *vaddr,
> >   	/* Convert the size to actually allocated. */
> >   	size = 1UL << (order + XEN_PAGE_SHIFT);
> >
> > -	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
> > -		     range_straddles_page_boundary(phys, size)) &&
> > +	if (((dev_addr + size - 1 > dma_mask) ||
> > +	    range_straddles_page_boundary(phys, size)) &&
> >   	    TestClearPageXenRemapped(virt_to_page(vaddr)))
> >   		xen_destroy_contiguous_region(phys, order);
> >
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
