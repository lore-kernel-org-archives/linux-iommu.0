Return-Path: <SRS0=FiUI=EY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961AAC5519F
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 14:31:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD98246B5
	for <iommu@archiver.kernel.org>; Wed, 18 Nov 2020 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QZFQ9NMj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD98246B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1F99986771;
	Wed, 18 Nov 2020 14:31:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-sEn+8TtRTe; Wed, 18 Nov 2020 14:31:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9826985C3B;
	Wed, 18 Nov 2020 14:31:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7857EC0800;
	Wed, 18 Nov 2020 14:31:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9D2FC07FF
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 14:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A8618859BA
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 14:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1Lr6RtWys2w for <iommu@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 14:30:59 +0000 (UTC)
X-Greylist: delayed 00:05:02 by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A66B3858F5
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 14:30:58 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id 23so4256102wmg.1
 for <iommu@lists.linux-foundation.org>; Wed, 18 Nov 2020 06:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M3TahTJ7BjaCKL6cCJzT4YU2/8yPvTg3NC9HtjjwB6E=;
 b=QZFQ9NMjk1u7iGKZodsPpAnv4GlhVxHP8yp3CWAfrgMAFbKO6nrCYfFkg+HMWylVQy
 4xwD0VvkN7cxe+o3TpUlsr0F0spio0q+/q9/CytGbvrKuOW6e2SVvNhL1cG+BP9zGKNv
 BIj2bn9jiVUoV6HSPLoZZs/rv8hIxQB7+6vjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M3TahTJ7BjaCKL6cCJzT4YU2/8yPvTg3NC9HtjjwB6E=;
 b=IRleq8lt5a5ff4Rgsi2GF8azSpaeEeTMfpD1RcPUkyvvebp2etJ018bjduh/yga8DX
 HKIZ9untusjmglCmtTGjogXP2XZA4eGr3M/HVQNkKzp0XRdM2tE8mkRRWuDMLJSv+UUp
 QG8dLMoxWNueLuswzw/qX0Bjvn2LbAs81kfqB2p12KUx9Eh/6U/9eQc49LtjIeMK4zHn
 j0WU1RTPruj7BGT1lzMriWnctxXG3Pfa3kZf7fHvxfQVLJvNICWvLn73l9cZ5FD+noDF
 05fTCnifyjmcGjhPPOT4UH66nYJRgwdhGsIMTF2qyDD57Xt+P1noWZZSWg1oXvpJFGZO
 kNKw==
X-Gm-Message-State: AOAM533VKajB51paYkTsKCULalciW91kZbK/NX1xKtR2yhEfJrePTc8Z
 QIDkmyQj8UrmJTVIQXcxFd7w1w2XW3cFgMX4dko=
X-Google-Smtp-Source: ABdhPJwIJfDIcqzIaOjyyYLoJOkj2Cs5fEWxJOZTYwXsOeX7KufPglMZqaylZEbPYySTYkeFoUw2eg==
X-Received: by 2002:a1c:7f90:: with SMTP id a138mr292131wmd.61.1605709555144; 
 Wed, 18 Nov 2020 06:25:55 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
 by smtp.gmail.com with ESMTPSA id o4sm491028wmh.33.2020.11.18.06.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 06:25:54 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: Christoph Hellwig <hch@lst.de>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH] WIP! media: uvcvideo: Use dma_alloc_noncontiguos API
Date: Wed, 18 Nov 2020 15:25:46 +0100
Message-Id: <20201118142546.170621-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20200930160917.1234225-9-hch@lst.de>
References: <20200930160917.1234225-9-hch@lst.de>
MIME-Version: 1.0
Cc: Ricardo Ribalda <ribalda@chromium.org>
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

T24gYXJjaGl0ZWN0dXJlcyB3aGVyZSB0aGUgaXMgbm8gY29oZXJlbnQgY2FjaGluZyBzdWNoIGFz
IEFSTSB1c2UgdGhlCmRtYV9hbGxvY19ub25jb250aWd1b3MgQVBJIGFuZCBoYW5kbGUgbWFudWFs
bHkgdGhlIGNhY2hlIGZsdXNoaW5nIHVzaW5nCmRtYV9zeW5jX3NpbmdsZSgpLgoKV2l0aCB0aGlz
IHBhdGNoIG9uIHRoZSBhZmZlY3RlZCBhcmNoaXRlY3R1cmVzIHdlIGNhbiBtZWFzdXJlIHVwIHRv
IDIweApwZXJmb3JtYW5jZSBpbXByb3ZlbWVudCBpbiB1dmNfdmlkZW9fY29weV9kYXRhX3dvcmso
KS4KClNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gUmliYWxkYSA8cmliYWxkYUBjaHJvbWl1bS5vcmc+
Ci0tLQoKVGhpcyBwYXRjaCBkZXBlbmRzIG9uIGRtYV9hbGxvY19jb250aWd1b3VzIEFQSe+/vDEz
MTUzNTFkaWZmbWJveHNlcmllcwoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3Bh
dGNoLzEzMTUzNTEvIzE1MzUxODIKCiBkcml2ZXJzL21lZGlhL3VzYi91dmMvdXZjX3ZpZGVvLmMg
fCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tCiBkcml2ZXJzL21lZGlhL3VzYi91
dmMvdXZjdmlkZW8uaCAgfCAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNf
dmlkZW8uYyBiL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfdmlkZW8uYwppbmRleCBmZjYyNGJi
ODU3ZDMuLmVmMWIwMjliODU3NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tZWRpYS91c2IvdXZjL3V2
Y192aWRlby5jCisrKyBiL2RyaXZlcnMvbWVkaWEvdXNiL3V2Yy91dmNfdmlkZW8uYwpAQCAtMTY0
MSw2ICsxNjQxLDExIEBAIHN0YXRpYyB2b2lkIHV2Y192aWRlb19lbmNvZGVfYnVsayhzdHJ1Y3Qg
dXZjX3VyYiAqdXZjX3VyYiwKIAl1cmItPnRyYW5zZmVyX2J1ZmZlcl9sZW5ndGggPSBzdHJlYW0t
PnVyYl9zaXplIC0gbGVuOwogfQogCitzdGF0aWMgaW5saW5lIHN0cnVjdCBkZXZpY2UgKnN0cmVh
bV90b19kbWFkZXYoc3RydWN0IHV2Y19zdHJlYW1pbmcgKnN0cmVhbSkKK3sKKwlyZXR1cm4gc3Ry
ZWFtLT5kZXYtPnVkZXYtPmJ1cy0+Y29udHJvbGxlci0+cGFyZW50OworfQorCiBzdGF0aWMgdm9p
ZCB1dmNfdmlkZW9fY29tcGxldGUoc3RydWN0IHVyYiAqdXJiKQogewogCXN0cnVjdCB1dmNfdXJi
ICp1dmNfdXJiID0gdXJiLT5jb250ZXh0OwpAQCAtMTY5Myw2ICsxNjk4LDExIEBAIHN0YXRpYyB2
b2lkIHV2Y192aWRlb19jb21wbGV0ZShzdHJ1Y3QgdXJiICp1cmIpCiAJICogUHJvY2VzcyB0aGUg
VVJCIGhlYWRlcnMsIGFuZCBvcHRpb25hbGx5IHF1ZXVlIGV4cGVuc2l2ZSBtZW1jcHkgdGFza3MK
IAkgKiB0byBiZSBkZWZlcnJlZCB0byBhIHdvcmsgcXVldWUuCiAJICovCisJaWYgKHV2Y191cmIt
PnBhZ2VzKQorCQlkbWFfc3luY19zaW5nbGVfZm9yX2NwdShzdHJlYW1fdG9fZG1hZGV2KHN0cmVh
bSksCisJCQkJCXVyYi0+dHJhbnNmZXJfZG1hLAorCQkJCQl1cmItPnRyYW5zZmVyX2J1ZmZlcl9s
ZW5ndGgsCisJCQkJCURNQV9GUk9NX0RFVklDRSk7CiAJc3RyZWFtLT5kZWNvZGUodXZjX3VyYiwg
YnVmLCBidWZfbWV0YSk7CiAKIAkvKiBJZiBubyBhc3luYyB3b3JrIGlzIG5lZWRlZCwgcmVzdWJt
aXQgdGhlIFVSQiBpbW1lZGlhdGVseS4gKi8KQEAgLTE3MjMsOCArMTczMywxNSBAQCBzdGF0aWMg
dm9pZCB1dmNfZnJlZV91cmJfYnVmZmVycyhzdHJ1Y3QgdXZjX3N0cmVhbWluZyAqc3RyZWFtKQog
CQkJY29udGludWU7CiAKICNpZm5kZWYgQ09ORklHX0RNQV9OT05DT0hFUkVOVAotCQl1c2JfZnJl
ZV9jb2hlcmVudChzdHJlYW0tPmRldi0+dWRldiwgc3RyZWFtLT51cmJfc2l6ZSwKLQkJCQkgIHV2
Y191cmItPmJ1ZmZlciwgdXZjX3VyYi0+ZG1hKTsKKwkJaWYgKHV2Y191cmItPnBhZ2VzKSB7CisJ
CQl2dW5tYXAodXZjX3VyYi0+YnVmZmVyKTsKKwkJCWRtYV9mcmVlX25vbmNvbnRpZ3VvdXMoc3Ry
ZWFtX3RvX2RtYWRldihzdHJlYW0pLAorCQkJCQkgICAgICAgc3RyZWFtLT51cmJfc2l6ZSwKKwkJ
CQkJICAgICAgIHV2Y191cmItPnBhZ2VzLCB1dmNfdXJiLT5kbWEpOworCQl9IGVsc2UgeworCQkJ
dXNiX2ZyZWVfY29oZXJlbnQoc3RyZWFtLT5kZXYtPnVkZXYsIHN0cmVhbS0+dXJiX3NpemUsCisJ
CQkJCSAgdXZjX3VyYi0+YnVmZmVyLCB1dmNfdXJiLT5kbWEpOworCQl9CiAjZWxzZQogCQlrZnJl
ZSh1dmNfdXJiLT5idWZmZXIpOwogI2VuZGlmCkBAIC0xNzM0LDYgKzE3NTEsNDIgQEAgc3RhdGlj
IHZvaWQgdXZjX2ZyZWVfdXJiX2J1ZmZlcnMoc3RydWN0IHV2Y19zdHJlYW1pbmcgKnN0cmVhbSkK
IAlzdHJlYW0tPnVyYl9zaXplID0gMDsKIH0KIAorI2lmbmRlZiBDT05GSUdfRE1BX05PTkNPSEVS
RU5UCitzdGF0aWMgYm9vbCB1dmNfYWxsb2NfdXJiX2J1ZmZlcihzdHJ1Y3QgdXZjX3N0cmVhbWlu
ZyAqc3RyZWFtLCBzdHJ1Y3QgdXZjX3VyYiAqdXZjX3VyYiwKKwkJCQkgZ2ZwX3QgZ2ZwX2ZsYWdz
KQoreworCXN0cnVjdCBkZXZpY2UgKmRtYV9kZXYgPSBkbWFfZGV2ID0gc3RyZWFtX3RvX2RtYWRl
dihzdHJlYW0pOworCisJaWYgKCFkbWFfY2FuX2FsbG9jX25vbmNvbnRpZ3VvdXMoZG1hX2Rldikp
IHsKKwkJdXZjX3VyYi0+YnVmZmVyID0gdXNiX2FsbG9jX2NvaGVyZW50KHN0cmVhbS0+ZGV2LT51
ZGV2LCBzdHJlYW0tPnVyYl9zaXplLAorCQkJCQkJICAgICBnZnBfZmxhZ3MgfCBfX0dGUF9OT1dB
Uk4sICZ1dmNfdXJiLT5kbWEpOworCQlyZXR1cm4gdXZjX3VyYi0+YnVmZmVyICE9IE5VTEw7CisJ
fQorCisJdXZjX3VyYi0+cGFnZXMgPSBkbWFfYWxsb2Nfbm9uY29udGlndW91cyhkbWFfZGV2LCBz
dHJlYW0tPnVyYl9zaXplLAorCQkJCQkJICZ1dmNfdXJiLT5kbWEsIGdmcF9mbGFncyB8IF9fR0ZQ
X05PV0FSTiwgMCk7CisJaWYgKCF1dmNfdXJiLT5wYWdlcykKKwkJcmV0dXJuIGZhbHNlOworCisJ
dXZjX3VyYi0+YnVmZmVyID0gdm1hcCh1dmNfdXJiLT5wYWdlcywgUEFHRV9BTElHTihzdHJlYW0t
PnVyYl9zaXplKSA+PiBQQUdFX1NISUZULAorCQkJICAgICAgIFZNX0RNQV9DT0hFUkVOVCwgUEFH
RV9LRVJORUwpOworCWlmICghdXZjX3VyYi0+YnVmZmVyKSB7CisJCWRtYV9mcmVlX25vbmNvbnRp
Z3VvdXMoZG1hX2Rldiwgc3RyZWFtLT51cmJfc2l6ZSwgdXZjX3VyYi0+cGFnZXMsIHV2Y191cmIt
PmRtYSk7CisJCXJldHVybiBmYWxzZTsKKwl9CisKKwlyZXR1cm4gdHJ1ZTsKK30KKyNlbHNlCitz
dGF0aWMgYm9vbCB1dmNfYWxsb2NfdXJiX2J1ZmZlcihzdHJ1Y3QgdXZjX3N0cmVhbWluZyAqc3Ry
ZWFtLCBzdHJ1Y3QgdXZjX3VyYiAqdXZjX3VyYiwKKwkJCQkgZ2ZwX3QgZ2ZwX2ZsYWdzKQorewor
CXV2Y191cmItPmJ1ZmZlciA9IGttYWxsb2Moc3RyZWFtLT51cmJfc2l6ZSwgZ2ZwX2ZsYWdzIHwg
X19HRlBfTk9XQVJOKTsKKworCXJldHVybiB1dmNfdXJiLT5idWZmZXIgIT0gTlVMTDsKK30KKyNl
bmRpZgorCiAvKgogICogQWxsb2NhdGUgdHJhbnNmZXIgYnVmZmVycy4gVGhpcyBmdW5jdGlvbiBj
YW4gYmUgY2FsbGVkIHdpdGggYnVmZmVycwogICogYWxyZWFkeSBhbGxvY2F0ZWQgd2hlbiByZXN1
bWluZyBmcm9tIHN1c3BlbmQsIGluIHdoaWNoIGNhc2UgaXQgd2lsbApAQCAtMTc2NCwxOSArMTgx
NywxMSBAQCBzdGF0aWMgaW50IHV2Y19hbGxvY191cmJfYnVmZmVycyhzdHJ1Y3QgdXZjX3N0cmVh
bWluZyAqc3RyZWFtLAogCiAJLyogUmV0cnkgYWxsb2NhdGlvbnMgdW50aWwgb25lIHN1Y2NlZWQu
ICovCiAJZm9yICg7IG5wYWNrZXRzID4gMTsgbnBhY2tldHMgLz0gMikgeworCQlzdHJlYW0tPnVy
Yl9zaXplID0gcHNpemUgKiBucGFja2V0czsKIAkJZm9yIChpID0gMDsgaSA8IFVWQ19VUkJTOyAr
K2kpIHsKIAkJCXN0cnVjdCB1dmNfdXJiICp1dmNfdXJiID0gJnN0cmVhbS0+dXZjX3VyYltpXTsK
IAotCQkJc3RyZWFtLT51cmJfc2l6ZSA9IHBzaXplICogbnBhY2tldHM7Ci0jaWZuZGVmIENPTkZJ
R19ETUFfTk9OQ09IRVJFTlQKLQkJCXV2Y191cmItPmJ1ZmZlciA9IHVzYl9hbGxvY19jb2hlcmVu
dCgKLQkJCQlzdHJlYW0tPmRldi0+dWRldiwgc3RyZWFtLT51cmJfc2l6ZSwKLQkJCQlnZnBfZmxh
Z3MgfCBfX0dGUF9OT1dBUk4sICZ1dmNfdXJiLT5kbWEpOwotI2Vsc2UKLQkJCXV2Y191cmItPmJ1
ZmZlciA9Ci0JCQkgICAga21hbGxvYyhzdHJlYW0tPnVyYl9zaXplLCBnZnBfZmxhZ3MgfCBfX0dG
UF9OT1dBUk4pOwotI2VuZGlmCi0JCQlpZiAoIXV2Y191cmItPmJ1ZmZlcikgeworCQkJaWYgKCF1
dmNfYWxsb2NfdXJiX2J1ZmZlcihzdHJlYW0sIHV2Y191cmIsIGdmcF9mbGFncykpIHsKIAkJCQl1
dmNfZnJlZV91cmJfYnVmZmVycyhzdHJlYW0pOwogCQkJCWJyZWFrOwogCQkJfQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZWRpYS91c2IvdXZjL3V2Y3ZpZGVvLmggYi9kcml2ZXJzL21lZGlhL3VzYi91
dmMvdXZjdmlkZW8uaAppbmRleCA2MGQ4MzBkNzRhYzEuLjgwZWVlYWYzY2QwNiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9tZWRpYS91c2IvdXZjL3V2Y3ZpZGVvLmgKKysrIGIvZHJpdmVycy9tZWRpYS91
c2IvdXZjL3V2Y3ZpZGVvLmgKQEAgLTU0NCw2ICs1NDQsNyBAQCBzdHJ1Y3QgdXZjX3VyYiB7CiAK
IAljaGFyICpidWZmZXI7CiAJZG1hX2FkZHJfdCBkbWE7CisJc3RydWN0IHBhZ2UgKipwYWdlczsK
IAogCXVuc2lnbmVkIGludCBhc3luY19vcGVyYXRpb25zOwogCXN0cnVjdCB1dmNfY29weV9vcCBj
b3B5X29wZXJhdGlvbnNbVVZDX01BWF9QQUNLRVRTXTsKLS0gCjIuMjkuMi4yOTkuZ2RjMTEyMTgy
M2MtZ29vZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
