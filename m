Return-Path: <SRS0=ehRZ=VM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC344C7618F
	for <iommu@archiver.kernel.org>; Mon, 15 Jul 2019 15:44:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D022081C
	for <iommu@archiver.kernel.org>; Mon, 15 Jul 2019 15:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bj7U5cnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D022081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 67A78EC9;
	Mon, 15 Jul 2019 15:44:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CC73BEC2
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Jul 2019 15:44:47 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
	(mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0EC27876
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Jul 2019 15:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=A8hy4etxacvzqFWy9OvzYQBeASyMkUdHiNPXEUK0Yrpr/kYGRFsp+KoCDC3SstEq5DbFBcjB9gR6wG7/sgumWbHnPtnboWfqyuP5ZbVNGdKLb+FvOBXBxUNN6/4kHvZ8jeb33IP/31gGzZw4ZsEwEa1R3T5eBb9NknuGOlbBG3usThtcOgz85jibe5/8rnPeu41pzu1SVYcQKAnfIuYX0jDmbzY0nixcDrG24zCfenAkiJEJ/SyUD9RhKxKbvqIcvF8X1QcODH4n6lRFnXM4CaxrAPzTFUry+nIb+hlgyNMw4IZg7nQ57OOYgMJy/gBNNtRXjpPzJj7+sAtia0oDHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rkm7TlCflg2h/1CDmf+8ktI4jTUVpUIqS9NvG32ss0E=;
	b=Q3TEMDGLmrzHkZNfYET3SxOeYOxs2dRsO9RULb7ewz7RMTGJ+Rwj7l5VuWJ3sykW9mBNazOFoHAbGFIeZpZRol8o9NKjN3rA4+vo3yM8YdiDnHpOOUeLRkCVq3CGYYGGD4GtdA8YZuC6myjDWMzk+4Y5spMVR7fGIyH8L3VDtypVJghLWZ1/gc//8Jnt2AvA3aEAQxGyN/Rylv3kBPGh2L4AByOirtbx8U7XRtz37ednZ2m0kQhRH++QdIzThvX68yW7mu55/gq0qvmumZGudNE400tRgKxC3CbTT2Sjcu/bFMggxH78VrGcfUYAxgg+jbf90ej3y/S7LUXUtH7E4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
	smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com;
	dkim=pass header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=rkm7TlCflg2h/1CDmf+8ktI4jTUVpUIqS9NvG32ss0E=;
	b=bj7U5cnIW6AfdWq+we005xBQxadaCFpeY1/gm0mdbZAGbud9J1i+DMw94xDsCBNkecLNcStk4a79Q73ZzEJHWsVVxjFhx3RMyMdQhr5hCq6kMgTfkZprPI2ACy+3hLPrDlnEbBeWiEBN26+P+om8Giw9py2CgGszqpA3q/dczUA=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (20.179.104.150) by
	DM6PR12MB4220.namprd12.prod.outlook.com (10.141.187.71) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2073.10; Mon, 15 Jul 2019 15:44:45 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7]) by
	DM6PR12MB3163.namprd12.prod.outlook.com
	([fe80::9c3d:8593:906c:e4f7%6]) with mapi id 15.20.2073.012;
	Mon, 15 Jul 2019 15:44:45 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
To: Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
	arch code
Thread-Topic: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
	arch code
Thread-Index: AQHVOHSFvIHUoc7V+E67qRA9cO0Ig6bG9RYAgACTIICABDL6gIAAB6aAgAAUsAA=
Date: Mon, 15 Jul 2019 15:44:45 +0000
Message-ID: <56b79040-257b-3a89-c9d2-5842594cad17@amd.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
	<20190712053631.9814-4-bauerman@linux.ibm.com>
	<20190712150912.3097215e.pasic@linux.ibm.com>
	<87tvbqgboc.fsf@morokweng.localdomain>
	<20190715160317.7e3dfb33.pasic@linux.ibm.com>
	<20190715143039.GA6892@lst.de>
In-Reply-To: <20190715143039.GA6892@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0093.namprd12.prod.outlook.com
	(2603:10b6:802:21::28) To DM6PR12MB3163.namprd12.prod.outlook.com
	(2603:10b6:5:182::22)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=Thomas.Lendacky@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d1b8e82-6d74-4a39-35fb-08d7093b5c1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
	SRVR:DM6PR12MB4220; 
x-ms-traffictypediagnostic: DM6PR12MB4220:
x-microsoft-antispam-prvs: <DM6PR12MB42209CF912174AD934AC70A3ECCF0@DM6PR12MB4220.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(189003)(199004)(8936002)(305945005)(14454004)(14444005)(186003)(256004)(26005)(478600001)(81166006)(68736007)(8676002)(7736002)(36756003)(81156014)(2616005)(31686004)(446003)(54906003)(6246003)(11346002)(316002)(99286004)(476003)(486006)(6486002)(53936002)(6512007)(6436002)(7416002)(102836004)(53546011)(110136005)(66066001)(3846002)(6116002)(386003)(2906002)(6506007)(76176011)(52116002)(66446008)(5660300002)(66946007)(64756008)(66556008)(66476007)(71200400001)(71190400001)(86362001)(31696002)(4326008)(25786009)(229853002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4220;
	H:DM6PR12MB3163.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2o3CgTK+bX0s2m1XSegvscLbDT6F58lpElIkDqZpZU26BvxzZNhleRjrqJv+HR0G8yUEdUOAN/zrpN3wnXm8EsKQPjXZMjOg2pGr9PoQP0vj77hYLrd6xq6CQx2B3FqvB78bXjK8CcfgkOa09BP5acePv1z4g/E3srFrQpXB/KOtBk3wjjy0bLrrDM8HrbRwElah4N2CuXJjgPBgesiawmgYzTlTAOXBzkWlLiWtFW8zftxNcjxnwGoAluVWm1encfoKx+VbBFdTTE7WQGF7ZvllMOJ5pUVuvuz9VHBMPRuJ12gIVN329z9BgoKX+16C8lgd2Fj4hey4LFDJrfFkkawpVI/j8bumX2zjDjpROooNyoE1qxBXbVokIXRpQXaX+vfqU0O4RF0dobkMpFj87nq1Yh8t4LQqQY7X//6OuzY=
Content-ID: <E0FC09AEBDB7CF40BCF8F08977DC2498@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d1b8e82-6d74-4a39-35fb-08d7093b5c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 15:44:45.1446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tlendack@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Mike Anderson <andmike@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"x86@kernel.org" <x86@kernel.org>, Ram Pai <linuxram@us.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
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

On 7/15/19 9:30 AM, Christoph Hellwig wrote:
> On Mon, Jul 15, 2019 at 04:03:17PM +0200, Halil Pasic wrote:
>>> I thought about that but couldn't put my finger on a general concept.
>>> Is it "guest with memory inaccessible to the host"?
>>>
>>
>> Well, force_dma_unencrypted() is a much better name thatn sev_active():
>> s390 has no AMD SEV, that is sure, but for virtio to work we do need to
>> make our dma accessible to the hypervisor. Yes, your "guest with memory
>> inaccessible to the host" shows into the right direction IMHO.
>> Unfortunately I don't have too many cycles to spend on this right now.
> 
> In x86 it means that we need to remove dma encryption using
> set_memory_decrypted before using it for DMA purposes.  In the SEV
> case that seems to be so that the hypervisor can access it, in the SME
> case that Tom just fixes it is because there is an encrypted bit set
> in the physical address, and if the device doesn't support a large
> enough DMA address the direct mapping code has to encrypt the pages
> used for the contigous allocation.

Just a correction/clarification...

For SME, when a device doesn't support a large enough DMA address to
accommodate the encryption bit as part of the DMA address, the direct
mapping code has to provide un-encrypted pages. For un-encrypted pages,
the DMA address now does not include the encryption bit, making it
acceptable to the device. Since the device is now using a DMA address
without the encryption bit, the physical address in the CPU page table
must match (the call to set_memory_decrypted) so that both the device and
the CPU interact in the same way with the memory.

Thanks,
Tom

> 
>> Being on cc for your patch made me realize that things got broken on
>> s390. Thanks! I've sent out a patch that fixes protvirt, but we are going
>> to benefit from your cleanups. I think with your cleanups and that patch
>> of mine both sev_active() and sme_active() can be removed. Feel free to
>> do so. If not, I can attend to it as well.
> 
> Yes, I think with the dma-mapping fix and this series sme_active and
> sev_active should be gone from common code.  We should also be able
> to remove the exports x86 has for them.
> 
> I'll wait a few days and will then feed the dma-mapping fix to Linus,
> it might make sense to either rebase Thiagos series on top of the
> dma-mapping for-next branch, or wait a few days before reposting.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
