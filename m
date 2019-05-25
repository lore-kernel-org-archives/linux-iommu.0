Return-Path: <SRS0=lyO4=TZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9A1C282CE
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:49:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D11C21848
	for <iommu@archiver.kernel.org>; Sat, 25 May 2019 05:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D11C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 66080DA6;
	Sat, 25 May 2019 05:49:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B7229DA6
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4D7986C5
	for <iommu@lists.linux-foundation.org>;
	Sat, 25 May 2019 05:49:05 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 22:49:05 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga006.fm.intel.com with ESMTP; 24 May 2019 22:49:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 09/15] iommu/vt-d: Handle 32bit device with identity
	default domain
Date: Sat, 25 May 2019 13:41:30 +0800
Message-Id: <20190525054136.27810-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190525054136.27810-1-baolu.lu@linux.intel.com>
References: <20190525054136.27810-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, dima@arista.com,
	tmurphy@arista.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

VGhlIGlvbW11IGRyaXZlciBkb2Vzbid0IGtub3cgd2hldGhlciB0aGUgYml0IHdpZHRoIG9mIGEg
UENJCmRldmljZSBpcyBzdWZmaWNpZW50IGZvciBhY2Nlc3MgdG8gdGhlIHdob2xlIHN5c3RlbSBt
ZW1vcnkuCkhlbmNlLCB0aGUgZHJpdmVyIGNoZWNrcyB0aGlzIHdoZW4gdGhlIGRyaXZlciBjYWxs
cyBpbnRvIHRoZQpkbWEgQVBJcy4gSWYgYSBkZXZpY2UgaXMgdXNpbmcgYW4gaWRlbnRpdHkgZG9t
YWluLCBidXQgdGhlCmJpdCB3aWR0aCBpcyBsZXNzIHRoYW4gdGhlIHN5c3RlbSByZXF1aXJlbWVu
dCwgd2UgbmVlZCB0byB1c2UKYSBkbWEgZG9tYWluIGluc3RlYWQuIFRoaXMgYWxzbyBhcHBsaWVz
IGFmdGVyIHdlIGRlbGVnYXRlZAp0aGUgZG9tYWluIGxpZmUgY3ljbGUgbWFuYWdlbWVudCB0byB0
aGUgdXBwZXIgbGF5ZXIuCgpTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPgotLS0KIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDU1ICsrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspLCAzMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVs
LWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKaW5kZXggMDhkYTQ4NGUwMWQ2
Li5iN2Y1YTYzOTBiZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwor
KysgYi9kcml2ZXJzL2lvbW11L2ludGVsLWlvbW11LmMKQEAgLTMwMTIsMjUgKzMwMTIsNiBAQCBz
dGF0aWMgaW50IGRldmljZV9kZWZfZG9tYWluX3R5cGUoc3RydWN0IGRldmljZSAqZGV2LCBpbnQg
c3RhcnR1cCkKIAkJCXJldHVybiBJT01NVV9ET01BSU5fRE1BOwogCX0KIAotCS8qCi0JICogQXQg
Ym9vdCB0aW1lLCB3ZSBkb24ndCB5ZXQga25vdyBpZiBkZXZpY2VzIHdpbGwgYmUgNjQtYml0IGNh
cGFibGUuCi0JICogQXNzdW1lIHRoYXQgdGhleSB3aWxsIOKAlCBpZiB0aGV5IHR1cm4gb3V0IG5v
dCB0byBiZSwgdGhlbiB3ZSBjYW4KLQkgKiB0YWtlIHRoZW0gb3V0IG9mIHRoZSAxOjEgZG9tYWlu
IGxhdGVyLgotCSAqLwotCWlmICghc3RhcnR1cCkgewotCQkvKgotCQkgKiBJZiB0aGUgZGV2aWNl
J3MgZG1hX21hc2sgaXMgbGVzcyB0aGFuIHRoZSBzeXN0ZW0ncyBtZW1vcnkKLQkJICogc2l6ZSB0
aGVuIHRoaXMgaXMgbm90IGEgY2FuZGlkYXRlIGZvciBpZGVudGl0eSBtYXBwaW5nLgotCQkgKi8K
LQkJdTY0IGRtYV9tYXNrID0gKmRldi0+ZG1hX21hc2s7Ci0KLQkJaWYgKGRldi0+Y29oZXJlbnRf
ZG1hX21hc2sgJiYKLQkJICAgIGRldi0+Y29oZXJlbnRfZG1hX21hc2sgPCBkbWFfbWFzaykKLQkJ
CWRtYV9tYXNrID0gZGV2LT5jb2hlcmVudF9kbWFfbWFzazsKLQotCQlyZXR1cm4gZG1hX21hc2sg
Pj0gZG1hX2dldF9yZXF1aXJlZF9tYXNrKGRldik7Ci0JfQotCiAJcmV0dXJuIChpb21tdV9pZGVu
dGl0eV9tYXBwaW5nICYgSURFTlRNQVBfQUxMKSA/CiAJCQlJT01NVV9ET01BSU5fSURFTlRJVFkg
OiAwOwogfQpAQCAtMzY0MiwxNCArMzYyMywxOSBAQCBzdHJ1Y3QgZG1hcl9kb21haW4gKmdldF92
YWxpZF9kb21haW5fZm9yX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYpCiAvKiBDaGVjayBpZiB0aGUg
ZGV2IG5lZWRzIHRvIGdvIHRocm91Z2ggbm9uLWlkZW50aXR5IG1hcCBhbmQgdW5tYXAgcHJvY2Vz
cy4qLwogc3RhdGljIGJvb2wgaW9tbXVfbmVlZF9tYXBwaW5nKHN0cnVjdCBkZXZpY2UgKmRldikK
IHsKLQlpbnQgZm91bmQ7CisJaW50IHJldDsKIAogCWlmIChpb21tdV9kdW1teShkZXYpKQogCQly
ZXR1cm4gZmFsc2U7CiAKLQlmb3VuZCA9IGlkZW50aXR5X21hcHBpbmcoZGV2KTsKLQlpZiAoZm91
bmQpIHsKLQkJaWYgKGlvbW11X3Nob3VsZF9pZGVudGl0eV9tYXAoZGV2LCAwKSkKKwlyZXQgPSBp
ZGVudGl0eV9tYXBwaW5nKGRldik7CisJaWYgKHJldCkgeworCQl1NjQgZG1hX21hc2sgPSAqZGV2
LT5kbWFfbWFzazsKKworCQlpZiAoZGV2LT5jb2hlcmVudF9kbWFfbWFzayAmJiBkZXYtPmNvaGVy
ZW50X2RtYV9tYXNrIDwgZG1hX21hc2spCisJCQlkbWFfbWFzayA9IGRldi0+Y29oZXJlbnRfZG1h
X21hc2s7CisKKwkJaWYgKGRtYV9tYXNrID49IGRtYV9nZXRfcmVxdWlyZWRfbWFzayhkZXYpKQog
CQkJcmV0dXJuIGZhbHNlOwogCiAJCS8qCkBAIC0zNjU3LDE3ICszNjQzLDIwIEBAIHN0YXRpYyBi
b29sIGlvbW11X25lZWRfbWFwcGluZyhzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCSAqIG5vbi1pZGVu
dGl0eSBtYXBwaW5nLgogCQkgKi8KIAkJZG1hcl9yZW1vdmVfb25lX2Rldl9pbmZvKGRldik7Ci0J
CWRldl9pbmZvKGRldiwgIjMyYml0IERNQSB1c2VzIG5vbi1pZGVudGl0eSBtYXBwaW5nXG4iKTsK
LQl9IGVsc2UgewotCQkvKgotCQkgKiBJbiBjYXNlIG9mIGEgZGV0YWNoZWQgNjQgYml0IERNQSBk
ZXZpY2UgZnJvbSB2bSwgdGhlIGRldmljZQotCQkgKiBpcyBwdXQgaW50byBzaV9kb21haW4gZm9y
IGlkZW50aXR5IG1hcHBpbmcuCi0JCSAqLwotCQlpZiAoaW9tbXVfc2hvdWxkX2lkZW50aXR5X21h
cChkZXYsIDApICYmCi0JCSAgICAhZG9tYWluX2FkZF9kZXZfaW5mbyhzaV9kb21haW4sIGRldikp
IHsKLQkJCWRldl9pbmZvKGRldiwgIjY0Yml0IERNQSB1c2VzIGlkZW50aXR5IG1hcHBpbmdcbiIp
OwotCQkJcmV0dXJuIGZhbHNlOworCQlyZXQgPSBpb21tdV9yZXF1ZXN0X2RtYV9kb21haW5fZm9y
X2RldihkZXYpOworCQlpZiAocmV0KSB7CisJCQlzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW47
CisJCQlzdHJ1Y3QgZG1hcl9kb21haW4gKmRtYXJfZG9tYWluOworCisJCQlkb21haW4gPSBpb21t
dV9nZXRfZG9tYWluX2Zvcl9kZXYoZGV2KTsKKwkJCWlmIChkb21haW4pIHsKKwkJCQlkbWFyX2Rv
bWFpbiA9IHRvX2RtYXJfZG9tYWluKGRvbWFpbik7CisJCQkJZG1hcl9kb21haW4tPmZsYWdzIHw9
IERPTUFJTl9GTEFHX0xPU0VfQ0hJTERSRU47CisJCQl9CisJCQlnZXRfdmFsaWRfZG9tYWluX2Zv
cl9kZXYoZGV2KTsKIAkJfQorCisJCWRldl9pbmZvKGRldiwgIjMyYml0IERNQSB1c2VzIG5vbi1p
ZGVudGl0eSBtYXBwaW5nXG4iKTsKIAl9CiAKIAlyZXR1cm4gdHJ1ZTsKLS0gCjIuMTcuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
