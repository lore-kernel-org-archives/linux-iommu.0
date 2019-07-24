Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B95FC76186
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 16:42:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9AAE2189F
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W8Xl7ku6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AAE2189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ABC90F6C;
	Wed, 24 Jul 2019 16:42:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BCA2BF4D
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 16:42:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680053.outbound.protection.outlook.com [40.107.68.53])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E2B6FFE
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 16:42:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=LzVuK9KLGbmb5Nq+4rBZb6yvjH9ghN7CXGUzz6E8LK+48Rx9EGHPOds1Iv8rQDRcOueEBk4SoWEmuzlpZlj9bdcaEbc6RIZf5pT7IOqw4noO1Vh1OxExbV1cL/wGDpmvFQR+0aHAhn3wUEYBPs3ywBV3UTSe/ygLBNXZT+LY9ZM0SkQkk4HPLFHt7/3Ii8GGL8pwDUFA5hrHXlcqofW0yfmfewaifyuvwM56s5XFpRzfqCSdnzhI4sc7tBEy1zZlPY1SUGFgK47AaND/GmShLaYH6WMBosEbLIKcT/EllHDfg3teXfiLeqOdBsAFi7aqOTaLOG2IiSVRwwFGPBocWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=95v9hTjNjX05jPmYXWrCEZIxgJzaaYNopRlP6dA/qes=;
	b=JXv15IGK98hLsoc36l2+G9hqHVzy7OI4oszaZUfTv16BJNFWiMkVEFGUGtObY/7kSOtqfyudxdNXWNQJjCz9GCCpqPYlhHLC/vgaieuBj/Cp9ybg5sGTU0VK42KQ2vG++mLVquu3LssAE4iAfEeIso2N3nowHSE5F/nciZ2Lebzc2+v6QMCtojokSXy+GxW0Thi9wF814R6obd3gmIEnLzGSN9MsgrOVM7fm4+c/wOaob/sUehS+Z6WcKsfnbvHH/rCRoQy+CC/ApCQV9bnL9d0esSdLBJjQ03Gr6qAQ1gVCRZHslvksIQaKHRVnlPJXBNGH3UAWMPw/vzX5GKeNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=95v9hTjNjX05jPmYXWrCEZIxgJzaaYNopRlP6dA/qes=;
	b=W8Xl7ku6sijOylU8auT/ekXEWG6niGXDND2oyzoozam6IrD24Mcev0CCiyM5TU1dAS0J0vB03EkHk+RzLSgWb7mxXIL9IgcxGs6alWQNTa3h9s0teEH2yZpfH1kjJiDo3t1H9LWFmvWaIrp2vgN0ic3EcUMXwhmJ6zw37TyPq1k=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB2763.namprd12.prod.outlook.com (20.176.118.93) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2115.10; Wed, 24 Jul 2019 16:42:35 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2094.013;
	Wed, 24 Jul 2019 16:42:35 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
Thread-Topic: [PATCH] dma-direct: Force unencrypted DMA under SME for certain
	DMA masks
Thread-Index: AQHVN1HbhkVejMp04kW0O/tJG/K57qbaAcwAgAANJYA=
Date: Wed, 24 Jul 2019 16:42:35 +0000
Message-ID: <acee0a74-77fc-9c81-087b-ce55abf87bd4@amd.com>
References: <10b83d9ff31bca88e94da2ff34e30619eb396078.1562785123.git.thomas.lendacky@amd.com>
	<20190724155530.hlingpcirjcf2ljg@box>
In-Reply-To: <20190724155530.hlingpcirjcf2ljg@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0022.namprd06.prod.outlook.com
	(2603:10b6:805:8e::35) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c94b40c5-ca89-499c-79a2-08d71055ee70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB2763; 
x-ms-traffictypediagnostic: DM6PR12MB2763:
x-microsoft-antispam-prvs: <DM6PR12MB2763A765B507273CEA56144AECC60@DM6PR12MB2763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(189003)(199004)(5660300002)(6486002)(66476007)(53546011)(229853002)(386003)(4326008)(66556008)(66946007)(6506007)(14454004)(6116002)(26005)(8936002)(3846002)(6512007)(71190400001)(71200400001)(102836004)(54906003)(6916009)(186003)(316002)(66446008)(81156014)(81166006)(64756008)(6246003)(256004)(52116002)(68736007)(31696002)(31686004)(25786009)(53936002)(8676002)(2906002)(7736002)(7416002)(305945005)(2616005)(476003)(36756003)(486006)(478600001)(6436002)(11346002)(66066001)(99286004)(86362001)(446003)(76176011);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2763;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OE6o+gTZ3ZmQ+ZfSYJD7cCDH3ZAON0wW+wyat2P0i01aBOgD1Z98zyNguVWa6AbnIYMfyl9jiYPWnOg9yLRKxAPR+lYCjo0ekxEPxTQVVzSKEWvEAaX8QRfuX751MSR/rWDc7VsmIlPQQuoBZzQm6RuhvvQTjnrT1fVHJ6eYyHpapaxPIbW+E6hx6xSugdewvssJNRHTbPgriKuirKaG1n7169cAdZKTX3lS4/S1/O8fEANilSwS9qs3pZNkEa1gnmHK01ib/x2+mTzXE531u1HHRBuOU7e+VJtg2SnYAGcg4Re25BXsXwEiK5BlW4NeWCkIpk15SaYRdshegQlrb3EH3RJIvzrLtUTxqZLdBgjdGgfnQa30q7WN2Ck8jJ12k0vBkJQCd3AzA262HZuhb5EzwGkp2D46aZyeAtRFFq4=
Content-ID: <D055E53CB3BCD94DB631418512E4999B@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94b40c5-ca89-499c-79a2-08d71055ee70
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 16:42:35.6746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Lianbo Jiang <lijiang@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
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

On 7/24/19 10:55 AM, Kirill A. Shutemov wrote:
> On Wed, Jul 10, 2019 at 07:01:19PM +0000, Lendacky, Thomas wrote:
>> @@ -351,6 +355,32 @@ bool sev_active(void)
>>  }
>>  EXPORT_SYMBOL(sev_active);
>>  
>> +/* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>> +bool force_dma_unencrypted(struct device *dev)
>> +{
>> +	/*
>> +	 * For SEV, all DMA must be to unencrypted addresses.
>> +	 */
>> +	if (sev_active())
>> +		return true;
>> +
>> +	/*
>> +	 * For SME, all DMA must be to unencrypted addresses if the
>> +	 * device does not support DMA to addresses that include the
>> +	 * encryption mask.
>> +	 */
>> +	if (sme_active()) {
>> +		u64 dma_enc_mask = DMA_BIT_MASK(__ffs64(sme_me_mask));
>> +		u64 dma_dev_mask = min_not_zero(dev->coherent_dma_mask,
>> +						dev->bus_dma_mask);
>> +
>> +		if (dma_dev_mask <= dma_enc_mask)
>> +			return true;
> 
> Hm. What is wrong with the dev mask being equal to enc mask? IIUC, it
> means that device mask is wide enough to cover encryption bit, doesn't it?

Not really...  it's the way DMA_BIT_MASK works vs bit numbering. Let's say
that sme_me_mask has bit 47 set. __ffs64 returns 47 and DMA_BIT_MASK(47)
will generate a mask without bit 47 set (0x7fffffffffff). So the check
will catch anything that does not support at least 48-bit DMA.

Thanks,
Tom

> 
>> +	}
>> +
>> +	return false;
>> +}
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
