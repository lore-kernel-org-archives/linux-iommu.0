Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728F7C388F7
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 10:15:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07E622280
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 10:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07E622280
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 45FA1869A5;
	Wed,  4 Nov 2020 10:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fj2-JGgJmESq; Wed,  4 Nov 2020 10:14:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A85D484273;
	Wed,  4 Nov 2020 10:14:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AA09C088B;
	Wed,  4 Nov 2020 10:14:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F6BEC0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 10:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0B3EE869A4
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 10:14:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c+bRqPXZFNIr for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 10:14:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0B74B84273
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 10:14:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0F714ABAE;
 Wed,  4 Nov 2020 10:14:56 +0000 (UTC)
Date: Wed, 4 Nov 2020 11:14:54 +0100
From: "jroedel@suse.de" <jroedel@suse.de>
To: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
Subject: Re: [EXTERNAL] Re: amdgpu error whenever IOMMU is enabled
Message-ID: <20201104101454.GR22179@suse.de>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
 <20201104085306.GQ22179@suse.de>
 <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR10MB13109574BDA0F1D8219A225C89EF0@MWHPR10MB1310.namprd10.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

T24gV2VkLCBOb3YgMDQsIDIwMjAgYXQgMDk6MjE6MzVBTSArMDAwMCwgTWVyZ2VyLCBFZGdhciBb
QVVUT1NPTC9NQVMvQVVHU10gd3JvdGU6Cj4gQU1ELVZpOiBDb21wbGV0aW9uLVdhaXQgbG9vcCB0
aW1lZCBvdXQgaXMgYXQgWzY1NDk5Ljk2NDEwNV0gYnV0IGFtZGdwdS1lcnJvciBpcyBhdCBbICAg
NTIuNzcyMjczXSwgaGVuY2UgbXVjaCBlYXJsaWVyLgoKWWVzLCBidXQgaXQgY291bGQgYmUgdGhl
IHNhbWUgdW5kZXJseWluZyByZWFzb24uCgo+IEhhdmUgbm90IHRyaWVkIHRvIHVzZSBhbiB1cHN0
cmVhbSBrZXJuZWwgeWV0LiBXaGljaCBvbmUgd291bGQgeW91IHJlY29tbWVuZD8KCkZvciBhIGZp
cnN0IHRyeSwgdXNlIDUuOS4zLiBJZiBpdCByZXByb2R1Y2VzIHRoZXJlLCBwbGVhc2UgdHJ5IGJv
b3RpbmcKd2l0aCAicGNpPW5vYXRzIiBvbiB0aGUga2VybmVsIGNvbW1hbmQgbGluZS4KClBsZWFz
ZSBhbHNvIHNlbmQgbWUgdGhlIG91dHB1dCBvZiAnbHNwY2kgLXZ2dicgYW5kICdsc3BjaSAtdCcg
b2YgdGhlCm1hY2hpbmUgd2hlcmUgdGhpcyBoYXBwZW5zLgoKUmVnYXJkcywKCglKb2VyZwoKCj4g
Cj4gQXMgZmFyIGFzIGluY29uc2lzdGVuY2llcyBpbiB0aGUgUENJLXNldHVwIGlzIGNvbmNlcm5l
ZCwgdGhlIG9ubHkgdGhpbmcgdGhhdCBJIGtub3cgb2YgcmlnaHQgbm93IGlzIHRoYXQgd2UgaGF2
ZW7CtHQgZW50ZXJlZCBhIFBDSSBzdWJzeXN0ZW0gdmVuZG9yIGFuZCBkZXZpY2UgSUQgeWV0LiBJ
dCBpcyBzdGlsbCAiQWR2YW5jZWQgTWljcm8gRGV2aWNlcyIuIFdlIHdpbGwgY2hhbmdlIHRoYXQg
c29vbiB0byAiR2VuZXJhbCBFbGVjdHJpYyIgb3IgIkVtZXJzb24iLgo+IAo+IEJlc3QgcmVnYXJk
cywKPiBFZGdhcgo+IAo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4gRnJvbToganJvZWRl
bEBzdXNlLmRlIDxqcm9lZGVsQHN1c2UuZGU+IAo+IFNlbnQ6IE1pdHR3b2NoLCA0LiBOb3ZlbWJl
ciAyMDIwIDA5OjUzCj4gVG86IE1lcmdlciwgRWRnYXIgW0FVVE9TT0wvTUFTL0FVR1NdIDxFZGdh
ci5NZXJnZXJAZW1lcnNvbi5jb20+Cj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogYW1kZ3B1IGVycm9yIHdoZW5ldmVyIElPTU1V
IGlzIGVuYWJsZWQKPiAKPiBIaSBFZGdhciwKPiAKPiBPbiBGcmksIE9jdCAzMCwgMjAyMCBhdCAw
MjoyNjoyM1BNICswMDAwLCBNZXJnZXIsIEVkZ2FyIFtBVVRPU09ML01BUy9BVUdTXSB3cm90ZToK
PiA+IFdpdGggb25lIGJvYXJkIHdlIGhhdmUgYSBib290LXByb2JsZW0gdGhhdCBpcyByZXByb2R1
Y2libGUgYXQgZXZlcnkgfjUwIGJvb3QuCj4gPiBUaGUgc3lzdGVtIGlzIGFjY2Vzc2libGUgdmlh
IHNzaCBhbmQgd29ya3MgZmluZSBleGNlcHQgZm9yIHRoZSAKPiA+IEdyYXBoaWNzLiBUaGUgZ3Jh
cGhpY3MgaXMgb2ZmLiBXZSBkb27CtHQgc2VlIGEgc2NyZWVuLiBQbGVhc2Ugc2VlIAo+ID4gYXR0
YWNoZWQg4oCcZG1lc2cubG9n4oCdLiBGcm9tIFs1Mi43NzIyNzNdIG9ud2FyZHMgdGhlIGtlcm5l
bCByZXBvcnRzIAo+ID4gZHJtL2FtZGdwdSBlcnJvcnMuIEl0IGV2ZW4gdHJpZXMgdG8gcmVzZXQg
dGhlIEdQVSBidXQgdGhhdCBmYWlscyB0b28uIAo+ID4gSSB0cmllZCB0byByZXNldCBhbWRncHUg
YWxzbyBieSBjb21tYW5kIOKAnHN1ZG8gY2F0IC9zeXMva2VybmVsL2RlYnVnL2RyaS9OL2FtZGdw
dV9ncHVfcmVjb3ZlcuKAnS4gVGhhdCBkaWQgbm90IGhlbHAgZWl0aGVyLgo+IAo+IENhbiB5b3Ug
cmVwcm9kdWNlIHRoZSBwcm9ibGVtIHdpdGggYW4gdXBzdHJlYW0ga2VybmVsIHRvbz8KPiAKPiBU
aGVzZSBtZXNzYWdlcyBpbiBkbWVzZyBpbmRpY2F0ZSBzb21lIHByb2JsZW0gaW4gdGhlIHBsYXRm
b3JtIHNldHVwOgo+IAo+IAlBTUQtVmk6IENvbXBsZXRpb24tV2FpdCBsb29wIHRpbWVkIG91dAo+
IAo+IE1pZ2h0IHRoZXJlIGJlIHNvbWUgaW5jb25zaXN0ZW5jaWVzIGluIHRoZSBQQ0kgc2V0dXAg
YmV0d2VlbiB0aGUgYnJpZGdlcyBhbmQgdGhlIGVuZHBvaW50cyBvciBzb21ldGhpbmc/Cj4gCj4g
UmVnYXJkcywKPiAKPiAJSm9lcmcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
