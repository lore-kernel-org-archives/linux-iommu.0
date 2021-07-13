Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8177C11F69
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:24:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E556117A
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E556117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8416D404E4;
	Tue, 13 Jul 2021 17:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ADBPK6OBiNbw; Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 65944401EA;
	Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FCB7C000E;
	Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4BDF2C000E
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E22A404E4
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zA1ii3sS27QH for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 17:24:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85832404F5
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:54 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id v7so22231617pgl.2
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 10:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hs2JqvHLc2VhwLkCLKEeX1pzwKqE7ns6gX3Zd+1Br1s=;
 b=QAav+USR8km1W3fwSHLhKJS1on6grs3Opl96GLHDUXTzUdbAL5VYIkzoLyBrlANCbK
 h7tBqzU14vWuEXJHP7LavFv46VEE9aRy2w311L4AqiEr4ztmPKwZzTPgC/vKTwAZRGKF
 8xn5xqsdT8QRQbhwm/rAziNhlFvLZDompwboVOpGY7UaqSk5HfvGfnzzUNm8ol5Ikg4q
 In8yeOl0RGiTRrCnAM2/36GUzvCB4jpNSWwyywTmTZW1ZGpe0wUeaU6RjGWp9iTt5O4q
 XgskL3sxT23Ri8ryCneep2SfQAeYns4MP9AgQ1b7Lc++vG7g422y5i/EtHDzO3ZqDDhW
 gTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hs2JqvHLc2VhwLkCLKEeX1pzwKqE7ns6gX3Zd+1Br1s=;
 b=N+erFefja/on9UPDT3RMGGXi/bMibyCuRZPrRFvpV2RcHnQF9qjamFJ7ErMDNzgwVQ
 7hUuHGUiNJVnUYJ1h+VSKKFCuFL8uFbt9LJNpizhBluGxebTBW172Zpx+EL4NfZlQkhQ
 GnQq/e64NmVhaOauNjN+5NcvHVmHhUAeyHw6WefGTBgLr4JBdqbzZtVzaCz9xSrrTDBZ
 9RwO8J7layFaq7fiKGMC+gANjwGSnukldh/698ia+CkVC6iZB0DgfyACDj68qYAnHsOu
 g1rqcI/u6xM+qR053imKMtLdaJqzSJJSbS6f7ra/YSqlNyu7DXPeu3vR9bw/JrnFdD1H
 tyOg==
X-Gm-Message-State: AOAM531fl4SfThWaGuCcAGx4gGQW9zfnVBWu9dehc0A4iNO2gLOUjpIS
 uYZTP/YXQLgP7+OAsFx4hJ8=
X-Google-Smtp-Source: ABdhPJylQ8Ys/YO1uvPeeqE89vjPI5d2swuMnSg4o+kFUEMpky9zhlRmquI4dqRTAZYSjKKKJtMoUg==
X-Received: by 2002:a62:3045:0:b029:32b:880f:c03a with SMTP id
 w66-20020a6230450000b029032b880fc03amr5756377pfw.22.1626197093839; 
 Tue, 13 Jul 2021 10:24:53 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 10:24:53 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 4/7] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date: Tue, 13 Jul 2021 02:41:48 -0700
Message-Id: <20210713094151.652597-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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
anVuQHZtd2FyZS5jb20+CkNjOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPgpD
YzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KQ2M6IGlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgpBY2tl
ZC1ieTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4KU2lnbmVkLW9mZi1ieTogTmFkYXYg
QW1pdCA8bmFtaXRAdm13YXJlLmNvbT4KLS0tCiBpbmNsdWRlL2xpbnV4L2lvbW11LmggfCAzNCAr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMjYgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2lv
bW11LmggYi9pbmNsdWRlL2xpbnV4L2lvbW11LmgKaW5kZXggZTU1NDg3MWRiNDZmLi45NzlhNWNl
ZWVhNTUgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvaW9tbXUuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2lvbW11LmgKQEAgLTQ5Nyw2ICs0OTcsMjggQEAgc3RhdGljIGlubGluZSB2b2lkIGlvbW11
X2lvdGxiX3N5bmMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAogCWlvbW11X2lvdGxiX2dh
dGhlcl9pbml0KGlvdGxiX2dhdGhlcik7CiB9CiAKKy8qKgorICogaW9tbXVfaW90bGJfZ2F0aGVy
X2lzX2Rpc2pvaW50IC0gQ2hlY2tzIHdoZXRoZXIgYSBuZXcgcmFuZ2UgaXMgZGlzam9pbnQKKyAq
CisgKiBAZ2F0aGVyOiBUTEIgZ2F0aGVyIGRhdGEKKyAqIEBpb3ZhOiBzdGFydCBvZiBwYWdlIHRv
IGludmFsaWRhdGUKKyAqIEBzaXplOiBzaXplIG9mIHBhZ2UgdG8gaW52YWxpZGF0ZQorICoKKyAq
IEhlbHBlciBmb3IgSU9NTVUgZHJpdmVycyB0byBjaGVjayB3aGV0aGVyIGEgbmV3IHJhbmdlIGFu
ZCB0aGUgZ2F0aGVyZWQgcmFuZ2UKKyAqIGFyZSBkaXNqb2ludC4gRm9yIG1hbnkgSU9NTVVzLCBm
bHVzaGluZyB0aGUgSU9NTVUgaW4gdGhpcyBjYXNlIGlzIGJldHRlcgorICogdGhhbiBtZXJnaW5n
IHRoZSB0d28sIHdoaWNoIG1pZ2h0IGxlYWQgdG8gdW5uZWNlc3NhcnkgaW52YWxpZGF0aW9ucy4K
KyAqLworc3RhdGljIGlubGluZQorYm9vbCBpb21tdV9pb3RsYl9nYXRoZXJfaXNfZGlzam9pbnQo
c3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0aGVyLAorCQkJCSAgICB1bnNpZ25lZCBsb25n
IGlvdmEsIHNpemVfdCBzaXplKQoreworCXVuc2lnbmVkIGxvbmcgc3RhcnQgPSBpb3ZhLCBlbmQg
PSBzdGFydCArIHNpemUgLSAxOworCisJcmV0dXJuIGdhdGhlci0+ZW5kICE9IDAgJiYKKwkJKGVu
ZCArIDEgPCBnYXRoZXItPnN0YXJ0IHx8IHN0YXJ0ID4gZ2F0aGVyLT5lbmQgKyAxKTsKK30KKwor
CiAvKioKICAqIGlvbW11X2lvdGxiX2dhdGhlcl9hZGRfcmFuZ2UgLSBHYXRoZXIgZm9yIGFkZHJl
c3MtYmFzZWQgVExCIGludmFsaWRhdGlvbgogICogQGdhdGhlcjogVExCIGdhdGhlciBkYXRhCkBA
IC01MzMsMjAgKzU1NSwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW9tbXVfaW90bGJfZ2F0aGVy
X2FkZF9wYWdlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKIAkJCQkJICAgICAgIHN0cnVj
dCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhlciwKIAkJCQkJICAgICAgIHVuc2lnbmVkIGxvbmcg
aW92YSwgc2l6ZV90IHNpemUpCiB7Ci0JdW5zaWduZWQgbG9uZyBzdGFydCA9IGlvdmEsIGVuZCA9
IHN0YXJ0ICsgc2l6ZSAtIDE7Ci0KIAkvKgogCSAqIElmIHRoZSBuZXcgcGFnZSBpcyBkaXNqb2lu
dCBmcm9tIHRoZSBjdXJyZW50IHJhbmdlIG9yIGlzIG1hcHBlZCBhdAogCSAqIGEgZGlmZmVyZW50
IGdyYW51bGFyaXR5LCB0aGVuIHN5bmMgdGhlIFRMQiBzbyB0aGF0IHRoZSBnYXRoZXIKIAkgKiBz
dHJ1Y3R1cmUgY2FuIGJlIHJld3JpdHRlbi4KIAkgKi8KLQlpZiAoZ2F0aGVyLT5wZ3NpemUgIT0g
c2l6ZSB8fAotCSAgICBlbmQgKyAxIDwgZ2F0aGVyLT5zdGFydCB8fCBzdGFydCA+IGdhdGhlci0+
ZW5kICsgMSkgewotCQlpZiAoZ2F0aGVyLT5wZ3NpemUpCi0JCQlpb21tdV9pb3RsYl9zeW5jKGRv
bWFpbiwgZ2F0aGVyKTsKLQkJZ2F0aGVyLT5wZ3NpemUgPSBzaXplOwotCX0KKwlpZiAoKGdhdGhl
ci0+cGdzaXplICYmIGdhdGhlci0+cGdzaXplICE9IHNpemUpIHx8CisJICAgIGlvbW11X2lvdGxi
X2dhdGhlcl9pc19kaXNqb2ludChnYXRoZXIsIGlvdmEsIHNpemUpKQorCQlpb21tdV9pb3RsYl9z
eW5jKGRvbWFpbiwgZ2F0aGVyKTsKIAorCWdhdGhlci0+cGdzaXplID0gc2l6ZTsKIAlpb21tdV9p
b3RsYl9nYXRoZXJfYWRkX3JhbmdlKGdhdGhlciwgaW92YSwgc2l6ZSk7CiB9CiAKLS0gCjIuMjUu
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
