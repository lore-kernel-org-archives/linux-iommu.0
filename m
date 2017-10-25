From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound
 traffic
Date: Wed, 25 Oct 2017 09:36:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00A24FC@AcuExch.aculab.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
 <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de>
 <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DD009F05A@AcuExch.aculab.com>
 <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CANCKTBu6H6thuK9F_6HBGhStaXSto7fwWv4V5oH8EdWQD0-1kQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: 'Jim Quinlan' <jim2101024@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux-MIPS <linux-mips@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Brian Norris <computersforpeace@gmail.com>, linux-arm-kernel@lists.infradead
List-Id: iommu@lists.linux-foundation.org

RnJvbTogSmltIFF1aW5sYQ0KPiBTZW50OiAyNCBPY3RvYmVyIDIwMTcgMTk6MDgNCi4uLg0KPiBI
aSBEYXZpZCwgIENocmlzdG9waCB3YXMgYWxzbyBjb25jZXJuZWQgYWJvdXQgdGhpczoNCj4gDQo+
ICJGb3IgdGhlIGJsb2NrIHdvcmxkIHRha2UgYSBsb29rIGF0IF9fYmxrX3NlZ21lbnRfbWFwX3Nn
IHdoaWNoIGRvZXMgdGhlIG1lcmdpbmcNCj4gb2YgY29udGlndW91cyBwYWdlcyBpbnRvIGEgc2lu
Z2xlIFNHIHNlZ21lbnQuICBZb3UnZCBoYXZlIHRvIG92ZXJyaWRlDQo+IEJJT1ZFQ19QSFlTX01F
UkdFQUJMRSB0byBwcmV2ZW50IHRoaXMgZnJvbSBoYXBwZW5pbmcgaW4geW91ciBzdXBwb3J0ZWQN
Cj4gYXJjaGl0ZWN0dXJlcyBmb3IgdGhlIGJsb2NrIGxheWVyLiINCj4gDQo+IERvIHlvdSBjb25z
aWRlciB0aGlzIGEgbm9uLWlzc3VlIGFzIHdlbGwgb3IgY2FuIHRoaXMgaGFwcGVuIGFuZCBzcGFu
DQo+IG1lbW9yeSByZWdpb25zPw0KDQpQcm9iYWJseSBlYXNpZXN0IHRvIGhhdmUgYW4gYXJjaGl0
ZWN0dXJlIGxpbWl0IG9uIHRoZSBhZGRyZXNzZXMgdGhhdA0KY2FuIGJlIG1lcmdlZC4NCg0KTXkg
Z3Vlc3MgaXMgdGhhdCB0aGlzIGNvZGUgb25seSByZWFsbHkgZXZlciBtZXJnZXMgcGFnZXMgdGhh
dCB3ZXJlDQphbGxvY2F0ZWQgY29udGlndW91c2x5LCBidXQgaGF2ZSBnb3QgY29udmVydGVkIHRv
IGEgbGlzdCBvZiBWQS4NClNvIHN0b3BwaW5nIG1lcmdpbmcgb3ZlciBldmVuIDFNQiBib3VuZGFy
aWVzIHdvdWxkIGhhdmUgbWluaW1hbCBlZmZlY3QNCihldmVuIGlmIGRvbmUgdW5jb25kaXRpb25h
bGx5KS4NCg0KSSBldmVuIHdvbmRlciBpZiB0aGUgbWVyZ2luZyBpcyBhY3R1YWxseSB3b3J0aHdo
aWxlIGF0IGFsbD8NCk1heWJlIGlmIGFueSBjb2RlIGhhcyBsaW1pdHMgb24gdGhlIFNHIGxpc3Qg
bGVuZ3RoLg0KKG9yIHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgY2FjaGUgbGluZXMgdGhlIGdldCBk
aXJ0aWVkLi4uKQ0KDQoJRGF2aWQNCg0KDQoNCg==
