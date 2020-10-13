Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292DAC43457
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:12:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFAB207C3
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 08:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I6ttXtQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFAB207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C44587AFA;
	Tue, 13 Oct 2020 08:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ch8HbgwqXhkX; Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8BD5D87AC5;
	Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85585C07FF;
	Tue, 13 Oct 2020 08:12:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1A70C0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE22D87AF2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IYn5vc6+76vl for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 08:12:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C9A7A8743B
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=RgWc9nkynvcBFppQsEDwLqzLhZzcJ5woAloxK69DHIY=; b=I6ttXtQgUdffmuQ7izO5ZTJ+aR
 5Wk4Qq54h7x2WilXjyV4qwN72fxXZpRyMItZOj1qf3eB9+MvjcyWI5lvWlrGqymrsuZc+tGESrje1
 WlxrbcO455lesZYUd3Lu8CyyunuIbv4CbzoN7Ve9Lcoi9TV7oyUBR0mjsnnG6UFaoudzR2j2X8Au3
 t0jJJbMgIAgMvhzVVlVzHvsu5QjdfCB4Y/E1h4CNKXoG9Brv81RYmEwOzdzfQQ2gaEBWAEyX4urR/
 TvEiPUnTzM6Ol2B8GSbH8epMHYQpOnx2GOYoeU91aTGe6p4/41zlvxat5LVdgCEkmbNJiMPweczgK
 cVf0rsxA==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSFPM-0006fN-QR; Tue, 13 Oct 2020 08:12:01 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kSFPM-006XXJ-BR; Tue, 13 Oct 2020 09:11:44 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH 0/9] Remove irq_remapping_get_irq_domain()
Date: Tue, 13 Oct 2020 09:11:30 +0100
Message-Id: <20201013081139.1558200-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0de733f6384874d68afba2606119d0d9b1e8b34e.camel@infradead.org>
References: <0de733f6384874d68afba2606119d0d9b1e8b34e.camel@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 maz@misterjones.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

SSBkaWRuJ3QgbXVjaCBsaWtlIHRoZSBJL09BUElDIGFuZCBIUEVUIGRyaXZlcnMgaGF2aW5nIG1h
Z2ljYWwga25vd2xlZGdlCnRoYXQgdGhleSBoYWQgdG8gc3Vic3RpdHV0ZSB4ODZfdmVjdG9yX2Rv
bWFpbiBpZiB0aGVpciBjYWxsIHRvCmlycV9yZW1hcHBpbmdfZ2V0X2lycV9kb21haW4oKSByZXR1
cm5lZCBOVUxMLgoKV2hlbiBUaG9tYXMgdHJpZWQgdG8gbWFrZSBpdCBoYW5kbGUgZXJyb3IgcmV0
dXJucyBmcm9tIOKApmdldF9pcnFfZG9tYWluKCkgCmRpc3RpbmN0bHkgZnJvbSB0aGUgTlVMTCBj
YXNlIHRvbywgaXQgbWFkZSBtZSBldmVuIHNhZGRlci4gU28gSSBraWxsZWQgCml0IHdpdGggZmly
ZS4KCk5vdyB0aGV5IGp1c3QgdXNlIGlycV9maW5kX21hdGNoaW5nX2Z3c3BlYygpIHRvIGZpbmQg
YW4gYXBwcm9wcmlhdGUKaXJxZG9tYWluLiBFYWNoIHJlbWFwcGluZyBpcnFkb21haW4ganVzdCBu
ZWVkcyB0byBzYXkgJ3llcCwgdGhhdCdzIG1lJwpmb3IgdGhlIEhQRVRzIG9yIEkvT0FQSUNzIHdo
aWNoIGFyZSB3aXRoaW4gdGhlaXIgc2NvcGUsIHdoaWxlIHRoZQp4ODZfdmVjdG9yX2RvbWFpbiBh
Y2NlcHRzIHRoZW0gYWxsIGJ1dCBvbmx5IGlmIGludGVycnVwdCByZW1hcHBpbmcKaXMgKmRpc2Fi
bGVkKi4gTm8gbW9yZSBzcGVjaWFsIGtub3dsZWRnZSBpbiB0aGUgY2FsbGVyLgoKSWYgSVIgaXMg
ZW5hYmxlZCBhbmQgdGhlcmUncyBhIGNoaWxkIGRldmljZSB3aGljaCBlc2NhcGVzIHRoZSBzY29w
ZSBvZgphbGwgcmVtYXBwaW5nIHVuaXRzLCBpdCBnZXRzIE5VTEwgZm9yIGl0cyBwYXJlbnQgaXJx
ZG9tYWluIGFuZCB3aWxsCmZhaWwgdG8gaW5pdGlhbGlzZSwgd2hpY2ggaXMgdGhlIGNvcnJlY3Qg
dGhpbmcgdG8gZG8gaW4gdGhhdCAic2hvdWxkCm5ldmVyIGhhcHBlbiIgY2FzZS4gRm9yIEhQRVQg
dGhhdCdsbCBtZWFuIHRoYXQgaXQganVzdCBkb2Vzbid0IHN1cHBvcnQKTVNJLCB3aGlsZSBJL09B
UElDIHdpbGwgcmVmdXNlIHRvIGluaXRpYWxpc2UgYW5kIHRyaWdnZXIgYSBCVUdfT04KYmVjYXVz
ZSBMaW51eCBxdWl0ZSBsaWtlcyBpdCB3aGVuICphbGwqIHRoZSBJL09BUElDcyBpdCBrbm93cyBh
Ym91dCBnZXQKaW5pdGlhbGlzZWQgc3VjY2Vzc2Z1bGx5LgoKVGhpcyBpcyBvbiB0b3Agb2YgdGhl
IHByZXZpb3VzICdleHRfZGVzdF9pZCcgc2VyaWVzIGF0Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9rdm0vbGlzdC8/c2VyaWVzPTM2MjAzNwoKaHR0cHM6Ly9naXQuaW5mcmFk
ZWFkLm9yZy91c2Vycy9kd213Mi9saW51eC5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9leHRfZGVz
dF9pZAoKRGF2aWQgV29vZGhvdXNlICg5KToKICAgICAgZ2VuaXJxL2lycWRvbWFpbjogSW1wbGVt
ZW50IGdldF9uYW1lKCkgbWV0aG9kIG9uIGlycWNoaXAgZndub2RlcwogICAgICB4ODYvYXBpYzog
QWRkIHNlbGVjdCgpIG1ldGhvZCBvbiB2ZWN0b3IgaXJxZG9tYWluCiAgICAgIGlvbW11L2FtZDog
SW1wbGVtZW50IHNlbGVjdCgpIG1ldGhvZCBvbiByZW1hcHBpbmcgaXJxZG9tYWluCiAgICAgIGlv
bW11L3Z0LWQ6IEltcGxlbWVudCBzZWxlY3QoKSBtZXRob2Qgb24gcmVtYXBwaW5nIGlycWRvbWFp
bgogICAgICBpb21tdS9oeXBlci12OiBJbXBsZW1lbnQgc2VsZWN0KCkgbWV0aG9kIG9uIHJlbWFw
cGluZyBpcnFkb21haW4KICAgICAgeDg2L2hwZXQ6IFVzZSBpcnFfZmluZF9tYXRjaGluZ19md3Nw
ZWMoKSB0byBmaW5kIHJlbWFwcGluZyBpcnFkb21haW4KICAgICAgeDg2L2lvYXBpYzogVXNlIGly
cV9maW5kX21hdGNoaW5nX2Z3c3BlYygpIHRvIGZpbmQgcmVtYXBwaW5nIGlycWRvbWFpbgogICAg
ICB4ODY6IEtpbGwgYWxsIHRyYWNlcyBvZiBpcnFfcmVtYXBwaW5nX2dldF9pcnFfZG9tYWluKCkK
ICAgICAgaW9tbXUvdnQtZDogU2ltcGxpZnkgaW50ZWxfaXJxX3JlbWFwcGluZ19zZWxlY3QoKQoK
IGFyY2gveDg2L2luY2x1ZGUvYXNtL2h3X2lycS5oICAgICAgICB8ICAyIC0tCiBhcmNoL3g4Ni9p
bmNsdWRlL2FzbS9pcnFfcmVtYXBwaW5nLmggfCAgOSAtLS0tLS0tLS0KIGFyY2gveDg2L2luY2x1
ZGUvYXNtL2lycWRvbWFpbi5oICAgICB8ICAzICsrKwogYXJjaC94ODYva2VybmVsL2FwaWMvaW9f
YXBpYy5jICAgICAgIHwgMjQgKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBhcmNoL3g4Ni9rZXJu
ZWwvYXBpYy92ZWN0b3IuYyAgICAgICAgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiBhcmNoL3g4Ni9rZXJuZWwvaHBldC5jICAgICAgICAgICAgICAgfCAy
MyArKysrKysrKysrKysrLS0tLS0tLS0tLQogZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyAgICAg
ICAgICAgIHwgNTMgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KIGRyaXZlcnMvaW9tbXUvaHlwZXJ2LWlvbW11LmMgICAgICAgICB8IDE4ICsrKysr
KysrKy0tLS0tLS0tLQogZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMgIHwgNDMg
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZHJpdmVycy9pb21t
dS9pcnFfcmVtYXBwaW5nLmMgICAgICAgIHwgMTQgLS0tLS0tLS0tLS0tLS0KIGRyaXZlcnMvaW9t
bXUvaXJxX3JlbWFwcGluZy5oICAgICAgICB8ICAzIC0tLQoga2VybmVsL2lycS9pcnFkb21haW4u
YyAgICAgICAgICAgICAgIHwgMTEgKysrKysrKysrKy0KIDEyIGZpbGVzIGNoYW5nZWQsIDEyNiBp
bnNlcnRpb25zKCspLCAxMjAgZGVsZXRpb25zKC0pCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby9pb21tdQ==
