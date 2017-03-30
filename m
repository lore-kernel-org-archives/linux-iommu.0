From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: flush IOTLB for specific domains only
Date: Thu, 30 Mar 2017 07:45:15 -0600
Message-ID: <CAD8Lp47VQ0X0ydsGMrpTu-y4LAXfg9N7+Mzb0hDWDsKc2P-kQg@mail.gmail.com>
References: <20170322112242.GK29659@8bytes.org>
 <1490595427-11979-1-git-send-email-arindam.nath@amd.com>
 <CAD8Lp46RjsUJEvCR5qVY6p8za5H9iDGTAyJMDd1zO7gbgBvqfA@mail.gmail.com>
 <MWHPR12MB15186B0A864F247BFBEF8EAD9C340@MWHPR12MB1518.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB15186B0A864F247BFBEF8EAD9C340-Gy0DoCVfaSXKu+HfpMNLNQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Cc: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gVGh1LCBNYXIgMzAsIDIwMTcgYXQgMTI6MjMgQU0sIE5hdGgsIEFyaW5kYW0gPEFyaW5kYW0u
TmF0aEBhbWQuY29tPiB3cm90ZToKPiBEYW5pZWwsIGRpZCB5b3UgZ2V0IGNoYW5jZSB0byB0ZXN0
IHRoaXMgcGF0Y2g/CgpOb3QgeWV0LiBTaG91bGQgd2UgdGVzdCBpdCBhbG9uZSBvciBhbG9uZ3Np
ZGUgIlBDSTogQmxhY2tsaXN0IEFNRApTdG9uZXkgR1BVIGRldmljZXMgZm9yIEFUUyI/CgpUaGFu
a3MKRGFuaWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
