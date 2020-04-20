Return-Path: <SRS0=cOz4=6E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B18DC3815B
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 15:32:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4600206F6
	for <iommu@archiver.kernel.org>; Mon, 20 Apr 2020 15:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tFvejdDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4600206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 73E9287E59;
	Mon, 20 Apr 2020 15:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gSBOV0sjpTGV; Mon, 20 Apr 2020 15:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 92E0F87E4C;
	Mon, 20 Apr 2020 15:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 728BEC07FF;
	Mon, 20 Apr 2020 15:32:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69BE4C0177
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5008020C41
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Po61vCgRG6oZ for <iommu@lists.linux-foundation.org>;
 Mon, 20 Apr 2020 15:32:30 +0000 (UTC)
X-Greylist: delayed 00:17:06 by SQLgrey-1.7.6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by silver.osuosl.org (Postfix) with ESMTPS id 0F6F32051B
 for <iommu@lists.linux-foundation.org>; Mon, 20 Apr 2020 15:32:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHIMhyzm56zW1LYVVi6argaKxI1Xn6ZvR+PwXPaY7y3TFxUrDdzxjC8fS1MfjqXm4N53RxL1JaQTznOW+QtJDCCqzCZRwlsjhqY+NcFgZ9bT0VNvN6oiHxu9Go0Qkx9xYdbL1BmOYBewDfMKCVR4nr+rIfdrXy9oP10b3CKrWQCrxVbDh65cXyHfh5JD1Ykmhn9JkdvrT/XO/UBSq/KsnXh6reyMP6kNkPm+nzMe6m0HJhNI9rlX8bKtbj+28xpVMhZaKyNmuKxzn+opTavswIGPsW7jmD2RUcqnuPNjvT7LZnQsIq+h184+xb/FVM9+Pdt6sQz+US9GMGto+BHZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlB20+Rmyl7OHe/6tsHMMwNKNZcnARrih+6tZhS8YOs=;
 b=JpdVihNktXyb+Mwpk9XCUxlxd1K5oIiRS6Es1L5L4Cg8znAsE6P0LPjK/6pUacLWz8YTUfYqiYfU3QXkFZhEsoe11NtVcG0ve7Iyr/XzM1IAe+OcirL6RDLuHzD6IhMIuueU7y4PGQuYMAgWmOd7MYoGYlKfuA0fsocSg0k57Me8O2cE1M94jwBe6VWPFLp3P3Olm2EJ84Mg2U5VzdGMzE0P4lD7HNzg6bNy79wi61XWVRl0Kt8Q7WRuNld+MjjBo09x+jzV/PHbBOcoTpZ/vac14f5tu5E7FHHSDQQZZa8thgHd0OyBW/IahwnHbACcLPAFgwRK9iyoxW8YsY1hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlB20+Rmyl7OHe/6tsHMMwNKNZcnARrih+6tZhS8YOs=;
 b=tFvejdDoDzp/1HhexSfRt0UoHTVbYtPQ/V1TAGWhW9n9RyyM9I0atV511ZETTmuIU5VYxaGmiXoVlfu0SJ4r/0X3K7ixVu+UZ1Wbw7zpcCgxVofnUw70tn+X124ut2oDhINxNqKw+Nz46Hy17pR+DkVNy+LEYnC5JYi/nak1ec4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:00:35 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:00:34 +0000
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org> <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org> <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
 <20200420115504.GA20664@infradead.org>
 <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <65709b48-526b-ff43-760c-0fe0317d5e9c@amd.com>
Date: Mon, 20 Apr 2020 11:00:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 15:00:29 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e3e7dc6-48d1-4fca-58e2-08d7e53b91d8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:|SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2512BFA656FA189B33FD864592D40@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(26005)(81156014)(8936002)(8676002)(86362001)(316002)(2616005)(956004)(478600001)(66574012)(186003)(16526019)(16576012)(66476007)(66556008)(36756003)(31696002)(5660300002)(52116002)(4326008)(7416002)(110136005)(6486002)(44832011)(2906002)(31686004)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRX8BVLLPrwFYYO28ur8xUzGd2KsrDdoQp3RWn85YlROeI0HViSEZtjDZ4JaHmL+bmvJnehRjn+BAEwuw8SypVVc+vQnNnYo7qX7HL+3BdfJr1sP1YbwFGqMZEgN5mXILFxiIinq+kZBIno82wiOJC152uhGYhkJUh9X88jeJWhA9TDj2i6d/Iy0QqpbPfLCNTdZ5E3OVmu457D/ARK68mZ7s3WXqBt7mIlnaUmAtVSpsZdJeOhqZ7WPyzixwoRJC8QOmlrHa1Qo6ZOoMoyNzuq6YNUIQy8lycg478VwXz9XzDNZbSfw4SkDItF0sXgMptXeRGhgWcFs1v4oJ9TW2aneYUKnKWHM24K7oR0breCLlfYb5YKCuJUJjp6nrQgvk2Hoq8l4eG5zzrRSeoENTe/g9QkROg1DhVe79UGph6NcnPD412kONpLK2I4Tw3zc
X-MS-Exchange-AntiSpam-MessageData: APW4AuyB41nOOrK+bR6qIzEwB3b/5fh6NoLcQXetg1QZgKqALWMTu1aI764U6MR22praENZ5ljx2zKa8YUAHXyxMQkuw+Mbqkwv8knQ+E6HEyTCA1HdKH0BE/TOPJgepePG/qSAlFS+1rf2gKPW/NQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3e7dc6-48d1-4fca-58e2-08d7e53b91d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:00:31.1099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+vtAbEtK09GfV5bFRarwkLDRgLklppa60qOdk2GuarJ/bDrDIcqDqwJOJgoAkfj1ZqCwTb3CUpeN6olbSoCaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 devicetree@vger.kernel.org, jgg@ziepe.ca, linux-pci@vger.kernel.org,
 robin.murphy@arm.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QW0gMjAyMC0wNC0yMCB1bSA4OjQwIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDIwLjA0LjIwIHVtIDEzOjU1IHNjaHJpZWIgQ2hyaXN0b3BoIEhlbGx3aWc6Cj4+IE9uIE1vbiwg
QXByIDIwLCAyMDIwIGF0IDAxOjQ0OjU2UE0gKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4+PiBBbSAyMC4wNC4yMCB1bSAxMDoxMCBzY2hyaWViIENocmlzdG9waCBIZWxsd2lnOgo+Pj4+
IE9uIE1vbiwgQXByIDIwLCAyMDIwIGF0IDA5OjQyOjEzQU0gKzAyMDAsIEplYW4tUGhpbGlwcGUg
QnJ1Y2tlciB3cm90ZToKPj4+Pj4gUmlnaHQsIEkgY2FuIHNlZSB0aGUgYXBwZWFsLiBJIHN0aWxs
IGxpa2UgaGF2aW5nIGEgc2luZ2xlIG1tdQo+Pj4+PiBub3RpZmllciBwZXIKPj4+Pj4gbW0gYmVj
YXVzZSBpdCBlbnN1cmVzIHdlIGFsbG9jYXRlIGEgc2luZ2xlIFBBU0lEIHBlciBtbSAoYXMKPj4+
Pj4gcmVxdWlyZWQgYnkKPj4+Pj4geDg2KS4gSSBzdXBwb3NlIG9uZSBhbHRlcm5hdGl2ZSBpcyB0
byBtYWludGFpbiBhIGhhc2h0YWJsZSBvZgo+Pj4+PiBtbS0+cGFzaWQsCj4+Pj4+IHRvIGF2b2lk
IGl0ZXJhdGluZyBvdmVyIGFsbCBib25kcyBkdXJpbmcgYWxsb2NhdGlvbi4KPj4+PiBHaXZlbiB0
aGF0IHRoZSBQQVNJRCBpcyBhIHByZXR0eSBnZW5lcmljIGFuZCBpbXBvcnRhbnQgY29uY2VwdCBj
YW4KPj4+PiB3ZSBqdXN0IGFkZCBpdCBkaXJlY3RseSB0byB0aGUgbW1fc3RydWN0IGFuZCBhbGxv
Y2F0ZSBpdCBsYXppbHkgb25jZQo+Pj4+IHdlIGZpcnN0IG5lZWQgaXQ/Cj4+PiBXZWxsIHRoZSBw
cm9ibGVtIGlzIHRoYXQgdGhlIFBBU0lEIG1pZ2h0IGFzIHdlbGwgYmUgZGV2aWNlIHNwZWNpZmlj
Lgo+Pj4gRS5nLgo+Pj4gc29tZSBkZXZpY2VzIHVzZSAxNmJpdCBQQVNJRHMsIHNvbWUgMTViaXQs
IHNvbWUgb3RoZXIgb25seSAxMmJpdC4KPj4+Cj4+PiBTbyB3aGF0IGNvdWxkIChhdCBsZWFzdCBp
biB0aGVvcnkpIGhhcHBlbiBpcyB0aGF0IHlvdSBuZWVkIHRvIGFsbG9jYXRlCj4+PiBkaWZmZXJl
bnQgUEFTSURzIGZvciB0aGUgc2FtZSBwcm9jZXNzIGJlY2F1c2UgZGlmZmVyZW50IGRldmljZXMg
bmVlZAo+Pj4gb25lLgo+PiBUaGlzIGRpcmVjdGx5IGNvbnRyYWRpY3RzIHRoZSBzdGF0ZW1lbnQg
ZnJvbSBKZWFuLVBoaWxpcHBlIGFib3ZlIHRoYXQKPj4geDg2IHJlcXVpcmVzIGEgc2luZ2xlIFBB
U0lEIHBlciBtbV9zdHJ1Y3QuwqAgSWYgd2UgbWF5IG5lZWQgZGlmZmVyZW50Cj4+IFBBU0lEcyBm
b3IgZGlmZmVyZW50IGRldmljZXMgYW5kIGNhbiBhY3R1YWxseSBzdXBwb3J0IHRoaXMganVzdAo+
PiBhbGxvY2F0aW5nIG9uZSBwZXIgW2RldmljZSwgbW1fc3RydWN0XSB3b3VsZCBtYWtlIG1vc3Qg
c2Vuc2Ugb2YgbWUsIGFzCj4+IGl0IGRvZXNuJ3QgY291cGxlIG90aGVyd2lzZSBkaXNqb2ludCBz
dGF0ZS4KPgo+IFdlbGwgSSdtIG5vdCBhbiBleHBlcnQgb24gdGhpcyB0b3BpYy4gRmVsaXggY2Fu
IHByb2JhYmx5IHRlbGwgeW91IGEKPiBiaXQgbW9yZSBhYm91dCB0aGF0Lgo+Cj4gTWF5YmUgaXQg
aXMgc3VmZmljaWVudCB0byBrZWVwIHRoZSBhbGxvY2F0ZWQgUEFTSURzIGFzIHNtYWxsIGFzCj4g
cG9zc2libGUgYW5kIHJldHVybiBhbiBhcHByb3ByaWF0ZSBlcnJvciBpZiBhIGRldmljZSBjYW4n
dCBkZWFsIHdpdGgKPiB0aGUgYWxsb2NhdGVkIG51bWJlci4KPgo+IElmIGEgZGV2aWNlIGNhbiBv
bmx5IGRlYWwgd2l0aCAxMmJpdCBQQVNJRHMgYW5kIG1vcmUgdGhhbiAyXjEyIHRyeSB0bwo+IHVz
ZSBpdCB0aGVyZSBpc24ndCBtdWNoIGVsc2Ugd2UgY2FuIGRvIHRoYW4gcmV0dXJuaW5nIGFuIGVy
cm9yIGFueXdheS4KCkknbSBwcm9iYWJseSBtaXNzaW5nIHNvbWUgY29udGV4dC4gQnV0IGxldCBt
ZSB0cnkgZ2l2aW5nIGEgdXNlZnVsIHJlcGx5LgoKVGhlIGhhcmR3YXJlIGFsbG93cyB5b3UgdG8g
aGF2ZSBkaWZmZXJlbnQgUEFTSURzIGZvciBlYWNoIGRldmljZQpyZWZlcnJpbmcgdG8gdGhlIHNh
bWUgYWRkcmVzcyBzcGFjZS4gQnV0IEkgdGhpbmsgaXQncyBPSyBmb3Igc29mdHdhcmUgdG8KY2hv
b3NlIG5vdCB0byBkbyB0aGF0LiBJZiBMaW51eCB3YW50cyB0byBtYW5hZ2Ugb25lIFBBU0lEIG5h
bWVzcGFjZSBmb3IKYWxsIGRldmljZXMsIHRoYXQncyBhIHJlYXNvbmFibGUgY2hvaWNlIElNTy4K
CkRpZmZlcmVudCBkZXZpY2VzIGhhdmUgZGlmZmVyZW50IGxpbWl0cyBmb3IgdGhlIHNpemUgb2Yg
UEFTSUQgdGhleSBjYW4Kc3VwcG9ydC4gRm9yIGV4YW1wbGUgQU1EIEdQVXMgc3VwcG9ydCAxNi1i
aXRzIGJ1dCB0aGUgSU9NTVUgc3VwcG9ydHMKbGVzcy4gU28gb24gQVBVcyB3ZSB1c2Ugc21hbGwg
UEFTSURzIGZvciBjb250ZXh0cyB0aGF0IHdhbnQgdG8gdXNlCklPTU1VdjIgdG8gYWNjZXNzIG1l
bW9yeSwgYnV0IGJpZ2dlciBQQVNJRHMgZm9yIGNvbnRleHRzIHRoYXQgZG8gbm90LgoKSSBjaG9v
c2UgdGhlIHdvcmQgImNvbnRleHQiIGRlbGliZXJhdGVseSwgYmVjYXVzZSB0aGUgYW1kZ3B1IGRy
aXZlciB1c2VzClBBU0lEcyBldmVuIHdoZW4gd2UncmUgbm90IHVzaW5nIElPTU1VdjIsIGFuZCB3
ZSdyZSB1c2luZyB0aGVtIHRvCmlkZW50aWZ5IEdQVSB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2VzLiBU
aGVyZSBjYW4gYmUgbW9yZSB0aGFuIG9uZSBwZXIKcHJvY2Vzcy4gSW4gcHJhY3RpY2UgeW91IGNh
biBoYXZlIHR3bywgb25lIGZvciBncmFwaGljcyAobm90IFNWTSwKZG9lc24ndCB1c2UgSU9NTVV2
MikgYW5kIG9uZSBmb3IgS0ZEIGNvbXB1dGUgKFNWTSwgY2FuIHVzZSBJT01NVXYyIG9uIEFQVXMp
LgoKQmVjYXVzZSB0aGUgSU9NTVV2MiBzdXBwb3J0cyBvbmx5IHNtYWxsZXIgUEFTSURzLCB3ZSB3
YW50IHRvIGF2b2lkCmV4aGF1c3RpbmcgdGhhdCBzcGFjZSB3aXRoIFBBU0lEIGFsbG9jYXRpb25z
IHRoYXQgZG9uJ3QgdXNlIHRoZSBJT01NVXYyLgpTbyBvdXIgUEFTSUQgYWxsb2NhdGlvbiBmdW5j
dGlvbiBoYXMgYSAic2l6ZSIgcGFyYW1ldGVyLCBhbmQgd2UgdHJ5IHRvCmFsbG9jYXRlZCBhIFBB
U0lEIGFzIGJpZyBhcyBwb3NzaWJsZSBpbiBvcmRlciB0byBsZWF2ZSBtb3JlIHByZWNpb3VzCnNt
YWxsZXIgUEFTSURzIGZvciBjb250ZXh0cyB0aGF0IG5lZWQgdGhlbS4KClRoZSBib3R0b20gbGlu
ZSBpcywgd2hlbiB5b3UgYWxsb2NhdGUgYSBQQVNJRCBmb3IgYSBjb250ZXh0LCB5b3Ugd2FudCB0
bwprbm93IGhvdyBzbWFsbCBpdCBuZWVkcyB0byBiZSBmb3IgYWxsIHRoZSBkZXZpY2VzIHRoYXQg
d2FudCB0byB1c2UgaXQuCklmIHlvdSBtYWtlIGl0IHRvbyBiaWcsIHNvbWUgZGV2aWNlIHdpbGwg
bm90IGJlIGFibGUgdG8gdXNlIGl0LiBJZiB5b3UKbWFrZSBpdCB0b28gc21hbGwsIHlvdSB3YXN0
ZSBwcmVjaW91cyBQQVNJRHMgdGhhdCBjb3VsZCBiZSB1c2VkIGZvcgpvdGhlciBjb250ZXh0cyB0
aGF0IG5lZWQgdGhlbS4KClJlZ2FyZHMsCsKgIEZlbGl4CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
