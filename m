From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 1/2] iommu: Disable preemption around use
 of this_cpu_ptr()
Date: Mon, 27 Jun 2016 13:14:17 +0200
Message-ID: <20160627111417.GI11432@8bytes.org>
References: <1464776603-11998-1-git-send-email-chris@chris-wilson.co.uk>
 <1464779409-26711-1-git-send-email-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <1464779409-26711-1-git-send-email-chris@chris-wilson.co.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: intel-gfx@lists.freedesktop.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

T24gV2VkLCBKdW4gMDEsIDIwMTYgYXQgMTI6MTA6MDhQTSArMDEwMCwgQ2hyaXMgV2lsc29uIHdy
b3RlOgo+ICBkcml2ZXJzL2lvbW11L2lvdmEuYyB8IDggKysrKysrLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCk9rYXksIGFwcGxpZWQgdGhpcyBw
YXRjaCB0byBpb21tdS9maXhlcyBhbmQgd2lsbCBzZW5kIGl0IHVwc3RyZWFtIHRoaXMKd2Vlay4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==
