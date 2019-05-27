Return-Path: <SRS0=w+D4=T3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B9C04AB3
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 11:53:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A331320883
	for <iommu@archiver.kernel.org>; Mon, 27 May 2019 11:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A331320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5E1A21848;
	Mon, 27 May 2019 11:53:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 194B8182B
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 11:53:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0AFC2823
	for <iommu@lists.linux-foundation.org>;
	Mon, 27 May 2019 11:53:00 +0000 (UTC)
Received: from ramsan ([84.194.111.163]) by albert.telenet-ops.be with bizsmtp
	id HPsy2000F3XaVaC06PsyAS; Mon, 27 May 2019 13:52:59 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hVEBW-0001O0-Ca; Mon, 27 May 2019 13:52:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hVEBW-0000aj-AI; Mon, 27 May 2019 13:52:58 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH v4 0/6] iommu/ipmmu-vmsa: Suspend/resume support and assorted
	cleanups
Date: Mon, 27 May 2019 13:52:47 +0200
Message-Id: <20190527115253.2114-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
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

CUhpIErDtnJnLCBNYWdudXMsCgpPbiBSLUNhciBHZW4zIHN5c3RlbXMgd2l0aCBQU0NJLCBQU0NJ
IG1heSBwb3dlciBkb3duIHRoZSBTb0MgZHVyaW5nCnN5c3RlbSBzdXNwZW5kLCB0aHVzIGxvc2lu
ZyBhbGwgSU9NTVUgc3RhdGUuICBIZW5jZSBhZnRlciBzMnJhbSwgZGV2aWNlcwpiZWhpbmQgYW4g
SVBNTVUgKGUuZy4gU0FUQSksIGFuZCBjb25maWd1cmVkIHRvIHVzZSBpdCwgd2lsbCBmYWlsIHRv
CmNvbXBsZXRlIHRoZWlyIEkvTyBvcGVyYXRpb25zLgoKVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBz
dXNwZW5kL3Jlc3VtZSBzdXBwb3J0IHRvIHRoZSBSZW5lc2FzIElQTU1VLVZNU0EKSU9NTVUgZHJp
dmVyLCBhbmQgcGVyZm9ybXMgc29tZSBzbWFsbGVyIGNsZWFudXBzIGFuZCBmaXhlcyBkdXJpbmcg
dGhlCnByb2Nlc3MuICBNb3N0IHBhdGNoZXMgYXJlIGZhaXJseSBpbmRlcGVuZGVudCwgZXhjZXB0
IGZvciBwYXRjaCA2LzYsCndoaWNoIGRlcGVuZHMgb24gcGF0Y2hlcyA0LzYgYW5kIDUvNi4KCkNo
YW5nZXMgY29tcGFyZWQgdG8gdjM6CiAgLSBBZGQgUmV2aWV3ZWQtYnksIFRlc3RlZC1ieS4KCkNo
YW5nZXMgY29tcGFyZWQgdG8gdjI6CiAgLSBGaXggc3lzZnMgcGF0aCB0eXBvIGluIHBhdGNoIGRl
c2NyaXB0aW9uLAogIC0gQWRkIFJldmlld2VkLWJ5LgoKQ2hhbmdlcyBjb21wYXJlZCB0byB2MToK
ICAtIERyb3BwZWQgImlvbW11L2lwbW11LXZtc2E6IENhbGwgaXBtbXVfY3R4X3dyaXRlX3Jvb3Qo
KSBpbnN0ZWFkIG9mCiAgICBvcGVuIGNvZGluZyIsCiAgLSBBZGQgUmV2aWV3ZWQtYnksCiAgLSBN
ZXJnZSBJTUVBUi9JTUVMQVIsCiAgLSBzL2lwbW11X2NvbnRleHRfaW5pdC9pcG1tdV9kb21haW5f
c2V0dXBfY29udGV4dC8sCiAgLSBEcm9wIFBTQ0kgY2hlY2tzLgoKVGhpcyBoYXMgYmVlbiB0ZXN0
ZWQgb24gU2FsdmF0b3ItWFMgd2l0aCBSLUNhciBIMyBFUzIuMCwgd2l0aCBJUE1NVQpzdXBvcnQg
Zm9yIFNBVEEgZW5hYmxlZC4gIFRvIHBsYXkgc2FmZSwgdGhlIHJlc3VtZSBvcGVyYXRpb24gaGFz
IGFsc28KYmVlbiB0ZXN0ZWQgb24gUi1DYXIgTTItVy4KCklzIHRoZXJlIGFueXRoaW5nIHN0aWxs
IGJsb2NraW5nIHRoZSBpbnRlZ3JhdGlvbiBvZiB0aGlzIHBhdGNoIHNlcmllcz8KSWYgbm90LCBw
bGVhc2UgYXBwbHkuCgpUaGFua3MhCgpHZWVydCBVeXR0ZXJob2V2ZW4gKDYpOgogIGlvbW11L2lw
bW11LXZtc2E6IExpbmsgSU9NTVVzIGFuZCBkZXZpY2VzIGluIHN5c2ZzCiAgaW9tbXUvaXBtbXUt
dm1zYTogUHJlcGFyZSB0byBoYW5kbGUgNDAtYml0IGVycm9yIGFkZHJlc3NlcwogIGlvbW11L2lw
bW11LXZtc2E6IE1ha2UgSVBNTVVfQ1RYX01BWCB1bnNpZ25lZAogIGlvbW11L2lwbW11LXZtc2E6
IE1vdmUgbnVtX3V0bGJzIHRvIFNvQy1zcGVjaWZpYyBmZWF0dXJlcwogIGlvbW11L2lwbW11LXZt
c2E6IEV4dHJhY3QgaGFyZHdhcmUgY29udGV4dCBpbml0aWFsaXphdGlvbgogIGlvbW11L2lwbW11
LXZtc2E6IEFkZCBzdXNwZW5kL3Jlc3VtZSBzdXBwb3J0CgogZHJpdmVycy9pb21tdS9pcG1tdS12
bXNhLmMgfCAxODUgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspLCA2MSBkZWxldGlvbnMoLSkKCi0tIAoyLjE3LjEK
Ckdye29ldGplLGVldGluZ31zLAoKCQkJCQkJR2VlcnQKCi0tCkdlZXJ0IFV5dHRlcmhvZXZlbiAt
LSBUaGVyZSdzIGxvdHMgb2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5v
cmcKCkluIHBlcnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNh
bGwgbXlzZWxmIGEgaGFja2VyLiBCdXQKd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJ
IGp1c3Qgc2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0LgoJCQkJCQkJICAg
IC0tIExpbnVzIFRvcnZhbGRzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
