Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78367C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 15:22:33 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4569B208C3
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 15:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BsP6AnL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4569B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E63812785;
	Wed,  1 May 2019 15:22:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8B0B12780
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 15:22:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2CB3A88A
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 15:22:00 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x41ExFjM181642; Wed, 1 May 2019 15:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=i/eVb1RrPCrDgsQYwTIls1vT7PGrIbuHhUptmv1sc2U=;
	b=BsP6AnL/ORY8ld331R4h0ac65YxS73XkP57Vczvh6L/OUPqAHMOzeF1ujrkUCRrgatxc
	jebYYcNYN8gNQ1pZZRlBgRtNrMTisjdd42nTg+Ycd9UXFg6tu7mpm/FPlvNziKb4GHgk
	Ev/rAHicr5ObHUMRbubGeDPRgTwGg3FWy0K33/iF0u2XsYkT68SDeK3uZU5y4oVZ33kj
	+ktkW9kzO8wVZMrVdA8Y+QMoCoV8U1+8O4GynSn3BODBw+OLs3zxFhsPGV8DCVHOV/rL
	f8jPd2DGbY/dStdvsDL4ViC8D5ksbEkNxvDpzU9xr8j+5etNJkZgs8hgSt7qW6slgjfr
	KA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by userp2120.oracle.com with ESMTP id 2s6xhyk8g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2019 15:21:04 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x41FIh2M030628; Wed, 1 May 2019 15:19:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by aserp3030.oracle.com with ESMTP id 2s6xhgjet8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2019 15:19:03 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x41FIjxB018467;
	Wed, 1 May 2019 15:18:46 GMT
Received: from [192.168.1.16] (/24.9.64.241)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 01 May 2019 08:18:45 -0700
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <4a47cf86-a05d-3de5-0320-eda06101cc75@oracle.com>
Date: Wed, 1 May 2019 09:18:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1905010096
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9243
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1905010096
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
Message-ID: <20190501151841.uumkmaOHusy6LnSY6pmmdkYUTBBI9a9NrKqukzDepbo@z>

T24gNS8xLzE5IDg6NDkgQU0sIFdhaW1hbiBMb25nIHdyb3RlOgo+IE9uIFdlZCwgQXByIDAzLCAy
MDE5IGF0IDExOjM0OjA0QU0gLTA2MDAsIEtoYWxpZCBBeml6IHdyb3RlOgo+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQKPiBiL0Rv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0Cj4gCj4+IGluZGV4
IDg1OGI2YzBiOWExNS4uOWIzNmRhOTQ3NjBlIDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dAo+PiBAQCAtMjk5Nyw2ICsyOTk3LDEy
IEBACj4+Cj4+IMKgwqDCoMKgwqAgbm94MmFwaWPCoMKgwqAgW1g4Ni02NCxBUElDXSBEbyBub3Qg
ZW5hYmxlIHgyQVBJQyBtb2RlLgo+Pgo+PiArwqDCoMKgIG5veHBmb8KgwqDCoMKgwqDCoMKgIFtY
UEZPXSBEaXNhYmxlIGVYY2x1c2l2ZSBQYWdlIEZyYW1lIE93bmVyc2hpcCAoWFBGTykKPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgd2hlbiBDT05GSUdfWFBGTyBpcyBvbi4gUGh5c2ljYWwgcGFn
ZXMgbWFwcGVkIGludG8KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNlciBhcHBsaWNhdGlv
bnMgd2lsbCBhbHNvIGJlIG1hcHBlZCBpbiB0aGUKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2VybmVsJ3MgYWRkcmVzcyBzcGFjZSBhcyBpZiBDT05GSUdfWFBGTyB3YXMgbm90Cj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVuYWJsZWQuCj4+ICsKPj4gwqDCoMKgwqDCoCBjcHUwX2hvdHBs
dWfCoMKgwqAgW1g4Nl0gVHVybiBvbiBDUFUwIGhvdHBsdWcgZmVhdHVyZSB3aGVuCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIENPTkZJR19CTyBPVFBBUkFNX0hPVFBMVUdfQ1BVMCBpcyBv
ZmYuCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFNvbWUgZmVhdHVyZXMgZGVwZW5kIG9u
IENQVTAuIEtub3duIGRlcGVuZGVuY2llcyBhcmU6Cj4gCj4gR2l2ZW4gdGhlIGJpZyBwZXJmb3Jt
YW5jZSBpbXBhY3QgdGhhdCBYUEZPIGNhbiBoYXZlLiBJdCBzaG91bGQgYmUgb2ZmIGJ5Cj4gZGVm
YXVsdCB3aGVuIGNvbmZpZ3VyZWQuIEluc3RlYWQsIHRoZSB4cGZvIG9wdGlvbiBzaG91bGQgYmUg
dXNlZCB0bwo+IGVuYWJsZSBpdC4KCkFncmVlZC4gSSBwbGFuIHRvIGRpc2FibGUgaXQgYnkgZGVm
YXVsdCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZQpwYXRjaC4gVGhpcyBpcyBsaWtlbHkgdG8g
ZW5kIHVwIGJlaW5nIGEgZmVhdHVyZSBmb3IgZXh0cmVtZSBzZWN1cml0eQpjb25zY2lvdXMgZm9s
a3Mgb25seSwgdW5sZXNzIEkgb3Igc29tZW9uZSBlbHNlIGNvbWVzIHVwIHdpdGggZnVydGhlcgpz
aWduaWZpY2FudCBwZXJmb3JtYW5jZSBib29zdC4KClRoYW5rcywKS2hhbGlkCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
