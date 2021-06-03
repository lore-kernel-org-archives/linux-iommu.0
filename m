Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FD7C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:37:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABC060FF1
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 12:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABC060FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5775540193;
	Thu,  3 Jun 2021 12:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NiDAVkWMAh93; Thu,  3 Jun 2021 12:37:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 41011400CA;
	Thu,  3 Jun 2021 12:37:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06934C000D;
	Thu,  3 Jun 2021 12:37:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22643C0001;
 Thu,  3 Jun 2021 12:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 03A31400E5;
 Thu,  3 Jun 2021 12:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08mnMO9Is8VN; Thu,  3 Jun 2021 12:36:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EBF1400CA;
 Thu,  3 Jun 2021 12:36:59 +0000 (UTC)
IronPort-SDR: U8eJZnyymn05XzbWNsm29g8RmNcysNgvoreJa5z99T1TB0S0NyJMLUVr8hsKUfh7sCW/4+XbfD
 7bXOJjKDkIZw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="201020030"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="201020030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 05:36:55 -0700
IronPort-SDR: DMsT4IunyzTkMTPF0j+HWuKSdADAefIJviCOAMI8H+DVHk0IbyopR6+wX1W0nFTnGGRm62w+1Y
 H1wyY/+b4K/Q==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="550676961"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237])
 ([10.209.7.237])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 05:36:54 -0700
Subject: Re: [PATCH v1 6/8] dma: Add return value to dma_unmap_page
To: Robin Murphy <robin.murphy@arm.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-7-ak@linux.intel.com>
 <c3b15bc2-104b-dace-1f23-608197b18107@arm.com>
From: Andi Kleen <ak@linux.intel.com>
Message-ID: <dbca06fa-d708-3c76-2890-82ca5a781366@linux.intel.com>
Date: Thu, 3 Jun 2021 05:36:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c3b15bc2-104b-dace-1f23-608197b18107@arm.com>
Content-Language: en-US
Cc: jasowang@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, hch@lst.de
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

Cj4KPiBXaGF0IGl0IGxvb2tzIGxpa2UgdG8gbWUgaXMgYWJ1c2luZyBTV0lPVExCJ3MgaW50ZXJu
YWwgaG91c2VrZWVwaW5nIHRvIAo+IGtlZXAgdHJhY2sgb2YgdmlydGlvLXNwZWNpZmljIHN0YXRl
LiBUaGUgRE1BIEFQSSBkb2VzIG5vdCBhdHRlbXB0IHRvIAo+IHZhbGlkYXRlIGNhbGxzIGluIGdl
bmVyYWwgc2luY2UgaW4gbWFueSBjYXNlcyB0aGUgYWRkaXRpb25hbCBvdmVyaGVhZCAKPiB3b3Vs
ZCBiZSBwcm9oaWJpdGl2ZS4gSXQgaGFzIGFsd2F5cyBiZWVuIGNhbGxlcnMnIHJlc3BvbnNpYmls
aXR5IHRvIAo+IGtlZXAgdHJhY2sgb2Ygd2hhdCB0aGV5IG1hcHBlZCBhbmQgbWFrZSBzdXJlIHN5
bmMvdW5tYXAgY2FsbHMgbWF0Y2gsIAo+IGFuZCB0aGVyZSBhcmUgbWFueSwgbWFueSwgc3VidGxl
IGFuZCBub3Qtc28tc3VidGxlIHdheXMgZm9yIHRoaW5ncyB0byAKPiBnbyB3cm9uZyBpZiB0aGV5
IGRvbid0LiBJZiB2aXJ0aW8gaXMgbm90IGRvaW5nIGEgZ29vZCBlbm91Z2ggam9iIG9mIAo+IHRo
YXQsIHdoYXQncyB0aGUganVzdGlmaWNhdGlvbiBmb3IgbWFraW5nIGl0IHRoZSBETUEgQVBJJ3Mg
cHJvYmxlbT8KCkluIHRoaXMgY2FzZSBpdCdzIG5vdCBwcm9oaWJpdGl2ZSBhdCBhbGwuIEp1c3Qg
YWRkaW5nIGEgZmV3IGVycm9yIApyZXR1cm5zLCBhbmQgY2hlY2tpbmcgdGhlIG92ZXJsYXAgKHdo
aWNoIHNlZW1zIHRvIGhhdmUgYmVlbiBhbHJlYWR5IApzb2x2ZWQgYW55d2F5cykgSSB3b3VsZCBh
cmd1ZSB0aGUgZXJyb3IgcmV0dXJucyBhcmUgZ29vZCBwcmFjdGljZSAKYW55d2F5cywgc28gdGhh
dCBBUEkgdXNlcnMgY2FuIGNoZWNrIHRoYXQgc29tZXRoaW5nIGJhZCBoYXBwZW5pbmcgYW5kIAph
Ym9ydC7CoCBUaGUgRE1BIEFQSSB3YXMgbmV2ZXIgdmVyeSBnb29kIGF0IHByb3BlciBlcnJvciBo
YW5kbGluZywgYnV0IAp0aGVyZSdzIG5vIHJlYXNvbiBhdCBhbGwgdG8gY29udGludWUgYmVpbmcg
YmFkIGl0IGZvcmV2ZXIuCgpBRkFJSyB0aGUgcmVzdCBqdXN0IHdvcmtzIGFueXdheXMsIHNvIGl0
J3Mgbm90IHJlYWxseSBhIG5ldyBwcm9ibGVtIHRvIApiZSBzb2x2ZWQuCgo+Cj4+IEEgbmV3IGNh
bGxiYWNrIGlzIHVzZWQgdG8gYXZvaWQgY2hhbmdpbmcgYWxsIHRoZSBJT01NVSBkcml2ZXJzLgo+
Cj4gTml0OiBwcmVzdW1hYmx5IGJ5ICJJT01NVSBkcml2ZXJzIiB5b3UgYWN0dWFsbHkgbWVhbiBh
cmNoIERNQSBBUEkgCj4gYmFja2VuZHM/Clllcwo+Cj4gwqBGdXJ0aGVybW9yZSwgQUZBSUNTIGl0
J3Mgc3RpbGwgbm90IGdvaW5nIHRvIGhlbHAgYWdhaW5zdCBleGZpbHRyYXRpbmcgCj4gZ3Vlc3Qg
bWVtb3J5IGJ5IG92ZXItdW5tYXBwaW5nIHRoZSBvcmlnaW5hbCBTV0lPVExCIHNsb3QgKndpdGhv
dXQqIAo+IGdvaW5nIHBhc3QgdGhlIGVuZCBvZiB0aGUgd2hvbGUgYnVmZmVyLAoKVGhhdCB3b3Vs
ZCBiZSBqdXN0IGV4ZmlsdHJhdGluZyBkYXRhIHRoYXQgaXMgYWxyZWFkeSBzaGFyZWQsIHVubGVz
cyBJJ20gCm1pc3VuZGVyc3RhbmRpbmcgeW91LgoKLUFuZGkKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
