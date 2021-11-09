Return-Path: <SRS0=/C+/=P4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB8C433EF
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 22:19:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6695661A2E
	for <iommu@archiver.kernel.org>; Tue,  9 Nov 2021 22:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6695661A2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40A6840454;
	Tue,  9 Nov 2021 22:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vZevHWC0TCvL; Tue,  9 Nov 2021 22:19:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3B38D400FE;
	Tue,  9 Nov 2021 22:19:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1720EC0012;
	Tue,  9 Nov 2021 22:19:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45CB0C000E
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 22:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27946608CF
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 22:18:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9ApGGI6ktyC for <iommu@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 22:18:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 78149608CE
 for <iommu@lists.linux-foundation.org>; Tue,  9 Nov 2021 22:18:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E36861A02;
 Tue,  9 Nov 2021 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636496338;
 bh=a0Cro++qhmuF6Bm4xZmuXmLi0pMKBpnB/iLX8qruxKw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oe7WIZRVct3DmPm3m6qdXR5IzjRPwhjPQe0qlDzNCfb0vaejq5YkZ3Zo6j20T3Kyv
 yl2yCjIZ27pDBIgNF2YLK8+piqt7EBlldpHQd9JV0FJRcGeDjsjC+szwMcnZSv1csj
 4eGCOrc3fpw4jdKgAB7VksDvtFXmLnj+/h8/vnvcGpqgGkquGwFHKt001+DmXy1mAp
 BUVBrlkYnP4a41v8cCUscwv59u+ykRcmCaNl4SBVeuLdiMtJUKkRJzAwE6ySYe/yCl
 duJGJj/+YVaQ/3ZeKfz95KiD9PJxt1XJx1dTQz9+iLczqDQa3f5py5d+apc7xqTDgm
 jtey22rPv4q+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 79/82] iommu/dart: Initialize DART_STREAMS_ENABLE
Date: Tue,  9 Nov 2021 17:16:37 -0500
Message-Id: <20211109221641.1233217-79-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211109221641.1233217-1-sashal@kernel.org>
References: <20211109221641.1233217-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>,
 =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik@protonmail.com>,
 Joerg Roedel <jroedel@suse.de>, Hector Martin <marcan@marcan.st>,
 iommu@lists.linux-foundation.org
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

RnJvbTogU3ZlbiBQZXRlciA8c3ZlbkBzdmVucGV0ZXIuZGV2PgoKWyBVcHN0cmVhbSBjb21taXQg
NWEwMDlmYzEzNjQxNzBiMjQwYTRkMzUxYjM0NWU2OWJiMzcyOGIzZSBdCgpEQVJUIGhhcyBhbiBh
ZGRpdGlvbmFsIGdsb2JhbCByZWdpc3RlciB0byBjb250cm9sIHdoaWNoIHN0cmVhbXMgYXJlCmlz
b2xhdGVkLiBUaGlzIHJlZ2lzdGVyIGlzIGEgYml0IHJlZHVuZGFudCBzaW5jZSBEQVJUX1RDUiBj
YW4gYWxyZWFkeQpiZSB1c2VkIHRvIGNvbnRyb2wgaXNvbGF0aW9uIGFuZCBpcyB1c3VhbGx5IGlu
aXRpYWxpemVkIHRvIERBUlRfU1RSRUFNX0FMTApieSB0aGUgdGltZSB3ZSBnZXQgY29udHJvbC4g
U29tZSBEQVJUcyAobmFtZWx5IHRoZSBvbmUgdXNlZCBmb3IgdGhlIGF1ZGlvCmNvbnRyb2xsZXIp
IGhvd2V2ZXIgaGF2ZSBzb21lIHN0cmVhbXMgZGlzYWJsZWQgaW5pdGlhbGx5LiBNYWtlIHN1cmUg
dGhvc2UKd29yayBieSBpbml0aWFsaXppbmcgREFSVF9TVFJFQU1TX0VOQUJMRSBkdXJpbmcgcmVz
ZXQuCgpSZXBvcnRlZC1ieTogTWFydGluIFBvdmnFoWVyIDxwb3Zpa0Bwcm90b25tYWlsLmNvbT4K
U2lnbmVkLW9mZi1ieTogU3ZlbiBQZXRlciA8c3ZlbkBzdmVucGV0ZXIuZGV2PgpSZXZpZXdlZC1i
eTogSGVjdG9yIE1hcnRpbiA8bWFyY2FuQG1hcmNhbi5zdD4KTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDIxMTAxOTE2MjI1My40NTkxOS0xLXN2ZW5Ac3ZlbnBldGVyLmRldgpTaWdu
ZWQtb2ZmLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KU2lnbmVkLW9mZi1ieTog
U2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvaW9tbXUvYXBwbGUt
ZGFydC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvYXBwbGUtZGFydC5jIGIvZHJpdmVycy9pb21tdS9hcHBsZS1k
YXJ0LmMKaW5kZXggZmRmYTM5ZWMyYTRkNC4uYWQ2OWVlYjVhYzViYSAxMDA2NDQKLS0tIGEvZHJp
dmVycy9pb21tdS9hcHBsZS1kYXJ0LmMKKysrIGIvZHJpdmVycy9pb21tdS9hcHBsZS1kYXJ0LmMK
QEAgLTcwLDYgKzcwLDggQEAKICNkZWZpbmUgREFSVF9FUlJPUl9BRERSX0hJIDB4NTQKICNkZWZp
bmUgREFSVF9FUlJPUl9BRERSX0xPIDB4NTAKIAorI2RlZmluZSBEQVJUX1NUUkVBTVNfRU5BQkxF
IDB4ZmMKKwogI2RlZmluZSBEQVJUX1RDUihzaWQpICgweDEwMCArIDQgKiAoc2lkKSkKICNkZWZp
bmUgREFSVF9UQ1JfVFJBTlNMQVRFX0VOQUJMRSBCSVQoNykKICNkZWZpbmUgREFSVF9UQ1JfQllQ
QVNTMF9FTkFCTEUgQklUKDgpCkBAIC0zMDEsNiArMzAzLDkgQEAgc3RhdGljIGludCBhcHBsZV9k
YXJ0X2h3X3Jlc2V0KHN0cnVjdCBhcHBsZV9kYXJ0ICpkYXJ0KQogCWFwcGxlX2RhcnRfaHdfZGlz
YWJsZV9kbWEoJnN0cmVhbV9tYXApOwogCWFwcGxlX2RhcnRfaHdfY2xlYXJfYWxsX3R0YnJzKCZz
dHJlYW1fbWFwKTsKIAorCS8qIGVuYWJsZSBhbGwgc3RyZWFtcyBnbG9iYWxseSBzaW5jZSBUQ1Ig
aXMgdXNlZCB0byBjb250cm9sIGlzb2xhdGlvbiAqLworCXdyaXRlbChEQVJUX1NUUkVBTV9BTEws
IGRhcnQtPnJlZ3MgKyBEQVJUX1NUUkVBTVNfRU5BQkxFKTsKKwogCS8qIGNsZWFyIGFueSBwZW5k
aW5nIGVycm9ycyBiZWZvcmUgdGhlIGludGVycnVwdCBpcyB1bm1hc2tlZCAqLwogCXdyaXRlbChy
ZWFkbChkYXJ0LT5yZWdzICsgREFSVF9FUlJPUiksIGRhcnQtPnJlZ3MgKyBEQVJUX0VSUk9SKTsK
IAotLSAKMi4zMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
