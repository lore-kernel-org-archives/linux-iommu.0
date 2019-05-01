Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0625AC43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 14:50:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9237208C3
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 14:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9237208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 704AE26ED;
	Wed,  1 May 2019 14:50:24 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1B25F26E5
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 14:49:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B0CEB88A
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 14:49:50 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AA7EC024915;
	Wed,  1 May 2019 14:49:49 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E30A710021B4;
	Wed,  1 May 2019 14:49:44 +0000 (UTC)
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Khalid Aziz <khalid.aziz@oracle.com>, Ingo Molnar <mingo@kernel.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
Date: Wed, 1 May 2019 10:49:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 01 May 2019 14:49:50 +0000 (UTC)
Cc: Dave Hansen <dave@sr71.net>, linux-doc@vger.kernel.org, linux-mm@kvack.org,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>, tycho@tycho.ws,
	x86@kernel.org, iommu@lists.linux-foundation.org,
	jsteckli@amazon.de, Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, konrad.wilk@oracle.com,
	jcm@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>, boris.ostrovsky@oracle.com,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
	tyhicks@canonical.com, linux-security-module@vger.kernel.org,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, dwmw@amazon.co.uk
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501144944.4O9MJFHrShYx1AEDkgLru0OoY0-7uOLhy8j-67nofrA@z>

T24gV2VkLCBBcHIgMDMsIDIwMTkgYXQgMTE6MzQ6MDRBTSAtMDYwMCwgS2hhbGlkIEF6aXogd3Jv
dGU6Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0CmIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50
eHQKCj4gaW5kZXggODU4YjZjMGI5YTE1Li45YjM2ZGE5NDc2MGUgMTAwNjQ0Cj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPiArKysgYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+IEBAIC0yOTk3LDYg
KzI5OTcsMTIgQEAKPgo+wqDCoMKgwqDCoCBub3gyYXBpY8KgwqDCoCBbWDg2LTY0LEFQSUNdIERv
IG5vdCBlbmFibGUgeDJBUElDIG1vZGUuCj4KPiArwqDCoMKgIG5veHBmb8KgwqDCoMKgwqDCoMKg
IFtYUEZPXSBEaXNhYmxlIGVYY2x1c2l2ZSBQYWdlIEZyYW1lIE93bmVyc2hpcCAoWFBGTykKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3aGVuIENPTkZJR19YUEZPIGlzIG9uLiBQaHlzaWNhbCBw
YWdlcyBtYXBwZWQgaW50bwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVzZXIgYXBwbGljYXRp
b25zIHdpbGwgYWxzbyBiZSBtYXBwZWQgaW4gdGhlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2VybmVsJ3MgYWRkcmVzcyBzcGFjZSBhcyBpZiBDT05GSUdfWFBGTyB3YXMgbm90Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW5hYmxlZC4KPiArCj7CoMKgwqDCoMKgIGNwdTBfaG90cGx1Z8Kg
wqDCoCBbWDg2XSBUdXJuIG9uIENQVTAgaG90cGx1ZyBmZWF0dXJlIHdoZW4KPsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIENPTkZJR19CTyBPVFBBUkFNX0hPVFBMVUdfQ1BVMCBpcyBvZmYuCj7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTb21lIGZlYXR1cmVzIGRlcGVuZCBvbiBDUFUwLiBL
bm93biBkZXBlbmRlbmNpZXMgYXJlOgoKR2l2ZW4gdGhlIGJpZyBwZXJmb3JtYW5jZSBpbXBhY3Qg
dGhhdCBYUEZPIGNhbiBoYXZlLiBJdCBzaG91bGQgYmUgb2ZmIGJ5CmRlZmF1bHQgd2hlbiBjb25m
aWd1cmVkLiBJbnN0ZWFkLCB0aGUgeHBmbyBvcHRpb24gc2hvdWxkIGJlIHVzZWQgdG8KZW5hYmxl
IGl0LgoKQ2hlZXJzLApMb25nbWFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
