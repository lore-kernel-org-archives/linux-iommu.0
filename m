Return-Path: <SRS0=zJQD=YK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7274CA9EC8
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 23:31:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BA320854
	for <iommu@archiver.kernel.org>; Thu, 17 Oct 2019 23:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SQwhaZM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BA320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C3ABCAF;
	Thu, 17 Oct 2019 23:31:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 596CBCAE
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 23:31:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
	(mail-eopbgr790139.outbound.protection.outlook.com [40.107.79.139])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E773B7D2
	for <iommu@lists.linux-foundation.org>;
	Thu, 17 Oct 2019 23:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Gwx9Wji2g0neHCvxN4Q5GvKB6CI/yHZjQ71+dzFp87WbKK/ICqLhf9cKtJ48D6sUrP+2vuOAEopy0SR8dGRCdFhmFyXDP83idFYxTBnW+pzJkcKJa+ZrDjdFluTvSAhFA/FAxUKp1gz+s8spC7fPwBd6EEhmVDO42QKDdPE1Rrrl2H0+R8T5qRrb2oAXDGOc2aXAZNxZC+mo2mMYQex7eoeeqVbiYcvoA/2Qbhg0dk2NRu0XlVa2PhrSm4jdWJQBTQiWo7rBTGLWabEPsUrlX/hPYpoTXp0oaH9RfQXgHT9yPEbjfMXz0D9yd0NJx8aUAabWulxKSWOOJZ1vZpBjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=EcpqB0clQOtqRtDRq6LJKR99/JeIIJsD1tvaeqjvtWI=;
	b=NWmWmrwataMLqAl63aIVdFqxLQVZxoqn3oWdNKGTdpd2f5CJu0byz9qvhqPE15AzoiU4Sm48ClGHrEBW9OkbsE3FjDzD4qjFqXeEK8zsZjgCicaVXL5Q1zl5H603UxuyY52oo8/aBmRyRXjTasp90RlWJa0hK7iK58Whi94GCcxdIkVSZEysqpCxmEx+KKiBDJ6ANQ9aMzIBvRGlhFWJv9eFIbMCAEya8Ek2XbYjSPI76uy5HUWQOz7yI2bWRnsu1z1gxIoEDGSHE4RYIW0pv25n4guTCYNk+xQD2+nL4SEzzVh0R/pv5S67YO8H4LGWEzV5Uwe4zfyCx+trY/0AOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=microsoft.com; dmarc=pass action=none
	header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=EcpqB0clQOtqRtDRq6LJKR99/JeIIJsD1tvaeqjvtWI=;
	b=SQwhaZM2QeQLg1eqPF3U4h0leHLIGeno7iasQRgZjK7Y0k+ZjnT1I2jHfBHjQBhGc13osU5nvSOeXR3/SxKKqOKWmaM4Fh6bYHLKg7BjPEUiTkpmHsFhZRkKbdF7lM+BI5C4PlH6x2ug3FNRzeNIJqE17xl+dX1DR1Sn+Ha4DTY=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
	DM5PR21MB0156.namprd21.prod.outlook.com (10.173.173.19) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2387.8; Thu, 17 Oct 2019 23:31:14 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
	([fe80::356d:3ae3:a1c8:327e]) by
	DM5PR21MB0137.namprd21.prod.outlook.com
	([fe80::356d:3ae3:a1c8:327e%8]) with mapi id 15.20.2387.009;
	Thu, 17 Oct 2019 23:31:14 +0000
To: boqun.feng <boqun.feng@gmail.com>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: iommu: hyperv: Make HYPERV_IOMMU only available
	on x86
Thread-Topic: [PATCH] drivers: iommu: hyperv: Make HYPERV_IOMMU only available
	on x86
Thread-Index: AQHVhIXjbKTvIJIwEEeS7r8pz2yO3adffKQw
Date: Thu, 17 Oct 2019 23:31:13 +0000
Message-ID: <DM5PR21MB01372A106600DBCC137EAF30D76D0@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20191017005711.2013647-1-boqun.feng@gmail.com>
In-Reply-To: <20191017005711.2013647-1-boqun.feng@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-10-17T23:31:11.8063301Z;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft
	Azure Information Protection;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d05a4104-3e6f-45bd-8a90-5e2b83c1dfbc;
	MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b6d52fd-9e01-49b7-a99e-08d7535a19ce
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR21MB0156:|DM5PR21MB0156:|DM5PR21MB0156:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR21MB0156C3FD9D9E8C51D9AD4A96D76D0@DM5PR21MB0156.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(11346002)(25786009)(5660300002)(229853002)(476003)(486006)(446003)(186003)(71200400001)(71190400001)(2906002)(2501003)(55016002)(8936002)(66066001)(102836004)(4326008)(26005)(6116002)(76116006)(52536014)(66946007)(3846002)(9686003)(99286004)(8990500004)(6436002)(86362001)(66446008)(33656002)(10090500001)(8676002)(316002)(2201001)(76176011)(14454004)(7736002)(64756008)(6246003)(7696005)(305945005)(256004)(10290500003)(14444005)(478600001)(6506007)(54906003)(110136005)(74316002)(22452003)(66556008)(66476007)(81156014)(81166006);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DM5PR21MB0156;
	H:DM5PR21MB0137.namprd21.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CuMlVVzgmEWaoqDnytuBFPz7v521ebmEU45JOGhz4U1bmaFpZZnSEtEFqW6lxc5UJpouxFD8Ya5UF+ooYJ8ybvyB5dNiLfV1fpY0lIdNg82kbSThpUg+qIbGZGspa6ZdG2mu/uGLPyKdkxYYYTFW6aGZSIXAqpSlXdn8HaqzuGqUgJesJ/apBTSn6618KWsOSg6Z7vNffJbOS+G65UN6JpqeYalXLbj9VZoGCCVtfaBsuapU6cDI7KPC7PBfxVbwxENyjQDgBmfPWt0/vOg6XH9utbiKn5aRNif33mddbAoKt65MtkqjBr6geYMdqn4KsjAnkFAxMKGvj/lKKcXjJlD5+i+sxq3N9rZQUaWcl8tV1eL7wOiJP8Q+4F+4YT+ZWQmUCcO5n6+Spnax2LRocEUWYPppRfzzJHI7lFVRWvU=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6d52fd-9e01-49b7-a99e-08d7535a19ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 23:31:13.9311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aVA4AQPVIPqOmOPinarLregB2Zk6608+4k6lBa5UuKGD3VMTuy29zjCjSuMznX9ta4bb0V7nEM+Bjh198PjxP1Tl9zI0XJbBc8A3qHvQ5aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0156
Cc: "boqun.feng" <boqun.feng@gmail.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
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
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Boqun Feng <boqun.feng@gmail.com> Sent: Wednesday, October 16, 2019 5:57 PM
> 
> Currently hyperv-iommu is implemented in a x86 specific way, for
> example, apic is used. So make the HYPERV_IOMMU Kconfig depend on X86
> as a preparation for enabling HyperV on architecture other than x86.
> 
> Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
> ---
> 
> Without this patch, I could observe compile error:
> 
> | drivers/iommu/hyperv-iommu.c:17:10: fatal error: asm/apic.h: No such
> | file or directory
> |   17 | #include <asm/apic.h>
> |      |          ^~~~~~~~~~~~
> 
> , after apply Michael's ARM64 on HyperV enablement patchset.
> 
>  drivers/iommu/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e3842eabcfdd..f1086eaed41c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -467,7 +467,7 @@ config QCOM_IOMMU
> 
>  config HYPERV_IOMMU
>  	bool "Hyper-V x2APIC IRQ Handling"
> -	depends on HYPERV
> +	depends on HYPERV && X86
>  	select IOMMU_API
>  	default HYPERV
>  	help
> --
> 2.23.0

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
