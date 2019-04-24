Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05569C282E1
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F95218FD
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F95218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 68951121D;
	Wed, 24 Apr 2019 13:55:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BA2CF11F1
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 13:55:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5E35DF4
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 13:55:24 +0000 (UTC)
Received: from ramsan ([84.194.111.163]) by laurent.telenet-ops.be with bizsmtp
	id 4DvL200093XaVaC01DvL9w; Wed, 24 Apr 2019 15:55:20 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hJIMq-00087x-39; Wed, 24 Apr 2019 15:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hJIMq-0006YT-18; Wed, 24 Apr 2019 15:55:20 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH v3 0/6] iommu/ipmmu-vmsa: Suspend/resume support and assorted
	cleanups
Date: Wed, 24 Apr 2019 15:55:12 +0200
Message-Id: <20190424135518.25150-1-geert+renesas@glider.be>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424135512.27X5nYQ3C_zGdwZXijVwh41aeWEeOrdju9CleP91fB0@z>

CUhpIErDtnJnLCBNYWdudXMsCgpPbiBSLUNhciBHZW4zIHN5c3RlbXMgd2l0aCBQU0NJLCBQU0NJ
IG1heSBwb3dlciBkb3duIHRoZSBTb0MgZHVyaW5nCnN5c3RlbSBzdXNwZW5kLCB0aHVzIGxvc2lu
ZyBhbGwgSU9NTVUgc3RhdGUuICBIZW5jZSBhZnRlciBzMnJhbSwgZGV2aWNlcwpiZWhpbmQgYW4g
SVBNTVUgKGUuZy4gU0FUQSksIGFuZCBjb25maWd1cmVkIHRvIHVzZSBpdCwgd2lsbCBmYWlsIHRv
CmNvbXBsZXRlIHRoZWlyIEkvTyBvcGVyYXRpb25zLgoKVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBz
dXNwZW5kL3Jlc3VtZSBzdXBwb3J0IHRvIHRoZSBSZW5lc2FzIElQTU1VLVZNU0EKSU9NTVUgZHJp
dmVyLCBhbmQgcGVyZm9ybXMgc29tZSBzbWFsbGVyIGNsZWFudXBzIGFuZCBmaXhlcyBkdXJpbmcg
dGhlCnByb2Nlc3MuICBNb3N0IHBhdGNoZXMgYXJlIGZhaXJseSBpbmRlcGVuZGVudCwgZXhjZXB0
IGZvciBwYXRjaCA2LzYsCndoaWNoIGRlcGVuZHMgb24gcGF0Y2hlcyA0LzYgYW5kIDUvNi4KCkNo
YW5nZXMgY29tcGFyZWQgdG8gdjI6CiAgLSBGaXggc3lzZnMgcGF0aCB0eXBvIGluIHBhdGNoIGRl
c2NyaXB0aW9uLAogIC0gQWRkIFJldmlld2VkLWJ5LgoKQ2hhbmdlcyBjb21wYXJlZCB0byB2MToK
ICAtIERyb3BwZWQgImlvbW11L2lwbW11LXZtc2E6IENhbGwgaXBtbXVfY3R4X3dyaXRlX3Jvb3Qo
KSBpbnN0ZWFkIG9mCiAgICBvcGVuIGNvZGluZyIsCiAgLSBBZGQgUmV2aWV3ZWQtYnksCiAgLSBN
ZXJnZSBJTUVBUi9JTUVMQVIsCiAgLSBzL2lwbW11X2NvbnRleHRfaW5pdC9pcG1tdV9kb21haW5f
c2V0dXBfY29udGV4dC8sCiAgLSBEcm9wIFBTQ0kgY2hlY2tzLgoKVGhpcyBoYXMgYmVlbiB0ZXN0
ZWQgb24gU2FsdmF0b3ItWFMgd2l0aCBSLUNhciBIMyBFUzIuMCwgd2l0aCBJUE1NVQpzdXBvcnQg
Zm9yIFNBVEEgZW5hYmxlZC4gIFRvIHBsYXkgc2FmZSwgdGhlIHJlc3VtZSBvcGVyYXRpb24gaGFz
IGFsc28KYmVlbiB0ZXN0ZWQgb24gUi1DYXIgTTItVy4KClRoYW5rcyEKCkdlZXJ0IFV5dHRlcmhv
ZXZlbiAoNik6CiAgaW9tbXUvaXBtbXUtdm1zYTogTGluayBJT01NVXMgYW5kIGRldmljZXMgaW4g
c3lzZnMKICBpb21tdS9pcG1tdS12bXNhOiBQcmVwYXJlIHRvIGhhbmRsZSA0MC1iaXQgZXJyb3Ig
YWRkcmVzc2VzCiAgaW9tbXUvaXBtbXUtdm1zYTogTWFrZSBJUE1NVV9DVFhfTUFYIHVuc2lnbmVk
CiAgaW9tbXUvaXBtbXUtdm1zYTogTW92ZSBudW1fdXRsYnMgdG8gU29DLXNwZWNpZmljIGZlYXR1
cmVzCiAgaW9tbXUvaXBtbXUtdm1zYTogRXh0cmFjdCBoYXJkd2FyZSBjb250ZXh0IGluaXRpYWxp
emF0aW9uCiAgaW9tbXUvaXBtbXUtdm1zYTogQWRkIHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQKCiBk
cml2ZXJzL2lvbW11L2lwbW11LXZtc2EuYyB8IDE4NSArKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTI0IGluc2VydGlvbnMoKyksIDYxIGRlbGV0
aW9ucygtKQoKLS0gCjIuMTcuMQoKR3J7b2V0amUsZWV0aW5nfXMsCgoJCQkJCQlHZWVydAoKLS0K
R2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAt
LSBnZWVydEBsaW51eC1tNjhrLm9yZwoKSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRl
Y2huaWNhbCBwZW9wbGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dAp3aGVuIEknbSB0YWxr
aW5nIHRvIGpvdXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBs
aWtlIHRoYXQuCgkJCQkJCQkgICAgLS0gTGludXMgVG9ydmFsZHMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
