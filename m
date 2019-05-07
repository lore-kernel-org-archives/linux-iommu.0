Return-Path: <SRS0=4fho=TH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2CFC004C9
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 13:47:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F4020578
	for <iommu@archiver.kernel.org>; Tue,  7 May 2019 13:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kshwGRMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F4020578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4436CEAF;
	Tue,  7 May 2019 13:47:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37534EA8
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 13:47:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A25A5196
	for <iommu@lists.linux-foundation.org>;
	Tue,  7 May 2019 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=MrItdIULoaoyG6nD6rhbuYQO/rMTgTni2ROD0CXj/Uo=;
	b=kshwGRMH1R6sAH8zQyOfZxhcpOh/6gN3vCEbsGjFxMcvS+zmrOovqmwJXxvMwZyk3bckS+ql9XocmFu5cX62xca1NWcCxnwTpFtbZg+PQHMqpsvKb9h2IVjZMbwy4rMHHDXlGyEo61cCnZuV32G2fJ9YiAjc8TnYaTGplRrsrXE=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
	DM5PR12MB1786.namprd12.prod.outlook.com (10.175.91.14) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1856.11; Tue, 7 May 2019 13:47:35 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
	([fe80::11db:1b41:d1e6:c6dc]) by
	DM5PR12MB1449.namprd12.prod.outlook.com
	([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1856.012;
	Tue, 7 May 2019 13:47:35 +0000
From: Gary R Hook <ghook@amd.com>
To: Qian Cai <cai@lca.pw>, "jroedel@suse.de" <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Thread-Topic: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Thread-Index: AQHVA8HKhrRFrjUPUE6UqWoL4ARBq6Zfr1OA
Date: Tue, 7 May 2019 13:47:35 +0000
Message-ID: <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
References: <20190506041106.29167-1-cai@lca.pw>
In-Reply-To: <20190506041106.29167-1-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0049.prod.exchangelabs.com (2603:10b6:800::17) To
	DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841f5cb7-f6b2-43b3-3a9a-08d6d2f28f49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
	SRVR:DM5PR12MB1786; 
x-ms-traffictypediagnostic: DM5PR12MB1786:
x-microsoft-antispam-prvs: <DM5PR12MB17863BDF30CC4A5E359973E2FD310@DM5PR12MB1786.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(199004)(189003)(53936002)(68736007)(6512007)(256004)(229853002)(14444005)(66066001)(8676002)(81166006)(81156014)(2501003)(3846002)(26005)(71190400001)(71200400001)(476003)(36756003)(6486002)(6436002)(2616005)(446003)(11346002)(6506007)(386003)(52116002)(53546011)(99286004)(102836004)(5660300002)(7736002)(316002)(110136005)(54906003)(6116002)(486006)(305945005)(72206003)(478600001)(66446008)(186003)(14454004)(64756008)(66556008)(66476007)(2906002)(73956011)(66946007)(31686004)(76176011)(25786009)(31696002)(6246003)(4326008)(8936002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1786;
	H:DM5PR12MB1449.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iehGFDvsKQUKjGG8k4lAush6yN+x0xMD4OPm/eLqPaZPKDhtviBdk8Qw3BDBi1FVrO6wJAcn2qZCAV5hPaUazA1roY9hs7L84RLEErbpkyX5BfghjidFWa7o+r4ORy9qFCnBOhLNw0xWt1dqaHiauZRivcq6FmmwRVMyOywJnwqwZBcuKiMMGLUZABpGlrA4EaQYO1iyxJDAMo9a/lZZH7AfQe86sEti/LSa4DcGtgktcjnTmaMSV17yrl7+pAbDfmUiaaLAqtWb7VTP8e3PliMffEe5TdB2IgvtZfK04qc7RQnrte9wz1Z5Ejx9o7CvQuZQCgsZzu4g8w3opVIG+WjMl8TfiQz79ucth4M7xda86PMgBQcOVxY9LU6cffIbYfiUuVD3rQze/r1pkuab3Ypgw3MkzRzWP3oXRgniHx8=
Content-ID: <298EF8706C009A43B0877EC26E6790BE@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841f5cb7-f6b2-43b3-3a9a-08d6d2f28f49
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 13:47:35.2397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1786
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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

On 5/5/19 11:11 PM, Qian Cai wrote:
> [CAUTION: External Email]
> 
> The commit e7f63ffc1bf1 ("iommu/amd: Update logging information for new
> event type") introduced a variable "tag" but had never used it which
> generates a warning below,
> 
> drivers/iommu/amd_iommu.c: In function 'iommu_print_event':
> drivers/iommu/amd_iommu.c:567:33: warning: variable 'tag' set but not
> used [-Wunused-but-set-variable]
>    int type, devid, pasid, flags, tag;
>                                   ^~~
> so just use it during the logging.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   drivers/iommu/amd_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f7cdd2ab7f11..52f41369c5b3 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -631,9 +631,9 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>                  pasid = ((event[0] >> 16) & 0xFFFF)
>                          | ((event[1] << 6) & 0xF0000);
>                  tag = event[1] & 0x03FF;
> -               dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
> +               dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x tag=0x%04x address=0x%llx flags=0x%04x]\n",
>                          PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
> -                       pasid, address, flags);
> +                       pasid, tag, address, flags);
>                  break;
>          default:
>                  dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",

I did manage to overlook that variable when I posted the original patch. 
But it looks to me like 41e59a41fc5d1 (iommu tree) already fixed this... 
I'm not sure why it never got pushed to the main tree.

grh

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
