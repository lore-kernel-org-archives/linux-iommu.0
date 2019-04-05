Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC37C4360F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:58:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977822175B
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 15:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5fGlsPen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977822175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 682682573;
	Fri,  5 Apr 2019 15:58:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DE56A2552
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:57:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5288DFD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 15:57:37 +0000 (UTC)
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
	by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x35Fresr028235; Fri, 5 Apr 2019 15:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=subject : to : cc :
	references : from : message-id : date : mime-version : in-reply-to :
	content-type : content-transfer-encoding; s=corp-2018-07-02;
	bh=WRUJkxssls3GC9KBeX15T16DarlkEO0tjOUvcslQoD0=;
	b=5fGlsPeny3lKV5g4pGEfyGSW7lDg4Vp/7R/YLGfDWdSQfJAi/h22T55ffkv4ltHWyIOU
	rAe160eHi+OPda5VW5bIJ17tYKirqxZ3FfAmTkzs3T6JmXour2Y6F7BGar33JBZhE+YQ
	X0nX1ToN5pxh4JoumB4NPi/UH8mcFqjhbd2xY/YdbpNbXIhHHk5XmYaBot//EigNftSN
	WeBM4E8n2cTDaMS408OIlTHpzhP0XJ7TRglzPkQQr0vB5xqqKDd2cOL8aiLheHbITKm8
	wX4fV0Ua8BAynkxn7APv9evY2t3Egcwyd0V/2DPRWfWJP8HZljD4cqzl1PCstN4ssI2v
	zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2130.oracle.com with ESMTP id 2rhwydnud9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2019 15:56:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id
	x35FtN0b049678; Fri, 5 Apr 2019 15:56:19 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserp3030.oracle.com with ESMTP id 2rp34jepkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2019 15:56:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x35FuApl008745;
	Fri, 5 Apr 2019 15:56:10 GMT
Received: from [192.168.1.16] (/24.9.64.241)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 05 Apr 2019 08:56:09 -0700
Subject: Re: [RFC PATCH v9 12/13] xpfo, mm: Defer TLB flushes for non-current
	CPUs (x86 only)
To: Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
	<4495dda4bfc4a06b3312cc4063915b306ecfaecb.1554248002.git.khalid.aziz@oracle.com>
	<CALCETrXMXxnWqN94d83UvGWhkD1BNWiwvH2vsUth1w0T3=0ywQ@mail.gmail.com>
	<91f1dbce-332e-25d1-15f6-0e9cfc8b797b@oracle.com>
	<alpine.DEB.2.21.1904050909520.1802@nanos.tec.linutronix.de>
	<26b00051-b03c-9fce-1446-52f0d6ed52f8@intel.com>
	<DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <66dba8f0-18dc-e623-9a1a-21e3e7ba7790@oracle.com>
Date: Fri, 5 Apr 2019 09:56:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DFA69954-3F0F-4B79-A9B5-893D33D87E51@amacapital.net>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
	malwarescore=0
	phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
	adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
	engine=8.0.1-1810050000 definitions=main-1904050108
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218
	signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
	priorityscore=1501 malwarescore=0
	suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
	lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
	adultscore=0
	classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
	definitions=main-1904050108
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, steven.sistare@oracle.com,
	Christoph Hellwig <hch@lst.de>, Tycho Andersen <tycho@tycho.ws>,
	Andi Kleen <ak@linux.intel.com>, aneesh.kumar@linux.ibm.com,
	James Morris <jmorris@namei.org>,
	David Rientjes <rientjes@google.com>, anthony.yznaga@oracle.com,
	Rik van Riel <riel@surriel.com>, Nicholas Piggin <npiggin@gmail.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Souptick Joarder <jrdr.linux@gmail.com>,
	Jiri Kosina <jkosina@suse.cz>, Joe Perches <joe@perches.com>,
	arunks@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	Mark Rutland <mark.rutland@arm.com>, Keith Busch <keith.busch@intel.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	"H. Peter Anvin" <hpa@zytor.com>, brgl@bgdev.pl,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	jsteckli@amazon.de, Joerg Roedel <jroedel@suse.de>,
	Kees Cook <keescook@google.com>, zhangshaokun@hisilicon.com,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	chris hyser <chris.hyser@oracle.com>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Khalid Aziz <khalid@gonehiking.org>, Aaron Lu <aaron.lu@intel.com>,
	Steve Capper <steve.capper@arm.com>, James Morse <james.morse@arm.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Michal Hocko <mhocko@suse.cz>, alexander.h.duyck@linux.intel.com,
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
	kanth.ghatraju@oracle.com, Huang Ying <ying.huang@intel.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Ben Hutchings <ben@decadent.org.uk>, "Serge E. Hallyn" <serge@hallyn.com>,
	Arnd Bergmann <arnd@arndb.de>, Andrey Konovalov <andreyknvl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>, osalvador@suse.de,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	iommu@lists.linux-foundation.org,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Logan Gunthorpe <logang@deltatee.com>, Roman Gushchin <guro@fb.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Linux-MM <linux-mm@kvack.org>, deepa.srinivasan@oracle.com,
	cpandya@codeaurora.org, X86 ML <x86@kernel.org>,
	yaojun8558363@gmail.com, Ingo Molnar <mingo@redhat.com>,
	Jon Masters <jcm@redhat.com>, thymovanbeers@gmail.com,
	Laura Abbott <labbott@redhat.com>, pradeep.vincent@oracle.com,
	pavel.tatashin@microsoft.com, Jann Horn <jannh@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jim Mattson <jmattson@google.com>,
	Juergen Gross <jgross@suse.com>, marco.antonio.780@gmail.com,
	Juerg Haefliger <juergh@gmail.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tyler Hicks <tyhicks@canonical.com>, John Haxby <john.haxby@oracle.com>,
	LSM List <linux-security-module@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, liran.alon@oracle.com,
	Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <20190405155603.IThjMESN5iWHprGcq5y1_8RLDeCr8-W2Y9TrGch3aHI@z>

T24gNC81LzE5IDk6MjQgQU0sIEFuZHkgTHV0b21pcnNraSB3cm90ZToKPiAKPiAKPj4gT24gQXBy
IDUsIDIwMTksIGF0IDg6NDQgQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+
IHdyb3RlOgo+Pgo+PiBPbiA0LzUvMTkgMTI6MTcgQU0sIFRob21hcyBHbGVpeG5lciB3cm90ZToK
Pj4+PiBwcm9jZXNzLiBJcyB0aGF0IGFuIGFjY2VwdGFibGUgdHJhZGUtb2ZmPwo+Pj4gWW91IGFy
ZSBub3Qgc2VyaW91c2x5IGFza2luZyB3aGV0aGVyIGNyZWF0aW5nIGEgdXNlciBjb250cm9sbGFi
bGUgcmV0MmRpcgo+Pj4gYXR0YWNrIHdpbmRvdyBpcyBhIGFjY2VwdGFibGUgdHJhZGUtb2ZmPyBB
cHJpbCAxc3Qgd2FzIGEgZmV3IGRheXMgYWdvLgo+Pgo+PiBXZWxsLCBsZXQncyBub3QgZm9yZ2V0
IHRoYXQgdGhpcyBzZXQgYXQgbGVhc3QgdGFrZXMgdXMgZnJvbSAiYWx3YXlzCj4+IHZ1bG5lcmFi
bGUgdG8gcmV0MmRpciIgdG8gYSBjaG9pY2UgYmV0d2VlbjoKPj4KPj4gMS4gZmFzdC1pc2ggYW5k
ICJ2dWxuZXJhYmxlIHRvIHJldDJkaXIgZm9yIGEgdXNlci1jb250cm9sbGFibGUgd2luZG93Igo+
PiAyLiBzbG93IGFuZCAibWl0aWdhdGVkIGFnYWluc3QgcmV0MmRpciIKPj4KPj4gU291bmRzIGxp
a2Ugd2UgbmVlZCBhIG1lY2hhbmlzbSB0aGF0IHdpbGwgZG8gdGhlIGRlZmVycmVkIFhQRk8gVExC
Cj4+IGZsdXNoZXMgd2hlbmV2ZXIgdGhlIGtlcm5lbCBpcyBlbnRlcmVkLCBhbmQgbm90IF9qdXN0
XyBhdCBjb250ZXh0IHN3aXRjaAo+PiB0aW1lLiAgVGhpcyBwZXJtaXRzIGFuIGFwcCB0byBydW4g
aW4gdXNlcnNwYWNlIHdpdGggc3RhbGUga2VybmVsIFRMQgo+PiBlbnRyaWVzIGFzIGxvbmcgYXMg
aXQgd2FudHMuLi4gdGhhdCdzIGhhcm1sZXNzLgo+IAo+IEkgZG9u4oCZdCB0aGluayB0aGlzIGlz
IGdvb2QgZW5vdWdoLiBUaGUgYmFkIGd1eXMgY2FuIGVudGVyIHRoZSBrZXJuZWwgYW5kIGFycmFu
Z2UgZm9yIHRoZSBrZXJuZWwgdG8gd2FpdCwgKmluIGtlcm5lbCosIGZvciBsb25nIGVub3VnaCB0
byBzZXQgdXAgdGhlIGF0dGFjay4gIHVzZXJmYXVsdGZkIGlzIHRoZSBtb3N0IG9idmlvdXMgd2F5
LCBidXQgdGhlcmUgYXJlIHBsZW50eS4gSSBzdXBwb3NlIHdlIGNvdWxkIGRvIHRoZSBmbHVzaCBh
dCBjb250ZXh0IHN3aXRjaCAqYW5kKiBlbnRyeS4gIEkgYmV0IHRoYXQgcGVyZm9ybWFuY2Ugc3Rp
bGwgdXR0ZXJseSBzdWNrcywgdGhvdWdoIOKAlCBvbiBtYW55IHdvcmtsb2FkcywgdGhpcyB0dXJu
cyBldmVyeSBlbnRyeSBpbnRvIGEgZnVsbCBmbHVzaCwgYW5kIHdlIGFscmVhZHkga25vdyBleGFj
dGx5IGhvdyBtdWNoIHRoYXQgc3Vja3Mg4oCUIGl04oCZcyBpZGVudGljYWwgdG8gS1BUSSB3aXRo
b3V0IFBDSUQuICAoQW5kIHllcywgaWYgd2UgZ28gdGhpcyByb3V0ZSwgd2UgbmVlZCB0byBtZXJn
ZSB0aGlzIGxvZ2ljIHRvZ2V0aGVyIOKAlCB3ZSBzaG91bGRu4oCZdCB3cml0ZSBDUjMgdHdpY2Ug
b24gZW50cnkpLgoKUGVyZm9ybWFuY2UgaW1wYWN0IG1pZ2h0IG5vdCBiZSBhbGwgdGhhdCBtdWNo
IGZyb20gZmx1c2ggYXQga2VybmVsCmVudHJ5LiBUaGlzIGZsdXNoIHdpbGwgaGFwcGVuIG9ubHkg
aWYgdGhlcmUgaXMgYSBwZW5kaW5nIGZsdXNoIHBvc3RlZCB0bwp0aGUgcHJvY2Vzc29yIGFuZCB3
aWxsIGJlIGRvbmUgaW4gbGlldSBvZiBmbHVzaCBhdCB0aGUgbmV4dCBjb250ZXh0CnN3aXRjaC4g
U28gd2UgYXJlIG5vdCBsb29raW5nIGF0IGFkZGluZyBtb3JlIFRMQiBmbHVzaGVzLCByYXRoZXIg
Y2hhbmdlCndoZXJlIHRoZXkgbWlnaHQgaGFwcGVuLiBUaGF0IHN0aWxsIGNhbiByZXN1bHQgaW4g
c29tZSBwZXJmb3JtYW5jZQppbXBhY3QgYW5kIG1lYXN1cmluZyBpdCB3aXRoIHJlYWwgY29kZSB3
aWxsIGJlIHRoZSBvbmx5IHdheSB0byBnZXQgdGhhdApudW1iZXIuCgo+IAo+IEkgZmVlbCBsaWtl
IHRoaXMgd2hvbGUgYXBwcm9hY2ggaXMgbWlzZ3VpZGVkLiByZXQyZGlyIGlzIG5vdCBzdWNoIGEg
Z2FtZSBjaGFuZ2VyIHRoYXQgZml4aW5nIGl0IGlzIHdvcnRoIGh1Z2Ugc2xvd2Rvd25zLiBJIHRo
aW5rIGFsbCB0aGlzIGVmZm9ydCBzaG91bGQgYmUgc3BlbnQgb24gc29tZSBraW5kIG9mIHNlbnNp
YmxlIENGSS4gRm9yIGV4YW1wbGUsIHdlIHNob3VsZCBiZSBhYmxlIHRvIG1vc3RseSBzcXVhc2gg
cmV0MmFueXRoaW5nIGJ5IGluc2VydGluZyBhIGNoZWNrIHRoYXQgdGhlIGhpZ2ggYml0cyBvZiBS
U1AgbWF0Y2ggdGhlIHZhbHVlIG9uIHRoZSB0b3Agb2YgdGhlIHN0YWNrIGJlZm9yZSBhbnkgY29k
ZSB0aGF0IHBvcHMgUlNQLiAgT24gYW4gRlBPIGJ1aWxkLCB0aGVyZSBhcmVu4oCZdCBhbGwgdGhh
dCBtYW55IGhvdCBQT1AgUlNQIGluc3RydWN0aW9ucywgSSB0aGluay4KPiAKPiAoQWN0dWFsbHks
IGNoZWNraW5nIHRoZSBiaXRzIGlzIHN1Ym9wdGltYWwuIERvOgo+IAo+IHVuc2lnbmVkIGxvbmcg
b2Zmc2V0ID0gKnJzcCAtIHJzcDsKPiBvZmZzZXQgPj49IFRIUkVBRF9TSElGVDsKPiBpZiAodW5s
aWtlbHkob2Zmc2V0KSkKPiBCVUcoKTsKPiBQT1AgUlNQOwo+IAo+IFRoaXMgbWVhbnMgdGhhdCBp
dOKAmXMgYWxzbyBpbXBvc3NpYmxlIHRvIHRyaWNrIGEgZnVuY3Rpb24gdG8gcmV0dXJuIGludG8g
YSBidWZmZXIgdGhhdCBpcyBvbiB0aGF0IGZ1bmN0aW9u4oCZcyBzdGFjay4pCj4gCj4gSW4gb3Ro
ZXIgd29yZHMsIEkgdGhpbmsgdGhhdCByZXQyZGlyIGlzIGFuIGluc3VmZmljaWVudCBqdXN0aWZp
Y2F0aW9uIGZvciBYUEZPLgo+IAoKVGhhdCBpcyBzb21ldGhpbmcgd2UgbWF5IHdhbnQgdG8gZXhw
bG9yZSBmdXJ0aGVyLiBDbG9zaW5nIGRvd24KL3Byb2MvPHBpZD4vcGFnZW1hcCBoYXMgYWxyZWFk
eSBoZWxwZWQgcmVkdWNlIG9uZSB3YXkgdG8gbW91bnQgcmV0MmRpcgphdHRhY2suIHBoeXNtYXAg
c3ByYXlpbmcgdGVjaG5pcXVlIHN0aWxsIHJlbWFpbnMgdmlhYmxlLiBYUEZPCmltcGxlbWVudGF0
aW9uIGlzIGV4cGVuc2l2ZS4gQ2FuIHdlIGRvIHNvbWV0aGluZyBkaWZmZXJlbnQgdG8gbWl0aWdh
dGUKcGh5c21hcCBzcHJheWluZz8KClRoYW5rcywKS2hhbGlkCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
