Return-Path: <SRS0=QuKU=D7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44212C2D0A3
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1A924694
	for <iommu@archiver.kernel.org>; Sat, 24 Oct 2020 21:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3Zk5cnG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1A924694
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B53287555;
	Sat, 24 Oct 2020 21:36:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JEaFKPTZX0dg; Sat, 24 Oct 2020 21:36:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 081448735D;
	Sat, 24 Oct 2020 21:36:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF93CC1AD8;
	Sat, 24 Oct 2020 21:36:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2EA9C0051
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 94FD386A77
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EogwivUemqwW for <iommu@lists.linux-foundation.org>;
 Sat, 24 Oct 2020 21:35:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 19501867CF
 for <iommu@lists.linux-foundation.org>; Sat, 24 Oct 2020 21:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=BB0rtOqqhF/O+4Eyi+jPOjXIPrc5yFSdnqnIg/CmQXM=; b=3Zk5cnG6/nm0qE6vEP5tNuuvKL
 FLwPSenwz6cySsnsI/i4ie8PSqyWUnjLgI25kG+98FxyD1nyee567XX7S6dwocmjdruxLkkMb3vYI
 GlvHkiy4hE1FgEAH14b0gaADbnRoQ+MJwuqcZjV38y6M7nSv6e1KIMPK7o/zwomzABdP/3RhvNnXy
 er4F+f9OPWoe3KlH4RPvBEtg/ZuvqR5CTUowY9JaUd0geghKIQTdIb7TTfbCz0WQ6KnhUXOVidmbX
 IxvTCcHaTCqSien6sc03PRyh/99ZBPUAgi5n1mDsu1aCdzAEdH0J+L62RbK/f+CAiM9vTLcWBGfQ1
 Zri9K4fQ==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kWRCO-0008B1-GY; Sat, 24 Oct 2020 21:35:40 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kWRCM-001rNZ-IO; Sat, 24 Oct 2020 22:35:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: x86@kernel.org
Subject: [PATCH v3 00/35] Fix x2apic enablement and allow more CPUs,
 clean up I/OAPIC and MSI bitfields
Date: Sat, 24 Oct 2020 22:35:00 +0100
Message-Id: <20201024213535.443185-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
References: <e6601ff691afb3266e365a91e8b221179daf22c2.camel@infradead.org>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 merlin.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hyperv@vger.kernel.org, kvm <kvm@vger.kernel.org>,
 Dexuan Cui <decui@microsoft.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, maz@misterjones.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
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

CkZpeCB0aGUgY29uZGl0aW9ucyBmb3IgZW5hYmxpbmcgeDJhcGljIG9uIGd1ZXN0cyB3aXRob3V0
IGludGVycnVwdCAKcmVtYXBwaW5nLCBhbmQgc3VwcG9ydCAxNS1iaXQgRXh0ZW5kZWQgRGVzdGlu
YXRpb24gSUQgdG8gYWxsb3cgMzI3NjggCkNQVXMgd2l0aG91dCBJUiBvbiBoeXBlcnZpc29ycyB0
aGF0IHN1cHBvcnQgaXQuCgpNYWtlIHRoZSBJL09BUElDIGNvZGUgZ2VuZXJhdGUgaXRzIFJURSBk
aXJlY3RseSBmcm9tIHRoZSBNU0kgbWVzc2FnZQpjcmVhdGVkIGJ5IHRoZSBwYXJlbnQgaXJxY2hp
cCwgYW5kIGZpeCB1cCBhIGJ1bmNoIG9mIG1hZ2ljIG1hc2svc2hpZnQKbWFjcm9zIHRvIHVzZSBi
aXRmaWVsZHMgZm9yIE1TSSBtZXNzYWdlcyBhbmQgSS9PQVBJQyBSVEVzIHdoaWxlIHdlJ3JlCmF0
IGl0LgoKdjM6CiDigKIgTG90cyBvZiBiaXRmaWVsZCBjbGVhbnVwcyBmcm9tIFRob21hcy4KIOKA
oiBEaXNhYmxlIGh5cGVydi1pb21tdSBpZiAxNS1iaXQgZXh0ZW5zaW9uIGlzIHByZXNlbnQuCiDi
gKIgRml4IGluY29uc2lzdGVudCBDT05GSUdfUENJX01TSS9DT05GSUdfR0VORVJJQ19NU0lfSVJR
IGluIGhwZXQuYwog4oCiIFNwbGl0IEtWTV9GRUFUVVJFX01TSV9FWFRfREVTVF9JRCBwYXRjaCwg
aGFsZiBvZiB3aGljaCBpcyBnb2luZyB1cHN0cmVhbQogICB0aHJvdWdoIEtWTSB0cmVlIChhbmQg
dGhlIG90aGVyIGhhbGYgbmVlZHMgdG8gd2FpdCwgb3IgaGF2ZSBhbiAjaWZkZWYpIHNvCiAgIGlz
IGxlZnQgYXQgdGhlIHRvcCBvZiB0aGUgdHJlZS4KCnYyOgog4oCiIE1pbm9yIGNsZWFudXBzLgog
4oCiIE1vdmUgX19pcnFfbXNpX2NvbXBvc2VfbXNnKCkgdG8gYXBpYy5jLCBtYWtlIHZpcnRfZXh0
X2Rlc3RfaWQgc3RhdGljLgog4oCiIEdlbmVyYXRlIEkvT0FQSUMgUlRFIGRpcmVjdGx5IGZyb20g
cGFyZW50IGlycWNoaXAncyBNU0kgbWVzc2FnZXMuCiDigKIgQ2xlYW4gdXAgSFBFVCBNU0kgc3Vw
cG9ydCBpbnRvIGhwZXQuYyBub3cgdGhhdCB3ZSBjYW4uCgpEYXZpZCBXb29kaG91c2UgKDE5KToK
ICAgICAgeDg2L2FwaWM6IEZpeCB4MmFwaWMgZW5hYmxlbWVudCB3aXRob3V0IGludGVycnVwdCBy
ZW1hcHBpbmcKICAgICAgeDg2L21zaTogT25seSB1c2UgaGlnaCBiaXRzIG9mIE1TSSBhZGRyZXNz
IGZvciBETUFSIHVuaXQKICAgICAgeDg2L2FwaWM6IEFsd2F5cyBwcm92aWRlIGlycV9jb21wb3Nl
X21zaV9tc2coKSBtZXRob2QgZm9yIHZlY3RvciBkb21haW4KICAgICAgeDg2L2hwZXQ6IE1vdmUg
TVNJIHN1cHBvcnQgaW50byBocGV0LmMKICAgICAgeDg2L2lvYXBpYzogR2VuZXJhdGUgUlRFIGRp
cmVjdGx5IGZyb20gcGFyZW50IGlycWNoaXAncyBNU0kgbWVzc2FnZQogICAgICBnZW5pcnEvaXJx
ZG9tYWluOiBJbXBsZW1lbnQgZ2V0X25hbWUoKSBtZXRob2Qgb24gaXJxY2hpcCBmd25vZGVzCiAg
ICAgIHg4Ni9hcGljOiBBZGQgc2VsZWN0KCkgbWV0aG9kIG9uIHZlY3RvciBpcnFkb21haW4KICAg
ICAgaW9tbXUvYW1kOiBJbXBsZW1lbnQgc2VsZWN0KCkgbWV0aG9kIG9uIHJlbWFwcGluZyBpcnFk
b21haW4KICAgICAgaW9tbXUvdnQtZDogSW1wbGVtZW50IHNlbGVjdCgpIG1ldGhvZCBvbiByZW1h
cHBpbmcgaXJxZG9tYWluCiAgICAgIGlvbW11L2h5cGVyLXY6IEltcGxlbWVudCBzZWxlY3QoKSBt
ZXRob2Qgb24gcmVtYXBwaW5nIGlycWRvbWFpbgogICAgICB4ODYvaHBldDogVXNlIGlycV9maW5k
X21hdGNoaW5nX2Z3c3BlYygpIHRvIGZpbmQgcmVtYXBwaW5nIGlycWRvbWFpbgogICAgICB4ODYv
aW9hcGljOiBVc2UgaXJxX2ZpbmRfbWF0Y2hpbmdfZndzcGVjKCkgdG8gZmluZCByZW1hcHBpbmcg
aXJxZG9tYWluCiAgICAgIHg4NjogS2lsbCBhbGwgdHJhY2VzIG9mIGlycV9yZW1hcHBpbmdfZ2V0
X2lycV9kb21haW4oKQogICAgICBpb21tdS92dC1kOiBTaW1wbGlmeSBpbnRlbF9pcnFfcmVtYXBw
aW5nX3NlbGVjdCgpCiAgICAgIHg4Ni9pb2FwaWM6IEhhbmRsZSBFeHRlbmRlZCBEZXN0aW5hdGlv
biBJRCBmaWVsZCBpbiBSVEUKICAgICAgeDg2L2FwaWM6IFN1cHBvcnQgMTUgYml0cyBvZiBBUElD
IElEIGluIE1TSSB3aGVyZSBhdmFpbGFibGUKICAgICAgaW9tbXUvaHlwZXItdjogRGlzYWJsZSBJ
UlEgcHNldWRvLXJlbWFwcGluZyBpZiAxNSBiaXQgQVBJQyBJRHMgYXJlIGF2YWlsYWJsZQogICAg
ICB4ODYva3ZtOiBSZXNlcnZlIEtWTV9GRUFUVVJFX01TSV9FWFRfREVTVF9JRAogICAgICB4ODYv
a3ZtOiBFbmFibGUgMTUtYml0IGV4dGVuc2lvbiB3aGVuIEtWTV9GRUFUVVJFX01TSV9FWFRfREVT
VF9JRCBkZXRlY3RlZAoKVGhvbWFzIEdsZWl4bmVyICgxNik6CiAgICAgIHg4Ni9hcGljL3V2OiBG
aXggaW5jb25zaXN0ZW50IGRlc3RpbmF0aW9uIG1vZGUKICAgICAgeDg2L2RldmljZXRyZWU6IEZp
eCB0aGUgaW9hcGljIGludGVycnVwdCB0eXBlIHRhYmxlCiAgICAgIHg4Ni9hcGljOiBDbGVhbnVw
IGRlbGl2ZXJ5IG1vZGUgZGVmaW5lcwogICAgICB4ODYvYXBpYzogUmVwbGFjZSBwb2ludGxlc3Mg
YXBpYzo6ZGVzdF9sb2dpY2FsIHVzYWdlCiAgICAgIHg4Ni9hcGljOiBHZXQgcmlkIG9mIGFwaWM6
OmRlc3RfbG9naWNhbAogICAgICB4ODYvYXBpYzogQ2xlYW51cCBkZXN0aW5hdGlvbiBtb2RlCiAg
ICAgIGdlbmlycS9tc2k6IEFsbG93IHNoYWRvdyBkZWNsYXJhdGlvbnMgb2YgbXNpX21zZzo6JG1l
bWJlcgogICAgICB4ODYvbXNpOiBQcm92aWRlIG1zaSBtZXNzYWdlIHNoYWRvdyBzdHJ1Y3RzCiAg
ICAgIGlvbW11L2ludGVsOiBVc2UgbXNpX21zZyBzaGFkb3cgc3RydWN0cwogICAgICBpb21tdS9h
bWQ6IFVzZSBtc2lfbXNnIHNoYWRvdyBzdHJ1Y3RzCiAgICAgIFBDSTogdm1kOiBVc2UgbXNpX21z
ZyBzaGFkb3cgc3RydWN0cwogICAgICB4ODYva3ZtOiBVc2UgbXNpX21zZyBzaGFkb3cgc3RydWN0
cwogICAgICB4ODYvcGNpL3hlbjogVXNlIG1zaV9tc2cgc2hhZG93IHN0cnVjdHMKICAgICAgeDg2
L21zaTogUmVtb3ZlIG1zaWRlZi5oCiAgICAgIHg4Ni9pb19hcGljOiBDbGVhbnVwIHRyaWdnZXIv
cG9sYXJpdHkgaGVscGVycwogICAgICB4ODYvaW9hcGljOiBDbGVhbnVwIElPL0FQSUMgcm91dGUg
ZW50cnkgc3RydWN0cwoKIERvY3VtZW50YXRpb24vdmlydC9rdm0vY3B1aWQucnN0ICAgICAgfCAg
IDQgKwogYXJjaC94ODYvaW5jbHVkZS9hc20vYXBpYy5oICAgICAgICAgICB8ICAxNiArLQogYXJj
aC94ODYvaW5jbHVkZS9hc20vYXBpY2RlZi5oICAgICAgICB8ICAxNiArLQogYXJjaC94ODYvaW5j
bHVkZS9hc20vaHBldC5oICAgICAgICAgICB8ICAxMSAtCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9o
d19pcnEuaCAgICAgICAgIHwgIDEzICstCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pb19hcGljLmgg
ICAgICAgIHwgIDc5ICsrLS0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vaXJxX3JlbWFwcGluZy5o
ICB8ICAgOSAtCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnFkb21haW4uaCAgICAgIHwgICAzICsK
IGFyY2gveDg2L2luY2x1ZGUvYXNtL21zaS5oICAgICAgICAgICAgfCAgNTAgKysrKwogYXJjaC94
ODYvaW5jbHVkZS9hc20vbXNpZGVmLmggICAgICAgICB8ICA1NyAtLS0tCiBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS94ODZfaW5pdC5oICAgICAgIHwgICAyICsKIGFyY2gveDg2L2luY2x1ZGUvdWFwaS9h
c20va3ZtX3BhcmEuaCAgfCAgIDEgKwogYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jICAgICAg
ICAgICB8ICA3MyArKysrLQogYXJjaC94ODYva2VybmVsL2FwaWMvYXBpY19mbGF0XzY0LmMgICB8
ICAxOCArLQogYXJjaC94ODYva2VybmVsL2FwaWMvYXBpY19ub29wLmMgICAgICB8ICAxMCArLQog
YXJjaC94ODYva2VybmVsL2FwaWMvYXBpY19udW1hY2hpcC5jICB8ICAxNiArLQogYXJjaC94ODYv
a2VybmVsL2FwaWMvYmlnc21wXzMyLmMgICAgICB8ICAgOSArLQogYXJjaC94ODYva2VybmVsL2Fw
aWMvaW9fYXBpYy5jICAgICAgICB8IDUwMyArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0tCiBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9pcGkuYyAgICAgICAgICAgIHwgICA2ICstCiBhcmNo
L3g4Ni9rZXJuZWwvYXBpYy9tc2kuYyAgICAgICAgICAgIHwgMTUzICstLS0tLS0tLS0tCiBhcmNo
L3g4Ni9rZXJuZWwvYXBpYy9wcm9iZV8zMi5jICAgICAgIHwgICA5ICstCiBhcmNoL3g4Ni9rZXJu
ZWwvYXBpYy92ZWN0b3IuYyAgICAgICAgIHwgIDQ5ICsrKysKIGFyY2gveDg2L2tlcm5lbC9hcGlj
L3gyYXBpY19jbHVzdGVyLmMgfCAgMTAgKy0KIGFyY2gveDg2L2tlcm5lbC9hcGljL3gyYXBpY19w
aHlzLmMgICAgfCAgMTcgKy0KIGFyY2gveDg2L2tlcm5lbC9hcGljL3gyYXBpY191dl94LmMgICAg
fCAgMTIgKy0KIGFyY2gveDg2L2tlcm5lbC9kZXZpY2V0cmVlLmMgICAgICAgICAgfCAgMzAgKy0K
IGFyY2gveDg2L2tlcm5lbC9ocGV0LmMgICAgICAgICAgICAgICAgfCAxMjIgKysrKysrKystCiBh
cmNoL3g4Ni9rZXJuZWwva3ZtLmMgICAgICAgICAgICAgICAgIHwgICA2ICsKIGFyY2gveDg2L2tl
cm5lbC9zbXBib290LmMgICAgICAgICAgICAgfCAgIDggKy0KIGFyY2gveDg2L2tlcm5lbC94ODZf
aW5pdC5jICAgICAgICAgICAgfCAgIDEgKwogYXJjaC94ODYva3ZtL2lycV9jb21tLmMgICAgICAg
ICAgICAgICB8ICAzMSArLS0KIGFyY2gveDg2L3BjaS9pbnRlbF9taWRfcGNpLmMgICAgICAgICAg
fCAgIDggKy0KIGFyY2gveDg2L3BjaS94ZW4uYyAgICAgICAgICAgICAgICAgICAgfCAgMjYgKy0K
IGFyY2gveDg2L3BsYXRmb3JtL3V2L3V2X2lycS5jICAgICAgICAgfCAgIDQgKy0KIGFyY2gveDg2
L3hlbi9hcGljLmMgICAgICAgICAgICAgICAgICAgfCAgIDcgKy0KIGRyaXZlcnMvaW9tbXUvYW1k
L2FtZF9pb21tdV90eXBlcy5oICAgfCAgIDIgKy0KIGRyaXZlcnMvaW9tbXUvYW1kL2luaXQuYyAg
ICAgICAgICAgICAgfCAgNDYgKystLQogZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyAgICAgICAg
ICAgICB8ICA5MyArKystLS0tCiBkcml2ZXJzL2lvbW11L2h5cGVydi1pb21tdS5jICAgICAgICAg
IHwgIDQ0ICstLQogZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMgICB8IDEwMiAr
KystLS0tCiBkcml2ZXJzL2lvbW11L2lycV9yZW1hcHBpbmcuYyAgICAgICAgIHwgIDE0IC0KIGRy
aXZlcnMvaW9tbXUvaXJxX3JlbWFwcGluZy5oICAgICAgICAgfCAgIDMgLQogZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2ktaHlwZXJ2LmMgICB8ICAgNiArLQogZHJpdmVycy9wY2kvY29udHJvbGxl
ci92bWQuYyAgICAgICAgICB8ICAgOSArLQogaW5jbHVkZS9hc20tZ2VuZXJpYy9tc2kuaCAgICAg
ICAgICAgICB8ICAgNCArCiBpbmNsdWRlL2xpbnV4L21zaS5oICAgICAgICAgICAgICAgICAgIHwg
IDQ2ICsrKy0KIGtlcm5lbC9pcnEvaXJxZG9tYWluLmMgICAgICAgICAgICAgICAgfCAgMTEgKy0K
IDQ3IGZpbGVzIGNoYW5nZWQsIDg5MCBpbnNlcnRpb25zKCspLCA4NzkgZGVsZXRpb25zKC0pCgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
