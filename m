Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A15BC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 22:17:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30976208C9
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 22:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30976208C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DEAC2878BA;
	Tue, 26 May 2020 22:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0PmOTTRGdkcS; Tue, 26 May 2020 22:17:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0ED73878A8;
	Tue, 26 May 2020 22:17:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6D3AC0888;
	Tue, 26 May 2020 22:17:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24C57C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 22:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 13842878BA
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 22:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mwjgh-sAVqW for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 22:17:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A5344878A8
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 22:17:41 +0000 (UTC)
IronPort-SDR: P+k06u6q6aaUPzOvV/pttjIRf23oSrY0HYOHpUTjtLsQk94DbQtpUZ3Kpz6rb+9KlQm2Whajgr
 1W8cZMWTBXNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 15:17:39 -0700
IronPort-SDR: LQRNBHg29mtUm+BYhW/F0JYJJY+Cx1gdDil/ex+yWAzjp61fCcXcLRRNl6lMtygMxkLl6ENDcN
 YPLwPdtukCtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; d="scan'208";a="468512269"
Received: from otc-nc-03.jf.intel.com ([10.54.39.25])
 by fmsmga006.fm.intel.com with ESMTP; 26 May 2020 15:17:39 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] iommu: Relax ACS requirement for Intel RCiEP devices.
Date: Tue, 26 May 2020 15:17:35 -0700
Message-Id: <1590531455-19757-1-git-send-email-ashok.raj@intel.com>
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
LS0KIGRyaXZlcnMvaW9tbXUvaW9tbXUuYyB8IDEzICsrKysrKysrKysrKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jCmluZGV4IDJiNDcxNDE5ZTI2
Yy4uMzFiNTk1ZGZlZGRlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2lvbW11L2lvbW11LmMKKysrIGIv
ZHJpdmVycy9pb21tdS9pb21tdS5jCkBAIC0xMTg3LDcgKzExODcsMTggQEAgc3RhdGljIHN0cnVj
dCBpb21tdV9ncm91cCAqZ2V0X3BjaV9mdW5jdGlvbl9hbGlhc19ncm91cChzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwKIAlzdHJ1Y3QgcGNpX2RldiAqdG1wID0gTlVMTDsKIAlzdHJ1Y3QgaW9tbXVfZ3Jv
dXAgKmdyb3VwOwogCi0JaWYgKCFwZGV2LT5tdWx0aWZ1bmN0aW9uIHx8IHBjaV9hY3NfZW5hYmxl
ZChwZGV2LCBSRVFfQUNTX0ZMQUdTKSkKKwkvKgorCSAqIEludGVsIFZULWQgU3BlY2lmaWNhdGlv
biBTZWN0aW9uIDMuMTYsIFJvb3QtQ29tcGxleCBQZWVyIHRvIFBlZXIKKwkgKiBDb25zaWRlcmF0
aW9ucyBtYW5hZGF0ZSB0aGF0IGFsbCB0cmFuc2FjdGlvbnMgaW4gUkNpRVAncyBhbmQKKwkgKiBl
dmVuIEludGVncmF0ZWQgTUZEJ3MgKm11c3QqIGJlIHNlbnQgdXAgdG8gdGhlIElPTU1VLiBQMlAg
aXMKKwkgKiBvbmx5IHBvc3NpYmxlIG9uIHRyYW5zbGF0ZWQgYWRkcmVzc2VzLiBUaGlzIGdpdmVz
IGVub3VnaAorCSAqIGd1YXJhbnRlZSB0aGF0IHN1Y2ggZGV2aWNlcyBjYW4gYmUgZm9yZ2l2ZW4g
Zm9yIGxhY2sgb2YgQUNTCisJICogc3VwcG9ydC4KKwkgKi8KKwlpZiAoIXBkZXYtPm11bHRpZnVu
Y3Rpb24gfHwKKwkgICAgKHBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0lOVEVMICYmCisJ
ICAgICBwY2lfcGNpZV90eXBlKHBkZXYpID09IFBDSV9FWFBfVFlQRV9SQ19FTkQpIHx8CisJICAg
ICBwY2lfYWNzX2VuYWJsZWQocGRldiwgUkVRX0FDU19GTEFHUykpCiAJCXJldHVybiBOVUxMOwog
CiAJZm9yX2VhY2hfcGNpX2Rldih0bXApIHsKLS0gCjIuNy40CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
