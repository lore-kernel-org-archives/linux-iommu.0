Return-Path: <SRS0=Hf/t=64=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45D9C433E0
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 12:46:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6665B2065D
	for <iommu@archiver.kernel.org>; Thu, 14 May 2020 12:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6665B2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B84A888E5;
	Thu, 14 May 2020 12:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpMCDyovcq2A; Thu, 14 May 2020 12:46:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 01B07888CE;
	Thu, 14 May 2020 12:46:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8CBEC088F;
	Thu, 14 May 2020 12:46:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1A92C016F
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 12:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D0E9C87059
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 12:46:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ZMsvC-M2OgL for <iommu@lists.linux-foundation.org>;
 Thu, 14 May 2020 12:46:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0DB7E87009
 for <iommu@lists.linux-foundation.org>; Thu, 14 May 2020 12:46:25 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9035C452; Thu, 14 May 2020 14:46:22 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 1/2] iommu/sun50i: Fix compile warnings
Date: Thu, 14 May 2020 14:46:20 +0200
Message-Id: <20200514124621.25999-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: jroedel@suse.de, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Maxime Ripard <maxime@cerno.tech>, linux-arm-kernel@lists.infradead.org
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

RnJvbTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+CgpBIGZldyBjb21waWxlIHdhcm5p
bmdzIHNob3cgdXAgd2hlbiBidWlsZGluZyB0aGlzIGRyaXZlcjoKCiAgQ0MgICAgICBkcml2ZXJz
L2lvbW11L3N1bjUwaS1pb21tdS5vCmRyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmM6IEluIGZ1
bmN0aW9uIOKAmHN1bjUwaV9kdGVfZ2V0X3BhZ2VfdGFibGXigJk6CmRyaXZlcnMvaW9tbXUvc3Vu
NTBpLWlvbW11LmM6NDg2OjE2OiB3YXJuaW5nOiB1bnVzZWQgdmFyaWFibGUg4oCYZmxhZ3PigJkg
Wy1XdW51c2VkLXZhcmlhYmxlXQogIDQ4NiB8ICB1bnNpZ25lZCBsb25nIGZsYWdzOwogICAgICB8
ICAgICAgICAgICAgICAgIF5+fn5+CmRyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmM6IEluIGZ1
bmN0aW9uIOKAmHN1bjUwaV9pb21tdV91bm1hcOKAmToKZHJpdmVycy9pb21tdS9zdW41MGktaW9t
bXUuYzo1NTk6MjM6IHdhcm5pbmc6IHVudXNlZCB2YXJpYWJsZSDigJhpb21tdeKAmSBbLVd1bnVz
ZWQtdmFyaWFibGVdCiAgNTU5IHwgIHN0cnVjdCBzdW41MGlfaW9tbXUgKmlvbW11ID0gc3VuNTBp
X2RvbWFpbi0+aW9tbXU7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+CmRyaXZl
cnMvaW9tbXUvc3VuNTBpLWlvbW11LmM6IEluIGZ1bmN0aW9uIOKAmHN1bjUwaV9pb21tdV9wcm9i
ZV9kZXZpY2XigJk6CmRyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmM6NzQ5OjIyOiB3YXJuaW5n
OiB1bnVzZWQgdmFyaWFibGUg4oCYZ3JvdXDigJkgWy1XdW51c2VkLXZhcmlhYmxlXQogIDc0OSB8
ICBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwOwogICAgICB8ICAgICAgICAgICAgICAgICAgICAg
IF5+fn5+CgpSZW1vdmUgdGhlIHVudXNlZCB2YXJpYWJsZXMuCgpDYzogTWF4aW1lIFJpcGFyZCA8
bWF4aW1lQGNlcm5vLnRlY2g+ClNpZ25lZC1vZmYtYnk6IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBz
dXNlLmRlPgotLS0KIGRyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmMgfCAzIC0tLQogMSBmaWxl
IGNoYW5nZWQsIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9zdW41
MGktaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11LmMKaW5kZXggOTg5ZDg3YWE0
NDI2Li5hNTJmNTJlZmY3YzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvc3VuNTBpLWlvbW11
LmMKKysrIGIvZHJpdmVycy9pb21tdS9zdW41MGktaW9tbXUuYwpAQCAtNDgzLDcgKzQ4Myw2IEBA
IHN0YXRpYyB1MzIgKnN1bjUwaV9kdGVfZ2V0X3BhZ2VfdGFibGUoc3RydWN0IHN1bjUwaV9pb21t
dV9kb21haW4gKnN1bjUwaV9kb21haW4sCiAJCQkJICAgICAgZG1hX2FkZHJfdCBpb3ZhLCBnZnBf
dCBnZnApCiB7CiAJc3RydWN0IHN1bjUwaV9pb21tdSAqaW9tbXUgPSBzdW41MGlfZG9tYWluLT5p
b21tdTsKLQl1bnNpZ25lZCBsb25nIGZsYWdzOwogCXUzMiAqcGFnZV90YWJsZTsKIAl1MzIgKmR0
ZV9hZGRyOwogCXUzMiBvbGRfZHRlOwpAQCAtNTU2LDcgKzU1NSw2IEBAIHN0YXRpYyBzaXplX3Qg
c3VuNTBpX2lvbW11X3VubWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQg
bG9uZyBpb3ZhCiAJCQkJIHNpemVfdCBzaXplLCBzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyICpn
YXRoZXIpCiB7CiAJc3RydWN0IHN1bjUwaV9pb21tdV9kb21haW4gKnN1bjUwaV9kb21haW4gPSB0
b19zdW41MGlfZG9tYWluKGRvbWFpbik7Ci0Jc3RydWN0IHN1bjUwaV9pb21tdSAqaW9tbXUgPSBz
dW41MGlfZG9tYWluLT5pb21tdTsKIAlwaHlzX2FkZHJfdCBwdF9waHlzOwogCWRtYV9hZGRyX3Qg
cHRlX2RtYTsKIAl1MzIgKnB0ZV9hZGRyOwpAQCAtNzQ2LDcgKzc0NCw2IEBAIHN0YXRpYyBpbnQg
c3VuNTBpX2lvbW11X2F0dGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLAog
c3RhdGljIHN0cnVjdCBpb21tdV9kZXZpY2UgKnN1bjUwaV9pb21tdV9wcm9iZV9kZXZpY2Uoc3Ry
dWN0IGRldmljZSAqZGV2KQogewogCXN0cnVjdCBzdW41MGlfaW9tbXUgKmlvbW11OwotCXN0cnVj
dCBpb21tdV9ncm91cCAqZ3JvdXA7CiAKIAlpb21tdSA9IHN1bjUwaV9pb21tdV9mcm9tX2Rldihk
ZXYpOwogCWlmICghaW9tbXUpCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby9pb21tdQ==
