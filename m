Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFDDC433FE
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 10:22:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27FE3845B5;
	Fri, 20 May 2022 10:22:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQbvr0_x7upe; Fri, 20 May 2022 10:22:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21B76844EB;
	Fri, 20 May 2022 10:22:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA886C0032;
	Fri, 20 May 2022 10:22:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED046C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 10:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6EFB409F6
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 10:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n6_0hL-AvhHZ for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 10:22:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8516D408B9
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 10:22:27 +0000 (UTC)
Received: from cap.home.8bytes.org (p5b006cf2.dip0.t-ipconnect.de
 [91.0.108.242])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id CC385209;
 Fri, 20 May 2022 12:22:23 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu/amd: Increase timeout waiting for GA log enablement
Date: Fri, 20 May 2022 12:22:14 +0200
Message-Id: <20220520102214.12563-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: "D. Ziegfeld" <dzigg@posteo.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 =?UTF-8?q?J=C3=B6rg-Volker=20Peetz?= <jvpeetz@web.de>,
 Will Deacon <will@kernel.org>
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

RnJvbTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+CgpPbiBzb21lIHN5c3RlbXMgaXQg
Y2FuIHRha2UgYSBsb25nIHRpbWUgZm9yIHRoZSBoYXJkd2FyZSB0byBlbmFibGUgdGhlCkdBIGxv
ZyBvZiB0aGUgQU1EIElPTU1VLiBUaGUgY3VycmVudCB3YWl0IHRpbWUgaXMgb25seSAwLjFtcywg
YnV0CnRlc3Rpbmcgc2hvd2VkIHRoYXQgaXQgY2FuIHRha2UgdXAgdG8gMTRtcyBmb3IgdGhlIEdB
IGxvZyB0byBlbnRlcgpydW5uaW5nIHN0YXRlIGFmdGVyIGl0IGhhcyBiZWVuIGVuYWJsZWQuCgpT
b21ldGltZXMgdGhlIGxvbmcgZGVsYXkgaGFwcGVucyB3aGVuIGJvb3RpbmcgdGhlIHN5c3RlbSwg
c29tZXRpbWVzCm9ubHkgb24gcmVzdW1lLiBBZGp1c3QgdGhlIHRpbWVvdXQgYWNjb3JkaW5nbHkg
dG8gbm90IHByaW50IGEgd2FybmluZwp3aGVuIGhhcmR3YXJlIHRha2VzIGEgbG9uZ2VyIHRoYW4g
dXN1YWwuCgpUaGVyZSBoYXMgYWxyZWFkeSBiZWVuIGFuIGF0dGVtcHQgdG8gZml4IHRoaXMgd2l0
aCBjb21taXQKCgk5YjQ1YTc3MzhlZWMgKCJpb21tdS9hbWQ6IEZpeCBsb29wIHRpbWVvdXQgaXNz
dWUgaW4gaW9tbXVfZ2FfbG9nX2VuYWJsZSgpIikKCkJ1dCB0aGF0IGNvbW1pdCB3YXMgYmFzZWQg
b24gc29tZSB3cm9uZyBtYXRoIGFuZCBkaWQgbm90IGZpeCB0aGUgaXNzdWUKaW4gYWxsIGNhc2Vz
LgoKQ2M6ICJELiBaaWVnZmVsZCIgPGR6aWdnQHBvc3Rlby5kZT4KQ2M6IErDtnJnLVZvbGtlciBQ
ZWV0eiA8anZwZWV0ekB3ZWIuZGU+CkZpeGVzOiA4YmRhMGNmYmRjMWEgKCJpb21tdS9hbWQ6IERl
dGVjdCBhbmQgaW5pdGlhbGl6ZSBndWVzdCB2QVBJQyBsb2ciKQpTaWduZWQtb2ZmLWJ5OiBKb2Vy
ZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KLS0tCiBkcml2ZXJzL2lvbW11L2FtZC9pbml0LmMg
fCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMgYi9kcml2ZXJzL2lvbW11L2FtZC9p
bml0LmMKaW5kZXggYjRhNzk4YzdiMzQ3Li5kODA2MDUwM2JhNTEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW9tbXUvYW1kL2luaXQuYworKysgYi9kcml2ZXJzL2lvbW11L2FtZC9pbml0LmMKQEAgLTg0
LDcgKzg0LDcgQEAKICNkZWZpbmUgQUNQSV9ERVZGTEFHX0xJTlQxICAgICAgICAgICAgICAweDgw
CiAjZGVmaW5lIEFDUElfREVWRkxBR19BVFNESVMgICAgICAgICAgICAgMHgxMDAwMDAwMAogCi0j
ZGVmaW5lIExPT1BfVElNRU9VVAkxMDAwMDAKKyNkZWZpbmUgTE9PUF9USU1FT1VUCTIwMDAwMDAK
IC8qCiAgKiBBQ1BJIHRhYmxlIGRlZmluaXRpb25zCiAgKgotLSAKMi4zNi4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
