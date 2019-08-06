Return-Path: <SRS0=bP0W=WC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E49CC433FF
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 13:39:02 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB01208C3
	for <iommu@archiver.kernel.org>; Tue,  6 Aug 2019 13:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ts0fga/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB01208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D69F4CC4;
	Tue,  6 Aug 2019 13:39:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 59764C7F
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 13:39:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
	(mail-eopbgr810078.outbound.protection.outlook.com [40.107.81.78])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 897CC89D
	for <iommu@lists.linux-foundation.org>;
	Tue,  6 Aug 2019 13:38:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=ZTEg16ry3vhRbnRUP+y0x/hsW202Tgro/MRoT6MMSYR4AmH0IXxjw71lKXsuOtwSeXLoflxFAqCE0/e0QbDKN9ABBGLrXOpoV4+c57odQw54nWU0bmCCqBMz2j4O+X4uc8FGKN6P85rmNSG4RlSWwcdmoCFRarUnOb1fWFP0NG2z6FXjQPOIzcDJaOQAR7em/JcJpmtXYtD7Iv2KO5vWhuddTuK5TOvKRgWvTcbWiok8eQu5ykNW5t6QB74WIwaRU8mOduIMixd9golEmOzWppATCEXUYh6MmKKlMq6PKZ/VyA9FQFPgvO0D6gTdU4karC5+YKLiN//ZO3pVUDpW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lwW/esXYhGhEUeROiIJOESnT7VKUfz7DmoZrXsEo3Xk=;
	b=VIVeLUQZAM/ESzpC8dMfBJnHZdrvT30st5kefSeXorEkHLAdss82WQ5/XSKX6oX3buqqFDRMgzm9vEYamBiXA6CDaAde0c/DEKYCZM6da2Zw+OAJafIPdtGdWIyKQjdu1Kd+q8uB4vKuEpu+1WDG55pvIGbEz8hSHG7xYo7ikKz7NKVXj0TEbwA7zp3zcyUPUMTnkAIOe5LUQgCcfBDYhsQNe5xVrPaXdeU9WH+a9LaBp4yKQCQ9JBpkC0HiglGtAbp19zmxbXKQOr31vgfd7MBMGn23/hQ0BxL3JHnOPEfXde/GBj6t7Aepn09m8Ojycqs7nim3I89mC/Qy6T3LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=lwW/esXYhGhEUeROiIJOESnT7VKUfz7DmoZrXsEo3Xk=;
	b=ts0fga/QAhMYtCjlyJH5bE3tlBgiqYFFjgxV8f7Fut/D1RBfZ8Jtt07fVba+uf8aPvd9OnbqglUFoQS24YW/W1DP12E5+9bgu3qcFcVOwdYD2p1GjSmyRqS4aQhzVDnHvx57SMzJ04dt9hs7Bts4mDEMZWLEVJmps0fRXiaKWkE=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3594.namprd12.prod.outlook.com (20.178.199.81) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2136.16; Tue, 6 Aug 2019 13:38:57 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2136.018;
	Tue, 6 Aug 2019 13:38:57 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Christoph Hellwig <hch@lst.de>, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Topic: Regression due to d98849aff879 (dma-direct: handle
	DMA_ATTR_NO_KERNEL_MAPPING in common code)
Thread-Index: AQHVTDc5jxhkF6eBGE2vQ7mpw/Pby6bt/Q4AgAAjGIA=
Date: Tue, 6 Aug 2019 13:38:57 +0000
Message-ID: <41cc93b1-62b5-7fb6-060d-01982e68503b@amd.com>
References: <1565082809.2323.24.camel@pengutronix.de>
	<20190806113318.GA20215@lst.de>
In-Reply-To: <20190806113318.GA20215@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0020.namprd06.prod.outlook.com
	(2603:10b6:805:8e::33) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 125b6e18-9dcb-4d2d-73e5-08d71a736e44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3594; 
x-ms-traffictypediagnostic: DM6PR12MB3594:
x-microsoft-antispam-prvs: <DM6PR12MB3594379105268ED358EB6AE7ECD50@DM6PR12MB3594.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(6116002)(6246003)(31696002)(256004)(31686004)(3846002)(36756003)(81166006)(86362001)(305945005)(26005)(81156014)(6486002)(478600001)(6512007)(25786009)(8936002)(54906003)(71190400001)(71200400001)(316002)(52116002)(7736002)(2906002)(110136005)(53936002)(64756008)(66556008)(66476007)(102836004)(14454004)(476003)(8676002)(99286004)(66446008)(486006)(5660300002)(76176011)(6436002)(4326008)(11346002)(53546011)(66066001)(229853002)(66946007)(446003)(6506007)(186003)(68736007)(2616005)(386003);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3594;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q+K75nkx9QaGUrW40RiqEbKpYNEaqcEVlKAtTLJLVL4RMXsDra36njh6iP5+gYlJz71ejwMSgWgvc03LM3qXjejMGhissrCKJccUIIeTVZAsUpZygyzXeFV87r7WRRJVOe9kQOchhewyCICvb57sye8Z7yeUHJ0+2I/KuKXYJgrOq7YoLnc7aZulWGcTYJGGOZvX22yLSRr4IezbtqDm3p1PgnWlQg64JLpi/o6Cavr1SIk5aFPR2g17eTd+XWED1npxCPvESkL4seUG5cmRXMgUApTorTOJ9Hv13//BMbmR5627TaWYbdWy+NYhCBUOWwEdPKxzAaBR57ZeeilDYnT5PwaWaLtLqekRyjJnsBZu4ZXuPS8g4qVV/E8haiX55goz+aZy5GlwtBYLwzAm8z6Mn8LuFg+qy7GQTA+SwuY=
Content-ID: <8065952E1A506246A136908F61BC426D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 125b6e18-9dcb-4d2d-73e5-08d71a736e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 13:38:57.1444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3594
Cc: Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On 8/6/19 6:33 AM, Christoph Hellwig wrote:
> On Tue, Aug 06, 2019 at 11:13:29AM +0200, Lucas Stach wrote:
>> Hi Christoph,
>>
>> I just found a regression where my NVMe device is no longer able to set
>> up its HMB.
>>
>> After subject commit dma_direct_alloc_pages() is no longer initializing
>> dma_handle properly when DMA_ATTR_NO_KERNEL_MAPPING is set, as the
>> function is now returning too early.
>>
>> Now this could easily be fixed by adding the phy_to_dma translation to
>> the NO_KERNEL_MAPPING code path, but I'm not sure how this stuff
>> interacts with the memory encryption stuff set up later in the
>> function, so I guess this should be looked at by someone with more
>> experience with this code than me.
> 
> There is not much we can do about the memory encryption case here,
> as that requires a kernel address to mark the memory as unencrypted.
> 
> So the obvious trivial fix is probably the right one:

This will present problems under SEV (probably not SME unless the DMA
mask doesn't support 48-bit DMA) when an NVMe device is passed through.
The Documentation states that DMA_ATTR_NO_KERNEL_MAPPING is to avoid
creating the mapping because of time and resources that may be involved
on some archs. Would it make sense to check for memory encryption using
force_dma_unencrypted() and override the flag in those cases? Does x86
have issues where this flag is needed? It could be set that the mapping
is only generated if you have to force an unencrypted DMA. The code isn't
as clean and you would have to hit the dma_direct_free_pages() path, also.

I suspect Power and s390 may have the same concerns here (adding them on
Cc: just in case).

Thanks,
Tom

> 
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 59bdceea3737..c49120193309 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -135,6 +135,7 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  		if (!PageHighMem(page))
>  			arch_dma_prep_coherent(page, size);
>  		/* return the page pointer as the opaque cookie */
> +		*dma_handle = phys_to_dma(dev, page_to_phys(page));
>  		return page;
>  	}
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
