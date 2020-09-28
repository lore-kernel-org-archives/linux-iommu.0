Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5828DC4742A
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 053302100A
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 21:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sx18k5qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053302100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9A62920794;
	Mon, 28 Sep 2020 21:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3dclsBY0JUNQ; Mon, 28 Sep 2020 21:37:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 046CF20785;
	Mon, 28 Sep 2020 21:37:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBE97C0891;
	Mon, 28 Sep 2020 21:36:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F18A0C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EC32B86655
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fYYSz+vVIVIu for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B2C1486668
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 21:36:56 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id kk9so1464054pjb.2
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Atey8nbuDzuUr3JKV5+LdIsFe8hfPfYfTvoAcQuofpk=;
 b=sx18k5qaKY7D44k250bMwq3BUbcBw0v4NNDbb7A3icBG7vgtWUUMQ56NxQaIUEyFZ2
 VAzw/jy0F2ydRi+14LPRsoaSfUxDSUBrWSpCMo6egbxoEEr+q3Bmo0zRmlZPA6Bj/P9Y
 minFyrHvScqwmmBLXc4P38QYP0JAChRfaMNaJf7lD5FVe/YPbblmKFBY2NBo2yrM8FbN
 Afo/LOcLg5udhHvPjOzuV8yK7xjKSPLgVvAOWQ4cVgRMa1OPGkGbmKiZCaq5fh+pzVPV
 FHR/roIi2Asx9cjJORqQe9hn2dj/o/q9vKlM4QIIBcWwI5+9/t1PSLAkApaImjDI56/I
 MaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Atey8nbuDzuUr3JKV5+LdIsFe8hfPfYfTvoAcQuofpk=;
 b=LoQR/HQQVfK1/AwDbGdkoD8bD4jImPcE5CJ5LCykho+kRVloJ1+i/+vCcGgmz7Pgms
 IVM/nBl7we+PXCBDiyOY1afrjMu3nxBrjPswREMY6X8bL6b5JqM7Id3QVo5C2IHRFfKH
 kxRuksV13W6uy264QTUvsQjxpd8twoJvYXqLppvBGTpsnZHCXak4yqclsy6m3UrkAtaf
 zdSNaTkdSvVrAK1Mm8bPGuWPFSKMA7ihd9BUF6STusu2h0ClCbRmpKpIxXiyj8w/L4t7
 twMxFR9b/JiIajtQ2Mwp4+LW2sBJfEX7LOelR0Pq8N3sO9x0y2N3KBWaz4C+d3psAZxk
 xNgQ==
X-Gm-Message-State: AOAM533ptdsjbtVRHbhd9U0WEDrO+ou9QpLtfX1NKUfLEZSPCjzpc+T5
 idyRBMZ6JBbOWw5NR1nIKHLq785cUko=
X-Google-Smtp-Source: ABdhPJz/P48h6PBRWfmYp4KTl1u93gqaZoCJDUfjjgJpm/85E2fGfKu8V02yVviaaDMvuehX6BNagw==
X-Received: by 2002:a17:90b:b8f:: with SMTP id
 bd15mr1062834pjb.65.1601329016059; 
 Mon, 28 Sep 2020 14:36:56 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com.
 [134.134.137.73])
 by smtp.gmail.com with ESMTPSA id l11sm2220864pjf.17.2020.09.28.14.36.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 14:36:55 -0700 (PDT)
From: Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 11/14] iommu/ioasid: Support mm type ioasid_set
 notifications
Date: Mon, 28 Sep 2020 14:38:38 -0700
Message-Id: <1601329121-36979-12-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, linux-api@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Yi Sun <yi.y.sun@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

QXMgYSBzeXN0ZW0td2lkZSByZXNvdXJjZSwgSU9BU0lEIGlzIG9mdGVuIHNoYXJlZCBieSBtdWx0
aXBsZSBrZXJuZWwKc3Vic3lzdGVtcyB0aGF0IGFyZSBpbmRlcGVuZGVudCBvZiBlYWNoIG90aGVy
LiBIb3dldmVyLCBhdCB0aGUKaW9hc2lkX3NldCBsZXZlbCwgdGhlc2Uga2VybmVsIHN1YnN5c3Rl
bXMgbXVzdCBjb21tdW5pY2F0ZSB3aXRoIGVhY2gKb3RoZXIgZm9yIG93bmVyc2hpcCBjaGVja2lu
ZywgZXZlbnQgbm90aWZpY2F0aW9ucywgZXRjLiBGb3IgZXhhbXBsZSwgb24KSW50ZWwgU2NhbGFi
bGUgSU8gVmlydHVhbGl6YXRpb24gKFNJT1YpIGVuYWJsZWQgcGxhdGZvcm1zLCBLVk0gYW5kIFZG
SU8KaW5zdGFuY2VzIHVuZGVyIHRoZSBzYW1lIHByb2Nlc3MvZ3Vlc3QgbXVzdCBiZSBhd2FyZSBv
ZiBhIHNoYXJlZCBJT0FTSUQKc2V0LgpJT0FTSURfU0VUX1RZUEVfTU0gdG9rZW4gdHlwZSB3YXMg
aW50cm9kdWNlZCB0byBleHBsaWNpdGx5IG1hcmsgYW4KSU9BU0lEIHNldCB0aGF0IGJlbG9uZ3Mg
dG8gYSBwcm9jZXNzLCB0aHVzIHVzZSB0aGUgc2FtZSBtbV9zdHJ1Y3QKcG9pbnRlciBhcyBhIHRv
a2VuLiBVc2VycyBvZiB0aGUgc2FtZSBwcm9jZXNzIGNhbiB0aGVuIGlkZW50aWZ5IHdpdGgKZWFj
aCBvdGhlciBiYXNlZCBvbiB0aGlzIHRva2VuLgoKVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIE1NIHRv
a2VuIHNwZWNpZmljIGV2ZW50IHJlZ2lzdHJhdGlvbiBBUElzLiBFdmVudApzdWJzY3JpYmVycyBz
dWNoIGFzIEtWTSBpbnN0YW5jZXMgY2FuIHJlZ2lzdGVyIElPQVNJRCBldmVudCBoYW5kbGVyCndp
dGhvdXQgdGhlIGtub3dsZWRnZSBvZiBpdHMgaW9hc2lkX3NldC4gRXZlbnQgaGFuZGxlcnMgYXJl
IHJlZ2lzdGVyZWQKYmFzZWQgb24gaXRzIG1tX3N0cnVjdCBwb2ludGVyIGFzIGEgdG9rZW4uIElu
IGNhc2Ugd2hlbiBzdWJzY3JpYmVycwpyZWdpc3RlciBoYW5kbGVyICpwcmlvciogdG8gdGhlIGNy
ZWF0aW9uIG9mIHRoZSBpb2FzaWRfc2V0LCB0aGUKaGFuZGxlcuKAmXMgbm90aWZpY2F0aW9uIGJs
b2NrIGlzIHN0b3JlZCBpbiBhIHBlbmRpbmcgbGlzdCB3aXRoaW4gSU9BU0lECmNvcmUuIE9uY2Ug
dGhlIGlvYXNpZF9zZXQgb2YgdGhlIE1NIHRva2VuIGlzIGNyZWF0ZWQsIHRoZSBub3RpZmljYXRp
b24KYmxvY2sgd2lsbCBiZSByZWdpc3RlcmVkIGJ5IHRoZSBJT0FTSUQgY29yZS4KClNpZ25lZC1v
ZmYtYnk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+ClNpZ25lZC1vZmYtYnk6IFd1IEhh
byA8aGFvLnd1QGludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogSmFjb2IgUGFuIDxqYWNvYi5qdW4u
cGFuQGxpbnV4LmludGVsLmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2lvYXNpZC5jIHwgMTE3ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIGluY2x1ZGUv
bGludXgvaW9hc2lkLmggfCAgMTUgKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMzIgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9hc2lkLmMgYi9kcml2ZXJzL2lv
bW11L2lvYXNpZC5jCmluZGV4IDg5NGIxN2MwNmVhZC4uZDVmYWViNTU5YTQzIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2lvbW11L2lvYXNpZC5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW9hc2lkLmMKQEAg
LTg4OSw2ICs4ODksMjkgQEAgdm9pZCBpb2FzaWRfc2V0X3B1dChzdHJ1Y3QgaW9hc2lkX3NldCAq
c2V0KQogfQogRVhQT1JUX1NZTUJPTF9HUEwoaW9hc2lkX3NldF9wdXQpOwogCisvKgorICogaW9h
c2lkX2ZpbmRfbW1fc2V0IC0gUmV0cmlldmUgSU9BU0lEIHNldCB3aXRoIG1tIHRva2VuCisgKiBU
YWtlIGEgcmVmZXJlbmNlIG9mIHRoZSBzZXQgaWYgZm91bmQuCisgKi8KK3N0YXRpYyBzdHJ1Y3Qg
aW9hc2lkX3NldCAqaW9hc2lkX2ZpbmRfbW1fc2V0KHN0cnVjdCBtbV9zdHJ1Y3QgKnRva2VuKQor
eworCXN0cnVjdCBpb2FzaWRfc2V0ICpzZXQ7CisJdW5zaWduZWQgbG9uZyBpbmRleDsKKworCXNw
aW5fbG9jaygmaW9hc2lkX2FsbG9jYXRvcl9sb2NrKTsKKworCXhhX2Zvcl9lYWNoKCZpb2FzaWRf
c2V0cywgaW5kZXgsIHNldCkgeworCQlpZiAoc2V0LT50eXBlID09IElPQVNJRF9TRVRfVFlQRV9N
TSAmJiBzZXQtPnRva2VuID09IHRva2VuKSB7CisJCQlyZWZjb3VudF9pbmMoJnNldC0+cmVmKTsK
KwkJCWdvdG8gZXhpdF91bmxvY2s7CisJCX0KKwl9CisJc2V0ID0gTlVMTDsKK2V4aXRfdW5sb2Nr
OgorCXNwaW5fdW5sb2NrKCZpb2FzaWRfYWxsb2NhdG9yX2xvY2spOworCXJldHVybiBzZXQ7Cit9
CisKIC8qKgogICogaW9hc2lkX2FkanVzdF9zZXQgLSBBZGp1c3QgdGhlIHF1b3RhIG9mIGFuIElP
QVNJRCBzZXQKICAqIEBzZXQ6CUlPQVNJRCBzZXQgdG8gYmUgYXNzaWduZWQKQEAgLTExMjEsNiAr
MTE0NCwxMDAgQEAgdm9pZCBpb2FzaWRfdW5yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3QgaW9hc2lk
X3NldCAqc2V0LAogfQogRVhQT1JUX1NZTUJPTF9HUEwoaW9hc2lkX3VucmVnaXN0ZXJfbm90aWZp
ZXIpOwogCisvKioKKyAqIGlvYXNpZF9yZWdpc3Rlcl9ub3RpZmllcl9tbSAtIFJlZ2lzdGVyIGEg
bm90aWZpZXIgYmxvY2sgb24gdGhlIElPQVNJRCBzZXQKKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGNyZWF0ZWQgYnkgdGhlIG1tX3N0cnVjdCBwb2ludGVyIGFzIHRoZSB0b2tlbgor
ICoKKyAqIEBtbTogdGhlIG1tX3N0cnVjdCB0b2tlbiBvZiB0aGUgaW9hc2lkX3NldAorICogQG5i
OiBub3RmaWVyIGJsb2NrIHRvIGJlIHJlZ2lzdGVyZWQgb24gdGhlIGlvYXNpZF9zZXQKKyAqCisg
KiBUaGlzIGEgdmFyaWFudCBvZiBpb2FzaWRfcmVnaXN0ZXJfbm90aWZpZXIoKSB3aGVyZSB0aGUg
Y2FsbGVyIGludGVuZHMgdG8KKyAqIGxpc3RlbiB0byBJT0FTSUQgZXZlbnRzIGJlbG9uZyB0aGUg
aW9hc2lkX3NldCBjcmVhdGVkIHVuZGVyIHRoZSBzYW1lCisgKiBwcm9jZXNzLiBDYWxsZXIgaXMg
bm90IGF3YXJlIG9mIHRoZSBpb2FzaWRfc2V0LCBubyBuZWVkIHRvIGhvbGQgcmVmZXJlbmNlCisg
KiBvZiB0aGUgaW9hc2lkX3NldC4KKyAqLworaW50IGlvYXNpZF9yZWdpc3Rlcl9ub3RpZmllcl9t
bShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYikKK3sKKwlz
dHJ1Y3QgaW9hc2lkX3NldF9uYiAqY3VycjsKKwlzdHJ1Y3QgaW9hc2lkX3NldCAqc2V0OworCWlu
dCByZXQgPSAwOworCisJaWYgKCFtbSkKKwkJcmV0dXJuIC1FSU5WQUw7CisKKwlzcGluX2xvY2so
JmlvYXNpZF9uYl9sb2NrKTsKKworCS8qIENoZWNrIGZvciBkdXBsaWNhdGVzLCBuYiBpcyB1bmlx
dWUgcGVyIHNldCAqLworCWxpc3RfZm9yX2VhY2hfZW50cnkoY3VyciwgJmlvYXNpZF9uYl9wZW5k
aW5nX2xpc3QsIGxpc3QpIHsKKwkJaWYgKGN1cnItPnRva2VuID09IG1tICYmIGN1cnItPm5iID09
IG5iKSB7CisJCQlyZXQgPSAtRUJVU1k7CisJCQlnb3RvIGV4aXRfdW5sb2NrOworCQl9CisJfQor
CisJLyogQ2hlY2sgaWYgdGhlIHRva2VuIGhhcyBhbiBleGlzdGluZyBzZXQgKi8KKwlzZXQgPSBp
b2FzaWRfZmluZF9tbV9zZXQobW0pOworCWlmICghc2V0KSB7CisJCS8qIEFkZCB0byB0aGUgcnN2
ZCBsaXN0IGFzIGluYWN0aXZlICovCisJCWN1cnItPmFjdGl2ZSA9IGZhbHNlOworCX0gZWxzZSB7
CisJCS8qIFJFVklTSVQ6IE9ubHkgcmVnaXN0ZXIgZW1wdHkgc2V0IGZvciBub3cuIENhbiBhZGQg
YW4gb3B0aW9uCisJCSAqIGluIHRoZSBmdXR1cmUgdG8gcGxheWJhY2sgZXhpc3RpbmcgUEFTSURz
LgorCQkgKi8KKwkJaWYgKHNldC0+bnJfaW9hc2lkcykgeworCQkJcHJfd2FybigiSU9BU0lEIHNl
dCAlZCBub3QgZW1wdHlcbiIsIHNldC0+aWQpOworCQkJcmV0ID0gLUVCVVNZOworCQkJZ290byBl
eGl0X3VubG9jazsKKwkJfQorCQljdXJyID0ga3phbGxvYyhzaXplb2YoKmN1cnIpLCBHRlBfQVRP
TUlDKTsKKwkJaWYgKCFjdXJyKSB7CisJCQlyZXQgPSAtRU5PTUVNOworCQkJZ290byBleGl0X3Vu
bG9jazsKKwkJfQorCQljdXJyLT50b2tlbiA9IG1tOworCQljdXJyLT5uYiA9IG5iOworCQljdXJy
LT5hY3RpdmUgPSB0cnVlOworCQljdXJyLT5zZXQgPSBzZXQ7CisKKwkJLyogU2V0IGFscmVhZHkg
Y3JlYXRlZCwgYWRkIHRvIHRoZSBub3RpZmllciBjaGFpbiAqLworCQlhdG9taWNfbm90aWZpZXJf
Y2hhaW5fcmVnaXN0ZXIoJnNldC0+bmgsIG5iKTsKKwkJLyoKKwkJICogRG8gbm90IGhvbGQgYSBy
ZWZlcmVuY2UsIGlmIHRoZSBzZXQgZ2V0cyBkZXN0cm95ZWQsIHRoZSBuYgorCQkgKiBlbnRyeSB3
aWxsIGJlIG1hcmtlZCBpbmFjdGl2ZS4KKwkJICovCisJCWlvYXNpZF9zZXRfcHV0KHNldCk7CisJ
fQorCisJbGlzdF9hZGQoJmN1cnItPmxpc3QsICZpb2FzaWRfbmJfcGVuZGluZ19saXN0KTsKKwor
ZXhpdF91bmxvY2s6CisJc3Bpbl91bmxvY2soJmlvYXNpZF9uYl9sb2NrKTsKKwlyZXR1cm4gcmV0
OworfQorRVhQT1JUX1NZTUJPTF9HUEwoaW9hc2lkX3JlZ2lzdGVyX25vdGlmaWVyX21tKTsKKwor
dm9pZCBpb2FzaWRfdW5yZWdpc3Rlcl9ub3RpZmllcl9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSwg
c3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYikKK3sKKwlzdHJ1Y3QgaW9hc2lkX3NldF9uYiAqY3Vy
cjsKKworCXNwaW5fbG9jaygmaW9hc2lkX25iX2xvY2spOworCWxpc3RfZm9yX2VhY2hfZW50cnko
Y3VyciwgJmlvYXNpZF9uYl9wZW5kaW5nX2xpc3QsIGxpc3QpIHsKKwkJaWYgKGN1cnItPnRva2Vu
ID09IG1tICYmIGN1cnItPm5iID09IG5iKSB7CisJCQlsaXN0X2RlbCgmY3Vyci0+bGlzdCk7CisJ
CQlzcGluX3VubG9jaygmaW9hc2lkX25iX2xvY2spOworCQkJaWYgKGN1cnItPmFjdGl2ZSkgewor
CQkJCWF0b21pY19ub3RpZmllcl9jaGFpbl91bnJlZ2lzdGVyKCZjdXJyLT5zZXQtPm5oLAorCQkJ
CQkJCQkgbmIpOworCQkJfQorCQkJa2ZyZWUoY3Vycik7CisJCQlyZXR1cm47CisJCX0KKwl9CisJ
cHJfd2FybigiTm8gaW9hc2lkIHNldCBmb3VuZCBmb3IgbW0gdG9rZW4gJWxseFxuIiwgICh1NjQp
bW0pOworCXNwaW5fdW5sb2NrKCZpb2FzaWRfbmJfbG9jayk7Cit9CitFWFBPUlRfU1lNQk9MX0dQ
TChpb2FzaWRfdW5yZWdpc3Rlcl9ub3RpZmllcl9tbSk7CisKIE1PRFVMRV9BVVRIT1IoIkplYW4t
UGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZS5icnVja2VyQGFybS5jb20+Iik7CiBNT0RV
TEVfQVVUSE9SKCJKYWNvYiBQYW4gPGphY29iLmp1bi5wYW5AbGludXguaW50ZWwuY29tPiIpOwog
TU9EVUxFX0RFU0NSSVBUSU9OKCJJTyBBZGRyZXNzIFNwYWNlIElEIChJT0FTSUQpIGFsbG9jYXRv
ciIpOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pb2FzaWQuaCBiL2luY2x1ZGUvbGludXgv
aW9hc2lkLmgKaW5kZXggMWI1NTFjOTlkNTY4Li5jNmNjODU1YWFkYjYgMTAwNjQ0Ci0tLSBhL2lu
Y2x1ZGUvbGludXgvaW9hc2lkLmgKKysrIGIvaW5jbHVkZS9saW51eC9pb2FzaWQuaApAQCAtMTMy
LDYgKzEzMiw5IEBAIHZvaWQgaW9hc2lkX3VucmVnaXN0ZXJfbm90aWZpZXIoc3RydWN0IGlvYXNp
ZF9zZXQgKnNldCwKIHZvaWQgaW9hc2lkX3NldF9mb3JfZWFjaF9pb2FzaWQoc3RydWN0IGlvYXNp
ZF9zZXQgKnNkYXRhLAogCQkJCXZvaWQgKCpmbikoaW9hc2lkX3QgaWQsIHZvaWQgKmRhdGEpLAog
CQkJCXZvaWQgKmRhdGEpOworaW50IGlvYXNpZF9yZWdpc3Rlcl9ub3RpZmllcl9tbShzdHJ1Y3Qg
bW1fc3RydWN0ICptbSwgc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7Cit2b2lkIGlvYXNpZF91
bnJlZ2lzdGVyX25vdGlmaWVyX21tKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgKm5iKTsKKwogI2Vsc2UgLyogIUNPTkZJR19JT0FTSUQgKi8KIHN0YXRpYyBpbmxp
bmUgdm9pZCBpb2FzaWRfaW5zdGFsbF9jYXBhY2l0eShpb2FzaWRfdCB0b3RhbCkKIHsKQEAgLTIz
OCw1ICsyNDEsMTcgQEAgc3RhdGljIGlubGluZSB2b2lkIGlvYXNpZF9zZXRfZm9yX2VhY2hfaW9h
c2lkKHN0cnVjdCBpb2FzaWRfc2V0ICpzZGF0YSwKIAkJCQkJICAgICAgdm9pZCAqZGF0YSkKIHsK
IH0KKworc3RhdGljIGlubGluZSBpbnQgaW9hc2lkX3JlZ2lzdGVyX25vdGlmaWVyX21tKHN0cnVj
dCBtbV9zdHJ1Y3QgKm1tLAorCQkJCQkgICAgICBzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKQor
eworCXJldHVybiAtRU5PVFNVUFA7Cit9CisKK3N0YXRpYyBpbmxpbmUgdm9pZCBpb2FzaWRfdW5y
ZWdpc3Rlcl9ub3RpZmllcl9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSwKKwkJCQkJCSBzdHJ1Y3Qg
bm90aWZpZXJfYmxvY2sgKm5iKQoreworfQorCiAjZW5kaWYgLyogQ09ORklHX0lPQVNJRCAqLwog
I2VuZGlmIC8qIF9fTElOVVhfSU9BU0lEX0ggKi8KLS0gCjIuNy40CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
