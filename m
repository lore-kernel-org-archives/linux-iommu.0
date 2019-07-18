Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C9C7C7618F
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:48:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3258221019
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 17:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ydsnii7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3258221019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 062E21ACB;
	Thu, 18 Jul 2019 17:48:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DD8851AC3
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:48:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800040.outbound.protection.outlook.com [40.107.80.40])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 563A58F1
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 17:48:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=XPPxH6gh4mXQqnHWxflqPG/I4aUGr7gfIkvM7sjI40E5itSTgKmYDDYmayEM0LvXPywK30l3RknR5DSTHSwLVJEx/ojJ7nNTNUhvV0L6vVNh9k7tfxzyVZS0pNL5tVmBWTTjbS9hwJUl7noaICnmtXA0szwnX3UWKWUoa2blOYINmBYAwdszZynx+kAh7y/fcct3+PpGIZL17Z1Bb8NfakVHxEwP3f21YCobX11lwsoF35C0svnD8zaCamNwwaatVnmLI9gbyfxznbCXSvscu5kvBEBNYpN1fRX7ZqzADAYT3qDk6g9AGJ9Yt6vB9XnvNVeQnTdSRM04de7MV3uFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sqYFTzPvqkPp1ogzDvPxzxk/XaqAr8Tx7Z9lSjMtonE=;
	b=W+dtYDUyyyYNi2uko7wt7U/hPpZIbArNg9Xv8OroVZ25hfYKznctPiy/EeIn3fQ49WYbHN/bTF6b7vK3zVwzQGEgnWxB6ApxEYTJ6fJECAUa49Spf826VzvA5osP7O/p6e1M+xJZ8P5kDMRKdBIt4R5bPnPu/rMZuL+yRsOo6S14rdG7SND0BUCsb+IufP28YInIDuvGclLTXqcdHgfNlfbFdNrom8s2vXi9eE1avLVHzuUQL1MMTqOGz0sFcymiCLfAvYwlaiIaENHCd9XKWCjrEZttU/SJ96h1qqxkibzyANrrNOQAyyrOc0PrY1z51UvgdONmEY+EqQcRgoNccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sqYFTzPvqkPp1ogzDvPxzxk/XaqAr8Tx7Z9lSjMtonE=;
	b=Ydsnii7NOzgZPaNaKd6KPEklvenCDIaa9NA3eF4qFPUtPP7NMR5ncnAOQJxDNfvljE1vDNjCvdIG0Sd/JhuZP/0LNs0eqvwcPqm7hQ8uc0WIgm4suhTkkbNzaa/GIWEvmo311Zxc69PDKgxuUJ2T98HUMJDcrpi6cZfY/nrW90g=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3081.namprd12.prod.outlook.com (20.178.30.203) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2073.11; Thu, 18 Jul 2019 17:48:21 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Thu, 18 Jul 2019 17:48:21 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
Thread-Topic: [PATCH v3 0/6] Remove x86-specific code from generic headers
Thread-Index: AQHVPRj/oX9x6en7K0GjSSUSyjk8U6bQp8QA
Date: Thu, 18 Jul 2019 17:48:21 +0000
Message-ID: <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
In-Reply-To: <20190718032858.28744-1-bauerman@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0156.namprd05.prod.outlook.com
	(2603:10b6:803:2c::34) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42a63cdc-3ef7-4951-4b30-08d70ba81fd7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3081; 
x-ms-traffictypediagnostic: DM6PR12MB3081:
x-microsoft-antispam-prvs: <DM6PR12MB30815EF8FE340B88AFC3097EECC80@DM6PR12MB3081.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01026E1310
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(54534003)(189003)(199004)(6512007)(305945005)(3846002)(478600001)(476003)(71200400001)(25786009)(6116002)(71190400001)(66946007)(2501003)(386003)(446003)(316002)(4326008)(54906003)(31686004)(11346002)(53936002)(256004)(52116002)(7736002)(66446008)(64756008)(6246003)(8676002)(8936002)(110136005)(66066001)(66476007)(99286004)(26005)(81166006)(2616005)(81156014)(5660300002)(6436002)(31696002)(6506007)(66556008)(86362001)(68736007)(14454004)(36756003)(6486002)(53546011)(229853002)(7416002)(486006)(186003)(102836004)(2906002)(76176011)(41533002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3081;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uvrtIfqOdJtQYYDYYQJHcGAIs5Vw2llnYaQuU65O9PMMmzz0QyQmvkIkKoD9xZvv4LPLiCIpU6nsdudoW7BBvlxb6AmRcweI0zWirRdD4f+244ss6J6bKT5RL0gJ0xXUwnVJSt9bSOHaLimXU46Cv+HiBQaeXLwaeyi9F3l4xsX5rJSp0pqpry2mf9ys9Uu0x/2gFzQ/0J70vqD6Rz4UDCBXWJdJ5+gVAERAn77t65WHxkGbUdcAPeEv9gf9h2d3xMQPdujLAKKTDv7TQQaD1AYBDR8EALksDqOkaLS8l4vYBcQY4yj9QRLoVXI58SoqEj0DXt8/4xzwXN0Z2/B/iq4hNKkfQEK2WizBMRZzqfh6ZfnE5MutkBuBs12DUinnlfwAEvLeEGyah9f+vp5JRJ3p5RHzxEMEy9FtrJGqfbI=
Content-ID: <F722F6675EEF4B4E824FE180F10FA466@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a63cdc-3ef7-4951-4b30-08d70ba81fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2019 17:48:21.4418 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>,
	Ram Pai <linuxram@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Christoph Hellwig <hch@lst.de>
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

On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
> Hello,
> 
> This version is mostly about splitting up patch 2/3 into three separate
> patches, as suggested by Christoph Hellwig. Two other changes are a fix in
> patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
> Janani and removal of sme_active and sev_active symbol exports as suggested
> by Christoph Hellwig.
> 
> These patches are applied on top of today's dma-mapping/for-next.
> 
> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
> been build tested.

I'll try and get this tested quickly to be sure everything works for SME
and SEV.

Thanks,
Tom

> 
> Changelog
> 
> Since v2:
> 
> - Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
>   - Added "select ARCH_HAS_MEM_ENCRYPT" to config S390. Suggested by Janani.
> 
> - Patch "DMA mapping: Move SME handling to x86-specific files"
>   - Split up into 3 new patches. Suggested by Christoph Hellwig.
> 
> - Patch "swiotlb: Remove call to sme_active()"
>   - New patch.
> 
> - Patch "dma-mapping: Remove dma_check_mask()"
>   - New patch.
> 
> - Patch "x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header"
>   - New patch.
>   - Removed export of sme_active symbol. Suggested by Christoph Hellwig.
> 
> - Patch "fs/core/vmcore: Move sev_active() reference to x86 arch code"
>   - Removed export of sev_active symbol. Suggested by Christoph Hellwig.
> 
> - Patch "s390/mm: Remove sev_active() function"
>   - New patch.
> 
> Since v1:
> 
> - Patch "x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig"
>   - Remove definition of ARCH_HAS_MEM_ENCRYPT from s390/Kconfig as well.
>   - Reworded patch title and message a little bit.
> 
> - Patch "DMA mapping: Move SME handling to x86-specific files"
>   - Adapt s390's <asm/mem_encrypt.h> as well.
>   - Remove dma_check_mask() from kernel/dma/mapping.c. Suggested by
>     Christoph Hellwig.
> 
> Thiago Jung Bauermann (6):
>   x86,s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
>   swiotlb: Remove call to sme_active()
>   dma-mapping: Remove dma_check_mask()
>   x86,s390/mm: Move sme_active() and sme_me_mask to x86-specific header
>   fs/core/vmcore: Move sev_active() reference to x86 arch code
>   s390/mm: Remove sev_active() function
> 
>  arch/Kconfig                        |  3 +++
>  arch/s390/Kconfig                   |  4 +---
>  arch/s390/include/asm/mem_encrypt.h |  5 +----
>  arch/s390/mm/init.c                 |  8 +-------
>  arch/x86/Kconfig                    |  4 +---
>  arch/x86/include/asm/mem_encrypt.h  | 10 ++++++++++
>  arch/x86/kernel/crash_dump_64.c     |  5 +++++
>  arch/x86/mm/mem_encrypt.c           |  2 --
>  fs/proc/vmcore.c                    |  8 ++++----
>  include/linux/crash_dump.h          | 14 ++++++++++++++
>  include/linux/mem_encrypt.h         | 15 +--------------
>  kernel/dma/mapping.c                |  8 --------
>  kernel/dma/swiotlb.c                |  3 +--
>  13 files changed, 42 insertions(+), 47 deletions(-)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
