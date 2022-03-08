Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C2C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 00:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E9D04173C;
	Tue,  8 Mar 2022 00:31:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id duGse3chbx3r; Tue,  8 Mar 2022 00:31:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D341C41737;
	Tue,  8 Mar 2022 00:31:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1F50C0012;
	Tue,  8 Mar 2022 00:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98403C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 00:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77DA560BA3
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 00:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vs9Zsnd74lBs for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 00:31:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5CC9560B29
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 00:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646699484; x=1678235484;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oSu0Z2jGUkfhbuVOaedzXc4LteEqQxU2xU+auVYA8/8=;
 b=U9yulwL7j4BvFnyJpDekyAKW8xTG0OGrMCCn0iglzcFi4bOBXawNbRlS
 yqgNkbdI6CRRuNkTZmfuntRj0sLP+AZ9609OjjSwRnPeo5G3Mfua5cF/s
 9YyFYuvpl/Vt0KdnccPre1wMGlURCa++TYiC9F3cXj9Mfl4Pl0lVBDpuC
 Xbaf2Wvq4fBiuR57gR/JuNe8ELv62gv+bIFzoT+9qYOloIpTCPq5/2IO4
 w1+tW1WMSd9O1LTCRWswjYAZ6ZSD/tjEFLXqoKDmham+3HVl7ACxBUR2G
 8VdZJYsz6/IkIK2w6jYqHIqL+4EJ1XfglsY6WMttbn8NMSpTKPK6VAJiN g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254736070"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; d="scan'208";a="254736070"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 16:31:23 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; d="scan'208";a="711324392"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.195])
 ([10.254.209.195])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 16:31:16 -0800
Message-ID: <5fb85230-466c-9615-0867-bb17cab34be5@linux.intel.com>
Date: Tue, 8 Mar 2022 08:31:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
Content-Language: en-US
To: eric.auger@redhat.com, Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-2-baolu.lu@linux.intel.com>
 <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
 <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
 <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
 <350a8e09-08a9-082b-3ad1-b711c7d98d73@redhat.com>
 <e2698dbe-18e2-1a82-8a12-fe45bc9be534@arm.com>
 <b1a5db0a-0373-5ca0-6256-85a96d029ec9@linux.intel.com>
 <ac75c521-fb13-8414-a81b-9178cbed3471@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <ac75c521-fb13-8414-a81b-9178cbed3471@redhat.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
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

T24gMjAyMi8zLzcgMjA6NDIsIEVyaWMgQXVnZXIgd3JvdGU6Cj4gSGkgTHUsCj4gCj4gT24gMy83
LzIyIDQ6MjcgQU0sIEx1IEJhb2x1IHdyb3RlOgo+PiBIaSBSb2JpbiwKPj4KPj4gT24gMy80LzIy
IDEwOjEwIFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAyMDIyLTAzLTA0IDEzOjU1LCBF
cmljIEF1Z2VyIHdyb3RlOgo+Pj4+IEhpIFJvYmluLAo+Pj4+Cj4+Pj4gT24gMy80LzIyIDE6MjIg
UE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4+Pj4gT24gMjAyMi0wMy0wNCAxMDo0MywgTHUgQmFv
bHUgd3JvdGU6Cj4+Pj4+PiBIaSBFcmljLAo+Pj4+Pj4KPj4+Pj4+IE9uIDIwMjIvMy80IDE4OjM0
LCBFcmljIEF1Z2VyIHdyb3RlOgo+Pj4+Pj4+IEkgaGl0IGEgV0FSTl9PTigpIHdoZW4gdW5iaW5k
aW5nIGFuIGUxMDAwZSBkcml2ZXIganVzdCBhZnRlciBib290Ogo+Pj4+Pj4+Cj4+Pj4+Pj4gc3Vk
byBtb2Rwcm9iZSAtdiB2ZmlvLXBjaQo+Pj4+Pj4+IGVjaG8gdmZpby1wY2kgfCBzdWRvIHRlZSAt
YQo+Pj4+Pj4+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDQ6MDE6MDAuMC9kcml2ZXJfb3ZlcnJp
ZGUKPj4+Pj4+PiB2ZmlvLXBjaQo+Pj4+Pj4+IGVjaG8gMDAwNDowMTowMC4wIHwgc3VkbyB0ZWUg
LWHCoCAvc3lzL2J1cy9wY2kvZHJpdmVycy9lMTAwMGUvdW5iaW5kCj4+Pj4+Pj4KPj4+Pj4+Pgo+
Pj4+Pj4+IFvCoCAzOTAuMDQyODExXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0t
LS0KPj4+Pj4+PiBbwqAgMzkwLjA0NjQ2OF0gV0FSTklORzogQ1BVOiA0MiBQSUQ6IDU1ODkgYXQK
Pj4+Pj4+PiBkcml2ZXJzL2lvbW11L2lvbW11LmM6MzEyMwo+Pj4+Pj4+IGlvbW11X2RldmljZV91
bnVzZV9kZWZhdWx0X2RvbWFpbisweDY4LzB4MTAwCj4+Pj4+Pj4gW8KgIDM5MC4wNTY3MTBdIE1v
ZHVsZXMgbGlua2VkIGluOiB2ZmlvX3BjaSB2ZmlvX3BjaV9jb3JlIHZmaW9fdmlycWZkCj4+Pj4+
Pj4gdmZpb19pb21tdV90eXBlMSB2ZmlvIHh0X0NIRUNLU1VNIHh0X01BU1FVRVJBREUgeHRfY29u
bnRyYWNrCj4+Pj4+Pj4gaXB0X1JFSkVDVAo+Pj4+Pj4+IG5mX3JlamVjdF9pcHY0IG5mdF9jb21w
YXQgbmZ0X2NoYWluX25hdCBuZl9uYXQgbmZfY29ubnRyYWNrCj4+Pj4+Pj4gbmZfZGVmcmFnX2lw
djYgbmZfZGVmcmFnX2lwdjQgbmZfdGFibGVzIG5mbmV0bGluayBicmlkZ2Ugc3RwIGxsYwo+Pj4+
Pj4+IHJma2lsbAo+Pj4+Pj4+IHN1bnJwYyB2ZmF0IGZhdCBtbHg1X2liIGliX3V2ZXJicyBpYl9j
b3JlIGFjcGlfaXBtaSBpcG1pX3NzaWYKPj4+Pj4+PiBpcG1pX2RldmludGYgaXBtaV9tc2doYW5k
bGVyIGNwcGNfY3B1ZnJlcSBkcm0geGZzIGxpYmNyYzMyYwo+Pj4+Pj4+IG1seDVfY29yZSBzZwo+
Pj4+Pj4+IG1seGZ3IGNyY3QxMGRpZl9jZSB0bHMgZ2hhc2hfY2Ugc2hhMl9jZSBzaGEyNTZfYXJt
NjQgc2hhMV9jZQo+Pj4+Pj4+IHNic2FfZ3dkdAo+Pj4+Pj4+IGUxMDAwZSBwc2FtcGxlIHNkaGNp
X2FjcGkgYWhjaV9wbGF0Zm9ybSBzZGhjaSBsaWJhaGNpX3BsYXRmb3JtCj4+Pj4+Pj4gcWNvbV9l
bWFjCj4+Pj4+Pj4gbW1jX2NvcmUgaGRtYSBoZG1hX21nbXQgZG1fbWlycm9yIGRtX3JlZ2lvbl9o
YXNoIGRtX2xvZyBkbV9tb2QgZnVzZQo+Pj4+Pj4+IFvCoCAzOTAuMTEwNjE4XSBDUFU6IDQyIFBJ
RDogNTU4OSBDb21tOiB0ZWUgS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZAo+Pj4+Pj4+IDUuMTcu
MC1yYzQtbHUtdjctb2ZmaWNpYWwrICMyNAo+Pj4+Pj4+IFvCoCAzOTAuMTE5Mzg0XSBIYXJkd2Fy
ZSBuYW1lOiBXSVdZTk4gUURGMjQwMCBSZWZlcmVuY2UgRXZhbHVhdGlvbgo+Pj4+Pj4+IFBsYXRm
b3JtIENWOTAtTEExMTUtUDEyMC9RREYyNDAwIEN1c3RvbWVyIFJlZmVyZW5jZSBCb2FyZCwgQklP
Uwo+Pj4+Pj4+IDBBQ0pBNTcwCj4+Pj4+Pj4gMTEvMDUvMjAxOAo+Pj4+Pj4+IFvCoCAzOTAuMTMy
NDkyXSBwc3RhdGU6IGEwNDAwMDA1IChOekN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NC
Uwo+Pj4+Pj4+IEJUWVBFPS0tKQo+Pj4+Pj4+IFvCoCAzOTAuMTM5NDM2XSBwYyA6IGlvbW11X2Rl
dmljZV91bnVzZV9kZWZhdWx0X2RvbWFpbisweDY4LzB4MTAwCj4+Pj4+Pj4gW8KgIDM5MC4xNDUx
NjVdIGxyIDogaW9tbXVfZGV2aWNlX3VudXNlX2RlZmF1bHRfZG9tYWluKzB4MzgvMHgxMDAKPj4+
Pj4+PiBbwqAgMzkwLjE1MDg5NF0gc3AgOiBmZmZmODAwMDBmYmIzYmMwCj4+Pj4+Pj4gW8KgIDM5
MC4xNTQxOTNdIHgyOTogZmZmZjgwMDAwZmJiM2JjMCB4Mjg6IGZmZmYwM2MwY2Y2YjI0MDAgeDI3
Ogo+Pj4+Pj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4+Pj4+PiBbwqAgMzkwLjE2MTMxMV0geDI2OiAw
MDAwMDAwMDAwMDAwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6Cj4+Pj4+Pj4gZmZmZjAz
YzBjN2NjNTcyMAo+Pj4+Pj4+IFvCoCAzOTAuMTY4NDI5XSB4MjM6IGZmZmYwM2MwYzJiOWQxNTAg
eDIyOiBmZmZmYjRlNjFkZjIyM2Y4IHgyMToKPj4+Pj4+PiBmZmZmYjRlNjFkZjIyM2Y4Cj4+Pj4+
Pj4gW8KgIDM5MC4xNzU1NDddIHgyMDogZmZmZjAzYzdjMDNjMzc1OCB4MTk6IGZmZmYwM2M3YzAz
YzM3MDAgeDE4Ogo+Pj4+Pj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4+Pj4+PiBbwqAgMzkwLjE4MjY2
NV0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAwMCB4MTU6Cj4+Pj4+
Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4+Pj4+IFvCoCAzOTAuMTg5NzgzXSB4MTQ6IDAwMDAwMDAw
MDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAwMDMwIHgxMjoKPj4+Pj4+PiBmZmZmMDNjMGQ1MTlj
ZDgwCj4+Pj4+Pj4gW8KgIDM5MC4xOTY5MDFdIHgxMTogN2Y3ZjdmN2Y3ZjdmN2Y3ZiB4MTA6IDAw
MDAwMDAwMDAwMDBkYzAgeDkgOgo+Pj4+Pj4+IGZmZmZiNGU2MjBiNTRmOGMKPj4+Pj4+PiBbwqAg
MzkwLjIwNDAxOV0geDggOiBmZmZmMDNjMGNmNmIzMjIwIHg3IDogZmZmZjRlZjEzMmJiYTAwMCB4
NiA6Cj4+Pj4+Pj4gMDAwMDAwMDAwMDAwMDBmZgo+Pj4+Pj4+IFvCoCAzOTAuMjExMTM3XSB4NSA6
IGZmZmYwM2MwYzJiOWYxMDggeDQgOiBmZmZmMDNjMGQ1MWY2NDM4IHgzIDoKPj4+Pj4+PiAwMDAw
MDAwMDAwMDAwMDAwCj4+Pj4+Pj4gW8KgIDM5MC4yMTgyNTVdIHgyIDogZmZmZjAzYzBjZjZiMjQw
MCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOgo+Pj4+Pj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4+
Pj4+PiBbwqAgMzkwLjIyNTM3NF0gQ2FsbCB0cmFjZToKPj4+Pj4+PiBbwqAgMzkwLjIyNzgwNF3C
oCBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4rMHg2OC8weDEwMAo+Pj4+Pj4+IFvC
oCAzOTAuMjMzMTg3XcKgIHBjaV9kbWFfY2xlYW51cCsweDM4LzB4NDQKPj4+Pj4+PiBbwqAgMzkw
LjIzNjkxOV3CoCBfX2RldmljZV9yZWxlYXNlX2RyaXZlcisweDFhOC8weDI2MAo+Pj4+Pj4+IFvC
oCAzOTAuMjQxNTE5XcKgIGRldmljZV9kcml2ZXJfZGV0YWNoKzB4NTAvMHhkMAo+Pj4+Pj4+IFvC
oCAzOTAuMjQ1Njg2XcKgIHVuYmluZF9zdG9yZSsweGY4LzB4MTIwCj4+Pj4+Pj4gW8KgIDM5MC4y
NDkyNDVdwqAgZHJ2X2F0dHJfc3RvcmUrMHgzMC8weDQ0Cj4+Pj4+Pj4gW8KgIDM5MC4yNTI4OTFd
wqAgc3lzZnNfa2Zfd3JpdGUrMHg1MC8weDYwCj4+Pj4+Pj4gW8KgIDM5MC4yNTY1MzddwqAga2Vy
bmZzX2ZvcF93cml0ZV9pdGVyKzB4MTM0LzB4MWNjCj4+Pj4+Pj4gW8KgIDM5MC4yNjA5NjRdwqAg
bmV3X3N5bmNfd3JpdGUrMHhmMC8weDE4Ywo+Pj4+Pj4+IFvCoCAzOTAuMjY0Njk2XcKgIHZmc193
cml0ZSsweDIzMC8weDJkMAo+Pj4+Pj4+IFvCoCAzOTAuMjY4MDgyXcKgIGtzeXNfd3JpdGUrMHg3
NC8weDEwMAo+Pj4+Pj4+IFvCoCAzOTAuMjcxNDY3XcKgIF9fYXJtNjRfc3lzX3dyaXRlKzB4Mjgv
MHgzYwo+Pj4+Pj4+IFvCoCAzOTAuMjc1MzczXcKgIGludm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4w
KzB4NTgvMHhmMAo+Pj4+Pj4+IFvCoCAzOTAuMjgwMDYxXcKgIGVsMF9zdmNfY29tbW9uLmNvbnN0
cHJvcC4wKzB4MTYwLzB4MTY0Cj4+Pj4+Pj4gW8KgIDM5MC4yODQ5MjJdwqAgZG9fZWwwX3N2Yysw
eDM0LzB4Y2MKPj4+Pj4+PiBbwqAgMzkwLjI4ODIyMV3CoCBlbDBfc3ZjKzB4MzAvMHgxNDAKPj4+
Pj4+PiBbwqAgMzkwLjI5MTM0Nl3CoCBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGE0LzB4MTMwCj4+
Pj4+Pj4gW8KgIDM5MC4yOTU1OTldwqAgZWwwdF82NF9zeW5jKzB4MWEwLzB4MWE0Cj4+Pj4+Pj4g
W8KgIDM5MC4yOTkyNDVdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQo+Pj4+
Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBJIHB1dCBzb21lIHRyYWNlcyBpbiB0aGUgY29kZSBhbmQgSSBj
YW4gc2VlIHRoYXQKPj4+Pj4+PiBpb21tdV9kZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluKCkgZWZm
ZWN0aXZlbHkgaXMgY2FsbGVkIG9uCj4+Pj4+Pj4gMDAwNDowMTowMC4wIGUxMDAwZSBkZXZpY2Ug
b24gcGNpX2RtYV9jb25maWd1cmUoKSBidXQgYXQgdGhhdCB0aW1lCj4+Pj4+Pj4gdGhlIGlvbW11
IGdyb3VwIGlzIE5VTEw6Cj4+Pj4+Pj4gW8KgwqAgMTAuNTY5NDI3XSBlMTAwMGUgMDAwNDowMTow
MC4wOiAtLS0tLS0gRU5UUlkgcGNpX2RtYV9jb25maWd1cmUKPj4+Pj4+PiBkcml2ZXJfbWFuYWdl
ZF9hcmVhPTAKPj4+Pj4+PiBbwqDCoCAxMC41Njk0MzFdIGUxMDAwZSAwMDA0OjAxOjAwLjA6ICoq
KioKPj4+Pj4+PiBpb21tdV9kZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluIEVOVFJZCj4+Pj4+Pj4g
W8KgwqAgMTAuNTY5NDMzXSBlMTAwMGUgMDAwNDowMTowMC4wOiAqKioqCj4+Pj4+Pj4gaW9tbXVf
ZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiBubyBncm91cAo+Pj4+Pj4+IFvCoMKgIDEwLjU2OTQz
NV0gZTEwMDBlIDAwMDQ6MDE6MDAuMDogcGNpX2RtYV9jb25maWd1cmUKPj4+Pj4+PiBpb21tdV9k
ZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluIHJldHVybmVkIDAKPj4+Pj4+PiBbwqDCoCAxMC41Njk0
OTJdIGUxMDAwZSAwMDA0OjAxOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAzCj4+Pj4+Pj4K
Pj4+Pj4+PiBeXl50aGUgZ3JvdXAgaXMgYWRkZWQgYWZ0ZXIgdGhlCj4+Pj4+Pj4gaW9tbXVfZGV2
aWNlX3VzZV9kZWZhdWx0X2RvbWFpbigpIGNhbGwKPj4+Pj4+PiBTbyB0aGUgZ3JvdXAtPm93bmVy
X2NudCBpcyBub3QgaW5jcmVtZW50ZWQgYXMgZXhwZWN0ZWQuCj4+Pj4+Pgo+Pj4+Pj4gVGhhbmsg
eW91IGZvciByZXBvcnRpbmcgdGhpcy4gRG8geW91IGhhdmUgYW55IGlkZWEgd2h5IHRoZSBkcml2
ZXIgaXMKPj4+Pj4+IGxvYWRlZCBiZWZvcmUgaW9tbXVfcHJvYmVfZGV2aWNlKCk/Cj4+Pj4+Cj4+
Pj4+IFVyZ2gsIHRoaXMgaXMgdGhlIGhvcnJpYmxlIGZpcm13YXJlLWRhdGEtb3JkZXJpbmcgdGhp
bmcgYWdhaW4uIFRoZQo+Pj4+PiBzdHVmZiBJJ3ZlIGJlZW4gc2F5aW5nIGFib3V0IGhhdmluZyB0
byByZXdvcmsgdGhlIHdob2xlIC5kbWFfY29uZmlndXJlCj4+Pj4+IG1lY2hhbmlzbSBpbiB0aGUg
bmVhciBmdXR1cmUgaXMgdG8gZml4IHRoaXMgcHJvcGVybHkuCj4+Pj4+Cj4+Pj4+IFRoZSBzdW1t
YXJ5IGlzIHRoYXQgaW4gcGF0Y2ggIzQsIGNhbGxpbmcKPj4+Pj4gaW9tbXVfZGV2aWNlX3VzZV9k
ZWZhdWx0X2RvbWFpbigpICpiZWZvcmUqIHtvZixhY3BpfV9kbWFfY29uZmlndXJlIGlzCj4+Pj4+
IGN1cnJlbnRseSBhIHByb2JsZW0uIEFzIHRoaW5ncyBzdGFuZCwgdGhlIElPTU1VIGRyaXZlciBp
Z25vcmVkIHRoZQo+Pj4+PiBpbml0aWFsIGlvbW11X3Byb2JlX2RldmljZSgpIGNhbGwgd2hlbiB0
aGUgZGV2aWNlIHdhcyBhZGRlZCwgc2luY2UgYXQKPj4+Pj4gdGhhdCBwb2ludCBpdCBoYWQgbm8g
ZndzcGVjIHlldC4gSW4gdGhpcyBzaXR1YXRpb24sCj4+Pj4+IHtvZixhY3BpfV9pb21tdV9jb25m
aWd1cmUoKSBhcmUgcmV0cmlnZ2VyaW5nIGlvbW11X3Byb2JlX2RldmljZSgpCj4+Pj4+IGFmdGVy
IHRoZSBJT01NVSBkcml2ZXIgaGFzIHNlZW4gdGhlIGZpcm13YXJlIGRhdGEgdmlhIC5vZl94bGF0
ZSB0bwo+Pj4+PiBsZWFybiB0aGF0IGl0IGl0IGFjdHVhbGx5IHJlc3BvbnNpYmxlIGZvciB0aGUg
Z2l2ZW4gZGV2aWNlLgo+Pj4+Cj4+Pj4gdGhhbmsgeW91IGZvciBwcm92aWRpbmcgdGhlIGluZm8u
IEhvcGUgdGhpcyBpcyBzb21ldGhpbmcgTHUgY2FuIHdvcmsKPj4+PiBhcm91bmQuCj4+Pgo+Pj4g
SG9wZWZ1bGx5IGl0J3MganVzdCBhIGNhc2Ugb2YgZmxpcHBpbmcgdGhlIGNhbGxzIGFyb3VuZCwg
c28gdGhhdAo+Pj4gaW9tbXVfdXNlX2RlZmF1bHRfZG9tYWluKCkgZ29lcyBhdCB0aGUgZW5kLCBh
bmQgY2FsbHMKPj4+IGFyY2hfdGVhcmRvd25fZG1hX29wcygpIGlmIGl0IGZhaWxzLiBGcm9tIGEg
cXVpY2sgc2tpbSBJICp0aGluayogdGhhdAo+Pj4gc2hvdWxkIHN0aWxsIHdvcmsgb3V0IHRvIHRo
ZSBkZXNpcmVkIGJlaGF2aW91ciAob3IgYXQgbGVhc3QgY2xvc2UKPj4+IGVub3VnaCB0aGF0IHdl
IGNhbiBtb3ZlIGZvcndhcmQgd2l0aG91dCBhIGNpcmN1bGFyIGRlcGVuZGVuY3kgYmV0d2Vlbgo+
Pj4gZml4ZXMuLi4pCj4+Cj4+IFRoaXMgaXMgYSByZWFzb25hYmxlIHNvbHV0aW9uIHRvIG1lLiBU
aGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbiBhbmQKPj4gc3VnZ2VzdGlvbi4KPj4KPj4gRXJp
YywgSSBoYXZlIHVwZGF0ZWQgdGhlIHBhdGNoICM0IGFuZCB1cGxvYWRlZCBhIG5ldyB2ZXJzaW9u
IGhlcmU6Cj4+Cj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9MdUJhb2x1L2ludGVsLWlvbW11L2NvbW1p
dHMvaW9tbXUtZG1hLW93bmVyc2hpcC12OAo+IAo+IHdpdGggdjggSSBkbyBub3QgaGl0IHRoZSB3
YXJuaW5nIGFueW1vcmUgYW5kIHRoZSBvd25lciBhY2NvdW50aW5nIHNlZW1zCj4gdG8gd29yayBh
cyBleHBlY3RlZC4KClRoYW5rIHlvdSwgRXJpYyEgSSB3aWxsIHBvc3QgdGhlIHY4IHNvb24uCgpC
ZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
