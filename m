Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD9C433FF
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:10:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52BD52067D
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="AnsHS7DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52BD52067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E1E3DE94;
	Thu, 15 Aug 2019 11:10:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 37AE6E2A
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:10:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
	[209.85.214.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB5838A0
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:10:25 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id gn20so975411plb.2
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=tcd-ie.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=H8YsE1R3VKt11b2vPfO5I4rTXhEDtbvh4/hWRhbqtaM=;
	b=AnsHS7DAOfX5goOT/7evKdCXr6zqdTp/mu4gAJneCWRt/pzazl5g48d/5ntrFMrNNH
	B1/atoeIrOUdUUAbllqXfzF9mKNyr51bhxPeWSW+r32uhrGINmH4vzPLsNXL0Q780o9K
	XBx8jtsyOtkAMHMB3YX2GiZDGWHmdw+iAzpeDKmLOkiAWjx1MSkRphfwLIcwTqmRI9Pi
	5fo7jyW4eBFEcNY07LXxnDW9rcMST7iKX22YEIIJ6EZ+zeEAgLfeCQwzMFG6ItH1xQ+I
	tVOY9pELjohMsN1MUUpj2sZ64VBC8ecPsaXdQtDg8KVNKfJSpeV7SahJHjCJF4TD7uKO
	WldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=H8YsE1R3VKt11b2vPfO5I4rTXhEDtbvh4/hWRhbqtaM=;
	b=ZlR4vT9ghqNXVyn/bEc/uYMAuoB82e4XzDNrnRIerOOnfuxgCSrvd+6k6YW1fceM2k
	vwaI4F+JNjEzg8mJK5VNTYAthvsYhosGi0uvV9gYrlWZsnegkJnvZcpzZKTJHA0qJ0Pk
	owVDpesvkpq0zn8uLQNwCC3F1kQ0j0Lo7+8WkRnXHxKXbiafNbdr76Gtc5pnfZtrvDx2
	BG9Y+52jg2pcOA38pzIUEIllZp3Cts3gVkfHnqwZozU7amDJgPY1YRad/9ectA0ktG3+
	S+zlmn0FXeQZFQoBBm4iGzObLkxqEnPTU0qWxlWYeFXN3Mfsp/p9/JolQhCgnnS9u8wE
	wL6Q==
X-Gm-Message-State: APjAAAWX3M5UL8QdvWL2e++OVvRLbx+Eu6ifoO6WARWm1pKASKjOr6ii
	2v2asq/oQoDk5uX+eFJhbzGWU8+8ur7mEQ==
X-Google-Smtp-Source: APXvYqxQmRTy6JR018gdfwbztNI2AL0CrwPSVdVGydFo6FztH+8DnZHDDGjukvyliCw9mNFUO6BPnA==
X-Received: by 2002:a17:902:4383:: with SMTP id
	j3mr3725604pld.69.1565867425139; 
	Thu, 15 Aug 2019 04:10:25 -0700 (PDT)
Received: from localhost.localdomain
	([2404:e801:200e:19c4:6c3f:b548:3a9c:7867])
	by smtp.googlemail.com with ESMTPSA id
	z13sm1042678pjn.32.2019.08.15.04.10.18
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 15 Aug 2019 04:10:24 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH V5 1/5] iommu/amd: Remove unnecessary locking from AMD iommu
	driver
Date: Thu, 15 Aug 2019 12:09:39 +0100
Message-Id: <20190815110944.3579-2-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190815110944.3579-1-murphyt7@tcd.ie>
References: <20190815110944.3579-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
	linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
	Andy Gross <agross@kernel.org>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
	Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

V2UgY2FuIHJlbW92ZSB0aGUgbXV0ZXggbG9jayBmcm9tIGFtZF9pb21tdV9tYXAgYW5kIGFtZF9p
b21tdV91bm1hcC4KaW9tbXVfbWFwIGRvZXNu4oCZdCBsb2NrIHdoaWxlIG1hcHBpbmcgYW5kIHNv
IG5vIHR3byBjYWxscyBzaG91bGQgdG91Y2gKdGhlIHNhbWUgaW92YSByYW5nZS4gVGhlIEFNRCBk
cml2ZXIgYWxyZWFkeSBoYW5kbGVzIHRoZSBwYWdlIHRhYmxlIHBhZ2UKYWxsb2NhdGlvbnMgd2l0
aG91dCBsb2NrcyBzbyB3ZSBjYW4gc2FmZWx5IHJlbW92ZSB0aGUgbG9ja3MuCgpTaWduZWQtb2Zm
LWJ5OiBUb20gTXVycGh5IDxtdXJwaHl0N0B0Y2QuaWU+Ci0tLQogZHJpdmVycy9pb21tdS9hbWRf
aW9tbXUuYyAgICAgICB8IDEwICstLS0tLS0tLS0KIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11X3R5
cGVzLmggfCAgMSAtCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9hbWRfaW9tbXUuYwppbmRleCAwMDhkYTIxYTI1OTIuLjE5NDhiZTdhYzhmOCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYworKysgYi9kcml2ZXJzL2lvbW11L2FtZF9p
b21tdS5jCkBAIC0yODU4LDcgKzI4NTgsNiBAQCBzdGF0aWMgdm9pZCBwcm90ZWN0aW9uX2RvbWFp
bl9mcmVlKHN0cnVjdCBwcm90ZWN0aW9uX2RvbWFpbiAqZG9tYWluKQogc3RhdGljIGludCBwcm90
ZWN0aW9uX2RvbWFpbl9pbml0KHN0cnVjdCBwcm90ZWN0aW9uX2RvbWFpbiAqZG9tYWluKQogewog
CXNwaW5fbG9ja19pbml0KCZkb21haW4tPmxvY2spOwotCW11dGV4X2luaXQoJmRvbWFpbi0+YXBp
X2xvY2spOwogCWRvbWFpbi0+aWQgPSBkb21haW5faWRfYWxsb2MoKTsKIAlpZiAoIWRvbWFpbi0+
aWQpCiAJCXJldHVybiAtRU5PTUVNOwpAQCAtMzA0NSw5ICszMDQ0LDcgQEAgc3RhdGljIGludCBh
bWRfaW9tbXVfbWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSwgdW5zaWduZWQgbG9uZyBpb3Zh
LAogCWlmIChpb21tdV9wcm90ICYgSU9NTVVfV1JJVEUpCiAJCXByb3QgfD0gSU9NTVVfUFJPVF9J
VzsKIAotCW11dGV4X2xvY2soJmRvbWFpbi0+YXBpX2xvY2spOwogCXJldCA9IGlvbW11X21hcF9w
YWdlKGRvbWFpbiwgaW92YSwgcGFkZHIsIHBhZ2Vfc2l6ZSwgcHJvdCwgR0ZQX0tFUk5FTCk7Ci0J
bXV0ZXhfdW5sb2NrKCZkb21haW4tPmFwaV9sb2NrKTsKIAogCWRvbWFpbl9mbHVzaF9ucF9jYWNo
ZShkb21haW4sIGlvdmEsIHBhZ2Vfc2l6ZSk7CiAKQEAgLTMwNTgsMTYgKzMwNTUsMTEgQEAgc3Rh
dGljIHNpemVfdCBhbWRfaW9tbXVfdW5tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLCB1bnNp
Z25lZCBsb25nIGlvdmEsCiAJCQkgICBzaXplX3QgcGFnZV9zaXplKQogewogCXN0cnVjdCBwcm90
ZWN0aW9uX2RvbWFpbiAqZG9tYWluID0gdG9fcGRvbWFpbihkb20pOwotCXNpemVfdCB1bm1hcF9z
aXplOwogCiAJaWYgKGRvbWFpbi0+bW9kZSA9PSBQQUdFX01PREVfTk9ORSkKIAkJcmV0dXJuIDA7
CiAKLQltdXRleF9sb2NrKCZkb21haW4tPmFwaV9sb2NrKTsKLQl1bm1hcF9zaXplID0gaW9tbXVf
dW5tYXBfcGFnZShkb21haW4sIGlvdmEsIHBhZ2Vfc2l6ZSk7Ci0JbXV0ZXhfdW5sb2NrKCZkb21h
aW4tPmFwaV9sb2NrKTsKLQotCXJldHVybiB1bm1hcF9zaXplOworCXJldHVybiBpb21tdV91bm1h
cF9wYWdlKGRvbWFpbiwgaW92YSwgcGFnZV9zaXplKTsKIH0KIAogc3RhdGljIHBoeXNfYWRkcl90
IGFtZF9pb21tdV9pb3ZhX3RvX3BoeXMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLApkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfdHlwZXMuaCBiL2RyaXZlcnMvaW9tbXUvYW1k
X2lvbW11X3R5cGVzLmgKaW5kZXggOWFjMjI5ZTkyYjA3Li5iNzY0ZTFhNzNkY2YgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X3R5cGVzLmgKKysrIGIvZHJpdmVycy9pb21tdS9h
bWRfaW9tbXVfdHlwZXMuaApAQCAtNDY4LDcgKzQ2OCw2IEBAIHN0cnVjdCBwcm90ZWN0aW9uX2Rv
bWFpbiB7CiAJc3RydWN0IGlvbW11X2RvbWFpbiBkb21haW47IC8qIGdlbmVyaWMgZG9tYWluIGhh
bmRsZSB1c2VkIGJ5CiAJCQkJICAgICAgIGlvbW11IGNvcmUgY29kZSAqLwogCXNwaW5sb2NrX3Qg
bG9jazsJLyogbW9zdGx5IHVzZWQgdG8gbG9jayB0aGUgcGFnZSB0YWJsZSovCi0Jc3RydWN0IG11
dGV4IGFwaV9sb2NrOwkvKiBwcm90ZWN0IHBhZ2UgdGFibGVzIGluIHRoZSBpb21tdS1hcGkgcGF0
aCAqLwogCXUxNiBpZDsJCQkvKiB0aGUgZG9tYWluIGlkIHdyaXR0ZW4gdG8gdGhlIGRldmljZSB0
YWJsZSAqLwogCWludCBtb2RlOwkJLyogcGFnaW5nIG1vZGUgKDAtNiBsZXZlbHMpICovCiAJdTY0
ICpwdF9yb290OwkJLyogcGFnZSB0YWJsZSByb290IHBvaW50ZXIgKi8KLS0gCjIuMjAuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
