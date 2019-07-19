Return-Path: <SRS0=Jh8h=VQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C49C76188
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 13:12:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B836820873
	for <iommu@archiver.kernel.org>; Fri, 19 Jul 2019 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZVFR7r7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B836820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B2A0262A;
	Fri, 19 Jul 2019 13:12:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EB2692429
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 13:12:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
	(mail-eopbgr760045.outbound.protection.outlook.com [40.107.76.45])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 56810180
	for <iommu@lists.linux-foundation.org>;
	Fri, 19 Jul 2019 13:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Z+R4EvSfFC6oIOg0I57t2z+Xhzj+CCwoBxHdt+rsD9fjHnm5T4LwOs+3VZOvNdh+wlgvn/Ms+jx2afoMHU4gy2cD6amngRTsC4xyW9N9e8SsUGRssQSqCY7OQj5YrZ3XipDC+WRm7AAl60zuMjJH6ogD/1PzI30+4XE+QVAgVe42B7wup1WyXQ46ZB8NdqKpWcCQBFSa3tkb1bemtn6glYF8mKtwjicOeU3IvZ8JT4KieyFEexsspBZoG01KsRUC9nHTpFqSve8PGgbEhFiM/pvKjZzKXfvD65Sjd6jadJ5zqN5kwzMvCWJVooRF1HKU0en3B4Y/fMc2lA4sEcFsBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ggUqI1mtPCK2vMkfn/mmHXNkd5CgzlWib7SrLAVBYn4=;
	b=YsYmOwy+XGrf9f/u2ggKDbZK6oA9I/0x5F4oWIqig3UTRrN1TucnYbiZx582cO99yrUXWRTbXEkBjWRjmf18ird41I4iZ1FHlbtclb7r5ErLzSA0WcDtIVLkUz4IpGPilqVdSUmpAfz3gWEWZWd/AoX0VXKc2bMbvzpoIDAfqOIlqjskFS9LK4ySx7OVb8pnhfggiYBLSHSiYjjRbWxvrcbyy/hWIS2AWlDogEzzgTuM3O4pCuPHyfxNGgqPYqiW9J6GauKX8m5upvwnJJpOoUcW0NFh2ydp5sWYDJfXpH5Fz8E63suVxaI2j/FyLaeeV0djuiNfuOv0Ku49r3pKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=ggUqI1mtPCK2vMkfn/mmHXNkd5CgzlWib7SrLAVBYn4=;
	b=ZVFR7r7S6LbywOS+XXr/Kv6FMk4sAJRpvuIwl+1cAp8qzyk9s4PB9xZRGleFVB1JrdcHqKkCFiNw1uzTMheItotNXoaWuz5V79ki2QZ5fjLGpQOlMutMMGfCdRUD+YSOYt485wD9AHBzSJZpHp/YZWXatn3ohEvQOZylS1O5QVI=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB3019.namprd12.prod.outlook.com (20.178.30.12) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2094.12; Fri, 19 Jul 2019 13:12:34 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Fri, 19 Jul 2019 13:12:34 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
Thread-Topic: [PATCH v3 0/6] Remove x86-specific code from generic headers
Thread-Index: AQHVPRj/oX9x6en7K0GjSSUSyjk8U6bQU/MAgAB0XYCAASS5gA==
Date: Fri, 19 Jul 2019 13:12:33 +0000
Message-ID: <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
References: <20190718032858.28744-1-bauerman@linux.ibm.com>
	<680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com>
	<87a7db3z68.fsf@morokweng.localdomain>
In-Reply-To: <87a7db3z68.fsf@morokweng.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR04CA0004.namprd04.prod.outlook.com
	(2603:10b6:805:3e::17) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b2d442-bed0-474d-cc2b-08d70c4ac2f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB3019; 
x-ms-traffictypediagnostic: DM6PR12MB3019:
x-microsoft-antispam-prvs: <DM6PR12MB3019427DB838CD628D02CA71ECCB0@DM6PR12MB3019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01039C93E4
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(102836004)(53936002)(52116002)(7736002)(229853002)(256004)(6436002)(31696002)(25786009)(7416002)(8936002)(68736007)(6506007)(53546011)(305945005)(6916009)(6486002)(386003)(186003)(31686004)(486006)(71200400001)(71190400001)(2906002)(478600001)(446003)(14454004)(5660300002)(6512007)(4326008)(76176011)(54906003)(81156014)(476003)(26005)(2616005)(66066001)(6246003)(36756003)(8676002)(3846002)(6116002)(316002)(64756008)(66446008)(81166006)(66946007)(11346002)(66556008)(99286004)(86362001)(66476007)(4744005)(41533002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3019;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F+z10TAX7b2fjtuBQEJL/X8dKfTh3kpLJ9l2EFFTfGUpWQHv3pKi923NSa4WHX3bZUDw7uVBjpSbx5TWXFEMqHG85J5aQOhUfgGwLGGFUa5p0uTmHKFg2e7fQ1tLgzphhqT9M7A7P4Lbi6n7qpFOMh/91YWDTjI0TOJ2cTR+tsAAVNPOeyNH+SkzZnb7gzI/YwCi7X4PJy/k1QeFqUBtnxsi/prOkx6wcGurCvrIUusYqQGDuu9CUAI7jPK1mQzqrWjeIu5q9NF24AGyo03Uswm8UOS8Sjzk1eRLwW32/7PnqBBx1/zcZrPBZAEEVANxJaQqXz3JoLueq4RNAdMoXQrq+mjiDov0v1Un7n2z/LFvw8rakuUggZfcvDrQDch9lC0rmF+bSS8FnX1g7LY+vaOUs2o0/pKyEVkZUo+/dY0=
Content-ID: <E6763BDAFFDD7843AF08E64ECA218C71@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b2d442-bed0-474d-cc2b-08d70c4ac2f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2019 13:12:34.0158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Mike Anderson <andmike@linux.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
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

On 7/18/19 2:44 PM, Thiago Jung Bauermann wrote:
> 
> Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:
> 
>> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>>> Hello,
>>>
>>> This version is mostly about splitting up patch 2/3 into three separate
>>> patches, as suggested by Christoph Hellwig. Two other changes are a fix in
>>> patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
>>> Janani and removal of sme_active and sev_active symbol exports as suggested
>>> by Christoph Hellwig.
>>>
>>> These patches are applied on top of today's dma-mapping/for-next.
>>>
>>> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
>>> been build tested.
>>
>> I'll try and get this tested quickly to be sure everything works for SME
>> and SEV.

Built and tested both SME and SEV and everything appears to be working
well (not extensive testing, but should be good enough).

Thanks,
Tom

> 
> Thanks! And thanks for reviewing the patches.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
