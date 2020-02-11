Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22571C352A3
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 09:32:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB4FD20848
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 09:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="mllI2Pw+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB4FD20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 99602204A9;
	Tue, 11 Feb 2020 09:32:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PA7AIDC-rzq3; Tue, 11 Feb 2020 09:32:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 90EE3203BE;
	Tue, 11 Feb 2020 09:32:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DE6AC1D80;
	Tue, 11 Feb 2020 09:32:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83178C07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 09:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7BEE686762
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 09:32:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0iZTyryLVkQB for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 09:32:06 +0000 (UTC)
X-Greylist: delayed 00:22:45 by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6993486631
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 09:32:06 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id q81so12196577oig.0
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 01:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessm-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W3K1RJQxlhAeDaxI7FtV3mf9LRwqMOs6DSkvkZhUcx0=;
 b=mllI2Pw+V5dAPg3TUI/DzZpHs0zupuj0j9wf0SHm1I9sNQmg//i+JqoJVfRNAWcUIa
 Y2igodXYzaqn3Alz92b0VR+0bzDAFVPO87+vj5ILWXaUMkNUex7I3gr/BwCj6ZoilOOt
 r3I0Jv2tL3Rlf7WTgKL/6UiOFIMePbojbkDQn2WhAlqRx07roHKSchDBZWdvHjOioTi4
 gtqWjV/DtB7cD7IZioN/Ctlg5tj6oYsSEFQug3KbyatSb2C6OAGbu9mv2cPg5HHsrJ5Y
 bdq4XUt234X396x3nM0xY3wqYP4umfL3LnSZcaWVRvdMfpWxSxnco/hePSyn09Qo0286
 GYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=W3K1RJQxlhAeDaxI7FtV3mf9LRwqMOs6DSkvkZhUcx0=;
 b=rwvjLzrO9PP8SF2REGDtIke/WY0LUYx4HfaLIeiOT6W3XwsZNGP+yFhR2yK4xpXymo
 PqJuQ+m7cdc0Z5SBSSkqdQTSk2hSxitmMgP9pnSzPl4/eRsHBNPP5INe3Ak0S4li1nKm
 JViUGMOjnHmxWqTYxl/fSd6L6+PjtvrLPk1qbGgrnB7oDcSpJgHeCZp8Pawytw5Z1+Jn
 euQamWIQ5gIuALHziA44Sr6V/tZ900h16d6mWmPD1t4S1QFl80x5oidM7t6jo79in6ZV
 zb/aIYqzhfteCGkxzDAWihvp0ONjFhAH44HtuMTQOkpf4Kgv3HM9CrEN+FEJdfQuoqqr
 rCFw==
X-Gm-Message-State: APjAAAXso6b9Q12nacA9/onOoPlRJsHscaqeOOTogvgdy24du1VTMpun
 dvvrYV8u8uOyDecmusXw6hLUBbY+ewGL6A==
X-Google-Smtp-Source: APXvYqySeJhy8B0OrsYRC2YrQ5nvH4/qtXSsBnuZhoTIdE5gvzgZW3XygG1HUrrfv5Ne58nQ06s/pg==
X-Received: by 2002:a17:90a:234f:: with SMTP id
 f73mr2399888pje.109.1581411810598; 
 Tue, 11 Feb 2020 01:03:30 -0800 (PST)
Received: from limbo.local (123-204-46-122.static.seed.net.tw.
 [123.204.46.122])
 by smtp.gmail.com with ESMTPSA id l18sm3319167pfe.96.2020.02.11.01.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 01:03:29 -0800 (PST)
From: Daniel Drake <drake@endlessm.com>
To: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org
Subject: [PATCH] iommu/dmar: ignore devices with out-of-spec domain number
Date: Tue, 11 Feb 2020 17:03:25 +0800
Message-Id: <20200211090325.11423-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux@endlessm.com
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

Vk1EIHN1YmRldmljZXMgYXJlIGNyZWF0ZWQgd2l0aCBhIFBDSSBkb21haW4gSUQgb2YgMHgxMDAw
MCBvcgpoaWdoZXIuCgpUaGVzZSBzdWJkZXZpY2VzIGFyZSBhbHNvIGhhbmRsZWQgbGlrZSBhbGwg
b3RoZXIgUENJIGRldmljZXMgYnkKZG1hcl9wY2lfYnVzX25vdGlmaWVyKCkuCgpIb3dldmVyLCB3
aGVuIGRtYXJfYWxsb2NfcGNpX25vdGlmeV9pbmZvKCkgdGFrZSByZWNvcmRzIG9mIHN1Y2ggZGV2
aWNlcywKaXQgd2lsbCB0cnVuY2F0ZSB0aGUgZG9tYWluIElEIHRvIGEgdTE2IHZhbHVlIChpbiBp
bmZvLT5zZWcpLgpUaGUgZGV2aWNlIGF0IChlLmcuKSAxMDAwMDowMDowMi4wIGlzIHRoZW4gdHJl
YXRlZCBieSB0aGUgRE1BUiBjb2RlIGFzIGlmCml0IGlzIDAwMDA6MDA6MDIuMC4KCkluIHRoZSB1
bmx1Y2t5IGV2ZW50IHRoYXQgYSByZWFsIGRldmljZSBhbHNvIGV4aXN0cyBhdCAwMDAwOjAwOjAy
LjAgYW5kCmFsc28gaGFzIGEgZGV2aWNlLXNwZWNpZmljIGVudHJ5IGluIHRoZSBETUFSIHRhYmxl
LApkbWFyX2luc2VydF9kZXZfc2NvcGUoKSB3aWxsIGNyYXNoIG9uOgogwqAgQlVHX09OKGkgPj0g
ZGV2aWNlc19jbnQpOwoKVGhhdCdzIGJhc2ljYWxseSBhIHNhbml0eSBjaGVjayB0aGF0IG9ubHkg
b25lIFBDSSBkZXZpY2UgbWF0Y2hlcyBhCnNpbmdsZSBETUFSIGVudHJ5OyBpbiB0aGlzIGNhc2Ug
d2Ugc2VlbSB0byBoYXZlIHR3byBtYXRjaGluZyBkZXZpY2VzLgoKRml4IHRoaXMgYnkgaWdub3Jp
bmcgZGV2aWNlcyB0aGF0IGhhdmUgYSBkb21haW4gbnVtYmVyIGhpZ2hlciB0aGFuCndoYXQgY2Fu
IGJlIGxvb2tlZCB1cCBpbiB0aGUgRE1BUiB0YWJsZS4KClRoaXMgcHJvYmxlbSB3YXMgY2FyZWZ1
bGx5IGRpYWdub3NlZCBieSBKaWFuLUhvbmcgUGFuLgoKU2lnbmVkLW9mZi1ieTogRGFuaWVsIERy
YWtlIDxkcmFrZUBlbmRsZXNzbS5jb20+Ci0tLQoKTm90ZXM6CiAgICBUaGlzIHByb2JsZW0gd2Fz
IGRldGVjdGVkIHdpdGggYSBub24tdXBzdHJlYW0gcGF0Y2gKICAgICJQQ0k6IEFkZCBJbnRlbCBy
ZW1hcHBlZCBOVk1lIGRldmljZSBzdXBwb3J0IgogICAgKGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxp
bnV4LWlkZSZtPTE1NjAxNTI3MTAyMTYxNSZ3PTIpCiAgICAKICAgIFRoaXMgcGF0Y2ggY3JlYXRl
cyBQQ0kgZGV2aWNlcyBpbiB0aGUgc2FtZSB3YXkgYXMgVk1ELCBhbmQgaGVuY2UKICAgIEkgYmVs
aWV2ZSBWTUQgd291bGQgaGl0IHRoZSBzYW1lIHByb2JsZW0gdGhhdCB3ZSBlbmNvdW50ZXJlZCBo
ZXJlLCB3aGVuCiAgICBhIFZNRC11c2luZyBwcm9kdWN0IGNvbWVzIGFsb25nIHRoYXQgbWVldHMg
dGhlIG1lbnRpb25lZCBjb25kaXRpb25zLgogICAgCiAgICBIb3dldmVyIHRoaXMgaGFzbid0IGFj
dHVhbGx5IGJlZW4gdGVzdGVkIG9uIFZNRCAoZG9uJ3QgaGF2ZSB0aGUgaGFyZHdhcmUpCiAgICBz
byBpZiBJJ3ZlIG1pc3NlZCBhbnl0aGluZyBhbmQvb3IgaXQncyBub3QgYSByZWFsIGlzc3VlIHRo
ZW4gZmVlbCBmcmVlIHRvCiAgICBkcm9wIHRoaXMgcGF0Y2guCgogZHJpdmVycy9pb21tdS9kbWFy
LmMgfCA4ICsrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9kbWFyLmMgYi9kcml2ZXJzL2lvbW11L2RtYXIuYwppbmRleCAw
NzFiYjQyYmJiYzUuLjhmOTRjODE3YTdiNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9kbWFy
LmMKKysrIGIvZHJpdmVycy9pb21tdS9kbWFyLmMKQEAgLTI4LDYgKzI4LDcgQEAKICNpbmNsdWRl
IDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGludXgvaW9tbXUuaD4KICNpbmNsdWRlIDxsaW51
eC9udW1hLmg+CisjaW5jbHVkZSA8bGludXgvbGltaXRzLmg+CiAjaW5jbHVkZSA8YXNtL2lycV9y
ZW1hcHBpbmcuaD4KICNpbmNsdWRlIDxhc20vaW9tbXVfdGFibGUuaD4KIApAQCAtMTI4LDYgKzEy
OSwxMyBAQCBkbWFyX2FsbG9jX3BjaV9ub3RpZnlfaW5mbyhzdHJ1Y3QgcGNpX2RldiAqZGV2LCB1
bnNpZ25lZCBsb25nIGV2ZW50KQogCiAJQlVHX09OKGRldi0+aXNfdmlydGZuKTsKIAorCS8qCisJ
ICogSWdub3JlIGRldmljZXMgdGhhdCBoYXZlIGEgZG9tYWluIG51bWJlciBoaWdoZXIgdGhhbiB3
aGF0IGNhbgorCSAqIGJlIGxvb2tlZCB1cCBpbiBETUFSLCBlLmcuIFZNRCBzdWJkZXZpY2VzIHdp
dGggZG9tYWluIDB4MTAwMDAKKwkgKi8KKwlpZiAocGNpX2RvbWFpbl9ucihkZXYtPmJ1cykgPiBV
MTZfTUFYKQorCQlyZXR1cm4gTlVMTDsKKwogCS8qIE9ubHkgZ2VuZXJhdGUgcGF0aFtdIGZvciBk
ZXZpY2UgYWRkaXRpb24gZXZlbnQgKi8KIAlpZiAoZXZlbnQgPT0gQlVTX05PVElGWV9BRERfREVW
SUNFKQogCQlmb3IgKHRtcCA9IGRldjsgdG1wOyB0bXAgPSB0bXAtPmJ1cy0+c2VsZikKLS0gCjIu
MjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
