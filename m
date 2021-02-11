Return-Path: <SRS0=8k88=HN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5FDC433DB
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 06:22:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F80364E7A
	for <iommu@archiver.kernel.org>; Thu, 11 Feb 2021 06:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F80364E7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1B7386B01;
	Thu, 11 Feb 2021 06:22:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dBfOzDklrVFc; Thu, 11 Feb 2021 06:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D99F86AB7;
	Thu, 11 Feb 2021 06:22:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F1BAC0174;
	Thu, 11 Feb 2021 06:22:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 500E8C013A
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 06:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C8FF86C02
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 06:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1JofcZu6PUrf for <iommu@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 06:22:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id E9524873CE
 for <iommu@lists.linux-foundation.org>; Thu, 11 Feb 2021 06:22:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD6F139F;
 Wed, 10 Feb 2021 22:22:13 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.94.253])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B75BC3F73B;
 Wed, 10 Feb 2021 22:22:08 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, will@kernel.org
Subject: [PATCH 3/3] dma-contiguous: Type cast MAX_ORDER as unsigned int
Date: Thu, 11 Feb 2021 11:52:11 +0530
Message-Id: <1613024531-19040-4-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
References: <1613024531-19040-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

VHlwZSBjYXN0IE1BWF9PUkRFUiBhcyB1bnNpZ25lZCBpbnQgdG8gZml4IHRoZSBmb2xsb3dpbmcg
YnVpbGQgd2FybmluZy4KCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgva2Vy
bmVsLmg6MTQsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvYXNtLWdlbmVyaWMvYnVn
Lmg6MjAsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vYnVn
Lmg6MjYsCiAgICAgICAgICAgICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYnVnLmg6NSwKICAg
ICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9tbWRlYnVnLmg6NSwKICAgICAgICAg
ICAgICAgICBmcm9tIC4vYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tZW1vcnkuaDoxNjYsCiAgICAg
ICAgICAgICAgICAgZnJvbSAuL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vcGFnZS5oOjQyLAogICAg
ICAgICAgICAgICAgIGZyb20ga2VybmVsL2RtYS9jb250aWd1b3VzLmM6NDY6Cmtlcm5lbC9kbWEv
Y29udGlndW91cy5jOiBJbiBmdW5jdGlvbiDigJhybWVtX2NtYV9zZXR1cOKAmToKLi9pbmNsdWRl
L2xpbnV4L21pbm1heC5oOjE4OjI4OiB3YXJuaW5nOiBjb21wYXJpc29uIG9mIGRpc3RpbmN0IHBv
aW50ZXIKdHlwZXMgbGFja3MgYSBjYXN0CiAgKCEhKHNpemVvZigodHlwZW9mKHgpICopMSA9PSAo
dHlwZW9mKHkpICopMSkpKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgXn4KLi9pbmNsdWRl
L2xpbnV4L21pbm1heC5oOjMyOjQ6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX3R5
cGVjaGVja+KAmQogICAoX190eXBlY2hlY2soeCwgeSkgJiYgX19ub19zaWRlX2VmZmVjdHMoeCwg
eSkpCiAgICBefn5+fn5+fn5+fgouL2luY2x1ZGUvbGludXgvbWlubWF4Lmg6NDI6MjQ6IG5vdGU6
IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhfX3NhZmVfY21w4oCZCiAgX19idWlsdGluX2Nob29z
ZV9leHByKF9fc2FmZV9jbXAoeCwgeSksIFwKICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+
fn5+fgouL2luY2x1ZGUvbGludXgvbWlubWF4Lmg6NTg6MTk6IG5vdGU6IGluIGV4cGFuc2lvbiBv
ZiBtYWNybwrigJhfX2NhcmVmdWxfY21w4oCZCiAjZGVmaW5lIG1heCh4LCB5KSBfX2NhcmVmdWxf
Y21wKHgsIHksID4pCiAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+Cmtlcm5lbC9kbWEv
Y29udGlndW91cy5jOjQwMjozNTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmG1heOKA
mQogIHBoeXNfYWRkcl90IGFsaWduID0gUEFHRV9TSVpFIDw8IG1heChNQVhfT1JERVIgLSAxLCBw
YWdlYmxvY2tfb3JkZXIpOwoKQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgpDYzog
TWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgpDYzogUm9iaW4gTXVy
cGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnClNpZ25lZC1vZmYtYnk6IEFu
c2h1bWFuIEtoYW5kdWFsIDxhbnNodW1hbi5raGFuZHVhbEBhcm0uY29tPgotLS0KIGtlcm5lbC9k
bWEvY29udGlndW91cy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9jb250aWd1b3VzLmMgYi9rZXJu
ZWwvZG1hL2NvbnRpZ3VvdXMuYwppbmRleCAzZDYzZDkxY2JhNWMuLjFjMjc4MjM0OWQ3MSAxMDA2
NDQKLS0tIGEva2VybmVsL2RtYS9jb250aWd1b3VzLmMKKysrIGIva2VybmVsL2RtYS9jb250aWd1
b3VzLmMKQEAgLTM5OSw3ICszOTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHJlc2VydmVkX21l
bV9vcHMgcm1lbV9jbWFfb3BzID0gewogCiBzdGF0aWMgaW50IF9faW5pdCBybWVtX2NtYV9zZXR1
cChzdHJ1Y3QgcmVzZXJ2ZWRfbWVtICpybWVtKQogewotCXBoeXNfYWRkcl90IGFsaWduID0gUEFH
RV9TSVpFIDw8IG1heChNQVhfT1JERVIgLSAxLCBwYWdlYmxvY2tfb3JkZXIpOworCXBoeXNfYWRk
cl90IGFsaWduID0gUEFHRV9TSVpFIDw8IG1heCgodW5zaWduZWQgaW50KU1BWF9PUkRFUiAtIDEs
IHBhZ2VibG9ja19vcmRlcik7CiAJcGh5c19hZGRyX3QgbWFzayA9IGFsaWduIC0gMTsKIAl1bnNp
Z25lZCBsb25nIG5vZGUgPSBybWVtLT5mZHRfbm9kZTsKIAlib29sIGRlZmF1bHRfY21hID0gb2Zf
Z2V0X2ZsYXRfZHRfcHJvcChub2RlLCAibGludXgsY21hLWRlZmF1bHQiLCBOVUxMKTsKLS0gCjIu
MjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
