Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E1C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 03:13:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257DF64F20
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 03:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257DF64F20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A256A4308E;
	Thu, 18 Mar 2021 03:13:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iOYdSlTV2ud0; Thu, 18 Mar 2021 03:13:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C33C43090;
	Thu, 18 Mar 2021 03:13:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52C09C000B;
	Thu, 18 Mar 2021 03:13:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1E0C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 03:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F6CF43090
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 03:13:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MNKx7sBsW2A for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 03:13:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A25CB4308E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 03:13:01 +0000 (UTC)
IronPort-SDR: Ns4Kk/TbKF+Pi0tHIsdkx+tsI0UCEn8KJ1DotvP6zq+dAtufbZg9BOz+6J7EAaGedUAtOH+fO2
 5n99P3EX2pcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="188960154"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="188960154"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2021 20:13:01 -0700
IronPort-SDR: Vnx2oAyvyukdZlcAlstH7BILdaPTgSZ4JzbZ1NXTAuRxz/+bbmk/5w+XoAZD7qOEB5v3jBQmr1
 C/Zb+pW/13yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; d="scan'208";a="433653512"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2021 20:12:58 -0700
Subject: =?UTF-8?Q?Re=3a_A_problem_of_Intel_IOMMU_hardware_=ef=bc=9f?=
To: Nadav Amit <nadav.amit@gmail.com>,
 "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)"
 <longpeng2@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0f4c562d-fcee-3212-0880-f67fd45b1462@linux.intel.com>
Date: Thu, 18 Mar 2021 11:03:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
Content-Language: en-US
Cc: chenjiashang <chenjiashang@huawei.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "will@kernel.org" <will@kernel.org>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgTmFkYXYsCgpPbiAzLzE4LzIxIDI6MTIgQU0sIE5hZGF2IEFtaXQgd3JvdGU6Cj4gCj4gCj4+
IE9uIE1hciAxNywgMjAyMSwgYXQgMjozNSBBTSwgTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJh
c3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikgPGxvbmdwZW5nMkBodWF3ZWkuY29tPiB3
cm90ZToKPj4KPj4gSGkgTmFkYXYsCj4+Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
Pj4gRnJvbTogTmFkYXYgQW1pdCBbbWFpbHRvOm5hZGF2LmFtaXRAZ21haWwuY29tXQo+Pj4+ICAg
cmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdpdGggaGlnaCBwcm9iYWJpbGl0eSAofjUwJSkuCj4+Pgo+
Pj4gSSBzYXcgTHUgcmVwbGllZCwgYW5kIGhlIGlzIG11Y2ggbW9yZSBrbm93bGVkZ2FibGUgdGhh
biBJIGFtIChJIHdhcyBqdXN0IGludHJpZ3VlZAo+Pj4gYnkgeW91ciBlbWFpbCkuCj4+Pgo+Pj4g
SG93ZXZlciwgaWYgSSB3ZXJlIHlvdSBJIHdvdWxkIHRyeSBhbHNvIHRvIHJlbW92ZSBzb21lIOKA
nG9wdGltaXphdGlvbnPigJ0gdG8gbG9vayBmb3IKPj4+IHRoZSByb290LWNhdXNlIChlLmcuLCB1
c2UgZG9tYWluIHNwZWNpZmljIGludmFsaWRhdGlvbnMgaW5zdGVhZCBvZiBwYWdlLXNwZWNpZmlj
KS4KPj4+Cj4+Cj4+IEdvb2Qgc3VnZ2VzdGlvbiEgQnV0IHdlIGRpZCBpdCB0aGVzZSBkYXlzLCB3
ZSB0cmllZCB0byB1c2UgZ2xvYmFsIGludmFsaWRhdGlvbnMgYXMgZm9sbG93Ogo+PiAJCWlvbW11
LT5mbHVzaC5mbHVzaF9pb3RsYihpb21tdSwgZGlkLCAwLCAwLAo+PiAJCQkJCQlETUFfVExCX0RT
SV9GTFVTSCk7Cj4+IEJ1dCBjYW4gbm90IHJlc29sdmUgdGhlIHByb2JsZW0uCj4+Cj4+PiBUaGUg
Zmlyc3QgdGhpbmcgdGhhdCBjb21lcyB0byBteSBtaW5kIGlzIHRoZSBpbnZhbGlkYXRpb24gaGlu
dCAoaWgpIGluCj4+PiBpb21tdV9mbHVzaF9pb3RsYl9wc2koKS4gSSB3b3VsZCByZW1vdmUgaXQg
dG8gc2VlIHdoZXRoZXIgeW91IGdldCB0aGUgZmFpbHVyZQo+Pj4gd2l0aG91dCBpdC4KPj4KPj4g
V2UgYWxzbyBub3RpY2UgdGhlIElILCBidXQgdGhlIElIIGlzIGFsd2F5cyBaRVJPIGluIG91ciBj
YXNlLCBhcyB0aGUgc3BlYyBzYXlzOgo+PiAnJycKPj4gUGFnaW5nLXN0cnVjdHVyZS1jYWNoZSBl
bnRyaWVzIGNhY2hpbmcgc2Vjb25kLWxldmVsIG1hcHBpbmdzIGFzc29jaWF0ZWQgd2l0aCB0aGUg
c3BlY2lmaWVkCj4+IGRvbWFpbi1pZCBhbmQgdGhlIHNlY29uZC1sZXZlbC1pbnB1dC1hZGRyZXNz
IHJhbmdlIGFyZSBpbnZhbGlkYXRlZCwgaWYgdGhlIEludmFsaWRhdGlvbiBIaW50Cj4+IChJSCkg
ZmllbGQgaXMgQ2xlYXIuCj4+ICcnJwo+Pgo+PiBJdCBzZWVtcyB0aGUgc29mdHdhcmUgaXMgZXZl
cnl0aGluZyBmaW5lLCBzbyB3ZSd2ZSBubyBjaG9pY2UgYnV0IHRvIHN1c3BlY3QgdGhlIGhhcmR3
YXJlLgo+IAo+IE9rLCBJIGFtIHByZXR0eSBtdWNoIG91dCBvZiBpZGVhcy4gSSBoYXZlIHR3byBt
b3JlIHN1Z2dlc3Rpb25zLCBidXQKPiB0aGV5IGFyZSBtdWNoIGxlc3MgbGlrZWx5IHRvIGhlbHAu
IFlldCwgdGhleSBjYW4gZnVydGhlciBoZWxwIHRvIHJ1bGUKPiBvdXQgc29mdHdhcmUgYnVnczoK
PiAKPiAxLiBkbWFfY2xlYXJfcHRlKCkgc2VlbXMgdG8gYmUgd3JvbmcgSU1ITy4gSXQgc2hvdWxk
IGhhdmUgdXNlZCBXUklURV9PTkNFKCkKPiB0byBwcmV2ZW50IHNwbGl0LXdyaXRlLCB3aGljaCBt
aWdodCBwb3RlbnRpYWxseSBjYXVzZSDigJxpbnZhbGlk4oCdIChwYXJ0aWFsbHkKPiBjbGVhcmVk
KSBQVEUgdG8gYmUgc3RvcmVkIGluIHRoZSBUTEIuIEhhdmluZyBzYWlkIHRoYXQsIHRoZSBzdWJz
ZXF1ZW50Cj4gSU9UTEIgZmx1c2ggc2hvdWxkIGhhdmUgcHJldmVudGVkIHRoZSBwcm9ibGVtLgoK
QWdyZWVkLiBUaGUgcHRlIHJlYWQvd3JpdGUgc2hvdWxkIHVzZSBSRUFEL1dSSVRFX09OQ0UoKSBp
bnN0ZWFkLgoKPiAKPiAyLiBDb25zaWRlciBlbnN1cmluZyB0aGF0IHRoZSBwcm9ibGVtIGlzIG5v
dCBzb21laG93IHJlbGF0ZWQgdG8gcXVldWVkCj4gaW52YWxpZGF0aW9ucy4gVHJ5IHRvIHVzZSBf
X2lvbW11X2ZsdXNoX2lvdGxiKCkgaW5zdGVhZCBvZgo+IHFpX2ZsdXNoX2lvdGxiKCkuCj4gCj4g
UmVnYXJkcywKPiBOYWRhdgo+IAoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
