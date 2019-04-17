Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7BFC282DC
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:26:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C47021773
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 17:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcvYWJCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C47021773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 29C2CDB5;
	Wed, 17 Apr 2019 17:26:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9BD5BD86
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:26:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0928486F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 17:26:37 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id z11so4375277wmi.0
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:content-transfer-encoding:in-reply-to
	:user-agent; bh=ns0QxnuhAfvDI+e0rO3qV1NnmRx4qtLcXwX4SEWj8w8=;
	b=NcvYWJCyNfLatXmVyDRxLTR3Qx/x7JgxS8jcPHCtBtiN6MPmtGAh7sebTFiQVJAXNk
	Sbm/GqYfFaqfvaPEXTOrurvDwkKnd5zlx2TBIC3kz2Q4om3TP0Y1KaPxiIdippBjXGPT
	mt//zbGrEi8KAnTquF8hj0kCkKK4+MgiTjgN9U5T632osXgyVF0kyOkokSJYhpqPWU7q
	HvdQgIN00S7lvWehKYIDllQwTC97+wEK/qsM7xgShblV1PsGd2t5GKDax19T5iQvivwv
	QGi7KKBjclQM6KMFluz3llgRlzIQ2Zeot4lykjGh7vko0CNZ/xTAD3H/14XuvK6bERiB
	TxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
	:references:mime-version:content-disposition
	:content-transfer-encoding:in-reply-to:user-agent;
	bh=ns0QxnuhAfvDI+e0rO3qV1NnmRx4qtLcXwX4SEWj8w8=;
	b=DgyrDSqRDIhhb84LPm5hldWDIB6UidRPMyLC4bTPPzVCvqbStjogOc1b59jp4oV0Ik
	bo3MbHrgKnYXyiRIBoxJKHcPmrZBmCBVBZVVeg8opQ/tBBrT9RsLSlAoJ4XoieofwOK7
	EgCe7BTmZOGre9zofEXJOOiXqn+CQbQTqMiYa7PUhrjxPM4APaEQkxt4Vju/CL8C/k2l
	Qkl/1+3tjVPnq+W4LTsYNzdADeCsp2dPKdlnS7MAjfhUvjAsdikaCTw81r75+EK3Vj0/
	Jg1V4opEm1Qy7ySTfxQM7F+f45I7jYR/emlCq/DxjWJkLeEk9T2VtC5ydu+hpHjXGaYC
	fdmA==
X-Gm-Message-State: APjAAAUrVeYu5xRJlq5jWZv5O0zZBpoqexHmVBkJW2mYAx5um3NG8+Ep
	lm6fgnSb1p7evRDdxqRr6hI=
X-Google-Smtp-Source: APXvYqx0bXa7GoJQLXDLgeOn35F7WmZUbi0CsPk0aTEStD8EU08aO6txiY/M5Pu51pv7jSUwysUxyA==
X-Received: by 2002:a1c:495:: with SMTP id 143mr575729wme.78.1555521996663;
	Wed, 17 Apr 2019 10:26:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
	by smtp.gmail.com with ESMTPSA id
	x5sm65470238wrt.72.2019.04.17.10.26.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 17 Apr 2019 10:26:35 -0700 (PDT)
Date: Wed, 17 Apr 2019 19:26:32 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
	Ownership (XPFO)
Message-ID: <20190417172632.GA95485@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
	<20190417161042.GA43453@gmail.com>
	<e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
	<20190417170918.GA68678@gmail.com>
	<56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Dave Hansen <dave@sr71.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>, Khalid Aziz <khalid.aziz@oracle.com>,
	deepa.srinivasan@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tycho Andersen <tycho@tycho.ws>, X86 ML <x86@kernel.org>,
	iommu <iommu@lists.linux-foundation.org>, jsteckli@amazon.de,
	Arjan van de Ven <arjan@infradead.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, jcm@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris.hyser@oracle.com, linux-arm-kernel@lists.infradead.org,
	Khalid Aziz <khalid@gonehiking.org>, juergh@gmail.com,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	tyhicks@canonical.com, LSM List <linux-security-module@vger.kernel.org>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	keescook@google.com, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>
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
Message-ID: <20190417172632.kQA4gzHb0m0-mX9rV2JqgF6TfV6qgfDTZIccv2nr2v8@z>

CiogTmFkYXYgQW1pdCA8bmFkYXYuYW1pdEBnbWFpbC5jb20+IHdyb3RlOgoKPiA+IE9uIEFwciAx
NywgMjAxOSwgYXQgMTA6MDkgQU0sIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPiB3cm90
ZToKPiA+IAo+ID4gCj4gPiAqIEtoYWxpZCBBeml6IDxraGFsaWQuYXppekBvcmFjbGUuY29tPiB3
cm90ZToKPiA+IAo+ID4+PiBJLmUuIHRoZSBvcmlnaW5hbCBtb3RpdmF0aW9uIG9mIHRoZSBYUEZP
IHBhdGNoZXMgd2FzIHRvIHByZXZlbnQgZXhlY3V0aW9uIAo+ID4+PiBvZiBkaXJlY3Qga2VybmVs
IG1hcHBpbmdzLiBJcyB0aGlzIG1vdGl2YXRpb24gc3RpbGwgcHJlc2VudCBpZiB0aG9zZSAKPiA+
Pj4gbWFwcGluZ3MgYXJlIG5vbi1leGVjdXRhYmxlPwo+ID4+PiAKPiA+Pj4gKFNvcnJ5IGlmIHRo
aXMgaGFzIGJlZW4gYXNrZWQgYW5kIGFuc3dlcmVkIGluIHByZXZpb3VzIGRpc2N1c3Npb25zLikK
PiA+PiAKPiA+PiBIaSBJbmdvLAo+ID4+IAo+ID4+IFRoYXQgaXMgYSBnb29kIHF1ZXN0aW9uLiBC
ZWNhdXNlIG9mIHRoZSBjb3N0IG9mIFhQRk8sIHdlIGhhdmUgdG8gYmUgdmVyeQo+ID4+IHN1cmUg
d2UgbmVlZCB0aGlzIHByb3RlY3Rpb24uIFRoZSBwYXBlciBmcm9tIFZhc2lsZWlvcywgTWljaGFs
aXMgYW5kCj4gPj4gQW5nZWxvcyAtIDxodHRwOi8vd3d3LmNzLmNvbHVtYmlhLmVkdS9+dnBrL3Bh
cGVycy9yZXQyZGlyLnNlYzE0LnBkZj4sCj4gPj4gZG9lcyBnbyBpbnRvIGhvdyByZXQyZGlyIGF0
dGFja3MgY2FuIGJ5cGFzcyBTTUFQL1NNRVAgaW4gc2VjdGlvbnMgNi4xCj4gPj4gYW5kIDYuMi4K
PiA+IAo+ID4gU28gaXQgd291bGQgYmUgbmljZSBpZiB5b3UgY291bGQgZ2VuZXJhbGx5IHN1bW1h
cml6ZSBleHRlcm5hbCBhcmd1bWVudHMgCj4gPiB3aGVuIGRlZmVuZGluZyBhIHBhdGNoc2V0LCBp
bnN0ZWFkIG9mIG1lIGhhdmluZyB0byBkaWcgdGhyb3VnaCBhIFBERiAKPiA+IHdoaWNoIG5vdCBv
bmx5IGNhdXNlcyBtZSB0byBzcGVuZCB0aW1lIHRoYXQgeW91IHByb2JhYmx5IGFscmVhZHkgc3Bl
bnQgCj4gPiByZWFkaW5nIHRoYXQgUERGLCBidXQgSSBtaWdodCBhbHNvIGludGVycHJldCBpdCBp
bmNvcnJlY3RseS4gOy0pCj4gPiAKPiA+IFRoZSBQREYgeW91IGNpdGVkIHNheXMgdGhpczoKPiA+
IAo+ID4gICJVbmZvcnR1bmF0ZWx5LCBhcyBzaG93biBpbiBUYWJsZSAxLCB0aGUgV15YIHByb3At
ZXJ0eSBpcyBub3QgZW5mb3JjZWQgCj4gPiAgIGluIG1hbnkgcGxhdGZvcm1zLCBpbmNsdWRpbmcg
eDg2LTY0LiAgSW4gb3VyIGV4YW1wbGUsIHRoZSBjb250ZW50IG9mIAo+ID4gICB1c2VyIGFkZHJl
c3MgMHhCRUVGMDAwIGlzIGFsc28gYWNjZXNzaWJsZSB0aHJvdWdoIGtlcm5lbCBhZGRyZXNzIAo+
ID4gICAweEZGRkY4N0ZGOUYwODAwMDAgYXMgcGxhaW4sIGV4ZWN1dGFibGUgY29kZS4iCj4gPiAK
PiA+IElzIHRoaXMgYWN0dWFsbHkgdHJ1ZSBvZiBtb2Rlcm4geDg2LTY0IGtlcm5lbHM/IFdlJ3Zl
IGxvY2tlZCBkb3duIFdeWCAKPiA+IHByb3RlY3Rpb25zIGluIGdlbmVyYWwuCj4gCj4gQXMgSSB3
YXMgY3VyaW91cywgSSBsb29rZWQgYXQgdGhlIHBhcGVyLiBIZXJlIGlzIGEgcXVvdGUgZnJvbSBp
dDoKPiAKPiAiSW4geDg2LTY0LCBob3dldmVyLCB0aGUgcGVybWlzc2lvbnMgb2YgcGh5c21hcCBh
cmUgbm90IGluIHNhbmUgc3RhdGUuCj4gS2VybmVscyB1cCB0byB2My44LjEzIHZpb2xhdGUgdGhl
IFdeWCBwcm9wZXJ0eSBieSBtYXBwaW5nIHRoZSBlbnRpcmUgcmVnaW9uCj4gYXMg4oCccmVhZGFi
bGUsIHdyaXRlYWJsZSwgYW5kIGV4ZWN1dGFibGXigJ0gKFJXWCnigJRvbmx5IHZlcnkgcmVjZW50
IGtlcm5lbHMKPiAo4omldjMuOSkgdXNlIHRoZSBtb3JlIGNvbnNlcnZhdGl2ZSBSVyBtYXBwaW5n
LuKAnQoKQnV0IHYzLjguMTMgaXMgYSA1KyB5ZWFycyBvbGQga2VybmVsLCBpdCBkb2Vzbid0IGNv
dW50IGFzIGEgIm1vZGVybiIgCmtlcm5lbCBpbiBhbnkgc2Vuc2Ugb2YgdGhlIHdvcmQuIEZvciBh
bnkgcHJvcG9zZWQgcGF0Y2hzZXQgd2l0aCAKc2lnbmlmaWNhbnQgY29tcGxleGl0eSBhbmQgbm9u
LXRyaXZpYWwgY29zdHMgdGhlIGJlbmNobWFyayB2ZXJzaW9uIAp0aHJlc2hvbGQgaXMgdGhlICJj
dXJyZW50IHVwc3RyZWFtIGtlcm5lbCIuCgpTbyBkb2VzIHRoYXQgcXVvdGUgYWRkcmVzcyBteSBm
b2xsb3d1cCBxdWVzdGlvbnM6Cgo+IElzIHRoaXMgYWN0dWFsbHkgdHJ1ZSBvZiBtb2Rlcm4geDg2
LTY0IGtlcm5lbHM/IFdlJ3ZlIGxvY2tlZCBkb3duIFdeWAo+IHByb3RlY3Rpb25zIGluIGdlbmVy
YWwuCj4KPiBJLmUuIHRoaXMgY29uY2x1c2lvbjoKPgo+ICAgIlRoZXJlZm9yZSwgYnkgc2ltcGx5
IG92ZXJ3cml0aW5nIGtmcHRyIHdpdGggMHhGRkZGODdGRjlGMDgwMDAwIGFuZAo+ICAgIHRyaWdn
ZXJpbmcgdGhlIGtlcm5lbCB0byBkZXJlZmVyZW5jZSBpdCwgYW4gYXR0YWNrZXIgY2FuIGRpcmVj
dGx5Cj4gICAgZXhlY3V0ZSBzaGVsbCBjb2RlIHdpdGgga2VybmVsIHByaXZpbGVnZXMuIgo+Cj4g
Li4uIGFwcGVhcnMgdG8gYmUgcHJlZGljYXRlZCBvbiBpbXBlcmZlY3QgV15YIHByb3RlY3Rpb25z
IG9uIHRoZSB4ODYtNjQKPiBrZXJuZWwuCj4KPiBEbyBzdWNoIGhvbGVzIGV4aXN0IG9uIHRoZSBs
YXRlc3QgeDg2LTY0IGtlcm5lbD8gSWYgeWVzLCBpcyB0aGVyZSBhCj4gcmVhc29uIHRvIGJlbGll
dmUgdGhhdCB0aGVzZSBXXlggaG9sZXMgY2Fubm90IGJlIGZpeGVkLCBvciB0aGF0IGFueSBmaXgK
PiB3b3VsZCBiZSBtb3JlIGV4cGVuc2l2ZSB0aGFuIFhQRk8/Cgo/CgpXaGF0IHlvdSBhcmUgcHJv
cG9zaW5nIGhlcmUgaXMgYSBYUEZPIHBhdGNoLXNldCBhZ2FpbnN0IHJlY2VudCBrZXJuZWxzIAp3
aXRoIHNpZ25pZmljYW50IHJ1bnRpbWUgb3ZlcmhlYWQsIHNvIG15IHF1ZXN0aW9ucyBhYm91dCB0
aGUgV15YIGhvbGVzIAphcmUgd2FycmFudGVkLgoKVGhhbmtzLAoKCUluZ28KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
