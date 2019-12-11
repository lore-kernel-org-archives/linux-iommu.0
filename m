Return-Path: <SRS0=NWqd=2B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A4C2D0C6
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 15:37:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9866B24656
	for <iommu@archiver.kernel.org>; Wed, 11 Dec 2019 15:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=arista.com header.i=@arista.com header.b="K30i6dN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9866B24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 74B2D86BAE;
	Wed, 11 Dec 2019 15:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XFWLAVNf3DPo; Wed, 11 Dec 2019 15:37:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E79C886BF2;
	Wed, 11 Dec 2019 15:37:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0CD1C1796;
	Wed, 11 Dec 2019 15:37:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38DCDC0881
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 15:37:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2550186BF2
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 15:37:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id naKuhUGwEFFn for <iommu@lists.linux-foundation.org>;
 Wed, 11 Dec 2019 15:37:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 34EF186BAE
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 15:37:37 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id l4so9071873pjt.5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Dec 2019 07:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=googlenew;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=mZyjjAAc7yNANmoebBsT963AofjY/s84X8vsLTIrpD4=;
 b=K30i6dN5IfT1gG+6PGpefroyqGIpo4g4XmXSr85BsjYcaE88tQFwI33Ovorlgz2ABC
 FZMpdjij1HpLqDarqrAR48u/z2XVLxf68TnO6laeWh58YG9jR16KBBpjlflEUeuPmVOs
 MMiE4Z69y4R+Ow5o1jQM/OGtDXgnQZG+oH6Ni96mfqqoRoipYsqyaMoSpAY+9hLDWDIz
 ug1/Jl1bdYElBVegTmWiGgTmdmpYkmhUDFVMAJVlv94FS4Mo4/tWB9yvbW04RB6zj5S5
 0aPsdhA1ysrLqUJmjegxg1Twxm1vDhc1dC3kl6hZuZ4GIa55Rrk8kQ151DpmSYFbDhKJ
 WFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=mZyjjAAc7yNANmoebBsT963AofjY/s84X8vsLTIrpD4=;
 b=kvhn+wTMEdq235W2w9cnwoFStYpPDo8vttEh9K7S98WrNiOzE7iOnnY+RQ7NfeW0Oo
 m2xTCj7wPCespHRnJrcO5/JYYsZnsLSilC1mpPCDyEsI+z1YPa9MuEFGyqH4d0HBBhJD
 Q86h4Y7DDZVcd0zGyPRhSftW2PmT4nRyG714p5htgUf4eXO8QIeTw92eLRSKE2IbpFsc
 Sd5U3aRtTb3Ys3cGYWlv3wbuq3dcjW/Ck/L3iGLd54FeLZPDhRKkMfTh7k5FZJcEHC2v
 S3b3AvzJHZQsQohUYW9X/dtwTrZjUdDPH3EFQvD290hl063xsLNklEIgjcgDit7rfyFm
 niAw==
X-Gm-Message-State: APjAAAW/Kcpi7YIJPRobWV5aEmsoZ43oQ8Xlxs1V+16la1CT6XHo+0Df
 /jaUwJQNJWC2A1js/OT84M31zQ==
X-Google-Smtp-Source: APXvYqyfHdj5Wju5tHjYhtBozUgo+eKxaW7VtMGL10rLo9NwZ5f8ANm6rWjTtpKXW6rwsYnvY5BNVg==
X-Received: by 2002:a17:902:b18e:: with SMTP id
 s14mr4008320plr.261.1576078656416; 
 Wed, 11 Dec 2019 07:37:36 -0800 (PST)
Received: from [10.83.42.232] ([217.173.96.166])
 by smtp.gmail.com with ESMTPSA id w11sm3150883pgs.60.2019.12.11.07.37.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 07:37:35 -0800 (PST)
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
In-Reply-To: <20191210223745.GA167002@google.com>
Date: Wed, 11 Dec 2019 15:37:30 +0000
Message-Id: <826A0459-FA8D-4BDB-A342-CE46974466DF@arista.com>
References: <20191210223745.GA167002@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>
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
From: James Sewart via iommu <iommu@lists.linux-foundation.org>
Reply-To: James Sewart <jamessewart@arista.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Cgo+IE9uIDEwIERlYyAyMDE5LCBhdCAyMjozNywgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJu
ZWwub3JnPiB3cm90ZToKPiAKPiBbK2NjIEpvZXJnXQo+IAo+IE9uIFR1ZSwgRGVjIDAzLCAyMDE5
IGF0IDAzOjQzOjUzUE0gKzAwMDAsIEphbWVzIFNld2FydCB3cm90ZToKPj4gcGNpX2FkZF9kbWFf
YWxpYXMgY2FuIG5vdyBiZSB1c2VkIHRvIGNyZWF0ZSBhIGRtYSBhbGlhcyBmb3IgYSByYW5nZSBv
Zgo+PiBkZXZmbnMuCj4+IAo+PiBSZXZpZXdlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdA
ZGVsdGF0ZWUuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTZXdhcnQgPGphbWVzc2V3YXJ0
QGFyaXN0YS5jb20+Cj4+IC0tLQo+PiBkcml2ZXJzL3BjaS9wY2kuYyAgICB8IDIyICsrKysrKysr
KysrKysrKysrLS0tLS0KPj4gZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAxNCArKysrKysrLS0tLS0t
LQo+PiBpbmNsdWRlL2xpbnV4L3BjaS5oICB8ICAyICstCj4+IDMgZmlsZXMgY2hhbmdlZCwgMjUg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pCj4gCj4gSGVhZHMgdXAgSm9lcmc6IEkgYWxz
byB1cGRhdGVkIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMgKHRoaXMgaXMgdGhlCj4gb25lIHJl
cG9ydGVkIGJ5IHRoZSBrYnVpbGQgdGVzdCByb2JvdCkgYW5kIHJlbW92ZWQgdGhlIHByaW50ayB0
aGVyZQo+IHRoYXQgcHJpbnRzIHRoZSBzYW1lIHRoaW5nIGFzIHRoZSBvbmUgaW4gcGNpX2FkZF9k
bWFfYWxpYXMoKSwgYW5kIEkKPiB1cGRhdGVkIGEgUENJIHF1aXJrIHRoYXQgd2FzIG1lcmdlZCBh
ZnRlciB0aGlzIHBhdGNoIHdhcyBwb3N0ZWQuCj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9wY2kuYyBiL2RyaXZlcnMvcGNpL3BjaS5jCj4+IGluZGV4IGQzYzgzMjQ4ZjNjZS4uZGJiMDFh
Y2VhZmRhIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2kuYwo+PiArKysgYi9kcml2ZXJz
L3BjaS9wY2kuYwo+PiBAQCAtNTg1Nyw3ICs1ODU3LDggQEAgaW50IHBjaV9zZXRfdmdhX3N0YXRl
KHN0cnVjdCBwY2lfZGV2ICpkZXYsIGJvb2wgZGVjb2RlLAo+PiAvKioKPj4gICogcGNpX2FkZF9k
bWFfYWxpYXMgLSBBZGQgYSBETUEgZGV2Zm4gYWxpYXMgZm9yIGEgZGV2aWNlCj4+ICAqIEBkZXY6
IHRoZSBQQ0kgZGV2aWNlIGZvciB3aGljaCBhbGlhcyBpcyBhZGRlZAo+PiAtICogQGRldmZuOiBh
bGlhcyBzbG90IGFuZCBmdW5jdGlvbgo+PiArICogQGRldmZuX2Zyb206IGFsaWFzIHNsb3QgYW5k
IGZ1bmN0aW9uCj4+ICsgKiBAbnJfZGV2Zm5zOiBOdW1iZXIgb2Ygc3Vic2VxdWVudCBkZXZmbnMg
dG8gYWxpYXMKPj4gICoKPj4gICogVGhpcyBoZWxwZXIgZW5jb2RlcyBhbiA4LWJpdCBkZXZmbiBh
cyBhIGJpdCBudW1iZXIgaW4gZG1hX2FsaWFzX21hc2sKPj4gICogd2hpY2ggaXMgdXNlZCB0byBw
cm9ncmFtIHBlcm1pc3NpYmxlIGJ1cy1kZXZmbiBzb3VyY2UgYWRkcmVzc2VzIGZvciBETUEKPj4g
QEAgLTU4NzMsOCArNTg3NCwxMyBAQCBpbnQgcGNpX3NldF92Z2Ffc3RhdGUoc3RydWN0IHBjaV9k
ZXYgKmRldiwgYm9vbCBkZWNvZGUsCj4+ICAqIGNhbm5vdCBiZSBsZWZ0IGFzIGEgdXNlcnNwYWNl
IGFjdGl2aXR5KS4gIERNQSBhbGlhc2VzIHNob3VsZCB0aGVyZWZvcmUKPj4gICogYmUgY29uZmln
dXJlZCB2aWEgcXVpcmtzLCBzdWNoIGFzIHRoZSBQQ0kgZml4dXAgaGVhZGVyIHF1aXJrLgo+PiAg
Ki8KPj4gLXZvaWQgcGNpX2FkZF9kbWFfYWxpYXMoc3RydWN0IHBjaV9kZXYgKmRldiwgdTggZGV2
Zm4pCj4+ICt2b2lkIHBjaV9hZGRfZG1hX2FsaWFzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHU4IGRl
dmZuX2Zyb20sIHVuc2lnbmVkIG5yX2RldmZucykKPj4gewo+PiArCWludCBkZXZmbl90bzsKPj4g
Kwo+PiArCW5yX2RldmZucyA9IG1pbihucl9kZXZmbnMsICh1bnNpZ25lZClNQVhfTlJfREVWRk5T
KTsKPj4gKwlkZXZmbl90byA9IGRldmZuX2Zyb20gKyBucl9kZXZmbnMgLSAxOwo+IAo+IEkgbWFk
ZSB0aGlzIGxvb2sgbGlrZToKPiAKPiArICAgICAgIGRldmZuX3RvID0gbWluKGRldmZuX2Zyb20g
KyBucl9kZXZmbnMgLSAxLAo+ICsgICAgICAgICAgICAgICAgICAgICAgKHVuc2lnbmVkKSBNQVhf
TlJfREVWRk5TIC0gMSk7Cj4gCj4gc28gZGV2Zm5fZnJvbT0weGYwLCBucl9kZXZmbnM9MHgyMCBk
b2Vzbid0IGNhdXNlIGRldmZuX3RvIHRvIHdyYXAKPiBhcm91bmQuCj4gCj4gSSBkaWQga2VlcCBM
b2dhbidzIHJldmlld2VkLWJ5LCBzbyBsZXQgbWUga25vdyBpZiBJIGJyb2tlIHNvbWV0aGluZy4K
CkkgdGhpbmsgbnJfZGV2Zm5zIHN0aWxsIG5lZWRzIHVwZGF0aW5nIGFzIGl0IGlzIHVzZWQgZm9y
IGJpdG1hcF9zZXQuIApBbHRob3VnaCB0aGlua2luZyBhYm91dCBpdCBub3cgd2Ugc2hvdWxkIGxp
bWl0IHRoZSBudW1iZXIgdG8gYWxpYXMgdG8gYmUgCm1heGltdW0gKE1BWF9OUl9ERVZGTlMgLSBk
ZXZmbl9mcm9tKSwgc28gdGhhdCB3ZSBkb27igJl0IHNldCBwYXN0IHRoZSBlbmQgb2YgCnRoZSBi
aXRtYXA6CgogbnJfZGV2Zm5zID0gbWluKG5yX2RldmZucywgKHVuc2lnbmVkKSBNQVhfTlJfREVW
Rk5TIC0gZGV2Zm5fZnJvbSk7CgpJIHRoaW5rIHdpdGggdGhpcyBjaGFuZ2Ugd2Ugd29udCBuZWVk
IHRvIGNsaXAgZGV2Zm5fdG8uCgo+IAo+PiAJaWYgKCFkZXYtPmRtYV9hbGlhc19tYXNrKQo+PiAJ
CWRldi0+ZG1hX2FsaWFzX21hc2sgPSBiaXRtYXBfemFsbG9jKE1BWF9OUl9ERVZGTlMsIEdGUF9L
RVJORUwpOwo+PiAJaWYgKCFkZXYtPmRtYV9hbGlhc19tYXNrKSB7Cj4+IEBAIC01ODgyLDkgKzU4
ODgsMTUgQEAgdm9pZCBwY2lfYWRkX2RtYV9hbGlhcyhzdHJ1Y3QgcGNpX2RldiAqZGV2LCB1OCBk
ZXZmbikKPj4gCQlyZXR1cm47Cj4+IAl9Cj4+IAo+PiAtCXNldF9iaXQoZGV2Zm4sIGRldi0+ZG1h
X2FsaWFzX21hc2spOwo+PiAtCXBjaV9pbmZvKGRldiwgIkVuYWJsaW5nIGZpeGVkIERNQSBhbGlh
cyB0byAlMDJ4LiVkXG4iLAo+PiAtCQkgUENJX1NMT1QoZGV2Zm4pLCBQQ0lfRlVOQyhkZXZmbikp
Owo+PiArCWJpdG1hcF9zZXQoZGV2LT5kbWFfYWxpYXNfbWFzaywgZGV2Zm5fZnJvbSwgbnJfZGV2
Zm5zKTsKPj4gKwo+PiArCWlmIChucl9kZXZmbnMgPT0gMSkKPj4gKwkJcGNpX2luZm8oZGV2LCAi
RW5hYmxpbmcgZml4ZWQgRE1BIGFsaWFzIHRvICUwMnguJWRcbiIsCj4+ICsJCQkJUENJX1NMT1Qo
ZGV2Zm5fZnJvbSksIFBDSV9GVU5DKGRldmZuX2Zyb20pKTsKPj4gKwllbHNlIGlmKG5yX2RldmZu
cyA+IDEpCj4+ICsJCXBjaV9pbmZvKGRldiwgIkVuYWJsaW5nIGZpeGVkIERNQSBhbGlhcyBmb3Ig
ZGV2Zm4gcmFuZ2UgZnJvbSAlMDJ4LiVkIHRvICUwMnguJWRcbiIsCj4+ICsJCQkJUENJX1NMT1Qo
ZGV2Zm5fZnJvbSksIFBDSV9GVU5DKGRldmZuX2Zyb20pLAo+PiArCQkJCVBDSV9TTE9UKGRldmZu
X3RvKSwgUENJX0ZVTkMoZGV2Zm5fdG8pKTsKPj4gfQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
