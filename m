Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD8CC433E2
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 13:44:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AFC20679
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcJ0FJkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AFC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DB9518669A;
	Fri, 26 Jun 2020 13:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9n9CAfkaqYyQ; Fri, 26 Jun 2020 13:44:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2D0D186569;
	Fri, 26 Jun 2020 13:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F323DC088C;
	Fri, 26 Jun 2020 13:44:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D25EC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 13:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 74DE7887D3
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 13:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PuYCwIn-hMHf for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 13:44:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BDA88887C8
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 13:44:15 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id y18so4303132plr.4
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 06:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=avkaKRtJK4C0IAHcq+LgUh9i3fWucO3C6govd2RCQI0=;
 b=dcJ0FJknKLnYp0ga1Ly2ebZkojK7vfLDvm1cFtpino4WqSydYNS6PifR1dp21sPuM3
 h4GMTldhYK/E2qm/UPo2mUSuHWW+HjdWwzECiZjVL7hM6GhAN3dAOpqRxGNFUX5Z+oM2
 /Af0OFiRH/V8M/P/mU5TBDt/R024f/t9PtXu91LrbfIJexhu33p+XZh/oe2PU6YEkZFc
 l37flrqK/cwCV1EohHKpLZZCOli6daX2RrzVgHICm+aFBOrA7CS0F2mvnf2vKFBkom2/
 uWbPxwR6GrpjNvAi1YGAsNb6lU5vO1D2/omYnJvWTehvt6SM+/QldpwvlW6E8emf6qtG
 w4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=avkaKRtJK4C0IAHcq+LgUh9i3fWucO3C6govd2RCQI0=;
 b=o88vkuvK/KiPmXBvaKMi2LiqnnsPvpFSSPMIN7bNLUAzrrWeGsZBEOMmPI+6oe6N2q
 z05Ou2EfFodDb5IVzLTOP3SCXh1dcvKXhHw4yDsYz28O2BWNyqHpWSmHj5PTf9jbXatu
 uzWZbXcbX1JnG2a9tWfAasq2MYMVwQ4/ir8EVBbG9ttJg236TGI4TZMLaocA5kc7t+Tt
 56OvJnS2GswQsvDxri7kZ6rhUTGjDSoIJEzyEsKyrg08J6oat2CVAbl5oXy2FZGreOXW
 iZfUV/isY3ySzBVBXOAoWn6gGJlOd+884I21WQdydH5wixJnvasZPAU+1ilox2hCB0RK
 FexQ==
X-Gm-Message-State: AOAM533M05EijrJsrpk1fU+rt0+MY3EI1gu5KOITDEyf3SFmQeQs0yKe
 QePIilXOkhbV6xa4vHAxnJA=
X-Google-Smtp-Source: ABdhPJwXVaAP8zWzcfa3qPXnxgqZhMnY5s5cL3q4YKh0yMe6Q1AWmLz7Shr3jpNlzvRs3S7LfHl7Eg==
X-Received: by 2002:a17:90a:9606:: with SMTP id
 v6mr1304478pjo.110.1593179055280; 
 Fri, 26 Jun 2020 06:44:15 -0700 (PDT)
Received: from btopel-mobl.ger.intel.com (fmdmzpr03-ext.fm.intel.com.
 [192.55.54.38])
 by smtp.gmail.com with ESMTPSA id k7sm15584523pgh.46.2020.06.26.06.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 06:44:14 -0700 (PDT)
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net] xsk: remove cheap_dma optimization
Date: Fri, 26 Jun 2020 15:43:58 +0200
Message-Id: <20200626134358.90122-1-bjorn.topel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: maximmi@mellanox.com, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, iommu@lists.linux-foundation.org,
 jonathan.lemon@gmail.com, bpf@vger.kernel.org,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>, hch@lst.de,
 magnus.karlsson@intel.com
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

RnJvbTogQmrDtnJuIFTDtnBlbCA8Ympvcm4udG9wZWxAaW50ZWwuY29tPgoKV2hlbiB0aGUgQUZf
WERQIGJ1ZmZlciBhbGxvY2F0aW9uIEFQSSB3YXMgaW50cm9kdWNlZCBpdCBoYWQgYW4Kb3B0aW1p
emF0aW9uLCAiY2hlYXBfZG1hIi4gVGhlIGlkZWEgd2FzIHRoYXQgd2hlbiB0aGUgdW1lbSB3YXMg
RE1BCm1hcHBlZCwgdGhlIHBvb2wgYWxzbyBjaGVja2VkIHdoZXRoZXIgdGhlIG1hcHBpbmcgcmVx
dWlyZWQgYQpzeW5jaHJvbml6YXRpb24gKENQVSB0byBkZXZpY2UsIGFuZCB2aWNlIHZlcnNhKS4g
SWYgbm90LCBpdCB3b3VsZCBiZQptYXJrZWQgYXMgImNoZWFwX2RtYSIgYW5kIHRoZSBzeW5jaHJv
bml6YXRpb24gd291bGQgYmUgZWxpZGVkLgoKSW4gWzFdIENocmlzdG9waCBwb2ludHMgb3V0IHRo
YXQgdGhlIG9wdGltaXphdGlvbiBhYm92ZSBicmVha3MgdGhlIERNQQpBUEkgYWJzdHJhY3Rpb24s
IGFuZCBzaG91bGQgYmUgcmVtb3ZlZC4gRnVydGhlciwgQ2hyaXN0b3BoIHBvaW50cyBvdXQKdGhh
dCBvcHRpbWl6YXRpb25zIGxpa2UgdGhpcyBzaG91bGQgYmUgZG9uZSB3aXRoaW4gdGhlIERNQSBt
YXBwaW5nCmNvcmUsIGFuZCBub3QgZWxzZXdoZXJlLgoKVW5mb3J0dW5hdGVseSB0aGlzIGhhcyBp
bXBsaWNhdGlvbnMgZm9yIHRoZSBwYWNrZXQgcmF0ZQpwZXJmb3JtYW5jZS4gVGhlIEFGX1hEUCBy
eGRyb3Agc2NlbmFyaW8gc2hvd3MgYSA5JSBkZWNyZWFzZSBpbiBwYWNrZXRzCnBlciBzZWNvbmQu
CgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbmV0ZGV2LzIwMjAwNjI2MDc0NzI1LkdBMjE3
OTBAbHN0LmRlLwoKQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgpGaXhlczogMmI0
MzQ3MGFkZDhjICgieHNrOiBJbnRyb2R1Y2UgQUZfWERQIGJ1ZmZlciBhbGxvY2F0aW9uIEFQSSIp
ClNpZ25lZC1vZmYtYnk6IEJqw7ZybiBUw7ZwZWwgPGJqb3JuLnRvcGVsQGludGVsLmNvbT4KLS0t
CiBpbmNsdWRlL25ldC94c2tfYnVmZl9wb29sLmggfCAxNiArKystLS0tLS0KIG5ldC94ZHAveHNr
X2J1ZmZfcG9vbC5jICAgICB8IDY5ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA3OSBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL25ldC94c2tfYnVmZl9wb29sLmggYi9pbmNsdWRlL25ldC94c2tf
YnVmZl9wb29sLmgKaW5kZXggYTRmZjIyNjUwNWM5Li4zZWE5Yjk2NTQ2MzIgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbmV0L3hza19idWZmX3Bvb2wuaAorKysgYi9pbmNsdWRlL25ldC94c2tfYnVmZl9w
b29sLmgKQEAgLTQwLDcgKzQwLDYgQEAgc3RydWN0IHhza19idWZmX3Bvb2wgewogCXUzMiBoZWFk
cm9vbTsKIAl1MzIgY2h1bmtfc2l6ZTsKIAl1MzIgZnJhbWVfbGVuOwotCWJvb2wgY2hlYXBfZG1h
OwogCWJvb2wgdW5hbGlnbmVkOwogCXZvaWQgKmFkZHJzOwogCXN0cnVjdCBkZXZpY2UgKmRldjsK
QEAgLTc3LDI0ICs3NiwxNyBAQCBzdGF0aWMgaW5saW5lIGRtYV9hZGRyX3QgeHBfZ2V0X2ZyYW1l
X2RtYShzdHJ1Y3QgeGRwX2J1ZmZfeHNrICp4c2tiKQogCXJldHVybiB4c2tiLT5mcmFtZV9kbWE7
CiB9CiAKLXZvaWQgeHBfZG1hX3N5bmNfZm9yX2NwdV9zbG93KHN0cnVjdCB4ZHBfYnVmZl94c2sg
Knhza2IpOwogc3RhdGljIGlubGluZSB2b2lkIHhwX2RtYV9zeW5jX2Zvcl9jcHUoc3RydWN0IHhk
cF9idWZmX3hzayAqeHNrYikKIHsKLQlpZiAoeHNrYi0+cG9vbC0+Y2hlYXBfZG1hKQotCQlyZXR1
cm47Ci0KLQl4cF9kbWFfc3luY19mb3JfY3B1X3Nsb3coeHNrYik7CisJZG1hX3N5bmNfc2luZ2xl
X3JhbmdlX2Zvcl9jcHUoeHNrYi0+cG9vbC0+ZGV2LCB4c2tiLT5kbWEsIDAsCisJCQkJICAgICAg
eHNrYi0+cG9vbC0+ZnJhbWVfbGVuLCBETUFfQklESVJFQ1RJT05BTCk7CiB9CiAKLXZvaWQgeHBf
ZG1hX3N5bmNfZm9yX2RldmljZV9zbG93KHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLCBkbWFf
YWRkcl90IGRtYSwKLQkJCQkgc2l6ZV90IHNpemUpOwogc3RhdGljIGlubGluZSB2b2lkIHhwX2Rt
YV9zeW5jX2Zvcl9kZXZpY2Uoc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsCiAJCQkJCSAgZG1h
X2FkZHJfdCBkbWEsIHNpemVfdCBzaXplKQogewotCWlmIChwb29sLT5jaGVhcF9kbWEpCi0JCXJl
dHVybjsKLQotCXhwX2RtYV9zeW5jX2Zvcl9kZXZpY2Vfc2xvdyhwb29sLCBkbWEsIHNpemUpOwor
CWRtYV9zeW5jX3NpbmdsZV9yYW5nZV9mb3JfZGV2aWNlKHBvb2wtPmRldiwgZG1hLCAwLAorCQkJ
CQkgc2l6ZSwgRE1BX0JJRElSRUNUSU9OQUwpOwogfQogCiAvKiBNYXNrcyBmb3IgeGRwX3VtZW1f
cGFnZSBmbGFncy4KZGlmZiAtLWdpdCBhL25ldC94ZHAveHNrX2J1ZmZfcG9vbC5jIGIvbmV0L3hk
cC94c2tfYnVmZl9wb29sLmMKaW5kZXggNTQwZWQ3NWU0NDgyLi5jMzMwZTVmM2FhZGYgMTAwNjQ0
Ci0tLSBhL25ldC94ZHAveHNrX2J1ZmZfcG9vbC5jCisrKyBiL25ldC94ZHAveHNrX2J1ZmZfcG9v
bC5jCkBAIC0yLDkgKzIsNiBAQAogCiAjaW5jbHVkZSA8bmV0L3hza19idWZmX3Bvb2wuaD4KICNp
bmNsdWRlIDxuZXQveGRwX3NvY2suaD4KLSNpbmNsdWRlIDxsaW51eC9kbWEtZGlyZWN0Lmg+Ci0j
aW5jbHVkZSA8bGludXgvZG1hLW5vbmNvaGVyZW50Lmg+Ci0jaW5jbHVkZSA8bGludXgvc3dpb3Rs
Yi5oPgogCiAjaW5jbHVkZSAieHNrX3F1ZXVlLmgiCiAKQEAgLTU1LDcgKzUyLDYgQEAgc3RydWN0
IHhza19idWZmX3Bvb2wgKnhwX2NyZWF0ZShzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCB1MzIgbnJfcGFn
ZXMsIHUzMiBjaHVua3MsCiAJcG9vbC0+ZnJlZV9oZWFkc19jbnQgPSBjaHVua3M7CiAJcG9vbC0+
aGVhZHJvb20gPSBoZWFkcm9vbTsKIAlwb29sLT5jaHVua19zaXplID0gY2h1bmtfc2l6ZTsKLQlw
b29sLT5jaGVhcF9kbWEgPSB0cnVlOwogCXBvb2wtPnVuYWxpZ25lZCA9IHVuYWxpZ25lZDsKIAlw
b29sLT5mcmFtZV9sZW4gPSBjaHVua19zaXplIC0gaGVhZHJvb20gLSBYRFBfUEFDS0VUX0hFQURS
T09NOwogCUlOSVRfTElTVF9IRUFEKCZwb29sLT5mcmVlX2xpc3QpOwpAQCAtMTI1LDQ4ICsxMjEs
NiBAQCBzdGF0aWMgdm9pZCB4cF9jaGVja19kbWFfY29udGlndWl0eShzdHJ1Y3QgeHNrX2J1ZmZf
cG9vbCAqcG9vbCkKIAl9CiB9CiAKLXN0YXRpYyBib29sIF9fbWF5YmVfdW51c2VkIHhwX2NoZWNr
X3N3aW90bGJfZG1hKHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sKQotewotI2lmIGRlZmluZWQo
Q09ORklHX1NXSU9UTEIpCi0JcGh5c19hZGRyX3QgcGFkZHI7Ci0JdTMyIGk7Ci0KLQlmb3IgKGkg
PSAwOyBpIDwgcG9vbC0+ZG1hX3BhZ2VzX2NudDsgaSsrKSB7Ci0JCXBhZGRyID0gZG1hX3RvX3Bo
eXMocG9vbC0+ZGV2LCBwb29sLT5kbWFfcGFnZXNbaV0pOwotCQlpZiAoaXNfc3dpb3RsYl9idWZm
ZXIocGFkZHIpKQotCQkJcmV0dXJuIGZhbHNlOwotCX0KLSNlbmRpZgotCXJldHVybiB0cnVlOwot
fQotCi1zdGF0aWMgYm9vbCB4cF9jaGVja19jaGVhcF9kbWEoc3RydWN0IHhza19idWZmX3Bvb2wg
KnBvb2wpCi17Ci0jaWYgZGVmaW5lZChDT05GSUdfSEFTX0RNQSkKLQljb25zdCBzdHJ1Y3QgZG1h
X21hcF9vcHMgKm9wcyA9IGdldF9kbWFfb3BzKHBvb2wtPmRldik7Ci0KLQlpZiAob3BzKSB7Ci0J
CXJldHVybiAhb3BzLT5zeW5jX3NpbmdsZV9mb3JfY3B1ICYmCi0JCQkhb3BzLT5zeW5jX3Npbmds
ZV9mb3JfZGV2aWNlOwotCX0KLQotCWlmICghZG1hX2lzX2RpcmVjdChvcHMpKQotCQlyZXR1cm4g
ZmFsc2U7Ci0KLQlpZiAoIXhwX2NoZWNrX3N3aW90bGJfZG1hKHBvb2wpKQotCQlyZXR1cm4gZmFs
c2U7Ci0KLQlpZiAoIWRldl9pc19kbWFfY29oZXJlbnQocG9vbC0+ZGV2KSkgewotI2lmIGRlZmlu
ZWQoQ09ORklHX0FSQ0hfSEFTX1NZTkNfRE1BX0ZPUl9DUFUpIHx8CQlcCi0JZGVmaW5lZChDT05G
SUdfQVJDSF9IQVNfU1lOQ19ETUFfRk9SX0NQVV9BTEwpIHx8CVwKLQlkZWZpbmVkKENPTkZJR19B
UkNIX0hBU19TWU5DX0RNQV9GT1JfREVWSUNFKQotCQlyZXR1cm4gZmFsc2U7Ci0jZW5kaWYKLQl9
Ci0jZW5kaWYKLQlyZXR1cm4gdHJ1ZTsKLX0KLQogaW50IHhwX2RtYV9tYXAoc3RydWN0IHhza19i
dWZmX3Bvb2wgKnBvb2wsIHN0cnVjdCBkZXZpY2UgKmRldiwKIAkgICAgICAgdW5zaWduZWQgbG9u
ZyBhdHRycywgc3RydWN0IHBhZ2UgKipwYWdlcywgdTMyIG5yX3BhZ2VzKQogewpAQCAtMTk1LDcg
KzE0OSw2IEBAIGludCB4cF9kbWFfbWFwKHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLCBzdHJ1
Y3QgZGV2aWNlICpkZXYsCiAJCXhwX2NoZWNrX2RtYV9jb250aWd1aXR5KHBvb2wpOwogCiAJcG9v
bC0+ZGV2ID0gZGV2OwotCXBvb2wtPmNoZWFwX2RtYSA9IHhwX2NoZWNrX2NoZWFwX2RtYShwb29s
KTsKIAlyZXR1cm4gMDsKIH0KIEVYUE9SVF9TWU1CT0woeHBfZG1hX21hcCk7CkBAIC0yODAsMTEg
KzIzMyw4IEBAIHN0cnVjdCB4ZHBfYnVmZiAqeHBfYWxsb2Moc3RydWN0IHhza19idWZmX3Bvb2wg
KnBvb2wpCiAJeHNrYi0+eGRwLmRhdGEgPSB4c2tiLT54ZHAuZGF0YV9oYXJkX3N0YXJ0ICsgWERQ
X1BBQ0tFVF9IRUFEUk9PTTsKIAl4c2tiLT54ZHAuZGF0YV9tZXRhID0geHNrYi0+eGRwLmRhdGE7
CiAKLQlpZiAoIXBvb2wtPmNoZWFwX2RtYSkgewotCQlkbWFfc3luY19zaW5nbGVfcmFuZ2VfZm9y
X2RldmljZShwb29sLT5kZXYsIHhza2ItPmRtYSwgMCwKLQkJCQkJCSBwb29sLT5mcmFtZV9sZW4s
Ci0JCQkJCQkgRE1BX0JJRElSRUNUSU9OQUwpOwotCX0KKwlkbWFfc3luY19zaW5nbGVfcmFuZ2Vf
Zm9yX2RldmljZShwb29sLT5kZXYsIHhza2ItPmRtYSwgMCwKKwkJCQkJIHBvb2wtPmZyYW1lX2xl
biwgRE1BX0JJRElSRUNUSU9OQUwpOwogCXJldHVybiAmeHNrYi0+eGRwOwogfQogRVhQT1JUX1NZ
TUJPTCh4cF9hbGxvYyk7CkBAIC0zMTksMTggKzI2OSwzIEBAIGRtYV9hZGRyX3QgeHBfcmF3X2dl
dF9kbWEoc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsIHU2NCBhZGRyKQogCQkoYWRkciAmIH5Q
QUdFX01BU0spOwogfQogRVhQT1JUX1NZTUJPTCh4cF9yYXdfZ2V0X2RtYSk7Ci0KLXZvaWQgeHBf
ZG1hX3N5bmNfZm9yX2NwdV9zbG93KHN0cnVjdCB4ZHBfYnVmZl94c2sgKnhza2IpCi17Ci0JZG1h
X3N5bmNfc2luZ2xlX3JhbmdlX2Zvcl9jcHUoeHNrYi0+cG9vbC0+ZGV2LCB4c2tiLT5kbWEsIDAs
Ci0JCQkJICAgICAgeHNrYi0+cG9vbC0+ZnJhbWVfbGVuLCBETUFfQklESVJFQ1RJT05BTCk7Ci19
Ci1FWFBPUlRfU1lNQk9MKHhwX2RtYV9zeW5jX2Zvcl9jcHVfc2xvdyk7Ci0KLXZvaWQgeHBfZG1h
X3N5bmNfZm9yX2RldmljZV9zbG93KHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLCBkbWFfYWRk
cl90IGRtYSwKLQkJCQkgc2l6ZV90IHNpemUpCi17Ci0JZG1hX3N5bmNfc2luZ2xlX3JhbmdlX2Zv
cl9kZXZpY2UocG9vbC0+ZGV2LCBkbWEsIDAsCi0JCQkJCSBzaXplLCBETUFfQklESVJFQ1RJT05B
TCk7Ci19Ci1FWFBPUlRfU1lNQk9MKHhwX2RtYV9zeW5jX2Zvcl9kZXZpY2Vfc2xvdyk7CgpiYXNl
LWNvbW1pdDogNGEyMTE4NWNkYTBmYmI4NjA1ODBlZWViNGYxYTcwYTljZGEzMzJhNAotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21t
dSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
