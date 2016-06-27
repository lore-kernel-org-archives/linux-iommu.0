From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 1/2] iommu: Disable preemption around use
 of this_cpu_ptr()
Date: Mon, 27 Jun 2016 13:19:25 +0200
Message-ID: <20160627111925.GJ11432@8bytes.org>
References: <1464776603-11998-1-git-send-email-chris@chris-wilson.co.uk>
 <1464779409-26711-1-git-send-email-chris@chris-wilson.co.uk>
 <20160615122548.GJ26566@8bytes.org>
 <7b6bfcfc-093a-f90f-94b0-0e89dde8c0e6@leemhuis.info>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <7b6bfcfc-093a-f90f-94b0-0e89dde8c0e6@leemhuis.info>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

T24gU3VuLCBKdW4gMjYsIDIwMTYgYXQgMTI6NTQ6MTlQTSArMDIwMCwgVGhvcnN0ZW4gTGVlbWh1
aXMgd3JvdGU6Cj4gSm9lcmcsIHdoYXQncyB0aGUgc3RhdHVzIGhlcmU/IFRoaXMgbWFkZSBpdCBv
biBteSA0LjcgcmVncmVzc2lvbnMKPiByZXBvcnQsIGFzIHRoZSBwYXRjaGVzIGZyb20gdGhpcyB0
aHJlYWQgYXJlIHN1cHBvc2VkIHRvIGZpeCBhCj4gcmVncmVzc2lvbjsgc2VlCj4gaHR0cDovL3Ro
cmVhZC5nbWFuZS5vcmcvZ21hbmUubGludXgudXNiLmdlbmVyYWwvMTQzNTA0L2ZvY3VzPTE1MzE1
NAo+IGZvciBkZXRhaWxzLgo+IAo+IFBsZWFzZSBsZXQgbWUga25vdyBpZiBpZiBmaXhlcyB3ZW50
IHRvIG1haW5saW5lIGFscmVhZHk7IEkgZGlkIGEgcXVpY2sKPiBjaGVjayBhbmQgY291bGQgc2Vl
IGFueS4KCk9rYXksIHF1ZXVlZCB0aGUgZml4LCBzaG91bGQgYmUgdXBzdHJlYW0gZm9yIC1yYzYu
Cgo+IFNpbmNlcmVseSwgeW91ciByZWdyZXNzaW9uIHRyYWNrZXIgZm9yIExpbnV4IDQuNyAoaHR0
cDovL2JpdC5seS8yOEpSbUpvKQo+ICBUaG9yc3RlbgoKQXdlc29tZSwgZ2xhZCB0byBzZWUgeW91
IHBpY2tpbmcgdGhpcyB1cCA6KQoKCkNoZWVycywKCglKb2VyZwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4IG1haWxpbmcgbGlzdApJbnRl
bC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
