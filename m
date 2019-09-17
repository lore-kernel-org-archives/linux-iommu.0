Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73513C4CECD
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:41:06 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA1B2054F
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4JVeVi2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA1B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 058F0BA4;
	Tue, 17 Sep 2019 18:41:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 60D3DBA0
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:41:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr690065.outbound.protection.outlook.com [40.107.69.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id BEE5683A
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:41:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Cau10OIOvDKATzwLWybCb3yrVT6odX4ZCyetTw7+Zode5y2qRb8ys8lasmRBD4cboeU0utTzdkOYtABO0kflQU0mpskOoewLaIwkbDtvnibIDO0TWpo1fKiyOpINh3PdKI5eriMV3DAvxZCLMdgkgBLtzW7BOecjBV91MkGXmxP8HdFvFXgswP3Ke2MCLfG0Ctiwkx/dbIxgkFk73mAb/N5+nDLHEjXTkjKWLrhC9mmT67/ZB40338zoO3YZK0Odix+gbCBtDrnKOjDEprk/lRzIBPCb6NKyiYQP+L5L2bfeDnhibTL5hDs4fMM8kNydmt/+cJj8DFa60Kk4rxo8tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=STIGllSdrhml3lsUo+Wtv1eCgCC0MjHGb4wrK76om0s=;
	b=dEpE2fnsspXb47OvMtIbD3NUuRE9dCPKtMTMEcKGqWCA/ddpcbOoAxBeeOwFMHpRNGQaZUBgd54o1Zc9iIj5dlAMmhwVVMHhpCrnxGwj/ixAn9/BkxytxkwXiLnrs2OyoYnJm/nWd5abHzRz5UN4k1fWYlDT9mE/5cyMPiNHHcbYPGC/1OTURUyI2AuwgFnf4H0wQqzvzLmiIhjjg1biM7y+Ij+HiNz7ZZrrJVorJU6yVTwTRdviG13kiCMPpgYDJjKydZXNVPuNWzoGJNksDCltlu6U/mGtrSOQfQCfuC8CA3NtgIRND8wU2fbo5eA6QoSPx6RZ3wEHspYFB0imCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=STIGllSdrhml3lsUo+Wtv1eCgCC0MjHGb4wrK76om0s=;
	b=4JVeVi2LchOZAudP/RPsOij6tQwn+2OxwtWWcpXetJNfC2GkBv4xlay4OXY+1/wl/36ooZsne7j0mn+1h3c976WYMnof++Bzac+Dr4bFP6dpz4fpT2P6PkZ2YbN7IOgF72QpBeki4NEbp77hGi+UyBSrH/grPgBcIag5wUcr+E0=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB2666.namprd12.prod.outlook.com (20.176.116.27) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2263.17; Tue, 17 Sep 2019 18:41:03 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::585:2d27:6e06:f9b0]) by DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::585:2d27:6e06:f9b0%7]) with mapi id 15.20.2263.023;
	Tue, 17 Sep 2019 18:41:03 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: David Rientjes <rientjes@google.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Thread-Topic: [bug] __blk_mq_run_hw_queue suspicious rcu usage
Thread-Index: AQHVY2lqe0y/Ny8J50ycIpieB3Q6FKccmUiAgAEU1ACAEVyvAIABOE0AgAAE/IA=
Date: Tue, 17 Sep 2019 18:41:02 +0000
Message-ID: <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
	<20190905060627.GA1753@lst.de>
	<alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
	<alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
	<alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0011.namprd06.prod.outlook.com
	(2603:10b6:803:2f::21) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 568b4c7f-f86f-494f-57f3-08d73b9e9770
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
	SRVR:DM6PR12MB2666; 
x-ms-traffictypediagnostic: DM6PR12MB2666:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB266674255C2A37D6865C3BF5EC8F0@DM6PR12MB2666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(81166006)(71200400001)(6436002)(6506007)(81156014)(6246003)(64756008)(6116002)(66476007)(2906002)(66066001)(8936002)(229853002)(31686004)(316002)(110136005)(3846002)(66556008)(66446008)(6486002)(54906003)(6512007)(4326008)(31696002)(26005)(76176011)(186003)(99286004)(305945005)(86362001)(8676002)(53546011)(386003)(66946007)(36756003)(71190400001)(25786009)(446003)(478600001)(11346002)(7736002)(476003)(14454004)(102836004)(52116002)(486006)(5660300002)(7416002)(14444005)(2616005)(256004);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2666;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JaI+ETOL76ZcMPGT7arga/10M90sqXlg2vGMxqSpwPfK0fWXnhnINcULdFQbfWOTUywm5OnrgUm9Nlf+xKlILXMIjqAvVP/Zip4n02I04AbTrtgz+kvk6FNt1z6+6lusreisNBvOZ/8nOs3ZZTH6OF7hZ25UJLTbJnwuqhjpDzNCmj/qBQJwjzxpieSwBBJDfC/Gi3D7O/J44b4D0mYg0hHwUT5WjT0tnOoxwYnVOhcqdQJBwN3i0RhNsUYcMpBzt8o9vJfzY4ns3UAW7A8+iX45Tnjm0yVYPpkeSuV0j5DSgGa6b21CTSBKOlmd+HRIkcEQltXB1y1V8cIYb1DP17aWa44h3lgPr1CmxVuwbpYLZX3nT6YowNoMydWSHAc+uZGM/cFd13Y8Q/eV6yhwQmt0dv7F3RPIvJbWUVQIjxI=
Content-ID: <4DC37A5F8C8F4B4B979FC5160ADED03B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568b4c7f-f86f-494f-57f3-08d73b9e9770
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 18:41:02.9237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6e3CGnsO9vv6ofIqHPL5Ist+degQvBJc06ioWjw0OGceTb3srGDb8jm6hThn7eoH1u3md2C35vzAu0z1sB9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Peter Gonda <pgonda@google.com>, Jianxiong Gao <jxgao@google.com>
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

On 9/17/19 1:23 PM, David Rientjes wrote:
> On Mon, 16 Sep 2019, David Rientjes wrote:
> 
>> Brijesh and Tom, we currently hit this any time we boot an SEV enabled 
>> Ubuntu 18.04 guest; I assume that guest kernels, especially those of such 
>> major distributions, are expected to work with warnings and BUGs when 
>> certain drivers are enabled.
>>
>> If the vmap purge lock is to remain a mutex (any other reason that 
>> unmapping aliases can block?) then it appears that allocating a dmapool 
>> is the only alternative.  Is this something that you'll be addressing 
>> generically or do we need to get buy-in from the maintainers of this 
>> specific driver?
>>
> 
> We've found that the following applied on top of 5.2.14 suppresses the 
> warnings.
> 
> Christoph, Keith, Jens, is this something that we could do for the nvme 
> driver?  I'll happily propose it formally if it would be acceptable.
> 
> Thanks!
> 
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1613,7 +1613,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>  		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>  		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
>  		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
> -		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
> +		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED |
> +					  BLK_MQ_F_BLOCKING;

I think you want to only set the BLK_MQ_F_BLOCKING if the DMA is required
to be unencrypted. Unfortunately, force_dma_unencrypted() can't be called
from a module. Is there a DMA API that could be called to get that info?

Thanks,
Tom

>  		dev->admin_tagset.driver_data = dev;
>  
>  		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
> @@ -2262,7 +2263,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.queue_depth =
>  				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
>  		dev->tagset.cmd_size = sizeof(struct nvme_iod);
> -		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
> +		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE |
> +				    BLK_MQ_F_BLOCKING;
>  		dev->tagset.driver_data = dev;
>  
>  		ret = blk_mq_alloc_tag_set(&dev->tagset);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
