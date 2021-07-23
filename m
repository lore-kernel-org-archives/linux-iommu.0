Return-Path: <SRS0=yZZ9=MP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C567AC432BE
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F37460F21
	for <iommu@archiver.kernel.org>; Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F37460F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50807405A6;
	Fri, 23 Jul 2021 17:02:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMHOeuo8-KyK; Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 45C6740588;
	Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14AABC001A;
	Fri, 23 Jul 2021 17:02:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9F95C0025
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A6FB840682
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 645IuWbsk8cM for <iommu@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 17:02:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1CAB40658
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 17:02:04 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 u9-20020a17090a1f09b029017554809f35so9773231pja.5
 for <iommu@lists.linux-foundation.org>; Fri, 23 Jul 2021 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BWFBKBoQSQylTkHjpb3SiDuKKZ/wgdaS3agUZ4UYN3M=;
 b=K735bBzttTFRvVBbD71RwbA5lvWBdsSYXqH3+GAld03dGl7BsTzF1EHQGduM2yjNKG
 9MwSA7EXUTeak48klV0Bum0TFR4omD9TiZJEd8rF1Dkl4mIi0zjXt5YxgHihNZlAVKrD
 +sVavs3d+pvzDhSdcEFdsmExTDetgVrXSJHvR1KJLtoakOx5pbUoobNbDhrnxtZz8wOF
 r/xEiT6a2yn0zfcrklbiMU2DUXMFaoAc/fty82DaApULtwoZvQfygUtmgJxWhJtyjBOa
 h3C8Gx0OOcciSpjtk64aq++Isk6yRgExMMJn+4B31oUJQWR+R1iX+h3dbTgEA7RyQr+h
 VdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWFBKBoQSQylTkHjpb3SiDuKKZ/wgdaS3agUZ4UYN3M=;
 b=uVUZoLY1/e46k0p6ESllwFWIOS6Sis56TnxoFmbDXs8OL672nwAw8mPYEeWEDectsI
 p5ct0r7vF7wOcfk0pu5qrta4EOvmvaat4xIj49zfMexPt+HZ5csJzH6kXslYcnrRLdlJ
 8Sviul6N8DGFLuMejWf++aK6pMWwVE41Srei18r72FKF0Ik9x4f+XC0qiSNGlwXYN7VJ
 hrhUggkKx6a5LBsm1dPv7c/bYcGLXV3cAEjvN8SlIWM97avZNJfTloR15qGlBd43KVly
 exgIOmFdKiubb1jIP2XJVxgBeRw4qqWoRQ72NGKbzzsWX3A3btaQhuSTf94nKuEjf7G+
 JY9A==
X-Gm-Message-State: AOAM531DJlLfMQl2w92ebL1vZVc++TJHDnPQHc/QaMlk6NFlas7psJ0q
 D3JAPLrLiC++XcAJLmMd06Q=
X-Google-Smtp-Source: ABdhPJyFYe7wB6XmVZKOiIJqtB5OibW35hOyo0W1fRRSsMwInjmBp8JR7cfPt0QeyErHlmlimA9TLA==
X-Received: by 2002:a17:903:2309:b029:12a:965b:333 with SMTP id
 d9-20020a1709032309b029012a965b0333mr4665525plh.31.1627059724164; 
 Fri, 23 Jul 2021 10:02:04 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id d15sm33479004pfl.82.2021.07.23.10.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 10:02:03 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v6 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date: Fri, 23 Jul 2021 02:32:06 -0700
Message-Id: <20210723093209.714328-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723093209.714328-1-namit@vmware.com>
References: <20210723093209.714328-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Robin Murphy <robin.murphy@arm.com>
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

RnJvbTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4KClJlZmFjdG9yIGlvbW11X2lvdGxi
X2dhdGhlcl9hZGRfcGFnZSgpIGFuZCBmYWN0b3Igb3V0IHRoZSBsb2dpYyB0aGF0CmRldGVjdHMg
d2hldGhlciBJT1RMQiBnYXRoZXIgcmFuZ2UgYW5kIGEgbmV3IHJhbmdlIGFyZSBkaXNqb2ludC4g
VG8gYmUKdXNlZCBieSB0aGUgbmV4dCBwYXRjaCB0aGF0IGltcGxlbWVudHMgZGlmZmVyZW50IGdh
dGhlcmluZyBsb2dpYyBmb3IKQU1ELgoKTm90ZSB0aGF0IHVwZGF0aW5nIGdhdGhlci0+cGdzaXpl
IHVuY29uZGl0aW9uYWxseSBkb2VzIG5vdCBhZmZlY3QKY29ycmVjdG5lc3MgYXMgdGhlIGZ1bmN0
aW9uIGhhZCAoYW5kIGhhcykgYW4gaW52YXJpYW50LCBpbiB3aGljaApnYXRoZXItPnBnc2l6ZSBh
bHdheXMgcmVwcmVzZW50cyB0aGUgZmx1c2hpbmcgZ3JhbnVsYXJpdHkgb2YgaXRzIHJhbmdlLgpB
cmd1YWJseSwg4oCcc2l6ZSIgc2hvdWxkIG5ldmVyIGJlIHplcm8sIGJ1dCBsZXRzIGFzc3VtZSBm
b3IgdGhlIG1hdHRlciBvZgpkaXNjdXNzaW9uIHRoYXQgaXQgbWlnaHQuCgpJZiAic2l6ZSIgZXF1
YWxzIHRvICJnYXRoZXItPnBnc2l6ZSIsIHRoZW4gdGhlIGFzc2lnbm1lbnQgaW4gcXVlc3Rpb24K
aGFzIG5vIGltcGFjdC4KCk90aGVyd2lzZSwgaWYgInNpemUiIGlzIG5vbi16ZXJvLCB0aGVuIGlv
bW11X2lvdGxiX3N5bmMoKSB3b3VsZAppbml0aWFsaXplIHRoZSBzaXplIGFuZCByYW5nZSAoc2Vl
IGlvbW11X2lvdGxiX2dhdGhlcl9pbml0KCkpLCBhbmQgdGhlCmludmFyaWFudCBpcyBrZXB0LgoK
T3RoZXJ3aXNlLCAic2l6ZSIgaXMgemVybywgYW5kICJnYXRoZXIiIGFscmVhZHkgaG9sZHMgYSBy
YW5nZSwgc28KZ2F0aGVyLT5wZ3NpemUgaXMgbm9uLXplcm8gYW5kIChnYXRoZXItPnBnc2l6ZSAm
JiBnYXRoZXItPnBnc2l6ZSAhPQpzaXplKSBpcyB0cnVlLiBUaGVyZWZvcmUsIGFnYWluLCBpb21t
dV9pb3RsYl9zeW5jKCkgd291bGQgYmUgY2FsbGVkIGFuZAppbml0aWFsaXplIHRoZSBzaXplLgoK
Q2M6IEpvZXJnIFJvZWRlbCA8am9yb0A4Ynl0ZXMub3JnPgpDYzogSmlhanVuIENhbyA8Y2Fvamlh
anVuQHZtd2FyZS5jb20+CkNjOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPgpD
YzogaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKQ2M6IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+ClJldmlld2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0u
Y29tPgpBY2tlZC1ieTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1i
eTogTmFkYXYgQW1pdCA8bmFtaXRAdm13YXJlLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L2lvbW11
LmggfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2lvbW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKaW5kZXggZTU1NDg3MWRiNDZm
Li45NzlhNWNlZWVhNTUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAorKysgYi9p
bmNsdWRlL2xpbnV4L2lvbW11LmgKQEAgLTQ5Nyw2ICs0OTcsMjggQEAgc3RhdGljIGlubGluZSB2
b2lkIGlvbW11X2lvdGxiX3N5bmMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAogCWlvbW11
X2lvdGxiX2dhdGhlcl9pbml0KGlvdGxiX2dhdGhlcik7CiB9CiAKKy8qKgorICogaW9tbXVfaW90
bGJfZ2F0aGVyX2lzX2Rpc2pvaW50IC0gQ2hlY2tzIHdoZXRoZXIgYSBuZXcgcmFuZ2UgaXMgZGlz
am9pbnQKKyAqCisgKiBAZ2F0aGVyOiBUTEIgZ2F0aGVyIGRhdGEKKyAqIEBpb3ZhOiBzdGFydCBv
ZiBwYWdlIHRvIGludmFsaWRhdGUKKyAqIEBzaXplOiBzaXplIG9mIHBhZ2UgdG8gaW52YWxpZGF0
ZQorICoKKyAqIEhlbHBlciBmb3IgSU9NTVUgZHJpdmVycyB0byBjaGVjayB3aGV0aGVyIGEgbmV3
IHJhbmdlIGFuZCB0aGUgZ2F0aGVyZWQgcmFuZ2UKKyAqIGFyZSBkaXNqb2ludC4gRm9yIG1hbnkg
SU9NTVVzLCBmbHVzaGluZyB0aGUgSU9NTVUgaW4gdGhpcyBjYXNlIGlzIGJldHRlcgorICogdGhh
biBtZXJnaW5nIHRoZSB0d28sIHdoaWNoIG1pZ2h0IGxlYWQgdG8gdW5uZWNlc3NhcnkgaW52YWxp
ZGF0aW9ucy4KKyAqLworc3RhdGljIGlubGluZQorYm9vbCBpb21tdV9pb3RsYl9nYXRoZXJfaXNf
ZGlzam9pbnQoc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0aGVyLAorCQkJCSAgICB1bnNp
Z25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplKQoreworCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBp
b3ZhLCBlbmQgPSBzdGFydCArIHNpemUgLSAxOworCisJcmV0dXJuIGdhdGhlci0+ZW5kICE9IDAg
JiYKKwkJKGVuZCArIDEgPCBnYXRoZXItPnN0YXJ0IHx8IHN0YXJ0ID4gZ2F0aGVyLT5lbmQgKyAx
KTsKK30KKworCiAvKioKICAqIGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcmFuZ2UgLSBHYXRoZXIg
Zm9yIGFkZHJlc3MtYmFzZWQgVExCIGludmFsaWRhdGlvbgogICogQGdhdGhlcjogVExCIGdhdGhl
ciBkYXRhCkBAIC01MzMsMjAgKzU1NSwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfaW90
bGJfZ2F0aGVyX2FkZF9wYWdlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKIAkJCQkJICAg
ICAgIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhlciwKIAkJCQkJICAgICAgIHVuc2ln
bmVkIGxvbmcgaW92YSwgc2l6ZV90IHNpemUpCiB7Ci0JdW5zaWduZWQgbG9uZyBzdGFydCA9IGlv
dmEsIGVuZCA9IHN0YXJ0ICsgc2l6ZSAtIDE7Ci0KIAkvKgogCSAqIElmIHRoZSBuZXcgcGFnZSBp
cyBkaXNqb2ludCBmcm9tIHRoZSBjdXJyZW50IHJhbmdlIG9yIGlzIG1hcHBlZCBhdAogCSAqIGEg
ZGlmZmVyZW50IGdyYW51bGFyaXR5LCB0aGVuIHN5bmMgdGhlIFRMQiBzbyB0aGF0IHRoZSBnYXRo
ZXIKIAkgKiBzdHJ1Y3R1cmUgY2FuIGJlIHJld3JpdHRlbi4KIAkgKi8KLQlpZiAoZ2F0aGVyLT5w
Z3NpemUgIT0gc2l6ZSB8fAotCSAgICBlbmQgKyAxIDwgZ2F0aGVyLT5zdGFydCB8fCBzdGFydCA+
IGdhdGhlci0+ZW5kICsgMSkgewotCQlpZiAoZ2F0aGVyLT5wZ3NpemUpCi0JCQlpb21tdV9pb3Rs
Yl9zeW5jKGRvbWFpbiwgZ2F0aGVyKTsKLQkJZ2F0aGVyLT5wZ3NpemUgPSBzaXplOwotCX0KKwlp
ZiAoKGdhdGhlci0+cGdzaXplICYmIGdhdGhlci0+cGdzaXplICE9IHNpemUpIHx8CisJICAgIGlv
bW11X2lvdGxiX2dhdGhlcl9pc19kaXNqb2ludChnYXRoZXIsIGlvdmEsIHNpemUpKQorCQlpb21t
dV9pb3RsYl9zeW5jKGRvbWFpbiwgZ2F0aGVyKTsKIAorCWdhdGhlci0+cGdzaXplID0gc2l6ZTsK
IAlpb21tdV9pb3RsYl9nYXRoZXJfYWRkX3JhbmdlKGdhdGhlciwgaW92YSwgc2l6ZSk7CiB9CiAK
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
