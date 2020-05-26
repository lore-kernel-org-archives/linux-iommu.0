Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AACC433E1
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 18:35:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFF582068D
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 18:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF582068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78D92886BE;
	Tue, 26 May 2020 18:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYBsH7cMf2zI; Tue, 26 May 2020 18:35:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D59A5886B4;
	Tue, 26 May 2020 18:35:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE2F3C0888;
	Tue, 26 May 2020 18:35:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8CF2C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B794E886B5
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zJaiHvOWZ1B3 for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 18:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2A082886B4
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 18:35:02 +0000 (UTC)
IronPort-SDR: Ktc1sXaS8PclLE0B8q+7zGteSo7q5BbNyGEP9jkCLMRTswQmT9Cpd7GS3XT/XIQZtCWoyjIHYV
 c9YWPEojrEFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 11:35:01 -0700
IronPort-SDR: Y+FI5ZVcXxa++6tH2EuB5e/A5meiAUK4eJ01+7jBspT26gqSwzsmUGMfjWsRBeKJNwkIM55H1/
 AZzrs7JRxjpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="291295609"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
 by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 11:34:57 -0700
Date: Tue, 26 May 2020 11:34:57 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] iommu: Relax ACS requirement for RCiEP devices.
Message-ID: <20200526183457.GC36356@otc-nc-03>
References: <1588653736-10835-1-git-send-email-ashok.raj@intel.com>
 <20200504231936.2bc07fe3@x1.home>
 <20200505061107.GA22974@araj-mobl1.jf.intel.com>
 <20200505080514.01153835@x1.home>
 <20200505145605.GA13690@otc-nc-03>
 <20200505093414.6bae52e0@x1.home>
 <20200526180648.GC35892@otc-nc-03>
 <20200526122654.7ac087b3@x1.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200526122654.7ac087b3@x1.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Ashok Raj <ashok.raj@intel.com>, Darrel Goeddel <DGoeddel@forcepoint.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Scott <mscott@forcepoint.com>,
 Romil Sharma <rsharma@forcepoint.com>, Bjorn Helgaas <bhelgaas@google.com>
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

T24gVHVlLCBNYXkgMjYsIDIwMjAgYXQgMTI6MjY6NTRQTSAtMDYwMCwgQWxleCBXaWxsaWFtc29u
IHdyb3RlOgo+ID4gPiAKPiA+ID4gSSBkb24ndCB0aGluayB0aGUgbGFuZ3VhZ2UgaW4gdGhlIHNw
ZWMgaXMgYW55dGhpbmcgc3VmZmljaWVudCB0byBoYW5kbGUKPiA+ID4gUkNpRVAgdW5pcXVlbHku
ICBXZSd2ZSBwcmV2aW91c2x5IHJlamVjdGVkIGtlcm5lbCBjb21tYW5kIGxpbmUgb3B0LW91dHMK
PiA+ID4gZm9yIEFDUywgYW5kIHRoZSBleHRlbnQgdG8gd2hpY2ggdGhvc2UgcGF0Y2hlcyBzdGls
bCBmbG9hdCBhcm91bmQgdGhlCj4gPiA+IHVzZXIgY29tbXVuaXR5IGFuZCBhcmUgYmxpbmRseSB1
c2VkIHRvIHNlcGFyYXRlIElPTU1VIGdyb3VwcyBhcmUgYQo+ID4gPiB0ZXN0YW1lbnQgdG8gdGhl
IGZhaWx1cmUgb2YgdGhpcyBhcHByb2FjaC4gIFVzZXJzIGRvIG5vdCBoYXZlIGEgYmFzaXMKPiA+
ID4gZm9yIGVuYWJsaW5nIHRoaXMgc29ydCBvZiBvcHQtb3V0LiAgVGhlIGJlbmVmaXQgaXMgb2J2
aW91cyBpbiB0aGUgSU9NTVUKPiA+ID4gZ3JvdXBpbmcsIGJ1dCB0aGUgcmlzayBpcyBlbnRpcmVs
eSB1bmtub3duLiAgQSBrY29uZmlnIG9wdGlvbiBpcyBldmVuCj4gPiA+IHdvcnNlIGFzIHRoYXQg
bWVhbnMgaWYgeW91IGNvbnN1bWUgYSBkb3duc3RyZWFtIGtlcm5lbCwgdGhlIGRvd25zdHJlYW0K
PiA+ID4gbWFpbnRhaW5lcnMgbWlnaHQgaGF2ZSBkZWNpZGVkIHVuaXZlcnNhbGx5IHRoYXQgaXNv
bGF0aW9uIGlzIGxlc3MKPiA+ID4gaW1wb3J0YW50IHRoYW4gZnVuY3Rpb25hbGl0eS4gIAo+ID4g
Cj4gPiBXZSBkaXNjdXNzZWQgdGhpcyBpbnRlcm5hbGx5LCBhbmQgSW50ZWwgdnQtZCBzcGVjIGRv
ZXMgc3BlbGwgb3V0IGNsZWFybHkgCj4gPiBpbiBTZWN0aW9uIDMuMTYgUm9vdC1Db21wbGV4IFBl
ZXIgdG8gUGVlciBDb25zaWRlcmF0aW9ucy4gVGhlIHNwZWMgY2xlYXJseQo+ID4gY2FsbHMgb3V0
IHRoYXQgYWxsIHAycCBtdXN0IGJlIGRvbmUgb24gdHJhbnNsYXRlZCBhZGRyZXNzZXMgYW5kIHRo
ZXJlZm9yZQo+ID4gbXVzdCBnbyB0aHJvdWdoIHRoZSBJT01NVS4KPiA+IAo+ID4gSSBzdXBwb3Nl
IHRoZXkgc2hvdWxkIGFsc28gaGF2ZSBzb21lIHNpbWlsYXIgcGxhdGZvcm0gZ2F1cmFudGVlZCBi
ZWhhdmlvcgo+ID4gZm9yIFJDaUVQJ3Mgb3IgTUZEJ3MgKk11c3QqIGJlaGF2ZSBhcyBmb2xsb3dz
LiBUaGUgbGFuZ3VhZ2UgaXMgc3RyaWN0IGFuZAo+ID4gd2hlbiBJT01NVSBpcyBlbmFibGVkIGlu
IHRoZSBwbGF0Zm9ybSwgZXZlcnl0aGluZyBpcyBzZW50IHVwIG5vcnRoIHRvIHRoZQo+ID4gSU9N
TVUgYWdlbnQuCj4gPiAKPiA+IDMuMTYgUm9vdC1Db21wbGV4IFBlZXIgdG8gUGVlciBDb25zaWRl
cmF0aW9ucwo+ID4gV2hlbiBETUEgcmVtYXBwaW5nIGlzIGVuYWJsZWQsIHBlZXItdG8tcGVlciBy
ZXF1ZXN0cyB0aHJvdWdoIHRoZQo+ID4gUm9vdC1Db21wbGV4IG11c3QgYmUgaGFuZGxlZAo+ID4g
YXMgZm9sbG93czoKPiA+IOKAoiBUaGUgaW5wdXQgYWRkcmVzcyBpbiB0aGUgcmVxdWVzdCBpcyB0
cmFuc2xhdGVkICh0aHJvdWdoIGZpcnN0LWxldmVsLAo+ID4gICBzZWNvbmQtbGV2ZWwgb3IgbmVz
dGVkIHRyYW5zbGF0aW9uKSB0byBhIGhvc3QgcGh5c2ljYWwgYWRkcmVzcyAoSFBBKS4KPiA+ICAg
VGhlIGFkZHJlc3MgZGVjb2RpbmcgZm9yIHBlZXIgYWRkcmVzc2VzIG11c3QgYmUgZG9uZSBvbmx5
IG9uIHRoZSAKPiA+ICAgdHJhbnNsYXRlZCBIUEEuIEhhcmR3YXJlIGltcGxlbWVudGF0aW9ucyBh
cmUgZnJlZSB0byBmdXJ0aGVyIGxpbWl0IAo+ID4gICBwZWVyLXRvLXBlZXIgYWNjZXNzZXMgdG8g
c3BlY2lmaWMgaG9zdCBwaHlzaWNhbCBhZGRyZXNzIHJlZ2lvbnMgCj4gPiAgIChvciB0byBjb21w
bGV0ZWx5IGRpc2FsbG93IHBlZXItZm9yd2FyZGluZyBvZiB0cmFuc2xhdGVkIHJlcXVlc3RzKS4K
PiA+IOKAoiBTaW5jZSBhZGRyZXNzIHRyYW5zbGF0aW9uIGNoYW5nZXMgdGhlIGNvbnRlbnRzIChh
ZGRyZXNzIGZpZWxkKSBvZiB0aGUgUENJCj4gPiAgIEV4cHJlc3MgVHJhbnNhY3Rpb24gTGF5ZXIg
UGFja2V0IChUTFApLCBmb3IgUENJIEV4cHJlc3MgcGVlci10by1wZWVyIAo+ID4gICByZXF1ZXN0
cyB3aXRoIEVDUkMsIHRoZSBSb290LUNvbXBsZXggaGFyZHdhcmUgbXVzdCB1c2UgdGhlIG5ldyBF
Q1JDIAo+ID4gICAocmUtY29tcHV0ZWQgd2l0aCB0aGUgdHJhbnNsYXRlZCBhZGRyZXNzKSBpZiBp
dCBkZWNpZGVzIHRvIGZvcndhcmQgCj4gPiAgIHRoZSBUTFAgYXMgYSBwZWVyIHJlcXVlc3QuCj4g
PiDigKIgUm9vdC1wb3J0cywgYW5kIG11bHRpLWZ1bmN0aW9uIHJvb3QtY29tcGxleCBpbnRlZ3Jh
dGVkIGVuZHBvaW50cywgbWF5Cj4gPiAgIHN1cHBvcnQgYWRkaXRpb25hbCBwZWVydG8tcGVlciBj
b250cm9sIGZlYXR1cmVzIGJ5IHN1cHBvcnRpbmcgUENJIEV4cHJlc3MKPiA+ICAgQWNjZXNzIENv
bnRyb2wgU2VydmljZXMgKEFDUykgY2FwYWJpbGl0eS4gUmVmZXIgdG8gQUNTIGNhcGFiaWxpdHkg
aW4gCj4gPiAgIFBDSSBFeHByZXNzIHNwZWNpZmljYXRpb25zIGZvciBkZXRhaWxzLgo+IAo+IFRo
YXQgc291bmRzIGxpa2UgaXQgbWlnaHQgYmUgYSByZWFzb25hYmxlIGJhc2lzIGZvciBxdWlya2lu
ZyBhbGwgUkNpRVBzCj4gb24gVlQtZCBwbGF0Zm9ybXMgaWYgSW50ZWwgaXMgd2lsbGluZyB0byBz
dGFuZCBiZWhpbmQgaXQuICBUaGFua3MsCj4gCgpTb3VuZHMgZ29vZC4uIHRoYXQncyB3aGF0IGkg
aGVhciBmcm9tIG91ciBwbGF0Zm9ybSB0ZWFtcy4gSWYgdGhlcmUgaXMgYQp2aW9sYXRpb24gaXQg
d291bGQgYmUgYSBidWcgaW4gc2lsaWNvbi4gIApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vaW9tbXU=
