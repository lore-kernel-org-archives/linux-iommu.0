Return-Path: <SRS0=En+E=3E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8BDC33CB1
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243C52187F
	for <iommu@archiver.kernel.org>; Wed, 15 Jan 2020 12:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z53Oerl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243C52187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E4D642050E;
	Wed, 15 Jan 2020 12:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7ujydwUrTpa; Wed, 15 Jan 2020 12:02:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C6BD11FD43;
	Wed, 15 Jan 2020 12:02:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C505C1D83;
	Wed, 15 Jan 2020 12:02:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BB93C077D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:02:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 70DB485D26
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:02:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wRTz1spgtQ6j for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jan 2020 12:02:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id E4E4D85DBB
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jan 2020 12:02:15 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EF4DB2187F;
 Wed, 15 Jan 2020 12:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579089735;
 bh=TO5UFyVXqPIEmhn24jmBqJH1UNBUHjDoh+E/hSQY4uk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=z53Oerl7n8zbUE6seRg1o8NOKvzxlsVNnV27zQwafcpsHlv52i1T84HDgX8ywjXou
 P8VYoeiJS7tXH/X/kxVeLcZ2+rqp8q4/tjZJDA101qoJqQj4JHWiAUW5vpLvBJ5M0H
 xAf64mzsRC1NtdzsjWQcUsBSCxup6Kp/s4KdX9oo=
Date: Wed, 15 Jan 2020 13:02:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v11 2/4] uacce: add uacce driver
Message-ID: <20200115120212.GA3270387@kroah.com>
References: <1578710919-12141-1-git-send-email-zhangfei.gao@linaro.org>
 <1578710919-12141-3-git-send-email-zhangfei.gao@linaro.org>
 <20200111194006.GD435222@kroah.com>
 <053ccd05-4f11-5be6-47c2-eee5c2f1fdc4@linaro.org>
 <20200114145934.GA1960403@kroah.com>
 <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c71b402c-a185-50a7-2827-c1836cc6c237@linaro.org>
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-crypto@vger.kernel.org, Kenneth Lee <liguozhu@hisilicon.com>,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

T24gV2VkLCBKYW4gMTUsIDIwMjAgYXQgMDc6MTg6MzRQTSArMDgwMCwgemhhbmdmZWkgd3JvdGU6
Cj4gSGksIEdyZWcKPiAKPiBPbiAyMDIwLzEvMTQg5LiL5Y2IMTA6NTksIEdyZWcgS3JvYWgtSGFy
dG1hbiB3cm90ZToKPiA+IE9uIE1vbiwgSmFuIDEzLCAyMDIwIGF0IDExOjM0OjU1QU0gKzA4MDAs
IHpoYW5nZmVpIHdyb3RlOgo+ID4gPiBIaSwgR3JlZwo+ID4gPiAKPiA+ID4gVGhhbmtzIGZvciB0
aGUgcmV2aWV3Lgo+ID4gPiAKPiA+ID4gT24gMjAyMC8xLzEyIOS4iuWNiDM6NDAsIEdyZWcgS3Jv
YWgtSGFydG1hbiB3cm90ZToKPiA+ID4gPiBPbiBTYXQsIEphbiAxMSwgMjAyMCBhdCAxMDo0ODoz
N0FNICswODAwLCBaaGFuZ2ZlaSBHYW8gd3JvdGU6Cj4gPiA+ID4gPiArc3RhdGljIGludCB1YWNj
ZV9mb3BzX29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGVwKQo+ID4g
PiA+ID4gK3sKPiA+ID4gPiA+ICsJc3RydWN0IHVhY2NlX21tICp1YWNjZV9tbSA9IE5VTEw7Cj4g
PiA+ID4gPiArCXN0cnVjdCB1YWNjZV9kZXZpY2UgKnVhY2NlOwo+ID4gPiA+ID4gKwlzdHJ1Y3Qg
dWFjY2VfcXVldWUgKnE7Cj4gPiA+ID4gPiArCWludCByZXQgPSAwOwo+ID4gPiA+ID4gKwo+ID4g
PiA+ID4gKwl1YWNjZSA9IHhhX2xvYWQoJnVhY2NlX3hhLCBpbWlub3IoaW5vZGUpKTsKPiA+ID4g
PiA+ICsJaWYgKCF1YWNjZSkKPiA+ID4gPiA+ICsJCXJldHVybiAtRU5PREVWOwo+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gKwlpZiAoIXRyeV9tb2R1bGVfZ2V0KHVhY2NlLT5wYXJlbnQtPmRyaXZlci0+
b3duZXIpKQo+ID4gPiA+ID4gKwkJcmV0dXJuIC1FTk9ERVY7Cj4gPiA+ID4gV2h5IGFyZSB5b3Ug
dHJ5aW5nIHRvIGdyYWIgdGhlIG1vZHVsZSByZWZlcmVuY2Ugb2YgdGhlIHBhcmVudCBkZXZpY2U/
Cj4gPiA+ID4gV2h5IGlzIHRoYXQgbmVlZGVkIGFuZCB3aGF0IGlzIHRoYXQgZ29pbmcgdG8gaGVs
cCB3aXRoIGhlcmU/Cj4gPiA+ID4gCj4gPiA+ID4gVGhpcyBzaG91bGRuJ3QgYmUgbmVlZGVkIGFz
IHRoZSBtb2R1bGUgcmVmZXJlbmNlIG9mIHRoZSBvd25lciBvZiB0aGUKPiA+ID4gPiBmaWxlb3Bz
IGZvciB0aGlzIG1vZHVsZSBpcyBpbmNyZW1lbnRlZCwgYW5kIHRoZSAicGFyZW50IiBtb2R1bGUg
ZGVwZW5kcwo+ID4gPiA+IG9uIHRoaXMgbW9kdWxlLCBzbyBob3cgY291bGQgaXQgYmUgdW5sb2Fk
ZWQgd2l0aG91dCB0aGlzIGNvZGUgYmVpbmcKPiA+ID4gPiB1bmxvYWRlZD8KPiA+ID4gPiAKPiA+
ID4gPiBZZXMsIGlmIHlvdSBidWlsZCB0aGlzIGNvZGUgaW50byB0aGUga2VybmVsIGFuZCB0aGUg
InBhcmVudCIgZHJpdmVyIGlzIGEKPiA+ID4gPiBtb2R1bGUsIHRoZW4geW91IHdpbGwgbm90IGhh
dmUgYSByZWZlcmVuY2UsIGJ1dCB3aGVuIHlvdSByZW1vdmUgdGhhdAo+ID4gPiA+IHBhcmVudCBk
cml2ZXIgdGhlIGRldmljZSB3aWxsIGJlIHJlbW92ZWQgYXMgaXQgaGFzIHRvIGJlIHVucmVnaXN0
ZXJlZAo+ID4gPiA+IGJlZm9yZSB0aGF0IHBhcmVudCBkcml2ZXIgY2FuIGJlIHJlbW92ZWQgZnJv
bSB0aGUgc3lzdGVtLCByaWdodD8KPiA+ID4gPiAKPiA+ID4gPiBPciB3aGF0IGFtIEkgbWlzc2lu
ZyBoZXJlPwo+ID4gPiBUaGUgcmVmY291bnQgaGVyZSBpcyBwcmV2ZW50aW5nIHJtbW9kICJwYXJl
bnQiIG1vZHVsZSBhZnRlciBmZCBpcyBvcGVuZWQsCj4gPiA+IHNpbmNlIHVzZXIgZHJpdmVyIGhh
cyBtbWFwIGtlcm5lbCBtZW1vcnkgdG8gdXNlciBzcGFjZSwgbGlrZSBtbWlvLCB3aGljaCBtYXkK
PiA+ID4gc3RpbGwgaW4tdXNlLgo+ID4gPiAKPiA+ID4gV2l0aCB0aGUgcmVmY291bnQgcHJvdGVj
dGlvbiwgcm1tb2QgInBhcmVudCIgbW9kdWxlIHdpbGwgZmFpbCB1bnRpbAo+ID4gPiBhcHBsaWNh
dGlvbiBmcmVlIHRoZSBmZC4KPiA+ID4gbG9nIGxpa2U6IHJtbW9kOiBFUlJPUjogTW9kdWxlIGhp
c2lfemlwIGlzIGluIHVzZQo+ID4gQnV0IGlmIHRoZSAicGFyZW50IiBtb2R1bGUgaXMgdG8gYmUg
dW5sb2FkZWQsIGl0IGhhcyB0byB1bnJlZ2lzdGVyIHRoZQo+ID4gImNoaWxkIiBkZXZpY2UgYW5k
IHRoYXQgd2lsbCBjYWxsIHRoZSBkZXN0cnVjdG9yIGluIGhlcmUgYW5kIHRoZW4geW91Cj4gPiB3
aWxsIHRlYXIgZXZlcnl0aGluZyBkb3duIGFuZCBhbGwgc2hvdWxkIGJlIGdvb2QuCj4gPiAKPiA+
IFRoZXJlJ3Mgbm8gbmVlZCB0byAiZm9yYmlkIiBhIG1vZHVsZSBmcm9tIGJlaW5nIHVubG9hZGVk
LCBldmVuIGlmIGl0IGlzCj4gPiBiZWluZyB1c2VkLiAgTG9vayBhdCBhbGwgbmV0d29ya2luZyBk
cml2ZXJzLCB0aGV5IHdvcmsgdGhhdCB3YXksIHJpZ2h0Pwo+IFRoYW5rcyBHcmVnIGZvciB0aGUg
a2luZCBzdWdnZXN0aW9uLgo+IAo+IEkgc3RpbGwgaGF2ZSBvbmUgdW5jZXJ0YWludHkuCj4gRG9l
cyB1YWNjZSBoYXMgdG8gYmxvY2sgcHJvY2VzcyBjb250aW51ZSBhY2Nlc3NpbmcgdGhlIG1tYXBw
ZWQgYXJlYSB3aGVuCj4gcmVtb3ZlICJwYXJlbnQiIG1vZHVsZT8KPiBVYWNjZSBjYW4gYmxvY2sg
ZGV2aWNlIGFjY2VzcyB0aGUgcGh5c2ljYWwgbWVtb3J5IHdoZW4gcGFyZW50IG1vZHVsZSBjYWxs
Cj4gdWFjY2VfcmVtb3ZlLgo+IEJ1dCBhcHBsaWNhdGlvbiBpcyBzdGlsbCBydW5uaW5nLCBhbmQg
c3VwcG9zZSBpdCBpcyBub3QgdGhlIGtlcm5lbCBkcml2ZXIncwo+IHJlc3BvbnNpYmlsaXR5IHRv
IGNhbGwgdW5tYXAuCj4gCj4gSSBhbSBsb29raW5nIGZvciBzb21lIGV4YW1wbGVzIGluIGtlcm5l
bCwKPiBsb29rcyB2ZmlvIGRvZXMgbm90IGJsb2NrIHByb2Nlc3MgY29udGludWUgYWNjZXNzaW5n
IHdoZW4KPiB2ZmlvX3VucmVnaXN0ZXJfaW9tbXVfZHJpdmVyIGVpdGhlci4KPiAKPiBJbiBteSB0
ZXN0LCBhcHBsaWNhdGlvbiB3aWxsIGtlZXAgd2FpdGluZyBhZnRlciBybW1vZCBwYXJlbnQsIHVu
dGlsIGN0cmwrYywKPiB3aGVuIHVubWFwIGlzIGNhbGxlZC4KPiBEdXJpbmcgdGhlIHByb2Nlc3Ms
IGtlcm5lbCBkb2VzIG5vdCByZXBvcnQgYW55IGVycm9yLgo+IAo+IERvIHlvdSBoYXZlIGFueSBh
ZHZpY2U/CgpJcyB0aGVyZSBubyB3YXkgZm9yIHRoZSBrZXJuZWwgdG8gaW52YWxpZGF0ZSB0aGUg
bWVtb3J5IGFuZCB0ZWxsIHRoZQpwcm9jZXNzIHRvIHN0b3A/ICB0dHkgZHJpdmVycyBkbyB0aGlz
IGZvciB3aGVuIHRoZXkgYXJlIHJlbW92ZWQgZnJvbSB0aGUKc3lzdGVtLgoKQW55d2F5LCB0aGlz
IGlzIGFsbCB2ZXJ5IHJhcmUsIG5vIGtlcm5lbCBtb2R1bGUgaXMgZXZlciB1bmxvYWRlZCBvbiBh
CnJlYWwgc3lzdGVtLCB0aGF0IGlzIG9ubHkgZm9yIHdoZW4gZGV2ZWxvcGVycyBhcmUgd29ya2lu
ZyBvbiB0aGVtLCBzbwppdCdzIHByb2JhYmx5IG5vdCB0aGF0IGJpZyBvZiBhbiBpc3N1ZSwgcmln
aHQ/Cgp0aGFua3MsCgpncmVnIGstaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
