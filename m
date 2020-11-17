Return-Path: <SRS0=JfyE=EX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA34C63697
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 20:30:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1631F2225E
	for <iommu@archiver.kernel.org>; Tue, 17 Nov 2020 20:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zj0QOE2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1631F2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 75F49207A6;
	Tue, 17 Nov 2020 20:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dicCOCJQ8+ZA; Tue, 17 Nov 2020 20:30:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 43FED2039A;
	Tue, 17 Nov 2020 20:30:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28AEBC0891;
	Tue, 17 Nov 2020 20:30:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8785C07FF
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 20:30:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CC35385551
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 20:30:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e8WGwe_k8eAy for <iommu@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 20:30:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0DA0D85531
 for <iommu@lists.linux-foundation.org>; Tue, 17 Nov 2020 20:30:17 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKORws128609;
 Tue, 17 Nov 2020 20:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to : content-transfer-encoding; s=corp-2020-01-29;
 bh=/9ouyw75sZcj64B7J3W0GYiJN8Cf86XbWdloBIz8was=;
 b=zj0QOE2bh0JBJey8IOaUA6r/ystzgD5gpvEzU19rRmVQqand2cCeG49nXMJ4WqNraXpV
 IDK1j28YlJPajIltbcu3+To0hmN14gYMNmDPo+uV1m0aj1RDAZBRE8rYPdWM/yibPidP
 R8e0BFr9pSFkdjy12jpO0nKmC1ScTtYnCmgqGrVXNcbqh0qHV7EEZzyFT3NFb/TaUbu9
 yDYTJbKtGSBmYZ69ECqCPNRBIlhcOH8CxK7rzSTqkWn9WMMBaQFPzRpmfAYkKzKvEvka
 gLIXCgL/GYbsXKfELoGg1q2tC5KTsj657Imuui6PN0ecrcZfydubwYhELrqU1VwMHKv9 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2130.oracle.com with ESMTP id 34t4ravu78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 17 Nov 2020 20:29:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AHKLGtT159075;
 Tue, 17 Nov 2020 20:29:46 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 34umcypfdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Nov 2020 20:29:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AHKTXiv026531;
 Tue, 17 Nov 2020 20:29:33 GMT
Received: from char.us.oracle.com (/10.152.32.25)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 17 Nov 2020 12:29:32 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
 id 9CE916A00FA; Tue, 17 Nov 2020 15:31:24 -0500 (EST)
Date: Tue, 17 Nov 2020 15:31:24 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: "Kalra, Ashish" <Ashish.Kalra@amd.com>
Subject: Re: [PATCH v3] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201117203123.GB16539@char.us.oracle.com>
References: <20201105184115.GA25261@ashkalra_ubuntu_server>
 <20201105190649.GB5366@char.us.oracle.com>
 <20201105193828.GA25303@ashkalra_ubuntu_server>
 <20201105202007.GA6370@char.us.oracle.com>
 <20201105212045.GB25303@ashkalra_ubuntu_server>
 <20201113211925.GA6096@char.us.oracle.com>
 <20201117153302.GA29293@ashkalra_ubuntu_server>
 <20201117170003.GF10360@char.us.oracle.com>
 <20201117173829.GA29387@ashkalra_ubuntu_server>
 <7EAA7A38-50B7-4291-9A4E-34668455B59D@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7EAA7A38-50B7-4291-9A4E-34668455B59D@amd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011170149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9808
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170149
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Grimm,
 Jon" <Jon.Grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "ssg.sos.patches" <ssg.sos.patches@amd.com>,
 "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "hch@lst.de" <hch@lst.de>
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

T24gVHVlLCBOb3YgMTcsIDIwMjAgYXQgMDc6MDQ6NTlQTSArMDAwMCwgS2FscmEsIEFzaGlzaCB3
cm90ZToKPiBIZWxsbyBLb25yYWQsCj4gCj4gQWN0dWFsbHkgSSBkaWRu4oCZdCBnZXQgdGhhdCwg
ZG8geW91IG1lYW4geW91IGFyZSB0YWtpbmcgMUcgYW5kIDw9NEcgY2FzZXMgb3V0IG9mIHRoZSBw
YXRjaCBhbmQgb25seSBnb2luZyB0byBhcHBseSB0aGUgPjRHIGNhc2UgYXMgcGFydCBvZiB0aGUg
cGF0Y2ggPwoKVGhhdCB3YXMgdGhlIHRob3VnaHQsIGJ1dCBub3cgSSBhbSB3b25kZXJpbmcgaG93
IFREWCBpcyBnb2luZyB0byB3b3JrCndpdGggdGhpcy4gVGhhdCBpcyB0aGUgX193ZWFrIHdvbid0
IHdvcmsgb24gZGlzdHJvIGtlcm5lbCB0aGF0IGhhcyB0bwpydW4gb24gYm90aCBBTUQgYW5kIElu
dGVsLiBIbW0uCgpMZXQgbWUgYnJ1c2ggb2ZmIHRoZSBsYXRlLVNXSU9UTEIgcGF0Y2hlcyB0aGF0
IGludGVybmFsbHkgd2UgZGV2ZWxvcGVkIHNvbWUgdGltZSBhZ28uCgo+IAo+IFRoYW5rcywKPiBB
c2hpc2ggCj4gCj4gPiBPbiBOb3YgMTcsIDIwMjAsIGF0IDExOjM4IEFNLCBLYWxyYSwgQXNoaXNo
IDxBc2hpc2guS2FscmFAYW1kLmNvbT4gd3JvdGU6Cj4gPiAKPiA+IO+7v0hlbGxvIEtvbnJhZCwg
Cj4gPiAKPiA+PiBPbiBUdWUsIE5vdiAxNywgMjAyMCBhdCAxMjowMDowM1BNIC0wNTAwLCBLb25y
YWQgUnplc3p1dGVrIFdpbGsgd3JvdGU6Cj4gPj4gLnNuaXAuLgo+ID4+Pj4+PiBMZXRzIGJyZWFr
IHRoaXMgZG93bjoKPiA+Pj4+Pj4gCj4gPj4+Pj4+IEhvdyBkb2VzIHRoZSBwZXJmb3JtYW5jZSBp
bXByb3ZlIGZvciBvbmUgc2luZ2xlIGRldmljZSBpZiB5b3UgaW5jcmVhc2UgdGhlIFNXSU9UTEI/
Cj4gPj4+Pj4+IElzIHRoZXJlIGEgc3BlY2lmaWMgZGV2aWNlL2RyaXZlciB0aGF0IHlvdSBjYW4g
dGFsayBhYm91dCB0aGF0IGltcHJvdmUgd2l0aCB0aGlzIHBhdGNoPwo+ID4+Pj4+PiAKPiA+Pj4+
Pj4gCj4gPj4+Pj4gCj4gPj4+Pj4gWWVzLCB0aGVzZSBhcmUgbWFpbmx5IGZvciBtdWx0aS1xdWV1
ZSBkZXZpY2VzIHN1Y2ggYXMgTklDcyBvciBldmVuCj4gPj4+Pj4gbXVsdGktcXVldWUgdmlydGlv
LiAKPiA+Pj4+PiAKPiA+Pj4+PiBUaGlzIGJhc2ljYWxseSBpbXByb3ZlcyBwZXJmb3JtYW5jZSB3
aXRoIGNvbmN1cnJlbnQgRE1BLCBoZW5jZSwKPiA+Pj4+PiBiYXNpY2FsbHkgbXVsdGktcXVldWUg
ZGV2aWNlcy4KPiA+Pj4+IAo+ID4+Pj4gT0ssIGFuZCBmb3IgXzFHQl8gZ3Vlc3QgLSB3aGF0IGFy
ZSB0aGUgImludGVybmFsIHRlYW1zL2V4dGVybmFsIGN1c3RvbWVycyIgYW1vdW50IAo+ID4+Pj4g
b2YgQ1BVcyB0aGV5IHVzZT8gUGxlYXNlIGxldHMgdXNlIHJlYWwgdXNlLWNhc2VzLgo+ID4+PiAK
PiA+Pj4+PiBJIGFtIHN1cmUgeW91IHdpbGwgdW5kZXJzdGFuZCB3ZSBjYW5ub3Qgc2hhcmUgYW55
IGV4dGVybmFsIGN1c3RvbWVyCj4gPj4+Pj4gZGF0YSBhcyBhbGwgdGhhdCBjdXN0b21lciBpbmZv
cm1hdGlvbiBpcyBwcm9wcmlldGFyeS4KPiA+Pj4+PiAKPiA+Pj4+PiBJbiBzaW1pbGFyIHNpdHVh
dGlvbiBpZiB5b3UgaGF2ZSB0byBzaGFyZSBPcmFjbGUgZGF0YSwgeW91IHdpbGwKPiA+Pj4+PiBz
dXJlbHkgaGF2ZSB0aGUgc2FtZSBjb25jZXJucyBhbmQgaSBkb24ndCB0aGluayB5b3Ugd2lsbCBi
ZSBhYmxlCj4gPj4+Pj4gdG8gc2hhcmUgYW55IHN1Y2ggaW5mb3JtYXRpb24gZXh0ZXJuYWxseSwg
aS5lLiwgb3V0c2lkZSBPcmFjbGUuCj4gPj4+Pj4gCj4gPj4+PiBJIGFtIGFza2luZyBmb3IgYSBz
aW1wbGUgcXVlcnkgLSB3aGF0IGFtb3VudCBvZiBDUFVzIGRvZXMgYSAxR0IKPiA+Pj4+IGd1ZXN0
IGhhdmU/IFRoZSByZWFzb24gZm9yIHRoaXMgc2hvdWxkIGJlIGZhaXJseSBvYnZpb3VzIC0gaWYK
PiA+Pj4+IGl0IGlzIGEgMXZDUFUsIHRoZW4gdGhlcmUgaXMgbm8gbXVsdGktcXVldWUgYW5kIHRo
ZSBleGlzdGluZwo+ID4+Pj4gU1dJT1RMQiBwb29sIHNpemUgYXMgaXQgaXMgT0suCj4gPj4+PiAK
PiA+Pj4+IElmIGhvd2V2ZXIgdGhlcmUgYXJlIHNheSAyIGFuZCBtdWx0aXF1ZXVlIGlzIGVuYWJs
ZWQsIHRoYXQKPiA+Pj4+IGdpdmVzIG1lIGFuIGlkZWEgb2YgaG93IG1hbnkgeW91IHVzZSBhbmQg
SSBjYW4gZmluZCBvdXQgd2hhdAo+ID4+Pj4gdGhlIG1heGltdW0gcG9vbCBzaXplIHVzYWdlIG9m
IHZpcnRpbyB0aGVyZSBpcyB3aXRoIHRoYXQgY29uZmlndXJhdGlvbi4KPiA+Pj4gCj4gPj4+IEFn
YWluIHdlIGNhbm5vdCBzaGFyZSBhbnkgY3VzdG9tZXIgZGF0YS4KPiA+Pj4gCj4gPj4+IEFsc28g
aSBkb24ndCB0aGluayB0aGVyZSBjYW4gYmUgYSBkZWZpbml0aXZlIGFuc3dlciB0byBob3cgbWFu
eSB2Q1BVcyBhCj4gPj4+IDFHQiBndWVzdCB3aWxsIGhhdmUsIGl0IHdpbGwgZGVwZW5kIG9uIHdo
YXQga2luZCBvZiBjb25maWd1cmF0aW9uIHdlIGFyZQo+ID4+PiB0ZXN0aW5nLgo+ID4+PiAKPiA+
Pj4gRm9yIGV4YW1wbGUsIGkgdXN1YWxseSBzZXR1cCA0LTE2IHZDUFVzIGZvciBhcyBsb3cgYXMg
NTEyTSBjb25maWd1cmVkCj4gPj4+IGd1ZWVzdCBtZW1vcnkuCj4gPj4gCj4gPj4gU3VyZSwgYnV0
IHlvdSBhcmUgbm90IHRoZSBub3JtYWwgdXNlci4KPiA+PiAKPiA+PiBUaGF0IGlzIEkgZG9uJ3Qg
bGlrZSB0aGF0IGZvciAxR0IgZ3Vlc3RzIHlvdXIgcGF0Y2ggZW5kcyB1cCBkb3VibGluZyB0aGUK
PiA+PiBTV0lPVExCIG1lbW9yeSBwb29sLiBUaGF0IHNlZW1zIHRvIG1lIHdlIGFyZSB0cnlpbmcg
dG8gc29sdmUgYSBwcm9ibGVtCj4gPj4gdGhhdCBub3JtYWwgdXNlcnMgd2lsbCBub3QgaGl0LiBU
aGF0IGlzIHdoeSBJIHdhbnQgJ2hlcmUgaXMgdGhlIGN1c3RvbWVyCj4gPj4gYnVnJy4KPiA+PiAK
PiA+PiBIZXJlIGlzIHdoYXQgSSBhbSBnb2luZyB0byBkbyAtIEkgd2lsbCB0YWtlIG91dCB0aGUg
MUdCIGFuZCA0R0IgY2FzZSBvdXQgb2YKPiA+PiB5b3VyIHBhdGNoIGFuZCBjYWxsIGl0IGEgZGF5
LiBJZiB0aGVyZSBhcmUgY3VzdG9tZXJzIHdobyBzdGFydCByZXBvcnRpbmcgaXNzdWVzCj4gPj4g
d2UgY2FuIHJldmlzdCB0aGF0LiBOb3RoaW5nIHdyb25nIHdpdGggJ1JlcG9ydGVkLWJ5JyBYWlkg
KHdlIG9mdGVuIGFzayB0aGUKPiA+PiBjdXN0b21lciBpZiBoZSBvciBzaGUgd291bGQgbGlrZSB0
byBiZSByZWNvZ25pemVkIG9uIHVwc3RyZWFtIGJ1Z3MpLgo+ID4+IAo+ID4gCj4gPiBPay4KPiA+
IAo+ID4+IEFuZCBpbiB0aGUgbWVhbnRpbWUgSSBhbSBnb2luZyB0byBsb29rIGFib3V0IGFkZGlu
ZyAuLgo+ID4+PiAKPiA+Pj4gSSBoYXZlIGJlZW4gYWxzbyB0ZXN0aW5nIHdpdGggMTYgdkNQVXMg
Y29uZmlndXJhdGlvbiBmb3IgNTEyTS0xRyBndWVzdAo+ID4+PiBtZW1vcnkgd2l0aCBNZWxsYW5v
eCBTUklPViBOSUNzLCBhbmQgdGhpcyB3aWxsIGJlIGEgbXVsdGktcXVldWUgTklDCj4gPj4+IGRl
dmljZSBlbnZpcm9ubWVudC4KPiA+PiAKPiA+PiAuLiBsYXRlIFNXSU9UTEIgZXhwYW5zaW9uIHRv
IHN0aWNoIHRoZSBETUEgcG9vbHMgdG9nZXRoZXIgYXMgYm90aAo+ID4+IE1lbGxhbm94IGFuZCBW
aXJ0SU8gYXJlIG5vdCAzMi1iaXQgRE1BIGJvdW5kLgo+ID4+IAo+ID4+PiAKPiA+Pj4gU28gd2Ug
bWlnaHQgYmUgaGF2aW5nIGxlc3MgY29uZmlndXJlZCBndWVzdCBtZW1vcnksIGJ1dCB3ZSBzdGls
bCBtaWdodAo+ID4+PiBiZSB1c2luZyB0aGF0IGNvbmZpZ3VyYXRpb24gd2l0aCBJL08gaW50ZW5z
aXZlIHdvcmtsb2Fkcy4KPiA+Pj4gCj4gPiAKPiA+IEkgYW0gZ29pbmcgdG8gc3VibWl0IHY0IG9m
IG15IGN1cnJlbnQgcGF0Y2gtc2V0IHdoaWNoIHVzZXMgbWF4KCkgaW5zdGVhZAo+ID4gb2YgY2xh
bXAoKSBhbmQgYWxzbyByZXBsYWNlcyBjb25zdGFudHMgZGVmaW5lZCBpbiB0aGlzIHBhdGNoIHdp
dGggdGhlCj4gPiBwcmUtZGVmaW5lZCBvbmVzIGluIHNpemVzLmgKPiA+IAo+ID4gVGhhbmtzLAo+
ID4gQXNoaXNoCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
