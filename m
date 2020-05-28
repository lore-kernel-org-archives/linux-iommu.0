Return-Path: <SRS0=4TkS=7K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20204C433DF
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 20:58:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3DE32078C
	for <iommu@archiver.kernel.org>; Thu, 28 May 2020 20:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DE32078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7835A8844C;
	Thu, 28 May 2020 20:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lZMtv256zynB; Thu, 28 May 2020 20:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 38B43883D6;
	Thu, 28 May 2020 20:57:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 288FFC088D;
	Thu, 28 May 2020 20:57:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E0E3C016F
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 20:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 16D2386FBE
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 20:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rb6HvdSK8WTe for <iommu@lists.linux-foundation.org>;
 Thu, 28 May 2020 20:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 65CAF86DDA
 for <iommu@lists.linux-foundation.org>; Thu, 28 May 2020 20:57:52 +0000 (UTC)
IronPort-SDR: 3vmo0OStfxdI62b4vwdnVzkrozG72Y84y36BVO0ATK3R8AlCIKbn0jm1fawPCfjWdcJwySAFkc
 MeqMwEbsoJCg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 13:57:51 -0700
IronPort-SDR: g97HzgpaCyP0RNtnAdIcT04mBb3TUUtTVMkD+bqeBN0v9vYO4vCsG/uu90zlloqNGBS/nnZ5Ha
 1pR/6s9+n1sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; d="scan'208";a="285292590"
Received: from ssp-nc-cdi361.jf.intel.com (HELO otc-nc-03.jf.intel.com)
 ([10.54.39.25])
 by orsmga002.jf.intel.com with ESMTP; 28 May 2020 13:57:51 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] PCI: Relax ACS requirement for Intel RCiEP devices.
Date: Thu, 28 May 2020 13:57:42 -0700
Message-Id: <1590699462-7131-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Darrel Goeddel <DGoeddel@forcepoint.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Scott <mscott@forcepoint.com>,
 Romil Sharma <rsharma@forcepoint.com>
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

QWxsIEludGVsIHBsYXRmb3JtcyBndWFyYW50ZWUgdGhhdCBhbGwgcm9vdCBjb21wbGV4IGltcGxl
bWVudGF0aW9ucwptdXN0IHNlbmQgdHJhbnNhY3Rpb25zIHVwIHRvIElPTU1VIGZvciBhZGRyZXNz
IHRyYW5zbGF0aW9ucy4gSGVuY2UgZm9yClJDaUVQIGRldmljZXMgdGhhdCBhcmUgVmVuZG9yIElE
IEludGVsLCBjYW4gY2xhaW0gZXhjZXB0aW9uIGZvciBsYWNrIG9mCkFDUyBzdXBwb3J0LgoKCjMu
MTYgUm9vdC1Db21wbGV4IFBlZXIgdG8gUGVlciBDb25zaWRlcmF0aW9ucwpXaGVuIERNQSByZW1h
cHBpbmcgaXMgZW5hYmxlZCwgcGVlci10by1wZWVyIHJlcXVlc3RzIHRocm91Z2ggdGhlClJvb3Qt
Q29tcGxleCBtdXN0IGJlIGhhbmRsZWQKYXMgZm9sbG93czoK4oCiIFRoZSBpbnB1dCBhZGRyZXNz
IGluIHRoZSByZXF1ZXN0IGlzIHRyYW5zbGF0ZWQgKHRocm91Z2ggZmlyc3QtbGV2ZWwsCiAgc2Vj
b25kLWxldmVsIG9yIG5lc3RlZCB0cmFuc2xhdGlvbikgdG8gYSBob3N0IHBoeXNpY2FsIGFkZHJl
c3MgKEhQQSkuCiAgVGhlIGFkZHJlc3MgZGVjb2RpbmcgZm9yIHBlZXIgYWRkcmVzc2VzIG11c3Qg
YmUgZG9uZSBvbmx5IG9uIHRoZQogIHRyYW5zbGF0ZWQgSFBBLiBIYXJkd2FyZSBpbXBsZW1lbnRh
dGlvbnMgYXJlIGZyZWUgdG8gZnVydGhlciBsaW1pdAogIHBlZXItdG8tcGVlciBhY2Nlc3NlcyB0
byBzcGVjaWZpYyBob3N0IHBoeXNpY2FsIGFkZHJlc3MgcmVnaW9ucwogIChvciB0byBjb21wbGV0
ZWx5IGRpc2FsbG93IHBlZXItZm9yd2FyZGluZyBvZiB0cmFuc2xhdGVkIHJlcXVlc3RzKS4K4oCi
IFNpbmNlIGFkZHJlc3MgdHJhbnNsYXRpb24gY2hhbmdlcyB0aGUgY29udGVudHMgKGFkZHJlc3Mg
ZmllbGQpIG9mCiAgdGhlIFBDSSBFeHByZXNzIFRyYW5zYWN0aW9uIExheWVyIFBhY2tldCAoVExQ
KSwgZm9yIFBDSSBFeHByZXNzCiAgcGVlci10by1wZWVyIHJlcXVlc3RzIHdpdGggRUNSQywgdGhl
IFJvb3QtQ29tcGxleCBoYXJkd2FyZSBtdXN0IHVzZQogIHRoZSBuZXcgRUNSQyAocmUtY29tcHV0
ZWQgd2l0aCB0aGUgdHJhbnNsYXRlZCBhZGRyZXNzKSBpZiBpdAogIGRlY2lkZXMgdG8gZm9yd2Fy
ZCB0aGUgVExQIGFzIGEgcGVlciByZXF1ZXN0LgrigKIgUm9vdC1wb3J0cywgYW5kIG11bHRpLWZ1
bmN0aW9uIHJvb3QtY29tcGxleCBpbnRlZ3JhdGVkIGVuZHBvaW50cywgbWF5CiAgc3VwcG9ydCBh
ZGRpdGlvbmFsIHBlZXJ0by1wZWVyIGNvbnRyb2wgZmVhdHVyZXMgYnkgc3VwcG9ydGluZyBQQ0kg
RXhwcmVzcwogIEFjY2VzcyBDb250cm9sIFNlcnZpY2VzIChBQ1MpIGNhcGFiaWxpdHkuIFJlZmVy
IHRvIEFDUyBjYXBhYmlsaXR5IGluCiAgUENJIEV4cHJlc3Mgc3BlY2lmaWNhdGlvbnMgZm9yIGRl
dGFpbHMuCgpTaW5jZSBMaW51eCBkaWRuJ3QgZ2l2ZSBzcGVjaWFsIHRyZWF0bWVudCB0byBhbGxv
dyB0aGlzIGV4Y2VwdGlvbiwgY2VydGFpbgpSQ2lFUCBNRkQgZGV2aWNlcyBhcmUgZ2V0dGluZyBn
cm91cGVkIGluIGEgc2luZ2xlIGlvbW11IGdyb3VwLiBUaGlzCmRvZXNuJ3QgcGVybWl0IGEgc2lu
Z2xlIGRldmljZSB0byBiZSBhc3NpZ25lZCB0byBhIGd1ZXN0IGZvciBpbnN0YW5jZS4KCkluIG9u
ZSB2ZW5kb3Igc3lzdGVtOiBEZXZpY2UgMTQueCB3ZXJlIGdyb3VwZWQgaW4gYSBzaW5nbGUgSU9N
TVUgZ3JvdXAuCgovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQu
MAovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMgovc3lzL2tl
cm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMwoKQWZ0ZXIgdGhlIHBhdGNo
Ogovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMAovc3lzL2tl
cm5lbC9pb21tdV9ncm91cHMvNS9kZXZpY2VzLzAwMDA6MDA6MTQuMgovc3lzL2tlcm5lbC9pb21t
dV9ncm91cHMvNi9kZXZpY2VzLzAwMDA6MDA6MTQuMyA8PDwgbmV3IGdyb3VwCgoxNC4wIGFuZCAx
NC4yIGFyZSBpbnRlZ3JhdGVkIGRldmljZXMsIGJ1dCBsZWdhY3kgZW5kIHBvaW50cy4KV2hlcmVh
cyAxNC4zIHdhcyBhIFBDSWUgY29tcGxpYW50IFJDaUVQLgoKMDA6MTQuMyBOZXR3b3JrIGNvbnRy
b2xsZXI6IEludGVsIENvcnBvcmF0aW9uIERldmljZSA5ZGYwIChyZXYgMzApCkNhcGFiaWxpdGll
czogWzQwXSBFeHByZXNzICh2MikgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQsIE1T
SSAwMAoKVGhpcyBwZXJtaXRzIGFzc2lnbmluZyB0aGlzIGRldmljZSB0byBhIGd1ZXN0IFZNLgoK
Rml4ZXM6IGYwOTZjMDYxZjU1MiAoImlvbW11OiBSZXdvcmsgaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9w
Y2lfZGV2KCkiKQpTaWduZWQtb2ZmLWJ5OiBBc2hvayBSYWogPGFzaG9rLnJhakBpbnRlbC5jb20+
ClRvOiBKb2VyZyBSb2VkZWwgPGpvcm9AOGJ5dGVzLm9yZz4KVG86IEJqb3JuIEhlbGdhYXMgPGJo
ZWxnYWFzQGdvb2dsZS5jb20+CkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCkNjOiBp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpDYzogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4KQ2M6IEFsZXggV2lsbGlhbXNvbiA8YWxleC53aWxsaWFtc29uQHJlZGhh
dC5jb20+CkNjOiBEYXJyZWwgR29lZGRlbCA8REdvZWRkZWxAZm9yY2Vwb2ludC5jb20+CkNjOiBN
YXJrIFNjb3R0IDxtc2NvdHRAZm9yY2Vwb2ludC5jb20+LApDYzogUm9taWwgU2hhcm1hIDxyc2hh
cm1hQGZvcmNlcG9pbnQuY29tPgpDYzogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29tPgot
LS0KdjI6IE1vdmVkIGZ1bmN0aW9uYWxpdHkgZnJvbSBpb21tdSB0byBwY2kgcXVpcmtzIC0gQWxl
eCBXaWxsaWFtc29uCgogZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAxNSArKysrKysrKysrKysrKysK
IDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYwppbmRleCAyOGM5YTI0MDljNTAuLjYz
MzczY2EwYTNmZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMKKysrIGIvZHJpdmVy
cy9wY2kvcXVpcmtzLmMKQEAgLTQ2ODIsNiArNDY4MiwyMCBAQCBzdGF0aWMgaW50IHBjaV9xdWly
a19tZl9lbmRwb2ludF9hY3Moc3RydWN0IHBjaV9kZXYgKmRldiwgdTE2IGFjc19mbGFncykKIAkJ
UENJX0FDU19DUiB8IFBDSV9BQ1NfVUYgfCBQQ0lfQUNTX0RUKTsKIH0KIAorc3RhdGljIGludCBw
Y2lfcXVpcmtfcmNpZXBfYWNzKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpCit7
CisJLyoKKwkgKiBSQ2lFUCdzIGFyZSByZXF1aXJlZCB0byBhbGxvdyBwMnAgb25seSBvbiB0cmFu
c2xhdGVkIGFkZHJlc3Nlcy4KKwkgKiBSZWZlciB0byBJbnRlbCBWVC1kIHNwZWNpZmljYXRpb24g
U2VjdGlvbiAzLjE2IFJvb3QtQ29tcGxleCBQZWVyCisJICogdG8gUGVlciBDb25zaWRlcmF0aW9u
cworCSAqLworCWlmIChwY2lfcGNpZV90eXBlKGRldikgIT0gUENJX0VYUF9UWVBFX1JDX0VORCkK
KwkJcmV0dXJuIC1FTk9UVFk7CisKKwlyZXR1cm4gcGNpX2Fjc19jdHJsX2VuYWJsZWQoYWNzX2Zs
YWdzLAorCQlQQ0lfQUNTX1NWIHwgUENJX0FDU19SUiB8IFBDSV9BQ1NfQ1IgfCBQQ0lfQUNTX1VG
KTsKK30KKwogc3RhdGljIGludCBwY2lfcXVpcmtfYnJjbV9hY3Moc3RydWN0IHBjaV9kZXYgKmRl
diwgdTE2IGFjc19mbGFncykKIHsKIAkvKgpAQCAtNDc2NCw2ICs0Nzc4LDcgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBwY2lfZGV2X2Fjc19lbmFibGVkIHsKIAkvKiBJMjE5ICovCiAJeyBQQ0lfVkVO
RE9SX0lEX0lOVEVMLCAweDE1YjcsIHBjaV9xdWlya19tZl9lbmRwb2ludF9hY3MgfSwKIAl7IFBD
SV9WRU5ET1JfSURfSU5URUwsIDB4MTViOCwgcGNpX3F1aXJrX21mX2VuZHBvaW50X2FjcyB9LAor
CXsgUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJX0FOWV9JRCwgcGNpX3F1aXJrX3JjaWVwX2FjcyB9
LAogCS8qIFFDT00gUURGMnh4eCByb290IHBvcnRzICovCiAJeyBQQ0lfVkVORE9SX0lEX1FDT00s
IDB4MDQwMCwgcGNpX3F1aXJrX3Fjb21fcnBfYWNzIH0sCiAJeyBQQ0lfVkVORE9SX0lEX1FDT00s
IDB4MDQwMSwgcGNpX3F1aXJrX3Fjb21fcnBfYWNzIH0sCi0tIAoyLjcuNAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0Cmlv
bW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
